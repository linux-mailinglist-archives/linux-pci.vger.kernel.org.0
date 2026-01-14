Return-Path: <linux-pci+bounces-44714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBB1D1D21E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD6773019952
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 08:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411FD37F724;
	Wed, 14 Jan 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A8l2DT9g"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013031.outbound.protection.outlook.com [40.107.159.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BC37B407;
	Wed, 14 Jan 2026 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768379657; cv=fail; b=chZJAzONTivvefv7L02mk7fxLJbOvSlx2h2Aw3JbUFuIvhghjjWQODuYgES8RZFgoJVu5FvSSZFKKcHj6nh32UfkiqiMlwWFwOi4JFBR35JJeK/wTVAod845P2paTWTwWmPAU7f+y4U7thi9wagIJgyGQLJeXSxxgjgft9Pxqqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768379657; c=relaxed/simple;
	bh=wzd0Anz0+8emu2RThWvzkcfWk1fK+9hUQ61/ioiHQ/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LBcneGTkX+veT08yWtgqOYt3gzdoLZP7eMv2FhCSRWuG4RwV1tG/0DZFCH3ssk4jP8VMLS3xjWt1m05N6PJmass0kDGfP0lzyeW+Wc3OvS9hdW5B1RM4zT7XVwzj84lbl2k+BBloGCEK8S2t6vxUrZIyle7iYmcGwl3+kZ8w14Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A8l2DT9g; arc=fail smtp.client-ip=40.107.159.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpciaTw3abvuz6vLnPIXD0mZBeDDGFPM4dY6LR5RkjtSzzxUzPoxYY42pw7f5QHeI+yBza2xAQ4y6t+TSr14k1qc8W8XEWwWDKl671jCHY7azWwhshoZ9c5I6098q6QE1p8lYgiTQyMG6VCULtA8kvrimXdG8eZvSZJXtNDMTrLb5iKKBMx/QRbPIQpX6xL3MD6zxtvcagm7fBBZYzXjJ7Wvl8fuzoX+oAVRhME87M7Yx+Ep3RsbbyortnCihfwbn9B6YnG8haxBqiv0oCAFFHm3fmhkwI4lg6TcbbzwPtU14BUUqqUuWTo3CLTG3Z1T+IpdPkno9+Z3rQ3Z5wVg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUxfXkHaZhWPYMwsgJAxrl74MceHbmdiPKW4s4qH/hE=;
 b=ae06NXJtDTfwdZH4+dbIZn/OZad2KCzTD7wpJQpHtoK4AepW1DJgdiAy+iWuCY2IOvtAbkT+NbU/UmFnHsgxcB8kHdmZBzfmO+0xGPEBEak+Qeq3r0Gz9V9gWnkrEwbMEvEx+XbrypKnJbuONcm1aIJQeQ1L9sqfr9E0Ql7/iA7lYg8KsWHS3DwQYbueEtqUWzbj0K6534ooufL3V62ZKiILhuwTDra1OxmWdvbOO+oEewIPWNqWBq9NPqTlQQ015CJTxlW9cxa/MprDFRJcOzpJfzZSAHNX2k6a+4Us1eyb3yjtd9E7JCk0W1rZgHVoy6j7NG/NzdANCEejt7BADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUxfXkHaZhWPYMwsgJAxrl74MceHbmdiPKW4s4qH/hE=;
 b=A8l2DT9g2R6Ii0sqdR1YzPsfQR4+uiSaHmra599djfebBiziGHbelSfefLsguTnda2y56OCcnJm2EHn3K49xkjcvGN4ih+HEWOTSzCUxIZHDcluN4Qw+G8aSukSdBOGsxYcTeMly37Zaa1w/i6E/t8apLImdQWsiXaxdHDsirHQ3vQg5Shubjsk/r+SrvQdtYyksONU58OhXNf30qqJ69hfw5n9cpifEyQaIRUg5IU1tqdIjkYcchhDofGGajAym6LJ/feBmTpBmeMGC5VENbKPbkks6VP9o0sGYwb0Tck7H6KYG7BX77ur64vpUw8Q0FR5Sk8GhifDsKX7l+RSAzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB8562.eurprd04.prod.outlook.com (2603:10a6:20b:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 08:34:09 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 08:34:09 +0000
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9] PCI: dwc: Don't poll L2 if skip_l23_wait is true
Date: Wed, 14 Jan 2026 16:33:00 +0800
Message-Id: <20260114083300.3689672-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260114083300.3689672-1-hongxing.zhu@nxp.com>
References: <20260114083300.3689672-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AS8PR04MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: c4262385-cbca-46c6-54ac-08de5347afd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yIlVqvAOejbaffvW0L1gsyTOCfaaOMUTs5eMScETiCLE5NHr+EOW7svulEvo?=
 =?us-ascii?Q?VLRyfOfurh7QlvSH8EBPmGg6t1p37fjFePuC2vgPt2cpHOegkfHGgndfmW/F?=
 =?us-ascii?Q?/JcxeuLDhzt9qvofu3y4725LrjX/GAK3qPfI/vxWAITsY2sQatApOZdDv3Vm?=
 =?us-ascii?Q?/hP5IELdpNjvuS5ChGD43iV22HyHtcQz6SNXp1lv4ReChSexnI3+EPs82pF+?=
 =?us-ascii?Q?CEKw1o1+1xBLENM4dCTvHOejhtncswLk0ZKxd/J0LDNALniSdR02tydq7cnC?=
 =?us-ascii?Q?vum4hSWdb7nuAf7O41WGdeOsBKGEC9ajYR4Vllu9dWWeDv5X0jJgJGc9+gGR?=
 =?us-ascii?Q?8//Z4IGKigHRX8htxm8q66hbEBrE/oNN/IYPh44qypnb3moEmCW2T0jnA4cn?=
 =?us-ascii?Q?pn1vNMq2N7YJyHdW3HZHeIRz7wb/c21PSbML2JAXUD1tNl7O0gpSbTOsEi55?=
 =?us-ascii?Q?8Jm7+00S5fyamnUEerVIJrzyAlyWSjy4R6R3CpaS07NfQRcv0ae1eV7i0rgm?=
 =?us-ascii?Q?YH2DHyKGO4myAgAe66QsmANh2I/RzaWUKOyVc8BqqYXU+fwTKMNMrrg1aBeG?=
 =?us-ascii?Q?6TtC962YbL8qdwaghPllVXX4Rbq2rfx24tEcowRdZs/skONBOoZXM37ewcfa?=
 =?us-ascii?Q?byJbVLvMO1HpunojE3gHFASjm1/6JQGfAdFrPgPs8K5bHwxmt/yM1+ZJmFdk?=
 =?us-ascii?Q?Ln0YusxpTnmt2teEYNXbyLY2iGuAjcweHIdJoxQgoZYb05UjqjRNzdq64/n3?=
 =?us-ascii?Q?GLHv3jGobNtPVjNNmcCd6eR0BMtwo9/DDA2rSn2OpZ0N89NL91A4jNV7pLLJ?=
 =?us-ascii?Q?ZitBsmkxwPUL4I609Ngo4ZYVVEUOimQuCegruZhlBywiGLrpX297R6gvLpai?=
 =?us-ascii?Q?iL0ddL7x1LM9ZrAH5OPnKwlhznerTX33D4xOFsufOmmMuyRi83oN0rPPH9RQ?=
 =?us-ascii?Q?BYD+2St7Ra5RGkg38I/Bx6PZt+pzS7Zdxk4q28KdWkD+1gbhuEzLe0lQ9omg?=
 =?us-ascii?Q?arbv7QfkSzQ8uAbUSumypafZ4zPTrtmIFUsTwMZ4K/2YDlr/dELke1B76p6X?=
 =?us-ascii?Q?PraZkrK2kkxwZ29rfKl8UkwKONhVJ0RIwM2bfVdT0Ex6x4h6c28S+iEDg0NI?=
 =?us-ascii?Q?K6GNMxIdDHCjfOTe15hifcPJO5Ns9NV/a9OoS1JH7bWcH1+2Q/wIqBQtzcUQ?=
 =?us-ascii?Q?KsoJH9GS1BVgf1WfwB/qKxVbyiGnEtlQshTEbhHRoUSrbqe+DN6B/oL7UiBR?=
 =?us-ascii?Q?kYg2EKQkBso0mUE4T0daO5ki4XEB7CfDaYjKA6EF1bQBDEDXgChXzVLuKs+i?=
 =?us-ascii?Q?qlmbQiyYSVG0Zw2exa/dx8xzDXFESJKaneLf6tofQrgUn/SwYUltbsmZMT0w?=
 =?us-ascii?Q?gJleRdIZLltVVZFbkO39QNgb9o3PpaO3Zx1ABlhFXE5bhoAtzHdrha1S3AYl?=
 =?us-ascii?Q?DX/gys4IbbNeJKIiNm4CQif1VPeCJlN32iuKZ+yUJDYT5wTH/XuWZmrP7C9Z?=
 =?us-ascii?Q?foJAvkoRq7t8Nym8qMp4qQRpVMgV6W0W3LDX1Hy+pmYDKfXCzsbj/909ww?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QPh/cge/Z3pEqlcAI/E/8qryE2c+GOw17E4vZr305QCODrUvRdG2X4m8iUWg?=
 =?us-ascii?Q?aax7KH0IpWHlLuQMpoM0WWwQ0PBUk39aBHkUyKCawA7Pd+9Yjm8JEUprZtkP?=
 =?us-ascii?Q?CtFptcu5XxmErluQ3Yzu48lAx7i0dVpspqBTVu2VMZK5aSWREUgjGNMkNQld?=
 =?us-ascii?Q?qCXs1OuQwzvz1QrdK27kjMqa7A9iDIO2LfY1EUacnC1kiNac8uvktl1SynAU?=
 =?us-ascii?Q?iAJCTI+OJMJIDF82dSEzAA+XgY8VU0SQjuRlE3/ardFkIbd9DJgycJyuTsEI?=
 =?us-ascii?Q?+yaWv0h/ZmiPvqB8pPgFmRyLfyJHgafBUIszqAJnexUrTkzKvndzE3o7vm7d?=
 =?us-ascii?Q?9/7FFCvUJbDk7FU2tc4jawPliB3ZNM8rigjT93i5yIY58dguAX5DIAVMfZdS?=
 =?us-ascii?Q?Okt04lK+Vt6apcG0ZyFe7J6C0bDOEv7stWFBvH15tb80NKy7OBV8xGG0Pngh?=
 =?us-ascii?Q?Y+G6z0RI0btlyul3VFGDpW7/pkiYSJa+q7urdJdjax6gQvJvvI5d0pfrtvyN?=
 =?us-ascii?Q?qfw3LAWnMajNtDuJmh1P/8ou/FBQW8zt4Cc1n/r6FkccadHHypMdGQjIixBw?=
 =?us-ascii?Q?ISU4yGBnV/8I2cXfdfvboGRuJkJJ61lgm1o7pwvtyawZzkpiJ3b8x/4Gjr38?=
 =?us-ascii?Q?XLibQdomnDl4PVhzPq4Y7q/kVaYjMiO6rMVaT7ULvf3RbpXRG115wqW8Jm6Q?=
 =?us-ascii?Q?03dwx2Z/8975buZZ/yWErdoix0cgfaRyeUgowkZiW2k9ZNgw0QL41Jyanux5?=
 =?us-ascii?Q?fhBZdEcZiKu/9dEHWriE7bnnMiP+wslycqSkN8OpeV/4kJ9ljQ05tsdModEI?=
 =?us-ascii?Q?/THZLsUAOpFFZsd91UBMAuEe2KAM5NBXWv2ZwCN1jNpyN0tL8FNQgGIWU7gv?=
 =?us-ascii?Q?NgKfF63oBklP0vdcsGl6009e1jwUDlW+KLyI6SzB+DO10uUUt5nbOkxWnKYv?=
 =?us-ascii?Q?yyDr2geCViBeByeqSpeMNWmeeISDpwHqDUWba4/+FSsxErVzSVPjLmbl2jYQ?=
 =?us-ascii?Q?W0tijo0WPJ3fH9AJjVn/jC3ehoLVLG3PakEQrJAedo8Q0xtbGJx6+9WIj1of?=
 =?us-ascii?Q?VxusOzA08PpIs9TvZUKcsVWQ9no3V/OkjPMf2cvuknB2qfml9aAk34NMCT+p?=
 =?us-ascii?Q?R6kJVp9pS1QeKFTaXNEGKwr3EMcecVd9mUJWCKTsJHyzlML7PGjdbEjsr+Uj?=
 =?us-ascii?Q?lCVJqK4KNZ1i7Eg+iIqLLDt3S2bZGHU0xo0XU/1nksq/H66+G3gdHAqy1jq2?=
 =?us-ascii?Q?nvk1b9RQu5TfajQN9wIr+6uWrZPXxQ9V/GEkRc5UOvGjZHXw+6e/LfGrs5jj?=
 =?us-ascii?Q?NVFwtisd+gJqmW3G6X93vfC+YR1/uQQ6BMdaztA9fDlLkJF2c87Nk70dUDzw?=
 =?us-ascii?Q?mNAAMsF7wZQHQ6hJvIMa3BWAm/4RV6wE+qBRFFotLz1fjkS02Ur3Ih69BUvf?=
 =?us-ascii?Q?t9curUP2rKZofhU+XqHStq+2Us5yc62y65E78HlQaO1X2JWentDrTa7lATQC?=
 =?us-ascii?Q?kY3xcHjcA8MCtTBm4+KcY7RHbc33FuK+x3UDqZSNkkAWPkktY5lc2E0nTQTi?=
 =?us-ascii?Q?a8oszND9jv3qdFJIdI5hIf3jvKKMCeo3WG5E5DGy4oWxhgAKwfyyTCX4McbE?=
 =?us-ascii?Q?Ptb9c/Oqvqs7gEb8NFUwy7B0gAdL3EFl3MieEdo/2G3Qt7YezD9COoMnJ8IP?=
 =?us-ascii?Q?+Xqy+HxehBj5B00BkpJtBtceLD2Po8GtJPfl4ksltg8Uk5AA7Aqbtg+lbzMF?=
 =?us-ascii?Q?cBxdrljXEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4262385-cbca-46c6-54ac-08de5347afd7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:34:09.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdhG1fP6Vpd2k0r2NCIatFUQFf5gdt2TrJl4vkLqnhD0/Vl6vUMwg9yVuCLCDfLSPOpaj+9WBLW5+vhhK3yWkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8562

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
PME_Turn_Off is sent out.

To support this case, don't poll L2 state and apply a simple delay of
PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the skip_l23_wait flag is true in
suspend.

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c             |  5 +++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bf..cbe98824427b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -114,6 +114,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
 #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
 #define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
+#define IMX_PCIE_FLAG_SKIP_L23_WAIT		BIT(12)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1777,6 +1778,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		 */
 		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
+		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_SKIP_L23_WAIT))
+			pci->pp.skip_l23_wait = true;
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
@@ -1838,6 +1841,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.variant = IMX6QP,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
 			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
+			 IMX_PCIE_FLAG_SKIP_L23_WAIT |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
@@ -1854,6 +1858,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.variant = IMX7D,
 		.flags = IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX_PCIE_FLAG_HAS_APP_RESET |
+			 IMX_PCIE_FLAG_SKIP_L23_WAIT |
 			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index fad0cbedefbc..5aa7f23bb58e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1194,6 +1194,21 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 			return ret;
 	}
 
+	/*
+	 * Skip L23 poll and wait to avoid the read hang, when LTSSM is
+	 * not powered in L2/L3/LDn properly.
+	 *
+	 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
+	 * State Flow Diagram. Both L0 and L2/L3 Ready can be
+	 * transferred to LDn directly. On the LTSSM states poll broken
+	 * platforms, add a max 10ms delay refer to PCIe r6.0,
+	 * sec 5.3.3.2.1 PME Synchronization.
+	 */
+	if (pci->pp.skip_l23_wait) {
+		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
+		goto stop_link;
+	}
+
 	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
 				val == DW_PCIE_LTSSM_L2_IDLE ||
 				val <= DW_PCIE_LTSSM_DETECT_WAIT,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f87c67a7a482..b31f8061f23a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -442,6 +442,7 @@ struct dw_pcie_rp {
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
 	bool			native_ecam;
+	bool                    skip_l23_wait;
 };
 
 struct dw_pcie_ep_ops {
-- 
2.37.1


