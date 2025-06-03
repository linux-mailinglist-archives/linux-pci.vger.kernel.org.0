Return-Path: <linux-pci+bounces-28908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B863ACCDC8
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD8E3A6BCD
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B121324E;
	Tue,  3 Jun 2025 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kLqMZFH+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A10158535;
	Tue,  3 Jun 2025 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748979820; cv=fail; b=iKafXsQrpwS2mZrl7F4B/KuOg57dBIvDqQoPTFUPkpRBoIw6K38YekqtYDMZcFEzymHnBH7SgJC472v5E8QZzt8nxNsRgeS4eQXuUTSLcdpA6V5g+ujh0PqJkpb/KJRdAcInD9xNwn0KYtTNVQ5Toy9Wp0bYMtD1fP5nyM36hVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748979820; c=relaxed/simple;
	bh=CNILbDBbJ2LY72PVw/x7udwiBCcoD55vYNHeIdLJeSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FV7PvPzLr0K+BOsL+knorvmG3Y671ku7Z8Er2e2Ljzpd3iG/+nD6mvVm+bgU9VAAtviAb+Dgo7qoP8BTBVv495vILidRuJ332jvepbl33i1RHLy8W9tH/11TYLhk2zAEZ1A3y17BI37qedrP8Ca9khpp9jrBjTTOJ4GWOrVU4mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kLqMZFH+; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpcMXpIf4tvgm7qilzJ30uUslH7JT0cP/l4+jUCcsVpvC5OyMCwhSHCJjefX6o6RZ8E76+qu/fCKz5Kl4HKfQC/znplkqbaBHBFS7kwbEvRGbX2X9v+U5Fupmdf0tjzHMF5V6O8gTVK/eZiEPFU4nMN2vfENXEhz7YcviJU1F/L6w/Ck0TC4Yplku3eQN3rvjuWZy/xnaAH8K0I2rgQ++3mRrCCGHFCDMoLghA3TxuRGU4L7bVFBVVdpTGTVp7/qfoOdvYJVt40eXN9/I2vvcE6jFvkE46WWKBZ2BSggoefhQ3V3IOSP+hiul8IG2SmF6A84JiU2FT11l+zxL3h3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Jz+rNV81EyP87q/AonFzYbsnvitXb5m0mZzE1YomY=;
 b=PD+cm4W/KwVEaXbRNjAXku726y6LBfddAILYtXqJdRejeI744tEVycolT361rUjtpjUpjUAZkPADxqD1NMhBIsfS0nezFlFh0rkNwpNZEs8iNDnI2S1fawJSOFs44gwo36Ff9hlFjrPjlcTCyk9g+zFuktWD5aIYGGM20/XQBy26qa7UPkbEHLI6Xl3UhClKm0tyRyqheEEiBjmfCyVmHhdavBwmYOma8N+5NKENI4CQZCtz/2k5bQS2VPJAGbw2nDdCAv2D80Dgksif54W/NQGq0a+b6qGhkU2CqyoLyzgXyFS3iRDfZTGSloRgTk5ujHE2MOnM4qjGnSETef1EFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6Jz+rNV81EyP87q/AonFzYbsnvitXb5m0mZzE1YomY=;
 b=kLqMZFH+aykQbbbnCsUvAjTtXKyHqdkGUp9zH1DQwi2pCwsMCUK1zv8UDT0gaW+cckUDxgDuXRZ6gLmGg/m+/Yfe6qWjHeych41/iKgHLYPkvxPENQfkxsBSBmKcPyVNx7N2JKhiA231NHJ62Oh0H4CUEPLwsU+pjIRtM+YlSwBI4USBKqzWoPLJRx1CN9psIz+eAQG4TAE0Zpa6vZSuxnD8D16lSGlqkyNCxogVnXIKl+l4wxOp5FjYhMazNK//SuktlXing468A77GreqCHAu49iWe+Mmeodqm7TFqgZjJPa2cQ99k/umNdjk/BDAI3HE4WJOsrMoUIi+3/5Br/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV4PR04MB11330.eurprd04.prod.outlook.com (2603:10a6:150:29d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 19:43:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Tue, 3 Jun 2025
 19:43:34 +0000
Date: Tue, 3 Jun 2025 15:43:27 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PCI: endpoint: pci-epf-vntb: Align mw naming with
 config names
Message-ID: <aD9QX767hHbCvFHQ@lizhi-Precision-Tower-5810>
References: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
 <20250603-pci-vntb-bar-mapping-v2-2-fc685a22ad28@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603-pci-vntb-bar-mapping-v2-2-fc685a22ad28@baylibre.com>
X-ClientProxiedBy: SJ0PR05CA0188.namprd05.prod.outlook.com
 (2603:10b6:a03:330::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV4PR04MB11330:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d79dad-ee86-41f7-46f4-08dda2d6ed43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wK+E6CnUN3HKaWcIV6WT3t5EUYC89vPP4CfmbcjskiVuu0GLyOULo/uokbhx?=
 =?us-ascii?Q?z2zaxIMX2yJFn3q5JLaVjcOLZtSueVC/qx/ZBfudCmoOo2YsLSrFSRakxec1?=
 =?us-ascii?Q?CQBKHoX5p8kqZW40tj4t4g5j887+Cp7LfDuQc3E01Kh2XGlprGqv87CsGv2B?=
 =?us-ascii?Q?XjRONrSGLLBF1iq5hp3jt4kReDusi0LiQaMZ+Cl4SiReGtFBIX+08FkHxkaQ?=
 =?us-ascii?Q?Bwj8Ug+IQkwYxyEpK4vu0a2DwchlpfD1WwOQRXxMZGuhdnpp3aZ4ZtMUb1pW?=
 =?us-ascii?Q?b4oQg0uwCp3nrrpumwkbY4Od3XWua6r/vw7qKqpwRHWVOTGoyDaBXtE2B0oE?=
 =?us-ascii?Q?d4rs7lgg6Q50EsypFD8xrMkr10gcadTwhEvHJT8bKIP/c2T/k9VpAxncySz2?=
 =?us-ascii?Q?5yY4pQOTFMe4f6AglpQjn82jfUNn1X4WZOUo+vf144CpWFNY+Xfw2NiX7gLq?=
 =?us-ascii?Q?2BGQ6zfv5aiS6taqOrz8x0QzgMAFdip+LfiuJg+nnxePzaIqFDIEDNfEeP9T?=
 =?us-ascii?Q?K2tYEW7Wm2iID9Z7P6nkQqDKi9uqa/ctDHjKlugX/mc8rLrwvWHDlunYpjAs?=
 =?us-ascii?Q?jB6wLZc2jaCC5ck3eR+NiZ/AuzqvUypgekEksQnt4726p3ITa9wJAsKx4v+4?=
 =?us-ascii?Q?5+MlaNdm5/gflwYyuYEecGnDbK0tFmu1Dl3Xz6QF9Ox3JFxg49Haxk7kJVen?=
 =?us-ascii?Q?vUbFwSX3QI44XtYlGLu5MriN+DFdKFj1HQLAQmf2LXO75ArC2vQZPcuAs9TJ?=
 =?us-ascii?Q?KN82eQ2+awoqkWtrZENjtfWprZD5YukKfnDbFmX7qKdsUXCo7z2G2a+WQOpv?=
 =?us-ascii?Q?rLReWZs/tNzUYZCQaW7X5vamMVOZkJMZsfEJN5+HGVVp5mjg2FZhRQH07I/x?=
 =?us-ascii?Q?QiLf1YJ3RrLrZY34vO1lDrja4ASMYt7Kf8h9KLd194v1eDy5CwJLkqKiYDRi?=
 =?us-ascii?Q?LWZNgvgonfl1o45o9o9Qjrlorqm6DRE0xLTBp2jTOEtHlU6bijEevGb4dp1t?=
 =?us-ascii?Q?ZT0peHqrGb7+xXuNWdW2wkq0HSbP8dg9EJQfxdgLpjECROGTs6lZLnE2UxO3?=
 =?us-ascii?Q?MWWrJJOJ+4B2ouwFbcdhOYn7VZhSOvM8fK8LS5np4HQA+wmMruSVYarv3tA1?=
 =?us-ascii?Q?KykJiMapZVlcWsOEmRVmv7BK+l44MfAUKmu7u/n9EZl5OFs1yRW6tn6iwDQE?=
 =?us-ascii?Q?jokZ0VlKSvR/4+JCdWRbbvJ4bfiz0IXjFqLdTYKVRe/CEqmS1S8AYwDKvKY2?=
 =?us-ascii?Q?nWsFFh6UJI4wtre2IkpyTOqDqScICzrG141oQnDWp1C5K/Kgx8YqH+pBQzPZ?=
 =?us-ascii?Q?mxJRS6u9pNgeC+fL8TCj7KCl13ohw+xurLxdSrkXK9IdMQoP8vZB6pO0w2d0?=
 =?us-ascii?Q?cCrbF59NG+znO+2snT9ywrku8YAooAzDP6UYdYAcASu/MMykkpPbSOykuIpm?=
 =?us-ascii?Q?9C3Zs8THhIxAFZ18fTumwnWgf5Up3kGjZeUUMXOJgvEoWrqW/jK3fA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OeHA7VeZJ+93oBsLYwh9TGnDtoDmbSdMTHP9Dt56ejI+y/cY8MFDbXl/TdxW?=
 =?us-ascii?Q?0as/uk4mp58Rdy8ayYFswjmHinRSZBrRSvxtbRTGQE6X0kHfVwE5kMKn+P9p?=
 =?us-ascii?Q?BZNKeSEE8ArKjSfULt4rbtPi1y19GT5pWQb3wzwAXvQKCbC7xnOTX3bHzWZL?=
 =?us-ascii?Q?Agnmfnk6JzvEHHS1yyiW7JebOFfd+5VzpIw2Myk+NbxNlyq4nvOT5qU6koif?=
 =?us-ascii?Q?yp15Boro+iswRKjf9V5rgGGkgOc9hggNsJHS1tzwGNmc4EG8VVheEwWXXsBH?=
 =?us-ascii?Q?A/d3z7f1rW5/dw2PTijVAwvEWlaa5lGC58YpgTT1Rurr+G8/Q3ZYrwnIuRPR?=
 =?us-ascii?Q?L37lcsmLm/FkZt8JkFj32fcgDyX6//A4I0pckjydMpcb6mfOAVypE62hb1qf?=
 =?us-ascii?Q?KWjuiiHjm0//DCBWJ4FPrew9bFt3rmTh78TxxHYlAhRhCjjlc0kiA64MHayj?=
 =?us-ascii?Q?Fc4VbRorYFOyRkBInsoviQn1ZrWP89wryngdE9+sH0fd6NRSymvwds+dV1IT?=
 =?us-ascii?Q?EVk38TWULwRynCgWqdTS26TdsC1Z7jObT4XDdkoI8ML+OLgPb2VKwy992YQF?=
 =?us-ascii?Q?YcgkvTJ+NZJIMQLcwIHOjqREOSqpsGP9MTHDNa0rrrb1c7t9/cEESjYJMw8Y?=
 =?us-ascii?Q?DuFvkuuaeu8oI+1HQVzNXcvtrtYT1Cb2I4V730bS4LrvInfP18ACbB09O97U?=
 =?us-ascii?Q?wgmp3tXkHr6rC1D7Ezmrf0SqVuXTrDjQ5zzfvutUDmXxjsnfNbTAu7cWujt3?=
 =?us-ascii?Q?8bXF/ytcTpDOT68UiYYfsNEzbV6VtzZCDDMhwYdJIPl0r6zt7YLgJY22bXWD?=
 =?us-ascii?Q?FsY3N+cLWiDminYv3icSQ9JZf7nNrnQ7TtwlbY+pC503efFAOPGfRgxKC+8A?=
 =?us-ascii?Q?d+WVB2yTJfa3Vm/1dIkWOoX6q2YjjSh63a7skO1RcwcxPxFnqkwuli8jE6hV?=
 =?us-ascii?Q?OKEqeeRrnk7JxANVd/xi7UpHrdNMTWyjW63zShKmyNPmobtHOal8+FVmxWPD?=
 =?us-ascii?Q?mR1GXtgotDvutratWqoz4HLO3AI3KpVm3wEAO6NJm4BThZ8jyB7Xm8tHsxfc?=
 =?us-ascii?Q?Nm+gvCK4c+rw+6haxwS+m8dl11e2NlQQEJi/CC5hQVbMRHl2+u06nuj/lr/B?=
 =?us-ascii?Q?j4MV4aB+rgFkMk1LBE6iYm1SaLB91xiQjPc0mja0h1uxFBNG98MKaqkf4rv1?=
 =?us-ascii?Q?6x/YvKUeQh8EEQR0tCkYZE4lG4rbe+cgqFAy9ku90MmuH6XeEjMMBEKd9J+L?=
 =?us-ascii?Q?4rv3h6OfDnbpDddC6YTJ0dYDIZZDiUgSZoTiqX2xHT32TxYC+7IlCrb6X0WV?=
 =?us-ascii?Q?US9dwhO8jIL9Ppu0QjHP+9SmHinIPyM25cL/cxfrPC0Gl+W9pNMNZfkWTFGc?=
 =?us-ascii?Q?i897BnjDVFmy/Rok1cq667KLSOsXrOyW8RxiQp/YEsdWEUzuwjsE0hU+cZPt?=
 =?us-ascii?Q?GhLh54bt0SEC6zeRK9mgzyuM8S3GwA8Q4Y5SOC2qfeJDA7ZQJEGmBUdFH5oc?=
 =?us-ascii?Q?wVejdLEj/Yq3kH5oPN1Yljp0cLoXM0ln11SH+9AXSNI0zzK+iT2Gu1vU+aSb?=
 =?us-ascii?Q?5kpJhkD1Bi60S72bp9U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d79dad-ee86-41f7-46f4-08dda2d6ed43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:43:34.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7L6f0U3J0iYsZodQ2sZPQaONdDiwHIil0i2O86fXIKsEngm3kAJjJE3UB0/1dpXzaEeytK/IZpqIiS21/sW3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11330

On Tue, Jun 03, 2025 at 07:03:39PM +0200, Jerome Brunet wrote:
> The config file related to the memory windows start the numbering of
> the MW from 1. The other NTB function does the same, yet the enumeration
> defining the BARs of the vNTB function starts numbering the MW from 0.
>
> Both numbering are fine I suppose but mixing the two is a bit confusing.
> The configfs file being the interface with userspace, lets keep that stable
> and consistently start the numbering of the MW from 1.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 35fa0a21fc91100a5539bff775e7ebc25e1fb9c1..2198282a80a40774047502a37f0288ca396bdb0e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -70,9 +70,9 @@ static struct workqueue_struct *kpcintb_workqueue;
>  enum epf_ntb_bar {
>  	BAR_CONFIG,
>  	BAR_DB,
> -	BAR_MW0,
>  	BAR_MW1,
>  	BAR_MW2,
> +	BAR_MW3,
>  };
>
>  /*
> @@ -576,7 +576,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>
>  	for (i = 0; i < ntb->num_mws; i++) {
>  		size = ntb->mws_size[i];
> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
>
>  		ntb->epf->bar[barno].barno = barno;
>  		ntb->epf->bar[barno].size = size;
> @@ -629,7 +629,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  	int i;
>
>  	for (i = 0; i < num_mws; i++) {
> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
>  		pci_epc_clear_bar(ntb->epf->epc,
>  				  ntb->epf->func_no,
>  				  ntb->epf->vfunc_no,
> @@ -676,7 +676,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
>
>  	/* These are required BARs which are mandatory for NTB functionality */
> -	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
>  		barno = pci_epc_get_next_free_bar(epc_features, barno);
>  		if (barno < 0) {
>  			dev_err(dev, "Fail to get NTB function BAR\n");
> @@ -1048,7 +1048,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	struct device *dev;
>
>  	dev = &ntb->ntb.dev;
> -	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
> +	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
>  	epf_bar->barno = barno;
>
> --
> 2.47.2
>

