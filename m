Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065EA30478A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 20:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhAZRAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 12:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbhAZHf4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 02:35:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 121D9230FE;
        Tue, 26 Jan 2021 07:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611646515;
        bh=+VAs2ymsR3wvwxQFkon4/lt3ON1FUNprV+UepWushio=;
        h=From:To:Cc:Subject:Date:From;
        b=DH2Lp/8Ef0k9WGN0ll9FmubItN0Z4unrWnNQS2pyl2CUBL7o4QsLZbVTFfKsobAFJ
         rqis4X+XbAgqsLOIi2xs0N9LOezi8R1B3MJRlaAf+t5K7louVm5tILOwBOPekx54Dp
         gxGYVH9sPqyKT9rTqpWuBYCY/4Ml/MC0cOYw5dSCTJwQMG0iNcMSQJWPiMJQGz01Ki
         A22EreErsNsWRT1n182mAs2KUT0HFIOn49DPq47GwhpEw133zKoi2C3eSrEIDvRSro
         yals0i+X72Z5A+lrvA7iUlU3O1m7Ebf/8Fx9SxxtUcGSuay+HFsCn+KXGiyEhuM4Q0
         ot6GUJlxXOVnw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l4Isa-00BqrJ-FX; Tue, 26 Jan 2021 08:35:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
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
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH RFC 0/2] Convert designware-pcie and kirin-pcie to yaml
Date:   Tue, 26 Jan 2021 08:35:05 +0100
Message-Id: <cover.1611645945.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rob,

As I'm preparing some upstream patches for kirin-pcie driver to support
Hikey 970, I opted to try first to convert the existing schema to yaml.

It should be noticed that those two patches currently won't pass
cleanly with dtbs_check/dt_binding_check.

I'm out of ideas about how to fix. It sounds to me that the checking
tools are trying to enforce different types of reference types than
the ones used by designware drivers.:

$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/designware,pcie.yaml dt_binding_check
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pci/designware,pcie.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
  DTC     Documentation/devicetree/bindings/pci/designware,pcie.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/pci/designware,pcie.example.dt.yaml


		[[2164260864, 0, 0, 3724541952, 0, 65536, 2181038080, 0, 3493855232, 3493855232, 0, 218103808]] is not of type 'boolean'
		True was expected
		[[2164260864, 0, 0, 3724541952, 0, 65536, 2181038080, 0, 3493855232, 3493855232, 0, 218103808]] is not of type 'null'
	[2164260864, 0, 0, 3724541952, 0, 65536, 2181038080, 0, 3493855232, 3493855232, 0, 218103808] is too long
	From schema: /home/mchehab/.local/lib/python3.9/site-packages/dtschema/schemas/pci/pci-bus.yaml

$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml dt_binding_check
  DTEX    Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dts
  DTC     Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml
/devel/v4l/hikey970/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f4000000: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /devel/v4l/hikey970/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
/devel/v4l/hikey970/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f4000000: '#interrupt-cells', 'bus-range', 'clock-names', 'clocks', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'num-lanes', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /devel/v4l/hikey970/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml

I ran out of ideas about how to solve that. So, I'm posting it as a RFC.

Mauro Carvalho Chehab (2):
  dt: pci: designware-pcie.txt: convert it to yaml
  dt: pci: kirin-pcie.txt: convert it to yaml

 .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
 .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
 .../bindings/pci/designware,pcie.yaml         | 194 ++++++++++++++++++
 .../bindings/pci/designware-pcie.txt          |  77 -------
 .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    |  98 +++++++++
 .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
 .../bindings/pci/hisilicon-pcie.txt           |   2 +-
 .../devicetree/bindings/pci/kirin-pcie.txt    |  50 -----
 .../bindings/pci/layerscape-pci.txt           |   2 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
 .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
 .../devicetree/bindings/pci/pci-keystone.txt  |  10 +-
 .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
 .../bindings/pci/samsung,exynos5440-pcie.txt  |   4 +-
 .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
 .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
 .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
 MAINTAINERS                                   |   4 +-
 20 files changed, 323 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/designware,pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt

-- 
2.29.2


