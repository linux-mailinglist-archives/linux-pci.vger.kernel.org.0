Return-Path: <linux-pci+bounces-25583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E791EA82A3C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353B69A82BB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 15:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB3267B86;
	Wed,  9 Apr 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nl67Fw8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F74266F09;
	Wed,  9 Apr 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210977; cv=fail; b=P+jaLmbmjrV0/QU9abFgNl+o26iz4BXsNB0EIRxWjSbWEaxwNQWbIg8FZAzxzmOlPGFCxvXyt3RrFGGq7WeyqZBjsoViJf+XE4vqIFY5f30y7rUtl7woX0MsCEJBRjBBix5ohDX81I3kyyUOV90NcO/xVJKHs4PY4/KVTqCuM/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210977; c=relaxed/simple;
	bh=nvqFyoYfLQlC3u9XrGzU0oW3WYe+GVcJE/RzGuG/tIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afbFUw8xm6bkYUDpxpZImSs1l5ppA7hque2YwNlOxjdT7oJo7Gqkeb8fbUr81s80TduBwpyToOLsOrDprah4paAI2EjAIxDHVKPDfqoGvzsLQL55L/ewcYG0TiChugaKUorctgb2RShwGT4HAqq4RzFnI7MuYrxI4JHmjr+jHAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nl67Fw8T reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mkj6eVqMSrQI4DjvhnmpOslPUh+ae3w0IYZ7tM6hMZI+vcAKn+SPRZfQjbiswQNwSrUoM8lgqiBgfZ+R8T/JT18ZYQCldGO4nCEB+0E39TaSjUZnmGC5UI8SO4ssTAoRqxZNzxIzgYDueTwIAT8KAhzeU1RreNRL5ERwXHhyZek4/FAPPkkfYzt4HIZOl+Dbl2SfMkGts4LvneXbDCnPHsn67akCQBGwY/u7DJCq9lPe/UhVoCk7DeCQz8/2BEgrKoyfd5kJ16BL8j9zOd2TeMQYOaAYCwYm6aFn/fuK9wM6KLT8nw755kVu5frZG7BcuLy9HXvsm0bdCWswBaChXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bOSAm1Y9NVH1EcOKel/Wh6sbc2+OKL3cWjtQSVwKS8=;
 b=KCjUbmunIoCevdd+XFozKGRvqfuONj+fwAC7RgJf5htWzsHJnmN5b22Yh0wxp1/RtwvrrnkApyePkotIqtCxcXyzzqVGXVwv+g+vRuq7Gwwh45gdsdvw4ElAdYBtzkegZNDHbJIdAwpugfkYqgeODbHr6wgMyHI59CyP4/tbNSwjgCWCKHqAaqGz8fD94uSLId6VHnFNzlW5/QOhiA3nlnHflQztZogXz+Czpbe0R3t1nfMNlBiLspPtqLvs7PQnUtoqcqkxhm2db4XbNiFp25XHB9QnN34hm+sT01II2U9iU0T6i5paPPkx2pkbEu/NwbTE5higR9ydMMkaqJ7qRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bOSAm1Y9NVH1EcOKel/Wh6sbc2+OKL3cWjtQSVwKS8=;
 b=nl67Fw8TFZEOEWsXsBfQ42MMHidEaDVBZPnvfdZugmWANTdxzgUUziOuNG29Kwdklw9Wm898FVVCd8QAR/A40woMLM3heQoo8aGm8XePQ7ZivvoAn+YavR+6wBQD2pV7FSBbdz6HarRJagrex92iFxS1ssd5DctRikCzfGJz1kdushmfBpBgVX66S4Mt4cjj5QuXT8vVtsxaWi6cgTqD6F0PbV05YKkr+q1YlvLs+GVfXIedbpclvs9rYghT43SuTWuNgnZKjbH6H06scOgVYKjdq+7CMIJv1/XrlaP6S3Lv0gCXvtEnLLxvG1Be/rZ86yN5zO8g6fsrhf3Bb5Ia/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9685.eurprd04.prod.outlook.com (2603:10a6:102:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 15:02:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Wed, 9 Apr 2025
 15:02:52 +0000
Date: Wed, 9 Apr 2025 11:02:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v5 3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
Message-ID: <Z/aME4QwgGUBs2nH@lizhi-Precision-Tower-5810>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-4-hongxing.zhu@nxp.com>
 <2989817.e9J7NaK4W3@steina-w>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2989817.e9J7NaK4W3@steina-w>
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: eea7ecca-6142-4e82-972b-08dd7777998a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?vmUT8SOHR9OVZtoNUGg7xBPG5saVxZd41svRZhVAxa9mOpX0dMICtVO2Bc?=
 =?iso-8859-1?Q?g686UtKKeYzVTWKLDqotvVn1qLyVgDzzqtkxmG4TPc9Cnwft24jST4f1WI?=
 =?iso-8859-1?Q?kkI8TADeh+cE19PNz3h0PXxxqpP3IQutsjm8Kol8IWXlXo4PP+isBiJk74?=
 =?iso-8859-1?Q?9eNmA1j+0FQgRtb5ZAx2FIdgx21mwGU9tcWiaWxbdpqEedY/pjozhBTXsz?=
 =?iso-8859-1?Q?1MZ6lryGG/yXm5IYm14V2vNhawOgnZZ2GCX3iGdBd8/BFhSDtpVhMhYYH4?=
 =?iso-8859-1?Q?sESdkZbTFsvR+dn+iyPZ4h8oLo7VXWbaCjjIylrP7FhU7qSRv/t7sQwllz?=
 =?iso-8859-1?Q?Ki2+tWUNHwj45ians0e5OI5bKiPlVF42fy+AOlJcjWYJG3kNj9YE0JX6SV?=
 =?iso-8859-1?Q?h1lapNppVH3gtrNgJDKB8/8KbXHVe0aPF9Ky7RclukIhWpnerTYA6Mtojg?=
 =?iso-8859-1?Q?wkBej9wjH5ecb07YuixYYxW8KzUN2KVZYgYaxV/4DeXWhPomhJu2W84Ebx?=
 =?iso-8859-1?Q?sVQ7Bjk6ugmvem+sSAtNi/5F4n7JKISU2rqkgrB/4qv93nSLsKObtubUbp?=
 =?iso-8859-1?Q?GfuP+XhuejmRp+VNalz9h8U0CGdEUWtaCdvFKtY0+Vwny+pGjNo3zJcHIV?=
 =?iso-8859-1?Q?BoU/Xt67/t2XpZwky/wOhKNgTvG1F08vBkHhPAO9GzLnpqGojU/Kge+vJC?=
 =?iso-8859-1?Q?ke5P5aCDKSVjY8fEK6fScXpqQG29xEFaP3XnSpUXEDaHqIpU8TcVqguRqR?=
 =?iso-8859-1?Q?XgxNgv/4yrbqn35OFJB+CpQuXi09zbkIN1apIdQ915Fc60zqPdpbz9vwtk?=
 =?iso-8859-1?Q?ioaiI+6oilCgZRGQr6Pi+7mFjyXZ2DYVBAIKsv8N5uyiHqkNVtYa4fmPQ9?=
 =?iso-8859-1?Q?+EsnjASQlbTnF8AixRCTLNAb9Ru0aUG9H2S4R2sPNlTiLbx+HVvwYOmLaO?=
 =?iso-8859-1?Q?AHPYWMye9iMuiXGEqJeLMIBHQFBHdy340VgSp/BFS6byDR5Wd5h89c/Egh?=
 =?iso-8859-1?Q?j/PgmjSRQRuPuzwryZ3oW2uijU+NQ2hHfrpVsL7WuKk9ZQvvRepZJVTO12?=
 =?iso-8859-1?Q?bVFoqfyFBX3pdWWbdmHbL2gZb+v2d9dBP1CiYWF2JJ1V9TLuKWXGCF/M8c?=
 =?iso-8859-1?Q?7fSFw1KBG8AQQTA70rHALQthmFcKhxnfYZU6nRO0FFyBm8eqNcUUI0vWQA?=
 =?iso-8859-1?Q?mNr8lij4sen16EfSXo0XgY7KYSdn7oPZ/2JDP740JmgZaRUitftxjkGfcB?=
 =?iso-8859-1?Q?V3yw75sfRHuwiyBjoJrdl+YSxmE6qsuOKIN2h8JEw0frnWZwwimtIHgsJ0?=
 =?iso-8859-1?Q?sbv2vhu+jcUHGyXzUKARbU1ZXsqicM5qVCTva6wyI72RwBh24/95xwzD54?=
 =?iso-8859-1?Q?iS+NXTLbF5HdcuvhiYCVSBt1/jV7Znl0OaCbdibGoxJjtFbzGom6HL8kZX?=
 =?iso-8859-1?Q?YnYXXTJS37cToxolsuD6jNvpznJVw46ZK+8iJF7OtOrHMFUpOC1ShjSgFk?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?HFIp+TFnRnMBRqfaFvslC0Pur05Fou+aErE8snhPb6cTpv4a9+R5emKAzT?=
 =?iso-8859-1?Q?2/VVdh1rcXdlVI0It+E7bjOLDPayBOOYCYUGQNyymSjBQ7e3ghjynqGUfr?=
 =?iso-8859-1?Q?XomYN4yQ3YjW1AWGDpSDJx2j6JV62GNXM778oZkXIiTTFUxWONtqHwPj4U?=
 =?iso-8859-1?Q?XCng5jBLHNUHEngYKXIdhzH5CjAgI9goKk+2+lWQkmD1dSEbfEX4OjKn65?=
 =?iso-8859-1?Q?Cbz+Z6t18ZVClb5hdvVSTBtEJoLmGV6jap0EteHS9Rvql1IGdEfo3hIAOt?=
 =?iso-8859-1?Q?1U5DJweIAKMVpMjMfIICnZ0O1x8luYYKEvOKXKgR3WpEwGLt5C2zzLjU9w?=
 =?iso-8859-1?Q?bCzQ4pwwhyLR2dkNYgWLReLFpm52MQbTFG+fdAS/PndW/irKhoTXrjl2Te?=
 =?iso-8859-1?Q?cQHNtwhq8rKotMYJEvu/C1+iFT17vGcslBVmK2x+hyTgtFGOvyy7KZeadv?=
 =?iso-8859-1?Q?PaVzDOC/j//OoGAzoityede9MrR/l97Z/fzUP24+clSDoDLToTJL4FLJcF?=
 =?iso-8859-1?Q?adYgXIphaxuDVnjCAdenSkw5+iUvWa+5CqIfYZuPylZqfnTxoNH1pTJ6h0?=
 =?iso-8859-1?Q?nxOg0nAELH5cHZkerY3EmCcRbgd1Xs1tVsP9Qd5dWfEXf5caP800Qg3MKU?=
 =?iso-8859-1?Q?scR6FfBTB81312Wgr8ZARg3BMmiRDfx2v3sOgESL3rC4E0jLCiHdJ0knJ5?=
 =?iso-8859-1?Q?KhgJVWXP9Q0UoHe7dgS9BFSzQ3KcoCSeaVyzqLsObWVwXlU+WCQw7y3q0x?=
 =?iso-8859-1?Q?1kKK/HxvE6bWGZYYqRZMVoYfJOXw3lllfJrUZ5g8PjN5Rvx/bqUxznD+IF?=
 =?iso-8859-1?Q?CwcpyXY2UprmYSxxUS7a5+MiknppFTIUBXWuY+RUFftKR126RLhp9gb5Fk?=
 =?iso-8859-1?Q?FscK0abFauCih3tNNS+XZrSyyb6494qaDuqf5KF634Pf5Ra+FTJ6EOtWD8?=
 =?iso-8859-1?Q?Ra/XTXXOpPCgQU7q1Nx2mw5Oj4MY67uBX4LdmaNu/yvdYpHLcQ2190vBZm?=
 =?iso-8859-1?Q?BdbU4F9EmIJyTL70ISNwvO62A58HFwjW5W+5z1btfwZAE1E8DONkYh9pTD?=
 =?iso-8859-1?Q?UNc0YWXipjdj5HFqarPHWFbxBe/g0lZccT+jkil82Bt83A7ryl4BAzsK0c?=
 =?iso-8859-1?Q?0LWEZbuJZlMEbLobxa9rmgiJQpOvJ2aLgKJV5CAA7mTkUcafvgzkIKJGYw?=
 =?iso-8859-1?Q?mDH0vx33/eAr3jW4QqkQZKJtbecUs6PTGuPBbVljNFLdaUC4UclHl+/Cd2?=
 =?iso-8859-1?Q?P3FF4b4QnQ4oRgpGo3HhWWoYI+t1g3ROzY8u3nN8V0so4wQXspnDeKbYI4?=
 =?iso-8859-1?Q?azHo6rYb3aTm0izk2hy4845+8ydqODXjyzr8V0pMefmxId3r7UZ2H3p6ok?=
 =?iso-8859-1?Q?jlRFbK7gTJF56VYEgFCztWHMWbWUOEUv1R3uH9nLeoALfWamz+jczv/yK6?=
 =?iso-8859-1?Q?N18u9eNn78buE1FMT5dR/BIOSqtwMOUg92rx7WBpxrSHlpSZB0DbtAFAV4?=
 =?iso-8859-1?Q?R6digWj4PB77m6+4xerAN2Th8jF/CoAGJH0fzGJqRh+eI4CGVrc29oRc7S?=
 =?iso-8859-1?Q?oQ16D3a6v98yDu3JUxM+thvQ8gT/VEAeyfOL2KQ3H8q1ObDcqmSP/65iPY?=
 =?iso-8859-1?Q?0vVe/s5F1O2VgAH3KxFpNfzF28qp+oXHSb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea7ecca-6142-4e82-972b-08dd7777998a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:02:51.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiXgzbwpS5Y9Yw6uLIm1USC51j7Iyf22BuQA7CPRV+p1xZX4FMSbUYbiGIkA0Tfq7t+eiseWwBSzPq7Jvog3ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9685

On Wed, Apr 09, 2025 at 11:51:53AM +0200, Alexander Stein wrote:
> Hi,
>
> Am Dienstag, 8. April 2025, 04:59:26 CEST schrieb Richard Zhu:
> > Add the cold reset toggle for i.MX95 PCIe to align PHY's power up sequency.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 42 +++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index c5871c3d4194..7c60b712480a 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -71,6 +71,9 @@
> >  #define IMX95_SID_MASK				GENMASK(5, 0)
> >  #define IMX95_MAX_LUT				32
> >
> > +#define IMX95_PCIE_RST_CTRL			0x3010
> > +#define IMX95_PCIE_COLD_RST			BIT(0)
> > +
> >  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
> >
> >  enum imx_pcie_variants {
> > @@ -773,6 +776,43 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> >  	return 0;
> >  }
> >
> > +static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> > +{
> > +	u32 val;
> > +
> > +	if (assert) {
> > +		/*
> > +		 * From i.MX95 PCIe PHY perspective, the COLD reset toggle
> > +		 * should be complete after power-up by the following sequence.
> > +		 *                 > 10us(at power-up)
> > +		 *                 > 10ns(warm reset)
> > +		 *               |<------------>|
> > +		 *                ______________
> > +		 * phy_reset ____/              \________________
> > +		 *                                   ____________
> > +		 * ref_clk_en_______________________/
> > +		 * Toggle COLD reset aligned with this sequence for i.MX95 PCIe.
> > +		 */
> > +		regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> > +				IMX95_PCIE_COLD_RST);
> > +		/*
> > +		 * Make sure the write to IMX95_PCIE_RST_CTRL is flushed to the
> > +		 * hardware by doing a read. Otherwise, there is no guarantee
> > +		 * that the write has reached the hardware before udelay().
> > +		 */
> > +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> > +				     &val);
> > +		udelay(15);
> > +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> > +				  IMX95_PCIE_COLD_RST);
> > +		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
> > +				     &val);
> > +		udelay(10);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
> >  {
> >  	reset_control_assert(imx_pcie->pciephy_reset);
> > @@ -1739,6 +1779,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> >  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> >  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> > +		.core_reset = imx95_pcie_core_reset,
> >  		.init_phy = imx95_pcie_init_phy,
> >  	},
> >  	[IMX8MQ_EP] = {
> > @@ -1792,6 +1833,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
> >  		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> >  		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> >  		.init_phy = imx95_pcie_init_phy,
> > +		.core_reset = imx95_pcie_core_reset,
> >  		.epc_features = &imx95_pcie_epc_features,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  	},
> >
>
> This change introduces an invalid memory access on my platform. There is not
> even a PCIe device attached to it.
>
> > imx6q-pcie 4c380000.pcie: host bridge /soc/pcie@4c380000 ranges:
> > imx6q-pcie 4c300000.pcie: host bridge /soc/pcie@4c300000 ranges:
> > imx6q-pcie 4c380000.pcie:       IO 0x088ff00000..0x088fffffff -> 0x0000000000
> > imx6q-pcie 4c300000.pcie:       IO 0x006ff00000..0x006fffffff -> 0x0000000000
> > imx6q-pcie 4c380000.pcie:      MEM 0x0a10000000..0x0a1fffffff -> 0x0010000000
> > imx6q-pcie 4c300000.pcie:      MEM 0x0910000000..0x091fffffff -> 0x0010000000
> > imx6q-pcie 4c380000.pcie: config reg[1] 0x880100000 == cpu 0x880100000
> > ; no fixup was ever needed for this devicetree
> > imx6q-pcie 4c300000.pcie: config reg[1] 0x60100000 == cpu 0x60100000
> > ; no fixup was ever needed for this devicetree
> > Unable to handle kernel paging request at virtual address ffff800081dc5010
> > Unable to handle kernel paging request at virtual address ffff8000821bd010
> > Mem abort info:
> >
> > Mem abort info:
> >   ESR = 0x0000000096000007
> >   ESR = 0x0000000096000007
> >   EC = 0x25: DABT (current EL), IL = 32 bits
> >   EC = 0x25: DABT (current EL), IL = 32 bits
> >
> > fsl_enetc_mdio 0003:01:00.0: enabling device (0000 -> 0002)
> >
> >   SET = 0, FnV = 0
> >   SET = 0, FnV = 0
> >   EA = 0, S1PTW = 0
> >   EA = 0, S1PTW = 0
> >   FSC = 0x07: level 3 translation fault
> >   FSC = 0x07: level 3 translation fault
> >
> > Data abort info:
> >
> > Data abort info:
> >   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> >   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
> >   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> >
> > swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000091a47000
> > swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000091a47000
> > [ffff800081dc5010] pgd=1000000092002003
> > [ffff8000821bd010] pgd=1000000092002003
> > , p4d=1000000092002003
> > , p4d=1000000092002003
> > , pud=1000000092003003
> > , pud=1000000092003003
> > , pmd=1000000092008003
> > , pmd=100000009299f403
> > , pte=0000000000000000
> > , pte=0000000000000000
> >
> >
> > Internal error: Oops: 0000000096000007 [#1]  SMP
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 63 Comm: kworker/u24:4 Tainted: G                T
> > 6.15.0-rc1-next-20250409+ #3009 PREEMPT
> > f6bd3cc6346487744ae55f6115e728ff2bc7088b Tainted: [T]=RANDSTRUCT
> > Hardware name: TQ-Systems i.MX95 TQMa95xxSA on MB-SMARC-2 (DT)
> > Workqueue: async async_run_entry_fn
> > pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : regmap_mmio_read32le+0x1c/0x3c
> > lr : regmap_mmio_read+0x40/0x68
> > sp : ffff80008223b860
> > x29: ffff80008223b860 x28: ffff00001000c800 x27: ffff8000818679c0
> > x26: ffff000013340410 x25: 0000000000000001 x24: 0000000000000000
> > x23: ffff000012f5e400 x22: ffff80008223b934 x21: ffff80008223b934
> > x20: ffff000012fc4900 x19: 0000000000003010 x18: 00000000a7aa953f
> > x17: 3e2d206666666666 x16: 666631393078302e x15: 2e30303030303030
> > x14: 3139307830204d45 x13: 3030303030303031 x12: 30307830203e2d20
> > x11: 6666666666666631 x10: 393078302e2e3030 x9 : 4d2020202020203a
> > x8 : 656963702e303030 x7 : 205d313236353838 x6 : ffff0000134e0000
> > x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000809bf028
> > x2 : ffff8000809bfb0c x1 : 0000000000003010 x0 : ffff800081dc5010
> >
> > Call trace:
> >  regmap_mmio_read32le+0x1c/0x3c (P)
> >  regmap_mmio_read+0x40/0x68
> >  _regmap_bus_reg_read+0x58/0x9c
> >  _regmap_read+0x70/0x1c4
> >  _regmap_update_bits+0xe4/0x174
> >  regmap_update_bits_base+0x60/0x90
> >  imx95_pcie_core_reset+0x78/0xd0
> >  imx_pcie_assert_core_reset+0x38/0x50
> >  imx_pcie_host_init+0x68/0x4a0
> >  dw_pcie_host_init+0x16c/0x500
> >  imx_pcie_probe+0x2f4/0x71c
> >  platform_probe+0x64/0x100
> >  really_probe+0xc8/0x3bc
> >  __driver_probe_device+0x84/0x16c
> >  driver_probe_device+0x40/0x160
> >  __device_attach_driver+0xcc/0x1a0
> >  bus_for_each_drv+0x88/0xe4
> >  __device_attach_async_helper+0xac/0x108
> >  async_run_entry_fn+0x30/0x144
> >  process_one_work+0x14c/0x3e0
> >  worker_thread+0x2f0/0x3fc
> >  kthread+0x128/0x1ec
> >  ret_from_fork+0x10/0x20
> >
> > Code: aa0003f4 2a0103f3 f9400280 8b334000 (b9400000)
> > ---[ end trace 0000000000000000 ]---
> > note: kworker/u24:4[63] exited with irqs disabled
> > Internal error: Oops: 0000000096000007 [#2]  SMP
> > Modules linked in:
> > note: kworker/u24:4[63] exited with preempt_count 1
> >
> > CPU: 4 UID: 0 PID: 52 Comm: kworker/u24:1 Tainted: G      D         T
> > 6.15.0-rc1-next-20250409+ #3009 PREEMPT
> > f6bd3cc6346487744ae55f6115e728ff2bc7088b Tainted: [D]=DIE, [T]=RANDSTRUCT
> > Hardware name: TQ-Systems i.MX95 TQMa95xxSA on MB-SMARC-2 (DT)
> > Workqueue: async async_run_entry_fn
> > pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : regmap_mmio_read32le+0x1c/0x3c
> > lr : regmap_mmio_read+0x40/0x68
> > mmc0: new HS400 Enhanced strobe MMC card at address 0001
> > sp : ffff8000821e3860
> > mmcblk0: mmc0:0001 DG4016 14.7 GiB
> > x29: ffff8000821e3860 x28: ffff00001000c800 x27: ffff8000818679c0
> > mmcblk0boot0: mmc0:0001 DG4016 4.00 MiB
> > x26: ffff00001333fc10 x25: 0000000000000001 x24: 0000000000000000
> > x23: ffff000013895400 x22: ffff8000821e3934 x21: ffff8000821e3934
> > x20: ffff0000134672c0
> > mmcblk0boot1: mmc0:0001 DG4016 4.00 MiB
> >
> >  x19: 0000000000003010 x18: 0000000038868210
> >
> > x17: 3038387830207570 x16: 63203d3d20303030 x15: 3030313038387830
> > x14: 205d315b67657220
> > mmcblk0rpmb: mmc0:0001 DG4016 4.00 MiB, chardev (237:0)
> >
> >  x13: 6565727465636976 x12: 6564207369687420
> >
> > x11: 726f662064656465 x10: 656e207265766520 x9 : 7420726f66206465
> > x8 : 6465656e20726576 x7 : 205d303033353938 x6 : ffff000013371280
> > x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000809bf028
> > x2 : ffff8000809bfb0c x1 : 0000000000003010 x0 : ffff8000821bd010
> >
> > Call trace:
> >  regmap_mmio_read32le+0x1c/0x3c (P)
> >  regmap_mmio_read+0x40/0x68
> >  _regmap_bus_reg_read+0x58/0x9c
> >  _regmap_read+0x70/0x1c4
> >  _regmap_update_bits+0xe4/0x174
> >  regmap_update_bits_base+0x60/0x90
> >  imx95_pcie_core_reset+0x78/0xd0
> >  imx_pcie_assert_core_reset+0x38/0x50
> >  imx_pcie_host_init+0x68/0x4a0
> >  dw_pcie_host_init+0x16c/0x500
> >  imx_pcie_probe+0x2f4/0x71c
> >  platform_probe+0x64/0x100
> >  really_probe+0xc8/0x3bc
> >  __driver_probe_device+0x84/0x16c
> >  driver_probe_device+0x40/0x160
> >  __device_attach_driver+0xcc/0x1a0
> >  bus_for_each_drv+0x88/0xe4
> >  __device_attach_async_helper+0xac/0x108
> >  async_run_entry_fn+0x30/0x144
> >  process_one_work+0x14c/0x3e0
> >  worker_thread+0x2f0/0x3fc
> >  kthread+0x128/0x1ec
> >  ret_from_fork+0x10/0x20
> >
> > Code: aa0003f4 2a0103f3 f9400280 8b334000 (b9400000)
> > ---[ end trace 0000000000000000 ]---
>
> Is this series dependent on any other series/patches?

Please update dts

https://lore.kernel.org/imx/20250314060104.390065-1-hongxing.zhu@nxp.com/
arm64: dts: imx95: Correct the range of PCIe app-reg region

Frank
>
> Best regards,
> Alexander
> --
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> http://www.tq-group.com/
>
>

