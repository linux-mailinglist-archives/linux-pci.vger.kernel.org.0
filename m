Return-Path: <linux-pci+bounces-14943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1FA9A6E0C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 17:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AC1281261
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD9D126C09;
	Mon, 21 Oct 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Agt3w6QI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E7132120;
	Mon, 21 Oct 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524383; cv=fail; b=muXVu0XTxaRvxB6MIsSp82GuPAnQV2A1bVsjxxBF7Mdsa507Zswv1zCnhb3IQtC8otTFOK+zqLJxxiHrKMot1ExU2FOMdNjFuZmyAO/bz2rR2ZBpbuBSPhl2/vBc6vi8RkfFN0Di8kZzULopqDyfEbiGQ32wLKg0qknrr1/miA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524383; c=relaxed/simple;
	bh=ljWyYNtLfRqyEXmKfb2/G6PuEfsIttPd/FTmbcNP3es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aFU5nC1ksGyQTgwOF3L5mapOJKO7+zHrg1WYo8Fqi6XIiaAyO6zqfu/2fAswLVkPgkx+CS22a1lAj73qFgSA+5c+l1xnQvXsgm0UmZlEjJYJLf2KK5nax6XwEk3X5XMfmLhK5RMLjheoJdHbW0FfAFvrjG9WxiR847o9EoNKWzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Agt3w6QI; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbn2aPd2Uc9khaih8HJUIQYdcqnrI6Kefu2FKLqRdMtlOMmc1z2Lco2IjdkT0HFHrjELE4FYecd1Zp2dwmNLxeEExQ8oqMih2bdXccB3YggLO6JuCCAOcxDnm5bL613uWpKMe+sJ7VQr4xi3A91DEp+8VuC0AyEN1kzsggnD9l7e2mndt9aR4nXXbriIuYYsQg0fr2RnhopIciwjXHJ6AXFL3/fP/XobxZENXY94+jbsa6upnbYDv4S8Otp7pfAkfkbKjqKtCoXy+RhCTwLn4s8fDg63zXg0XHtcn9v6jN6P0IaVWjiqOrb2Sytvp28c1XwKDHDFDPyWzA0/4uav5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPMaczac2JD4D0PzAgylR3vwiinXQwDVi+d0m7RVY6M=;
 b=WGohNmW0gYgVdOpsR15cI6u1+u/rKmoHBwiABLqvukC1MlE8kirMSlE90xqJb/qdyXVzi8YfCVKrSwNO8NNJSm97wTdD0y1KdXu3BiqzusW38iupJ3OOJM/6YW88zTEBPYODHF2vXEO7jrkdoemkhNAN3UbmH1nfo8AeY0j0LUsua9S5E8iRzlZSpq9O2t/d0IFgeIQmwalxFd/gpt1qICa32najRflH2W9J2JLAMAAa3ky7obozW6hbn+bwG9YAYR2kLkbFdUHbmyhV8HKIIqIyidxb1y3nzFgOeabfQp/poQ2wNyT4St0j6+g5tOJ5HLLMm8+kFHdeExZpxL2xBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPMaczac2JD4D0PzAgylR3vwiinXQwDVi+d0m7RVY6M=;
 b=Agt3w6QIh0oSzEl7Flm3omvowBEcTzdjnJhuEWR4f/bHqKQXAf/qehp00cN+4/OJVf9xcmh/I/HAIRokKoALdUyhCzj0afxjuxFKpxAk/JPXvSD/JPH7m6Y16ohh7WUocWiwblHHkZx2JtiHxGLh74WLej53FLEk0yi6gjtDWyxqSJyPnpiDUqs8PqxIa5iD0ro3Z5CncX3pE21nso9eFpEq0of0nXvm9uCBZ63uic1JgaYuuQdOCR2Xtu5vgdF538KzdOquTT4M6DxaTCxUaV3FyQ0NOg2ahpnRx9zEqeFO7Cv58lmOorID6fpMZVNck2uj5WTvI4GE6tmZ9rqCTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 15:26:16 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8069.018; Mon, 21 Oct 2024
 15:26:16 +0000
Date: Mon, 21 Oct 2024 11:26:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, kw@linux.com,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	lpieralisi@kernel.org, l.stach@pengutronix.de, robh+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe RC
Message-ID: <ZxZyjLnSunE60Qo1@lizhi-Precision-Tower-5810>
References: <1728981213-8771-2-git-send-email-hongxing.zhu@nxp.com>
 <20241018231305.GA768070@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018231305.GA768070@bhelgaas>
X-ClientProxiedBy: BYAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PR3PR04MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc0e3d2-e9b6-46b0-cd57-08dcf1e4b3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GR754dkt7pF3N/xkLPtlseFpWBTVkxMqCGAXjiWADxx8jcXk2XXaaTl8WFys?=
 =?us-ascii?Q?3Zs8V1P7B/L3Eme9t4K+nLS/s7vsD+ukJV4HixVH0GkenSaX2SNrmmepH71f?=
 =?us-ascii?Q?AKOoyfdJASATC7UupcrvQk7fR3sBKlx9cqRTQ5d3nxHG4JNbIvzBSaxTRMH1?=
 =?us-ascii?Q?MiHb3vaRhiXD2HSa67ddpOhFxt1kg7wt9uVvdU1yynjbY8H/i6Kz7gkgxYk+?=
 =?us-ascii?Q?TjlT7JH4pgWXS5BtF7v1CDDyb/zVvw1keFIYVRlorbUSp5Qkc3u1N1mUm5i3?=
 =?us-ascii?Q?vs5eTwBTTuY52fu4fDR5Pj0rimprDv6uBehnyzbBjl1ireigfqAb58Id3r34?=
 =?us-ascii?Q?AUTvP8UIWlQ2vSEhuLVHt3xrxQfJHuWN9qdsMMhwwlkqD9illVKEUEPECTPy?=
 =?us-ascii?Q?NfnzV7WoYFTeDcTWLz4/t/zwLCO64kx/AnWJ6S3viIEtvcQ4CcmIYhPUvyQt?=
 =?us-ascii?Q?qpP+22SQLxID9fCRAm1z6jTiRb4I+TNxxams6zYjODmMEOr/EGomiDTqSOnN?=
 =?us-ascii?Q?VjeJvKHVRpxLgYuWjarGu7kUPtNcxHJPl8aXuAwVBnlNvsIpV+OsZE3t4GEZ?=
 =?us-ascii?Q?+VZlk4ysXLKBue+Q1WwmLtP+YZv86p10J7XzmYU/MV7o5J/H3v2l8WYhF5N1?=
 =?us-ascii?Q?sIkFfdXE2OJW6lz1Qzr4aaxnbCQfbn4qgYm6rD5gG1L4Md8Ot+Tbx3YX+u45?=
 =?us-ascii?Q?eshbQPJfi8LndRTt+3LfHlQXBorfX9HnaGUVDaKScwUTYBb5w8NJ5zU5CkB5?=
 =?us-ascii?Q?pjoAwjofIz754NIB1L67wI5+Ia6Sn/CNL/N6YUZGMaCrmoS5BXc0/dj9hqyR?=
 =?us-ascii?Q?Qs7mXAHq7KiAmmq1ZMKU7Sesb+7RE57a/NfjC9Wylmgjtpy/UuA69ruZLyfm?=
 =?us-ascii?Q?bEUX6SUkZgVFmFIKcjRJoN5+egnuQfo78zHhf6tA0syWeJpMDPi+LcohGjrH?=
 =?us-ascii?Q?E9cdjJhNH8I4+IA3xQ/dGYLtEMJJj1CLB6LbTdzWyT66urnlsPjXuWPkuZQ3?=
 =?us-ascii?Q?nIZumwMJg/1spM+XWvVyxluxQBQqTIXbkuo51RCa8AnS9CStRZiYONYnWHk7?=
 =?us-ascii?Q?iC8chUPxQEzgheoAv+/vRJujmzPAOSNzq/lJRaSgUd8lttHfGRDpxdMhZy4r?=
 =?us-ascii?Q?cBhe0+uJjThWFfVUdg5U3mIMHKezOLS0HztTFRsa6YR6NnKzeTL/vAfnl3Zv?=
 =?us-ascii?Q?Ax/fghGu6w+yX4epk48hLjv4tIoRtn5PPzTeY8o2C4W35uQPx5Wc9bPogQcy?=
 =?us-ascii?Q?TObCiWDHixpHW9fN+yndvQk2JZxxHSjyX9N4tnEPxumHncbzlNGs8stYy5Ot?=
 =?us-ascii?Q?NfLRGJ/Ce/fSmvcKXapJiqqqbQ4Uu7FJOqVmtAFMgQecbGNYW+l+wQH1/X/0?=
 =?us-ascii?Q?eEcykOs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5T074juwEpkf3cLtOhT38HrWESbPcouIrxmnFOpd+SF8l5rnWssKTIUyhSQE?=
 =?us-ascii?Q?76hkGNwte5bT9NRpBKbF9C88PMmDTke4LlNwvOoqwWR0xKVW13fb1k0TjkEt?=
 =?us-ascii?Q?NgvcnCZGmRDemHjhv+gyzZb8T9wSwIDlOy4mMn3WTfJovQhXvzZPL7QwFgne?=
 =?us-ascii?Q?78ni6CcNsDOOKt1nHeh032dlwvDqkrcK8mUc8acukWL95xRa4kI1aFlTGeoF?=
 =?us-ascii?Q?0NSM7H1aXlKrdTEYy6H8qPG1+z1lRRxiyYElG3tCKDUJJsJgP7+2MRTUTKqC?=
 =?us-ascii?Q?l9FmmY95K8pxBt7ABF85O7A3yVIPp1ZSHKqYLyxRRr4wK3sDlTMb7cNh+5rz?=
 =?us-ascii?Q?4SJ4yGV+TjNTqWJwqhWMmvWz853scT8LYSic0pnbi+/L/qiDEfFWjtjWJtSp?=
 =?us-ascii?Q?XtXI0jLwhWNZDmyLTaWy0UlY6E4QuwU2d6l4u05tfV76QYu8pyQmkMXS677w?=
 =?us-ascii?Q?pGCD1ny6LExPeTWJ/GSIfmDV05l1L1fcVLHKWwULxLm4/kNkgo1uxv0Fvo68?=
 =?us-ascii?Q?sJ9hq5Ecv5oSKwJCdUi9fDz7xOfPOQ1e40SYjf9w6UO9zXBFqXU8dcQURBNg?=
 =?us-ascii?Q?byTlnVk/rK1wDaybDFQDMKdKktYuV0xUfIMqP5Cg4OCWGSU381e1wqN4muBA?=
 =?us-ascii?Q?UmCLB0spqBY1dyi4wOrVzyonywRQEuxWig7WNDHzLqOhodkfA/f6Dh6bNhVH?=
 =?us-ascii?Q?E2QQwo1ymnTTO0w1kllTQjUzRtBqogF5djhX8dcHXxQ595kDKBxbH7zoU1cw?=
 =?us-ascii?Q?8tMO1YSz8XOvaQpHlImdsF18YRJH3eZrb37vPwXB6AjenBbQbWOyg6MyWEkj?=
 =?us-ascii?Q?EQVMm8iFPEVgM9MTqwlx5JiNf0g+A6tuBT2wm1Fkz4ukOL9EUnkNfsoEVGuv?=
 =?us-ascii?Q?24HIZSecvsLbGO3I/zuj5g5XkH3k64nB4fr6TdvEPabyOqljaB370qKdgGk9?=
 =?us-ascii?Q?N5BP09n36uHHrgfj5qOROVNznrB3tC3mByb/+OIIG461RHN4wpWS5tOkzMgN?=
 =?us-ascii?Q?Rx3Ml25Vte0T43cS2bFy1EnYXRXaSR2zZGhW5obs4n2+UNOeZKvAkqLgsdOm?=
 =?us-ascii?Q?GjQmuXoJXzWAyaZynvRnR9Uxs63/v6FJVcsu1l63PS3PQyDAvlDOVWKCFl1X?=
 =?us-ascii?Q?fEdfEBRS+qf0HiMZCmFbXhEvksLp7ilK4JdC1v8mZs5Dn9jdS/rMVNH5JbVv?=
 =?us-ascii?Q?6FL6E/zxZKfCyJuiNt5s5mYNU2gmx58z31jCtHfEI35p/i5enBDnFPRusmnD?=
 =?us-ascii?Q?pc2fIIcV7f/Myr7YUtt6GFH57k4gUi2B9LoUp/bhQvlq+6NUcH0sPSxFAZsy?=
 =?us-ascii?Q?EkCtNXWxiQR1eQtLWJ97e8cCTB+Z8PTBI1ubcmjyxgQWWgnU8Sp9SgM2gz9/?=
 =?us-ascii?Q?+yZA+aQrUDeWizpIo7iJdjAWnY2v33IH4/oJ/McdNQbh2o9hKNFm/eQ/+rG1?=
 =?us-ascii?Q?Wb8sR2gE4ECzyDD0n9bd8a/ThZELq2qEi4kVP55Wr3vTO40D71IkqQ8Ewj1d?=
 =?us-ascii?Q?LNVogjqnJ4z4RbUYXyyY9+KhpFbPmGiDw0ZIliiFcnhqtCLXEu4r9DkgKINc?=
 =?us-ascii?Q?nbOHVxOavZg1e+EwfRY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc0e3d2-e9b6-46b0-cd57-08dcf1e4b3e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 15:26:16.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0El7UrTMyPQ+EfTZRMxEEg2Dtbi3Bjy2SEP+QxEgbW7S7Jrwri2b7wMWQLEeN7cealW3SaK1IOIygIT6M6re6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355

On Fri, Oct 18, 2024 at 06:13:05PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 15, 2024 at 04:33:25PM +0800, Richard Zhu wrote:
> > Previous reference clock of i.MX95 PCIe RC is on when system boot to
> > kernel. But boot firmware change the behavor, it is off when boot. So it
> > needs be turn on when it is used. Also it needs be turn off/on when suspend
> > and resume.
>
> I think this background would make more sense in patch 2.  IIUC,
> that's where the driver behavior changes to do something with the
> "ref" clock.

Yes, use "ref" clock are more reasonable because we have not consider
external osc clock case at beggining.

>
> I'm not sure how to interpret "Previous reference clock of i.MX95 PCIe
> RC is on when system boot to kernel. But boot firmware change the
> behavor, it is off when boot."
>
> Does that mean a previous version of the boot firmware left the ref
> clock on at handoff to the OS, and newer firmware turns it off?  If
> so, I think it would be useful to include information about the
> relevant firmware versions.

i.MX95 is quite new. previous version should be 'preview' boot firmware.
The production version turn ref clock off. Can we simple said "preview"
version. Most people should use production version, which is general
avaible for public.

Frank
>
> > Add one ref clock for i.MX95 PCIe RC. Increase clocks' maxItems to 5 and keep
> > the same restriction with other compatible string.

