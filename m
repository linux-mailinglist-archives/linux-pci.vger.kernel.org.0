Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77C153FF86
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jun 2022 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbiFGM4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiFGM4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 08:56:36 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091397A810;
        Tue,  7 Jun 2022 05:56:36 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e5e433d66dso23015816fac.5;
        Tue, 07 Jun 2022 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLS7tQNn56jjH+puzkBXWN/PDzRhNhPsyuoB3P38+0o=;
        b=GHe27Z6Jkxw/+0HA6RgiePa4zSEKbKzers0hugcbMWMr5bJbkbCeItFiZyZodVQdCO
         Drx1fo5KygQp8G2VygioAfnqlJwPCxADoiaOuc9i9xnBjoGFSlKNtIyQqM9XRkwBnWO7
         upcarXqaE7G0hl6Qt8sJ7ZaxLeVy8O+In7nssy52o2+H3/dV2jmo+W7Iz5DxkmnWOUw5
         NSQZmsNFqQoIyAi21KiCMTta2029il71dIsrtLvV+7a/J/lSGbr0ct4OZeSpySsRUisI
         3HQk2ylsOQIoft3YzcKW49OWPuLeDXRtgOLTthLC17MQmJClEs7m5Lp5icpReuJEagjd
         nNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bLS7tQNn56jjH+puzkBXWN/PDzRhNhPsyuoB3P38+0o=;
        b=ZvEU7jfIPPbE4oVey9Hyl1ubPjdovAj9d437+Gs3pvw4MkYzYsTWWnBVuEqpzDkMxe
         OftBWXE0/gS089hSGv4lH4dQaqUcisYtiM19ENWD4ZnIwKTUf1XTzUxDpis9duKd49XP
         TyxOzXc8Kh9FWz3ERjDSCU+jnc6Q2ETHzRSUsJ1H7JSP6BMhekYGjGc+d+DteyvZUIsd
         s5gnzM9d8bfLMQF2siapNVZNXWBPKqUxQ13PMDDa363gnBF0mvYHz3qCEI0yrr6TCT+f
         4R7PIcgGbzkVQxgx6Qoo8Pk6ijjSwg4RQzsA0Onxk+/JdOi3YtI0CcqHQ/fTiF0N4tlp
         +vxA==
X-Gm-Message-State: AOAM531jU8/ADNFGh3P7aJCMAHqmQKzeb3l0+jEVeKtG9/S8najmI3kV
        8Xaj8rPE5o0dnYUzyEiE8es=
X-Google-Smtp-Source: ABdhPJyKaeFSa2UkUqJ48ZB/5OFISEdJc8ytlCSkZ2DJGDkvy3KWScg32CLDimVMqW6hikhFYKrm9g==
X-Received: by 2002:a05:6870:b41c:b0:f2:5d2b:9a77 with SMTP id x28-20020a056870b41c00b000f25d2b9a77mr16377912oap.62.1654606595409;
        Tue, 07 Jun 2022 05:56:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o7-20020a056871078700b000f32fb9d2bfsm9130713oap.5.2022.06.07.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 05:56:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Jun 2022 05:56:33 -0700
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
        linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        babu.moger@amd.com
Subject: Re: [PATCH 1/2] x86/amd_nb: Add AMD Family 19h A0-AF IDs
Message-ID: <20220607125633.GA1787169@roeck-us.net>
References: <20220601172121.18612-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601172121.18612-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 12:21:18PM -0500, Mario Limonciello wrote:
> commit 4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh)
> and (A0h-AFh) PCI IDs") had claimed to add the IDs for models A0h-AFh,
> but it appears to only have added the models 10h-1Fh.
> 
> Add the actual IDs for A0-AF which are needed for SMN communication to
> work properly in amd_nb.
> 
> Fixes: 4fb0abfee424 ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/kernel/amd_nb.c | 5 +++++

I'll need an Ack from a x86 maintainer to apply this series,
or it needs to be applied through x86. I sent an Ack for patch 2/2,
so the latter would be fine with me.

Thanks,
Guenter

>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 190e0f763375..cc8c7cfa9068 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -25,11 +25,13 @@
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
> +#define PCI_DEVICE_ID_AMD_19H_MA0H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_19H_MA0H_DF_F4 0x1728
>  
>  /* Protect the PCI config register pairs used for SMN. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -43,6 +45,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_ROOT) },
>  	{}
>  };
>  
> @@ -67,6 +70,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3) },
>  	{}
>  };
>  
> @@ -85,6 +89,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{}
>  };
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 0178823ce8c2..05b4c67a8a2a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -560,6 +560,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
> +#define PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3 0x1727
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
