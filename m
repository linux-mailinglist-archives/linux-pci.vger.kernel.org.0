Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52A497EB5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 13:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiAXMM3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 07:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAXMM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 07:12:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47265C06173B
        for <linux-pci@vger.kernel.org>; Mon, 24 Jan 2022 04:12:28 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jx6so20848122ejb.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Jan 2022 04:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EF33JaMG+hm3D3rC4FKnXqraG6SkDY8uCv7rbWwdgXo=;
        b=h9kOSUGdVE4gKL9s/LJMs1IPT3IbpeWYBrpfv+AuECTvZC/d9Mgmj+8/qzAF3eXbfK
         m2PtizTIvCHLxd6Gr7Fy05dMKmmlLLy4fEUmMzmo48gVyiHxEhPLV4MLyO9oPA3wQplh
         Vu1eRpEh9FNcwp+b/0xm/G3Q5QeqPlP25zblpv7pn1fhf7z/jOebqtlWaC7aW9HA3fhF
         VjHo7lvhY7/oUqkPSCrDzarLxSsOAQnP9tESF52Jr02HUzNrium0qVdHZa1C0dYGAGE8
         mDJhzJkStQMJW3cmp/Q9xzv797988P0T7BpUMuqWmKMM8P4QGKIRCVs93TY4AR01o66n
         x2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EF33JaMG+hm3D3rC4FKnXqraG6SkDY8uCv7rbWwdgXo=;
        b=0vupCX1PWvPdREZmHvGasXfyo9KANcE5nYdQf5l9+Z/Nk0I8WAMu1WBj0ahxrq0Igf
         hGXcmnuFUDnMSccAqJipTT35+yFkNJoDSIiJ8qk5HiYLx/SjxIiwYq4DsbUxmkl8hrEH
         285VN7GZgvTx1aIvJIyqil+/AqsrAH/sWq2cN37yEc2uyXGwjbGn2MMaloJjWDAcipjF
         3nwmfm/K/kzasi8dODPtvxckUAhrOq0lZv2xFnmfZcMqAYTOcH01+ovRYRwPcLPZ+S7X
         c2Wz3kxaroiPL/1HeltDzcxbEABWbjWnAuIF1auOWN0MP2fhU+jNQrjy8JFkpWYeSleI
         ebjw==
X-Gm-Message-State: AOAM532JhM5ZdyND1bXP+x7i7QxhDtkG7Sqcfur9R4zBhHIxqokLODZ/
        Qocu6JOGeXtMbyI7rKsFUNYCSllZzbJel+qv
X-Google-Smtp-Source: ABdhPJyQSddN36xdAtpIRActuatI3ilXCh3FopeB7M5+U2SlQv66S7Fj/8y3ScreZHIH5mQGHDw6Ng==
X-Received: by 2002:a17:906:c099:: with SMTP id f25mr12755359ejz.458.1643026346842;
        Mon, 24 Jan 2022 04:12:26 -0800 (PST)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id gu2sm4768438ejb.221.2022.01.24.04.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 04:12:26 -0800 (PST)
Message-ID: <9e98c6c9-36a8-046a-b195-78942fdcafff@monstr.eu>
Date:   Mon, 24 Jan 2022 13:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] microblaze/PCI: Remove pci_phys_mem_access_prot() dead
 code
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220121205150.1151607-1-helgaas@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20220121205150.1151607-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/21/22 21:51, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_phys_mem_access_prot() is defined but never used.  Remove it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   arch/microblaze/include/asm/pci.h |  4 ---
>   arch/microblaze/pci/pci-common.c  | 49 -------------------------------
>   2 files changed, 53 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
> index 7c4dc5d85f53..d90528064604 100644
> --- a/arch/microblaze/include/asm/pci.h
> +++ b/arch/microblaze/include/asm/pci.h
> @@ -61,10 +61,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
>   extern void pcibios_resource_survey(void);
>   
>   struct file;
> -extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
> -					 unsigned long pfn,
> -					 unsigned long size,
> -					 pgprot_t prot);
>   
>   /* This part of code was originally in xilinx-pci.h */
>   #ifdef CONFIG_PCI_XILINX
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index 622a4867f9e9..33bab7eec731 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -165,55 +165,6 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
>   	return 0;
>   }
>   
> -/*
> - * This one is used by /dev/mem and fbdev who have no clue about the
> - * PCI device, it tries to find the PCI device first and calls the
> - * above routine
> - */
> -pgprot_t pci_phys_mem_access_prot(struct file *file,
> -				  unsigned long pfn,
> -				  unsigned long size,
> -				  pgprot_t prot)
> -{
> -	struct pci_dev *pdev = NULL;
> -	struct resource *found = NULL;
> -	resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
> -	int i;
> -
> -	if (page_is_ram(pfn))
> -		return prot;
> -
> -	prot = pgprot_noncached(prot);
> -	for_each_pci_dev(pdev) {
> -		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> -			struct resource *rp = &pdev->resource[i];
> -			int flags = rp->flags;
> -
> -			/* Active and same type? */
> -			if ((flags & IORESOURCE_MEM) == 0)
> -				continue;
> -			/* In the range of this resource? */
> -			if (offset < (rp->start & PAGE_MASK) ||
> -			    offset > rp->end)
> -				continue;
> -			found = rp;
> -			break;
> -		}
> -		if (found)
> -			break;
> -	}
> -	if (found) {
> -		if (found->flags & IORESOURCE_PREFETCH)
> -			prot = pgprot_noncached_wc(prot);
> -		pci_dev_put(pdev);
> -	}
> -
> -	pr_debug("PCI: Non-PCI map for %llx, prot: %lx\n",
> -		 (unsigned long long)offset, pgprot_val(prot));
> -
> -	return prot;
> -}
> -
>   /* This provides legacy IO read access on a bus */
>   int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t size)
>   {

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs


