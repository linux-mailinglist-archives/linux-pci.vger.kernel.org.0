Return-Path: <linux-pci+bounces-18240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ABC9EE304
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955AB2844A6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449EA20E327;
	Thu, 12 Dec 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xr7/YRXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C420E337;
	Thu, 12 Dec 2024 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995693; cv=fail; b=HfUklZ9cNVl62PTuQmuXR+kx07Nd0swV+xRG/q0X+Qoeb8eTPjupKIMBbbm0sCzrrJLBiIjN02Ic6K3yoWYlfOraK7c6l2hsgeIyuY2vYuHA9q2seJBQtuc2P8E6x01fn2nAIBfdVXrBIliuBsqYvTBURCvi+2IW7x17vRVvf6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995693; c=relaxed/simple;
	bh=exomWPUWQBxjm1lFjS/3OOSb5ki6csHfBAQDDIUq/Rw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=olKmiRjt3aHrFBpm+PV/TE37Mr8EwuAGyqIyWItV5cEybY8Ooz51NWT9yHpdDbS1nU2MM4RjUv1VQTLEF15Bc2C+DfNvkQ37uAXVZHUnDR8pBoxgCs8nR0iFe2cgK8gneK718snbS2tnwQtUAdzu1iGoxGYnx74XyG4G+cPKX+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xr7/YRXm; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbwT7XDy6l3osANg2hR+BCXmi1HauzAX7paT4X0xbAnT5nCPEaJ5EI64Zhaz/9KV0OTLqP9UwIFpKAA141LluPc0ts/IbUUJzKkTzNnr3QBWcO6LdWTFWvL7ujcsPHY5zBfyxzef6NXVQNytqXShMlbW0yNjXl4Xoy7iqjom9cR8JpT+HDoAN77Bu3ZmZUZ+b4B1sP7gWDINRqXTsrI1v3yu4wj4hJBNaYnvinWGMKNRYEgL8kbVkQL8tKgDqbcpL/cBQHBd2h7U/La+Cgdj8VcWGXkDZLeZuGERPhDbONYVfVnl/o1SzM8HxmyCqkvfVz5AOERbuInT1K1IqI9bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5k5ilDy4+Pcatqayc5wEc9j5BYPGyE/EYGHV5klirxQ=;
 b=hkXtqZpSFMkqgAc+ooLHN+Br+1xj36mztHaYQWgwrn/+J1faTMuhXFtwNudyU8Rr0o7vseP25UGPpe5Z41VXCNcBgK++/xhzhysjEsTMMug8G/2SFneHBj/jvSBd9aXSj0ezRje/G4zP2Zqeh0z7erQMCgVojxQ/tWQnsQb7Xmocq76ZGfR9N4P73HNQX6G49McaCUaqrnPcuYUkBiZyc0EgJ59CGHho4rDv0vbEhmXVoQHryOOm4wRPxovMif9xGM0zQtcpxmbfhXlDr3hvqxEwqHL6wJ5K2G5K3uILEY9aiMXu9LwhQCxCU+BElV+Z/MYZmU+z/79CBJA6sZ5QGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k5ilDy4+Pcatqayc5wEc9j5BYPGyE/EYGHV5klirxQ=;
 b=xr7/YRXmBO3Hb0M7n+1oGyIC1fFExDgu1iwhr1BdMG+9MyVO8mRKP2u/+nfBy4SnfB6m2LwM+ZHo7aQeVjz3yvVB1oBqRV2nh27y7OlkHfcvZcjleaSfjcRmnZ594HRDIUCKRIqEu+ikYcjoHQ37jdqjjx0rbCQdpGSoA+a/b2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 09:28:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 09:28:08 +0000
Message-ID: <58b9bcce-ac76-e0d0-1a8d-a8d8c0b20b43@amd.com>
Date: Thu, 12 Dec 2024 09:28:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 07/15] PCI/AER: Add CXL PCIe Port Uncorrectable Error
 recovery in AER service driver
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
 <20241211234002.3728674-8-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241211234002.3728674-8-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 76572e05-0608-4318-5030-08dd1a8f49db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzFaYU1QZjI5V050cEhxc05VRjAzYTNJb0NPUGVHdiswQzl5THFFNlBBMTZX?=
 =?utf-8?B?ZGRtcnU3Z3JaK2JzK29sRGdTOWxjZVRTT3FENm9CTEwzOVBjNWFyT1FWTzd0?=
 =?utf-8?B?TzMyc1ZXVTlKWXZrajU2QUVaK2gwOG95L0htOThHb2FsYlYrZ0loaW1zcVZl?=
 =?utf-8?B?aUd6VlZtNmplY1V4OEFvUlYyeTVrT2RCMzJnVFQzSGU5ckRjWE03d1FUcG1o?=
 =?utf-8?B?YVJ0WkxqcjRVc0daK3hqditCL0RpajZNS1NIRG9pZnE2VlVsdHI5NWJyZVpq?=
 =?utf-8?B?Q1FsT1dEaWpSa21tQlNNam4zRlgxNDMwM280YzFkV1lFd3FMeTNvT2dsMVlD?=
 =?utf-8?B?TlFjOUxTeDFkM2JJUWFsTVlaUVVrNU1LNTFqR1VNdVd1M3FTdWl5TWZLOUtw?=
 =?utf-8?B?UlR6Z0YzV2d6UmlKa3BOaEFOMDRRUmNJaTRLZGp2WmJVSzBlRlNjb0JNaUdn?=
 =?utf-8?B?ZDZ2aGdMcjZ2d1puS3pNSG1WQnphaDYyYzNEb2J6WHZNSC9hY3NZV3U1RWsr?=
 =?utf-8?B?SHdjUXZHSnRVOUdLWmcrbUlpMnFLaVBlUUxKbUZtVFpxbXdwTjA2S25UZXpO?=
 =?utf-8?B?OUM5V2VTWUhwaFdlcUlseGZCbmREY0Y1N05Pck1wK3FndUpLQUlFaEoyWVVZ?=
 =?utf-8?B?MG0vbHNBd0cyNDJBYk9xVWwwR2V6cFc2cHEyUXY3OHhIZXp5dldPcGtzVnc4?=
 =?utf-8?B?MjFEdFhYdGpCZ09nM0h6SHlDaEhzSWtnRE9YOXRkdXlvNmovb3NZTHJMalZ2?=
 =?utf-8?B?R2l1aVQ1VmFvdktuR2wyVTltRWJpeGgrdlB4N0dNRy9aOUU2NzBhSDBGajly?=
 =?utf-8?B?UVRpTlJjTkJHN2szUStwS3JCMjA5ZTE2RzVQL3g3VUl3eWZHckdXd0t4ZnJt?=
 =?utf-8?B?SWdKV2VaWWIvbzFMVUI0NFdqa3pNaUwxaE5WQ2NSeXFHYlZGZDdFZ0lEV201?=
 =?utf-8?B?VWdDbFBiNmFYY1NnRHVWTVY0UVZhbDZXaFhsdzV1Vm02blBsZ1RDK09Dcm44?=
 =?utf-8?B?V0NoTkgwdHhjL2thWHdoQzFZeE1LOG5IUFlyZElXMXMvYmZxbi8yMGFtNjRM?=
 =?utf-8?B?ZERkanE4K2RsakdCYnBSUlVzUEh0MzkrUHNIRTUwcXJIclR5YVFtK044ODFx?=
 =?utf-8?B?bW5CSGpTUWJJenZpOE5zbEYrNlhCMkM1ZGJuWmd1NFdyaC9EQ1ZDc3VCTWJL?=
 =?utf-8?B?QTd2NkdLRjMybmlmT2ZwcE44SmJkOGZyN3B3RGZBc2gvNTVtTzVsNmpFS1NJ?=
 =?utf-8?B?V01EYnEzY1V2aGM1UHFzc3dMa2FYcy9ld1VER3JXMmE5N0J1OUsySkFlaXlI?=
 =?utf-8?B?ei9Ld0NNU09McVEwN3JoUDZOQWNPZFNMYXEwQXhDbEcwNnAzQTB1bnhyb2Z5?=
 =?utf-8?B?alBOY0NYZ294a1doVVlZUmlBTmM3SGJDQXpUQjR1UEo4WVJVaEJKd1l5OXp4?=
 =?utf-8?B?ZE5jdjJzYjkxbEVJcHZBTUl6SGZpSFN1M09qNy9SaWNhdklkWXFLQ0dVOFJz?=
 =?utf-8?B?L25LUVVOZEg5OVBIb0o5OHV2UzZKSGtNVmg0Z3NZbmkrWEVoZ0xlYisrUzV2?=
 =?utf-8?B?bDBpQlFaMWlWTVFPVkN3TU9Db2hUNVB6NWdPQVlNTzRlZTZidG95aGJDQ2RF?=
 =?utf-8?B?RE1rR3lsN0oya2N0ZGFZcmt2Y29vY2NuQ3IrdG9JcDY5T2o0WWQ3N1N6dWlo?=
 =?utf-8?B?QTgxYk1uTmkydGFGdGVZMHRrOXVWRkRBVGVuclNzVWozYnd6d29qZUVEUkU3?=
 =?utf-8?B?a0VzaU9SQURtblRjUVZYTjZPMkt2aGVjUG9kc3RkbkU0VHZ4WmpGUDdVYUR4?=
 =?utf-8?B?eTNGaEtjRStpc3U4blk1M203djJ5a29WZDhrWGxsejY5RmdNcjJSenBBSUo0?=
 =?utf-8?B?bHQ1eUViazM2ZmdTdFBSS2VPc1VWZC91ZkVtUFQ1a21JZ0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXBhak54aThGWnZCOTBnYmJUelZBZ1h3cXh5OHl0RmMvQkV1aHpsT1V4NmV0?=
 =?utf-8?B?eWRUMkVoL1ZqS090L1hoUTY4cEREb0REMEVTUEhvWkNZV0FYeFp3Y1RNaERE?=
 =?utf-8?B?bkxpd29jZEZjU3BaV2tsa0c5anE0RC9xQW8rbkdlM3VIaWhJUG5rWEJpL3RJ?=
 =?utf-8?B?VHNKQjhETlhDTXhuR0tVdGpyU09YQkNPc3cyRzROVHkvQTF5cDZlRmJmSm5O?=
 =?utf-8?B?MVNFaTVReloxVmQrODl2eUJZaysveVhGdEVQQ1hLMUcxMGhVTHRnU2NvV2NP?=
 =?utf-8?B?RWVDSHZZN0pzR1NOeE11aGd6SHZ3VGZ5STVnSmo5UlNnK3VaQS94cVVZN3ND?=
 =?utf-8?B?UkY3ZEVGam9UNkc4dGV5dVU2WU56bUR1eGlGSmlGRitaMy9FamlWU3hIRFEz?=
 =?utf-8?B?QUFwUjF6REpnVmJ3RzFrU2xYT0k0d2lIQm1kYzdoMU5CSENTL3ovTllvOFpN?=
 =?utf-8?B?NzRtd0d0WTRadkU5cC93Nmo5Y2xYN3o3NDNRSWJBUlFDRkxQM012MDc5K3Fr?=
 =?utf-8?B?L3phYytXNHc2cTh3WHAyL1ZCMVYxNHhvRGRwMzEzMFhqT096aHRHTXprVSty?=
 =?utf-8?B?RDFnTFVseVczR2drTzhwNmRsSXorY3hvYUlIUFYwRWQreUExcW1JLzFkNEdS?=
 =?utf-8?B?TW5OVHFaUDhQWXhjUjlJNndGbXJtcEp2UC8yNnNHOVY5ZDE1RThOenRPblFE?=
 =?utf-8?B?Yi9BMFUzRE5GZVl3V0d1Vy9FMXJQRGxqUjdvQTdmV1hiQTJXM3RNeHFEb294?=
 =?utf-8?B?VVpneVoyOXdnZ3FucDFoaThMWnlac1llTkpneWxZdk00UkROK2ZuWUN4ZWhp?=
 =?utf-8?B?QzZjWnNCTzVnbjNZN0lya2N1SzYvOEJTa2IrVmVETVZmYXQvdVg0UDNuMTAw?=
 =?utf-8?B?WEFFTEZaNEFEelM5V3p5cjE2SytuYVZ4bWIyREhtaXdlZ2s0dllxMmVaZnBS?=
 =?utf-8?B?R1lwL1ZoT2hQQzN3b3FpaGdSSHF5Y2Vxa0tTNXlwcmF1c3NORzBnT2o1T1gz?=
 =?utf-8?B?dmxlYkJtR0huYjlGOVo5c2V1NFVTTGx0MVlvRDdLcmlTOTRlZVdza1F0WWFW?=
 =?utf-8?B?TnJpM2JyS3haRHF2L2h3dFRFVURYbnVRWmMvMGJqRzRVdUFXbWVtMFJzOTR3?=
 =?utf-8?B?ek1JRkRDNURUTTBYenI5bmlaTitubHF0aG1EcVFMcDJhTWJzVXd0WjV2TUxT?=
 =?utf-8?B?R0xEc2JNcUtKcWMyTnRzME5KdkZUUnB2N3RLOGZPTDQrcnVHSHlZdXg3QlAr?=
 =?utf-8?B?dUZyZ21KMXNiZWtCL2FSWXhraTgybXVpT1Z5REh2b0pDc2E3UzVZMis4YldO?=
 =?utf-8?B?S1hDYjdDM2tweGtubnJDSHJQQTE3eTUybFpVSU1aL0laelpBeXlYY0Fzdi82?=
 =?utf-8?B?SlUwYnF6eG8yeUZXVHZqeFhHQjZpSkp4R21IQnVvTitiRmErbEdLQ3JEa0VM?=
 =?utf-8?B?KzFtK0FQRUhMNkJLc1pFUFlKNmxtUGx2bXJHRXdueUlkcmtkTGFNYjdnVFlI?=
 =?utf-8?B?dllzMVFMZXVFVHFDam00ZDd1WXk5bk0wc29jZGdQbUJvbDBjKytlRExXR1p4?=
 =?utf-8?B?VUJkckhLRnYzb0pMalFLQ0REMVdzNDB0WnF5enVRa3FNL1VGMmRzcEgrOHBi?=
 =?utf-8?B?REw5YjlnNDBTQ1UybHpLblZwbEhKajMvazBGL2JrSmhXQmNiYUdIc0FKZWxB?=
 =?utf-8?B?WUpJa2lXQS96REZKa3lxQXhGbWdnYUtESnUzWG9WMVVqSmUwdDFjMjVvTmVW?=
 =?utf-8?B?R01admFlUTlocFc2TEdReEVTcHlrOUZOcWIrTTdaQUg2eGVPTUlCYTBUVnI4?=
 =?utf-8?B?VlpqREZ5TkN3MHhjblNOZDFDUktFTzY3R2d2UG9WNTluTW1EbjNyWkxCL1J4?=
 =?utf-8?B?VVdCWUQ4V3hKKzJmanN5MVJIVXExS0w0VExxTlBQVk9TamlJOEh2ZUlZMTdF?=
 =?utf-8?B?b0x2elRjK3JHK1JENSt1V3JoY2p2Q01xWGtPRm1xTCsrblRzeXE5c2FUSlZn?=
 =?utf-8?B?Skd3bWlucjJVdzQwaHdsSTZySDRlRUZiODY0aEl1c0pMNUNnaDJCenhaQk9z?=
 =?utf-8?B?RjdHWnZ6c0lnbk9DWTVxQ0RwMDJGOHlpWlFWb2tSWkdHa1lrY1lOSG1LTGxP?=
 =?utf-8?Q?iKW1KOImrU9mAQE72Rm1j/fui?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76572e05-0608-4318-5030-08dd1a8f49db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:28:08.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qaMVssjQiIQNhssR+fkK3IUOCLCPBywU6Au0aV0T+qeq7oEiiXoeRutxOLSoy772iY5ppMOyvq4r/ggsN1L4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060


On 12/11/24 23:39, Terry Bowman wrote:
> Existing recovery procedure for PCIe Uncorrectable Errors (UCE) does not
> apply to CXL devices. Recovery can not be used for CXL devices because of
> potential corruption on what can be system memory. Also, current PCIe UCE
> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
> does not begin at the RP/DSP but begins at the first downstream device.
> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
> CXL recovery is needed because of the different handling requirements
>
> Add a new function, cxl_do_recovery() using the following.
>
> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
> will begin iteration at the RP or DSP rather than beginning at the
> first downstream device.
>
> Add cxl_report_error_detected() as an analog to report_error_detected().
> It will call pci_driver::cxl_err_handlers for each iterated downstream
> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
> indicating if there was a UCE error detected during handling.
>
> cxl_do_recovery() uses the status from cxl_report_error_detected() to
> determine how to proceed. Non-fatal CXL UCE errors will be treated as
> fatal. If a UCE was present during handling then cxl_do_recovery()
> will kernel panic.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>   drivers/pci/pci.h      |  3 +++
>   drivers/pci/pcie/aer.c |  4 ++++
>   drivers/pci/pcie/err.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 61 insertions(+)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 14d00ce45bfa..5a67e41919d8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -658,6 +658,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   		pci_channel_state_t state,
>   		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
>   
> +/* CXL error reporting and handling */
> +void cxl_do_recovery(struct pci_dev *dev);
> +
>   bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>   int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>   
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c1eb939c1cca..861521872318 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1024,6 +1024,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>   			err_handler->error_detected(dev, pci_channel_io_normal);
>   		else if (info->severity == AER_FATAL)
>   			err_handler->error_detected(dev, pci_channel_io_frozen);
> +
> +		cxl_do_recovery(dev);
>   	}
>   out:
>   	device_unlock(&dev->dev);
> @@ -1048,6 +1050,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>   			pdrv->cxl_err_handler->cor_error_detected(dev);
>   
>   		pcie_clear_device_status(dev);
> +	} else {
> +		cxl_do_recovery(dev);
>   	}
>   }
>   
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffc..6f7cf5e0087f 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -276,3 +276,57 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   
>   	return status;
>   }
> +
> +static void cxl_walk_bridge(struct pci_dev *bridge,
> +			    int (*cb)(struct pci_dev *, void *),
> +			    void *userdata)
> +{
> +	bool *status = userdata;
> +
> +	cb(bridge, status);
> +	if (bridge->subordinate && !*status)


I would prefer to use not a pointer for status as you are not changing 
what it points to here, so first a cast then using just !status in the 
conditional.


> +		pci_walk_bus(bridge->subordinate, cb, status);
> +}
> +
> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
> +{
> +	struct pci_driver *pdrv = dev->driver;
> +	bool *status = data;
> +
> +	device_lock(&dev->dev);
> +	if (pdrv && pdrv->cxl_err_handler &&
> +	    pdrv->cxl_err_handler->error_detected) {
> +		const struct cxl_error_handlers *cxl_err_handler =
> +			pdrv->cxl_err_handler;
> +		*status |= cxl_err_handler->error_detected(dev);


This implies status should not be a bool pointer as different bits can 
be set by the returning value, but as the code seems to only care about 
any bit implying an error and therefore error detected, I guess that is 
fine. However, the next function calling this one is using an int ...


Confusing to me. I would expect here not an OR but returning just when a 
first error is detected, handling the lock properly, with the walk 
function behind the scenes breaking the walk if the return is anything 
other than zero.


> +	}
> +	device_unlock(&dev->dev);
> +	return *status;
> +}
> +
> +void cxl_do_recovery(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	int type = pci_pcie_type(dev);
> +	struct pci_dev *bridge;
> +	int status;
> +
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    type == PCI_EXP_TYPE_UPSTREAM ||
> +	    type == PCI_EXP_TYPE_ENDPOINT)
> +		bridge = dev;
> +	else
> +		bridge = pci_upstream_bridge(dev);
> +
> +	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
> +	if (status)
> +		panic("CXL cachemem error.");
> +
> +	if (host->native_aer || pcie_ports_native) {
> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +	}
> +
> +	pci_info(bridge, "CXL uncorrectable error.\n");
> +}

