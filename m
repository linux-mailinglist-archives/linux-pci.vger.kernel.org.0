Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DF854A0AF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jun 2022 22:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351444AbiFMU7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351455AbiFMU5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 16:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01E817667
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655152305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IemLxworfi1ssWHIr1XY0msbamo9wIJHBY45twSSanM=;
        b=J+ZW3GAVN1168EMNv62nROgTgsmz2w06wYphfPnvlg03UMnmGNSowZ82JcvFT518UdkKXt
        MgafnvWmUFZ5ZOqcAEd1pLvWSb2KIqeWv4PD1QodjVDBLBplmE0AYMBKA9gAvhh5i9ONQ2
        LrQQFcVFVd+ZGr9OmerOSMxzQC7JL60=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-5WLtQHN6PgSAdPTn1yy3og-1; Mon, 13 Jun 2022 16:31:42 -0400
X-MC-Unique: 5WLtQHN6PgSAdPTn1yy3og-1
Received: by mail-ed1-f70.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso1682961edx.19
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 13:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IemLxworfi1ssWHIr1XY0msbamo9wIJHBY45twSSanM=;
        b=POpQ64FF5DxiFfFheu7OZd/V1O68h2nrIrUpYGhGeXIqF4Qhdqd/SOpUohA5PpeYrZ
         XN1xbWyENpC9dhU9UtfgQdEVbxy6qIGm6u07SVembafU7InTRuUm0TXvUFOvPPgqE3xP
         WxPiGdD3B4DfiaaNN0KCSPGcIpbMe0Ly8oQp+3bMJDQ6Tf9xXnMOPP3ytEhxHe++j9D9
         JsxqVwmwRE+h27c+jHvWr+3z8VNaioBrkS3s4Cuk+ItKTbHyGIezbEF4yz4JzubcxBwn
         5RsPS6Pl+RoXNGUjv/7FhZlBFtdA2wmJLi8Pnf7Et6wDy2P7QwAM0eAL1Eq8XQiv/d+s
         9H3Q==
X-Gm-Message-State: AOAM533E7eiQ+kFuNB2CSu0OMKCgJ5l8aUteJuvu3uN05+Bdz+y1+QEI
        QqSlqtf71PoSg1TSERqIeKv7gmShnJy1Je0FvAi7tq3+L0PyG4M2IQAL1unE9UbieAXrvF48h2A
        dHYe/TE6W6wLUbavIKDc+
X-Received: by 2002:a17:906:1109:b0:711:d8fe:fe56 with SMTP id h9-20020a170906110900b00711d8fefe56mr1326763eja.261.1655152301314;
        Mon, 13 Jun 2022 13:31:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFYL6OPM1ZkwR1etQsbWL8guElE0GayChWZSl3pxUxYwdxlGsh/5LPiNVqQEj6Yg/QMdLsfg==
X-Received: by 2002:a17:906:1109:b0:711:d8fe:fe56 with SMTP id h9-20020a170906110900b00711d8fefe56mr1326738eja.261.1655152301108;
        Mon, 13 Jun 2022 13:31:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u20-20020a509514000000b0042dd1d3d571sm5678676eda.26.2022.06.13.13.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 13:31:40 -0700 (PDT)
Message-ID: <45d458f5-4f4e-9ebd-cb51-1a7b784248ec@redhat.com>
Date:   Mon, 13 Jun 2022 22:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/1] x86/PCI: Disable e820 usage for the resource
 allocation
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ferry Toth <ftoth@exalondelft.nl>
References: <20220613201641.67640-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220613201641.67640-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/13/22 22:16, Andy Shevchenko wrote:
> The resource management improve for PCI on x86 broke booting of Intel MID
> platforms. It seems that the current code removes all available resources
> from the list and none of the PCI device may be initialized. Restore the
> old behaviour by force disabling the e820 usage for the resource allocation.
> 
> Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
> Depends-on: fa6dae5d8208 ("x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Andy, thank you for the patch. Commit 4c5e242d3e93 has also been causing
issues for other platforms, so I've submitted a revert of it here:

https://lore.kernel.org/linux-pci/20220612144325.85366-1-hdegoede@redhat.com/T/#u

can you please give the revert a try, and confirm that that fixes
the Intel MID platform issue too ?

Regards,

Hans



> ---
>  arch/x86/include/asm/pci_x86.h | 1 +
>  arch/x86/pci/acpi.c            | 2 +-
>  arch/x86/pci/intel_mid_pci.c   | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index f52a886d35cf..503f83fbc686 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -126,6 +126,7 @@ extern const struct pci_raw_ops *raw_pci_ext_ops;
>  extern const struct pci_raw_ops pci_mmcfg;
>  extern const struct pci_raw_ops pci_direct_conf1;
>  extern bool port_cf9_safe;
> +extern bool pci_use_e820;
>  
>  /* arch_initcall level */
>  #ifdef CONFIG_PCI_DIRECT
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index a4f43054bc79..ac2f220d50fc 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -20,7 +20,7 @@ struct pci_root_info {
>  #endif
>  };
>  
> -static bool pci_use_e820 = true;
> +bool pci_use_e820 = true;
>  static bool pci_use_crs = true;
>  static bool pci_ignore_seg;
>  
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index 8edd62206604..7869b86bff04 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -313,6 +313,7 @@ int __init intel_mid_pci_init(void)
>  	pcibios_enable_irq = intel_mid_pci_irq_enable;
>  	pcibios_disable_irq = intel_mid_pci_irq_disable;
>  	pci_root_ops = intel_mid_pci_ops;
> +	pci_use_e820 = false;
>  	pci_soc_mode = 1;
>  	/* Continue with standard init */
>  	acpi_noirq_set();

