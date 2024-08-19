Return-Path: <linux-pci+bounces-11811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D922956DBB
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 16:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DE21C22785
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429F16A92B;
	Mon, 19 Aug 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6V8OTnn"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013045.outbound.protection.outlook.com [52.101.67.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB891BDCF;
	Mon, 19 Aug 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078728; cv=fail; b=tKEHGLZHB/n8t6GpusWTiJdwyfAfvb9kl3lNSUJfF29Gwgl44DyoP3BJf3f55Qa6XlR6FbLl4Y1NfNza17Yox7XAMXKiZ86tCM7vUntRCf6vJED7nUd8DI9yFXA5b2F0XCCJp66EksQyuO959NBzCidDsEfuXqURoiwZFaO2EGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078728; c=relaxed/simple;
	bh=2PNrQNouf7XrWojvj+qG/BeyeFyOLpeCK0+XpPmD5is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ULmObtoAOOkRW6uPjw3+NMz7LMBCGrPMSmE5KQ+cJuD8qZ0ds767QVUfRRBTICFemOsgh5wdqffQfHM/3rAsjCDAuJ7D05NIgc8/tcYPM7Viv4voHnhqQuI0dkgbBZX3rKbpacP/QjhKMBI2G7D08JU3/jhtv00Udd5BOGUCh28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S6V8OTnn; arc=fail smtp.client-ip=52.101.67.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx+0AYirMiTO+4kfOGopAGSNB0K9YsjoDojmaIJ9+aB5bAdDh+ZMlvmZRtD1yGIHTtV1RxA621LyayBYLLJqUKY+BjvJCHd/Vs/laPdESm2CFUUTTrg00JbexPyB6CqlJBUcGRp4V1YH8otqoQi6spcICbPVjt9hNpxgT0UPlvrk7XjbTmQ7AMb57vaeSkdlJWTk966y1FVwVGUpFXcEtDfK72ABvgnzLN8nniZl5etc14a+ETtq9klVdNBRRSIbTGm3peULAgshr23Sw82Gv15QAsSPyhPVw68fTNJTaVImpe/Sw2NQ87QrzozHWRXMmDjN3dgy1WCDIWsR94umrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WOygTGMW4OmiUVg0LifCCjfWY5YUu48DSGmHXhrAug=;
 b=K7T7T9u+vmYWOWwyrk3amj4lFgxAo/o+Nms0kmUdZb7ok+qPN0GwGAZGKqMRhkbPUPqCqxPjKmd/YXbimYIRWr3HUk2zHsg5rF86zkUOBv8M++ndbI8Gpwpyb16gpOkeLBxBsWTbzHzdia3olFTn8G4+javLzIg1sw2YANi9NS1lxolYLnd+9BORrx+peAGK8vAc552HrpW0NZE+5NVKWrgLRxr8XQKB7wovcOL/niaz5D2poGLr+4DQa8bFnEDBhXkzzYzUeATXAq4vq36dSqLYOvrCibfGuDMJsQ0h56XTzul6jTUzaLtXXa107TKlx7x9aH6pIZkpEkdeGVDnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WOygTGMW4OmiUVg0LifCCjfWY5YUu48DSGmHXhrAug=;
 b=S6V8OTnndGEFKnWT+iJLA3XrrN67YDQ6gqu4U7YdidvPD46NJkPpppp8/o+iDKUa7JUky7c9YARUrMhN5fpDeU/tl7s2IJe6cZRH1MpsRAZ2ESq/xwdDUx5ZSxU64pSGcl3ldksiv08PLr8Hy6aG5KC3NrskK7E+azVkoUNJ4BL7OcF1C3oNKzVGCS52U98hvE2DZllIJN1txijqeU1bxKkJwDoWko2a0/rprYQmKjyk94i7oxc0F+6zHNhMTgtu3XlivDfxe4pFvuWq94B/KfNWLxoVj8iHYx487yVkQSDxnW1BBV33AQp1rEu0/vvZyPw0yl44Ob/OrCDPGUccRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9796.eurprd04.prod.outlook.com (2603:10a6:10:4e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:45:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:45:23 +0000
Date: Mon, 19 Aug 2024 10:45:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 2/3] PCI: imx6: move the wait for clock stabilization
 to enable ref clk
Message-ID: <ZsNaeV29s913HU6E@lizhi-Precision-Tower-5810>
References: <20240819090428.17349-1-eichest@gmail.com>
 <20240819090428.17349-3-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819090428.17349-3-eichest@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a9ba98-7470-430b-fe67-08dcc05d8e16
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?g8NtHLeNKwwjEyhaBfzcMdW2xFvgHOxcbVtJ5drx/0o896UiQOMMhu7d6Ew1?=
 =?us-ascii?Q?6WGkKhICWTOduLzc43pUZSnftYy+CehihZgrLB3nW5wXEsTMhuJj3ftFhg9T?=
 =?us-ascii?Q?mdYtQaQbeycpl4HdgH6eWX9LDfhpOuW99FYiGV8Vg+Tgx2RcjFfNRG6v0OMg?=
 =?us-ascii?Q?TbsTsF5x7jpiKG0YQQHHLM9vqlHtWWe/JAVWTLkozGlLs6YljTjpgYDM5N8L?=
 =?us-ascii?Q?A3olG0CA7+XlGGnH2PfjFdvta1HvoplKhTvXzqPPDg7r18B5n3/7opdqcmTq?=
 =?us-ascii?Q?tdTmyzSqzHSm9VMqQbtxqVSok4HnU3E4QL4j6nsYBnhHuTblZcq6C6+zSF78?=
 =?us-ascii?Q?QqlcQFivdemIpyhQC3INKpJcSDzjtaN3zxhCXM20bkum5k27M82y0fb2ur91?=
 =?us-ascii?Q?BbVfcN7I8LNmqsr0wuOIdRSL7MWyNd9XKimu3anrRSUgJGiCTGGo3WeA/jV9?=
 =?us-ascii?Q?Rno1cBplix+0U9uZv9k/2HRqr2aiuBxt8u25AOUi6eSuOG3Y8sMsA06N8GRC?=
 =?us-ascii?Q?nS5Pu0C2kV40fD/EqQhmGbJ6sNbBxVuziSrHORuH/CB5qNQmtmTZMjmPYbxm?=
 =?us-ascii?Q?3QSreOg1mPqyl2rScE7NT57HJzib6QzmuIQzTv0XEa7NWAScyHeUW77VqSkx?=
 =?us-ascii?Q?pw3aeZTcTniDiF2OImGTu9W1fUxibJ9kyqsh4GgbT8JI71bGUquXn0ng77DX?=
 =?us-ascii?Q?/xLTSywKrmN0R/v34rw5F/AJ+XM0k1ilU+NJcjls3qmC71TRaVRwdTEElVYy?=
 =?us-ascii?Q?7+RS6GcZz/JYCblsI290YS9LBw7GMFst4iAaGVQOq7fQPN17lFm9mDYrUK+t?=
 =?us-ascii?Q?WyTDPdP2742I4Zcq8FVO202cWj7YjeyOUrUIBObvD2K1eYX6l0fUu2b1uWaF?=
 =?us-ascii?Q?lPn/QXqpLIT6V+fHsiizyReqkRsuUQH+Vcbcb93tIJBBCSojuowfwNxJ+MF+?=
 =?us-ascii?Q?dHBLOWdptEH66j3WsogiAFi/o4g92F8DHN0Pj5SrbKP/c0OHgBT6KCcfAoZ5?=
 =?us-ascii?Q?QYUGIGWzqKqqSrBzzHbj1crn7ZIkfOv6uZ2blDHoZHvUy5e1aXl4RqTGICwG?=
 =?us-ascii?Q?RmU2VuU2lru5W/tnIazKz5ILSXhju6kY4ubzpfUb3vqnaU5p9xYkKG9DPTa+?=
 =?us-ascii?Q?fsnU6WGWyTKEzF3ZuAl4A+chDzozp2QBs3HTn+x3ELHBkSv8NXQeSwKGfb9a?=
 =?us-ascii?Q?Ow1j0Gimnmfnke1j4YyJwGU6EGiRQ72Bb2xf2+/SJBHvzkP3X0ax2+6iDawc?=
 =?us-ascii?Q?Ktg3D7zWwLA1F7Lnutw9R3q4mAWbt1BOh1ygRy/l7cL25nDAphr+122mMjSH?=
 =?us-ascii?Q?pzxLNeV2eVmclMDPEXfWvZU8EscS5+0pps6O46VmjtDXEgeKUBn1czJ8C5z0?=
 =?us-ascii?Q?SXP1AN0No9fl2WhfYJK8c1jYG6oNqlTLNVe/kECrNsvzUNfSLA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?qSIqxwhp4hcSBmPu71zrh2y48Ajh3M8z3YHIDE7wAqjwNUzzU6aEk/EiESGq?=
 =?us-ascii?Q?L2SBb+xqrsQZvDk1IB2dcB7ikVMtBOpxoiEvqsu7nVIoKJyjvGNjZ1Q0Qpuj?=
 =?us-ascii?Q?kEWz3H4AfaZaV0eFBR5J6WWHg3Ddf3CShYwGuReqNngaCbAM1eRI6Mk1UoAa?=
 =?us-ascii?Q?e21mhEr6eBofhCWWkiqneXv5HG9aJsFrWC/PeMLLvNCr3cmMBkB7XerJfjlc?=
 =?us-ascii?Q?JFTVlXoQiF7ZkpRb9p9M1qDGA3Dg0NxqO1lxQKkONWAn3xjteNK3BrbhilPz?=
 =?us-ascii?Q?bwIyckWAvHonatBCUq2MHkG9gzqDr7g3tQwfL548q71K/72GDnJ3dQr/m3Vy?=
 =?us-ascii?Q?wSJvX/zEXNjd77XOYdticUM19OVBle/aOrr7/hwCbY5wNho3Ig9x9egp1XcL?=
 =?us-ascii?Q?5kPCBk6fdlDsPTHcHunG2zDuuYLXsYl8WopahEF66PCca1t+nDJmRwAVY2jS?=
 =?us-ascii?Q?5YvO+alTN9tsGZPwkoSeAfLAvqJt65cZP/WKsRTR1o+ET3fC5eTkeo1THKJz?=
 =?us-ascii?Q?gTQW5A/UZhc3Ok53is+5FwZzeqPwQBgBN77olX3Of2kX2PVCHp3ycKLaccOQ?=
 =?us-ascii?Q?3iJE2thlPklxYk9bu4PCcgqR+1iai9ZBR0KvklVd9ItlCM27hEATQxbMLhfo?=
 =?us-ascii?Q?oaHUvbdaBxny0WPxzsov5mUfpE7m7y1ya7GvfU1DF7LMMVGckr40HDqJQjWl?=
 =?us-ascii?Q?HIGS3bhunGcIYNL9tdqcWCCWEyHFTbHvx9lvahlamfWYGYdRaCPb4pIc05Sq?=
 =?us-ascii?Q?808DxmKa95RBTdj97A0N8gGvFo7ffFaZ6Waax2pEBHxt24XEEIIlxAcXn9pY?=
 =?us-ascii?Q?xgLmM9ZGsX00tJYrYV3oEZYGOZM+Aj64oP08hhlb4zx+zFDcRcu0K4y5mWe2?=
 =?us-ascii?Q?VK3ajov2W4mFSbBZ5eJShbimq9+j9DL2aQeciHmN8Gp73sdMwUi1XE+h4mCm?=
 =?us-ascii?Q?5iULwwUuFGJdbsG9L9OS9ZBkSv4O5jAk5uT4BXwUpIlNXOf9TAs/do/CrXe0?=
 =?us-ascii?Q?F+5ZNk2ZDoepOkLuo3N3NGFiYkf5uhjqutcr5C+XdKxjtuXBfHUDgkLmyX2T?=
 =?us-ascii?Q?O/4CybKss8QlMCgr45rmpBxZufk9cUSDYr9dyvVRhfHLgggaot9FER+9vgQQ?=
 =?us-ascii?Q?S0aAuNhbwGwelfpC/qij2Ef4PUbrEMFS1EPCUnmtYkc45JSNBkTtXwtZeyk6?=
 =?us-ascii?Q?QPTWLmklfKsUPLObmKktSERLzzKPZRDqUBP4X4ppIqLoCMQPouDe2ObDrR9j?=
 =?us-ascii?Q?uoHbG8iGoK3KXcsb09vuLPaUKpZNsdP06cHBtGVRlyOmrorokn6lM1nikKQC?=
 =?us-ascii?Q?enwNGKnG8wSGRxbVc2YRckMxvTSoudvnSstu4y65MguPqWFdwBYsHP8vmsuN?=
 =?us-ascii?Q?riH+tA+nil4XUSNeLZAKsfM/Qf5SK8vplCmYYc06OWYvkayDmFZAa2YYzWBS?=
 =?us-ascii?Q?4qcEJTwvw8iNFPyNG56+NaW+eMMWZypeCRziPCi1n9Kq/T4lf+Ulqc6xJH/p?=
 =?us-ascii?Q?iGIPw+m/gqNSmJPvUPw6zvj6XdsiIIU0np2iSuSbaRiK8Baq5yGMMGsNoAUA?=
 =?us-ascii?Q?DnDRubsAHH/wRwcJFLUMuJ9GSetNRlmyugTkle/q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a9ba98-7470-430b-fe67-08dcc05d8e16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:45:23.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW7dPc1ZWas+sp5tcAyRUSMm0NKGYgHw1yNrl87EpvMTUqqHp6d7KKla20bLa0GrQaCwlXQOOuDvfOGBtRzaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9796

On Mon, Aug 19, 2024 at 11:03:18AM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> After enabling the ref clock, we should wait for the clock to stabilize.
> To eliminate the need for code duplication in the future, move the
> usleep to the enable_ref_clk function.

Logically, it's better wait in imx6_pcie_clk_enable(). But not sure why
it can reduce duplication.

Frank

>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index fda704d82431f..f17561791e35a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -632,6 +632,9 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		break;
>  	}
>
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +
>  	return ret;
>  }
>
> @@ -672,8 +675,6 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
>  		goto err_ref_clk;
>  	}
>
> -	/* allow the clocks to stabilize */
> -	usleep_range(200, 500);
>  	return 0;
>
>  err_ref_clk:
> --
> 2.43.0
>

