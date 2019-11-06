Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C40F22D8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 00:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbfKFXrs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 18:47:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44086 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfKFXrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2019 18:47:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id c19so352646otr.11;
        Wed, 06 Nov 2019 15:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YghF0O9CdijziXRtYqs4rBgfocxRjD2jrxaldxrfZPA=;
        b=NIubXICO4wlGVnIg5qoO8hQMroL030JH9nSoCwhvljSnEhpxfdLyzJrzx3hVxfdP0c
         r0tGFox0C9Hf7Q94N+liKh8UxwowiRZracamg7q1JQiQ8vyebGwnGVnkQ58ZiDbaXh2A
         hueaOzIdK717Ua8pNc1j71PBsdkKK8Wo0NSrlQqy02HkAKtimfnoY7KHLXnacmDHFTlc
         njks2uwLhoCX/daqpk1tfj5BTeeqm38a90vpGcZFYh32ao8NkfWK0F6B++PqaBl3W/cs
         zYIgfWHdQsehdktbT5Crcwdj+NRAwGKNUh3rb+pd9KZu6HGZJh0r2lw1pp9h8q0eiY3b
         pA6g==
X-Gm-Message-State: APjAAAW/slmdA4QjjHqAzq0oBq+RGaD73dpyKvLvEtwl3XoXR6/wX9rn
        Zb5zl4G0PNLGUL3kHCvqPg==
X-Google-Smtp-Source: APXvYqwgUlLWV9jHJ0xyKT6tWKqUtqWriZJeI42q4NAZ1iSZ8g0t2OjEoqRReV7onJSmLDH/dWe6Lw==
X-Received: by 2002:a05:6830:232c:: with SMTP id q12mr319872otg.168.1573084066922;
        Wed, 06 Nov 2019 15:47:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t12sm150529otl.71.2019.11.06.15.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:47:46 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:47:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rfi@lists.rocketboards.org,
        linux-arm-kernel@axis.com, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v1 7/7] dt-bindings: PCI: Use IRQ flags for legacy PCI
 IRQ interrupts
Message-ID: <20191106234745.GA29524@bogus>
References: <20191104163834.8932-1-andrew.murray@arm.com>
 <20191104163834.8932-8-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104163834.8932-8-andrew.murray@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  4 Nov 2019 16:38:21 +0000, Andrew Murray wrote:
> Replace magic numbers used to describe legacy PCI IRQ interrupts
> with #define.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  .../devicetree/bindings/pci/83xx-512x-pci.txt | 18 ++---
>  .../devicetree/bindings/pci/aardvark-pci.txt  | 10 +--
>  .../devicetree/bindings/pci/altera-pcie.txt   | 10 +--
>  .../bindings/pci/axis,artpec6-pcie.txt        | 10 +--
>  .../bindings/pci/cdns,cdns-pcie-host.txt      | 10 +--
>  .../bindings/pci/faraday,ftpci100.txt         | 68 +++++++++----------
>  .../bindings/pci/fsl,imx6q-pcie.txt           | 10 +--
>  .../bindings/pci/hisilicon-pcie.txt           | 20 +++---
>  .../bindings/pci/host-generic-pci.txt         | 10 +--
>  .../devicetree/bindings/pci/kirin-pcie.txt    | 10 +--
>  .../bindings/pci/layerscape-pci.txt           | 10 +--
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 40 +++++------
>  .../devicetree/bindings/pci/mobiveil-pcie.txt |  8 +--
>  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  8 +--
>  .../bindings/pci/pci-thunder-pem.txt          | 10 +--
>  .../devicetree/bindings/pci/pcie-al.txt       |  4 +-
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 20 +++---
>  .../bindings/pci/ralink,rt3883-pci.txt        | 18 ++---
>  .../bindings/pci/rockchip-pcie-host.txt       | 10 +--
>  .../devicetree/bindings/pci/ti-pci.txt        | 10 +--
>  .../devicetree/bindings/pci/uniphier-pcie.txt | 10 +--
>  .../bindings/pci/v3-v360epc-pci.txt           | 34 +++++-----
>  .../devicetree/bindings/pci/versatile.txt     | 40 +++++------
>  .../devicetree/bindings/pci/xgene-pci-msi.txt | 10 +--
>  .../devicetree/bindings/pci/xgene-pci.txt     | 10 +--
>  .../bindings/pci/xilinx-nwl-pcie.txt          | 10 +--
>  .../devicetree/bindings/pci/xilinx-pcie.txt   | 20 +++---
>  27 files changed, 224 insertions(+), 224 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
