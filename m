Return-Path: <linux-pci+bounces-262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A70C7FE656
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 02:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD432B20D6D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 01:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D94A4CB41;
	Thu, 30 Nov 2023 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TP0cnFmb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2092.outbound.protection.outlook.com [40.107.93.92])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE3A0;
	Wed, 29 Nov 2023 17:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0cLrjvg6jHGDQmr+Gy9tN+F7Uealgx+1s+6x4BxTySaviqJXxfAGnY5E8Ffx1EwGV1A8M7zF9NiVex4P5Uc0Vv5boiOxdStq1VMoU2XRg6lJhokWxCgGvjex0+A8aEBlCX5d6zNQtUS05WU3fnPkTWvRd/i3mN+p6akbRLYdAh0ncCr0GOePmX7M+mdwI4ZlsV9N3noET7tXURYrxNqQ/Izaz10DB4WjgGf7CII9vsFztjZosNXlyD/pOjuIB3WGeOHLW7mGmg9We8p5NY7HRwgjqx39sZOEw8r/A+9xEvseDYo6DtXVH0gYkKaH5eLcKp2BtDtTrfeBl/TYwo1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/ArqhTU/4bF20cmjnsW+snQl0D/0aXlMPj7mEmB5ks=;
 b=aHLS8MhTZYxcMLafpsrkjJEPKWgN7RBf+5JC6SkHPDlsHnl/6q6aFMOxklNt6e0wNHf4hQwQiP5EQkhebxbDvHisyd8kDWrDlxCwkVz1F5UjUJox5zn4MqGhdtvbYDyV4IZTZaNWAvVvHRt+tPdyDk+M5ilXPZYN2hq727XkNEh7PGcfhLkLst/5qJ83inLdo5wLn6kHpxrr7y9lsqCX7Hzy+wF/+aScEooc3r1PiCfJL9EgIPikUge/VGsMWxtndLkjrn/Ldk4enna2v4tIOx5h6Odc1NQ4r6wnFFW3+vwhMzXRFicFJzazkn6+OYih3HEtqXZXIuynJeD6OywD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/ArqhTU/4bF20cmjnsW+snQl0D/0aXlMPj7mEmB5ks=;
 b=TP0cnFmb06GPfqN5QvnP5UVOP1IIUtY3PNSFfIBsNyjOaiRUkN5MycHXRP686EY5eQJ+KzeGjm9vf728ln+1TxElq4dMIXXAjk6jpEo9OALHdD5i5thKzHO0Mt3m0ZnIectlV3h9yg6kktARCnEIMK3VIGXVzLDiWDBS2mJ625c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BL3PR01MB7179.prod.exchangelabs.com (2603:10b6:208:346::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.23; Thu, 30 Nov 2023 01:43:31 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 01:43:31 +0000
Date: Wed, 29 Nov 2023 17:43:15 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com, 
    helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org, 
    Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com, 
    robin.murphy@arm.com, chengyou@linux.alibaba.com, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-pci@vger.kernel.org, rdunlap@infradead.org, mark.rutland@arm.com, 
    zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v11 4/5] drivers/perf: add DesignWare PCIe PMU driver
In-Reply-To: <20231121013400.18367-5-xueshuai@linux.alibaba.com>
Message-ID: <aaf365bf-ada5-a52-c35-d7dd2d598b49@os.amperecomputing.com>
References: <20231121013400.18367-1-xueshuai@linux.alibaba.com> <20231121013400.18367-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:610:e4::13) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BL3PR01MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e137b57-2f9e-4fb5-6f2c-08dbf145c182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I5ucRTcvBBtHs/JrQwuGuXs2OvxJWsuIqHwlTdBOyGz6msM3+4pjHY9dyLRkHVnEY3Lpng9hjpO1PhiibcRjvJVE4aI9vZQQKQvr2R/78M5OyEhRvTZoqEi9sx3WJBRuhAo4Tk+pdvUBLEstZTI+HYvaRCAD0K7G3oJ7oU4AoOReCNCJenUsUTXhlXxSNA8SbHjcDKVQHHyljUGq1jVgOd8aze9dq6r+OVkCVhN3G/n0o8/dd/R6ieKcI40jUzgtyNiquCETMUskr7PLye6KbOdyLSLHDE4OZsg7KtMNpMuHLFrdfLM7n6Ujeb5PqS34Fd2t2TslET5MK8XDXf5+AUatJHETIlQjXK82M8NJzN2+mRz9xQsSSGwoBP3Vhz8fW5Z6ETcL7XCXQs5f2TxSHxKhIW5g8Q81wWtsZZEibS1Rd/QLp6q+pXZen51VDmL0e5+TJV2IBbGsK4eMkXGucgWfgv9t7h+Rsuzw2oDl56EPoG1lLkNg60tf8ZZdmxW2GApFX1x6j9Tok7d5/cd994nGKdALVcGPAjbX0d+00qG/Q8zhcTHVRRghtGQU9RjkvYl8iWYXhYDiWudmRhQoLLk/UdwVCqSYc1SITCycfUOntJgYy6rsY5FIcemVBYsB0lCi7NftzgZriWLOuXZOmxrUR8uQdkk6pUvQ7mvMnho=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(366004)(376002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(202311291699003)(83380400001)(5660300002)(2906002)(86362001)(4326008)(8676002)(8936002)(66556008)(316002)(6916009)(66476007)(66946007)(6486002)(478600001)(52116002)(6666004)(6506007)(19627235002)(41300700001)(7416002)(6512007)(38350700005)(26005)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ugnLTXI03PJ22oKRtsObFlQ1aD2s/60NgRXwAc2pcZCzWnyfFTJ3M6VWoH2b?=
 =?us-ascii?Q?SeLNMS13qqPznFwONAfQVFACBNgZv13VcmUqT6KT7++U8oXDtM3UMI09aAwo?=
 =?us-ascii?Q?nZjcyLGMiVhE7lENtBCKPYwCO9iWEPSy7K12NeN64D+AMXeG/lo5d039AD9D?=
 =?us-ascii?Q?5ZVnILwToLa113KUsKJsvKNoCyQq26YDSwd8XDUpP1kpBOgaXjjOrLchng3P?=
 =?us-ascii?Q?HxbQWwO8tdG82vJlB4T0EkkePMhLb8rd10KO2aKdccO/7w+1Ktj7piRgq0be?=
 =?us-ascii?Q?3KOBufCb8bSUN9jqZXI+xDVN5wzNIpGc/BPqvAyQHqcDkq5gVt311zi8LfZY?=
 =?us-ascii?Q?8LR4H1QLJj/X1BaOIyaQUSjmc2LhftdnCQdB35Ia6cPRf0ANOkBQ6+cs9jHF?=
 =?us-ascii?Q?cMslca6YTg8n1rOJJ3WYp2CLpTWCcX0zOXHZ6KRhWmbKVf6OpC+l6nwXZQ5N?=
 =?us-ascii?Q?7qzxV9mlI02Z1MfQ10qCZMsxhuDrOEdlj+/9y6CUcJbDUcC39LetdwqsOWLW?=
 =?us-ascii?Q?Yz2V80eln6CvlMnmKL+6kymQsBOG0Ybz2w8b5bXpYTyia4vlz8ttx3XdDUsG?=
 =?us-ascii?Q?IxeF7/17KV3vFowF8q1Mk4A+LSW79aZoU7pjJOuoe38sfmbnLyCtvtKbEQkX?=
 =?us-ascii?Q?9cDrUpXSecIqe73BA1Tju7bL80NXX3l3VNEvMSPkBjDOqFPq8rJvxh3zA4ak?=
 =?us-ascii?Q?jeqg2SK/yKBubMptsK4uAaVTdmGM2X6aZ0VujG5Z75tzlidm5mb4hulXVmC5?=
 =?us-ascii?Q?yFcjonbKyaT8/tazYiukbZlkpJ1yrHdcFi0ZveJ3LHunDYVujXOkUId1DoyM?=
 =?us-ascii?Q?Q2PpRdWlzn3jpGcwVu620AkvXB5aw9h5mAlFUQghFPbNaVUR46edRRRWK3wP?=
 =?us-ascii?Q?6sLuiGXPDp1/ABOmOle2m3T4tMlj5HXI0+7BryVUFkFeRmmqkgsehj62PDHp?=
 =?us-ascii?Q?uDD3PjIj/kQAfN5iSBG+ZEAhoKYasLNEnj3fssAQgNmnrR1GMiCay6OHxSsX?=
 =?us-ascii?Q?bs0oKSSmvXjb6/FdQqsD+ir1e5+RMk3MBMsfHbhYQ+nL4EiDDHqW8qd1Damd?=
 =?us-ascii?Q?U/1al4FyvKoUGqJHV2BlOcYpqSuJL1Knj7wLYoa6IepYgw1DxxoLyAbb6yiQ?=
 =?us-ascii?Q?bjT9eRUJNUCxY+qIWek9jjP12xpPknF7GyzLosUtHzneGm73dlYHxdoVCJhb?=
 =?us-ascii?Q?1rtmt0o3fY0DpCFygfIITrFqjut80RbzVd1Qp9Ao76V+nq5rRjIg9RJ3YSEQ?=
 =?us-ascii?Q?urtMn0kQP1UyAwU6wOhz1kZIQtc6JJ6M2wnW2VtdaxzanbBS5XBZttxrjOWu?=
 =?us-ascii?Q?62b5KylbgbLONeCuxhbJJOW1mFzH2ulLeqX+kOL6naEgfOkyrlQ0gdBQeonr?=
 =?us-ascii?Q?TNEDj9AiLGct/1pdo/CswSrWXuutpqNr5YFBTiISnlFLk39xmPyBNZqu95pQ?=
 =?us-ascii?Q?dNeXRsoS2akU1E764Gre9n95CkH12K41LvnDlsYOhaQJJf/GDofs/fcxAM05?=
 =?us-ascii?Q?alpwCfu1OCcMEWdQ6rhv/bDFt4cHexjvQUSCYzvVnBaN7LrLCFR/YLtkFTfG?=
 =?us-ascii?Q?7r3TObUape5KTp67OhoAmNQsvfKS7wBmkAtSVN5SrONbZGaLxqZWUoLb1/W8?=
 =?us-ascii?Q?0AHZE0UYtXCFKIMx/CShRGs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e137b57-2f9e-4fb5-6f2c-08dbf145c182
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:43:31.0137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmE09Af18vNgfnDFusU0j+wMeSj3/Z4No+3f8TrlMEVUnLTfWpoaSJfiIxI68/80l1Kr4rp3ZxA6Ht8zRyIkDGQRgCupxGZUYlNSoQEvkFx7jMxZOf/2rd2Lwl/zSToA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7179


On Tue, 21 Nov 2023, Shuai Xue wrote:
> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is a PCIe
> configuration space register block provided by each PCIe Root Port in a
> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
> injection, and Statistics).
>
> To facilitate collection of statistics the controller provides the
> following two features for each Root Port:
>
> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>  time spent in each low-power LTSSM state) and
> - one 32-bit counter for Event Counting (error and non-error events for
>  a specified lane)
>
> Note: There is no interrupt for counter overflow.
>
> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
> named based the BDF of Root Port. For example,
>
>    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>
> the PMU device name for this Root Port is dwc_rootport_3018.
>
> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>
>    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>
> average RX bandwidth can be calculated like this:
>
>    PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Looks good to me and seems to work fine. Thus,

   Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


You can keep my "Tested-by: ..." in the other patches.

Cheers, Ilkka

