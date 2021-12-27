Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4247FA92
	for <lists+linux-pci@lfdr.de>; Mon, 27 Dec 2021 07:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhL0GqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Dec 2021 01:46:12 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:53426 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235318AbhL0GqM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Dec 2021 01:46:12 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 4EE16440534;
        Mon, 27 Dec 2021 08:45:58 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1640587558;
        bh=BP1dvxIAwyBUC3bfdY7iX3hCPTCn/UhmSEubBQYYE/c=;
        h=From:To:Cc:Subject:Date:From;
        b=uRcxdRpapqtmNQIGXXwwNonuMJUvmTkS0cneWjHMxr71gi4Gc4RSHFWXuEkJ/G8Ex
         3nQqunH7tAL9APIRuji6Z+olX9VB215+cghXsKWrSXG1oYpvZl1Y30nH9xYmbrwh2H
         qNSWD6GPHHo3lnjBhBcst8YJFOTTtgKSQorEiWEh84IZ4nw/nZYvHT6zTQgdDbWXoy
         NbWIjHtbV9BqibP5Sk9x+lhfklgGk9NIFuqiZ64mDjikUKPwta2gVrWDwsBahx/a1Q
         f1vafpFFgXVLTnGykxsitCyhCPlwGCsoep0ZDKo9h3CqlRQYINVYl60guqd8DnZ3kv
         sBxDsfUztBwAw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 0/3] PCI: IPQ6018 PCIe controller support
Date:   Mon, 27 Dec 2021 08:46:02 +0200
Message-Id: <cover.1640587131.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is 
ported from downstream Codeaurora v5.4 kernel. The main difference from 
downstream code is the split of PCIe registers configuration from .init to 
.post_init, since it requires phy_power_on().

Tested on IPQ6010 based hardware.

Changes in v4:

  * Drop applied DT bits

  * Add max-link-speed that was missing from the applied v2 patch

  * Rebase the driver on v5.16-rc3

Changes in v3:

  * Drop applied patches

  * Rely on generic code for speed setup

  * Drop unused macros

  * Formatting fixes

Changes in v2:

  * Add patch moving GEN3_RELATED macros to a common header

  * Drop ATU configuration from pcie-qcom

  * Remove local definition of common registers

  * Use bulk clk and reset APIs

  * Remove msi-parent from device-tree

Baruch Siach (2):
  arm64: dts: qcom: ipq6018: add pcie max-link-speed
  PCI: dwc: tegra: move GEN3_RELATED DBI register to common header

Selvam Sathappan Periakaruppan (1):
  PCI: qcom: add support for IPQ60xx PCIe controller

 arch/arm64/boot/dts/qcom/ipq6018.dtsi        |   1 +
 drivers/pci/controller/dwc/pcie-designware.h |   7 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 145 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c   |   6 -
 4 files changed, 153 insertions(+), 6 deletions(-)

-- 
2.34.1

