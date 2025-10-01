Return-Path: <linux-pci+bounces-37367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC9BB17D9
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 784EF7AB994
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE66F29827E;
	Wed,  1 Oct 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gHkcqqJn"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4226B0BC;
	Wed,  1 Oct 2025 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343442; cv=fail; b=Wu0ZMWlEOvFzwQScBdbXzkPbEMi962/65wOk9kMr24ThR3yqeFF0pVzQpWAHFjlixkM+YThwUPHMJh+wx/mgqg4D4T7/0Gl1hSTtjZnnBEI6uZjW61i6rlMMlcd0cEaIvPBI+Taz8HiCKZGhblgEENS7IeKduzxbCGSq1ipgvZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343442; c=relaxed/simple;
	bh=LNCHVmby60kt7TTAsd0MKdwOOCj0q8FSU2tnMqU1SJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G1KXgb7ckg549v/wWuxatasOkY7Oh3JG8b/zpsqiNk79MW0mCaCD0i5a5vOsVEhCb+8ObwOSuxQA/NEbj8aMYq8e+BCkGDDKP+XzqEmdZF7euV64Q4V7sLc7m0i5G+UwITWk/QTm+g5S2w6yW2IGUvi+ln+vFpF2A0oro7m35/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gHkcqqJn; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0fEGc6y7LcTFaaCsOg/NavOrKnHFLE45Uoo1mGC/+PMsWDgPsYg5EXrUQbKOIx4T89iqEmUrvq6eKqO9lbiApmMTDA+dFKoK2rCSlxgbbWkRiHiHVxArJ3jKRTrRWXiHTvjE/NqI8mAIuB3z81NHxhpjWyZekK65SMfk+If5AF/8aLmACdHf5ljq42c4WwvxXEkqafNhuaqhl9YGvXnjwkJmBG9b0kA2kRcj4uAOLC8ekotvChVXs4E9S6JVBihFi0RYP7ZN0QnxlXjbOnMk4Di1+ZYBCoPOss08zBVMzrxQJ6yh81nkgAtKFongmQyxanaGUJ3qQJ6OfZVDV9oWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Cp24uYlTPeQ4q9ppED788C8+l30b8wbETYVXxFxFQk=;
 b=mk7wIzRi8UytBIgjAIo29cJk+CZdtbUi8Ti4rUIKKYlGEmL/gLTaPI5QyLW4IGKTm/2KgxETIVOfGMPXgHjQ5MwuY/2/wLUYBul/hTe9udKRu95A08kn8iM0r/wTXogb/if/dWFDt3vmeUVO255PFEKYKSmDBDngeBXqZmbAjIsZ+1ZK3oPRVX7s1nzh2ev2S6tAM6r4JbI52/Uc+wzI41UCgiAIMnrA3k5WX88qgPiQ+zcK7kEEwL7qCVUcdJf5hAbSyu2jiKk7LIPi3KTE2UNzmZpRQ8NTYg3Baxr5zXcCQlgiXHfSJ6qihism4HFaxIVzkPOauIpx2hlU1SdiIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Cp24uYlTPeQ4q9ppED788C8+l30b8wbETYVXxFxFQk=;
 b=gHkcqqJnt5qbSCqvSUz3w/xraDVaXq3XMpT3M/yLB3OXzpw597RiAzi+NbSXLDhYtEx1SpKaWZQvE8GvCDnRbYI3DvU+nFAx0QNKCA8HZkivRNMvyFCZAQdFENSrPRCwu4b882qFUZAy1Zeayb8Wm5IxVYwMlT5ZqV8AZuWVLQKkM0T6O6HIQA4jkGuuW3g6EZlAE1ISmWQUI4g/jdDpBbQ0q8hPkcV09WYldOzQhIB1obXlQWyWvapst8ty5iCphBb67SAJMsSfQOovpVZwwZHmEZALB8N9k/dnYbRUEWHIsw0NeXF2D4YzxSkAzRDOks2PufTbaiP0gstDpovQGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 18:30:38 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 18:30:32 +0000
Date: Wed, 1 Oct 2025 15:30:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251001183030.GA3195801@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
 <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <20251001144629.GA3024065@nvidia.com>
 <20251001121631.7f2e68f5.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001121631.7f2e68f5.alex.williamson@redhat.com>
X-ClientProxiedBy: SA9PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:21::22) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 136607d9-f346-4918-5f47-08de01189ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CABQjFxfpNkkHGRNAe8HyP7rs2W6Dm5qs16CFDj/lx2UFgIPBn7A5OnmBlyX?=
 =?us-ascii?Q?MtqomT77oawHsmplIuCGsyP63kNIOp2H5TzfmMsZeM9JCTSLtLxINEi1lIOC?=
 =?us-ascii?Q?+QG7Kote7wAEV5/xgXU1INoe2kSxicSNNd4HUSPt+rkgbONE5xxmE3ruaa90?=
 =?us-ascii?Q?TB1Xa9DkK5ga2xSLo++U15qd/K8eu7fzG4X0gYVSdmibhBWzeNCBSgev/T1w?=
 =?us-ascii?Q?FQqkrfe79nafN5xBXij2E/mGzun+lV0ffpUh4jJ+xC2O4x9vU8eYxQALEpTW?=
 =?us-ascii?Q?QgwaLDHZ+OY++ZzqJ37pJ4UzAHLN5KPorBh9HyEiPH1wUP3QWLC6Qrf4asvO?=
 =?us-ascii?Q?oPol9gkYHDlY7olNpkAO+FAGIH9tbt4+tJZA6QUWmyUDLu6REci/4u4P/slN?=
 =?us-ascii?Q?Eo6/ImVxRXi0aHYqgd8nNpp5h5fA9dJLTi4RAXA7PylIZAvk3pVk0rzjRaSP?=
 =?us-ascii?Q?bPUxcsaIQckcqu9WRMfbj6cezSqfLzRyjpSnShMM6pBjWy4/qmfFM4GiHl8W?=
 =?us-ascii?Q?+q76XOYvoAwwX1sXjdlICyi/CR14ldKPHH/APnyJ5jgTAo6CFHqnhAeaW2lY?=
 =?us-ascii?Q?cOlDSOOJqH4ubqxBIzAYZc9AsTJhF15fIuNuuWWSn11ZhYPj7DwieB4r1G3E?=
 =?us-ascii?Q?9oV73e/vb/aR8kTEurwLVbHsEAJazlC4S0mpEI6af9MoW2GED7cYRWgU7bQb?=
 =?us-ascii?Q?Rb2k53li4+GXBInDe2BbXkc3ndw125WDt9TyGtsanCQNA4CdsQIkSkjot/LN?=
 =?us-ascii?Q?0nNJ3Gh6f1bKPpUCzc7nZBwnFtkU/zqlUajsSfGoctjyNP9RDuMnGTVFyU+Q?=
 =?us-ascii?Q?Y4MJlDKypr1V4kUkaf7Ieye6NCdsUyD0Z6fub7C9bdLyLB1X/+N+e0/4Iy0A?=
 =?us-ascii?Q?kBb8ds75qLMPPBRQaDfijYoa672uiBnZpz56y1RwJD1z0of2XyNrJQylOe0K?=
 =?us-ascii?Q?KSVQkaWQ3sjzhoGxatsSFVRVYDkvR2cnQYB1JOhM8GjVRUDDkmaHoTn+XmJN?=
 =?us-ascii?Q?jSpay3+6/Zbx5W8dQsmoeR3tbZ4SykkvVtvXhl5V9zydif4ASjqWBc97LXIo?=
 =?us-ascii?Q?puJQPSnvkMATM0feyw/1yoCbj7bJQVxyjV4rcM4j2Zz/KA+3mrUqQm3mHn42?=
 =?us-ascii?Q?O++cl2bSTrQeMV88mZaDlSNTi4elOomeiLUgOYIwr9dLSM4DCQOx7CDwSZRf?=
 =?us-ascii?Q?YmdUP6NVOaCqCx82X/0tUCrhvfCOX8nxof1L/ugT/q29mpVxUVkpC2TZSfva?=
 =?us-ascii?Q?kJ4UeGtgk09GKzkgUjD6R1gYRBvu5OsUZPVBx7asDSYx+t8yU+XsjtBA7bFS?=
 =?us-ascii?Q?eK28GztrbFtP577VSsROaY1SssF/Vj7Iqvj6QB5ilS9enUBic/z/5B1TF790?=
 =?us-ascii?Q?NqTjwedTMUP0cT5N+fMt8s6w2KP8CE0dL1slA/GiGMBd4NRERS3K320kfkPx?=
 =?us-ascii?Q?CSqZkw0/mfzr6gR8elcHZ77ve5cRT4qE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O3uRrUxoibZQF82WeiV05IpVBFTHZNBsnieVrwGjLzy33g+5W/e2N2GoNeuw?=
 =?us-ascii?Q?4Y6O2RQzZ+/EB9j9Z0IDt3NFV+SvHtDeaz6ac8iC9A6MEDYxnaEIFvrpN5ek?=
 =?us-ascii?Q?bDe0eO2pj5WvyOrFdlIPsaWZ6plLifz7xAcsxS0qPzVYpnhLqqG2oGr8PIb8?=
 =?us-ascii?Q?D4xo5UjHevgFJXK52hsStG8MCO6N4aC/X/XF/39bManj3/SR6otjIQZKMZyA?=
 =?us-ascii?Q?Sv/veABKsJGn5yVbBzqEyLucpkW9pZ5GL1Q4UegHH8FEXALkiM7pUxT158v1?=
 =?us-ascii?Q?TzlvMzrzxZ6alUyPwY3KlUE89GtOe5yO5XYbWDghMIUY6ghhLmuF1ecqQYA7?=
 =?us-ascii?Q?ITZp6MJ2mV0MABP0OBNEg6mOGIc4q+OqPc/KkWCxuFT7iGDqTx1WfEKruV5e?=
 =?us-ascii?Q?3VVFF2XZiWT4nLjmVEhKRFB1b8cZ0lhJiBgeRVbvRJjBeypC3GcQFDWvmQy+?=
 =?us-ascii?Q?7GRASQieMQUpPDpfsaQX0Q+XJ/uTXGZVlauVIoo4lAmOrQcO7pDbNDLXbm8I?=
 =?us-ascii?Q?6+E/Le8TPFlL7B78oyaM24ZUa0bagzcrJilOYrTydE6cmQgEP1m6EYAtf3SR?=
 =?us-ascii?Q?JIoH7lt6LRn9l66NTvg40tXJeiTGraG6am+H/g82TyJooj1sbuGad6xxifV+?=
 =?us-ascii?Q?VgaxA8FjMWQrONitoD+IaIY6J2UIGr6OvX9DpY+k9V0/pJeHnlXlFJTscx0M?=
 =?us-ascii?Q?UauDW1MDrGvmywzR9jSLytGv+ySQMVxysheXWFubIWidWrBkly0pvo7g1HwT?=
 =?us-ascii?Q?07u6g3oK35J3MFDUVWD7od+mxgRbW3zsDJxwOoky7hOlWxgI6GrSpZLm5CUM?=
 =?us-ascii?Q?Y8t7PcWCvN5/89NGAaddf3Qo0q93TEZQtWn0M2qiQRX6AA44aVozeO36H+Sr?=
 =?us-ascii?Q?Lp0UPXfV+leSzMwPej2Yt+Cp8eBTXlrpyQ8KrDQU5euv960RX+BjdE2PEgbf?=
 =?us-ascii?Q?Yyg6iKeUdG5qRNv/qW0I1nh6kYzyr4MtJcMsALxASU5pFNs6YbpfLwHdaLwU?=
 =?us-ascii?Q?b0hi38rGXCEX6DQUX7ZMmo++7RExyo6VOfwIAJDdVrCgdpbi4ADsBtCAQN6j?=
 =?us-ascii?Q?kO8EeEUH3BPsYUBshCdPrilsC7pgDe3Lo7DdqXz0RFVjAuNBDHqSHrA4E8nK?=
 =?us-ascii?Q?B5DvRgJUj5VPi6ShWA0jXGEyae2RvaX2uMVfUd+W8LizXOiPwBmigC+EL/Xt?=
 =?us-ascii?Q?7TRIR80O69u+QGydh4Cag6EiQcxpt9qKbMEz7nSqBMqryXudCax2nGk0xjQt?=
 =?us-ascii?Q?9OfteEcMpMcyr0OaDfx2NGCA/PUyxy5yyIFSiEROS2U4LQXhyFVAVCUGBnvL?=
 =?us-ascii?Q?+OCpRWtwiNPU5krDK4Ggfgk9VUsoErru6AVzeqIHbiMp1sEgskktvZLcEmFb?=
 =?us-ascii?Q?M+p23F7f59b3l4jeIiKFOcfJKRnPGN+LCi0/Fh/2UpgvXVPyXCsYEU/Ia2q2?=
 =?us-ascii?Q?L3+YtqQmbQqyoda5+qp+TsJyetIVxLuZIGolV1BXKpzBJgmDRqMYTpm9Z8AN?=
 =?us-ascii?Q?ajbKxvPusMnbs4eQmjOrFaneFYVKz3O3tBL0o2AJCYnWqjdk27eXnk2rA2f4?=
 =?us-ascii?Q?SLEPOTbOH8rIk1vVex4HulPM2oqDtkXh03bgOLWs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136607d9-f346-4918-5f47-08de01189ac2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 18:30:32.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZaO/EnrLUBntYZt3zwQhWMVOkFbN8qKGDznbTugtHm5rcUDi4G50BdyftlBYTns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681

On Wed, Oct 01, 2025 at 12:16:31PM -0600, Alex Williamson wrote:
> I think the question would be whether a "bare" VF really provides a
> useful device for nova-core to bind to or if we're just picking it
> up

It really should work, actual linux containers are my goto reason for
people wanting to use VF's without a virtualization layer.

> fair bit of software emulation/virtualization in the host vGPU driver to
> turn the VF into something that can work like a PF in the VM and I
> don't know that we can require nova-core to make use of a VF without
> that emulation/virtualization layer.  For example, aren't VRAM
> allocations for a VF done as part of profiling the VF through the vGPU
> host driver? 

The VF profiling should be designed to work without VFIO.

It is was one thing to have the VFIO variant driver profile mediated
devices that only it can create, but now that it is a generic VF
without mediation it doesn't make sense anymore.

The question is how much mediation does the variant driver insert
between the VM and the VF, and from what I can see that is mostly
limited to config space..

IOW, I would expect nova-core on the PF has a way to profile and
activate the VF to a usable state and then nova-core can run either
through a vm or directly on the VF.

At least this is how all the NIC drivers have their SRIOV support
designed today.

Jason

