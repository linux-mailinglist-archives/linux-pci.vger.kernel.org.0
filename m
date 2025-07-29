Return-Path: <linux-pci+bounces-33110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE94B14DFA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9743B2EE5
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778BE13C8EA;
	Tue, 29 Jul 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OtXo9+jQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8779482F2;
	Tue, 29 Jul 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794000; cv=fail; b=cS7BaUxq0PJmH7qr6vURtlsdBlqrxCwujik9KGzlmVx9tKSL0/bEJbv5Eu5obEOxVGyFPKrCIg20oj8mabPU2xWErhynpir0oNaEbopjp61U7ouM1W/thorux/8NpLSEdTUcxGbHhEb6pm7AIbdViN2STBqiWdX+Si7ZHSiWAKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794000; c=relaxed/simple;
	bh=iBCbnSqR8iAuF5ui3KzClJ8ojyCdOUP+fQXC84wjxMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I4pu0fAgAbXE4jKPuoBpdPNPvhxBr7P2C/h3aU0uj7o+krzS0qp30RuobWDVdD7kLpDYUU9u+GW95mhvdxILqpvSWrdH10d/cQiZNNWdZnSxUqZWlYd9bzNvSg1I9D1nCnQBPxoBYKilC4Btye1RsqB1db1r2cVtu+TLxCdZwcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OtXo9+jQ; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if0cSVVTZ/yTO9E9KqlAPlnjdxmDZhTUDPgs85Vwa/vaXt3iIBPjHJ14HABwh17I9OfVkWpfEwsJUfHSpHoq1liBc41mK1+gKjOBs97//xulS6StJ3ZiiQzB32nShbAEhHSItBSNkYDkXHtLb4vsMR42s+X4bbMgk5TORaXsLQnYaZ1DuaaEw5+g2PGWDw4gaz3FXrCF7NZxcfWACXOX7pR1GAdeVn7H1jgm0/aO5NhNrOis07Ymz3ARf0bKf03fUOyY1+nn+HhkWm1aSxFHH8LpszXb+Ci/frrYKGzvsrhEN+gY5CAkTI9FYa2KIw2Ge6GFwjFb9SImEpOuLMqycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o78aoexDA7UblGy1fxAQ5opbZeC36rlHLAltPiBKkNQ=;
 b=r/u3zNc4RCmFtdxBiAcIf6rnRs2M4C14jvNalIoksJeutL6SsLZqupUi19s8ZPi0U+tPk6JCrKhGd+LyKaUwp/+fpeqb32QOjmwvDBnvz2KvZJxWlEj0hF3/7QtM7JTDY0sMKY6S1FnZkOQ15PUw+IJORG32lQyApsPWQMPCOJdiPNn86oKVtCtCBwmBCQb8tl1lbIW7W/Dl84J0ZEsdwdmTsby6nrVm+75F7qmbCEPbkL/7MfNaVTvkdO0wGAj7+vWIlItFyNgLwakST0hZPN+4LP8VSiOeA8ELxw7+Ao/5bRnJuMyo4mhrgI3v0U4zI7JBlHfeH8gB+6BiKMTlag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o78aoexDA7UblGy1fxAQ5opbZeC36rlHLAltPiBKkNQ=;
 b=OtXo9+jQMQ32RcO6S/nb/tpjrcAV+XPT9pi9j/eg/Yr0qB2LFzDewtsm0dDptR/r/py+GaaF4mP+zNrrBTP7l9KiIORM3Z5X1o00rR8wEo8bAp82U8JPTm6uz7PAErngYz0ozBTq+0B6D7TfvEpO5GAjcBqqVIQ6arEA/4UOEmNANpbVoMAHVkBOqsjdkPqvrO9VIFuBVyTm7Gz9aslU+rAwc4nSc4Zj5nhdfVfEh9DaqhGTwhoy03qk0+UMmloVYYWvtlav0LEtlgrZGs5vRpS45dB/EeYLlUxEjeWXjE1ySMevtAB74tdiscPU1rnb1BMkIhaums+jLLNXR73ShQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB8473.namprd12.prod.outlook.com (2603:10b6:8:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 12:59:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8964.024; Tue, 29 Jul 2025
 12:59:54 +0000
Date: Tue, 29 Jul 2025 09:59:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, patches@lists.linux.dev,
	pjaroszynski@nvidia.com, vsethi@nvidia.com, helgaas@kernel.org,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH RFC v2 0/4] Disable ATS via iommu during PCI resets
Message-ID: <20250729125953.GH36037@nvidia.com>
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <4f7e4bfb-1bc7-4c87-a9f1-8c8b6ee9a336@gmail.com>
 <aIOz1bzgfK9q0n4b@Asurada-Nvidia>
 <606f65e1-ccfc-4492-a32f-90343be654e7@gmail.com>
 <20250727162041.GC7551@nvidia.com>
 <d7543795-b172-4452-8789-e1c810d8075a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7543795-b172-4452-8789-e1c810d8075a@gmail.com>
X-ClientProxiedBy: YT4PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 43415ecf-d711-4525-a671-08ddce9fd031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FD5/Hk1NtCMfHEeIn1Inm0wkYPRvvM0gblJao2lkde7W16dj2u95QAZMw+1e?=
 =?us-ascii?Q?CXOTkXYUp2o49jXUExPEG58Dr2915e534Fvwfl0X9NUJ2OjElXZqCfy6/H3r?=
 =?us-ascii?Q?vZxZpcA8VCTOyP6RIelq9ISpqvJttDWt3BtxqFMQJftzJ/X0IAaeAAMe1PqP?=
 =?us-ascii?Q?XWrgGK4Nac/2B8H0T5Ihuxu7wpUJi5P2CnGD7V6G9UaOMgbGoykJxH1CCvrP?=
 =?us-ascii?Q?bS+XbOvHZEoyhEqBIOC6JJQf6clS0CgZ0plft6EPa2u8fjZoNnByWh8I9bTB?=
 =?us-ascii?Q?c2ZrL7+73G4HJyzs1QPAIRG+nTGGk9tWlDfdUiQCuWSS5VUvWvhMFxVejvV4?=
 =?us-ascii?Q?GTKemLxFpCbbUtkF8V6Acq36ZV8xvHXZ4XowU1TKRAU/ZTOkwOm2VqwOeXo+?=
 =?us-ascii?Q?1nxXscBt3K+iA+Ow8vpdtPV0eIgtL+gYM8vdNRY1PNSZ3RxqaE8Qk//UemWG?=
 =?us-ascii?Q?rK8xglGGlccoq6sVGKKAD4AuoOy96C5XrXnNepiXAU9riq2bZo76Pmwx7BPg?=
 =?us-ascii?Q?b6ie5JdgZCpJG1gcZqBEG+uls3wtK+tp82+qh2Rko7tpD6oVPVE+vObe4nrR?=
 =?us-ascii?Q?bLfs02hVazjQa96kJIUNOe56h+ObeF7SPBpGbkChKvOSGV7RiepVTpqrep9u?=
 =?us-ascii?Q?QuBlnvy4Rp8tLcUdXtla54S1TN+h9CbVowYznidyHG3MrDTHGlq/DQqxL/Aq?=
 =?us-ascii?Q?IxpEbI7bTW1pIni/9U6zT6UwdX3e2qb8nWP5tN7bKQRtKXD2ocljYT5K+L+j?=
 =?us-ascii?Q?U2nT51y307QsReZcxQKwHB31zLzXxwCkAWKBBI6QDZIwYaTKFqqghZqkUHNv?=
 =?us-ascii?Q?gnUrFREvlKrZROGUn7zMeudrwXxeRZEiN3bmPHG2lq7NCTYutH8F/y66rOAJ?=
 =?us-ascii?Q?ONZO1DC0L8VYWBhQYRPDXCdfxEUk6KWVOLb6blXC6raFlH+7yA53AmxrgLUy?=
 =?us-ascii?Q?T/RqTS1aiHv0+h8fsA1gVJwOG+VoOWYr4KEbbNtmE8nRNJBfCny3Yr/9kTF8?=
 =?us-ascii?Q?+ILh7NdzHbv1UdYh/aEiaDIHO7UsLf8DROlfmFMCKXUw05dpNAEjig5/D8+A?=
 =?us-ascii?Q?aGwRw/7kRtIOtek17tdbcbteWvS5PIJ3p4rVq4sAeLg++TuXMtYaxXOpQyk8?=
 =?us-ascii?Q?RUrAR3BQatw4IPBgXgpSbzaZekl467rUPCdYXmc8E8vIO4KUzrIykpnPMzpa?=
 =?us-ascii?Q?RR/V7x1Xj+g1+hcr+kUBbEYDI2khZS4YReJLWJFaibIXln2LMa0zU8VNPmhu?=
 =?us-ascii?Q?GQZPy0l0veCWsNGk38AcWKj/sUYG33TyPcLsErJmhZZNEcI/xpuzzSlQpslT?=
 =?us-ascii?Q?iLV6yX48w9TYo28hmyIjLRpaIwuMf03iYi8eC8fRel245LBP/bVx+d9Gbm9z?=
 =?us-ascii?Q?RDP6wZJnf7NRWDEJxLnuyOkzIhDu0nCgDCYJlgygp8cIepICVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PXIiorQP6wMTwpSqy2b+FSJSp/0Ux/uV8q4aioMutHprMDFBfcQHcRFkCuea?=
 =?us-ascii?Q?wCAOLyjKA6ZBLA+6Ujv3omqeUiK0/C/NNKqYA3jzBFQPfWKEAG0pfa0ph6lI?=
 =?us-ascii?Q?xbkte0/MNoN5IzSdjPqQ62WO1X3vZCGMT7A46V32rSWZEjxx2HwEetibD3ZJ?=
 =?us-ascii?Q?KR2rlEuZF71aOLrKW0uMQnYQtxDdkBPqRS/+tcEB+0TE6zIXpbPbt5CMwK5c?=
 =?us-ascii?Q?d/cgblRs9sXvutaaYdKndTBVjCuMIE3QXPeDw/KXhlZISerJufx9GEf8lt0X?=
 =?us-ascii?Q?DQrPsweLhnwoX/Ea1KLSoPeuQYvtey3kd/EXyhLvrUZy3s8/SBWt/wJkSVSc?=
 =?us-ascii?Q?ihrRS4ShRHVkPJtFwWjNSvrkxW8R9w+f8Hdu4jKRjbGgQ5rHGxncivhc67dK?=
 =?us-ascii?Q?x5DBphwmeYO0HaeTorGIxHcF39of+c9TFNYMGYEW3BpPeBFByOFeE5nC7JPs?=
 =?us-ascii?Q?a/9QDCW2nhZQoqiohzXhy9/uC7uFZoOhMc2dInexpgp5+xuPMDv1jzP7r4em?=
 =?us-ascii?Q?cgFfl3DFLtEotUMZZhZ5Rb8BEY1vUrhrleMDiQxuQmy75LhTyKBfSfDu9iN/?=
 =?us-ascii?Q?upOI9mwqBy/Lg1EcLy/m3IVDKnkdw9uuQoBCBgJCSId+jxo+pWnRnOeN3zeI?=
 =?us-ascii?Q?a30OX+i+9iM7jLZ2hNPC+XKmL7tPaJ1yew/IybenVsWc/4P7nzZjDGBluS5W?=
 =?us-ascii?Q?/4f0d/+X6Il7WiL8JFpolWpF9qNDxXjiTClnEXzeR5NU+Iq5VeKwYv0KUPoI?=
 =?us-ascii?Q?FUcU5IsXMMOHYp89iNPTvBW1Ofi8gxpWY5kr6RdbsrVMUlxQSC10eb0LcHaC?=
 =?us-ascii?Q?xuySjRUjm9VTTGdXkwCD7e5t2j2fPLZSGOdmN8K+TBU23CrjF9hN+sMxbGl0?=
 =?us-ascii?Q?X/BkRDV+8eKcLdI56U5nDSWAfVxgUo9++wxv0a6hr1lB/tELxYTx7wMnKOYr?=
 =?us-ascii?Q?ELjHpAp/PfluygdKyZ7sX8bvQ2N0dpUArowMoLhxDjiAW+us+RbQSpdMw0Pl?=
 =?us-ascii?Q?cEnr1YzEPWNpQ9diSFucMxveq/irfnDEyaFYK0ZAPcaShzpLYS3zOuv2FR8S?=
 =?us-ascii?Q?eQf3k6XG7JAYr6EzCUMDlvDgbePkMf9UEkvzeftlOqGqkfwKobnajeu6R/xg?=
 =?us-ascii?Q?pyrvUhi/H7KBrysPlqviGKvOa7ICkLM+auN7jiFR7dakK3PUmHuMYV0NBFbP?=
 =?us-ascii?Q?EtJsC11m92oPS3jvcFuO9gU3pAiOkwpEh0WzMawRQ3rWvWDRuxM+ZJ17S5gz?=
 =?us-ascii?Q?9IyJj6vUzeRz1x1WSGub17F+ySCFpBegisdA8FvzrDcnwZoDpnMg/T2PKi4p?=
 =?us-ascii?Q?jqExTQzeIAZz2QEfdrte+uiiOpjzhq+9OLhXvESRsC0RLbFW6g4otfAxWXjG?=
 =?us-ascii?Q?LwEd/k5mRVjXKRW8BTr5CFtAkd5cl6BniVxICqn4xZrvPbzSrmms92bkpTos?=
 =?us-ascii?Q?9eRmI6QuskxHlFZnkoaIPDkvGjZ+pZb6FrWcRzFSP6wnkDkarNmgJz5amrsS?=
 =?us-ascii?Q?MvOl8KbmFtVqX3lMOE9cHwa0KO5okJ6lGjTxNOzW2CEgylvRlvibd5k9+3r9?=
 =?us-ascii?Q?DrnVhs89fpNllNdKd/M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43415ecf-d711-4525-a671-08ddce9fd031
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:59:54.6566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuSvhsieZMSNJ05XP0pPLTmsJga/1zHYFzbFwSCF4hxzAyZ68NtGPftf03v5JjWV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8473

On Tue, Jul 29, 2025 at 02:16:43PM +0800, Ethan Zhao wrote:
> 
> 
> On 7/28/2025 12:20 AM, Jason Gunthorpe wrote:
> > On Sun, Jul 27, 2025 at 08:48:26PM +0800, Ethan Zhao wrote:
> > 
> > > At least, we can do some attempt in DPC and Hot-plug driver, and then
> > > push the hardware specification update to provide pre-reset notification for
> > > DPC & hotplug. does it make sense ?
> > 
> > I think DPC is a different case..
> More complex and practical case.

I'm not sure about that, we do FLRs all the time as a normal part of
VFIO and VMM operations. DPC is pretty rare, IMHO.

> > If we get a DPC we should also push the iommu into blocking, disable
> > ATS and abandon any outstanding ATC invalidations as part of
> > recovering from the DPC. Once everythings is cleaned up we can set the
> Yup, even pure software resets, there might be ATC invalidation pending
>  (in software queue or HW queue).

The design of this patch series will require the iommu driver to wait
for the in-flight ATC invalidations during the blocking domain
attach. So for the SW initiated resets there should not be pending ATC
invalidations when the FLR is triggered.

We have been talking about DPC internally, and I think it will need a
related, but different flow since DPC can unavoidably trigger ATC
invalidation timeouts/failures and we must sensibly handle them in the
driver.

Jason

