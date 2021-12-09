Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21846F66A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhLIWHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 17:07:16 -0500
Received: from st43p00im-zteg10063401.me.com ([17.58.63.175]:33600 "EHLO
        st43p00im-zteg10063401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhLIWHQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 17:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639086859; bh=lSevOr7BAHftq5gxm26fGEC7mH3hZcAia+JHROve4Ww=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=q5t/DKdBvP9q+nzCkGJpn7xSxHHNxxgvmXvcW+Wi0lQwPb7+XZEm13Zr0qY3IEtRs
         7rCEDwnzoADw9cStuRLkadK9jwEwx0XKeyhm2npxT5W6spmbdxH3QGIvfCTLZcUh7r
         nO3lh25RzloZhhY57OnZ4pZ8t+cRBFyRKfnAE2snTnvUjNLcWAeGOvL5Oscw+MkQhC
         u4qXOLQmx+XqXrHxxNUhIzXMDBNM0MNUQWGFJTTscfaQTA3dKr+GQbmSUYdr8tYNyK
         5QECHCBol1M1C/oqMc3bEVVrhzgeWsZEl5sX899tr+CvN8R6/RmAk/ZNQigVH3ZXco
         dNZV4sM19q+tA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10063401.me.com (Postfix) with ESMTPSA id 445B04A05FD;
        Thu,  9 Dec 2021 21:54:18 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH 5/5] ARM: dts: sti: enable PCIe on the stih418-b2264 board
Date:   Thu,  9 Dec 2021 22:53:50 +0100
Message-Id: <20211209215350.4207-6-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209215350.4207-1-avolmat@me.com>
References: <20211209215350.4207-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-08_08:2021-12-08,2021-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=708 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112090112
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

