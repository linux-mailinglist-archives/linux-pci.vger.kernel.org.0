Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC113FA0EC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhH0U40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 16:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhH0U4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 16:56:24 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33532C0613D9;
        Fri, 27 Aug 2021 13:55:35 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bi4so7468379oib.9;
        Fri, 27 Aug 2021 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AR/V/S4gEhO+Sv9RlmX7K43eYdJGeLu7Uj2QL6eME/4=;
        b=OII8pcnwn6M07SYN+svsPeGO0pm5GfVFfgE2/WFNp/GXrNr0kgn/d+NBRka8zUo9dH
         1LtredJj5T381fsZKuHHOSLk85i8NV4dRQxS922YLg+fCBUvU1Oa4qusXtuKng7A2Jly
         lpjCso05LAtVKlqQZBG5My+62Wzd50V3sh7ND7OG+OGmbFkvQ29vDyAUuAqqPliQh0i6
         sPrS+Xt9yieF+eP+7O2iN1RkKmtDuwgXvVT7pED3I0jjbF89WyWrL/TeJmBILMa4hOpL
         hqMhO3PKIzxUUj7bEGY8sTZjRgfwprLoI7rEwirElHbr5mxOK28xj01pdMgZDqY4idAh
         9NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AR/V/S4gEhO+Sv9RlmX7K43eYdJGeLu7Uj2QL6eME/4=;
        b=Sfc9aZ09/KPWUdd+G4gQmn6vYbUsTaFujCC0lJ4KRvG6NkN0++5BU+9ggmBEPB1HJT
         5y1cCGOsMUJ8hH2083EQY9MN8pB5rmy9lrJEXdbL7x7XhBBkL9xEbw0g9Ih9HHU0bx8D
         R+A2Ds6gv5aWqZYqdysThyGCbCsBy8FiY9FEU7cVlyYvKn+usA43+woZn6V3j6jfiCeZ
         pyNlkLjzvFq+NuDo2PNVSP7SL+MhL8dKL1CR6Bkf9XJHdraAWWIuz4zBpTXWhMJmIkqS
         rGuo8kBND33YYGdm/rGQm6n6o5gW0dXwr86AphkQyxow4mSjwmt4gL9lLilT1hbmVhVH
         WGEQ==
X-Gm-Message-State: AOAM532lmRBkHhyjcUjoVhkonVrWsHyf0XhfVzEhU3EtHiZZXqnIe2P5
        Du0Rg5Zcb5RL5CKECeaCHHo=
X-Google-Smtp-Source: ABdhPJxzq6AxmxkYeBzWiT6pA+A6AZP4mPuk9QC+1wUixuJjhYHn5Kcsa8xdBNyLHp/riMITGDrkVw==
X-Received: by 2002:a05:6808:214:: with SMTP id l20mr7951527oie.134.1630097734596;
        Fri, 27 Aug 2021 13:55:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c14sm1457336otd.62.2021.08.27.13.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 13:55:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Aug 2021 13:55:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Wei Huang <wei.huang2@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jean Delvare <jdelvare@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        David Bartley <andareed@gmail.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] hwmon: (k10temp): Add support for yellow carp
Message-ID: <20210827205532.GA678720@roeck-us.net>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
 <20210827201527.24454-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827201527.24454-3-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 27, 2021 at 03:15:26PM -0500, Mario Limonciello wrote:
> Yellow carp matches same behavior as green sardine and other Zen3
> products, but have different CCD offsets.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Borislav Petkov <bp@suse.de>

Applied.

Thanks,
Guenter

> ---
>  arch/x86/kernel/amd_nb.c | 5 +++++
>  drivers/hwmon/k10temp.c  | 5 +++++
>  include/linux/pci_ids.h  | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 23dda362dc0f..c92c9c774c0e 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -25,6 +25,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
> +#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
> +#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>  
>  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
> @@ -37,6 +39,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
>  	{}
>  };
>  
> @@ -58,6 +61,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{}
>  };
> @@ -74,6 +78,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{}
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 159dbad73d82..38bc35ac8135 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -459,6 +459,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			data->ccd_offset = 0x154;
>  			k10temp_get_ccd_support(pdev, data, 8);
>  			break;
> +		case 0x40 ... 0x4f:	/* Yellow Carp */
> +			data->ccd_offset = 0x300;
> +			k10temp_get_ccd_support(pdev, data, 8);
> +			break;
>  		}
>  	} else {
>  		data->read_htcreg = read_htcreg_pci;
> @@ -499,6 +503,7 @@ static const struct pci_device_id k10temp_id_table[] = {
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> +	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 5356ccf1c275..e77a62fd0036 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -555,6 +555,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
> +#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
