Return-Path: <linux-pci+bounces-25971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D0A8AFC4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 07:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA1017C6A4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 05:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7464B5AE;
	Wed, 16 Apr 2025 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anwFQpqi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335C28373;
	Wed, 16 Apr 2025 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781669; cv=none; b=U6l6aZ9aJBIZ8rs6NhtvwIYYw4i79rh1ysyYwJXiFs67u7GnpXSwQs3rbgdZBGHf/OvLJ4NgDZjM4itc6sOSqCvy3MXrslZwjzYZyLXg/hMEDaDCYwga8L17bYOeMiiJv17rmYZiy/sBgP9nbEt80hnoJk+g8nFBoRoILzr6DaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781669; c=relaxed/simple;
	bh=4F3MVwcw6IvjuBhDc2KBs2/k1G6l6isdd8aW6Z+Q1oU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aRw70itnMnYGkCh8kJDVv6SuRDOtbK5zh7uXxw/dLWZ3IteSobpBg0xlrq1sl+ZaGA48FKODc40Exc5wM7KtX+u42gmz0JOilvpcWPE9FVCOIkh7x9c5dOGEuzYuptvR2P4HtIIo+oTqe+TpDz4uerMpl2ugeXjqvEO+ZcV3Ons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anwFQpqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B46C4CEE2;
	Wed, 16 Apr 2025 05:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744781668;
	bh=4F3MVwcw6IvjuBhDc2KBs2/k1G6l6isdd8aW6Z+Q1oU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=anwFQpqi7chW5Oy21cayLWYIN/SW7O4Rnwt23K9fT9J2WoJKz4LFF3Wvxwm8K0gHH
	 TCtlfK6RVmCzqc0CrUvPHfi+/eLFTAtR7H/wnjM97UjWMz9FA8Qf5BQyGy6PogGl1d
	 elCvFAhN0FRk0SjSVPWBP2ye4XSxzXoIqTD2Wj5k/3eYnFo36G8LdaKX5OxPRRgggg
	 3rqnIHMTFM8pX56kvx5yec7O0+f/WBWTRP3oacKgQriQ7vr2wtfQIShlP5ugl7LMfw
	 YxxuJSvI/e9DR4c57D1Q1oE/hUBPpoymUyR/v5sion0rFKg7ZYUOYlrFLl1FXe+xep
	 bpieAxvbxO5uw==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 Q)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, aik@amd.com, lukas@wunner.de
Subject: Re: [PATCH v2 05/11] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <174107248456.1288555.10068789075179290465.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107248456.1288555.10068789075179290465.stgit@dwillia2-xfh.jf.intel.com>
Date: Wed, 16 Apr 2025 11:03:34 +0530
Message-ID: <yq5asem84qmp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

....

> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..17657b7ef66c
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,135 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_dev;
> +
> +enum pci_tsm_state {
> +	PCI_TSM_ERR =3D -1,
> +	PCI_TSM_INIT,
> +	PCI_TSM_CONNECT,
> +};
> +
> +enum pci_tsm_type {
> +	PCI_TSM_INVALID,
> +	PCI_TSM_PF0,
> +	PCI_TSM_VIRTFN,
> +	PCI_TSM_MFD,
> +};
> +
> +/**
> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> + * @pdev: indicates the type of pci_tsm object
> + * @type: debug validation of the pci_tsm object type inferred by @pdev
> + *
> + * This structure is wrapped by a low level TSM driver and returned by
> + * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
> + * whether @pdev is physical function 0, another physical function, or a
> + * virtual function determines the pci_tsm object type. E.g. see 'struct
> + * pci_tsm_pf0'.
> + */
> +struct pci_tsm {
> +	struct pci_dev *pdev;
> +#ifdef CONFIG_PCI_TSM_DEBUG
> +	enum pci_tsm_type type;
> +#endif
> +};
> +
> +#ifdef CONFIG_PCI_TSM_DEBUG
> +static inline void pci_tsm_set_type(struct pci_tsm *pci_tsm, enum pci_ts=
m_type type)
> +{
> +	pci_tsm->type =3D type;
> +}
> +static inline bool pci_tsm_check_type(struct pci_tsm *pci_tsm, enum pci_=
tsm_type type)
> +{
> +	return pci_tsm->type =3D=3D type;
> +}
> +#else
> +static inline void pci_tsm_set_type(struct pci_tsm *pci_tsm, enum pci_ts=
m_type type)
> +{
> +}
> +
> +static inline bool pci_tsm_check_type(struct pci_tsm *pci_tsm, enum pci_=
tsm_type type)
> +{
> +	return true;
> +}
> +#endif
> +
> +/**
> + * struct pci_tsm_pf0 - Physical Function 0 TDISP context
> + * @state: reflect device initialized, connected, or bound
> + * @lock: protect @state vs pci_tsm_ops invocation
> + * @doe_mb: PCIe Data Object Exchange mailbox
> + */
> +struct pci_tsm_pf0 {
> +	struct pci_tsm tsm;
> +	enum pci_tsm_state state;
> +	struct mutex lock;
> +	struct pci_doe_mb *doe_mb;
> +};
>

While working with a multifunction device, I found that adding lock and
state to struct pci_tsm simplified the code considerably.

In multifunction setups, it=E2=80=99s possible that multiple functions may
expose DOE capabilities. In this case, when sending SPDM messages for a
TDI, should we always use the DOE mailbox of function 0, or should we
address the mailbox of the specific function involved?

If the latter is preferred, would it make sense to rename the current
structure=E2=80=94currently representing the base pci_tsm plus the DOE
mailbox=E2=80=94to something more generic? because it is not more tied to
physical function 0

> +
> +static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pdev->is_virtfn)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return PCI_FUNC(pdev->devfn) =3D=3D 0;
> +}
> +
> +/**
> + * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
> + * @probe: probe/accept device for tsm operation, setup DSM context
> + * @remove: destroy DSM context
> + * @connect: establish / validate a secure connection (e.g. IDE) with th=
e device
> + * @disconnect: teardown the secure connection
> + *
> + * @probe and @remove run in pci_tsm_rwsem held for write context. All
> + * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> + * for read.
> + */
> +struct pci_tsm_ops {
> +	struct pci_tsm *(*probe)(struct pci_dev *pdev);
> +	void (*remove)(struct pci_tsm *tsm);
> +	int (*connect)(struct pci_dev *pdev);
> +	void (*disconnect)(struct pci_dev *pdev);
> +};
> +
> +enum pci_doe_proto {
> +	PCI_DOE_PROTO_CMA =3D 1,
> +	PCI_DOE_PROTO_SSESSION =3D 2,
> +};
> +
> +#ifdef CONFIG_PCI_TSM
> +int pci_tsm_core_register(const struct pci_tsm_ops *ops,
> +			  const struct attribute_group *grp);
> +void pci_tsm_core_unregister(const struct pci_tsm_ops *ops);
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> +			 const void *req, size_t req_sz, void *resp,
> +			 size_t resp_sz);
> +int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm=
);
> +#else
> +static inline int pci_tsm_core_register(const struct pci_tsm_ops *ops,
> +					const struct attribute_group *grp)
> +{
> +	return 0;
> +}
> +static inline void pci_tsm_core_unregister(const struct pci_tsm_ops *ops)
> +{
> +}
> +static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
> +				       enum pci_doe_proto type, const void *req,
> +				       size_t req_sz, void *resp,
> +				       size_t resp_sz)
> +{
> +	return -ENOENT;
> +}
> +#endif
> +#endif /*__PCI_TSM_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 628f9f5fdac9..57cfa0e3f2bd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -537,6 +537,9 @@ struct pci_dev {
>  	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
>  	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>  	unsigned int	ide_tee_limit:1; /* Disallow T=3D0 traffic over IDE */
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	struct pci_tsm *tsm;		/* TSM operation state */
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset */
>  	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 9253b79b8582..59d3848404e1 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -111,7 +111,9 @@ struct tsm_report_ops {
>  int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>  int tsm_report_unregister(const struct tsm_report_ops *ops);
>  struct tsm_core_dev;
> +struct pci_tsm_ops;
>  struct tsm_core_dev *tsm_register(struct device *parent,
> -				  const struct attribute_group **groups);
> +				  const struct attribute_group **groups,
> +				  const struct pci_tsm_ops *ops);
>  void tsm_unregister(struct tsm_core_dev *tsm_core);
>  #endif /* __TSM_H */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 000258cd93c8..713588a29813 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -499,6 +499,7 @@
>  #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
>  #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
>  #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
> +#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
>  #define PCI_EXP_DEVCTL		0x08	/* Device Control */
>  #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
>  #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable=
 */

