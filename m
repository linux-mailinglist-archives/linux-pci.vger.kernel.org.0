Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D1482ED8
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 08:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiACHsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 02:48:10 -0500
Received: from st43p00im-ztdg10071801.me.com ([17.58.63.171]:44360 "EHLO
        st43p00im-ztdg10071801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232058AbiACHsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jan 2022 02:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1641196088; bh=+49ITMZhhvsylnROVwCGbQZMaN2WBTCcdJwitqIziGo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=iuEYyea0WuykOXRneeoWnaAg2GXJwqbrpsKpHseXugB63JtfzBjKQkHMAGJro2OL8
         kfuDkRu+zviE9pGSum5kb0p2tGvHHT9nxtY4PXyKEg4FEzL2PcFjRjG1I+/MrbwCef
         QwfTIqBcrLI8j7/9F63PCklVezvZvtBHyaG1tT7u/UDtQ7wVmwoTi3BJOzkR/slKhP
         UhcrMDYMNxKiolSISMvXv0Zi/u8Jy62N68gw9LxEOBrb45tlCDZgGmia+3dM68KQ40
         mJin584xEX8kpHTyQEJfhOtpAnzgNqomF2bNrvwbl8xTxMqY0rYR2raFOSF8hUXd+C
         4t/2Y4oN4loMA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10071801.me.com (Postfix) with ESMTPSA id 65C2F3C02BD;
        Mon,  3 Jan 2022 07:48:07 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH RESEND v2 3/5] MAINTAINERS: add entry for ST STI PCIE driver
Date:   Mon,  3 Jan 2022 08:47:29 +0100
Message-Id: <20220103074731.3651-4-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103074731.3651-1-avolmat@me.com>
References: <20220103074731.3651-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2022-01-03_02:2022-01-01,2022-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2201030052
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIE Driver entry for STI family from ST Microelectronics.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d..081ccdfbd89c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14666,6 +14666,12 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/pci-exynos.c
 
+PCI DRIVER FOR ST STI PLATFORM
+M:	Alain Volmat <avolmat@me.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	drivers/pci/controller/dwc/pcie-sti.c
+
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
-- 
2.25.1

