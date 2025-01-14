Return-Path: <linux-pci+bounces-19793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CFA11586
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB90188AB31
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595A2139DC;
	Tue, 14 Jan 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dU7rkwFV"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF12135AA;
	Tue, 14 Jan 2025 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897988; cv=fail; b=soGD0fsaN2lrROtMoKERyRMw4cYKnduxj3NR9Bxoy9+MXIE7VVwMD2KA09y3zr76XVc8dTRmVwywe3YFOIyIaKYtWNBGzYEdYNp6Bv06uBhfwIW0XzyXvOJbdf91XhFi9lNSclKZYwixe9ETJbwnG6dwBmKlt9d4iqsSwLb3pyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897988; c=relaxed/simple;
	bh=ienmtOr/C82jgr2xhCKTfrZS9U5uYrja2+zVBW6G/8s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ulHl3m1FQCQipNiikruAjF8F4ukUkI+Wl5q0r0Yv6hyvdvCxthTVvUlYu5NZV7o/m66457cJxVtv8gnPzYPPVJYHdB5r31BvoT/q6YHc0c3UwXSJCfqGL3zkNnTxJqRvQwDQBupMHe1Ymiu9fLrMNoQopZBUDz+oXoJga43jhPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dU7rkwFV; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaY/DmSKAdl7myKBAP+pVkNTauVziP/NkYtoo1wCjPXcYwwkhGsAQuTy97TW/62I/RuPSYocKZlm6C/P4oymlpWS8inA3DB7Kc80m8P3597aC19FuO9P2fg9ONp6Y+VcMJrxmSQYeM6XkMqwXIabw95NQLgZl0FnAauLgR56WBd/mFkFtxyU6KICWEVXNElSulNbSMIkwi8zwcVqsicSAOUKhUAQaaElFlfCM9VTJpUsl0kWVA9s60hqKQOAVWn68LOGBIyAg4DDPFWIk44gScPHMppK9qjzYnNL9Oajc851Ayt7J55Sr/mgYR53FjfjpMtfMYCDruxSZoTATCqIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah5sYYiQ1+lNryFfcAWl0tuEC7RDgiLCq5U0iEkAu1w=;
 b=raGXDapdp/VeyBgbL7RJfCZlnv53xnTzdCS9wfL/abJZGbzvM7Te2OgD8JB7W5IyAt/JU+VJlzMghnhymGBlQO32ZyXiJuqhyyTvZ/QTj0v0LgsTYR071D5AFXdHgQYj924i+aCzjCT/pcbFAleTfYz+Prr9EAT4ZRtF9E1375/vFh4dXAPyG6MTNqQPpfJB5X2VR5ECDQsskkJsDfhGvLXx01AMzvSmwhmIEc7OoH9NXOX7dBws4zx+5fc0sEDdso9SfrUVXNr4smPjntzBep/BxkvKFjbo9Rt6uQmDIpmnrmZjFJpNIgGHFpe4TA3QBut5+cj3TgfUhXFjf/q/ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah5sYYiQ1+lNryFfcAWl0tuEC7RDgiLCq5U0iEkAu1w=;
 b=dU7rkwFV2EK8XqvlzGrwHvNWSpAT9UDuLxD6m7iApUgvWYByusVf9haaSdEuZoOvkrcdpS8wHp18AAej/ImXM44dIeFc0tZBPMYdf1JmRUz1dNkoaU00T0U1wQ91it3/pauWTpiY7UOhS4XWOtMk3rl2C2UpMamP+CeIZcVJnLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 23:39:43 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 23:39:43 +0000
Message-ID: <94ea539f-763b-42ae-bf5c-6013edf2f188@amd.com>
Date: Tue, 14 Jan 2025 17:39:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/16] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-4-terry.bowman@amd.com>
 <6785a691b56f2_186d9b2942@iweiny-mobl.notmuch>
 <a2fc0134-5b6d-4778-aef2-4447c50eb430@amd.com>
 <6786f4531d23_195f0e2946a@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6786f4531d23_195f0e2946a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0005.namprd05.prod.outlook.com
 (2603:10b6:803:40::18) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: dacf553b-6895-4d07-d4e0-08dd34f4b8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFV1MXZ0NGZwVnlUdERvL0lXL09VSk13NkpZeTJXUHR0ZjhqWDZCTEdaYTAv?=
 =?utf-8?B?bE91SzMrU3hXV01TSlVJWk91RUlBTTRtL3JsRllmR0RUR1hDZWZTcVpmSE96?=
 =?utf-8?B?YitpYWtpN2Q2cTRpUU1abzFDYXk4anRxL0U0ZnlkdXFETmJPb1FRWS9qQnBy?=
 =?utf-8?B?elplQ1Q0V3NZaFFQYTFCTW5pZGltazRuUmFUZGRxcitGL2p4WGJPYzM0UzQ0?=
 =?utf-8?B?Z3E1aFVZMm1MTUFMd2JIR2VaalNSc0tadXczV0pOc1VjVjlFZjViQTNlUmxl?=
 =?utf-8?B?MHNBaGhPc3dwaXNiTzF0eEo1VXpVYTdWSUJrUTl3ZGZiZkloeXRaVUc1aENN?=
 =?utf-8?B?L210a3lvUFJhVXd1NGVaZmtGcXRoQVphTlNuLzgydFE2TW5HdkFPbjdnRFFR?=
 =?utf-8?B?ZHhFRjVRUG45M3B5NTI1U09nQjVmeVJoaUprTzM0SFY0WndKT0lXdnFHQVI3?=
 =?utf-8?B?bXJ3UU5KNDNUOTByK2xybTdoUjV2RFZ0NGR0bkVwMFdrNmhxTzJLSzdnWEhG?=
 =?utf-8?B?WnFZQ2w5SVhmTml1c1VwMkhDWE9tQWdoamZwYTVKRHU2eUluZ1Z5MTdFTENU?=
 =?utf-8?B?MmFpcVprS3FxdGtDY3Y4dlYwUEp5cU9jY29lODVqTTdSY0gxY2EzMk5BVFpK?=
 =?utf-8?B?emVNdkgxdVRIc1pPcGxTT0Q1U1ljanpPL29pTUN2ME5rMCt4QmFFaGVpZ0Vp?=
 =?utf-8?B?UzV0cllIQ0YxNnZBbU45Y2I2bHgrR2JGM2FPVWdoT0N3amVRc0cwM2FGTFhU?=
 =?utf-8?B?YWk2cEgxenlLbGl4ajNRUjNEVG9kN01vQnZFd2xxd0x4bnYrN3RGTldpWDBY?=
 =?utf-8?B?SmJiMUdObFhJT3dJVFZrQnBwTFZzNmU1UjlXa0dUdDQ4cGM5RmZZTkRzQUxV?=
 =?utf-8?B?eVk5TzBwcGIxTmhCWGowcXRLVHZRV0F3OFBkbGZhOUhNZ3F0OUZhTHpaelVH?=
 =?utf-8?B?cHh6SUdONlVWaDMrN0tCVDAvbnE0ZHkyUmRCR3Urc2xhVFVvQm9Yb3N6WWIv?=
 =?utf-8?B?Zld4TGpoUXdJVWs2eHBWYnV0R0ZjTDQxMGpRUWZWcGxETWNEQi83cVhXcXNS?=
 =?utf-8?B?MGxIT1FEYXdocFhmU0xwUmUrenhtdFVldUhlWVJsdlBDUFZRdnZCVnJ0dkJh?=
 =?utf-8?B?QjU5RENkUGZkcHVRNjZ5dXhVL05WamhGSDB0d2hkelJyZkI4MUVGNWtlMnFy?=
 =?utf-8?B?SHdTZ2JNd204THU5Y2RzL255YW9QeVQxamZTS29JVSswcGhhSG5EOWlGZGI1?=
 =?utf-8?B?WjlxaUp3NGlaLzlDTDVVQ3JVMjhYWW9OYW0zTVI2ZEIxbUUrek1pbVJiWGh2?=
 =?utf-8?B?OFZQajdTTmJDcnJ0RjFJbjhVVFQ1anZpUi9tK2k1ODlXRXRESnF4ZHd2eHZQ?=
 =?utf-8?B?dy9sTFhyY0xWVHk1MUUrY1BCM3N0QVVBbnpKUExiYzJJU1dkcWdnWFV1T1pn?=
 =?utf-8?B?YURITmxjYjZJaWE2dlFLVXZ2UmJqWjRhYzV0SXF4MWh2c2dlenJvaDNtRUtG?=
 =?utf-8?B?Wmx4M3Q1YWI0U2p4Y3NGS2tzZG9DcUVham1RMnZ6V2dVbUhxa3prR0VoaFpM?=
 =?utf-8?B?ZnNSWVdtRVNSN3F4UWllVW9UQWxFTU82Um5mMkFybXZZZVkwSnZ2aklTci9R?=
 =?utf-8?B?L0ZzNDU3UEFSMkJvUEEvYU1nMk03dUNlTmgxZkdQMjRFcnhUM0hsSlJLNmRO?=
 =?utf-8?B?QjkycmFVQWNxeU9pYkZGczlxWStJVUhYeGlhM0V6N0hMV1V2dUlkZEdZU0Y4?=
 =?utf-8?B?S2YvYXBIMmNEQzQ0cXl6MmlEYmZNWFJBcnhCOXl4V3l3TUo0V0xSZkcyVmxQ?=
 =?utf-8?B?TStxd0ZpUWtLLzBIZy9kKzlGaEVjcEJROUJraUp6VUZpMUViYUdUMU5ETHhx?=
 =?utf-8?B?bnlKdGRVRWFhakRjbnhKbGVnWTVhd3VpU1JPbmpBangyNXZmbnI0ejZud1Vy?=
 =?utf-8?Q?Ftrim42JFEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUROQnVRSkQyUXZ6WWxDRFhvTEg4TFAvSWpCYlR1RTNwYzZMNjM5NlI1VzEr?=
 =?utf-8?B?YUVvR3gxcm1MKy9mQVFERGRWb2FWSW1WQVRHclQ2VXZJMGNOSTRTaUNVZk54?=
 =?utf-8?B?eTkydTV0QllmcFM5ZVFBcWpOUmdTZE4wd01XbnBVWmh4RWVGcTd6SlVQaUpH?=
 =?utf-8?B?TWtZaWllMjJvTGQzRmlCQmZsSVVaWW9JWXY2TWRiblpDSnR1RzZ0MUVNZ0hl?=
 =?utf-8?B?b2lPekhXTDlQOGhCd09adFpiRklJcngvUWVQM2V0NThHd2E5V2szMzlKbkFx?=
 =?utf-8?B?VXZRb3ErcDJEamZKRFBxRWUwY1l1Q2w3YjNvQkk1S0Rkc2k4QkFVQythZ0xt?=
 =?utf-8?B?aHVrdHdLS0ErZnhMUWhRbzEyOE42d280d0M4RUY0Wk9Ib1J1M09hLzZRenFn?=
 =?utf-8?B?WE9MdFpCZ01WdVFtZktLODRtazlVTWRlUncxekdXM0hLN3QvYUVGT2NYTlh0?=
 =?utf-8?B?L3Y0UmJzVGczbmdzZ3VvTUxHQ0c3QWMvUEpCR0JwczZzS3FzNkZMTUVZSnlt?=
 =?utf-8?B?UnRmdFByQnMzcTNuTWwyKzZFY1FEUHl2bVgvZmJub0NMT3BzZmdqdms4L1Fj?=
 =?utf-8?B?TkZtU0ZUVmJhamRzM211K1VITGlidTBFWnNQdmF4YzlzOS8xcldPdUYvUlRE?=
 =?utf-8?B?dURhM1ZmUitkdFVhSzdlN2RLTHlaWWNmREg3VUFlVXVMNlNaeWFTNWdPbzIw?=
 =?utf-8?B?ZE1DK2hmdVZQbXlMcXc5Y0xWdkEzS3RYeDE5TExGdWhPdWtJTE9laWt4ZURH?=
 =?utf-8?B?YzBoRSs5anFLRnVqdnptZDdIUG9VdHJIekhRWS85V1p0dTE1WGVmNW1pNFgv?=
 =?utf-8?B?RXdzZFJ0TWpDVlNaK3BvVVpGcm1iak1MUHZPS1c4SDNrM1JiY2krR2pGcWpM?=
 =?utf-8?B?d2dVb2Q2TjhEVjZYN3ZhaEdjZ25TeU5oY29GRGdydXN2SXNwOE8wa1pSMW1i?=
 =?utf-8?B?WEdWS1p6VUc3MWpLZHAyMmYwUGRadHJid2V3MVpvMXdIc1l0OEd6Q1ZtYWNZ?=
 =?utf-8?B?aXlWbUYwZ096SENON0FtVFZ0UURlUXFBQk1IWSsxZWZCOFRGVFhoYjFNbFEw?=
 =?utf-8?B?cWJwNC9QMFhBVENCcm94TDZLTy9GQzdUdDg1dXhNVExvZ3hicXdJdnYyTHYr?=
 =?utf-8?B?V0VFdERycWFJL0dHMGR1dW5VdzlIdVRCL0E4S0k3ZnZDNVdQa05UVjRkYTdB?=
 =?utf-8?B?Q0t2VHFIS0kwOHYydXlnQW9veDU1YjNhMHg0dThuaUhCTkI5OEMyS0ZGTit2?=
 =?utf-8?B?ZnVwSi9kVzJQaURsRWVWZ05udGE0YUFOR3oyYXUxdWlBN0dTelUzbzV4K3By?=
 =?utf-8?B?TXh5eXRWWlB6QXYrOVoyZTdLZGttR0lOTWZISUpzVTNmL3FjelRqQU13MnBG?=
 =?utf-8?B?cXNiNlVaMzhyKzNQMkJBS29CZTd4L2pjdGZjNmtrZVp1Z0FmZEkvRGJka09W?=
 =?utf-8?B?RDZXeEdNM00xMW9UZzVXZENGeVA2UTBQK05YMzkyeVhVSTg1T3dFVHAwYzI3?=
 =?utf-8?B?bjQvbFpoZnluWTl6M2FtTW95SWZjbWhSYklYLzhmWU1obW83WHJTR2VjMlgw?=
 =?utf-8?B?Q3U5NHB6Ukw3U1JzMnVJT3lIdUNtT2lyWVNwbXI4UlRPS1BEclNra3ltRGVl?=
 =?utf-8?B?TGdzQ285aUZjVmxvNHZGSy9ZdkdlalA3eUVMTFpnb3NjeGJFR1lCVC9mcEpz?=
 =?utf-8?B?bWsyWitVZWRkOTRhR2M0T0FpMnlJRVBwNGRBQ0I5UCtYblBQY2puWkJhbzVh?=
 =?utf-8?B?dlJiTThqR29NUFRxYXF1ODZwdzhoZ0ZYMXBmdVFvNDVvaWhJNXpNTGwwQ05m?=
 =?utf-8?B?SGVSZ3FDV0FiRXVDSXFNWVNnQ3FTLzlqb3VFZUVnRFNTbks1NHB5cWVFUFZz?=
 =?utf-8?B?Q2pvbHBweTRUUDd0cm9oVUZGVTJDNk9hcTJ1c2pQTnVpdnRlcGRUdXhYekQr?=
 =?utf-8?B?aTVLbld4YmpkRUZldGM1MVZFbjBDajVZcGt1SzlncTl1UFdIa0d2NHVYa3FB?=
 =?utf-8?B?ZEs3aXUreENkNVRWaGxFQVcybjlGS2M0SlNMdGEybm5QRGlkSlBvV05zMVkr?=
 =?utf-8?B?K08zT2t5QkE3VURuT1drUy9yN2xJVUR6SS9RSGNaUFRrTGxKeFVUWjVjMW9l?=
 =?utf-8?Q?O58993DMTRZJw0oV4qK5H6E6v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dacf553b-6895-4d07-d4e0-08dd34f4b8b5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:39:43.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kd6wb21YjRgm1Fv6EgR/fuBtVbOF0Pwd6mnNvzVru/YCStzAxYfHpqLKWhWf9nEleEsud7hNh0U26sKKAAJfgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084




On 1/14/2025 5:33 PM, Ira Weiny wrote:
> Bowman, Terry wrote:
>>
>>
>> On 1/13/2025 5:49 PM, Ira Weiny wrote:
>>> Terry Bowman wrote:
>>>> CXL and AER drivers need the ability to identify CXL devices and CXL port
>>>> devices.
>>>>
>>>> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
>>>> presence. The CXL Flexbus DVSEC presence is used because it is required
>>>> for all the CXL PCIe devices.[1]
>>>>
>>>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>>>> Flexbus presence.
>>>>
>>>> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
>>>>
>>>> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
>>>> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
>>>> CXL Extensions DVSEC for Ports is present.[1]
>>>>
>>>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>>>     Capability (DVSEC) ID Assignment, Table 8-2
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>>> ---
>>>>  drivers/pci/pci.c             | 13 +++++++++++++
>>>>  drivers/pci/probe.c           | 10 ++++++++++
>>>>  include/linux/pci.h           |  4 ++++
>>>>  include/uapi/linux/pci_regs.h |  3 ++-
>>>>  4 files changed, 29 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 661f98c6c63a..9319c62e3488 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -5036,10 +5036,23 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>>>  
>>>>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>>>>  {
>>>> +	if (!pcie_is_cxl(dev))
>>>> +		return 0;
>>>> +
>>>>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>>>>  					 PCI_DVSEC_CXL_PORT);
>>>>  }
>>>>  
>>>> +bool pcie_is_cxl_port(struct pci_dev *dev)
>>>> +{
>>>> +	if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
>>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM) &&
>>>> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM))
>>>> +		return false;
>>>> +
>>>> +	return cxl_port_dvsec(dev);
>>> Returning bool from a function which returns u16 is odd and I don't think
>>> it should be coded this way.  I don't think it is wrong right now but this
>>> really ought to code the pcie_is_cxl() here and leave cxl_port_dvsec()
>>> alone.  Calling cxl_port_dvsec(), checking for if the dvsec exists, and
>>> returning bool.
>> Hi Ira,
>>
>> Thanks for reviewing. Is this what you are looking for here:
>>
>> +bool pcie_is_cxl_port(struct pci_dev *dev)
>> +{
>> +	return (cxl_port_dvsec(dev) > 0);
> With the type checks, yes that is more clear.
>
> Ira
>
> [snip]
Since sending the above I made update to be:

static u16 cxl_port_dvsec(struct pci_dev *dev)
{
        return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
                                         PCI_DVSEC_CXL_PORT);
}

inline bool pcie_is_cxl(struct pci_dev *pci_dev)
{
        return pci_dev->is_cxl;
}

bool pcie_is_cxl_port(struct pci_dev *pci_dev)
{
        if (!pcie_is_cxl(pci_dev))
                return false;

        return (cxl_port_dvsec(pci_dev) > 0);
}

I can change if you see anything is needed.

Regards,
Terry

