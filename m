Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3680241A1F9
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 00:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhI0WDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 18:03:20 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:37836 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbhI0WC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 18:02:59 -0400
Received: by mail-pg1-f177.google.com with SMTP id 17so19082646pgp.4;
        Mon, 27 Sep 2021 15:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=g1utYXq+wY57RZcAhHq5AQl/UkdCz6MKvlIxZEz54ak=;
        b=vL7YwdfyPtWYT8Su5mHNpBkcRCQK80kGzIn2OqTWowxMb0FWsig9bSFnLmfXtDMJsK
         zj4TScJrvo06WrKiSQCVeEXc7lFpLhaPTqMiPCunHCljHGqQ1UxG8QclhJ1876NzQsId
         SZw/Hgv1aeB/6lbR4XwX11F4GUkQfBa9qdb7mHJ5NhVE/WMl4DTfvWnU1Fab7/zpkiI+
         X1ZciS2lJE66J+tXKerBWVLL1gkSwd16QoKi5hunUC7RklfkutfTKGV8Qt9aDo+7t1O5
         ZTyF8LZCccLvlbgmg9/eFKmjO/3cSe9jO62TUB0d2kcNLVIBhTWbPObBJpyfmylODUT5
         /Adg==
X-Gm-Message-State: AOAM532G87R5FVMcagzNs710dnY6xT2puNyuv1foQtb3XK1Oj7QAlnVy
        GvR6GDZZ50S/7Bo6bw0MrC8=
X-Google-Smtp-Source: ABdhPJz1xurkGC+wCDH4v9Y7JT2IpZnvZhGN8PoGQxC4xdO7GrNl6OJ8UKZUL0iotz+UiqG6zJ6RkQ==
X-Received: by 2002:a62:641:0:b0:44b:74bb:294c with SMTP id 62-20020a620641000000b0044b74bb294cmr1956387pfg.12.1632780081012;
        Mon, 27 Sep 2021 15:01:21 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c9sm19427778pgq.58.2021.09.27.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:01:20 -0700 (PDT)
Date:   Tue, 28 Sep 2021 00:01:09 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene: Use PCI_VENDOR_ID_AMCC macro
Message-ID: <YVI/JUBsn5wDFaPo@rocinante>
References: <20210927134356.11799-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927134356.11799-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

> Header file linux/pci_ids.h defines AMCC vendor id (0x10e8) macro named
> PCI_VENDOR_ID_AMCC. So use this macro instead of driver custom macro.

[...]
> -#define XGENE_PCIE_VENDORID		0x10E8

Another possible way of doing this might have been to alias the macro:

	#define XGENE_PCIE_VENDORID		PCI_VENDOR_ID_AMCC

Not sure if this would be more or less confusing - I certainly had to go
and look up what "AMCC" was.  Only to found out they got sold few years
ago, and such...

Nothing to change here, though.

>  #define XGENE_PCIE_DEVICEID		0xE004
>  #define SZ_1T				(SZ_1G*1024ULL)
>  #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
> @@ -560,7 +559,7 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port)
>  	xgene_pcie_clear_config(port);
>  
>  	/* setup the vendor and device IDs correctly */
> -	val = (XGENE_PCIE_DEVICEID << 16) | XGENE_PCIE_VENDORID;
> +	val = (XGENE_PCIE_DEVICEID << 16) | PCI_VENDOR_ID_AMCC;
>  	xgene_pcie_writel(port, BRIDGE_CFG_0, val);

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
