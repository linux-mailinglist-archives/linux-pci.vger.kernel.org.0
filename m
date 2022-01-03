Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F7482EDC
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 08:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiACHsY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 02:48:24 -0500
Received: from st43p00im-zteg10072001.me.com ([17.58.63.167]:49126 "EHLO
        st43p00im-zteg10072001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232087AbiACHsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jan 2022 02:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641196098; bh=lSevOr7BAHftq5gxm26fGEC7mH3hZcAia+JHROve4Ww=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=iW/dvf83BPVpMA1Omhu3AylQPoL9dyQZp853xrBYySrkj8u/S4WinpaTsWkWEYzkK
         DaFrRRN0yjDfwVNkUZ8Lm2MSTwZhH8hCI6dmkiX/+e6WAQpL7Z9msS1fatsFNSU3SW
         BGO+j2O3uMiUUMDQi8+Mfo27mbqIC+PLBKMFUvaOBimLs98vb2Dyi9+QMGmdS/yHiS
         l5JiuuOy5Ic59657qwWdncji4p1SAR2QRy+uZYbn7NSW0TizdX5W5w2cP9IOqjo+ZF
         kI+mDJwdgnx1dFRGzgrU8fYK8bhoH8k52V9SzMe0yHpkqMUxyi2Dt+eUaJddUCScOQ
         5aeqLG11JVHnA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id 3A503B40605;
        Mon,  3 Jan 2022 07:48:17 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH RESEND v2 5/5] ARM: dts: sti: enable PCIe on the stih418-b2264 board
Date:   Mon,  3 Jan 2022 08:47:31 +0100
Message-Id: <20220103074731.3651-6-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103074731.3651-1-avolmat@me.com>
References: <20220103074731.3651-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2022-01-03_02:2022-01-01,2022-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=748 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2201030052
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable the PCIe controller with proper reset gpio pin for this board.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418-b2264.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stih418-b2264.dts b/arch/arm/boot/dts/stih418-b2264.dts
index a99604bebf8c..ed183292a669 100644
--- a/arch/arm/boot/dts/stih418-b2264.dts
+++ b/arch/arm/boot/dts/stih418-b2264.dts
@@ -130,6 +130,11 @@ &ohci1 {
 	status = "okay";
 };
 
+&pcie1 {
+	reset-gpios = <&pio34 5 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &pwm1 {
 	status = "okay";
 };
-- 
2.25.1

