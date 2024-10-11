Return-Path: <linux-pci+bounces-14337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206DE99A7E4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 17:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8732282DF8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DF3194C8F;
	Fri, 11 Oct 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/7nPOBw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D05381E;
	Fri, 11 Oct 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660977; cv=fail; b=SUcAA85MCfEbFE/nYa91MYoTgNX1LQfU5PJ0SaboyJIVfaDzez+gLSk+qqEmNSzXSrK1yxjA5akBULQI2H2/lCEnN3QlM09E5tD3zq/zMFQVnMMw09Q6ntHg00ZtvhI008QSmJbA+dpHmBM4TZL0yDULWcINhdWw0neBnJfixsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660977; c=relaxed/simple;
	bh=T4YYjKRc0UhtTmUldS0ge1Qqk8hf+gqKseoxXnRoWCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DO37Ikqbh0BiCVMfTBEgsPT6R03SHBZulGnUxtnoU7I7Qv7OIYc/whvJzxex/zoSO+xnVbyhWNIC08RzK0chg4GEedU1PyN3sc6ojRGex/FBDtxv67bShgtczFR7osSt+q62/iLodfwFx1X2iKrUby/q4UNMLlKadWW9+6pOqNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/7nPOBw; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euZr4sgxPbkmSPWiuSsyQuZz1IcQ92hOtRHIxa4p8iHuMoKupzLG2NqTr8I2yUQDf4/iC6oWZC2fqASoWx8XwP9HmjrZ5QD0gW5Qca8zC/fSOWs8ffGlqzxZC6grMfYjw6YIWDOdZvNzRGLPZ+ejotgPPprD0hOV8jE+0Zf/JxBk9TCqBmgRFm3oRHzmdWGchSXM5Te+0UtVYR5gqagk1dhW4i0tMu9qAkZldSKOlMpugXp4g8Kamtyk7pXfxBHTqLIRqnP5GCwzC4dswF1LrtkQpRD7vgOuzkuMFB29bnDyJeJCwT1WRzFpCOGvw/4YXjRgYtVSQGcoFVxxASXrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5HJ57Pa2PMNwpe6YR4df7q/0ugBSXWEaJAODyNt2NQ=;
 b=Mj34681jtiuUZo/9TvlvNorXm8V32vEdtuFOWHFIaQ3/WP3TnJMa/Qx2p6pBdHHN9RvagkoTQlkw9Y6suYYNOD5uLI4Hdw6Mj+sboQUQwr5/g7J8rFdcyRjkOR/OQ8LLE+JmstswKsDcg6vs9td0ZgN1TxBELOLpMGXL8jdgAmukl2gl96vww9NVkPq7I0nlCm10Fb7O0BwRNFJI2U9UuJJoB9ahdcrTGb0RW7XXc22Wh40PB2kmw4scVJz2JWl+VmedtEr2k6vhiMLU1uXL0UE7CQrRThxC/BIqKmg7cbrv1tgqkqYHRpANkXzTBVwtpkHjq1P+UhfZ+LKY40YJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5HJ57Pa2PMNwpe6YR4df7q/0ugBSXWEaJAODyNt2NQ=;
 b=D/7nPOBw07oGXPFflPKpw4NufPUo1KGlb+5KKx2kceQ3RHYU2FV2TTfrdeyrqmKdhBrCP/U51zZwse6Q4/pncHkr8Df4xBLeMX3Vr7fmNxkUJ0IelzteQfdXVu1frhhQB4Q5q8g/xE0GiJvjES2XnoOWOFm1vz+/TUSaxSgnLd+RKTCTxWxUakFYOIEelkkQSNVyYVFs60Ii+yxZbG31EseZ7PF1aMBceCxLRnTzuPKHsfFkd8/cJA7qF/0LhgpuX0+6qARgvt4gS6Azs3rI5sSgXTKq5vksYMhTFH7sDJXPl2Gnb/1FCwcM56WUvE8NeVNaSzPF3DW11t6i2ewkxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10863.eurprd04.prod.outlook.com (2603:10a6:10:588::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:36:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 15:36:11 +0000
Date: Fri, 11 Oct 2024 11:36:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <ZwlF4VhRPv6mzURo@lizhi-Precision-Tower-5810>
References: <20241009131659.29616-1-eichest@gmail.com>
 <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>
 <20241010201121.GA88411@francesco-nb>
 <ZwhY/dtSNPptgs27@lizhi-Precision-Tower-5810>
 <Zwk35efNI4EO1eir@eichest-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwk35efNI4EO1eir@eichest-laptop>
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10863:EE_
X-MS-Office365-Filtering-Correlation-Id: 072dbc25-588d-455e-966b-08dcea0a6f1b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Fjs9e4LF25rmLdIrA06xEiFGxq48Aw2LRPR2bVrCvVvLIe6KpNaUvlLpVGJh?=
 =?us-ascii?Q?CbMbtWViK3L3xTHjD1uCcRx33FyheRENKtWqSTIq2gmqluCmSOQ2+HkHvmnP?=
 =?us-ascii?Q?43GBU68BeMRngggbr9i/rtcV0Q1Iq+RPEc/GiNtQZztFUr1hnl31OgdwV//H?=
 =?us-ascii?Q?BOBBPDa+ducGHgLnzCUj7812N8u2cbXvSs9vW/7IzisxZpvReSjxHNvo6UOO?=
 =?us-ascii?Q?21giaSyCnI64HS5rQIakK2ral7rU7U7d3RBTuwBzRNVm8aIIZTTVEOQfolPj?=
 =?us-ascii?Q?nBDTDT397cKY241nVhm/XEqqDrcsIhhiQJ5gUv2ZqPQzEjUUyIcXXtbV9f9u?=
 =?us-ascii?Q?AUe9SOKugvrZ6LZvbOuHxDnCSltmGy8NRgumuV1rgd5dvxh9vunKkdQz2A9r?=
 =?us-ascii?Q?fkNOPsdrLcP04u9V7cgYpKnNLeY/nJ3rCYOYf/vbyW4LIjH29PefgnsKFfp7?=
 =?us-ascii?Q?1XUrxq0FMs1veYcH1m5e1hlQwXdOJEoNgJaEWdnyu8Lnur7o3e/41JtJTc9E?=
 =?us-ascii?Q?NTHEqQh4XsWS+MFgaJdPGdjByUGx1eS0OPSg80LPN5r1DackHe1BWERliB/x?=
 =?us-ascii?Q?NxbgYUViWc6yuWV5GXDBK6HLpCnr4/L7KiumqJNBOzi7YztOlWHrI2Rg/f9O?=
 =?us-ascii?Q?iik1YifDDpYoXJG6XDqHdQLi2ud92ARiGJCM7Q+Kh06cLsWYwx6WNCAlzXYw?=
 =?us-ascii?Q?e88v6G656+GkIZn35RXYLzc0P/av7hEH32IGFdmM/dFoa9/JtKOh080VfmTq?=
 =?us-ascii?Q?GzT6zOJFCOLeiVNkcZJOiPZkFWXIJQGbMfiO5j/JuhLMsDIM2vFNZMDZEo6w?=
 =?us-ascii?Q?N/AUdrdc7hxK/WXXy/AU8sXD3YnGtTvCLX0m68qeyw8NjvFS5BtV1PjZyz6m?=
 =?us-ascii?Q?70hkFPp8wZdVWhDaIxgJyew3on1Smg9ZbySnMMWKvrm9MwbLjkRNW3as4dJw?=
 =?us-ascii?Q?lp0Jg2vKCqxgZHXap7tVMZ6qUobWBWWth7fikS4y7el/Jo9VHN/FXYfGMJPG?=
 =?us-ascii?Q?mnvIm4w7pM1YisIOGZrw/typX2Y/rPMJAdkMK0amB0EUrwWKO0DgbLVzcKj/?=
 =?us-ascii?Q?BHkX/8EJEqXoGepHNzx5ejIizcUD9Z1QI4R7TMHW7J8/hlxzdBNFULAq9Zh2?=
 =?us-ascii?Q?wkfmsGQ1z6tfdw2XqnBGmFQN21wwPkJxPtL4WXrvFz95z/H6hm1tq1vss0h0?=
 =?us-ascii?Q?FMoKtmAa43aea/WxuICEuTAjqRlj0ghBAWx+6BwJXReXzNSSBMOysddNvqGt?=
 =?us-ascii?Q?KJuiA3prIL+YIr1fxfWmBR/G5muz7if5mQ3ATwcsydJkJxrZ1sgKwnbMYblO?=
 =?us-ascii?Q?JgPniSVR0lK7pAD+RViKkOXulFlE0kL4ToRayKi3iJLtWw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Ue+HpH1vD15KSbdvicrVIGLsHZ0IXMhUlGmqVreVs1TUr4olJeIhLRiOmfTA?=
 =?us-ascii?Q?EUKk5wcoKxLs5Yn8tX6hop0CPlMrX+Tc+2t2TOS7jWXD0Xyu5+wWObtIS7Iz?=
 =?us-ascii?Q?ogg4OArg/8z6mkE1Il6osfBqR/B85WjvXS3Tn4sgY7DpEaYnDl/2DkTmxBfA?=
 =?us-ascii?Q?HOx3l+7GIfg7HDC5ZryFh/770CvzOlK6dnLdfr/TPbc0ngw0B/M8p4/zOMP6?=
 =?us-ascii?Q?+LX+blagLGzXpY78fYdV+aWI3zNzz+jsjI3aKNOSPYRGf1QI1d1iTsZLeYOA?=
 =?us-ascii?Q?BgKzAvN/2finFhs+vSSE6ZvcN69LkL4/sLCpVU2+eEWEyDQ6GnJLPa+qQthz?=
 =?us-ascii?Q?7T0hccW1W2g2R2Bkkz0BT7sdkqiWHEZV8nzbf4XE7E+Kn5/1rzBlP6pRTJKN?=
 =?us-ascii?Q?C5gJWJS/w6wzFHZvUr7/abteeV7+hBQMhATmQDEcQvP4LtWh+x0mCfIcyo/t?=
 =?us-ascii?Q?SWWHezXaRr1Jov6uV7KdHf1j9MeSW7xJQ1TmqYir5XblMeFx4tLM9PrVITCy?=
 =?us-ascii?Q?2yBm7BBSJqUybPupTXBgJALh48Y9bMDv0vzq0k3U/TAYsO2dytd0vhU6HFpK?=
 =?us-ascii?Q?ZzHrVsvuhIYpAwv15NA0lufxlUmq4xSfOy/pk97VhOXgbVQZQXgZq1N9yIxz?=
 =?us-ascii?Q?BwapyEU5eB3HktF18HQgumBuTfKKvmxb97eUw6gYAwwD5X1LXbQqUjHwb6Rp?=
 =?us-ascii?Q?RnGzjwHeufyiOA96q72N2X6LkQvfJ3tlLJOE5j/fSjVyQ6RacJxsF0KXbHwp?=
 =?us-ascii?Q?F7YqMjiMqPgjk3230Xnj63GIERJ+/JrM02v1STEPYIEpbgrOR1Dfkfh7NAlw?=
 =?us-ascii?Q?8IPtKkdM0ke2QCQmd9yrDOPCY2id+osnYSaTQjpfRnyzni++rSFQlx5MIgsK?=
 =?us-ascii?Q?YNcOwCvJnw53hgcjqpLph/5O4uleY5W+MjekUhsWjF2fvppb9VD33xpj97i3?=
 =?us-ascii?Q?Nv+0ZHwbPexl3q4CJ/mzlSZ5Xu5ED3pA80jUXpIBF7TNf5dI4gXijDVBxvdA?=
 =?us-ascii?Q?ga9LZzjok7fxKQooob8KQJqJ9fZf8/cG5vURsf2ULDmlg+Aw4bVv/ULg3OwX?=
 =?us-ascii?Q?avEMMuJIi9aHl6KekLSeFHVSXOsLonwLq1ahS9NypsZqE0vHZDYK2SdAlPtv?=
 =?us-ascii?Q?WtDFvW7Ix+0CuKWIksKXdN9UeOQqJyQgn5huQnsAzcV0yQAUK/U54c2izQh7?=
 =?us-ascii?Q?7lIqy0XmQeiixqhWLeUOxEKaMsTXYJ6SZOdNpfgxe/zoIcpwF+eQtmF0+vXn?=
 =?us-ascii?Q?XDzPgS8D8junLH9ozk6UFnizdSdQXkCv7k51QX8ZoLNFYqRF3VdKj8LbfgqE?=
 =?us-ascii?Q?4/6yaf0AwCfpZ9Su8USyxzb2TN7vM3LJUFYzMdhU3+al53oCaMyTtJ0/UATJ?=
 =?us-ascii?Q?gMz3gua8KcVzvNZQCRee2dIw0Y5v50THODNzKgBtV07sAkSM7BC0XO4lMBHD?=
 =?us-ascii?Q?IWsumTatUWoLEYt7uSydoY95lCvx/2P8APWp1AnHkpU+k2f4rH9UhmfVAI9d?=
 =?us-ascii?Q?RtHRMVkJyInskWyXC3WSP2Mr4A9QNduuolHR0ZVaIoIA/iHFbbuGmfkNGDPh?=
 =?us-ascii?Q?4yYN+RDJwr4yDJ0jlPU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072dbc25-588d-455e-966b-08dcea0a6f1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:36:11.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8N40P/zq1gYxo+hL17dtIVehL2apZzIActM6nFfhf4keplbhVYkPHgzwPypU1y2PSHZLo7yDNRnelB2uLLe5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10863

On Fri, Oct 11, 2024 at 04:36:21PM +0200, Stefan Eichenberger wrote:
> Hi Frank,
>
> On Thu, Oct 10, 2024 at 06:45:17PM -0400, Frank Li wrote:
> > On Thu, Oct 10, 2024 at 10:11:21PM +0200, Francesco Dolcini wrote:
> > > Hello Frank,
> > >
> > > On Thu, Oct 10, 2024 at 04:01:21PM -0400, Frank Li wrote:
> > > > On Wed, Oct 09, 2024 at 03:14:05PM +0200, Stefan Eichenberger wrote:
> > > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > >
> > > > > The suspend/resume support is broken on the i.MX6QDL platform. This
> > > > > patch resets the link upon resuming to recover functionality. It shares
> > > > > most of the sequences with other i.MX devices but does not touch the
> > > > > critical registers, which might break PCIe. This patch addresses the
> > > > > same issue as the following downstream commit:
> > > > > https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> > > > > In comparison this patch will also reset the device if possible. Without
> > > > > this patch suspend/resume will not work if a PCIe device is connected.
> > > > > The kernel will hang on resume and print an error:
> > > > > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> > > > > 8<--- cut here ---
> > > > > Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> > > > >
> > > > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > > ---
> > > >
> > > > Thank you for your patch.
> > > >
> > > > But it may conflict with another suspend/resume patch
> > > > https://lore.kernel.org/imx/1727245477-15961-8-git-send-email-hongxing.zhu@nxp.com/
> > >
> > > Thanks for the head-up.
> > >
> > > Do you see any issue with this patch apart that? Because this patch is
> > > fixing a crash, so I would expect this to be merged, once ready, and
> > > such a series rebased afterward.
> > >
> > > I am writing this explicitly since you wrote a similar comment on the
> > > v1 (https://lore.kernel.org/all/ZsNXDq%2FkidZdyhvD@lizhi-Precision-Tower-5810/)
> > > and I would like to prevent to have this fix starving for long just because
> > > multiple people is working on the same driver.
> >
> > My key comment for this patch is use flags IMX_PCIE_FLAG_SKIP_TURN_OFF
> > in suspend()/resume(), it is up to kw to pick which one firstly.
>
> I will try to implement it as you proposed with the new flag.

I have not met this problem at arm64 platform. what's your .config?

Frank

>
> However, what I figured out with kernel v6.12-rc1 I get the following
> warning when booting on an i.MX6QDL even without my patch applied:
> [    1.901199] PCI: bus0: Fast back to back transfers disabled
> [    1.904754] mmc1: SDHCI controller on 2190000.mmc [2190000.mmc] using ADMA
> [    1.904914] mmc2: SDHCI controller on 2194000.mmc [2194000.mmc] using ADMA
> [    1.910686] pci 0000:01:00.0: [168c:003c] type 00 class 0x028000 PCIe Endpoint
> [    1.918390] NET: Registered PF_PACKET protocol family
> [    1.918573] mmc0: SDHCI controller on 2198000.mmc [2198000.mmc] using ADMA
> [    1.924322] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x001fffff 64bit]
> [    1.931635] Key type dns_resolver registered
> [    1.936764] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> [    1.961043] pci 0000:01:00.0: supports D1 D2
> [    1.961526] Registering SWP/SWPB emulation handler
> [    1.965601] mmc0: new DDR MMC card at address 0001
> [    1.976575] mmcblk0: mmc0:0001 Q2J54A 3.59 GiB
> [    1.979794] Loading compiled-in X.509 certificates
> [    1.985036] PCI: bus1: Fast back to back transfers disabled
> [    1.991531] pci 0000:00:00.0: bridge window [mem 0x01000000-0x011fffff]: assigned
> [    1.998742]  mmcblk0: p1 p2 p3
> [    1.999163] pci 0000:00:00.0: BAR 0 [mem 0x01200000-0x012fffff]: assigned
> [    2.003947] mmcblk0boot0: mmc0:0001 Q2J54A 16.0 MiB
> [    2.008990] pci 0000:00:00.0: bridge window [mem 0x01300000-0x013fffff pref]: assigned
> [    2.009023] pci 0000:00:00.0: ROM [mem 0x01400000-0x0140ffff pref]: assigned
> [    2.009054] pci 0000:01:00.0: BAR 0 [mem 0x01000000-0x011fffff 64bit]: assigned
> [    2.017526] mmcblk0boot1: mmc0:0001 Q2J54A 16.0 MiB
> [    2.022015] pci 0000:01:00.0: ROM [mem 0x01300000-0x0130ffff pref]: assigned
> [    2.032133] mmcblk0rpmb: mmc0:0001 Q2J54A 512 KiB, chardev (242:0)
> [    2.036347] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    2.036370] pci 0000:00:00.0:   bridge window [mem 0x01000000-0x011fffff]
> [    2.036384] pci 0000:00:00.0:   bridge window [mem 0x01300000-0x013fffff pref]
> [    2.042552] pps pps0: new PPS source ptp0
> [    2.048338] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
> [    2.083626] pci_bus 0000:00: resource 5 [mem 0x01000000-0x01efffff]
> [    2.089972] pci_bus 0000:01: resource 1 [mem 0x01000000-0x011fffff]
> [    2.093461] fec 2188000.ethernet eth0: registered PHC device 0
> [    2.096283] pci_bus 0000:01: resource 2 [mem 0x01300000-0x013fffff pref]
> [    2.096352] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/resource0'
> [    2.096365] CPU: 3 UID: 0 PID: 52 Comm: kworker/u19:2 Not tainted 6.12.0-rc1 #54
> [    2.096381] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    2.096391] Workqueue: async async_run_entry_fn
> [    2.103025] imx_thermal 20c8000.anatop:tempmon: Industrial CPU temperature grade - max:105C critical:100C passive:95C
> [    2.108932]
> [    2.108940] Call trace:
> [    2.108950]  unwind_backtrace from show_stack+0x10/0x14
> [    2.121391] clk: Disabling unused clocks
> [    2.127423]  show_stack from dump_stack_lvl+0x54/0x68
> [    2.127451]  dump_stack_lvl from sysfs_warn_dup+0x58/0x64
> [    2.134265] PM: genpd: Disabling unused power domains
> [    2.138525]  sysfs_warn_dup from sysfs_add_bin_file_mode_ns+0xbc/0xcc
> [    2.138547]  sysfs_add_bin_file_mode_ns from sysfs_create_bin_file+0xac/0xb4
> [    2.149242] ALSA device list:
> [    2.150647]  sysfs_create_bin_file from pci_create_resource_files+0x84/0x148
> [    2.153183]   No soundcards found.
> [    2.158407]  pci_create_resource_files from pci_bus_add_device+0x24/0xe4
> [    2.211699]  pci_bus_add_device from pci_bus_add_devices+0x2c/0x70
> [    2.217930]  pci_bus_add_devices from pci_host_probe+0x7c/0xa4
> [    2.223806]  pci_host_probe from dw_pcie_host_init+0x4ec/0x71c
> [    2.229682]  dw_pcie_host_init from imx_pcie_probe+0x3a8/0x75c
> [    2.235559]  imx_pcie_probe from platform_probe+0x5c/0xb0
> [    2.241010]  platform_probe from really_probe+0xd0/0x3a4
> [    2.246364]  really_probe from __driver_probe_device+0x8c/0x1d4
> [    2.252321]  __driver_probe_device from driver_probe_device+0x30/0xc0
> [    2.258803]  driver_probe_device from __driver_attach_async_helper+0x50/0xd8
> [    2.265892]  __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
> [    2.272980]  async_run_entry_fn from process_one_work+0x154/0x2dc
> [    2.279115]  process_one_work from worker_thread+0x250/0x3f0
> [    2.284811]  worker_thread from kthread+0x110/0x12c
> [    2.289726]  kthread from ret_from_fork+0x14/0x28
> [    2.294461] Exception stack(0xe6a0dfb0 to 0xe6a0dff8)
> [    2.299535] dfa0:                                     00000000 00000000 00000000 00000000
> [    2.307740] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.315942] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.323156] pcieport 0000:00:00.0: PME: Signaling with IRQ 293
> [    2.329645] pcieport 0000:00:00.0: AER: enabled with IRQ 293
> [    2.335553] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/resource0'
> [    2.347794] CPU: 3 UID: 0 PID: 52 Comm: kworker/u19:2 Not tainted 6.12.0-rc1 #54
> [    2.355229] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    2.361779] Workqueue: async async_run_entry_fn
> [    2.366349] Call trace:
> [    2.366362]  unwind_backtrace from show_stack+0x10/0x14
> [    2.374183]  show_stack from dump_stack_lvl+0x54/0x68
> [    2.379273]  dump_stack_lvl from sysfs_warn_dup+0x58/0x64
> [    2.384706]  sysfs_warn_dup from sysfs_add_bin_file_mode_ns+0xbc/0xcc
> [    2.391183]  sysfs_add_bin_file_mode_ns from sysfs_create_bin_file+0xac/0xb4
> [    2.398270]  sysfs_create_bin_file from pci_create_resource_files+0x84/0x148
> [    2.405360]  pci_create_resource_files from pci_bus_add_device+0x24/0xe4
> [    2.412113]  pci_bus_add_device from pci_bus_add_devices+0x2c/0x70
> [    2.418334]  pci_bus_add_devices from pci_bus_add_devices+0x60/0x70
> [    2.424642]  pci_bus_add_devices from pci_host_probe+0x7c/0xa4
> [    2.430511]  pci_host_probe from dw_pcie_host_init+0x4ec/0x71c
> [    2.436384]  dw_pcie_host_init from imx_pcie_probe+0x3a8/0x75c
> [    2.442258]  imx_pcie_probe from platform_probe+0x5c/0xb0
> [    2.447704]  platform_probe from really_probe+0xd0/0x3a4
> [    2.453057]  really_probe from __driver_probe_device+0x8c/0x1d4
> [    2.459014]  __driver_probe_device from driver_probe_device+0x30/0xc0
> [    2.465493]  driver_probe_device from __driver_attach_async_helper+0x50/0xd8
> [    2.472580]  __driver_attach_async_helper from async_run_entry_fn+0x30/0x144
> [    2.479666]  async_run_entry_fn from process_one_work+0x154/0x2dc
> [    2.485800]  process_one_work from worker_thread+0x250/0x3f0
> [    2.491494]  worker_thread from kthread+0x110/0x12c
> [    2.496408]  kthread from ret_from_fork+0x14/0x28
> [    2.501140] Exception stack(0xe6a0dfb0 to 0xe6a0dff8)
> [    2.506214] dfa0:                                     00000000 00000000 00000000 00000000
> [    2.514418] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.522620] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>
> This was not the case with kernel v6.11, do you have an idea where this
> comes from? I did not dig into more detail yet but it looks a bit like a
> regression. The driver still works, it just prints this duplicate
> filename warning.
>
> Regards,
> Stefan

