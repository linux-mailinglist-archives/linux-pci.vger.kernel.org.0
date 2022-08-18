Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C00259871A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbiHRPMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 11:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245462AbiHRPMB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 11:12:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7236BE4FA;
        Thu, 18 Aug 2022 08:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FilaJm8WJ4mv8K7SkKAnTzQCdvO8KB974EEYb18SnExW3Kr2/c8KtA7jwTnLvoRp6X4zKZH9fLLyyhw9ek1+rp719oWS6An6OGGf0dfHi9CVjf936F0VqIv7nNjPeoik/oerqLQgOKLaCR56V1G1uup9l73Mh4IQLA/z8bw5zqJbZxpgGVq9J1NRssWBrvDVhNj4VYzgTT6WPkseEENNE6P6ULrlu35jVq0HTUiLv1d7IKRs+lo4AvQqjD4J0z0CpRj1XZ2ADrwGigNdd2ApMXIvwK7iywi3/TJeFGoiV7Qi6NUerOkYldFV6x6eCKBQu7+/FnR1kahXuTDLOg7oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=BprdSuTI+P64SOqeTQzWn/O+FrdrqbR5bcNvLLtsq80lt/lyxqdTo+QiN+aVhRywr2kPZSNk3fwQYKupVI/xmRyh2GmP3IWtXz+Fuq20bEDpfg/tvmXeu6p2Wyes+VQVk73QTH9/IZlttHpQQL7/gcWd1ZgKrG1SYm8+TPqN2fXbKkGg5UTxG7lGfbXTLiI+nrGzAkfllVNeyChBTvC74OYHsweoIpDcLgefFjpd8lpR8oTaKeJA1hq5jDC07YwAQleNhMG/DQyff2PZ8etGGK06v+xF4fcDHnoqrFQgwdfYkb+10l5j2tx0q3oAuIZK6QOwj0fn8f13wtwyCEij0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxyZmoQ4HPxt9JAZN3QVzBllZWpIazPpqniEWrzTllw=;
 b=JqOYbackT+upKDF5Qbg15kkR77MfoYd0HVJPnnS0YH8eMAFx0fu8kAwAMHlNVM6nuHwfIvknSuAj13jCihQNyxuGqq/Ilq90SmFLcydGAirjtPbQMjTWNrZUHuIDeR/SPNjhGyaxFOPqMMrzC/Myc3Tr45+G7czLweLDeBjOZGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM0PR04MB5713.eurprd04.prod.outlook.com (2603:10a6:208:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 15:11:53 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::40a9:93e4:75d4:f73c%3]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 15:11:53 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev,
        lznuaa@gmail.com
Subject: [PATCH v6 1/4] irqchip: allow pass down .pm field at IRQCHIP_PLATFORM_DRIVER_END
Date:   Thu, 18 Aug 2022 10:11:24 -0500
Message-Id: <20220818151127.2449064-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220818151127.2449064-1-Frank.Li@nxp.com>
References: <20220818151127.2449064-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e208eae-693c-42e4-9a3a-08da812bfb8d
X-MS-TrafficTypeDiagnostic: AM0PR04MB5713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvfwWvBA5amL9yHYFfkpE1WDS7ibdl1vEbbL9hWOH0tBFiWlHoV21qL5yGR0mQLbk/BqW2JIFW3YZTY0SMd/eWt3fRjXEefEWwGBBotCtcfKpa0dTXOdvN5jmeOTXQpZoVWu1ZyBK4W45QhUpwgsVEg0vrK1qVKlC1LYSTAdsaYvYyHHOuGor+rLY69CSV/JFGV0dh3CqcoR2sv1CilZDlXNK0M0/lia2xhxVOt9SGmqp7bYpYLbqwkmAVEA74ya6Z3ysEafZPbIMYJNDmRMzOZJdGckGgih62oZj8Ky1kQBM68U0NqvT/4ww2VhsBvMbkvk7hua8ZaN7ha+CyF7qP3vTpJT5ls7frw5j5noGgN0bHdHipiNs1SxDaaHFWSuUJwWs+bmLwCL+0fPv8zM0U3kHOhZU/QT7Ks1z0N0Nq0lBXhx+1GWYvJTzwPeb8jkYM0O5VoUeUcL6rRnHpPqNr76Fm94aIqBWoDi8M4XDnzZEoAxBgNSaBQ/8ZXzxP2z2TvLTEpzH6TRAJy9/sJvL2t9UYol0fDpYGhRU0qieA61yttryd3gt0esnmtED1PaGQkRWr/G7g89LmOXfLxmotUqQe5wfiMbwc42IMIEdw11O4InGoAWT6GwjwScMuXucOj+NhEi1S0J9B/SalR9PqmdOKaBZnuA03gmFKTj9idbj1xBhw+JIfBHUIbBf1L6TOJMjrWgkbszrjZgb9aFOVNQWxreR1Z1bVIwYtHmw2mvkyzzZQORfnAvlZHe5dkPJSseLOzI7B+tYcazWiLOfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(2616005)(316002)(1076003)(186003)(83380400001)(36756003)(38350700002)(38100700002)(6506007)(52116002)(4326008)(66946007)(66476007)(66556008)(2906002)(8676002)(6486002)(86362001)(6512007)(41300700001)(478600001)(26005)(6666004)(8936002)(5660300002)(7416002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PrJHPDQliS87q+bg9R7PHgtQ2fJtToVoan0SFxHjojiiV/YvfAbKt8nAkGmR?=
 =?us-ascii?Q?2wYedH/dnH2Pao4bS0+bAUut1hvPazRRrAX8Z3X/SVZ5AtVXAj85GS5jrH82?=
 =?us-ascii?Q?dgSTDHUbG7qhzfGXnIk3vJcQJKQ5lMGCfMy2VLAX7sxQczhGwJfMuWZ0hhNZ?=
 =?us-ascii?Q?t0CyK/PwRjYumuXjfzrlXh50G6TwavpoHojz77x8MGe714UIrMah17kFYeEt?=
 =?us-ascii?Q?+mt5eeicl3eFdpQpxzCG+Fd3rcarmkYwg27jh3sYvhTp5cWGcOPFqoedfZM2?=
 =?us-ascii?Q?FxNpSVsLvBZdkWvnZpPWzMiyKku8mP7cj3gXhETKXUNFL5+T/hKh6iSdFPdk?=
 =?us-ascii?Q?m9R2e0eK4Dpdr7/SwgBAtvgYHgAQQCc+p7SDyLxTkCPSfStbtxWCmk6WfNJ7?=
 =?us-ascii?Q?fDdrVJSem7Ugv+vcdZmRJtqXqsC7LoDT812iCQHxSTHDqhJVExVcbj6rsrA6?=
 =?us-ascii?Q?pY+1cKuzB0qB4WwuRMWbNYRXeUjLuUtUu7WfEdzYPvOGRKQ0JImnkxLQ0jDn?=
 =?us-ascii?Q?CUNo3c6OxO7yp/IrxciQS+8pUWKA7bvewuX63aw2IKfg6d45C+7Byyts4mb0?=
 =?us-ascii?Q?IjVOH6cqxDCgCEzwWhXxD3hZ9sLENEHzTFJcYGUXOFo9kXQDDTDM5q7Udq1H?=
 =?us-ascii?Q?Al2YUua2f4eE/0w1xJfPxMEkjrs8f8PettE7O+BifDXV9WLjSCDH2G8i5NQj?=
 =?us-ascii?Q?bTMjJxE1GVspYfq5Xo5CTWSCpwBdwuYR9UuAo2H3ARIDYTLRKZbmwsxFPNj5?=
 =?us-ascii?Q?tagA4Vmz/a4iQIejH11xWH57cLG+27tLgL62LWlwi6WEWYo79a43edLRgM/Y?=
 =?us-ascii?Q?1XMK5tbpUnUCo0Fz3OjCQ2cJkyXbpXZoNEwtCXO3J2ARrf/vuVdy2RMStW9a?=
 =?us-ascii?Q?OlFK02MpD0gnItOrBQDaDH4WsSyyK38EEZRQjLl0JV91EIB5Eoc6pR5xioR7?=
 =?us-ascii?Q?1j70maHQtBGBXBRhzOiRudLy1P0Ynbku9yGeOi4F1neIXnHfodMk/C7vKimc?=
 =?us-ascii?Q?K+FquAaf0vJnqAa1zFgKI6vkQ3Ntg7JjqSJDRsQTxmUfLcHTsMkpsxA1L3PM?=
 =?us-ascii?Q?bZGcOnNkN/qK7VLdh0rQpKFqg7tG16D4OyubHFAXm+YKBZZ0L0uvsjR54leo?=
 =?us-ascii?Q?SOPfn0ONlRvDXc6FYv/89uzLYAD7U95WbH8u/j7wdq9SdxzEgI4gFG21Ujp6?=
 =?us-ascii?Q?8zliUCvRKkHvFqJNjHL3NGZ9ZD7jyBAgFfgK0sXCTw3nMx6TNgFsCiAXcNGr?=
 =?us-ascii?Q?Ax61LjGKDnQytCVuoZZuwdkAqastvJaTofj0LWXyUjJWb76w6+0tAr0whl/P?=
 =?us-ascii?Q?WUTrrCiQz9AXhWoGNqgdl2QbClKCgsv9i4HehHlSta7W/eHJAIWOUN5h6zNK?=
 =?us-ascii?Q?tycTHZuZDTiMGzWkFFaneiJkd5GNh5o41X8jxpPCD46bVcKDdomxvlaedkEG?=
 =?us-ascii?Q?h+EHu8N6y1tZ6IuCt1K5/178dt/2iN0xWQpzhy3/fCnbLZE8R0c8Z4OUSF8u?=
 =?us-ascii?Q?SdHhQR9fsnVwZ7LBZQ+CknEDHzQvWq1Rmq5fb1rl+3iL6Em39mkmoYmDyD9y?=
 =?us-ascii?Q?z96tNbR2BrYuzZqqhdE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e208eae-693c-42e4-9a3a-08da812bfb8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 15:11:53.4971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jobOm0K/E/a/JCE+0jARUIrdM3wjIzW8CELUJ6HOQMOMXyGj6IOjdQMLsQs7PsGHF/Gt8VvlpGXLD/oxzG9aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IRQCHIP_PLATFORM_DRIVER_* compilation define platform_driver
for irqchip. But can't set .pm field of platform_driver.
Added variadic macros to set .pm field or other field if need.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/irqchip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 3a091d0710ae1..d5e6024cb2a8c 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -44,7 +44,8 @@ static const struct of_device_id drv_name##_irqchip_match_table[] = {
 #define IRQCHIP_MATCH(compat, fn) { .compatible = compat,		\
 				    .data = typecheck_irq_init_cb(fn), },
 
-#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)				\
+
+#define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\
 	{},								\
 };									\
 MODULE_DEVICE_TABLE(of, drv_name##_irqchip_match_table);		\
@@ -56,6 +57,7 @@ static struct platform_driver drv_name##_driver = {			\
 		.owner = THIS_MODULE,					\
 		.of_match_table = drv_name##_irqchip_match_table,	\
 		.suppress_bind_attrs = true,				\
+		__VA_ARGS__						\
 	},								\
 };									\
 builtin_platform_driver(drv_name##_driver)
-- 
2.35.1

