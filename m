Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B174984CB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 17:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbiAXQ3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 11:29:10 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:34339 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241118AbiAXQ3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jan 2022 11:29:07 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id A8C90440537;
        Mon, 24 Jan 2022 18:28:47 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1643041728;
        bh=5QfVU3Vc9kJkteXou5FKpbIKc/tTimDxXUcTduzXFC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5TPIKBdQFS/Tup/NtncXiCmPANMKDUmzh0Qqt/F4GS7c7HDrh2aQVwliKUAm+iT3
         T0CIsjEpC9qftv41GCjggnIMCXq/lXRHLpxzCpkJG9r1ffdTnsWyuscK4UYu72TeHH
         UzVVwm7NEiR3zOxFEHGdHMdi0mnj/hk+YF0yo1NURvgD0vRv2a4c1/wZbJR9zdXlWI
         dx+XobylLa1aMIkqk8McyzNMhq4ddwBtz9gQE+81qa6MQCA5sOUnQhliVoffQvirwx
         bsHYcwcfhUVTL0t8uHowcGbS8Huf+kEOaBsD7CCoXQUcunXaFHP5g36zCA4pMzhR57
         wEkGOyj8bxJyg==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Baruch Siach <baruch.siach@siklu.com>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 1/3] arm64: dts: qcom: ipq6018: add pcie max-link-speed
Date:   Mon, 24 Jan 2022 18:27:29 +0200
Message-Id: <a3c2914eb55d0e364611c56e1ef3ccbe2342ba3f.1643041464.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643041464.git.baruch@tkos.co.il>
References: <cover.1643041464.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Baruch Siach <baruch.siach@siklu.com>

Add the generic 'max-link-speed' that correctly describes the IPQ6018
PCIe link generation limit. This allows the generic dwc code to
configure the link speed correctly.

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

