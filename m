Return-Path: <linux-pci+bounces-4032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0925D867C8F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03FEB2B997
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7912CD80;
	Mon, 26 Feb 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hbaz9giU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675760BBB;
	Mon, 26 Feb 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966071; cv=fail; b=UGep9KDFX+3j+541ZM6Rhhst7k0oMA4ssqhUOm14OcFUtJzNdyCg1kn36T+GJs91/F7Hx1BQVOrIPpyoCvEPcqRFwEC36WmtetDzdp/Q/oTUhXnyGo1ZffJ+S/8CgLvDL5G1ldaCi2ATjG7UKIulRM6T/eq/SLDhGohnpvBAagk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966071; c=relaxed/simple;
	bh=23kjBBx7CBKV8nCj3Dj2CRrPXaxjROxzjAYe43192d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bq71bHG99f5+i9mI/5FOklS0ibUFMUWPlTFABJQPk1tJ5dFj5mcHUxhixenOKRCBhfDD00zHggl4s35BbzwEJL0TgTrZlpuB+jMK5mKPeZYmZOYI/fboPATbLoAdKHNXwvSx94l5uGW3UGf+PxRuID9z7YHLWk3yHoirD/scDPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hbaz9giU; arc=fail smtp.client-ip=40.107.6.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGFRycfiukb1OmvtmtZVCiX9auqL2RhRE9fhR0gztLHrPwq0b8e/6X7LtL3pV+eJ/Oj6OTfr+HynJmNSgHSft49tnPzotaw8Crr2fjmLvvLEzMkdJkb50t9fywYHMjUEvjilfL0ysrzyPIP/NlEH/kv6WzusL2NxNRpc3Pn9DFNJhmSxDmFZD30Dn+5xeUBR9yvB90uBZKJygZV8WphMhjETGHQPLcu5nFrtJbd2azTAmHp5TbeS9Vy64hppJW9GTnNnesUpwgaiCSQDUff7nRnqlc1wgLZ+j38WUiAw24z0OvBTCiWrb+3+tBkgjdJ3oy7nTgVBM0LCIhmg1VUmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UxhsnAw/ru5t4Lv5++VZ2xJHAq/SReysrgdu7apBAk=;
 b=d7LWCcQKoMk/7h9SmKm/0tc8QPO1HHfdMMllkGKKueC3u+lL8VgDNY3s6Pue6+n/39i3dy02MPPAuikUWbGIoaj5LVcsQgY45TOPtx6fHQPk7IJKjlR920AlBQW4iP7yLLwt4FApzndfCd3EBFIV2mIhHvZhpe5LdE1X3K8eXut1IQkY8FyBA3u1LTuMYZZEnmplj83i7HP1nkL3la9fDybM9/P0uvNVbpElo4RiHkpYZgsj+qz0mLduN0tXx7Uw4Ri6EPKzeM+T0atkqglIxuKVA0pH7AQjAu0T5EhsRi91ElqeW94HMnLPw9UMnr5OR5eB6Hb3UpfQ//uGM2y6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UxhsnAw/ru5t4Lv5++VZ2xJHAq/SReysrgdu7apBAk=;
 b=Hbaz9giU9By0zgmuV/lZfFmg/rEx4qBKVlazDAkOPkyEY3JjWn9H3l2XuKTTDUzl3BEn95JjCF8HIj9xUdAVlPL6mH8Sg9RaeKwO27gJWllXyQpkxeQQHwGMknpliRFR5Khkq3Hrp5tubzx9/grmygv3huOvfXBHxO+VIbdGxlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 16:47:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 16:47:45 +0000
Date: Mon, 26 Feb 2024 11:47:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for Block Passthrough Endpoint function
 driver
Message-ID: <ZdzAqUIIXHtVM+3x@lizhi-Precision-Tower-5810>
References: <20240224210409.112333-1-wafgo01@gmail.com>
 <20240225160926.GA58532@thinkpad>
 <20240225203917.GA4678@bhlegrsu.conti.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240225203917.GA4678@bhlegrsu.conti.de>
X-ClientProxiedBy: BYAPR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::44) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: bf120df1-a275-46eb-974e-08dc36eaa848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nnw1Z3XGRyRZD2KgXO8DILNpPcBq0epVmUlXOF9hhQs0Ptiy6c2ajVjRAf8v+gW1ehILinx1ZSoAnfHXelCkn3AWKKROCeeOYzXb8Mv+z17xv0sdxgkKREC2NKy+sH8BJtuFRPETiEuO1KiThUjomdPyEe8ao+FW7xMKXmZ6qS9QVmHpNlanS8mkpqJVu4A8hFZB9rWt0MXDGCiWIHY8X+xjdM5CkUcPuVgMJcMhgb2VvTeCDBWVgNvy7DkpeeR1ppnft+URt0Mobg10bcubNs+mhVAm/Dh8wsma6dYUG9sbalqtZPHnr1n1TaoMdo3o5H/7OTEsvfjfm5mW2wSO9J8yMFfFHj8TVTv5CQ55ulmRu2AipBo/jd/g/IV1q1zmxqQevK5PY+H1bpR28qegSdVJMMfPqvDbrTxib7nJMdy1P8ESYOzExaqz4NAXazcIJX4UTlwEcjg4Tk7jZNkxQ9biLynpSGzukHk88O/MZkyMN3M0R1/LzAvyIbo+EmH4mi/Eefcbhdk3TfWNXnU0z3AepJz/hRu56ch/ZXW1BSch7Ly6V0DvHEdZwDhwfY/NnuRSDaGT4pajoGySxEIvNlFvB6KbFCpgN7WKYD+kXNv6b9fxvMKZuj8QohwlEpJWkKSLT9DOoXQ3CzG/Ywz0Ka+M6I8ZPwaM4uZDkLFp2J+7cYNzc8iKdXirBqVsWxoFq0wPZjV4JSmux9uwIGNosw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K01zTGZpbWVJTERSSGsyVjNla2pWNm04eFJZR1hrTk8xWnNPbFNaNVJvbjlY?=
 =?utf-8?B?N3RrdWdiZk03eCsvbjFQWXNsMysyUmxpY0dha1hEQWlSa014UkxpNkJYRkhj?=
 =?utf-8?B?WndoZ21mdmhVc1lqdmtJdW1WWWdFVTNWWE13SzZGbWF3QUtyR0JKSm9WMzNF?=
 =?utf-8?B?T0dGRUl4R1ZCNCswZlQ4SVI5Z2IwUnliRUdNSXYwMjE2djRRUCtuUVlZTGVL?=
 =?utf-8?B?T0ZwNm11WE9iSHQ4ZGl0Ymx6N1RXbTlvbXFabEg4dVhPNSt4U0kzdWpZNStT?=
 =?utf-8?B?MlVqMm5yd3c3MEhFdko5eUxxZ3NOWUQrSkdaanNNSTZHUU5lQzNQempFaWZG?=
 =?utf-8?B?cWxUYzN4OEtzRGlWck9NVnd2c1R3djdRbjU2VGt0RmpnZXI0bWJNMlhSeEZk?=
 =?utf-8?B?VWxTUzV2cDZQL1VsNldqc0V4WFRUWTFvMGlNakw5Sjk3aTh5TWdoQjd4Sk9T?=
 =?utf-8?B?aXI4N1UzRXMxenFQK0ZFNDN6RFgvc1pVUHBvTndSenJuZUFIaW41VmVaL2dQ?=
 =?utf-8?B?Vms1L2ZCL1pEek9kL3dlbDZVR1psRFo5RUlWcnAzR0QyaUMxMm1vUnh2bXhO?=
 =?utf-8?B?cTRHOFl2RE9FWlpRM0VNSXBZdXo4S1AwRnRrenRReUl3MmJjbklmYkxkTktZ?=
 =?utf-8?B?dGVMNk9NMExESDZWN2dIOE1DaVZjTWxXMGVuNkZKTVRLM3RhOWZBZS8xQ09m?=
 =?utf-8?B?QWhsWEhVQzV5dFNwYi9Oa1lsdWNkRGtMVThUSG80L0NpRVloanBtbDVDWSsv?=
 =?utf-8?B?TkVZeW5pZ0hwUVd0WUM4VE9RaUJDQm1KMDVaZ0JvSWVMcmFwN2RsOUFkWDhw?=
 =?utf-8?B?cFV3aVAzMjRnTUg1WU10OTJHcUptb1FDNGtXRlIrVm9YS1IzMnFzSkRmOGdG?=
 =?utf-8?B?Y2RIVGViRXNIM3EyRUVYUGE5ejZ0a2xOZVFFcks0OUVWeTNSaHNXVEhpQWly?=
 =?utf-8?B?MURBVXcvbkY2SHpXekZHclZiV2lFekZnMk1ZcmMvQVlGUlV3TGdSakxHOXJC?=
 =?utf-8?B?NXprcGpqcVVVZzhyUmtNaVBEOUVOK2hXU3FWU2kvZmRILzRkSENIbzFpZHBV?=
 =?utf-8?B?WUdUektXblRTenpQRmgzZXZWSGdyQ2pTR1hBbWNnTUNBdWJPc1B0dnorMjVs?=
 =?utf-8?B?OENna3kvN1hHMWF6bHZXZGVLVW1aUW5KYjIzUUczdXRxblZ0a1pYVjYycWJD?=
 =?utf-8?B?MVJjaUVkZm81ZnA0a0tQWFZHZG5GcVhhQ1ovWmV5cTZ6K1J6a0RIc0RSUG95?=
 =?utf-8?B?Y2dtQ3hNMllzNUtwblFQSU9seUpEcUlrTERBREpsMFc1eWNZb2FMcWlZcjN2?=
 =?utf-8?B?M0NwRDkrc04yanNRT25uTmVhUVlHemtmTXVyZWxXR0hod1l6dWI2ODBKL2tW?=
 =?utf-8?B?ZjBDYzRWd1Eyb0d4VWdFRnRvOXFOVGl4MnVDR3J4Q3daUlQvdnRGVHFIb1p6?=
 =?utf-8?B?WmZTakxzWmtsTlQrck1DcmNuWlFMemIxQlBRSit3MG5mQUlKWEFPTkxrcnNh?=
 =?utf-8?B?WHp4Nk0vSTlYSXlaaUE2M3ZHRm9nd3F0b2pISktiamdXa0tJN1NSMVlYOXF1?=
 =?utf-8?B?S0I5V1ZCNERHQStoWTk0ZjBpWVRVVXNpY3EwR3JLNmVOQ0xTbzRrYlZzNm1Q?=
 =?utf-8?B?OTE1VEU2L2pVKzNCekhUL0hzQzRJUXlMYlpvcHVNbUJvSXFBODM2U0RIRXZE?=
 =?utf-8?B?MWNKZGJWUFNKVERXRHVEbFhNSm5SQ2NZWWluRUNGZ2lBNm8xM2JQTmlIYlZ4?=
 =?utf-8?B?cGtBOERiY212K3hneDc0ekVKalZzWk4zY1B2aFBtSDEyY2ZacFI1c0VJczF4?=
 =?utf-8?B?QmpRZGtIb2tZYjhoSzNWU1N0NjNXbWY0UjNoT214eGZWKzYzanFIVUhxZXBP?=
 =?utf-8?B?NjAvQmZ4dk1KM082Wmt6amxBeTRYd1d6bk9Bdk4yRWVoa1BNNGpGblVCcVVL?=
 =?utf-8?B?MUVnb3Zrek1hRFZsOFFnVEVKdHI1QTlJK29BbGFUckwzSVV1YmdDZ1BKWDJ3?=
 =?utf-8?B?dnpaaUJDNjFPQVpra1MvYjJRRWZJUG9Ram9qbWo2cklnWTY5Y2llMm5LaklU?=
 =?utf-8?B?WVA5ZlhnalhacElYMklpNXl3b1lRakVjWEJmNGFHRmpYN0lOakgySjVvdW93?=
 =?utf-8?Q?6n1ZtsIZEy/dXoGzf2DfGvcS1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf120df1-a275-46eb-974e-08dc36eaa848
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:47:45.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8QjGdDyfk3zhbbLWZtibus6pxh33y4/IRZXVp9N/Y8mmR461xGd71rCebRWFZ6oN0hg6IC5frdccNI2locr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

On Sun, Feb 25, 2024 at 09:39:17PM +0100, Wadim Mueller wrote:
> On Sun, Feb 25, 2024 at 09:39:26PM +0530, Manivannan Sadhasivam wrote:
> > On Sat, Feb 24, 2024 at 10:03:59PM +0100, Wadim Mueller wrote:
> > > Hello,
> > > 
> > > This series adds support for the Block Passthrough PCI(e) Endpoint functionality.
> > > PCI Block Device Passthrough allows one Linux Device running in EP mode to expose its Block devices to the PCI(e) host (RC). The device can export either the full disk or just certain partitions.
> > > Also an export in readonly mode is possible. This is useful if you want to share the same blockdevice between different SoCs, providing each SoC its own partition(s).
> > > 
> > > 
> > > Block Passthrough
> > > ==================
> > > The PCI Block Passthrough can be a useful feature if you have multiple SoCs in your system connected
> > > through a PCI(e) link, one running in RC mode, the other in EP mode.
> > > If the block devices are connected to one SoC (SoC2 in EP Mode from the diagramm below) and you want to access
> > > those from the other SoC (SoC1 in RC mode below), without having any direct connection to
> > > those block devices (e.g. if you want to share an NVMe between two SoCs). An simple example of such a configurationis is shown below:
> > > 
> > > 
> > >                                                            +-------------+
> > >                                                            |             |
> > >                                                            |   SD Card   |
> > >                                                            |             |
> > >                                                            +------^------+
> > >                                                                   |
> > >                                                                   |
> > >     +--------------------------+                +-----------------v----------------+
> > >     |                          |      PCI(e)    |                                  |
> > >     |         SoC1 (RC)        |<-------------->|            SoC2 (EP)             |
> > >     | (CONFIG_PCI_REMOTE_DISK) |                |(CONFIG_PCI_EPF_BLOCK_PASSTHROUGH)|
> > >     |                          |                |                                  |
> > >     +--------------------------+                +-----------------^----------------+
> > >                                                                   |
> > >                                                                   |
> > >                                                            +------v------+
> > >                                                            |             |
> > >                                                            |    NVMe     |
> > >                                                            |             |
> > >                                                            +-------------+
> > > 
> > > 
> > > This is to a certain extent a similar functionality which NBD exposes over Network, but on the PCI(e) bus utilizing the EPC/EPF Kernel Framework.
> > > 
> > > The Endpoint Function driver creates parallel Queues which run on seperate CPU Cores using percpu structures. The number of parallel queues is limited
> > > by the number of CPUs on the EP device. The actual number of queues is configurable (as all other features of the driver) through CONFIGFS.
> > > 
> > > A documentation about the functional description as well as a user guide showing how both drivers can be configured is part of this series.
> > > 
> > > Test setup
> > > ==========
> > > 
> > > This series has been tested on an NXP S32G2 SoC running in Endpoint mode with a direct connection to an ARM64 host machine.
> > > 
> > > A performance measurement on the described setup shows good performance metrics. The S32G2 SoC has a 2xGen3 link which has a maximum Bandwidth of ~2GiB/s.
> > > With the explained setup a Read Datarate of 1.3GiB/s (with DMA ... without DMA the speed saturated at ~200MiB/s) was achieved using an 512GiB Kingston NVMe
> > > when accessing the NVMe from the ARM64 (SoC1) Host. The local Read Datarate accessing the NVMe dirctly from the S32G2 (SoC2) was around 1.5GiB.
> > > 
> > > The measurement was done through the FIO tool [1] with 4kiB Blocks.
> > > 
> > > [1] https://linux.die.net/man/1/fio
> > > 
> > 
> > Thanks for the proposal! We are planning to add virtio function support to
> > endpoint subsystem to cover usecases like this. I think your usecase can be
> > satisfied using vitio-blk. Maybe you can add the virtio-blk endpoint function
> > support once we have the infra in place. Thoughts?
> > 
> > - Mani
> >
> 
> Hi Mani,
> I initially had the plan to implement the virtio-blk as an endpoint
> function driver instead of a self baked driver. 
> 
> This for sure is more elegant as we could reuse the
> virtio-blk pci driver instead of implementing a new one (as I did) 
> 
> But I initially had some concerns about the feasibility, especially
> that the virtio-blk pci driver is expecting immediate responses to some
> register writes which I would not be able to satisfy, simply because we
> do not have any kind of interrupt/event which would be triggered on the
> EP side when the RC is accessing some BAR Registers (at least there is
> no machanism I know of). As virtio is made mainly for Hypervisor <->

A possible solution is use ITS MSI to triggger at irq at EP side.
https://lore.kernel.org/linux-pci/20230911220920.1817033-1-Frank.Li@nxp.com/
Any ways, virtio layer need some modify. 

> Guest communication I was afraid that a Hypersisor is able to Trap every
> Register access from the Guest and act accordingly, which I would not be
> able to do. I hope this make sense to you.
> 
> But to make a long story short, yes I agree with you that virtio-blk
> would satisfy my usecase, and I generally think it would be a better
> solution, I just did not know that you are working on some
> infrastructure for that. And yes I would like to implement the endpoint
> function driver for virtio-blk. Is there already an development tree you
> use to work on the infrastructre I could have a look at?

There are many one try this
https://patchew.org/linux/20230427104428.862643-1-mie@igel.co.jp/
https://lore.kernel.org/linux-pci/796eb893-f7e2-846c-e75f-9a5774089b8e@igel.co.jp/
https://lore.kernel.org/imx/d098a631-9930-26d3-48f3-8f95386c8e50@ti.com/T/#t
https://lore.kernel.org/linux-pci/20200702082143.25259-1-kishon@ti.com/

With EDMA support and ITS MSI, it should be possible now.

Frank

> 
> - Wadim
> 
> 
> 
> > > Wadim Mueller (3):
> > >   PCI: Add PCI Endpoint function driver for Block-device passthrough
> > >   PCI: Add PCI driver for a PCI EP remote Blockdevice
> > >   Documentation: PCI: Add documentation for the PCI Block Passthrough
> > > 
> > >  .../function/binding/pci-block-passthru.rst   |   24 +
> > >  Documentation/PCI/endpoint/index.rst          |    3 +
> > >  .../pci-endpoint-block-passthru-function.rst  |  331 ++++
> > >  .../pci-endpoint-block-passthru-howto.rst     |  158 ++
> > >  MAINTAINERS                                   |    8 +
> > >  drivers/block/Kconfig                         |   14 +
> > >  drivers/block/Makefile                        |    1 +
> > >  drivers/block/pci-remote-disk.c               | 1047 +++++++++++++
> > >  drivers/pci/endpoint/functions/Kconfig        |   12 +
> > >  drivers/pci/endpoint/functions/Makefile       |    1 +
> > >  .../functions/pci-epf-block-passthru.c        | 1393 +++++++++++++++++
> > >  include/linux/pci-epf-block-passthru.h        |   77 +
> > >  12 files changed, 3069 insertions(+)
> > >  create mode 100644 Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst
> > >  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst
> > >  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst
> > >  create mode 100644 drivers/block/pci-remote-disk.c
> > >  create mode 100644 drivers/pci/endpoint/functions/pci-epf-block-passthru.c
> > >  create mode 100644 include/linux/pci-epf-block-passthru.h
> > > 
> > > -- 
> > > 2.25.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

