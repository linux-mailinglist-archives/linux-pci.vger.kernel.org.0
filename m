Return-Path: <linux-pci+bounces-34387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A621FB2E0B4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5A45818DE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B404322A12;
	Wed, 20 Aug 2025 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nJh1zVD7"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF82773DA;
	Wed, 20 Aug 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702258; cv=fail; b=eXQWSlhzhsb4Ps9Cmpl+s7XbUhPCV98q38Bc7O/EbDv2fkXxKqfUPCOdDNuPqltNlsWONaWbFhF5JVw3RS9LsNqezbK+1CEJyqIDZnCJJWWpggmHWhN3k8jGqksRlJoshS/33Xczi8sxlTqMg6+CNgKQqL6qNaTXSG/ZY3aLXCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702258; c=relaxed/simple;
	bh=GF8kmL/+CpKP42KOuETl7QXlmCDZmjTF+kw8rPZzMdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mYxvBDWuVMjGVvGMAbm56Zr2TMC2PwaQ/FYB3Li8YasOalb9rmJveXnCsPdLNXG1NQoykzAgjPIP16nAqPHeAsMBC9NiPsyumnt9ryeJj3S6ZhoZanx4+SQMXy2Pc23seP2VeUSrcxde+ZQNePc9t076BzkRGIhqwHv1eQAJYT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nJh1zVD7; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OA0ybhQdslisgcP3aapG5j9icUzfEcWPZHoFRrQpmFzXe1xrPQ51MGhTTm9kqBljx5mLPJBHvMZiKE3jO3OS7Z7DO6NQPpO/03xcJGUTL6JbGOD2g6K6fvxb8yGrWMYw+hYkI/v2el7abKrlkbY62M4MwappoHH14Vv3oZDjJUA9evGvhEDUMCd6iR97g6YZkYneCGy/2Aea8NOdv7/zYULc1dJ+aiOwOEVZXkBfEs1CvFSQxhijP65/9g1syRloywQg4ME+zk8Fzl65W5n0ypYUGiMqzHCvOIw5V2nLlxD1tqoAlpGwAOixV+LZqLdjtvFrVLt1y8Ad84tMh4AwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAVtJCz9hj861a0/av5zeX8q9iPSvyX3Uw11B7ltlqU=;
 b=FpsY34C+CfQKWGLzIS01NEx+Cx6P7coYpUNiqBnOlo8lcMjXpiGVzLPYTqfnxg+A/y5rReb2KZciRPJzDWQTsRyv+1cdJP8BMBNW2pQRiZcut7FCUOFZawMrQXf0zuoDkNQ03XAejqi5ctVj1Ccy/o+y015viJ7+9hZ+TLg0Asjhuxw+aux1k9VPF2Z9EFfuNtnMFJVn/ImO2/TYKLWiUpQLyq38ZFdv3dtEau9PtNyak5tHNM6LMjdpVyJLm5OBWaB2oQGUJ3mXhpf+EYFldbXwJt49Zi4EhhpKQ1qgBiydQHiCP9wck4x2v//qLT6CbQVhofbyPDD7Fl6SeMwTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAVtJCz9hj861a0/av5zeX8q9iPSvyX3Uw11B7ltlqU=;
 b=nJh1zVD7DYo36ZCr4XWPwfGnKm6Vm/aQSl0IIBnXQB/t5QRksqowNtBF4e+jR6p03zY2cpvyKKOfZOzesnpK44Q+EK+sfmjyU7PiSm+vy3QD0ACzo1r7R+pCvqZS6dXa8zQJhm+N/smxtvPXzN+6aJ9RzwO9eAJJxhwgfyPWUBJ3NP6K6EEM9j1sjSopwSxkWtDdYn+sE5YijL4HrKYv60pNGu0N38GXehzUTdatHuW9TNmJFFpuwRwDBIGwZZ/co6kSWyq+8dD3h2DFg5cOluxVHeMeHZynxQpH9lo7tB4xyOLxofJhPVG+mpcpAnn/XqLURG3dqVOWQS3qY7PnxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8698.eurprd04.prod.outlook.com (2603:10a6:20b:43d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 15:04:12 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 15:04:12 +0000
Date: Wed, 20 Aug 2025 11:04:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: imx6: Enable the vpcie3v3aux regulator when
 fetch it
Message-ID: <aKXj5IT9yEWYn6BG@lizhi-Precision-Tower-5810>
References: <20250820022328.2143374-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820022328.2143374-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH8PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:510:2da::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: d754a8f0-ae0e-4f81-8e47-08dddffad1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tDCwi+vQ/nmON968S5WTZli85IO9Tm0IycjBHxrcwt2RCvC8jB8x39se1sN9?=
 =?us-ascii?Q?cF4RkPN48SxGO1WfuZ1rCbAZmcPO9dOYl/JtIPtz8/hUkkzcManTQTsTh6Ox?=
 =?us-ascii?Q?dZ2uGxj2i+GxgzUi2aUmjg7r51J43MxH1QIGtTBehieEm9lmoKaSTuyW2+JW?=
 =?us-ascii?Q?KOVp30YGnaKljhTOyJJ96Pqqf+1hz2Z2reHDRUeo6dDK0ue237wdDx73wtaw?=
 =?us-ascii?Q?7uNnd1xP4m4KeqaMZ8djnzHNuQjtOkLBTyYRyv+kLOII2wDgX3yT8iY01W7d?=
 =?us-ascii?Q?I41A/T99ipxtE5rRkVzlJTWJIrHD1d5trtpyKbPhMGug2iC1XAA/LK/0Cu12?=
 =?us-ascii?Q?2IazKo4UpuBs36VcX2CwMa1ajwKsAKz5RIBqeq2cCTIVn0Dk24oKnYxQxZc8?=
 =?us-ascii?Q?vupO24hW/2fKgIjuB0O6wPMyfXb34J1K1bas+ebqJUni0jHStvMo0xx1Vg0H?=
 =?us-ascii?Q?bcf10DELlSWdrzaIRT2IyMGdKuwkibURpD5eCFjWVXhQ2PMbmi6cml5wg70w?=
 =?us-ascii?Q?GnBio3Vb/OA5mDa5q5kKGjxob0xulA/diY/Vc/Qdk21u6x22LjpV2bUucdk+?=
 =?us-ascii?Q?5jK76fZNdyJqBwW8zfmc6KUxvhhJWIQ4q7ceUVoNT8fqqrUcyvMa2F8MwiRW?=
 =?us-ascii?Q?oazLQ2SjzoxsgnMafI3I7q88WoIRQ2DP/M3FPiyEqYfQpKtG5in+EmKZKFfC?=
 =?us-ascii?Q?9YFVhMylAF9h7swqDgP5qUNQOdQPrp56cgr0WoKSVoCjeuyZCh7I8hSpbhRu?=
 =?us-ascii?Q?krdehmwFDD6EgnH1EJV7HsxOgJ9aZqCOGj+hGIGLuf3VpQe/8JN7on24CZr0?=
 =?us-ascii?Q?HhzWY+w2+Yiak0sxOPN/jjFHRic10R22oi91xGKwYq3u4w8EDc+si8dJsTxy?=
 =?us-ascii?Q?hQJlO4uoQjCJ/RfZIgOr0j7KCROoaegoawFWbrBhf8T7kfcgkc8kg1SwXiZV?=
 =?us-ascii?Q?4ZXj7JPNeDMrnuwmiqBCJvmyipPQLjmeqItU85KUD+CcutHNN5ArDPckI3yL?=
 =?us-ascii?Q?yMqm1D3Nayk9cv4djGVW5wlOVl1XY4THX2waaNX7UmXDFHxTErWlaq9m9sD1?=
 =?us-ascii?Q?jRenR8SGTBTPxqryFKz159hb+uJ1oNLvjBSxtLgH1xjCXx7YBvoVtpCl0jco?=
 =?us-ascii?Q?OM4Db8OBtjwIIjk34FuXCW7gDMpU+o8Kbgm+ddVB1RVuVFCd6bn9bMZWNN/n?=
 =?us-ascii?Q?b4cjyzWNjAVb2epDk9lrjWtVtXPkP5XR14GhTSkE5jSopEnOvXa24uyj/wWw?=
 =?us-ascii?Q?p4tltCjWqvEOYEwyWrTiRSCso4NgeTbCNFSSN9La7rj/bB26S+gtjQCRqS/k?=
 =?us-ascii?Q?LPGzwqrwSrE+6BuFHhkESBzZF5OWfnEMDcybEAEW3g6oEOxH4pZggjBpMw4T?=
 =?us-ascii?Q?lzXecbPZzPeGHWwBOxHbIov1T5PU4jsHRTOuvVTuG7AsCMUCDqp5j46E1J0Z?=
 =?us-ascii?Q?cFhW2aPSQ51f4SYD1qjQflnz1iCvHSbHvXubk3WM2d5LoePEmQ9shH+rTyVo?=
 =?us-ascii?Q?ylSWeB7E/VGWMuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ebxpT22WMxFxo40mUYaj2KMvcubWtgODm0LKeXlSHh8bi/cLaIVaGEls1qVy?=
 =?us-ascii?Q?ksQKyDhK7+BcSvEwQd+8FYArnhwodsJGpBHkWkV89J3m7jadxuhlBFE+i5jT?=
 =?us-ascii?Q?oBEjnHjgGFlG8F9YpdATpsWfarOohaApt96RhoGqWE+v/T5cCxXDOlPycfRk?=
 =?us-ascii?Q?rrFrIjfzx4AgY1VTISoFXEQFiCb2CQioR9OFmBKACSpZRbNG7yuXm3n6lOGv?=
 =?us-ascii?Q?AkvKvWF3OW77qUJ1hyC6WyM1SCDu6JvBuL5iVhBDhN/n7hB2i3skhw/Rtmmn?=
 =?us-ascii?Q?ATLkzcpVCCvhWZRprTeAl99pXvqU7N3hBseOmkSAoLXFJbifyTbEyhllb/tb?=
 =?us-ascii?Q?ohOQTGvF4XlsFFBmjsdpI7hobzxEz2aZuvyuuQGbqUFeM0JD9AHqVDd7YahZ?=
 =?us-ascii?Q?ioXYTDZ4fPZtrKEpvRVAXJrOdDgCsK/yTuyJMXsfekvHXCmP47quIO4dLc2L?=
 =?us-ascii?Q?NSiezIOlTrESZDiORYE6CRm4/NQANSfeuq5VJLdddzpZL2fB8L1A7DplrrQb?=
 =?us-ascii?Q?vwKMj+q9e4uu2PCwWjhnDZP35YfjEdjfPgqPh/rPqutdqjsjdHFMQSgJZMkE?=
 =?us-ascii?Q?MroKo5ml4ZGU6+VZKaP3OFJDj7Un+uUCqbRQa/WlM88wHrxj5Bg09ro0lk11?=
 =?us-ascii?Q?/MMfl5bHdMgluw7IN2FUwPrBZhu4iTYctMPgGpczK5xagZu325dH0ZfmzNuq?=
 =?us-ascii?Q?DfienzMmO+DNWytf48knRk/hGQm3MDjkuRMlOwPOF6iEdJczbpqUMNsoVPGK?=
 =?us-ascii?Q?25mqynbx3zVSSv1aBAIlGQQjfQ9GSwRv3MDXz9xwFDxCoTTv57wbRQPfsUDm?=
 =?us-ascii?Q?chnpYm6/eUQF9u0CGEIuEygJSyyldNlnF3GTLdH+wCaTrb3OqOG1E2e9vVXu?=
 =?us-ascii?Q?ZLmqkv/KUl/biwVD11qxw/UKwAt1RJ7SEXLjdPhbBKNDWSwO1l+NTLdo23Ry?=
 =?us-ascii?Q?AO1D4QysR1JUYnuuyja4J2sVx6JDXvcVMYpz2Wru+KKvVRomJIE1FtxZKpKJ?=
 =?us-ascii?Q?QhfC7nNL/A49nz0Aeypm3qmQMk8lwm8QGAYNPhzGrmae7mrH7ZFzkB7Jym+K?=
 =?us-ascii?Q?sjK/Fk78Sjg6lRa2xsVz8oM76WS4RVhQgMZNF1dOgbxU3/0/cRBPXU5/hEfs?=
 =?us-ascii?Q?ufllzqAKWWPtFrgUkZy0zqm2mO6BHXM1UGzr+wEk99BZPqbA6V6GO3tN9lu9?=
 =?us-ascii?Q?nni/ewauZLw7FmLxPf+Klda+2ngsFyitpP5aLAqHGdSzVU2QYXzbZQFyTnam?=
 =?us-ascii?Q?kFDaMt/L/V3C08tgWnQVguLtbUjz2JVmSN9PdvaQrd1UI/AR4hfJ8o0hnqgS?=
 =?us-ascii?Q?sC40JVV5MCeIQhbSpAgnDO10cgrzgFijOOy8/wvWW7sZl6EbHD2zu2O9cPQa?=
 =?us-ascii?Q?S7SQ5RmsE3gwRd21p/UV11i5COvverHCjBaSR4xIE2LItyXxU7v1QxaT+tT7?=
 =?us-ascii?Q?N+IGr5oZO3q//pw4mouDHwRo6TcxlblK0VdBT+X6+lBBJiv9+0z5ZlWy/GQl?=
 =?us-ascii?Q?cHccvAEJM3m1Xk7RkBrZLFqHWwjif7zGghpz7C/SviZrAALHMkC8dz6ukygq?=
 =?us-ascii?Q?+10MlPH5GZnQqI8Jq2IEi0p2ZXjEr2DdBMjpCawc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d754a8f0-ae0e-4f81-8e47-08dddffad1ff
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 15:04:12.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5vGT8RWPOOZDn94xEeFvYAlEWdp3OKxicG15r1QhiWmmZc/J0L3wLdo/arHiZKNBbU25IhzGN89RWOq0tLiww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8698

On Wed, Aug 20, 2025 at 10:23:28AM +0800, Richard Zhu wrote:
> Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> asserted by the Add-in Card when all its functions are in D3Cold state
> and at least one of its functions is enabled for wakeup generation. The
> 3.3V auxiliary power (+3.3Vaux) must be present and used for wakeup
> process.
>
> When the 3.3V auxiliary power is present, fetch this auxiliary regulator
> at probe time and keep it enabled for the entire PCIe controller
> lifecycle. This ensures support for outbound wake-up mechanism such as
> WAKE# signaling.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> v5 changes:
> - Use the vpcie3v3aux property instead of adding a duplicated one.
> - Move the comments from the code changes into the description of
>   commit.
>
> v4 changes:
> Move the dt-binding to snps,dw-pcie-common.yaml.
>
> v3 changes:
> Add a new vaux power supply used to specify the regulator powered up the
> WAKE# circuit on the connector when WAKE# is supported.
>
> v2 changes:
> Update the commit message, and add reviewed-by from Frank.
> https://patchwork.kernel.org/project/linux-pci/patch/20250619072438.125921-1-hongxing.zhu@nxp.com/
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b1..5067da14bc053 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1739,6 +1739,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie3v3aux");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable pcie3v3vaux");
> +
>  	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
>  	if (IS_ERR(imx_pcie->vpcie)) {
>  		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> --
> 2.37.1
>

