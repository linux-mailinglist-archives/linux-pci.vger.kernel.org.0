Return-Path: <linux-pci+bounces-23373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229F4A5A4C1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3187D188D962
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE11E6DCF;
	Mon, 10 Mar 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CCVuq9b/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CA1E5B6E;
	Mon, 10 Mar 2025 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637893; cv=fail; b=sLrSFeD7jg193lKB+lygof14HoiZ9oAJEWuGap+UioA4UAYx45+xM2c3/LqzfypJIfwZr4+n8JFahcEjmS43etTw/+kWnWzMUI9CzrKFApvoYfyAcqyza3UhP3/RruaEhlwOvYHXvlE6hMYUWhNgG3o55MQ/EQ3xL6fL9GXzmXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637893; c=relaxed/simple;
	bh=98mr0hEDlbNB1twO9eEomfVdivfO7N5yLVSVflAGipo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SgTgVNKx5uD74KTSDtjr/KTiZD0ghMLwq+guVOcPs93LD0QJkmycUf/1YqRiG9Cu80y+hhkDhrI4JzEWI9mrWX5mwm2My7eEOqUA4yO1yEMAg9xozN3GKLD9L4ltHIisNn2y1iCFC8+9GFSf9tYgYs/t6BcftmgRXdnkJV1cX1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CCVuq9b/; arc=fail smtp.client-ip=52.101.66.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wEnmi4JqAgnW6p2wSKQk78aGKnhz2KQIy4MMvK6G04tv7LCc4dj9De8YcbqBBf/EeZ9KEz/eR0frvL+GNZ83AXAM2mtMkZe+73Ktk2o5zYyFsuAXseDIvWE9c3xTqLAtG+y6c7yhccJQMc1J1dFu7rt/Vok5EUyJc5kDe90Npjho3nU+vY/3oxzGHxvmH04yRzcjkiNQ6DSnLpc0VTA+9jEprWF9PMdWDFvbYMBcRRIepF0qPEDRA+qCc831tJatmzyYN0v4KJB+tRswluRkJj0FEjcv46b1qf+Lc/psyOgwk4DM8ZWqzq9J3//jbRKw5f+gJppkbdx/pYfzjyCUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBW2fAmfiSNKUGb/8tkUB5oukqJc1J6cu2/BIg5Rkdw=;
 b=UqcMVK8YA8Nhzm5hCKWdUFVmJk4C+TdGALZAk8EXHVM3bZYocMSIHbRbvx9BrjWyKBJ/MyIOYxwXoRPmDGSn2MWRACIiZRoDD98sGhlKKBb0Oo+XKVEmCjwQ4wDdCvNDG3qXNjWCdP+1/VNdI6VRxfycmHtw6usb3kB2ClXjI0ILAxCBn/Cc6gzAjIf6n17FiAiGzcfS5UW3BJh32W+x1DyjfjNS8iqeDhn+BQ0VKA6+OBJHhw4/WAfGqRKGVY+o5UhOGEGfMeMrDJp+Ht0QOGoyuldF6qqMMTV9XfwoFqzYT4ub8GK6SzPgrPNDEUrAmtEN+KgvI0ytvm67hru57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBW2fAmfiSNKUGb/8tkUB5oukqJc1J6cu2/BIg5Rkdw=;
 b=CCVuq9b/cA5ItzYF7DJoE0+QHGAcYVLORqZ9dU2ipfqCj6wP6ejsIpzZTEdsc4e283nMHjHFmvUR3mgFvSXrIFQ+eVi/XhmhtgvFbjiCh6E1fuXQkSozPouEpSSd9ZKRDhPI/Ofzer3Em3Ek+9oqPkg9JQ3Mb+6RCtCrROF01MisgC1voQNn/fwptQ/Mg08bz1pJQ/Di2Ovzb9eJoPhR2PV8kEnb+Sx9oHBZtmR/hyqj3MBxxjU0l0XgK1FJB8jEKQZ77HUyAbNr2oQKoZBok0KgnA1Tg5H+AbKkTNC+Iqotf/kIYPJ3vwvo5nOQtuuei6bjn+BTC+pBGcRjCU1gZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:18:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:18:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:48 -0400
Subject: [PATCH v10 10/10] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-pci_fixup_addr-v10-10-409dafc950d1@nxp.com>
References: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
In-Reply-To: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=2220;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=98mr0hEDlbNB1twO9eEomfVdivfO7N5yLVSVflAGipo=;
 b=UcMJDdXUszV7GESUyUPsgL17MLWzwHSC4V+uetF59Ju0+JhfslXCaMAya/Fqrt+sY1bsAofed
 f72Lyb2L4GODjjLG5Sb3yQ9t1dn1qyPpLjCGZ6+kh/m2nlbRMKCUkDT
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e751f96-6dfc-4ec5-b965-08dd6010ac29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjhFcStZRERaWXgzQkd2aTI4d2lNU0tWWUlBbjNBeWRsNi9jU3VWeE10VE94?=
 =?utf-8?B?ZDUxWDNNcnB3SFR0Z1ZpSEhEdklnNysxK2FMMlNEcXFON1NjK1JlTXY3NWVD?=
 =?utf-8?B?MXEvcXcva0NicDlZUzg1bWYydTBNcUZUd29rdmRFY2t0ZWMxcGdzZE95bXpw?=
 =?utf-8?B?L1hlU2J0N05XSSs4RzF1RDRwZGNqWmRSOXQyci9ML2dMMGN2M1g1eDNsVVI3?=
 =?utf-8?B?a0R2NzR2dzFtYW5WR2hERHhPYlpVdDcxeitsVVZOY2xETzg5eHowOUpsdTht?=
 =?utf-8?B?YytUMys2VUlEVS9SaGV1OEJnUE8zZXRVdHBiMEM3RGZ0c0hRdXNlOVM5THFH?=
 =?utf-8?B?Z1lmcVYxWGFOTy9oOEV6c3M1NFlLb0dVeHJNWHlmM1NPVGI5NmxPZTlnMHl3?=
 =?utf-8?B?OE0rOG5FNW1jZEhXRUxkc2hzYUcrQTROWWFxS2RyQVpEbXNSZWQyTFNQbElq?=
 =?utf-8?B?WVYxOXZGSzdRMnUyLzA4ZEo5M0RYSEpITXpwOTJBZnhpMnE0ZGIvSWcrRkpI?=
 =?utf-8?B?bG4rNE01VXo2MjlYSS9FSVh1VWVrWjM0U3FhRGdaK1V5RGVTT1BLenNNb2Ry?=
 =?utf-8?B?RTRicEtmWkpjVURnaFd0dGQ4bVpNVWhjQ243MkoyS3pmRlhaY0pQQjFPSHgy?=
 =?utf-8?B?RVdhQW1sZGRpQUxqdnM3MHFKa0pkM2FROGwzV2o5TVYySGE3a0M0OFRhdVVp?=
 =?utf-8?B?Qmlhc3NURFZXWGo4QmlSdWphMzMxZ1RlQzdVS0hEVmljRXIrSVVtQ21aUjRm?=
 =?utf-8?B?bEtVMGtJOEtRb2g4QU1JQmRMR0E1SVdzbnJVRWhLcUFRR1FBSVZJbGdYbnNW?=
 =?utf-8?B?cU1WSVR2Y3Z0RktRNEY5M2drMTR0aEN2MnZTVEY1VTNQUmlDYXg0ajYycVdQ?=
 =?utf-8?B?K092L3lKSFZ5TnpNWkhSc3k4OXlTTVBpeDhHZlJLSVdEM29rbHJIYUE1ZzFF?=
 =?utf-8?B?SVJuTVk0SXAybnhzSU9zVlZTQ3M4TGNaZnlES215cExNL202KzhzajBZemJ2?=
 =?utf-8?B?ODVlNGlMeDRNK29iQ1pZbXhJQktVVHV1STdXZTN3MHdEN0JkVjRUMzJnd1lZ?=
 =?utf-8?B?bnlHRjNKYlMrNDdIam1JS0NMQXVvVzR6QWExdjlqbjNxZXVBUXZTYlQyNkRr?=
 =?utf-8?B?WnFyZzU5ck9ockg4R0FZclJ3Mm5WUExldHpIM08zR3pvRFlwUFp4Ujk5NTdP?=
 =?utf-8?B?WFhScnQ1NkFkR0o2Uks0WGNoTkpCc1lQbG85STVlZmVpNHpTaGswQ2VJZGtr?=
 =?utf-8?B?dWlBaWlxaEgrOWxxck5sVVFEZURkVVVyeDdqelBndGRIRDdtMVJISVR6dzFk?=
 =?utf-8?B?aTVjbC8yZTFVem15dGdTWDBJdGFBamE1N1hYUVZVSmxra2xGdy9mVDAzZHdl?=
 =?utf-8?B?TGhlcnlSRjk2S0Q4cTdnSkkraVlDS3BVcTduSjJnTzFlS1Qya3J3YWVVN01Q?=
 =?utf-8?B?Y1NVSFdTN2VOR1NGK09FSUxpbUNETWFaUCs3US96Vm9wcC85Mk5Wc1dWY1l1?=
 =?utf-8?B?Ny9uRHhDYW5ReUR0RDNzMkJIWjU2eGVoUE03MFhHZHhlc0V1T0xscW0zT25H?=
 =?utf-8?B?Tk95c0ZpMmdKSUNsTTJEZUwxNHJTVTIxUzE0Q0lyQmFHbHJWNHJPU05qUDJS?=
 =?utf-8?B?MHRyOTJNaGpCc3ROVHE5SmpSUjlBSi91NlN5OFd1bGpVZld4SVRkZmMwVzZB?=
 =?utf-8?B?ck04K0hCRlVOMEtQaWQzVjY5TTRDN2pFelAzN3NlSU04aGVkZzlGRXB4Unlt?=
 =?utf-8?B?UzBmUGxzbHVMNHQwRmVFVWxmMytqMXZ5WUdjR0pKSWlzYXFOaGJNcHJiU1U5?=
 =?utf-8?B?QWxrSlRpVDdMZDNwTTBsdy9rTGpLVHk3dGMwNXBCY05MTCtleGZncWpLcVFB?=
 =?utf-8?B?OGJ0TDFSL2pRSHhsRnNlcDZ0U09tdzk3ckRGWnI5KzlRM1Y1K1BBbWlsUndj?=
 =?utf-8?Q?5Q+US9ShoohYtEpO6iKftmd0fiv3ohqf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlDb25yaSt4WnhrbjV0bmJmSEFleFNoN2hkUUNRNG8yYVFrczMrTG5NZERD?=
 =?utf-8?B?U1JBWVZ6YkEzT0MwdllpMEorREQyS1MwdTI5SEJnY2pEVHNJU25kZ3ZmakJO?=
 =?utf-8?B?eEVQNnFYalFBSXFGZzJnSEwwdDlYNVhGbXJPVFNTd2l4RFo3OUR0NTRqV0Rp?=
 =?utf-8?B?Ym0zY3dHOStmWmdpOE9TcFBlYzJhTFdKa1kwNGozM1ZoRlNFOXorUFEwT3Vh?=
 =?utf-8?B?d3plN25hWjdjNDlyYk1pdjFmR2xlNURDdnQyM0xrY2J6UkpFbEVPdHJzMUFq?=
 =?utf-8?B?c2lmRUdDY1d6SURvOHJ4aUt2aTlXZldtZWpKZE1ISThRU2t4YStLN2hSdUFM?=
 =?utf-8?B?Ung0OTdtRTAwUnVKVk1maktaMnFVVWtJcldyTDF1K0FLeklwR3NXYW5DeDR4?=
 =?utf-8?B?eW9KUG56TVJUMFp3ZTJhRDVRTHZ4K0xHQVErQ3NFVjRPQmQ5cDZYRnJULytS?=
 =?utf-8?B?aFhKcktEcTdMb2ZZZjY5Yk9jdFh6aFZsZHh0U3duK0Z1SDYvYlJ4aUJTK1ZL?=
 =?utf-8?B?QXZNd08xRjQ1VXg4MHVHZXFGajA1ZUFUdjh1TjhONmlMYWVvSFNuWFJVRmxX?=
 =?utf-8?B?RU5IUTZWZXZMNFpCVlF5WnJkNnA0cUJzVmdaOVExMVBtYUI1dVk1SSsvbzk0?=
 =?utf-8?B?QzBnbWVwVytxZSs4K2lqU3pGWERwM2xkb3NUTnEyVC9MZ3dYRWZvZEV5a0FP?=
 =?utf-8?B?bkNOQXdzc2w2ZXlqeHFQYU9XYXY5WTlMeWVwNDlpUzlwM3diallyZGdPZDZY?=
 =?utf-8?B?TFNnMEdSYjRESkVLTmlkRGloREtRWmJScVBjTUl2Uzk0VC9YMUM5YTdFNWE0?=
 =?utf-8?B?aStXd01VWXVEMG55Nk1KbW5NcEhRVWpnUDhheG40VnZkeTdSK2JCSVJpUDRF?=
 =?utf-8?B?b1Q1b2xYQjBUaGxYV3gva25aQVZxa0xKOTFOMGxnOVJKWUU4RGM3T0VPR21r?=
 =?utf-8?B?SFdYNzVWQ25kZ0RMQTVqUDd3eE9OMk5DMTlXV3Rudi8xNi9XSmprUFV4eDdr?=
 =?utf-8?B?WlQ0UlhGZktrMUxYQldLaWl0cXA2cWNxcDJSSTU0RjJwYTVzRmdYM2ZLTzAy?=
 =?utf-8?B?OHRJdXRUVjNmMHZVNGw1U2tyaFRKc2FYbXJ1UTVXWnV2NjBxMExNM05UblJi?=
 =?utf-8?B?YUdheDBnVVd4TzZoL0hJVVNXbTRXUVc5dTBmTWhFT2psZjNaY3B3VXBRUGla?=
 =?utf-8?B?akNJbSsvRFZSNXB5L2hqczdXdnlyQmU2UVZFaVZTVzdOWklYdzRwV01KRllQ?=
 =?utf-8?B?TlI1aUdvNnRYa0tTbnZiU25vSlNOQ3dIMzdLTW9MbmZVK3RzWEVrcEQ0enZS?=
 =?utf-8?B?VnEvbzlFUnlMTjJTd0tnT2UvQzROS3doUmdoNERWb3FzK20wblBNN2gzSWNi?=
 =?utf-8?B?a1EwV0xnSzl2aW1yMXI5Tk5rVnVpTERlejQ0U1lLOXdSZjA0Sk1ISmg3cFpp?=
 =?utf-8?B?ZlRHV0pCZ0o1RCtJaVBjaXNCczVTcVVyQ1BRUUhqcXdOYWwva1Rmc094SGhQ?=
 =?utf-8?B?dnovZDlTRWZzK04wam5SbENxaTIzYnNpTWtZZUx0S1FsVjFDdlVCUUJEeTR4?=
 =?utf-8?B?dzZEc3NRMXN3aVdVK0Yzd3p1dmxTcWZpUmpxelBJcXdPV3psUUd1b21NcnBp?=
 =?utf-8?B?eHNXSGtrVlRYc0V6d1E4VDVkWDVVbEtlaEJGV2FuYUhVaER2UlovVFVqMXZ4?=
 =?utf-8?B?T1Z4YUxWMmRqTWlGQVV0ZnBMY09mQWRSbjZwZEdDN0ZNU1lGYVpvOG1XYnpm?=
 =?utf-8?B?RU96czZOQW9vMUROdXEvNm1VOEFwWXpBVFl3c0JURitQK1hobkFpNlkwNzBp?=
 =?utf-8?B?QUl2bjZEWHZHaVY4MHdONkh0Q0ZmZHRUWThiTkpyaHFyUXRBNE5VUDB3RGpq?=
 =?utf-8?B?cGpjYmRhY0VzMnhLb1F4MHYxRlg3Qit4ZURNWmFiL0N0WXRxZVh0ZlZJTzBM?=
 =?utf-8?B?amY2Nkdzc0VNcnJ5SFZnOG1jYXVqRm1LbzVyUTNmaUhxV1B3WSthQUVNTkZC?=
 =?utf-8?B?RkgzTXBoa2lKSExpaG41a0pJeTMzT1dEeDR1L0dtd3drcExTaHJiZkYvaSsz?=
 =?utf-8?B?Rnk3MHVjUzg1RHFBSzVlQ3Z4YUM1YzNFVzdDb3B6RGpxRE1oUzE4R2Y2Snlu?=
 =?utf-8?Q?lqrFBniJLffUKccfjIa02Hi/5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e751f96-6dfc-4ec5-b965-08dd6010ac29
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:18:08.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbpO/Urz8QPyGfPoRgtCub7b3PhXUx0k0UZSgPNOKP+7kLSdY5zd447PTaEtt154vPKkfJ+AUAfq2YWSo+YHVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9255

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v9 to v10
- none

Change from v8 to v9
- rebase latest linux-next (close enough to v6.14-rc1)

Change from v7 to v8
- add mani and richard's review/ack tag
- use varible 'use_parent_dt_ranges'

Change from v2 to v7
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90ace941090f9..d1eb535df73e1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1217,22 +1217,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
-static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
-	struct dw_pcie_rp *pp = &pcie->pp;
-	struct resource_entry *entry;
-
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
-		return cpu_addr;
-
-	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
-	if (!entry)
-		return cpu_addr;
-
-	return cpu_addr - entry->offset;
-}
-
 /*
  * In old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD in iATU Ctrl2
  * register is reserved, so the generic DWC implementation of sending the
@@ -1263,7 +1247,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1645,6 +1628,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)

-- 
2.34.1


