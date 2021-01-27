Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB92305509
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhA0HwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 02:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234070AbhA0Hte (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 02:49:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF76B2074A;
        Wed, 27 Jan 2021 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611733728;
        bh=Nro3vfQTCFtmv98iajZ/Tld6vSBtHkyWqkV/zj14XFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SHMBfSfTtkKbBZei+R26dC4Lsa2N+suQiJ9H3LZMp1MaKa5JjGt+4QjAdFsyIyLUT
         tQmzXXgXxEdLQ2XzmFzAyIzEDH80xOrFrwsQDYWFBcKKnne9TgiIilSEhMFajPzLcb
         WKlppAIzlGh3Fdk7NfvaI8omlrDmEFva/CSsY1cFN2joSSKZRYRcFT7U90A+CfEknv
         NgBhXEjQyytURjwbuv1CbEWSI5z02gPfxp9eYDmJnFUBTAyEZEGvdNF+R6c9qOt6Gv
         k1vZRXX2j4SYiZQErTdX1uQdkl0rrqMB5kZzlCHOYRGKTz5ie1ZeE0UWWrrB+E8xPk
         07s+G/JFyQ1kw==
Date:   Wed, 27 Jan 2021 08:48:37 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt: pci: designware-pcie.txt: convert it to
 yaml
Message-ID: <20210127084837.39d68850@coco.lan>
In-Reply-To: <b6ab7110-fc87-85d7-d591-dffad32985ec@samsung.com>
References: <cover.1611645945.git.mchehab+huawei@kernel.org>
        <CGME20210126074127eucas1p1dd8f2d1704d708d64458922566b934f1@eucas1p1.samsung.com>
        <55f479324098b66d7dba89c8f9c3e455731df4f7.1611645945.git.mchehab+huawei@kernel.org>
        <b6ab7110-fc87-85d7-d591-dffad32985ec@samsung.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

Em Tue, 26 Jan 2021 11:13:20 +0100
Marek Szyprowski <m.szyprowski@samsung.com> escreveu:

> Hi Mauro,
> 
> On 26.01.2021 08:35, Mauro Carvalho Chehab wrote:
> > Convert the file into a JSON description at the yaml format.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >   .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
> >   .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
> >   .../bindings/pci/designware,pcie.yaml         | 194 ++++++++++++++++++
> >   .../bindings/pci/designware-pcie.txt          |  77 -------
> >   .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
> >   .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
> >   .../bindings/pci/hisilicon-pcie.txt           |   2 +-
> >   .../devicetree/bindings/pci/kirin-pcie.txt    |   2 +-
> >   .../bindings/pci/layerscape-pci.txt           |   2 +-
> >   .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
> >   .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
> >   .../devicetree/bindings/pci/pci-keystone.txt  |  10 +-
> >   .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
> >   .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
> >   .../bindings/pci/samsung,exynos5440-pcie.txt  |   4 +-  

> You must have used an old tree for preparing this patchset. The above 
> file is gone in v5.11-rc1 and there is 
> Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml instead.

Yeah, this series was generated against v5.10, as part of my efforts
to have Hikey 970 properly supported upstream:

	https://github.com/mchehab/linux/commits/devel/hikey970

For the next version, I'll rebase on the top of linux-next. 

Thanks,
Mauro
