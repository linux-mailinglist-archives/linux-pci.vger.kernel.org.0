Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0174983A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGFJWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGFJWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 05:22:13 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20709.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::709])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D41FC6;
        Thu,  6 Jul 2023 02:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+zbcWE7Jw5/x5ap2in+6qSvbAHHGDgKTSNca7FcFYfuUGQwULFRZ9V/6MUvuVdP8mHgAEe+BTmKXNJ39rjALOLdxD0Dti97o1Rli6n5HAV6KoFHFu8cSf17CgDfGJFxU/6uViUF1wHBEmtAfUMTUXknv+9l1qX33h6ctpGQN2paGXJFvfq0nNUKLXsoP9GVToxYBcGPHr+OWiG+2ugmWgJHwzCksUB/vGP5PEsz8m+2VzalyRdxUgr8KFpK3389fdodIuYud++GkhftaZluIXoaelKIlx4U0sD09t1A5O2xWw6KF+kdxDKBiFj8M3EB093AcH6mzlpPSbh5xcsqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voSi5+evNxjrc10na+M1f2wZWxGFN58S4FEVMOC0YGc=;
 b=HbWUuKH7S+cua/Hk7xwa01ED5k/l6AvmLjtPMdPEhfsQOjoBfhVnyOkm/2ZWnk/kwvl/3mFsG2B3fUcPSdK2i2zkcFNwkyine8rDIl+FNATrBfdU8sCmQq4SpMtLZbVVuZtjDZQgRCIf9uVccF94fDmdBoz+En5VE1OhoVP63Aex7tuV7pq0m/9s45tEdoRUDMaecfx946czg1Am29wBUYSkKMAf6iMq+sopS67j5JP0WtvDyepS0jruAPguGIZEEL3fRF3vmITgXfUfyftyZ2UoLYpotRG3xH7xzI/sUJG3EONCZEanaN4BplZMlPaKaB1b8mAc280ENuy4FIytxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voSi5+evNxjrc10na+M1f2wZWxGFN58S4FEVMOC0YGc=;
 b=T3D9RJDRujHnycuWCQSpJ1m2//tH9y4Pb959DA89nkrEb9xu3bXgR2OkszDHjne95W9JQpDiBxIxeBvlrS75xEHObSAb/w0W7O6wqVHkixQbtTTBNFfXIPUK5a+zEFqrfsGd0t3CK+T8dJHbLpaT4Kg/3ZkxoSMlIU3CT3xLFuktA+2h9ew2YyQkzBtfx1epYrppT+KXsJznHKWh6p3xe6xFlH+mtJjs5Z4Cwlo+tb4GHMhYStVAI/N8yfAnq/6mKnA66F9j7/SEpO72061D7aX9eNKDvJZ/5+L5aij8srET7xAh7hGL3x0+TZs36GBez7tc5NmWq8tAp9+k5UEz3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6378.apcprd06.prod.outlook.com (2603:1096:400:419::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 6 Jul
 2023 09:20:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 09:20:59 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] PCI: rcar-gen2: Use devm_platform_get_and_ioremap_resource()
Date:   Thu,  6 Jul 2023 17:20:44 +0800
Message-Id: <20230706092047.18599-2-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c1d2327-244f-477a-4da3-08db7e024f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFWUWxbLS92yE0nWmO3SwiqdNavlTrCD9+QZc8PdJC2ft/5Rdn7HeUSfcDOkoeO0FDa8N3qzpk6d74jXqRIzbkfCRo8GTuylslLkdn31Maa93ekBYlWcLpN+/dUCCPH49cfF+4yWmiic1b7hIP67QYF7wPaB979v3GWeGoCi3iJGXruYHUHgH9SrZ08TdIZG8guQCW+n6Gd5pO67xEAI8GZc7WIQzcGsfk6heOfBEn8Ss5BHGbvrWfEuGvgbIXPfiTEiGJ944IOq/sf3Ki77quiu+XMy2lWFjQmwpgiZmrpkm9KR2C/89Zdc2M87V5XtCfQ8U5S93hpnylfV7qWwwPQ8zDFiovNvQciirdxwcE1FRsjAcC0ZgRfyfpWI4SqqQEbOaaxPHwmA+p4v8DU49YManzCo6Fr1CXX+s5Sjudvd10+PZFrOMNK9V6tuGJKXjWH1KJ3mZKuiHMlKJRRG9faeJUsW2sZ5IisdKLlR9Vzx1BEaCTjOnbk2GMi/fJwgkvaew8fzsg+yvhA3kaI6fVSCi93a430lTQlGkUe4SAdtI8LdstC6RZoLah5Ux2a3LyotoC1o9gh5tY7Lx1x0YkGpBad1WRo4sh6UmzhSP93ybDLQNmVLP62aKAD8/AgI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(1076003)(6512007)(66556008)(4326008)(66476007)(8936002)(66946007)(316002)(36756003)(5660300002)(8676002)(478600001)(2906002)(4744005)(38350700002)(110136005)(26005)(86362001)(41300700001)(6666004)(6486002)(83380400001)(6506007)(186003)(38100700002)(52116002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mzx0tG/c7ov74Uv3zmhvhjqNiU64Ci06I10wyb0zUKiyVV8OWTUu7SaZRA7x?=
 =?us-ascii?Q?3ypHR5YNnffHcXw34IDByVK7rq7SICGJn9Za0Q6P7zQA0GwvKTAGkx0g+bBT?=
 =?us-ascii?Q?ja3fPZU9l0DaTT14ow4gXD8Bw378ZDadyQh0eEi4GCtxPcm2UKNOeNECBQQX?=
 =?us-ascii?Q?8qdlkcfgQzgXpnr/2p/Qcsj1vg0DMA7Uau51BOHA7uUn2ufX/+SshfPN1YrM?=
 =?us-ascii?Q?/TWkfFy9+HCVvKPu8wm+I5MYIeow9egs41957zvJ9FPmENlA9SBSSraReQcV?=
 =?us-ascii?Q?qRkvWLZD9D8Tz/zv0c+By7jQC9RUNCOC3m0vcnCuixSjIMWhJhfipLyKeVMh?=
 =?us-ascii?Q?RuN4jI3TcZj5/lVvFxk5ig0vMiH7VPDDR4lJP2yoQv1lt2gynIPfMwsb7BLe?=
 =?us-ascii?Q?/thycQhFvClUe9KK0PULMiHKBPzV/MMyYxhpFL5jlk24Xcc9wlHdlTLQD6tl?=
 =?us-ascii?Q?Pcwsd/HyKF6aguIrqebdR44cK1DD/Aq9Esb8l7zdHkuER2KYGEpJsRERbM2M?=
 =?us-ascii?Q?g3XA9ed0EHRxaYfKZead5ItIHOAYbJwsVnMz4mofU4zGZiM5oRVB4krar26x?=
 =?us-ascii?Q?QMyv5vnBES+f5HVid+z73wOt1I1d27DLUF0266dqSelyjawA5dSw3v67bWJ+?=
 =?us-ascii?Q?+BPXCXRu7biub7aaaJUWc8PspytNylTBX4a0crxzhXhb0U+zVbNrNzuxmGpH?=
 =?us-ascii?Q?ILfZHxOrPqaspul/snH6462zmhOvTKhSdTkzXlD2mTtZ5hCCxE+L67QRPIxe?=
 =?us-ascii?Q?Wvt7Kw/H6PibI4dY9Eli/zmX4dcPgUWbz5Hq+K8iD3qLW+3Cbc3sjH9bYrZH?=
 =?us-ascii?Q?m97EEKJBQVKauaU5whDewMEmVtuAqHceBMXe7R+mOvlP6kh43uLCwyDZgkEW?=
 =?us-ascii?Q?bu+v4Bh1+dTSoHT3+D4Dl00PJb3gTfaaD+hnXUKaz4QkbJu0xK7lnjCFxe3s?=
 =?us-ascii?Q?G1tYEJXASCHxu5ipHeLNW+uZUz7Zf3q2MsLWR2NEU+tKSVSPYO+5w1JORa2b?=
 =?us-ascii?Q?8PQ4hgwHiaMS9DEbzuGoCXHz3CXAaCNlSgJjeuWw52vQa8YVffQ1h4AP4PZg?=
 =?us-ascii?Q?4lMLSDrm28Pt5tySaNrykpyO6QcYob+F751MwCBcGMcV0yegJOkUcgdE+eil?=
 =?us-ascii?Q?j/pZhR4pj4IU6IGUSvx94yC/ewl3hIi07ACghAIBO9iXePqIt5QGU8PfDjbO?=
 =?us-ascii?Q?yCoMCvppw1+qA0RArDBdnxEROO1ugdpLR9lgE8xl1KrZqKgSzRuNzI/HIl4R?=
 =?us-ascii?Q?KbhZ1d8wDW1tX+muLnJVg+qYtu/7wOufvcevJ+10iGGPqIptnVKfIlTW38Kj?=
 =?us-ascii?Q?PJQ1HiLYkx8HhGPlkjpIJsvxpB6DShh9yDXqIVtJ+5iREurP/bQ2r3WhRtXW?=
 =?us-ascii?Q?tlk+wygy3Di88t3sH8B/1oU4paJidJKUAO66sw6DeQcpCZDlp3m+nnBn1LwB?=
 =?us-ascii?Q?7lBwwheNcPRSBTodgbhUx8hf1/XodIlNuwxnY6YlHhO5hTe/+qXTEdUC6et7?=
 =?us-ascii?Q?dk/0FKDdaDRQfDwmtpdGIklOhukoRX/mrGrwKFOFaFT7aIWxmS2NQLga32NN?=
 =?us-ascii?Q?hvYf4NCynm0iVNQCcEKlNuQv8CE0XgZ+gUKw7yup?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1d2327-244f-477a-4da3-08db7e024f9b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 09:20:59.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U268Q9xyNSVp0fV2FAYhSg14WEUEexQmGJWRN/G4vGQ4bP0XzO2sbKZHvDQDjqaeJUiEmBT+yERq4Heegk/gpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/controller/pci-rcar-gen2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 839695791757..d29866485361 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -290,8 +290,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	priv = pci_host_bridge_priv(bridge);
 	bridge->sysdata = priv;
 
-	cfg_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg = devm_ioremap_resource(dev, cfg_res);
+	reg = devm_platform_get_and_ioremap_resource(pdev, 0, &cfg_res);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
-- 
2.39.0

