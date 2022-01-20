Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9997B49526B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 17:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbiATQb4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 11:31:56 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:35625 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346858AbiATQby (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 11:31:54 -0500
Received: by mail-oi1-f171.google.com with SMTP id s127so9665475oig.2;
        Thu, 20 Jan 2022 08:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oIS21M3kDACk8JCT5uuyNKZCe6YGCb1Ik2cXn3T5AB0=;
        b=TH5G2TplCGappsYRRkehXFphvULbK2Jkksqbl0djI8I7s/f7tWiVOPDxR1R6TVIgIh
         9Wx4pzzMsw3slayECc1l/ab45OYw8WIX4qOaE1nM3qHLGSMR7X3WkzB4w2X1aaXgSk/0
         7b4ySIKa9mPUk/8X5yvXfTfchHIIlWf0kVo53+oQ4txrl33jFHjbLBIBX2y/IhxJYaq2
         YTsVDGGb9/WzjpTI7Imr93my6a0EQStuu02bppYr6QW0EpA2vWFhUi4noAUTLsAIII0M
         y/rGascBhz+/RMg0moCLontIwaApyIY4ThkhY2plr29BlUQPRZemlvlmSsFwhjZPIiAN
         sUGw==
X-Gm-Message-State: AOAM5331WgnymGmaG+0ZdXk6fl11jlR7YG6vW0XeRj/Tbl8PWs84U8ko
        6LkkBhWpPdzY1CPgaRGeJQ==
X-Google-Smtp-Source: ABdhPJyAmQH8lK/5INP9kdsaboVqe2rh5v2NQ1dA3JLRep7fGroWXk18fJqb9O1GEwXs999OdcKCYQ==
X-Received: by 2002:aca:2409:: with SMTP id n9mr8475446oic.120.1642696313584;
        Thu, 20 Jan 2022 08:31:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f8sm1343757oop.46.2022.01.20.08.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 08:31:53 -0800 (PST)
Received: (nullmailer pid 1556364 invoked by uid 1000);
        Thu, 20 Jan 2022 16:31:52 -0000
Date:   Thu, 20 Jan 2022 10:31:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] PCI: Small improvements for pci-bridge-emul and
 mvebu
Message-ID: <YemOeJ2qIJV9dzO6@robh.at.kernel.org>
References: <20211221141455.30011-1-pali@kernel.org>
 <20220104153529.31647-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104153529.31647-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 04, 2022 at 04:35:18PM +0100, Pali Rohár wrote:
> This patch series contains small improvements for pci-bridge-emul and
> mvebu drivers. This patch series is based on top of the patches:
> https://lore.kernel.org/linux-pci/20211125124605.25915-1-pali@kernel.org/
> (which are now in pci/mvebu branch)
> 
> In V2 was added comment into code explaining PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
> and PCI_BRIDGE_EMUL_NO_IO_FORWARD flags.
> 
> Pali Rohár (11):
>   MAINTAINERS: Add Pali Rohár as pci-mvebu.c maintainer
>   PCI: pci-bridge-emul: Make struct pci_bridge_emul_ops as const
>   PCI: pci-bridge-emul: Rename PCI_BRIDGE_EMUL_NO_PREFETCHABLE_BAR to
>     PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
>   PCI: pci-bridge-emul: Add support for new flag
>     PCI_BRIDGE_EMUL_NO_IO_FORWARD
>   PCI: mvebu: Add help string for CONFIG_PCI_MVEBU option
>   PCI: mvebu: Remove duplicate nports assignment
>   PCI: mvebu: Set PCI_BRIDGE_EMUL_NO_IO_FORWARD when IO is unsupported
>   PCI: mvebu: Properly initialize vendor, device and revision of
>     emulated bridge
>   PCI: mvebu: Update comment for PCI_EXP_LNKCAP register on emulated
>     bridge
>   PCI: mvebu: Update comment for PCI_EXP_LNKCTL register on emulated
>     bridge
>   PCI: mvebu: Fix reporting Data Link Layer Link Active on emulated
>     bridge

For the series,

Reviewed-by: Rob Herring <robh@kernel.org>

In the future, please do not thread new versions with the old version 
of the series.

Rob
