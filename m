Return-Path: <linux-pci+bounces-14810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7C49A28BD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D0028952B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD701DF263;
	Thu, 17 Oct 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xb/EWgt1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC711DED75;
	Thu, 17 Oct 2024 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182415; cv=fail; b=gnLFFMK9Lk9BwZR1l/hC46FdEn/R0QD6nJpBUfwMtsl1mA6/H6BLhZXAmVRlYvrDIvT2CURr1Z/VYmMNu60+cINPVNLNOv6ST8czHELV0O3Eyc+ER2mSdBX5mSt/wyeQ3WAVSdb2a2tdkOG0LID/qOI6x/Sn3swnGr4iaJVbfGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182415; c=relaxed/simple;
	bh=18SD88F0MWc4jNlx2ZqbqniM4oWY2CXdt8tKXU7aEDk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RthawvwYbbJwvBvswkUx1QXqn4YOm3UK3nedeF9Ps/wLs7Sz5iM9NRU9F5Jiv8Sjwa/+vtPFXRGSbBZIknRhI3o0+QAgy53wC7DWZqrpq1Dh2TrCFmpxUnfdyENKFGozJ5vc6tXYAzvt1FqfvYPmS8psm+4m46Adq0qOGLG445k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xb/EWgt1; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIuUEenyUl5a/crHRw5CrN1nNR79MyTYVFkTo3IcwuYwrnDYwMymXtP+NP4C/lYdGnVoSd3tnzLAwWrew8X3y8fINKjTk5M3sDHlYjGFShwaWJK9/UWLN2YVV0P9T3XFBTpOwckunrqWpQK/BDwaNSjwlbO5u0TCl4MGI8OmqzRKu6Dxp+RnVYYSv3wUaHNHWCREk8hws2UB0NhWJpTYbIX0hZDfQliWs2rO1iK1L9p1ckntV7xyRW9TMjuf4fQ0UlCUh7nY+nBXfkDl8GsGY9FLlRWSnmgPEC7sx4ysS9rbaIAVisK3gT2qCt7tXnHczp7bdLQ8yS7Ll8TnlsvWWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4KUU2khQNdFl+E2fwoGkot3U4xPB2cfdacT6YvIggA=;
 b=pTxHVsR4THRvQqwPJ1opEEn0i6zpw1OU1aNRLgL5y7jAL+7Kp/fPJaFoe8jtrrnaGAng1usZyfZsm+gj8VBqqrRcKAXdaQ3F+UbJMYLEKSWoFz5ff4yJ+lXIfVjdXIz69O+M1mye6qQVn87LMyEkhiZhn25ItUlfo50LqLrp+Iyduix1vJpB4xlqKQ7gjxbtlDVjSGZ9VMdx1jGQQailefSskuy/PPD3oH9oAt8H+a467J8S6xGNz6MZGYAeEQY4EWpvF6gLD+hNVuiOZAiduBx8LOQhoSvzOlUBuKhFZsd2e/hbX3CnzSQIfnxWvapX2/a3kSZRoe8is5tnbdnMHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4KUU2khQNdFl+E2fwoGkot3U4xPB2cfdacT6YvIggA=;
 b=xb/EWgt1gwZmZLYW37xjuB0k7PewlGyxuLNDgjBleyFmSOogr85ibnrodLfWDlFhUaABJLft+8UgyLWPw0qHvvTNaP03d+xuLNjKjAZoWEU3eQ5HjA/HYyh8kel/KY5Nzbfa16N0aevj/RBix8rirVUmn9kmwpr6qFRZ3Gnz9KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Thu, 17 Oct 2024 16:26:47 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 16:26:47 +0000
Message-ID: <20ccf961-606d-4247-a4bf-b53d5ea4a05a@amd.com>
Date: Thu, 17 Oct 2024 11:26:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] cxl/pci: Map CXL PCIe downstream port RAS registers
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Terry Bowman <Terry.Bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-10-terry.bowman@amd.com>
 <20241016181459.00000b71@Huawei.com>
 <4a298643-28f0-4aac-be2d-32b8ff835e2a@amd.com>
 <20241017145025.00002fd3@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <kibowman@amd.com>
In-Reply-To: <20241017145025.00002fd3@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:806:6f::19) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 797558ee-beed-4689-ce35-08dceec87f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDM3TGJVazRVU01HcWNqbGRNbHBBd3FreTdNa1Jtak90YklUcnN4b3pEaVRv?=
 =?utf-8?B?ZFpiSGk4VDZkUlZvNDhQbE5oUzRveFFjL21wem50SU9Mc1RjYjZHT01KSzQ5?=
 =?utf-8?B?ekZjSDZ5S1pzUG1udVRXanp4SXNnWTVnK3ZvWCtoSmtCUjdKQXIxQ3dVdGw0?=
 =?utf-8?B?M0Z1aHBCdCtualV4SnV6S3FzS1JPVDNBMWJycDZCSGJIeFZ6LzJkY1UzSmMw?=
 =?utf-8?B?cnNZZmNzdEJYelErS1JWbW1ld3c0RUhPTkYxTGNuVGFscXRWV3JCd25DRktk?=
 =?utf-8?B?L2xqM3oyckFrRjFGa0xmYWI2ZjNHNEpaeCtib3BhMHVQSUlRZ2ttdXBjUXZP?=
 =?utf-8?B?MS9tMFBmemZ3R2V6dGRvclczTE1hOWNrRDV1NUU5SDIzdHgvMkdTR003dENt?=
 =?utf-8?B?Vm1qTHlnSUdrL01qakJTZEhyaHM2SW5xdTlXU2JPUG5lVmNnZnZzLzE4TTJG?=
 =?utf-8?B?NVF0djdNRzZacDc1b1dlV3Q0TldtU0RaNk1FRDJ1SDZSQlNFTm1XY3ZoTFBr?=
 =?utf-8?B?enZ6V2FLNzBaZXp0RUdWd1lqOFduRnJUOWI2SWhLbUhJODFkN28vNFZ1VzJj?=
 =?utf-8?B?cGFZcDRXK0NLd0VZQVZlbk1SSVkxSEdUZTE3NzMyRHBCUk0wOHN4d0JRbG9P?=
 =?utf-8?B?bjFEUkg5ZTJlQlNiV0d4REs3S1F3UlV6NHIwR3ZKQWhRY0xBRWd2OW00MlRh?=
 =?utf-8?B?d3o3NTdkTERHSDc1T0pmRGNwamdhanJrUFRuVUR6a1ZNYTlGNUtoZUxrZk1Q?=
 =?utf-8?B?Q05WaGFTNmpEcCszeVk1RkdFazBIRG5EVHBvNEJVOTZvalJHc3lpTktFVWpk?=
 =?utf-8?B?dDY1QW14TmtuWklPMko1SFZ1VHNQUVovcFljbi9XZDJjS1lleGZVckx0VGtq?=
 =?utf-8?B?UUZFQklwSXgrcW5zZ3Bjd2N3VUNKb0V0NzVvczR1N1hnY1NydGNZcUJzZnNO?=
 =?utf-8?B?WkRCbFh4dC9sN0UzUlM5OEZ4TTVpOUpHMVlnQ1pyR2tJUDh5WWFiNEZ2N0wz?=
 =?utf-8?B?Q1V5K0RNb25WMTd6WWZvbFRpTEZMaEFWL3RZOTRzT1M3c0RtcmFhOXM3RTNZ?=
 =?utf-8?B?N0xsV3JZNTQwQWN6T3dFV2lBamc1eGVJVnNOMVo2Z0gzMDZ2N2pvc05LeitN?=
 =?utf-8?B?K0xSL294TmtBc0FiM3pqQWVrd2FNdEo5QURwTUZrUVFsV1JhRXRZQVJrVWs2?=
 =?utf-8?B?d0xWcUVXWktIU0xkZ1dtMnVjNExBN2VsZ3UwTHNwaVFXYng2MFl3VDdDVXpX?=
 =?utf-8?B?MGU2MlBnbXRJVXAzV2lVcTJLT2JCZ0RCdzRGZEk2dXl0VjJwWklsclB5RVlL?=
 =?utf-8?B?VWdhdU1DUjdWbXZTR1pUY1NtZlRTS0xPVVQrZEJkbGNzVWliWlJ3WXBNT2d3?=
 =?utf-8?B?S2Y0L2tQRlo1U1FRRDNTVTBzMWMvMlcwU0pKd0dSY09ISFBGSGZUVGF2THZj?=
 =?utf-8?B?d3pXUC9kTXdVRTBWVms4Vm9iYmtDREZ4VEZBUnlPNWxVUkhnNzdHUyswV1NO?=
 =?utf-8?B?cUt2U01VcHdmaFRVOCtyd1FvclBUVTNOODNRc1J2SWVlQ1ZwM1VGVFhTSEwr?=
 =?utf-8?B?Q1hpQytmd2M0VVVVUUVDMkVZOW12aUVNWHNsVmhKeGhPdWFDN1UxeFVOUWIx?=
 =?utf-8?B?STVtMjg5Z2kzNkJ0M0dVRXM5K3ZmbVpGTUFLeFk5cUM5QitPVzQxNWxqemhz?=
 =?utf-8?B?VTZ6ZUFnbUVhYzlDdFQvUnBoQzVRWURnU3RRUTBpQWg1RnBQRWlsbGMvRWRG?=
 =?utf-8?Q?RYjEad4tvHU1jWstYxmMFxV91/qNRV/6hPquL1D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHVGd3RQQk5DS3JGckt4bWZrSmxuS3l1Wi9EaWhKQk93dWRkZkdFb0UvVzZw?=
 =?utf-8?B?UHFQcm9GNW52QkVVakp2TURyTUVWdk1pV1hwZnp0dW1XWEpDalNJOFpOSXh2?=
 =?utf-8?B?cjh6MDNaZXRCKzBxUHFsK2VtR013bUdrLzYxczdRSmNUdU1CMU1iLzQ3NFMw?=
 =?utf-8?B?aFI0R2JtYWt3eVJXVDRlV2RwMU83VGIyMzcyWEg4QkRuNUlGSWpTZEphUjRU?=
 =?utf-8?B?ZWtsYzhoeUJjR3FmWDZLeXQ1VUV4Y29GVFVvYnh2M0ptZHBvaWlWLzNBMUJ1?=
 =?utf-8?B?bWlWUWFEcTE3azF4ZDJCTEo3NUJ1OXJMajMwTGxSekt0dkpzemJGbWJadFhQ?=
 =?utf-8?B?SVNwVlB1SHhCdzFITzNLa3JYVlZVcGZLL3hoVVkxcUNUaTVSQVNWQU1kOHlz?=
 =?utf-8?B?N1BvMEt3cGFOUXVvMkIvclVKVGI4cnZkWXhyWmNXZkd3RFBrWFYydWN6REcw?=
 =?utf-8?B?a05CcytOL2NqS1JoS242REhDblN5RVI1OTVUUnVMcXJNSFJvN2Y3enJ2QURl?=
 =?utf-8?B?cENFMGwxdDJWTmlsUXozTnZQUDYwYmdMVkxjV1dvR2hxYWdYODkvb0ppeHJi?=
 =?utf-8?B?c3NPR2dWWDljd3RhalNXMFphMTNWdGpJcjVZQVlPQzBkeUUwRk1QNzcvUEl4?=
 =?utf-8?B?aHFXdDJOWVFLZFJ0R2EvcG9Fek5kaEp4M0JNcW9Na25CQnNPRjVacXBNaFVR?=
 =?utf-8?B?VkpqSGhPWDRnaG1XM2RrNGtPaFFCaTU4Z3I3c3UwcjF0b3BKZ0V1WmhpVmd4?=
 =?utf-8?B?MnRYQjR6b1QzalhZOGxiV2grS1lUUVNTZ3VCSW9UeWxGV2ZKSzFPbXliaFVL?=
 =?utf-8?B?QXdXdUpMOEFZZFNjeFVPUFlUQXg0dThJOWlQbFl5c2g1TWhnaFVSUW5iRlFW?=
 =?utf-8?B?cUdmcktjRGI4NHR6MFZqUU9adVprdGpLN21aS1NyRmZ6bnFtMWJRMCtGWEk4?=
 =?utf-8?B?UHVoYldGdGNHWXZ2VTRPdlpGQ3c0eEQyM0c0MHdRQ1M2ZkptMVJWSmxYclA0?=
 =?utf-8?B?SUNmSVZaTE0yeTUxcndYMGNVS2Ewa01vR3JMdHVyUG9MOXQ3MWRrUjhkQ1RI?=
 =?utf-8?B?cnNqOGhXaWNDMkZ4ZzNNdFdhNXZPYmN6eS83cVU3bVczcEVMYURFYmZmUFZN?=
 =?utf-8?B?K0xLZ1Fhbm1DNk9zNy9aUVlyZGEvK0R0OEo5dmNSQldUVlV3L1haeDdDdkNE?=
 =?utf-8?B?eVUzN3VNZUZVQktZWiswa25Tclo1cThuV3IxeE9qMGZvZTE1SENPQ1hFeldj?=
 =?utf-8?B?TVYvaW5vUEJFajRPYWppcGU3NmFKZDVMM2VKZVV2ci93cW45SHUxSFFXaEZa?=
 =?utf-8?B?dUovdU9qNWVNN1BsTjZkTE8yN3FpUkpCS0RpaExGR3J2SVJ4cUlGVEc4bnNS?=
 =?utf-8?B?S2VBZnZId2I2QnYvZXA2L2tFQ28xUkxwei9aVUhYMVVlSGF2bHBQNG9VcGls?=
 =?utf-8?B?RVJNSzdtS0pQcWNZLzlmL3BvYmNDT2xLMHRrM0lvNkJiWkIwK3lJMklPdW5M?=
 =?utf-8?B?bytVbk8xNGwySWhVTGlPcFYzY0lxNXpEeXRyU1hjeldlaFlVK0lRc2dHWDds?=
 =?utf-8?B?aGxHM1luTTRXM1JXS0ZPblViSmFydkQxRXNIelFZM1UrRmNCVXlWTjR6RnRu?=
 =?utf-8?B?UGN3MUJlME92Q3FiZGltZkp1YVBSU2owekZ0L0FSV1dQcFZlYW14bzVZWUN4?=
 =?utf-8?B?NCtmQUh1dEc4WUFCWnYvRDU1dWdWamtVcDJtN3hDUlNQV25URDR4ajgxZmg4?=
 =?utf-8?B?ZWpWWFFDTjUrNGw4OGpCcDgrQmxtNE1MT01wMlMza0VEcGY1c0E4MTNlbG1J?=
 =?utf-8?B?ZVVHUHpOSmFvZEhTZkRYQW1SbUhhZnE0R3h4RWQ0d0YrdVQ3NEUzdS9WWnZu?=
 =?utf-8?B?djY3UVlnNlZiTHJVSnUvN0pEcXE2Sml3bmFlRkgwWmcrVFAzbWQ4bUh0N1Z5?=
 =?utf-8?B?d0FNeU8xa1hqZDg1QTh5S3d0L1FVNG1oZ3hsc1IrYWhuMW56YzNqVG9tcVQx?=
 =?utf-8?B?Uk5yUGM3dnpiV0ZNdG5ZemZRVlJDZHFFeFB5TGVvQ2xNL1dpazFCSllmdVdy?=
 =?utf-8?B?b0tMQktHT1hrQXp0VHB3Zy9HZnNwdTVJUktMdEgzTE1WSWxyR2pONTRqYXhl?=
 =?utf-8?Q?VJ7z9Oo+je+zi8Nn+9vg5DSHa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797558ee-beed-4689-ce35-08dceec87f23
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:26:47.5524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQ9DmZG8WCC2Fex2px8CZR6YsTlTEJ9/abZ8dtPm7vby/+hwDGqtbY0jFEd9TRIzp4+4yqz0809gcHdc8KD6Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

Hi Jonathan,

On 10/17/2024 8:50 AM, Jonathan Cameron wrote:
> On Wed, 16 Oct 2024 13:16:34 -0500
> Terry Bowman <Terry.Bowman@amd.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 10/16/24 12:14, Jonathan Cameron wrote:
>>> On Tue, 8 Oct 2024 17:16:51 -0500
>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>    
>>>> RAS registers are not mapped for CXL root ports, CXL downstream switch
>>>> ports, or CXL upstream switch ports. To prepare for future RAS logging
>>>> and handling, the driver needs updating to map PCIe port RAS registers.
>>>
>>> Give the upstream port is in next patch, I'd just mention that you
>>> are adding mapping of RP and DSP here (This confused me before I noticed
>>> the next patch).
>>
>> Ok. Good point,
>>
>>>>
>>>> Refactor and rename cxl_setup_parent_dport() to be cxl_init_ep_ports_aer().
>>>> Update the function such that it will iterate an endpoint's dports to map
>>>> the RAS registers.
>>>>
>>>> Rename cxl_dport_map_regs() to be cxl_dport_init_aer(). The new
>>>> function name is a more accurate description of the function's work.
>>>>
>>>> This update should also include checking for previously mapped registers
>>>> within the topology, particularly with CXL switches. Endpoints under a
>>>> CXL switch may share a common downstream and upstream port, ensure that
>>>> the registers are only mapped once.
>>>
>>> I don't understand why we need to do this for the ras registers but
>>> it doesn't apply for HDM decoders for instance?  Why can't
>>> we map these registers in cxl_port_probe()?
>>>    
>>
>> We have seen downstream root ports with DVSECs that are not fully populated
>> immediately after booting. The plan here was to push out the RAS register
>> block mapping until as late as possible, in the memdev driver.
> 
> That needs debugging because simply pushing it later like this is
> only going to make the race harder to hit unless we understand the
> 'why' of that.   If there is a reason to delay, my gut feeling would
> be to delay the cxl_port_probe() until things are stable rather
> than just trying this a bit later.
> 
> This might be the whole link must train before CXL registers are
> presented thing (a less than ideal corner of the CXL spec) but not
> sure it would mean they weren't available in cxl_port_probe()
> 
> Jonathan
> 
> 
> 

My understanding is there is no spec defined expectation for when CXL
config registers are ready.

We need Dan's feedback. He has asked several times for this to be located after
adding the endpoint in the memdev driver.

Regards,
Terry


