Return-Path: <linux-pci+bounces-4453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A2A87077A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 17:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9911F21DA7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84EC364CB;
	Mon,  4 Mar 2024 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gyB9mNoQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0C45BF6;
	Mon,  4 Mar 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570869; cv=fail; b=kq4a+GXO6ybbiW35g08f0yxDYo++W3+3eYy1ppk7P0aXnt6VaiJ/nCtZ/r32xy5SY/VaBf+xinkZc/cmOzB2yFT0sobGbHy6m45ziX5r88VIiyRYC192lO9acZsnn/bd+6IJwQKi5sWbSxU/PGpmITWc0fXhTsltCp5TMis0FTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570869; c=relaxed/simple;
	bh=mIL2WSe5kuBcpjskhi6jaCvIYCfNZI8D1GAllHYvieU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qo5YVZACxhvuApRINvlxMKJX1rZqWqiMoVX/CsAhTK/zDNy6ZMtEhB1WUC8ULuIpkGE8a3LmWF4mgCBfgYETAXdgmWi6Qiqw2us+j3H3+q/hpT0Ok6/oI3HYzpau6LshzZijSC+TIAKnG8RrsZ93RPDNDJPnZHCCa2uZCBLuK4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gyB9mNoQ; arc=fail smtp.client-ip=40.107.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5iIykjCFuJ6oBNCQlVvkPhqdlQUpJFebHoFJu9HM8c/i1dsQhhRiNlza2/i4gQb48WeCb06/q0e30hZ/U1v2RGEWFSOUd/86xgoTU+DtNGw42cLLZzz+Jsq+QePwnqT6o5Z102IsdiQ0ax1tMIkfS4zJq/3d3wsydlRWJyrfrWzFQgHXrSJRtF2vomQpAJYv89Z/qPINuZB64iocYtxpy1S48dpdSZ0xJYQuK3wU7qcwERt7iOC79jsI14eNJuJMccg++dQHvdzAEDnmmdjPEQPK8qmVNoGtiNTs5rmcKwc+eXrVLMwWOXGQilxQmm4ibVpe/48nREAFBQIjBqHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV5C8IvFgRJZn6HH9s8GVvkD5PBiCpLzTS4yNCFXnaA=;
 b=adHkRLkDa0CQiwJPCtoY8v0Urn7ZGaZ0ZvhPvUa2SEGVdxQcVzMhhF71hVs+nF60rvae9yVF/UKbHQfrzlNChr8/fodxRIBHX/y0jPmmvgVlSDoK21NRF2rkIA3HwAEiRJhk5JIsPUSrKKiipN5I0qm2nz6uabHGmLKKUO1q0qkoEEeIszkIK6/6NS1KVpxvpPCTw1NkitEkYabxSiCN9MUoqJ2fpNzUizSuYMOW69k/0RlDds6B0CEkfWcJx9LFLroceYosfFtifuzA6EGneWyQq4y0PQ5wshhDfBJKO1kmfFX0IaoQ+B4G6s0Utk5CrplTiNsYdhx2kEQpCxu9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV5C8IvFgRJZn6HH9s8GVvkD5PBiCpLzTS4yNCFXnaA=;
 b=gyB9mNoQK6QMS30GNwS59LgOb/VmUrdWYNzKKcIBhPoncVaKTMw/cM1pLW9oxBRYsj67J3c2IG4Hxt/G991/hQSBm8/x8tqBybley1+3y8gIz3AC6yV/Gn80Ok7Uc6PdLbEkN28mYUkUrM0K0R84pX9ickvP7ly/htl+li9UiBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 16:47:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 16:47:44 +0000
Date: Mon, 4 Mar 2024 11:47:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
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
Message-ID: <ZeX7KDuwLWxwb5Kw@lizhi-Precision-Tower-5810>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon>
 <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
 <20240304084841.GJ2647@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304084841.GJ2647@thinkpad>
X-ClientProxiedBy: BY5PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:180::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d23100-8e1c-4b93-4fd4-08dc3c6ad072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TNY971hhx6SR34BvtAjxGT/YaeMz0r2KGVhJDGcTO1/rOZn5VKnMvK8Q/DWU6+qO3QpO+A7BPwHPzRbkxpRtVyUmtcz5gCYNRbgqqW8dhpBcY9a8mJI0E+Oy7ZMhjAsMQSEKOSWTd+9jH9eOgCz1yEqg0givSlqNLvDUmtRnLTfBkMaauneguOx+fJ7GfMkeH6zuCOgJDEu0V2R7cxuV3KyH2n+BvMXWcReVvUtcJH2IzG1e+Moc24G9JewQjJ+3k4HxqHldbTSPVe86ZT7BP9efhY3jT9GOjxdQ7QOl3VdpcpYlFk8eTESVK3iTjGI96aoc6XZHAOtGrTZfiovSL64ONkBKiI+ZM8ptXbm1VZSuT4R6+/U8LdH3gQFAg1pknCvQbm7MzbRV96wn92hwK4R2qIMANeprlLTPzt4SLmLe749yuI98jQNXg97FXN1fGbrzHLTS4ReivoBoNuQp1lBhHtgTsATLY2vpN9HwEPf5KoWsIhdn9egkwduq5Ks/jXBg41rRCH9jlpAwhJRAGkzLKHR6bCWTyV8NFpY7lVTWtzhS8lunbGoWnwCXAmwhEyVy7ll4vDo087DLcRspX4XxvjLpu/NkJFuITOY3I91zw5rSNNjTCCM97Mdi9yseKJe6E/1CIbDNeiAVSSOixMnUESLSiEvUbJU4mv3EthY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlJtck9PK0hBYjlmWk9odDk4SDFETVBrbWExYUMza1gvdDJIZkxFOEdSWm9H?=
 =?utf-8?B?QzJoVGh2aFc2OURoS240Rm1OdktkTXA5b3BLTnovY085aGloY01MSWlYQmpu?=
 =?utf-8?B?NnVsSjMzSlZqV2s1NU1kK2s0QkYvRk5GTis1STVRRElJWVdJNVZYVWR3Tldt?=
 =?utf-8?B?dDBnLzVjTHR2cGVaNUhCMTR2TE1DbGxTN21ZQ0tKbEFkSkhaS2lBVDdlMmcw?=
 =?utf-8?B?OVdvQXZ4TXZlclFOK21oU2FwdnNPNGFDY2VKNndQd2VOMEpLUG9wQ3pqZzNY?=
 =?utf-8?B?b3QxUnRwUkVQYWpBQlBhV1pJRHNYcTlLMmFlaW5FVVZVOHduZEh1V2g5VWRU?=
 =?utf-8?B?WEFHeUs1a21CSDZkdWszd0wvNldRRTVIRGY1eUFwNE5CQ3NVckVLc0YzNVlv?=
 =?utf-8?B?ZGE3L0FBbXAvQjFFNjhyMElDaUFoNk44OW02bm5SdFNyL2dUem0yakxub2JP?=
 =?utf-8?B?UEhGaUlSZHJFNE42blMrMlU2UU1WdmJmb1JrZkozcTRYK0lBWFlhYmRHekJi?=
 =?utf-8?B?TmRYcCtNc2E5Nk0wNmNXdUNGTlpiZisxcGxEdzVHdDZCTVdyS0dYMDQ5SG1N?=
 =?utf-8?B?b0lHMUR0VjV6RmdOR0EzT25RUU1RNWRoWHFYRXM4WXE2NDVxaTRGYUlrQm1r?=
 =?utf-8?B?OE5EMDhpY1ZzVytYWExLdkxPcFpMZ2dlUXBoMnFOZmwvWFgwWXpucUFWUExQ?=
 =?utf-8?B?Q1FITktXVDBBZ281RjNMOEdSekd3azJrNi9PV0JGMlJsbWRGUUhoU044TDcv?=
 =?utf-8?B?c25ta0tlMzZOMHN0bGphM1BOV1lOcDZtZUhVSkdqZ3JzR1k5NkJRT3NlZzBu?=
 =?utf-8?B?QjlyVEl4Z3dlbWZhMkhCTmw1QWdZOEE5ZkdnWjV2K2xtQXVGRGFVOWtUSEY4?=
 =?utf-8?B?eGhLclUwUTB1UFQrMzM4K1ZuTGFSR0F2TE9IVEwyK1FxZHVCS1o2SW5mVmlC?=
 =?utf-8?B?dzIvbjd4VHF2aW9FT3lCNXhjSjVOUW1MSEl1ZmgxRHkvdjBNS1gwd3dMWHEx?=
 =?utf-8?B?cnRIWkdIZGZWTTYxYVVVK3NhaTlBU3FKRzVQTEpoUWw3aWxwQlRiVzBQVUZG?=
 =?utf-8?B?cGgzQWxQT3dFVWM3OE1PckQ0cFdBWTlzc0Y4WTFlUlNtUVZoZmtZRk41TXpN?=
 =?utf-8?B?L2NZdXF3MW9HTVIyZ3B1cEdka3o2UGFpQ0ZLZkV4RTNIVDNSd0traHdJVUU5?=
 =?utf-8?B?ZzkzcERmODJ2Y2d5Q1Z5SnpzLytWZzIzMFo1SzdBb0wxSFo2UVRjZEJ5RHJX?=
 =?utf-8?B?aS91MGsrNEVod0hxaFZMSGlFaUZTZFVqM0VPcVRGSEUzdzRndDVWbDFLRGxk?=
 =?utf-8?B?UXJ4WnRPZXNtaUVTSEpSVTljMkZ0UjN6QUZsT01jYU9yN3NNQkkycjVKV2Ja?=
 =?utf-8?B?TENGMlBPTG9pQnpzVWFyemNVcXkyRSs2anpTZ0NWc2FFWWppRHJjTUtXVlJm?=
 =?utf-8?B?cS9vemRxdHpiMVM4ZTE2QzQrVm11V0RhNWRkdDR6YldSeWEyeDFVbndvQlNa?=
 =?utf-8?B?TldmQ2RSUGZMT2RBV2JwaHpXb0NLOFMrRzV6VlBJcXBVc0RzS3RhUHRCcDdt?=
 =?utf-8?B?YmFlQVVrNlFLaVI4ZFZCTWsxeW5BekV1RnhKL1BMY2hmZ3QyMWV5NFluL1FW?=
 =?utf-8?B?YTRWTm5VbWlsOWhQRTFiZS9hVDVOSjQ4cHRyaUFrMmxoVXI1RWwyVVpJQnI5?=
 =?utf-8?B?cUNqcmxKVlZMRHJHdGN4TDM3Qm0zaWVPUmg0ZGVLTFU4OWZwYnNTUUZIMjRU?=
 =?utf-8?B?ZVgyVk9LQXp0OGxHVFZiNXpOUWwxQXlJK3hYazM5TmlDMjJpNWcvS2M3cnIw?=
 =?utf-8?B?QlZTdGM4T2RTVzN3cUtZTlY5dTB4Zm91dzNDNWJYc2NxQnIyVUZBcGhKcmty?=
 =?utf-8?B?VDRtblNZa29iS2JIUEZuMiszbFVRVDdNUHFYQzNUalhpTkQ2ZHIyT2liR05h?=
 =?utf-8?B?Ryt1VlkwQWY5alVhMmlONmRoSFRiRWdTYUt6dmEvZE52eW9QSUc5c1loZ25I?=
 =?utf-8?B?b3RNdmE3Q0k2UVVwWE5nRytRSVdBUTQ0b3VpeFQydjVvYi81a1p6ZUtkNmZm?=
 =?utf-8?B?STV5aTNCY1daek1INm1obCtKKzBmai84K0owMzlMYzlPMkFGb0FmeWdWRW1l?=
 =?utf-8?Q?CIBp49YsWkEyU0kQPqzOo6qLl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d23100-8e1c-4b93-4fd4-08dc3c6ad072
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 16:47:44.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wzxbe/cEjJF0knlP3RKm7ysM+QTWy7fliu5KPKBcFUWMEyVgzXKbUo0o4SN57KN0y3OEfT/YYRQD/av30NScpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520

On Mon, Mar 04, 2024 at 02:18:41PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 19, 2023 at 02:38:34PM +0000, Niklas Cassel wrote:
> > On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> > > On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > > > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > > > dw_pcie_ep_inbound_atu()
> > > > > {
> > > > > 	...
> > > > > 	if (!ep->bar_to_atu[bar])
> > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > 	else
> > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > 	...
> > > > > }
> > > > > 
> > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > 
> > > > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
> > > > > not allocate atu to the bar.
> > > > > 
> > > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > 
> > > > > Notes:
> > > > >     @Niklas:
> > > > >     	I have not test your case. I should be equal to previous's fix in
> > > > >     mail list.
> > > > 
> > > > Hello Frank,
> > > > 
> > > > Thank you for sending a proper fix for this!
> > > > 
> > > > Personally, I slightly prefer your fix that saves the iatu index + 1, and
> > > > keeps 0 to mean unused. That way, you don't need the memset, and you don't
> > > > need to change the type to signed, but either way is fine by me, so:
> > > 
> > > index + 1 don't match hardware iATU index. It will be confused because
> > > other parts is 0 based.
> > > 
> > > So I choose "-1" as free iATU.
> > 
> > A s8 can hold a max value of 127.
> > CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.
> > 
> > Since the DWC code can be synthesized with 256 iATUs,
> > your code will not work on systems with 128 or more iATUs.
> > 
> > If we continue to use a u8, and offset the saved value by one,
> > we will at least be able to support 255-1 == 254 iATUs.
> > 
> 
> Agree. I cannot suggest a better alternative. So let's go with this. But please
> add a comment before bar_to_atu assignment to make it clear. Like,
> 
> 	/*
> 	 * Always increment free_win before assignment, since value 0 is used to
> 	 * identify unallocated mapping.
> 	 */
> 	ep->bar_to_atu[bar] = free_win + 1;

This patch already change to use "-1" as free. Only issue for this patch is
that use 's16' instead of 's8' becasue max ATU number is 255.

Frank

> 
> - Mani
> 
> > 
> > Kind regards,
> > Niklas
> 
> -- 
> மணிவண்ணன் சதாசிவம்

