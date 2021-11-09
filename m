Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD42544B3F2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 21:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244318AbhKIUbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 15:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbhKIUbr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 15:31:47 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F355C061764;
        Tue,  9 Nov 2021 12:29:01 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id be32so854086oib.11;
        Tue, 09 Nov 2021 12:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6GlLfHyxrJtakkswPGlQUnwqHu16D3zpv7l0fb4R9EA=;
        b=fI9r+sWmDHUqUsfVWZWaYL1pvM1PX/W/Z18RpAhIpiSP+4tzZNH47ih2KpWKi9OtqA
         heqx5vAnHdZtg+gFUfpMEjruYHrQYlL0K4Gdr42idGuNPRLSFxPR1A7q9QcW94+O5du9
         ZrcfoPjW8RMY0Kg+tNOQ8KmRYCZaKYx6jo4d+0z2UEAUEOhFwd0x9fsfV5yyrSOAef3W
         YVD72rs1nNKjHVxrrmB+Gon9YWRvw5GEu+zh9mVNRJuTruey5HMZ38rU76iHkXS/8bnz
         tIDRSPfrfplBmR7b9DwQ3QT6fKqo87Cblg+6HvhDZ/Eb2FHqnGY1Opw/LnztqX4Q/mYp
         ixqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6GlLfHyxrJtakkswPGlQUnwqHu16D3zpv7l0fb4R9EA=;
        b=3YjjaT0IW4wgEEOBLzrSyZNw5eHAve4GUu0DY6DsstYwGAWPep7sMqXYnZhnTaWBId
         4omb/Rwylx/Fw0dZtM3H7Yvzy47i4u5l2r6AFgmqFkeItNJQ9N7T4iR5g1sdNAoTdfnT
         pLviwPYUF1OsmKQGreNzieEg8IkJQOdBqyIlgQmytf/wJ6Dyhmz1wl4c+IX2I8MOdBeN
         r34fqxNn7ISNdD5IsgqiE1jPMkkHNQE5vmRVhGCpZNfnPRyxwObKb9Qs4ZS69eBTNdW0
         nY6w7RoKoe/BQmM+SRpos7S9grWyvCW9QaaHbeJ4an6hEKo7ELZcljZyf+i8gop+k6t9
         F3fQ==
X-Gm-Message-State: AOAM533ydJrVdszHz7XL+yFQzsKY3WSbZ+Xwx74aYX2rpqteuRBbyIcz
        DNGXB6NP2er0dGnJ0gxhyG0=
X-Google-Smtp-Source: ABdhPJySifUnLFlgayyTlHcGz3287vSYaDvTSG3SD/tpQ5NtXMwiBX/Q/SjLLuCpR9u5cSRoChOHzA==
X-Received: by 2002:a05:6808:1984:: with SMTP id bj4mr8567389oib.165.1636489740539;
        Tue, 09 Nov 2021 12:29:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e21sm2408234ote.72.2021.11.09.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:28:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Nov 2021 12:28:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Babu Moger <babu.moger@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        clemens@ladisch.de, jdelvare@suse.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and
 (A0h-AFh) PCI IDs
Message-ID: <20211109202857.GA3692856@roeck-us.net>
References: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
 <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 03:51:21PM -0600, Babu Moger wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Add the new PCI Device IDs to support new generation of AMD 19h family of
> processors.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Acked-by: Krzysztof Wilczyński <kw@linux.com>
> Acked-by: Borislav Petkov <bp@suse.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_ids.h

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  arch/x86/kernel/amd_nb.c |    5 +++++
>  include/linux/pci_ids.h  |    1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index c92c9c774c0e..f3e885f3dd0f 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -19,12 +19,14 @@
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
>  #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
> +#define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
> +#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F4 0x14b1
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> @@ -39,6 +41,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
>  	{}
>  };
> @@ -61,6 +64,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{}
> @@ -78,6 +82,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 011f2f1ea5bb..b5248f27910e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -555,6 +555,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
> +#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
