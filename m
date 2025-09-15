Return-Path: <linux-pci+bounces-36209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1CB58767
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 00:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C29201A6F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 22:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248192C11CC;
	Mon, 15 Sep 2025 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfdqV/xp"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014252C11C5;
	Mon, 15 Sep 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974998; cv=fail; b=X0SbOca/G1K+FiqXQnTdQSpRKsAstGqqSllJZcDBzIbc22qfyf4Sya+mPoKx0xqkrDNI6Lh4u1Hyptxmc02Tko6P2J3FiwsNeZ7iHWykZprwUXhT6IQkY7gS+q1/c23t7SBD/EfK+evMGzII5mesCW4/5g1d2fodf59kiObHWCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974998; c=relaxed/simple;
	bh=rwvzLacyUQMOeSMwsRx/x8GHQLdA3aC2JIJLH0hPDmE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=FfMNhM4r2SGFzLCAf37Y/DXadVYcqM14XsMvPB5jjbMsPzjo2npA/vONYbcj65zAjOfPekZ0tEgpkHUsiLKIeg2Q8pH+EKJz7gZHTbipzk8ZVFFMqDA61iUM9vs3UUL5aXEK5W0ZiWK/e/Yi2CJZiUwt/h6JGBmMpi0ifAU/oC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mfdqV/xp; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDWEKa64hYGytmBHhF6fXg0StfskF3XleUACcOAVlZUeFaimzlYEH7iQVFVr6JmqkeaFXB+nTEDFV0Z8C7KQufspafF5ruVs2yeC0gdw6qD4pfjtEBgWt4l/BXu75l1oC6Q8RJUbEfc/WSG30ovqqHWeLgQVDVOkXaSLZbqd8pWtINGO4Bh2+0Cq/nWSb2zxzo9RYvvrwaH8Yr4Hm8yQregkBBdGQbr4M4fb6WeqQqi409o8PzSl23S+JI3RfgTOkTydhjd7Uk6Gorh5nZggGTk/wTr+yAJ1kawA+Rl09kl4hP1AnowbB6GdOcReL2BULLhVQnCPeOEi7BhiL/8H6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIlUOFiYFSoMnRjIFkTp4hMGins9zrvRoX/RjwDHZyg=;
 b=Dxf1n7nMr3UmzUx9q+yo4y8GxfSBJx52Z0t/t3gh/2xlCIKEtDIyBfjQhviTKmq3DfXHF3B4egxw5HOCY7HepR9/hGOEyNtKiGqU9dl6H/Hje2Cm6tA1FaO+O+s4h1dPkcauUwyjoIEDGJ4cgkDkFIVdRCrBvtuBQPenGvWa1xCAE5Rx39OO26SnAY3vONTMlxXtXX/1xFf1yvSW76/IVWa0DrFNm2u2/hAAhSZOgEQSs6FXPJxxmg4u5ggYn4G1nlmbswfC4oeyET0Qw9m8TBkGhu2jSKAuHYYZfFCnqk70b0LF//lziR0zWhC8KV4gtSFFNJqYfK16nli5bSbX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIlUOFiYFSoMnRjIFkTp4hMGins9zrvRoX/RjwDHZyg=;
 b=mfdqV/xpZ2RouPezVTXxI5jE6I/nHD4hWmuaELcHe/VYZhHbFYNr/YXhxRGxPPlBg1562gNeK0/69M5njM14mCn4Ai3Dqd26NgHprRLtxrbPPxmEIVuYocLlw7iKsMKAFTFU8OWw+iL5cNLLkdQdWOB2KjY0G39G5tQ1HWojpAd6Jbr/ugo6H5TjCVggz64MKGZ0/N/NUUDAVXIOs7xXuGzNGU1zEMUgQOWar3KMn7h7Xw7JEAOjMM2sWlTRKJVPaRs+pm9Z73RmrJcByYQp94b4XbYK8cdje7T2tQBHkZvUYgAnU0WYkpQb3i/FJbH5cHNHKdNr8fdINZZv4F+axA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 22:23:11 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 22:23:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/3] pci: endpoint: vntb: add MSI doorbell support
Date: Mon, 15 Sep 2025 18:22:43 -0400
Message-Id: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALORyGgC/22NywrDIBBFfyXMuhZjG/tY9T9KCFHHZiDRoEFSg
 v9eG+iuy3PgnrtBxEAY4V5tEDBRJO8KiEMFeujdCxmZwiC4aPi1Fiy5RXVTpM54HxSOI1OWW9V
 raaS5QNnNAS2te/PZFh4oLj6894tUf+2v1vyppZpxdhLGSn1W9ib1w63zUfsJ2pzzB7nfodewA
 AAA
X-Change-ID: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757974988; l=1216;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rwvzLacyUQMOeSMwsRx/x8GHQLdA3aC2JIJLH0hPDmE=;
 b=vTQ9KIiacGSP6C8SWVGPkouzGZ2cNml7ULPixJQaICLuFLGcz1B2b7ZSgxI8W4PYbZoGa+eU+
 DtuJ6GI8OytD1xbX1keARoh7XMptAuRsuRVtBeG5AlbEMk29bv8MMC4
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a5ba65-f300-41e2-d4cd-08ddf4a674a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTd6Q2dZbFhVYmhPNXVCVzZzUkdiNmJvUEoyVDRRNnc1S2ZLb1JqVSt5VlRs?=
 =?utf-8?B?dkpvWjJPNXRUeHdzcWtLRFUxSEwrZ2ZJZ3hjSUIyM0JTZ25acGxRVkl6UXNn?=
 =?utf-8?B?bzFKeGx4djRWMVBqY3ZEL043RVlnMUNTcEdVRlNzaHM5ZzdMb3BJUEdaSFoy?=
 =?utf-8?B?ZXB5RlNSVzYwd2d5OHNUbjF5Q2JBTmxtOC94b0hYS3Raa2ZibXVwU1B1RVlW?=
 =?utf-8?B?am1POGMyQklkdktOdVZqdXVvRWY4ZGFzWEx2UUZ5dWZLN3VFaXVSa0cyVWNB?=
 =?utf-8?B?YzRnSDYxMXMwdmtNYWVmTVh4WHY4L2xwS2NXcXhZS0tzUUExaVVQK0lxeEdZ?=
 =?utf-8?B?SjZ1bnhFdFFaNUZnMzRObDRzWndTL1VOWXBhVWVVL3J5U3RST0U1cWJpMG1W?=
 =?utf-8?B?b2NxYzRoY2pXYzVhcHhtckNTRERwb0cwbFNkVWZNenBCS0FvK3VsNHRpSjRK?=
 =?utf-8?B?K1VYdEdIZEZ5Z3lwL3pYTzNEejJWcGV3OGF2eVI3Q3dCbXJGQ1BSSFN4Vlh5?=
 =?utf-8?B?V1Zha1phbXpvcGpVOXNCTXk5ZmxTRWNWdGkwV2pseWNCNjdkMlo0eDdjNEhE?=
 =?utf-8?B?eXdkbW5mR3VOTW1tb1hGV3ozNHJhbkpaZ2ZaTUdvVlQ4cVhnQS9udkkwY2wr?=
 =?utf-8?B?V3NWU09VQVpDS2N6cHREdm1UM2ZEaVhpZ2syZDB2THN1bW5JenhCV2Y5eHFU?=
 =?utf-8?B?RGFxak9hZUtSdnRRTzVRU0JUMGlBME4rUDZTd0FpOFVXTUJ3ZUNTS3I0VEFm?=
 =?utf-8?B?elF3bVdud1V4S0kvdEJTUmRMeEF3NDllWkNmb2FkRC9iaTB4ejU2cnhrcWRo?=
 =?utf-8?B?Sm5tekNXSjN3NTBHQnNMYVN2TzJSa0wrZnRNUFpOU0YwSVhkUk1XVGx5OG1l?=
 =?utf-8?B?M05jclZHK0ZkcmV0RVV2YmlxVmVnb3RBRVhrMlRER1NuLytTaEtrNVdGdWg0?=
 =?utf-8?B?OHZoaWpUTXAxMHk0d3Q4dm1MMlVjWi9FVDUwbm9TL1lkSnAyMVdINXlac0hk?=
 =?utf-8?B?MmZGRUllQlZTcEJZN1hLcmFhZ2ovbHhFYUtHa3U4RXBEdnh6NzF5UVdyVlpp?=
 =?utf-8?B?QTk0WjU4K1B6eG4zc2VHRXBYcUgzQWEvUzZYYnJURzE2V3RDZy84UXNNcXBt?=
 =?utf-8?B?L1ZXZi9HUEJZZDJNWGNZVUg3dlFEWENzbHJyT1EydTVXNDVyOUovRjh6V2o3?=
 =?utf-8?B?WTBVOGxpTjU0b1h3UjlQWk44NEljNVl5WWdjYmJuWmJhM0ZhN21odzlGRTNJ?=
 =?utf-8?B?ZElIcGdBWldsdDNFRHVndlA1ZEdNdmQrT0NSRmk5b1dWM2RPSG5XMGdQY2tG?=
 =?utf-8?B?TExaV3pLdDdicStjblFlczEzT3B5MEJPYW1qOGVSYjdVQkR5NzR0cWFqaHRu?=
 =?utf-8?B?NVF3UTFzTHdDaEFRQ3lKYm5xVW9wbUZJN2ZCWWlRaG9tZG8xazdLWWpKR2U1?=
 =?utf-8?B?N21tVTFJMEtTQkxwUkNlL2lqNzJJNWZWTkdGUGN6U0RGUU5PU2UxZUZWdUVZ?=
 =?utf-8?B?M2RVaVBBbUFUaWtDZHh1bHJ5SXNnbkRqTURmZnRJMWhiQXorZnZIMGlYeHhL?=
 =?utf-8?B?M0RjQkx1elhjdlRkOTFjMXczNkpObmVkMmNhSys1TVdXWkczb01ta25tME1u?=
 =?utf-8?B?OXRVWDJ2NGNGbExvWVo1VHJlNVVwR0oxOXZZcThzQ3NKVnhlbHhZYmNVenRn?=
 =?utf-8?B?VStFSy9IMXZQOEJwNURScVB4Mmlwc2dOaFBlQW9GZGx6c3NTd2hycEs5WG4x?=
 =?utf-8?B?NTY1eGRSZmcydVZkRVNSTTZ6VkpKTkhUcWxBRmdlYnhYdmdxQXpmQmtwQ0R2?=
 =?utf-8?B?ZUFmOWhjRzVnb21PQ1lkSnhlemdrYktKUXl5MjVDeXFBUWRSLzFQdXV5b3VW?=
 =?utf-8?B?T2tHV0tvVkEyOXdhdDBrZTV2bXYxamV5aDZ4aThzQUw1TURVczRiTHVQQkFW?=
 =?utf-8?B?VzR2YVhZWHc0MG1XelhiTjZvcGZ4NktLY2lzRnZpL3BiaUFzaVBoSlZpTFZL?=
 =?utf-8?Q?TXj7usZe8kg72kDMFNQnlS8NPPsFRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MElNWFgvYnkvRGp1WjlDL05XWXYzd3BPTHlCek0rNkxJM3FQS1NqTHpkd2tM?=
 =?utf-8?B?eFNhYnRIb3pBRnp1eUhPUUl4SDd3VWFFb3c5R3RLUlpScEVQdXVQQkxhRlVZ?=
 =?utf-8?B?Z0lxSUFpUVVpOXJWRk1NNTBGYTJXRjdnWC9oZlBMYmxSS1dGRHpjSFczd3VG?=
 =?utf-8?B?ZStyYzh5dFJ3dEtBeC9WenpDQTNlc01Tek1VKzB0WnF4MDlISjQra1VKWFAx?=
 =?utf-8?B?QXkzdEE1MmpLeEQ1YnI5bmROcjByczUzakVIZU8vOEJxNW5FQzRPTC9jK2xP?=
 =?utf-8?B?bTdrT3kwN2FKMUpGbFY2a2g2RXRaUUwwdE81alpQMXNGUXpHeGl1WnZFWjMx?=
 =?utf-8?B?ZHBWV1BNaHlhMnBlNUdvUTRQK3U5Q0tOdHlMSWVGVkZWT2JmZDNmNW1vUFp5?=
 =?utf-8?B?N0Vpb2xiMmg5MXQyT2xzV1VCODYvLzdEamU0SlhKbHRTcExVNWdyMlFuRXVL?=
 =?utf-8?B?QUErbWpINXZnNlM2TUdvMjdOYzIvcmo5dUdLNGRQdnhZOExjdHkyVjdTKzI4?=
 =?utf-8?B?S3JuOXFZeWgyVUpiMC9acnVIOTNwdUJ5UVQxRDRWTnNNaHpUZDdDa01mUm03?=
 =?utf-8?B?eVlXeVJaT0FRcitUYWtuNUtmeG1GTk9Ya0ZLM08ydmVabWk0Z1l2TFBZYlVv?=
 =?utf-8?B?ZkQ5YmJZN3RQZmtUMk5tQmI1NElVZ2dBTjJjVytUMTcvdzBCSXhqb3hJMzNC?=
 =?utf-8?B?SWJtWFpVNmoyM3gxUVRna1I4SXJjcDFJWHAyaGgxZC90TFNKVGtCYnJCYUVn?=
 =?utf-8?B?TjRaR2JMeURtWHNZK0ZQY1k3T2FDSUNIUllGZFBtbHBVNDRvZkFNbWZYTi96?=
 =?utf-8?B?MXdNZkRPemsyYysvK0tUemZkUFdtL0dvd29oZ29qMnRhblZzSnYyREkvaysz?=
 =?utf-8?B?NVo3b0tCSjU0akwyME9wTkVHZTlxdFVEWC9abWhuUmJkRXNDOWZBNWVNbmVD?=
 =?utf-8?B?a2dBQkpWQktIWHFNTVJLbnNnYVNpQ2Rmd0dhWWg2TFBIYnBieEVlMXJ0MjZo?=
 =?utf-8?B?STJqL2dDaE1kWEVWTEZ0U1A5a0lXdlNPbXFBL00zZlFEanFEY0VNNlJMMGto?=
 =?utf-8?B?eGVrcVJJRFd2SHZzQVM3Znc2RFpHSmNiQ1VKKzBYRU03Qm9iUk5HR3lPbTQ0?=
 =?utf-8?B?VVRUbnlTNW9DYjlZWGlTRE5jLyt3elNjM2RQcVNOTmhpUUNwd0xUVjlhZ2ZN?=
 =?utf-8?B?M2E4N3JvREh3aFRwcm42ajVjQkFqcGp6QWtraWlYSjNPR0N6aHpBb3ZEUkUy?=
 =?utf-8?B?V2tKR0tCWDE1bExyV0x5WlBja2VPSDloa1ByODBDdWxXbytQQWhsRVg2MWRR?=
 =?utf-8?B?cnVDVmpTWDJpOCtNeERpUm12QjF4cUpZTWZvT0ZmVjE4Q2FzYkxoR2ZkdzR5?=
 =?utf-8?B?OUlQMUZqbUoweEdLTEhIRGN2cG5tK0JQRE1TTmh0SDRHdi9XcEJtOE10K0J0?=
 =?utf-8?B?WVJocGJDcUxQTjgvbGtnWlZXL2F1cUpVa3ZSeE1nRExoaU9qS09aVWZZbXdZ?=
 =?utf-8?B?N0pMZm9Va0pLSkFVY1BvVHV5Y2R3eGw1L2FVOUxKVDJXNEoyYTJoMkVXK0Yz?=
 =?utf-8?B?YWNmSmZxNnkvTThxQmRYbVAvYy82dzNERnp6QTN1bTBJZ3VkZUJadXV6YTdO?=
 =?utf-8?B?Ui9xdVpOOW9YS0Mvc2JSaUZCTUwwVmdwWVVUK0hTZHFvUDhGWk5MVkE4Q2ZN?=
 =?utf-8?B?V0h3ckxKeDhTbXFLbFpkZkFiUlZSVVRUUFNFOHl6U1hoaEpuNGY4azhJUjI0?=
 =?utf-8?B?MkU4Z29WbUViM3oyMjBpTHBOckkvRUV0SWwrMHFYc1ZaaUVuV1BKTzUxMklE?=
 =?utf-8?B?TGZNVFZJYWRmS3l3NHNmVWNoTTRjdkFDRUFDMWdpc3hHcmIrUlBOUFFTMEcw?=
 =?utf-8?B?VWh6UVBocjNXV2pkbWFpd0xCcFNBZHpocm5WeFY5M0Z0RzNjQ0pzQU1zRVJo?=
 =?utf-8?B?d3ByNG0zTkQ3Z1lsVXdiemMxRXNKVW14NzJLT3VyWTdpSDZNNGpKQ0M3dkts?=
 =?utf-8?B?OVhYYTFmc083YVBiSm5aVUs3d3o0Zkk5L2poTG5SclVhOG1aQ1dMRlUzVnQv?=
 =?utf-8?B?VXVEeFhHYmpTcjJ0UmFqc2xVSXZrM2tia29XQnhLUzhreURTQWl2Mlp1WENm?=
 =?utf-8?Q?lb3+DJ9Op8v7WY4AZtkeCfbg6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a5ba65-f300-41e2-d4cd-08ddf4a674a3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 22:23:11.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7XU7TO+U1C6J7oD/sl91uvIb+DJZQDohuk4TsGkhDtO8R6YR6x0UNKMqVXly0yy/4duywCjcHZ1WFNxsLpl5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
using platform MSI controller, PCI EP can get notification from Host.

VNTB use this feature to reduce ping latency.

The first patch impove epf core API to allow set any MMIO address to specfic
bar.

The second patch add MSI doorbell support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- add help funciton to get bar's inbounce size
- fix miss x8 when caculate bits
- Link to v1: https://lore.kernel.org/r/20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com

---
Frank Li (3):
      PCI: endpoint: Add helper function pci_epf_get_bar_required_size()
      PCI: endpoint: Add API pci_epf_set_inbound_space()
      PCI: endpoint: pci-epf-vntb: Add MSI doorbell support

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           | 138 ++++++++++++++++++++---
 include/linux/pci-epf.h                       |   6 +
 3 files changed, 262 insertions(+), 35 deletions(-)
---
base-commit: c2a282d1fccc53a989da61a5da4f03c9d67ee99a
change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7

Best regards,
--
Frank Li <Frank.Li@nxp.com>


