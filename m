Return-Path: <linux-pci+bounces-24626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7AA6EA47
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699F47A2F8A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 07:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92B72528FF;
	Tue, 25 Mar 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="cak0Uueu"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11022083.outbound.protection.outlook.com [52.101.71.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36419CC2E;
	Tue, 25 Mar 2025 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887130; cv=fail; b=Tzae+7+DIutvBTc+3teGPupDEnaCZweTakT8GoBPe5NSeHIVRjaQL+m8MsXKJW+0YCVMT9Cjq6MEvRB6EN+dU6AQHngR+kSdzEAgBaXHva1WFS7BwvS68LqbmAg8VtzV9K8Gw3xyKHOeAmIn10+NfSFnty7W8jYO07k7+9d7kVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887130; c=relaxed/simple;
	bh=8LrMiQNm+ovk/dvPZpNl1FPBCb4S8ihW8Kx3n1PPp0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gnhfjbOCCrMsH/6IRorlwtt9EwGVdh94+IFwa4e5Xhzc58kKA2EXRSK5cgLlt2zomxAZ6cbDOyVKPFq7crw+tSlb1Da6RZNNOWit/UGlomcQjVgbPNIHpwxcYwKODYWaA60XPQnCnYXIedDBBbCAGU56/lYK2lFqFMuVEvuT15s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=cak0Uueu; arc=fail smtp.client-ip=52.101.71.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMFcD42yw/1K1V61mH4jd2D5VL5migHxBNUZbMPl3ACI8kMn6syNt7zHEt/Z1wD81yGbxmBU6/9xweHl6dfBQwTchEoyw2E67BGmGLnH0gL2uCMudBrSfdVrW6nlwBgzhpDiuqbdBCp8Rue7mfYj0yFkOxYL0stmDGuZ+g0BWUoJPHB5t8PFh8gPIDd+J13ON88ARH4gev0J6ybPfe4F8e+M22bcI3OlIxnuUAJTrdzKMpCaft5J5KZP8GV9fprd+XAEZ953RO3o/euMmo5Byjo1mCsFtETdYzdvVlvqKcug3ULfpvQhTAC4qqFPlEE5DiJrh28/k+edxdDAUBSr2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLo9YkjZ15cy2YtMT5cZ8K1WsUZkZCMJ3QVG6afXiiU=;
 b=ZJJq6aXyIvgxPkku1BkiWLtDLghSM9OZ6YuqE/8SjbYKjLtN2Rn9vuxq9OrFfvJje9EbBCzyCnLQXrxruiovxcjkwqqjc67kzm2ivV+NXWPZIYBoRS0Dj+zv9S0+l/rISZHm2TPqohQmHrHbE0s4SskZmlv8PYMtTCGerTpSx4L9h1l1JkuWzXhrk24zed/2ZZVCff4m7SkNCY3BEyLgArNpoz/PzgvYjoZ0nnoYb+1/Ff1Vzo4ocben4khILFTkVcI7+SxKzpu6+g2W6EF5qY+ZxNROIC9Xp7SUGkVWtbFLeKZ2mlaaUQFrT4S/tqNF/TUYYCDqiVsewC4HA5QNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLo9YkjZ15cy2YtMT5cZ8K1WsUZkZCMJ3QVG6afXiiU=;
 b=cak0UueuwBtqxlLxIkLWpVZmA/Qw0nHkn11ESs4z/qp4TDubES5WLaSCTi7S4/jBjQ8Y5cRp5pncoMKT9FHTXuKQiu8TNz7vrEJDquH74kZv7AfD+xmnTfwxVf51f8Fnf2rYISc+ZmICfMMMNIOZa0qDJnq5+mUGgCfNKXT81iy1tzu5QWNBwJ2iwK0nVvco0M7qkw9bZNmxiW3DM11FePQ7ug2WFuhBYxlWcsrMwu7fW/AttyNcFuK+qDpDq2m6Nlucz+OXYKIGF8bjK+uF/25fYtuPZdzIdo9NT4IqJeJm665epYOPTvvB4DAv19ooWFgXXknmGU2fTymQL4klIg==
Received: from AS4P190CA0056.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::27)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:18:43 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::d2) by AS4P190CA0056.outlook.office365.com
 (2603:10a6:20b:656::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 07:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 07:18:43 +0000
Received: from AS8PR03CU001.outbound.protection.outlook.com (40.93.65.54) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 25 Mar 2025 07:18:42 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DB9PR04MB9353.eurprd04.prod.outlook.com (2603:10a6:10:36d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:18:39 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 07:18:39 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] pcie-xilinx: Support reset GPIO for PERST#
Date: Tue, 25 Mar 2025 08:18:27 +0100
Message-ID: <20250325071832.21229-3-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325071832.21229-1-mike.looijmans@topic.nl>
References: <20250325071832.21229-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f2f40822-7953-4b0b-896f-3a325392c185@emailsignatures365.codetwo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0013.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::26) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DB9PR04MB9353:EE_|AMS0EPF00000199:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cec0869-d94f-4613-0671-08dd6b6d467c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?PyXTpevlucM3fvcq+q3UOh+RWB6711Q2tvavSCeFW7w4Dqjr7RtOaRXK0tTJ?=
 =?us-ascii?Q?tsQCqlEU2yn4n0si93+IP4dJWmMQZwjh0jUQpJGL9EqTAfpDSEh12MQZ5qdY?=
 =?us-ascii?Q?QUjkxbC78qcA8bsUIAsRSOLc8oxJlRmnSzTpW8nsdJSwRphhv/P4X87Vii8M?=
 =?us-ascii?Q?WQlN8b+avj8/CatJUPw6d0cl2sx3gKwkQ7XRWhFMg79cbOa8Plhhzpj1ljze?=
 =?us-ascii?Q?s3MdOWtc6nBinmLyBgauaoV88m2gPV/GCIL9aqurTmxZsaTwB1kpcF0y7hAV?=
 =?us-ascii?Q?nAC2E1xkAktP5Nl+7VDnkt7nHprHsAAGFaQlx8DH2wT2Lec5+s8m08gDO+Uv?=
 =?us-ascii?Q?THUWwF7+189FGEnLG/KscQSQq4cLTQ+bovZu1nV+omAwhfOHF0vXWYsMZ4iY?=
 =?us-ascii?Q?HiiG7a+zPzUq1zDz80xJfAc5giiLqhVRrh3e+89ZubxtSy2yBWqTBcA6UccW?=
 =?us-ascii?Q?3LAd+mWg57k2PiwGhZ4iugU6111/PTkn+emOSl06SyTgldq8UnivfJjbCpo3?=
 =?us-ascii?Q?QIkY3LC9Q04ySrXo/HMgeBIKfukscVRuc+IP6i37OQEzHzzD6GOp44uhyew0?=
 =?us-ascii?Q?DyKtyhjYpgSnv4rMsq55i/myirL2i3/PnldJggFZvmORoqsVC4aiBgmYArdS?=
 =?us-ascii?Q?mbLpH7sAsPVSmaP0BPkuKz/Q4z6k5TFGkksl0Y2P6glqeqtgIHDgolM2feE4?=
 =?us-ascii?Q?A7XiU3esRJdhDsiCPN55Qau9Nsb6aLJeX9s8ca7m2H3ZLHoNx6NfaGihTbE2?=
 =?us-ascii?Q?KLFj+PqWY0c6MVb81OlrFvxAFYVmfdR27B8mpmygV9KjDQKW2AfUF697U0G+?=
 =?us-ascii?Q?uL2/3/xxlSKgIclWjKK0UN4uVSkyCWlNji0a+WLh0LRBwftmigUu+/OlGUru?=
 =?us-ascii?Q?sXXoYQpNEOmM5DU2NrmH8CyOHBv/W7MrqNB1SPvDY+LguTbIFYtjkncBTUzu?=
 =?us-ascii?Q?UCtmR3lVHgf99ESxzeWNPtF/wbKJANLqeCIU+po07DoaZgHMcRfHnoZAcNyD?=
 =?us-ascii?Q?huEDfL53DSZ3XWcq3DA/fT5BQ4TYQlVGJslrlPsrd5+70LrG5FJeNz4Pkk8M?=
 =?us-ascii?Q?oK4IAcoE6dPmt4vKE+AtN+6tJJ5xDUlQ57oss8tthRoBSNsgNQsc/8bS9Lri?=
 =?us-ascii?Q?kj+FbPLbWkZ1S4A85s0bODA4Q6LmKJFxF9T1NiH+012blL2+7OaYEBn5a4pB?=
 =?us-ascii?Q?y76P5I5XWSZ+mnMBSAGAvhwqotcl9B5vhcI/Mq2lrKaUzoLMyV6KpNkT+knI?=
 =?us-ascii?Q?QI+kbhUwgzjU+R9i84o5X380MdPUiw6Dt1Z/yGG3EDljEYC5YkUBwNcDeIKM?=
 =?us-ascii?Q?2b/x+aj75jCVmY5IaScbDduT9HzYcLNMMV6KUo+A9EvhRDQbHsPTh5eZ1d65?=
 =?us-ascii?Q?DG0ioRw9p/xxyCMENUNhuhoif5PqR6XjP7WGJ1GrOgIc9YekHc0T6aU126QK?=
 =?us-ascii?Q?Iy+E+PSIbBOWfPqriOdoUfY+bOp161wN?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9353
X-CodeTwo-MessageID: a765cc7c-e15f-4fce-965d-543a995643b2.20250325071842@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ced0a7ca-c9f4-47b4-b2b3-08dd6b6d4422
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|376014|1800799024|7416014|14060799003|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VuJeEi8wbVUmyTjjOU6bDsEE9Uoa/vBB2etqR0A+/CKChTfEoaC2yh3QeLMX?=
 =?us-ascii?Q?9s6hsfkmODMsgxchi8nXSUkvC8Cex5HvGlMATmZ09IQjsg228Ey0eabNuRaP?=
 =?us-ascii?Q?fWh6fdnX7ZsgKoEuDG75/rk9Nkvc3Gs2gFrh9u8eNxj/bhQcanlMF0Ds/xeM?=
 =?us-ascii?Q?WUPQEFGQns125/z5pcr5VOjuO/3UisuWkXyRLQDEBUcCzZ+7YYgS98+Rhcxx?=
 =?us-ascii?Q?EWTn688fkZBVnFaSid27C/Iolb2kpOix3cwpPiKY57IArRkl2zKDverRVI8T?=
 =?us-ascii?Q?rP5x+jRhCDWmcEUqnHpPkAqO7HGqKYk3y5K5rqUINy8ChIpt/4sBhFNoEyV3?=
 =?us-ascii?Q?TaySzqVpOZgowcJ9Nr9A8xvq++J4sxQhX/otRxLJRgZmNmZME+gq4Qnzfcjc?=
 =?us-ascii?Q?9c7x840id7bkIN5G3OTv1x+ACwYhnJcBYyJei7IgxWxU4uNBTsr0C5ul2VUO?=
 =?us-ascii?Q?PHtUYshigNjbUsqNIqcQ75mhdLsXFhPUnR/fW+DMo8yifjug4dD7GRyZ1Ptl?=
 =?us-ascii?Q?8M5jTG3ovTUusATdnsYqO2iY80Hfk4qeu+N4R38Jo0YXdIuG7ajV2pk7ys+v?=
 =?us-ascii?Q?jBM4j7ExzxtCfhg369SEkilZ/6+6IdiaoBsrNNqsG9kE2c99JXf1ansZEh4r?=
 =?us-ascii?Q?nbraZKGmspMZ87cP4+TXnshlL5KsDqGbJElU/gIwqBxvV1QJvq1jWpF4kGJi?=
 =?us-ascii?Q?W0N467/XqTO5UesszIi7pv3uAW0dGyBfdOUrs5ShnBuIdwj7w1DyneldaRkc?=
 =?us-ascii?Q?4WC8OoKZ+K9VZuLZ+XwDIOhMTgp7SUSVJA08oL4Wb6fOzNHvOs1Q5xBr+hhz?=
 =?us-ascii?Q?kGz3wXwDG5url/SZo1bmGzC1BPQDs7lEkq0hD/211li4sqS7NmRJ+G6UsiJA?=
 =?us-ascii?Q?+j55gu44xHPXyU7li6O2xHUjaHau48X2HGJaD0V7QhbTsXvOeyEw9Y61GEYS?=
 =?us-ascii?Q?lOsM7V+WtQIorn7np7bzBpFxyPUFea38UGCnnOYYhF9HVVr+IDR5hGNy2J+u?=
 =?us-ascii?Q?T3XIedY/x+f2NQkGkY5VX8JpxMWcXp7tXo8G14cMSZYJmZIIaZqvpewY56n1?=
 =?us-ascii?Q?jXNq3FuSUq2Az4s263k8ZNqm5NcyWpW/Jtmgmdt+pagtq/ZlG8i3aHG9pXTK?=
 =?us-ascii?Q?ff5NA6Z8sACDeyfgx0V2jBz8vI2bBBuIT7iNsMnz8f5dmjKxz5MMUbE0rcvW?=
 =?us-ascii?Q?+O2dW8JUBjeQdqeF9sewe9iC7Z7MfYQMKK/Re7hBOfKUs3933XEC/xCW9INB?=
 =?us-ascii?Q?8I5iL220NwodXNfiOzHzxXp2B4w4Al4HJUHBRro+EeJQGheKob44JKZFMfGE?=
 =?us-ascii?Q?SH3BhG+EqCPhFdLUJRNex+vvGbEgwSygYXh5Z3JAX9FCcd2dG1MN8QgWIfSM?=
 =?us-ascii?Q?w0ajEP3ZVUeKut/twTs3Y58yokU9FZp2tjx7tfVefpxa7JCFU8O1nWbbSDEE?=
 =?us-ascii?Q?kLjvn0KT/PU=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(376014)(1800799024)(7416014)(14060799003)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:18:43.4150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cec0869-d94f-4613-0671-08dd6b6d467c
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

Support providing the PERST# reset signal through a devicetree binding.
Thus the system no longer relies on external components to perform the
bus reset.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

Changes in v2:
Split into "reset GPIO" and "wait for link" patches
Handle GPIO defer and/or errors

 drivers/pci/controller/pcie-xilinx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/=
pcie-xilinx.c
index 2e59b91f43e0..e191ab95d669 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -18,6 +18,7 @@
 #include <linux/iopoll.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/of_irq.h>
@@ -577,11 +578,17 @@ static int xilinx_pcie_probe(struct platform_device *=
pdev)
 	struct device *dev =3D &pdev->dev;
 	struct xilinx_pcie *pcie;
 	struct pci_host_bridge *bridge;
+	struct gpio_desc *perst_gpio;
 	int err;
=20
 	if (!dev->of_node)
 		return -ENODEV;
=20
+	perst_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(perst_gpio))
+		return dev_err_probe(dev, PTR_ERR(perst_gpio),
+				     "reset-gpios request failed\n");
+
 	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENODEV;
@@ -596,6 +603,13 @@ static int xilinx_pcie_probe(struct platform_device *p=
dev)
 		return err;
 	}
=20
+	if (perst_gpio) {
+		usleep_range(10, 20); /* Assert the reset for ~10 us */
+		gpiod_set_value_cansleep(perst_gpio, 0);
+		/* Initial delay to provide endpoint time to restart */
+		usleep_range(1000, 2000);
+	}
+
 	xilinx_pcie_init_port(pcie);
=20
 	err =3D xilinx_pcie_init_irq_domain(pcie);
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

