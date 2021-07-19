Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4253CF267
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 05:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhGTC1F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 22:27:05 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:35609 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359656AbhGSVWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 17:22:00 -0400
Received: by mail-il1-f169.google.com with SMTP id a11so17437935ilf.2;
        Mon, 19 Jul 2021 15:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f1jPjrRlaCoGW6NcDg+XE1Qycqf9T6zQzCIsLWnTwZQ=;
        b=GE7hs4aKssR+tkCZ2JdLeIsRsAPN6hDYNRJ3NaB0O/YuXKBJMzW4flKrJJoNVbAu+c
         gKiH/95MU5l93sLt9JX2CiGKSTHfL0YjmoTAdUgofZY5rPcj4onCmufaErvN4hd8ghNh
         rWVfvTiPBW93WBwbgEK1fC+Q+opfj94Ms0Rorzq/g/f0chqSgbBcV5f/XknYfq9CsLex
         8xy4wh+J9JLR/unBHeH6l8Y7l24kA1z6v635284N0hVsx1fwF2IXrHnsdgs/Rmv010/p
         f+ENTIQY7CD5WD7wWnJ/R8MztAawlhYWHz6+1yvUxCalT6cFAultsPQ+SbvaV2UmAYGC
         Mq+Q==
X-Gm-Message-State: AOAM533Nod60KTqSkrIhjmv1RiNmeLfBxfjZ5pBZdATuBnyUt5ZBr63d
        UST1dpMhhuF7kEPOvKAEfw==
X-Google-Smtp-Source: ABdhPJw7EeICoNwI7faYsy/ynAxnzY/CYjaXAly9aLu6w9Sr0yXeF9bmNozCXqaxmtS1LZg+Uz4WKw==
X-Received: by 2002:a92:d706:: with SMTP id m6mr17728297iln.78.1626732154753;
        Mon, 19 Jul 2021 15:02:34 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o13sm10372829ilq.58.2021.07.19.15.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:02:34 -0700 (PDT)
Received: (nullmailer pid 2677074 invoked by uid 1000);
        Mon, 19 Jul 2021 22:02:27 -0000
Date:   Mon, 19 Jul 2021 16:02:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        mauro.chehab@huawei.com, Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-omap@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@axis.com, Rob Herring <robh+dt@kernel.org>,
        linux-tegra@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-riscv@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-arm-msm@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        linux-pci@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linuxarm@huawei.com, Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 3/5] dt-bindings: PCI: update references to Designware
 schema
Message-ID: <20210719220227.GA2676918@robh.at.kernel.org>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
 <dfff4d94631546c53450d1baeddc694dd26b5c36.1626608375.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfff4d94631546c53450d1baeddc694dd26b5c36.1626608375.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 18 Jul 2021 13:40:50 +0200, Mauro Carvalho Chehab wrote:
> Now that its contents were converted to a DT schema, replace
> the references for the old file on existing properties.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  4 ++--
>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |  2 +-
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |  2 +-
>  .../bindings/pci/hisilicon-histb-pcie.txt          |  2 +-
>  .../devicetree/bindings/pci/kirin-pcie.txt         |  2 +-
>  .../devicetree/bindings/pci/layerscape-pci.txt     |  2 +-
>  .../bindings/pci/nvidia,tegra194-pcie.txt          |  5 +++--
>  .../devicetree/bindings/pci/pci-armada8k.txt       |  2 +-
>  Documentation/devicetree/bindings/pci/pcie-al.txt  |  2 +-
>  .../devicetree/bindings/pci/qcom,pcie.txt          | 14 +++++++-------
>  .../bindings/pci/samsung,exynos-pcie.yaml          |  4 ++--
>  .../devicetree/bindings/pci/sifive,fu740-pcie.yaml |  4 ++--
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  4 ++--
>  Documentation/devicetree/bindings/pci/ti-pci.txt   |  4 ++--
>  .../devicetree/bindings/pci/uniphier-pcie.txt      |  2 +-
>  15 files changed, 28 insertions(+), 27 deletions(-)
> 

Applied, thanks!
