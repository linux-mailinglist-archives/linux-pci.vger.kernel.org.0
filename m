Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD992F3F80
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbhALWuC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 17:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbhALWuC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 17:50:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52DEE230F9;
        Tue, 12 Jan 2021 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610491761;
        bh=p1PTtzIxKwN7wfHP+F+H+uuPoruMlHkjSlRJPBD21gA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kcfNWI3rhBKsKBW7mV4AguHbrYo4YF4lxMRInURMspXzFCY8jjYcssl1J2Cby9v8k
         +PrWyFXVZ+t7/VW0/Lg7WipXwEppCo5Taf14Yl+FhECdWy/dYaVaUVIYAivevuYXk3
         jYyrIegrgyeeoYY9JKMjfmLvzt3+gOnQRLiMWPMf8AsEb+t4BS+8UWQJMRgq5LY0ld
         RIJLWom1tb0/WFZGmCdjJ32MjheBzhEQ8qABYHKVcQe9AALHkV3xNlylgQoouHinVD
         TYXjNaimUsJSzMHujP5tTc1hDuXUmtmgHL+0JWxqdT79xKRw0IgecGyp+ilBjt/6Rw
         1Chg6pAb2+DKw==
Date:   Tue, 12 Jan 2021 16:49:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        benh@kernel.crashing.org
Subject: Re: [PATCH] PCI: decline to resize resources if boot config must be
 preserved
Message-ID: <20210112224919.GA1859692@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109095353.13417-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 09, 2021 at 10:53:53AM +0100, Ard Biesheuvel wrote:
> The _DSM #5 method in the ACPI host bridge object tells us whether the
> OS is permitted to deviate from the resource assignment configured by
> the firmware. If this is not the case, we should not permit drivers to
> resize BARs on the fly. So make pci_resize_resource() take this into
> account.
> 
> Cc: <stable@vger.kernel.org> # v5.4+
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Capitalized subject to match convention and applied to pci/resource
for v5.11, thanks!

Is there an email, bug report, etc that prompted this change?

> ---
>  drivers/pci/setup-res.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 43eda101fcf4..3b38be081e93 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -410,10 +410,16 @@ EXPORT_SYMBOL(pci_release_resource);
>  int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>  {
>  	struct resource *res = dev->resource + resno;
> +	struct pci_host_bridge *host;
>  	int old, ret;
>  	u32 sizes;
>  	u16 cmd;
>  
> +	/* Check if we must preserve the firmware's resource assignment */
> +	host = pci_find_host_bridge(dev->bus);
> +	if (host->preserve_config)
> +		return -ENOTSUPP;
> +
>  	/* Make sure the resource isn't assigned before resizing it. */
>  	if (!(res->flags & IORESOURCE_UNSET))
>  		return -EBUSY;
> -- 
> 2.17.1
> 
