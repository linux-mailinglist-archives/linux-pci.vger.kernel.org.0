Return-Path: <linux-pci+bounces-21356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A18A6A3487D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545123ABB77
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6D144C7C;
	Thu, 13 Feb 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R4dLRC8a"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1182D14658D;
	Thu, 13 Feb 2025 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461429; cv=fail; b=VrMF+N+SVOzRtAH2AJCxZAw9jnWYo1fYFjE3AVgODDCCHBaK2+Eqa4U+BRHUnbK+gP8iwP9Os1uXgaboHDtag8+yQ3Gja5F9kacNQgl7Z5bfykx1oDJ83fTs74aOJVyK12jpub3xdKjn/V+qfjwUynkDe5ge0tU/S6zxe33758U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461429; c=relaxed/simple;
	bh=0dXvG93vVhqHBKF9kLIHeR49Bfo7CpqDPfB0bkRhhvo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iCz1i6A9MC5qJ/JIzGPnddlxFislyQaTyefVRRf66dNsummbg7v+2DI9vtSmQitXkx/d55FI1xQHnmkyeDbMjr9xH3sl90jaOzE+piBz+8EERxB9OCtoUBAqTQW8RWs7WPeZmtl8H0aR8M+c+ble5sPAE7AhLCcYKBZTIug2F7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R4dLRC8a; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nva37x0x9QTHQBaBT6AzvkxpRHlyrcvebitR+fsqFlHV00D2RS00F/FSfLFUsi9qpSX9vQvCXC0RlZPoTZA23zIkTqooUHtZc/ugARglS89WrbT10L6aUJPZO4gR5O+B0ARz/DiArkO+cAZ02WR0HY1BIINoMXxjqyDuCUD7UG5WKp/ur5S8AvKWbtqgW8hY7Ky8WXRerAIMGY9xo7/ALwGybCSN2A03QRbnmWqtrFZrM7YnllvtMlfzARiDEyxLcXv8J4TT21NvOsIzmbcKHvAeIQlcSqoqyIUp9pVe4BKDiDTlnH+0HRa/RCAZ+z0vrkvrg6/+zUIWhubcsAL+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zun6O4wdV1a+kedfzZgxB6TgKTJv0H5rfttt1BTvN70=;
 b=Pfw7CpHjCqkOXI44U4ymOiMfeW5kBFRus/LEXQayAKpMkKJog4xtB8oJLiyRXeo4AFOCnmwPbluG1i3LjoEzbdk7WAY16S+oKPxJlXAZchmbQ6vnohdGFZDr16oKVnHCekJgibm3fL/Q1HDMn7lF6dhmG3k5jzxjmTDxp1Xm/6XUBPe6/qPC8kZ/fPXQhMa2WjNE3J83KNzuJjk6rP/Y/9QRzqzGQfO23TbLugmw3liEe4zHmY1DI3VaMWs+vEPTjPT3tsTUhVrekqfa+KxjoICQ+eRvnlBbYNfwdvSAScDqugpzdTo6+SLYWpIGmeZorOyKlVm54TO4LeNyV2Ztqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zun6O4wdV1a+kedfzZgxB6TgKTJv0H5rfttt1BTvN70=;
 b=R4dLRC8ayzvxLIaZTAI43LRLQG0++CSApNvfpQAfP5eu5tCyYo+Pafa4z5aTMk+ES4UyJ+FWHEy9tivLcGK2GhwZW5PmP6+QYIAe3uFo3i/F3NzzZ4BCfKBQyHYugsycpbARJfYRKodAxhzmX9oISv9KNICogWyP+Ktx6xy1DJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 15:43:44 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Thu, 13 Feb 2025
 15:43:44 +0000
Message-ID: <609a02bb-3271-4021-9499-8b281a959f62@amd.com>
Date: Thu, 13 Feb 2025 09:43:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-8-terry.bowman@amd.com>
 <67abf81f4617b_2d1e2946a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67abf81f4617b_2d1e2946a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::10) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d799f4e-eb9a-425b-87f4-08dd4c4532bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VksxSHhlYjhLV3BiVjZIOU9hU2pXUzRpdFdoaGZ3YkpIajExZFE1b3I5ZGNN?=
 =?utf-8?B?VjhlTkpkRXIxa0xQaXo2L21vcmJYVldSQXB5dzM1RU8rTzgvTnNYMGEzMkFi?=
 =?utf-8?B?VWkwNVY1cEs0LzdsSDBWTE5mcjR5M1RaRms2d2xnYlZ4M2lCU1Y4VjhVNjU0?=
 =?utf-8?B?NWpFNERaKzJKK1F5M2R0aWdwbVd0MWZhRnBOTC9YcWVGeitRMERJRTlsZDNv?=
 =?utf-8?B?NFBGTUdNWHRlcXF3S0hQa0Z5Q3Y2ZEY3b0tLQ2tWMmUreExkUk1xTm5Oc05Q?=
 =?utf-8?B?UitkSlVsUTNtcHUxWHVGL1RuM0JTTHQ5dGp0Ui9GcUpYdXVWS2h1bnBXclR6?=
 =?utf-8?B?NEZMQnpFUHdLWHN5NWtTRFQxWnYvMXdzaU1Rc2VHbjV4VW53V0hMelgxUG1n?=
 =?utf-8?B?Y1JtN1FRTmJMMnZ6RTRHR05wSkkxV21zME9BS292V3h4NlgwanhVSGxUNk9P?=
 =?utf-8?B?SFdhWWdSQmxkZTY0SkFtR2FVTEl4UVFWNVVQQlNHOE10TCtmMFNFbXc4aGtn?=
 =?utf-8?B?czNIVDBGS3JyaHEvc0tMOGJ4SCszemY3OGlneGpnNDdqN0ZOMEpKbDRybUE3?=
 =?utf-8?B?OVBJTEh2YzhSVkd4Qy9aSEF2RlBZNlpYYUpVVTdBcnNRdXFjdGxRd0hBNWJ1?=
 =?utf-8?B?WDBELzlQdkJUK3hDRzZnVzBwRHhjbzhYdCs5U0FLcmY2QW5WOHUvUExxOTkx?=
 =?utf-8?B?MktuT29pRU5iZGdkblJsanU4UWJPUUtnRnFlcTh5eEpPRSt1RlRqSVpOWFdU?=
 =?utf-8?B?N1JOR0xab2xlNEhTVndhVU9rNUFDZTBHTnljVW9UMmRhYU8vRlFTYkZsQVpO?=
 =?utf-8?B?d1lxZEVhRnVrZ0FjRmw2ZlFoQWhzQ1JBc084MGxpMnpDMFcyRTNSNklNeXhw?=
 =?utf-8?B?NndMWVRycjQvTmZSOCtTVGVKVFU1MFFBckRJRnNIbjltVzNpYkg3UTdwOXY2?=
 =?utf-8?B?a2pHTzVPWDQvbDdiaTBEaU14YjdZY1lrQnNTY1owMmRFcVpzVDQ2SXRZdkdn?=
 =?utf-8?B?ZU55SVpBbjVRNktwVlpENU5kaDlYSVRBLy9LVFhIcFVPb0pwbnI4K3ZCZUVa?=
 =?utf-8?B?aGVaM2twKzhRMWNkTFQ3NTlFbm9kSFJXT241Ukp1cDJ4YjBNNXBXbVVGczJY?=
 =?utf-8?B?SmNXaUJxeDNkVGg5QXVTQ2RMTDhadjlkSjY1V3k5Z1JuRzZDcUN0c3hjbUJD?=
 =?utf-8?B?ZUVxUUtaWHp2bUlKUFBuQmlYYWtnMW9EZDl1anBUVzhPRzVRY1F2VHRzRHdW?=
 =?utf-8?B?b3p2M0dxdFVZd2pMUXRQeURoWi9iT05EU2djcUZNT2NWQWpGVEl4SjN6NU9m?=
 =?utf-8?B?V2d6Y3pqQW93ZHJ6eHQwQmtDZE00RjFXVTV0RGlQMWpmcWtkTkRpWWNPRlRr?=
 =?utf-8?B?SkFxV296Qy9VdDN0SExpYVlCUTByME80c2VJV0t1RloxZjFpYk5wRzU2YWQ4?=
 =?utf-8?B?UTVFZ1ByTVFWcldBZTJpdTU5eHV6SGtTT2pFdUJjNnpHQ010RTFaQ3JkZmhu?=
 =?utf-8?B?UnVEeHVSZDZSL3dDb0hudktRVTFPSDl4S1JUTVZCK1RkRURFOENwdGJhSTZa?=
 =?utf-8?B?Z0M2Y0dtQm9CWUpwWEEzRUROYzZJZndVekRlS0wzUlZHMGF2Tkh6T1VSWGpy?=
 =?utf-8?B?N0JJemQ0aXhUQzErYmxPM2JYWTNvYkkrbXY2YTJ2WmNNRlNHRjg5Vjd3dlQx?=
 =?utf-8?B?R1ZRVEF0V3h0c1VlaGxNZC9JeDRneE83NDdmV2NDUjNrTGt1T3dHcGIwYnFL?=
 =?utf-8?B?V2ZiRnBvMXRyb2JNRmtTT3c2ZnkrWERKMkRBeWFFYWdjZjRNWE12bTRXUkFq?=
 =?utf-8?B?OWplRGRYL3JjYlpBVGFrSVV1M3JyYUZ1RWRSVnRFalZPa0xINEpBZlN4UU1O?=
 =?utf-8?B?OFg4Tm5NRFhyQm1TcjZwNGw1eGUwNC9HMHBCMEFZVGhVNWxZTGR0SWR4d2kv?=
 =?utf-8?Q?JQaQCOnhiUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTQ0THp3RnpWeG5NM1BYY3ExcnNCaGtMTS94UzE0K25HRVdNQzNKWGlYdzlT?=
 =?utf-8?B?TGpkUDRsZEE5eTFIVmtDa0hEV1VmTzVDNC9sa3drSURTMGtHV3Ivekw1WXJR?=
 =?utf-8?B?Z2FlZHFZUEdPcWEybkUwUEFvYnhaN1hLeGhHbGkrMmpSbjJUUEw5QzlvSDJa?=
 =?utf-8?B?Q3NkM2lHem5BUWdFNGczcXRROVRGanZ6ckFiSEwxZFFHTW9WWG5kY0Jpc1Vu?=
 =?utf-8?B?ZHVTVEUwaUI3S2d2VW9Qbk1QMGFZclE1OGxQa1NSeW1mTWdOTHJRK3FNRVpV?=
 =?utf-8?B?cXNUS3psQWozenFJRjh1N1hMeHFreUlkMFNTNEt6OUUzT1lDK1NnZXE5Ky9F?=
 =?utf-8?B?azFvS2d0WkZhVVlVNnBxd3FvcjhBYUVZcmVJNE54d2duTllIT3drSWFuN0l3?=
 =?utf-8?B?V1g2d3pYUDlrWW92RzdwWTdhNThJL1EydjFNVUh0SnA3Z1hReVNHNVZaUytJ?=
 =?utf-8?B?blN5aGFlR3c2MjJjWkVKLzBsOEZvSkVLQjhPeDFSbE9KbnR6N1VXaGlBcHBp?=
 =?utf-8?B?QWdaUWVsQVY1dUFMaGV6ZklKU3NRWlVodi82VWt3R29Nb2FJOGtXbTFhekRY?=
 =?utf-8?B?TWt1WktkWjRJbDAxQW44ZUwxYW5hMmRPMStVN2lnbXpSczhLYi9kMVFmQzJM?=
 =?utf-8?B?V242UUFDbFdaczlnaTdQTkpSYURBdmVxSTlnWWs2Z3B4MC9IZ1A5RXdDRm8r?=
 =?utf-8?B?c0V4WU4yOEsrMW4zWTZUNldRckdzT0tGMkxVT1RDTVEzNUlBb2ltREZCRkhP?=
 =?utf-8?B?ZXNyK0ROSk1LRjBSZytxOEtTWXJmRE14cTFIUVZwMFVFM2lHMWtsVERabjh3?=
 =?utf-8?B?enUrUndmbnJQSnQwWWUwR0JYTWNQQWVOTEhwWG9iWTZYNkQ5OHlmcEQvcTV3?=
 =?utf-8?B?bFBGUHNkck1ZeTRJVThtZDg3LzliTlhzSCt3WnFpbUxrcEEwYk5tWWZmWXRv?=
 =?utf-8?B?blNXMGd5V21UMFVzZkxneGpCMUFZTVQ3dGp3MjJtZUJydEw1YzlsNERkelZQ?=
 =?utf-8?B?dDg2b1E1UXB1TXA1TDV3RkhLYm5kSTB4dnN1WXFUcGE5QUdqVWY4WkVUWHMy?=
 =?utf-8?B?eVRCMkUwV3dvdDdSeHdFaThRRzFEajdOcVRrTEpiNnNiek1kZzlvclYyWU1q?=
 =?utf-8?B?N3k2cmZ2bGhRWHoxa2JmK1dXSklMejJEZ3NkZDlENVpVbmRWVEVPUDM1NTd5?=
 =?utf-8?B?NmV5USsyUTErSG4yaFc2NE9ZMGdvRzZVaC9zRm1YWWhIVzdjSUNsUlliNld2?=
 =?utf-8?B?cjFhUkpuUWwyVTJGQjZTV0s3Vm5zVzVlKzhsT2xKOGo3Q3hRU2dhYXRSenY5?=
 =?utf-8?B?TGNCMGRDRGd4U3NTY1FNcVZxNnNjNExvY3h6ZWlOZzNLS3ZqSXdHc2JKR0hC?=
 =?utf-8?B?dG9Xb05BbWpEcUNvclE5aTRpZ2RlVDdXdytmbHVha0JUOTBGUVBQTzJyMFY1?=
 =?utf-8?B?dTBDUHNyYlErT25vNGUzS2RPUXBSL01TKy92WmNQdGVpYW9RS3d5dkdJUHBU?=
 =?utf-8?B?TVY5cXZzcmtyMnNuV1BYczQ1ZzJLYUxNNDBCY2IyQWVVc3JCVld1cU1lWmt3?=
 =?utf-8?B?MWRiMXJVRUJTd2lQd2NTZFNZQnloUFM2dDZGd0xiOG9VSDM3NWtRMXVRUDNl?=
 =?utf-8?B?STM1cFdvcnVoVEY2NGlYN1R2RUtYd0tQemZoOE5MZzk0djlwS1FycDRnMXFT?=
 =?utf-8?B?UlhQTTRmWDN2aXhKVDRlQ3F3a0RGTk52UXVlSG5ud2FvcDZrMUtTaGlBbTRl?=
 =?utf-8?B?c2psNk9jQ1FWWFhTR2duMHY3ZTBXQ01zVnROejFDNDlWOUpGSWZCelNiOVEz?=
 =?utf-8?B?eXJBU1M4aFVtYmU3cmVoNE1lVUdRZjdjTHlVZHVvMW1YckFaUnk4Q0pBTWFF?=
 =?utf-8?B?OTFhaEMrYTY5bmZqV0c1Y2kzZ252cjlEZkpwZUVqZzRKOHgrV1czeUZQTStL?=
 =?utf-8?B?K1dRclVQMk05SkdPbHhsazYxMXF2SHVWOEFnK1htdWFVOUlTZkZKYzdjUXBJ?=
 =?utf-8?B?eGY4RHZLS1l5cDZnSjRiekJJSm1uWDdhbCtrZytrZERwWFlPMXJ3V2hVVHh5?=
 =?utf-8?B?LzdjalJ1MGdxWTNqWkw3bGczR3lkTTBSSkEva1VDbjhNd3h5WnU5eEtCQjUr?=
 =?utf-8?Q?FaZj168r0TsTSeu6hpasG9XLW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d799f4e-eb9a-425b-87f4-08dd4c4532bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:43:44.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXP8DWzqwSAifDRQzx45RBIGihZU8fKDE9Y4FogIcZYNHOBidJwh42tq4ox8rduTqw892cItAkzcTHqdA5KHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767



On 2/11/2025 7:23 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
>> registers for the endpoint's Root Port. The same needs to be done for
>> each of the CXL Downstream Switch Ports and CXL Root Ports found between
>> the endpoint and CXL Host Bridge.
>>
>> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
>> sub-topology between the endpoint and the CXL Host Bridge. This function
>> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
>> associated with this Port. The same check will be added in the future for
>> upstream switch ports.
>>
>> Move the RAS register map logic from cxl_dport_map_ras() into
>> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
>> function, cxl_dport_map_ras().
> Not sure about the motivation here...
>
>> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
>> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
> Ok, makes sense...
>
>> cxl_dport_init_ras_reporting() must check for previously mapped registers
>> before mapping. This is required because multiple Endpoints under a CXL
>> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
>> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
>> once.
> Sounds broken. Every device upstream-port only has one downstream port.
>
> A CXL switch config looks like this:
>
>            │             
> ┌──────────┼────────────┐
> │SWITCH   ┌┴─┐          │
> │         │UP│          │
> │         └─┬┘          │
> │    ┌──────┼─────┐     │
> │    │      │     │     │
> │   ┌┴─┐  ┌─┴┐  ┌─┴┐    │
> │   │DP│  │DP│  │DP│    │
> │   └┬─┘  └─┬┘  └─┬┘    │
> └────┼──────┼─────┼─────┘
>     ┌┴─┐  ┌─┴┐  ┌─┴┐     
>     │EP│  │EP│  │EP│     
>     └──┘  └──┘  └──┘     
>
> ...so how can an endpoint ever find that its immediate parent downstream
> port has already been mapped?


            ┌─┴─┐
            │RP1│
            └─┬─┘
  ┌───────────┼───────────┐
  │SWITCH   ┌─┴─┐         │
  │         │UP1│         │   RP1 - 0c:00.0
  │         └─┬─┘         │   UP1 - 0d:00.0
  │    ┌──────┼─────┐     │   DP1 - 0e:00.0
  │    │      │     │     │
  │  ┌─┴─┐  ┌─┴─┐ ┌─┴─┐   │
  │  │DP1│  │DP2│ │DP3│   │
  │  └─┬─┘  └─┬─┘ └─┬─┘   │
  └────┼──────┼─────┼─────┘
     ┌─┴─┐  ┌─┴─┐ ┌─┴─┐
     │EP1│  │EP2│ │EP3│
     └───┘  └───┘ └───┘


It cant but the root RP and USP have duplicate calls for each EP in the example diagram.
The function's purpose is to map RAS registers and cache the address. This reuses the
same function for RP and DSP. The DSP will never be previously mapped as you indicated.

>> Introduce a mutex for synchronizing accesses to the cached RAS mapping.
> I suspect the motivation for the lock and "previously mapped" check was
> due to noticing that the ras registers are not being unmapped, but
> that's due to a devm bug below.
The synchronization was added as result of review recommendation because it is
a racy area. It's possible that multiple endpoints using the same switch could
call this function from devm_cxl_add_endpoints()->cxl_init_ep_ports().
> Even if it were the case that multiple resources need to share 1 devm
> mapping, that would need to look something like the logic around
> cxl_detach_ep(). In that arrangement, the first endpoint in the door
> sets up the 'struct cxl_port' and its 'struct cxl_dport' instances, and
> the last endpoint out the door tears it all down and turns off the
> lights.
>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> ---
>>  drivers/cxl/core/pci.c | 42 ++++++++++++++++++++----------------------
>>  drivers/cxl/cxl.h      |  6 ++----
>>  drivers/cxl/mem.c      | 31 +++++++++++++++++++++++++++++--
>>  3 files changed, 51 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index a5c65f79db18..143c853a52c4 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -24,6 +24,8 @@ static unsigned short media_ready_timeout = 60;
>>  module_param(media_ready_timeout, ushort, 0644);
>>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>>  
>> +static DEFINE_MUTEX(ras_init_mutex);
>> +
>>  struct cxl_walk_context {
>>  	struct pci_bus *bus;
>>  	struct cxl_port *port;
>> @@ -749,18 +751,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>>  	}
>>  }
>>  
>> -static void cxl_dport_map_ras(struct cxl_dport *dport)
>> -{
>> -	struct cxl_register_map *map = &dport->reg_map;
>> -	struct device *dev = dport->dport_dev;
>> -
>> -	if (!map->component_map.ras.valid)
>> -		dev_dbg(dev, "RAS registers not found\n");
>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> -		dev_dbg(dev, "Failed to map RAS capability.\n");
>> -}
>> -
>>  static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  {
>>  	void __iomem *aer_base = dport->regs.dport_aer;
>> @@ -788,22 +778,30 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  /**
>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>   * @dport: the cxl_dport that needs to be initialized
>> - * @host: host device for devm operations
>>   */
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  {
>> -	dport->reg_map.host = host;
>> -	cxl_dport_map_ras(dport);
>> -
>> -	if (dport->rch) {
>> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
>> -
>> -		if (!host_bridge->native_aer)
>> -			return;
>> +	struct device *dport_dev = dport->dport_dev;
>> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>>  
>> +	dport->reg_map.host = dport_dev;
> This seems to be confused about how devm works. @host is passed in
> because the cxl_memdev instance being probed in cxl_mem_probe() is doing
> setup work on behalf of @dport_dev.
>
> When the cxl_memdev goes through a ->remove() event, unbind from
> cxl_mem, it tears down that mapping.
>
> However, when using @dport_dev as the devm host, that mapping will not
> be torn down until either the @dport_dev goes through a ->remove() event
> or the device is unregistered altogether. There is no CXL subsystem
> coordination with a driver for @dport_dev. The PCIe portdrv might have
> an interest in it, but CXL can not depend on portdrv to map CXL
> registers or keep the device bound while CXL has an interest those
> registers. The devres_release_all() triggered by a
> "device_del(@dport_dev)" is also uncoordinated with any CXL interest. In
> general, it is a devm anti-pattern to depend on a device_del() event to
> trigger devres_release_all().
>
>
>> +	if (dport->rch && host_bridge->native_aer) {
>>  		cxl_dport_map_rch_aer(dport);
>>  		cxl_disable_rch_root_ints(dport);
>>  	}
>> +
>> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
>> +	mutex_lock(&ras_init_mutex);
> I suspect this lock and check got added to workaround "Failed to request
> region" messages coming out of devm_cxl_iomap_block() in testing? Per
> above, that's not "more than 1 downstream EPi", that's "failure to clean
> up the last mapping for the next cxl_mem_probe() event of the same
> endpoint".
Synchronization was added to handle the concurrent accesses. I never observed
issues due to the race condition for RP and USP but I confirmed through further
testing it is a real potential issue for the RP and USP.

You recommended, in the next patch, to map USP RAS registers from cxl_endpoint_port_probe().
Would you like the RP and DSP mapping to be called from cxl_endpoint_port_probe() as well? Terry


