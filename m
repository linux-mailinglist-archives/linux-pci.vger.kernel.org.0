Return-Path: <linux-pci+bounces-12394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D68B9634AC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 00:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EB61C219FB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FBF1A76B9;
	Wed, 28 Aug 2024 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PvvItzV5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3D167D97;
	Wed, 28 Aug 2024 22:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884000; cv=fail; b=bYubV2G4XOPbNeWMDFx4dPC502Vdy6r4Qx2rOKxH5BQCmaH1k2MsqmdNxbQAABa8Vlg+zKLNgPDx6zzfaXgo6PyBQRLX7ORvvw07cOYoOA/NqQARByCC3DLfhaZE4dYSLgZ3JQvDXX6mOVGdGylf8kk3wXCzkVTxasiYbGVDYfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884000; c=relaxed/simple;
	bh=59F6GUAxS9NTFA8IJfY4ZD7/dqro8ToYttgCcw7k6/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dvYG2IIgNQ/ShD9kKNdw2agXWGSQNbgYKJTRHFXWsfFqnM3MpnYFa/UhEj64QJubXNs8/CrUQytvHliivyKZr23gXPCnHz7pZ5TX69q2mRRCpAiXgrTEIqYiQwNdMpf1BnkvjcAMOtQ3M7JSx1gssIvDZq0rBLVUclWrTXbap4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PvvItzV5; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2tvDcpFX3isoNs+j8lTbXKXFo/g0f+L+lfOSMg7L5wPwZibQoGcmtviVlxs7NjCU244TG0yfNR44RgBWfLvrPLNYvbqM3W52p4AT3K3mKQrSXeQ89omOeJKwoNAQLooIOrtckE6p1tJ3cyRddAQlPS+6sgz6bZFZXMpwW4oIdEBqmQTJFNViAU6CGJG9t1FfGSGl8U78pH+1Q9jhdMKGmUt8VRiryKGY2SLEpBf3SdL7HLO2Xlj/ZBAYoEbPDLh5C8907k4ZEqU4lM4FiqMOSY31B6ta0PzVlSbhXoTjSBh/XgwdH6oLj2/74odDIm1XIM4eaqiShIftOyQbmAxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYG5fjJyTU5mBr05OytNbeWEP2T3g/f7VheSG4+12IQ=;
 b=Wkg/SEGTeqVftlUZ7R9vfenrL3gW/A7OtFJ6K8xHkeirtLd7wf9o2+xqgjpAAc6DwEa0IXYDVOsgKXHb6/CXs39BhPDPLkGlaa5f2Ef2ATOuvRyfl5rjI0n0zjsjjUVo2rpW5kRqajQFFUHL24+aM5T3J4xTDiHVNxdop4X/FqeHq/ocEbo3Ep6zChglrPQqaIRLBpoOv/6qyvJWaelu5IusSHjJVW1n6Cuy2hDaufg8dmQgJYKEOjlwA8W6H7iVXNvOCf4GilhUcvDOprWrmDhMLMFHVq+FQNA5S1lH64pj4+to7BTtMSAVIxFl3VwIpAsWq0PIF8sLbcjmfm/ueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYG5fjJyTU5mBr05OytNbeWEP2T3g/f7VheSG4+12IQ=;
 b=PvvItzV5f7rO+YYKNmJYFfrmxbhzSWb4lXzjkZbzFRynGrBrRTX5tiF5/7/suBy331TMLvlEoz0+M0oKw+j22MIddOUCD6rfSXgdbfouvKuGTWCqxJzmzaAjcETaJOGCeDaUUQgR9ChBs0NpJJ8+Pavd3CbqQAGm2dPKLuQqZZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 22:26:36 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%7]) with mapi id 15.20.7849.023; Wed, 28 Aug 2024
 22:26:36 +0000
Message-ID: <ab893fd1-6a90-4a39-963a-111dbdc9f720@amd.com>
Date: Wed, 28 Aug 2024 17:26:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] PCI: Use Configuration RRS to wait for device
 ready
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Duc Dang <ducdang@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "Li, Gary" <Gary.Li@amd.com>
References: <20240828214218.GA40398@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240828214218.GA40398@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:806:130::27) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9730fd-01b4-4996-55b0-08dcc7b07a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVVIME5QUUMwSEpFWENwM1Z4aUYvdk4zdTVBbDdBYktMQUM1QWFhdTJHTGps?=
 =?utf-8?B?MUdtQ0lmNXhSbklnN0l0amtFVFFHTDV6c0kwc0VrVWkxRThwZTA5bDRkTnlh?=
 =?utf-8?B?amtRMGJIeGQ2NU5peE1ZSnJXTXJBZGpQajU1Y0ZEaW5SU3Y4ZmVydDZGeC9R?=
 =?utf-8?B?WmN1UDFKRWI1Z1N4ZTFTa21USG8yRjJCWm5UNm85N2F0ek1ZSXdzUVc0NVRr?=
 =?utf-8?B?U2Z4OUF4V1JPVE8xbGltRDRuMGdYNnpYazNZWnl6RHltQkQzMmFwQkVLcDBF?=
 =?utf-8?B?ZkdzYzNBZlpGK3FHNW9MWmlhRTU0K1FSaFNLbWo3SUpISzNISWQzMXNZREoy?=
 =?utf-8?B?L0ZBQm1JekJONGMybFMvMTJ0ZGJtK2x4UEtMakNvREJoS1NiSXZZN0VCNXlD?=
 =?utf-8?B?dmgvUTRmNElnOHB0OFhzelJ3RkRMWkZZck44NUZRT0tCaGFEa1UzRjFuTU1n?=
 =?utf-8?B?encxaG0rYXVBanRKemNteUVER3J5MTVXaGVuVFF5ZVFWbjN1eDNQUDlZUldh?=
 =?utf-8?B?dlBzb3pTQU9zWTh5MHNTdXBuYWFPUWVsTmx6cWZtQTEvNVQ5dGJMWHdPbTZ1?=
 =?utf-8?B?MDdwODZ1RFRsVGFLNWhFZExFSmVod1BzQzNUbHhUeEduck9tT1liRzFsbVls?=
 =?utf-8?B?NkV1UStTcENmZUhnWVEyM0FNc2ZIS3NWVFpzcHZEL1BoUXVIVGRjd2MrRmxj?=
 =?utf-8?B?MFRoUTNxSUlDK29iVml5VW9VazBSSzhCUzdOMHVXTXBPRld6MzNna3FueWNN?=
 =?utf-8?B?L0loVlJIZ2lPMmN0RWhraWEramhib0tZMjhYUkV5QkdCc2psby9pNC9tUmhJ?=
 =?utf-8?B?bzVadnJPeWFxV1Z1SHdJM1FLWUREWEM5bzVDdkFNOTYrL20xSlhWUnFZZjhz?=
 =?utf-8?B?clNBVEpFUWF3Y2YyOUpDMWpWK1dpUytjMWJUdUJWOGkrL1IrcTkzWE41QnBZ?=
 =?utf-8?B?V3FSNDNodWY0VzRjZHpycGczM0FMd0hrakN0b2JRakhtNmNKRGppcjlDVFN0?=
 =?utf-8?B?N0tEcXlRVUV0RUNyQUROdTliL3ovV1l1N0x6c2V6TDkrdlZQNkxaWXF4alFm?=
 =?utf-8?B?NlVSaFUzNlpIUWtHWld4Wml6c0xFYnNMTHVXeUZhK0JTaEVPWnFXR01sVUh2?=
 =?utf-8?B?T0VCQUZMZHdwNjZlWDI4V0V2L1BneUdUQUxkUmNFOFBucEl6WXNqWDNublph?=
 =?utf-8?B?T0hIMklMVnltRHNueWN2aUY3RXpDaEVBQXdWRS9kMkZsZFZES1VXY2E2WVlw?=
 =?utf-8?B?T1RZaWNkNnJJN2xWM3Z6NGI3b2NNRWtqUkNaSmU4c2ppNDhjNnVXTm1wWHNq?=
 =?utf-8?B?WWRuYm9EL0MzT3BkVVAxRTNweDRmWWNKVUtXRUJNUjkvTjlQdDg4L2R6NXYv?=
 =?utf-8?B?RThVdXAyaUFVZWpZaHBySG1yM1NuL2FoMWZObGk0bzE2U2NhVTRIODVhNHVI?=
 =?utf-8?B?cDNCTTFBRTNTSTBQd0g4SU10b015T0k4ZmJNVzhRa2lEQkhLd2pDbXBWdUcx?=
 =?utf-8?B?djNwVUJwbnV6eWs5YUtNQm9zSGMwdXErc2ZIcXpYODd4N1pDYnAwN2lPSXJw?=
 =?utf-8?B?MmlocUUrY2dkS3h4MHVlZm5yWUxCNURNRVhXbG1lNHJJSjF3SnZ1MHFjRmc1?=
 =?utf-8?B?cFczSE1qTlpyTDVVeUcvQUFsV0ZoM3Y5NkpKbTkrME9NaGQrVVFucU9LcjRT?=
 =?utf-8?B?NnVVVE8yak55TkErVG1wSGVRSHhHTjZuSjJqcU4yTHl2K01TbHNmVE9tMmla?=
 =?utf-8?B?Z3pUZnk3MUswbHFUc3dmVnJwcHRHMXZzRHhwMmVoUll2ZktKY2dsWDg2L2pw?=
 =?utf-8?B?c3JPMFlXY0RiSDI1M1dNZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG94cTd2QWM1MmtaY1d5ME9WbDlBV3VPdXRxTCtxOVJYR0xjOXdKQkUzV1dx?=
 =?utf-8?B?R1hMRGZ2c1pMMWtqVGhvcE1ya1prdzZ4VVdiR0p5V0wyK3lkUzdlZ2huTDBF?=
 =?utf-8?B?aDMwYWowVnR6VXpjSTBkdHJnRVh2L29aZFdtbWxoRGxtZkxNa3BOUXh1bmk0?=
 =?utf-8?B?V1FGaWpiRWhSdkVrS2hsOEFIUGxTU0FlcFZyZW41TUhnUk1mYWxFT2UwQWhG?=
 =?utf-8?B?SUhQb3A0NXRKelRUNHpSUklYU0QrcFBHVlBLS1k4dTkwWHhFT1ZYRUpjbCt6?=
 =?utf-8?B?VHMybnVaTmFHaHJBaWltK2F2WngwQW9uZG5qbVNDamRFNUY3S3cyNDAydmI1?=
 =?utf-8?B?TW5UcElzSmNCOEFYN2REK2NuQUtremV0SHhuclVJZCs2QnMxRUluMWt0d2lD?=
 =?utf-8?B?SWZxeE5mUll5TTlzcnoxTVpzWUh4ZlZJSSt3WlM1d1BaVmhrd0EzcnVFOXhj?=
 =?utf-8?B?V2JnUUt4WHdUaFp2eXZiWGpmQlg2WHYxc3dxR09pZW81Nml3cjhhZFNGekxr?=
 =?utf-8?B?WVhDYW9KNWgrd00ycHBOL1RtekdVWURtL04rNlgzamVPUy8yS0VNaUN0MmJS?=
 =?utf-8?B?T3hMbXN3WjRwNld3bkhsZFpZakdIV0hhQVZYdlBqaXhCRzBGSk1uU044aGhj?=
 =?utf-8?B?UjhvcEc0N0M0Wi83L0pROGxWV3VoTXJBTGRaZmt4QWVYdlpEMUVmTkZqb04y?=
 =?utf-8?B?Tk54T3JoTmp4QTN3anAzQWNzaUhNRnYrdzNLOUV3Sjhzdi8vQy9YRHdja1pS?=
 =?utf-8?B?YVJvNHp2cFJJUG96QTFwNnV6c0ZVWWxITDNnMlFyZ0IrcVJrQ2UxalNXZ0Zm?=
 =?utf-8?B?MFpvQ1VBNnFpM2RIMktmOGx4cyt3TDV3d0t4NVE2VUR6N2hocEsyQWQ2VHRR?=
 =?utf-8?B?YkViTU9BM0lrNDg4cnFHU1NRRnhQbGNJOVlKZnFoRUoxcmE0bjhwMklvYUE5?=
 =?utf-8?B?UzRNMnR2ZWpZZ2tMb1hEUVFkb2RWbVNnV201ZnBGa0V2MzRwdVgyYUYzWU02?=
 =?utf-8?B?TlN5MFhZWGZvL09CUG1YTHlCZ3pKeFZOZkFoaHdUMXhNZzh4UDVsbDBtU0Zm?=
 =?utf-8?B?TUdRZjVmdmVIUURkR1JRaFdIMjgwYVJnS1NwQ2VPV3MvTkh6UjFYMWNRTXdm?=
 =?utf-8?B?dHNvNXpnNW1JbEEwdVhoNnZ3TkM5UzVyZ2dYTUxSUDhxRHdDOGxWZzlXZ29N?=
 =?utf-8?B?ak1IUStLOFBBWVpKUWlrdVN6Qm5ndjJld3R6NGU5enQ1ckYrN1ZKaFFQRitR?=
 =?utf-8?B?RlhKbnRwL202Yjdja2J1eHlRelZMRnRMNEhaTGxkVnIyU2JJdjQvVVVCa3VJ?=
 =?utf-8?B?VGg0VnJiMU0rRElvem1NUnk2QUtxNHlyZmJ0VGZYODJNRCtvZ1U0eTZIajBV?=
 =?utf-8?B?eE1STDYvN1VPWElxcVVrQU1aVDNLTnNYQnZIRGVwY3RDUUxiektkZkl4Q1R5?=
 =?utf-8?B?NWp4cGhmcGJ2ZWtJeGF3WEpNdHNwVjJaUnExeE9EZVhlVG1DUU41WXNVTk0x?=
 =?utf-8?B?ZEt4WGs0UlhjTk9BT0ZCc0hqMHRMRTlPbW5EdHVWaGNzdG0wekZFUk94UlN0?=
 =?utf-8?B?cGRuUWZMN1ZHM3ZrVGFSVUNFQ1VJd20xS3JxSE95L29sT0RnUDJNT3ZQMmRw?=
 =?utf-8?B?Sjd2SjlOS2NCV2ZybmFveU5LNlZzRHhjYU1iREtwOFF2VXZhQWNBeGh3T1pK?=
 =?utf-8?B?RC8rYW9BK2dpalVqUWtiL1NIY2VBK1FhMTZTWHRMRmJSWmhHMU1hdU1KaFNj?=
 =?utf-8?B?Mi9pcjVJVVVmMkUyN2FmVlVxRmlMVEdtUnI2NTc5S0ZhUDN6WkkyTjZTeW1n?=
 =?utf-8?B?aGdQeHo4cUVuTWFneWhhbEdOUU1pUHAwSzlHWmFIMlZGTkdiaUxRZHhwczVw?=
 =?utf-8?B?c1JoZkhvbng4dCswWUxSaWJXNHNhYWRuS2VJMDlQMUExcThIc3hHYkE0K2NC?=
 =?utf-8?B?cjdQNHhBdE1XMVd4cCsvbThGOVRzMFFEN0QvZXhPWmNnSE01M0RXZmFHa0RI?=
 =?utf-8?B?Z0ptRmNnYjAwZGVSNnhhcEo5T1VLMzgvOWxPZldYQlRiSmpFUmYwOFRWTnow?=
 =?utf-8?B?bk45Sncva011T3kzb242L05sbUdMdE5zdXoyOU1SZFBoRFdka2hTc3RoR042?=
 =?utf-8?Q?1H92ho4QYL2r2VX83TFLSzCaD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9730fd-01b4-4996-55b0-08dcc7b07a37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:26:35.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mX2JqMctLOcLPMn6cdIsQpcG5euy6rjDRWOlHee4Pvl7ToEyPFWy0r7+sFwLmELNeINR4ECGQ9Kb6AXJYqKZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

On 8/28/2024 16:42, Bjorn Helgaas wrote:
> On Wed, Aug 28, 2024 at 04:24:01PM -0500, Mario Limonciello wrote:
>> On 8/27/2024 18:48, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> After a device reset, pci_dev_wait() waits for a device to become
>>> completely ready by polling the PCI_COMMAND register.  The spec envisions
>>> that software would instead poll for the device to stop responding to
>>> config reads with Completions with Request Retry Status (RRS).
>>>
>>> Polling PCI_COMMAND leads to hardware retries that are invisible to
>>> software and the backoff between software retries doesn't work correctly.
>>>
>>> Root Ports are not required to support the Configuration RRS Software
>>> Visibility feature that prevents hardware retries and makes the RRS
>>> Completions visible to software, so this series only uses it when available
>>> and falls back to PCI_COMMAND polling when it's not.
>>>
>>> This is completely untested and posted for comments.
>>>
>>> Bjorn Helgaas (3):
>>>     PCI: Wait for device readiness with Configuration RRS
>>>     PCI: aardvark: Correct Configuration RRS checking
>>>     PCI: Rename CRS Completion Status to RRS
>>>
>>>    drivers/bcma/driver_pci_host.c             | 10 ++--
>>>    drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++---
>>>    drivers/pci/controller/pci-aardvark.c      | 64 +++++++++++-----------
>>>    drivers/pci/controller/pci-xgene.c         |  6 +-
>>>    drivers/pci/controller/pcie-iproc.c        | 18 +++---
>>>    drivers/pci/pci-bridge-emul.c              |  4 +-
>>>    drivers/pci/pci.c                          | 41 +++++++++-----
>>>    drivers/pci/pci.h                          | 11 +++-
>>>    drivers/pci/probe.c                        | 33 +++++------
>>>    include/linux/bcma/bcma_driver_pci.h       |  2 +-
>>>    include/linux/pci.h                        |  1 +
>>>    include/uapi/linux/pci_regs.h              |  6 +-
>>>    12 files changed, 117 insertions(+), 97 deletions(-)
>>
>> Although this looks like a useful series, I'm sorry to say but this doesn't
>> solve the issue that Gary and I raised.  We double checked today and found
>> that reading the vendor ID works just fine at this time.
> 
> Thanks for testing that.

Sure.

> 
>> I think that we're still better off polling PCI_PM_CTRL to "wait" for D0
>> after the state change from D3cold.
> 
> Is there some spec justification for polling PCI_PM_CTRL?  I'm dubious
> about doing that just because "it works" in this situation, unless we
> have some better understanding about *why* it works and whether all
> devices are supposed to work that way.
> 

I mentioned this a little bit in my patch 3/5 in my submission.  The 
issue isn't "normal" D3cold exit that is fully settled down.
That takes ~6ms from measurements.  The issue is how long it takes for 
D3cold *entry* followed by *exit*.

When this issue occurs it's tied with a tight loop of runtime PM entry 
and exit happening in that short window.
That's why it can be tripped by unplugging a dock, waiting until 
~approximately autosuspend delay and plugging it back in.  If you catch 
the right timing then the USB4 router is still on it's way down to D3cold.

In terms of a way to match this problem to the spec, the closest I could 
think is PCI-PM spec.

But I do see in the PCI-PM spec that the delay for D0->D3hot should be 
10ms. In the Linux kernel implementation __pci_set_power_state() when 
called with D3cold calls pci_set_low_power_state() which does wait 10ms 
followed by using the platform to remove power.

I can't find any timing requirements for D3hot->D3cold transition though.

I would hypothesize that if we injected a longer delay on the "other 
end" for the D3cold transition entry it would solve this issue as well 
though.

