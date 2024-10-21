Return-Path: <linux-pci+bounces-14957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067C09A90A2
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 22:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64052847CD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8C1FCF58;
	Mon, 21 Oct 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYmXJDMr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD11FCF40;
	Mon, 21 Oct 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541288; cv=fail; b=VgadqfzCYqOUBEO+7A1mMtz3doZhAz4CRUD1NofqRxZLL2vuoaIKW7XHNvBiiaEc68abMOvrYa2fgaqNBZjgdickhiIDI2RR3ec/9jXCiBjvT6fejRO9+J2aFNLiPkqEGqXPN4+E/GxotLyHCE1K2S0qSEFTIbtsFowhaD4VnV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541288; c=relaxed/simple;
	bh=BLCZ2PxedJ8sdH0+OO2S4L0OwBVlKQm8vFUPblDgBs8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=vD3Ij100eNz0lcT15DEvhyzwoDDHz8CGGECfD8Kq+b0hkHVkPQAwXG+ejWH9cLTEg7MrkpbuJz4Wr2nmeMYhqb9CqdryHZV8IzINg3FZECK0NFlaGSIY4lD1MBEGNr/oJCtuwWUczxAW3zX81X6Q2aqjHqZqskvMOPVCUGfpvwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lYmXJDMr; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBtgyFeEcG5A7soUlVllARJCh6L6WawVfy9SEnQDckXPSjjRXs2R+39QEh9cCjVLdsYoZD2tWaQCQMg5w+UNbw51MJr1t+jskgF/qrcLaE0I14AHEEyB30gJGxi3X65NNYrZI0kbNg9O2WJfZWlrtLMUBgEdNh+ZUe6G/QRP/HHff70Gyj+PfxlLSkXfAZcmx3m3zqMUdwyKGjBecrLwbJccnjtXpx7vc24LDzIMZ9gxXE1nCe/iU6Cu/EUhJBJcGZ8yNJET1j1hofxkDs88ETCrCmtQfOS/dYvBGXfVafTP8XdNgnEDXVKhnvCcQQiZcqhWWNQb3kre/bzdS3V+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PyAIWaOdZO0FeU9DlPkmrVDHjIO1344fxwDNX/2GJo=;
 b=fMGhLNsfW4xdNvO6I9i6ROTpkSmTp2Gdkx9SHuFnyYvYyxj1Spy5yHFU9QVdatu0QTLDcYOMuh7M3yCl0wz4QQEhzqiE6aUn241T9N+Ap/pvnaqVEbybAOBcelhYM42ZtSCXUlD4nKdftVuE1iU5NYoIJrQY9sDy//SGlOvAlH0IOvXwkKcmVmiS3LIOo92O7YOAW7lqb5j/RPeE8bbYDxrRgmIgIE1FkCFKEzXSpMedGKC2fp89yyR6bOeUFjHG5CTwG+fnyYCattLM+BexrOrQ8S9OS1hd/FSzv2OMD8lK5UhOM+UuWUBILfczkzRwvbTA81e+X9CFna25o1JANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PyAIWaOdZO0FeU9DlPkmrVDHjIO1344fxwDNX/2GJo=;
 b=lYmXJDMrq8LdN7l4XN4lNpgvjNshB+E2q3xohRA+rlSz4nd5geB2jhaXIbkEEHFBubn+d1mXlHUTqJuUdATy9NbLUHt2vVzeS83t3jl7VeTZQ5GNcTfzkYWo10YI9R+UywhnutPiaHG9wtG4SiBV8VyOZPb8EoviOW2Xp40WZLPKXVUcEZJtjSOKYuKPPpC0DUHNm2nwPElTR5UHf08L30gDWSWcjhYNm/E0zxp1fIIvYgfLSMTjI4JzeWWXGQ8J2kSfK4HRqSgL5gwnajyMBothHI+OLZzRTDLfJf00hnHLMoN1sX9ckPaldjbf1sM65HPC6XygNxQCC7V6FBFySg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6882.eurprd04.prod.outlook.com (2603:10a6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:08:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:08:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 21 Oct 2024 16:07:39 -0400
Subject: [PATCH v3 4/4] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-pcie_ep_range-v3-4-b13526eb0089@nxp.com>
References: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
In-Reply-To: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729541264; l=2779;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BLCZ2PxedJ8sdH0+OO2S4L0OwBVlKQm8vFUPblDgBs8=;
 b=I0Y6HBxi83M21mJruo/UF9A9/P79iglng8Vq/leSNmuBTVJgb5/hHk6IspsBWf8mdE1ifzvX7
 fFArpwcY8/IDx/GMhaF07h1l3DIiltAhF6NJflP2H0zWRZ1ryhgZnmi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: fc65adfc-fdc1-4f44-2792-08dcf20c1248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1liTHVQVFhqUmQ5MWJRV096M29LN3ZaSXRHQTNjWGdiYlB5ZGFDU3U2bHc0?=
 =?utf-8?B?TjFVYlBXTnVqdzZqdnlxSDd5RFV4YkZNTUFlNzhCMDV1L1M5TVVXMEp1cTFv?=
 =?utf-8?B?Yko2dVBaVlNFQlRKRHRtM2F4T3JSa1A4WTB6cmxqUU1wREo2bUlCUnM3WTls?=
 =?utf-8?B?YmlWYUd2WDdNZ0FheFFodmdPdEw0L0VxL2RjVWhKWjhJbWF3N09INGx2ZTEy?=
 =?utf-8?B?OTB4NmxRb0F0UlJyWktwcmNLcko2aGxMY2NXbEthOVBORnlaSkV6ZlR0a0Y2?=
 =?utf-8?B?Zm5acnRWTTlrM05QSmh3Q0JjRFMyYnEvUmhGQXU1YTJJMVNKRlI4a2NJQzdq?=
 =?utf-8?B?OGNsMG5hVnovQjUySEg2d3gxM1VlRENhaEJKNmhhVlhxL1lPd2Q3WDBTeEtj?=
 =?utf-8?B?eGQydUtuMFUwNXJxZXR0R2lpZ2JZK2tTNHdsZzlTZklYaVIvSVp0WmQxbFZN?=
 =?utf-8?B?TXIxa2Z0emcxMFNNMFh2a3Vpand5UlQxOXlRTlprKzVwQWZqN3ZCV3ZIcHJn?=
 =?utf-8?B?WmdTeStWNlpvWkRjdDMvTTh0UnhBby85YkFwUDg1eENvSWQ4amw4RlUyYWxO?=
 =?utf-8?B?NTIyWjdYWWNmL2FwOFo2RFBiemkzZFAxcCtXa0hMdk85UEd2NGZNN1doUnpn?=
 =?utf-8?B?c3ZabVlGVThPbGFqVG9HODk4K1FPdFJudVhBc1FSc21uNGU5akFNYlpUQnFM?=
 =?utf-8?B?bTZIN2t0Y1NKQWgzVVhidW51aVJDd1V6QVpDZzNGVU5PZnkxVkI0MW54QnhX?=
 =?utf-8?B?Z1hvaGh4SmNYZHJPMTZwMU1kOUI3RllMcDlNMkFKUFRLeWREeXpMTzFXdzFx?=
 =?utf-8?B?RS9KY2hFS0pUVHdRNUNhUGFWc3ZjQTVsNWp6a2hpSHNIbWdWeWova0VseTRM?=
 =?utf-8?B?YUhMNVh2Vzd3VzMrTWl0TUhVUVVpMkE5WW8wZXhTbytJTUpDNGZ3VmZrK0NR?=
 =?utf-8?B?eXVYNUF5c0VIQUdtZklOd3FUTm40UEh0ZWNsOEpOZG0veS9kTEg4TmptdmMr?=
 =?utf-8?B?Y0dxM213eGZFTVVVODZCZzIyUTc2c0E5Um1UaUNNcG1rb3J0NlJpUGlPdjhP?=
 =?utf-8?B?KzFlUnpVY0tWYUhlR1hCS0k3TnZTc0Ixd01pSWMzVDI2U2x1VFFKUUJsaUFQ?=
 =?utf-8?B?azNHWW9FSVhYMlIxK2ZsSFZlNW9jM2dqR3o3UXBpSS9pazdMMkFlOXRxM2Mr?=
 =?utf-8?B?WHo0YlFGMHJFdnJMcUJnZGQ1dlNyYW5XMnkxTTIzMmxOaldYSjluOW9kZjdn?=
 =?utf-8?B?UklQYXVRT0VtSjhsdXUrQlUxUUluN2FtVTJIUHFMOW9oWHRvTlY2WkJ2UUlR?=
 =?utf-8?B?UElEeUVtd1dlNHdybjFVaWhBeDlQRUdFcDJRTXBTOTUwaUxERzV1QW0zNkx5?=
 =?utf-8?B?R29ULzc0N2FoZk1oREZySnAyV3JFUTA5bzJWSTMzSTNHdktrTVEyUGFjaXFl?=
 =?utf-8?B?TlZzcnJLbkVXSTdoN3BWTEFjTGZxZHpER0o5Mi9XUGV1T0U1OGhhZEczOHhh?=
 =?utf-8?B?dlQ3LzEyR0p6a1dJbnBLSSs4ZVJON1hlb3pFWDd0b0JCVG1ZRWoyYk1XeU14?=
 =?utf-8?B?T2xzNGR4N29STmZVcFBnM01SVUhlUWRpWGxlVml0K01OVGxkWFBiVGtyTGVG?=
 =?utf-8?B?aVhnU1pSRDNkUUdORkVwVlFSZWliRldPQ2FGaFd3YisxWkFiT2RKRUhSYVNV?=
 =?utf-8?B?cFpmbGQxeGI3TzZjMWhqbkEwc3hsKzRXTXJwZzE1RmtiRzBzOUNtQzMwbHdF?=
 =?utf-8?B?WVlqQ3Q2dlNiemN5dWZucGtNL1B5VVZ3TWdFZ2F3VUxGZ3ROaW9rVGpUMjRZ?=
 =?utf-8?B?b2pFdnlCanVKczFFS1F6S0ozMzRNdzZORXZsVXpYRi9TckhKS2VBMjg4WTVC?=
 =?utf-8?Q?O0OTmaweptoih?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVI5Q3d3Ymh0VE0rbXVtUHN6bWs5Vm45ZlhYSzNzS3hrOVpzOG5zQ0JRUmhw?=
 =?utf-8?B?WCtKbUtGQUtPQ0N1OHlhQk81cTBkVW1QQ1p1aDIrcTU4MEZpVVR3MFJPQzBo?=
 =?utf-8?B?ZVd5ZEx6cXJ4a0lMdjk4Q0dFeUFkaWRHeC9LRTgwWms4YXNYL0tNOHUzL2tF?=
 =?utf-8?B?ZHFVNUlTQThFSERnZ294TXRra1REeEhnc2ZnaGJERTJJNGQ5WmxvS1RPMEFJ?=
 =?utf-8?B?eVg1anpnR0lRMTJSeHE0OHlTSFhGcXpGcTQ5bnpFaUcyNFNlU3ZSU2JUMEFK?=
 =?utf-8?B?WnIydDBVS3VoUk9PQ1g5cVRobGlqZ1lZWWhDYUN4cDhrQTFUM2prUWZ6VW1v?=
 =?utf-8?B?S3k4dSs1VzQ5UERpMlhlUy9NYTJUK2RzYjZNRVBEKzAyL05COEhlUHBtY0xN?=
 =?utf-8?B?ZTZWTWxReERuY0RsVk5tWlRHMkc5c0JvTzlxenowZEZheVNkM1dYTnVuTW5a?=
 =?utf-8?B?dFBnNENzREE2ZFE0MlE1aDZKbUJ0bXYyKzU4dUJUb2t1ZUl6Wjd1ak90YTFT?=
 =?utf-8?B?ZnRRaHg3aTZhWHZqcnFMdmpuWUg2SjFJSUNyaUJYRGQydmZIT3RMeW9veXlN?=
 =?utf-8?B?S2ZXTHM5M0lIOE1KckFHN3pzT3VvN2Z0OW04dTM1UWhQSGJQQVBRTVVQK2dY?=
 =?utf-8?B?T2FMTm5zd2ZGVWtOQ016WTMwNHNzdHlIekl6OGU0dDBOSGFoRVgremNyK21C?=
 =?utf-8?B?U1EzeGFhYkRoUGd0ODhPbkJpT3N2V0JSL09FV0U0RkJwNlpXbEtlQlN2YlZq?=
 =?utf-8?B?MUxDOWZwK0xHQ2JFTExCWUxtLzlyQW9Nc2MxUGp1dVZGeXJFUW9kODZObWtS?=
 =?utf-8?B?U0g4OGUxTVQzamVzTU51TE1KR3I1YlJHamhoR3JoMEFTVGVpV1AvR3JkR25i?=
 =?utf-8?B?S0w2eGZIRE0vWCtjNUJ4QjJlZlBlWGlha3ZOeG5CRzdubnFES3hhQmt2S3BO?=
 =?utf-8?B?MlVTWkpkN1F1V2lYQWRrUldCUFR3a3lNcGkyUWZyanFEN1UwcXVrK1hlWDMr?=
 =?utf-8?B?eGdvMFM3ekM5Vml6MmtBbTBKNTk2aDhuVmNOSWxhRU1WSS9qbUsvWU50M3hD?=
 =?utf-8?B?ZmZOYTE4bXlQSEdIWGlkUC9ieUN3aE5BcW11WFpCOUdQb0h1bHQyQ0RwckRa?=
 =?utf-8?B?VCtWVjVscUd3WlZrWXBBSXZyd1JCNXdjajFWUEJMUjZVRnVrTWdOSDFVeXk0?=
 =?utf-8?B?U0tnYm5iaEcyYU9zcXgvMTQ1K0FIZWw2WWxQRWhlRHNBMzIwU3J2MjFjQnlZ?=
 =?utf-8?B?aGNFOXdGZ3pXL1VVc1dyd25waXRTS1lXMlFMMHQ4bk9HWkZkZVB2bVJwd0tr?=
 =?utf-8?B?bSt2Y1Q0WXYzSHZQNWx1TDJuUG80elprbnluVDlGUHh2ZjFHQ2Q0a0xZOGZK?=
 =?utf-8?B?N0pxZENqbFhFd0d1bEQxK0cyeUsxVzJLOG5DN2Z6WnJielBCbTMxUnpTdysw?=
 =?utf-8?B?cms3TndxZXUwdGN4blNYZzFDaXBYZDhsc2NOZ29pSERlYjQ2VW91YjRqSFlD?=
 =?utf-8?B?cWJMcko1UHEyeEhXenhuRXBETS9JQ1FZYjFzUW43ZWlEWFN5eW1mVVZva3hj?=
 =?utf-8?B?YzJCWmpHQjgwY1NYNVVWL011NisyK00vNklGNUNyR1pUanJlL2VUUGV6QXlt?=
 =?utf-8?B?NkFCNGdMU25MSm1Ca042MnVnN0MveFE3bjcvNjZITE10ck93VjVOTnVlRnc3?=
 =?utf-8?B?ZFNWcUhDMlVxN25IdjVKb2lJblNXVzROekJWajhUVkpERFAxYXQ2a2dBNHpV?=
 =?utf-8?B?dmdsL2R2dWI3aHRaSTJ6dEhpM1ZiVm9MY1hVM0JVWWZyRHl5NVJjMWNIUHJv?=
 =?utf-8?B?SExSem1WRnU3R0NicGJkdk52VXdpMkhUUjZqbzhuaUZuczRaYm13TVpBQWtH?=
 =?utf-8?B?WjExQWtTRWViUHpWQi9sTTNLOWpmL0haZlo5NWJ0eWF3THlZYTRVNGtNYS9o?=
 =?utf-8?B?TjlQSzdKTHlwbmdYN2psZHhaaDY5aHpPQXUvSHIxTTYrTUxoZkxBbzFkcXNH?=
 =?utf-8?B?QXl5QklJMjV2UlpsS1dNNnZPTGhBalZXMFZZUGF5dWtQSllXQnd0dXhldUs4?=
 =?utf-8?B?WGl3eHlBN21PUFlKZ29zZW5pUkl2LzFCai92TENZRmV4ZDhOQ3hyMTgwZitG?=
 =?utf-8?Q?wgqLe3uYc3oW6GRIDphULIkjh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc65adfc-fdc1-4f44-2792-08dcf20c1248
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:08:04.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUlC8cRfjyuzpJ0t5YnrrrN1Hu4s6s9NcJJMS5gHbwrpYctWUYLTdaIi2LGQj8Kwi/lAtSdRMU8QBp7yVdCnGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6882

Add support for i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
Endpoint (EP). On i.MX8Q platforms, the PCI bus addresses differ from the
CPU addresses. The DesignWare (DWC) driver already handles this in the
common code.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v2 to v3
- add Mani's review tag
- Add pci->using_dtbus_info = true;
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bdc2b372e6c13..5be9bac6206a7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -1079,6 +1080,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
 /*
  * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
  * ================================================================================================
@@ -1448,6 +1459,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->using_dtbus_info = true;
+
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1645,6 +1658,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1674,6 +1695,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };

-- 
2.34.1


