Return-Path: <linux-pci+bounces-15203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D889AEA38
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBAA1F21237
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA11E25FA;
	Thu, 24 Oct 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VQulfnaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8E1E1311;
	Thu, 24 Oct 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783211; cv=fail; b=ia7kmWWJ/DomFi6xI8WPtu0rvkSCV/BWAcXP966w+u+2w060lAqcuZQ8uNvN+SI/zipNUYOe1ugZI8fTi92QObwKAt48G0Jz3rfa9heE3QkrIvafPYLsy0uJ/Fglg9yJAYGDQth39ulr6wU+UWqSViGT5TOmBMG02pZNhIEmSOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783211; c=relaxed/simple;
	bh=czDsefYSPOMbZzaSPGpwNgR6LXw7LUi5/0hsVG2XLkc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LI3PbWwHwaRPIzmiHPmCCKJ16BPvwhfmQktEfcbLKZW38hjf3F1Xclc3CCDf2APHLYrSK1F5xqP7moTyNQDfJEcYE+5+/74BCGt/18VLhsbwp1hPr3kDPJgCzMdtmW/ZYOFscYRdXoi6RLx314sXPtISqUfIbxUQodiCLKUWVw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VQulfnaD; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwbK9HwOTUmJKf/0T9fRLWNCQDZdqFCNJhnIzm6pZ+zh6CCXK5g/gt7RQDoaPIC/r2QvNRKEuIhsaFsWr5XeD2WWtANviWqf8Xw1Fic7DIAg+HitzEybZVSLdTJjIpyoO0EnmyBhAuaE8M/8SEULAuu4NFbua97TZjv//sJVxiPthK8mpFr5b3zdWde4zqeJYi2etphUoUoz6Nd7/Q2f3KaVPwUvB4XPffSNrLLowrL3Vb4mVcjp3xVHi5Skrs/uM/WpfHCgHB8J8rDW02uF4HkmXFlKOlai9Te6HD7fLeiBBYxP/syS4To2wN6f16z6cQDoUufSzwRNU7UY1Bkh6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT1NHbt/4WyhMbxSV7BE/EmijsOORy1bgZ2R+WM8RMg=;
 b=PzWtwqklV6cduJuEwqKfhLMz4GlG+kfT2Ga1d87Bm9ltBxaW6UPW4kITMqaaax4mPggRP6INvwb9FJZ2zVAIXN77pT3FSy3To61+GzDxSMBVU4RxcotZiiL3tSEfcKBQKjLlpjuHI1YwvzNoRcqHLU63jy5ynNgH+r1+RjMZphvlvDaerv2YQO8k7GU1HfoWI9RlYJk7r+BBtJGkkGCCK73fUHBy57Jva025PHEJweDFwr5yRDPblphlmnRp/tSJnHV1R3Mdy8UBISjPREMIZ+eAYWNLs+uymPmMBeZBbNZ89K1bnY70mawCBGd6v15pUwiBvBDDR0oIATtqB3FJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT1NHbt/4WyhMbxSV7BE/EmijsOORy1bgZ2R+WM8RMg=;
 b=VQulfnaDjo3FL/zQq032O/EVtE/81hyBGzej1itQFU4Pp7x7HVT5FDbqQHffNILBG7CWabmQTckgIcdBCmJOb4S7/CfDvI58m9JE0KlS+Fs8Yglfe/UFrR6TMpTJmICAw5BIV0afu7uoop09b56k9Gv756TM8Ww50hr5WiVUHHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.20; Thu, 24 Oct 2024 15:20:06 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 15:20:06 +0000
Message-ID: <6af9d0a2-97fe-4296-9ceb-bf9e7fc91d5a@amd.com>
Date: Thu, 24 Oct 2024 10:20:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] cxl/aer/pci: Add CXL PCIe port error handler
 callbacks in AER service driver
To: Dan Williams <dan.j.williams@intel.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 Benjamin.Cheatham@amd.com, rrichter@amd.com, nathan.fontenot@amd.com,
 smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-2-terry.bowman@amd.com>
 <671705b5bb95b_231229468@dwillia2-xfh.jf.intel.com.notmuch>
 <0cceca3d-f69e-4277-bc9f-2556fd212ebb@amd.com>
 <6717dc2ec6c90_231229487@dwillia2-xfh.jf.intel.com.notmuch>
 <b3fea77e-1103-40ab-b7f2-adc545273be6@amd.com>
 <671838bc84b33_4bcb294fa@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <671838bc84b33_4bcb294fa@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:805:106::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ee446f-a789-407d-1286-08dcf43f571a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVlYK0xkbDV5QzdpV1JkZXBKeXlxb0xYWW1aekJTTGtKN2dBRFU5WnJ6RGJq?=
 =?utf-8?B?ODhITkZ1UUVRSk9BdFZaQlVXaWNDd1N2ZkZYRjZsS1pSYlZGS0RmMlZYcVhE?=
 =?utf-8?B?Rjh6UUFueGc2UG55bXdaM3VDbEVwdXorYWl1c2lKU2RzalFVZzIvSzBuOVZH?=
 =?utf-8?B?alNpU0V3bXBvaC9kaEJCOGNnanFHSTA5RlRoZWE1SDA4N0hEOEVJWDJ4MStm?=
 =?utf-8?B?b1kxM1hnU1R3Q2duVGFjN2NZMWdlek1tUE5DQ29ESFlsS1lWWmxTVExPTktZ?=
 =?utf-8?B?VUNCenJTVmFXOWw0NU9tc2NBRUpZeW1qZk9NTlpvdC9ENXBFTGF5SlJXNitI?=
 =?utf-8?B?NzVQbVZIYy84RklaQi9lVllLM3lKWVNjTVFrRTYwaENQeUtObXJaSVRlYVVv?=
 =?utf-8?B?Z2FIeFNIcjlSdHM0K0trWmZ3V0FnTWdQRS9xOVJyOGdvRE5uNWhzZm5wYTNQ?=
 =?utf-8?B?c0ZkV3g0MlVhWS9LOC9LaWtGWDJTeDk0cmhtMGgxZWVpMWFwampkdy83WHlC?=
 =?utf-8?B?OWZsMTllT3BGWDJJSnRHTVo4NlNkSEUzbncvYnVMLzB4SnY3QUZpRVJwYlBl?=
 =?utf-8?B?QTRNRG85TWt1dzlXZW9abTNHV3B4Z0xUQm1GVjkzY1BjamxGWEpXK2x2bHNX?=
 =?utf-8?B?aHBBRVZqcUVGSkt3RkhSWHVXNXFiaW1VVlo3RmlicVc3NWRnWS8vWUYvbSs5?=
 =?utf-8?B?cHlJdzZkMDU1MGVjNUN0ZEEvV3BaM0ZkNE9IY2k4cGFqV2NkdHFuWjB3ak9H?=
 =?utf-8?B?VUFScDlYOVN6U2poYW5aMTNwbExEL01CS2g5THR1TXNWSWY4aXlBYlJPaU9u?=
 =?utf-8?B?bUkyQ0dwUGliVVNEZXRMc25hc1dUUHVOUGZpNUc2M1drUkpuWDdrRVhPazdF?=
 =?utf-8?B?U3JqNExWaGxFbkNKbURxeUpjN0Vqd09hSW1DRTRjajF4T29kNENLSERYT2Nv?=
 =?utf-8?B?b1A0SDh6S2FyK2hJT0NTYkVRTmtWc3JQUkZyQUJjeitVb1RRQmNWVHhVMGZC?=
 =?utf-8?B?YkNlS3VReVE0VzJ5ckMwT0ZqRWs3ZVRFOG5LQS9NNERJWnc4OGNsb2J5SzNt?=
 =?utf-8?B?d1ZVQjZQaU94UDRIMUxYY1pIcFRGcU5FVFNBSG4yT1RSd1NZeTFmMHE4L3pI?=
 =?utf-8?B?KzBwZms0Uk1VS3VBbUs4KzdlcnYwTnQvUTVKS2tzdWZjanJINy8raERYaGJu?=
 =?utf-8?B?cHhpZG85TkxrRzlWUkV3VTZuU0xlSmk0Q1NlSE8xSWp4M3c1YXI2bUc1S1pO?=
 =?utf-8?B?NzVrY2NWMG95Qm9kODZOZDBsRVJRMUw4QWlsRTM4TkFidHV3THIwd25heVZO?=
 =?utf-8?B?UU1RNUtXZlkwYkpwSk53R3UyMnU2OVBJMTgwbTU3aXQ2WW1qMERXOVF3L3Bo?=
 =?utf-8?B?YzRFVHlrSzkwem5henMvRkdJWlNwVWlEVVJGMDkweDdyTXlPUld2UlZ3VnFs?=
 =?utf-8?B?dnN1Mjh0UCtwNVBRbDI4a1hodkxybUdnaWkwMVErcUhDZXU0QVg2b1NJbC9p?=
 =?utf-8?B?MW9sdWtJRE45SmlXT2psdnBXdFFsS1BCSVc2QWFpT0pQVHM1bE1ORTlSWXpi?=
 =?utf-8?B?Skg5K1RVNklxSWw5dEJjdTNMVVFpeGtCYy9lK0haY1BUMmtkUU1lTmtWZU9Z?=
 =?utf-8?B?bVpXU0k5OVJaVGVnVVM4U1V6djFaWmR5SXRFL3dMNU1RVUo0ZkhlSDdGQUM3?=
 =?utf-8?B?Q2VlV05DMzlTd3FhT0RDeURtTUFrYnVyQmNJaVU3d2hydU1QNHlrN2tWbVM1?=
 =?utf-8?B?b1p2cDl2SjFXaGk3dm5LbDJ1eW41Vmt4cU5jdkpIT0ZGY09lc2xHNkZTb3FH?=
 =?utf-8?Q?wIMQ9K150LogQQJ2VPX22iSsCj4+XmHSxbQ3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGhUV2I1TDQyeW8wdVR1a0gxaFg2R1lIVmpHYmthaU1xL3daNTYyQTJFeWY0?=
 =?utf-8?B?cHJkcXcyWDlaSFFMK3RLV2R2YjkrMjRmOEw1bUtXTjJNbjczaDNuanB1TEp6?=
 =?utf-8?B?Qjh6dU5aSGIvV0xrQjdBOFJZVC95MTI3QSt3ZG95azNOVzVscGtRWXVOTDZS?=
 =?utf-8?B?NFE0a09HVnRLK0ltajJBNE1ZNDBnblExMkEzUHZzbTc1a04zaWZHcmxIZlhH?=
 =?utf-8?B?Zkx5b0N4dnJxbEVjVXB4eWJWK3A3R2liMGZyTzVzL1RLQjVlekdZTDdyblRE?=
 =?utf-8?B?eDgvaE1FY0svRXkxS1R6V0tyZzRXNG1vWXJLZHVjWkdSUnRuNFNWeTM1cDJT?=
 =?utf-8?B?YWpXZU5GcnhZUWcvbzFHR0F6ZVJBLzM2eGZ2MUU1SmM1RWk0S2RDd2tDRFBH?=
 =?utf-8?B?Sk14MldkdlpqSEhoV0lHaHlRZ2FyRFJQbnRSdENnSGt5VWlPL2o1SkQvL0do?=
 =?utf-8?B?SG5zdmIrdHp5d2RmQ21GVTVhSWg0OEFNa2IrbG9Ic0syV0dpRmlDOHQ5Y1Fq?=
 =?utf-8?B?SVEwZlBMY2djYW1DcCtrRVFnYXFaOWw0WjdHVzZIQ0hhVnRPSkxUN3ZkdTNQ?=
 =?utf-8?B?bVEvY3VGejdCbExKQXFUNG9WTnhqK0lBZzhNMTdnSURqMVVybEIvLzF6UytW?=
 =?utf-8?B?SnhSNmoydEVoZ3VaU25LYWJFSGF4WmV5Z2NSbm5CdmN6ZzJRNWliSG83WUVn?=
 =?utf-8?B?Mnd4WGp0bll2QU55REFRWWtXdWc1ZVhWaHF3bDJtSFo0QUxSSVNkaU5Zakhs?=
 =?utf-8?B?MU9RdFVrRlloanBzdElLejJ2ZDRTdGw2VEozQTJVTnlLM0h6amF0ZGVZbFpo?=
 =?utf-8?B?bDQ3a29RVkZ5OFRYOXZheURFMWNXd2dYb2VSZFIyQjJSMUZ5Uzl3aUMvQWpx?=
 =?utf-8?B?M29MS1hnSk01RkhkaTZ1R096aEsySTNJM2d6MUtsNndHOFNBcFZDS2tXZEVV?=
 =?utf-8?B?OWhVbHVEV2VtMWRqSzlqZEx1RU9FQWxic2VlZk9QNFRObU5UYTY2OWtrOHBU?=
 =?utf-8?B?dGVLZkJDNk50UmgzWHhvNFF1RTZKYWE1L1VWK0VxbzdiczJSYW9GeXkvTFJw?=
 =?utf-8?B?RTRaSkExVmVkQW5uOWlLODRqaGxpcFpFdVpibEkwMTV0NklvdG10U0VDbmZi?=
 =?utf-8?B?dE9ZYUlHNG1xUytkRUVkbk9tc0lLVkRNd0l1VEVWZFBLVG4zeFlaUC9vWWxt?=
 =?utf-8?B?MWFYeGd3TjZ6YWd3K0Q2aHBCWmh5NXcyMVlhUFJ0anora2kyNGV2ZXEyRTYz?=
 =?utf-8?B?ekR4ckpKZ2NvSUNmQ3FQVDVYOFpXdDhMTDlwU3lTaXQ4ekNQYi95WHhucXpi?=
 =?utf-8?B?ZDl6ZllXS2pES0VUZU5xWFBFZEt2ZEV0aCtvSFRtR09QWkVudStYeTJwNHpY?=
 =?utf-8?B?Ky9Tek81b0lZeUpYRnVwSVV5eFVTUzhvSy8zQ0VBM0MxQ2ZHbGFyWnlxbWxQ?=
 =?utf-8?B?S0lBOEs5WjJMUjB0MUo5bi9YT1c0dS9ITksraUNQWURQck1VSERxZXo5dTgr?=
 =?utf-8?B?Ty8zUEh1cCtLMnRKa3ZQYmk1dWNDalVIeUVrSGZhZU92N255OHZqTWcxNDNJ?=
 =?utf-8?B?RUUvUVdlVFNCNDUxMW51d3Mwc090SWRpMzVZTjhhWXA1enJiR1hxT2tlZnVP?=
 =?utf-8?B?N3h4S1ZibmpJTzU2MVUrbkRkR01ILzZwcXpKMmZEMDhYd3NXWXJqUnpHNC8z?=
 =?utf-8?B?Q2xBb1RQMW1yeHFXVDZGZHNjRnFVL3B1THFoRVFSZ2ZScFhpS0JWV0RQbjQx?=
 =?utf-8?B?WXJkSUR2Nm96bFN3UXpLTStKVDhQUHorY040L1c3ZVhuWmVNNi9KcGtEejNK?=
 =?utf-8?B?Mk9rWVhXaHpnWWdQVXlIUFJIemE3WU8rNGZveFp6YTZqSE8zZHN1eHVGU1g3?=
 =?utf-8?B?QlVWbGxENzYxeGRTRkR6cE5EQ3hPQzRyVHZXVWExRDdZSTI4S3YxU2E0V0JB?=
 =?utf-8?B?eGRBeTIzMkV4TjBMMlJSNUUzUkgrRWV1UUl5eHdmYXFzbXBubHBUSitMbUVL?=
 =?utf-8?B?OVozdmo4TnNPQUZ6Q1RGMmNPa2NCU1B5S3NnampUakhDb0lka2U5VlFtcnVS?=
 =?utf-8?B?ZVVTVmZwWXp0dkZ3cUVtV1JTSDhpbGZ6ZzIyRHRIb1Brb1U0RXVMdDZvM1ho?=
 =?utf-8?Q?1qI6u/gTUdepVEzwN0LpfTvFL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ee446f-a789-407d-1286-08dcf43f571a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 15:20:06.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Tg8aUDldKzFHKTbCMdeoQRT0gXuMhxV9jNhhF2itMwbA4kcn4g+M5cG4t4g39KOJyhoiznVTMkMdknjabBxNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181

Hi Dan,

I added a question below.

On 10/22/2024 6:43 PM, Dan Williams wrote:
> Terry Bowman wrote:
> [..]
>> I was referring to reusing separate instance of 'struct pci_error_handlers' for CXL
>> UCE-CE errors.
>>
>> One example where it can be reused in infrastructure is in err.c's
>> report_error_detected(). If both PCIe and CXL errors use 'struct pci_error_handlers'
>> then the updated report_error_detected() becomes a bit simpler with less helper
>> function logic.
> report_error_detected() is concerned with link and i/o state
> (pci_dev_is_disconnected() and pci_dev_set_io_state()). For device
> disconnects, CXL recovery potentially needs to span multiple devices.
> For i/o state, CXL.io could be fully operational while CXL.cache and
> CXL.mem are in fatal state.
>
> CXL considerations do not feel welcome in that function.
>
> Ideally a PCIe developer never needs to see or understand the CXL error
> model because it is off in its own path. In other words, if someone
> maintaining pcie_do_recovery=>report_error_detected() for the PCIe case
> needs to go find a CXL expert each time they want to touch that path,
> that feels like a regression in PCIe error handling maintainability.
>
>> But, it's not a reason by itself to choose to reuse 'struct
>> pci_error_handlers' for CXL errors.
>>
>> Looking closer at aer,c shows there is no advantage in this file for using 'struct
>> pci_error_handlers' for CXL errors.
>>
>> If I understand correctly you want a new type introduced, 'struct cxl_error_handlers'.
> Yes, mainly because the bus state and the result of the recovery tend to
> be a different operational model. If a CXL error fits the PCIe model
> then it can be sent via pcie_do_recovery(), but I expect that only
> applies to a handful of correctable errors like CRC_Threshold,
> Retry_Threshold, or Physical_Layer_Error. Almost everything else *seems*
> like it has a CXL specific response that would confuse
> pcie_do_recovery(). 
>
> So, in general new operational models == new data structures and types.

Would you like to continue to use the pci_error_handlers for the CXL PCIe 
endpoint device driver? Or do we change the CXL PCIe endpoint driver to 
use the cxl_error_handlers ?
Regards,
Terry


