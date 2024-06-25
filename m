Return-Path: <linux-pci+bounces-9244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8523916D5A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C242B2341A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABE414A091;
	Tue, 25 Jun 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CA/nlkhq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177716F29C;
	Tue, 25 Jun 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330208; cv=fail; b=SJmRlcE9xLm9aN5WGauKoTZ6yqAdSS8T14RmvPP6RNjlJvERrT/Ja8ZlgBuM0weSMT9nEYRHADhmT2ixDnjVkilOoXa636HSr2MjfWmxl+0aniM6SVYhN8gqxso4XJreXaFdaBYLec95nikfDBC+QAD1iqZKutkkmbBNjD3jRKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330208; c=relaxed/simple;
	bh=qPN/TajQR/gTF4PD6mHrIzm/3eXRuFNVFPTlreb3yxk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJV1X+KbTQL6o3btW7veXv3B7lbVsDgJnXfqCQFroqv1ul12fLJVFsAWh0HIK3f95Qmh8d5/6J9wXKYMLF9ucowXV0uvh+5nnHEa70+Y6rnfaNojofQkXO29OO6VAhf4FP56aHyG+YklN474T+9Cai1AvyuZ3rRjCqe/U4OkptE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CA/nlkhq; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwlMt7WHef7EDM+G7Pxo32Xp15l9+F1wYG9Hdn9dFmNCRYCThpPTl0zj+iMtljF1UMRbpAhT4Elf+ZBYLkx20CQkmOBqs4PoslLQqrbRD4Tv4CYpgeWH1gKuJL2rRVsixUz/HCIzr9rWdRpoUG/zOQ3lPbI9hjNO09E3ZOFgFimcOX0qI/Uhw7bjTHt9Aipu+VjpyhdbjnIe79/lnJYfwFIAgRBQFrisPzcbYrk3Cp4ZgRmyxgrh4Q7kuviSuXRkwuVHNDAE2AXzTnrPIn9/bGQ7eVUCbvx6gmvclfrPfXk2LDz3xXgaRVQhdd/DrMqQXipkVdVhgRbH6FWjApNfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU1BiNTBJEM9CwQDqQtq3dThJvgq9PRKvUWDxUV7JLA=;
 b=Suh/x0WVp20+pzBl6cDX+yebNdC0mG7i42coXa+n7zrLQYPxIRWtvJRzqSWfPqHzP6RvTZ9grMUV91UDooQptofqwJG5PALP6RecRONiYRbPIcZZZrEAnXO3pV4s6AimHHEnsahztmJAlOWcrLN29vkAeIbiXiTKHsQnpCOk62+TDIn/suAOp7d/Gl+ttOjjyV9eKwBnMlFIFkBljoZjuHISb3OebtD9CyVNcIwfkgIDdMssJ9ILD9E1maX3npcm6E7q8l2tPUs1urNp7QWejo27B/qhbZ/jEvkyIlJnl9CDV1PHCWSAj8QtNjHdCBEqUPoIB6u8Wl8vKuznle83KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU1BiNTBJEM9CwQDqQtq3dThJvgq9PRKvUWDxUV7JLA=;
 b=CA/nlkhq7z3v+U3UHQDmtx0F59B1/XtB0o7YYX8Dhg2oDnlCekT423mXqrLsmtTghGa2m8zb2sL4BjBYdpAmgHv/46BKgJTBeZqXgAGsbt+95ACyW1fD2nEaQLVNZVRCKz71593Gcs7QPIcaLgh0jPFGwLB21u6EZxIYcBj+ZQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 15:43:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 15:43:23 +0000
Message-ID: <a9436f1c-330b-469d-bb93-3e89102b09b9@amd.com>
Date: Tue, 25 Jun 2024 10:43:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Verify devices transition from D3cold to D0
From: Mario Limonciello <mario.limonciello@amd.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
 <20240618131452.GC1532424@black.fi.intel.com>
 <9f465ec4-32b9-4cd8-89de-a57a99880360@amd.com>
 <20240619052927.GF1532424@black.fi.intel.com>
 <5a04e554-9f18-43c0-8095-d3e0c83db76d@amd.com>
Content-Language: en-US
In-Reply-To: <5a04e554-9f18-43c0-8095-d3e0c83db76d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:806:a7::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af5a8f5-6ccf-4546-fa9e-08dc952d8bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkQ5VnY0bGlmRUZ2SU9sTFh0bHBsV3FSazhoSzVvV3pIRURyNzhTTHY1K1JL?=
 =?utf-8?B?WHRIRzNVWlcxM2RNWEU1Y1ppK1k4NHlCQnJwWUxaUytYMFhVaERCWkRxRjBC?=
 =?utf-8?B?U0VHMDdvc2VobXBPSGd3R0pvbC9mTjBGbzl4c25oWFF5c1NydlAvemNkbXMz?=
 =?utf-8?B?M0hyNXJHd05zSlcvd2htaUU1UkhXbys4R2hqbHBkYWNmTE01U0NnWnBYdFM1?=
 =?utf-8?B?SUR0MDVySWY3aExRaXlwZDZuZTQ0OC9lT0s0ek1lQnJOM2ZzczhTZFBkYmVS?=
 =?utf-8?B?WDkydSt2Nlk2NWhBd3V4MzhzdzhJR1ZZb3ExOUdjeDdrQ2U5SFRQOXlpNCs0?=
 =?utf-8?B?UUwzc3AzbktYSUdJRUtrVU9yY0FDWnpyejYrbXF4K2Noek81N3dTWWlwSXFI?=
 =?utf-8?B?MmI1aVJ3MXVnNUd5SEZVcE1iTzJDaGQrNEIzb0hOZ1kyQUp6Vnh1YXVzaEc3?=
 =?utf-8?B?NFBzOHZMdEF0TW5USmgvcFFKWkFBYUlTR1ZRd0VPd29xQmZ5bitheXlHNjlS?=
 =?utf-8?B?ajJwZFkxTC9MQXJwVEk5Tm9VYVNpaVA5TUt5ck16WklTaS9JMHNFQWtFR1NZ?=
 =?utf-8?B?VlJZcnhYNUY3U2F2ZTVsL0U2NUhYMlpJZTFOcjRCWXdxSXZZNlExZk5xeGdO?=
 =?utf-8?B?UnhFM0luNzJVdW5uU0tWbFdvdmErM24wT3dlMDZ4cjRyY3ZUMUJGN3R2T2xI?=
 =?utf-8?B?QU50UUpic0VlOVNrUHRZdTd4Q2tPM3l5L3B6TXVlTXhVNjBiWXRlaU9YT0tW?=
 =?utf-8?B?UU5GN2lNajkxYjZZcjAySElYUGhmZXZ2MkFjM3FqeVY3NmZQdVUyVzJBVXhB?=
 =?utf-8?B?ck8wdit0NjBVeFBjbHFRR3E4T0Y0WFRReHNkREsraGx4TzZ5SEVuTk56VE54?=
 =?utf-8?B?UVFUQjBXajlUdWFieEpBbnRJQUhKQWxOQWdOdVdzRTVNMlp6NCtSRjVERVhh?=
 =?utf-8?B?bDNOdTJBbUt5cTRiWDkxZzBrWXRYQ0xMODlDV3E1TFNRUzQ4TnN3WkVsQlpn?=
 =?utf-8?B?M04wbHJqKzBJZ0ZSc2NZbzBlV084RzZkUzFkdFdWa1Z6RHBBOHNDb2VEVkJC?=
 =?utf-8?B?SC84Tmprb2xabm5yWTdFNFBsNTk2Umowb1FNdjQ0Y2dYSVBpSGNiYktoZjVP?=
 =?utf-8?B?VEdQZWlvRWxrandUa0dWaFp1UHlZdHpBOTB5R3dCeURuUFJWN1pNV1lMR2Rw?=
 =?utf-8?B?ZTFpWE9lZFNzRmNzMVlQRHR5NHdRRjE3dkhtVzU4MER5ajBxU1I1M3RwYXEv?=
 =?utf-8?B?NTg1WVpnajljbWZiNE5LOHFSWlFwZ3M2VzBodjN0VExCSlRkZTlRbkxNblI1?=
 =?utf-8?B?VVZzcnhPd1ZjVHNxR0ZrUnBSNi8xU2NJdUVHUmkrQ2x2R0s0ZUsvRmFoZk1H?=
 =?utf-8?B?aVJIRzV6SXIzeGJ0S0h2VklVNWNHc0xGZjJkdXJNRGpHLzJtcXlRTENkMUFE?=
 =?utf-8?B?Rlo4MUp1SHRpMW9QMlBaSXM3b2Y3RGt2WlExNGVjc1owWStqREpZd0RDQTZi?=
 =?utf-8?B?RzliT3oxdDhrSEgvSDAybzZvUlNOR04vWk81TldVTlp2UGpxNGk0ZHllcnJa?=
 =?utf-8?B?WUF4Q09qaFdjT2lIT1NNOEVNak1DVFNBdmV0akhQN1J5MjBuSWpVayswdlYr?=
 =?utf-8?B?REpRemlqWUhwZ2Q2MXYxMG1hL2daYXI2WW9IRnk5MG5DMnBFZGhvRWFib25J?=
 =?utf-8?B?Ui8zLzcrc3FyNW9NaG41eGsxZ29NK3lvcXpPMU51RFAwNEl6Tm9qRnBvRnVp?=
 =?utf-8?Q?A2uWiI6cRrHcYDVnHSatg+3YMSZAq1NQbAmLXZ6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1luMTREYzFTSm1INm1YZHZFb0JrTmxXaE4rdm5wa2NQMzBrcDJjc2k3KzFh?=
 =?utf-8?B?U3lxZ2lNb2sxcko2aGJrREFzME9KZWRGVGJpQTJ4NG5NTkN5NmtOb1VXd3NN?=
 =?utf-8?B?UDN5TmJTcm9WSnpaVzFteHAzSVR6L3c1bUZCL2RvQWxsVmVQNWQ3SC83WGVu?=
 =?utf-8?B?NnFXcVh5S2lvLytTaklDVDBhMU5Nc0pHSkh2RTNrNWw2TFJXclZ3dmZlcUNC?=
 =?utf-8?B?d1pEdDFyRDlTcTBJeUV4cklLbEZVeFRla3VramVycFBSTjJlYlpZYnVlYTc4?=
 =?utf-8?B?Q0svRU9IZTR6OWptQmp1VHZQc0ZpYkUrYTR0YWp3TVVhMkd5QXMyaHhJVkdZ?=
 =?utf-8?B?UHVLM3h6VjQ4MTNIai9TS1Q0TkczUnh6RzROSDVZYlpLL2dKdDgrMDkyYXlY?=
 =?utf-8?B?a3ZPZmtUdTZWTXczM0NhQVB6bW1lUGduamFRbElmb2o5OFR1RXpZNzNoazA0?=
 =?utf-8?B?bzNJKzYxRnJYQTd3dDhFdStHbWcvc1RSVFZmazZVb0NVMkF1b0F0U1owN3pD?=
 =?utf-8?B?UGNkYkI4ZXhXTkRQWWpDL3p2cDV5S2FIUjk4NXNnZ2FudlVFRnRYaXRLSG1n?=
 =?utf-8?B?eUhRZFU2enErSGh2ZXFrTjNLOVFkWXVvUmgzQ0MxZTBVSlVBNU1GazhNRmlU?=
 =?utf-8?B?UU5WSzlzL2U2TnU3WlJjUVFWY2l1WEJDRjhDdzI3YlBKblg3UDkzVXF2RDVi?=
 =?utf-8?B?RWtXdlp0ZVNIOE9QcFlUeTN6YjI5Z21lK1EweE1EUnVNeFB0MDQ0bjlVWmQy?=
 =?utf-8?B?NThORmZvRTNMTXk1cElFRFBaYUpzMnZaMHVmOW9OTUZCUUhCWTloYldxd01L?=
 =?utf-8?B?ek1Nd3BwODd2UC9GMEdxdEJQZDlnVlZYWitqTWZYdHZ2Nm9jM1djWGNZK2hx?=
 =?utf-8?B?TWtodDBSZWk5TWp1dkUwdVViSjQ1MjluaFAvZmRGWUdwRWFIM0IySEEwSVFN?=
 =?utf-8?B?RWo0Y3lWNlRISnJVQkJ0V1M2QXdoM2RVTG0yb2ErS0g4OFhtT3FjemExT2hh?=
 =?utf-8?B?emo4RDJlMThzNUlMMEozZzE5anhEWXZpak1wMEZ4b1ZZM2ZqeXptb0lGL1pk?=
 =?utf-8?B?M0xKNktadDFGUjZFVTk1Qm0xZkdpNnhrUzVwMXlvOXBFWnhXR0NMUlliQ2lB?=
 =?utf-8?B?NGhURjh1TjhSR2k4ak9pQ1RhYTQ2WkJwREswMkZscFZlbnNUUThpSTZGM2lx?=
 =?utf-8?B?a0J3RVNHOGdodHU3MlJabW11cFpmNDRuYUo5WnhaMjVIR09DT0g1dVJiUFph?=
 =?utf-8?B?WTNvSlVBSzdXY2pWNUVyNWJVOVZRQ2J0Qy9UUExFRit5ZHJ4Z2g2ZDZvdlhy?=
 =?utf-8?B?cmFXbUU4dENGNUEyc3RMdVNyQkRRdkJieU9pY25kNjN4M1VveWJidVhxbTR0?=
 =?utf-8?B?Si9zK3BaVUM2WkpiVWxwdXBkVWcxalRwaEoxcFJFUXdPQmdkbS9yc0ZNUkhS?=
 =?utf-8?B?dmxiNkk4aktZWjl6M1VkanFFQU5xNVhGYTZGdzYweXVjYzVqbkhXVHhicWxq?=
 =?utf-8?B?cXNDWmFMMWNobXJiZlZXVS9SYXk5OEorZW9oeGRFWmNPaTJkVUVRdE9NNVFy?=
 =?utf-8?B?bTIxWVZTZGZRQ2pEd1lRYTVOdHNEQWY1alJwZlA5cVNzUkQ4R2RUYm5mOVV1?=
 =?utf-8?B?ZnZuU0NsampFK3ZuSVZWUTBpNjcySWtCSlhXa1RUS1pwdkFYNXJ1amVveWRk?=
 =?utf-8?B?blhjeDdtVStkMnNjU09UaTZCdmJZdWQrMkNRdG41RkthTk42VGw4ak1BMEVO?=
 =?utf-8?B?amgvT2ZVU3J6cmt5R2ZFOHBwUkZGOWZGamxzY0JOOXlDc29xSEV5ZFh1Q0JU?=
 =?utf-8?B?aTdCUVFlTVlCYmxVYThEbWpMc0d4TEhUN0RwTkgxR2MxQ0ZFWkRuelNKUCtB?=
 =?utf-8?B?L0tWdThLWndFVHk0bmMrQzkvZE80SHlFUVVjT29MSmIzKzdnWkVWWjRWTTRm?=
 =?utf-8?B?cE91anRNc0dtSmpEYms0dkdZdjNhQUlyU2twaWtIdStKTlJkUkZJak5FeHlq?=
 =?utf-8?B?NC95Nll1RDNhYlpEZi81T2FybHdHWUlUMGlxMjBQTWJaWlZUaGRHRlZOcUJX?=
 =?utf-8?B?V21DUys4dG9lMTBHTU1YMGVoM2hQM0ZhVzNyN3NoODZoMUlsaFk1dWM1WjFN?=
 =?utf-8?Q?iClLN+DdfFwwgESn8BwoNarS/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af5a8f5-6ccf-4546-fa9e-08dc952d8bd7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 15:43:23.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNgYPuoaY5v26TEZ9Lm+vrualtLpn/sOrlxC8eZRRUmd7gM76qm2DZ4wZQPUWKV7QTS3NSzZXikuFXEw+NKOSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332

On 6/19/2024 13:50, Mario Limonciello wrote:
> On 6/19/2024 00:29, Mika Westerberg wrote:
>> On Tue, Jun 18, 2024 at 11:56:50AM -0500, Mario Limonciello wrote:
>>> On 6/18/2024 08:14, Mika Westerberg wrote:
>>>> Hi Mario,
>>>>
>>>> On Thu, Jun 13, 2024 at 12:42:00AM -0500, Mario Limonciello wrote:
>>>>> Gary has reported that when a dock is plugged into a system at the 
>>>>> same
>>>>> time the autosuspend delay has tripped that the USB4 stack 
>>>>> malfunctions.
>>>>>
>>>>> Messages show up like this:
>>>>>
>>>>> ```
>>>>> thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX 
>>>>> ring 0 is already enabled
>>>>> ```
>>>>>
>>>>> Furthermore the USB4 router is non-functional at this point.
>>>>
>>>> Once the USB4 domain starts the sleep transition, it cannot be
>>>> interrupted by anything so it always should go through full sleep
>>>> transition and only then back from sleep.
>>>>
>>>>> Those messages happen because the device is still in D3cold at the 
>>>>> time
>>>>> that the PCI core handed control back to the USB4 connection manager
>>>>> (thunderbolt).
>>>>
>>>> This is weird. Yes we should be getting the wake from the hotplug but
>>>> that should happen only after the domain is fully in sleep (D3cold). 
>>>> The
>>>> BIOS ACPI code is supposed to deal with this.
>>>
>>> Is that from from experience or do you mean there is a spec behavior?
>>>
>>> IE I'm wondering if we have different "expectations" from different
>>> company's hardware designers.
>>
>> The spec and the CM guide "imply" this behaviour as far as I can tell,
>> so that the "sleep event" is done completely once started. I guess this
>> can be interpreted differently too because it is not explicitly said
>> there.
>>
>> Can you ask AMD HW folks if this is their interpretation too? Basically
>> when we get "Sleep Ready" bit set for all the routers in the domain and
>> turn off power (send PERST) there cannot be wake events until that is
>> fully completed.
>>
>> There is typically a timeout mechanism in the BIOS side (part of the
>> power off method) that waits for the PCIe links to enter L2 before it
>> triggers PERST. We have seen an issue on our side that if this L2
>> transition is not completed in time a wake event triggered but that was
>> a BIOS issue.
> 
> Sure thing.  I'll discuss it with them and get back with the results.

 From the hardware team they describe this as an abnormal state that 
they don't expect.  I don't believe there is anything in the BIOS to 
prevent it though.

I could discuss options for this with the BIOS team in the future for 
the USB4 router ACPI device, but as this "seems" to be the same problem 
as XHCI controllers going back at least 5 generations with those quirks 
I put reverts in this series I think a general kernel solution to make 
"sure" that devices have transitioned is the better way to go.

> 
>>
>>>>> The issue is that it takes time for a device to enter D3cold and do a
>>>>> conventional reset, and then more time for it to exit D3cold.
>>>>>
>>>>> This appears not to be a new problem; previously there were very 
>>>>> similar
>>>>> reports from Ryzen XHCI controllers.  Quirks were added for those.
>>>>> Furthermore; adding extra logging it's apparent that other PCI devices
>>>>> in the system can take more than 10ms to recover from D3cold as well.
>>>>
>>>> They can take anything up to 100ms after the link has trained.
>>>
>>> Right; so currently there is nothing checking they really made it 
>>> back to D0
>>> after calling pci_power_up().  I feel like we've "mostly" gotten lucky.
>>
>> We do have pci_bridge_wait_for_secondary_bus() there but I guess that's
>> not called for integrated PCIe endpoints such as xHCI and the USB4 Host
>> Interface. They too enter D3cold once power is turned off so I agree we
>> might have gotten lucky here with the D3hot 10ms delay.
> 
> Yup; exactly.  I think when Gary found this he was seeing other 
> integrated devices not being ready in time too, but IIRC there wasn't 
> functional impact from them like there is on XHCI and USB4.
> 
> 

Bjorn,

Considering the above, can you please review this series?

