Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38EF11DAA2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 01:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbfLMAJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 19:09:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39274 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfLMAJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2019 19:09:01 -0500
Received: by mail-pj1-f65.google.com with SMTP id v93so342394pjb.6
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2019 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZX5FIig+PltrUOh2irARTBb4SMqy+3JGG456ynVffsA=;
        b=bc4mBc+hxrzzlqEkVsRvE8U/868sKjjzHbGjJ4Sn5+ok64Cyxsrok4uwEOIisNtYKe
         XFWYyKL5Gchf5njs+wMRQuMb9XhRxekb9USxHHgmItG7aCGPzsoK+ffPTA9ngdzo0vGJ
         1qc2ZhSEnB7fLySt3iLidu0y4L8R2X8+cuFCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZX5FIig+PltrUOh2irARTBb4SMqy+3JGG456ynVffsA=;
        b=V1gVBo0HNrr6m1wrabpHhAlXBpjNI4Qufvz7Dk/WrEZ+2PuJ7NNDbUYi/hnqd4CbVG
         EUwS2s+DvC38LYkRfsnnYgqItJ/HABqPG/e+C4J8wFKI+f7DGk9LKqpaS2h5fjzWlgrS
         txVk9xRfsT2pbssksdP6tR3BiBQxEamXI6wAL0wyBHDwcha0LQOjD4io+qVqv+k74gyv
         oWrcNpBKlLWJ9iTpmxOhLA7LhaYxtivLXDzIdjPqjDN6v5GXnq19xJn8Pd0ZbkLVbFUS
         bi+MIJm4oEF06Am4iSecndhrFPFooQzvjItWyjZ2lVEDFDCExdWzvxDuX5l/v4OcxR3T
         J62w==
X-Gm-Message-State: APjAAAV19bebPVIc+4/+cHjupniv+Y5QBojFIrGfYC0WtU12EzPxZq9y
        NgVvA59U1ELnfcmk9XYcYKKJdw==
X-Google-Smtp-Source: APXvYqwlP592HsIruuRWcHEP49EkKextpSSoeAOyqMI9+/Ib/POB5GRvcPClRorTanW7gzMWxwXwyQ==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6mr12572348plb.223.1576195740634;
        Thu, 12 Dec 2019 16:09:00 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z19sm8245149pfn.49.2019.12.12.16.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 16:08:59 -0800 (PST)
Subject: Re: [PATCH] PCI: iproc: move quirks to driver
To:     Bjorn Helgaas <helgaas@kernel.org>, Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, rjui@broadcom.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20191212232344.GA36928@google.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <67db99be-5552-a0c7-bf67-a32d3156bb11@broadcom.com>
Date:   Thu, 12 Dec 2019 16:08:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212232344.GA36928@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-12-12 3:23 p.m., Bjorn Helgaas wrote:
> On Wed, Dec 11, 2019 at 04:34:38PM -0600, Bjorn Helgaas wrote:
>> On Wed, Dec 11, 2019 at 05:45:11PM +0000, Wei Liu wrote:
>>> The quirks were originally enclosed by ifdef. That made the quirks not
>>> to be applied when respective drivers were compiled as modules.
>>>
>>> Move the quirks to driver code to fix the issue.
>>>
>>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>>
>> This straddles the core and native driver boundary, so I applied it to
>> pci/misc for v5.6.  Thanks, I think this is a great solution!  It's
>> always nice when we can encapsulate device-specific things in a
>> driver.
> 
> OK, I moved this to pcie-iproc.c:
> 

Thanks a lot, Bjorn!

> commit 574f29036fce ("PCI: iproc: Apply quirk_paxc_bridge() for module as well as built-in")
> Author: Wei Liu <wei.liu@kernel.org>
> Date:   Wed Dec 11 17:45:11 2019 +0000
> 
>      PCI: iproc: Apply quirk_paxc_bridge() for module as well as built-in
>      
>      Previously quirk_paxc_bridge() was applied when the iproc driver was
>      built-in, but not when it was compiled as a module.
>      
>      This happened because it was under #ifdef CONFIG_PCIE_IPROC_PLATFORM:
>      PCIE_IPROC_PLATFORM=y causes CONFIG_PCIE_IPROC_PLATFORM to be defined, but
>      PCIE_IPROC_PLATFORM=m causes CONFIG_PCIE_IPROC_PLATFORM_MODULE to be
>      defined.
>      
>      Move quirk_paxc_bridge() to pcie-iproc.c and drop the #ifdef so the quirk
>      is always applied, whether iproc is built-in or a module.
>      
>      [bhelgaas: commit log, move to pcie-iproc.c, not pcie-iproc-platform.c]
>      Link: https://lore.kernel.org/r/20191211174511.89713-1-wei.liu@kernel.org
>      Signed-off-by: Wei Liu <wei.liu@kernel.org>
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 0a468c73bae3..8c7f875acf7f 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1588,6 +1588,30 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802,
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804,
>   			quirk_paxc_disable_msi_parsing);
>   
> +static void quirk_paxc_bridge(struct pci_dev *pdev)
> +{
> +	/*
> +	 * The PCI config space is shared with the PAXC root port and the first
> +	 * Ethernet device.  So, we need to workaround this by telling the PCI
> +	 * code that the bridge is not an Ethernet device.
> +	 */
> +	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +
> +	/*
> +	 * MPSS is not being set properly (as it is currently 0).  This is
> +	 * because that area of the PCI config space is hard coded to zero, and
> +	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
> +	 * so that the MPS can be set to the real max value.
> +	 */
> +	pdev->pcie_mpss = 2;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> +
>   MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
>   MODULE_DESCRIPTION("Broadcom iPROC PCIe common driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4937a088d7d8..202837ed68c9 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2381,32 +2381,6 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_BROADCOM,
>   			 PCI_DEVICE_ID_TIGON3_5719,
>   			 quirk_brcm_5719_limit_mrrs);
>   
> -#ifdef CONFIG_PCIE_IPROC_PLATFORM
> -static void quirk_paxc_bridge(struct pci_dev *pdev)
> -{
> -	/*
> -	 * The PCI config space is shared with the PAXC root port and the first
> -	 * Ethernet device.  So, we need to workaround this by telling the PCI
> -	 * code that the bridge is not an Ethernet device.
> -	 */
> -	if (pdev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> -		pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> -
> -	/*
> -	 * MPSS is not being set properly (as it is currently 0).  This is
> -	 * because that area of the PCI config space is hard coded to zero, and
> -	 * is not modifiable by firmware.  Set this to 2 (e.g., 512 byte MPS)
> -	 * so that the MPS can be set to the real max value.
> -	 */
> -	pdev->pcie_mpss = 2;
> -}
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
> -#endif
> -
>   /*
>    * Originally in EDAC sources for i82875P: Intel tells BIOS developers to
>    * hide device 6 which configures the overflow device access containing the
> 
