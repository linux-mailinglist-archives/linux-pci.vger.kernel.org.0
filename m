Return-Path: <linux-pci+bounces-13448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A24498488A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 17:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDECB286018
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7BAD531;
	Tue, 24 Sep 2024 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kz4/Low5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595461AB6D9;
	Tue, 24 Sep 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191406; cv=fail; b=UcnXXJKkbbknfQmiy0bkPd3q9To1N9fQqfYmgfP710sLqR54qp2iW517VGZfmR8ah2vF8Tqcd/tAaxHtpb6/JO7C5FosWAxUmm0WGerDtdvhMSjMz0BQ4qJgFwSTwDF6OGeLFcCyzLuMZ7mz3Ans987sNX2qQqB7OFNaXkfFoes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191406; c=relaxed/simple;
	bh=4TZpAVrhwHZkdJBJ2PyNAuWVVRAo0VqXDMh+iNl9c/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pTH3N6vEgXDGFc3qxHT74o7wZ9azSCxPJlUUOGB45CHM1km4+WoULocTwBrhYsD194j4UwECRkK1QH4+hAykJC1LaN+6Ys7IlMYpazzr5O1I42mEhp82i5z6vegl6ozalGiiZ1DBVGU5tMMqf4KQ5Is43HwproO1YNiYrG924NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kz4/Low5; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ8iFh5T68tWIj3m+80yPlUQfgx+nTqQaeKg8i1wPRKLuAhhGeOYFuKPFjfQbRW00bcChSKuft9DbpL9j436r4012E+LZ2GO8+L9Y6C91IeYEfrkxakNTiZmN2fAyyBbCsf0d9CEj0XukjmsYDUiojWEff5cK1DpE3DA37IAqmcDOStRew21aHJlwB2RU4K0bv0rL0XQKhSCW2sWhRlc1gH0mci/SESSo8NtFZLFm/mM2yswGb38QnpndD6KjcIj0eQX6viQ0EcjK6OFNIz+1oM+CREKLWiNEUDnAeiVNUva/JBByabDWI7mRm1G5Y+fFKV2Anq4PB3VKc1dnzRoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TZpAVrhwHZkdJBJ2PyNAuWVVRAo0VqXDMh+iNl9c/g=;
 b=IjeUqzGHnja7FLuYqg6SKjxzX0G3fnGD1tLhQO5tWFP2aThYwNp7nBWlfR2xX7yoW/DYKxEpLpznWIWP3sgNBa4rw/FaJDHhbrrILXZtBXqoUO9XD+aQzmANWVdOEXBo5BS8j3jkubY6Tj1Svd0B66SRhbaS8GcuVcODE8ZvwPOnyZFzIfx3D415W5OkP12jIQC/KJASsKvCL/ghg5QKi9XFqUzsLL4inZ/IWm6CTCpFHr1/HusikrYRFU47CthI0vwcyzwJIi4cOpd3O1AiBXx5yuHXP23eDswhT7ZfBH703wmYJJT1xdpqGm5kdawyUE0cQI9hF6EO4Yga+FAuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TZpAVrhwHZkdJBJ2PyNAuWVVRAo0VqXDMh+iNl9c/g=;
 b=Kz4/Low5PFDaWc82LXaCwOfLcvTWWS9qSBAZ36UBmyffR+VSjjQAjwbHJHbtN8h0yq1njsPUJPEXpJwHKOT2qykzpWfM0KGLHGC2Yyrfgda1ElO30gKwmoN1QGHMXSiYg2ekaNQBaEnahdl7ramhNI0O+TPeCQ8EMEdF4rfYxUeEorqkpeFrmjX+Pjvm9xdLze7yYep/NpRg89nh4Mwphrvk5QMXvaQhclzGDIIJhNqDG8z9+v6/W21bmJdpT6UAlUKTJT9hg4fH5Ixo8982qhfQvk2r+VK0ld+/xT2/hmjw/l5I1qzg5RLCC9vRpIlGF2ll+rmEqCceUa0h/rWHyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 15:23:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 15:23:17 +0000
Date: Tue, 24 Sep 2024 11:23:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	kwilczynski@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v1 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe
Message-ID: <ZvLZWqRFnAtgFo3B@lizhi-Precision-Tower-5810>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-2-git-send-email-hongxing.zhu@nxp.com>
 <20240924-ended-unlaced-cc7ddf87af90@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-ended-unlaced-cc7ddf87af90@spud>
X-ClientProxiedBy: BY3PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:a03:255::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d1426d-44c3-4695-f4d9-08dcdcacd0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qGBure/UFF09csTgJ5ssLyRGnDW+bUoFL6SxmUQ1oWpZYzywCF3I4nR8mzc4?=
 =?us-ascii?Q?TIb559YjnejHAE5UkS2IdPKvRFKdK/pjrWhtpRAv3SMOmiTlHEcgp26BAzj/?=
 =?us-ascii?Q?fY0wc6wzZZMFXfnQddytFkUV5fOMki5H5h05UWJr9hev4+NrXSRN3IBheVRx?=
 =?us-ascii?Q?E/uxJ6m90BEoBVFKOXqLWtyQIq5TB9/1E33MeVOfT07DjCv6RPAXhcW4ZgoD?=
 =?us-ascii?Q?W0qV94XLB0r8h8YE37+KlrBIXNMsXTYEChuUfHkKtGQ0pT8wJX+KHlk7jjgb?=
 =?us-ascii?Q?Q/dcI9CgExIttWOKAgJ2JHGkelY1E6TrHN5vTRBby5MeuYzFnMWye20jUmR0?=
 =?us-ascii?Q?ksfvLPtULyaO/9hK38okZN/X1MIzRZVQFIsSTV4BUSNqlWtNXkaRqNP4qjoa?=
 =?us-ascii?Q?twW2buvWPm9XRTfUtP5Kd5f4qE9Wpy7UQN2C252CvnmofTukKQId1eM0Ursj?=
 =?us-ascii?Q?J+knQNQ/XgJyJhML2+vvcxmhCF33uA2BWZgsgy9bBLRRuo0ehmnRomPsX7p4?=
 =?us-ascii?Q?quNjLj0DKany1DJCkUIkyX6xJ2c8ES4AVErRTIHs/Gzq2EyARq9Kfe8++Fli?=
 =?us-ascii?Q?bCm4cfbTepCYBR/uBwbrO3O/MxhLK4faJKeeL2ilVV01hZXrmQuZg79gsDgX?=
 =?us-ascii?Q?wth9MU50zAEdvm7jskzYEXVFrMVz+tRgLv1iteqof1lHs9XG/khjNBqMqW/H?=
 =?us-ascii?Q?rL3Oy792Yf1iFonHCcWQTmAY/NAa5+WfBuQGNrofNqCD3/+lWIHZt9Fn0yOG?=
 =?us-ascii?Q?GKbBQRE9GGJvLMV4M2+cRn5wfA0UKN08uVtLRe++KXlXjgRuoNeFaxfU/ufr?=
 =?us-ascii?Q?Zc4sSVf4NFxTwIWwa+C8rPoQQhH4AtkLhQrQZTVcSLQMQYn1Ch05CB/Z1EE3?=
 =?us-ascii?Q?RDKJ7qb0Oln0y7F0ksmRv2nu/tGBAftzzMoYGZdnpRWciDiUNR8+VChD0Ym4?=
 =?us-ascii?Q?S1pNjhNgJ9O56ZODc+nE4eYx2ynQ77A4oFVkiG7sz24cNcny9x4BzNlZJ6p8?=
 =?us-ascii?Q?uWi7ZrXFz56bX2VJ9FWsqevm/xU2POJq8sP/0kCmFge2gLCpTE320g39p8vk?=
 =?us-ascii?Q?NpiCt/Fm2VlMmLbdc2hm0SqVSAL+kKVCQK4BBucoYDoan2F+JkpQAxjSPZI1?=
 =?us-ascii?Q?DDIoPs0UxBMdv4pNQ4E2h6vwVO5xzD84xiFqKY4+mWLXhLUeYitklNuDPNIg?=
 =?us-ascii?Q?iDEprNXC4WAU1VZiEagm7B1BM0PKFbwjaxOoBeFMwQymen4zIRBNe2EH4cf3?=
 =?us-ascii?Q?GdQdOnteKLT3lORJvx2XU58N998LwWrBUD1y9BVCElVZj9PAEC9uWBWE1ubn?=
 =?us-ascii?Q?BFqg1Azh8fYLdM3IcD1TMTD5KRGdI7oc1c2hii3boiC+cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iEfocwVFdFK1uiQcW+XGTzkzfscoc+e9SkMs1oFSrpirJWMhXFxZmUvan3dw?=
 =?us-ascii?Q?A89r7iVPeSjmeEJusUstnha50UVQ8BvidcsTmhcCRb+GGRrxDpc6mTRT1tjn?=
 =?us-ascii?Q?oP1VEzs6bK+783B2TPijD7hlJR8wUvgD7i63L+tqTQdmrg9M2s47fY1SonZi?=
 =?us-ascii?Q?DY47M+v9BFO2IijC136AOE5cogfkGXtKEPSHGGB+/tb5KEhnfwRMn+Nnd+Gg?=
 =?us-ascii?Q?B9BCGfl1tK++dEKDFdPVVeBJoPX/FE2nLrJgikpoCiNWGoK5+2Gn/yGDf+2s?=
 =?us-ascii?Q?VPTA9z8vh1EslyalTyVXLitmBhpbRq5XM9yR+HKYLBtlfyHOfXMqzjzCR0Te?=
 =?us-ascii?Q?V34Xte24U7ny8xT149D97Chr/igg7VbdZd1MnXTx0Jcsd2tGZy4+a3w2H/jH?=
 =?us-ascii?Q?UpWBj5r++byrgMXsiV2sH2QuWmUfhvZiZTjH6vOhW5bOiNRbZMaAgWcjLkp5?=
 =?us-ascii?Q?WiS6rcl9IPjMw4LpW2fwGpLMU8L+/s0zeJklYiwHi2bi58ZYzMzK6GLUJqX/?=
 =?us-ascii?Q?EhiL6+Nc2Nsc54ey1UYvcwKieDs1Z7VLP85KmtKWzZisfxvFw0gjZGFNu3i6?=
 =?us-ascii?Q?OzPtXTaw/QvdjYbPT+HvAy+mLPKGHYZlm86jTrIgEghC8uMLRdwDT+xkXAw7?=
 =?us-ascii?Q?rXgYLWebLX9O80BjYNozjcg9u0r+r3gRJo5aFdjJ/9RWxq1SVHsXhO1wSRWV?=
 =?us-ascii?Q?0IjLPIKvfkgmj50O5pwxL+9+5Ka3VZycm1RKkkqaMREhYnTiHfoNlli7SHrF?=
 =?us-ascii?Q?Kja/CybD14C15A6qDx+Foki6/KyhJiCEuifnbg0g38OFWyYh7rp/De3QZcAQ?=
 =?us-ascii?Q?iFfgbYStKXNL93CSiU9YV43AcblehobW9v27vOsG8HEeDIRULOYObJImb+4m?=
 =?us-ascii?Q?6IEOnS19rcl0m/DXOr8K57v1pBwlLnW1px2jTko8vRj53ymV+wTduSOGFVXb?=
 =?us-ascii?Q?0gemRhArMuJkbIBhRvcTjHQUdNNXbRef0d6dwpakd95ycbpuiSCj8GQL92a5?=
 =?us-ascii?Q?egOB/oRvpQJkJ2JSLQEkqGDHFlqzNzYwDS+qNKD5BqMSFeEQEzFd5yAtYvdC?=
 =?us-ascii?Q?wTodZV99synAdGrZ9tEa3ULK1JwUcg/JkPdZijmjk+B6lwVSo8qa6JJoP7g9?=
 =?us-ascii?Q?YKkL3EckCz89dZ1PTp+l8Os6iGfPNTQXgJj/6zoYCh2jLKVOYfL8UjTi5+Mf?=
 =?us-ascii?Q?qHa4Asqeb2r6Q6wN+GKCFR5dLrZTg5kpgHrcUiDyz4u88/z7Og4fwskPlgAT?=
 =?us-ascii?Q?br5FG3iGZ99IgEkSMBjp1x1UaV017j0s6R29GMNFaurS295MsBETIah9n9Yb?=
 =?us-ascii?Q?Px9YzLDmbGdGH+4r/GXD7NDhbA84l/8/enC2f3m9pX6M8rlsxrlWL9iQSpZ8?=
 =?us-ascii?Q?2cZjnonAK4F9qijgKQmbjcOs+Ts4CDl6Qkdh5o2apVvddhjMOHw83eo7Ak+F?=
 =?us-ascii?Q?yRWLhMM4fCL2t+sJKlihHZLzFTfB4rtwU2yjCAquCJlxl3/PoQPfqb0RIf31?=
 =?us-ascii?Q?vqXidXREtMF8b1MfAVFZtyUzBcLXk9EpW4CqYAoEBg/qq1gsi4x+RO3nUDSm?=
 =?us-ascii?Q?H90ZMWRSa0Ovd62PI2Hiyp7NbZbEDUWg5Y4TdhkT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d1426d-44c3-4695-f4d9-08dcdcacd0ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 15:23:17.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 906+pRakrIQODf8ZwYKZ/w2/e10AGgs4u5Vx6zDh6q1uXFGe+DDcnht5ACSN7yOLAJL+eRFH/Jh9/Khba2FsyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031

On Tue, Sep 24, 2024 at 11:08:20AM +0100, Conor Dooley wrote:
> On Tue, Sep 24, 2024 at 11:27:36AM +0800, Richard Zhu wrote:
> > Add one ref clock for i.MX95 PCIe. Increase clocks' maxItems to 5 and
> > keep the same restriction with other compatible string.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>
> It'd be really good to mention why this clock is appearing now, when it
> did not before. You're just explaining what you've done, which can be
> seen in the diff, but not why you did it.

Previous reference clock of i.MX95 is on when system boot to kernel. But
boot firmware change the behavor, so it is off when boot. So it need be
turn on when it use. Also it need be turn off/on when suspend and resume.
Previous miss this feature.

Frank


