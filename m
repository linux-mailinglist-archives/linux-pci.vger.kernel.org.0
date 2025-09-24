Return-Path: <linux-pci+bounces-36833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC1B98819
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391AF19C2642
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 07:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443C2741DA;
	Wed, 24 Sep 2025 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CVU6JFnZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49B27381F;
	Wed, 24 Sep 2025 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698634; cv=fail; b=dP142obRR/knkQNRj2encXnudYjtfeBntZZ+K1NAmBNmngRCbIc1P46/JGUHQcG7wcSCb8Ex+NZgWSpoEe1mdwFYM9DoO6I7kCNEidVuL1/Bq/oOReRp8MesbXmCosZy81bbDoX+BwWuFH8HkNhN1HLnWXz6rbUAO23DQYmaYvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698634; c=relaxed/simple;
	bh=Y0jtr7lqX7Ermy5CrVwI3qVIAe9ZjB6+6p3xLFA8LT8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MoypdRcNLrmBoTEhp1BeDVn9zQQq/bKlb6CJ0DnFUq4Tud5uQZyCtwInSyqlf6exwuS5n1UE/vIvVEawDTpX1NvpXLeUz1gGiPNzHpSS2CHP0lMm/A8Q0jegKsXCSgVYUV3W2nUh6N1scNEqCx3SJNGpZLLwD8+h9eHpeRtfbEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CVU6JFnZ; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXPgg6ZHtVitfgtOZa5otc707pMOg5xZVUyuo++ViyfC7LNzgMKeGqjtiVR+0YtjP/Dj+zvc6UrFy30Q2cwiM4hpJKcYsrXX+SNnMp14ZKHXitEJv9TtICU2GBKoSHsr1/c5nAAxZZogmGNl8Ud2WQV2wv8jTPYzHn7oknDsh9ugp6ObAhEYr5UfvqFrqtVTBEqnCYNQ88BWXR4keidBXMKe14CJ8DjfTFoByYBundF0iwhAPahqvPIy1gA4xTDLyuQQR1Cv4n+r4SMSJLixCMkO+r40GP4CuC0G4qksEVRHBDCnNG5iO9ukAE84e9rGwJZfBlx9lCreP7NUKpbTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TniH5s76aj6VeJ5bwBUri8asDAqEe6N7ZeSKqwAwNg=;
 b=Kzu/mXwU29HGy6z9z9FhHUEQRq9DuzuTvbwnL7JexCqQiTz4u0PglUBmH54SBieLEynPbIEGZZDsHKvaNW0LnkKibGNgaITbRcolvRmtZF/P+ZdyssE8gsYphd8aysuCqCCI9ycgyuLfwlH6K7r18+u7tkv81zRKmEAsH9PkZBAszTiIsoD0vOfKAkL4HlRkexBQgrc9d64IPS9EziVI7BEeQwsP6lMcGbXSLCPpcf5rSfje7mekVdXmtGc1vlv98ptcaPdEXkvXpSLch/n2z7ZGHX9eENpw8O/xWRRuxvacX0nngrJwou4rG2x38cagkZ98mHzd+Wmv2pUpJywx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TniH5s76aj6VeJ5bwBUri8asDAqEe6N7ZeSKqwAwNg=;
 b=CVU6JFnZCioaql3hdn4s8O/mJQtUgOYWuR+C59DKtTW6bHvNitJ0IuBQWsljhOKlg6xQ16N5FgGJcHLNP5ozajNk+6XSpnhcZ9pje416x/fl9rs3NivMtIOhOmzcVDOUq9DRU52cv4H1yekeZiB5OX3SkLSQ+xW0sz6qXKUecff0UBwdUNTlSSP0pDwUGjzVIBRA386poGV0tPREld27bgiSks0VHeFUvoFCKEi5oXS5cqy4C6Efcf0eHeunseFhvugctpBBtKJWn2SaRx2JSoJrQG3H4+4ztND1TexPyZRGhYO38PYKc5jGJheIT9yNvoDHKXAOdfx9xWgWQZEfCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB8PR04MB6921.eurprd04.prod.outlook.com (2603:10a6:10:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:23:49 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 07:23:49 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] Add quirks to proceed PME handshake in DWC PM
Date: Wed, 24 Sep 2025 15:23:20 +0800
Message-Id: <20250924072324.3046687-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DB8PR04MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 036051c4-bc96-4ae6-ffaf-08ddfb3b4e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y1ACLNGxexs93IkyztEUk77s2aHLbVqXYmm5Gy+N2YMECNfaZ5FffnlZjJ5S?=
 =?us-ascii?Q?1wWHjlSL4ywxhRuUhfu0Vhnu9JZAvoJ+xRM2EJSZJZjeyzc9JueND0ZIL457?=
 =?us-ascii?Q?gfubX17S+aCohMieMFo9sEzXMsSbkBgGMV8bUEOY0w1/xB7tCa3xJO5STljV?=
 =?us-ascii?Q?naegEx0zlY43RPmuUK9ky+a2LTXGyUpY3qHXPw6q7obyNg0RjNUDCqWi0C6H?=
 =?us-ascii?Q?pwmw/3w+fskM7px9BfM9ineNaiAeUlAQ0gHyGTK4wYPKsn+jvizK2uEtQt/5?=
 =?us-ascii?Q?nzuq7w67cMg4efFiF//fXDowQkRVo/htOm8KgggTRYM+h9ybhSyRcYk7FqQp?=
 =?us-ascii?Q?jAJDICLfAi5oiQx7Ig2YkYYKup17rMPpElSd910DUKZpVNXfFUNnDdxyXpQb?=
 =?us-ascii?Q?Ysb6QeF4/jmyGh0Mnv7bOSOXP9o4OzRBKmvzTi7f2dSpOYGzVkGLVL9NXxg8?=
 =?us-ascii?Q?bOMLjUwFt52toQEyXoCWH0jducr/RE9HrG+faIEjATcxlWs+R3ea/U7ayx7L?=
 =?us-ascii?Q?7pUyiE2yEE+PIbPgSI8NP9eKZlIkuWJO4Dpu8/SKk+cKLv5KjloRQ7UskI7+?=
 =?us-ascii?Q?Z92UCSMcZfJB7ELk0pgjY57bCbOwW95jxhgeylgH94nMD4sxMwgnNg1TKFng?=
 =?us-ascii?Q?9JWVFpcPWuEwu+6OvqOYvjnPvNw/BFTaogTFic13Ke+eFM9e+/LczZ32dhdX?=
 =?us-ascii?Q?hA5tKEdtWtCeSpaFt1i+XF7mbPWsS6P89ipq0gwhcU/Ovqmm/Q3aDg2BWP4K?=
 =?us-ascii?Q?G3FdQVaR3t4yTHpfc2GsXOMoIxX8cimbAuxuE2h2iWnJXrhiLOl5G6Y7EWia?=
 =?us-ascii?Q?lEum0P+WEr4QT+r+XyhNt1ypL1n4cx70s876OBtYT39sx+9n9jC1Z9Q4o+PS?=
 =?us-ascii?Q?yGn31qFSXMPFI9UWLSFrC34d1bz8Cm5OfBvVsWwfJRVZdPKneE+4COBS2EpX?=
 =?us-ascii?Q?Mvrpt2IqSSsoeVbyHDnn0h7NzGL1QYGSx9CQpfsuSuo8s0APaZ+qG67zknrP?=
 =?us-ascii?Q?/07joxJ0hx0y1oQLj3yMfRlhGw3tTp2YWE3thS8QPjJHy8K94pjbGofXGGPO?=
 =?us-ascii?Q?npOpo/X28YmuaLHE2wQBlES861UZ8AmN3qbllh8h4AV44K+FW4SQXRMYTKuF?=
 =?us-ascii?Q?+UID23pVJpEnc5PgsA+OyIrE/bx9vJpSdhuiigJWmqKnKeZ9x3/SLxitHmmG?=
 =?us-ascii?Q?aiDG5GxkWLKuDfrguTfQu3x/oZOUSpwsfQdHLW9FyX7YrHdanT7tyo9oOCp/?=
 =?us-ascii?Q?hIT+rkXuvdzXyy/vcE9X8Ekrv9OQ6VhoDid9uy34OwviSEt4Qtfdd9ZHbbty?=
 =?us-ascii?Q?brD5lO9EufqpC4WHdUdvIuX2yp1U0YpYpRU5JfHwrkoyrJcymTWzSMNZeg9Q?=
 =?us-ascii?Q?tKnmp83ZmZYlA3tzfQeZwkhNSIWHT7ilNlQnAXFBr8imnQ8ZzrQzgANPX/I4?=
 =?us-ascii?Q?2cWk7w9sIjdv7m2ztPKzQwwBnJhvfQMFbIJSlRj2Jh0fMCWE/qjAiFm8vOnd?=
 =?us-ascii?Q?/Evn1u2fwbykoHGhll37v5+y5+9o6FFiuJ3Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xb/+CVWh0fBoeEfqccE12vwcTeyJDUoUGYHPNJJfnDe49ulopw4DloeQ8cmg?=
 =?us-ascii?Q?R/x+JTiC3rfo0Bm2okzdiELv14puVNzKBmSrxUbS/DEqw/RfmRHlwk+ks6+T?=
 =?us-ascii?Q?JYX9FJtET7IeMRFUAMHxFASAzzRO6HsxL0zf2NhfTjWXcGdPysas2f5TQn4O?=
 =?us-ascii?Q?3R4B53lvWUMi7xgNBDYnm2xgdnYlnBFq9qkm7LDqa7+8UMcJy5vtx8XbBaqB?=
 =?us-ascii?Q?gD7pGpXHDkIqO+RsGH49j6M0ToBPyMoTpXVcIEOQuabyctGnfkiPqptH331/?=
 =?us-ascii?Q?zZpAuHTnIbwgBCGkItK2ONN+Xk2L2naxN1EiZZ9rWm0cNZc+YwDSeHioTpHT?=
 =?us-ascii?Q?NeR+CkBkPZ9mDtwoh4X5RLZ0HzbzNF69uqXXcxwYW9oyhpnOB8FeqiMug9ae?=
 =?us-ascii?Q?aXRxsg5pf9a10u6Qmtwd8RUjDnTTO4f7fNh2ibOGn3VCh9Ss32Y8FOxvX8al?=
 =?us-ascii?Q?2ihV1LGUERgz9RE/AI34fu5aCUBP5driD+efTLK7jGJ/AMAvdHIpXaIEexEC?=
 =?us-ascii?Q?BsMJAromvWUWVxwpfCvYay1d9w0tjx5mmEg/I3uIpP33HuOMucmIntLPuWt9?=
 =?us-ascii?Q?REr3sQ5Aw4FGLODWK42RLDCk//UQiCriVs2TIUGEj35zn0AoQjpIXDmI5dI9?=
 =?us-ascii?Q?Y/AGCgXywVZsRkYUIiTTnO85B+1u/n3tmSFJ7yLuLgOpBTfvmJMnEAaE0AHE?=
 =?us-ascii?Q?fHPxNhGspVyUhJmcfu7gPyMa1cBBDCvVl8j+iFneaOHgzTbM18RhLeBpVynN?=
 =?us-ascii?Q?f8VVi3ph6bsIVXNoIaX/KschEkO6N9GbvYuvzjVG1k5rKpE7JvhjYm/f3Y1k?=
 =?us-ascii?Q?aBi6ADCuJqtL31GE3mQe4mPl27rTF3hZ14lXuEQ6+81SVj92ZTibzyFpPr+n?=
 =?us-ascii?Q?SnBNrNriU9KV/Ch9zuH9Abch+/zzMdpg3BhLVTUvfku3JRA0UYZh+i/iR2Hg?=
 =?us-ascii?Q?Q8/Kx6vkxbQ08U9MGqhzp/G1zIYbjd1R6k544RYkh21DbLcevD2wdbbDbAbH?=
 =?us-ascii?Q?fwfvZnB4EQ//0K2PAipTMqv1RWxqE+JthSOwNg+R4xC4IM5i/qxbvdWhLvdr?=
 =?us-ascii?Q?Iox8ygs8KBQa5ULz+KbdHD/NAg2grA5WKMtaY1uCma3WWLH9rm87CpWOTxat?=
 =?us-ascii?Q?cExPktVtOtkBIXARa1AdUOHEPmVHlCJnFjHG0/z4N6rGkJ3AYJBzxf5mJGBX?=
 =?us-ascii?Q?SS/C8p7uPljJxMVv4+lqRcU+muI8wv7U2m1zuW9Yt6MGRqKpKQmTsM/L7J3b?=
 =?us-ascii?Q?YXO5EXfgDLzZZUcl2RmL8p0kH7Cc8/7qkELNeuEdAkCiEY2JOQ6wRCOV5nsH?=
 =?us-ascii?Q?kIzUZn9+zPRWBvuDmZ9N7J7Ly+YSJiOEy06+K93RnNb7GLAPMiJW++2qDRuN?=
 =?us-ascii?Q?f6Q/stA8zX7actynZVGvFM7AVXNI28y9MPEOF2g3D7Ub/V10vUqxlg6ME6MB?=
 =?us-ascii?Q?TAYaklcic+t7pCLFHkk1tC+OzZHAhx8Jfc+4ELFekWEDPJC62PpA+pQxsu1/?=
 =?us-ascii?Q?JUmTv7IEi0VNU8stpeH0GUXw8PE0mLQQu6BbzhazTEwZAl88SjvToGRorxhn?=
 =?us-ascii?Q?ZoBwrIVQlxdHAVjKuEppu4ITvDRfwKCmQ/20F958?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036051c4-bc96-4ae6-ffaf-08ddfb3b4e81
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:23:49.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRP4Tgvp4t4YJLblL4nF6YLQUVTkvECxCaXcz6NnBDwIj9dJLa4cJeLngQbSNLLHpB0H2ywMR9n2DeMPQBSelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6921

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Main changes in v6:
Refer to Mani' comments.
- Update the commit message of first patch.
- Squash the 6-3 and 6-4 into 6-2 of v5 patch-set.
- Add the Fixes tag, and CC stable list.

Main changes in v5:
- Fix build warning caused by 6-1 patch.
v4:https://lore.kernel.org/imx/20250822084341.3160738-1-hongxing.zhu@nxp.com/

Main changes in v4:
- Add one patch[1/6] to remove the L1SS check during L2 entry.
- Update the code comments of 2/6 patch and commit description of 6/6 patch.
- Add background to 5/6 to describe why skip PME_Turn_off message when no
endpoint device is connected.
v3:https://lore.kernel.org/imx/20250818073205.1412507-1-hongxing.zhu@nxp.com/

Main changes in v3:
- Adjust the patch sequence to avoid the build break.
- Update the commit message.
v2:https://lore.kernel.org/imx/20250618024116.3704579-1-hongxing.zhu@nxp.com/

Main changes in v2:
Add the following two patches.
- Skip PME_Turn_Off message if there is no endpoint connected.
- Don't return error when wait for link up.
v1:https://lore.kernel.org/imx/20250408065221.1941928-1-hongxing.zhu@nxp.com/

[PATCH v6 1/4] PCI: dwc: Remove the L1SS check before putting the
[PATCH v6 2/4] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is
[PATCH v6 3/4] PCI: dwc: Skip PME_Turn_Off message if there is no
[PATCH v6 4/4] PCI: dwc: Don't return error when wait for link up in

drivers/pci/controller/dwc/pci-imx6.c             |  4 ++++
drivers/pci/controller/dwc/pcie-designware-host.c | 62 +++++++++++++++++++++++++++++++++++---------------------------
drivers/pci/controller/dwc/pcie-designware.h      |  4 ++++
3 files changed, 43 insertions(+), 27 deletions(-)


