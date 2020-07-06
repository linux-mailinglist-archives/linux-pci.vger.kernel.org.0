Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F7216284
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 01:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGFXts (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 19:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbgGFXts (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 19:49:48 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E448206E9;
        Mon,  6 Jul 2020 23:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594079387;
        bh=rcSfzqKMqTAG4cZgVNbjNYrKd7WW6S5TsXMAfz2WtHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OAk1XCEw69JFMDD5mSVljMjA3rJmzjhckHDUt8Howp5kh3Q2cnjFGujMp0Mzf+1BC
         wGBhKk5ONavqe465bLIanMAJmPWgNLe8cfQR/cLQJXK0mZG7n/176obN0Rt+FBMoQq
         AsxoAbxA0sLkGyDy6r70vGsM2xTUBmBmaVo1aXh8=
Date:   Mon, 6 Jul 2020 18:49:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, svarbanov@mm-sol.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/9] Add PCIe support for IPQ8074
Message-ID: <20200706234945.GA171874@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 05, 2020 at 02:47:51PM +0530, Sivaprakash Murugesan wrote:
> IPQ8074 has two PCIe ports both are based on synopsis designware PCIe
> controller. while it was assumed that PCIe support for IPQ8074 was already
> available. PCIe was not functional until now.
> 
> This patch series adds support for PCIe ports on IPQ8074.
> 
> First PCIe port is of gen2 synposis version is 2_3_2 which has already been
> enabled. But it had some problems on phy init and needed dt updates.
> 
> Second PCIe port is gen3 synopsis version is 2_9_0. This series adds
> support for this PCIe port while fixing dt nodes.
> 
> Patch 1 on this series depends on qcom pcie bindings patch
> https://lkml.org/lkml/2020/6/24/162
> 
> Sivaprakash Murugesan (9):
>   dt-bindings: pci: Add ipq8074 gen3 pci compatible
>   dt-bindings: phy: qcom,qmp: Add dt-binding for ipq8074 gen3 pcie phy
>   clk: qcom: ipq8074: Add missing bindings for pcie
>   clk: qcom: ipq8074: Add missing clocks for pcie
>   phy: qcom-qmp: use correct values for ipq8074 gen2 pcie phy init
>   phy: qcom-qmp: Add compatible for ipq8074 pcie gen3 qmp phy
>   pci: dwc: qcom: do phy power on before pcie init
>   pci: qcom: Add support for ipq8074 pci controller
>   arm64: dts: ipq8074: Fixup pcie dts nodes

No comment on the patches themselves, but please update the subject
lines so they follow the conventions:

  dt-bindings: PCI: qcom: Add ipq8074 PCIe Gen3 support
  dt-bindings: phy: qcom,qmp: Add ipq8074 PCIe Gen3 phy
  clk: qcom: ipq8074: Add missing bindings for PCIe
  clk: qcom: ipq8074: Add missing clocks for PCIe
  phy: qcom-qmp: Use correct values for ipq8074 PCIe Gen2 PHY init
  PCI: qcom: Do PHY power on before PCIe init
  PCI: qcom: Add ipq8074 PCIe controller support
  arm64: dts: ipq8074: Fixup PCIe DTS nodes

Also fix the same things in the commit logs, e.g., consistently use
"PCIe" instead of "pcie", "Gen2" instead of "gen2", etc.  For example:

  ipq8074 has two PCIe ports while the support for gen2 pcie port ...

What's the point of using "PCIe" for the first and "pcie" for the
second?

You can learn all this by using "git log" and "git log --online".

>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  47 ++++++
>  .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   1 +
>  arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |   8 +-
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 109 ++++++++----
>  drivers/clk/qcom/gcc-ipq8074.c                     |  60 +++++++
>  drivers/pci/controller/dwc/pcie-qcom.c             | 187 +++++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h          | 132 +++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.c                | 188 ++++++++++++++++++++-
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
>  include/dt-bindings/clock/qcom,gcc-ipq8074.h       |   4 +
>  10 files changed, 683 insertions(+), 55 deletions(-)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h
> 
> -- 
> 2.7.4
> 
