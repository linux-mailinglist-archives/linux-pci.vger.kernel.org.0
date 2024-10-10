Return-Path: <linux-pci+bounces-14245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9277499956E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AE3B2288C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94435190499;
	Thu, 10 Oct 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MLB6Rh3d"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704C14D6F9;
	Thu, 10 Oct 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600331; cv=fail; b=mB+yZ0zjGNillorUIsyF9JsVcIjA2p9AyxuLzmUzHw6K/WLYyof2nvSOiQjtKs9z6/ESFoLn12BTRbMiumtUyclYhPcX7nRj7MQ476E/x7ipbs0+LVTjNi/iDbe6OmOrKS4oHKTAMvbVl4hXUn9LPNJ5VdxKmEH1/JDPFYNhplg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600331; c=relaxed/simple;
	bh=IPGVUISI5QFOvnPYsHB0tJf/Hb43nAxXTcG3rP+ZG9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f70KdUeWfpC0YxHRVJWDuN6EBpnqIUL5ZAbGsgtA+GnkSgLKu/DMCTnxTlf6KZOsYyehX7g6Qh6U3+uKk7jxWPPHvWFjMOmGiL47tUIbe1bJGkWC7wEOC9kkEcMcX4MHTkHy9OfElQGurfcOFY0IUYG9bIjJOjkkFDckD/MOloE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MLB6Rh3d; arc=fail smtp.client-ip=40.107.247.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlnqO9TXiLhdswLVGyiTKj8SMp7v369Rj1u49wXT4A1VdmdLQFPuuihgKF/PuGh/RGD8A9oqqKhzdQ2hLLk60YEm6r+9E1zsoamEao4QEcjd3Mz6g0NtIZJ69LYvHtyTmGa+naCi2jj/tdLtpvzrRFk+cMwPmDel/NqY1SpkLukrhpeIiUebrvxHfZOo6Dlz/N39PVO8TV8EcGwwZtbj2tqLngGK7eR2fbUNxOZ3EvS+iuxXhvgSCmTXbMEn95FypXW78csLEfXyVAXdGTXchTVFgZVoo9Nzob/aH8PR7g2Gz9vBlmCA9RX0gIR33wH4/tuKVyOlmF3QKL9GMSqKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPGVUISI5QFOvnPYsHB0tJf/Hb43nAxXTcG3rP+ZG9M=;
 b=flU2J6+kz3Pb4kIbVMIrLDE1zx8snK8tyeGOCgiXEH2qLutv0hQv/hI8z1fUk819fxtQBj0yctlRkUP4FvJtYfPqdDOSudY3vcXFwPqVANpPzi0uJG5kaDYZ4lXOzWRerlrfmhuvZhrtqQauNSmyKq4eit9+5YqKhfPx0IX9cFG2BSeLR8Xj2GxSu6x4dvsPcgZ/oPCENcfI1CWdDek/aqsffZXCxEtWwtoyAOmFmYqmT8QjssbVD52Qs5ZQKh48V7FjF9143aBLVQK3lp1KjT4hQ4fubPIfVBZNiEKLA+5QYjU8nhBaifl9g2d/v6/Hk5jcgxHkoDi2PXwq79k0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPGVUISI5QFOvnPYsHB0tJf/Hb43nAxXTcG3rP+ZG9M=;
 b=MLB6Rh3dAN3U4N+v7jOV5vwU1rxa5or5WK7vyqc9JZGTyOA/XQ2wi/c6RmJasWErVFvkTO6mJUNhvVRujmTzraBA3ql9DsBQ3MqxLFKTB8g83BJQ3v9ENgE3yZdGGSMsScHp+Zrei1lgibhwCRx8nTjyA+Xy4ezL7EUgovpLCYuvijIEKq2fv2TEZHJ67EinalJl42LDEALnzotHi81uXRBSyXL8PaCQZsia6nJLcsGk5hSHaBM0mchmdXISyuoKYgOUiLUuI8VxQxBzQN9ZG8iqfma7kSpdDRW8GU5FRA0K6n2hdBjKacRE/zbzaZkEEPQ5IZc0XNMPTwjKZrjEqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9210.eurprd04.prod.outlook.com (2603:10a6:10:2f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 22:45:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 22:45:26 +0000
Date: Thu, 10 Oct 2024 18:45:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Stefan Eichenberger <eichest@gmail.com>, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <ZwhY/dtSNPptgs27@lizhi-Precision-Tower-5810>
References: <20241009131659.29616-1-eichest@gmail.com>
 <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>
 <20241010201121.GA88411@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010201121.GA88411@francesco-nb>
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 76de2d9c-cf69-4a2b-47f9-08dce97d3bb8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?tP2XAXlazrJQEspLY44v8uLgM6UKQWge0EnJkMS7qbKqW4AFBmrt22f4spyd?=
 =?us-ascii?Q?SSdCrllDZ3jeTZoNKjpQvk30ehceTrlTzjuCsbpizyZl0gA1yb8ztnyuEniS?=
 =?us-ascii?Q?7zVro9WB+8ROMw4a7ZWRZ9AzGswsitY0ks42+rgp3dNeexQ0uG5sP3xKZex7?=
 =?us-ascii?Q?GRr3wiAwjfGwfFzYJrh9qf75fR+Ks6KGMBsAd8tSdaycmdzsIMaqlIsyW5L/?=
 =?us-ascii?Q?ET3AvxqaT2gcOPnINmKwRH1lUhkMVpw+C+f+VNn5UViL8ZDzuH9CcjRGBxRI?=
 =?us-ascii?Q?NUaCTJBZUWDUVvHIkr2ewNMlHnDg3sVrMWulR8GZpL7E5nOvmhHZUumuqq0p?=
 =?us-ascii?Q?WzPuFAMXtjtEU5/aIi1+4CLou65TJqpLObyVGD1NgVRDry6PVZimXvSTY3+O?=
 =?us-ascii?Q?MoF91mIbQ9/o6s8OfI8tl3cj53F9u6QjwlzxKXNtlUQ72dRTjwXMCgSnmicS?=
 =?us-ascii?Q?puwCgHZk2WVC9tiN5WU5bBcCzZ96ydQlPJvBwQtSfftV87ygnyj5deOlToU9?=
 =?us-ascii?Q?O7UngZ+lDPjAtcjL8A3p3VPzMeNsJ8sMauF1W5C3qYiG1hafcj56gB9e3/PH?=
 =?us-ascii?Q?gIhcdsBEYSotJFl96Akdgmj7eY5CH0lK4BcY7AgIt/d7ZQX5rWmTpUZFWDu5?=
 =?us-ascii?Q?g9wQfTN/P2kjHz/I6BH2DLzJcMBPfApHw3Fh19AxJm/Q0sjD5JvhvPHBS31h?=
 =?us-ascii?Q?Q8ftYv5uUtvN4YY2FiIRzUymw6dyFjwm1+xy8mCsuxZ93c7HDuB4hljnfKNt?=
 =?us-ascii?Q?A2Oy2EI6km2QHLfuHuj1xUaxTk/N7CnGomS92T77Kxq27hf/7AU7yqnnkrhu?=
 =?us-ascii?Q?feaXLwCbe/JN7zU+HU+dbaiIokO6YbQMbOPOO7Gf//OwoqF13lR6zET95v+C?=
 =?us-ascii?Q?SsoCBV0U/1+S35qfRejtBRgmCnNBKi/o9SGpKpCc2KRHtdJrYixOe7lHU0Tm?=
 =?us-ascii?Q?1ItTK6TFbTmQmj9rtGfDVQuAhmfxqR3MZDiMTScobHgwtwyy5qLxVytm8bU8?=
 =?us-ascii?Q?4oGi1dFgD9yCLCfYBKzgMb8S8CgezOvpRKNVZPgIem0Slw8jGw5EoDtXTlTo?=
 =?us-ascii?Q?jd/4CKfiXZw0baun3L9ph0o+D44caihG1Gv1qjSTS4KosZkgjjDYjPIKX11V?=
 =?us-ascii?Q?/PkB4LUdAK430q6m4j5XAKJ4rve5j7PU9HDCNawLP10nFGXOXN3bxosdEN/M?=
 =?us-ascii?Q?wVQr+KuzOgNPO0N+/PT7nHzgLoUM23EabUY+lUfp1BDEKLuLfc2K7rG/YNQZ?=
 =?us-ascii?Q?4GVAjEGtSMVmk6kj9CU83o30YZy9d7slxa/4zEVQmP9rdwBFtW4HkPbxrNpb?=
 =?us-ascii?Q?aWP2EwZJroMyMWx56ZAGbEvpsRzNoQeunUj8fHuD34hDCw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?YJ1MhlTkmjDdv9pyVQbYnbA2JYnapsoo5EUWW61/Vy5g+FIs/zi9SUPZ0XjR?=
 =?us-ascii?Q?PPw5TjxffiQt1fn9IuG+M8hMWNHaVJ3IqwoJAsAhBeCPep+4HIhCp5gboOq3?=
 =?us-ascii?Q?4qP8fFIYu0vhdFdoD7F0WKW9wSNnCZNPbO8S4qM4AQuLT5PqpqBUG16+wqA8?=
 =?us-ascii?Q?IcuhbQjkgW9dKK0dKIlSGW9HWXroRQxwW5lb0YQrAm72rB/1crmwcEjGdAEt?=
 =?us-ascii?Q?DHaphU3sxMEFY6y6NTetGnfXK+l49W4SlCTiTF4DwTBNdyozS4zV2I9gJYcK?=
 =?us-ascii?Q?5rWez+VQAQGsmNwWHvNtiHPa/RaSJhwM49KIYn+gLJ1ZyMQ9kQm9T8pJCh8L?=
 =?us-ascii?Q?ZDdOA74uXXr85/Y5NX91Yo+u/gml186/99PqOUrFnltghA5g6668qwTQX2Gm?=
 =?us-ascii?Q?mwglm2oiYWgVSVHpLzIbsEtwdA1R01nUpMCRUg1hO4MmX98beJXqPQfcRsEg?=
 =?us-ascii?Q?lRflFDdSSw22LBevD2hKt9R+t2zAR6mpHzI1dqDdlQpxmn8iHJzPJE2Ym2qa?=
 =?us-ascii?Q?MSOMI6kEXz6+9bJu4mAa1i+6wjl3KM96jr/lUMOg7KpOyLx34p0aWdjDUkD+?=
 =?us-ascii?Q?t+axaDy98bua3pgtFQck3PzyGw5Xsm59PtQcsfbRx/ob+00JON90YwXO43zM?=
 =?us-ascii?Q?YIJNF3y0lv2DH4njTzXYH6SaLfnKtv0TAx+Hh5X8D1RCaLmee/f+xHBJg9Nr?=
 =?us-ascii?Q?MooIrgac4E0KlP3ZA+Hm54rOSCqrPaScM64xh/BETPjnqqh3uSjmBHolkfXE?=
 =?us-ascii?Q?aHSy93Ob7038/e+cl303FY4p2faJTShdOHFcheLfo0NWmgF4cN2ANGn2ENIt?=
 =?us-ascii?Q?M7t7ibJcaBajPUou0xvuSaLjxUqQ51msXFGI3APntf601a7LOg3jCsoYQMS7?=
 =?us-ascii?Q?orzBjuv+ZM0VLyRN0QyJc0etUzxxaNvTPcn5OZL6yBusg2AanReErpr6c0t5?=
 =?us-ascii?Q?en8+S2aKXQ8K+kR8EymlO9qiRW6axaHNJrLzFanPm7kW0v9blXgnSZIuAnDz?=
 =?us-ascii?Q?5z/iRH1/tLlSdpxvooUqpOilnszzkMB3/1/84TnMdy01qUAIkByBx2mfaQCZ?=
 =?us-ascii?Q?556hBfGdFiGn8vKz+DjUq3GWLwR/1zX3brhV6QismhO4durcxS2XcL6uQJ7c?=
 =?us-ascii?Q?u4CZVoSaHTCXhp8ansyKWavHnDpfD9ctX81I90Yti+uGsUdtwwF3vVXJ5mYw?=
 =?us-ascii?Q?g8zAMAchs71AhrL+55KxxO4hJUOEfbQWqulVTmWYQHI2JfZPAsBiJhOJ9Gob?=
 =?us-ascii?Q?XdLwCCNMwNkBVZdOXS8YE3eiRIuvAq3dE+8LMkv9ZWyzEyIcAs/dm08daI3d?=
 =?us-ascii?Q?1J9HMplHvShpPjXs+CJE409w6xVLmXKwIAzV4Ds7tfAlMkRIc9vR2OgKIr/i?=
 =?us-ascii?Q?TbfAfx9Xr31wNt6jYsa/Un2g2Ok17O78f7q3A4uHTcyU2MeFfkHi2xxqPGZU?=
 =?us-ascii?Q?PzWQ+qcuIkUrfpZw7m6IcPLipw9rbyLfl9r7drsrDEd0Cq2j9bQEzRb7Ui2g?=
 =?us-ascii?Q?dLzAjBEPg9uoBPwsg4vt9fOorHSGPhsgy87g9FB1Nmwa4va2tIBc1jPheJJ5?=
 =?us-ascii?Q?VJymXJHGJqyusmOAs0M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76de2d9c-cf69-4a2b-47f9-08dce97d3bb8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 22:45:26.2652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiujjvJwEBiuPfxXl/Gnsn3ITYo+imA03v7ArYNxYHUvIAXWjE9EwCL6iIAYSpyO8qIgg+LoW32ll6Fb/xpjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9210

On Thu, Oct 10, 2024 at 10:11:21PM +0200, Francesco Dolcini wrote:
> Hello Frank,
>
> On Thu, Oct 10, 2024 at 04:01:21PM -0400, Frank Li wrote:
> > On Wed, Oct 09, 2024 at 03:14:05PM +0200, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > >
> > > The suspend/resume support is broken on the i.MX6QDL platform. This
> > > patch resets the link upon resuming to recover functionality. It shares
> > > most of the sequences with other i.MX devices but does not touch the
> > > critical registers, which might break PCIe. This patch addresses the
> > > same issue as the following downstream commit:
> > > https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> > > In comparison this patch will also reset the device if possible. Without
> > > this patch suspend/resume will not work if a PCIe device is connected.
> > > The kernel will hang on resume and print an error:
> > > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > > 8<--- cut here ---
> > > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> > >
> > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > ---
> >
> > Thank you for your patch.
> >
> > But it may conflict with another suspend/resume patch
> > https://lore.kernel.org/imx/1727245477-15961-8-git-send-email-hongxing.zhu@nxp.com/
>
> Thanks for the head-up.
>
> Do you see any issue with this patch apart that? Because this patch is
> fixing a crash, so I would expect this to be merged, once ready, and
> such a series rebased afterward.
>
> I am writing this explicitly since you wrote a similar comment on the
> v1 (https://lore.kernel.org/all/ZsNXDq%2FkidZdyhvD@lizhi-Precision-Tower-5810/)
> and I would like to prevent to have this fix starving for long just because
> multiple people is working on the same driver.

My key comment for this patch is use flags IMX_PCIE_FLAG_SKIP_TURN_OFF
in suspend()/resume(), it is up to kw to pick which one firstly.

Frank

>
> Francesco
>

