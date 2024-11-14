Return-Path: <linux-pci+bounces-16790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C759C90D4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F40AB4604A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B3C6F307;
	Thu, 14 Nov 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N0dQEqr6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530D433D2;
	Thu, 14 Nov 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604062; cv=fail; b=BrfCJWEYwy6Ei5GyKAcK7X4Rc4BnxTh6CMvquZBXe/587Lzopv0jUkC3KcEwD8XYePl73t90b6T+le206v8ivtQHuBDMrJhySuQG3wf+DuxQmAOaIoe6NlOrj9Idp0R2GdJJwpEUHXLeYaZoy5HSGrsGmc7x894UPBdx3q3ClbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604062; c=relaxed/simple;
	bh=EAT5zWJ0LeoH//qDVwNrcHZ9T36ARFvE6S+WIJqut8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jQ5V6zjSzKVVwOR6yoxmWR2EntpeXP218xVVYE4P6/N0wHXMzFIyG2L8NnWfT5rky0nG1pqdsBUYzpy1tGhh+Ckywy6zawWSX4NXtSimYgc8l6nIR9Bq0jI4VQv0ccoVUBQlExbuGY09fiZQ4o4VW+KltyybhNISmu7X8uqIK6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N0dQEqr6; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v46XPP4qjnjQzCzIgALo/WS3dTju8P2eYKWX7WfM2UGARFRvFsyFYbcEtjMMBZDk+GYf5Q05Dy/FQwdznyw5vwraAFz8IWBrqh3Aq2jMtzyiI1l6KZJCrOOVUQuAQtPDqOHTayv50st64FPvomgqUL4mSWn8+K9vTd5jI9jD9AE2/qQdGUyfzhssAa0cCGh015bvcN4KaSg5mYuSM7f3+aD2z2EjvNvV3hP2PncbZ4Xh6GOdxQ5G29S/iNJceBU7N6+Bm3AvRSUYD+p7lXj4G1rC36pk/Gn//HZlYZpZhdBevKJqBOdC4hYXBcoMj8QWjARce6Zn6AwK5+MMwh+juQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4SA+B0tUVYgm1svSDmHU1CfE+4TmrOJVU2b+b8BO0w=;
 b=vist6HZh2ZH3vKfV0h6tLHCLJNBY1vdHvVrTAKR3ZwV5BROVLLKApozd2gO9ExDyw8HKPVs1rbcsFv4d20I7Z+JT7SrS6rlMl03lTjquZB7XPUoNqrJG9wiFb3DfORN8tiRl5G7TujzdZIF6WTMKOFPI3Gc8kdmnzbSf4xsmHd3eo80wqVIkoy/Ek6Jvxs3/6XBbBN+LRCUS2iXNU+8GvBwRz47nkDWoRPwpqVR0l0vHOEMjRe8AhKtlHk9KypLEi8c8Wjp6kl/J+H6gDsHK1FC/oZB6brCRjMLPu4BtCBvJYS/6wZwBHGT+c6gRXeaeTtH6STnbtqMby2W5DDlHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4SA+B0tUVYgm1svSDmHU1CfE+4TmrOJVU2b+b8BO0w=;
 b=N0dQEqr6/wC4QQ1gND1o7VD78HqMTnlrbXThbQWO8eS2LreyEuIUbcpRatUhnaabyVWjSzMvPaSTVI6hG9Kaq2g7VdK/lOzX4S5qe0na5xvcPB2ltjl29tucnZ4W99wLbkF/2we5ogd6rRbITox0JaHSpfTK+Pjjx3/P7tREaEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Thu, 14 Nov
 2024 17:07:30 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 17:07:30 +0000
Message-ID: <e686016d-2670-4431-ad9d-3c189a48b1e4@amd.com>
Date: Thu, 14 Nov 2024 11:07:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] cxl/pci: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-4-terry.bowman@amd.com> <ZzYbHZvU_RFXZuk0@wunner.de>
 <ffd740e5-235a-4b74-8bf9-91331b619a7f@amd.com> <ZzYq2GIUoD2kkUyK@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZzYq2GIUoD2kkUyK@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:806:120::6) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac820c5-9a38-4cac-2ad4-08dd04ced27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlU0eGV1U1gza3N5K1hpTjBQV1RhMTdTY1pZUU1PVDdwb3hZQzkzbVZTU3V3?=
 =?utf-8?B?UWhTV2JZa0lpdW8reHVoQXBiS1BudVByMUlnbnd5QkxYUWxsTVd5WDVQSmhZ?=
 =?utf-8?B?ZU1pbm5ta0Q5cGN4VFAvSXJ3dTZhY2pUejFrUkMrU1g1bnM0b3FCMzJsMnk2?=
 =?utf-8?B?RmtiTUZvZWNTb0YveVVkOVpJQjU4SVR5VktqQzBVNXJqNU0wR1V3eWk5cHpM?=
 =?utf-8?B?U29mZk5pUzZYR2ZsR0ZsbEduMms4UXNocGROMHZqRDYvTkxHdjFhbU5Qd3Yx?=
 =?utf-8?B?Rml5eVFQOU9wZFVFNGpEbnZNejlDc1FESElWTGNZcVlKM0VESGtrVWd2dnRN?=
 =?utf-8?B?am9BaEpweStmMmM0a1M3VFpWd3ZzM1RsalRtdGI5SHFGNU5xK2JtK3RwQU5P?=
 =?utf-8?B?djBKV0JrVjhKWSt1OUQvamdob3JJVGs3ZEhEN0cvZ21sbWNYbXJMNEdkcUhE?=
 =?utf-8?B?bXRka2ZrK2QrNFBOdUE0dkJNMm9Ra1ZMeXVqWWQrQnZuWjNRbldMYlR3TVNr?=
 =?utf-8?B?MUtlaFdpN1F5bmlqb3hZMlVjeVNHZ211Vmo0Zzh3ZUZObmJqbmFreFlmQmV5?=
 =?utf-8?B?Y1NmUGFzZHNFbnFRK2FzQzQ4dXl0ejhHKzdNMjNJUFRQanVTRXltNXJNZjR1?=
 =?utf-8?B?RWpUWHNxcnZCRjRvOVB6NlRNMHdBeFJJSkFoQ0RlR0dDM3M5ZEdhVnNUcmhX?=
 =?utf-8?B?c21PR2Zsc3Y1TnR5SDRoUW9vZnFucTFodUtLUU1JZUhLSmhXdXJweExCNk4x?=
 =?utf-8?B?WXVUcldCcTVpQzVuanoxdk9IV0h4V25iSWx0dDlkWWlORG4rc0lZQjFvNnRn?=
 =?utf-8?B?cVhJSkswQi9PM3lSQ0NLdEhxcTNKZmZkZkNmSjFjUFpIaG8zeC9aaWovRFJw?=
 =?utf-8?B?c3NNWkZ6OFBDaTdKS0VzWVorYTVlWERENkczaUU1RC8ra1doeWdScStRRkVR?=
 =?utf-8?B?QzF3YUJOVTFFQmxTQ3Q3SzA5Z20yRGMvczExUTkrTWNINzEwdzYrb05JeXRs?=
 =?utf-8?B?V2RCTElrMVJFc0hoOHVDSHBCOFF1eUpmdHlDMXl1QnJ5Y2oxNWNYVXRGRVlH?=
 =?utf-8?B?T0xOaGdoaGlXZjZBbENMMmkzRG9TVmhXcnF2WlNySjBqV0F3WWM4QmRJNDhn?=
 =?utf-8?B?azlYT2F2MWl4VTBaWWNXZ2ZqSGlXOFBqeElEYlIwWkszY3FWL3ozLzlRUGlN?=
 =?utf-8?B?azJPRDh1Z3VhU2pMc0tmWHJTQ3QzZHBzZXdUaGJiWHZYZmJmV3VoL09MeDg2?=
 =?utf-8?B?VFhTaHpBSEpUUWpSb241YWpDSlFldWpqRXNtRnVVdG1uT1E4K21tN2RseEc2?=
 =?utf-8?B?N3JWWERzUkV1cnpQWWN2NldUSzVPb0RLQm1sYnNPcWVkM2JxakdleWd0ZCtu?=
 =?utf-8?B?WUUzYXpWWXdRSmhQSlhkcEpxeWJSb3ltMGFYNW5FOGprYjFFV3hXYTROY0d4?=
 =?utf-8?B?aTFmTWV5bWpRYjZXVVhYM3I0ZEZKd0J5b3lYRUlyb0pMbTNwSUxhWVpFNElE?=
 =?utf-8?B?bUovQ3VhT0ZGVDJHZE9sQjdRVDBUbmNhWjVMNnRhU1laK2oxNEIvdkt6d0xL?=
 =?utf-8?B?NytBYTZMYXVkekFYZi82QXpuM0cxY2hIeWgrQm1mazkrZVkxZmtiOGhyN0Q0?=
 =?utf-8?B?NUJZUmVlWWVwY2xRWTBDMGQ1QTY4NzJZMW9UNW4wRlNyeXVFeHhPdlhyWU9F?=
 =?utf-8?B?QUl4aU1HWlNGQk1oWThvQkVhWG9UOHBDTFY2R3c1VnlOc1RFZ2N3RWlpTzk0?=
 =?utf-8?Q?5+KQa3BqUnUWHhU4PTxcfqPQ+G7czmi0OmIHRye?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmloc1F0Mi9mWXAvK2RvQWVmSUsrYXhEVVU5TFcyTlFlWjR2ekFDMjQ0Uks5?=
 =?utf-8?B?ODJ1Z2QzNDQyTTdaT3FzM1hhMm1objArN0pid0w4RXhUTHBlMW5XYWQrUDA0?=
 =?utf-8?B?TnB0MDI0QVFsbzU5YXhCYXE1VkFVaVN1NXdSaXVxOXF4WTA2ZmY5Tis2WGk4?=
 =?utf-8?B?TFJiUy9KZVRlUHFGRlM1d0NWa2YvZXRHUHVMaDJoZWpXTnZlUFROVXhIWnJX?=
 =?utf-8?B?MVVFSnZhRTg0bFZmUk5nNzVGeVBIVjJ1Q2VEL3draG04RTVpN0FsVjBZLzNs?=
 =?utf-8?B?N2VleUpFTTdVRmFMY2crRHQ3M0I1bHFKbDFLMW5FNXJuK2NXQU5ZWW4vSnI1?=
 =?utf-8?B?QlJqUjFzYUU5R1dYL2JJRFFKbGxUbUpGSDB6SHJ3VnQxdGsvdWFpU21oUnNI?=
 =?utf-8?B?YkhqQ2dZdTNwaC8zNVhLR0QrS2M2ZitNU1JuRmFab0Y1QzVnTk1ub2I3ai9B?=
 =?utf-8?B?QVNxbHlvT2VCWDgveXJiZFBQQm1ZWnpvSmgyOGlnMnZNZmN0djNzYVZxSGFP?=
 =?utf-8?B?RlF1OStOWDRraE5reVZaMlVNSkhvOWpxeXgxT2cwanBYY1VUVmdDUCtYL2Fk?=
 =?utf-8?B?QWxreUJYdXo1Q0l5TWxNZE5CMzFValZENTlJTDFOZlcvbXRjWXFEOG4wSFlU?=
 =?utf-8?B?eXAxSUo1STUzR1Q3UlVyZ3RVU2FILzZneC9UMG9PeVE2YmtuVXZoZ2FsVTJH?=
 =?utf-8?B?bEl1NG1qMVVqR1VSRXU4K2ZIYkhPa2FFQURnV292dlk4R0FFODFSelZBRnNi?=
 =?utf-8?B?VTlZS3pqeDAwa1B1OXA4dWlJYWpscFlmcHVWaldVZ002YmZiM01DK29FelFP?=
 =?utf-8?B?Y29NUXI4dFZQeEYycWtTQytwOGpsUUtiV0szaTNuTUE4eHBHNXVJMVU1U3Yw?=
 =?utf-8?B?SGtaUVlJc2toY1Mwek1uYnNzZm5kdWt4NHNWaHZmNHdMUjZSVVBHRmhIUk1G?=
 =?utf-8?B?TFFGUlNpNzI2eTRtL1dJb1kxOXhxZS8vVjF6M2NiTDFzcm5CVE5iUFRkZkQx?=
 =?utf-8?B?L2VXNVppSG9DTmhKTEpicjRIdTlZb2JORmszdlcyYXl5Ym1vQUQvZEViWGxh?=
 =?utf-8?B?bkZBWHlHeUZRYk9iYUZkSmVtb1ZOaU8rWXcvbWprYjFrNU9maXF5cS9URGVm?=
 =?utf-8?B?dzdxaE1BTXFJSlpsbkhrRDhBRzQrSTJKNG1EUGFNSW4xRzdNbGcyWUF0a3NQ?=
 =?utf-8?B?LzNrMm9WZFZUS3ZzRzM5dnJETGNmSjg5aktGeUV0eWZIVTJuUjdYd2VxTW9X?=
 =?utf-8?B?VWhQZXQ0cmR5amRuS0gvVXVTdXhBaXcwektxRmZMMmQ2NTltZHIwZnBqY24y?=
 =?utf-8?B?endlbzY4UnRBeHFkcVVYaVlDY09BMk1IS29JTU1jWWVKN2tlT2FnZXpDMDVs?=
 =?utf-8?B?a0h6MVc2WER6UlBVR1UzeXIyTGJlOG4rTitZQSs5Mnp3ajBVeUxOMVRMcGVL?=
 =?utf-8?B?ejdIckViSldRRm43WmFUZjZsNTRyZ0E4cDdzT2lUV0pjUlVkVklGVGd2cGVj?=
 =?utf-8?B?RGNBQUc2WjQxWFF3NVRPTm91c2N6Q0hDdGcrdkFWVFYra0c4SVJ3ZzVKNksy?=
 =?utf-8?B?K0l6Z2VLNUtWWVdkdDBNUmRzRDFHWVE0N0RBOVFIMHFGZHNTYk9ndDFYUGlV?=
 =?utf-8?B?Zng2NlNMSnliTTdQUzgyYTFoUUFjeEFFdnBaUjcrNEZjQ0pHbkY2OVNRV2kv?=
 =?utf-8?B?WFJpNEpTK1NSKzVWMnBIZXFGeUxIRnJxMldmQnF4SmQvNXN0a3lWdHg0THZo?=
 =?utf-8?B?VXZ1ek9Sd0RNd0FzditRV0NOdklYVDRtS0c4eG5qT2l3eGgwellPWUFSZ3pI?=
 =?utf-8?B?cC8yWHp2Y2FJeWtUa1FTeHRHNmg1R3FEUHlUaW9MbFBYSnRnU0ZkWmVnTjJk?=
 =?utf-8?B?QTd5cmpJWFMvS3VPekRRa0ZHdkp1Z1l3V0VLb1BkVEhkYTZSRFlia1JnMTla?=
 =?utf-8?B?TnFHNnNDdVh1anZ2aEdtUStnajhTY1pvZHA3UjJxbkozZ2dvcURvSWFhWUsx?=
 =?utf-8?B?M1EzQ3ZYU0lOS3A4Y3FKZEFDWExIQ0JFNjhlQTdQSnJCL080NVF3Q3pTYlRk?=
 =?utf-8?B?aHIvMU5oMnJKakxQV2ZYQUEvNk9HVWg5cmliWERIaHUwZm1TU1Erdkt2Ukdu?=
 =?utf-8?Q?reeebci90mP7evl7weryf/8lI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac820c5-9a38-4cac-2ad4-08dd04ced27a
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 17:07:29.9694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIJ5Kq2DHx0Uhp4GelH+PEZ47x3+0JO+gBc5kbuHH5irh69N4aP/d9J0URH4by2Tmdf8c4qtQRA8jsvJhNFP3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374



On 11/14/2024 10:52 AM, Lukas Wunner wrote:
> On Thu, Nov 14, 2024 at 10:45:39AM -0600, Bowman, Terry wrote:
>> On 11/14/2024 9:45 AM, Lukas Wunner wrote:
>>> On Wed, Nov 13, 2024 at 03:54:17PM -0600, Terry Bowman wrote:
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -5038,6 +5038,20 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>>>>  					 PCI_DVSEC_CXL_PORT);
>>>>  }
>>>>  
>>>> +bool pcie_is_cxl_port(struct pci_dev *dev)
>>>> +{
>>>> +	if (!pcie_is_cxl(dev))
>>>> +		return false;
>>>> +
>>>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
>>>> +		return false;
>>>> +
>>>> +	return cxl_port_dvsec(dev);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pcie_is_cxl_port);
>>> The "!pcie_is_cxl(dev)" check at the top of the function is identical
>>> to the return value "cxl_port_dvsec(dev)".  This looks redundant.
>>> However one cannot call pci_pcie_type() without first checking
>>> pci_is_pcie().  So I'm wondering if the "!pcie_is_cxl(dev)" check
>>> is actually erroneous and supposed to be "!pci_is_pcie(dev)"?
>>> That would make more sense to me.
>> I see pcie_is_cxl(dev) is different than cxl_port_dvsec(dev).
>> They check different DVSECs.
> Ah, sorry, I missed that.
>
>> CXL flexbus DVSEC presence is cached in pci_dev::is_cxl and returned by
>> pcie_is_cxl(). This is used for indicating CXL device.
>>
>> cxl_port_dvsec(dev) returns boolean based on presence of CXL port DVSEC to 
>> indicate a CXL port device.
>>
>> I don't believe they are redundant if you consider you can have a CXL
>> device that 
>> is not a CXL port device.
> Can you have a CXL port that is not a CXL device?
>
> If not, it would seem to me that checking for Flexbus DVSEC presence
> *is* redundant.  Or do you anticipate broken devices which lack the
> Flexbus DVSEC and that you explicitly want to exclude?
>
> Thanks,
>
> Lukas
No, the CXL port device is always a CXL device per spec.

This was added to short-circuit the function by returning immediately if the device
is _not_ a CXL device. Otherwise for PCIe Port devices, the CXL Port DVSEC will be searched.
I was trying to avoid the unnecessary CXL port DVSEC search unless the other criteria
are met. And I expect most cases will not be a CXL device.

I will remove the "if (!pcie_is_cxl(dev))" block as you suggested.

Regards,
Terry



