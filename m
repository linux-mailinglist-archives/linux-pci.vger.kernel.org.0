Return-Path: <linux-pci+bounces-35328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA40B40876
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70B35E4F14
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C90930F54A;
	Tue,  2 Sep 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj2XyH1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054EB1DE8B5;
	Tue,  2 Sep 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825563; cv=none; b=pdnW6n/erQzo/umCSKOMcyAw4wvIqtkIfYR7Uy1gpYrjqa7nV4mlyyrT5zeNy7SR8ivR3hl/Io0M5Oa74iPhPlypWh+7nfUufXsyUI/OgDMgfEzm9AWhOSBpnOWHoqWmscVsSt8TtCLYCDcU4HSniAYS+Kmb44/s6c/zkjj6a/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825563; c=relaxed/simple;
	bh=a7plQZt9CBVLEoabmV53yeJKpub8B3Vjm+HcSP2DS9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2AzMta02UEG2Fxb/iMPVSOSZmmlxEiA3za7mPX7bm2HpE28b89rWOVRYsgxmJvGhh7ZvczVgj51hxCeIw11qE5PVsORWdCmKk383ApqDwdotKs+665lQsZ19PSxB42O/shubu9VO+WtkVuG0gWBlHVd64d9Pd3E7XITb2e2aUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj2XyH1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D43BC4CEED;
	Tue,  2 Sep 2025 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756825562;
	bh=a7plQZt9CBVLEoabmV53yeJKpub8B3Vjm+HcSP2DS9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cj2XyH1ztkfb4wa1MxB0+16/VBUhVMjQe8UvD+tYKYOSZRGjP3D0Z6zF9EeU2DBBG
	 yKvx7FDm4vV+lzwXgoKHgigXPvLDT8vaOUQxLWw63O34epA/09NOzVZA678ZRgNTls
	 Xmai4ua4E48Ojnnby78ZBK1I6LJLXOFq7CadCS2rEN/2EySkC4pIdn5de7RmllxrzW
	 iY9ajaOu3EMMeZJ7dgKumlzdLpstjgH3Gx36W2h4yTbhN2usyyVDJRj3jhi/ua+T0R
	 X4zs0+0MWn1rjl9H3bREtgznSu9Z7M59iqxGWvEUWip8Eg9wKlctvE/oG1FI61K7YO
	 pyBaPW/RP5D6A==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com,
	aik@amd.com
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
In-Reply-To: <20250827035259.1356758-2-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
Date: Tue, 02 Sep 2025 20:35:50 +0530
Message-ID: <yq5a7byg3ne9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> After a PCIe device has established a secure link and session between a TEE
> Security Manager (TSM) and its local Device Security Manager (DSM), the
> device or its subfunctions are candidates to be bound to a private memory
> context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
> Device Interface (TDI).
>
> The pci_tsm_bind() requests the low-level TSM driver to associate the
> device with private MMIO and private IOMMU context resources of a given TVM
> represented by a @kvm argument. A device in the bound state corresponds to
> the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
> 'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
> it involves host side resource establishment and context setup on behalf of
> the guest. It is also expected to be performed lazily to allow for
> operation of the device in non-confidential "shared" context for pre-lock
> configuration.
>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/tsm.c       | 95 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-tsm.h | 30 +++++++++++++
>  2 files changed, 125 insertions(+)
>
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 092e81c5208c..302a974f3632 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -251,6 +251,99 @@ static int remove_fn(struct pci_dev *pdev, void *data)
>  	return 0;
>  }
>  
> +/*
> + * Note, this helper only returns an error code and takes an argument for
> + * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
> + * always succeeds.
> + */
> +static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
> +{
> +	struct pci_tdi *tdi;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +
> +	if (!pdev->tsm)
> +		return 0;
> +
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	guard(mutex)(&tsm_pf0->lock);
> +
> +	tdi = pdev->tsm->tdi;
> +	if (!tdi)
> +		return 0;
> +
> +	pdev->tsm->ops->unbind(tdi);
> +	pdev->tsm->tdi = NULL;
> +
> +	return 0;
> +}
> +
> +void pci_tsm_unbind(struct pci_dev *pdev)
> +{
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +	__pci_tsm_unbind(pdev, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_unbind);
> +
> +/**
> + * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
> + * @pdev: PCI device function to bind
> + * @kvm: Private memory attach context
> + * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
> + *
> + * Returns 0 on success, or a negative error code on failure.
> + *
> + * Context: Caller is responsible for constraining the bind lifetime to the
> + * registered state of the device. For example, pci_tsm_bind() /
> + * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
> + */
> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
> +{
> +	const struct pci_tsm_ops *ops;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	struct pci_tdi *tdi;
> +
> +	if (!kvm)
> +		return -EINVAL;
> +
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +
> +	ops = pdev->tsm->ops;
> +
> +	if (!is_link_tsm(ops->owner))
> +		return -ENXIO;
> +
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	guard(mutex)(&tsm_pf0->lock);
> +
> +	/* Resolve races to bind a TDI */
> +	if (pdev->tsm->tdi) {
> +		if (pdev->tsm->tdi->kvm == kvm)
> +			return 0;
> +		else
> +			return -EBUSY;
> +	}
> +
> +	tdi = ops->bind(pdev, kvm, tdi_id);
> +	if (IS_ERR(tdi))
> +		return PTR_ERR(tdi);
> +
> +	pdev->tsm->tdi = tdi;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_bind);
> +
> +static void pci_tsm_unbind_all(struct pci_dev *pdev)
> +{
> +	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
> +	__pci_tsm_unbind(pdev, NULL);
> +}
> +
>  static void __pci_tsm_disconnect(struct pci_dev *pdev)
>  {
>  	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> @@ -259,6 +352,8 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
>  	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
>  	lockdep_assert_held_write(&pci_tsm_rwsem);
>  
> +	pci_tsm_unbind_all(pdev);
> +
>  	/*
>  	 * disconnect() is uninterruptible as it may be called for device
>  	 * teardown
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index e4f9ea4a54a9..337b566adfc5 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -5,6 +5,8 @@
>  #include <linux/pci.h>
>  
>  struct pci_tsm;
> +struct kvm;
> +enum pci_tsm_req_scope;
>  
>  /*
>   * struct pci_tsm_ops - manage confidential links and security state
> @@ -29,18 +31,25 @@ struct pci_tsm_ops {
>  	 * @connect: establish / validate a secure connection (e.g. IDE)
>  	 *	     with the device
>  	 * @disconnect: teardown the secure link
> +	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
> +	 * @unbind: remove a TDI from secure operation with a TVM
>  	 *
>  	 * Context: @probe, @remove, @connect, and @disconnect run under
>  	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
>  	 * mutual exclusion of @connect and @disconnect. @connect and
>  	 * @disconnect additionally run under the DSM lock (struct
>  	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> +	 * @bind and @unbind run under pci_tsm_rwsem held for read and the DSM
> +	 * lock.
>  	 */
>  	struct_group_tagged(pci_tsm_link_ops, link_ops,
>  		struct pci_tsm *(*probe)(struct pci_dev *pdev);
>  		void (*remove)(struct pci_tsm *tsm);
>  		int (*connect)(struct pci_dev *pdev);
>  		void (*disconnect)(struct pci_dev *pdev);
> +		struct pci_tdi *(*bind)(struct pci_dev *pdev,
> +					struct kvm *kvm, u32 tdi_id);
> +		void (*unbind)(struct pci_tdi *tdi);
>  	);
>  
>  	/*
> @@ -58,10 +67,21 @@ struct pci_tsm_ops {
>  	struct tsm_dev *owner;
>  };
>  
> +/**
> + * struct pci_tdi - Core TEE I/O Device Interface (TDI) context
> + * @pdev: host side representation of guest-side TDI
> + * @kvm: TEE VM context of bound TDI
> + */
> +struct pci_tdi {
> +	struct pci_dev *pdev;
> +	struct kvm *kvm;
> +};
> +
>  /**
>   * struct pci_tsm - Core TSM context for a given PCIe endpoint
>   * @pdev: Back ref to device function, distinguishes type of pci_tsm context
>   * @dsm: PCI Device Security Manager for link operations on @pdev
> + * @tdi: TDI context established by the @bind link operation
>   * @ops: Link Confidentiality or Device Function Security operations
>   *
>   * This structure is wrapped by low level TSM driver data and returned by
> @@ -77,6 +97,7 @@ struct pci_tsm_ops {
>  struct pci_tsm {
>  	struct pci_dev *pdev;
>  	struct pci_dev *dsm;
> +	struct pci_tdi *tdi;
>  	const struct pci_tsm_ops *ops;
>  };
>  
> @@ -131,6 +152,8 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
>  int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
>  			    const struct pci_tsm_ops *ops);
>  void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
> +void pci_tsm_unbind(struct pci_dev *pdev);
>  #else
>  static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>  {
> @@ -139,5 +162,12 @@ static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>  static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
>  {
>  }
> +static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> +{
> +	return -ENXIO;
> +}
> +static inline void pci_tsm_unbind(struct pci_dev *pdev)
> +{
> +}
>  #endif
>  #endif /*__PCI_TSM_H */
>
> base-commit: 4de43c0eb5d83004edf891b974371572e3815126
> -- 
> 2.50.1

Can we add tsm_bind/unbind so that we can call tsm function from iommufd instead of
pci specific functions like pci_tsm_bind()?

modified   drivers/virt/coco/tsm-core.c
@@ -193,6 +193,24 @@ void tsm_ide_stream_unregister(struct pci_ide *ide)
 }
 EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
 
+int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	return pci_tsm_bind(to_pci_dev(dev), kvm, tdi_id);
+}
+EXPORT_SYMBOL_GPL(tsm_bind);
+
+int tsm_unbind(struct device *dev)
+{
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	return pci_tsm_unbind(to_pci_dev(dev));
+}
+EXPORT_SYMBOL_GPL(tsm_unbind);
+
 static void tsm_release(struct device *dev)
 {
 	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);
modified   include/linux/tsm.h
@@ -118,6 +118,9 @@ const char *tsm_name(const struct tsm_dev *tsm_dev);
 struct tsm_dev *find_tsm_dev(int id);
 const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
 struct pci_ide;
+struct kvm;
 int tsm_ide_stream_register(struct pci_ide *ide);
 void tsm_ide_stream_unregister(struct pci_ide *ide);
+int tsm_bind(struct device *dev, struct kvm *kvm, u64 tdi_id);
+int tsm_unbind(struct device *dev);
 #endif /* __TSM_H */

