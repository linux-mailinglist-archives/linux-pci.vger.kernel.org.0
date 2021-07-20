Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ADE3D04BF
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 00:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhGTWCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 18:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhGTWCA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 18:02:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A63C96101B;
        Tue, 20 Jul 2021 22:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626820958;
        bh=jR6UFuNxvAco3dy/gJeltUmqZ9bsV2MNKvDiRpfMHcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A5E6pidX5nq0eamnCJbxoZXae+xFnJ7imi30h1anp23y/P2GrrN+3Lg+jITT3NZPW
         4hnA754YwWv9agJvujm4JQOmranrSxXCeM6KkX/YFOOUofKaIut9yeBxll8c4NqF1p
         wNpNwrCOz4EQ7irPxwmb1Z/Sh6eQ4NfoG8tqmIZnBOKyphVnoytIdtTmxclR1r/MTh
         VJynMswbIlfeq6qdxsyEUGhBxV08tbhG8iUqXLgm4zWJQh/CcfxGeSQXEn7foyUdAx
         mLPNYd9jdOQFwaHl6lemIDRkfcWkUUmVcPvFQS+BvHj9JFrCFtB2Wa4N3cf+ZppPsx
         1MhUJWnZsi/xQ==
Date:   Tue, 20 Jul 2021 17:42:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Jon Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: vmd: Issue vmd domain window reset
Message-ID: <20210720224236.GA136601@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720205009.111806-3-nirmal.patel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 20, 2021 at 01:50:09PM -0700, Nirmal Patel wrote:
> In order to properly re-initialize the VMD domain during repetitive driver
> attachment or reboot tests, ensure that the VMD root ports are re-initialized
> to a blank state that can be re-enumerated appropriately by the PCI core.
> This is performed by re-initializing all of the bridge windows to ensure
> that PCI core enumeration does not detect potentially invalid bridge windows
> and misinterpret them as firmware-assigned windows, when they simply may be
> invalid bridge window information from a previous boot.

Rewrap commit log to fit in 75 columns.  No problem about v2 vs v1.

> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 6e1c60048774..e52bdb95218e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -651,6 +651,39 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  	return 0;
>  }
>  
> +

Remove spurious blank line here.

> +static void vmd_domain_reset_windows(struct vmd_dev *vmd)
> +{
> +	u8 hdr_type;
> +	char __iomem *addr;
> +	int dev_seq;
> +	u8 functions;
> +	u8 fn_seq;
> +	int max_devs = resource_size(&vmd->resources[0]) * 32;
> +
> +	for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
> +		addr = VMD_DEVICE_BASE(vmd, dev_seq) + PCI_VENDOR_ID;
> +		if (readw(addr) != PCI_VENDOR_ID_INTEL)
> +			continue;
> +
> +		addr = VMD_DEVICE_BASE(vmd, dev_seq) + PCI_HEADER_TYPE;
> +		hdr_type = readb(addr) & PCI_HEADER_TYPE_MASK;
> +		if (hdr_type != PCI_HEADER_TYPE_BRIDGE)
> +			continue;
> +
> +		functions = !!(hdr_type & 0x80) ? 8 : 1;
> +		for (fn_seq = 0; fn_seq < functions; fn_seq++)
> +		{

Put "{" on previous line.

Looks quite parallel to vmd_domain_sbr(), except that here we iterate
through functions as well.  Why does vmd_domain_sbr() not need to
iterate through functions?

> +			addr = VMD_FUNCTION_BASE(vmd, dev_seq, fn_seq) + PCI_VENDOR_ID;
> +			if (readw(addr) != PCI_VENDOR_ID_INTEL)
> +				continue;
> +
> +			memset_io((VMD_FUNCTION_BASE(vmd, dev_seq, fn_seq) + PCI_IO_BASE),
> +			 0, PCI_ROM_ADDRESS1 - PCI_IO_BASE);

Make the lines above fit in 80 columns.

> +		}
> +	}
> +}
> +
>  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  {
>  	struct pci_sysdata *sd = &vmd->sysdata;
> @@ -741,6 +774,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		.parent = res,
>  	};
>  
> +	vmd_domain_reset_windows(vmd);
> +
>  	sd->vmd_dev = vmd->dev;
>  	sd->domain = vmd_find_free_domain();
>  	if (sd->domain < 0)
> -- 
> 2.27.0
> 
