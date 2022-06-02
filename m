Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B636E53C030
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 23:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiFBVFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiFBVFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 17:05:49 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E273527C;
        Thu,  2 Jun 2022 14:05:48 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l9-20020a056830268900b006054381dd35so4266567otu.4;
        Thu, 02 Jun 2022 14:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HGr/+ymyczZCHw1APWris6lQW2YQvCdg22oqh/0jGeA=;
        b=oAFasd9GCb80UlOnD8ktOGBBXm//vGHyTigWKupoKRuESokdf5g57nMovIVR09q4gj
         4O2dkfFWSs7ZN99ll4mP3Zj80Oy5/uDK7uodA7GUKsQfI7SVfpkRXHCJ8QuDVildyx/2
         zcyQCWL06W71MARQtw0dv6T91L2EBBOFmFMM/Qv1iiWDk5g0yoybuSHqHdotlHJ66M45
         SdvjGLQabE1CPUDTyZIgP81UYI4PtzhOqUsvU/LxE5tRgSmNJBWXvXzda7Bjcdiuf5Ds
         ZICVKVNm5CL7o0T8RhyWIsMrL7XoJH7doOlgD+LLAM5571coGzHSyEoeagq99guJheBD
         WarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HGr/+ymyczZCHw1APWris6lQW2YQvCdg22oqh/0jGeA=;
        b=tEsG/Go7CQuSqPPBUHQN5dU//Cm2B+sLqaRKXBOvyFGIkC/i6hTCoU7YgBinWvqymN
         CyhJGXRJd5jepWGSmTGFaVeoXWkGdYxN8LniqnK7MbzrgSeNg2ITgVD7uyXm9f/sORfX
         b2bDHIf6SMOCmz61itmocu+0S1r+UANKWNefQqeJcAyHYnfxtzBFIgJoo+DV5gyjHTIC
         FG6C+46WXhdDk4Mcpl7JD2b3L2TXcD24tIC80wVHQ7q3blt5km9+66wd+hOzF8MdEi6C
         5uR/kXXJrN0myNqk7mfUyHZeHdSnUtb1Ay8NSMSWzLZQfwCVqwmrXu3OAPml+B4Vf76Z
         OR6A==
X-Gm-Message-State: AOAM531uADMn66PY3N86A/ptchSVxqyxfXLjh0HiTY+7oFlZG8iJKpkK
        AIplQcP68fj6G1mHSOh4InA=
X-Google-Smtp-Source: ABdhPJySSK14us5JjYsqa+GuIo/MKS6M/M+wxgYB8/dNy8IQOvxhybAtTW5jPp/i5RnAjtEcw+Sy8w==
X-Received: by 2002:a05:6830:3107:b0:60b:3c30:865c with SMTP id b7-20020a056830310700b0060b3c30865cmr2827446ots.335.1654203947453;
        Thu, 02 Jun 2022 14:05:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w5-20020a056808140500b00326cb6225f8sm3050312oiv.44.2022.06.02.14.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 14:05:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <371592c1-28e6-6c77-f820-9bb6f6236f42@roeck-us.net>
Date:   Thu, 2 Jun 2022 14:05:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/6] x86/amd_nb: Add Family 19h model 70h-7Fh IDs
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Babu Moger <babu.moger@amd.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Cc:     linux-hwmon@vger.kernel.org
References: <20220602201137.1415-1-mario.limonciello@amd.com>
 <20220602201137.1415-3-mario.limonciello@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220602201137.1415-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/2/22 13:11, Mario Limonciello wrote:
> Add support for SMN communication on Family 19h Model 70h.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I can not apply this series without the context patches (which I wasn't
copied on), so I assume the idea is to push this through the x86 tree.
This is ok with me.

I can not apply this patch without the context patch (which I wasn't
copied on), so I assume the idea is to push this through the x86
tree. This is ok with me.

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/x86/kernel/amd_nb.c | 4 ++++
>   include/linux/pci_ids.h  | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 60c7bd525237..15295f5d9aca 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -32,6 +32,8 @@
>   #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>   #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>   #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
> +#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
>   
>   /* Protect the PCI config register pairs used for SMN. */
>   static DEFINE_MUTEX(smn_mutex);
> @@ -46,6 +48,7 @@ static const struct pci_device_id amd_root_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
>   	{}
>   };
>   
> @@ -71,6 +74,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
>   	{}
>   };
>   
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index ec1c226d13e6..32a1f85ff0de 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -561,6 +561,7 @@
>   #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>   #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>   #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
> +#define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
>   #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>   #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>   #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001

