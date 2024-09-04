Return-Path: <linux-pci+bounces-12783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A722496C7E3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 21:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CC31F243F6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF501E4938;
	Wed,  4 Sep 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OfeH11ES"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA540C03;
	Wed,  4 Sep 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479318; cv=fail; b=t0KNzPIfdOeD4hiPIFZh6PGx5JHfrkeCGhz97kQ2MSRoWzuFpZJ1/kIE3yoZJRlFMvNaTFa3clJLneBVWkBJ0nJPKGzwm6gG+Aan9tWhT8IBebA1q+NRpfFEZ9jGDY7Xx+g409AdCU/5wvpSZtExAxZEljzr9rkbqkBOZuqUiXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479318; c=relaxed/simple;
	bh=8LXZFt5EfxQQ/q1PH5CPTHR44adOdGZvuPZA+d711s8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=omPZak6b0oeMvJWZEf9/F8lY6QMhueog5xKvMRY3DPCxNnJ4ZUmvEwl01mqZ1VzeobjCtHmGgyRN46kwx2fwSeklIFYN2JceWNJ6cpOC3cTa6MSOgBfvq2QhtD5qSe9hiqSG67CKTlFUCS7N8tcxRFhK85UQ/FkVL0bbqbV0o3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OfeH11ES; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGI1+GCPZLwgoBQUM5ActachixWHU69HMPBcu+37u9XXOFfpFmXfgwKziXzJ5eby6Su6YLcted3iC3qevPwM/yrkYWGCbYUfg9ontFxph0/IvuJSTgkk8PXWMMqGFIsJ2AxPqxF/JaW9/NveU1lJHhfmAB2nf7xKKS1Dm5Fp3iD6U8dcgIMz5ggips9tKRcocy69ay9+MhEEeES5UTAXFv11wWuN4PmN7jjm2IrzzaI2F5ret3NFBMSLJKZ+SRDYUCFEoqdmAOWYQ+svgxkwIJc3oGoq2edvPQTM153dy9MBmvjxOlYGz8CA1QWtLL1F0MOeQbj3qgAvIdVT19O4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op+7j+ot4mXqYGCk9uiBNnkra+Tx822j9uajDFeC3EA=;
 b=vYaCc8WxUWB396GjMAsWudDzqdbDW9ruW9+DBu6nebFjTdnipet1lvifqlPKgOaG6QKRFy4UE7cegf4j2LX/AgjiDvRNmd/bA5FyHwA2xobi3/4RjFPIQVeajonAGVr6JnfZIPWyxOGMKm4Ql4gSQun39qOOBc3k3LejjnB/KKTjXy+guycaq4dksg4zQlU+V8VvXqCHfzSdED0p1SlqkwyewuO3Q2cv210SrQtaJ/C3ICh/ykdoGsTLMj4GobUQuYFdnusKEA4M8s8lFJFg70k/YIcL34qD0YPYVLS5MOLrIqjFBnB91CzuAbClYs+qBzDEZZk3mPJHocECbdsTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op+7j+ot4mXqYGCk9uiBNnkra+Tx822j9uajDFeC3EA=;
 b=OfeH11ESOUC1dcBnPORQ1g2Z8M6cfVcbvgaJKluSWu6TaNzd+Z78dNJL134sPEMuMxhQzpzQKcL1dISbTTUyaaq7uU1J1khl7Ni4jMlnxqFG0ZuPcTPF0lXptgzBKnQDX0ME1zOsDRJYCyp+6tKdXc5vINuzsSMI6D7LFlr6d8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 19:48:33 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 19:48:33 +0000
Message-ID: <a1459350-f458-470b-a288-a92e2085f93a@amd.com>
Date: Wed, 4 Sep 2024 14:48:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/12] PCIe TPH and cache direct injection support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240904184911.GA340610@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240904184911.GA340610@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:805:ca::21) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad6b8ba-2c0c-4649-7649-08dccd1a8eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEZPLzJXWXdzRTh6VHpPQzRQNWtKbnAwM1crdytKaE1ka0RkNEhUNWRMUnY5?=
 =?utf-8?B?VllZYWU4eEllVUdWbWx4NGFKTjJFanRUTmxSLysvc3NhOWl4YmtWMDNKZEpY?=
 =?utf-8?B?WnZUQ3NUUE1tU2hiM1puVjFDZVFqTlM4WThMVDYxSWZrWC8xZTNuUDZJeFBv?=
 =?utf-8?B?MFgwMjJvVFg0MDZ4LzlnMmdDSVhLZnVHYUx1SnFXeHlScUpnc2lYdnp6dVdm?=
 =?utf-8?B?d2pGL2NGa2crYmxkQTBhUUhDZThjb2pNRHMxZDhUSmxIbGR2MGxuKzByVnll?=
 =?utf-8?B?OEl4TWpMcXduVFhXek9uVitRdUk0ZDBSNEd3VmVWS0lYK2tnbzZWVjlrRGNC?=
 =?utf-8?B?NVdmOFNYZThmdE1IWkZoZWdLYXlJa2E3T1hUemdGNVQrdWNkUzVBRFAxdUhM?=
 =?utf-8?B?VEpHNXh5RTJDbElBMjB5a2UwazYzRThLSmV4bGI2R3J6eGNSNEprRDhaNGF6?=
 =?utf-8?B?cDlFT05ZdFh4VmZrVCtzeHk3WGJINkFIbFNJelVrTkpTSDNJMHM4VFFrNTZO?=
 =?utf-8?B?SDNjZGFSWHBTWkk5eEQwRU9xYTdhcFVtWlcyVEJ4TG1ENENzMjB4Mko2VmZu?=
 =?utf-8?B?dEdvR0J2Z1JQMFJubjFleVAxZGdDWlJ4YjdXeU1GWGY3aUtYb1NWeXlPWW43?=
 =?utf-8?B?emZRbmhZZCtVUUt6ajBBNW1IUWtEcWVKZHVOd042ZU44QWpvMjRtNWpRRVZW?=
 =?utf-8?B?Z2ZWQ0hoSUNROXlIdktXemJ5cFZNUG9rK0VZUysvYXZMa3hHN3B6b0tyREI3?=
 =?utf-8?B?ekpSS1kweklKWnhIR2Jpa0REVHBCTmJrRlVWMm5uUTc4c2pvVWZHMzB2VGdE?=
 =?utf-8?B?MWpwM0V6TE1XRW5WbXkxU0QwM3ROUTlEdEg5d1A4Y3g4WFMycm50TllaSCtn?=
 =?utf-8?B?WE95VXg0ZTZER1lRY012TkFSTjdLUjVlbkpRTENzdGhOc0xoOXhpVHRMMTl6?=
 =?utf-8?B?b29NTzBJQUxZcUhWUjM2NXJ2dUQ5bFd1RmNsbmNVbjkrOU9UcTFOeHlNZU0x?=
 =?utf-8?B?c2VWaGxINVRFc1YvNUZiTjBZV0tnWUkrWXg4UWJEK2pxN1B2T2UrSG9LMlpk?=
 =?utf-8?B?anlQcWdDN01JQkR5Q2tDOWV3Ym03RHNZMHUrTXpWRk9NUlJ6cy92RDNUaUdH?=
 =?utf-8?B?OVIzSlZlNVFmZFVyL3oyM0RQREg5RXh6QmNsQ3ZWTmdGbGJyMkxOb1hwUzhO?=
 =?utf-8?B?ZklicDlNb1lxR1BBTnRuZ1daeFdQMGJQSy85YmVCWjZMNWNwNHBOZWpDeGth?=
 =?utf-8?B?SWlDYjhnNUJ0Y25XNm01L28yVjVvd1dOSEl5VHp1Ym1Ybko1UkxrRTVjd0R4?=
 =?utf-8?B?ZlRDelIyTnBJcXZ0cnpwbUFpNTk5Q2lLRFh3VlZmU0ZQWTJkeHE3ZmtZRzRM?=
 =?utf-8?B?SnJYdXEzYjA2M1V5ZDhDQ2lrNXVxZFk4QVpEU1dRV3E4c2hkdVJrMHc0UU9N?=
 =?utf-8?B?Rk1QQk9YWWZKWjYzZHdFRVlvM2xRbDdtN291SU9XcTZOaDRIUlcxK3hjak12?=
 =?utf-8?B?d1g0elI0SEVkUmJSTU1RQ1piam1qaHdPMU5yQVZja0JxSnU2NE0zTUhIYzRG?=
 =?utf-8?B?SUoxYVRPTlJUdUY1VkxmaU1wbjk5ckNmNVBSN2hBYStJSGR0VWpQMzB6V2cz?=
 =?utf-8?B?dHhXeVpjeU1ublNrZnJmcFI2NDh3RGRmYnlETHZFNkNlL281T1ZqdjZYQUl6?=
 =?utf-8?B?bXpMUWN4eGlTYkdHa043VTJEQlBuQlgxUmlvSlI5QUl0cXpvMjhVL2k5NzNM?=
 =?utf-8?B?M3lib3VNNWhqazd0SVc3ZmJWY1hyYkQrNHFFamkrM3N6UnVvakV5VlNQZWh5?=
 =?utf-8?B?N1JzK2xYL2RRNnd5MWZ0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bndPSkRKSnQydnJRZXY1aTlBa1F6Q2l1NHh4c1ZyWWhYM1N4Vm5HVkxiNVQ4?=
 =?utf-8?B?UmpWSFc3TnJXeHZYdmdXVDVWaTJDVTlDdTBjWk9TTExjOXYwSlBoU2xaZW9t?=
 =?utf-8?B?NzYrRGtTOUlFempnYTM2YjZEU3YvZnVFVHRLdFVaVXN4VndyT2RDYVRmWDV6?=
 =?utf-8?B?K0FNcFNrVEtvNGd4Vm9aS2hoZStxT1BGV1lRTitzLzJQbG9ldWFQM0w2YmRE?=
 =?utf-8?B?SlpaQy91Um1INkc3Y0VrVDRxMzU2eVhtY3RWd2lLekFkN05TRXVMTjJIS1o2?=
 =?utf-8?B?YTErMnNNT1NhangreHVGUjJudmYyWFA2UjFKYWpYS0VRcW5BZXVoSDc2SFJz?=
 =?utf-8?B?bDdlSHNRNC9hNWl0amlOQ1lmVkNwVkk0cWcrZVZFVFhjUVpHMVFjbnQ2cW13?=
 =?utf-8?B?SDlseTdYdzFoSnpZSVh4Y2VLMzNHRHR3M0JlUmtjbUQ1dXdWbldtbjdjanFp?=
 =?utf-8?B?WFdrd3hMRk5uZm9uZkpWYmwyc3ZEZkd2c3BCVVlzdGR5cER0SmxvNkE5UEpE?=
 =?utf-8?B?dHpIUjBqaUs2S2tGZzNPWmNtUkFZQlk3UFAxUWRzZEFxelBCdEZkTnlUWDgz?=
 =?utf-8?B?cERzT0dOTEdMV0xXUkdTajk5QnhlR0ZtZkJ2QXhwVVBIMmx5SzJDNE9WR2Fx?=
 =?utf-8?B?cnZLNGpSSVNwajI3SjQ2QWpxYTZuWTI0MnQvK3hpZGNkVkFHMDZ5WjlkMUpt?=
 =?utf-8?B?VHZQNHpMNDM3dk9zdFBobjlYdEt6QkxJMm42b0EyTzlaVE8zVXcrWElUWVpS?=
 =?utf-8?B?TER5R3Y4TVlPWUVTUUVCUzZRNzcwOE5wVlQxaHUvMVdvUUpYTEJQZ1lJODVS?=
 =?utf-8?B?YW5PK3hvQWtqcXMyaXZYSmtaWkVBM0VKa3dBOFJuN2lpaFRjUTQ0MXRMVW9Z?=
 =?utf-8?B?YWxoZ2ZlK0xDZG0yZUExQ29SNVJXaGZINjdJQTdheG05ZTlHRGVhdFhxR1Jn?=
 =?utf-8?B?SnlLdUNGWVd0aDdCMVFnOVRhUHdNK1R4Vk5OZE5NeDVuRHVQRU0zalRKaElO?=
 =?utf-8?B?OTlPVlE2d0JmTmxqQ29MbWc3L090dGJlNXlTWlFVSmRONk1TRithYUZ2WWla?=
 =?utf-8?B?RmdPWEFqS3FmU1E2VnY4VnBXdHAvNGdUU3lhVHBCQi96TDRhQU1va0JsWFJP?=
 =?utf-8?B?Z2ZiM1VLTmsrUllvbGJ6cmxtbGwrWkFOdGlQS0FMTXd2ODJpTEJRK01wTm5i?=
 =?utf-8?B?SXhLeFdkK0o1czBpVkNuRWN0VG5WcGxNc1NJaTd3K3dwTnF4RHYvNUVkV0xY?=
 =?utf-8?B?SG9QOEhVUHZpTHNJOXJRVU5TTmpMNHNmNnYrWjIwYkM1N3FNdEU1VktGelcy?=
 =?utf-8?B?K2xsTFZ3UkhLSjd5YVdQUS9rN2FVQ0R6TlArd1ZabzlqTERqaTBQN2hZV1JM?=
 =?utf-8?B?T3hkZitMM1hJWUdEdkUzR01lRkZ1MmFNUzJJMWFZTDlKTWxTS283STVBeld3?=
 =?utf-8?B?TFdvMkVpb2s1cTI4R0ljU1l6QkJtLy81dGJmVWUwditCT3ZUdWF1UkJQb2Ns?=
 =?utf-8?B?a3RzOHpSZUMyK2xxam9waHJuVWlwSE1HNVNkZjJ0MFd2Q1VQdjAweHo2NlRl?=
 =?utf-8?B?NGxCenI3aGRGTEYzT1hSK1p3RTh3S2d1S2J2Rnlvcm1kcmEycjY2K0JzL0w5?=
 =?utf-8?B?ZDQzWk4vSGZPMVJ2OVVkUURPY3llVW1LN0pHVmh5Tjg4SHZCYjRGZnhUWHNi?=
 =?utf-8?B?VzJTUnRFWTJrTXN3aDh5N0pXV0p0aVpoVzBHNTYzc1hraUZGQzNScTFVa1Nm?=
 =?utf-8?B?RjNvM1NJeU42YXlwSDJSRmtIME9GQ3pkMWJ4ajFSWUpPVkRUdy9RMWRRNzgy?=
 =?utf-8?B?V0F6aWtWbG5Hd0tRTmYycXpmRHI2Y2RYbldXL3hpTUlJSGwvclcwRDVhRjdX?=
 =?utf-8?B?Rmpnb2pESVYvQmJEQklkNHlRWmRLcm9Ecm9HeWd6dHF1UjNLMEtyREF3SnBL?=
 =?utf-8?B?NEUycGR3RUs1a3NDRTN4Y0NZVkNNWTVmMnBiWWdXWVZOTTY2M2duQktERWtF?=
 =?utf-8?B?S3FVWVdqV25EbHI1bWYybGZCY2tpSGNOUGVxcjJMWDNzVFVxYlJpQ3hHUy9a?=
 =?utf-8?B?N0hGSUlEcmhaSXY1MTZYOStRMVI5TGVDemZhWHlKQUY3VUp6UXYza294K25W?=
 =?utf-8?Q?1Y8U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad6b8ba-2c0c-4649-7649-08dccd1a8eed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 19:48:33.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ym3J5Vqi/VY5VS7XVKrgkNKDHAtW7UTiEpq7eGGy81p2PBQCP99V5nfivDZP5rc0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176



On 9/4/24 13:49, Bjorn Helgaas wrote:
> On Thu, Aug 22, 2024 at 03:41:08PM -0500, Wei Huang wrote:
>> Hi All,
>>
>> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint
>> devices to provide optimization hints for requests that target memory
>> space. These hints, in a format called steering tag (ST), are provided
>> in the requester's TLP headers and allow the system hardware, including
>> the Root Complex, to optimize the utilization of platform resources
>> for the requests.
>>
>> Upcoming AMD hardware implement a new Cache Injection feature that
>> leverages TPH. Cache Injection allows PCIe endpoints to inject I/O
>> Coherent DMA writes directly into an L2 within the CCX (core complex)
>> closest to the CPU core that will consume it. This technology is aimed
>> at applications requiring high performance and low latency, such as
>> networking and storage applications.
> 
> Thanks for this example, it's a great intro.  Suggest adding something
> similar to a patch commit log, since the cover letter is harder to
> find after this appears in git.

I'll incorporate some of these descriptions into the TPH patches where
relevant. Additionally, I'll enhance the commit log for bnxt.c (patch
11) with examples of the benefits.

> 
>> This series introduces generic TPH support in Linux, allowing STs to be
>> retrieved and used by PCIe endpoint drivers as needed. As a
>> demonstration, it includes an example usage in the Broadcom BNXT driver.
>> When running on Broadcom NICs with the appropriate firmware, it shows
>> substantial memory bandwidth savings and better network bandwidth using
>> real-world benchmarks. This solution is vendor-neutral and implemented
>> based on industry standards (PCIe Spec and PCI FW Spec).
>>
>> V3->V4:
>>  * Rebase on top of the latest pci/next tree (tag: 6.11-rc1)
> 
> No need to rebase to pci/next; pci/main is where it will be applied.
> But it currently applies cleanly to either, so no problem.

Got it, will rebase to pci/main in next spin anyway.

> 
>>  * Add new API functioins to query/enable/disable TPH support
>>  * Make pcie_tph_set_st() completely independent from pcie_tph_get_cpu_st()
>>  * Rewrite bnxt.c based on new APIs
>>  * Remove documentation for now due to constantly changing API
> 
> I'd like to see this documentation included.  And updated if the API
> changes, of course.

Will do.

> 
>>  * Remove pci=notph, but keep pci=nostmode with better flow (Bjorn)
> 
> This seems backward to me.  I think "pci=notph" makes sense as a way
> to completely disable the TPH feature in case a user trips over a
> hardware or driver defect.
> 
> But "pci=nostmode" is advertised as a way to quantify the benefit of
> Steering Tags, and that seems like it's of interest to developers but
> not users.
> 
> So my advice would be to keep "pci=notph" and drop "pci=nostmode".

OK, I will replace the "nostmode" patch with "notph" in V5.

> 
> Bjorn

