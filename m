Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472334C8AA5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 12:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiCAL0n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 06:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiCAL0n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 06:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACE4A91371
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 03:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646133961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFMGRfIAmrHrnLa3rzlWjdovVbrK0w7x/Azrkml2F4k=;
        b=PN2J4tOpc148IaYCYaqi6+7lQhepBOAWtlPtv4X7chOJuGNmW1rwF3Zm6HWWxeMAyCEbPJ
        MXjXNBk5Y2C1r9gDWPPpvDwAP1c/ksbAc98DPVswl1sdAMKvbZOVoPOlXwQFYgfujcmKw6
        7yc6sQi6CGkMNNUDlep4jtP7WDxuCPs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-33-J35lnMjFN0mLTG8Pe6O73Q-1; Tue, 01 Mar 2022 06:22:57 -0500
X-MC-Unique: J35lnMjFN0mLTG8Pe6O73Q-1
Received: by mail-ej1-f72.google.com with SMTP id k21-20020a1709063e1500b006d0777c06d6so6707160eji.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Mar 2022 03:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pFMGRfIAmrHrnLa3rzlWjdovVbrK0w7x/Azrkml2F4k=;
        b=u0778OwNkKOA9TeDCZhTCANSHW+N2JuKqGxCur5OWtCQ3U9iBLKOI9SY17VjAiVI0h
         j5+sXhsvdebJmLcO8qtcy4vBvE4tvr37G+YQ2QNVdGFjxOl2O62lzHOSnfwZ6LCdMq1K
         j+Nzn+FbTMSVggLGiHh/bae9uEnfAaxQGrf1kNL0/n0k0yBhKYzY+ENkk3vEyyBuj98d
         Z4QyyIHNe3W/P48JiiQ0uEf2fObexqBVf0xLtK7L1SA0xnKkptlllNxZKsHPiNSY1c/d
         Vt7UyH/QhbMhRKZaZA7I50ApsX6isuQtSDJ7lyzqTjEFGc4MBRj/R0EesA4qGh/xm3TW
         Jg7A==
X-Gm-Message-State: AOAM533jWxihMJxPLNmqHQD/TLZDZQGkackYUGMx/ascbA3yaQE/K24C
        ZTDoDyva4KISkwL16EP7YVyCqc553NvNsRJEHY/TcOURj4Tt5/ezHnYSMW3NhT6zbQiOLwX8oXW
        L/zCVxHskLOvccVdRRbRF
X-Received: by 2002:a17:907:1de9:b0:6b9:e4f:25ec with SMTP id og41-20020a1709071de900b006b90e4f25ecmr18442056ejc.741.1646133771856;
        Tue, 01 Mar 2022 03:22:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+FvelUXqjUMkFgQlPbM4vmDcfG8aw+ARZ98e8mbNjb+ZEBkzBWNtvUDQB7qjysKVje2E3iA==
X-Received: by 2002:a17:907:1de9:b0:6b9:e4f:25ec with SMTP id og41-20020a1709071de900b006b90e4f25ecmr18442036ejc.741.1646133771584;
        Tue, 01 Mar 2022 03:22:51 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id et3-20020a170907294300b006d6534ef273sm4619085ejc.156.2022.03.01.03.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:22:50 -0800 (PST)
Message-ID: <497da433-f300-cfed-33af-02b8e9f16426@redhat.com>
Date:   Tue, 1 Mar 2022 12:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] x86/PCI: Fix use after free in
 pci_acpi_root_prepare_resources()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20220301081010.GA17375@kili>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220301081010.GA17375@kili>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/1/22 09:10, Dan Carpenter wrote:
> The resource_list_destroy_entry() function frees "entry", so move the
> dereferences before the free.
> 
> Fixes: 62fabd56faaf ("x86/PCI: Disable exclusion of E820 reserved addresses in some cases")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  arch/x86/pci/acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index e4617df661a9..fa89ffba2e51 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -357,14 +357,14 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>  	status = acpi_pci_probe_root_resources(ci);
>  	if (pci_use_crs) {
>  		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
> -			if (resource_is_pcicfg_ioport(entry->res))
> -				resource_list_destroy_entry(entry);
>  			if (resource_is_efi_mmio_region(entry->res)) {
>  				dev_info(&device->dev,
>  					"host bridge window %pR is marked by EFI as MMIO\n",
>  					entry->res);
>  				pci_use_e820 = false;
>  			}
> +			if (resource_is_pcicfg_ioport(entry->res))
> +				resource_list_destroy_entry(entry);
>  		}
>  		return status;
>  	}


Thank you, I actually send a new version of that commit to replace the original
one also addressing some other issues:

https://lore.kernel.org/linux-acpi/20220228105259.230903-1-hdegoede@redhat.com/

I expect Rafael to pick up the new version, resolving this. But maybe
Rafael prefers a follow up commit instead ?

Regards,

Hans

