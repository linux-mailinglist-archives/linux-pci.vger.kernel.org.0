Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF4278A02A
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 18:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjH0Q17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjH0Q10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 12:27:26 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D0C1;
        Sun, 27 Aug 2023 09:27:23 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c0c6d4d650so19760255ad.0;
        Sun, 27 Aug 2023 09:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693153643; x=1693758443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqf0ICl6pyvfSGedRrmWV0KgewJjUsjj+Fcfy2g8HFo=;
        b=fPYGWMVyNHz1bWlQBm+sdmzx1HlSGu9BPc8YZZwqQORxKiZZxaLgV59Lp4twfQl07H
         ftjMJ4Lat4jIGYWHnJ7n0L0JWAQpVuoXKkgfzguKsI7C20PAwB/JMUfaN+BjhOZca5px
         KmMVVrqDNpQmgD3RRU1916a4K7CIxqJdZOtjL9Qb/GNxwyCIWexYIqKnc2XKRAhDKaRP
         UzyEPydqmrKqCcMdgo9o7YpegPjRT3MHFvvHJO2oQxkpTo6ViWBEiH+4FKO7Cj2VttND
         RZ6tQok07VqVEz3faorV3GURHeO4eq/0+fE5L6FKzmseFibilPi0EdxYHmvVdG0q+FNe
         gp8Q==
X-Gm-Message-State: AOJu0Yyr129nplK5jNeYLouh0PqXfMNDp9UcSluBz4YpaaX+lSW89yDv
        QKhG7WnJwyh8wShzgz632rQ=
X-Google-Smtp-Source: AGHT+IGxjUi4tzjyOdm0G81ktTducGNMEGVWFe9lvPLMKSECgLhft8mo7kS+LhCku+FVsnyBtcAunQ==
X-Received: by 2002:a17:903:22c6:b0:1be:f45c:bc38 with SMTP id y6-20020a17090322c600b001bef45cbc38mr25969686plg.2.1693153643118;
        Sun, 27 Aug 2023 09:27:23 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b03b7f8adfsm5464272plt.246.2023.08.27.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 09:27:22 -0700 (PDT)
Date:   Mon, 28 Aug 2023 01:27:21 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        fancer.lancer@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v20 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Message-ID: <20230827162721.GA2932694@rocinante>
References: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825093219.2685912-1-yoshihiro.shimoda.uh@renesas.com>
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

> Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> To support them, modify PCIe DesignWare common codes.

Applied to controller/rcar, thank you!

[01/19] PCI: Add INTx Mechanism Messages macros
        https://git.kernel.org/pci/pci/c/b6dc5750a17a
[02/19] PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
        https://git.kernel.org/pci/pci/c/6cbd4d406cb0
[03/19] PCI: dwc: Add outbound MSG TLPs support
        https://git.kernel.org/pci/pci/c/6ab660b25520
[04/19] PCI: designware-ep: Add INTx IRQs support
        https://git.kernel.org/pci/pci/c/b788d6fd273e
[05/19] PCI: dwc: endpoint: Add multiple PFs support for dbi2
        https://git.kernel.org/pci/pci/c/6e4db9846cf4
[06/19] PCI: dwc: Add dw_pcie_link_set_max_link_width()
        https://git.kernel.org/pci/pci/c/d0f961f40da8
[07/19] PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
        https://git.kernel.org/pci/pci/c/a0473c77b4c1
[08/19] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
        https://git.kernel.org/pci/pci/c/e45ff874cede
[09/19] PCI: dwc: Add EDMA_UNROLL capability flag
        https://git.kernel.org/pci/pci/c/2424c3ddbd4c
[10/19] PCI: dwc: Expose dw_pcie_ep_exit() to module
        https://git.kernel.org/pci/pci/c/3f937c80eb8e
[11/19] PCI: dwc: Expose dw_pcie_write_dbi2() to module
        https://git.kernel.org/pci/pci/c/a986f6fd339e
[12/19] PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
        https://git.kernel.org/pci/pci/c/6504d294399e
[13/19] dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
        https://git.kernel.org/pci/pci/c/5ca157f7d36c
[14/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
        https://git.kernel.org/pci/pci/c/af285bc39885
[15/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
        https://git.kernel.org/pci/pci/c/738bded11aaa
[16/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
        https://git.kernel.org/pci/pci/c/943a310da907
[17/19] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
        https://git.kernel.org/pci/pci/c/db4499d11f46
[18/19] MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
        https://git.kernel.org/pci/pci/c/2e0ef5776946
[19/19] misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller
        https://git.kernel.org/pci/pci/c/33fa67818fe7

	Krzysztof
