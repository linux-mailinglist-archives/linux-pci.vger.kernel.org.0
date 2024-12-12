Return-Path: <linux-pci+bounces-18244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482B99EE360
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AC41621C0
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F220E6E1;
	Thu, 12 Dec 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hgQxmqkB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B71E9B27;
	Thu, 12 Dec 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996790; cv=fail; b=DlkEmoCM/vMI3x+FwED2ZEa9pqdozZdOoaf2JVXot+ChxZCVMkosWI/3gEJB+0IltdYDLMHn6UejaemZmBdZCpqk6jWhu1ltKJlzApnm5vxJc2uaal8NoG8x9iOZaz/5UVH6cbpWJrEtEVLWODeYlVq6rdJPM52mnqFq8J20PC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996790; c=relaxed/simple;
	bh=2A69jPd64yf8950bxgrOpTGpEkeHxxFPUd3fg2iK6ws=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XaFbY03MzM2VwBamHOGDii30vTZjpwt/pEg9D8tVkQY2KL147BUx7Uyfy9a4+gqZWWtzmC2hZmd5uHHbUiTLXtU8hVcRZ1EpjJGp7XVkLC9sifbe56CSIiEmkdCVN6upkSrnRLRzYolZysfO8a+FPyL3srSlVDfP6usBQPx6Yoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hgQxmqkB; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuFRswglBYLyF/6S73r1ggzyrEuLXs6SgEecCOENKweyPqGg+Dt7N2msiS9XSRCH2nY2ezVwgMPinJmuJ6ldXz+zNPpt8ry9+nqNhtRTU09oiNi7R0X7m6VvBcyVnUQ1PIrewYHtPaB0zKzeTiX2JgJbE1eUzMuD6HmdtjFwS/3lEbyoft+QLFPiWA9q6AiSCGBwl04mqUxu82CHiZVam3L3wXOPUN20lceYlVAvjy88rAov2gZDeq+xUUFufBzR9t1f99ZhPdLo9GZ0qkuFilmJFqPP3Ew2YT88GMtcjHkRo+JKef8l0KW4W0ebtveRzth1HM4BFH9WJhlfbcVEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqDkDASIH8AF5o5beXAxk91VtGN31dV4SquhtlDNmeQ=;
 b=kypGYjxL1Lm120mcpUltEzOkwaM9O8hM1Htqb8TDZ6wxqihFIja4enjKem3Fu9HVY3zKBquy95zgX8/d2P8RXrTLwIs39EDm9KrQFk92kx4tNS7DzTYY1djWe1LbmIYCfe1RV+jH7YPQsHGtZBJxlDqYHv0E53M+fF6vUWONQM4eiPktZSFsfzBe4+/vMXVnkEvDf9N7LcO6R9MoZ6kruziis+4Bu+qvvowsOcQvuUGszNLdSyRwZxkR1GHIh3FAtWxsg06RInOzvGThlKh/8KHoH0I/lwKznIlip1seOG/3qTgu0ke8e8HsMtln1FJbkHdCKzBqD1fA5eNdgv0tvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqDkDASIH8AF5o5beXAxk91VtGN31dV4SquhtlDNmeQ=;
 b=hgQxmqkBpwVnRuCTgA4TMAZo834yCpasZ9yv6v8L+BSNmPhL4TUiA4zgxMNBsf3og9qEF0tru8FFLi4odVGpmHQEsTOazqZkQzNoT/Bbsb51Ds3SK92cVVAbw27DVlrcThUjhwiArlDs53ThGmrYLI4V+vJismw4Yf8x9FHhu80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 09:46:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 09:46:26 +0000
Message-ID: <fe67ae94-1c12-288e-07ed-4391fead9949@amd.com>
Date: Thu, 12 Dec 2024 09:46:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 13/15] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Content-Language: en-US
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-14-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241211234002.3728674-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e18e26a-8d4c-4b55-6288-08dd1a91d846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0htK2pVbDBRSU1BN0xLd1c1eUU0dU4yVFUrWFBhbXh5T1IvU3FxOWJPT2Fj?=
 =?utf-8?B?c1JVNGk0NTMrRkRmNW5uVm5aOG1DWCs1MDhPQmNTYzdaK09VdDczZTI1ZlhG?=
 =?utf-8?B?cWdYZXdJUkNwVlVady9IcTlZUGJURStoQ29hMzUyMUNaNXgwYkU0WDRwaURZ?=
 =?utf-8?B?WlVCbEN6VEhOS1VsenMvYmtRaHFzMlJySFQwWkx1UFNJV05zbWdnVEswOEZH?=
 =?utf-8?B?ckppWUdiYVVidzhOVVovcDhkZzRORWlLV2V6MFNGMHVzWEZEbit0eGxkMDJ5?=
 =?utf-8?B?SVk3akdwa3lJUm14V0diQTJUTnlybWlaam1TbXhJTFRzb0o4MzkwRHNNdlcy?=
 =?utf-8?B?dWtkZG1ZZEcvUDQ2UnFLUmF0aUk1RWdGRTJ4RHQ4UnpIWGI2cGxWZmR5c1VH?=
 =?utf-8?B?SFd2Y3NxQ1FhTnZxZ2NCNThLWGhVVWVHNHgwTktzeitZbnZ2amtqeUNNRStY?=
 =?utf-8?B?eHR5bkZDSmRYZXI4S2w5NG4xbGs4TjlJN1QzWnE0RzkzNWFWSmVoUFV4NWo3?=
 =?utf-8?B?dTdMQ1RPWXQ0dEF3VHJnNzFUNGJaNnNvMk9DRkFFWVhKZzhLbkVtTzBRV2cv?=
 =?utf-8?B?VVNncDl6TXB6OERWMHUxMFJ5Q29HcnoyeFErWVlhdjFwVUNOU3doK1dJaSt2?=
 =?utf-8?B?SlRQejM4Yzk5ZFlIalk5d055TktmY1NxWkJvRHZ3QllaTVZtOXpRZ3Y0M2sy?=
 =?utf-8?B?RHR2d0pVOGpFYUo5ZFZ4ZVVQVDFKRkxVMm8yVmZwd3gwb3ArcEpPQXE5MUZl?=
 =?utf-8?B?L1Z1QjVhbGRWZXY2WE1SSU53S1Z6UUlTeTFLZ2l2VVpOOEZ2Y29GS2s4SzJQ?=
 =?utf-8?B?Yy9BUUY1d2oxVCtwYzBSYXNtYms5WFZzRXptKzR1MGdhTUI1TEFDMkRxeXc1?=
 =?utf-8?B?amswSStzQ0NISUxKbjU0ZWl4c21vTElxWVFnS1ZhYzE4emJzT25ZNEZ6eHdP?=
 =?utf-8?B?cnozeHlBZWN5SjZvRVd4YVhxeW9QdFducERDZ2RkV051YTNlNmZRKzF5bFIx?=
 =?utf-8?B?Mkgzbll5ZGlldGEwditiMlRUWHVkVXpteHJybEJqUDlEQnU1UFgrNzFyTDVQ?=
 =?utf-8?B?aDFNbEZ5OE1CK3FoL1gyTDV6eGhPaVlDdndySlZVeFV1S3FMRTBRajU0N0s5?=
 =?utf-8?B?dGdmMTFVV3diV2w2Q0xnUXZLY3FjNDhWdGlMamFjajJXa25NZ1MvdElIRG83?=
 =?utf-8?B?RDVldXh5NzhCVG9mOExmd29DL2JEbU8rMzRGMVd6dTJDcmFsektNankzYjBC?=
 =?utf-8?B?V3NiRzU5b1pUbU1lY2s1S0NFQ0ZTeWN2anpObFR2YmdFbXpIUWlWblRURGlh?=
 =?utf-8?B?R0xYUkJmOThIa1Rpc25sdFpaM01Hekl0R3h3bnQ0ZWliNGVzaUprdGVqN1I2?=
 =?utf-8?B?UHM3K2tUSlhBUExER2h4Mmc3SFRMa01OVTR3RG04OWQwYVNrV1ZGbmNQcWsz?=
 =?utf-8?B?QUNxTG1PTWJyS2xSV3ZRVTRnTnpKaDVtN2JvMFFNVHMyOWpQeUs0ckxWbnM5?=
 =?utf-8?B?TE5XVm5kRURYRGRhQm9nbmhtK0Y5SWtENW9qc21FRXRRNkVLbStWVDVrWW9Z?=
 =?utf-8?B?czRkcEd4RFpsTmVOQVpiQmZGNko2b3I1c0Fyd3FWYzQwcGx6bzlrTmU5Ry9N?=
 =?utf-8?B?OU8zODkrdUNHM1R0SlRUWnpXbE12cjFwNzgvTE1UejNqRnhDVXZkWmdEMWQ0?=
 =?utf-8?B?WDJWREREY2xlOHpVdHExQURJU2VycFFDbGVTbXoxYW5nWUZvQm54WGRpQzRa?=
 =?utf-8?B?TldKZXdIRG9KbEMzUjhOY3VsTGhnSjNCRGZJZkh5NGJDZE1tUkxMM3JSaG02?=
 =?utf-8?B?VkpGMFRkZ3dQa1Q1ZUJNU1ZEcUlZRzZoYUJRK0pyWjh4RnhzKzNuSkZaVnlF?=
 =?utf-8?B?V1FEV2xFa29aU0dNdUhockJJY2xRZU1wYzVTNE1YNzFGbkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UExCNmVYSEhJMHY1emMydktkbTJ1S1NVRTBFZnJ5Y2NZQmNhTVF1cXhwL1cy?=
 =?utf-8?B?MDF5bHBHNmlvRTYxNU5CblRLSlVIYjNsZUFjY1paKzZzVmtLdXlvcVFmbU9y?=
 =?utf-8?B?WGtsSmh0cWI0RmxMNFdpV2pBb0IyaFFzdDRXZEFzRG5ZaDdxVTNLNERacEIz?=
 =?utf-8?B?N3RDNThMNXlRWWc2MndiZUpFelpNTERmQkxZUzhhUTh1QmEyclcycmJoTzF3?=
 =?utf-8?B?ak1ZUFpOblNuZW9zcVUxSmEraUF1NENyMzJlbDJ6Z2pKZjR4VUYzKy82N2Ex?=
 =?utf-8?B?Z0Q5RUtRZHA3Q3ZsQmV5blRkTGRrMTVLVTVpQlN5ZjdXMXI0QklRRlZOUUdw?=
 =?utf-8?B?N3hVa1V2UDBBNURKWmNhdVMzOTBpZUNhNFdSTDBZeVZMWVlKbGRpVGUwbGtm?=
 =?utf-8?B?OVdiVGs5NEJJekVLWDZJY1RaZHE2azIyc2ZuR3pBOWRNM2FhV01vNUZPaFdl?=
 =?utf-8?B?UUxUZE1PRWJyQjRrVkEwU1ZFK2xPdTJWZDhxVTRtN3EvMWorRFlZSnM5YXgr?=
 =?utf-8?B?RVRIQXEyVytTbTQrUkl1QUxBN1hXcmFNSUlvRlBKVXlpcEx3cW1Yd0Z6dmhJ?=
 =?utf-8?B?VG94eGN1Nm9NaUVHY0VDei80THlpR3JTM0hSMXYyWnNYdWZadmFXSDRITFlQ?=
 =?utf-8?B?UHF1c0hTZGRXK2hzSFVac25DRUUxVzBXMmdEY0h0cXpCaE9kcmpIWkZUL1N6?=
 =?utf-8?B?eWR6V1hqeGdEWmIvVTVPSnZDbGlVM2s2TExaZnRlS3llcllkK3VRUWJGV3dR?=
 =?utf-8?B?UkZ0TXJzeHNDVExYS1VmZ3orNXV4ZXQ2TVl2b3ZDeWhLMStMTXlFSFVjaHo2?=
 =?utf-8?B?UmlDNitkMW1ZN250aUdteVJQYXNpMWV2WHFZSnpucFVjUG1mZkdyUUtaKzN1?=
 =?utf-8?B?SVd1VEZHc0VoUmdKMWVCOFh0ZkdIZGZHbGhtNDV6aVFSaFgzRXI2MkdJU0VK?=
 =?utf-8?B?cWt6eVdnSlM0Qk40UDIrNllFVWJtYjlja1NUV3huS0ErbzJKZ1d5SitmTUF4?=
 =?utf-8?B?ZVhkeFY0WCtUcGw5SmxybmZrY2hqd28relBOSW5ydTlSUHFTSkdlNHNQQVAw?=
 =?utf-8?B?cUFjbGF1bTJZUk1iWEtGZ3FQNnczMElhQkhvTDRwbUgwcmk2UGdYUmFiYkpm?=
 =?utf-8?B?MitGL015clBYbzV2bGJINnBVOVoyekVWMVVPTG9INTVwQWdxR0RxallWRHp0?=
 =?utf-8?B?YXFYcHpZejJ0blVELzQxZmdtV0dXUlJqeDNZUkYyNFpRSWhmMld5YlBHQm9a?=
 =?utf-8?B?MWpkakVqSXlXNEo3dVlSVHdzK3F4U3NLN2F1MDB1S1MxeFVpSTc0N1JnSFhn?=
 =?utf-8?B?S1pPZ0hjKzR6aklmcW5JNDNkcFlob1lDMmdxS1Z5Z0dSU0RmRSsyNk5TUjYx?=
 =?utf-8?B?eXp3dld1MHBPSFJ6RGEybDhGT1I2SU1PTVR5N2t6Yytua0RWV2Q3TWQ4TXhi?=
 =?utf-8?B?UStkdUdlanRkZ3dEaW9xZWFPaFJmdlllbHFYNzNKSFNQK3J1dnljQ1VRbWlK?=
 =?utf-8?B?aTJHcVNsSmErbDIzREQ3Tnc2UXJ5YTY2K0tXeGp4ZXVzZnRJQWFpOHkwdlEr?=
 =?utf-8?B?eEkyQjNmdmIvTk13MWViYWNZQ3p3cC90eEptdWl6RkpLbFRPRlpEb2RDSHM4?=
 =?utf-8?B?NHNXZEIyK0k5cDFFS3dIQk5rVjZQRGd3VkRwTlpQdFhJNmFzcnVCTWdXQ1po?=
 =?utf-8?B?ZllVQ0c5TW9QNFVtQ3ZaRE5QRjM3djJNUXo2R3FaT1ppMUlDTnN3d2lIb0Yw?=
 =?utf-8?B?TVdlZ281bGFnOEdEZlpzZ0tqTWVGM3BnT0FGa2ZYOXAwQ2FSY1lpck9GS0JP?=
 =?utf-8?B?Z2F0M2tOWjJWUUpFaWtQUjJNM09BREFNNUw4UElHeDJ6WnNHR21YZDc2SnFl?=
 =?utf-8?B?VXZBOUx1TkhOV2lCb0xpeU9VaUdTK1BZbzRwczFWdGRrOEFqNWtNeFR3NVhC?=
 =?utf-8?B?TnhuMmpwQUtTUnEzdHhUTEp0VElLL2xpRXBxUC9SWHFTQkJKSnZGRjg1TkF5?=
 =?utf-8?B?cU9IV1lRakx2U2picEtodFA2VDlTTkpyK3FVbnFabTdhdHd0ODF0RFBISlpP?=
 =?utf-8?B?NnNwUGZvTEtLRHk3M3V0LzM0U1l5bzRhMytITWlaOU5RcXVxS2kvRFQ3ZHpD?=
 =?utf-8?Q?aGq8r/egfz0Z0BGrZ3YKPADi/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e18e26a-8d4c-4b55-6288-08dd1a91d846
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:46:25.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zxY+k/hns5w4mvylds5+2Nw0Um4cdhQQpBZl5fobVqH4ARgU79MJUMF8VthqpEpf++V/hhENKxWpG5WBz4MrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211


On 12/11/24 23:40, Terry Bowman wrote:
> The CXL drivers use kernel trace functions for logging endpoint and RCH
> Downstream Port RAS errors. Similar functionality is required for CXL Root
> Ports, CXL Downstream Switch Ports, and CXL Upstream Switch Ports.
>
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
> the PCIe Port error handlers to invoke these new trace functions.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


> ---
>   drivers/cxl/core/pci.c   | 16 ++++++++++----
>   drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 52afaedf5171..3294ad5ff28f 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -661,10 +661,14 @@ static void __cxl_handle_cor_ras(struct device *dev,
>   
>   	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>   	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	if (is_cxl_memdev(dev))
>   		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> -	}
> +	else
> +		trace_cxl_port_aer_correctable_error(dev, status);
>   }
>   
>   static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> @@ -720,7 +724,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>   	}
>   
>   	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	else
> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>   
>   	return true;
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 8389a94adb1a..681e415ac8f5 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,6 +48,34 @@
>   	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>   )
>   
> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(dev, status, fe, hl),
> +	TP_STRUCT__entry(
> +		__string(devname, dev_name(dev))
> +		__string(host, dev_name(dev->parent))
> +		__field(u32, status)
> +		__field(u32, first_error)
> +		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__assign_str(host);
> +		__entry->status = status;
> +		__entry->first_error = fe;
> +		/*
> +		 * Embed the 512B headerlog data for user app retrieval and
> +		 * parsing, but no need to print this in the trace buffer.
> +		 */
> +		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> +	),
> +	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> +		  __get_str(devname), __get_str(host),
> +		  show_uc_errs(__entry->status),
> +		  show_uc_errs(__entry->first_error)
> +	)
> +);
> +
>   TRACE_EVENT(cxl_aer_uncorrectable_error,
>   	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>   	TP_ARGS(cxlmd, status, fe, hl),
> @@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>   	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>   )
>   
> +TRACE_EVENT(cxl_port_aer_correctable_error,
> +	TP_PROTO(struct device *dev, u32 status),
> +	TP_ARGS(dev, status),
> +	TP_STRUCT__entry(
> +		__string(devname, dev_name(dev))
> +		__string(host, dev_name(dev->parent))
> +		__field(u32, status)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__assign_str(host);
> +		__entry->status = status;
> +	),
> +	TP_printk("device=%s host=%s status='%s'",
> +		  __get_str(devname), __get_str(host),
> +		  show_ce_errs(__entry->status)
> +	)
> +);
> +
>   TRACE_EVENT(cxl_aer_correctable_error,
>   	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>   	TP_ARGS(cxlmd, status),

