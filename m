Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E27C46F664
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 23:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhLIWFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 17:05:55 -0500
Received: from st43p00im-zteg10071901.me.com ([17.58.63.169]:52047 "EHLO
        st43p00im-zteg10071901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231286AbhLIWFz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 17:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639086851; bh=+49ITMZhhvsylnROVwCGbQZMaN2WBTCcdJwitqIziGo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=V2UXJo7HCJbPQCBlGKRlKoJn4jiLAMyQDg+m7i+h4+ASmYzkZyPyCDU6/YB3lRj56
         X/96UhgOHNkkUaTqjQr2Ii+hoQyzQ9ZwTX9FEjFqLPd5Czs7uXsq6mrb3R26vd643Y
         jgFTYkToI7DEfG4Otv+GQQ61bxKl2SXsS0CuKuDBHIzN2cvPz9BnqQpNgswy28ayGj
         r8fELmUG+R0cbIG04HhYR96okpkEwUpMWvIHA2Z0uSHyPKtxqEo3t5GpY7flWgG4TM
         efSwnqz0KY7sEpNqvrU32sAob+NTIOJ/SjqE0WRnj9tDMB8lrkJSPi9lK3J7KYcaJD
         bdpqEsXfH9gJA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id AD67ED80F3B;
        Thu,  9 Dec 2021 21:54:10 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH 3/5] MAINTAINERS: add entry for ST STI PCIE driver
Date:   Thu,  9 Dec 2021 22:53:48 +0100
Message-Id: <20211209215350.4207-4-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209215350.4207-1-avolmat@me.com>
References: <20211209215350.4207-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-08_08:2021-12-08,2021-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112090112
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

