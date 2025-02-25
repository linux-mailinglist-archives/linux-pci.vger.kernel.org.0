Return-Path: <linux-pci+bounces-22288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA42BA434CF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 06:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6573B4977
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 05:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B21527B4;
	Tue, 25 Feb 2025 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MWMy7NN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13036124;
	Tue, 25 Feb 2025 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740462615; cv=fail; b=AUAYhQM+g/gIfh+uar8aeHF1Ki6dm9qWk8N8bGQufhrc7pmBWJ2cUZ+lu25z41eppZTCZTd8+kS2CTgadtprRByueSDz/DZy3+F5cI9hMTbz9+rXqUxayXMa9rKVs1mD2H2CV2sWn+qlQkAsHaU2clYPsQavF9e3oyQJpXzdcvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740462615; c=relaxed/simple;
	bh=De9HflAEHxMDdFHLBnxanByIo3+poRQLcGt8Pm7AZe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=npAIFpfV03lohoBZ1O7tpqgPMSfglnbTP7wZfp7EK4ySTd9Wgvx8Y+XGuXie9bFLgBCJ4GnGYeLeK9d3scEz0j33lGZ7suVtJntsCG0wCEKacGItTVGiJJXMtFsqaOYcoZ8r3y3voPJ1ZKokhjYizKwfnUHL1CONuTUolR16Nvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MWMy7NN9; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEJIfG+xGiorMtcotkXmPMx1USePDIcqT5xlM8qe9sX9GQEr/Htu6RQDNcMclMA/VjSk0/S4LkkrhBmnMAYvoArll5UwYC5CYvJc/52zGl+OPzzdqScZawrjSC+rKN1Je/z4/JpyoLgSNZzJ4L57VWRHTyheACHlABJCABErfSLGPS+f6FKeQdZ4vO5v3hkxL8YXnfAhBIjsXnioUGSeg93Rocs1GRKIXynAB6HLpBwGkKb4do4uMYBlgMVFENDp1TaejoJouTp81Ddkm6aMxKUrdbpK34Td57cxlmoLLh/tEhEo/H5/FtoXyPAJFITQBQZhoWSA6GSkpFVJgqrwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fplV91QASSm99aHRnQEj8sdb8Ms1z7g9mZJRNTp8oLQ=;
 b=whTG4+UEuA9fw5Cejj5lJ0UVDBKpZS6/5YPwHeZBbun02nAlqxfb356m59+/GvHFs6f1PG9GcY97/6dgDbpYcdJEa90vB/hxjYT5Yzsu9xzKhIn+VluK9vkwnxtu9Kv9/HfBGzVKk95p/hK7pwxAphLgFAotFCclNgods760qpMqsKPhaVvznxAUs2RBdj1iJKznQoQvJYEwxO5vsmWVMS/gEmxGFyVGnZjCDnTUTKITqcrUGy3fIP6Rv9U2Vux8kxOq/ANIj9MLBJcPmd8WS4woyFkcT0q9TUSN8qmQOi/eTDpOSu69Xl6Ny1XpMEJveQfPFtLxxyRInZt6l4cqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fplV91QASSm99aHRnQEj8sdb8Ms1z7g9mZJRNTp8oLQ=;
 b=MWMy7NN9zVfi9jjxuKglEddLpTGOvnSHfj9ICkEqbLx/clnZPNoJnG1C+GRUbH4dwpc/bH5jO6oB67gISmJ9RV3gUruok129mo9neCVuMX3ESTYINWCmmDN07NbAg2H4DJdnaXr6RPzPWoP3auhJLa8zq615qG/CXVu/bjTT36Roo+qc3HdPUfPPZKwXK0fWesNQRmWQofGeCMkLYpbJc+jmwwNSp968usuJwAcZ/VtJREpeeqsHVEuWFEwT5sw4WJhctjNLIkfYJKutDA/ec52ZDjB+l3ENr/1bczAOBJ1YLqe1vOT8VUlqO7/4Pykfk46eroXr5ES9CxCgKiUNcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 05:50:10 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%6]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 05:50:10 +0000
Date: Tue, 25 Feb 2025 16:50:05 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, j@jannau.net, 
	fabien.parent@linaro.org, chrisi.schrefl@gmail.com, paulmck@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
Message-ID: <wnzq3vlgawjdchjck7nzwlzmm5qbmactwlhtj44ak7s7kefphd@m7emgjnmnkjn>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-8-dakr@kernel.org>
 <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
 <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
X-ClientProxiedBy: SY5P300CA0019.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::11) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|PH7PR12MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: e34f3c03-e034-4347-1c5a-08dd556043e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGJFcE9LcFoxZ2NOR1dJcWFiMlZNNjJaS1FrZTJkNXBsa2drUHY2TDFTWHln?=
 =?utf-8?B?c1I3eUI4SjVoTVJDTmtXN0w5N2xaYjVYVTlzaGVTZi93K0xOd0cvd0JoS1c2?=
 =?utf-8?B?NTdKVU1OZ01jcTZiQjRHRFREaHVKNkZFaXRKNXZMN3g3WXRUeFZWdFlTcXdZ?=
 =?utf-8?B?NG1wa3piOWc1SStUMnFTRE1RS1N5anJjTVhIcjNKbnBJS2RTQitMbzZPa1pz?=
 =?utf-8?B?OFM3RWJpNUducUNFT3lIbU5jSzZWU243RVN5ZVkzeUppUnRWeWNZazVRaFFH?=
 =?utf-8?B?b1dROGZHZ0ViT0gyRDR4YkQvdUVQa1o1REZIQ081dTFIUG1BYitlQS9FbU1R?=
 =?utf-8?B?QktGN0UraWF5TFpObDMvQXdWbWlySnEvZnY4OHZ4WTV5bnNUTndvSnVHOWZu?=
 =?utf-8?B?N1BUMEhYOFhhRDRIL0lSTUlhYzJqT2FLZ3VPbmVlQjg2dHNQUElza0s3emRq?=
 =?utf-8?B?cStLMmk3YTlCcktScDlhbWpncXJWazBQTUxSU3MxakQwZWhrckdpeGRLcjBP?=
 =?utf-8?B?NDQvZjA4WVRJOXIrNFVWdVVwazRnZ2lIMCsybzFxZHNnWDR2c2ppWmJqRlY4?=
 =?utf-8?B?ajBWQ2U3eTFrRkRZZGhORm5XMTNBRzVZZzZmaVNvSlpidTBRQkxwZThoTTAy?=
 =?utf-8?B?WnF3MUhZclc4ZkIzaWJPMlQxU1UvdURSN2xUOExIb0wzTTlRRGkvNTR5OG9N?=
 =?utf-8?B?M1JucG5kRGRTU1lsN2xmT2VZem9rYVdvSm1QZ2VZeExuYjVib29oKzJZeXZ0?=
 =?utf-8?B?aEl0Sk5WWXBYQ2Z4ODYvM3V3OG1iMHNjZlJIKzJrV2FXdFc5b0xjeGdIV013?=
 =?utf-8?B?WFZMK0VsTWg4WmljdCtQR08rZEVqT0xBSU9GUmMrSnZqL3ZVRGpOTUVZbUdV?=
 =?utf-8?B?ZkRhdWhBNmlsNUQwdmVrbThNZzlBMURxOFFxY0wwbVYyT2FyNnk0cjNXVFpp?=
 =?utf-8?B?Q1B5RSttU0V3cTBKYTJlUUdaT1U5MVhtUC93SmRYZ25MZ2VPMU4va09aaVBI?=
 =?utf-8?B?UWZnb3lMeWhpc1gvSHcyOXhKR01Yb1NyZTM2ZkxEZFV0VUl2cHdhL09lMzBB?=
 =?utf-8?B?LzdXUHEyKzNDRmpXL1QxLzIvTm15Y0VHTUpkQ1ladm02UDJkZmFFcFI5NVdS?=
 =?utf-8?B?amxRN0NrNmIyNGdrQ1VzNnNmd0FvOXZ6K0ljY1pKbngwUlIwajFWdzVkeElK?=
 =?utf-8?B?aHQrV014K0ZNV2x2WlVYOVZiTU84SmdKNDNLUXlCQ0J4TGNzalRkSnEwKzFp?=
 =?utf-8?B?amZuUTd4aDBmWXduN0dyTURIUW1oTGxwRElvMmRjenNVWGNmUzZnbXZ0a2hp?=
 =?utf-8?B?YkM3YVpmeGxPdFNrM09rbWJzaHJENUd4dXhQNnFzbjYrWUhsV0RrTWZ5SGZz?=
 =?utf-8?B?eDk2L09OYWhrM1AyYWFHdi9xenU3N3VlYlFZdnQ5WUc1eENVL3VreDFNalJp?=
 =?utf-8?B?bmFVeFBpYVZSRVRWb2VDOUx0TVJGTmZOUmZrelNJa3EwSzNNME5MK3VRaVA1?=
 =?utf-8?B?ZFNCRUlDZUlVNXZVSUdZTUdHSk1xR29NOUdYakNPR2IyWjd0VlNFdlJ5SDhG?=
 =?utf-8?B?Vm9EVEZDTzJqR2RQQmU4UlczeGZtd01pOTJsMURNOHBuOEJpQ0t3UHU0ZDlT?=
 =?utf-8?B?TFdIckR0V2ZhdzIzNnNSN1FYWkxveHhudTh0WHVpaVVDMytTZVFJb1N2amdY?=
 =?utf-8?B?clV6b3RlYjQ2TDJHWm9xTUFZQU5oQmxQVXYxSXdTcTlqaVhGUXB5SzlFeTlz?=
 =?utf-8?B?YlVyZXZ3cFc2MmMydks4VWlrMDN0MU1qOENRaWxBaUJSVDRJSHJLUHlmSzAr?=
 =?utf-8?B?MHo0dm5UYzA1YlRQc012UEVpSE1mRFZRRGZmNnFPVlJPNnBjOGhvOER2QWdN?=
 =?utf-8?Q?usWJJu2wtMkzA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUpuWWxhOG8weUxndUNMOUNuSndCc2NHRkdpZ1ZRNFU3a0pJSDYydmhyVXZy?=
 =?utf-8?B?bGVlOHJrK2hjL1dQb1lWNFA3b0o2c1lCRFVETXUvRDNwL21WcFRIdVp6bldh?=
 =?utf-8?B?eGplVHpOa2VYV050Ty94YVIvUkdOTnMvOXZvS01WRk9DbmxEUG43cWloUWt2?=
 =?utf-8?B?YnE0R2U4QjRjdmRqYXRqZzlnc2NvY3JMb2RmZGFYSW1IbUozcWE1dVdUQ1F1?=
 =?utf-8?B?VWVaM3lHamJXSm0zMFhGaGsrNXZHU2FydCtMRXFHcENiVDR6enkxNXp5K0Yv?=
 =?utf-8?B?NDl1STdPTjVnb2F5VllKaVdSUEp4bUlVZUlqeDgxOTcwWkR4YlQzYjIwNmhC?=
 =?utf-8?B?N0RKVnNFeVM3bURlNFNqcDNEeHFYYStUSklyYmdLS3VLaFNCODVzdXBMSUJa?=
 =?utf-8?B?aHVabnFkS20vbUQ2VlBXU08rYmVLdmxGNXhiRnhpbHo1QjdhYkNvSzl4cWUz?=
 =?utf-8?B?NUZnZFFodzhKTC9vR3NMK0dtRlBtU1Q5cndDS0pYVE1OVTRsT0pHQkFvOUFH?=
 =?utf-8?B?cDVlK0ZrU3BFUWx4TEtwcWx4Z2xDZjNkdHUrVVdHazZwMzRaZ05kOGpKMXdj?=
 =?utf-8?B?a0NJKy9hZWUyamw4NEpCbFpQUVUveW1pQy9taC9kd1N0V0VsTXAyRTZCZWph?=
 =?utf-8?B?V2NmQzByaVVyTlJBdnRnblhqQ1ZCdEd0cStqZzFrMTNJeUdzQ0VPNmgxVzMw?=
 =?utf-8?B?ZnJXSklYMlNPcU5LQm5URWI4UDFTZzNvNWpSYzgrYnRBUUEvOVpOaUowRnUv?=
 =?utf-8?B?ZU1jM1hRdEh5V05RZlU3RmlhWFZjSFFvcmhOblh0S3Zlekd3bTlQd0lOdUFm?=
 =?utf-8?B?UkZLbm9Pb2k3YkR0NDZ2U0llU1p0RnNlTGN6SG1ZakMzVzZHeGJkK1RFVGs5?=
 =?utf-8?B?L3pzUnROZXBEeU1jVGRSaS9tVzR2MWhKdFdrUlVycGFVOTV6REdxRjU4ZUJk?=
 =?utf-8?B?azZEUGxnUG56MnhXQklSTTFWZSs2TjVtUDFDSnFlaDQvSko3TzMrYkNacnZT?=
 =?utf-8?B?V2RrcFRrdHc4YktVd1ZFNW10SnBKbmN3OE43WVFiaUk4T052OFlZVzE2Unl1?=
 =?utf-8?B?aVNmSXVFR2JUSCs1eUozK0xac3pmV05Lai8vN1M3aHBhWUV6UC9Dc2NxS2w4?=
 =?utf-8?B?TVlHVUgxNFlzNFlkTXI4bDFaaGptTk4rc0NQZk82emhGc2RPZkczMGlwNkdB?=
 =?utf-8?B?U0licEJNZkxaa1RHcmk0Vk9CK2VzUmlOZ1hkZjhjc3d0NDZPWjZhaHYzOWVx?=
 =?utf-8?B?OGd6cklOekpJekt1WHUwZEp0QWx4QW1zdHFFZ1g1REU5cndYaEpONytUY3Bl?=
 =?utf-8?B?SjdOWU1iS2txa2ZBZjNNa0c3TERtZGV1YkVYNGlQZ3R0UmpiZXY0TFkwc0Fv?=
 =?utf-8?B?L2QzUEVvZXAxWG9mazFnS2paaVdRTml2bFphMjFrTmpVZlhnZVFRcytTcWZC?=
 =?utf-8?B?aDgwRVB6a3hRK0M3YW5aNlJ0M0JNYUhsamM0eC9sYlJUUUJqa3NkeVJ3ZldQ?=
 =?utf-8?B?ay9DT2d0Sm96STE5bUpuM2o5bG5RelFmbGkzS0R1R1hNcG0vRDZlOVFqYU83?=
 =?utf-8?B?dEVQRFVDYUhTd1o0aGNvSmJSZXpKMFRpdEovWmt1SlVqaUM5Q0xucXNuUWZC?=
 =?utf-8?B?UnZUbndnUUhybnBQRUVQYXhVMHFDL3NKZTh4Wm5SSmsrSFE0Z2xPU3FPSWtT?=
 =?utf-8?B?ZGJTVVdpY2tYUldGQklRVk9xaWRTSU1aM1UyNmovUDMrTlFCQlc4bmtIVmpo?=
 =?utf-8?B?NTM5UUM4anovL1AvTmJGV2Fzb1phNUhzUmpRenk0SWN5SGRJejAwTDZTc0cz?=
 =?utf-8?B?eC9BNm9kbkhKaEVNdVhCbGdLZ0FWa1pzcXBsZ0FxYXRRVXJoUVdrOFNFTFg5?=
 =?utf-8?B?Zno3bTVCUmZmVmVWV3M1RVpId2dVa0lHay9yUVlDc3E1YXdJeUE5TDJOSFdB?=
 =?utf-8?B?MzlqSENaUnNlWDVMSHRwUXRVbG5FaksydVc2eGZoOCtrb0liZEtMck9iUENV?=
 =?utf-8?B?NDVxRUFncDdtTDZIbk9LRlR2T1lZVm1nOFNwU0FKNEwyQ29LOXBlbXpDSTlm?=
 =?utf-8?B?MzJrNWg1VnljTGYrOEJwUW9ESk4wL0RuRDFwajZiQVlZdmlrRVBYajJXTVFl?=
 =?utf-8?Q?FzdPQMBjkF/1X47olyq3JvWJ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34f3c03-e034-4347-1c5a-08dd556043e4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 05:50:10.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wJlgULlBT0Y/2KvEFNWtiSZiEJKCVP4Gx75ripgzyXhrSFtWfmQqza/fEf+UuTIkqtwJH0wslvw4GF6xSDgzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952

On Fri, Feb 21, 2025 at 04:58:59AM +0100, Miguel Ojeda wrote:
> Hi Alistair,
> 
> On Fri, Feb 21, 2025 at 2:20 AM Alistair Popple <apopple@nvidia.com> wrote:
> >
> > Is this a known issue or limitation? Or is this a bug/rough edge that still
> > needs fixing? Or alternatively am I just doing something wrong? Would appreciate
> > any insights as figuring out what I'd done wrong here was a bit of a rough
> > introduction!
> 
> Yeah, it is a result of our `build_assert!` machinery:
> 
>     https://rust.docs.kernel.org/kernel/macro.build_assert.html
> 
> which works by producing a build (link) error rather than the usual
> compiler error and thus the bad error message.
> 
> `build_assert!` is really the biggest hammer we have to assert
> something is true at build time, since it may rely on the optimizer.
> For instance, if `static_assert!` is usable in that context, it should
> be instead of `build_assert!`.
> 
> Ideally we would have a way to get the message propagated somehow,
> because it is indeed confusing.

Are there any proposals or ideas for how we could do that?

> I hope that helps.

Kind of, but given the current state of build_assert's and the impossiblity of
debugging them should we avoid adding them until they can be fixed?

Unless the code absolutely cannot compile without them I think it would be
better to turn them into runtime errors that can at least hint at what might
have gone wrong. For example I think a run-time check would have been much more
appropriate and easy to debug here, rather than having to bisect my changes.

I was hoping I could suggest CONFIG_RUST_BUILD_ASSERT_ALLOW be made default yes,
but testing with that also didn't yeild great results - it creates a backtrace
but that doesn't seem to point anywhere terribly close to where the bad access
was, I'm guessing maybe due to inlining and other optimisations - or is
decode_stacktrace.sh not the right tool for this job?

Thanks.

 - Alistair

> Cheers,
> Miguel

