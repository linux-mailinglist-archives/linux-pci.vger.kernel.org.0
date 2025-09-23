Return-Path: <linux-pci+bounces-36787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE6B96E4B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A2B481543
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 17:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB81D5146;
	Tue, 23 Sep 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PO0ddrxw"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254271BCA07;
	Tue, 23 Sep 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646854; cv=fail; b=UmlIAu/dTxYj04h5VIFj2Yn0RgR5ZKILMBIrP4UjzD5JrhvlNQKXKrRS1TvEN3j7ZWNotsy5621sp1y6tF/+ZuiHuWDLKaAAfNRZfGWwudDTLMTlHvKXGWXrN+4qGqh9jsb3eKROmWk4v1eBkLWAgom1RSU+Ix4PDfaFOqIopLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646854; c=relaxed/simple;
	bh=dxDmWJLk/VWHhZACSjszWNQjigwgfsFvCLYGjOZZOeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4ksudocGGtMcqiclGAIyNcMQkVi3oxWvTp9EHz/hm+b+uGqHqa2RncB+kgRPViz6aPmxogoX19LkqtETgADcuMFEySQaPr35yxWz/WFFFmSxyJNT8ile6hYQiDjFuX496AZpYh0lEyZ/VKaT1WzACWDs91m6z4ND8q05utTrO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PO0ddrxw; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTi61w/Ktq9pvdUvVXNX2Su/p4a+YksKidmKD4Ea0NFqWzkrtyl7VqmBXE7QonrZIeXU9UYB9ILCLjZYs2ZBv7Dc3h/GmJU2VVjeECRnbIa/LeBqZbG5HwLacwK9ie4Fm6KPCEJtxaHX2gpYkikabs03hMrxwRqSOTEohnKBhGkIiQ8VC2KbQBIlqs5c5gA/bS8qs1xTebuUy0/gYZZzsVVVgHBb1c2nGp6R/ExAAN33pTL2dfj7Mk4mfsmK8r3aZy061YWdlvelsPOAKjbIFoEg0yusitW1r+QLiJqnRGdwuvCVaeuchCZ0EnjXPmszkkeNtW2+B5cPSsa2RXgyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PJCryrcGZlLyn2yOaE6LhwVAHu35o09M608LkhpNsM=;
 b=JeJ7MMUntL2Hk9czy4KBq/pEa4mhowPdjuO+CauZ5XMLjKEjO5QDXGPQqFOOTFRkHKUJJCUaE5QTI8NyPg1zfEyErpOA1gFUH07DJCKMkhNER4Tb4+e34c4Hf+oMqW0tIvOwQKvMjAJH6btOkVjG91qS3m/73vYF9gdZjXYqLQEBuuVU9sgbRgkuY01FqUJ8NNHlm6snQZNPKmXyiTb4i4CXxEWDlw7dDamDXlTkPbScakClg8Jghx1MtOQEh9dj812DuH1OQ4dbiDqiDzJ0dJtwnP2OckFDAdNIzbaUGv7eo1vmonS7K9Q7lYwpJR8f9Guhw4CM3kuYPqSK6+GZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PJCryrcGZlLyn2yOaE6LhwVAHu35o09M608LkhpNsM=;
 b=PO0ddrxwSt8J5yEhMKP0NN24H0U/Sa/HsI57XfoCvkn6nJCpSrkZDiNQB9uY+AuB38Hp6kATroZPKur6QxQ5qI7oBUBWUURCgoMHyNYUgkhWm6nEhcRlpGY+w4yn7l158Z3m2ECXUGXZrlDDIesVhOlywRKHmRCNIS1NQzgzo5IXHrgqop8NG6IOX9EOUtyXd4prbJCHQ8SXuJgBvkMbWk43pIVANW6xrAOq4LHDJPcrae/c/340McrsdcRr+o06iSK2wMW+9F0wDYi13feqU6oNtsIKKJgu6mczLCuWwxUdUU8faJJbB3/e4YXQ0ZOD8P8SrMHo49cfHZWBPDyBvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 17:00:49 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 17:00:49 +0000
Date: Tue, 23 Sep 2025 13:00:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: pci-imx6: Add external reference
 clock mode support
Message-ID: <aNLSN5Ix2iZyxeng@lizhi-Precision-Tower-5810>
References: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
 <20250915035348.3252353-3-hongxing.zhu@nxp.com>
 <20250922155054.GA38670-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922155054.GA38670-robh@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::17) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 71dee60e-e4b4-4596-29ec-08ddfac2beaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sjIt1bO04rdiTUFRQWw/I2Oh5uDZa+2aS4AcmO7+VfMtbsflZ2fTdSPvKMZd?=
 =?us-ascii?Q?VwfzGMf8XWQRbmmfJ93ArgFNPwfx0xarx7hWIiQYBcmBd/3KIs5ssZrKg1Sb?=
 =?us-ascii?Q?Jez6C+VtO5rbiBhRubf+g/HdzihlqGsO8mY2ObDxSnZf/vBiFVf38U5s4z4P?=
 =?us-ascii?Q?/5ALuxPkC9aVe5n/6gs9bNc4Pn5W6UkJLeUTB4w3sKW+uPABkv+Upyis3HaV?=
 =?us-ascii?Q?545fxgk7VrxMAppkYXRAHCwiyftyWNjNzL2aLZ8/Ng+pFYbMkYiZRNsZ4l43?=
 =?us-ascii?Q?9W445KjZoXY5RYnoOfvJzFDfkhKBQddXbJ7yKpL9JjzPMOezzPfCTOe8EL4z?=
 =?us-ascii?Q?NFB374Z+D11MOM62vIvDBur685hts/IKW5UequhuU6/gIx76LMBjVIzcXCUu?=
 =?us-ascii?Q?iLo7vF/XJpNzLMhJqepyCKWyz6dO9yV36vAQ1y5HRc1UtUfPVbiSe0P/onI+?=
 =?us-ascii?Q?MU/ofcBSD5W35tt2liWoQope9vwcbpHTWxMwHsRHUZLfqdCBRlT4IH6Q//rQ?=
 =?us-ascii?Q?+O9ZCmTRrbx3cnqL8S40HDfo35SnoA5v9cmREekk3dVrvW7rN+tO15fAMH75?=
 =?us-ascii?Q?T3u4vOzEV5Fzt0pAJHIHyuVNxZO5Sua5hFZjk6ppYvWWy4ryCSlJ2LjvcMdJ?=
 =?us-ascii?Q?JRegZcqi1/Ly3mhdfqMPoxc8D1xEv8OQSxuv6vEpfomkW3BAs5m4MbBl2yHG?=
 =?us-ascii?Q?FM5Pb7xgFmD37OnW24jOwVC9HfEDesp44CoYAuYGBOsIi2oJqiA9S7uVfW0x?=
 =?us-ascii?Q?WQDnFcDxKJ9JekVdDy8kS4vLb7QJc2okzg97jSD1YoD0Ej2a/C4u4aG4ymAj?=
 =?us-ascii?Q?oFpmFguAkuy5KmjfvnKngTyUZhsEkgNKdSsIseziEbrLMWNk1jerWW8+W/MQ?=
 =?us-ascii?Q?bTHyNPyIYNGEMzSvH833J/I7hAI+SNh+TDln9FAb12Ttp9pu0+assjIQrKPP?=
 =?us-ascii?Q?OE8AKhdR2LNjzrY9+/Y95Lfo8Rwxe2sm9oL70x5+ZRDNdDORu0fZQBndYYvM?=
 =?us-ascii?Q?ExS54eMEApPxuiqNzLCiHrifQl3vI9gDCamYkd7J8EeQrPZtLZhS3V4Zl0sV?=
 =?us-ascii?Q?u/VqCl0LbsLi4tp7/tN9hiU3C2KEEhjSSvv/a6GZm8rh4LBuBZmH+Pwgqyqj?=
 =?us-ascii?Q?CvWTsUw6YNoCSgQsnFwQPC/OYhS/LZkSzrSG+bVIKJrTrhsyxGdXkuKWyRmg?=
 =?us-ascii?Q?Lq4k2ggexfVsFIa/GInuLL5LLNFUANWUnasTkhBR/QIMk5aJ569cc+h1AmAt?=
 =?us-ascii?Q?i/wKviRJt4I0dBihEogQTHUISsQf0fE6zCCbQ/B3xHtuWIx0Q7g/E06gVffv?=
 =?us-ascii?Q?A08Wwqa9+tj8RWN6g3wcEL1sB6d3e9L/p9vx8iP9RI5t7SqD/0ryeykcxq5R?=
 =?us-ascii?Q?F9dZcVN7imVkRcFvF0YJyORBhswE9Itj8hsOSt1TV3pDZMINY2vuREweKSko?=
 =?us-ascii?Q?q4RpxCdiog6tQSpbYJ3eRoG9fsGwiDk6BuWILgmlxTyInpsW8nZ1bbEbdVJ3?=
 =?us-ascii?Q?2J6EYKBpwv/1boE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aj2NUpMeoBRjBAMZP2coGd6/BO+xq1fEeCm0E94ohwnO1XFAoAv2lo0N7Lgy?=
 =?us-ascii?Q?9pFi5zSjEj0aAU/Syi+GBqfabKbMa+Pl1FDU5PxhQlUISqXah3tby3vrvl4o?=
 =?us-ascii?Q?aDaRYmsOCMV6l8fRUI21MB6LPgMEU+FPUKmAN7HdhqmRw0aOESPD9/HLo6TZ?=
 =?us-ascii?Q?Qg48jyTGMGczI1lI9IJ31pKDAH1jRNyT/VbkWYGigw2M4ZsDL4ugOwv1649P?=
 =?us-ascii?Q?2sjB6Otm+jRFtLOwC3OfGxjQMmWNEIQ/v5EPGNeNWbxk2AOAyNjimWW4EkgS?=
 =?us-ascii?Q?f7S0Af4nq3Z7C8WcSM2ZafYzAsCBr8LM9WAoKVYWMpanJy7UWv5UuBucpoA5?=
 =?us-ascii?Q?nKJywp5ptmi/VQqBO8XEyQ5RsjT3pRNnlMP5DgdnSWEIZZCuS0n5IXpkBGqS?=
 =?us-ascii?Q?lISUbsrtb9oY9wcRmYVSDUPdNS6scFoC4qNf6Iv61aQwqx9S9yZQVi/gibiZ?=
 =?us-ascii?Q?3yw8GpwOruZPjIN2e+O/AKcVkiG5597DFqt2M4T/XE5u8IYPcBmmhTsLBjn8?=
 =?us-ascii?Q?CFVt06fOLyMprHubrxBl7X8xJrrFR5szI5eCFN3/NeIXOLvYgrTUfgDUZtti?=
 =?us-ascii?Q?cJUvAN5iPkmlgyj7Ros2I0IUiAYcutLiHmapb10TxQBvrq58TCC8rqcdYIhe?=
 =?us-ascii?Q?vGqAJi2eaV7qL6/KWyw3t0/EDPe43ei693klPIsSyV8XVdn85zPmKR+axjkq?=
 =?us-ascii?Q?yG4cfrHHwAhs2oNPDoe7exqjgjQYwiUSltJxNvHZviC5VxbXZZvVaPLsgvrH?=
 =?us-ascii?Q?CbuCMUiTBmlQZrjmJENsxJVe5Pol0V58n+ZToV0gSAsd8zfzO/JX7rKv7UL+?=
 =?us-ascii?Q?SZjH9Q/TtT4XOl0O2KelyU4aDRHR4aWEcPzqv1Upgpvotwy6u5iCwHt5gOJT?=
 =?us-ascii?Q?g2L+7+ieJldsHzO+Iu7s6Bz60x9FwrFs362jhtHA09N/+dWqcS/dOz5uyVuc?=
 =?us-ascii?Q?Z8EykDa4us1OsR4lVDYZeDd3VXoyMIRgVaox8NCJ0bMaKXFE0J/qhFlayuSI?=
 =?us-ascii?Q?YuGQAl05Dk2sWqvipmw4RQXkEsm/5gmIH+TizDslkL3IW1Xc09ROmEutF/Ls?=
 =?us-ascii?Q?pPJer7pqce4rNHSH4CeiHilfzaD/PxbmB2wutV4ZJ1AudzaVPwj7uEqQPQJV?=
 =?us-ascii?Q?xre6exs5PGKc3J1R3lVRN4cjDrO2ELPLyo4fYafQmxiv/Cbb5aOmcTwmOR7l?=
 =?us-ascii?Q?m+2XcIEzgOgOfLV9G93z94IT9ThYltvXt7AAfP1nP60U2wKFiyKSNwd05nfw?=
 =?us-ascii?Q?RA8O3F0kXCtmC9HpsfzTwf9Xr2EJYRZYTfs8zTZsIIhP95S3jaT1EhS5gCsr?=
 =?us-ascii?Q?y+3S3dLAkMZeWgWF1toNKeVfuJ6WvvR31kJe2NCBBGmaElLpRyiekZMXuJ9q?=
 =?us-ascii?Q?zE6pFCh7XIARHgf3rI0OoN40cnOktBxgsXr8GQoRDx/TMxLwKNKYRJKKqVl0?=
 =?us-ascii?Q?tv77EQ4Tem0LSpCMdBWteKQAlHTGIlELgOkLo0IU3tQEhi+sBSXdlW4J2AhX?=
 =?us-ascii?Q?RAfx+hnHq5YeUOC4kt52mkrXuL6GmXFmKh94ma1CgcjxAwmBRe/+KovA7Xpc?=
 =?us-ascii?Q?z8OvtsrUD1zp+ni1a6CGK8HDcAkKupRzWLMVlVRJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dee60e-e4b4-4596-29ec-08ddfac2beaa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 17:00:48.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lib635bzvERGXr/8bxiCxSzzy7OmiBuvPu7pkdi9SGrj0FJyN+j6H3M304alpNd66xSO8hNFjNYkKmv7fq1Uiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

On Mon, Sep 22, 2025 at 10:50:54AM -0500, Rob Herring wrote:
> On Mon, Sep 15, 2025 at 11:53:47AM +0800, Richard Zhu wrote:
> > On i.MX, PCIe has two reference clock inputs: one from the internal PLL
> > and one from an external clock source. Only one needs to be used,
> > depending on the board design. Add the external reference clock source
> > for reference clock.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > index ca5f2970f217..6be45abe6e52 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> > @@ -219,7 +219,12 @@ allOf:
> >              - const: pcie_bus
> >              - const: pcie_phy
> >              - const: pcie_aux
> > -            - const: ref
> > +            - description: PCIe reference clock.
> > +              oneOf:
> > +                - description: The controller has two reference clock
> > +                    inputs, internal system PLL and external clock
> > +                    source. Only one needs to be used.
> > +                  enum: [ref, extref]
>
> This seems wrong to me. There's still only 1 ref input to the PCIe
> block. If you had 10 possible choices for the ref clock source, would
> you add 10 clock names here? No!
>
> Can't you detect what the parent clock is for the 'ref' clock?

In include/linux/clk.h, I have not found any API to get clk providor's
information. let me know if I missed it.

> and
> configure the GPR register appropriately. Or that mux should be modeled
> as a clock provider.

The mux is inside PCIe controller IP. Similar case in S32 RTC, which have
4 clk inputs and mux is inside IP.

https://lore.kernel.org/all/20241104152934.GA129622-robh@kernel.org/

We met many similar cases. Actually s32 rtc's first version modeled as
clock provider, but this way is rejected because no clock output.

Frank

>
> Rob

