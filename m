Return-Path: <linux-pci+bounces-14952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E79A9088
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 22:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CE41C22C0D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750C1C7B68;
	Mon, 21 Oct 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MzCEomOg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064111C7B64
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541015; cv=fail; b=pFmEdXdSEv3WWA5n/ARlCwG3WFna/blZ6mASkFLbMVN0js+xUGqT0otijsnUT22YpQLuB3RUgo3tTuWDy9S8OYsefJS9CQ/AzVLtAY0aSgOUAIU9zzpt3LlRd1Y9gj8gtPshVAMw0PQHJzZCBarQoMSzLIHORZsyO+4l3Xcs5oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541015; c=relaxed/simple;
	bh=LG3BRVkhMc8rdLLpdNh76MjjMTdmoFFHcq4zT1I6PvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BqGaL70aMHuwLzS3D2s07HlVkUbnwGM1/LkOTbTxhuE3W4kPLXRubkxw13rgEtEVv8/T/JYuWYfBP87tXOOa6eOfYb9IIsA2xTm0BzQbgxBSnnef3PzWyhXo4IQY05V9E9IArHNr/C2IDG8l+cWVztyLflcKpKn0Z10WDcuUMgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MzCEomOg; arc=fail smtp.client-ip=40.107.104.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtzipkAi4U37GUSmsxO/VBuzFAAY1F0VHubfFfOPZXz6oSoinvzi9BZ12QFKcyXhVBcyCA/rYXenFBHpdWgVzduNAmJR/fF4ruUeX5EEgvsuZtyljnYiCs7GCAxa2CrptWKN4jg1lx+NZLt92Bi6tUYTWV46CamBcHRZbnFzZW0JoztVMVcZ9l6dC7SgLNZCtCg6YoYI6LoyoWyWBMG+Ag5HTrNVCpgQwYlpw9lpmBHup68PYgTS8ItYEQHBAGZFBYxqpkaqIy9OZC5W+HRqXc7/v8OZcrYmuDTJ/wuqvhLsms7Hf/3SaI1UOz3YWdBwy7uzR6WmvrNeLMXBTvpt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxNlIsun9urBOBi8/fM05URVyO+Zh7iYKI3GGLIn8J8=;
 b=GV03FLm9+trb95QjkYyE098kES3OmtWhsJP6F1kFlOKYhSuLwpm2lWKM43reprFmvtZMqg31xCBXg3uksYgML2ml3SuOeqPzFsOGV4kay0H5CjMrYC/4BJ1Sp8cTcL805nVGIGA3C5izlZHn9KsVEcnwR+syVUVExq/xmZPtyfuQsOsAC+dowuCL11OCiRYSIQBqi0L0qB0PPmb/td/YjbVPhJO84nyig9kd6rXVtUNEOu8Bz2L6QjZLLOyyuyc0cx6Z26CnJSfD/m5vYhxNsDD7u8kndvvAdQBPDcSeUSIFTACpGuMZcrprH42c8GvLkp7j2XM9UXIBEgGdoxhJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxNlIsun9urBOBi8/fM05URVyO+Zh7iYKI3GGLIn8J8=;
 b=MzCEomOglazb2b6Gnj0P1tjI5lWzJwr20uVvQhlq+M5Yx5jgeUYd/1mXil/nTbLngAeg0vFYd9Sm32hlKjOCOtSnq1ECxvwRkylZTSmIw60aIwONYwVHb3a6iOATMaiqZLY4+zHjEU6AVz88nQOpRzw3CAIo9nBDaqsKa6oRqAJ+UJtFAqwUAl6ZOUuR66wxtC4MiyhEcWbSEpO8/GTPs0s70KTh0EqidTKdyishPyqUGPpUao6SdBjzbYZKKuPtotyDw4HeG7RVsygChomkmN0LNRlyXX1bZIxz19lbYNYmXVFhr1mQP3Zr9rSrfR/eSRFBBdN7vH/Us/ktNNGgDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10800.eurprd04.prod.outlook.com (2603:10a6:150:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:03:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:03:30 +0000
Date: Mon, 21 Oct 2024 16:03:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: PCI endpoint: pci-epf-test is broken on big-endian
Message-ID: <Zxazi8MzOZGCCsZI@lizhi-Precision-Tower-5810>
References: <ZxYHoi4mv-4eg0TK@ryzen.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxYHoi4mv-4eg0TK@ryzen.lan>
X-ClientProxiedBy: BYAPR01CA0028.prod.exchangelabs.com (2603:10b6:a02:80::41)
 To DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10800:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba8a133-8406-44b0-0f53-08dcf20b6ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+444ASGQDqOHxh9EAQAGLMckU4Ky+X31GoP9CtWjiz9ci6phedLVuL+rSsVn?=
 =?us-ascii?Q?ilV4COX/Nzk4WZ9LwB03apFN2uXHOsmKvzNd6GXYcUkEc2s7Cyhnb+l/7pSL?=
 =?us-ascii?Q?qZGrHgswVJhF7FkwudpOND3f9u428t5f0dJrXmIlhPSVpI/E3CBdeAuhXwZA?=
 =?us-ascii?Q?ayNucEPbaMngb4tbphNtyKmEG2Igt8DIGrU+KF4mZlEBksj/pn4DoPqcisJf?=
 =?us-ascii?Q?CNxa3yFWrg+iu8WKwUEPYJvwvD9uEwTHSh9ayDqLI0aDyaZ/UWj4YG2zQBHw?=
 =?us-ascii?Q?Wl/5Qx0Z/EHVpDaIYCl+xPzcWdyfei/+o1CZcGxQR4uAOvj9ogzbKc+y7xBD?=
 =?us-ascii?Q?7yR4kAWpKJs9B1e5T8JB8e8L8GIoLn2q2owO7uVY/dIHf13ZN1Kw8N+VhBSu?=
 =?us-ascii?Q?lENReJTY9ttHlSvLSvA/lTkcslgTg94vwKgnCgGS4ziHzdmHF4RgHZ5zfTx6?=
 =?us-ascii?Q?idyId2HK42dOBN45XTD9rSgyx9SCDooAiIuN+sc740dqJ+iE6xDMpICDnbFh?=
 =?us-ascii?Q?rmFBDJytbEHEGfRcjheb9AK/HnRrlIujcmIjjouqGcXNsEKISiLgsIKl7jIU?=
 =?us-ascii?Q?myzJu7uDcav94CyjdjTLlmx9HC2/7T3yXaId9cQydyJIhQWjfJ9HA9E99WUk?=
 =?us-ascii?Q?xVtgpvyk+Nf1y3hXeMWANpyR6GsJExGhPN/fFXSZxrtyEifYOp/qO41+PC/P?=
 =?us-ascii?Q?v/dA5VUf2qXocWPuqkJg0u1cSUrq3Rk88kwqFnv2+plytN8uD2iMUPcsIJDe?=
 =?us-ascii?Q?ThdCaM0CHhfR6EyXzoxPFj81SlxSHyaV+jPgESwvpHf2FkgqV4dcFNpFWCwp?=
 =?us-ascii?Q?EsNMWqmd0tobDp/5nxdNnm+WS/op4ob3C8kT37kBwb85dIdx5YMaQ+JG18c6?=
 =?us-ascii?Q?QKi3QoFHmqpOhrhq0RsJtCvjn/ImPszVIy1h4Or1N1YHZYnxto+ekKBlF06/?=
 =?us-ascii?Q?zUKG6+U/oQYaxb1ILENetKVkK0RzShiCGqQ6kWi/6uuI2DvdXe59Rke62l6M?=
 =?us-ascii?Q?SwKIvnSXbLYB2O3Jq4yNCt3DvFv7T+qjYEdrfF7vov2Hxc0/W7aPK26+ukB1?=
 =?us-ascii?Q?rE6obMbnXvxvHRpg2kORbUhXJm7vCd0a11r87YHFaxCqOdVG7kXuyFpZ2IYQ?=
 =?us-ascii?Q?YArssphzFeyYS+EKnDFuA7vi4ABRiDOG7JGPFGjcm4baNynerl49XrgXwQ/M?=
 =?us-ascii?Q?rQ4X/Fie8T21D09zgUpt5VR8nIi20tYPICyTarAovI8vyDPtx0gFJ5iDifh6?=
 =?us-ascii?Q?0+13pAkt1CO2Cvr9FMN4Ph5YoY/Lh9MTZd+KhvFb+il0EDKFFQY+mHr+9C60?=
 =?us-ascii?Q?/XuV8mWRc5hG3fv38Mk6bf11?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mlLcdjmhw3h0ioAb0cNb8bYDsT+h6an3j3ot4JIWzsqb/Rcte66vp5L3l3rc?=
 =?us-ascii?Q?f2z1+FHW8YxKg8F3bsuFARLURKTSMhkx9W/lg5L2ibAASsRGU+6v+od8T5Ue?=
 =?us-ascii?Q?3JTRUw1dzDsO6aPZ8002EyH6zqPi02PP11QBmXBJMiQzbiFK7y2rklO6pCGl?=
 =?us-ascii?Q?uELUR3LaGLk+ESM0pIpCGxiFt2SxwANJuiSBR1CPwU85GVKtvYvr66n8mHRi?=
 =?us-ascii?Q?4zTnaT7BCwBtXN+nu4DT9fmLgR3iTs4bLdBXn85W/eVws214K2giYkX9vsZW?=
 =?us-ascii?Q?sDJh6xcQl2dccKy+Dq2urVrarRH3qslhCrZ0syWgi5Ma9+ZQkEMuAV8Cav74?=
 =?us-ascii?Q?yQnKytw84h1c3uXy5gDCRUkJ3ByFOxS0tvD/zm/o0M2jDqa91gJAogji9I+1?=
 =?us-ascii?Q?P/xTA5L129k5YHgwSW67e5koBEPRTlsJhDhOFMFA1JxPxsbZmahPo1sP9Rdt?=
 =?us-ascii?Q?UMbGF+EQLNNS0pBVudBdzHtomQXdvLb1esyMurcEk9x9yqDudKAyNurpzN+T?=
 =?us-ascii?Q?oSWeL+2P4BKN7VSP6Okk5QYbKdqr6stPIgpup8M2B3tYJ8Xq737FVNcvPPaJ?=
 =?us-ascii?Q?TXNwm71+f58twUTyiGw0ML9DnrHrg+mmDjFEu1cgMZTmP+WdUgcQlsXo3zC5?=
 =?us-ascii?Q?TI3URnfklBLWcFEtSuQ4VzN3hj6rQIB0VjpA8dIihCtuv8l0G5SY299OAl6s?=
 =?us-ascii?Q?ZB4RnKWEMohN2tr66RPvXaCeLUDesSZPRS6r7PAhpRzEE6SFjzBtlHnC1BUs?=
 =?us-ascii?Q?CN54WLRc3l1u0AoxhdqIjnnSzgFXbWOT/HP3SfAyD6Nyav7Fy/EsLhNDi7el?=
 =?us-ascii?Q?gqhIXPsIKRGDKBo6y15fVjfUEB9WVARYsKjdm0mVJ/ceGk4nqoHxYBRngeAF?=
 =?us-ascii?Q?xl7B6X7raeWbjiJRjjEUjIufAxlInYHtHmSzFHaFoBHYkJSnnfohgyEk83EV?=
 =?us-ascii?Q?39BNEg4IsJlaLy5uZK7LpWWFN7TPUk2d6llyqGATMC0pEmFl9vPDv+FK4+Ix?=
 =?us-ascii?Q?euCFcvGoDljytQ77cA/56Wc7oav/neye8fZgDa0uZ23u3Ch2p1/DM7QMIrnA?=
 =?us-ascii?Q?bPFbFj/4WEzBg8WUltFKmumX8NE19XwppALeQYjaeyKQ4NuArClWvWb4Or5S?=
 =?us-ascii?Q?XKFgMxgDrXqGDdvv4BluHDVhfYAqOaLhGdgQ/4sMSo0rlOfZvswuLQ+aJPtS?=
 =?us-ascii?Q?+HpvVnTnnmZk7Ps2N3cPF+DO1TaKqMctuoy0lpha/RFm8XRPVnsFK6PZsE9h?=
 =?us-ascii?Q?6w9m6c9ffa/9sY+jW8jH7kdVuJFDfjGdlfsvdiDVCwh4iS16i4CwzaeIqy+1?=
 =?us-ascii?Q?2Bm8XgC5wQ4BPTTmqu7vq95q39iWDlYiuRSAbztgtscVjUtndo40PlOZqqPy?=
 =?us-ascii?Q?U16PRiwVUMqsarU/WLNuK16uS2LpViVQnUjvNyubcR0VrIATRoekd+6ZoKrg?=
 =?us-ascii?Q?yp9714TTEb++HtS47uqW67LfHthuqs6v2jZKRwz+BmwiwEoZ2wjehDCnaA5b?=
 =?us-ascii?Q?ynfP6mXKxBm6EKS1d9MYFsIVkZRr1MqMIY3b+A+6E2FAnFDPGkyDexo3PNjg?=
 =?us-ascii?Q?v4HXaQYtDb25W5lxebiw8Wy+wZwXk6nmWyH2LU7C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba8a133-8406-44b0-0f53-08dcf20b6ecb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:03:30.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/HlIGWc6rwzWHLNEguI5bBVGUVxUatvb4Vb0oxEgb0qWHoNLMq/YUU/OkI9crvN2u/Ygk4Vq42/KrCfd6kl7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10800

On Mon, Oct 21, 2024 at 09:49:54AM +0200, Niklas Cassel wrote:
> Hello PCI endpoint maintainers,
>
>
> While looking at the pci-epf-test.c driver, I noticed that
> pci-epf-test is completely broken with regards to endianness.
>
> As you probably know, PCI devices are inherently little-endian,
> and the data stored in the PCI BARs should be in little-endian.
>
> However, pci-epf-test does no conversion before storing the data
> to backing memory, and no conversion after reading the data from
> backing memory.
>
> For the data backing test_reg BAR (usually BAR0), which has the
> format as defined by struct pci_epf_test_reg, is simply stored
> to memory using e.g.:
> reg->status = STATUS_WRITE_SUCCESS;
>
> Surely, this should be:
> reg->status = cpu_to_le32(STATUS_WRITE_SUCCESS);

struct pci_epf_test_reg {
        u32     magic;
 	^^ should be le32.
	...
} __packed;

So sparse can detect all endian problem.

Frank

>
>
> Likewise the src and dst address is accessed simply by
> reg->dst_addr and reg->src_addr.
>
> Surely, this should be accessed using:
> dst_addr = le64_to_cpu(reg->dst_addr);
> src_addr = le64_to_cpu(reg->src_addr);
>
> So bottom line, pci-epf-test will currently not behave correctly
> on big-endian.
>
>
>
> Looking at pci-endpoint-test however, it does all its accesses using
> readl() and writel(), and if you look at the implementations of
> readl()/writel():
> https://github.com/torvalds/linux/blob/v6.12-rc4/include/asm-generic/io.h#L181-L184
>
> They convert to CPU native after reading, and convert to little-endian
> before writing, so pci-endpoint-test (RC side driver) is okay, it is
> just pci-epf-test (EP side driver) that is broken.
>
> I'm not planning on spending time on this, but I thought that I ought to at
> least report it, such that maintainers/developers/users are aware of it.
>
>
> Kind regards,
> Niklas

