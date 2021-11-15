Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9659B4504AC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 13:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhKOMro (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 07:47:44 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:37841 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhKOMrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 07:47:43 -0500
Received: by mail-pj1-f43.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so3675193pjb.2;
        Mon, 15 Nov 2021 04:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9iZuL33ceXpCXCfFWKi42NsB/3gZo7JPTPdXREUwvAE=;
        b=jZXkWJbsFtL7fiGVs/LL02iNu8Lt+nBTDmlfbJjq6wC7H97AJ6aMzjPb2/EB310gof
         5lKdKFi+TUSbxk1lcOz5t6HYYF4m0eeDnb4o5mX8+llz3uhIFb9E3ccBOU25WWYlVdUx
         r5EDQCRNNRJ2dPEbQXcnKm+yzIeA+tpvcHxzP2lAo2My1sA7ynMB6bRISaUC9ZVcu4hG
         cVA3Jrez5ssmaVDLarZeDX+OFepVPym0+izBb3bIZnfVxpl/Z8C6bAwuAFOuSOEYEQx7
         vZGdxyB2iaot7mcj4VWrtxBaJXB3Aqm4j2XTB+qw6hoBMFVT82ApFuaEgMG8mA59sb+U
         peUw==
X-Gm-Message-State: AOAM533HF6pcpJKez+rrfrBhDNCcaAgtZ8Ke4mQF2OSEAuB3rcb2/Oim
        30Odl3ticQ3fRIu6OgZjMVFgRVHLnOnrug==
X-Google-Smtp-Source: ABdhPJzzNaZ29/peuDxBxii07epiJMKFleZTMMebqA97wN0IYLgpKA+OGvEuM2D4GfCchMrReRbZ6Q==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr65286839pjb.12.1636980287501;
        Mon, 15 Nov 2021 04:44:47 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j22sm9774869pfj.130.2021.11.15.04.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 04:44:46 -0800 (PST)
Date:   Mon, 15 Nov 2021 13:44:35 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 4/5] PCI: mt7621: Add missing 'MODULE_LICENSE()'
 definition
Message-ID: <YZJWM33dXqW1BsuV@rocinante>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
 <20211115070809.15529-5-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115070809.15529-5-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergio and Yanteng,

Thank you for taking care of this!

> MT7620 PCIe host controller driver can be built as a module but there is no
> 'MODULE_LICENSE()' specified in code, causing a build error due to missing
> license information.
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pci/controller/pcie-mt7621.o
> 
> Fix this by adding 'MODULE_LICENSE()' to the driver.
> 
> Fixes: 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host controller driver")
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 9cf541f5de9c..a120a61ede07 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -561,3 +561,5 @@ static struct platform_driver mt7621_pci_driver = {
>  	},
>  };
>  builtin_platform_driver(mt7621_pci_driver);
> +
> +MODULE_LICENSE("GPL v2");

A question here about the builtin_platform_driver() use in this driver,
especially since it's set as tristate in Kconfig, thus I am not sure if
using builtin_platform_driver() over module_platform_driver() is correct?

Unless this is more because you need to reply on device_initcall() for the
driver to properly initialise?

Otherwise,

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
