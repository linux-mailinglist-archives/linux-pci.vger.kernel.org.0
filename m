Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0ED1897FE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 10:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgCRJgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 05:36:45 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:6073
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727443AbgCRJgo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 05:36:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na9EaAaaDf2hX9cWeAHQX306fmZoODgR6w7nov3e8Nw8RzuucgGX2STr9Cs1ue/lLhcjS0xQaDU3D3XYjf04QHATSayxsj8XblxTcTsVqOWuQFF/j7kt7B/U9QfASuo2QFE5Rw2Ys3AD60nWeeQdS/IPfpsB671FuFdVUilJFHv5SOC4BUf5wkfjmMDg6UR1D0sFi/E/kgnGOT83M1TIUgP9smVUzy7oMk5FeCV333TrK4400JdqR/bAiQFaRD9lHpO97xaSGvsQx62f6R/E+elXJLOsAPf2az6bSDDWPUIR9uo/g2dvIl4dVmlNDQKNHhcIGnQYdghB5F/JEgRPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVSrFp/weAo7fUhY1noyn5XO8HofXBtUfvcGKnQ/rm8=;
 b=U/8uV27zb6m8fNdmMPmFUGdSRX87MYwc+iiUXX3qinsuVBHsc+gyh7rx/C56D9Cd4LpWKVUVEb8/jbJwzLC+aqvmJc0D4J8+ZgTflcYs1n8dsRUmV5ntr/mNpTBIsBGBeYtpuuycGyemaaXiYxjUpqQIhDQzmkt0U3t5YFfMQUsnPAqD6S64/Yr5SHrlx3ydmfjnMaDoWI5odjpm9a97if+WVKfGoCDhiIC1n6+/myKl/fiYxvCIuutui6GNWvfvbnTIb7jBk2zlZ5zkG4r2J3zz5I3SVB/2ANI0PVmh1QReSkHJ+1s8QhFbCqSB21MEp4SjJ9PPz/eWBeHcKTkWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVSrFp/weAo7fUhY1noyn5XO8HofXBtUfvcGKnQ/rm8=;
 b=Z18v8Zv/Cf3J0AxAl2U2Bad3eX/H65pV+ShZcTo2On84XydXbFdos6x77LdK6XWOW8gOdKbmATXQFAYd4RSkS8NJEfxxjUcOeIWDYCb+cAWTAHznO1iPn+9S+bgDpR1Lf5cpFiLLNRk3FHcxAwIvfG5TmxCR0QGeQkS2jOeaL+0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6426.eurprd04.prod.outlook.com (20.179.249.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Wed, 18 Mar 2020 09:36:41 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e%5]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 09:36:41 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, rdunlap@infradead.org
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: mobiveil: Fix unmet dependency warning for PCIE_MOBIVEIL_PLAT
Date:   Wed, 18 Mar 2020 17:33:12 +0800
Message-Id: <20200318093312.49004-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR01CA0160.apcprd01.prod.exchangelabs.com (2603:1096:4:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Wed, 18 Mar 2020 09:36:38 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65002b98-364f-4de0-58b3-08d7cb1fdd1b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6426:|DB8PR04MB6426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6426A837C953BEB4806F5F0284F70@DB8PR04MB6426.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(66476007)(66946007)(66556008)(4744005)(4326008)(6666004)(186003)(6486002)(16526019)(81166006)(8936002)(26005)(316002)(2616005)(956004)(36756003)(8676002)(86362001)(1076003)(81156014)(69590400007)(2906002)(478600001)(5660300002)(52116002)(6512007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6426;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AYUKYY23xbjDhrlw6YiZirRnXX/RHLHGmkyFdztIk7xRa3VkoLpABPiSkoaT69jlbS4VqjLup/WDmvMU05HXYeZ5NDE5/lA3J61LKGSrxSAh2NNsjz5qh3qfZ763MaRqkXq633AABqnD+k5XFv50HrlksQtS2N12FOBJkPjEcba5wRjfFJowyD4RoP/sZiNPurCPb5qv7VZ+ZVx1BCsWWTHsYMe0cEOsaWCtkSOHeqvWnpVMOYSb8L30itC47wvE/boOrQlxS6ffbr3yQMSoWt+zuHXlcTaiGTwm1aNdWqUXl283/VzpEPr0VvAbCyfQiu51/6j40qsoU9LyJgA/41mgmaAQsLYkdpxDMIM/mz5v7qzaxT8DTY7fFL11m/Vr8eFWLvQI4Y4KQqIRz8zFy5y0HkJfFOz25OI7fLPa1V4tHDxB5nIkVomTg6qMYeTYUUHLGV63bFFn3KmWaXCpjoGpfIA2S9xYCYjo6jA9+jfd71k6/cwqIdGuIg0mItjl
X-MS-Exchange-AntiSpam-MessageData: Oc9z5NPyrC63LE1/+dKdUEY9k7VUe5hf2pzrFmjZdMycdoF2P4gCKrNWxgKULnRw7DGJf4VmGcWp5E7h9FlY68P7jH4hkPCMJ4D6hSr1P2JMy+oqzZG7XVK3vLdhZvPJf4dr16NOXnrhU9wvz/gUHA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65002b98-364f-4de0-58b3-08d7cb1fdd1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 09:36:41.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iG89NZ3Y26P6gf+QnpKyPGCPRzjog40o3LCDPNrIWxciGVmwcvW+EQXwXbtUOIzkf/otSTjTAJ0EBj37jtMMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6426
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Fix the follow warning by adding the dependency PCI_MSI_IRQ_DOMAIN
into PCIE_MOBIVEIL_PLAT.

WARNING: unmet direct dependencies detected for PCIE_MOBIVEIL_HOST
  Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
  Selected by [y]:
  - PCIE_MOBIVEIL_PLAT [=y] && PCI [=y] && (ARCH_ZYNQMP || COMPILE_TEST [=y]) && OF [=y]

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/mobiveil/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index 7439991ee82c..a62d247018cf 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -15,6 +15,7 @@ config PCIE_MOBIVEIL_PLAT
 	bool "Mobiveil AXI PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on OF
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_MOBIVEIL_HOST
 	help
 	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
-- 
2.17.1

