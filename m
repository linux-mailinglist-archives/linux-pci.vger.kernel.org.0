Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F3853FF9A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jun 2022 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244341AbiFGNAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiFGNAp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 09:00:45 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681BB0A5C;
        Tue,  7 Jun 2022 06:00:42 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f2bb84f9edso23024426fac.10;
        Tue, 07 Jun 2022 06:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DFToUn3iIlPxtwCctA389NaCQNcd2lS9FNAvhbLgX7A=;
        b=eFM0y3cJ4KihBtIvqfCsN8r9BkeugI0423BFDlCGweJVhmjOc4pY7PEHHOseD33BR3
         sjALDaeJEWfKLLnpML8JZkwcqfpPAnOYO3hgYy8VbBQ20UK8LKS1gICJdQx1fzebLxdM
         SaTKvHRUHB3sqtBrYaNudmnZ/MWJL1OZWa/BarJSJXkVGzqmVQKJsTIh0ccEGPjuDsWA
         pf26EdU8u5ZtbzyMi5vOo5zTfzTn6caXkEqMeL8//Ob69Vw0Cmz4FG4SaBjiMnObSg90
         o3NDJ/heHKciiHqhngJDVp9kHRQS52mw0Zujex2/lSV0aE/5nzknpOCUiEB+JhuTKdEP
         XU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DFToUn3iIlPxtwCctA389NaCQNcd2lS9FNAvhbLgX7A=;
        b=tmjL7EtLkhXO7/hWFWK4jHul2oo1+RS4SQx5bBB5qHkC+h3vMHn00TdJvVP23D3VGN
         Jxswa7USw7tWH4WNtwYlaioJQFKzrcNNzkR2DtYnWibhdCL7zMjlwBhRE6PMJL6qiJWT
         tbnjwRJuzYiiQEidQvs3psVKQb6PUAxBIMfQVkS9XNOJJcU/WyX4w/w3xDDs27kw90A2
         B117kSBvH0B8TTmkSV+HOOEfqlYh7yyQX3vPuZr3mvaDwvkLAGKG4LVhcSgJbh0mthbv
         /86s1+yHRD03Yic3MCJUEt0wCOXCWkAcodEiYJw3WGIcbt4r2ErB+SKdoe47yNaJWBBZ
         I/Zw==
X-Gm-Message-State: AOAM532UjINPDxgUXnSSALFyL+K3jKWuhBnHkHExaJ9o+VRdzClB6TpI
        rOxZDLU16OUBZ+cZCsgNfhY=
X-Google-Smtp-Source: ABdhPJw9+QuoevZiTtGaeX6fa/5aU29ffGoDEmpMzhDm0HudV6g2B23y5grfm/Z5prDTntn74tvJKw==
X-Received: by 2002:a05:6871:797:b0:f1:d49b:2f3b with SMTP id o23-20020a056871079700b000f1d49b2f3bmr16274781oap.40.1654606841310;
        Tue, 07 Jun 2022 06:00:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb35-20020a056820162300b0040e8c09f99dsm9518388oob.23.2022.06.07.06.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:00:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Jun 2022 06:00:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, babu.moger@amd.com
Subject: Re: [PATCH v2 1/6] x86/amd_nb: Add AMD Family 17h A0-AF IDs
Message-ID: <20220607130039.GA1787486@roeck-us.net>
References: <20220602201137.1415-1-mario.limonciello@amd.com>
 <20220602201137.1415-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602201137.1415-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 03:11:32PM -0500, Mario Limonciello wrote:
> Add support for SMN communication on Family 17h Model A0h.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Drop fixes tag
>  * Fix commit message and definitions for s/17/19/
> ---
>  arch/x86/kernel/amd_nb.c | 5 +++++
>  include/linux/pci_ids.h  | 1 +

I would need maintainer Acks for patches 1-3 of this series to apply them
through the hwmon tree. Alternatively, I am ok with applying the series
through the x86 tree.

Thanks,
Guenter

>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 190e0f763375..60c7bd525237 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -19,12 +19,14 @@
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
>  #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
> +#define PCI_DEVICE_ID_AMD_17H_MA0H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
> +#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4 0x1728
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
> @@ -41,6 +43,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
>  	{}
> @@ -61,6 +64,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> @@ -81,6 +85,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 0178823ce8c2..ec1c226d13e6 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -556,6 +556,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
> +#define PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3 0x1727
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
>  #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
