Return-Path: <linux-pci+bounces-25069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB9A77CF4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF8F1674E9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023DF2046AC;
	Tue,  1 Apr 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iiDr6a1I"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7D2046AF;
	Tue,  1 Apr 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515783; cv=fail; b=cYU+V7bl/9zdCHKEje9hbM2HKw/p+tp/k1KzagTB7Lp66zRzGlkNtWE7Lh1o9WgbhUIlj6VATtH9kPYnz/3cl0i7jPJPK1k4tPnpyYUJs6rfJEfBOqbHYHZuI2wcvA9Crd4zTedzunD2Gih508qsXypek/0UjIJaZsMbXSU9+og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515783; c=relaxed/simple;
	bh=J44IQQcHy8PJKjqheXN7xa6VlTNoNHdu3Zzju3OKkU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KwwfNmbFG1kI3lA30ZDke3fMTs9toZPvr2X2+dTKXWLXdb60nqfwQNwNf3k13MsvRY1HRcYcv8ZpilvY1QGws6ORjmN5e/a3bG50zMr6ZOkmJO1Mshnca6emwSlDA/VUYfNWRkv8ajjgNp1WX9coDDfOsylEZKviwYpxMTTeG0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iiDr6a1I; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcyOztp7Uk3IcagmF6sa9hSGz0n73wdC4FKkxLLTFk2FscoZBjV26ZsszxSxan+tWbxaQTHa5nmypaOLxzUV2IN3QSN//hUe5FpOO3x8gUzVcxEjI0N9NXiGYvUakAFlNHWkD3BlKWa8vZXllUoALUI4s9aOUNbJ0l0cM76I7B7hXla9vPS5fFUDzKHltt20N5pZMXJ2mzjW7KSE0jvRgkSUi6eqymoCkWHX80ArPZ6rVksYwFe+9TFELzkg+khcdsH9mxr4tG42KLANESSvoYjQGGA3FQRF15vrqGFJBAbZRhVM19pRsNoaDpKB9yYwUs3T3fcEEv5JTcPRcjtTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J44IQQcHy8PJKjqheXN7xa6VlTNoNHdu3Zzju3OKkU4=;
 b=p88bvxiwRRdWspPrYR48eGG8OuFcTFDok4jF8YDjdbBRdy5OjqXXQebAsAOwgBkmk3dGMSOFtGasqvoMOKmQ6hytTcVzRCCIUJ6L7i0vEeflPJDjB7RQRyGcQPNSIYbO6TXV9LNVZqPAm7pTC490FpYeARSj8XH94hTA6VchiHTByDW6eIU5CEKxGo5QyqbgxGzPR88+rvem+21bIHQLUvdJraRw86jr9PgYe+K7PlyaVlYp5KHQWWlkdtgDU+Vr6tdTM6iKO2Tg7JH5rYxaOSEy2VtNB7ZGno2SA5pFLUMZw6IgOt+KHKy1yQzCI7gGtQOlIv6E//j80y/PYG4G4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J44IQQcHy8PJKjqheXN7xa6VlTNoNHdu3Zzju3OKkU4=;
 b=iiDr6a1IM3vMEUJtwsT7Yam2fZDXs3nzy+gJNxmFz4/aDxDUBImhpXedZTHxY0AdDWAWzL8Do2e2JCuThz04wmYrkCrmK7svpW/W74yUTB3OVO9oGDWsuCbR4VHlXPBR9yZ8pkg9OFs4VstA5jlVH3JJ8iURnjkCXXycoGTcpNP1n8QZvdFegCofTid+LHW5do7Z2IRSPeMTxXXVZuBDEH6BCzpQC+B2iV+Y5YvPw6b3w/QpVNcux1IvznLXDSC5VmHCYozboQ2FbOfGty8mBa+JT4Cg4og/7pezcEj9JsOH9QZgZ6gvWTUGLDWwtXHXrBLS/S2CGGLxkjKllQ6lJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 13:56:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 13:56:18 +0000
Date: Tue, 1 Apr 2025 09:56:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] misc: pci_endpoint_test: Set .driver_data for
 PCI_DEVICE_ID_IMX8
Message-ID: <Z+vwfHOLIej1gjsL@lizhi-Precision-Tower-5810>
References: <20250331182910.2198877-1-Frank.Li@nxp.com>
 <Z-u6cZs6qncIWF98@ryzen>
 <Z-u__47R9vprIbCS@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-u__47R9vprIbCS@ryzen>
X-ClientProxiedBy: AS4P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: ab1e7a00-fffc-4a59-9e93-08dd7124fa02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IEiZLSvHxHiTSZP4sjUMFilSUk3D4drfwX+DVgAKzlrCq1y6eHF03+fSbC/I?=
 =?us-ascii?Q?P4OVsWPnqc1ZNRci6vcyRYqNUWIPjXgjTqaVdImuLnbs5I5K8mLHeEqc4bnO?=
 =?us-ascii?Q?DKB3xjOEMvltOzpe8V9iTFDyU7nU+Jqs5e+hnigf8jkvFeKOGtDjP0SFqlfw?=
 =?us-ascii?Q?YrLgdEX5cPFB5Ki/1MFs8ba56DQfxvltiamkWyzzK/uNZgFaCFIUsr516muT?=
 =?us-ascii?Q?rEaAGWED/WgvXnrN97Bv3j+r4L7mWkDU1J+uM3oAACeeTEjCMR3HWEIl3Kyr?=
 =?us-ascii?Q?S5NzX+F7gbrhz2dSCLAUQLeIRK03ii/y91jSxkiwDoniyHQ+Ab7PxVKfMVGt?=
 =?us-ascii?Q?1U23JTtB7HWUyaerzPBCnx10gHBnCZwhiWEzrwKdbj4yJBQyjj4r4vtgNoit?=
 =?us-ascii?Q?4Mb3L2nf0im+WQEROe+Y8Kbe+GLNrJifPiOK2rvKQHir0YVF9R8/xm/x88kM?=
 =?us-ascii?Q?Pi8gSs4uCWvJQtu7+B2eks7mHe+4q1uSpWTZohyr9chbcLbmprl7dYENQan1?=
 =?us-ascii?Q?XZ2A7Ypwfr/b4kmyhY/8IhgliMK6RxEwsQXcZz4X9COoF3Dh51r/KVPBXy1r?=
 =?us-ascii?Q?OCIPDktsP4xiDZqPB2w+qrpnebHWLsOuF2FFPLcmr/OSDOoSorNCTK7U2gUk?=
 =?us-ascii?Q?+/QdRxaBk9OIaSYzalDkmnBTTZOfwTqwljxHf09o2viwktZoO2hCRCiLw6LZ?=
 =?us-ascii?Q?ZUc+xbRrK8OIDwBPi5CD2Yb2+Pojyuq4sXeg7q/raRfS2h1RAiSOOnfz5M5q?=
 =?us-ascii?Q?FjRMIGrdlKA6QCrMVS1/G88SVqhI+8ML/hIgzhxVdBxdtBGHttoZLq80b6GI?=
 =?us-ascii?Q?DVElsyOvrHkeNG6wvx9CF5CIqO7sVq3xG9Kzbw7MbfwjrAKU9CBczDGSZRBH?=
 =?us-ascii?Q?u7+P/ZKTyFtr1vWS8qLwNwEMNPh/aPE8WtJoWyyAz0DcMyFYz5AoX+v8YYwQ?=
 =?us-ascii?Q?qEKA6cF8TRUzfVvNkETS95TyuXKXPnHDROBwEN7MVb5c9Y/ZJW5fH6iAP+ag?=
 =?us-ascii?Q?paDnvjwB/ckiKwto9UBLfcnoDHiK4Xk+IiK1KTScGBc9K8e5CnqBD5z6WHyK?=
 =?us-ascii?Q?0KEPZ7dQXhQxZNOuHdAQ6e46GtgWykP9SawPtG3vskIqBoZxNdjxd+c3nzBz?=
 =?us-ascii?Q?DJJX6LbgLirufrs3lRkuTZVUqXm57BIxjzn5qQBl4zgfTSxqQUXlODs22Axn?=
 =?us-ascii?Q?zEuWb4RpD0idPsu69KAujtqLRBCl2PMYPjceF0x/3QgGKI3f2A+r1Ej5SVQX?=
 =?us-ascii?Q?6cKBIUSyFpMt6pdmwzALKi4ZVDDjMuL5Pd8k9ICHIOkKbmZi3GR7bU4vnKPn?=
 =?us-ascii?Q?mwqHK6iTaSy1zAXJo5EuGubrzhFieJLiLgJ4TyWrgMwi97oAweaDYraDPnWi?=
 =?us-ascii?Q?CpYMH4hRKslbQOgZ8Bp7Vjg/7Q+/1Q1QSS/uCLiQeIWfLQqJvAW1VrS0mce9?=
 =?us-ascii?Q?DYoEJW4rXf5PZ4RNNNe4X6zPokSN44xW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FV9YY1Yb7g7QG+ozJbtYkZ93nGw98ASQtFCeyTtoxOK0DRCORFdun7mdJLDn?=
 =?us-ascii?Q?gnx7auCiDMn8gyJBHeeoEmdE16LkPr4Xz3U8qkaMWpx/ASWJs22TTSBRFJZd?=
 =?us-ascii?Q?/cuMAILWtRcCSv0D7cQ+9vCYg6kUk4y6K1NE4s1YSzhuSQxO2jxvsNIaoON/?=
 =?us-ascii?Q?muzAgCBMmeddmr6oQdw+Wsq83/qmI3HF8cBDO0ecmZT2ACWN2ZKzKheIudTH?=
 =?us-ascii?Q?TWFGpe9Gk8Qa/E7JBhFHzA4A07ZgOvBYEaPHDrqAeDAhlGaD40q+23kLw6l0?=
 =?us-ascii?Q?YxbU0zTszAB8/S6p3vX28hN8+9LqnYG4Jf/TkcxoqT1ZGWfXKfmy16wnGItZ?=
 =?us-ascii?Q?7nu5TDx6EvnUMRlB/eHo2ZhOd5NZ4vElHcAa/KGObUQJYHb5j7juQlmweEAv?=
 =?us-ascii?Q?yKuQgtFxVk+edrCzqg4FGIDj8P+StIF8HCTgE8iY4vSo0R+nrD81gKqJPwat?=
 =?us-ascii?Q?fw1LCKDOl542lcQoTiSTtkOBibf03F0JPtUqGnobfX2kH63nvMTL5gl7k6ad?=
 =?us-ascii?Q?Czsy5PZ/GVWqdv2j6PJWqVwG1/YXkoZFnsIKgPooRRroUD/I/Ap8zTGHE7BF?=
 =?us-ascii?Q?NRyncU2yg7JpxSF73lnQEQq/LDHHt6S74mQzaZASKPdDhctTvOTPFPaiPuKW?=
 =?us-ascii?Q?UtoxhXCzo4htgQcw+acUqdFimlUmx2ghhw9DtJ7nXPs76pHdI8fE5lrdrPRL?=
 =?us-ascii?Q?Rej0WkCwXmHGTPoPKuJGZ3UUG3dmjswxl5pv8gj27DlB1ebkKJpzQUGyDHfH?=
 =?us-ascii?Q?9Ic7wnRySpkIMGV7ZhONlzMLYt+UDm1MyPKvyRIatxjojU+DujrmYFVu3KKO?=
 =?us-ascii?Q?H4Vt6nTgOW9St2EgEcrAzpG5MuQlTUZHVn2NNxSvkZLU8uKhsK+cC/4Z9R6d?=
 =?us-ascii?Q?aEdDRZDGDnwe+ZLr9lKaDSvnyo9oCv94KmQAbWc6uIYrp4ycIPJtMTBPchJj?=
 =?us-ascii?Q?XF4bYYZG4Z26siHYm54ry4M7DJ+9xdA6saZqh+mAzoXaNcSh3CiJwH8+lZKK?=
 =?us-ascii?Q?OtetUC2q3hYQcoRZJPgK+1Gth6nsq4qBRAYXVQ39kz/YnStlf+4S4pMSdjNW?=
 =?us-ascii?Q?2bIaDtFPGucAbz6Qd6sAJr0ODoYWig+6GpJyHI+Qb6VmOg+9RWugdOIb1T3i?=
 =?us-ascii?Q?wM2dwXwUOld+QlmXY+DUmdEve2ZBrKp7+vTePHho8ZOzMuJ0ZvYF084bB9gh?=
 =?us-ascii?Q?Vogi5AAtsoifoOLU33CaIWAaGB2c2XEQnmQlRCiUMcZ2aKN9TpjCu1jk6BJp?=
 =?us-ascii?Q?ajrklGmKscHGDMydABPtW4vL0/HkdJHNIhDLNTY58lSJbD7DOflpr3qaF3DK?=
 =?us-ascii?Q?otp+ctObWmDpoe9ATHrCcZlQp2sjMbMrHZbtHvTjkdBQkJ3+6ZXPkPtEQhLB?=
 =?us-ascii?Q?OYOPjXcUy5/hQc7uIkPShlpue3QoN/vJ1xu3317tyxqQvh7fGvacgOL1KB5/?=
 =?us-ascii?Q?qbho+pfL1MemGtVGpJ5O0ty1Rnw9X+XImyOonES7azhFfrS3WAAwoCYfthqz?=
 =?us-ascii?Q?i10I3ngXd4I6FUaI35lpFGQAtACnxpuYF2XK6BId53r9+/YJGZohFj4NjUMS?=
 =?us-ascii?Q?xSRkaYx14qt3GD67w0FLGoF7EMZwFYi0nvgzUIeF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1e7a00-fffc-4a59-9e93-08dd7124fa02
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 13:56:18.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnNXBoKXEvTSZFgvgyup9nq9sMmk23S+jJgOGqVueqB0x68GpKc8AP3W7AB1naM/J8ukXcs5lWbRPAY71Gzlww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10378

On Tue, Apr 01, 2025 at 12:29:19PM +0200, Niklas Cassel wrote:
> On Tue, Apr 01, 2025 at 12:05:37PM +0200, Niklas Cassel wrote:
> >
> > But... I suggest that we just remove the pci_endpoint_test_alloc_irq_vectors()
> > call from pci_endpoint_test_probe().
>
> ...
>
> Solution 1.
>
>
> >
> > Or, if we want to keep allocating some kind of IRQ vector in probe(),
> > just to rule out totally broken platforms, I guess we could also do:
>
> ...
>
> Solution 2.
>
>
>
> Considering that this is a test driver, I actually think Solution 1 is better.
> That way, even if the platform has issues with IRQs, the user can do still do
> all the tests/ioctls() that do not require working IRQs, e.g. PCITEST_BAR and
> PCITEST_BARS.

Can you post patch directly, so I can test it.

Frank

>
>
> Kind regards,
> Niklas

