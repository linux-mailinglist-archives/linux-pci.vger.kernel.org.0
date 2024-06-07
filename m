Return-Path: <linux-pci+bounces-8465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772A2900A24
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B26F1C2221D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A2A190668;
	Fri,  7 Jun 2024 16:17:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647612E47;
	Fri,  7 Jun 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777047; cv=none; b=tjYstTbLjtIe+b0MSj0J2mzVkN84nzIEtXC7fUOaBh3XCZnIihjs1ZptfGbFMZjZkoHlQL483ii74R6JHowS3jdRWAKwp4EIlPaFkoozE/hgybRnmd+wX0MUKtaeJBShwgPQXrp3Xmzw2cKjx5R4NnNkbMySaGoePeA7S/cLM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777047; c=relaxed/simple;
	bh=6NpbI6cVT/qBF0SqsyJAoESRZcL7nfvEkvqXgsuhiz4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWtLTNoO4hnwSdkHEKMKUBW7/LwqD9y+1k+xY55cH6kh2d9MxKj49Oag77btny/Iqaji4qOisXo03yhdYFeDKD0wnZgEMHDy1ixpL/HuZYW62GnsAvGCqw1EDZsVWVSrQpJP1roEk53AhCpV92FvU2pnGk0pGlcEdbaIR38/iqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwmSj6Nqmz680ZP;
	Sat,  8 Jun 2024 00:12:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F3FB140A36;
	Sat,  8 Jun 2024 00:17:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 17:17:17 +0100
Date: Fri, 7 Jun 2024 17:17:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Wei Huang <wei.huang2@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <alex.williamson@redhat.com>,
	<gospo@broadcom.com>, <michael.chan@broadcom.com>,
	<ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
	<Eric.VanTassell@amd.com>, <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<bagasdotme@gmail.com>
Subject: Re: [PATCH V2 2/9] PCI: Add TPH related register definition
Message-ID: <20240607171716.0000216d@Huawei.com>
In-Reply-To: <20240531213841.3246055-3-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
	<20240531213841.3246055-3-wei.huang2@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 16:38:34 -0500
Wei Huang <wei.huang2@amd.com> wrote:

> Linux has some basic, but incomplete, definition for the TPH Requester
> capability registers. Also the control registers of TPH Requester and
> the TPH Completer are missing. This patch adds all required definitions
> to support TPH enablement.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>

As below, you can't modify uapi headers because we have no idea what
userspace code is already using them.
Also, (annoyingly) the field contents in this header tend (or maybe always are)
in the shifted form.

> ---
>  drivers/vfio/pci/vfio_pci_config.c |  7 +++---
>  include/uapi/linux/pci_regs.h      | 35 ++++++++++++++++++++++++++----
>  2 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 97422aafaa7b..de622cdfc2a4 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1434,14 +1434,15 @@ static int vfio_ext_cap_len(struct vfio_pci_core_device *vdev, u16 ecap, u16 epo
>  		if (ret)
>  			return pcibios_err_to_errno(ret);
>  
> -		if ((dword & PCI_TPH_CAP_LOC_MASK) == PCI_TPH_LOC_CAP) {
> +		if (((dword & PCI_TPH_CAP_LOC_MASK) >> PCI_TPH_CAP_LOC_SHIFT)
> +			== PCI_TPH_LOC_CAP) {
>  			int sts;
>  
>  			sts = dword & PCI_TPH_CAP_ST_MASK;
>  			sts >>= PCI_TPH_CAP_ST_SHIFT;
> -			return PCI_TPH_BASE_SIZEOF + (sts * 2) + 2;
> +			return PCI_TPH_ST_TABLE + (sts * 2) + 2;
>  		}
> -		return PCI_TPH_BASE_SIZEOF;
> +		return PCI_TPH_ST_TABLE;
>  	case PCI_EXT_CAP_ID_DVSEC:
>  		ret = pci_read_config_dword(pdev, epos + PCI_DVSEC_HEADER1, &dword);
>  		if (ret)
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 94c00996e633..ae1cf048b04a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -657,6 +657,7 @@
>  #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
>  #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
>  #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
> +#define  PCI_EXP_DEVCAP2_TPH_COMP	0x00003000 /* TPH completer support */
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
>  #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
> @@ -1020,15 +1021,41 @@
>  #define  PCI_DPA_CAP_SUBSTATE_MASK	0x1F	/* # substates - 1 */
>  #define PCI_DPA_BASE_SIZEOF	16	/* size with 0 substates */
>  
> +/* TPH Completer Support */
> +#define PCI_EXP_DEVCAP2_TPH_COMP_SHIFT		12
> +#define PCI_EXP_DEVCAP2_TPH_COMP_NONE		0x0 /* None */
> +#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY	0x1 /* TPH only */
> +#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_AND_EXT	0x3 /* TPH and Extended TPH */
> +
>  /* TPH Requester */
>  #define PCI_TPH_CAP		4	/* capability register */
> +#define  PCI_TPH_CAP_NO_ST	0x1	/* no ST mode supported */
> +#define  PCI_TPH_CAP_NO_ST_SHIFT	0x0	/* no ST mode supported shift */
> +#define  PCI_TPH_CAP_INT_VEC	0x2	/* interrupt vector mode supported */
> +#define  PCI_TPH_CAP_INT_VEC_SHIFT	0x1	/* interrupt vector mode supported shift */
> +#define  PCI_TPH_CAP_DS		0x4	/* device specific mode supported */
> +#define  PCI_TPH_CAP_DS_SHIFT	0x4	/* device specific mode supported shift */
>  #define  PCI_TPH_CAP_LOC_MASK	0x600	/* location mask */
> -#define   PCI_TPH_LOC_NONE	0x000	/* no location */
> -#define   PCI_TPH_LOC_CAP	0x200	/* in capability */
> -#define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */

It's a userspace header, relatively unlikely to be safe to change it...
This would also be inconsistent with how some other registers are defined in here.

I'd love it if we could tidy this up, but we are stuck by this being
in uapi.

> +#define  PCI_TPH_CAP_LOC_SHIFT	9	/* location shift */
> +#define   PCI_TPH_LOC_NONE	0x0	/*  no ST Table */
> +#define   PCI_TPH_LOC_CAP	0x1	/*  ST Table in extended capability */
> +#define   PCI_TPH_LOC_MSIX	0x2	/*  ST table in MSI-X table */
>  #define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
>  #define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
> -#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
> +
> +#define PCI_TPH_CTRL		0x8	/* control register */
> +#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x7	/* ST Model Select mask */
> +#define  PCI_TPH_CTRL_MODE_SEL_SHIFT	0x0	/* ST Model Select shift */
> +#define   PCI_TPH_NO_ST_MODE		0x0	/*  No ST Mode */
> +#define   PCI_TPH_INT_VEC_MODE		0x1	/*  Interrupt Vector Mode */
> +#define   PCI_TPH_DEV_SPEC_MODE		0x2	/*  Device Specific Mode */
> +#define  PCI_TPH_CTRL_REQ_EN_MASK	0x300	/* TPH Requester mask */
> +#define  PCI_TPH_CTRL_REQ_EN_SHIFT	8	/* TPH Requester shift */
> +#define   PCI_TPH_REQ_DISABLE		0x0	/*  No TPH request allowed */
> +#define   PCI_TPH_REQ_TPH_ONLY		0x1	/*  8-bit TPH tags allowed */
> +#define   PCI_TPH_REQ_EXT_TPH		0x3	/*  16-bit TPH tags allowed */
> +
> +#define PCI_TPH_ST_TABLE	0xc	/* base of ST table */
>  
>  /* Downstream Port Containment */
>  #define PCI_EXP_DPC_CAP			0x04	/* DPC Capability */


