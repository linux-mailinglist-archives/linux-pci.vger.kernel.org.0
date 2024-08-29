Return-Path: <linux-pci+bounces-12460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0596965234
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 23:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2761F213E8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 21:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F631B9B51;
	Thu, 29 Aug 2024 21:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UgxgayAb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899918A93A
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967834; cv=fail; b=n5WbhKhG0CkzfOLcCJS/ee3BUlc8GIDfShRokPs11tc6toMxtGDuo88oZ0747v1IqdOB3aSH4RwInHswzkpjEfVbSshtuCUPH+/YKkv4n0zQ8Lxg3jSHwXl0SiYDhIfgdIYaFfa7I67bgGWOyWt8dB/YhPNup6vaRxA6DPAdMfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967834; c=relaxed/simple;
	bh=VcQrmFFtl5vgv2B8pRYHTQt5NDEAhLkt6d+3I8+9TAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bic4UVveTOLy0IJxAY8xdW+drEt6maAjkUksAU7NYKmQqXSptVEQiZ/H7R2L6vE9GU+MVR+bH7W4JXbsOt8aFMJKYaPO8fpFWJwhuYG10GRqgfG0nGfrorAIxTqRTpa6WLiMS6hFv85aFuQjj3WNlP8faop5haJiRZKwl8icu5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UgxgayAb; arc=fail smtp.client-ip=40.107.249.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpDliW3DeaHO/+o2Lu2vRXCWWs/05Af8nE2VHJ599adV7NhRy9h5W30MOQ+cdPcjoK8aUTMCXDlkV6k3VP1ZbUpet2TziEgMVWyWbha3iv/nmy0aqmV1q3ndDUZpn8spxk/OENFCWYhH9cfpFPEFCnTwQXkancPm6LGvXWCBT6fxpXws6B7miFUq+OwEPNplL267nH7dbyzze303n1AS7hWKpz6hbBGK0qiHylykeofP8n/91l/b1OY4H0IKueC+IboPjOhPvNyOx5R6Pe+lgii2L9g+U8h+DPGy065JIOs5UZ4hyx60LlfcYF1WsrjU+V46TjXRysOw6HhJ0LBIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO3UpIoROg0V4UlOv6JvbieLkI+qZiaMczriJdHr0Jw=;
 b=DdxbOsN5NpcnBpkSLGgzSuNg+lY3jrf9R0ceNvfdNpUNVefj1pS/yl7xLPvSBwaoGW+b00Pr8be9DevFj4WH8r1J3ucYgdnMqjmnUp8KiPElF4uouotwVDjEf6gVqeu51IzcS6cHwM2oxWaVcJ+dBmSbQlz8TM4JaNEys7N5UugNz7KMUqdXIXu+KKqX3jZmTvS2ug2pVvp7/RN8SCK0OKFrDN/f6DBDqFWR+j9LyU43j4w/TsCXkGI767L1WmzdwmYNNqFUiKnUUaTa3t0ynPhEPWe/xds4HOMmeyVEguLLpRB/lJZeksaHkOfZJ+/ifKrqB4Yt02DfLxUn/NUExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO3UpIoROg0V4UlOv6JvbieLkI+qZiaMczriJdHr0Jw=;
 b=UgxgayAbxG7ytB/gaCvkLWH+q21kqMJKzavoR3lzN785m8yP70JmkyYcHzZUUnKU58+5BhmN4+AMrrJ8mTYbT2gcRDgORbmbQBzVVuOrUvtaMhIn2Cb01R3eBNA8lhZNdcN4G4I8OzPLZO/D2rJQhskBILDYD6fFM1N36D7fPPB4GS29bMkYaEN+g1g3SiEAGC13sGTQbQ/HeFeC1wqkYOGhbcjjfxKNsg7IUOuQgWb0gYhZzzTE1SwTZfPgzyOxdd0o9g2yfJlFQRBerCH2jv6kByducVyQAY1i5A1R8o7QXIc1X2kJI9NpocA6Is4jD2R/33VBnvNhDSmn0duZpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9685.eurprd04.prod.outlook.com (2603:10a6:102:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 21:43:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:43:48 +0000
Date: Thu, 29 Aug 2024 17:43:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <ZtDrjl3b8yhumk+A@lizhi-Precision-Tower-5810>
References: <CAJ+vNU2YVpQ=csr-O65L_pcNFWbFMvHK4XO44cbfUfPKwuw6vg@mail.gmail.com>
 <20240829212235.GA68646@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829212235.GA68646@bhelgaas>
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9685:EE_
X-MS-Office365-Filtering-Correlation-Id: dc18e5ae-4283-4636-a5bb-08dcc873aa4a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?GnNypgxG+66KwKRpysLolb4QMXsJIAkWEKKkZ/MIkwykRaRy+UCEVcZWTkAP?=
 =?us-ascii?Q?0XLx/j/7TV9PW6vQ0YhdS6rezhnCi74dyEnF18y5xoN7ZlRhbwQfUCAG9U4L?=
 =?us-ascii?Q?iTS81382D9UIskg2tbgEych44S5S6q9UKIw4n9p9zQc2FiGr/9liGFUoM/v6?=
 =?us-ascii?Q?ngnO6TObEdtzjyZDK/PxhcwLDXgAdZtULO9KvcudPAhpYFcyZAIaXl5C9ABv?=
 =?us-ascii?Q?NarnMB231VzcsbcOVdc9UINX1ZXwgwQhJr8LteNLRmaAuC/SVJII4AKqhNi9?=
 =?us-ascii?Q?1yOeDN0GKpMAGbQKzD45d9Y9ugUbUeq4r/pZx8ymlLJs/3ZR5lEu0fASTo2+?=
 =?us-ascii?Q?HD5LjhdrwNwnguoFRlRDtVUBnF7/GpsKtjTIfUtTj0CPI2xUFYjNkxR0hi8y?=
 =?us-ascii?Q?f2OnDMF8xBkmFbEk5v4mdaEzMm7VUR0edzqaRkT5TTjHEfeqHz+L0gD/Sj/t?=
 =?us-ascii?Q?AVGSSa5bhki/ArVP5PpoG5NCSlY3ZMX1DJEJ3+Q7iZZli2YWEqQQtAl7+Ypj?=
 =?us-ascii?Q?00YNFWjTSDy85VDM5UC5EzEufsTIl4nH8iC7lbpUaOSwgnNCdJX0FfFVvwa0?=
 =?us-ascii?Q?NlclfGx8Pztavgmci9ztHbg/0g//N/fVcsvK7f/KNU3r09kz1MgUKqCyrsBO?=
 =?us-ascii?Q?/klVEAv3VCy4/hjM4Tc4G1B3lviyn7GucRHn6tn1JyODqsi+Jh5ba7fPj/a0?=
 =?us-ascii?Q?wcKUI+6b0SDWykR8xe4Ek7NEYQmX7qxvrRS1qAWsIzGTYBtYb5zOSQuzVGTm?=
 =?us-ascii?Q?yxxUZeT/GQY/dK99th9Umccj34NQl+/poav4L12VzFA4YLZhVy+2YQM4PljP?=
 =?us-ascii?Q?i91ZtK9JILvVwU8lFMdSWwbplXUf6EW6vY6VHXrqktU3C2na8Q1r9+lmeVIl?=
 =?us-ascii?Q?qPi2Y8fN8Qd4uc0fk+f5snCOU0gU1JMayZMYk747Rs7umXzb9bKbddLILoFV?=
 =?us-ascii?Q?heI66S9NXGVlwUA35FbjVEjd5Jje6lsgQrh6X9FNxbV3/szy0PqMCK3T+P05?=
 =?us-ascii?Q?i8hkr9l9jLqSujZn9C7i0PE/Cpp7Mh7cTlRlnafLx6zPlXP3lcfk+JzKtqej?=
 =?us-ascii?Q?RmBkuYgt3amgWQw2SEGaTHLvoBymJUDeJpUQYxSOsE49GOGAncRitqargG79?=
 =?us-ascii?Q?8QM/jtO164r2F9lli1g9e5h3Mkjo/dh7Ro/g0dsd6imIEO+CdylziFNXNaLv?=
 =?us-ascii?Q?x3PKINufON4oKETJ1N7otlLA4rZoR9mGK2vtYD4kvi++58d3YmKsHxz6YVeY?=
 =?us-ascii?Q?YFa9Aq87o1CA7wuDpvVzeFOhJzVa/KvSamWMpq8ltBW8Gi2sBNwzZNY2/ZJo?=
 =?us-ascii?Q?zIjuNipx1dcc9s4WD2vQRL6OQeXfSMr12F1rD5Xq71vaIyBZNl7y3kw4M4F8?=
 =?us-ascii?Q?hKaVbkA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JOnSJuerhsigvxmSYSpcjpE4+79UVKtvEphNNrz5W00VlhlPcPFfoxxlavW5?=
 =?us-ascii?Q?qW7hgQGZ6ksDOon6JBNSas5cKeCEjPz05qGtjkqFFEwxuoh4hF3/SOFfoHGh?=
 =?us-ascii?Q?JyuPpVpPQkeh79okRmwtByXK5REjyk+xOwCm7gKNmBZenwjxhX5BzEKjLgU0?=
 =?us-ascii?Q?wSLsnfBxbszkKkEOo8jONf4AYG5rbIeGN88CtTHa7lXYDon5wgg/N4/wLTvZ?=
 =?us-ascii?Q?5fyF8wrzhoVMBiWvX6dBS8EUwY+NCwwfTh4nZJ6aeYwHA7aqrtEBhrTg4KTe?=
 =?us-ascii?Q?WYSM6pzAFS8+O2WYo5B/ntj4tzGbnmEtJU5sOgbpQEC7k8Hdq5+d8sM/OrjW?=
 =?us-ascii?Q?wp1ZRKFgqr1Kbi64MG9TFkW0yjZ+N5K1t/gcDydk7hAmH5xryJf9mZdkZg2h?=
 =?us-ascii?Q?Ox2StaHtxg5JEArgQ+A0ZUWjNT6B3uSQKQt7wFCVRpbAKgnq9Kgp0s16e45m?=
 =?us-ascii?Q?YFsaLfVhRrlcgi1g2OgEMlHuCoC6DZ+mu8d+Ls4RB8u+S7zkga7jNXzSqx+t?=
 =?us-ascii?Q?jwwC1RWWeuAsXCheBPVSUQU/dPJbAVQ9SBDvcXFdp2oLCH4IFWHkvEfM3RfC?=
 =?us-ascii?Q?fDxZBLojbzLxs5DP5f+DYLb0Br7YyTOSYsy6/RUe6fqeRKXWM/ZopP3CKPf9?=
 =?us-ascii?Q?IYabjdiQeWN1jplXbQ9v6jcss1o2Q927zBBa/lDNX3XIpoFchIx0hI2NGVEE?=
 =?us-ascii?Q?mhSDPLrl9eP9tvF2Gu8CRgGgKDa4YAUefoydQhwLMkXY93ZYalT2DnKLLxmB?=
 =?us-ascii?Q?b5vDfpNbYz8aCDVKhSXJp1KCAh7JSz2svuJUAWF3TeES1s9iq9HS9ctQ2N9n?=
 =?us-ascii?Q?/e/jbe7dIrqCYHCLvumiz/w5n9Cb6Fb5QEH8Qd8+dELf8x0qqu0sn6WQf5Uv?=
 =?us-ascii?Q?JVu11lxSgN2dnwGgppmvyuuAUIQvZRtkLnX4n5aym4+ItKo2lLy0UlrkmhQU?=
 =?us-ascii?Q?gZyr9sHgiQx8S7Xf0Zp3GSVGBvW6jOA8dxGvz/x+DqD3XTu18FuTxiH3bVO+?=
 =?us-ascii?Q?ZtND1m7IW0JeXC2uO4wDrvBaKgcvze98EEweIPygrCi4JF5DqE2rU0Benn7c?=
 =?us-ascii?Q?StOC9Fz+bFTFlv5auOhnRX36IO/lgVMXKfsJQ4Oy5W5fQGo8XTQJuaOmfaNs?=
 =?us-ascii?Q?Pb/UO2KjwLJUy9GZ3LjSnf9Fek+Rh0rL2pEQ9fqhou+nGxvShma37fNE7TQg?=
 =?us-ascii?Q?2VZdOID9Ifgop/DnQ3zZ1Mh7TIaAWAVRGFqMueKfQkOqp+tAcct0rB8Rs4GB?=
 =?us-ascii?Q?ul1xUkgNbVss7sIPOO9XOe3TwFTcZLjPKkAmnp0oAA3xwblGVNY+h6Qsgb7D?=
 =?us-ascii?Q?OQ1qI9T+p4KBe29DobEGddb7yCVQaAuhgIl7Ab5ZwpxTudkrQynXKkZBkatN?=
 =?us-ascii?Q?+8rzySmGbEE0K3JLIpPiXuRrSW4bfdyyRIPzFQkI79iiXf1waLEr/5AoTIs5?=
 =?us-ascii?Q?aAj5GvmWw4sel6bsm2qRyIjkQN5ZtEau+4KUsDIlWRNMGxQH66GQdD76VXVP?=
 =?us-ascii?Q?8EpZeUwVzaJCxj6AWQiIdjG+7ZogKA+wCFPetllblN1atWW1PGHuQRV7fiUy?=
 =?us-ascii?Q?bem0y8v7S1EZmwbsAXQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc18e5ae-4283-4636-a5bb-08dcc873aa4a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:43:48.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpfIJHLG5O929MdkNURTiuW4MHcvO609zgqViuc1R4Ri1+pGBTscmCpKjxnlaPIW0Rca1rVv51AtNk3SHH42aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9685

On Thu, Aug 29, 2024 at 04:22:35PM -0500, Bjorn Helgaas wrote:
> [+cc Richard, Lucas, maintainers of IMX6 PCI]
>
> On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > Greetings,
> >
> > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > device and the device is not getting a valid interrupt.
>
> Does pci-imx6.c support INTx at all?

Yes, dwc controller map INTx message to 4 irq lines, which connect to GIC.
we tested it by add nomsi in kernel command line.

>
> I see that drivers/pci/controller/dwc/pci-imx6.c supports both host
> and endpoint modes, but the only mention of "intx" is for an IMX
> device in endpoint mode to raise an INTx interrupt.
>
> A few DWC-based drivers look like they support INTx:
>
>   dra7xx_pcie_init_irq_domain
>   ks_pcie_config_intx_irq
>   rockchip_pcie_init_irq_domain (the dwc/pcie-dw-rockchip.c one)
>   uniphier_pcie_config_intx_irq
>
> but most (including pci-imx6.c) don't have anything that looks like
> those.
>
> > The PCI bus looks like this:
> > 00.00.0: 16c3:abcd (rev 01)
> > 01:00.0: 10b5:8112
> > ^^^ PEX8112 x1 Lane PCI bridge
> > 02:00.0: 4ddc:1a00
> > 02:01.0: 4ddc:1a00
> > ^^^ PCI devices
> >
> > lspci -vvv -s 02:00.0:
> > 02:00.0 Communication controller: ILC Data Device Corp Device 1a00 (rev 10)
> >         Subsystem: ILC Data Device Corp Device 1a00
> >         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx-
> >         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
> > >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Interrupt: pin A routed to IRQ 0
> >         Region 0: Memory at 18100000 (32-bit, non-prefetchable)
> > [disabled] [size=256K]
> >         Region 1: Memory at 18180000 (32-bit, non-prefetchable)
> > [disabled] [size=4K]
> > ^^^ 'Interrupt: pin A routed to IRQ 0' is wrong

look like bridge route PCI bus INTA to msi. I remember msi irq0 is reserved.
Do you have more information about bridge's MSI informaiton by lspci?

Frank

> >
> > I found an old thread from 2019 on an NVidia forum [1] where the same
> > thing occurred and Nvidia's solution was a patch to the dwc driver to
> > call pci_fixup_irqs():
> > diff --git a/drivers/pci/dwc/pcie-designware-host.c
> > b/drivers/pci/dwc/pcie-designware-host.c
> > index ec2e4a61aa4e..a72ba177a5fd 100644
> > --- a/drivers/pci/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/dwc/pcie-designware-host.c
> > @@ -477,6 +477,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >         if (pp->ops->scan_bus)
> >                 pp->ops->scan_bus(pp);
> >
> > +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
> > +
> >         pci_bus_size_bridges(bus);
> >         pci_bus_assign_resources(bus);
> >
> > Since that time the pci/dwc drivers have changed quite a bit;
> > pci_fixup_irqs() was changed to pci_assign_irq() called now from
> > pcie_device_probe() and dw_pcie_host_init() calls commit init
> > functions.
> >
> > While I don't have the particular card in hand described above yet to
> > test with, I did manage to reproduce this on an imx6dl soc (same dwc
> > controller and driver) connected to a TI XIO2001 with an Intel I210
> > behind it and see the exact same issue.
> >
> > Does anyone understand why legacy PCI interrupt mapping behind a
> > bridge isn't working here?
> >
> > Best regards,
> >
> > Tim
> > [1] https://forums.developer.nvidia.com/t/xavier-not-routing-pci-interrupts-across-pex8112-bridge/78556

