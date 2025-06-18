Return-Path: <linux-pci+bounces-30097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED7ADF32B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A960168213
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77F2FEE18;
	Wed, 18 Jun 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bs1skNr7"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903842FEE2D;
	Wed, 18 Jun 2025 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750265781; cv=fail; b=a7IfysdQrRZCYw7bCgGPVqaI4NhPr/wGU2KJ/fAgK2+dTrDvyr5etPNPiiq7aRj/mMgYtMw806ns5FrsptMdfSPuV8l84Vyo4E1MrUeyNU3IYiWpDGPRUe4Dfp2SCMB1hquaFiP7FNaQohSYfbSIEU09j7rJJBdgnQuKYn7Bon4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750265781; c=relaxed/simple;
	bh=vDHOrGxFQHa+6Xx8iYYjPXGP0tsrxXPvoWj2I3wsybE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fsz7GoJwMMYmNKUjkQnF9m+V8LF/aadCrRSGkUf3/GPvAXi9qLrCuNHnOwSUDw2QmMC+mP3PcNeGvLUWwfdn1bTnLgLHdDEE25NCUNRdc61++iDZk1e3+4jednvSWHPD1CnnN5Hv5n8daLNOYVjtcRuQBqE1faxax+8VGa6lM3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bs1skNr7; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUZiy82AwHal3yDzqMQFBKIF7MOoUEe2+qtp6TGiXtN4ZV9MH1c31jih+b7WJs6wKKmn96/6OhXkkDSQRl1/wTOHpS0ntUif+WdDuKQCaBpMd+eX6qxYI3P2v2EWmY3Fp4GUCjT161V3B+UQeVvDuZlB7YdSey59YuMhp/0gFPwz6O3x82c1vdt0PAOYoAKTJmF2EqKatsBH5m8mLuazprb4RaiQy5aRcxOa4dj70LzlomlfoO+BtdHkHspJpFczgnamjD+BGWbCGjm/J+0lLhwisomPSNXjEvUNkyADU0lvHG8Pi2/26+HOWTpkqylNn5INVxtYhBuztTVZvKg3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUom+/4Oe6wGFXKvfrWhiWeAEG8v+mPzyZm4W0qQsb8=;
 b=xPZ9fXDAZVsfz0FC01MJDmq2OjO+K7I3afsHvOogCNWb5G93+zAdOaduQWWdIx4lCrru9v7s05nZBq95HtWmgPKv2LCzXCpcf/mT8Lfj2Q1FCRtDev3qYOGYi9Lhmxu3bfC3C0XdKivITJN7HVqVL8/C8W0t+HH8ITabs4K0i3ggurVh2wBH/HhOnmahS0XLzwW1ih8+T9so9NXHptJVnOKK3jA5YyX4PwcIYrhRsejOmG6xBHiXXrxAG+iPR7sRLHrXzWLm0RpxK13f56n0+poSFiiRuxvQ9JRJhnyG0F7rIjpLCOWh8fKWYnlXUS1u6D11kgnNM5rCM9j7W8iihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUom+/4Oe6wGFXKvfrWhiWeAEG8v+mPzyZm4W0qQsb8=;
 b=bs1skNr7RAAFre/8LX0lWLvFsidoi5csE9I1i5axS+WjlMevesWMqZ37cvm0AcvyeegauLt3dEOTESvK3TST+JXn/q2Ju5++xE5aN3WuNNn0+8aWqSv1MNJDyQbU6v5zSp+viXMBzjZ+9lru4Oe10iq1gyu59PYyOsHNoaKpDWt5hb8ZbMVN2IdgrvUtY/FjsRaZe3kzHiI0aWrr/o7kBbM/gQxehab3QBJOGGfDLgqSEckja0i0xnkT6BRBXtPvTKtS9pENJnmgE4iTWuvxp7BmRzgP+VoHNdXUlUlYoa0/dDh5avyN8UmEYVUglTDkdHjE7m+4wVk3A6sZwMBaJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10961.eurprd04.prod.outlook.com (2603:10a6:102:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 16:56:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:56:13 +0000
Date: Wed, 18 Jun 2025 12:56:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Enable the vpcie regulator when fetch it
Message-ID: <aFLvpRd56i5F9fMd@lizhi-Precision-Tower-5810>
References: <20250618082042.3900021-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618082042.3900021-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10961:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bb84a1-5296-4236-1953-08ddae8908b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DxM99tgJbsHBKQhc+OdC43o5zONJ7weGHTtfv8XqguWkQnOhG/2jdBr52Z++?=
 =?us-ascii?Q?AXcTEGqlgS/G73c4cbXcUowEMoU6N4olZms8GuOnjdG0qiMQPj9HlGM87JIh?=
 =?us-ascii?Q?QuTSct2C0cylpXvQQ3/lisF17QwZDm7AudZaJ3yTT1Gb+5nIASTPJHNSitT8?=
 =?us-ascii?Q?Puuv5ISqk83vT3Of4DgnxKB3kGonMFn8tkAcKaR/cFHYeDaYebRWXj9R8G5w?=
 =?us-ascii?Q?UL7ebX71ugT7BTLeN37bJnZdVRnRK/MNDTAoPO+FYwuNPAvyOGoAP98nLHZ8?=
 =?us-ascii?Q?Ep+Hk0OsHsYP2IfgtPkENb9dmmWsKMqWuGNfvpTGFQe361Se6mPm8KpZPBxK?=
 =?us-ascii?Q?InVQgbup9UXH60XmK0XKUBf55zyz/gxiqjsyIi69jlqEqVqbf9K9rFoWQtbU?=
 =?us-ascii?Q?E1/nFvkt3nVmHD9W8o+B09YB+hWMgTicm6F00xc/ic2lTjDap/Gs2MBk1V2e?=
 =?us-ascii?Q?GJTJhQUamQLOEj78ZHH+wgQTCgqV7NanebGpLHL7RudyvJhuBppcuHi8LRw1?=
 =?us-ascii?Q?BcsWid4AZplThNU1WFKH2DVTD0Vnkob02EqvlmPYQU4FTWDeAGoEtEtZrmyw?=
 =?us-ascii?Q?e0/uB77CWZ9pzlQL/ZKIYoXZDVHG2pfYCOmk4kyPPXQ4tk6LtixlA0A5JPLJ?=
 =?us-ascii?Q?aHtvTm8LtWP3WUwDBFAjvHupQ4wUy4EL9hlAcXHWzdFiooU5i8Jjgag24NPn?=
 =?us-ascii?Q?2Nwx8GgJgYtFnLKIVOFuSSxo4mgKB0vq3f5r83TThsvt+hjgEZvkwCucvclg?=
 =?us-ascii?Q?LbFBc3W/SEexs7/fQD469mP+KDJDTqI/PnUFOWdkt4KoGiV99NNmN9xqjiiD?=
 =?us-ascii?Q?EHW0En8Fbv5jBVG7Qs2NIcGQGnoPcwc69pj5kKO7p/RF5C3aWCbcAIIObw5Q?=
 =?us-ascii?Q?WYtOGHKTZjdwrpnpO7Zonm6NXuGacSaDwoO39bmIrQJJNEZFkkYWPXJyjZHS?=
 =?us-ascii?Q?3S5aqJhkfE+294M32OD4m5GJgQIYY5kU8T4syX0jSyRzFvjcPF92ur9gpVef?=
 =?us-ascii?Q?9Anz6Ge8lZ9jm6NMzFmp5ym1P47m03VS7rJuvsVWZAdnnOrDOQa6B1IL0fXY?=
 =?us-ascii?Q?WoqyWmSvRzuEyuWB3Ixqe3A6fhzT+GAqzM96lkk8fAB15Vz57HE4Nfe1AD2H?=
 =?us-ascii?Q?S97V7HVF+cPpGhQyGLjOurCn7isJDxbOQLsTABfXAIJfwPch2RmpeU2sDqir?=
 =?us-ascii?Q?utAuaXbWIzigVIjii0AJ65jv7fst2LEbRE/Qc1JxK9Owdgsn5kFMTu+mB+XY?=
 =?us-ascii?Q?GYp+HfnexigJ5HwFyYV6QQUhBVkb98qy4KO7IpFcE/t1hxQVHBKqLwuaugWt?=
 =?us-ascii?Q?LmShl1SpPOTsg1g8nWRU8Tq6mI/r9lLqomADN66v3cGJwBaRwPEOxHkw21+W?=
 =?us-ascii?Q?pOEbYjR8+rioikVb/kFb5vUbMRwLrl9Kdk/AixIKxp2Y/YUaZohOK0kuUwjB?=
 =?us-ascii?Q?9bAEIx0tXWdCJ7MJAJCaji/CUt7Yd1zVESWuEAibB0ZaMbscOb2ezCuBy4Rk?=
 =?us-ascii?Q?81yI026GlXjjDno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vrvSt4oe4dPn9H+T9bsqoe9poj/RXKsxA1pYiJ3ckjAsG5Knlw/v/nM+0TzR?=
 =?us-ascii?Q?WuIjrJClugh9G7HZrTNujFM0FWQzJBrtzAb4H08JTbUogOSJUJY847UVgm6j?=
 =?us-ascii?Q?hCr1cQZmJtlftq19M/V0OjhGC58aJzTLP47KTaeFJlGTp1sNdM94iKhXlXeD?=
 =?us-ascii?Q?XLnIF6uAgYAPDkIAD4l8M1t/8rhB5xhOu/m9pxbj3Q488egLokLen5gYsyeI?=
 =?us-ascii?Q?+sX68EIqAkntlaj/tW1xqq/xGfw6ydvcDaiLbYttJyMW6o4wrP8jNNAp6TwJ?=
 =?us-ascii?Q?mojmwBY0VWpF2u5Wtret59oyv8JwvCbQYeQFNGgHNlobVs3j26v2B9sZgHTZ?=
 =?us-ascii?Q?JKX35oMk/5tlNxTfOmVCzIzftVo0Y1zWVD6rl0KMHxS3IFvrwkzhAep9142O?=
 =?us-ascii?Q?UylRxNW+T6aRHq41K9+6hMFaXsNhA86SI3xQynnip4U6Vk9O5mrlTWttviMd?=
 =?us-ascii?Q?jHZ6qa54CYFmyhp4NgCyi/S19nUtTQk8R27+mZ2LkS4BEC57ql5VPW8kqxFM?=
 =?us-ascii?Q?yuDDcWE6Huqg7pyuEpdwB/E9Ih5XjiuEnGa44CcvAs8MMNlBWbx1UpD9vDyF?=
 =?us-ascii?Q?4My9vw0OGZVxb3eNAWoqnoTAe4TUiiJhWnUiPPx4ZGI1//yZWlxP7ImqzRsx?=
 =?us-ascii?Q?GcXXQEMh+wbNKGgpKZCIHE4A4i5pbzdzKNQf6vyd6aW1a4XD1sfxSTcM1zMr?=
 =?us-ascii?Q?d+fCHjJj6I6HnOyIKs770zGJKeM3Ib3I4qKPbM5i2OxZLp0yc48FE6fGBsCe?=
 =?us-ascii?Q?GT9fZnvmmtf6ITZF4W7jnGpx7NRGhGtkdxQtnfGbnNUWsp2exzAbI+ULWo9x?=
 =?us-ascii?Q?WidujywBk+XruOHIOHTo/pWXySOFV1kJ3L3iHW4UZuRFyTuXsvcZQVOPTMq+?=
 =?us-ascii?Q?eWkgwebHuSlTAvbLa86xQawGzSVsA95OK5U1thp/WOI9AuGQChqyEO4inuTk?=
 =?us-ascii?Q?NjfPU6Hx7tZ6DbUaI9wRpPQfSuXs7EEEjlWcKXZaGb6HS1U2KKyffNxyt/pK?=
 =?us-ascii?Q?dnScPekre6aGZbr97/AVgjHKh8gj9aKHU7jK3C4MwEzSQpjnj/ZtBcQM5JTV?=
 =?us-ascii?Q?+Y88qlrf5lfvQso234lNoAvI51KYTVAGW2qgYiVlh9NYbRad5RV0pL3M1mUp?=
 =?us-ascii?Q?BrF1QXRqqYC3wb02omwCe7KlwYydxIbWxNO7Mf/tMM8UIbGUaPEbx6Dh2qIn?=
 =?us-ascii?Q?hrkq4u5Wn2z/++ZQJv4EAPkf3K1pgyRAkC87yQRNtn04oqGBibmHxfG00YWA?=
 =?us-ascii?Q?oIb+lJuCU0K1YYPaqZz6jNJj6gunUrcbMuzlp3qhojFBSg2XiMld3USUT4kf?=
 =?us-ascii?Q?4VnTdz0O0QF5AUUjxkp/TNFi/nnNw+7NaH9IgkTFpniHSRBnms0VLtbPg0oM?=
 =?us-ascii?Q?CQBy8qYv5jnC046ieRM9gFbWNqs+GHBZhK3ei3w4BZsTOuP0z+O/iRZGz1jj?=
 =?us-ascii?Q?mQ7qbo/1SqPFmzjNKVHWYT9HEPcfjZUw7GA0N1I0GE57jin+hEQtLOUD84c0?=
 =?us-ascii?Q?P047TKLFzStU1Xa5V2qtcmUX4bD1O4SzKzxdWO8CPfAxooQgcVLqkO9+g+2a?=
 =?us-ascii?Q?5tlgFeCD+/+EYL4VYt4/YPvhMGvELoRIMo/si1hJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bb84a1-5296-4236-1953-08ddae8908b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 16:56:13.7635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m36NHXm0Ugvn1iryyJNuhaVDQPQyFyR1fZDaVxTCNOqoZ+VY2JNiHayIoTkJjRxbU7l4EhUXmOsg2fNXTBdrBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10961

On Wed, Jun 18, 2025 at 04:20:42PM +0800, Richard Zhu wrote:
> vpcie regulator is used to provide power to the PCIe port include WAKE#
> signal on i.MX. To support outbound wake up mechanism, enable the vpcie
> regulator when fetch it, and keep it on during PCIe port life cycle.

Not sure if this is related

https://lore.kernel.org/linux-pci/20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com/
https://lore.kernel.org/linux-pci/20250610164154.GA812762@bhelgaas/

look like it is port property

Frank

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..7cab4bcfae56 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -159,7 +159,6 @@ struct imx_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
> -	struct regulator	*vpcie;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
>
> @@ -1198,15 +1197,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
>  	int ret;
>
> -	if (imx_pcie->vpcie) {
> -		ret = regulator_enable(imx_pcie->vpcie);
> -		if (ret) {
> -			dev_err(dev, "failed to enable vpcie regulator: %d\n",
> -				ret);
> -			return ret;
> -		}
> -	}
> -
>  	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
>  		pp->bridge->enable_device = imx_pcie_enable_device;
>  		pp->bridge->disable_device = imx_pcie_disable_device;
> @@ -1222,7 +1212,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	ret = imx_pcie_clk_enable(imx_pcie);
>  	if (ret) {
>  		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> -		goto err_reg_disable;
> +		return ret;
>  	}
>
>  	if (imx_pcie->phy) {
> @@ -1269,9 +1259,6 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  	phy_exit(imx_pcie->phy);
>  err_clk_disable:
>  	imx_pcie_clk_disable(imx_pcie);
> -err_reg_disable:
> -	if (imx_pcie->vpcie)
> -		regulator_disable(imx_pcie->vpcie);
>  	return ret;
>  }
>
> @@ -1286,9 +1273,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		phy_exit(imx_pcie->phy);
>  	}
>  	imx_pcie_clk_disable(imx_pcie);
> -
> -	if (imx_pcie->vpcie)
> -		regulator_disable(imx_pcie->vpcie);
>  }
>
>  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> @@ -1739,12 +1723,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>
> -	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
> -	if (IS_ERR(imx_pcie->vpcie)) {
> -		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
> -			return PTR_ERR(imx_pcie->vpcie);
> -		imx_pcie->vpcie = NULL;
> -	}
> +	ret = devm_regulator_get_enable_optional(&pdev->dev, "vpcie");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vpcie");
>
>  	imx_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
>  	if (IS_ERR(imx_pcie->vph)) {
> --
> 2.37.1
>

