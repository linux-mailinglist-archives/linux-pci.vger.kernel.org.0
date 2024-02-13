Return-Path: <linux-pci+bounces-3414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7EC853D99
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 22:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102241F26730
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 21:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D9162143;
	Tue, 13 Feb 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HL3xNrvK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F0612F9;
	Tue, 13 Feb 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861079; cv=fail; b=kgKWNNKgZFvQkebME6GdyLlAN2Za8wxb7c+KUfq6lmDwUWKbQvxM46vQNTojJBrnz649mkmpeLlnFb6pn95ZCFLtilONb9ye76Cdf0TzcgVoKMrF+2dkE9LksFFtP4WH6Qvt2SDjsA7rsoFQNiz6rcTQRQjEnw/6QkZgRBwiJJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861079; c=relaxed/simple;
	bh=2ryMSn+7oWVdWbaSqBP0ADpPZJzZOgdyFOobfKXU/2Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cuYtNyK9Rwm8xZm0hetK2gNzs4GCMRz6Xc/jUF+klsYfJ1mak+Kf0JfvDwbqOULjP5607jn+FiIQjUGT4ViJJZCcGFIc3P4EDt7gLV9TL+hcXcJyWfMeml/FvckUFFnQprhTg/NjSmJIjXIJAEHXEk3DEklxJgoSU9Y4OsPSDy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HL3xNrvK; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljbWw13r8kx3qrQmLl15I95GlgZ6H0iP0CoixvIENWOOt/yzH0fGAmEEmu6DJf/uuMR8Qap2juHXcwmsA2OlTrd7CDj2Pb+7PqVm3Vtirg2Pa9LmI0QZeZF2EKW1397isuiuJosA32vUr4BXPCPvJ1gx/w++1pSlHl3Fsa9quCohMdVxt7Y7hdEP4gWuyC9caP78u7qaF09gvP7ShVZnkTHe6I+WqNciKiOGeJxGVQN+zpisYI6n2z15omU3QU32U3x+xVs9PoMYlSLdNpkQFofXcYHg4G3jr4PEHukhPZBZyuh8VXVzm5JKvq0zJUJ0PFlH80LPLlT/rsXSynwFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/j9LMNuY8Cie7KYHeJpRADBHByenFKKikBZEbSU5P4=;
 b=OgAIqknFZZSklfW3k7SAImxZnSCb0v6ne7wm/c2rF8SyDOujngxGZg5p/49ghQ8e+s/hujMLf/+vy1EI98rl8arWNg31Q4wdqmN7BgGvRD/QVzo8EFR3bNAeCeUbqVnNrzLUwIUZmvQ0j72H7WxMyqIcn9Z8S0FPV2EW1KZGKdZRbISOQLm8sHZG5jv7SxNpvj7Zpwoekb7BO7dEcNrV4e95sJi6kgeFWeuth6YSmzY1XT0GUD99v5qAPsnEkTnu12VOH+ILxoZK0rV6Srr0m8kWY2mjcltjRbOGxu8Q7yv8CDX/dOVBnRM8c4jj1Tz43adU78Y+Qm4eDz8tAv8h+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/j9LMNuY8Cie7KYHeJpRADBHByenFKKikBZEbSU5P4=;
 b=HL3xNrvKBjCK4uaiexAeNDpcsFC5CqgwVNSwyu76Qv5FpyZoDK3HmGTpwP3N8FC6/1SFzZ+Ws/8NIPWLzscMHxDRsmOTP5bjMBAVHVb80yxcZhP1NWxAcWsfbqsSH88cQ7122hMyPoZvxcN9rj2rdlB+OyuSi3BB1VO8phTMQMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Tue, 13 Feb
 2024 21:51:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 21:51:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Feb 2024 16:50:22 -0500
Subject: [PATCH v4 1/5] PCI: Add INTx Mechanism Messages macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-pme_msg-v4-1-e2acd4d7a292@nxp.com>
References: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
In-Reply-To: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707861066; l=1631;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pajLHGu+pjoI9EU+H1bgcTzMS64qjiDozYPsqoeYdBU=;
 b=ByMTiEbf+7uN8FadYgv3U6VCoxZ95pb3iJmxGYDd1XrRbbyxugLlroEF/3JX7zeAUH1TLEDNV
 /v89feX3/nsDrVhAZnEumb9+wYW/bSAAkr0caDHbPgDNyhkbkIAKw/j
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdd61aa-c268-4c93-b3f0-08dc2cdde686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xJSCUtmR9PmxiRhR/6d+PX4WZXqG5/JdeePYd/sDUM1fbANG7if+Tbr2btSiYAQIt/EY76SbCjFVftQle5S1JsUNyQbEviAp+1ZlsNAsmc0NeF+LqUiTRMd7XcBSWt+3R4or0XuRoC6Qb7oAlNmPnH3PV0uBa5CrKQ4Lgr3teHS4q9ceejTWWxS2hn+xET0Tkay4vx1Gfh3hg8XMmZfaVaLUfhxKGaU/qCdqgGqyZ9i7B9nLTY8MaUOa3zJ9+S2I2Ktm0qBAERQOhqAdjcvEGF7DatnVu3y+l5ggbEbAWq32sCikZ/wMwHHxLQv48ecIaXZGsgngEfiQZKy7Yr5p5kmpM3hfYjhri5n8OeEA2QbGqRvmzDDeA+qDynKgm4d/QT4PTZW/Q7+HbJp4Iww70K6rWD7542ZHNmQJEZ9N8pzyBOnOnK7TqHi52Er7z09YYpeHtcxtVdGaeBlX1NJvnR6AjXIWdveO9fMzPs83F0N5ruDNlMlrs6Dl2f4UPnCi/AqgY4stvMLi5Bpyp8z7dfxuuQ0Tu0tug2O6mQo03dqkJfKacpJJ9ud+yoCMehp/qhnpKILn6k2Z+LkkrZiXzg9fGO/s0C8epIWhqEQYUhmz1EJ9hIr6nVe0KkAn78nbkSwY+MmUSGjiddniHZBqgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2616005)(6486002)(478600001)(6512007)(6506007)(52116002)(7416002)(26005)(316002)(54906003)(110136005)(66946007)(6666004)(66556008)(66476007)(8676002)(4326008)(38350700005)(8936002)(5660300002)(15650500001)(2906002)(36756003)(921011)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWFnam9LV2xCdWFOSTRhMW5PZ0xqVEI0Tm5GNGFZTjZyWEdLaWs1WE43ZER6?=
 =?utf-8?B?QWdLOVh4MnlHUnpOM2ZSOWYvZGR6N0tFbDJveFFGVExYNkM0YjlUNFVmVy91?=
 =?utf-8?B?K3FCNVNPL3BZbSs1V0VQWkdGMGlYcFEzQkVBY3N0cFF1ZWZiU01DRWx0RHgw?=
 =?utf-8?B?bDl5dlVycnVnQWF0dEpqaFM1SmpZaFlna3o1SUYvS1BONkpZZ2pkdjJRZWU2?=
 =?utf-8?B?azZtVGZJeng0OTZva3o0ZnNzRTRvWTBYbW5tQVpob2xhYWFHQzYyU3l0bDJV?=
 =?utf-8?B?RVorS28rSS9keGRzd2ZRSkhxd0tMclpBWUF5ci9vaTR2b0pzMGRUZVZKdmRh?=
 =?utf-8?B?SDVMdklLMGxTTVRQWGdnWDNTUnlPZ3NIYkJqdyt2RXBCZG05QzR0UjJ1UFV5?=
 =?utf-8?B?Qk1oek1iZEdrKzF1eFY2VlZuNFlmaUV5VUNQelhVenBsSjdBWjZuVHl1ajIv?=
 =?utf-8?B?R2NIUGwwTTZ3YVE3NVh2VThVeDRZT3ZnaVduUnMvQ2JGeUtSK05EQTlTUXJQ?=
 =?utf-8?B?TmZ6a0NvdysyODZvSU1JdkVGK0tMQnVXYy9YcEVYTVdvNkJMb24xUnlxbGhy?=
 =?utf-8?B?Zlp6SVBuL25kWmVRTXgyUXpOc3NEb1R2d05TaHN0ZC9MZEVZYTFiNms1WkZp?=
 =?utf-8?B?dW9idUdvK2dicktPaDVLbjFjaGpIZE5pR1YyNExXZ2QzMUduN2NVaUJ6UjZV?=
 =?utf-8?B?bzZzSExpS3cva2tCRUVxNXZESUVpVEErbHlGU0V2Rk4ySjVqSzhvNFBtZGR3?=
 =?utf-8?B?TFVkaHZoYzB1TTlOMmJTRFVOZHcxeW5hQjhld1F0bS9YWW1Uc1FoYXJlT0JJ?=
 =?utf-8?B?VU9meUl0enM2UTlUQmNuNm9kemY5aVZOdDdCblY3ZjUwUm1hNUE4eElOZytx?=
 =?utf-8?B?TkxQRmo2RHBIc3lZN2RMVHVUUEROSEQrb3pEN0g4SHFjb0VTYVJjbysvZ1cr?=
 =?utf-8?B?akJxODI2MFBwb3lzNExjQ2dGd3BRSEFGNkt5MnNsSkNJZWtZMlp1OHdrUkJO?=
 =?utf-8?B?QnI2ZnFSZ1Vmd05KdjBkSjBsb1BDM21peGJDMHlHYjVYc0hRcHNFeUhsbTNV?=
 =?utf-8?B?N0dpYnhsajJVdnova3NvbDZVa2V4azlqYndoelZNOHF1aFZNS0JObncrd0dN?=
 =?utf-8?B?a01waWU2V2EzbjY0TERhSEdhdEVUbWd2QVRyL3Q2S1RzVjZWOHdVV3ZrblN4?=
 =?utf-8?B?MGs0c1k2S0o1RDZ6N09VZmJ3bFhDVHJrTHdvTTNDKzUwdnZmUzhQdHZkUE5h?=
 =?utf-8?B?b0xvNXlaWWFkeXEwMDRIcEI5YlBVcVg0QTNienFjWG5kWXA2UUNaUXRKRlp3?=
 =?utf-8?B?RUV6UHMrVzFiQlZtWFBUbGpMOHBzbDV4anRyWEdmU0k4QXhrb2R6NzhWMDlM?=
 =?utf-8?B?T3BVM2tFK2k0RmNzUk5VNjRkdnRTbFpWeEhRQzNaaXdaUm1VaTVQcHZ2WWdT?=
 =?utf-8?B?UDlZcFNQQUZONm4valJ1ZVpDY0sybldkZkFVN1U4M1NINEttY05rNzhBNHBM?=
 =?utf-8?B?K2YvcWZ2SkFyTElRT3kyKzVVcEt3K2Rpa283V0F0K3RFUC8wRjZock9mTGVR?=
 =?utf-8?B?aXR0aStyRjhPbW9OODZqYkZLNDYvajFaRmJid0ZPTUlHOUR5QTJZcE4xcWZE?=
 =?utf-8?B?SndsYVdYdWgxVHM5Tm0rM2JYcUtVSmQxUjJ5TzV3djBjZDkvNnZobGw3RUhK?=
 =?utf-8?B?MjhKbDlGV1E5eWpZbVEvTzJRdmFGNVMyOGFaR09WQUhZckZTSlp3dW5pWUV0?=
 =?utf-8?B?U1h2V2k0dFZwbkxzNWNocU1PNFlsYWZLNG1JeTVYOVZoVS9LRnc3ZUJZWHFB?=
 =?utf-8?B?UStqRFh4VVQ5Q0VyYnozTU5xRTlVU3JWSXBCc3dzS3YzR3ZLTDFNalFZZ2Fy?=
 =?utf-8?B?YWt2TU1PMDd5alFkTlNTK3o4cUZ2MU14enpSMitlT2ZLRHpHc3BXUnhhamlE?=
 =?utf-8?B?OHR6ekM0Z2h0cXd0TVNodnBOSzhoM3YxMXlQNVl2RmQwSjhqWDAzSmEydFJC?=
 =?utf-8?B?Q2EybHpoRmJueUl1dnp5cTBoYjFMZVB2MmZZYUVyd3hsMGlOQ3lkWmppa0RV?=
 =?utf-8?B?dmxDY2JYbEdXZTZEeUxDRzZXK054ZFVnemk5dk5lTHlCV3NJNHAyNVp6dkV0?=
 =?utf-8?Q?iUsp5UaQcv7U3bcCk2PrvRf5A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdd61aa-c268-4c93-b3f0-08dc2cdde686
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:51:14.7640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54PQ6fnBmSaQdWq8ijRqfscGx3EevvQiO0xhu6+EcXOaeVwMxe+OAR83OP9Ox8uTMP29KUv5fcROGYJccq2r+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "Message Routing" and "INTx Mechanism Messages" macros to enable
a PCIe driver to send messages for INTx Interrupt Signaling.

The "Message Routing" is in the section 2.2.8, and the "INTx Mechanism
Messages" is in the section 2.2.8.1 on the PCI Express Base Specification,
Rev 6.1.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab2..ffd066c15f3bb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,24 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/* Message Routing (r[2:0]) See: PCIe r6.0, sec 2.2.8 */
+#define PCIE_MSG_TYPE_R_RC	0
+#define PCIE_MSG_TYPE_R_ADDR	1
+#define PCIE_MSG_TYPE_R_ID	2
+#define PCIE_MSG_TYPE_R_BC	3
+#define PCIE_MSG_TYPE_R_LOCAL	4
+#define PCIE_MSG_TYPE_R_GATHER	5
+
+/* INTx Mechanism Messages See: PCIe r6.0, sec 2.2.8.1 */
+#define PCIE_MSG_CODE_ASSERT_INTA	0x20
+#define PCIE_MSG_CODE_ASSERT_INTB	0x21
+#define PCIE_MSG_CODE_ASSERT_INTC	0x22
+#define PCIE_MSG_CODE_ASSERT_INTD	0x23
+#define PCIE_MSG_CODE_DEASSERT_INTA	0x24
+#define PCIE_MSG_CODE_DEASSERT_INTB	0x25
+#define PCIE_MSG_CODE_DEASSERT_INTC	0x26
+#define PCIE_MSG_CODE_DEASSERT_INTD	0x27
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


