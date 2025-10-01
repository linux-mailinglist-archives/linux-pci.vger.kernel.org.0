Return-Path: <linux-pci+bounces-37317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52989BAEF34
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 03:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6111942C31
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 01:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA783202F93;
	Wed,  1 Oct 2025 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nf8TXHvq"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10A6BFCE;
	Wed,  1 Oct 2025 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759282002; cv=fail; b=uq0boqX2Xe7w9uEUu4Uk8XTeOx0Uj1rlqY6ZxWdvtaq5JGCOYN4WhLEgmQuBzEcuwxzDTxLCs0RiXpOJ4arNsBtspSzwkZSt+56ZjLRmjkUFMoNTvtnPNXwGk4V5+sO055fRbJEmO575LODmsSUeQHYRYXidkGODqzFLHciT1kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759282002; c=relaxed/simple;
	bh=ePMNNewT6rt9d7O45QboAElDihYXoYEaTQa5Q6a3Se8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fDRJooXZkQ4c9TvTjphBUzM18yBd9slVg02osGCkFdgyf2I/sxccgpT93sJ2zPFs8N5stWrNo2dqrIaYOFf0w1tAp+8H3IyMaDfnodK9CrRTXiwdbQGK00iECHBUmIV7aI0zAP34hDCz9HRE1gaEwt90jqXzTcHTCtrOQBl6Hng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nf8TXHvq; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqJxu/aF6z11HuPewNVFYVoZgO/irsW6Nnf/dcl8NWxrU7pXqXAOAqVE7ugT8X9/72CUxgAicSR3pqB1elT8KPFvhUINTJwI8tkstFjgkP7MNnvQ7/C0uNjUI+RM9jOsiTNqfB+sq6jcl4jOo5Xsjs+IBiWRKvX4JPGTVClKfDn3D/eIya/sCIIqRpY/ADpog+iPfoJuBjN7bEmivddlFZGlpZp7AifrLnBtUwdDtyBeeLXT7Rgw14hTlv+UdpY9n1GOIGrsKO7HTjM3SefsccjCJAhztmw5wiZUU19nYWSyNsJy/eD+ym2zqwxT01OfidE8HCYybNzopceXlZlJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h9kmyhBkZy8BDnleCeRsjIk8rSEWftJoOrH0urm9SI=;
 b=VNpzHV50wTJ5MuutDxXeV81ztIiLdp+k8DJ+Zkr/AU/RXHSE5i9Kri3pkLU9WfZsh/plRDiYJR4jeho5KOch2KVJoMbf1DC0FiGNDPgCpsizHbWfg07C/hA670QJWjbb/ngbfTq7g1oUa+PvnMXo7DJ5zso7Vmd8OHV9/RXFyPt3s1E/QVZLtRS3GeGWurUz8NuPkPieqemEOUxEaERHaZeaFxAHA4ue+GAicLLQRrLVdku+QPmLzWfKvxRg71YfNa49uighDBI5n9e5eh8jA+71+lKyuxd8mwZQf/iq1fi7Khyaa8PhDwFqpOTeE+NJCBGgAYpNlfbkor9xgTVfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h9kmyhBkZy8BDnleCeRsjIk8rSEWftJoOrH0urm9SI=;
 b=nf8TXHvqPNvJJGQzwB86YCzt90vZJp+GIPe0Q2TN4fyt/RVfIZ9ww3C99Jwy/NeatZRNwEU7eJKak3e426biviBqjk6A85Ertihx8Lkll2Z2BijedNChPuNcvFdEh15lEnvZe9yQxZIQWgvZ1VJDGDIJwTIOKSipLMnJdat3l5WGq6u58tt0DZ21EUrwEtm4V1/BNuk0vRPA4KJ3KYg8hF5zNk4LoqlQmLAP+Pi+/q9qO5P6C0K1ZrreUtCnktYQ43A/vbi4Xr45XZPnhsCtMsj3+aMTQKw33tiqy0xG2bQxzB46Hw47owdMz3LHe8fIRXhUB0JNi+MqE3hXXlo+qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN7PPF9E4583E15.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Wed, 1 Oct
 2025 01:26:38 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.014; Wed, 1 Oct 2025
 01:26:36 +0000
Message-ID: <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
Date: Tue, 30 Sep 2025 18:26:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|BN7PPF9E4583E15:EE_
X-MS-Office365-Filtering-Correlation-Id: 1792f226-2366-41cf-cb41-08de00899062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0tuYXZqbm1wZ0JuUWZuVXA5V1AxdEtTTmRqVHVPZ1dQY3VRWUxWdStoUkRu?=
 =?utf-8?B?ZGxwQmppNGFNclkycnl2L1BFc3cvY2FhOFhKak9hK0lDNUlQOVRPOHdscmxL?=
 =?utf-8?B?Z1hjWnltZVM5MUlibGZtNUVjTkFIektXaVhvSHd5TnFBOXVkT2hNaXJzclU0?=
 =?utf-8?B?dTZUWTY1Y1E5UjJMUDBneWNTMmpiLzNseFZFVlFIcWRTeDNzMkpJeXZ5cERa?=
 =?utf-8?B?eXorUW50TEdkWEtLVkpLb28zaG12c2NTbXlTVFlMbysvZEw5bGd5d0pESFlT?=
 =?utf-8?B?LzJGZEFSbFdnYktJVkVZNW5EQkhjK3VmZWRPS29WVmNyWHdLWEkwaXY4RXh1?=
 =?utf-8?B?ZFJodk5lOEpuZXdzRVVwOWtyZWFRRWR5NFhzQncxMjhyS3BvWDZ3MWNkSzJN?=
 =?utf-8?B?YWkrRjlveHV0T091bGM2eFJNZzZpNVlnNnI4NTIrOFdWZjVBMnRlOVJrK3FO?=
 =?utf-8?B?MitWOUYrV0xxUzA1NTRpSHgvYVNNdllQK1RvS1ovZDhaQVJnQjd5VUxXU1o1?=
 =?utf-8?B?QkEwdExma2FycFl5LzJCbmg2eW45RjAyMmJSaUdqZ2p2SHlERXFRYzdHVlBZ?=
 =?utf-8?B?UGYrRXhoYUQyOW9IU1NPYVpON25WRGZmbE10Wk9ZcDM0TGRmRUJaUDFCeDk1?=
 =?utf-8?B?SjNpSXFPZ2tnbDl6b09ya0kzR0ZXaWMxM0Z5VFBWWTJ1N3FIbVJyOFI1T2F6?=
 =?utf-8?B?d0kxNCtYNmduVVNqU1dySE9UZHBadjV0TDJ6NGRsaWVkN1JwVnFpcFBnQzBp?=
 =?utf-8?B?bFNSOFhmb0RRbnhqWDV5UmVmSVZoUkRzVWV2RzhFeHVDY0loTlBRTlViNFpp?=
 =?utf-8?B?c0dBV0NJNGg2UEdYVXlnTklieGxTMWlaY2lTWDEyZzBjUG5QK1BJS21qU1pw?=
 =?utf-8?B?dEhxdTloWTBJTWpIMndhWkVGWkhKcGZJYW9WczJ1NDMyY3hvTHBicjZ6M1Ro?=
 =?utf-8?B?bi90VVhFMXhPbER0S1VOUkhjaGZBSDQ0ck1nN0xXWDBKM21iTG9meFdvaVM2?=
 =?utf-8?B?djRoRHpKb3NSSW5PeUhxcnZmUXFKd3FxdHAxaFNSNytsU3gwSU91Um0vTE42?=
 =?utf-8?B?MjRhL0lBWGxsejdIUy9FVjA3TThiZHlPMkVBcVVrdTJ0TEZFUm5EN2REajFL?=
 =?utf-8?B?cnVndENGOC9qY2JZSkVETFlGRjNKQjkzM1Z4SG1FUWYzdS9wYVdVZG5Qemd1?=
 =?utf-8?B?MUpFc21YbXpyQkZrcG5uVTBhZVpLMWxnWmNnNU9xUUlLanM5ZWRRU3pmZE1I?=
 =?utf-8?B?UlVCNFpmWG13Z2dOUWM4cWIydlB5ZUl6dXpRMXlCcXNOKzZIUU9jZmZIME52?=
 =?utf-8?B?TzFwZXR0OE9laURFeDNKUWRnMkxWREtDaFdYYXVlWkRVVFNRM2V3bUQyMHNP?=
 =?utf-8?B?UDVLc2wxbHBGckJ2djQxMkpjNmdBZ0xFcjBialh2Q3VrUVRTRTNPekF6SkRZ?=
 =?utf-8?B?S2pmQjdpZkJDZW1pdmlpMzlyL2R3aCsvSjdPeEUyNUpSbldiY0dvaDBEdHBB?=
 =?utf-8?B?TXZwNFhqSnBJM2QxMXFPcjVqSjRpVWtRdlJmZUEyNzJHTmJacS93M09TeVNV?=
 =?utf-8?B?U0xDQTI1S0Fsclc5RDJxblZXK2JQN3NxTVlrVFZlMnkzYXV3V2QyUWdYYWZI?=
 =?utf-8?B?NFhDZXV0a3RoSE1ZYW5kSXRPU1BkUkFIaFZKVXZpWDYyM3VmMXVUNEdOUG56?=
 =?utf-8?B?aCtscEdLUXNZWUxJN0ZGTjRwWUFGdUJNdnh2QVNjMjlsaGtOYTZ5ckNlSmJt?=
 =?utf-8?B?U0JMN0JUdUlvb2kydU53V29vL0wxWmx0OVNTOEJ4T1hSZTFWTFdVeUlMNld1?=
 =?utf-8?B?Z3dRL2draEcwbnNoNVE4TUlucndER0VpcVlpZ1VPRjhneVFUeDR2bVJlcFpX?=
 =?utf-8?B?QllNOEVoUUtZOWxDL3F1ckdWK2QwOVNkbjNXWDMvSW9jOUMzTGR5bTRFb1Ju?=
 =?utf-8?Q?Yi+2xJ4j0q+iBOFoaJqzkA3ZagQ1UxBB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T21XZzJZVHlCdDhHSFVMbVRTMnUrZ1R6U0RtNjh6N1pqSmx4Qi9LdmhpR0NL?=
 =?utf-8?B?VVhaQVNXc2x0RWZmTk4xNmlBV0djSEp2RW1LRi8wbDZUeXZ4VjMzWkhQUy9o?=
 =?utf-8?B?VHB0WC9mNEZvb1drQ0hoenAzYkFvM09NQkF5Y0NBeFlnYW5kNXdhK3FwODFk?=
 =?utf-8?B?QWx3Zjhsa3FDWE1PZWcrdFIwVHI3dzVoZU95VU9Nbk8rTERDV2RaajZ3dm1U?=
 =?utf-8?B?eExyVlU0eFBOQURIYXVPWmZiTU5hayt5dVZpZ3EvSmdlL2ZoZTIrUzdsNW1x?=
 =?utf-8?B?TG94ZlVWa1ZRcjFWV0wrSksyN3hia2ViVXV6bG5lS09kMmZnZWN0UmEvOVFp?=
 =?utf-8?B?YUxhQ21ISGhwc2Nvb3F0T2twcGMwaWI4VEhZTWVudTNPZXAyeklhK0JJVXBt?=
 =?utf-8?B?Ty9LcGVsby9qY1VwYXk3TGtoaC9DcGg4RjNJMlVYZVVZT2xOZXZYQ1pWbXJ3?=
 =?utf-8?B?dHFDMnp4SjBBaVFEc3hBSlhQQlVrZ2dzOTE5d2tuRGhjOXRHYmdFaWVSM2pF?=
 =?utf-8?B?N1F2bU43N3JTVTh6S2xKVEJlZWpTVTRVTWswV1V2eDVmY3hOOHZsQ044VUp3?=
 =?utf-8?B?cnVlb05QK3pML2dGS0FlUVdNaWprWFdsdzFXcU1VSFN2cm1Oa2E4M2toU3Y5?=
 =?utf-8?B?S01haUR2TlY5RGVwMndhVEpWWitiQnpldTQ5ZWcwT1MxZkJhaDNqYzNJM3l6?=
 =?utf-8?B?K0J1MTRQYWlQcWxWTnlyMDRyZTBQMGsya1hqUVUwZXVRbS9TRUxmRFd0NjFM?=
 =?utf-8?B?NzExTm93dit0UmhjZFZiQkJNL3ZlTVpLRG1RV3p2Y0t2VHBDcGZDVll5M0R6?=
 =?utf-8?B?Nnc4ZGtrYlBOclZlSkRieHY0QTcvc1RGblg4dURCb28vQnNJU0Q4RXlobGxO?=
 =?utf-8?B?V00zeXl5ZWZiamxxTUliSEpSZTNGRmtMN080UFNJQ25yVHRsL2pldzNkMWla?=
 =?utf-8?B?THZlc1FPdklJdlNqYWJyRkRaZk5IZW1OMmZjRlovVUR0bTd1bWhXU3c0STI0?=
 =?utf-8?B?Z21Uek4wc3BseEZxZVFrK2xuMndwbTFDbDV2SDhRZGoxVjNFTmcwNlg4RURE?=
 =?utf-8?B?OFhHSUIvcHdTUlJYcnFRQlRzeW5PSlVFR2hVWVdoblpUblZZOTlJSjlUUU5t?=
 =?utf-8?B?Mm8rYmNhYXFmaXN5WjAxQjRlT0F2T2p5UkIwby9GMGthTmVhOTY0ZjdDUmpC?=
 =?utf-8?B?b3RRb2RZbG1yejNsSlRFZEw5OWVBRzA2OXpUaGtnYUxCaWZib1Y2UEc2NEo5?=
 =?utf-8?B?R2N1N0ZHMXhSd2VOWHFFUGRHTVJQVzgzN2k1K1k1WkgzVDFteVpsMWVLdXdM?=
 =?utf-8?B?RTExMDNIcTl4MG5OcS9Lek9LdE1zd3kwR3h3Rm4xMGRCQzRLajBYWkUvbEV5?=
 =?utf-8?B?TGJJTGFYRFBPcXZyRU1OYlRLQTk5d0RiM0EyVlM0WXBUaThMY1RuU3JBd2la?=
 =?utf-8?B?WFNDK1RjVmpHNzA1eEQ3YzluL2JnV051eHpaai8rSE1tZ0FzSVQ5VmUzeGE1?=
 =?utf-8?B?M1Z1eFdFR09QZGVPSFZjNWVLNmpqYkMzWUF4dFpMS2JYQTdwVTlFVDlVdnhF?=
 =?utf-8?B?VVdhWVVNT3dzQWoxS1oxbkhpaEZGSkZMWTBTY3RGU2p2Y2lQL1RwUnNJVGFB?=
 =?utf-8?B?VTI1VHZleGtMcEYveHlIUHdQOVJDcTF1cmhoS1Rsa2JaLzZicFhaRTM1L0x3?=
 =?utf-8?B?aHNibWNHYmJnVEVkL3FtMTFwWTh0Y0VIRmpoaXFmYkx3N1NjclBZVmR2NmJy?=
 =?utf-8?B?eUs2MEJHYm84YXR3OW82TDNSclE3Q3NJajJhWi9MeG52YUluNlRyM0dGbWVv?=
 =?utf-8?B?L0I5Z0I2WmdQZTE4YkttcG1qT290RDVMaUJQY2NMU1RaOXdHZm1BanVydUlP?=
 =?utf-8?B?RjFIaGFJWDBTSGd6YW4vSDhFR3JkNzduT0l6YXZVNmY0SWR1enF1SzhoQmZG?=
 =?utf-8?B?OUdxcDNJNHNMUFBPYmh6akF3RlROQUgzYnNneDFocnBOMllPSnVEcGJ6MEZi?=
 =?utf-8?B?RkhvY3FSNVpvb2lmMG5FUnl0eHhwdDRrMkFGcWlmUjlLYkdmMlh4d0NpSm9U?=
 =?utf-8?B?NVlEbU9xMXkwRGxyN3lIQ2JodldKVThnWFhxaE5SMEo3cnFYeE5ObUZEVUVa?=
 =?utf-8?Q?40m0OIy2vKAILZ5/6e0IVI/kf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1792f226-2366-41cf-cb41-08de00899062
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 01:26:36.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSQ1nQtcflwwTD4J7RELnXErHa2QOxAUyXqzEb2d/NmDGK+6jPzCS1wyoPs9eZL4lbbiyTUXTzwad6hgxAooIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9E4583E15

On 9/30/25 5:26 PM, Alexandre Courbot wrote:
> On Wed Oct 1, 2025 at 7:07 AM JST, John Hubbard wrote:
>> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
>> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
>> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was to
>> let NovaCore bind to the VFs, and then have NovaCore call into the upper
>> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
>> longer in favor.) So, in order to support that:
>>
>> Nova-core must only bind to Physical Functions (PFs) and regular PCI
>> devices, not to Virtual Functions (VFs) created through SR-IOV.
> 
> Naive question: will guests also see the passed-through VF as a VF? If
> so, wouldn't this change also prevents guests from using Nova?

I'm also new to this area. I would expect that guests *must* see
these as PFs, otherwise...nothing makes any sense.

Maybe Alex Williamson or Jason Gunthorpe (+CC) can chime in.

thanks,
-- 
John Hubbard


