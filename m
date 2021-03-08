Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2E1331AD9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 00:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhCHXLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 18:11:44 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38050 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCHXLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 18:11:17 -0500
Received: by mail-lj1-f181.google.com with SMTP id 2so18273835ljr.5;
        Mon, 08 Mar 2021 15:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3sLOpMcNZFmK9gLPudJacF0X8QIMSGunlUsiZURia08=;
        b=U/M2o01m5ZkGabL/lrEBEoghe7baCK9o6LMw5rLZCXxvjaU+pF6bMZlvQ+MFbRbmUB
         S4IMyELVvobfvq+X3eIYo1PI+mOALvBtFFuqzGkTWSoSFxKM4XV1xaqbbTUer8PnrRc+
         GWL5Pctataz4Lil6IIcJkp8R45G0NwtUHKUr56C5tzJBlgNFNV3QFFDTdR8aM/oppvIl
         vPj1K9X2NnBR9P16RrliXttN9FQaugncTjIN9uSzUVvM959OMTOdfpohpeJKbAHi8uHQ
         rgfu7WD5Q6OTcTiKH73jD5WW1E4jH4W52NhpSgVTmbAYBpk1/SYYyqg7F3e5AI/hNwXA
         9r3g==
X-Gm-Message-State: AOAM530ECDFXrjOBoOBDWZzmL2S8MxeiWXUNajogom1RQ8Tbpb6xJiZS
        G4xALIo+oKtyy+pcSzTO8wo=
X-Google-Smtp-Source: ABdhPJw7fGZia5J/uUKz7N0Odf2XZ4DoBLJuDwokYYCGkjv0fk8MvIsNwnpeI2Ap5Ssb87Jhb7gG1A==
X-Received: by 2002:a2e:505d:: with SMTP id v29mr15153535ljd.131.1615245075594;
        Mon, 08 Mar 2021 15:11:15 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v80sm1509340lfa.229.2021.03.08.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:11:15 -0800 (PST)
Date:   Tue, 9 Mar 2021 00:11:14 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: controller: al: select CONFIG_PCI_ECAM
Message-ID: <YEavErsucOAkO6Hf@rocinante>
References: <20210308152501.2135937-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308152501.2135937-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> Compile-testing this driver without ECAM support results in a link
> failure:
> 
> ld.lld: error: undefined symbol: pci_ecam_map_bus
> >>> referenced by pcie-al.c
> >>>               pci/controller/dwc/pcie-al.o:(al_pcie_map_bus) in archive drivers/built-in.a
> 
> Select CONFIG_ECAM like the other drivers do.
[...]

Ouch.  Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
