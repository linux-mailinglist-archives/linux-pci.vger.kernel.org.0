Return-Path: <linux-pci+bounces-29895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E743ADBB3D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 22:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816B23B5D1F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379BA2066CE;
	Mon, 16 Jun 2025 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5PK+4PNj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF02BEFE2;
	Mon, 16 Jun 2025 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105858; cv=fail; b=N7ixfdEXB98ieNi3QAXtDlutdscruaZfdVWTp6wImBDumr1M9xdtDgoJCkaIYB4peWo6G/3aIxvWBYCEgd34TenB3XE6dOb9au1lRyIWLEHSNb8t7BBi7VipiP62MFO2K8ALv+Pi7sGz03qbLlMApEvXgNDJop6hep1T6fvWoho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105858; c=relaxed/simple;
	bh=j2vWgkvtzSMPjTdC+hU6Xe1jnQ/X8RubWRNUSvingc8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uKwy/cgRdAZiGLq68o50sntHnpZrNrcRWzVpsR0NW7SqMkkc/oqvnwGItyTrVfqwvUzwPRwZOxyr+unYD9cutD8ZWSwE+/9/54FXFelFpsb2nNScYC19ugWb7e4uZmHm1LZ205dAlRNl07VPL1cZ+orEW65zk3aBDCzN9pXY2qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5PK+4PNj; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEk35n6ygJchtRL+2vJ5HvLJIaZQT3T1G5uzAQzmgh0az4ihcTN95ipuzhB8gfklo9XA2/+BkCKclfijkNwr+eR6Q90XwJGa8L2q4+R8Q9H9LnNMICZbfPNCkkiTO04iTubhXj0J5Tu0O2UeTfjSGx+uY4WYrwJ0CLn8W1wEOYtaSoitlc7DmKOnb/WVOiiZQw3vJOuyT0FCi7Yjctm8tEWzuTkso8VXOP77lbSXzZKW1xIEUPPHQfDQKZT4xupdNmdxtoQSMrCTYQ0hIx6ZotfnKtHriQNa7nhBvRhQKO/mYiZW4/v9qSrJfHGJthgvpFIQBgCSrcNy/KGxlgqq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FavojxFnXB2OlzgM8H47qhk21pPVAW0SRzXVou5r8M=;
 b=yngrLi4bNfEsVd6IM0OOd5Yxn7bDQUbaCbB3vQQigUNShs/9CEZ7A5cWfSEj0DOByMcsl5tHj36i0sDA2S3nEn8r+eCJJ4CXG0od2uXWwx1Lrjuikc7u5zGngbUj/ovNV7dGuxwvBiPSaoNV5jtbIcW8OjC8h7jCKA/Iap+Ej91Ur7yGp0HWoUV1mdd7BMBw+tX5BhCVdgS6bnFqT6TNCdhmSX8Hct6aa5HObeVR0Yqy2BWP2w0NSp0eH9OgxDtvG5UsfY//YDcC8pfDvjTYcnCUw2aXAZTQi0jVIhOyRjzjuccaLZYk2DmXKTo3JjmTSSqIzpMQmMcNZk8j2cB09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FavojxFnXB2OlzgM8H47qhk21pPVAW0SRzXVou5r8M=;
 b=5PK+4PNjJyJSndycD/y67UUtCHOBvx6Z5loAQQLOOZgioDB6QsxyAPEnuO/1y9VdOOUgOVlGG1AoqTcfLEqwNVODvkxcdEDiARuhWL8C2xHT7Dklb21pJY4rvBAL47UzIrCnxixSXAn5k9on1sFErU3z20cu7X8TVvCkueqbkDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.27; Mon, 16 Jun 2025 20:30:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 20:30:54 +0000
Message-ID: <fb630ab5-3ea0-4469-b21c-28817a184205@amd.com>
Date: Mon, 16 Jun 2025 15:30:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/16] cxl/pci: Update __cxl_handle_cor_ras() to return
 early if no RAS errors
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
 dan.carpenter@linaro.org, Smita.KoralahalliChannabasappa@amd.com,
 kobayashi.da-06@fujitsu.com, rrichter@amd.com, peterz@infradead.org,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-12-terry.bowman@amd.com>
 <20250612174610.000035ee@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250612174610.000035ee@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP4P284CA0038.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:127::9) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ac91ad-e581-4f6b-c0d9-08ddad14b0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkRvWmJleWMrQmFRT2hlSHlGTVNtSHYzQTVaVjUrVWtsVkhEUGFrZ2Zhc0sv?=
 =?utf-8?B?M0hSYkhhM1BwK0xYcXRUeHE2TXdpYktPVEFBV0VpVHpWb0pyMU00a0VEMXZT?=
 =?utf-8?B?bk1LbXh5VkMyR2JJMmV5WENRNTlhTzF6WGpvTHVqV05GR0o4TGQ1dDdkRmcv?=
 =?utf-8?B?czZpOTZBbm9OYzVYby9IOXBEaUdtMFlnd3RSYTZyQjY3REo2ZWFKSkJvdThz?=
 =?utf-8?B?NGNZMXE2dk51ZFp5TlcvZHRLdExWUHZ5NEZNNThtVmRBd2NFV3VxN00wTkdx?=
 =?utf-8?B?dWtKa2ZlWHFBay9scVZaa25HOFdLL3h5YVdCWWEwOVVlNkNPdEg3V2ZIcEVk?=
 =?utf-8?B?bVA4RXd2cWJEZU54eC91OTN3ZzllTS81d1hNMU1MMTlDMURhRmR0UStDU3JD?=
 =?utf-8?B?eFh5T1ZxZEZXZVNQVUk1d1hlZlQvTG1jNzMrbVlXdnFhNUJtNGRiVEN5V0ky?=
 =?utf-8?B?UlB2ZkVjNm5Vc1Q4Q3lZTUUveGZXVDlPQXFxTTNKS3VHUU5WcjBsVm1OZVVQ?=
 =?utf-8?B?N3NUMWJNRXlSTjBLeGVLcnhoNVdsOEcxMFIwaERqUnV3SDVjL282bzBiSmsy?=
 =?utf-8?B?SDhNS0tQUVJ4RkxBaHJNcmJNY01PU3JFekc5enFKQ3JUdDdobEo2V2h4bGt6?=
 =?utf-8?B?UnFxVmNVMXRnYTdUUjJ2S1lWZWxvQ1NBRE5Ua2FQUHM1ZTIvVkloSW4zU0Z2?=
 =?utf-8?B?ekpoWW9QTHoyL2laK2RoQnlYWDRreFRNcXFKeGJ1L0FidDMxM0NwY2ZNdEVX?=
 =?utf-8?B?YStXWFFyMnJnd3dDdXlSNnMrbGtkYkxKOWI3bzF5RTV6YmphUXovcm9ETk1V?=
 =?utf-8?B?ZGRRQThIUzVRMVA2R1Q5Mld2VnozSEtQbDgvUFpQd0k3NXN1NkJXdERwMll4?=
 =?utf-8?B?RDdwRUoyRURRRWZvSlpZKzBOUDVFU2VrRTNRUE85SDVma2hqdHk3Zk9ySnpz?=
 =?utf-8?B?MkJaR1o0VXAyUUxPMXRvT3QzbVNJbytNdHFxSVF4SVdjQ2lRZ0Z2YUF1MnJr?=
 =?utf-8?B?SmxPRnlHY0o4ZWMreDZwUzJMWFI4NzlTalRqSHZCcHRXaHBuOG1NS3djeTBn?=
 =?utf-8?B?QStjRXNBN2VxWnhOaW1TUnU5YUJCUEliWUdycVZyYXU5czFycDNoY1BvY0Nw?=
 =?utf-8?B?VjhDUTNpZkdjay9lSlV3TjZSQ21NSTdWZ2k1djVQNU1lNHpic29nZmNETCtX?=
 =?utf-8?B?eTVTQTJCcHB4RHZqazlLMjNMdkdMd3RqRmFXYUJzM0RaUy9jcXVtaHRVNjJx?=
 =?utf-8?B?Q1ozM1hUWWZCUU5ONU1pb3BiYUVjT0QrY083ODQ0Zy9VZXZGaHdNQkZ6MDRX?=
 =?utf-8?B?dWVXSytZNTlrSVpSdFB4UjdoNzlMMHc2azZhOHBWVFhDOFZ1Rkh6OHRXUks1?=
 =?utf-8?B?M3Q0aUc4UXFEYzFpWGc4SXQ1RDlOZXhpaFFIRVRuUFowK0tyWEppNXRLUUhN?=
 =?utf-8?B?Mm1rMXJWeFBpN3lITHNzTUJ1KzJseGVHeURjM0I1WDZSckMrczQ0elR2WGlQ?=
 =?utf-8?B?Z1BDZXF4cmI3dFFrL0RkV3RrcTYzd0VkL2h5d0dvZmxqc3NqNmRMYUlUOHlZ?=
 =?utf-8?B?VGZoVGsxYWhTMzdxczlLazhKZlZoNFhnOE9ISUZlM0gxZTR2LzRrcUwwMmFw?=
 =?utf-8?B?QUo2V3JLK1lJWUNyZzFQN2RyaURPbHZ0aTA4OUY4anRBRmxtbEVQSHNBbE9u?=
 =?utf-8?B?a2VwVktJWUtlVVpPQmNOeXFTREVOOUN3WUd3dXRYZlp6ajJIc3pLWi9hQmt3?=
 =?utf-8?B?eW1BTm5KR2VrN2VVYXBaZjdjRXJySVNWbENYdTY5ei9qYUljU1Q2Rm0ydUNR?=
 =?utf-8?B?d3JBb0M4bWZSQ25EWWVCZldkRXRkZGdHL0JxdzcxSXdiZGRGWWdieWtXczRk?=
 =?utf-8?B?TUI1akVzZ1N0N3phY3QrdWw3U2ZTTmlJYmw0WTRmYWgvT3FhZXRSUnY5UG13?=
 =?utf-8?Q?2fKR169g1sc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTdSd1BrdXBvSGZHQzVTTUM3NUJlZllZYXlLVUY1ektWNE9vSkk1akRCWi9v?=
 =?utf-8?B?SVRxUFVDNXF1cDBDUkNjMDRNMVJFZThaT0VudEdONVY5TVRoaTcrUzRTbStw?=
 =?utf-8?B?UHFLNjhiV3U5M1B2UEhPSXpZVTdyNzh2Q0NBQVc2Sk0yNjdmSU9kOWNQdDFH?=
 =?utf-8?B?bFNSSlNwcHRsbFh4OHZ3a3p3dGZtOGFzckV6eTNuMUNZbkVlNEViMURvdlF0?=
 =?utf-8?B?V0Zkbll4dUdxVEg3UWNqZkNkMm1oM1dCUXhaR0Q0QUhqU0w1eGtvblJiTGRB?=
 =?utf-8?B?M1ZtMFhoQXNUcUxMSGNNaUFiVUZvTjFDU21hL0tMZlZuRmpGN3lHekhRQ2xB?=
 =?utf-8?B?Z3JnWnUzRzlkS01oN0x3K3h3WWFLNElRV0c0a1QzeFBOcUVFbHd0U0MxWlZj?=
 =?utf-8?B?dmZaV0s0eDFISVVsY0MyNEdSb0x5TENqMlJKU0Q5Y2VkK1pQcWcrWjUvamdp?=
 =?utf-8?B?dk9yWDZhcVl1WGhwekczSmhWS2ZQWUxtZmNuSzY0Y2VVbE14VFduRGsxYmdV?=
 =?utf-8?B?RmJrSEo1dmV6WkpZeDhCalZiYVU3SkI3UmlxR3pYaHQ1Vmt5WDBVSlhoUVhD?=
 =?utf-8?B?OFdzNXhmb2cwYjh1dDhlOXUvdUoxc3JsNzA4TGFQMG5JT2UxNEJOeEpCZHpI?=
 =?utf-8?B?VDRLVmhjcm41cEsrWjJweU9ZU0dRdHZ2bWp1Wlc0VyszU3dkWGZBQSt2NTFS?=
 =?utf-8?B?blJKSG5jYVRlWmdMbzQveStXaXpZSzFlN1RaVzA0Tnh3QW5hWDdDWXpEdlYy?=
 =?utf-8?B?dER5Sm40bGVsZ253ZVNSMTlKL1c4aVNsby9aKzVlVmNnS3pHL2pzWjZrVHdM?=
 =?utf-8?B?Nm1ZMERWV0tlUkNUUldpazJFV2RwcWU4SVlFSWpnd0FWZnNlcDNhNldSYmxX?=
 =?utf-8?B?RnIrRjhhQ3VHeUwrMmVVL1Z3SXZ4dFBlNzZLN3VDNVpIRlVaaDFjMkxuTXBX?=
 =?utf-8?B?T3dyQXFSL0J4cTEyWDEyTlliSVZEd2NBd3lTQS9PZklEUk5ObWNTbVl1MWRx?=
 =?utf-8?B?bDVJditlMTQ4bUhuQTdWL2pTYkFWSkwvaTZxM1NWWnZlNU1ySmdaODFIMEVu?=
 =?utf-8?B?Tjg4SVpKNVBWdDIvQnl2dUZrZ2wyejE2UWpvSUNwejcvdkNLZnBXWkRORis5?=
 =?utf-8?B?c0NzS1c5dWNidnZ6YTZ2bnR1M3BxTVJBODc4a29lZlk1QWthUEt5UEQwM240?=
 =?utf-8?B?KzZQWTlUdG1lemM0R0MrYW5Ua2loYUNJS1A0WU5CY2R5cHNpRGdzVUVkV2lL?=
 =?utf-8?B?azZ6NjlGRGUwMDYvYVBMcGpUSHU5UnFzODVJeDFlcDlNa1ZQVEZHWDRLV3h6?=
 =?utf-8?B?SUwwNitXWTNuQ3NCY1NrODVxM0szMGQyRGRza1FqZ28yeUVhWU5mZ1h2Ty9z?=
 =?utf-8?B?c1VDT2xFQkhLVjgvUHZ5c1l0YWZCVVdKYUsrOHdZSjJNWUxpK25kanlvREpN?=
 =?utf-8?B?dDdqclVSOWJ6SkRPb0YxUEVIbitDWVJBd2lJUjNlUmo5aUlzMjF2NUZWNlY0?=
 =?utf-8?B?MXNubGhPNmZHU2c2MlNyQ1dsbm03TzZITmY4czVXRlNNUHRNbFQvSGo1MTNi?=
 =?utf-8?B?QWpQSGFXd0w2RmlHeEJvNVdITVk0RXpLRkpOUkFZRUl1ajMzMEVZd1hyMlB4?=
 =?utf-8?B?WjEwT0xUUVB2RWxjbE1lNUdxL3RKQWQzZ1VKUlNQaDVFSzVoODFBUS8vdUJ6?=
 =?utf-8?B?WEVTYmFkWXhpQ2w1azJEMnJEOW5SUFNrYnRWWDMvUHVURGhtWERaYjhTWVY5?=
 =?utf-8?B?d0E3eXVGbDluamI1QmpDbUtyOXU0SWZTRDN4elE2eWo0YXdMbGhRdEY2VmhQ?=
 =?utf-8?B?ZmU0WEoycUV5MTd5Mm81bUhLTXRmOG00QTV6bGJ2aEdFeFo2bFBteTVTMmxM?=
 =?utf-8?B?Vnd6d1lkVGJBQjJyS3d0U2k3SVpFb3NzMWJOanJwRkdiSGhzaHJBTURWQy9a?=
 =?utf-8?B?N2lEbis5OHNkbmFDN2dyQVBrTXAvbWFCenhlLytqRVRHTUxWUk1Wanl5Tndn?=
 =?utf-8?B?RE1hREhLazlJQlJSK09KYjh1V3JEUnBtcHNnYmZydHJrMnZob25TTlRYVENL?=
 =?utf-8?B?YU8yVGpFRzFIZGVkSjBCTFVEQk9YK1BIY3lSdldtTGdTdWJWVWtKL25UUXdI?=
 =?utf-8?Q?c0BDiAI77fVPephdeO0SPqqVu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ac91ad-e581-4f6b-c0d9-08ddad14b0e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 20:30:54.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBqNh3C8EbTHgvYhCR7zdpvUqlkLCxs2zC6M7IXLLe0ZKm/QvaIutRD5W0jparpX88lDQCx5hcoyY4b2+XOyfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021

On 6/12/2025 11:46 AM, Jonathan Cameron wrote:
> On Tue, 3 Jun 2025 12:22:34 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> __cxl_handle_cor_ras() is missing logic to leave the function early in the
>> case there is no RAS error. Update __cxl_handle_cor_ras() to exit early in
>> the case there is no RAS errors detected after applying the mask.
> 
> I'm all for this as sensible cleanup, but the 'missing' kind
> of suggest a bug to me whereas I don't see one.
> Perhaps reword?
> 

Yes, I will reword the commit message.

-Terry

>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 0f4c07fd64a5..f5f87c2c3fd5 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -677,10 +677,11 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> -		trace_cxl_aer_correctable_error(dev, serial, status);
>> -	}
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
>> +	trace_cxl_aer_correctable_error(dev, serial, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> 


