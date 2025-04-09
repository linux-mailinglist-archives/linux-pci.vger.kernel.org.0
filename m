Return-Path: <linux-pci+bounces-25574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD52A82915
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574E1176D15
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B82673A2;
	Wed,  9 Apr 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="D6budtVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2122.outbound.protection.outlook.com [40.107.103.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9628A266F1D;
	Wed,  9 Apr 2025 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210188; cv=fail; b=uKGhGxXXlzP18SLg/8kucdk0uGZXbY7+x4omZWmbzzLVQ74ie3oVT7VupFJar3SIX4/PxxEdEqcciGm/LIMx2PevXYbu/XF5ywYR4ApetOH2LsAUwdclBiQOoVlTaJSxMlO179g6J2NpF20OuDNpqYWJlMMg8XF3t5Z1BYjFp/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210188; c=relaxed/simple;
	bh=tD21dCKlDyuTG9YxVS/EKuQkWyoYresPV6qbUpheQWY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=ZRCeBIco9Cq4MOJms76iq0+9aJvlSLsLK8rUdcWJC6kuHGateSl52my+Q/laBVgC3KCoevHBSk1cZaDpJ2b/+xDZbwm5z6+x2DMNaXOn2eQCRkseKeFgM4GZtNqZIAqOJ/1VRNEhWAF5Rl+88DMeP8PO+eOF6twBIvs3yf4mBxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=D6budtVV; arc=fail smtp.client-ip=40.107.103.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUH0I5RvU9D9cwHTpNurwCEJAQcor1iRz9zRgvNgzNAytD1YDePrWpnhXqdyq4BhK1K1OtLgPW3OenEVYlHFft5sTZSbmEHZz7RNsifAVfl6JPkeQdf3gKkLpAv3daUMTYSqd1C9WZJW+Y05FfXzVUoWjvru2TOG6lYW+dULU/n95aZWbT44uEMb1CLfHNtGiQ/C1iyd+A4IW8yLcBlOWXflePoShbadOuMSjGu8aHa0Hl8Tj9b8BqSVleXod2rpXib1362R7u3yYAMmZhw8n0/H6JtRqvPcgS1d7o8O5cgOfrT5TGg+14ILzERbPA1md6IxN5dOlxPOPM8xBbYpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e14WHygYEIx2z/myUUSGtjuD5tEozC7eQUDOWClsPg=;
 b=KAjgLEBSfeOPWU2Lq+lMuhlTJnABQdBTy+wnE0N+2wtHbOj5S6HudGoNE+F1qRVoUg6F0uymUKrz1n7ULmw9QhWIh4m5LNnp396X7tl3a6ct4/SDQGqPdYjCrRz1sKoDR+9SkS/rvl1vhQBlzonqF+TqPsgrmIN6j/p575KMx14cxkdQdEnLm3yfHZv5V0CKgCdTg63K8qlQyiKL0PQelogmOTq3FeFUMH3k27YZxYFe9i0PRrQW9dlgK8ThU48+eEPRpep1gj676mozwfzniFfbEbUcljkt3Pmo/Xk88EnMuPvZuz8NRtKVJ1QKGo5LWygLSs6o+w9EHMu8WE7OnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e14WHygYEIx2z/myUUSGtjuD5tEozC7eQUDOWClsPg=;
 b=D6budtVVhLCbUk4xBIFQICGwRjEce6inEalBVyWahpVdp7/N1KIDQtVlKCasfekEHf71krmqlxwwpZWBwOe0oIJXKujyTuwf+ruAJWvPxtftf8DpW4WGx6C3l3NFsuMO82BS+X0a2PvGUAmFjPD2NvMIKzOTOL2IceF5h4h42KVEC6WvkLGag2beXS/lBu9BtXULGfss80PAg3YV+cACu6GwOA/Lb1RbtORLItLVhFiVD+fXRXTzhO/2PqmaZMN5p2uZaFCY4uAjXgjlZdzn044+fkbK2idLjZopbHf4RzuFzAL1/xzdJ52oApGEox7PRaEm93HbGIIbfs6oK3xT6w==
Received: from DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) by DU4PR04MB10840.eurprd04.prod.outlook.com
 (2603:10a6:10:58a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Wed, 9 Apr
 2025 14:49:40 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::7f) by DUZPR01CA0008.outlook.office365.com
 (2603:10a6:10:3c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Wed,
 9 Apr 2025 14:49:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 9 Apr 2025 14:49:40 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 09 Apr 2025 14:49:39 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM0PR04MB7155.eurprd04.prod.outlook.com (2603:10a6:208:194::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 14:49:37 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 14:49:36 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pci@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] pcie-xilinx: Wait for link-up status during initialization
Date: Wed, 9 Apr 2025 16:49:24 +0200
Message-ID: <20250409144930.10402-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM0PR04MB7155:EE_|DB1PEPF000509F0:EE_|DU4PR04MB10840:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b2efd8-53ea-4f05-c1e3-08dd7775c1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?OeqqdKfKnZUFCJmm1XnqiNCjdCNCRlpAllaTQKInab5C/0f5oW5ccuPMml2e?=
 =?us-ascii?Q?4/IdBHIjdi/LnyALVdOA1owRNd0VfkuPEEV9YH+NDFJdUoOGcSdEk15+VDPL?=
 =?us-ascii?Q?BG7PpoWJSMhm7QxEeTid+IAbQxlPsPB/B2yo/2tXdFXa5qCFPDmrm2QDeC1D?=
 =?us-ascii?Q?sdvuBz6Jj94yXvAn8gHCe6mTtTZXtEDLaC05tbInw4xQcAH8kxnSmxxqJCBr?=
 =?us-ascii?Q?oNeDQvpCubmzYQEmLE5/uqjF4678PLodAwQhM36RkWUtfC9PlUPfWI4I7aHD?=
 =?us-ascii?Q?kstgUBPSg7MXtafVSloWZMB8tn+V7I1ucYSc3J321SI8iMT/iKkxCQCAjeOG?=
 =?us-ascii?Q?8Xr9AGBmtae+kRObbdMM7ncRtHebudQJpuq9wl5weTWNu6iLRa2W5JrSHCni?=
 =?us-ascii?Q?+Zr6BAqCWMKWgi5sRcmuhrWXHx39pQtnARHeRGUp9Y9pUKiL2PRAxqb3AA+n?=
 =?us-ascii?Q?XVdppMd8Jbw3awfBEZU4TspEcee37ngiPHY8sB+X+09bRxu6qz7UnYzJhpUn?=
 =?us-ascii?Q?pHLoOvWhsd/aCsjWbfnOr1eRUDYOpHuZJziTfbQovV18dttr2JXHUXVADunT?=
 =?us-ascii?Q?OFpC5LcxLRJcRZe2IessFDJ47qkcKsjSMXVnL9Q/DdvNrg+seg8DZnTU6vl2?=
 =?us-ascii?Q?Pg1bJ6ZViZHg3g4LIyBrFLFXzO5hTpfnaFmOYxQ8kiUPOBLKOWHRyA70TOcd?=
 =?us-ascii?Q?xciKkDwAWPfGcWDtgTcdcYC2tC9YaWUNXPoHSAZ/7Lpae2ZLUMnVOjYQSgxf?=
 =?us-ascii?Q?OB3CmsCPkhmYM/3srZhI+vAcWh6KK+/4344vjBvIVjuVsi8CAM0Cpa4lKUVb?=
 =?us-ascii?Q?9Jxh9D6SYKAnxtLTWSmp5zelPCkdSaHbXKXAW6jyo1/+gZphuA33UEPazZNV?=
 =?us-ascii?Q?VX++HqbyCb1TnKGHHxahvf90Tsd7zBzjYmY1VHz40heqUNmJyg36W7evrlhi?=
 =?us-ascii?Q?0KbxYMUGYc+qU8iGycMSVaSKIn7+DfqIjiE8Xkvny+WSpXiaXAwpzeUWnpoO?=
 =?us-ascii?Q?+AszGNM38HofsuRz+PFaCTIvrHEszLDYYYOs+NyDneMukIEvdq89Pq8ElZ9Q?=
 =?us-ascii?Q?fwlD7LriPM+/i630WH595dms5sHibReCJWSbM/7+sPjiAAgBbMi28GbO4ORh?=
 =?us-ascii?Q?bDu9inTaKXmWP23MqU7t9bD7/RT7Xw5/Wc3mliBrptnqyXiv0dmnj1qnQYaP?=
 =?us-ascii?Q?XSuEgjbVvxyq34ZARRWIKNbygkWrVkdlGAPwyA2fP7NxBmsyIF/74wQv84ws?=
 =?us-ascii?Q?Vk1z7vYh51yje5l3UgvDRNZNMxIdeN/6e52RVrUQ3h5iM2LdAdD9zhJG/XgV?=
 =?us-ascii?Q?OABz+HmjTfz/5XrmyPGa+o5bHBEXtKRuJDxRZF3xwrF4iPfOunvFLPBeZuuc?=
 =?us-ascii?Q?893dq4+7RwmrO454ZuztU+nXyMTjO3EIR9Yk0XkZ9qt0YGM7hmB3P/mtQEvg?=
 =?us-ascii?Q?2NolDHAwBMKAAMN8ykOGG53KhGRczmjdXTz6K+GuGW13dlMzzXYX3A=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7155
X-CodeTwo-MessageID: a5dab0de-e288-42b8-a640-180713b70c31.20250409144939@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.d67fd5a1-30a5-4d5a-a4ef-dde83ebcdd8d@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6c2360f3-94fc-4ad0-5d93-08dd7775bfc0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700013|1800799024|82310400026|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TLaEj91agsRv8AD6RI0pupH0CyA6F2Kk+B4xa+sgiYUAIKOPYY2IbEyAXu1P?=
 =?us-ascii?Q?H62aFWzGt9cnL88oQR0vpT6O1s+d2IvCvpvGGXFbiB3hWcUC4sKxDoLUQUvl?=
 =?us-ascii?Q?K5lshCxWn4AnpJcbzNh0Fz/ZCL2qGwzVSAc2u6or6Mm4isQyXkr0wVTS8gDK?=
 =?us-ascii?Q?7Y9Bi5Gb96lkQUbJu1HmxQWWnBfv0T0WoGkrlVqSjWfFAb3WXEQLRqESgP6m?=
 =?us-ascii?Q?JigpHSyuBNV0hEmBAXeHqf2/9ZubMPzG/th4fQTNUWtuZ9C/qawKN7Hl/Pqz?=
 =?us-ascii?Q?3k4x5dKHUv4wweuTfbhlbFbVak5K9EuSL71CD2xTYtIhja+hzvT7LPvj2ora?=
 =?us-ascii?Q?IwBe8QUm6ATGAUqYePMeu0BBmYV3TUzn1CKz5ysHj7aVj3U7e3jRgNGTphg9?=
 =?us-ascii?Q?vo1CPDCuGGuOVXpgISo8W0pLnX6K4eFLSZsC1SRm30yp7uMyheSZjGLrkr9T?=
 =?us-ascii?Q?MReUhlnVpNiqa0SAc+/KSNjRiaZ7RGJO9jcTnMZLi7UwFq7/yBjMdRQdIHQr?=
 =?us-ascii?Q?r8OmCafIMaDXwE7F6xoeUov76Mo9Y0TBsZN/xBI8A8yljtVUKp1uyalMI5wr?=
 =?us-ascii?Q?ByRhW2l3Y60qomi47xc3ExE0oVNdxLXVfWJQ9iakfKJVBNq+EU41H7lmnlpK?=
 =?us-ascii?Q?OrZDHOsddqKHcjXkTo5PAKU+2Q1QsYv4/ArZ7ZWTgDZsUefBKRP3yGd6uYyq?=
 =?us-ascii?Q?e04nIio0EHRfmNShUXe2ELYx4MWpj7JXWrWV+jNakqke4H8ShuDNP6Kxvil5?=
 =?us-ascii?Q?fuVAHC/PyQUxsrjNdEJb8zQQu9zfvI6wclix4f50vKkJWXzUAMJDOXP3j6EW?=
 =?us-ascii?Q?eihJOQVIDzl+eTDqXBtKgEvg5UbJvEy/1YtIc1VJL+4rSMvmkJx590vTxpU4?=
 =?us-ascii?Q?lSbeDow91jiq5oNVklPtCrtgQUTfKrzzRkl/LEQEoznTEXFBMdfreJmiltDE?=
 =?us-ascii?Q?Rupv+Ci8T9AuSE0VshU9MgzIHSwFAykIPuu4pLGl0PsqcKb11qfQJmAJyHA7?=
 =?us-ascii?Q?xRfSjyH98RFerisQ/qU1xzBS2K4lG1/vOIN2MwUEAkqQOfwL5RUa3sUkniBL?=
 =?us-ascii?Q?RwSuceFV9ghARVK1JzQRDNgq5d0GaEcsnOltWzxzq3blYvCpLcX8cqwSnGgS?=
 =?us-ascii?Q?qIIa0wRF7Tb27koXUT3PSNxSNDFUuBzXMqmI+eg3DrlNldOsYEjhDxVx8oj0?=
 =?us-ascii?Q?6Bih2QyUKf999blo7I66VPoyxyX43YFFY7YSN+zdMEtb50qug48aVqTJCUip?=
 =?us-ascii?Q?YQ03bRWoC3NJDNzvtqNWEMpYoG7URAj4B88D6sxJp4/OK2E4H5OdFmiEvdIW?=
 =?us-ascii?Q?hdr3Iujz2pn3wvxkhN0wvMio6uoseu369lRjV2AQf67MyGG/gVekZGck8YDH?=
 =?us-ascii?Q?q/y1Agy6sMNGrax3j2HrJh1/cmyohTfnJOdQl01LcypyiOszH0s2O0U/2pXJ?=
 =?us-ascii?Q?b4u84/uAxnUCkoagRv3K/amXnoW1mqQ8?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(1800799024)(82310400026)(376014)(14060799003);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:49:40.3248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b2efd8-53ea-4f05-c1e3-08dd7775c1eb
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10840

When the driver loads, the transceiver may still be in the state of
setting up a link. Wait for that to complete before continuing. This
fixes that the PCIe core does not work when loading the PL bitstream
from userspace. There's only milliseconds between the FPGA boot and the
core initializing in that case, and the link won't be up yet. The design
only worked when the FPGA was programmed in the bootloader, as that will
give the system hundreds of milliseconds to boot.

As the PCIe spec allows up to 100 ms time to establish a link, we'll
allow up to 200ms before giving up.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

(no changes since v2)

Changes in v2:
Split into "reset GPIO" and "wait for link" patches
Add timeout explanation

 drivers/pci/controller/pcie-xilinx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index 0b534f73a942..2e59b91f43e0 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -126,6 +127,19 @@ static inline bool xilinx_pcie_link_up(struct xilinx_p=
cie *pcie)
 		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
 }
=20
+static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
+{
+	u32 val;
+
+	/*
+	 * PCIe r6.0, sec 6.6.1 provides 100ms timeout. Since this is FPGA
+	 * fabric, we're more lenient and allow 200 ms for link training.
+	 */
+	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
+			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2 * USEC_PER_MSEC,
+			200 * USEC_PER_MSEC);
+}
+
 /**
  * xilinx_pcie_clear_err_interrupts - Clear Error Interrupts
  * @pcie: PCIe port information
@@ -493,7 +507,7 @@ static void xilinx_pcie_init_port(struct xilinx_pcie *p=
cie)
 {
 	struct device *dev =3D pcie->dev;
=20
-	if (xilinx_pcie_link_up(pcie))
+	if (!xilinx_pci_wait_link_up(pcie))
 		dev_info(dev, "PCIe Link is UP\n");
 	else
 		dev_info(dev, "PCIe Link is DOWN\n");
--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

