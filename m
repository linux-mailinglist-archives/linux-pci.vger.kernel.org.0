Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF0D4658F9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 23:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbhLAWUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 17:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242357AbhLAWUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 17:20:32 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375CC061574;
        Wed,  1 Dec 2021 14:17:10 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id bk14so51601258oib.7;
        Wed, 01 Dec 2021 14:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZD+wACY3SAuTXTUljVln3laEvcK5M7PHpyfxljx+Jk=;
        b=AFp0DZrbg+kL+LwrvONlq6K9FDEB8l4aqulKDEq9wkZYI1E3lFkReWCc4n8My8QcOV
         FK5pStCUOz5JLp7w22iP6i+uL/Ci4JMR0VjMeNKUlj7Lbb8k3ukrWMgpiUUVxdfTTEh3
         4v0vwPCtSo8PzDZN+xvuS3AWguRN/2N5QUCoCf9ffXnO02Sb7bW4my+rFvzJRvVBOCnn
         IxA/THxjH/ytSTKJPvX3pH+4GpYDri3PxrtG3M9qeID9eYn9a82SiLaT8jrLXp2bPJYU
         ll6jVQjBIV4khOG/hQI4u01oXbo9HFh48Mwg4tSGWxHHf/nqzgwGD4WhcZN5CyGwObdT
         UKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZD+wACY3SAuTXTUljVln3laEvcK5M7PHpyfxljx+Jk=;
        b=c0F+jup9q9/PC1Qxcm3Bw92EntGmylqwY2vUZhAfHPMasFIuntSyZBXG9mTWXVofDr
         S6zjvh5D7ET8YmAN4MuxgVT9L2XEj6V2Q0EpepeVGtX2RSjQbBBMFNnjRmwKzGkDF3Qc
         8+u1VqildEtGW+fWhdCmtXz3+6DFcFr08NfVcZLV6oF7p9e7lMTey/rSWjQG1bY7Qmw5
         Y79Cje4kaFVAK6AuhLp1RnJIHCyUK7ZePQH6vPS2KVU0kK8AjGzWg8MawWbEU1NvrF4q
         544ICB5FgUsCGcdh5+EiPhhTOZ6VnjQF4WjMFLhhmPNaHIzVYes2kRcgg2tLhKKstIpN
         yi4g==
X-Gm-Message-State: AOAM531uMk8dqXZXZb8PEsO7lG6vYLFkYLBEcAO5CH9ZiEqWUInsOlPu
        VG7jmy8M6hcSZ+W47DlskeUz9dCmiz8=
X-Google-Smtp-Source: ABdhPJy/Ko5RmZFfrSdHWpJGy3yrJjyfbKqIy4l3ek0avXdcJzN5Kt1mcKgyyxew4PMN97s50heykw==
X-Received: by 2002:a05:6808:1403:: with SMTP id w3mr1054161oiv.80.1638397029652;
        Wed, 01 Dec 2021 14:17:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3sm382044otk.71.2021.12.01.14.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 14:17:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/5] MIPS: ralink: implement
 'pcibios_root_bridge_prepare()'
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
 <20211201215127.23550-3-sergio.paracuellos@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d243a90d-25b2-a65f-b69d-af7497db8742@roeck-us.net>
Date:   Wed, 1 Dec 2021 14:17:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201215127.23550-3-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/1/21 1:51 PM, Sergio Paracuellos wrote:
> PCI core code call 'pcibios_root_bridge_prepare()' function inside function
> 'pci_register_host_bridge()'. This point is very good way to properly enter
> into this MIPS ralink specific code to properly setup I/O coherency units
> with PCI memory addresses.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>   arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
> index bd71f5b14238..7649416c1cd7 100644
> --- a/arch/mips/ralink/mt7621.c
> +++ b/arch/mips/ralink/mt7621.c
> @@ -10,6 +10,7 @@
>   #include <linux/slab.h>
>   #include <linux/sys_soc.h>
>   #include <linux/memblock.h>
> +#include <linux/pci.h>
>   
>   #include <asm/bootinfo.h>
>   #include <asm/mipsregs.h>
> @@ -22,6 +23,35 @@
>   
>   static void *detect_magic __initdata = detect_memory_region;
>   
> +int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	struct resource_entry *entry;
> +	resource_size_t mask;
> +
> +	entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
> +	if (!entry) {
> +		pr_err("Cannot get memory resource\n");
> +		return -EINVAL;
> +	}
> +
> +	if (mips_cps_numiocu(0)) {
> +		/*
> +		 * FIXME: hardware doesn't accept mask values with 1s after
> +		 * 0s (e.g. 0xffef), so it would be great to warn if that's
> +		 * about to happen
> +		 */ > +		mask = ~(entry->res->end - entry->res->start);
> +

Try something like this:
		WARN_ON((mask != ~0UL && BIT(ffz(mask)) - 1 != mask);

> +		write_gcr_reg1_base(entry->res->start);
> +		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> +		pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> +			(unsigned long long)read_gcr_reg1_base(),
> +			(unsigned long long)read_gcr_reg1_mask());
> +	}
> +
> +	return 0;
> +}
> +
>   phys_addr_t mips_cpc_default_phys_base(void)
>   {
>   	panic("Cannot detect cpc address");
> 

