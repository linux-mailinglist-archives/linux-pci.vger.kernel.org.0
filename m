Return-Path: <linux-pci+bounces-17890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CE89E849D
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DB8281400
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 11:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEA576025;
	Sun,  8 Dec 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lChJCs9W"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF7EEB2
	for <linux-pci@vger.kernel.org>; Sun,  8 Dec 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733656873; cv=fail; b=k84AX1QjB6RNvmQJJDKLu1Fe7x0xFpiTik2fOpTWoI4YuRevUZcIblt6x86YD/O8BXbschskyHViobY54OsPjjX3yvBUZZFK9hL5xDfNZH3QUEY6AoXHvDOEgtwHnCrlRr2y9vHL8kXkXhB5jPIOzveL8XFNXsS9Za40QefzF2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733656873; c=relaxed/simple;
	bh=GstEkf2BoHAqNVr2WyZckCHjLQFpplHh78J5/LSadMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=osaHpnbXb6hjXqr6Nb1LZJhteNcNRFAvppYPXq0c4AYPHxX/TJZCOHrbiaUTW39wptbgxFXxshNiMblVweTPhYrf002eIeaXTJ1OSFkW3RnQFA4B5KvSyBREjBEaVwzRIpaPqtLx8rg0XAifKs/diCTHeWvIiBL0lJijIN3CJHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lChJCs9W; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRbXzuoHzpJ7MAMUW9HevnMQCkUIRnPkWlXdXRcEw1pL6QCvi1gJTELXjhSxulhDNk03pVWA0YmB3Ea1PbTwg6B8awyr8rLzwsKuTDlVUuuPhqFj2O5DpWALT0Sci4NCChi94kSyHpRNqKrpZJY0WDKR2PLltBlDn3KhQ6CzeXEPgVPBT/DfNYpoBlq7qvxf+JEZNqmp8ukYXoMjEtuTeCDlhRDNjwXVB7VNT5mEABkkLWIW5KLo/Lpc1uDZ5MZ93l/2qfy/Sd9IHzK+VgGHANofz7DHhotgPLP1d+PuAoGXrM8oN2wjjQopfi2UHnOHIbiTIP6xxmse7SwKMVctUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbKO0HEnmAT3dsDrjgCuKeV037h7I86nu8XYX2gUXkA=;
 b=Cx9o5JpEsEanwnCjD9ptXeMpLV4SSbtL3Oc4X12mM7nu0FSv3vOozjy5goHIN/VSM3FzGMZKvaE+8a0LRNb+rsrcKtoGs7GeJqMOvA03CSToZc269vkK06OvfcdYM3yTwhR8wXWMVQZHcdtNB9nhWdncSD/1VrT//HqOJGSIXIHRmy5wkslPcTrAye/MS2d2v27OmzNh0q1LHL7r6lH8BgufYyhRypiQlNtMz6CRs4hDCxLB7J1Ivgd0FgcAC0mBgGoNS8MyED8y884odMc6sLZPG3Ko0JuEyhbpff8kndgHgW2Bm9uL5szgV16aA5M9oNmsTEPjnaKiSjUF3Yo81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbKO0HEnmAT3dsDrjgCuKeV037h7I86nu8XYX2gUXkA=;
 b=lChJCs9WsVcmE1S/dh6qpwPrSZFVFZ8IY75TgUTr6U18eHv4eCCDBGFqXLF4ynhDybJ+4viD1OgqvLKAj227bpss0zqmUxIUVjnsQLWSBP3wQekUBbXhdBDkh2Oqg0CLJqngZSOeExi6yPl08zI84caOjlgXU8nHTpCilQ0n9O8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Sun, 8 Dec
 2024 11:21:09 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Sun, 8 Dec 2024
 11:21:09 +0000
Message-ID: <6b1d3a0d-1df7-f81e-ea87-d455a4caf1b8@amd.com>
Date: Sun, 8 Dec 2024 11:21:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] resource: harden resource_contains
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, alison.schofield@intel.com
References: <20241204232422.GA3027254@bhelgaas>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241204232422.GA3027254@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dabf765-a4ed-46b2-f5f5-08dd177a6a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0VxRVV2azV1T2FOT1dqQWRNa05jMmNOTXB6UTk5ZDlubDlER3dqUHg3RUVN?=
 =?utf-8?B?aE54SVRndXRDUVkwNW14Q2hQdjltRU5Fa3RQZzgrQmlTYVU3TXNBdTRCN1Zs?=
 =?utf-8?B?UjhWVnFkWjRIcEdQY0xQdFk4YWtpbmY5T3QxWEgySXFsK1d6Z0hGTjh4dWRh?=
 =?utf-8?B?NTREMzZKbkJwVFYwM1lKWmo0dlhEOURXUlBpWi9nSmNVaFk1c2hqb2xQblBV?=
 =?utf-8?B?NUpUZjREK0JiaDJaeUZxZDk2OWIwbWlwT2FSQnh0MjhvS2dhL3E3aVRTeGE4?=
 =?utf-8?B?Q0VPVjREbmcxUWQyVG04NUViVk9ReU5hT0VVcnNndWpVU1lESDNPdDEvMEkw?=
 =?utf-8?B?dW1PamlxMlFUdVdxUHdYUHprZ3Bmb2NvM1lCejdDWkJ3UUVYRHpWc09ZVUF6?=
 =?utf-8?B?OW91b3pMZGk1cGZHZXNPcW1uc1A4aFZna1dIaTBjMVRxM3ZNclRhRlB4VFIv?=
 =?utf-8?B?V3NHUWZlN25BZDAwQTROTS9ISGFkUEk3emVLUXlLTkp6Z3JoZ2pwaWkvZjVu?=
 =?utf-8?B?Mjh3aTI3S3Rvd1ZoRXkxVjVteFlxYkdIY3c4T3dqTGw5RjAwdjdqUFJvOVVM?=
 =?utf-8?B?S0NOQ1BmVFBVR2lwbjNmVEp2ZUx5VWdqV0ZSMUxyYnJ0ekp5R3pza0pQSHFy?=
 =?utf-8?B?ckhwVUtaQktiemVKRWN0dkc1TDIxeWlMTUNKZm5MNk9mYlRaZThMaEkxK3hi?=
 =?utf-8?B?QzRFQTZSZUpQOTBUK1hDWW9GUzFZWlh6RVM4OFpOM1ZIV0cvcVBVa3pPZ2FO?=
 =?utf-8?B?NmNjdmwxOWk3VDBJSVVOd0Q2ZjE1b2Fmcng4ZG1iSVN0TURxZ05HSFU1L1Q1?=
 =?utf-8?B?dzQxaXM5QXZwVkFNTHY2aE01MUJ0TlZDR05uUjJtcDRBc09YR0h6aVUxQmxv?=
 =?utf-8?B?OGxneUF5VGY1NzhvRzZIcnkyV3lTSVN4TUFDMW5qYW5UQU9qTmhhWWxENHY5?=
 =?utf-8?B?d1dmTGMwaVdJVmtCMDRieDM4ZHRQb01sempZS2ZvbzNqZDRGSGoyQkNweWRw?=
 =?utf-8?B?RzBGc3phSUZYUG05N1d2d3A3NmttSkc3ZnE3Vzc1cEhuUGwvNjE4VUZ5UHVV?=
 =?utf-8?B?TDZ1U1ovSnFVOEVXYk5XRVU1ellMMU5YWjJZclhQcm5IWElJcytENTdEMTBp?=
 =?utf-8?B?eER1eEJLRUlpRzd5ZEFVeGtSMWcxVzJ1Sit6ZW5LU1ZaL09PUGJXMnZqeDQ1?=
 =?utf-8?B?MEp2MUxkdFBsV0R5eHdlalQ2ZlI5SkxmOERYTkRUUU9YZ3lKbVVUNFQwRmtp?=
 =?utf-8?B?NEM0UFU5Zzd2UmxVR0hDSldKSERHRzB4ekFFTHBlTG00TWcwZFZGeFd0NGEy?=
 =?utf-8?B?YW40ek1wWldFTzI4UUVIZjZEY3A1U0JvRE9yV3FQSzdLY09RYkxJN1ViWkcx?=
 =?utf-8?B?cFVxaVJYeFVaT1FMKzZ3RFY5RldkWVllYkdNMGhJdFlPRnFLbWxkNDlOakxY?=
 =?utf-8?B?b0xqR3F3clVqT29FZDRLdGdQc2RQcVh0U3U1eUp1TFJ4VXV5V1lCelJ5V1FL?=
 =?utf-8?B?NjlMKzBBK2s4eFZwYUg4cE9ZVTRGTTBWQUtDd1U4MTQxWDg3bTZhYmVEb2pP?=
 =?utf-8?B?aDhkWEJUWjNGajF0QUlFRUVPQ21LVytvczkvMTlxNlVUa21yeEdhbXNhNDVs?=
 =?utf-8?B?SGM0cXpIKzU2a1NEZVg4ZkYyalA4dTVwMkZlMlBvN3ljNmVaKzVXSTVyQ0VR?=
 =?utf-8?B?bzArc0ltOFNOWXhWb0lueFNYam1OVzdISCtKTk9jaGdUYVMwckVNTlZBY2Fo?=
 =?utf-8?B?YzR4YlFOYjVzSklNb1JlRjQ1eDd1RW1zTjFERFVlSTFWd01rdUpjRzZWTys1?=
 =?utf-8?B?UHJyZldLUzdzMW9PRE1wQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnhpNkduN2hYUTkvcC83TFV3enk4SWZVSy9wNUVsd202WjhxWlorRG1hUXRG?=
 =?utf-8?B?Z0Z1b1Rnd3F0VFBxcW5kalQyVlp4Uyt1STNJM1JPazVPZ1IyOXdGOUdnbXlR?=
 =?utf-8?B?UnRFRTlVWGhKZDJ5RFRkUnptVmhzcE1iNVMyeVI4UEs1ZS8yMnNDYllkdHU2?=
 =?utf-8?B?ZFhhM1BkSEVFejltQjdYa2JFb1VIeFRWTTNYMW9xUUdEdXp1TlVJK0E2Z1J6?=
 =?utf-8?B?RTd3S1RTbktFVkxSRzJYSXRWZUg2RTFMOEQ4Q3RhakU2elhMck10Z1BQdjJD?=
 =?utf-8?B?UUFCYXo1NEVrYm9HVXRwNWM3VW03eFJnT1FaOHZvdkNvdlZvcFZKeEw3MTJq?=
 =?utf-8?B?Yi9OblV1dXJ4cC82a2hBakJlWFYzWFVlaWVsL1RBVklWemhxaVZ1WTBsWDFu?=
 =?utf-8?B?ZzErczhyU3FQTFg4cncwMDJVRXIvMmxEWmV2ZldKUExteG9oTk1JM054alhQ?=
 =?utf-8?B?SmtwbFJwbnJjVmhEMS9VUlAvVFJoUlRsdDBHdGJuQ1ZkSC9Id1FPTjRsYjR5?=
 =?utf-8?B?S2FoclBEdVFzS3hmbWxWOFFzSklnTTQvc05zbkV0cjNQcU5FMGQxMlpFVm1T?=
 =?utf-8?B?Q1pIT3JOMk5FRUhoMWN3d3IyOFRDUklSRk4vNEZjVlN2V01reFNqU05IZFpW?=
 =?utf-8?B?T0kvODRuUndGK3gwRXZWblN6aWg5NnNUeHJoclJFYnB2enMwV0pzdnZPbjVl?=
 =?utf-8?B?SW41OGQ5TWpXWkY4ZHZnb3N0STI5cDZBTjl4VlM4bitBQUhvYi9jRlJqYVkw?=
 =?utf-8?B?a1R4NTBJeEh0eDB2L05XVjZudGZjSk9lVzdZWXBWWGhXTzVVNzh5MzRVM1d5?=
 =?utf-8?B?YUwvbDJwb1RNRnRMNnhIdjVwWDQxQktvcElSaVRNQmViUnUrbXJzMmlVaklm?=
 =?utf-8?B?eWhkcVJPZWpVS0g4Zk1RdXZNNUhoc05GMXIxcEZjVE9xck1DL05GUXZyR1d1?=
 =?utf-8?B?eW1CdVVDd3o2U0dPenIwSzhLV3ZRaHVwcTlBbHRkOFBPWnRQK3pma053Uko2?=
 =?utf-8?B?RVRuc3M0UmRNbjNoUFFpRjVCek9CY0VSMTZkRnIrSmticVBUVDBjZFFFYWZU?=
 =?utf-8?B?YXBabThoZ0lOYzkrak5JVDZKdndmNkJXS21tQ0NVZG53YmlPUkFKWVEzTVpt?=
 =?utf-8?B?eGk4M0JWaytmNVBiUWZsekFNdFBLUzUrMjNMbFpjUGxZZFF2NkJISnIwc1RD?=
 =?utf-8?B?aTMybUU4RzBVSXdudzVyeW1TSnNQQWFVenE2WWFUZitRVGVYZGhLakNsSXQ0?=
 =?utf-8?B?RGhlaFVHTTR1ZFhkWUlGYTk0RUF1THBrd2V5Mms5dHpGZmxBZjBacU1WVGh5?=
 =?utf-8?B?dTE1R0JIdkNpaWFCQ1ZJazQ2Vmp4RFYxYktCc2RaUmdEYnZvSGNnSW5SQWUy?=
 =?utf-8?B?eVE2KzNkOVNxaVFIL24wUkM5M1FpSk94bUJpekVSRSsxMk9CV3NCN0ZTaEpM?=
 =?utf-8?B?aHZ6ZUFxdUpDUlhPUW1oRVZuN2ZuZ3ZUSWVWRVQwTWF4WUxySFYxckpjTTJj?=
 =?utf-8?B?SmZPL3J4RFhyZitlamJ6Qy8wVGRwa0V2eFFHZ0xTNW1OWkJKaGo2MjNUQlFv?=
 =?utf-8?B?aCt1bXVkUzhvajd2d3hYdFAzczJkdmxPWmhCeVRncVl6b1JhS1JKNTU2N2Q0?=
 =?utf-8?B?RnpHYXczaU92MjZrWktwbmpSeEhqTkQ4SktiaHp5SVViNlNmUU83NkRHZWY0?=
 =?utf-8?B?RFg2RWFwSEJWQUd5aHFUMFkwcjhJQmhlQ1ppdE9CSjd1aWxBQ1NmU25xM0Jh?=
 =?utf-8?B?cDQ0Yzk4Z3NHWlRDaWZpOUE0YlVucUdVTjVKbE0raDRqSkpNcXlrNnAvWFdz?=
 =?utf-8?B?dzAwUmpYdmdkODdEdk03REV4cnFHc1BobmVNa2RQQVRsQkk3S3RSQkRScEFZ?=
 =?utf-8?B?a0pCdWc5N3JPQ0NYbHdsR2J5OGFERTZsNFFocG95TmhaVm9sd2N1UnVuYTJp?=
 =?utf-8?B?djZ6dXBDdHRHcXY4Qyt0eXVzalhGM0luR08rVjZXbngxU1BibWlaWTJBVG05?=
 =?utf-8?B?aHNETFUydk5CVk1jTGNHdEZKQ2UySk9oNElOcU1SMkxzVnpWa1ZCN2kwZDVH?=
 =?utf-8?B?aHFxOG96OFFrbU5PejhqUE1ib1JyMGNLQ1ZodHpCb0Jrd01qRHlvbUtvYUN6?=
 =?utf-8?Q?Ie0d5zApYgr9g7xP6+ZSnUes8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dabf765-a4ed-46b2-f5f5-08dd177a6a18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 11:21:09.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0G7OOAazYXM29kMWkUQYW7ZNfPBBCB/4KOApxHqikHBqs7XUYugtPrrGTOHWL3ah8UYyat1o51XizFFXwhfYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203


On 12/4/24 23:24, Bjorn Helgaas wrote:
> On Fri, Nov 29, 2024 at 09:15:12AM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> While resource_contains checks for IORESOURCE_UNSET flag for the
>> resources given, if r1 was initialized with 0 size, the function
>> returns a false positive. This is so because resource start and
>> end fields are unsigned with end initialised to size - 1 by current
>> resource macros.
>>
>> Make the function to check for the resource size for both resources
>> since r2 with size 0 should not be considered as valid for the function
>> purpose.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Seems reasonable to me.  FWIW,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>


Thanks!


>> ---
>>   include/linux/ioport.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 6e9fb667a1c5..6cb8a8494508 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -264,6 +264,8 @@ static inline unsigned long resource_ext_type(const struct resource *res)
>>   /* True iff r1 completely contains r2 */
>>   static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
>>   {
>> +	if (!resource_size(r1) || !resource_size(r2))
>> +		return false;
>>   	if (resource_type(r1) != resource_type(r2))
>>   		return false;
>>   	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
>> -- 
>> 2.17.1
>>

