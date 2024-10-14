Return-Path: <linux-pci+bounces-14495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04099D589
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6E5B22059
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F7F1BDABD;
	Mon, 14 Oct 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GugmSQMS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5A29A0;
	Mon, 14 Oct 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926542; cv=fail; b=nHtQESanp1fNtT8X9PFjKEuEkyTZCX/z+x1oYnB5Ys4b+Zh+YkMByVyywMQuLSrLBjzL9x5ZE7Zh30uJ5CtlXfxNsaYupYK6W84kSkBa/AMmUlyNmWpQWp8aLjrV1nwC5NRKMOaXXCUeGuYhhDexbdg17OBqDbhxJSE1e1DRAs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926542; c=relaxed/simple;
	bh=xsREzCo0JwbhCgvPFfBHe8JUmzgrfPZFbEbixZQAhXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MTbu8y1NbrVzy8g3kJV2w78B0g1ONowIwa56vBVM1K6TxcxCZPU3PjR+jmc3q9L2tdgxrPOcMIFUxBKKozcAhvLpDiydKtCdXEJTTa86OAwSBBySiqqdyNQBEi/SIQHmS9GQlGSM0/XYxQwvh7ivN96GhBh4uIJsPW7IOggAprc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GugmSQMS; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SA9JiTu7JMQY0xPw/1bs+fw/UEqJl4t9mEB/xkCReslFwClBtEnvYFX1No5f9DOXHmIIo4BRM4sBQEWMEbYHVKV2CHcE6xEAy9d+YMLKSZ3vkjMtkeg+F4E5gcL16Az/VM8oVt+lVS0d+mantapPyCHVXt+4jzEnZqro508YbYC9BfQ3C8kGk+uQw4NEh5XJW/jbH0NbG7i/CrN+grsC+Fh1HEXFLnZfGxveZ/c24RJTzJUR/hIeq21iTFa8XS1f+saQEJdW7yO+nQh45xnQGlaMycJtGguxucRTiDEudNeP4gRzrwCrt4heUPxo3Flzvz07tcCPnkkYiYdh9NClyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79QooBCLTxW4hHAnGvEDAmE7HKfxn2m43jiGQISGU2g=;
 b=avK29iD1gIFKzBBipMbU1YiK97GCqw9a458yh3wUL+0tVh3iEmAn5C24NkfnewTNDA2NK2rwQL0jpYC9JcZNKjCpStLfs8xMP0xJV04hHln4PXfOCzyirziU46xEUQ/+/+VHAeXjJxUx8a1MPWSziUrxpJOmh/PMJmeM6BlyF1qEG+nFeMQSGlQ5GZYagCHLzcNhJLg51BYcpHMkFxJsPwbSgCZUkHg48Ux7US90GL1ZnO9rVb9WTsStwVQ420SO6c2/xA0J1fazgm0F2CGyvVRzoGmQ2RBP2f5Bzn2c4nT20HPnT4LgzMyLae8qn7ZKPyf9OBnOHJCpkv44GRjFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79QooBCLTxW4hHAnGvEDAmE7HKfxn2m43jiGQISGU2g=;
 b=GugmSQMSXqJnp5+sA0WS9CZyczHCEBiNkhq6ZsIorw/u1RTeIHkq61Z6U6MqRwNKrX/AkhVXR5ItAgkAyszvRdG39R/APY+eB1l2cebJk0lMHKHNtFBnVOgQbn8UUXRLTp4tu/HjqHLxilRW9zAmdTS6Dn8Lep7gNkEZE6jlOCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 17:22:11 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:22:11 +0000
Message-ID: <17857590-4fca-4c55-b1d7-85a0b22519b6@amd.com>
Date: Mon, 14 Oct 2024 12:22:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241010190726.GA570880@bhelgaas>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241010190726.GA570880@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0179.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ad837c-29e0-49d3-0d4c-08dcec74bcd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjdBZEVhenRINXZ2R2xOMStzWC8rV1J2bCtHVmUyWUNrYVhDbzNpSGdNVTRM?=
 =?utf-8?B?VzlXS3YzYlJJWlNPUE4xdXU3K0pHRUtKMzRpdkdHbjRidkpDblBXbTRWLy8x?=
 =?utf-8?B?RTUyV05nZWlVTldsRmRxYUE3dkErT0FTQ3RBRkVrR1FyQllrSndXZUFBbGdi?=
 =?utf-8?B?MkYvR1VZMzhjUW8vdDNHNXZjT2R5Y2FxNlJWTUF5b3VlUUlnSjl6bnIvUlRm?=
 =?utf-8?B?RkdRT2ZydWNhWFB3S1lOUnRqRnRUc2d0L3VXZWlGVTJ6ZkN5Q2hGRTd6cWEy?=
 =?utf-8?B?bm1nZW1UcVl6M1NQdjM2aDlJQlZkdDVHREFaTHNteUR0RWdwTHkzTm81VUl3?=
 =?utf-8?B?NVlyZUcyaDZEZHdEUkNBK1dHV3FjQUxMTnFTaDV1eEN2ckF6WE5MWXFqTFo0?=
 =?utf-8?B?cG5nMjZOVHF3TFpXRkIrMzExbm0rNlJabVZzQjBldHFPRWxHeG04emhnNGFI?=
 =?utf-8?B?RXZIYy9GWFRudlNzUU1xTjJwNkpuS05YRGtYM3hjSHpQYU1NeG5vZWd0cUhP?=
 =?utf-8?B?RFRUUEQ0R20vNE1KTGQ5bXV2THd2Qm1PSUlnZkJLZnhQOHl5NEEyeVlkdUZn?=
 =?utf-8?B?QTRkdEVxL3JCcDluNG9Hbm5MbmNtSlZhMGNncTlDSHZFQ09Nb0ovMmI0RUJz?=
 =?utf-8?B?aGFUVkZaNGUyaTc5TXNtZHR2ZGxDK25yVmdzTkQ0aXpFM1pQRjF1YTlsWTRX?=
 =?utf-8?B?ZUpvNWNNZWliMkJ4dFByZndYUjUvV3J5cnZQUk9WNHRIeERFbjhqME91Q24x?=
 =?utf-8?B?QitGK3J2NkFEWVNzWlFmTTNsejdYRk5FeUNDQlo1V2xtd1IrbXNKdEMrak5t?=
 =?utf-8?B?OTIxcU9hcVpHNURoN2w5NmlWU1duejRsbDI1OVFNeW8xa0pwNkhYUFBmV0Iz?=
 =?utf-8?B?c2F5TGpvRVVDd3Z5dkpZYnJOYXZFZ1RZNmxIcUdNL09tOTVGSCt4YjJBTXpS?=
 =?utf-8?B?eW4wRGxTaWZVa1RTclRjQXVqUXBmSlhJeXl4d2h2NE54cTBlVUt4V2duNlMz?=
 =?utf-8?B?LzFyaUFEblBaa3U4WGU5b2xQMzk3b3J0UUFOWXh5Ky80ZkJTenlJc3JRS08z?=
 =?utf-8?B?Y1lhbkVuRG13Tm9tUTVNV2prYmNBcVh6YWlJTzZIZ2RCUWFRNXAyZ1ZEK1Qv?=
 =?utf-8?B?YXcrT2t6MC93QWd4dkY2Ry96ei9HL3ZkRG5TYXJEdW50T3l3ZzI4emhsa1Fv?=
 =?utf-8?B?MXBtRndHOXNrcU5nakNvT0ZnY1JuZjhMMnNJNi8wQmh2dTJoN2VoL1p2ZTFS?=
 =?utf-8?B?anlCSG5xWXpBV2h4L1REN1psYUlnU0VNSGVIVlhCaHhhc3IzMVczSFhmUmo0?=
 =?utf-8?B?RVR6U2t1bzJTR0wwalJDb0lvSi9YZnVOa29ZVnJVUVB6VEZGQlozOTZmZWNU?=
 =?utf-8?B?YTI1cHZGTmdLWFhuUW5XcFFRRTFsK29PY3h3NzBiaUJFWXdsMUZhekZ1RFFZ?=
 =?utf-8?B?L2ZUWWpxellqeHRkaHFlb1RuejJzQnMvWFk1VHVZZFN0U2llK0dZV0dGeExl?=
 =?utf-8?B?aldqTkh6VmpxL24renhaUS9EQjIwSlhsM0JZK0VldkROaDM2T0s1V0U4cmxN?=
 =?utf-8?B?b0NCR1hjMHFSOFZ3bE5oWFBiZ2tJUVlydmFsOU5KY0JhNDJrYUZqOTc5aXdF?=
 =?utf-8?B?R2hTc2NOaXV5N2taSjRKQ2Y0dzl4azRxc3F2V0RMdm1aYTJUQzhXSkhqSjVZ?=
 =?utf-8?B?SzIxRUhWWkVrcUQxNmx3Vm13dS9kNUdtbG1PNnRlbjdzRDlBNXNkcHZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlhwbFExclcvZTd6L1FKSEZKSGdWelhIcWJSV3M3MzlPWk1vaVlzdVB5d1FR?=
 =?utf-8?B?TXZ2Zmh1YWh6N1JjbC9ld0xFeTh5dWl1enk5NHlncGlJN01YZzF0MUJWL2FT?=
 =?utf-8?B?OVpDUXpNc1BhMUZIc0RGVDBWVDlOU3VjdGNhMjg1MkdOaHUvbDVieERTL1Fl?=
 =?utf-8?B?OFZJbVpnYkVld1hIYjdmRmFHdDZ1YkxvOW9PWVVUald2Rk4xY3Z3S0lsMk5s?=
 =?utf-8?B?MXFrZkxPNUJmeWpPSitJL0VzODFzWkNMcFVoVHl3WHFVQ2hiUFppaWxOWTB2?=
 =?utf-8?B?QlJyQzMvS0lGQmxqVXc2SFY2eGlTSDVBTG16ZXREbFNGS05tcnd2VFdHcjFO?=
 =?utf-8?B?VUlHVFpnSGxnR0ZEcjNBL25RNWwyaG5vQldXbkcvRVZ0UXB0UnJCaUxUaGxw?=
 =?utf-8?B?VUxubnpiWHdORzdYc3Y5dXpvU0RNVSs1cGU0OGhidUJzV29jaE1LNXZHQnZV?=
 =?utf-8?B?ZzRIRSs5UHQ0NWJvM01iZXdYejVCVlpFV2U5TGMxWTV4SFB4cmdRazBnRXZz?=
 =?utf-8?B?TENiRnNHVnZZc1l0TVhtSHNZRVUwckgyTUtVL1JvUnAzWGhUTkdYa0JmaGNa?=
 =?utf-8?B?bUdKY1F0bEpyYjQ4ek83clNmK3hUZ2hpQjJlVjZuNHVKMUIzV0tFZll0bUdJ?=
 =?utf-8?B?U2VrMEIvaDlGNnhPYy9PeXFHOU0zUEJvUWFjb3I1QmR1S0dXMHByV01Cekx1?=
 =?utf-8?B?WXJmTVFoRXFTc1JKaFQvdFdFejdFRG5OeDMydFZoZktyVVRXYndFUUFkUFBQ?=
 =?utf-8?B?amliWFBKTklRKzNkbkNROXhQYVQ1dC80QkRLd3RuQnoyaUROeG90ekRlbm9k?=
 =?utf-8?B?WmV0a2IwamdZNGx4a1lkU3ZZR2NNSmROZ2VWZEI3SGRhcFUzRlF3azBid0Fq?=
 =?utf-8?B?RUgzRG9uMlIyTWQ2VXpjQXdyM2thZXFBc0dSNGVoc3NEc1RCTEJrRlRmeEcr?=
 =?utf-8?B?NWlVa2d4VGgrSmRFZGdNWk8wQTIrdzZZQUo3K2pjV0VkL0N0czhkb0N3R1o3?=
 =?utf-8?B?WE9jc1N1aFFwMkVndDYycjNxdXZNK24rTlR1YlZEU0F4SnVWa25PVnAyN2kr?=
 =?utf-8?B?QjJNeTVEdHBXS3d6bHg5VzJ2VlFlMmx1elpXb1lmeVRBNjVwMXZ0dEtKeDdC?=
 =?utf-8?B?NGN3Tmh1ZWgyZjlyb1BxY2U3RDcrMlg4OERQNlQvTkdyaHpnQUJJSUk5Wmpj?=
 =?utf-8?B?ZzhqaUFtQ3lIMGM5UC96WVQrZmtTUXN6N29vVFh0RVRzZWJITWU2aFMxWUFl?=
 =?utf-8?B?RTNLS24wN2VjcnZRcFZOUzdPbVR2MCtrMCtVZ2Rrem5oRFJvZDhYN0JMQ1Nn?=
 =?utf-8?B?QlU2RzE4Y1p4UXgvazJoV1hkK2ZFM094b1psSE02bk1iV0lxeEJDek1qREtp?=
 =?utf-8?B?d09aK3hFQ3NtMk5jNkxRa1h4QnkvRzdWVkp4aWtFaURsbWduSjR0eEZPVTJu?=
 =?utf-8?B?aTNXZXJnK0laOVE0Vm1DN2lIV3d3OU13YW8xSi9pc2tNbTllV0hUUCtLYndp?=
 =?utf-8?B?UWlOOWgwRFFvOXVCVk0xMGJETUhEYlpYbEJGWmY4ZU15Y1RkUlJZL1RGZTNn?=
 =?utf-8?B?OGVnempSdGZXclpQVm40dysrYzlHcU16ckpyUjVCU0FpZ1V1TDd5bkRxdDNF?=
 =?utf-8?B?YnhkSU9lV0lBUHVBTVQwZDhRQjZwR0haL3F1WkNUdE4rd3BjOWxxcGNqYjY0?=
 =?utf-8?B?YkJZSTFZQVlEbUxQcGFLNjNjSGt6NFJLVFM4dXZ3WFVkZGM4MzJQTXpVTU9I?=
 =?utf-8?B?Z0VobmRveTgzN0JTdlNtcG43RDl2dGlZSlFmMU8waDBHMldMNWxrdHYwakpa?=
 =?utf-8?B?UTRDOXRobDZRbTArck9rQmIyclljQk1OaDZ1WDdVejRCb0E1ZUkyT2Z0VnZo?=
 =?utf-8?B?cXE4bnhaL01RcER3c2E1Y3FpQW1pd3VDb1JHZ2VXcXNvNk5IVkw3U0ZRd0c2?=
 =?utf-8?B?Sm9qSUszOHM1bG9MVDdmREgxd2ZxR3pPMXVka2YrVGlPYSttQUhZUjFhcWhC?=
 =?utf-8?B?dlFBU1NaWWR5Yit0RTAvczRmR1ovVmdvbHJTWGhNVWtlN0RkKy91ME14cTlm?=
 =?utf-8?B?UngrR3p0V1NtdUxMVHArTmVrWDhlOVU0dmlsZkQzYXFKdTkrNFB2RnNRSVpJ?=
 =?utf-8?Q?VLMiUp7XR+UL2HSaTZ04J3fnn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ad837c-29e0-49d3-0d4c-08dcec74bcd1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:22:10.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuw9XbRHxMrCjj1uqGMpUwKftymYf5PeTQ+ur8wSlxBTuz8YWtjabC4swB+OhDGq4hgOSm1/hPAI2fGCIEn9FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409

Hi Bjorn,

Thanks for taking the time to review. I added comments below.

On 10/10/24 14:07, Bjorn Helgaas wrote:
> On Tue, Oct 08, 2024 at 05:16:42PM -0500, Terry Bowman wrote:
>> This is a continuation of the CXL port error handling RFC from earlier.[1]
>> The RFC resulted in the decision to add CXL PCIe port error handling to
>> the existing RCH downstream port handling. This patchset adds the CXL PCIe
>> port handling and logging.
>>
>> The first 7 patches update the existing AER service driver to support CXL
>> PCIe port protocol error handling and reporting. This includes AER service
>> driver changes for adding correctable and uncorrectable error support, CXL
>> specific recovery handling, and addition of CXL driver callback handlers.
>>
>> The following 8 patches address CXL driver support for CXL PCIe port
>> protocol errors. This includes the following changes to the CXL drivers:
>> mapping CXL port and downstream port RAS registers, interface updates for
>> common RCH and VH, adding port specific error handlers, and protocol error
>> logging.
>>
>> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554
>> -1-terry.bowman@amd.com/
> 
> Makes life easier if URLs are all on one line so they still work.
> 

Ok.

>> Testing:
>>
>> Below are test results for this patchset. This is using Qemu with a root
>> port (0c:00.0), upstream switch port (0d:00.0),and downstream switch port
>> (0e:00.0).
>>
>> This was tested using aer-inject updated to support CE and UCE internal
>> error injection. CXL RAS was set using a test patch (not upstreamed).
>>
>>     Root port UCE:
>>     root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>>     [   27.318920] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>>     [   27.320164] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>>     [   27.321518] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>>     [   27.322483] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>>     [   27.323243] pcieport 0000:0c:00.0:    [22] UncorrIntErr
>>     [   27.325584] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>>     [   27.325584]
>>     [   27.327171] cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error'
>>     first_error: 'Memory Address Parity Error'
>>     [   27.333277] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>>     [   27.333872] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g1fb9097c3728 #3857
>>     [   27.334761] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>     [   27.335716] Call Trace:
>>     [   27.335985]  <TASK>
>>     [   27.336226]  panic+0x2ed/0x320
>>     [   27.336547]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>>     [   27.337037]  ? __pfx_aer_root_reset+0x10/0x10
>>     [   27.337453]  cxl_do_recovery+0x304/0x310
>>     [   27.337833]  aer_isr+0x3fd/0x700
>>     [   27.338154]  ? __pfx_irq_thread_fn+0x10/0x10
>>     [   27.338572]  irq_thread_fn+0x1f/0x60
>>     [   27.338923]  irq_thread+0x102/0x1b0
>>     [   27.339267]  ? __pfx_irq_thread_dtor+0x10/0x10
>>     [   27.339683]  ? __pfx_irq_thread+0x10/0x10
>>     [   27.340059]  kthread+0xcd/0x100
>>     [   27.340387]  ? __pfx_kthread+0x10/0x10
>>     [   27.340748]  ret_from_fork+0x2f/0x50
>>     [   27.341100]  ? __pfx_kthread+0x10/0x10
>>     [   27.341466]  ret_from_fork_asm+0x1a/0x30
>>     [   27.341842]  </TASK>
>>     [   27.342281] Kernel Offset: 0x1ba00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>     [   27.343221] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>>
>>     Root port CE:
>>     root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
>>     [   19.444339] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
>>     [   19.445530] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
>>     [   19.446750] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>>     [   19.447742] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
>>     [   19.448549] pcieport 0000:0c:00.0:    [14] CorrIntErr
>>     [   19.449223] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>>     [   19.449223]
>>     [   19.451415] cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'
>>
>>     Upstream switch port UCE:
>>     root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
>>     [   45.236853] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
>>     [   45.238101] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
>>     [   45.239416] pcieport 0000:0d:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>>     [   45.240412] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
>>     [   45.241159] pcieport 0000:0d:00.0:    [22] UncorrIntErr
>>     [   45.242448] aer_event: 0000:0d:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>>     [   45.242448]
>>     [   45.244008] cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error'
>>     first_error: 'Memory Address Parity Error'
>>     [   45.249129] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>>     [   45.249800] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g1fb9097c3728 #3855
>>     [   45.250795] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>     [   45.251907] Call Trace:
>>     [   45.253284]  <TASK>
>>     [   45.253564]  panic+0x2ed/0x320
>>     [   45.253909]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>>     [   45.255455]  ? __pfx_aer_root_reset+0x10/0x10
>>     [   45.255915]  cxl_do_recovery+0x304/0x310
>>     [   45.257219]  aer_isr+0x3fd/0x700
>>     [   45.257572]  ? __pfx_irq_thread_fn+0x10/0x10
>>     [   45.258006]  irq_thread_fn+0x1f/0x60
>>     [   45.258383]  irq_thread+0x102/0x1b0
>>     [   45.258748]  ? __pfx_irq_thread_dtor+0x10/0x10
>>     [   45.259196]  ? __pfx_irq_thread+0x10/0x10
>>     [   45.259605]  kthread+0xcd/0x100
>>     [   45.259956]  ? __pfx_kthread+0x10/0x10
>>     [   45.260386]  ret_from_fork+0x2f/0x50
>>     [   45.260879]  ? __pfx_kthread+0x10/0x10
>>     [   45.261418]  ret_from_fork_asm+0x1a/0x30
>>     [   45.261936]  </TASK>
>>     [   45.262451] Kernel Offset: 0xc600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>     [   45.263467] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>>
>>     Upstream switch port CE:
>>     root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh 
>>     [   37.504029] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
>>     [   37.506076] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
>>     [   37.507599] pcieport 0000:0d:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>>     [   37.508759] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
>>     [   37.509574] pcieport 0000:0d:00.0:    [14] CorrIntErr            
>>     [   37.510180] aer_event: 0000:0d:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>>     [   37.510180] 
>>     [   37.512057] cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'
>>
>>     Downstream switch port UCE:
>>     root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
>>     [   29.421532] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
>>     [   29.422812] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
>>     [   29.424551] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>>     [   29.425670] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
>>     [   29.426487] pcieport 0000:0e:00.0:    [22] UncorrIntErr
>>     [   29.427111] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>>     [   29.427111]
>>     [   29.428688] cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error'
>>     first_error: 'Memory Address Parity Error'
>>     [   29.430173] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>>     [   29.430862] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g844fd2319372 #3851
>>     [   29.431874] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>     [   29.433031] Call Trace:
>>     [   29.433354]  <TASK>
>>     [   29.433631]  panic+0x2ed/0x320
>>     [   29.434010]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>>     [   29.434653]  ? __pfx_aer_root_reset+0x10/0x10
>>     [   29.435179]  cxl_do_recovery+0x304/0x310
>>     [   29.435626]  aer_isr+0x3fd/0x700
>>     [   29.436027]  ? __pfx_irq_thread_fn+0x10/0x10
>>     [   29.436507]  irq_thread_fn+0x1f/0x60
>>     [   29.436898]  irq_thread+0x102/0x1b0
>>     [   29.437293]  ? __pfx_irq_thread_dtor+0x10/0x10
>>     [   29.437758]  ? __pfx_irq_thread+0x10/0x10
>>     [   29.438189]  kthread+0xcd/0x100
>>     [   29.438551]  ? __pfx_kthread+0x10/0x10
>>     [   29.438959]  ret_from_fork+0x2f/0x50
>>     [   29.439362]  ? __pfx_kthread+0x10/0x10
>>     [   29.439771]  ret_from_fork_asm+0x1a/0x30
>>     [   29.440221]  </TASK>
>>     [   29.440738] Kernel Offset: 0x10a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>     [   29.441812] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>>
>>     Downstream switch port CE:
>>     root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
>>     [  177.114442] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
>>     [  177.115602] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
>>     [  177.116973] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>>     [  177.117985] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
>>     [  177.118809] pcieport 0000:0e:00.0:    [14] CorrIntErr
>>     [  177.119521] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>>     [  177.119521]
>>     [  177.122037] cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'
> 
> Thanks for the hints about how to test this; it's helpful to have
> those in the email archives.  Remove the timestamps and non-relevant
> call trace entries unless they add useful information.  AFAICT they're
> just distractions in this case.
> 

I'll remove the test logging and details from the cover sheet. I'm unable to find how to 
attach using git tools. Instead of an atatachment, I can locate the log files and details 
on a public github. Let me know if this is not acceptable.

>> Changes RFC->v1:
>>  [Dan] Rename cxl_rch_handle_error() becomes cxl_handle_error()
>>  [Dan] Add cxl_do_recovery()
>>  [Jonathan] Flatten cxl_setup_parent_uport()
>>  [Jonathan] Use cxl_component_regs instead of struct cxl_regs regs
>>  [Jonathan] Rename cxl_dev_is_pci_type()
>>  [Ming] bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can
>>  replace these find_cxl_port() and device_find_child().
>>  [Jonathan] Compact call to cxl_port_map_regs() in cxl_setup_parent_uport()
>>  [Ming] Dont use endpoint as host to cxl_map_component_regs()
>>  [Bjorn] Use "PCIe UIR/CIE" instesad of "AER UI/CIE"
>>  [TODO][Bjorn] Dont use Kconfig to enable/disable a CXL external interface
>>
>> Terry Bowman (15):
>>   cxl/aer/pci: Add CXL PCIe port error handler callbacks in AER service
>>     driver
>>   cxl/aer/pci: Update is_internal_error() to be callable w/o
>>     CONFIG_PCIEAER_CXL
>>   cxl/aer/pci: Refactor AER driver's existing interfaces to support CXL
>>     PCIe ports
>>   cxl/aer/pci: Add CXL PCIe port correctable error support in AER
>>     service driver
>>   cxl/aer/pci: Update AER driver to read UCE fatal status for all CXL
>>     PCIe port devices
>>   cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to pci_ers_result type
>>   cxl/aer/pci: Add CXL PCIe port uncorrectable error recovery in AER
>>     service driver
> 
> I had to look at the patches to learn that all the above only touch
> drivers/pci, aer.h, and pci.h.  Can you use the PCI subject line
> conventions (e.g., "PCI/AER: ...") to make this more obvious?  Almost
> all already include "CXL", so I don't think we'd really lose any
> information.
> 

Yes, I'll change the patches' headlines to use capitalized "PCI/AER".

>>   cxl/pci: Change find_cxl_ports() to be non-static
>>   cxl/pci: Map CXL PCIe downstream port RAS registers
>>   cxl/pci: Map CXL PCIe upstream port RAS registers
>>   cxl/pci: Update RAS handler interfaces to support CXL PCIe ports
>>   cxl/pci: Add error handler for CXL PCIe port RAS errors
>>   cxl/pci: Add trace logging for CXL PCIe port RAS errors
>>   cxl/aer/pci: Export pci_aer_unmask_internal_errors()
> 
> Ditto here, and add something about CXL in the subject since this
> doesn't export universally.
> 

Ok.

>>   cxl/pci: Enable internal CE/UCE interrupts for CXL PCIe port devices
>>
>>  drivers/cxl/core/core.h  |   3 +
>>  drivers/cxl/core/pci.c   | 172 +++++++++++++++++++++++++++++++--------
>>  drivers/cxl/core/port.c  |   4 +-
>>  drivers/cxl/core/trace.h |  47 +++++++++++
>>  drivers/cxl/cxl.h        |  14 +++-
>>  drivers/cxl/mem.c        |  30 ++++++-
>>  drivers/cxl/pci.c        |   8 ++
>>  drivers/pci/pci.h        |   5 ++
>>  drivers/pci/pcie/aer.c   | 123 ++++++++++++++++++++--------
>>  drivers/pci/pcie/err.c   | 150 ++++++++++++++++++++++++++++++++++
>>  include/linux/aer.h      |  16 ++++
>>  include/linux/pci.h      |   3 +
>>  12 files changed, 503 insertions(+), 72 deletions(-)
>>
>>
>> base-commit: f7982d85e136ba7e26b31a725c1841373f81f84a
> 
> This doesn't apply cleanly on v6.12-rc1, and
> f7982d85e136ba7e26b31a725c1841373f81f84a isn't upstream yet.  Where
> is it?  I guess it relies on some other series that hasn't been merged
> yet?
> 
> Bjorn

Hmmm, I thought I was using a 6.11-rc7 commit. I will rebase to either 6.12-rc1 or rc2.

Regards,
Terry

