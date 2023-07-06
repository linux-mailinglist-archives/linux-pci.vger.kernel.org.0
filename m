Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE7F74983C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGFJWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjGFJWT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 05:22:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2118.outbound.protection.outlook.com [40.107.117.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B4C1FDB;
        Thu,  6 Jul 2023 02:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtGEtoyHaiS4JgftmQEqOMwQDsRca3rX8TdSaFMiX3XwuYGIBUkjGZ9RzIxEjLBxDImvsgU1uGQN8kW87LiBTieJqv5nk5rwQaoBm28AY2gr/ru821ZzFpR2ck7Nc7He8kPF2G+fNdcjjSIzmF/yQB/jretputMtbX6QPbaXkVBOqGg/G4JBjbKR2BMCkhQ8/7qQHaScax+1SLsbU+DY4y73MWN8TGh/tfFNMy7Sk4nPVv1fv+6rol847MaS2A62fNpiIMTkPUBlh00XDcqhGvTnj0aCRnIAKLPoE/B9zkwOCk7yG7g2M/OwuxN/9uPhpC/XtIhJ+KbEa6+D3IfwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OX2vGAet7PpI5x6PD205cmO+y21lSocNiCDk59Mgp4=;
 b=LS7UJd/nmQWCtd6gynQEZYSfKlmtXoJZk1OG6JW5kqiGLyJhzS1tvkPBOrdxPrtpve62TD7Nml9+BCejb/JGpWipUt89tH1j9q8mob4N8ZTPLfwqBRNVnc7v6fUL8+jY6qwRKFkOaJfbbMAAVau6Aj6q0sIavXC/8KoCZ22edyccdwmcGQsQDxGnTpbq/juaiMngGr89g1loHKqsgrBy4cyuXGrTOEtBKyNcK3Ebp7PNtA7D1imOCUedkqNCzMmEZx2cowO+73zpCN/SrZ7xgJ1DxgI19xbFVhr9uqM4wTxYR5de1TsC3Df8l0JTjsEhEwPMWDE6Le2HoAFq/xyY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OX2vGAet7PpI5x6PD205cmO+y21lSocNiCDk59Mgp4=;
 b=n+P3xP230pcpfUmwXX++qgn0EqA3OLcmOK0mCGYXh0jbGi4TGrElmFeshGuUL4zcWKgTWSd7UZWxxirf7ysFsJXbOe2ANAG8Pob1gB60vvV6I3W1BqSkEsVYSDK4clrXVL6QXU+vz7zk2ieQUSMYBSqQWJDq+mtQfwEdEf+tZvVDCnvM5dJfqyjZtio/BU6PL9s6kAZ7zfIhrPJaekTCb9xLLIGqZjD09xiDL6Ev4ervLFMgxnJyMhDrK3lKGy8vKZuqepm18/hsrIPoLOGeB4Kcek4g6ZDo3vTOkMrkmQHL7OnfzTKxKphstsGOOSHjwalqt8OEFzLpRwvEbrQYMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6378.apcprd06.prod.outlook.com (2603:1096:400:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 6 Jul
 2023 09:21:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 09:21:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] PCI: v3-semi: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 17:20:45 +0800
Message-Id: <20230706092047.18599-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706092047.18599-1-frank.li@vivo.com>
References: <20230706092047.18599-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: dab93279-957e-48db-03c8-08db7e025108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7GPygDXM3/poUomjcxR1sPxHI3u4yLysArMr04G/Z/wTjPcJXk9iD8+oeVKkaT2Z2Naqj3gWl+eO6RcR2fifsEzvfjhFKWJyp4QniQqX3BbH1ebwx8AebilIraoDpqBIHJojAvk95ZAvL4nKVQtJPyV1i9IVH78iM9eb3kQnIc5xl12q4FCnkJPCxnH9VHKwm5ZI8HPUWITsuzfpPVNTD1ljeD1BCM5CvQ+DAbpJ2Q+gLZlfKfi7X+ujnmEa87JagDqC+Vn8OqlhKIuf2mh3R1+Acba91iSmdDPPHvduJZoVCzDorQRjbkN+Z7wYpzI+EwgxS1xQyH5MSr1ypKkc+EsDMAp4ev2+uojilJo7BZUc8QFQtNQZqXHfX/Z3GiJZb3TMl2QUZbVHf7NyNL9/iBLEtrlnbvKI5gqO2LxxFcIKKPEwjaU1Qt5eRoKxJZBP0PxIuSBVYYL/CUk1+lWJdwraNzsSaQU52/OzR9ybSaSgcWsc9teGqAYP8JWjH89fUKJttbl9oJRYJ39gZBvSHTnTVWUCoZ3Z1cLG6OHxaEedMKIlImVp2zQTqiyqHRgiTVoXxBC6BzvtyhHH0XGlejak5CaD+HfQ9hwVoTtGrM7d7BJ34t4hd33fgWPzS4s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(1076003)(6512007)(66556008)(4326008)(66476007)(8936002)(66946007)(316002)(36756003)(5660300002)(8676002)(478600001)(2906002)(38350700002)(110136005)(26005)(86362001)(41300700001)(6666004)(6486002)(83380400001)(6506007)(186003)(38100700002)(52116002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cmdb1WkQjGE1CVfDihwVEu55A5Vz1joLpRA/YBYgENdRX5lwNQ+UQuD+Ulz8?=
 =?us-ascii?Q?kjqH9z1ZgEVNctV6wlSn3Npu6OTTWo4ll97VLKi1MWlMAWJS8bcA6TrOOMpI?=
 =?us-ascii?Q?P9/jo9kazIaidp1izEBB1qDQzDBXnMeL2b+V0LODjs6NkiQ7fG0kYtjCEoyk?=
 =?us-ascii?Q?zGZ2LkjRCZ6MQ3ifayCqsqCp5JtSs6SUyuofe0kekU/WBplE0dDEg02042T7?=
 =?us-ascii?Q?M/PXGwg8EugDdUix0D/gNBa62U3wKSAFyD0mFZjc+X2+srplYPPlMltag1Mc?=
 =?us-ascii?Q?eE1r2crRGxXjSlP8l+Y8z8mMiV5PG2eH7nZr2J0RFzASvke8CW8Jk9dcVjrE?=
 =?us-ascii?Q?8HKzNN9mgPuwHulEXXQUdNZe4p6PQPVwSk34LWvP1kf2cMwBAiE1gwMwHHsy?=
 =?us-ascii?Q?LY6+pd6AAtQIyEBAzpH43e3CkXeGfmr6I0FmaJyGjK07/Cj5NrOSRhY87Um9?=
 =?us-ascii?Q?1JOI7BYEVZRrhEe+Y5vbZkq7SJDVkUAWSYy0YQjiz/+gjTW8Nnl0xB605vU1?=
 =?us-ascii?Q?KPCmzQeaVSuRRMv+SqF5AYSJYCbcEwioqHkUJoWMeeoLLRo6l6N2//Th4+X6?=
 =?us-ascii?Q?5V7lySKfF7Lnr9zrFf3+x0kL22JWFyd57jPmjcVRhC0fKh2Ae3+WxmavDwtf?=
 =?us-ascii?Q?47bUVMkbmZL7RC58IE6yrmuFlvc3zJf0MutsXGlThbkbQy0boErcDVLLc+oZ?=
 =?us-ascii?Q?f0YowqrpKbOY+N+QPNbzQvLcjgwnNi/ssH3cT1rOUYcXhgoZKq3qy12+cWJO?=
 =?us-ascii?Q?jGGHfzUqrnFA+KlhjvDmP8K1+tXhzA54eMMRrAPsMW4RC9Mk6c+/SdDVS8nX?=
 =?us-ascii?Q?+5Ts+CJjAz6+Y6Q1BG6CWWayQZEb2ANhHTf7EuV48D/rEjcbvf+hvm/i/xSQ?=
 =?us-ascii?Q?LT/zr5CRZLQyG3HT35WRyDn92DX5dfROhJjW4fX2ZWN9S3KAtThvRkm82QJf?=
 =?us-ascii?Q?diMORLb9qJYxwPYdnU+zRkzKpkQPWn9M0yym6MK+tm86fUUJHF49YV5YKpac?=
 =?us-ascii?Q?dCkeD6P49CD8wH0RoVMnLpK7r0VgvjjFHrsglqshI2zjp2KJch3Y9ILnZW8N?=
 =?us-ascii?Q?kU/G6iMq6hC/Ky8GLE9jkJRJuAdKUvuQb6h8cFjwZT4VRpcdaEzc808z9Ctc?=
 =?us-ascii?Q?uSFJ0rydk+Ao9W89Xpq3u+vReejnfakLmntXrzGEZsWgsiqPwP+PmezN7SZU?=
 =?us-ascii?Q?3Fq8h7svy18FeyKwlhUEpUJHudYG5mEe7yRZDBvrU2yiy8AR75bVxQAREVwT?=
 =?us-ascii?Q?oLgts6B6RsiFwPVbdIiVl9N52MfAgWTdbBN1ypA1yp5JH2AN2K6xO5ORYVIQ?=
 =?us-ascii?Q?6s7pkh2z4Hw7ouaz9qHAMcrOG7pb32H4yVgJ/V43qk6aZYavEyGeL3g2ctGq?=
 =?us-ascii?Q?J8dBYvc17pEtpZkKB8fQP1g+QGl1QcZvBjpH3NGC4vsru/WNlmpDniM9iJ0a?=
 =?us-ascii?Q?1ck0K7aGHSZfXd9m6gmJk5L81MpHuuyLzgowGz9XHgjPVoVUKhOvdKg8isny?=
 =?us-ascii?Q?7zEmtz4VYJhdleE4WsXQgvTFQB53rhI+Wb4DFffFZ3fBBGO8oFOifKKiHpAO?=
 =?us-ascii?Q?4as6OVUEdna9zScN5xIQCLHCudARt3h8E0XKwmXT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab93279-957e-48db-03c8-08db7e025108
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:21:01.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFx+TzGHwVrcp0G/WhqiACMOuOoo+yM1niQTxfv7W8BufYACNvPVKc9+wjRLlHkQ/unr4FveTm3th+lOeXJNWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6378
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/pci/controller/pci-v3-semi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index ca44b0c83d1b..0f993328dba2 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -736,8 +736,7 @@ static int v3_pci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	v3->base = devm_ioremap_resource(dev, regs);
+	v3->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(v3->base))
 		return PTR_ERR(v3->base);
 	/*
@@ -750,15 +749,14 @@ static int v3_pci_probe(struct platform_device *pdev)
 			readl(v3->base + V3_LB_IO_BASE), regs);
 
 	/* Configuration space is 16MB directly mapped */
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	v3->config_base = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
+	if (IS_ERR(v3->config_base))
+		return PTR_ERR(v3->config_base);
 	if (resource_size(regs) != SZ_16M) {
 		dev_err(dev, "config mem is not 16MB!\n");
 		return -EINVAL;
 	}
 	v3->config_mem = regs->start;
-	v3->config_base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(v3->config_base))
-		return PTR_ERR(v3->config_base);
 
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
-- 
2.39.0

