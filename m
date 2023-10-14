Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95AC7C9689
	for <lists+linux-pci@lfdr.de>; Sat, 14 Oct 2023 23:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjJNVor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Oct 2023 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjJNVor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2023 17:44:47 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3A5CE;
        Sat, 14 Oct 2023 14:44:44 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57e40f0189aso1760528eaf.1;
        Sat, 14 Oct 2023 14:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697319884; x=1697924684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CedS0UtUemXwbonN9/fFRXtk39jIVXXNQiChUqQ1fk=;
        b=nhInuReZCfXJeuBeUQEBesKcOjpD7b3etNmic4siZwXOvjJ53hE7l5ryGSRAwzXfKQ
         NjTvr+OP+3W8MBevbKhR76dXrcr7tzQa33oEsuHjABA3BR8NVVBrPUtp9e6nNYR8X1ZO
         jGxL9yA70GTErMKLW9bELZEs5y3Jt0i9fFN4ze83pIXJ8KYERUsp8XlzOxMPDX5Ck08j
         UCvncBNc54QU5SKGFvhXSxbmipamCplp0aPmV83a/4YE/KWBn5SNGrwW3x3seYAJ5xQM
         TUt0VcKuIpDnTzWkrsE/VBE0fPJ0OY+Zx6nctUdYO26V4jSeGOgy+MPvauiLcepMNlG4
         /s+g==
X-Gm-Message-State: AOJu0YzXmwqhfOtw8wAHKuRapyVR8bM982wrPg6ojtz71e6P4AyJzI09
        v5yrM7zOSkf7HJyP9rwotyY=
X-Google-Smtp-Source: AGHT+IFkHb4GyAH4twL5cQ/no5AbXoxMjN3bWktyTKRtOuu6b+LNQXUeyS53IKdpj8GMVFuDfmZ8sg==
X-Received: by 2002:a05:6358:6f97:b0:166:a6e3:dfc2 with SMTP id s23-20020a0563586f9700b00166a6e3dfc2mr4690514rwn.9.1697319883990;
        Sat, 14 Oct 2023 14:44:43 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id g27-20020aa79f1b000000b0068fb9f98467sm1974370pfr.107.2023.10.14.14.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 14:44:43 -0700 (PDT)
Date:   Sun, 15 Oct 2023 06:44:42 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mani@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v24 00/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 support
Message-ID: <20231014214442.GC1246721@rocinante>
References: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011071423.249458-1-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> Add R-Car S4-8 (R-Car Gen4) PCIe controller for both host and endpoint modes.
> To support them, modify PCIe DesignWare common codes.

Applied to controller/rcar, thank you!

[01/16] PCI: dwc: endpoint: Add multiple PFs support for dbi2
        https://git.kernel.org/pci/pci/c/cca7bd87028c
[02/16] PCI: dwc: Add dw_pcie_link_set_max_link_width()
        https://git.kernel.org/pci/pci/c/4f3d04e53b9d
[03/16] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
        https://git.kernel.org/pci/pci/c/0d8ef6f3065e
[04/16] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
        https://git.kernel.org/pci/pci/c/42a0aaac1df2
[05/16] PCI: dwc: Add EDMA_UNROLL capability flag
        https://git.kernel.org/pci/pci/c/9ece6ac45d1b
[06/16] PCI: dwc: Expose dw_pcie_ep_exit() to module
        https://git.kernel.org/pci/pci/c/3f643b8dd982
[07/16] PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
        https://git.kernel.org/pci/pci/c/b4e028978e1e
[08/16] PCI: dwc: Disable two BARs to avoid unnecessary memory assignment
        https://git.kernel.org/pci/pci/c/e308528cac3e
[09/16] dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
        https://git.kernel.org/pci/pci/c/e7bb27bdb333
[10/16] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
        https://git.kernel.org/pci/pci/c/888d9525eaee
[11/16] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
        https://git.kernel.org/pci/pci/c/323d6545bc64
[12/16] PCI: Add T_PVPERL macro
        https://git.kernel.org/pci/pci/c/bfd7a42cd940
[13/16] PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode
        https://git.kernel.org/pci/pci/c/8386896d2eb6
[14/16] PCI: rcar-gen4: Add endpoint mode support
        https://git.kernel.org/pci/pci/c/32b83c68d634
[15/16] MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
        https://git.kernel.org/pci/pci/c/714e7cd07645
[16/16] misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller
        https://git.kernel.org/pci/pci/c/de45624e69e1

	Krzysztof
