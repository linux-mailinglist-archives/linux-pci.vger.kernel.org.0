Return-Path: <linux-pci+bounces-26693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D0A9B19B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324137AED4F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68A72DF68;
	Thu, 24 Apr 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vGxkfWhN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3662701C1;
	Thu, 24 Apr 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507022; cv=fail; b=HSQ88dGfk/QWs/OEHAKVma7OSiaxwlrHQyuT/iCP9GUXMX+akaEuz0kNwi4HHFfNMkVx/XffKsK7A0eW3yLM8ENPQKhzJtgm6hh3I+7aFq13n+euqkW76y5AukFwhwNZY5zfXhT0GmjyTp3+8qooIERY29nQJaV3MiL49Sa+O7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507022; c=relaxed/simple;
	bh=FX3pvY0ANxIGB1Qau0Iwv8v3A2oNTW39YUZdlc57Sto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqF6YpA+/0B+I/xq2PmJKQWXs65kKGcouR53JteUMw7hexQa7JT4InOy9YI/MYyz5wXZtTbstog/kpg2Wk/cjYXnWKB/3FUrmUKv2KyGKwTycTvh93bukBPyZA9ACKirVg3HdGGAHnaRKt4eSjMD5q0t1xt2qQN4pB8Y3tcsW4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vGxkfWhN; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGhYapIzTuGMS6Yh+pNsW2Nwr9tqx5GppCN8DpiqdDIoVcziT3dIDGsHe0d3Z9EJjuJI7wSa1T/g1c9t7VNxRMZ4xacFptl+8K7vV/wl0Mw+P/MTDELN2XTSmTwFL9iln6nzO1vk/CP+U7XX1OONXmp8+ahZcMM7aIkhIXHayVBlsL0+Ul9ZAKwS/do72N/bSVOvykX81Otay01bpw9k4dHS+AH4RUGb0SG7iN6XOC/1o+i7MDPFNxFIplnURmex/Bt6/IsenmDdiQ2IQkiDoVXA3QGop1b9zGTIhqlY5I22H3XpOQon+ZZf1DA+Jm5De9mj7KrdlIufY5TZICuFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UooQFhtokQnRxkeXSNMalEddp93mvipXw1u8FPMmuN0=;
 b=RFSYFEuPdIZ6sKlzMRmxPjhXd5jSRYWdxYZ7NlswVppue41KKtQJXITukPwmkzaWh13ge7oN3jw0H+43Uk4ffg3RSqPY+gs4UW/zBhIebMrL3ZNa4AfTNmCPArQvX75H6+kY8lAJ6VMrsy2ZIkXBy9k6yR6uDV9mhZtGxT4e2KZKmUqZsW1zlPlS7SLRRf1ff2o/Ywo4kvKiaq/8S6K6Pmp4Jrkz+E9u9zlz7IA20peX5DT6bSkaQ5WCa9ka9yvV6JSXKC7yRxysjrJHrCkuFi/Yr8w7LWLetpDMZRh9hMnyRRfCOlP1af3oUEKyvsbAZQOCuWHo+AL/tC9FCVvbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UooQFhtokQnRxkeXSNMalEddp93mvipXw1u8FPMmuN0=;
 b=vGxkfWhNXqTfuf668O3cyA+ks487nTWkt9UHaZ4kHzWMIcCY2Qya7Cfxju3/pkPW+g6CyBNUpDAblpd3AzScRcUrIU/nU3IQhB9nJY3/Dlj8E2HJesOCgZ1oMUb8zC4KdZTPdbWTHOsK/WouHZlrR7ii+6AePWt9u4LqFpDT1Uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA5PPF3C36BFCB5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 15:03:35 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 15:03:35 +0000
Message-ID: <1a355946-8a5f-46b3-a8bb-37391fab304b@amd.com>
Date: Thu, 24 Apr 2025 10:03:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/16] PCI/AER: CXL driver dequeues CXL error forwarded
 from AER service driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-6-terry.bowman@amd.com>
 <20250423172842.00002c40@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250423172842.00002c40@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:806:126::15) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 1864af04-b7c9-400d-ddb9-08dd83412f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1BjUU1vbnZoYU9WU3o3RStzNWxZbEEvYlp4YU9ndk90eHRaeS81bk5BTms1?=
 =?utf-8?B?azk3WTd0cXdkbklOZXdnM2k2WWFwRXNmYlFSYXI1VUltMXNKaGc2VW1mUGR5?=
 =?utf-8?B?V1ozMVVTV25RWFVqcG1XZXhSUFpzc0pMTFJ5NVpMV3FhaytoZ3hUZ3l4OWk0?=
 =?utf-8?B?bXlKVGZkSTNjL2N1ZTVuVlkzVzJ6cllLbHowQndJaUYvM2ZsWStuTnFwb3Yy?=
 =?utf-8?B?TE1pZmRGbHBRVWliS1dlcVZkNDVNTkNZZkhtYXZ4QS9Nbm5ETVVVN2JVMlgy?=
 =?utf-8?B?YVRrVkFYUHdZOHFLZTkrQytzNzErZExWQTJrU2Zhb3FpTWx1SE9IeGNybnBE?=
 =?utf-8?B?WWtvdElZRmg3QWFqTUdkMU1sam9TL0xDN3R1cUFpQ0luWWdybFNkazQzOGEz?=
 =?utf-8?B?akVnQXViYlR0Z0RBNGhOVDV6b0YvRjFCdzJVd0o0K0dpOHJpYnZTbXcvYnJr?=
 =?utf-8?B?MUdBWDlEN2FBUXB5YnRRU3hZcThqUjU1R21aYzF3WVFvU3dMN3FVbHBLa3pr?=
 =?utf-8?B?R3p6K1l5UGxOdGZ3ZFhCTng4ZTZ0NFpjQXlFc1l2RzRJN2dKbkc4dW9VT3J2?=
 =?utf-8?B?dG5TNmZVTEtzbWhqYXVXMk9ycXE4WUNoNzBJcTIzVXBaaVF3bm1HT3BjVThF?=
 =?utf-8?B?WW5Qa25Bd2xEQUhvOGgwNzlIMUFpNWtSNUNFRDZPajF3VllLNWFUaVQwRE1P?=
 =?utf-8?B?TXpxdTNKYmY1R0x5ZEpxaVRIOGxYa2xrOVBOMEtuMzhjWG9xNUNzWkFiS21m?=
 =?utf-8?B?NllZUGpVaWk1K3lQektqejluRlFIZFo0UGRUUStxZ0FQM2g4U0Jrd21lQVZT?=
 =?utf-8?B?VXNoaHBtdWVGbVg5U1FGeXdMQzMrSWRIMjRnRUdab201c29SMmV4N0l4OTJC?=
 =?utf-8?B?Um45NDZQRkwzMG5QbVlvUysya1V3U2xKRFlhR0dBdGVRTWk3bXlkLzlsYzBV?=
 =?utf-8?B?MWlSQzY1UHQ1NFNlY1luUzhiUnJXSDVyRGFwc1ZSVXFqRGFwcEhCbzdhbHNs?=
 =?utf-8?B?ZXZvdGxuTHFEOUY4bzU4UEcyc3dubjlLaS9PQUVTVXZES1BqcEpxZWg1REJz?=
 =?utf-8?B?aGx1S01ZSkZDd3JjTFZQWjNYQVAvSk9aeks3ZFRGVUR4cXFtalRCWmZ4TmdN?=
 =?utf-8?B?UG5rQVZqV0pWNHJQSHpCUmZtVlJYY2tsdE95OUxYT1lEYytob1lmUEVtbzJx?=
 =?utf-8?B?NWxqWDBmZEFmSDVKaGgrSTBuUnY0bHhtRXBNcVJjcHZZUTMxOFhBdVJ3UmRr?=
 =?utf-8?B?ZjBaNUNHaEFNeUV0Q1J0WmpOUzQxa1AzYVhpMmxTeGdueitQZ3Z4cFplSFBt?=
 =?utf-8?B?dzRWSS91ajA4R1EvZUR1aVN3bkNKSTdmU3hkL3VvM0oyQzJ0TjJxTDU2STE4?=
 =?utf-8?B?ZjlGdTZjVjd5L3dVa3NhdzNnWElqWWRDZU9qRFJtSGNGYWZ2d1IwdXcxcVB3?=
 =?utf-8?B?eG8rZy8xS3hyWXF4dGttbTlYTzREdlVKc0N6VUdMUTUrakN0eTFSRFNhL1dE?=
 =?utf-8?B?RXR1RVI2QUI3WHJZaFBBa0NKNUNUcUJjeXNDNVpmQUh4MCt1QmwrTWptaExF?=
 =?utf-8?B?TGxwRGV5R0k0ZEJ0dGo4OFBSV0gzZmdXYTdTajUrYyswNWZsamJrT2N3RmFU?=
 =?utf-8?B?UjZJeUxsNTA5NEg4KzRsZkZDby90cjkweHdmSWV1cXNrdjMzcmpnRCtVR1NZ?=
 =?utf-8?B?T2JYL0Vka2wvSDJkaVpnZGZoT2N1cHpvK1pxZVZqZ25QVVB2RU9uNFpjL1c2?=
 =?utf-8?B?WGFOZHpzOWdzdlREWFFDczVrZlMwM280VFlMWHZuN1k1SVJ1WERIcDVsUzQ4?=
 =?utf-8?B?QjZOV0lKdElBbWR2QXRLTzFQNWdaaGVRZ0tMU1liZHdwSEEvQlhCem1vclZu?=
 =?utf-8?B?V3ljSFE0RTJEdFZsUWtteCtSdUhEWHVxTEhMREZBQVQ3dHdoSDNRa0NNWjlO?=
 =?utf-8?Q?r8njlcxzj9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWlZZjl1dHZ6NitsWFpWM3l6UnhSZVQrbnYrcmM0WEsrOXgyUTJXN2JYTXdV?=
 =?utf-8?B?a3V6NTRIdTVHNVVVd1FrQ0FOL0U2WlNYQ0ladVBFS2V6NnVrUFpxTzJCUllq?=
 =?utf-8?B?MCtOek5jN2p5Um9nU0FZeFZyWDE5UkIwYXlFSm5IU0lHL1Bydi9lWmttQXVJ?=
 =?utf-8?B?Ly9EbzBpWXUxd3VYNGdueVVaTTlvbkxXaWVmZXE2amdoSGs1SUpwTlZYK3RC?=
 =?utf-8?B?RHlOSHpBdmt1bXo3Z3piUGp0WlJ5RVdwUVZLT2ZtQnpwU05SUFlCOGprRTJ6?=
 =?utf-8?B?TkJpQVlXRk9iTkhTTUdObWpVck9qQUlZVzQydkdQL2g5SkNhMlBTbGhNdzg4?=
 =?utf-8?B?UVJxUXFUUjR2MUZlOUVMUE5jdE1tb3hwOHA3cGhRZW9oTWFmUkNpZnhyM1Jl?=
 =?utf-8?B?YXdFS0FFODlweFdnUG5zTWtEb1BiUHFYZEorN3l4ZkwwYzJpTlQ1NGtoMjRs?=
 =?utf-8?B?SDlSNUhZVENZeFZ2dzYyUTMvMXZPVzBlbmVRTVFLWmI3Mkxoc3hFenhRVXp6?=
 =?utf-8?B?R0VJamZTcVVNbkthSDQ4c09POWkzT3o2cWowaVNCc2N4VFVPUjExR1BQRmV2?=
 =?utf-8?B?amxLY2h0amsxTUJOV1NNOGRFdW5BdW4rUlZYcVBaUCsrSllLR001elJ6V1JG?=
 =?utf-8?B?TExhaU9BSmlhVTZJY3FBSS83anYrT1RSb24rV044SXYxalRtV2VWVm1kVTBx?=
 =?utf-8?B?SXN2ZFlDNmlTd3Nlei82TERNMFpXSzNEdlduQmIzUUZNVkRkbmRJeXEvNzNU?=
 =?utf-8?B?YmVEenpaOFdUbDF0SXk5QVJWQndZTC9qeEJyK3NBcDdaK2ZEdWQxNU8ySmJl?=
 =?utf-8?B?b2pqMWswRGlhalRhREdBQXVBdlF3RXJCZzJxZHA1YjZiS082R1p4UG1mOGc0?=
 =?utf-8?B?MnRWSjVPZHlac3lCbTZLbHc4VGdpQU9QS3ZwVERSOFl4VHRVVnpNeXAvMUds?=
 =?utf-8?B?M2pRY2g1ZHpOV3ovRmorZG9vM2dUQ3pTNk1pcE5MZ0t5cmkvaDE1V0NTZkdM?=
 =?utf-8?B?cFFWeWRqSHdPYWo0ZFdvOEVFd01rNXpLMnVBWStPQm1VZ3NTVlR5WXUxaTBp?=
 =?utf-8?B?OGc0WWVRcUNRQ3BBSVAvWHdxcll0ZlVobndab2xFeVV0VldCUUkrRTJMWFo1?=
 =?utf-8?B?bThUemFET1liaGNqblBxTUlvTnBweElJajQyOEJSY2JPSUZrM3ZndjZDL05l?=
 =?utf-8?B?NUxReFpKS3kva1lQSFgwMWptUk5MRDhXWEdjeDR3NndZc2ppOXFmdHdBblRJ?=
 =?utf-8?B?Um5QU0dneEVQMis0WnN4c1dDSE5pazRYUE9jUHVBbjhlTHlmZFBJOGNraUQr?=
 =?utf-8?B?YnMvRkdFQWFqUTZUcUJOYzhqNnNnVnVKUERmTjM4SmJZR2hSdTlkS2lOTXl2?=
 =?utf-8?B?OFFFdlRWVzNEKzZURkpZeHpibFdoeTJuOVpEQytNYUtpR2t5VVhOQnY5S2tK?=
 =?utf-8?B?TXVvWG83Vk1vMzVqenY0bHp2SlZPK1NNTlE3K2NNMENvZ1hrR1dyZXRQbG90?=
 =?utf-8?B?dWticE1xeUZ5aXQ4V1lLK2M1NUNmczdXcFZCRGdKK01hWTh3SEdWNXo1ZEd1?=
 =?utf-8?B?K2ZoTGZGZ0U1YnN1MTc2OUhxYjkxcEJjMmpud0hVVTc1Z2k0RDU3YnY4ZzZB?=
 =?utf-8?B?MStVTzE4QWhSNE83V3JGZW4wMHJzUG1qRjRlcjdOak5oNXJDbGVDTm1tM1gy?=
 =?utf-8?B?ZFppQW9CSXlLMXJ6bVlNN1hzQklic1VIbUNwckdPNDBaeFV1Q0cyWlN0Z0h5?=
 =?utf-8?B?aWxpMFJqZm0vTHFiaEIraWZneEtJcXBObUpKWU5QMisrMHFmaXJ1aktlY0Y5?=
 =?utf-8?B?bDR0aklUSnVUZGlRc2NLbUlTdVdKQmZLS0lpRnlNUVptT2JWcXV1S0JUNHcz?=
 =?utf-8?B?MTZLcU15SC9iV0ZyaEZEc2FOVlN1Wkx2MVRTakxoMDlLamRNb3EyUlJNdDNT?=
 =?utf-8?B?bUp5WlZ4eWpPYWlqcit3Tythb1ZUZ2dHbU1vQmJQZU9hNGx5di83SzAyKyt4?=
 =?utf-8?B?bW0vMzZob2NETkQraVg4Z01XV2xKZjNDVnB0UDdwcC8rYk9tbWprUGovZEV6?=
 =?utf-8?B?ZjRWeFZXRWs4UE9iRjBLbkhSaDlMcnZpT1RaOUNTWFllRG5idGNpYytrc2xU?=
 =?utf-8?Q?Jpf6sDUT+VVytTpiGowIweTnV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1864af04-b7c9-400d-ddb9-08dd83412f5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:03:35.1005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJW02N1F1OJnR0+88GHTCnWIXhJaM3grgCzaRMeUjmDYOqVhMbFP6JsD9JNG7B4JcPMG5GKsLyQAhjWzDC3nUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5



On 4/23/2025 11:28 AM, Jonathan Cameron wrote:
> On Wed, 26 Mar 2025 20:47:06 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER driver is now designed to forward CXL protocol errors to the CXL
>> driver. Update the CXL driver with functionality to dequeue the forwarded
>> CXL error from the kfifo. Also, update the CXL driver to process the CXL
>> protocol errors using CXL protocol error handlers.
>>
>> First, move cxl_rch_handle_error_iter() from aer.c to cxl/core/ras.c.
>> Remove and drop the cxl_rch_handle_error() in aer.c as it is not needed.
>>
>> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
>> AER service driver. This will begin the CXL protocol error processing
>> with the call to cxl_handle_prot_error().
>>
>> Introduce cxl_handle_prot_error() to differntiate between Restricted CXL
>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>> RCH errors will be processed with a call to walk the associated Root
>> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>> so the CXL driver can walk the RCEC's downstream bus, searching for
>> the RCiEP.
>>
>> VH correctable error (CE) processing will call the CXL CE handler if
>> present. VH uncorrectable errors (UCE) will call cxl_do_recovery(),
>> implemented as a stub for now and to be updated in future patch. Export
>> pci_aer_clean_fatal_status() and pci_clean_device_status() used to clean up
>> AER status after handling.
>>
>> Create cxl_driver::error_handler structure similar to
>> pci_driver::error_handlers. Add handlers for CE and UCE CXL.io errors. Add
>> 'struct cxl_prot_error_info' as a parameter to the CXL CE and UCE error
>> handlers.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c  | 102 +++++++++++++++++++++++++++++++++++++++-
>>  drivers/cxl/cxl.h       |  17 +++++++
>>  drivers/pci/pci.c       |   1 +
>>  drivers/pci/pci.h       |   6 ---
>>  drivers/pci/pcie/aer.c  |  42 +----------------
>>  drivers/pci/pcie/rcec.c |   1 +
>>  include/linux/aer.h     |   2 +
>>  include/linux/pci.h     |  10 ++++
>>  8 files changed, 133 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index ecb60a5962de..eca8f11a05d9 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -139,8 +139,108 @@ int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
>>  
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(cxl_create_prot_err_info, "CXL");
>>  
>> -struct work_struct cxl_prot_err_work;
>> +static void cxl_do_recovery(struct pci_dev *pdev) { }
>> +
>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_prot_error_info *err_info = data;
>> +	const struct cxl_error_handlers *err_handler;
>> +	struct device *dev = err_info->dev;
>> +	struct cxl_driver *pdrv;
>> +
>> +	/*
>> +	 * The capability, status, and control fields in Device 0,
>> +	 * Function 0 DVSEC control the CXL functionality of the
>> +	 * entire device (CXL 3.0, 8.1.3).
>> +	 */
>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>> +		return 0;
>> +
>> +	/*
>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>> +	 * 3.0, 8.1.12.1).
>> +	 */
>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>> +		return 0;
>> +
>> +	if (!is_cxl_memdev(dev) || !dev->driver)
>> +		return 0;
>> +
>> +	pdrv = to_cxl_drv(dev->driver);
>> +	if (!pdrv || !pdrv->err_handler)
>> +		return 0;
>> +
>> +	err_handler = pdrv->err_handler;
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		if (err_handler->cor_error_detected)
>> +			err_handler->cor_error_detected(dev, err_info);
>> +	} else if (err_handler->error_detected) {
>> +		cxl_do_recovery(pdev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void cxl_handle_prot_error(struct pci_dev *pdev, struct cxl_prot_error_info *err_info)
>> +{
>> +	if (!pdev || !err_info)
> Are these real potential conditions?  If so can we have a comment on why.
> If this is defensive only, do we need it? 
> Looks like the caller below checked pdev already.
Yes, these checks can be removed.

>> +		return;
>> +
>> +	/*
>> +	 * Internal errors of an RCEC indicate an AER error in an
>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>> +	 * device driver.
>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>> +
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		struct device *dev __free(put_device) = get_device(err_info->dev);
> Similar question around lifetimes. The caller already got this. Why again?
Not necessary. I'll remove.
>> +		struct cxl_driver *pdrv;
> calling a cxl driver pdrv seems odd.  cdrv maybe?
Ok. I'll rename cdrv.

>> +		int aer = pdev->aer_cap;
>> +
>> +		if (!dev || !dev->driver)
>> +			return;
>> +
>> +		if (aer) {
>> +			int ras_status;
>> +
>> +			pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &ras_status);
> If we get multiple bits set in this register, can this wipe out ones we haven't noticed
> anywhere else in the handling?  Bad tlp etc.  Maybe we need to ensure this only clears
> the internal error bit?
Good point. I'll fix. I'm going to rename 'ras_status' to 'aer_status' as well.

>> +			pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS,
>> +					       ras_status);
>> +		}
>> +
>> +		pdrv = to_cxl_drv(dev->driver);
>> +		if (!pdrv || !pdrv->err_handler ||
>> +		    !pdrv->err_handler->cor_error_detected)
>> +			return;
>> +
>> +		pdrv->err_handler->cor_error_detected(dev, err_info);
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(pdev);
>> +	}
>> +}
>> +
>> +static void cxl_prot_err_work_fn(struct work_struct *work)
>> +{
>> +	struct cxl_prot_err_work_data wd;
>> +
>> +	while (cxl_prot_err_kfifo_get(&wd)) {
>> +		struct cxl_prot_error_info *err_info = &wd.err_info;
>> +		struct device *dev __free(put_device) = get_device(err_info->dev);
>> +		struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(err_info->pdev);
>> +
>> +		if (!dev || !pdev)
>> +			continue;
>> +
>> +		cxl_handle_prot_error(pdev, err_info);
>> +	}
>> +}
>> +
>> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
> Ah! Here it is... I think this can be in patch 3. With a stub of the function
> (which is what the patch 3 description claims is there).
I'll move it.
>>  
> Jonathan
>
-Terry


