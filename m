Return-Path: <linux-pci+bounces-20002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7215FA14119
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C023AAA17
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CA522CBC4;
	Thu, 16 Jan 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BQcXoKlQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002B14B094;
	Thu, 16 Jan 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049532; cv=fail; b=P8bemYXOb1JnBUuDHy18cfNzv8wM2YspY4un7dwABaoyTe8xZTkp0ZVPDlnHbUm+pDPG7IXOz69SYZIm8X53dOAiwD2RxSNlXhGrrjXdYA2uCJK0Zp1qmprMDbgxdW698yPaCTZm77NZoB9hp/a8SjAXVNjBrdc2ITOZy000UIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049532; c=relaxed/simple;
	bh=emdeXCSPxiWRPdNurFo9UOpMj4URIplViahjVW0sH1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtDX8gFK2KwHSUVnt3yr4Yi0gw4cbLY+ALq5fajhwDqKorRb2gDzKHtSa0Y5ZuJ16ynvKzC2GNCL8GSsl5Kq/ow4oLD41FKtgkuCtwUZG16MNLx4p8nWs0RXrAq7ke0iQwwXO+9Sv1Y93aVNYcD8FBtVVpRFSfqW14GMRuKxyG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BQcXoKlQ; arc=fail smtp.client-ip=40.107.241.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPTIwYF9/FwNxZFax3GpYcgbc2x6Q+8HoT4S/yMjB/4uLlrjYNndqwZxYWHWfKNDeiUxsHAAXkO3ydZ8qdRnCCNIFChRLoC+s/qUOpls8T7NxilJ/SMWZ3CKVx+2+kU1T75n9KEIfwQCEK0MHBsLf69Ge28qZoVZeyW9p9FYfFXCdTWtKII9jOxPgCFkfoyz+2SKbK++vAjCdSXiA05bTt5cTtzL7P77gr4sW8RCoSPGNzakLw9wCYQo6Oxfsn7VHzQ9dT0x876K3WJfd10fpXcLT4yt5PdUHD57qnWKdHIIU79vaXc+EOAvheAEm97XGKEocVsYYEtBn77HZOXhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azVeL2bz4LUhacvYEVfGTYA8cFluyzZMef9q5esnBT4=;
 b=dfX2dEot2vHTpdkXeeJAiOuJmTAFJaGllH4Sn6cvfhVp5V1LhKUlanqSFtgJ2uF7a7UuR+dBzDXc32WzCPgfMbsweg/mc2cc+AUuAaMQxp4t89DWy5oDIpnte+3PYtQ5xRLtCwy7sAGpbhK9ks8XCRew+ELGQX2FEW1NUZSD2UlOxhXWubSsUVx+27+JIGe18vnROEaHSAyCKF+gBvA/89dCm1XcttGYFDMt2bmYjSX8otrHhMbCQ6M4+ZlsUZGyb7D1OIRsWFXqAPLktl5irEn1cjf0uLr5X/zLkxYnWMOj7PqbFpxsQMKEIPzrCXsPAWJGZ7TnrkgXZP9/FNP9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azVeL2bz4LUhacvYEVfGTYA8cFluyzZMef9q5esnBT4=;
 b=BQcXoKlQXI9dcYDNygQzx1Wraq4ZTT1WDK2+IiXchp8uxrD34dJUQ1BJV5NP7f+7piNJ26oupcZqiKuQV3io6ycKL0alIgcuoH/F7VzFqfdUYsllYXU6sJ99sLOzLSW5nM25M78nn013EwJjWcZa1mrpIjYHQ4Lh6HR8LfS7mUxDMdjU6T8K0j6R7Er7LEZHTUkIU738J+fHWfEBlop1zyUt1SihMKS9ZSup0Kud73N2xNegvQmlR5BISxraLCPlw2ALSQSxrqzDIGNWKQsBCGWTs/wJs29PqfGWSjG36zk1UOQZWcweOhVIpvF+awm/XPeaXLtg52RRdTMTmOsPWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 17:45:27 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 17:45:27 +0000
Date: Thu, 16 Jan 2025 12:45:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/10] PCI: imx6: Fix the missing reference clock
 disable logic
Message-ID: <Z4lFrNNkwhl+PuXz@lizhi-Precision-Tower-5810>
References: <20241126075702.4099164-7-hongxing.zhu@nxp.com>
 <20250116170114.GA561930@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116170114.GA561930@bhelgaas>
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1a2daf-b944-477c-84ef-08dd36558fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2eK+6XM7rhlo1bDiUuW7303hcthSlEgLZgr+a8Lvegb8F5VKvmpjdaQ501+p?=
 =?us-ascii?Q?UWk9QMyewP2Kn7xD/lIBonNJNjEoS3xuDnU+IrXod6ckp40b3ofKJAMhhXbB?=
 =?us-ascii?Q?XASIl0SZZoRB6EkCADARx536qunvVFxA7jH1uNNfEiEUXl2Ntx++A+WggtAr?=
 =?us-ascii?Q?aVVC9OqviBaNdt3cDIl4a8kvo46LfqG8gPxt7C/syEsNFfiFMh5+hgLHhRD5?=
 =?us-ascii?Q?louQFPPtSjqXaTnUpio+jImLpjEPr9Djc0SwuxAE6s9bRtm7gKNVXWH+yOvH?=
 =?us-ascii?Q?Ubqf+xAQcUbJINmE54lnOGtDmgj2Uric+UYkpYGbNCFiaOoNwkkPhpUK2PYg?=
 =?us-ascii?Q?sg10F7Ra2Xl7BHTykorYHWXinpQJHOrhG1hlaLET4YJXfmpw2g51va6OuIBw?=
 =?us-ascii?Q?Z+A/0leNsj63e7xkvoBakiLmpt99fF4K2CcQCZIK6QlxbhMOsPRhPxS2zuhm?=
 =?us-ascii?Q?OCmasj4ZWOx2XHdidDFg6O9AyCyWPfBwog6EM1u+ZPutmemSHJP6Bb3PGupJ?=
 =?us-ascii?Q?KMmoppUt4ASHN2YIJxCVnocdvdPBe1Lkjr1bhbga105hTXyy4DIUbAXAdweb?=
 =?us-ascii?Q?OSSoY4zUXA/j9u9KhcvfeK8HOnFwGAbi6Xp/QzsZQo/ls9wyCSK0+L1CScnF?=
 =?us-ascii?Q?+UEu/0CliHO8pnrYE7RUurjX1FfPOm0/o47LLey+9gs4vQk+1lWcnX2a3XOp?=
 =?us-ascii?Q?cPPbz56I4gGO6bYQ3bzmIC/vAeiKPD6p9CENsniN9kWB9fKVuQQ7F3TC3vUR?=
 =?us-ascii?Q?j/VhGipUUKtFRVZOoi/cqcgHr+MnTpy3Mu9+INN7LV2iT2eZqfnzk5GA77Lf?=
 =?us-ascii?Q?WDCOjebehPSV9QWFMbIOSJlVc8u6fksoo33y0okm59dli78ktLIU0E3n/bjd?=
 =?us-ascii?Q?eaurkr/RBXd7ASuBN//2UQECAwEZEk8k16ZOnateGSSYgkEalfOFWJRB9Xcf?=
 =?us-ascii?Q?0TWI/jScK0Rp4lqMknFKmEz8smss7qqg2wyxjlsvgJaLmZXhsakYDsMtL0eX?=
 =?us-ascii?Q?uN1ln3PlsK3/8pOBcK3Web8xHpU3tJNVD+GoaqK4+3Jzxq31zKKnQwmOusXL?=
 =?us-ascii?Q?pUSuZ5jCQrJknEWTkNJdAiAfz8zlLa4HqK+1sV/uX02cx3Zxi7kL64fvdTcv?=
 =?us-ascii?Q?EZiKRl3LtW4LfyWSIjlxpm+C0rsWVskCZPIblWWbeFj6ZcOy/OcghM3I3zBk?=
 =?us-ascii?Q?JzkRfwwrHl1qQpzw0V8Sr03se8uns5VSeeu8XkYRWsi6Lq+K29014GJjAH1V?=
 =?us-ascii?Q?VLPpIzwgDNzzjNVFBqGRIzIQfFTvSYI5LBci0FGggUQ18wm/EVLtiiBDK0DI?=
 =?us-ascii?Q?Ld+kE106l2OvrFeLbX6FXDzncaBz1e23Hk5ojdArmepfX8hXk8MeBTUAbMth?=
 =?us-ascii?Q?ShE75tbYaPPo4MHOhFRjceKws51qMQutPANqvFu9lQ/lRo5ZiN6/V9UahQua?=
 =?us-ascii?Q?ZC+KoHmYXAfj/PE7XYXo9WosF1PvHXkW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U8ohhuC9PmRbkOdcdahK+Of675EfsLgL+cAEeK3lox4VfyKCW24DyyhfY9Vw?=
 =?us-ascii?Q?Et3G097XZu7Ey92I6p8d5zxw7DzEkQToMKSWr+QHR+fnJyQaKUIEPqGW7dPT?=
 =?us-ascii?Q?DVeO8ZENF6JazFWmH73HxaUkyy5sRcCRs5x/yyQGBigKDYbonm55SABzqknU?=
 =?us-ascii?Q?3hOkCpalcZU1IpRAY1We/QbY91mYHi/Ib9mkRXXKxYFrvgc6lKnYhlmu0Tls?=
 =?us-ascii?Q?EZE8Xw5FRzxoROspCJ7HYqRUbzIw/flhG7EmO4NYea57Iz5l2zd2jwPa5qCa?=
 =?us-ascii?Q?JyfvvQLVMmNeToQR0dyFC++6wA9ImVUFkpgktUqJ/o33sTdfph/g1fh4hxwt?=
 =?us-ascii?Q?mRUYwdhi+i2tnd/IHunKGTySSTNWkCG0LK+4r+VsaByDs2WZkjHHnzDJoADN?=
 =?us-ascii?Q?7xfeH3DTccV/TEyItM31L+nBYbfWTCmo3N7fbfW0vgbIQpG9Ub/LgUmN9Z3W?=
 =?us-ascii?Q?xp5eWiEIebEjIbLG2iwNEw1a74WBCVg4vbHMcQ4/migizOrSoiZJniYkYeRm?=
 =?us-ascii?Q?2qHCgRNkrAWOh6Ds4vtlffe4wlA5eeO3b4GR8M5H9Oks+igZ5POl/yt+5xPI?=
 =?us-ascii?Q?WU5A5JCm23uh7oak3P+oRytEfF3WjA75hkT7AVzvEcfg1kDUTMJOt4fK4xum?=
 =?us-ascii?Q?6ygkS/EpB/Uz6GjuCqJpzgJ/4BaWCOe55YJLxHcM5C45bIHtY7fDRZfhHUej?=
 =?us-ascii?Q?SPXxy2ecgwrjqxlKLBpB8d1FKgOEeFcJ1KcJgNIAjJItr4Y380m279gsxozr?=
 =?us-ascii?Q?aTj8bG1BP/li9lJEbqH9sfr7y/FTBt9zJpCqmkyaLZUOSu/J3Ns3mTTfJG75?=
 =?us-ascii?Q?GzNAzhJV284hpyy+LzAv3aZ0FeRmqpCaCZII++jgub0z8F+Wgwlu9rBnQ6eN?=
 =?us-ascii?Q?eW9NQ433ZxaTzqOTfogJMhS3Mh4F87RzHYqZB/ANo2VC4or6/IMs7dm0GwQ/?=
 =?us-ascii?Q?+zlJVq/VNxNWuypOct54ODcUvj2Tl3rKyKaZP6KV0nw/GGO1LGkoX3ocB9Oq?=
 =?us-ascii?Q?mmAKpGqi4WEfWKF5Yd5WEH+98Dc80Q+/zPeDNEBzU1KDfYPkuVjChHE9fDfN?=
 =?us-ascii?Q?3J8vkYxgtzpAXbQNPZqeY8T5YMVLGEbF7DRFQ9ZOoa49t07OTd//wRihxh/H?=
 =?us-ascii?Q?r9IcxZrnt3sKu4HSvyWaKDHTQ7UaArYLShZENV/RnF/DA5OOZWs7uQH+Sqdj?=
 =?us-ascii?Q?K28wzZH5N2gBetVflClKzddaIYoRBBLMZPamr3uZFNdbORraURF0nMpOimKK?=
 =?us-ascii?Q?6TQlc8l8yNZlWNLaxGk/OcZZ6nPTZlxWShxPdcS73MdUS8tQwAnU2oFepbFw?=
 =?us-ascii?Q?jczvhCmpRDtMdSwLTdxX28KQ5FOEzwAj9JIkIhA654C+9T+aD3kV9fgwCiVu?=
 =?us-ascii?Q?D08C61LgkatXXWAhrhml88AkMPQX1GEHc5kFWfPLtVqxb+/OvxuUvYd+c4J6?=
 =?us-ascii?Q?2cRyyCQbrsUdq4GzBAjSMdKGujlHOOovlQ7ILQaVzhMpOWjEgw2p9XJI8FzF?=
 =?us-ascii?Q?m2UNC73q1Gy4AXHHTNfZmPmgN5EgPXDOeOh0XmTlSaiIe/ccDKuRd7ztXiOg?=
 =?us-ascii?Q?Ae0BXFATXWCy0/l+UPGv43rL37Z0/aMh5XL6oYox?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1a2daf-b944-477c-84ef-08dd36558fd0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 17:45:27.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZvrkA9BwZYip8afeNqJl4YWMwMLBIMUu3zMGkHJaMWeoAHpS4yzFHzhHEaufWCfnrBapdGlIhFf/QrUefkI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593

On Thu, Jan 16, 2025 at 11:01:14AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 26, 2024 at 03:56:58PM +0800, Richard Zhu wrote:
> > Ensure the *_enable_ref_clk() function is symmetric by addressing missing
> > disable parts on some platforms.
> >
> > Fixes: d0a75c791f98 ("PCI: imx6: Factor out ref clock disable to match enable")
>
> The patch below looks fine to me, and I guess it's more than just
> making the code prettier; it also actually *fixes* something, right?
>
> It looks like a functional change because imx_pcie_clk_enable() will
> now enable the IMX7D refclk when it didn't before, and
> imx_pcie_clk_disable() will disable the IMX6SX and IMX8M* refclk when
> it didn't before?
>
> But I don't think the Fixes: tag is correct.  I looked at uses of
> these symbols:
>
>   IMX6SX_GPR12_PCIE_TEST_POWERDOWN
>     enabled by imx6_pcie_enable_ref_clk()
>     disabled by imx6_pcie_assert_core_reset()
>
>   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL
>     enabled by imx6_pcie_init_phy()
>     disabled by imx6_pcie_clk_disable()
>
>   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE
>     enabled by imx6_pcie_enable_ref_clk()
>
> As far as I can tell, these uses are identical before and after
> d0a75c791f98 ("PCI: imx6: Factor out ref clock disable to match
> enable").

You can drop fixes tags

Frank
>
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 413db182ce9f..ab2c97a8c327 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -599,10 +599,9 @@ static int imx_pcie_attach_pd(struct device *dev)
> >
> >  static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> >  {
> > -	if (enable)
> > -		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> > -
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> > +			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> >  	return 0;
> >  }
> >
> > @@ -631,19 +630,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> >  {
> >  	int offset = imx_pcie_grp_offset(imx_pcie);
> >
> > -	if (enable) {
> > -		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> > -		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> > -	}
> > -
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> > +			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> > +			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> > +			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> > +			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
> >  	return 0;
> >  }
> >
> >  static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> >  {
> > -	if (!enable)
> > -		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > +			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > +			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> >  	return 0;
> >  }
> >
> > --
> > 2.37.1
> >

