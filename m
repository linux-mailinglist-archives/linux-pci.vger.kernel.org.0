Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5947495457
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 19:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbiATSns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 13:43:48 -0500
Received: from guitar.tcltek.co.il ([84.110.109.230]:56269 "EHLO mx.tkos.co.il"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234648AbiATSns (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jan 2022 13:43:48 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 185D4440EF6;
        Thu, 20 Jan 2022 20:43:36 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1642704216;
        bh=PGhMLORSfy3wSs+LCZjEijqyIDVkSA0QE53BUyLL1HE=;
        h=From:To:Cc:Subject:Date:From;
        b=E2RMGQZKsQaJd8DvwYm0b31ZhHHG/DE1ETo5ELn0eA3LH6QUdUWmbnQYm/TrpJ5kd
         Xp0RmF2Gou3qCPDQQyXJ9bjawAn2wxjyvBSghLHelyVTDudovNJqMdUEtN+9GCbwkU
         O4fIWQPbP3rRBxydL3JvjuCoflsZCPw9vnGP/EDgrfmefrWsOIh0cLtD6MdmgkMk55
         MW/c4DwEV4VunAL6OYlK3GH1pr4V5pKrIA/bR7y8rBqAjqp/tRzA2CA/p1HAwIoZYc
         +yDI42147q5jlatiHY34J8ItDX3Osmlfc1eUJqtiRmHrMYPL+6kgQ6PaXQkRfsks6H
         NTlM2Deq61Obw==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Kathiravan T <kathirav@codeaurora.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: qcom: ipq6018: fix usb reference period
Date:   Thu, 20 Jan 2022 20:43:41 +0200
Message-Id: <4f4df55cf44cd0fd7d773aca171d4f48662fb1a5.1642704221.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reference clock period for rate of 24MHz is 41ns (0x29).

Link: https://lore.kernel.org/r/1965fc315525b8ab26cf9f71f939c24d@codeaurora.org
Link: https://lore.kernel.org/r/a1932eba-564c-fe32-f220-53aa75250105@seco.com
Fixes: 20bb9e3dd2e4 ("arm64: dts: qcom: ipq6018: add usb3 DT description")
Reported-by: Kathiravan T <kathirav@codeaurora.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 665ee301b85d..5eb7dc9cc231 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -762,7 +762,7 @@ dwc_0: usb@8A00000 {
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_u3_susphy_quirk;
-				snps,ref-clock-period-ns = <0x32>;
+				snps,ref-clock-period-ns = <0x29>;
 				dr_mode = "host";
 			};
 		};
-- 
2.34.1

