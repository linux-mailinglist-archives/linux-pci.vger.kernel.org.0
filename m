Return-Path: <linux-pci+bounces-20303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF45A1AA0B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 20:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C691165B83
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C489198E9B;
	Thu, 23 Jan 2025 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j34nHWdP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590B199932
	for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659379; cv=fail; b=G5dKCcN5FitdSaTT6VmdmPwmvmqG80Y1wzMX4LxhhqwnUvTa3Uj5la0kj2LkJ/kyGtlWpvJYlLKcrv4Wqbnb9xnaRnhfTcVgKPYIeRLBiS+2pPrdN45qJPbmPSqEYOxu2t8DfvWZJqAEF17wZR1heHzMJex/XSUgUZGcUzYaeFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659379; c=relaxed/simple;
	bh=a0EOf5OUve3TB/tFzhOGCUU6/6uSkQE2B2zpo+7va1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bV5V2lPBvz7OLdmi3pCrIIW6pq2/ae0gX6ZTxhUN8GcZyvLoNUVzDuqyf7pnioodxUsBaI4T9cSCVCEWxVW1vhvSOOj9bxOfLSpgiwj9tfhexTDVat980AJdH8zJzWNvQZXHPiaBiKs6wmR+2jYPrptofHxHcWTWwJGaj1e6OZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j34nHWdP; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzYdIjOuJc2LKFcs1+pygFvI9GEmKK6YR0Aea9H5yk1FS2j/zRSrzu5U7SBC2nVdeXLUT67volXgzG7vf+AhNpOOo93po2r00EXlnKdWx74Cz4KMn2xLgXUUk4Go76zixP60upDvo/5UXxAM7GNXZv1gpxLpneigaGhhlf/BhDobDLfmqZAlmVPzmtj7BOgdgT0WLzF8VPtBmEGIdkpXIo2hzPCQrV3/49AWEfTOAl5TfOVtfh8ALTBEsRM8At/wwDSN5KWZqrZAs/i5gTFSaXs6vMlUoBBwwsdjMLHEY+aHwBIcsTzzEQCptiI93w6d4gHm+1vc00gS+9uTDp4Qwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=267YOxN2Wm7GNvx6xr9XaqFG1LoNY8ldKHA2Q4dXPbc=;
 b=vH/DrJhjQFUQGeOBy90hO+kWqC2gB7jAxv/QjB2WMtHxWI0Uo0mEskpVN2/4ocZj2TotATPBzobuy3PcElxBE1kA/2EMROnlbe+ZY2nmiFzXr1e0jR3k4f/pYGhSb4MWwZHYgNZl1ACzs0KJWJy2TX7XcFZ3G42Z5pdMxthxucO25WK4OO7BXuyIETtvT2Nt0dtrud1bV57XXWeuEgYU+fkNsPEXydIE4GLCqHmIvEGjATImy80PPiFVBNdG/y4XG6M9vWjskQxDk/8UbPfLCKoJ9Qevl/y+BeGykNeDXeQlHpUPqT+7A9A14OSMMahrJ3X1Pw5jSaHyXcdMvXbbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=267YOxN2Wm7GNvx6xr9XaqFG1LoNY8ldKHA2Q4dXPbc=;
 b=j34nHWdPUdd10HogYvol6mU8qqNboER4Rr6ijsjJIqJqX7swo6RW8WoUxvWCdVG7byCZO+RsJcjk2qVJftfpFsTTFXxRfSaZka9Nm+QonM6aPctQO6P4+9De4lw84TrcubnzPYbb+nBWnpm2xOtFJN/phGREzN1kXArCeFJCytYk9CblsdUnie3E++PI3+zhEh4L42oLV49tgyRYC0W1+swSigygliGFJBycs8RTL5NceY4j1IM/PyDOzbvrS8kZHGt5JSGdP2xncq2Tsg4klYlzOHYXrS28EtGiAWMwSd56VvQ6LEb1OX0JsSZWXpckpswHdqlpCFkrGRiYYPOfXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10870.eurprd04.prod.outlook.com (2603:10a6:150:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 19:09:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 19:09:33 +0000
Date: Thu, 23 Jan 2025 14:09:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>, Hans Zhang <18255117159@163.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
Message-ID: <Z5KT5GZH4VEpz430@lizhi-Precision-Tower-5810>
References: <20250123095906.3578241-2-cassel@kernel.org>
 <Z5JmK3tAtNi2K2bO@lizhi-Precision-Tower-5810>
 <Z5KL2o0hREaVDiTC@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5KL2o0hREaVDiTC@ryzen>
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10870:EE_
X-MS-Office365-Filtering-Correlation-Id: 31289d69-c3a8-44fa-e912-08dd3be17833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLF3t9hONXG1i0Ki+nIwo4HACBwkzmttoJr7/jTIIe3vWzfvShiCrZsT2lDK?=
 =?us-ascii?Q?LwAJYJku9okmt3P/UQUNk1go6rpXmd8wDrqQndp7f2Hq1qmaOK5bxgSnG+m3?=
 =?us-ascii?Q?8j78KMDaOHW/2ZgD+Jn82ZUFccugMbXudKXfebRD+q/3f7Zp5y7iF7C7Gy9F?=
 =?us-ascii?Q?PYAURoYLnSY+vZjwZi891dbRXlN962AaPCGvULh5nlVhK0Kt3PFq504Yp2iS?=
 =?us-ascii?Q?9cq9YRiXNlTLPnxU+UDLbPFA+UXByPs/hTjmho/bLbeXag23U6gmogngXSnn?=
 =?us-ascii?Q?egQWqaiXrfzKGN80fPXzTP62emP1rrlYG9x+VYcc0YrhF7/I9et7+r2kpv74?=
 =?us-ascii?Q?e9kwyzh+GhKLkhT2fpK3IxDqHy86v4DEkkpoNpH22G0mmcSU+D7emggPU3WJ?=
 =?us-ascii?Q?4MVLnGzVUMZFbTWIPvI0bquHqJbZNO9lgLz3CCemcJ0nxv97e03R74t+Xi9Z?=
 =?us-ascii?Q?gc7kYHHniN+EJzmRS/AyQX5wL1+cdc/q9tfazqP+o+MtQZr0mUCCPjlHRQCc?=
 =?us-ascii?Q?jjnrX8BcvAIm93o+G9Rskyi7ff+q9/N1ql5ZIzdgTfoD6pQhG/4o30H4Gknn?=
 =?us-ascii?Q?3ZTcvkfQaJknBR43GrJnRvcJHHWErHltuKQ1Gn9zCXVRLawWXBxRf5tKG9Ra?=
 =?us-ascii?Q?i/pjljAdhNSH0bofkrit2DDGiIxg05vxaSB6SowNZliBRTu+a7Y6JFinZWT4?=
 =?us-ascii?Q?aXgs5RSYs4/SqEEU0Gr9CZD1eGzhHxWbHQyl1BwwzmjZMYEYcLSQlxsggBD9?=
 =?us-ascii?Q?lA/m8HWwXdkDxluqVwd01YuI8awcPqpcAnRonUKSliQWgd1/PjqxsPVNZkbi?=
 =?us-ascii?Q?QIs4CNY0ShhfPvai3b2W2waqJIhLLEVB5YMfCidlrYkufMUB6P0R9G8txh2L?=
 =?us-ascii?Q?vTFrbsD9ofaWvQs+y8bGoT6fLr1PCvUKFae6B9V+kNBD50EZE2DFTYqRkow/?=
 =?us-ascii?Q?bVS+BAUV4GcjKHN4zxw5gHlkX4MOzIRIs0NzeXINkE2dARBbBT/ldHOzuqex?=
 =?us-ascii?Q?VVWCwwZFeeUKu6Ely2btCVV9VTaobo66+g6s8ySJ7z4CTmu/HLUbL8NZ6LX5?=
 =?us-ascii?Q?szluBaKVrIXsVmpif4BzEM8sVzvkO3fCtJyUnoiKZfEFa4IkwR62+Z5sMNcp?=
 =?us-ascii?Q?10Pd5xlQ2KNrD7PQFc85L4BDfMqUBvVKZ09NiBsgzvJgnVjeY92oAoHxio+J?=
 =?us-ascii?Q?i/I/VtFCqodugDLfhsSc3evnkLpyht//heSRe7kyHq0RmOvQIt0XDmXadcbO?=
 =?us-ascii?Q?1mVz6t2hSIwb44zvBlgH9oGk1fUtAi3zQP0E9cOJT6wDdWftt1K/A6/fxMsx?=
 =?us-ascii?Q?jPCOLx0tMu37JRngvUp+R8008U8B7IkdHniqaaotCqC39vSkzyxB2VdD88z9?=
 =?us-ascii?Q?qHMTyuZlL9yU7PImSj9iHXTkNScEGqjfna/v1blXsFj4ctVLlrhu8ST/27zC?=
 =?us-ascii?Q?G3MlLizHjgFB5VlFezJSl9tQtHXJR0yZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xZtdzHYyONebbz0Ypn9VnBnmoff2cS/KGneU6ZLUSTdYQdLmP4NPAlEickbZ?=
 =?us-ascii?Q?Q7idpgTBtHWVgP305EIm1dxvHAJDDVxN+EEcfv/xGSHD12bxjFZ5KPr5J061?=
 =?us-ascii?Q?1R2T0Ib1k6nB04Y9jxKOjl5u8FbZqTlnrATTCDmfXaqPcuoRjyxjJZo6gNCq?=
 =?us-ascii?Q?csi5af/3WLAMMBw1+sKRAOWfyKABlYbsn4+sH0uLilXGH0awoY46MbcqEEer?=
 =?us-ascii?Q?x0tHsyvMOaGapiBf7Ex71rxsEFRZaV2uhvOLozUGxLFR9l3T2ccDcwi6Ux0u?=
 =?us-ascii?Q?KpmZnHWVeWi3Ts7jGb6fW3CwLuU8p5JlmKP49C4C2IYZzZXfhNHXC4C6IhYA?=
 =?us-ascii?Q?pmz4jvLu3EWCeD9nC4Y12J8SGfGUnOOITA7x5U9QTmaHoFod57ABZ6jC9zpn?=
 =?us-ascii?Q?C0n+A+4Iq1q30bA5wfyOuxahkjkQJHKfS2R+ze7Va5TXNJLRcmEyf5ald85C?=
 =?us-ascii?Q?OryGRlaHVwQ0Tyj4iXOwsSiem9xpYyZLnUOBnchD52/IuCjL/kYM0gbqGEgC?=
 =?us-ascii?Q?xo0uJ5aPWn+OGr+gFTDwJycphqlI2MEU4chN7zsxRJ4UQfml9wSvZRyFttwL?=
 =?us-ascii?Q?0HE+nrjYHJnoa41h4X0d3EBMnVF4Jr7SE8rvY3O2EmHEm+Ya91OgehN7iyrw?=
 =?us-ascii?Q?1u6+4suARcdcpQkjcqbT6lZnY0WyNiszhAXeUi4ttiv+tmlVCVOlToCaXYXc?=
 =?us-ascii?Q?6QRI4c+1xhkprtwPGCtev+K3y1NiD1DJ3SFu/0cchAdhuXIkjjsSH+SZExpK?=
 =?us-ascii?Q?qb1mE2ABbnh2hmINFyNwrFf0UMw6/jbLkhrfcpUQNolAZNl47AAN0nYLvjCm?=
 =?us-ascii?Q?bTBZdkHW7WCTQJS6plUqCKyBf/WkUMrLc637EZ6g1RmtoJxslIW/SUHIngS7?=
 =?us-ascii?Q?1yBwxADoQzPV8bsw1yxrRy4xg4n30+2fimt5ncepDEaGp55twqET/9F1r+LV?=
 =?us-ascii?Q?KIC436avc+/7TNFpVpz/hPuZGSBpEUA7y2hd71Ma2EqXviOJ6Gre+z3XIe94?=
 =?us-ascii?Q?lJR36nApduJcrxDZCcLuD+WSaiduxdW4pHOMKv9kWI0NikAPRx9y9ZgKPu5y?=
 =?us-ascii?Q?j3fV5XoSuG1OnCzQeQk+bVlD9BE74sw1sRJfGPl3eTt/73tkVMpQRxBLajMp?=
 =?us-ascii?Q?cDSPo4gK1PW1UntBPUs+NKRsN3OIS7+ntyhUmpw/MrGZ9BZEULvJrIlaGaao?=
 =?us-ascii?Q?ZRUlFr1cmZQUVKKmQKHredsmvcUkgCOHvoWdu/RPfTnfPOZFqevut6I5AxBG?=
 =?us-ascii?Q?OvQiiF8RFUlb3cXRr9nq6/Sqf/tk9WsdsweHlCFnjfjgOUV/zgEtuycQ9VrV?=
 =?us-ascii?Q?FUALWRGZ4YYD95HcIqYlHJzsIDZuqbG/u0921EAgwgaCkAlhORESX8n/rQ0+?=
 =?us-ascii?Q?7fWwnBI/D1FQrqjtsvahQ0C94oDsgwqdl1vDlT2tagEJCnJZTRkALx//HqSw?=
 =?us-ascii?Q?j2VAboz82RX2HpvnkDLA6M+qcxOtxsmCVYauX0qb/t/UU0YJ3TUc4yW3QBZq?=
 =?us-ascii?Q?DoQESFi3FV7ntV+XIamJSf83G8V3ZU7l/Q3Lwb7QmujhA7h1v6RFIZzhSf75?=
 =?us-ascii?Q?iKPbEaptv4m3nerYKZHrb+vY3ac5YQvT9UMp40In?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31289d69-c3a8-44fa-e912-08dd3be17833
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 19:09:32.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZNc/XMgVUiVbCSRPyZoNozqM8fXleBs8mlJ/ZjbKUwKUquQ4lTlN0/8ICgudVu9jx0fnIlbq4yyhqijB7+D8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10870

On Thu, Jan 23, 2025 at 07:35:06PM +0100, Niklas Cassel wrote:
> On Thu, Jan 23, 2025 at 10:54:19AM -0500, Frank Li wrote:
> > On Thu, Jan 23, 2025 at 10:59:07AM +0100, Niklas Cassel wrote:
> > > Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
> > > is e.g. 8 GB.
> > >
> > > The return value of the pci_resource_len() macro can be larger than that
> > > of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
> > > the bar_size of the integer type will overflow.
> > >
> > > Change bar_size from integer to resource_size_t to prevent integer
> > > overflow for large BAR sizes with 32-bit compilers.
> > >
> > > Co-developed-by: Hans Zhang <18255117159@163.com>
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > > Hans submitted a patch for this that was reverted because apparently some
> > > gcc-7 arm32 compiler doesn't like div_u64(). In order to avoid debugging
> > > gcc-7 arm32 compiler issues, simply replace the division with addition,
> > > which arguably makes the code simpler as well.
> > >
> > >  drivers/misc/pci_endpoint_test.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index d5ac71a49386..8e48a15100f1 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -272,9 +272,9 @@ static const u32 bar_test_pattern[] = {
> > >  };
> > >
> > >  static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > > -					enum pci_barno barno, int offset,
> > > -					void *write_buf, void *read_buf,
> > > -					int size)
> > > +					enum pci_barno barno,
> > > +					resource_size_t offset, void *write_buf,
> > > +					void *read_buf, int size)
> > >  {
> > >  	memset(write_buf, bar_test_pattern[barno], size);
> > >  	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> > > @@ -287,10 +287,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > >  static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
> > >  				  enum pci_barno barno)
> > >  {
> > > -	int j, bar_size, buf_size, iters;
> > > +	resource_size_t bar_size, offset = 0;
> > >  	void *write_buf __free(kfree) = NULL;
> > >  	void *read_buf __free(kfree) = NULL;
> > >  	struct pci_dev *pdev = test->pdev;
> > > +	int buf_size;
> > >
> > >  	if (!test->bar[barno])
> > >  		return -ENOMEM;
> > > @@ -314,11 +315,12 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
> > >  	if (!read_buf)
> > >  		return -ENOMEM;
> > >
> > > -	iters = bar_size / buf_size;
> > > -	for (j = 0; j < iters; j++)
> > > -		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> > > -						 write_buf, read_buf, buf_size))
> > > +	while (offset < bar_size) {
> > > +		if (pci_endpoint_test_bar_memcmp(test, barno, offset, write_buf,
> > > +						 read_buf, buf_size))
> > >  			return -EIO;
> > > +		offset += buf_size;
> > > +	}
> >
> > Actually, you change code logic although functionality is the same. I feel
> > like you should mention at commit message or use origial code by just
> > change variable type.
> >
> > #ifdef CONFIG_PHYS_ADDR_T_64BIT
> > typedef u64 phys_addr_t;
> > #else
> > typedef u32 phys_addr_t;
> > #endif
>
> Hello Frank,
>
> I personally think that is a horrible idea :)
>
> We do not want to introduce ifdefs in the middle of the code, unless
> in exceptional circumstances, like architecture specific optimized code.

You miss understand what my means. I copy it from type.h to indicate
resource_size_t is not 64bit at all platforms.

Frank
>
>
> Kind regards,
> Niklas

