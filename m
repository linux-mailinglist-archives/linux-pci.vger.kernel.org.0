Return-Path: <linux-pci+bounces-18821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA09F867A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 22:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B85A164563
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2971853;
	Thu, 19 Dec 2024 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iPUiUdGx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01E154C15
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734642137; cv=fail; b=b5cFDNtefVwwNPUlT/2j4NL7lUornyyQXRhfk97GtukCHlLHPY97IqqPrJeJYCE1Xe0qR9T6XyxhXOvwcFRO+QDc3I1n4XRnIHt9tvWNFisyz28amw3JJRrQbRYGPQi4YUjXEa1GglEBH77CkT8B8DVpdaVjSj/N68tjuzf60UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734642137; c=relaxed/simple;
	bh=8WAoq1btyy6kUpUL+kQzRLEDM66sU1+MUJCq0Dciccs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XcJMhJ74IQjHM+jOwZ6CvqhpTIQkwrCV5o+e2rw6NErNZXjBjj8sZ349YE1p0r5dEzic4Nhy2+oLZZQpzdLocLnR2j4F5qr9mmFl6u89P/N5+KhwX2DJVVUkJjUPhk5bL6bxzuF6x5jPPiY2vFqD746/iGBi6nZ2fEWudi20dY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iPUiUdGx; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPLbX5PFpYGhTd6SvU6sM9QQqsBKxfyUJSDf+MfpfDQyoEswyxCX49RWFYU2Q18xYZJYjx2ATd/VF/iCFALWx8Bn8g0INWa5VQBXN2NtALKJtg57U+R4FQI9LwVDovjhC5AV/huEhEjV/9/IRIIytOfcobRLPb7Fda2l9NVe3OzjdbcGp9nteX3zXqiDCnr97M+HYYbk5l0B6EwjBqgMyw2W38O5xnYVAXE0yOsag3ozxT/Rhke5yj9q6IZHnGjUOn26ew3YEwP50V3xGkMvCY5Dlh3gLX1pp5jMmmxUx3gb2/OqGGCvRqhzjPvPKVtb4NZI8OzvwKp1zmCZf+3FcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYJrNeTTBG8kpA/h+t9xfysapHPQ7VqGy0L43errDVw=;
 b=n9Lp2ULfm9BNuGToGT/yG9FFbg+s3POsNfVR5asU/q+iDVKdIzSabZUQ6WFjDJHatgHbI1CMMT7ITw+ilb0n407vprUXU7kVcCgWB3jlNLVet4CpmjgBWsgAr97N/ZhhMJjv0XfVhTz32coO314JbwuFNoizcEZtwo1i4Xxw5NcMfZlXYGLbGx24b055OtQgi3a5eKZ62fkLXXd1lbvZO+dDm5a+bdlje+ANd85zlqwCAYyad2pxulHqxuNuCJic+EAfps9lAAfC/bQ+cs9i4iHnjSA2V+azaYhjeRAD6ZQ1O3kfhBjG2LQYodMdiz/3E8WmlAz9OxiVwSPUaEkvOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYJrNeTTBG8kpA/h+t9xfysapHPQ7VqGy0L43errDVw=;
 b=iPUiUdGxyg3bKShKFUODnVT6Yc5xx0g1UcAokL1YkY9ZxTS9QUkvEfWSEAYYMvzhlyO84x/ogSquuAc2rNltG8kddBJu84RAZ5epbbOqSp+6YIHppX7AN1QH2nRgDnNofk4XOGNKuVBCopy0yC4ps+c95VbEwge0TdLZnol2ktkqds9mDNCDcTXbKP1vXuniU8L2SGdjYi6xdMfSPEi82v/B8sQ5BFoCPH8qXS0A7Ex3xunAbrrK0yjS/cs92W01KiuoOuBOSQFyvca3uHE2sy7uENiJHzX+BedBlTXvSKT6iC/f5anhs/plgX1CtyJ5WiiSoSxBzs/fsAyJwrYB+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9895.eurprd04.prod.outlook.com (2603:10a6:20b:651::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Thu, 19 Dec
 2024 21:02:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 21:02:12 +0000
Date: Thu, 19 Dec 2024 16:02:06 -0500
From: Frank Li <Frank.li@nxp.com>
To: Tim Harvey <tharvey@gateworks.com>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: hang on enabling PCI AER for IMX8MP + PI7C9X3G606GP 6-port Gen3
 switch
Message-ID: <Z2SJztEqmr3FEIas@lizhi-Precision-Tower-5810>
References: <CAJ+vNU3Q-VBuhUzQYrQ_BYrPM1cdP_i=7ToQk5DR+4MQYE21BQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3Q-VBuhUzQYrQ_BYrPM1cdP_i=7ToQk5DR+4MQYE21BQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9895:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b90bdd-5466-415e-e8a6-08dd207068a3
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Fv+zcYdJqebuJfReJOHzIV49+ZEplQBNYFG/8XReRhRxgaMO/6Jc2HhwEQ4m?=
 =?us-ascii?Q?qPvi9RLXpKJgLWWzRzdexEKfcPQXZVC5j87u/icRE9PSjqOvyDE5r9PakmZ7?=
 =?us-ascii?Q?PmtaYK+GLzrVGBgW14dU2dDMWQH8S7QhDXYIot7CtYaS3GIcePMo5ti+jP9x?=
 =?us-ascii?Q?1Jwvr8xO378AebW9MXnKAmrSm9BnQOCUg1hz0lw8ODvBkovcovqSHGQSxd+7?=
 =?us-ascii?Q?89kzflQ4kOuNSAkf8jN9cUWLzEmCfB8vWSeE/nY8whYBSwpLEOcyI/Fu+G2o?=
 =?us-ascii?Q?GoBI/c0qjSKFdbTwf9gxyGT1oU719twMIcbPr1xfQolp8bOUNOvvrMSgQtYO?=
 =?us-ascii?Q?lSjzFsT5/AiKkZUo4JujGJxrHvwAqL2FLSlJyCvfkEtEi7B2WtReHCTz5YzB?=
 =?us-ascii?Q?YC5M7LwkVOGU2xwJJDD2O9GcWBkTa1fl6AAy7VAL+3K9ZvbC2pElRGHqSL0H?=
 =?us-ascii?Q?uW1SEdvLmohkrYygLbhxgLReYVxSh9J20wwzcBU5mXXBwlAgElD0mJC9mA4j?=
 =?us-ascii?Q?5NxaCb8xV1a4zTuX4IV5CzEu2uiCh1YUxOO/v0x9f76vg44Thr5TZnD951Q/?=
 =?us-ascii?Q?ZiDwOIJmbszsuMtzDsvSxI9lIoGvON5uLWR+KE7DFX1gy4kSJCNJ4KTrqLXu?=
 =?us-ascii?Q?4zAL1PqM6QRpodU83C0A7WDT0gEY0JXXYl/JJ9J6vZO4aXxy/WmW/pnmTAUN?=
 =?us-ascii?Q?g7fQTd2WtrzmxVIco2T0vaiaw6zwbYDnU74zX4PO9ecWkdN6GvqT8LYRGh5L?=
 =?us-ascii?Q?o90rMAu3EJlwVnjdLQOuFjFWCwIgwNSzd6kRHUcshBhIIcxW0jk5Hf3Nm1El?=
 =?us-ascii?Q?CRWpGkuxxF1CuVkEwju7MZGU2OGKReoDHoGlH58p3SI/5R2XsoGz/TlZmYsh?=
 =?us-ascii?Q?N1rlXWYGmdJ5OUVSoLZ3PwNMtY/1zv5rY0xUz5z/tU72REKfABFQsDFj6jr8?=
 =?us-ascii?Q?BHMoaE+jy37Vvn+99E5gvw8TlXRpgiDER6Oo5t1+ZOWodcze/LFFdXwciDPg?=
 =?us-ascii?Q?a4VnpF7P7hPljE8BRAb2hTbc93s9EIZZzwjredgErgQblcXiNwem7tYKOp6F?=
 =?us-ascii?Q?6pQrVoS4m5BerM8wYfWioOzGSnHFJ6zQkbUg0R9x7GjNnyEZwVzTFduCs1qQ?=
 =?us-ascii?Q?g5LYI9hKuxbGHS8Fz0gF4Y7sZ8qfJbsITYZwV9NGjNMdiwIaVRdF94KsItUx?=
 =?us-ascii?Q?tdRQ+RqqIBya1iPwPKE7HlDvv5+VkCWwPimr4jNjXCBY444GItTlRZLbbj1S?=
 =?us-ascii?Q?LFVAZIZJ1mTa0wWrpFZc/lLthERhrrz7OqWnTbrL8PJfsxZEnd0qb7sPnYzI?=
 =?us-ascii?Q?RrNBaiSv9trHUxR2WcsAcJ+V4WmY3+VZ1YPJaKI2LfK2X3JaeLBJOuO591nx?=
 =?us-ascii?Q?JnLOWrXzYYWHlfqjfHcM0zOHjO/y0HFO/B9Y6PxtY/7DzDkz/LXcfkpn5zeu?=
 =?us-ascii?Q?Ykfbw3k+PRn/5aHL6IIjabjB50AvOFwa?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?4ZuWZ2R76HGsJ6fxqdUYzvV3N8NdfSZF39C59Q2Y4GN0AkecdXb8GkSRdEok?=
 =?us-ascii?Q?VSi0Go0Lja8w14PvZLAXTtZezfV+dM8HV02Nsz0YqCVDFWZ63WbbYHuRcD61?=
 =?us-ascii?Q?wYZyQw/RxdINNUGOIl9DeTsXElS8Dpdk2xtSnXkZoXwZzRFHGmxxna/MkD7x?=
 =?us-ascii?Q?drUR/6OI8go4yxTcJ2lsaeb/5PR1v2gIVlu2+NHsXvLGcp37/+ytsrE60tbA?=
 =?us-ascii?Q?A3JwyzK74D29/AoSSwMdE0hHqtB2hdV7Qjew24c4ZlIj9d90VwtCyRChI/BK?=
 =?us-ascii?Q?zUvRHpFHVoU0XV8qaXJSO0H//7xjjckRF1H1e50W1n42BSAG8wOxmbaizf3l?=
 =?us-ascii?Q?RCxW9HbvSjvfWVfvqz37VUI4wSrUOLPFGv29o73SRn8tJUUgoumdKgah1SVP?=
 =?us-ascii?Q?4538sMP9fGZ5HGrQCNFlB440ZiuqDGi3qqmifDLW0gDv074hFdGyy8SPQgY9?=
 =?us-ascii?Q?BSOEBJ69weKvu+YZQ9ird5ujIcJh8+wqucFhHtlCcMEJqG+A3J2Ft9qS9Lr6?=
 =?us-ascii?Q?J4JlTd4Trh9SAtj9b+p/jV3xMjkjnQpRyTaoUASJ7isNWnQvqdL8IHk06gzE?=
 =?us-ascii?Q?oWvqa2k0yuR2dVG8FrHUxUmoGIcGcMAeMLrJ144IfdtvMiQ3Wd16XGGX7Ikw?=
 =?us-ascii?Q?mLlfMh2d22WGl59m+w5cKrm05Gtekw2PFSS6E/gIaHuuCHLm0PeukHHWkcty?=
 =?us-ascii?Q?p224mYAWK3SaVKnhksxejOnXikIjnyUYAKtp7YI3DXxFSdhfUOrs9r/Qa3cl?=
 =?us-ascii?Q?RgvHk3qSYJQLw9s18xtOu7EcAcMtzcLY922U/L/APvo8So5To6p+C/eUwUcR?=
 =?us-ascii?Q?nOxHelV7xWLaPkctnX33HOv7uIYEH/vjmTocaQA4CDj2FFI664B6Wuwhby+R?=
 =?us-ascii?Q?/GUbZIo6ylVOI5u38CQDhqUK64Pv3sMbnyMEstTkDs1DyEIe4B+s1t81r/wa?=
 =?us-ascii?Q?ab0zijPI+On2rs7uAhP5ZI9NZicYC9127frlyd0QFYhQmTi1+xuxW5mWyzfK?=
 =?us-ascii?Q?ogecfsLrr8SSNGto71IwAnqr+Kr83aC5PjG4XU2/APuGMf0Ro06ffX824Kbq?=
 =?us-ascii?Q?TNwREZ7mKwSu9zb7ZNVGF9Dfq1PR09CAKJ5c/oZuzQcvxUuIEazq4Ww50u0i?=
 =?us-ascii?Q?acEebJ4uDDJW77C0wyYk9qhYDxOjos0Xdd8CoH2QryX9ZaQLgV47ToaxzRxM?=
 =?us-ascii?Q?VcSjIcOR6vCb+ZLq3ueCWxrHQv+BKT+El6O2d5qi/3Rno8SIXK8jy6ZadCHd?=
 =?us-ascii?Q?EdyROaFKSmgjm8geMAtEBUwB2upQoWAV5HTzbMBHR8Y12axzxWS7yFUws0db?=
 =?us-ascii?Q?m139jOSYcQoZBznPjtNRuEKrvyTSRRqTRJsZYeVlOhDrmmfT3sKbR9kUIB0p?=
 =?us-ascii?Q?K6IvCAlvk/XGS3msy49smHGXRox4e5H8fhxyDKSJKwjdxasezoExmCD0v1pN?=
 =?us-ascii?Q?kFYI2AEZJAxVY6k3cAPVcOPT+NckPr1AftDMu9uXsZdDQ3MKUpOeqWkErwoq?=
 =?us-ascii?Q?JfZx10fQK2r7b0X/8AiefJUI52wEwgq7qOQNkf/dWMAmRuIJoojEx7QWH2Q1?=
 =?us-ascii?Q?cfIqvaljlG6afEkFJcw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b90bdd-5466-415e-e8a6-08dd207068a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 21:02:12.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8PufwZnL4ZCm+JNdPv2qmRmfvW2FEhoKaXJx7l1s44MCEAMBTh1xN0bqR6BnicvmmueL3mEKRrw4Hb2dn5AEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9895

On Thu, Dec 19, 2024 at 09:54:55AM -0800, Tim Harvey wrote:
> Greetings,
>
> I have a board with an NXP IMX8MP SoC Gen3 PCI host controller
> connected to a Diodes Inc PI7C9X3G606GP (imx8mp-venice-gw82xx-2x.dts)
> which hangs during pci enumeration if PCIEAER is enabled.

How to reproduce it? Just enable CONFIG_PCIEAER?

Frank

>
> I've tracked this down to the enabling of fatal error reporting
> (PCI_EXP_DEVCTL_FERE) on the upstream port of the PI7C9X3G606GP. In
> other words if I mask that bit out of the
> pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS) call
> for that device (or disable PCI AER via CONFIG_PCIEAER or pci=noaer)
> all is well.
>
> Here is what lspci shows for the root complex and the switch upstream port:
> # lspci -n
> 00:00.0 0604: 16c3:abcd (rev 01)
> 01:00.0 0604: 12d8:c008 (rev 07)
> 02:01.0 0604: 12d8:c008 (rev 06)
> 02:02.0 0604: 12d8:c008 (rev 06)
> 02:03.0 0604: 12d8:c008 (rev 06)
> 02:04.0 0604: 12d8:c008 (rev 06)
> 02:05.0 0604: 12d8:c008 (rev 06)
> 02:06.0 0604: 12d8:c008 (rev 06)
> 02:07.0 0604: 12d8:c008 (rev 06)
> 09:00.0 0200: 1055:7430 (rev 11)
> # lspci -s 00:00.0 -vvv
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> (prog-if 00 [Normal decode])
>         Device tree node:
> /sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 219
>         Region 0: Memory at 18000000 (32-bit, non-prefetchable) [size=1M]
>         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
>         I/O behind bridge: f000-0fff [disabled] [16-bit]
>         Memory behind bridge: 18100000-182fffff [size=2M] [32-bit]
>         Prefetchable memory behind bridge: fff00000-000fffff [disabled] [32-bit]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>         Expansion ROM at 18300000 [virtual] [disabled] [size=64K]
>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA
> PME(D0+,D1+,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
>                 Address: 0000000040101000  Data: 0000
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [70] Express (v2) Root Port (Slot-), IntMsgNum 0
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0
>                         ExtTag- RBE+ TEE-IO-
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L0s L1,
> Exit Latency L0s <1us, L1 unlimited
>                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 8GT/s, Width x1
>                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt+
>                 RootCap: CRSVisible+
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> PMEIntEna+ CRSVisible+
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> NROPrPrP+ LTR-
>                          10BitTagComp- 10BitTagReq- OBFF Not
> Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>                          FRS- LN System CLS Not Supported, TPHComp-
> ExtTPHComp- ARIFwd-
>                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
>                          AtomicOpsCtl: ReqEn- EgressBlck-
>                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
> Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB
> de-emphasis, 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete+ EqualizationPhase1+
>                          EqualizationPhase2+ EqualizationPhase3+
> LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [100 v2] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr- CorrIntErr- HeaderOF-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr+ CorrIntErr+ HeaderOF+
>                 AERCap: First Error Pointer: 00, ECRCGenCap+
> ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
>                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
>                          FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
>                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
>         Capabilities: [148 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>                 LaneErrStat: 0
>         Capabilities: [158 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2-
> ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                            T_CommonMode=10us
>                 L1SubCtl2: T_PwrOn=10us
>         Kernel driver in use: pcieport
> # lspci -s 01:00.0 -vvv
> 01:00.0 PCI bridge: Pericom Semiconductor Device c008 (rev 07)
> (prog-if 00 [Normal decode])
>         Subsystem: Pericom Semiconductor Device c008
>         Device tree node:
> /sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0/pcie@0,0
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Region 0: Memory at 18200000 (32-bit, non-prefetchable) [size=512K]
>         Bus: primary=01, secondary=02, subordinate=09, sec-latency=0
>         I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
>         Memory behind bridge: 18100000-181fffff [size=1M] [32-bit]
>         Prefetchable memory behind bridge:
> 00000000fff00000-00000000000fffff [disabled] [64-bit]
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- <SERR- <PERR-
>         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [48] MSI: Enable- Count=1/8 Maskable+ 64bit+
>                 Address: 0000000000000000  Data: 0000
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [68] Express (v2) Upstream Port, IntMsgNum 0
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
> SlotPowerLimit 4W TEE-IO-
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr- UnsupReq+
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+
> AuxPwr- TransPend-
>                 LnkCap: Port #0, Speed 8GT/s, Width x1, ASPM L1, Exit
> Latency L1 <1us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; LnkDisable- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 8GT/s, Width x1
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported,
> TimeoutDis- NROPrPrP- LTR-
>                          10BitTagComp- 10BitTagReq- OBFF Not
> Supported, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported,
> EmergencyPowerReductionInit-
>                          FRS-
>                          AtomicOpsCap: Routing+ 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                          AtomicOpsCtl: EgressBlck-
>                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
> Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB
> de-emphasis, 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete+ EqualizationPhase1+
>                          EqualizationPhase2+ EqualizationPhase3+
> LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [a4] Subsystem: Pericom Semiconductor Device c008
>         Capabilities: [b0] MSI-X: Enable- Count=6 Masked-
>                 Vector table: BAR=0 offset=0007f000
>                 PBA: BAR=0 offset=0007f080
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr+ CorrIntErr- HeaderOF-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> AdvNonFatalErr+ CorrIntErr+ HeaderOF-
>                 AERCap: First Error Pointer: 00, ECRCGenCap+
> ECRCGenEn- ECRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Capabilities: [130 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=4
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=05 MaxTimeSlots=64 RejSnoopTrans-
>                         Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>                         Status: NegoPending- InProgress-
>                         Port Arbitration Table <?>
>         Capabilities: [1a0 v1] Device Serial Number 08-16-48-96-00-00-12-d8
>         Capabilities: [1b0 v1] Power Budgeting <?>
>         Capabilities: [1d0 v1] Multicast
>                 McastCap: MaxGroups 64, ECRCRegen-
>                 McastCtl: NumGroups 1, Enable-
>                 McastBAR: IndexPos 0, BaseAddr 0000000000000000
>                 McastReceiveVec:      0000000000000000
>                 McastBlockAllVec:     0000000000000000
>                 McastBlockUntransVec: 0000000000000000
>                 McastOverlayBAR: OverlaySize 0 (disabled), BaseAddr
> 0000000000000000
>         Capabilities: [210 v1] Secondary PCI Express
>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
>                 LaneErrStat: 0
>         Capabilities: [2b0 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2-
> ASPM_L1.1- L1_PM_Substates+
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>                 L1SubCtl2:
>         Capabilities: [300 v1] Vendor Specific Information: ID=0000
> Rev=0 Len=560 <?>
>         Kernel driver in use: pcieport
>
> Is there anything here or any ideas on what could be the issue here?
>
> Best Regards,
>
> Tim

