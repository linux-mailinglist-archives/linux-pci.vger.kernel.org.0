Return-Path: <linux-pci+bounces-29489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299FAD5E82
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E801E0544
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005781922DC;
	Wed, 11 Jun 2025 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K44ty8pS"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339A18787A;
	Wed, 11 Jun 2025 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667565; cv=fail; b=GMf64z8HNR5INxptHJFSzIiyuFslf76LRMUJ8KNCLo30iG1Ah6/BcxiW2L0aBDexbmRneAs47NMQEsrqH94jv7Se46zBy80rAvKr5JSGtMklu9f3AtqFuHmmrhy+Vj+Lm2xYnojnWdTq0M+4xX5eUh77xQSnlkPIPA+SjAqFCwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667565; c=relaxed/simple;
	bh=es33RJpeXZ2KDTAuv9p5HprhxL/sEAds5sIUaBX/uUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OKQWiD9Qr+eU1QE0sjDqvqBWUHgOg0lUy12Ho1iPcKNJiTmDBvXUndhmINiE80CPnZysJ5ea3ia/T24e+AQ11ffRrygkpdZq8neQbt6Z6BzSBfofJ6TPNZwTEflW7zoVGTYYcUSo6KO0Daqjbvx5iTC7BA7lcJoFPQWMB2FqfY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K44ty8pS; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKPnEp68OdJpsylU7/I14UEIR5VB7A2xfcLCPhgXJ0G5xwvngzvGCwo890qorU2BftJsTZQWfoFg7QKxhcsXfaZ2ZYkkQZg1VsLMapuXiLqjzDgPbmMavi2JvgdmnNvdOVJAjtQVZ90wcqP6t1hFLF5dZnyK6GPkDfz5SKIbECoKskTvcXnAJdWMP4xsXhqfK1+mMFKAujO/jn3WikmuAUn2i4CvhT5wnq5mW6q06SULME521lYBcH98/TbDOE3E94GnCKDYfrIE3LKqFgourpqKsAw7/khx86biUKhlOhN6TLkV5bcoC7BhitbubilFQcamx3ZvvHfh110lu7dygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33NfDAuygudf64zZoA4UY5+AHakmGCff3VAqTDyEfYA=;
 b=isGkBNYmAV7u9zWehK+ZyV66FWyluFuy3GnkFydd70WUJXNVDxvVy9pywbu32FSYmIy6mnpmeABKfLzczxkujA7SxPuv7OmhpPmQeEwTA8N8zJ5PlP/UyAiZmyuVQsUtVryUnF1Tjnmi8Nu8zJcUeupZr5FLmLjtvqWjyw5xTXd21QDwChZo0hxw6GRstt1JCNEwC22FZtb3bJhDFGwbxKjZYQwFQfJwJGnDIbNhyIbHAEV1ew8mvEh73nFTNTMjVC61ECZO1TfL7Mb4eaJUQY2JaRZ0SnVL6A1fvi6cNjuXvtWAmnYyaMD1yIOOtQyw2Hr9YVEAEkcvFV7lCv3wAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33NfDAuygudf64zZoA4UY5+AHakmGCff3VAqTDyEfYA=;
 b=K44ty8pSUqM5ym+t3Urd0eWxl2pq3C4hoPOqSA9OrU2eZRB6z9wPRJ1JzE9xcv8f5G/tenhrS7b3RoM3C7llzGe3rOs1kPsdaLyn+ewEaQ//xm9azA6ToTdg+5pDNLyJ695HT9dSwD7Ctd+g7kUpFl6xJQIPO2TS3mXfcRXXh8PNgizDJ3luwRs5/ZFktSJfdS2nStIeo0cCqT+fWLGNno+jlbRe0Gv8JI4tzVpXt4lAkYVRQHpPDDVYuMlrcX+u+/55rPiVtoVuySw9hcEksQ1/Hv6zwdZsZXwKyR76Tkmm3K4YD1YKeav06o+h1ApD2Aa1gedDM2hKGxW2NPn7Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7362.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 18:46:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 18:46:00 +0000
Date: Wed, 11 Jun 2025 14:45:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, jingoohan1@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] PCI: dwc: Refactor imx6 to use
 dw_pcie_clear_and_set_dword()
Message-ID: <aEnO4QSrAzEHzoAe@lizhi-Precision-Tower-5810>
References: <20250611163121.860619-1-18255117159@163.com>
 <aEnNFgv08BVVxfOQ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEnNFgv08BVVxfOQ@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5257f4-e14e-4c05-cee1-08dda91835c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?716YzQTn+9MyZYpjQ7wt8EqSQ8yXBKXNGebIYK/Y2TFwtld2iuJ15iTuaS3E?=
 =?us-ascii?Q?5EEtjol2ekSeyy/DlGAZ2D58SPNhhzIoWxIjp84smqXQQI7HbzZHkQbWWeb0?=
 =?us-ascii?Q?rYmxjdkTGzaP/w56t/l3HsxKmHNkTudwTw7za4CC9j//WII6bIwC1iS1CjuL?=
 =?us-ascii?Q?nDY/D7ihT5lnv/A8hR6P0rbrCoRTVdoWrZ7GZp2y/GlIu+IXcBcOIy+usOoA?=
 =?us-ascii?Q?/pC4ijDkDHRsCNKhLw+X6/nGhlv57+pbsnO+PYJ/8YouD6SGaKlGDQFfq8qU?=
 =?us-ascii?Q?RwxLJ4P7uiV+2W/FGDts2D7jy+7MPWIt5BUQk0skH0mwyn19upgPNAgZ/dVJ?=
 =?us-ascii?Q?BuCiqQg958gXdLqgCg3BohqTCY5OjAGtkTcso4qDXChZO1m5ECM0W+179N6d?=
 =?us-ascii?Q?BU9Di1zsowV/djjjNPq3j5oRDzAP5f9Sv92KCHH3Em6/JKvpC2DMNNnF/vLK?=
 =?us-ascii?Q?HkJ9J92EP3NKCS9GQIyxzl8olrHHpSMguv93zmBKar8SKUoH2PgMUkTxmZfz?=
 =?us-ascii?Q?RU+gfEXk23X6G41dm/EmrxcJ2u0ipv1nB2EgUgzlgKesOkdw1Fl4zbctsY3f?=
 =?us-ascii?Q?ltI62UXzZx8lpCscf1pxMlSMaOB+q7kgxV9cdv0TfCBm9fFkDBq9YxuEzUwI?=
 =?us-ascii?Q?jcM0umi+TwvAjgbng0ebznmBUWtKIRKKDAeuUq7yj/nKm9sGFGq0wakA9kIl?=
 =?us-ascii?Q?AKJx5qvaW/URSMRhSub0EerA6GUxrPnXvX1qT1uJ1mK9CH+/DdClaEm8gXjF?=
 =?us-ascii?Q?pfaLIIV2ENf4KibvgPn/2Iu5nCCy7HmhFLfb7TXP0G3zjMV1nsJovm5wuzS0?=
 =?us-ascii?Q?8xyFp5liu2dEe6PsBHh05v+kAnw7XFBZq+whukDZxb6QNlVG9j+6z4sM5G/S?=
 =?us-ascii?Q?on29dc5FKDx8IGKfU8+++iOTVHI50O+bdefhNDvrEx9Op9xontaAEfckNEQr?=
 =?us-ascii?Q?dIO4jAdPj/XdcZwyeo0S91Lo17yzTDprbQP+y9Mh1ur+lE8nzIX5fjdJsDEL?=
 =?us-ascii?Q?D4owTWsohBVw9TRr3uUSTbAJWn2OB0sx+XRE1CTq2eoXVE8sBEW+xsDEUxov?=
 =?us-ascii?Q?1YMuZOawY8I1RTyDP9itcPoDknfKkNVjTOi1ZbPqeU5SSFg6yswMyvvYR2GY?=
 =?us-ascii?Q?bWNO9mMo+IGuDusLRa7tEyVB9kZ+fVqzNQNRzB11eIa61gl7b96z6LvSZq/k?=
 =?us-ascii?Q?gYA0xueiz3nPUv3sD71L2HkiGoxND98lj3l++h3IkHkxRYRmoF+TpzfxUdSP?=
 =?us-ascii?Q?ulDJotCHt2eFhL2EoUr2Z8XxfqPi5GbPrrv1erhhv3wjzKQs2FIEMVb6LntS?=
 =?us-ascii?Q?eeAtB7Nt6Yzn6T8Xy8aKPOeP41NlBtrAor17niJp14Mt99qjEy5IngsBG69D?=
 =?us-ascii?Q?aX+fA51iHMLMaHZS+ijab1rHOeq6+UVHEh8/wEXuX4TikrX/r/m2K7qfm40d?=
 =?us-ascii?Q?sEGOUMWjv1xRwdg2BPhA3hf0USE1O11fYWrQ0L1qysGndJ0W52ypgdhKez3h?=
 =?us-ascii?Q?DKTg27mUmg3w3Nc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fuxPQIIbLwiyaIp/W9Cw8SckBZF6toP7s/w8BQpPLwVzxaxoxXKsUmmrMijw?=
 =?us-ascii?Q?DiUxb8BVPCtMtXBuE2MOvWK4cFJu+RRdZJzikTA4r7j6T/7NPweFT4q1bfCL?=
 =?us-ascii?Q?l165jECd6V7RosFIIiMpa+UhjtHKO4is1yqa5yHQLaJ3YRKSI23j4wnS1sGU?=
 =?us-ascii?Q?U/gK6mgOlxIPAPWwTmj7/vaAN4olI1MoKKDBi1dNJ8Y2ZbEh3MdgFTpvCM0F?=
 =?us-ascii?Q?vzYb3WTH9MwSfsOAu5AScq/DG3y7NMtEbdvjO84KtuYq7tvNTvMx2OAHfPrp?=
 =?us-ascii?Q?NIgruad8sUrFDTy2r22nm6/UFbjCs5+uJes0NX+6IFt1xVrBFtxbGKrOqNpC?=
 =?us-ascii?Q?OqG7lzLMb+VRDtQcSE5jIzC63zKQWDKLa6NrlQ/whweH4bB72bvzWTz+YcKW?=
 =?us-ascii?Q?u2242kgkaAVijq/5i6Vll0B4YufAu6YIqo1v+N8s8oO5y9ICsaqlr+58ECE8?=
 =?us-ascii?Q?5v+2auTC85Yt1pJnOILxm9nfPWlPrW4/at2G7QbHQ5AkjdUsrSQDt2DTfQZD?=
 =?us-ascii?Q?jZxQJJjvTpz1QTHcJZqzu4/sDO62q8lwG9OxotCG/rClYp0em/tMWjkOGXmM?=
 =?us-ascii?Q?hhccf9Yu05CdwJGNFJjeHfA7EC4F+3nqjnNs9R12KhZIt4j3dwCdoRJV1hOL?=
 =?us-ascii?Q?moIHHerUw9id+N2VyZ6cgpm0gWhUB1EYAwWDYDe/fUZAi+193+4Orws7iBEh?=
 =?us-ascii?Q?4MgBmRtlqEqG0doRDFXjr89jeDb0aMI8rSwaEflKElcLcdxEr4RYHc7kz6rT?=
 =?us-ascii?Q?/ruyPjcOeMWuDD83hdWqF+H+ZMaGinGsQQqGR0B57LB3bvvqmO/mnlzDlkFv?=
 =?us-ascii?Q?JDEYkwrzkKccPBgyMg1ayXiyVuAxCUpckfQbvD/Ch2H7T9IEJIGtHPzQJPcK?=
 =?us-ascii?Q?zpbDh2cUMZJa8+vVfhmsJnMcfInwDOKuzXuB7k/6R5qepEfBGVGs7tgciG2t?=
 =?us-ascii?Q?q+ABjTcy4LFug6pHN7L+c0mSaOBmXZ4HUl/NjmT96Kc65rOKWLt2P7w/DCVI?=
 =?us-ascii?Q?MtBwH76MDlhxmicvv3d3t/npK3Q9sRJtOoUhU1FXUfRAFRvelifXKVH8S3MS?=
 =?us-ascii?Q?QEuhToyg5KJ6EayJ6C90QnQO2ZKuTjvrlIYtuYo8/OvWzTxKAx84dF8cEGgg?=
 =?us-ascii?Q?RU6ZDL2m6Qb+fYZtMAt0PDuyTuQrMXjSBdi3sapmG/rwAgCh9nam54MvSQTi?=
 =?us-ascii?Q?R6LlNnCVyJpmf9/4tkadQbKoj/YIcLGiCR1iUv76RwgrT6PvyzyXu57VFjVY?=
 =?us-ascii?Q?2mYns9XI+MpSpcVpaYPY/ry9Bf7CMohDT/PHycLmuSLpnQgXg/rLZqVBnj1f?=
 =?us-ascii?Q?jBNw75KWaHhqUtW78LeXabvDz6iPYxbOYzrY4uVlbV8f4NaKR+D0nsUx+3hl?=
 =?us-ascii?Q?kgALbVIYG7H+5FZ9fP07zGke5BUbpYoXY7DI2zsHDBErP/355W23d4n5ZzBV?=
 =?us-ascii?Q?36KNIXHilSKbD9jhCcsSjlS0iKZ9lp5Hvz/g/627EWBXDONPaB9p1g7n7b+6?=
 =?us-ascii?Q?Le3HVeHCgiH8yeZRL2967WvyPBB4b6oS1+j88HSpyZMYIbifmON+mPNkgW9P?=
 =?us-ascii?Q?gbtM8NI7Zab2e3WtDRFoyLrZyRashFusQpr7qwMd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5257f4-e14e-4c05-cee1-08dda91835c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:46:00.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU2mqgPrQMCPpJjfGFxhwKhUyrA42wJCcYmKvZZ827KUR46wxqF4G1UUgH95nU1qIRm0d21zZeUqhPstb328fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7362

On Wed, Jun 11, 2025 at 02:38:14PM -0400, Frank Li wrote:
> On Thu, Jun 12, 2025 at 12:31:21AM +0800, Hans Zhang wrote:
>
> Subject should be
>
> PCI: dwc: imx6: Refactor code by using dw_pcie_clear_and_set_dword()
>
> tag "imx6:" should after "dwc:"
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

I sent out too quick, please don't applied my review tag at next version
because I found a issue, see:

https://lore.kernel.org/linux-pci/aEnONwJUSEMdMAUD@lizhi-Precision-Tower-5810/

Frank
>
> > i.MX6 PCIe driver contains multiple read-modify-write sequences for
> > link training and speed configuration. These operations manually handle
> > bit masking and shifting to update specific fields in control registers,
> > particularly for link capabilities and speed change initiation.
> >
> > Refactor link capability configuration and speed change handling using
> > dw_pcie_clear_and_set_dword(). The helper simplifies LNKCAP modification
> > by encapsulating bit clear/set operations and eliminates intermediate
> > variables. For speed change control, replace explicit bit manipulation
> > with direct register updates through the helper.
> >
> > Adopting the standard interface reduces code complexity in link training
> > paths and ensures consistent handling of speed-related bits. The change
> > also prepares the driver for future enhancements to Gen3 link training
> > by centralizing bit manipulation logic.
> >
> > Signed-off-by: Hans Zhang <18255117159@163.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++----------------
> >  1 file changed, 10 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 5a38cfaf989b..3004e432f013 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -941,7 +941,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
> >  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> >  	struct device *dev = pci->dev;
> >  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > -	u32 tmp;
> >  	int ret;
> >
> >  	if (!(imx_pcie->drvdata->flags &
> > @@ -956,10 +955,9 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
> >  	 * bus will not be detected at all.  This happens with PCIe switches.
> >  	 */
> >  	dw_pcie_dbi_ro_wr_en(pci);
> > -	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> > -	tmp &= ~PCI_EXP_LNKCAP_SLS;
> > -	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
> > -	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> > +	dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> > +				    PCI_EXP_LNKCAP_SLS,
> > +				    PCI_EXP_LNKCAP_SLS_2_5GB);
> >  	dw_pcie_dbi_ro_wr_dis(pci);
> >
> >  	/* Start LTSSM. */
> > @@ -972,18 +970,16 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
> >
> >  		/* Allow faster modes after the link is up */
> >  		dw_pcie_dbi_ro_wr_en(pci);
> > -		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> > -		tmp &= ~PCI_EXP_LNKCAP_SLS;
> > -		tmp |= pci->max_link_speed;
> > -		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
> > +		dw_pcie_clear_and_set_dword(pci, offset + PCI_EXP_LNKCAP,
> > +					    PCI_EXP_LNKCAP_SLS,
> > +					    pci->max_link_speed);
> >
> >  		/*
> >  		 * Start Directed Speed Change so the best possible
> >  		 * speed both link partners support can be negotiated.
> >  		 */
> > -		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > -		tmp |= PORT_LOGIC_SPEED_CHANGE;
> > -		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
> > +		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> > +					    0, PORT_LOGIC_SPEED_CHANGE);
> >  		dw_pcie_dbi_ro_wr_dis(pci);
> >
> >  		ret = imx_pcie_wait_for_speed_change(imx_pcie);
> > @@ -1295,7 +1291,6 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> > -	u32 val;
> >
> >  	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
> >  		/*
> > @@ -1310,9 +1305,8 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  		 * to 0.
> >  		 */
> >  		dw_pcie_dbi_ro_wr_en(pci);
> > -		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> > -		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> > -		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> > +		dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
> > +					    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL, 0);
> >  		dw_pcie_dbi_ro_wr_dis(pci);
> >  	}
> >  }
> > --
> > 2.25.1
> >

