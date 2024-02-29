Return-Path: <linux-pci+bounces-4279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9E986D3FB
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 21:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D042878D7
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F3313C9FE;
	Thu, 29 Feb 2024 20:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TX2znE0Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFA7E76F;
	Thu, 29 Feb 2024 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237637; cv=fail; b=t7IVVkKKwWNKmNIlzKDJKwfJv+pHk6cp0Y2YJwdBCdH5JnR5P6wpyED0yaT6XT9AinCccNMNldx5Ztq3Y/Yi8RnOvJ2ABc9cBW0oQMNfrxfYtv0dLyg2KjDKcCNMW5Qb+0mZajj3PQU+BN5TVF56GWEbU/p6XEWWwkigKUGZPr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237637; c=relaxed/simple;
	bh=lS3KtFBV/Jqp4y0yqdIiY1U0qh8ZY9L9cLHIwSR+9ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XfO17UxDe28oVdHb/4vcmagyRUnMJFnVXj/zFcauZ8LP78ygHsf6Kt8TvIOtb8FJNt13HhCnf6qX4ssO0NxoCRfTV/+OqpzfFrgoHXIkbo6d5F8h471uMu0eQqeLoebFtrY0hGln7LDXG8UJ5WR6xmEK4j6e+BB3kAHHmNa/vys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TX2znE0Y; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6iQLLQlUYZkia4xz7NTdvUmsGfOdH/VCS2Gr5/Vqizn/7SnzsD5kx0HhugN2B7kBxAdAGzoQ2KehHOVijbN+aE5NSNfkCOksEQk9J+IQqKaOh/IBBGRaWLOkqbW/ecvEyAUbX24badX5rkEmxYKOvNjmIYP6Ulr4xs/OyQeDhONrfZc1VUakBRu04D/ttzTeNopYYRMVIKQznSroNh5bAnG88zeRYAQnbDgB9gX8nBQSsaybyoN6AyZhRQp8pXv99vAIux1jkhQ4jTJQde7C845ZvwblGNujzWdHpswu8GwZxXfHA9Ov24dqDcTMxRYfMGePhUWhvvbvKeSqCxeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dh8PUCeGK1YmsYbJmDDpQebglUlkdluMVbc8IfJE8vk=;
 b=lBpnINow7ItDRn/xTPeSlmMgj51xrMpslfTynF6GOjqLjsEah1IU3wnfsNhElO70ZpghchSH6wNw0RzqvBYfI7ZxdclLbu0rTvZHM99mQXM142Pgc6TREm3eyYjqDQmVxTCFNNsdl9IQHgq3QkfjbducoBQmnfLh9HKB0csjw9wrWr/VgTb3sOF6EL14PVBFKTVbiCFNzNrocfbJjnqBn/gGIV3rNMARSktz1xVIOAxwxLldS1TyWn3CbduK58r31yJxHkqf0qApB9tvnue/eFycyU5P5TLWCyfS0UsbfzHGt9cMThp862LItBasWj04a0U6jpGNTVy+q0tioRPHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dh8PUCeGK1YmsYbJmDDpQebglUlkdluMVbc8IfJE8vk=;
 b=TX2znE0Y55YnojFvbXcJEF+2HU0o9R07WXSXgeIyfI1CZfSUx5vNbvPyreCNSDMarjKrpXNZyt10Vz8Vo3RVE60TOuz8foPcasrXH+yuDGXMU7XAPXI5WSJ4JM/VrpH6axNpExoQaN72+wSJMD4KAA05t74rp7wQGlxDDhA/5rI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 20:13:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 20:13:52 +0000
Date: Thu, 29 Feb 2024 15:13:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	"open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Message-ID: <ZeDleC7dlImhNGO+@lizhi-Precision-Tower-5810>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <ZZ1Pj3MvhQNMnP8M@x1-carbon>
 <ZbFEafUmqmE0nrPx@lizhi-Precision-Tower-5810>
 <20240130062938.GB32821@thinkpad>
 <ZeBygq5FngE2vlL-@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBygq5FngE2vlL-@fedora>
X-ClientProxiedBy: BYAPR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bea1f7-8544-4ba3-c382-08dc3962f2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d5z6785ZCTWaWxTANkI718yUFshsk6Z1etHWF4YLlDPPA/goJQSZ/73exDzGG3RPegpPWPSLIvzOk4VqX88pqK+rr9E4rNiwS47MNFdEhbulfLxMVZvLhKWJkLNr3DlstyLI/fEXWbZJ/PnMpoSIJfyjkG1lWEbN14eH8tXNjot7zRgsvhfxNW04jZf1vLC3Q7w4Hmj/StfOO2MHJkrcocJ1DjytQLDv3PIwLk+bMhjZYw+lybqpUkNUmLu9xlpB02QVdRjejNj5EQ2jyHX0nbuRMo7OryKMykaZo4AmzvvJM7xSPkkM+b3FzYL8bRx6vT0/gL5775juoO6IJIwrtwvqNtlH7dV2+ckUmqAjCFvSVrMEeuKpiUnBbP1lXKNgu07d+OjAKRB29OsGQmagId0CoGdeAu8Szcol+8c+RTO+qbZ251pmrNYFPQHgDrGPpEQSX5BuU+Xa65XsyP8sau1HnYZCFEGxDp+6A4V5T+o+g2jsncamxe0Xu2M30ms5ME84Ou5k9R16ldFvUayQUD3aRst7MVzWWoTifhQWeSgMIOyikiKTJG+35NNy/i7lyu0CgA29JVqH7QlTwKvrqW+HnHnfdaHm5aF1uZRICMTdaiae/SgMqQkKnXHMLXRFKpYW70vPeHnN/eJHSSXr8GmQA2KrhNZvZTEg+S1IyXc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYYZS84hM/Ckk6hv5JOVsb7wHB+K0eG4LoEAcE2nIHt2PmHJrvfpHIrfMxz5?=
 =?us-ascii?Q?mYI5DBGuEjMxKzn4jucYaWTfphkV5m+sIcPPp1NPoMViIDG7fwMSS9iCrhp5?=
 =?us-ascii?Q?oi9OaRNRFLA8xQ1g7bZ9zYfZ9BCTtPOcZwB9vxQey3EBCKor6GpfAWFame+I?=
 =?us-ascii?Q?Lnv/R1C94hYpRWvFMlj27GAAC1C3SyZ8sNcucf1j0sg2C0pgkV4S4DAZA9hz?=
 =?us-ascii?Q?2N2vz91DIPqBDgKie0yjWeyBZwtlX/R7t5XzYtLgFuKx6kyzB6qTV7fSmHTB?=
 =?us-ascii?Q?uA9U9HogrGuG/pPPQi6qMibWqPzxFsO14Ec1mDfhlCjHjA3hiNjuu+O6S/wM?=
 =?us-ascii?Q?P5V3e1YFHy46r0YIS9fU3TfTFA5nQb3boQaCCW0J9GPWgbmYS44tP6FVoYfY?=
 =?us-ascii?Q?w3AoA05Uvsq9gh/OiS5nYscz58WEA24VVs8uZkD87hqAqejFYH/QfKQDJbXi?=
 =?us-ascii?Q?vn2c3a56t3N9OwKdJ2TROqrxSHcsWX/OXmkIODixazTjuEjfENt3dyiWpBBl?=
 =?us-ascii?Q?U2iQDwIgjoMNdCe/HbvPFgO9sr3yZOFmcTqmcUHeogvMvgprjQ98Y9bXx74P?=
 =?us-ascii?Q?+GktfNAfrArPOwH8RWCgDaSfaS0XHbttvFtDoprukVE52O8x4EekV+Y2E0jq?=
 =?us-ascii?Q?aVLBqdn5EC0QAP6NjdoayjJrbsjFOKaXGKevmJlVrFA9rRVA9p04AgnaHlYP?=
 =?us-ascii?Q?cg4P32Z6crvdPbRUc1uj02wTQldnuy5MOkV+AgeAcanIWwJO5eO3vFlBT8lr?=
 =?us-ascii?Q?8/kBG6sN71+eYDDZsMdAdY2NEGgPFMf+szXixKwzfrIULQBZwFrZiCp/DL4V?=
 =?us-ascii?Q?kLe8Xr2QQ5R14BtxYwKdjybkIKr0rvN7SSYebfEbqQF1Qnc8CYnnXrC53zR/?=
 =?us-ascii?Q?AXixyg4j1JmLpwJ14aHJVrZNhpJgZJ7xZ/8sdu1c/UAspQ1+zuPYmAQ3FORl?=
 =?us-ascii?Q?AyePwrF0EZnDl3ChsWEiFZxGk0GPm/v31jNhd+iZxLZNGnPn1EUu2mnrv+bc?=
 =?us-ascii?Q?+g3WWlnIIkLUI5pVWUdFH8kXzm9zjmDKiIrAjaVl+j6HADHMQ72DvWaQQ0nP?=
 =?us-ascii?Q?ffxKZxCZGEXMi6M3ErDxib5RQTdiWPMTuWX320RKtC5jIiUFYiQXPM8Xlcg8?=
 =?us-ascii?Q?lKlsrhqSoZrrEfLJNb81EdY6t//A5cwbilYH2i8UXc3Bda0o3tfaXRBOGTeM?=
 =?us-ascii?Q?9/5ocEQxm1szJ55rOKdE92lRX+0pdgFRPBC4AdKW10vD3ZyOQmqM0Jhls4YD?=
 =?us-ascii?Q?+iA1bXRzDzZLCvRpGUexVo3vI8jmawuhMQCXYYFiF32k2kYm9owDkT9U/GNt?=
 =?us-ascii?Q?J9JHS2CsLXgIAUdSMJP/HblPnVY0HRhRoFuBXDQBulVo1O59xRla9ZKvscgS?=
 =?us-ascii?Q?aNva+0pDzR8pSTjQoqtl1F+50G8vjB+KNeoQWykUoB++XBWwPeVMMQSv18KF?=
 =?us-ascii?Q?+Nk8eEXmuHOfwbxZSeEWcSRs66nXUv0MOry1kCMl3Gb1cwhCCuxBvXn51kQN?=
 =?us-ascii?Q?PLXUxgGFqDk2NFlj048tsP5DjopXwS6D2/z+NUYkHDd/b6Kmi8LOmSZXjie5?=
 =?us-ascii?Q?M1/ynzr1L13uHb389MlWyJfVAKaivtUimZCPQHXk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bea1f7-8544-4ba3-c382-08dc3962f2ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:13:52.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjNfthPInvZbvQkEI35TBkDziniZuYzMq37wzb1jC2O8Fm7/+TxvemK7X2HphW6oBbQcva2dbThF2z1DHgLEJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401

On Thu, Feb 29, 2024 at 01:03:14PM +0100, Niklas Cassel wrote:
> On Tue, Jan 30, 2024 at 11:59:38AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jan 24, 2024 at 12:10:01PM -0500, Frank Li wrote:
> > > On Tue, Jan 09, 2024 at 01:52:15PM +0000, Niklas Cassel wrote:
> > > > Hello Frank,
> > > > 
> > > > On Tue, Dec 19, 2023 at 03:38:33PM +0100, Niklas Cassel wrote:
> > > > > On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> > > > > > On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > > > > > > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > > > > > > dw_pcie_ep_inbound_atu()
> > > > > > > > {
> > > > > > > > 	...
> > > > > > > > 	if (!ep->bar_to_atu[bar])
> > > > > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > > > > 	else
> > > > > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > > > > 	...
> > > > > > > > }
> > > > > > > > 
> > > > > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > > > > 
> > > > > > > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
> > > > > > > > not allocate atu to the bar.
> > > > > > > > 
> > > > > > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > > > > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > > > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > ---
> > > > > > > > 
> > > > > > > > Notes:
> > > > > > > >     @Niklas:
> > > > > > > >     	I have not test your case. I should be equal to previous's fix in
> > > > > > > >     mail list.
> > > > > > > 
> > > > > > > Hello Frank,
> > > > > > > 
> > > > > > > Thank you for sending a proper fix for this!
> > > > > > > 
> > > > > > > Personally, I slightly prefer your fix that saves the iatu index + 1, and
> > > > > > > keeps 0 to mean unused. That way, you don't need the memset, and you don't
> > > > > > > need to change the type to signed, but either way is fine by me, so:
> > > > > > 
> > > > > > index + 1 don't match hardware iATU index. It will be confused because
> > > > > > other parts is 0 based.
> > > > > > 
> > > > > > So I choose "-1" as free iATU.
> > > > > 
> > > > > A s8 can hold a max value of 127.
> > > > > CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.
> > > > > 
> > > > > Since the DWC code can be synthesized with 256 iATUs,
> > > > > your code will not work on systems with 128 or more iATUs.
> > > > > 
> > > > > If we continue to use a u8, and offset the saved value by one,
> > > > > we will at least be able to support 255-1 == 254 iATUs.
> > > > 
> > > > Do you plan to send out a v2?
> > > 
> > > @mani:
> > > 	Do you have any comments about this fixes except u8's problem?
> > 
> > IMO, the core issue lies in the EPF driver. It calls set_bar() during init, but
> > it is not clearing the BARs with clear_bar() during LINK_DOWN.
> > 
> > If the BARs were cleared properly, then we would not see this issue.
> > 
> > I'm planning to do a cleanup of the behavior of EPF with core_init_notifier and
> > it should get addressed there.
> 
> Hello Mani, Frank,
> 
> Please reconsider respinning this.
> 
> I think that the invalid usage of find_first_zero_bit() is very bad,
> because other people might copy the find_first_zero_bit() usage here.
> 
> 
> find_first_zero_bit() can (and will) return 0, so this check is just bad:
> 
> if (!ep->bar_to_atu[bar])
>         free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> 
> ...
> 
> ep->bar_to_atu[bar] = free_win;
> set_bit(free_win, ep->ib_window_map);
> 
> 
> 
> No matter which code Mani adds that cleans up the BARs, will not change that
> the logic is this function is just broken.

Hello Mani:
	if you agree this fix, I can respin this patch by fix s8 problem.

Frank

> 
> 
> Kind regards,
> Niklas

