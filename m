Return-Path: <linux-pci+bounces-16002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA89BC002
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A031D1C204F6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B621D54C0;
	Mon,  4 Nov 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QMRPAvK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87019BBA;
	Mon,  4 Nov 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755586; cv=fail; b=G4mOIfdA5pxdBPsLruODt/q89AeVwIRaNFayz1u0Cy+AL9knEURzUFgsPwOgc9+GQwXSTkI5KnQfZbGZE9gzQ+FqVUl7D+UxBe06s5NlCIqX5ah9oI0vW2XxOEcCkVRM8rWAa1G+tYc8GU9nPTzYseaTnT/xkOa1kSEqRIqjsLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755586; c=relaxed/simple;
	bh=vG6P/pfERSooCyp8fuOi1+EAQhdqdPlpZeBcWGPdSEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t9A5QRRJEyx66TDbJe84Ji7SvuYFqqbDWqWFuB9GbSGRsMjPje6Id18Po/g12EqVmTqwYSx9Ymh5/zYkAz4tyNVNOFLwXNE8SxtB1q6NfkkuHk3ck0gWpfbng7Au/p9qQTU8dmEKcvn0rF6IAUe1KjMaa6k6EK4ibYwmU1D6fdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QMRPAvK0; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvjLBWqXjGVIcdQa5OtFiYY+QTWrGQ8MZl7y9QPLX4NTbMdFgFt4OgZ/XlUH8jGTS9mZ/v47GhjlhTAXn21sNBA/e1PkroGZZEHbK1BtcQ6w9I+NMDxR7GhmRUhQ/t6E4HpW95L8N/zPfsMlvq5UjWs2KI444l9VN1Qkok2wBh7CwWMz161t5AcDxK17G/LE2LAyFqHjiRQ/JWCX1+JFY5rsJSPJC/vcdsqSv0fAmAhoIvuJjUuqu4SHN+56oWmP/yDIJmldAcJaNR23TazO60+YeVbHTGCbv33OMbu/tCvJGYZlY5YAEkdsrO8dJUFmaepJVTLJ+3y0V80FvQIrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vZRezUiuRlAOetaKDKl6vi0Dwx1KiETwKd3PTTXvHs=;
 b=pQZNlL2q8dVe49o94DO6nQW07WSlomfzR3clCp6YW/PcJLYkyfbiLuZeOdg3ldmxoOoRktfzNiVsCbXsyBUbXLTksIUCA9oZW3sv9grfmQImJN2MJNDhy5AIO5kk9YdKNOv4/ZqSrLPLd863eRn46AnUEPwLA4gWxS+BWkRET3Vk/W7C5FRmDYZZ6NY6gFSTfyGD9/KAfDObLF235N12uTowzJO2EWZ7wXM1LWIoT+9mPQOuak9EqKw1nJI7mic7zv7hf1+6UulB4tUwfacBJzLHnE6utJWWVhFOmzjL8FYqeLCbL974YzVFOY+bNtt+NcBc/B1JkScOEAEgGlQLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vZRezUiuRlAOetaKDKl6vi0Dwx1KiETwKd3PTTXvHs=;
 b=QMRPAvK0qvGxxIyx/WbjQ7YwhkmwQFAOt4hQhMHlNOdi6UbRlmBtsGRkzV7oCCOL3Kt8MzMU02gigBSQVvLofD6v6Yk/JON7k2jz3GwjFmv6FxeeDHXJX+L0ip0c4UaRVZHE1w9g3lXAOkv77mSGCvVWnNwO7Ylfcr/WujQi0RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB6457.namprd12.prod.outlook.com (2603:10b6:208:3ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Mon, 4 Nov
 2024 21:26:17 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 21:26:17 +0000
Message-ID: <341e5c63-8f1c-4b53-a6f0-bdd7483f0c93@amd.com>
Date: Mon, 4 Nov 2024 15:25:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/14] Enable CXL PCIe port protocol error handling and
 logging
To: Fan Ni <nifan.cxl@gmail.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <ZyUXLpQBBgTl733z@fan> <8a73bfa1-b916-4f0a-92be-0cb677e1e334@amd.com>
 <ZyVSAzSW1HEd2_Mp@fan>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZyVSAzSW1HEd2_Mp@fan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 377156a5-10ab-497e-d703-08dcfd17513b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UCtPTmcwWUI5RjVxRklLR0FhcmRrNlNoL3NhQ2h5VFFpSlhWREoxTnJxSytr?=
 =?utf-8?B?TVdPY3IreWV1dlZJOFhiZllyOG13QmRQZ3VuNVFXOW1FSVoySiswTVJWS09i?=
 =?utf-8?B?WjJHTXg2TDlOWmFnOE8yd1VJWThlZ2RxRzNtTGdWU3l5NDdQRjJQYlFIVy9F?=
 =?utf-8?B?b3Q0UXBtWFUrRUdFazl0SFMwWGZuOHF0eTBubDdhTTNQdDg2Um5XL2xVbmFY?=
 =?utf-8?B?a25TN3pUelVKbXZtWnZ4Z0VrWjY2cVY5WDRMd3NwRzAwNWkxMFpaVXVSTkcx?=
 =?utf-8?B?Qnc4YjZCZXI0ekdDNzhRaC9sa3FUaXhTalcxVjBEcjA4UU8yczNMdWY5b2p4?=
 =?utf-8?B?UVdRenE4M200cGNodlBuQ1o4NGlYU3l4U3lzWHc4cXFydjRiRjI0T2tCeGhG?=
 =?utf-8?B?aVIzNmtNN2tCTlFGU3NIbUpNS21kbG82RDZQV2Zvb3pGd2VTYkx4MVYvN0Fm?=
 =?utf-8?B?U0ZKeFhyRDhhVEIzbjFCUmlIeXoxaGl6OVZPUTNVRXNySXZwVnhHcTdwUHVZ?=
 =?utf-8?B?bVBiSXY1dFkrUlFmWnNlZ2lMcWYzeWl1bjQ4M0hKcGNvbit2TDMzaU56bVlq?=
 =?utf-8?B?SmNTZU1DaEVIWFlXVzByVG0wOGNNbTJhTnM3dm9wa3A2bmtRVENLRlZSWHRL?=
 =?utf-8?B?TkltbXNNNjQvUzI5MDBtdkp1SkMxOTJkV2VvOFp1V1E5WndHNVdGRmtnemlW?=
 =?utf-8?B?RjJrUlllRmhkSHQrM3VDNDI0cWx2L2tUVFhXVzRlWlhEUlZPNlF5YVpFdm9E?=
 =?utf-8?B?a2VoOEllTDBvdG9JYWpGd1lUdFloUnlOa0l1dzJudzhoaldtZ0lwUWJ3RHBh?=
 =?utf-8?B?ZU56QVJnSGJxcWtxam00NHl1dWxLSXV1aVk4TDhiaEYwUy90TWdZNTF6SDE5?=
 =?utf-8?B?bWUvbGJLZ3kxbHA0WlQrS2xjenFJL0Y4WWZTMFFFSGt2ZWdpdG1LRHdqQWxv?=
 =?utf-8?B?eG9uUjllSFY2OGlOTVAvaGpuU3ZycWdKZlpjazdaakx6NkRIYnE0RHVDbGpE?=
 =?utf-8?B?MGVxaStoNGNnQTFTdnUwY2RUalE3bGhVSDUwSjlIY0xsTHBKMGlRN09WcDZp?=
 =?utf-8?B?WGgrU3J5MC8yS0RTa1hQb2ptQW5xR0lPZnU2TVFTdUZJdjdCdENkV2p4V0lJ?=
 =?utf-8?B?eFYwb0ZZbFYvWDFnNFFlbHlwMlZ2V0Fqbit4Vm0vUkxNcnI4UUFaTmZyTjBR?=
 =?utf-8?B?ZEVNZy94QTVENzZSa0JqUm1XRmdJZXAvWVlXRXUzN1dXNkxxaEdVdUJya21a?=
 =?utf-8?B?YmJBZGJkR0ZFZ2EzcDV1cHZkNGdzRERyM1Q1MnpobVJYbU9GdHRSNTRub2V0?=
 =?utf-8?B?Q2NtTEhVMVVMN0p6U2VGWkRWaFFPVFA3bVBRL0kveVRvR2JpajhsWjB0OUdD?=
 =?utf-8?B?TGFQaXRNZzl6SGkvUWxtMitPKzFPL0lRMXJQVjVFTnBnVG55RVlMUXVSMjZT?=
 =?utf-8?B?STVJQkRBL2d3ak5UcjZtSDVhNlRpbEwzWW1zaThud29oVjAvQ0VnYTFkZXpl?=
 =?utf-8?B?cFpQQlhBRDd3cnNhL1Q1N2hlRVgyMmNhZWsxeDZtK05RdXZvTzRwSzhubXFl?=
 =?utf-8?B?M0c4dFFLU1dEQWowc2RBZmEreTlKMWFvSC9BK3Y1WFJWL1BURG1pSmRuM3Y0?=
 =?utf-8?B?allMdWJCckZhcHhKa0F2T0tsZXVZSlU3dXdyZ2M0b1hIMDI3WHk2NG5kTWZT?=
 =?utf-8?B?TExEUkhTWVR0YjhmZmc5aXljaUdIMHZETVIvSTVid2JNRlRRSnBNTktXMng0?=
 =?utf-8?Q?dldWGNXxZiGWL8R4X2/285FZ85CGwj/Sh3gWxNk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU00WlFqZ25DWU4zc29uY1lyTnhFcXdZc3Q0YzFmRDZkeEROOG9qVnRFUFk1?=
 =?utf-8?B?bVVMS1ZOS1h1YjRMRkVZS3RYYmdUVlFybm5yMHZCd2M1cWtEcmR5WVh0eldM?=
 =?utf-8?B?UFl0Wnk0bDRoL0Z4WWN5U0xaOHRYNVN6R3lKUldoNTVvZUpSandFZDBvSC9x?=
 =?utf-8?B?Nlo2VnFQS3dSdmNsY3pUTEs4cisvYi9lMzh6eUdRUWhuc1lQclZUbEo5RjY4?=
 =?utf-8?B?QjNiSG1qanNYcmtCck5GQVpsNXNtRUs3Z0JLdDNZSTZiUFgwZHVEVGFIUmFO?=
 =?utf-8?B?SjEvb09jZm02VFBsenFTRGhKRXlDRlUzM3FFdFBMU3VXc3Y1OVp4QmtIdVNs?=
 =?utf-8?B?NGFyWngwVENMQTZhQlFCRWtIWXExcU01SG1MZUY0T3hFNHZ1VHBpMHN2dkxo?=
 =?utf-8?B?Kzd0YkUrZU9XQlZPOE1tNXVWVGlPdGZsK0U3UFRoQjYydzI1K3pUOThtbkhh?=
 =?utf-8?B?d2ZGa1dmc0Vvb2dRSFpnMjV3ZFpUNWNGUVlPVWUrcFRQa0ltekZpam85cEpC?=
 =?utf-8?B?TUJJTzRqRTdtRDdwQkcwM2p1K2htRGQ2alBiSmdyZHhPWWsyWHp6WEhuTnJB?=
 =?utf-8?B?and4UE9sVjZwVks3dU03T012QUJ5Z0UxdWZnSVhpdUk5eGtsRHJlY3JXUFlm?=
 =?utf-8?B?ZitXYVc3ZWJXNGg5L1V3bVg5NTd5b3dpbjJWdzlYMHllc3VMYjNTR2RpSVc1?=
 =?utf-8?B?MkIyTGttZmxBVzVTdUo2enArNmtmTUtCemZkVkhKTDFKeThZRi9EaFo2My90?=
 =?utf-8?B?MlM2V0xMeVpCY1ViZnV5ZGxaaDdXWG51NTBkT2hrV0hDbEdQZ0tpd2FjbUZy?=
 =?utf-8?B?dm5hTWxMeWtOblNvbWorWWY0bVJ5cjNsUm4wNTZCUk5RVTJhZU1NZUcxQU44?=
 =?utf-8?B?UEU3cUx0N0Q4MjlEajZIbDBmUXhpMTRwV0lOSXZ2YWJ6QjJocjQzVytacEFF?=
 =?utf-8?B?ek9MUm8xRHY4VE1PUVFjeWFiZHFoTGNzRW51cXRuVlpTL2RIdkRtbmJOS0xN?=
 =?utf-8?B?TkZ0d3BGRDBkQk15OWpEU09sTmZiMHYwVDRlOGNYcHBPYWNTTEN2T2pNejZP?=
 =?utf-8?B?U3htQ1hIRFhRdEdDTVNzajYxK3Q4S09KV1JoUHFSaUpMTnRNWFp4OVlCMis5?=
 =?utf-8?B?T2tJbGppbmJyWjB2NEp5cmFETEdNczQzc0NzNlVrRG5xSzkrZ2tybEkvQnNQ?=
 =?utf-8?B?aS95ZTJ0R284NUhmWWZyWnd6K0FPQklPR1c5cXZvdFBTSXNhSTdFOWdhS0xN?=
 =?utf-8?B?Qmp2cEVsNnZrMkpTek9QVG9WNTRQdkRFYitCNVU4K1NWU0Qrd3pERlBWSnZX?=
 =?utf-8?B?bldEbHJMUHlySDk0U3J2YzI4SmJ6S1JMd0lEZHdwcXQwNFE1USt6bmNuOXBK?=
 =?utf-8?B?V09paCs5ZFRKZmtTWG5McWxSRkoweXR5TnVIM3hyYm0rZHNpSmhWMTlJMmcr?=
 =?utf-8?B?TkdqVlVnQ2JQMjR6MVpNeTVKdHZVNUZIVWgrMkxkSFJoenlrREt0WmtsdlhY?=
 =?utf-8?B?ak5uMFlMeFJzRGd6cW9xZGU1RWhvS042RXpwV3JyOFpoMExNZCtoT3R6eGRR?=
 =?utf-8?B?OUpXSFNkTG9UYUloQ0dITGJHUE9HZmllRmcycXFxM1JUVmJMV05vZGMzcndo?=
 =?utf-8?B?WlE2YXRCcVA3MThuYnhuaFZoTEptUTZlbFFqQ3I3TzhYZXNlZmp4R1M3NS9v?=
 =?utf-8?B?RkRKeVF2azU2TjgrRGEwWXJLLzFUYUtRYjQ5QUlhK2Raa1BkT1VyZFJ6UzI3?=
 =?utf-8?B?cnlIN3gzdEJFMDRyazFnNExHdjBKdGVieXJRT3BOcUUzQUQzeUx2bWxqdGRu?=
 =?utf-8?B?K1dNUTV5a3U0UWljT1VPdFdEUjZNZm84cmhpYldmY2Y1L1BPbkYxcDk5L2tF?=
 =?utf-8?B?R2k4c1RrSlFoazZLbHJHUDZSWENPNVIxa0IrYjNQMGlRY2ZMaEExZFZGMzRC?=
 =?utf-8?B?SXpoZjNxWXhuRitmSkVEeHdYVmVqSzlWdzB2a2JIWDZiSTdsUmtLb3VXbUFw?=
 =?utf-8?B?UWZyTk1uNnJNcGxqSU94Q080SVBEY3R4VDMwT1JQMTgvNWQ5cEVIbU5mZVRz?=
 =?utf-8?B?MWQxRmxyMDRPWWdib2x0VDl1dHo1SklJRUtrMVlhd3lua0QzR21NRTJGWExM?=
 =?utf-8?Q?fVEgbNswsh/FqtZmLUb4Ijbsn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377156a5-10ab-497e-d703-08dcfd17513b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 21:26:17.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmoV//78yAHmQa4G6DauHFAFhjIfsIZodVrAbJonlaJlhPmbWmLZ5s2jTfAFhM23ySCHL5eox5Bpn+kMT7NZwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6457



On 11/1/2024 5:11 PM, Fan Ni wrote:
> On Fri, Nov 01, 2024 at 01:28:12PM -0500, Bowman, Terry wrote:
>> Hi Fan,
>>
>> I added comments below.
>>
>> On 11/1/2024 1:00 PM, Fan Ni wrote:
>>> On Fri, Oct 25, 2024 at 04:02:51PM -0500, Terry Bowman wrote:
>>>> This is a continuation of the CXL port error handling RFC from earlier.[1]
>>>> The RFC resulted in the decision to add CXL PCIe port error handling to
>>>> the existing RCH downstream port handling in the AER service driver. This
>>>> patchset adds the CXL PCIe port protocol error handling and logging.
>>>>
>>>> The first 7 patches update the existing AER service driver to support CXL
>>>> PCIe port protocol error handling and reporting. This includes AER service
>>>> driver changes for adding correctable and uncorrectable error support, CXL
>>>> specific recovery handling, and addition of CXL driver callback handlers.
>>>>
>>>> The following 7 patches address CXL driver support for CXL PCIe port
>>>> protocol errors. This includes the following changes to the CXL drivers:
>>>> mapping CXL port and downstream port RAS registers, interface updates for
>>>> common restricted CXL host mode (RCH) and virtual hierarchy mode (VH),
>>>> adding port specific error handlers, and protocol error logging.
>>>>
>>>> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/
>>>>
>>>> Testing:
>>> Hi Terry,
>>> I tried to test the patchset with aer_inject tool (with the patch you shared
>>> in the last version), and hit some issues.
>>> Could you help check and give some insights? Thanks.
>>>
>>> Below are some test setup info and results.
>>>
>>> I tested two topology,
>>>   a. one memdev directly attaced to a HB with only one RP;
>>>   b. a topology with cxl switch:
>>>          HB
>>>         /  \
>>>       RP0   RP1
>>>        |
>>>      switch
>>>        |
>>>  ----------------
>>>  |    |    |    |
>>> mem0 mem1 mem2 mem3
>>>
>>> For both topologies, I cannot reproduce the system panic shown in your cover
>>> letter.  
>>>
>>> btw, I tried both compile cxl as modules and in the kernel.
>>>
>>> Below, I will use the direct-attached topology (a) as an example to show what I
>>> tried, hope can get some clarity about the test and what I missed or did wrong.
>>>
>>> -------------------------------------
>>> pci device info on the test VM 
>>> root@fan:~# lspci
>>> 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
>>> 00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
>>> 00:02.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
>>> 00:03.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
>>> 00:04.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
>>> 00:05.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
>>> 00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface Controller (rev 02)
>>> 00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode] (rev 02)
>>> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
>>> 0c:00.0 PCI bridge: Intel Corporation Device 7075
>>> 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
>>> root@fan:~# 
>>> -------------------------------------
>>>
>>> The aer injection input file looks like below,
>>>
>>> -------------------------------------
>>> fan:~/cxl/cxl-test-tool$ cat /tmp/internal 
>>> AER
>>> PCI_ID 0000:0c:00.0
>>> UNCOR_STATUS INTERNAL
>>> HEADER_LOG 0 1 2 3
>>> ------------------------------------
>>>
>>> dmesg after aer injection 
>>>
>>> ssh root@localhost -p 2024 "dmesg"
>>> [  613.195352] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>>> [  613.195830] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>>> [  613.196253] pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>>> [  613.198199] pcieport 0000:0c:00.0: AER: No uncorrectable error found. Continuing.
>>> -----------------------------------
>> This is likely because the device's CXL RAS status is not set and as a result returns false and bypasses the panic.
>> Unfortunately, the aer-inject only sets the AER status and triggers the interrupt. The CXL RAS is not set.
>>
>> I attached 2 'test' patches. The first patch sets the device's RAS status to simulate the error reporting.
>> This will have to be adjusted as the patch looks for a specific device's bus and this will likely be a different
>> bus then the device's you test in your setup.
>>
>> The 2nd patch enables UIE/CIE. I moved this out of the v2 patchset. I need to revisit this to see if it is
>> needed in the patchset itself (not just a test patch).
>>
>> Regards,
>> Terry
>>
> Hi Terry, 
>
> I checked the two patches you attached, do we really need the first
> patch to umask internal error? I see it is already unmasked in
> aer_enable_internal_errors() which is called in aer_probe().
> I tried to only apply the other patch and test again, it seems the test
> output is the same as applying two patches. The system panics as well.
>
> Fan
Hi Fan,

Which device did you inject into? RP, DSP, or USP?

Yes, the RP UIE & CIE are enabled by the AER driver. RCEC too. But, this is not done for CXL DSP
and USP. Below are details from the spec describing how an AER error masked at the source will not
be propagated as notification to the root complex (RP or RCEC).

'If an individual error is masked when it is detected, its error status bit is still affected,
but no error reporting Message is sent to the Root Complex, and the error is not recorded in the
Header Log, TLP Prefix Log, or First Error Pointer.'[1]

[1] PCIe Spec 6.2.3.2.2 Masking Individual Errors

Also, there can be platform BIOS settings that enable/disable UIE/CIE.

Regards,
Terry


