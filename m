Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26946F9265
	for <lists+linux-pci@lfdr.de>; Sat,  6 May 2023 16:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjEFOFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjEFOFO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 10:05:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D59EE3;
        Sat,  6 May 2023 07:05:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643aad3bc41so1575515b3a.0;
        Sat, 06 May 2023 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683381913; x=1685973913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkd6WhOnQ+KRJOV8mq0TlD1Vd10aUH02oQzy0floNgM=;
        b=oZ/wzpDrNQU5oZBQyozEZp/aueljhoFfsUE1M196wAGapBqhMVXtvpTaANriQD12z1
         CYEg7PWsaSBrOYqkBgPV8q4xpWcZjVvQvmJnmaQyrVuah01sUWYm5MOhaTa6rY0u+ao9
         J5SvoqKaCvLK2gtKqK20sWmTQYhZbLxQQO61uiKXv2H3Uncipj5skzx2G/+y3Qfd3QHx
         Z79evxngpcyoP9GLiK60fAzLGujA+naSqO2YqU9zJfnzWpCbTzA/sBRKPly2zdZWhkJo
         6D6py3AEBxeCN6Bibnfr7yexfudCV/IE/YBSot3fPUKvt3wNC8eXHIVIvcTf1YYD8rd/
         DwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683381913; x=1685973913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkd6WhOnQ+KRJOV8mq0TlD1Vd10aUH02oQzy0floNgM=;
        b=W1+MNd0b4wVzEtNJDWU5EhohebKEvAcyrkv4TRT+rsvUXiGK52vPgEDur0uVEoQQuW
         r2RjnHq0eWC+NA7TU9+Zv6oNDkxkL60Z+/PbX560MDGTo7xABwqRINjtpmHIFay4ftkZ
         qsd5HSdlm6jQoU+uS6HfSlj+TVQluqVPAqH6LsUNhaCw2fW/g9Uep97mEvWAsx3sZU+X
         LobIfQjA8CRV7jHvKUWspQ+4e71XVcII1KNbh+Cx1uHTLj4pm6SwU3LWnpDnF+hN0yHC
         9jHgcMrTjTKG6qFwf9pgFCLIEb3dNn7+dnCDX/g2KxQ6VqKIOxGNAzKQYbptgjNek1X4
         K6hw==
X-Gm-Message-State: AC+VfDyZ/4zZEee0LF+BpqdCjK+3l/NChLTEaw8zX1jFBWAUFtDOAAU+
        XGKbqydzVuNELmMS54fDg04=
X-Google-Smtp-Source: ACHHUZ7rgEFomnilJPyZ9wR1v0RoF0VJiK09vgckHJn4op9dBHqIrGd5UF7Buqd+HJ5Z29zeoKndfg==
X-Received: by 2002:a05:6a20:442a:b0:ff:68f1:679 with SMTP id ce42-20020a056a20442a00b000ff68f10679mr2930570pzb.52.1683381912861;
        Sat, 06 May 2023 07:05:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m22-20020aa78a16000000b0063d3d776910sm3244758pfa.138.2023.05.06.07.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 07:05:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 6 May 2023 07:05:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Richard gong <richard.gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] amd_nb: Add PCI ID for family 19h model 78h
Message-ID: <7b74c389-97b7-4f56-851b-6ce17950a4d1@roeck-us.net>
References: <20230427053338.16653-1-mario.limonciello@amd.com>
 <20230427053338.16653-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427053338.16653-2-mario.limonciello@amd.com>
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

On Thu, Apr 27, 2023 at 12:33:36AM -0500, Mario Limonciello wrote:
> s2idle previously worked on this system, but it regressed in kernel
> 6.4 due to commit 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN
> index 0 for driver probe").
> 
> The reason for the regression is that before this commit the SMN
> communication was hardcoded, but after amd_smn_read() is used which
> relies upon the misc PCI ID used by DF function 3 being included in
> a table.  The ID was missing for model 78h, so this meant that the
> amd_smn_read() wouldn't work.
> 
> Add the missing ID into amd_nb, restoring s2idle on this system.
> 
> Fixes: 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN index 0 for driver probe")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

FWIW:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Note that this patch is not upstream, meaning the second patch
in the series can not be applied either. I am not sure if that is
because of "regressed in kernel 6.4" - after all, that kernel does not
exist yet. The offending patch _is_ in the upstream kernel, though.
It might make sense to inform the regression bot if the problem is
not fixed when v6.4-rc1 is made available.

Guenter

> ---
>  arch/x86/kernel/amd_nb.c | 2 ++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 4266b64631a4..7e331e8f3692 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -36,6 +36,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>  #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
>  #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
> +#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
>  
>  /* Protect the PCI config register pairs used for SMN. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -79,6 +80,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
>  	{}
>  };
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 45c3d62e616d..95f33dadb2be 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -567,6 +567,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
>  #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
> +#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>  #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>  #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> -- 
> 2.34.1
> 
