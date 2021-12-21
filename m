Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9347C47C6C9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 19:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbhLUSmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 13:42:03 -0500
Received: from st43p00im-zteg10072001.me.com ([17.58.63.167]:49056 "EHLO
        st43p00im-zteg10072001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241472AbhLUSmB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 13:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1640112120; bh=+49ITMZhhvsylnROVwCGbQZMaN2WBTCcdJwitqIziGo=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=IZJWsDGUjKX/UtKYg+KQ5HgjPscBofBpUBsXtJh/Inh+7s6u65h0o6Lf8mfQZn8mH
         +72fJD8ezk3SlHxrSTfLbZK8uizHPLI+gMwQ180LpuzfFe4yLoDu7cfbAO0z06MEY9
         44YYXLqFDByYn78d/sqIHEzv64thUVv2IjW8cgXrbDPytoWyIEKHdnTyCAMF/1Jurq
         HPpymsS0WjQG3tP8LOSorrwwxtBMc8QXsltyf5g8oYlDbwUcuJB9C6LIPAiXgJk/sU
         8TqwN7Jc9/ThWq1ZRQLuzXnWAdkVOr9TzKMMhzXRut3VlBnpDH+8SIBSCmmVMi8CNc
         lbh9Da/o8QFfA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id BF82EB40D59;
        Tue, 21 Dec 2021 18:41:59 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>, avolmat@me.com
Subject: [PATCH v2 3/5] MAINTAINERS: add entry for ST STI PCIE driver
Date:   Tue, 21 Dec 2021 19:41:01 +0100
Message-Id: <20211221184103.279437-4-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221184103.279437-1-avolmat@me.com>
References: <20211221184103.279437-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2021-12-21=5F04:2021-12-20=5F01,2021-12-21=5F04,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2112210092
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

