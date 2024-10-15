Return-Path: <linux-pci+bounces-14581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5DA99F71F
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 21:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF781C233A6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE91F5853;
	Tue, 15 Oct 2024 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jolDNz6h"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EB1F5830;
	Tue, 15 Oct 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019869; cv=fail; b=R+aR0gdrddySa1SEngPqXxpfe6q6N+OA+VvKtZxaU7IrUCi2hGZa3pTymTs/MXB5tIM99ww+tJ0m913FANHtuNpTX3lPWFPJbTxMx2iX8SURoAMWEqmgE0RrY3ndqCGMIr3UxRlWSeI71zJLZtIBQHgRzqi7n4G43Xd3SPtjYHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019869; c=relaxed/simple;
	bh=mpQkyAmcMxPoQ2LNPaVnnXkLHMMBxJM2cbPN+52/6qM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dJmf4HnQ+cCIzF2p6p30y23ZdltTwcobT0lJJu4/rUVkMDkr1JhEpcxGe10+SXLXzhLJHYbH4mBxjq/yL/zNTRJbWDvaxoajY7CMiSuaM/CvhHyxtF6iqqBSF4jVQz6Uzw3fT+2J4P+2fzqmGYnAKtRt4RPpYKjPxTUqnr2cDVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jolDNz6h; arc=fail smtp.client-ip=40.107.104.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFNUhd8schFXsNX9Aok39fvhPNg2K1Xndn34PFp+aP9zKYjgoC/m67qBVZjhhHjNh97Es36YOiOb1qkyorMdnqF1fP6nlI9ID1fT9iAt8eVJFnDDSe2QNvqewsmp3AqGdWo3jeuf8Buge1wnKEnzekyUGH7o7J5XYP8po2M/mHWzVcaPEXygW+dIX+JWiJkYXfCGe7inaPywM5vJapfLnqkd4xdKNRGfFKN2mgmOicgM57azTk4Zuv983SqiUh13CgenvwisXRTOhM2vohTIhQphK4MiYbpLNalWiNmjc2cjDlNdmzV07BNeogWzZ5k/hpPnRZSHuJMys3S84y1G3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPYi6nf5hF87bcZhksCeSoE7DI1/Kxlduip+Pl9A+ME=;
 b=VX23sYR/7NHPDDTppcgEOGc3aybw8mTTpDvwwgBQV1p/HNU+u7GH1sIoYAGpnLlear/ahLiHvJNiyWoKp4L1yGXEV7+Q0X7/hp3ci0sZqHd4afUlC8vzJ6iLhUidB+Jtdu5jQ0Bmp6jfvlueWVaP9HtJLN+nby8kUY2B40oF1jV3dnCZ1i/nb8lEpwo9hUi+EXbqcjyKLL75kSe5wGq+k0XoIplC35G7HyeiLk0mWKasSghpklZcnCJCgul/ZdierAZCQtdMu7L6JQi4G8chK/Y01zkuLGKsggDK93xWINz0QIc5w4V3J40RyUS0pXcNCnmTFg4NS8mujwbYIfkC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPYi6nf5hF87bcZhksCeSoE7DI1/Kxlduip+Pl9A+ME=;
 b=jolDNz6h3bWC+zrFaswi3C5hIy9dA/w52JXm7z1pzw17upGaNEvkNsbZ8/toKh4SRnIBCP/eqmsv/L6IzDuB4/P0P5XE3l50v3i8QiGzHzogaRv7BvaoGVCyyge6PsFma+kugGITWn2mZyCZg3lq5JCS88MaS3Ikyacu5VgNnBlrNMoREoj0SVUfifPimgP4hEY98NhPAH+C0cByq23meq87TqNEMetSyD/oJCsLit1zEjHszPB9ZYU3zdzWFK4Xz43BLyXhoe/ajelVhvP8vWmEXI/Cpwv+JnK4bN9Pt20Bh2hD24mPoorjiiO5WhfCcVXaAwtsDgopK9TAeGfIyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB11002.eurprd04.prod.outlook.com (2603:10a6:800:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 19:17:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:17:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 15:17:17 -0400
Subject: [PATCH v5 1/3] of: address: Add parent_bus_addr to struct
 of_pci_range
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241015-pci_fixup_addr-v5-1-ced556c85270@nxp.com>
References: <20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com>
In-Reply-To: <20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729019855; l=4731;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mpQkyAmcMxPoQ2LNPaVnnXkLHMMBxJM2cbPN+52/6qM=;
 b=yAk0aYUD19q9Mz9u5tenR1MnHu79q4JNoA+Uict2jX/ebVbxgfGNePvLdPw+Dmrui9Xt5LDxE
 RrjPRxJultiApLREyohOc57Zaa5aTq4ocyaDO8YLNHXlagw7siqVO44
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB11002:EE_
X-MS-Office365-Filtering-Correlation-Id: 915ca2cc-1e15-44c2-35a7-08dced4e0bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkVPbksrUDZoSGhoaHJTaG1GODYvTDBnUlBzdUxiNFFybW40WmRWMFIrU2lB?=
 =?utf-8?B?M0pWVDgrME9mSGJmU3VadHlWekZzWVUzczQyeUIrRVM2c0lickpSeHFVR2di?=
 =?utf-8?B?andxZkdURDZnenB6aFlpZlFmdFMxQk5lZW9nbm05d3F3QjdIcHBERTdIbS90?=
 =?utf-8?B?VEw0RGEzbEFEcGJoQzVTRmFaSjk3K3hIM25IYk9GK1RMWDRqUURUS2F3K1RJ?=
 =?utf-8?B?QkJvYWgvQWQrMlRrU05vTURlcVFJaHNQQ0FZOU82UjY5eE9PYnhSWFIwNzNp?=
 =?utf-8?B?UzZIejU2YUFNNDdYdVhEK2xrN2w1M1FQR0pCVjhTNGJiSHNwaWNOK1kxdVZu?=
 =?utf-8?B?ckFVdTJJYjIvbklieXhwR29XZThzcG90eEo1Vk10Tk41R2NQNUxWd0hKeHZM?=
 =?utf-8?B?VjBaaVZwMzRWY2dTQnhhK3FjT3o2aitSNy9JVU9PZ2d3bDQ3N3Ywa0RHNng2?=
 =?utf-8?B?aEpHUUhHMWs4QmhodnVvbEVKazhsV2JRNVVyY2NNVHUwWkZvZzBsMUJCNGhn?=
 =?utf-8?B?RFhldTlvd1ZoenpMWFhsaHJib2MzWEw5YThaZ1hGTUNZUkZhU3ZmZEpxWCtx?=
 =?utf-8?B?ODlPRndRc1Z3RzZmeHhLbHVMYzlYK2tpUHZseFN2VjdQY20yMm8vcTNKQlhH?=
 =?utf-8?B?eHI0NkFZUVhRRHdwNmhsbi9pQktNTnI1b2xhS3R3a0YwU3N2Qzc4OHFmRXF2?=
 =?utf-8?B?U1hzWXR2UW95dGNncUVUaS9aTk5lVStrSU5qSjlHSzJIMUJMVVpEekw2bElV?=
 =?utf-8?B?aTZqeTFjREd5QTArQjZ3ZmpwaWQ5ckhwajlsZE5FQXorYjVGWGRjTlRjN1FZ?=
 =?utf-8?B?NVRwSm1POTN1VUgraXFGdkVGMXVLLzZLc29FQWZrWGVIdUp4VWZscy85cktC?=
 =?utf-8?B?djd6Zkg5Skp4UWQwdStndFlsbE9XcGxiMnJORXFIZmZ3MWZ1MHJqQ2NVTnFm?=
 =?utf-8?B?RWtDU2pjMU5FdGhndmgwMGQ5cUZwaWdOM3ZnVW0rSnY4cDNJTTV2S0J5bFdZ?=
 =?utf-8?B?VEJKdTVBZDZCK0g3RHMrZXVUSVFRMzhvWlNERGVmRlpiNmVTcEVXTkJSSDky?=
 =?utf-8?B?cWhaSmxaWCtBWEVCZEkzWjBnOTA1RUdyR3ZkbWZSaUhhVVBUNmFTUFRQYVFs?=
 =?utf-8?B?ci9WdmpHM2ZCZXd6WStUdzVQNm1hK1pYUElIMmlLRVdwdEFQcmlzdzBKR1Ev?=
 =?utf-8?B?TnBWQ29DNUI0d3NxZU5Jd1h1QXRxS3VZdTN6bm1vQm9WNnlmNkZNbUJLUVpV?=
 =?utf-8?B?V2xVTzRiRWtNREJ4V1luWVI0dWszVlhRSkNaMG4rYmZWLzgxd0NVQlo4Wm0v?=
 =?utf-8?B?dzJDQU1UME9hQ2Z0QVpwLysydmVOOStwWEpNMkpKdjhabG5wMWxqcmRZZWcx?=
 =?utf-8?B?b3NlZXhncnhrSGlla0EyQlBBUzR5UjlUV1NmcTVLMWZXZXYwbEZZSTdxQllY?=
 =?utf-8?B?eFpLQXhVckJENVJ5SG9VUnRrbXNNOVU2bHdzaVd2UHgzR2FxNHNaOUxnbG9a?=
 =?utf-8?B?by9jNTZUMlJWSTZFOWxkY0NsSVBYTUxpR3NGQXdya2tQSU5zTTI2V0YyK0lC?=
 =?utf-8?B?T1g3QUpYdERERlA2SjhiVmJUK0JXSmxJQTdDWjRTVU1FL0I3cUY5WDEyenZ2?=
 =?utf-8?B?cU80aHJwZUYweTg5SXAxSDgybzdWb0JRZXliZjI1UytUUWQzelI2UVRCL2Iw?=
 =?utf-8?B?V3F0NkFPT0kyYnh2eXRrRWtVSGI3NXc5bUJ2cDBIWlM0eW1aZ2lRWStWNHha?=
 =?utf-8?B?NnByT25mNVNCYXA2VUgrWVY3NHhHS3hHczNVSC9kYkErdS9LbVFmcjdyZ1JN?=
 =?utf-8?Q?Jg0bVt789HLWHTtidjpuM309gsSL2eBPBTDpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW90WHg5VXozeDhHN3FFL0hmamJVWjB6QmIycTJISU1DcW50M0RkU21tbGJz?=
 =?utf-8?B?QXlwdDIwK01OUGZmMG5ISHJZS05Cb2U4NEx0RlBIQy9Kc2RsaGk3WHBKZG9R?=
 =?utf-8?B?ajZGdHNaUHpYcE12bUEyRUxqSElROEZsKy9USUoxaVpQd3phVTZhWXpwcWVq?=
 =?utf-8?B?MWRGandDNzRTTExkdDd2cE1STmhnZnAyQWdyT2xMSjJrOVpKcUdHVDJrK2lY?=
 =?utf-8?B?dy83RWNUSzdsVStoWmYzM2FiKzBJMURiaVR1aHVQQml0RzBiZFlnS0dwVEpo?=
 =?utf-8?B?ZzJqZWYyb2VzZXVLTXA2YVJpL05BY0JYY1VrZVlFcnNiSTNqR2JVaEQxZFdQ?=
 =?utf-8?B?aEJSVkFjQ3B3VXpYczc4OUNWTFhZRzlZQllYTnVYdURKVUp0RnZXd01tQ3lL?=
 =?utf-8?B?dEkvQ1lDNnFKYXp0S2xNTjBLbjdhZ3c4eTZuYU1rZm1xTXUvKzNILzljbzZn?=
 =?utf-8?B?RVh4RERmWWU1YnErMDY5b0NkMmNXeFVIR0RWTXBtNVZaeGVJNm91MFFsMThB?=
 =?utf-8?B?MjIyUERvRUlSOEx1RTYxQTFYYzJIZU82RkpUaDFEZVV3ZWRORWlJUWZtYUlw?=
 =?utf-8?B?YnpVZVpReTU2RjUwUlpzNVd4dFM5L2hVSVJINkVnT1dwaCtTc0E1NUwvTDg2?=
 =?utf-8?B?SEJERTdNb3g0OTUrc2lKSlE1bHZWSVFTM1hJMC9RTDBTd08vUGVTZ1NYaDZ4?=
 =?utf-8?B?K0ZlK3hML1RXSk5jekMxaW1oTDhua1VrWG5wdzVOaTdYVFJUOUppQUJPN3Jq?=
 =?utf-8?B?dno3d001TGRoTHYwY0ExUEE0WXdHY0VkRStQclhNM1dCdFRtSjBJRnY3aU9y?=
 =?utf-8?B?amEralV5Yk5NTGVmZWIwN1ozVlRNQnhSMTlvcDkwYW4rUkR1NURzSzhUcDZT?=
 =?utf-8?B?RURHQzNnZEE5aUhSV2QxM2puQXVQSXBiRU5vaVp2T2FWVW9ZdCtiRWZnSDFa?=
 =?utf-8?B?azNHTlJtV3gwTWpxR0prTnE4Q1JYMjROVzh3cFBPMS9EZXo0Z3pEbWxOUjJI?=
 =?utf-8?B?cXBmN09VM0pUZEE4TnBYYnhLMUl6NndDUXkrZUJYUEdXb3U3Q1VaOC9XRXhG?=
 =?utf-8?B?cGM0TUFxd3ZhaTZ2MEcwN21id0FSeXJ5bEd4TEdiVVdpWjFjZW0ySkVWQzU3?=
 =?utf-8?B?eDhOZG5ZanZmdlJORW95Z3lwMi8rMTVxZlJrOXhqRW9kWDZYZnVTd2ZUajJu?=
 =?utf-8?B?UFg5RkRRTFV2NVNETjUwUUx2akluQ3NJRnAvNks4WmExdHRlUHVGa2xjc3NU?=
 =?utf-8?B?VGNYSFRVU3R1Wit4Mzh1b3orZ09HS2drb2o1K3A0T2ExK21abldPWjV6Y2Nl?=
 =?utf-8?B?MlEvWjRPblI2amY2WENydmlVNVBscXRnZkNubnhzT3R0NDdUK2ZlczAxOEo4?=
 =?utf-8?B?R052MDNUTHpYSml5b3hHMG5uRmRqb1lWMkM1cVVFY2R2MzdHZ2s1L3h3RDVJ?=
 =?utf-8?B?MWM5RW1SSjFFL0VBQll1YURGajhKMi82cVVPcU1BeG8yUlA5QWV5eUJRZVI4?=
 =?utf-8?B?aUlHelI5QkI1dTByWm5NMWpZbHJFK0Y2UzlYVXpXaE9hYkJscE14RFYxTjlD?=
 =?utf-8?B?RS91WmU5N3hPVk9JVG91SlFab1djWml0Vm9KdENUREdsMUxsMnRqNE1DdTNL?=
 =?utf-8?B?L3Z1RXo4M1ZsSnZaamx4QWhaVjJML3Uvc0JveHB3WmhQaDRsUVUxdkFpejEx?=
 =?utf-8?B?eGpDUWljbExqcDVjQ3I0b1Z3NkFCV3ZsTnRVM3JhNnJVNXZVOEtvNGRTUmJQ?=
 =?utf-8?B?aXNTblk4VHlJd2s4bE9VVkpqZFA2QnBxakVMOS9nU1FKVVhQenJSV01qWnhC?=
 =?utf-8?B?QlcvcXBjV3d1TG9mdUt4ZGw2R0dhZ1hpL2VuS3RnSkp2RGFveVhYNHJMZzRw?=
 =?utf-8?B?SXVHZW1LaU1hTXhpWWJrUjVEVnFqekVoempjdVpsNnJHV1ZETVZ3enFLUW1Z?=
 =?utf-8?B?bk9WRXZhZjE0dkp4RUxMcGdtUzVVVkNBWXl3NlhsZU1TaXAzbmVXNm1FOFBQ?=
 =?utf-8?B?QktRcGtLMUdlWFBWNHBoaTNIb1lwd0ZBOURwMnFFc2E2ekRFNmw4WklhRVM3?=
 =?utf-8?B?endOTXdUaFpTdDIvcEV4V1hBRm4rdnlqQ2FyRGpyd0hZOEtma2YvNlRrc05w?=
 =?utf-8?Q?+8kE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915ca2cc-1e15-44c2-35a7-08dced4e0bdb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:17:44.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xc2rtHGTlkrULzy6w6+XBXq3IupCZLahZWyt0jCUb4sfBblRJtFlPJlYKENjTCMHbknPcTy8H4GZpBR38yxb6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11002

Introduce field 'parent_bus_addr' in struct of_pci_range to retrieve parent
bus address information.

Refer to the diagram below to understand that the bus fabric in some
systems (like i.MX8QXP) does not use a 1:1 address map between input and
output.

Currently, many controller drivers use .cpu_addr_fixup() callback hardcodes
that translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR"
(drivers/pci/controller/cadence/pcie-cadence-plat.c),
"cpu_addr + BUS_IATU_OFFSET"(drivers/pci/controller/dwc/pcie-intel-gw.c),
etc, even though those translations *should* be described via DT.

The .cpu_addr_fixup() can be eliminated if DT correct reflect hardware
behavior and driver use 'parent_bus_addr' in struct of_pci_range.

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
        compatible = "simple-bus";
        #address-cells = <1>;
        #size-cells = <1>;
        ranges = <0x80000000 0x0 0x70000000 0x10000000>;

        pcie@5f010000 {
                compatible = "fsl,imx8q-pcie";
                reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
                reg-names = "dbi", "config";
                #address-cells = <3>;
                #size-cells = <2>;
                device_type = "pci";
                bus-range = <0x00 0xff>;
                ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
                         <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

'parent_bus_addr' in struct of_pci_range can indicate above diagram internal
address (IA) address information.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v4 to v5
- remove confused  <0x5f000000 0x0 0x5f000000 0x21000000>
- change address order to 7ff8_0000, 7ff0_0000, 7000_0000
- In commit message use parent bus addres

Change from v3 to v4
- improve commit message by driver source code path.

Change from v2 to v3
- cpu_untranslate_addr -> parent_bus_addr
- Add Rob's review tag
  I changed commit message base on Bjorn, if you have concern about review
added tag, let me know.

Change from v1 to v2
- add parent_bus_addr in struct of_pci_range, instead adding new API.
---
 drivers/of/address.c       | 2 ++
 include/linux/of_address.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 824bb449e0079..38db2074494b0 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	else
 		range->cpu_addr = of_translate_address(parser->node,
 				parser->range + na);
+
+	range->parent_bus_addr = of_read_number(parser->range + na, parser->pna);
 	range->size = of_read_number(parser->range + parser->pna + na, ns);
 
 	parser->range += np;
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 9e034363788ac..0cff903653916 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,7 @@ struct of_pci_range {
 		u64 bus_addr;
 	};
 	u64 cpu_addr;
+	u64 parent_bus_addr;
 	u64 size;
 	u32 flags;
 };

-- 
2.34.1


