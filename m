Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1706147FA95
	for <lists+linux-pci@lfdr.de>; Mon, 27 Dec 2021 07:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhL0GqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Dec 2021 01:46:12 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:53437 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235366AbhL0GqM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Dec 2021 01:46:12 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id E36234405B0;
        Mon, 27 Dec 2021 08:45:58 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1640587559;
        bh=v4vtQdbtJGJ4z3e70Ewov7SB+hmi3tHkxZRYAVgoeM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAe9bh2vJHXby9P12x4UIwvnDilOG7Z26L0Xe6TQ/Hp4NrHXTBF7wKzB1ugDdCLqW
         lc117XRJRIZs88L/1/cVn8xDicMl7ny9V3EIu+6cNCPmMs5Iaoul9CsZsJBTEJMxHT
         jldrLdPm1XxgQOFaxShIsNa86fDj0fbB6RmGIyAoEFQK1zRCPnIQfXWvnz1mp8fbN1
         VLsizx6szLiAsW4crYsQxeqroTwI6ulxMLbx+Gbg6ZmWvIH63xsI7ZK1rTLkMy121T
         twqYhukrawAwnR0vDzo8WoVCE/emETTrIH7OXqXKZQHk5hnzTKT9KpSSSmWyknWjYI
         5OTRb+qPOLAGA==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch.siach@siklu.com>,
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
Subject: [PATCH v4 1/3] arm64: dts: qcom: ipq6018: add pcie max-link-speed
Date:   Mon, 27 Dec 2021 08:46:03 +0200
Message-Id: <fcf41277cf8529437374a5c10b2b1fcad30cd7c2.1640587131.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1640587131.git.baruch@tkos.co.il>
References: <cover.1640587131.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Baruch Siach <baruch.siach@siklu.com>

Add the generic 'max-link-speed' property to describe the IPQ6018 PCIe
link generation limit. This allows the generic dwc code to configure the
link speed correctly.

Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index a717fc17523d..665ee301b85d 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -438,6 +438,7 @@ pcie0: pci@20000000 {
 			linux,pci-domain = <0>;
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
+			max-link-speed = <3>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-- 
2.34.1

