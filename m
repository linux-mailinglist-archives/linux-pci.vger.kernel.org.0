Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6D27BFE3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 10:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgI2IqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 04:46:14 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:27109
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727831AbgI2IqO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 04:46:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RObNL7h4NkyjImPokafad2GOlY4j0+ZVCKO6sqZeEBr4TpC8O1Xw5AJsa2FG8T3Bq0ol2NK1uU0bUUjPeAgtTrPjsRtGJJ8tD9QdNuS2R868ByckwHJGxaX8Ti1y168F6xyVa8em8uioW2BeFsUJLFMpF+ZwUe/9ROGQpW2wzsFBWjj81M3TZUunJ10ERcA5nNyb3SZN1rkG4LZIMpOC6Xab/hiVY4b1oLZjFr/5S3RVbjVq+2SgYOnxFcIMUR2o8RJ28Bk+p7hDnSyCQytoBa5zqOC+FvFNPy/NY1B3WqeIZu3K1noOVpUOtcAb1FMt5U6QOOl1jkJ1HgIwFF5sCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7XSUcm8dJe4tRSMEVoN6BWe5vWa0jZMWFN3EZXFOG0=;
 b=iDd45LQCNVJ0qyK4VERBhQ3U1DiKgswSJGtAPq8f6ew2kgRhqR+ge8VKQBdRiMuJSILFemK0xZ5g9SGe3QcIRxcP6Gs9eUb+Ge+Dm9hm82iNe5NynkTGBZg9V9K/ow2VdVKPGm0g00fDdUKDbz/QujwS+u7K5HvNMG1RhFAFmanFf6m4R2sQ87r55RedTj9CBLyw8ltG/0a5iUoNa6nPVFMAt7KyM/CesEFoH+RfwhvszcF9K63Gr//joTFrV7TBCUG/0u/jm6chU/1Ey2pfmd1IBq0we4DESsRc12HzFRjiMLzev1F20jZpMDoPHk7Oyq5YTCnke8i+47Avjxhm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7XSUcm8dJe4tRSMEVoN6BWe5vWa0jZMWFN3EZXFOG0=;
 b=GVRGcvOrpWbet3Wp9yibBpH/SJ0WNWkmSnaHlWPBGQXoO78EMgrCqA84ozAHCMqq1VDpbH9SNzGd/a2uRDjuz8ngTKm5cG1SYiraEpvFJaiPNjxBib9oeyhNko87WBaTqZ/voBTFJysoF56m2cBbmUhfEpDw9dgibpiDj7FhYqc=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 08:46:11 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 08:46:11 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 4/4] misc: vop: mapping kernel memory to user space as noncached
Date:   Tue, 29 Sep 2020 16:44:25 +0800
Message-Id: <20200929084425.24052-5-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929084425.24052-1-sherry.sun@nxp.com>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0032.eurprd03.prod.outlook.com
 (2603:10a6:205:2::45) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM4PR0302CA0032.eurprd03.prod.outlook.com (2603:10a6:205:2::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 08:46:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8be80092-fda0-4902-92a4-08d864541da6
X-MS-TrafficTypeDiagnostic: VI1PR04MB6910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6910E6BF5E08E5DCDFAF48C092320@VI1PR04MB6910.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNq16VwuWZ/leJ/yb4vYSLx7Lhyuh2PRJIp6F11T9rub+hSrwuq2YbV7vdd+mZNXe9Ke1UX3ROz3uQSfTpNr0cPmqAiSX2eUyRSX2H2jWxsjYpK0GGjMMGate0zYc86CaX1a27L2Bf4Le/k4r3cHlyBwb9z27vmTchw2gs/i4GiT3l1yQTZjsE8YWrH16F3BJTAvKgp7MlbUaVnvKeO9q7bOuo1PAilBlvbUfKEpOfK+kmi8fKr1gPxqLZfq9UQPTa3nRuchI+CyMCj+hB/d1o9/U65Rbu4l629h+qWlumOVf4sxgT+moLlsdaQEEDesOmo1y+AMyhGyR/3T1PIpq7LLATt9rn7qwO/23ts168J53gP/dGZcst9MgnrIbaiH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(2616005)(186003)(956004)(316002)(6666004)(8936002)(6506007)(52116002)(478600001)(4744005)(6486002)(5660300002)(66946007)(1076003)(26005)(4326008)(6512007)(16526019)(8676002)(2906002)(86362001)(83380400001)(66556008)(44832011)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rdltEmWlnMnFiN954l8oPPRo05wR/I5mYN+wr50UR5r4dM4wy+eltiv2FuqLerGGO2AFubl8O3shFTLE+05/vdEcavTl36SQVXCIKvyKs0UqVrScW20NXB5UvDz1rF+wcYyrCuXlnepv5vBCbmTyHZNh/FdJCAsuy6PiFD6400q56afeBTNNFzTap+Tl+i0xGy6ju/Jme75KNMvSDxUgfPapMeuMXNqQvt4Glj7yb3RXcZSN133tm9fwivHwpKcL+PVwfHmaM31lFGL+nbhb/f/i97DNnr8r9rK2pFCrBurBPVv9/6OnmSE5c9QjtlwyCzQ8p3HF8yeOntEAHrbBUCmi52vc71cBQAjBjjHR4Gvy4qSzglR2QeDS8qvsI4vr7TOQHy+2kMY9EO1TndTzUtYsGgb6flpoofCZ745t3QbWqXiKPH1haOKsOu/NQlB0WCDPPJYwmCKmlJB2oln116LPCOCuEbzAex8QbgCpKVZ6bUjy0DTPBEE6reAf/0sLoRsJ0ziul2LPas6vvag8pFPkS/tgu2DybjPv6Cd5vhGnUWLJqzGve664ulo8q1OPi9HT7z55YXjscytndCt6Dh7QN/HQeEYMw4xYTgja+TmY3KvFXkpusrLP43Ayh7IJ+oIEG/R7OPKt05jG0TOhog==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be80092-fda0-4902-92a4-08d864541da6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 08:46:11.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CY8de6KtT/0myODomWvXQm8RuXP0tRcdeV33oubGB60NcLoWhkha5dFVfXuIsNvHXE4XzUZLoDgYYrhrvcr2FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mapping kernel space memory to user space as noncached, since user space
need check the updates of avail_idx and device page flags timely.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 4d5feb39aeb7..6e193bd64ef1 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -1057,7 +1057,7 @@ static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 		}
 		err = remap_pfn_range(vma, vma->vm_start + offset,
 				      pa >> PAGE_SHIFT, size,
-				      vma->vm_page_prot);
+				      pgprot_noncached(vma->vm_page_prot));
 		if (err)
 			goto ret;
 		size_rem -= size;
-- 
2.17.1

