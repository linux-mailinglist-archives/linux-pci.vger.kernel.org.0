Return-Path: <linux-pci+bounces-37639-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA4FBBF92A
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 23:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33ED1897891
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 21:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D033253B40;
	Mon,  6 Oct 2025 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhGYbzkX"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4832566F7;
	Mon,  6 Oct 2025 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759786098; cv=fail; b=gRNRGfHIYRggI8Nh4C0UoISdu/duibTr9uCYvO0wf0w52ZQ0AYjptdGdTrFEJUG7uyH4eVellfQNZgKF94L9dgIswWUzmO8n31aMEVBC5UqgptH+cHtdc5iMVFDeHTBRocoOnLE02zT2vhqAtxr5d/lp+fAYRwyNb1rQCs1DlGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759786098; c=relaxed/simple;
	bh=O4fjx0pPsKx5Ld3TeDoOx3j5WShynW+t8CxMNlSpzpY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Um3x7YIk++EY77QjQOcJPqf2haEg19q2ThEiMFAG26zGdX4Vfy3s06XERbW2tOHgbPQZQxuXVeoJhktxVXwj5zi6UHsvocBUxqXO0nzqP8qJkD5z/7Fz/renA9cOKwAUF2TqGsK14av8zYdaCCLUZJCdR0FZkiBgbUoXGLSVIGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhGYbzkX; arc=fail smtp.client-ip=52.101.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sUxwnVePaBYtot5aw0fpQLvzBvpsXb37h6cCAbYnrIBOTirAQqMaLpjKT8K1XrFAdGiC1lSyAuK9ea9VmtJEVQ/KEuxOgVwVDl+Su/NTXiQJUxj2n3FwLIItp3x3Pq/yJUFvN4Q7siauebstHCv8Ur0UEG3x5M29WhTvcz31muV8prbGIiE6fa7zH/sel3vJfNnqR58ey2lyOQYj6NfhdN46w1ui8/Qh6SCHZbPXCAjAKil24O53uCp9QV0pCM3op2k1TJpqJ9DWw20KGJnXv3P+aZMA4glWMGCpPNwyNWgmIysAfQk7sJMHv01J/QwPLtzjSfRUTxRagGEfipRJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30tLY8QKk6HY6jkhEbX44upngKq+uj6lr+UyNmei3fA=;
 b=wWlfuOMHnJuB9vH5kmzrdCWR1158eF0+BQSZRrf8wlr/358XiVzf8hUZ3rtEtQhB3eQsPGOWPHpzsraF4ZJQUa8SiO+tx7/5Iu0NheOTT7JpetTR7vXbrjC/ZU9sFq3hxGFVa/+e4pHmaDDMGq8taTIJq9qcMcYjLmnkomXqWYcP9qFvtYMIdj66HD8b2fAU4hnORcns5FRy+v9bkKdV0qlxwOY7Juv0NZ/b0TewbDYpLhq/Ey+vuP2z/P4pP2atul7NSiqt9LJMNMMpt3tcTZuFCBjO66QyAkWbBEAg4MuungM+5lhRr3SmZ5G9VTyJyu3IbehsK6g5Bm+odkU7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30tLY8QKk6HY6jkhEbX44upngKq+uj6lr+UyNmei3fA=;
 b=vhGYbzkX1gajQTkOZp5P0xnWxqziNsb5J57shbntOEELGqbDGk7nzWYVQdW1r2bOlcueZcI9YAsRCiGCKUtPKkvrXi5HCk2DEESd5nTTcLxu3+EIO1m1mBtQnepGaErgtD+f4GW1X3EwaL6HLQNY2flMw+iiXgZY5dJx9ZTHpI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 21:28:08 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 21:28:08 +0000
Message-ID: <2a922e66-dd0a-4f51-918b-92e5b40293f5@amd.com>
Date: Mon, 6 Oct 2025 16:28:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 21/25] CXL/PCI: Introduce CXL Port protocol error
 handlers
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-22-terry.bowman@amd.com>
 <03ee0a67-9f2f-40a2-aa47-e548fb800ab9@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <03ee0a67-9f2f-40a2-aa47-e548fb800ab9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::18) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9b4064-988d-486a-5ea0-08de051f3e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVU1cFVIRGxITklSRUNKQlJPYXMwaWs2bTVyajRwTW12d3pyZjVFUThtbFdK?=
 =?utf-8?B?UGdJcFViUGJvdVRsZXJucXB1ZFYvK1k5dDFnL0VxcTVoVFFsNjR0ZlhsMlhI?=
 =?utf-8?B?V1dpOGI4K1gxRlF4d2pUNzZnanhnMnFqVjk4Sld1cnZHWUx5QUhuZWcyek9x?=
 =?utf-8?B?OUhna3I5YXBEVkU2bXUzVHo2M1NKMkFuV09lWHVQNzAvU2ZYTVNiK1hCZXB6?=
 =?utf-8?B?TnRrZytseWdIQXFvb3FDQW9hK0MzeHV3VW5DWVUzZ1laWjlob0FZOUgrc0VH?=
 =?utf-8?B?RWorWmFLRVJyV21MT054dzNFVUpoZVZIWkF5RU1DNTBrN2JUcFVscXVFek81?=
 =?utf-8?B?eVJDd0FoWld0QUlROFFVblNyQ2RUUDBNTGJ1SUNKb3hrR2wwT3Z1U2crRk1L?=
 =?utf-8?B?TTNVWVdURlFvWUdlYXVxYVBHZmlEMmhFTUtYOGRQOTlMcm9hS2RFOFd3a28z?=
 =?utf-8?B?MEJmdkJObnhlUkRIQjk3VTJCNFdFYmFESHVNeHE4QmhYaFQ5ekhROGtJZzJE?=
 =?utf-8?B?SFpqKzRHUUJ1cS9UN1RRc3J4TUtQT3FXbjN6UnJ6MVY4YXhlZS9UUTBGQTdH?=
 =?utf-8?B?Wm92elJVTnZpTmpxcDQ4YzZHcHczeXRvNjc3bTlIWG1Bc2wzMWdxWTRLWndt?=
 =?utf-8?B?YmhuNzJqZnZOdVF4QUNNdWVMb0Z6aEtOTzZ4MmhUOXZCc1BLTGkvNEpnNXFF?=
 =?utf-8?B?dUZkUjlESkQxUmxDT1MvdlIyem42Y2xEdHRDNWVxc3lyZXJ4YlozV0lsMDN0?=
 =?utf-8?B?NlBhOHhITitQeXNxK2UydEVBY2JZSGdNdnJ3d0p4ZW1oenlPSldpTTdvQlVs?=
 =?utf-8?B?QjhQQ0FIZ1VXQm9wUGJMRjJldDVvcVJ1N3plcURHSXlOVXh4NDgzSDU1bWpv?=
 =?utf-8?B?YTJUOGRabFFnT2prYVRyblFiMlQ2K2UxdTdhSXZDSWhXbC9OKzhtTFgrNms3?=
 =?utf-8?B?WnpJMWNVcTczVVVUdHpvcnNIMFJyZXlCRjdhWFNtdUVFL3ViMEh5UnV6ekZW?=
 =?utf-8?B?NzhQaStPSm0rTVlJTnNmZURoSEhMNkUxSkRGMEVkem9vaDRmbHA5eDdwcVVm?=
 =?utf-8?B?R29kTlZxVURvZVZFUU5ualh3RUFJN2V0cFJST09KTTNTNmsyQzlOOXl6LzVF?=
 =?utf-8?B?dktMa3AyY0ZQa3pXamNISi9SZkZGRU9FRW40WjZBYkY5M2lHWHRsc3c3L2ZW?=
 =?utf-8?B?ZUtBS3VEVzVmZXByME9POGp1c3dqOWlWVzdHZHVxYTJ0RlA1ZmhtU0lENSs0?=
 =?utf-8?B?L1o4KzJtcnQvMkJGeFRBSmtIVk1WZ0dyRndnWUl2WVhpcG1qbGJSbENMMzBE?=
 =?utf-8?B?eWtnTUF4Y1ZBLzdHbVVLV2MwUkJIaUlpUmRZUGRZRFdlc2VQd2thazZSTUly?=
 =?utf-8?B?OVdscFVpQ1JaeCtMNGIxUWNyRmM0aUJOa09UTDQybHJwMzFYVWxUWTVoOFZD?=
 =?utf-8?B?VE5ucjRpZHBvTUlBWjhTRGxMNUFyeUh6OGdXeXAxUHBoSktrUFQweGwvdU5p?=
 =?utf-8?B?Sy80TnAwOFdGRFVqYlNvVGhzbjhOR2NzV09IeEVEbDhRTzN6bVRlMzNweW96?=
 =?utf-8?B?VTZoRVl0U21ZeTJXK1lhVjJLTFYyUWIwNDI3elBjZC9YNGVJUitwWExlaU9p?=
 =?utf-8?B?V0x5c1E5Tno5ZVBSM3k3WmVLbFZQM0NIZHAxaWR4d1BHRG9nTDZwOUtzWENG?=
 =?utf-8?B?dmYyV0d4cHRnMmVxRXhGNkp6OVlRME5vdis4MDBReFVQTm0rQzQvOHZIajhO?=
 =?utf-8?B?Nnh1VGRrVmhMQzNNdTNhazh5RldaUVkyWkNXdURpVEhramEyeGRsV0Q1Wmw3?=
 =?utf-8?B?SHRmb2hrc09jUTlQcnFmYnk3ajcvL3hQYkpCdzZwQ2wremtBRGQzQWRycEd6?=
 =?utf-8?B?Y05OYU1JMVJZUHB3bkpqc0JjNGkyWVB4QzRvQmNqRDFWZnlocnpPOHpMMlFp?=
 =?utf-8?Q?eZo5hsHD2PsHZOZUBf7fpJFFZZrme1Da?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTVqaFJ1M3ZjdzhMdG1oNkNsS1JPN2t2QjZWNkFycEtCT1ZRYi9BMW9aWHBi?=
 =?utf-8?B?bzJjMTk3dVZMRTEvRkZ2UlpjMGREczFmUEp5ZkM4TzAzMXpsYUR6SUIxQ1Jy?=
 =?utf-8?B?RXZhVzZxSEVPem13ZVcvd09rT2Z0VnNuYmIxUTFCMnk2cURIeXl1VFdWQ2Nz?=
 =?utf-8?B?ZmRRdzhybk5wNDR2U2EvUFBINFZDOHJlMDh1VTBWTEJxVWpDZFBPSEptQ1Rp?=
 =?utf-8?B?N2xDOTNKYkNHL0puSXpJZUVLaGpDNG1EZ3NtUE5zbmdxMkUvMlBCUXZreHNm?=
 =?utf-8?B?b3Z2RnR3ME5KajliYmVCVFFDQ0trT2p5L2NyZ1hRZnhGbUZncWVHb3Z0a1N4?=
 =?utf-8?B?dlVtcDcvSDJzRGhZSkpHb05QbjF3ZlQzclhXR2M4NG1MdmxoTFkvaFF0aURk?=
 =?utf-8?B?WjV6TysxSnJoTXYwK0ppQW9aL3BjZzNrSEtGS2tFSG9xdWpFb1p6UXRuOXgr?=
 =?utf-8?B?V09XVDd4L1Q4TGt6QldsaHg1bU9sM0g1R1FwZ1ZQSkdKN2s3aDhKNVBhUEdH?=
 =?utf-8?B?bVNoSEVTdnRybmtpOWdxNmhnZUt3SjNtcllVV3k0bmQ1YkFEM0xiUy9JR25y?=
 =?utf-8?B?RHVaTmc4ckhGczRVR3RaNk5FWEdNK0FFNEJKNWkvVUE3bjQ1VllUcG02MXN5?=
 =?utf-8?B?dWxhMEU2L0JVQ1JPU0M5MmQxM2wrWDFZZFhmaGIvTmk1VGZsV1h6T0ZhaWxI?=
 =?utf-8?B?MUVkNktqRmtuWjJwMGY3SEtmc3FpOWhlMUNrQm1aQ1FDQWFRZ3p2YmV0THNZ?=
 =?utf-8?B?aWlPMHM2OXRhTTZoS1IzQzk3ZjJXcDMwSHhnMFRic3d3TEUxdUo4eXpTaHMv?=
 =?utf-8?B?dk9RTlRSMWVvVDE4aTVISkxLU3AxQnpyNmN0cWoyakpha0h4dXFXSUVEclJn?=
 =?utf-8?B?WHRrRGtQV1Q3SGdWbldqOExWdmhLQzQraDBIbmloZHFSYXZDT1RTQXdNamsx?=
 =?utf-8?B?anhQclNralVoYXdwTU5PalJFSFFnYkg2VVVGK2pvZUJiRmpnYUcyazMyN2JN?=
 =?utf-8?B?dGdQUGErU1VYY20vRHE4cFRjb3Z3Q01nOGsxRnZqaG9kbEFwd0E5MXZoT3Bn?=
 =?utf-8?B?VTl0WjlFbTZSNC85U3ZNSm5MbWliM1FNRDdENXlrTDRMdnMxS244M1ZsMlN3?=
 =?utf-8?B?dHV5ZHhWNEhiRzlERE1tN2pXWVo2dk9zN0doTmxNMTZUdlc2bWRWOC9nNlRp?=
 =?utf-8?B?SUVHdElYTXd2MytNVzZVQnR2cjI4VEJCc1R4UmhHdWlkWU0rNmduZC9NK0ds?=
 =?utf-8?B?Q0lZVGxIeCtnOGV6K3BSemY2MHZrcVI0S3hLVGljQkcwZllNTkVnZkQ1RTlm?=
 =?utf-8?B?NE5QNHNvSFVOaXZLMkhyWG91UDNRTTZMaVgwZXdEU0czUFp1RnhpazUyM2NN?=
 =?utf-8?B?cnB6VXZRNGdvbFFkZmhTa0hoUHNZcHkzY21kc1NjUWJ1YnppYWROMU43bERQ?=
 =?utf-8?B?VVFjRVovY3gva05MQUJmWnh0MnNVaTBMQmdBWGl2V0hTN3dxOVArV0YwK3BG?=
 =?utf-8?B?b284elhaTFpKSENEa0RnL1hDaGwzTk04R2toaUx1RXVCai9kU0E3cG5tZHVP?=
 =?utf-8?B?VUVQV0pvRFBjcW1uNndZNTRPV1Q1WkxDakwvaXowYTRvbGUvWEI4djdBRW9z?=
 =?utf-8?B?Z3g0alZVOTdJL0FFQkNlRWdoQXFIVThPcjNwak4yMG8raUNJbDYvRDViM0s4?=
 =?utf-8?B?N3hERndWZ25mNnFBeGp5NjArMFVEQmZtSitvVHFtU1JLTFh3b3h6d3ZVTXlB?=
 =?utf-8?B?UFBmbHF3cGZWZ2pLQnRhWXpyK00wcFpOOU9wUWRvK005Nm9JazBDM2VmRGhq?=
 =?utf-8?B?ejdlMjhFeThBazZjQXZEQ0N3U3JWckRNTHd4czMwVnllS0swaGlZa1hDTEl2?=
 =?utf-8?B?bHhmSVQ1M202NjB3a1lUSUlJNUE3QjhNbjBmeUZkQ2g2RGlRL2JGa3d6NWVS?=
 =?utf-8?B?RWJET0tqa3M2dVlLMWZ3eEdlV3R0SjNXVGR0ZEpkc1JBeGpvSjQ3SGEza2do?=
 =?utf-8?B?K1U4RER0d3hVTmY3TXJ6OGdXc3dxR3NCSkd5V1VSMjYwdTJVMUVkTzY3T1FB?=
 =?utf-8?B?ZytPTnN2M2h3NFVWOFRPVTRkZm9BaG9qbHRTY2tQVHhFN0M2ZWRMSnI5NHIx?=
 =?utf-8?Q?ZXU6+zQ8UlSJcOwG3hV9ZDXkh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9b4064-988d-486a-5ea0-08de051f3e6f
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 21:28:08.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gL/933/xKX+UMpN0RH7rnkscypPe3jgW3ss3fMGfiF3cDDDyXujGKd2Ex4ey1MsizNsBVmsNo6FlLlZKEMXuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006



On 10/3/2025 3:12 PM, Cheatham, Benjamin wrote:
> On 9/25/2025 5:34 PM, Terry Bowman wrote:
>> Introduce CXL error handlers for CXL Port devices.
>>
>> Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
>> These will serve as the handlers for all CXL Port devices. Introduce
>> cxl_get_ras_base() to provide the RAS base address needed by the handlers.
>>
>> Update cxl_handle_proto_error() to call the CXL Port or CXL Endpoint
>> handler depending on which CXL device reports the error.
>>
>> Implement cxl_get_ras_base() to return the cached RAS register address of a
>> CXL Root Port, CXL Downstream Port, or CXL Upstream Port.
>>
>> Introduce get_pci_cxl_host_dev() to return the host responsible for
>> releasing the RAS mapped resources. CXL endpoints do not use a host to
>> manage its resources, allow for NULL in the case of an EP. Use reference
>> count increment on the host to prevent resource release. Make the caller
>> responsible for the reference decrement.
>>
>> Update the AER driver's is_cxl_error() PCI type check because CXL Port
>> devices are now supported.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> ---
>>
>> Changes in v11->v12:
>> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>>   pci_to_cxl_dev()
>> - Change cxl_error_detected() -> cxl_cor_error_detected()
>> - Remove NULL variable assignments
>> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>>   port searches.
>>
>> Changes in v10->v11:
>> - None
>> ---
>>  drivers/cxl/core/core.h       |  10 +++
>>  drivers/cxl/core/port.c       |   7 +-
>>  drivers/cxl/core/ras.c        | 159 ++++++++++++++++++++++++++++++++--
>>  drivers/pci/pcie/aer_cxl_vh.c |   5 +-
>>  4 files changed, 170 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 9ceff8acf844..3197a71bf7b8 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -156,6 +156,8 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>>  void pci_cor_error_detected(struct pci_dev *pdev);
>>  void cxl_cor_error_detected(struct device *dev);
>>  pci_ers_result_t cxl_error_detected(struct device *dev);
>> +void cxl_port_cor_error_detected(struct device *dev);
>> +pci_ers_result_t cxl_port_error_detected(struct device *dev);
>>  #else
>>  static inline int cxl_ras_init(void)
>>  {
>> @@ -180,9 +182,17 @@ static inline pci_ers_result_t cxl_error_detected(struct device *dev)
>>  {
>>  	return PCI_ERS_RESULT_NONE;
>>  }
>> +static inline void cxl_port_cor_error_detected(struct device *dev) { }
>> +static inline pci_ers_result_t cxl_port_error_detected(struct device *dev)
>> +{
>> +	return PCI_ERS_RESULT_NONE;
> Same question as endpoint error handler on if this should be a PCI_ERS_RESULT_PANIC instead.

PCI_ERS_RESULT_NONE is correct. If CONFIG_CXL_RAS is disabled we don't want CXL RAS logic
running including the handling.

>> +}
>>  #endif // CONFIG_CXL_RAS
> Wrong comment style.
Ok
>>  
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport);
>> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
>>  
>>  struct cxl_hdm;
>>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 56fa4ac33e8b..f34a44abb2c9 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1357,8 +1357,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>>  	return NULL;
>>  }
>>  
>> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
>> -				      struct cxl_dport **dport)
>> +struct cxl_port *find_cxl_port(struct device *dport_dev,
>> +			       struct cxl_dport **dport)
>>  {
>>  	struct cxl_find_port_ctx ctx = {
>>  		.dport_dev = dport_dev,
>> @@ -1561,7 +1561,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
>>   * Function takes a device reference on the port device. Caller should do a
>>   * put_device() when done.
>>   */
>> -static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>> +struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>  {
>>  	struct device *dev;
>>  
>> @@ -1570,6 +1570,7 @@ static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>  		return to_cxl_port(dev);
>>  	return NULL;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_by_uport, "CXL");
>>  
>>  static int update_decoder_targets(struct device *dev, void *data)
>>  {
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 9acfe24ba3bb..7e8d63c32d72 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -250,6 +250,129 @@ static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>>  }
>>  
>> +static void __iomem *cxl_get_ras_base(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		if (!dport || !dport->dport_dev) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +
>> +		return dport->regs.ras;
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	{
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +
>> +		return port->uport_regs.ras;
>> +	}
>> +	}
>> +
>> +	dev_warn_once(dev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>> +	return NULL;
>> +}
>> +
>> +static struct device *pci_to_cxl_dev(struct pci_dev *pdev)
>> +{
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +
>> +		return dport->dport_dev;
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	{
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +
>> +		return port->uport_dev;
>> +	}
>> +	case PCI_EXP_TYPE_ENDPOINT:
>> +	{
>> +		struct cxl_dev_state *cxlds;
>> +
>> +		if (!cxl_pci_drv_bound(pdev))
>> +			return NULL;
>> +
>> +		cxlds = pci_get_drvdata(pdev);
>> +		return cxlds->dev;
>> +	}
>> +	}
>> +
>> +	pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Return 'struct device *' responsible for freeing pdev's CXL resources.
>> + * Caller is responsible for reference count decrementing the return
>> + * 'struct device *'.
>> + *
>> + * dev: Find the host of this dev
>> + */
>> +static struct device *get_cxl_host_dev(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		if (!port) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +
>> +		return &port->dev;
> I may just be tired, but won't the __free() action get called here unless you use no_free_ptr()?
> You do the same thing with cxl_get_ras_base() and pci_to_cxl_dev() above, though I think it's the
> intended behavior for the latter function.
This needs updating to not use __free. Thanks.

Terry


