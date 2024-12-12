Return-Path: <linux-pci+bounces-18252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2099EE441
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04A12836CD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0B210190;
	Thu, 12 Dec 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M3wfOeWi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09120E705;
	Thu, 12 Dec 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999822; cv=fail; b=hX61WGKZHC6XBcrdMpPW+q+706n57F6moXsdl7J/2vqAW/yMjtKelyqgmkiMm3SyLwbTQ6mrltQmt1pWVb0Yjw+Zw1alHlbiNXCv6enpkXDl5hU9/SLzcIOoej5Ap9XbpU1CCKBVOqQEEgKll3rucGalyTI3S5xcmhmcQmY9ENw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999822; c=relaxed/simple;
	bh=KHXLo5bZTqrpY1YYxQza855KS62p3ayYa5jkv+bf4F4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MqOXP/Y6lftLLrsZFq3JnuyWuPBSKOzBp+Ka87cNiT+XLIprUMAerjt2eqmIOJ0GGDfNxJQm5zREzeEVsqnXOcu6kXx8iC2e9WPSXlYyyuQ0VtOekHe93FsA8AU1fI9J6UUdIMun4GFs1C/LjyX2f3hl8qe2MIxexRZsPdzkC5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M3wfOeWi; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+u7a78kJe6Ax3yIRpxPyNGtUPYL8ZqdVUpzbjqF9E3az8qs7q5Mg3kmmtw3N7p4EAq0itBE3ENf5ZGl2iJrfoCU8Iu2jmpE4u1JPxYVVnKP3AAPX0GMV55gwmH5P3nRULDf9RS21w1r36I6CWfv+SQWeGA/IY+6azI5TRcpVrLTr1UKzKbYU+diSPHhR5TznaZOBjeB/qhakGWAKlmp7d3cz7STVL+3WfMkmyA/vLTdK+8SLslBRDZ3NvvfeK3m7+7+1DkwtRSV877c9wdhYIvbeP+IzDBbEshGlNndc9SSwhfwkNKhAfpd/xNWQIH2hRJ8AHz4ebAhWT8NP9DTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGELJPTbxQqf3LLG1lGAbmBiYPIqTJbqTNwkz9I4mbU=;
 b=SJBXst2cXSjYl4L8gEslHKtItEX+EMumdwb2fqEAv/3NGYhXEKuhATednzu03XAJI3Ho20zkqRSSnUxNBV8gzgKZxVWWPoxVC2Yn+hZUgeZOTdtG7et/+77tcahILGo91EaQtkfG6duaLWNyqj93nrzO46DNXL9PnBq+AZJi2XDLruIxWDyssX/RYzp9dW2x7MK8MtBRbLPJ4Q870OlIS2v34eJVpet2+6T6TUbjXMXzbBPkjLD7VatPA5aZqkgVWyYj+JJ91SjZjvCOcg+B/IXZR0sdOrH0z/kk2CzL1gHvK+r70GMVB1sUJtHfPXMsNlmOuUFiniOv9wDZryQyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGELJPTbxQqf3LLG1lGAbmBiYPIqTJbqTNwkz9I4mbU=;
 b=M3wfOeWiZtJWETf7nOpLJoi6iSDbGCcVJ60cCyCLSe7n56Lpe30NtDThrhmO2PXS0iJd8VAEFeT8a3QrHzk66RUci/FKfCxRWYLjcgau3dlb0vrcVOsC7b5wIQhIWEXbTXyg91CZpiDt0fgu4KxCUQmNSo8ERy/2IaJKqeq5Iyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 10:36:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 10:36:57 +0000
Message-ID: <a3aba79f-ceb9-324a-d683-0c58876f6e1f@amd.com>
Date: Thu, 12 Dec 2024 10:36:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 08/15] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
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
 <20241211234002.3728674-9-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241211234002.3728674-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0088.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::33) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7cca30-7d3a-47c6-c284-08dd1a98e735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjFXbGVtbFpEbVAzWEhTcytTUzFrd214YUNQNWh4blFPWno0WTh1MDd0YVdl?=
 =?utf-8?B?OTZsUHFISjR3cWF4U1h0MlpoWm90ck1NL3M1N3ludStTamx4d3UyM2lETTlT?=
 =?utf-8?B?bW1Ld3VGcXE2eWJUZWZWL0s1djZ0Qkc3SUZLV2IzOEtWa0l4VTF2WXFpZW55?=
 =?utf-8?B?eUhZbjJPNmMzS3dOaE5MaEd0K3I3WHNmM3diMlJUdG5NM0N3MEdQcUZyTGF5?=
 =?utf-8?B?Y1BlYzdHYU50emdxVXZENmZLV3RSNnFVSkRkQ3RqNTBnM2VRcUxLV1l4Q1Q2?=
 =?utf-8?B?UHYxU05WRDZVTGdpMkIrTS9mZmJCNXRpNHlMUEpJQ2ZVcHVzdlFQUlExRCtK?=
 =?utf-8?B?NWtWSG5XdGRieSt5Y2xRWTNxckp3MVAyQ3ExTVduWlFVcWRIbjlGdjJUdUhE?=
 =?utf-8?B?djNhb1p3YVJ6SXlwSjVyaGlIWjhrcjFwOFRrTjhwbzRPVldjQUs4OExDK1NH?=
 =?utf-8?B?dXhXSWFLU1o0Mk1yUjA2MVJDSTlLeVlCT3BZVU5yWFV5bXlDNWplbkJEMW9n?=
 =?utf-8?B?YitsSTFwd2x5am16NHRRcmdkSDEwSXVoZC9hVzRjSWpGTFo3ajgyTXhDT1RF?=
 =?utf-8?B?bFdvRWFBcUhENzVYN1o4eWFKbjRzdnNIN2JyRjhUcnJhamZTbFB1dXUrYzF6?=
 =?utf-8?B?Vm1WeVhPZFg1bDJmdmJ0cWJsNGJhNy8vZVJEUjViRmROTGplZXBnbTVxWWlv?=
 =?utf-8?B?YmFSRjFNSmp3WkdkQjBUVnRsSGpucGZ1b1dQUEkrVmVFanQ3eDZvbTI1aTlh?=
 =?utf-8?B?b1pqV3BiUG1HZnRWZXFmY1RKVGV1TTdDRVlBQUpjK1NmZFF4TzkrdTcvM2dl?=
 =?utf-8?B?Q3FMWmw3ZEpTWFFvWS9yY3dyRUE3d2U0aUx2ekJmUFlURmJRNmZlU1lXUFF4?=
 =?utf-8?B?bjJwZktyajltd2tCbTIrbnJiQXZTOVlCVVlVd1pqYTh4RTl1c2FwNmMwTGt3?=
 =?utf-8?B?N05oRlcvbFFzWjlObm1BVGpBcmU1b2U0THJVdkkweTlpU3A0cGxiTTF0eG5h?=
 =?utf-8?B?Y2ZYeFpVOGtlMW5LZGpQYi83eUh5dW5aampYVExnUi85RDg5SlJIdnFaYkk5?=
 =?utf-8?B?czVXcmdWZ3RUNnpmM0dNNnp4VjMxMUZSMFF4ZU1GbHRvL3QxWm9UWDkrUGRJ?=
 =?utf-8?B?SXZWczhwQ2ZDVG5mQ1N4a1R0Z3I4KzROSGdGOGk0S3lQYWZzSlR1UG5IS1or?=
 =?utf-8?B?OVNmblByS1NOK1ZodXFObDhEWWJoYnpNK1VqaW5QbFp5MzJPcmxUOUMrRjlS?=
 =?utf-8?B?SFc1V3NhYSsydmlDNWRKWFhZSXRkL2Naa2dUcldRNWtJbCtiVnk4NG5VenVD?=
 =?utf-8?B?K0YzdWdmSGJHREZKT282MFdhQTE5ampTZjlDSlVPZDFVaHFiSzE2SUJHR3Rx?=
 =?utf-8?B?eFN4Si9maW1CZjM4L3RRMjI5djB5NGRTQXV2SFZUNkZMem5hK0RoT2JzdHJG?=
 =?utf-8?B?Nm1iTTdqaWJzZ29ndFJpZ2lDZkhEcnlPWkc5MDF2eDhoUUxERjNwdXhYQ0pV?=
 =?utf-8?B?VEtwRllIbmRuQWVWSE9aU1UyYnZKMjdDdCtub1psOUN2b1VRbUw5L0tmOWRN?=
 =?utf-8?B?d3RhVEU3NytKZW5GM3ZLQnRoRGk1Wno1TG5sVjNHZmxJK0IwbzVmTEZGMEJF?=
 =?utf-8?B?V3dWSEVxQzBteHNIS2p2Zm1FdWthUUdwRmhQdEl2ZzF4aEhHeWp2UFJlWXJK?=
 =?utf-8?B?THZUTXB0bFhSa1lGcWZKNnpoblFseTlUQnplci9Db2pxVlMxWDBJVzQ0aHd3?=
 =?utf-8?B?OEhXZllQUGNGb0V0ZlZUa2pGcTBSTTVRdlJxMHhSZStVMHM0REdBU3RlWWRy?=
 =?utf-8?B?NE5HYnZHTlFIb0NxMkltZ3lDQ0ExdTNySDZLM0xLelI1ZG9sZjhSclNQMjlT?=
 =?utf-8?B?aFRZb2F5TDRNbFRXSzZhZSsvZXFuc2p3ek1OS3ZnVGpwNVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk5EOGZKMHZ4b0tqaytRVzJXeTkxKzR5WnpWM0Vja2Nha2g3VmhYL0RsQWVR?=
 =?utf-8?B?WXV0ODZuYWxrVmlIOGhyYXBKS25rZ3FyaWJyMlVPZGljZXNkQU5nOE9reEF0?=
 =?utf-8?B?QzRXbzU0TFg3cW95Sk5rY04zTXkrVnJ3dUFteTNoNGx1RTZqaHFuT1ptWmpI?=
 =?utf-8?B?L3FualFQTDJRSWFMMG0ySU1rOVdsSy9uVUdoVWdjZlNDbjlQVVR6cjE0NlEv?=
 =?utf-8?B?aXcyZGZrMmJNV05aRUN6VkNvVitkZWV0cjVVYnhRcjVzbU5iR25LQkdVazZ1?=
 =?utf-8?B?dmlIODkzNWR3ZzlQSUZnUnFqbnBBNGh3MGQzc1hqUlAzKzFYNDBIU2IzRnZv?=
 =?utf-8?B?MkpxbzNhaGZXWCtHbHBkRk4yU0JjdjZSRTRPWDgyZ2tpMDRpVkQxYzBNcE1z?=
 =?utf-8?B?NmI4RFY3WEQwWEdONTRvQkZwSnZEbG92d0U5UUhYaUZmeFhmalVRSkYzcmxp?=
 =?utf-8?B?ZUFrOEZKOWpkK2g2WEhRQTRQQ2VwcDdaMnVLa0JZbmlXK3lzOUg2QklpRlJp?=
 =?utf-8?B?cmRzUUx5c0xIUHZ5blYvZStDYXM4ZXBvM2FsMmR2RFlPeU1CTEJ0UnN4aEFo?=
 =?utf-8?B?MlByeHNqVzZpdmlnOENGR3NOWnlhUC9ESFBqNUJaMFNJb3hSS3RDQzNCSnFm?=
 =?utf-8?B?TUFJRUl1UG00SWMwRFNmMDhZL0I2bUFXYzNiOU9xZ3kvNlI4MDU2RXh1b2wx?=
 =?utf-8?B?eis4Z2xselhiNGdsMjJMTDdRemZCZEpuTXRPM3VRUndGUzhRdWRibUIxWWVz?=
 =?utf-8?B?ODZreDV0cVdGUlozL0k5Z0d2MENydnZGRkNtckF5TU85RVlZS0pWRldjNk5o?=
 =?utf-8?B?cGRGQjRMaDNLYWRQdFlEcnFZUWNycTlxZVVwdzZBUWxkTEh4eFNvVllUcjBp?=
 =?utf-8?B?SEd2OXBKaVN5blduRXhBOTljM1dBZnA5QzloVnFGU1pEQU9KQUlYN255ZS9Q?=
 =?utf-8?B?U3pwSmx3SWRZcXBSN0srNU5pa2xsVE40Rk4vQnJFbC9OYUpmZDZjaHhiTkFJ?=
 =?utf-8?B?ajMyOTg0TXVmRXFlVUFMVWt2ZXR5K0syckFWMmoxeXpPNTFvRTE5ZE5sSDFr?=
 =?utf-8?B?NDBKSlQrRTBzenppcW1PSFkyZ0hQN1lxSStDc2lWTFU4Uk12ZGJTYU1MdVVV?=
 =?utf-8?B?WTlKMFFraC9JUW9LMUVPMkRRRkhuby9uc3NqY3ZMOVg3b0VkbWhsWFI5alR3?=
 =?utf-8?B?WTkrTzhZK2ZyRzErK2N6K3ByYWxSbGp1eVJpOUFKaGk0ZjBBREJaRE1YSjY4?=
 =?utf-8?B?b2Rwc0lYOFdrYVJOemZhbktCQ1AvT3NaWTZGeU55R2xwOHRud05iclp3QkRh?=
 =?utf-8?B?NWxYcFZzZTNZS29odGMyT1RmbmhJckNDSGJDTHhRU2xjQUtDaUltdGNHdWVm?=
 =?utf-8?B?Q0djSTFpc3p1Q2k2Ym9jd1ZkbVJiUEp4eExnNTVVMmJ0WGE0VXc5Z1dneWZm?=
 =?utf-8?B?bnppa2x4SDlNMDM0UjUvS1J0RHVYQWo5ZUEwUkhhY1hOQTh2aDdMQ3lFL016?=
 =?utf-8?B?elpRaDRvT2JEcnVCb2hPMUlMQUJ6dnZHWENUZTQ4Z01OUC9paVF1VzRRamxC?=
 =?utf-8?B?K3pzQy93OWQ0bWhURUZBRFdFYVYzKzdGbDNwRVZpVjNoelhzM25ldlg2T3ZJ?=
 =?utf-8?B?d1lrNkFPLzAzTWhRaU9xbVNqZTM3aHZzM1ZrOVZuZHk1dzlaL041YzcyL2dx?=
 =?utf-8?B?VXJmdGV4bG5UdERKQzVFQ0lodVR0T01jbURPZ3p4UStiWmx1My94VFc3cjZl?=
 =?utf-8?B?K0gwZmQ3RmxsaW5wS2IvZ3EwTHNGZnBpTExaeVpYeE9kMHFWZjNFOTBWck9W?=
 =?utf-8?B?bk1HQ0p6NzEwdUFqSTFSZks3RGhZSm1kYjZHRm1sNTc4OTc1cTBlNVVEUG5j?=
 =?utf-8?B?WVJ2cFhiT0RaWjNjTnlvcEdDQmhrekNVNS9DTENObDZQNThTRkg0RmpPcWUv?=
 =?utf-8?B?QnVrQTVhcitrQTFjT2pqZUZVb1dtS3JBamFmTG4rMWQ3UzRza2E5cm9FOU1M?=
 =?utf-8?B?Q2hhTEUrSzV4Uy9ydFVsWlhFMHdabldVOG9Xb2djc2VVT1ZMakl2RDNRWEpm?=
 =?utf-8?B?NGhLSFkvOU96WGdXbUR5eE1hNUhDdGg4OG50ak9LMjZYcDVyVlZuT3lXWnA2?=
 =?utf-8?Q?2RUwFznWyTkoRMR+6ESAXmgp1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7cca30-7d3a-47c6-c284-08dd1a98e735
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 10:36:57.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElUp9ocXoVb67hfLXvMkBYXeteXgpql+iYYeiIycmog5Gcv0gGChyaX6NVntfKfbCNxk/JjmvcTJ0qjGlAUmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390


On 12/11/24 23:39, Terry Bowman wrote:
> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
> registers for the endpoint's Root Port. The same needs to be done for
> each of the CXL Downstream Switch Ports and CXL Root Ports found between
> the endpoint and CXL Host Bridge.
>
> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
> sub-topology between the endpoint and the CXL Host Bridge. This function
> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
> associated with this Port. The same check will be added in the future for
> upstream switch ports.
>
> Move the RAS register map logic from cxl_dport_map_ras() into
> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
> function, cxl_dport_map_ras().
>
> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
>
> cxl_dport_init_ras_reporting() must check for previously mapped registers
> before mapping. This is necessary because endpoints under a CXL switch
> may share CXL Downstream Switch Ports or CXL Root Ports. Ensure the port
> registers are only mapped once.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


Just a nit but, regs mapping could fail, what is properly reported, and 
the __cxl_handle_ras function checks for the regs iomem being there 
before using them. But if the mapping failed, any report there is 
silently dropped. If the AER is happening, maybe to add a WARN_ONCE there?


> ---
>   drivers/cxl/core/pci.c | 37 +++++++++++++++----------------------
>   drivers/cxl/cxl.h      |  6 ++----
>   drivers/cxl/mem.c      | 31 +++++++++++++++++++++++++++++--
>   3 files changed, 46 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5b46bc46aaa9..8540d1fd2e25 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -749,18 +749,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>   	}
>   }
>   
> -static void cxl_dport_map_ras(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -}
> -
>   static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>   {
>   	void __iomem *aer_base = dport->regs.dport_aer;
> @@ -788,22 +776,27 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>   /**
>    * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>    * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
>    */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>   {
> -	dport->reg_map.host = host;
> -	cxl_dport_map_ras(dport);
> -
> -	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> -
> -		if (!host_bridge->native_aer)
> -			return;
> +	struct device *dport_dev = dport->dport_dev;
> +	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>   
> +	dport->reg_map.host = dport_dev;
> +	if (dport->rch && host_bridge->native_aer) {
>   		cxl_dport_map_rch_aer(dport);
>   		cxl_disable_rch_root_ints(dport);
>   	}
> +
> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
> +	if (dport->regs.ras)
> +		return;
> +
> +	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> +		dev_err(dport_dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 5406e3ab3d4a..51acca3415b4 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -763,11 +763,9 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>   					 resource_size_t rcrb);
>   
>   #ifdef CONFIG_PCIEAER_CXL
> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
>   #else
> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> -						struct device *host) { }
> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
>   #endif
>   
>   struct cxl_decoder *to_cxl_decoder(struct device *dev);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a9fd5cd5a0d2..0ae89c9da71e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -45,6 +45,31 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>   	return 0;
>   }
>   
> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return false;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	return (pci_pcie_type(pdev) == pcie_type);
> +}
> +
> +static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
> +{
> +	struct cxl_dport *dport = ep->dport;
> +
> +	if (dport) {
> +		struct device *dport_dev = dport->dport_dev;
> +
> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> +			cxl_dport_init_ras_reporting(dport);
> +	}
> +}
> +
>   static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   				 struct cxl_dport *parent_dport)
>   {
> @@ -52,6 +77,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   	struct cxl_port *endpoint, *iter, *down;
>   	int rc;
>   
> +	if (parent_dport->rch)
> +		cxl_dport_init_ras_reporting(parent_dport);
> +
>   	/*
>   	 * Now that the path to the root is established record all the
>   	 * intervening ports in the chain.
> @@ -62,6 +90,7 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>   
>   		ep = cxl_ep_load(iter, cxlmd);
>   		ep->next = down;
> +		cxl_init_ep_ports_aer(ep);
>   	}
>   
>   	/* Note: endpoint port component registers are derived from @cxlds */
> @@ -166,8 +195,6 @@ static int cxl_mem_probe(struct device *dev)
>   	else
>   		endpoint_parent = &parent_port->dev;
>   
> -	cxl_dport_init_ras_reporting(dport, dev);
> -
>   	scoped_guard(device, endpoint_parent) {
>   		if (!endpoint_parent->driver) {
>   			dev_err(dev, "CXL port topology %s not enabled\n",

