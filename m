Return-Path: <linux-pci+bounces-35659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5A9B48B25
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 13:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9391884BE0
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21892F99A4;
	Mon,  8 Sep 2025 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sIDQpu29"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661AC1C4A10
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329755; cv=fail; b=V7g2mexf+qs5x1WHZkYw7dmaA0Kpm8Vs5/jlvxLBPnkCcnjy6VomE66H/fcGdqYv+X91ELo49krLa8UpGCNEenEkQ/btesLYAh1V3iV0mNSivAa0A/Zu7bkyMndU6xuZ2Kuyvt5LGxRZXWDSLCFQ2ZTAx5wyT8xscP/cktWoxNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329755; c=relaxed/simple;
	bh=GhuUOlXEWgTmO0qywAKhlxpX5zMarfKHeH02DFvnUd8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rp+lqYFreOfZDWOteuITG0eWcRPfy7JVhvyJMcYdyrzEbDgyVwdVMM24dONJLfCK9z+pjcar1lPUe7+gL16O6G+0s8oirELLGL6P3XKuy8MFgv91skvTazZMqFmo70bpefgUQv+ANnRaj97rf3dP4PWwLuCVGu8TXPkvvp58HGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sIDQpu29; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv29EB9gavcbPWpga0Qe/FxtDzoYcfOackkSNNulULIsu/IFuL2dSx319Cp39bxw9UW+v1K+tXq1nhELg5/vIzoKY1PRWOYoZpA6a4BCDwXM24zc+mwz9K3UGdQwFZdV7nkA1muDnacwt1qlO4M0kZtKs6as+xSrs/pfGwmCnx059rI2D7vZTUNsZ0JZE6ywcEwH/7lE2RkNykV4ced9SWEPSTG+gRCG1m4jpLQeTvxtuL1xruk8bfjuQwL5LAgWOzsVVFdcH2B4zQJsUIamdKzbmjHKwK0eCCXNwvDqIjPXo3/QVzRxgf+Tbh9sz1g74XHZ6WyXR6MiWToEvv+xOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajrLBR9lQEYmwytgbehaE/ABdhR77Gnzt1d49cZp7k4=;
 b=MaXxVESagUZ8Ub+sRDuOUfI6vfivpQt0qNRkfe0dxCCZRjAEEnUl76+a5pEZ5bBDXpP0f8nbq9CZkwD/uhLSaPXR8yqnw5ulr9Clgk9zB0/JHROQ4aozRQp/jLElAnZoadUdDQ29FHn51yr4EfzDYQqh0YTeasv1qC+JwZEk6mBjpKPJEKtFbNgWWB8gGbvyNV0lAL1ECINl11AtKm48+10brq0vfEd/Rp0Zt48wmGC0cdsSIBVwEsh89KsJOcJ5RxLNL/hR/RCROb63ujs2vdQjY/adeVT2uRGpcn0p/W3cuCMS31wUhw4mrWKbED8yeoJ5RW/YXyhHWpplJWnR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajrLBR9lQEYmwytgbehaE/ABdhR77Gnzt1d49cZp7k4=;
 b=sIDQpu29E4XGixAOqtLdHyp7YLwai5XE+NL/p/3QQPVNse1tI6HOsie6b1/dzZSKsSaTBy4WosXMxCRW/2a8OPE9vjfW+9CYDGhsZcjdgqKT4v45slwZTw6IOMsa4jKtPTc2fQ+Q+ZkRX14AOyhUiaC3Zf8FTLRaaGgfarxfBRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:09:11 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 11:09:10 +0000
Message-ID: <0f1f47f5-7855-42f3-9a89-54fec441d7b4@amd.com>
Date: Mon, 8 Sep 2025 21:09:05 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
From: Alexey Kardashevskiy <aik@amd.com>
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com,
 yilun.xu@linux.intel.com, aneesh.kumar@kernel.org
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
 <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
 <68b0d30e2a18c_75db10050@dwillia2-mobl4.notmuch>
 <101dc0bb-d6d1-4f29-81fb-fb1ff78891ba@amd.com>
 <68b2640726bd8_75db1000@dwillia2-mobl4.notmuch>
 <6b07daa7-665d-404a-b5aa-c6053dead62c@amd.com>
Content-Language: en-US
In-Reply-To: <6b07daa7-665d-404a-b5aa-c6053dead62c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0141.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd57c39-43b8-4b22-ba30-08ddeec822d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEdCQUZDdmg2cVpPZ3BFYUgvQ09QM05weENORzg1UW90R1F1QnJRWE9qQnhp?=
 =?utf-8?B?K1Z0anZvdkdLRWlBTTRKTndKMmhIckVOQTBDd3lrWGR4SWZXS0hwdUxHdVRu?=
 =?utf-8?B?b212ZVJlam80YThYWEZ2a1I0NUFDeVZla0hzdG9JMlpvZURLVVpwazM4Nllk?=
 =?utf-8?B?a25KSzE1ckZSdTVvZVYycnBGbE9hczB2bXhqMnovTUZ1b0crOGg5OVFCUElG?=
 =?utf-8?B?eW1pWCtPdnhtbFFheGNQajcrd1lKS2FvekpyRlEyd2gxNExqYnN0QkZyY1RX?=
 =?utf-8?B?VjZMOFF5b0RBNXlzelFMSTZrdzlXR0RnZEVLd1hjWE9naXh1V3piODFQWXl3?=
 =?utf-8?B?aFlvR1g4dTZvMm1HU2RJUGtHSk5EaFR3a3MxOHpYWFpOcTVNTDJDa2g1bUZi?=
 =?utf-8?B?L1Mwazg3bUh3b2hFVGRxc2YwUTJaK3JMM2hYRkJ0cnhsRndYOS9sT0hNMWhj?=
 =?utf-8?B?WmM2WXdXdmZwM0JVK1JTM00vbjRJb3hXclZOQ29INDBZb3RWM09TUGJkQUcy?=
 =?utf-8?B?VVQ5SFhxTE1HdlZzNERWTDgxSzNYOVpLUnMvTUVQYUdmenVFK0ZPT0tyaWN1?=
 =?utf-8?B?K0VxUXgydGNBdmF5VU80YW1qT0l1a3duck9FcmdZbGk3UWlGQm1FZlpoT09Y?=
 =?utf-8?B?YVFWZzVWQXR3YXJXOEJPY2tKVUx6ME5QUW1vaHFOZnB6YndpTTJIUW1WU0Er?=
 =?utf-8?B?UVNnT3I2K3Vwd2hxTlI0bWVkK2EwQmdBczY0TjVIRzVjMDdFSVVYUzJQRVZz?=
 =?utf-8?B?RHpjNFMrcnRNbUMyWkloOFdILzNJRmRGc1BvcmlhNnFjK3hRd2lidFp0d1pt?=
 =?utf-8?B?SytKN3pEY2V5YWp4TXc4N1JVMGliWUMzSDA5ZkRpNG52M0FRUFVKQkFWanIv?=
 =?utf-8?B?NHNtL1Nzd3NUdlZCRU1EREJCSmUxcXRGbnpiNkU3L3V2RG9xMm5mVUM3WlhT?=
 =?utf-8?B?SUprbkRJTlhPdHRzMzA3cGhCNTZzc3NBYVhSSWVCamsyNlFlMktHMVJmS2J5?=
 =?utf-8?B?dVpSZ3ViQ2lYZE9PdytWR1gxODduaEtGWkVRd05vUzlJMUd0VGEydnR3aWln?=
 =?utf-8?B?V2UzeTA4bjU5VTdVcm9mejBEQ29tOENBOGdRRlRiU3duZDIwbS9oaHBWZUFL?=
 =?utf-8?B?WHlLSWtUVnRMTFlseVBOeU4yQW9rSkpTd0NDMVJXeHNRRkF6VUM2V1Y0SDY2?=
 =?utf-8?B?WnhBbUtqaW0zSEUxOWlXL2xDWnF1YWk2TmZtRVJsYU91QTlEM0lFNGgrVk56?=
 =?utf-8?B?SVVtbXlhMVVzS2dXMGpvRzJ2OG5CZzUrV01zQVEza2FpKy9BdlBpVmNCenNq?=
 =?utf-8?B?OENSeVZzNklmZmRoYWxXZVBVZ2JvbkovUnljMnIzSnlXQzBpVkZNL2Q4UkE2?=
 =?utf-8?B?dEh1SDR2MnFEOVJqemVkUEZ4U3JWMnVobUhLWHJwT1ZYc3NKbFJYcVloeGU1?=
 =?utf-8?B?Skhwb3dVWHB2aEp6NDhnb3VXQ0NWT2dJSnY5WkxBaStEWDZvRVVvbzJ6RzRm?=
 =?utf-8?B?NkZuR0k0SldZNjZVdDdBdU9WV0VIVE5rYnRzRW5OTEVWUU85YmhsbitTZmU5?=
 =?utf-8?B?aDZpMnJDcXE0SHk5enlaL3lEMDhmTTIwZ0RXNW11V3JqS3FTOHd5NzM1dEJz?=
 =?utf-8?B?L2w5cHR6a3lVMUxJTXRBOTY1K1plVDBWUTY4UzhjbGNoNmpkSmQyc1YvWU1M?=
 =?utf-8?B?eG51VnhUTG1yL1VlZU5XNHJlL0NWdUZYRjVJYXc4dkJYODNOR3QyVzc2RG1N?=
 =?utf-8?B?WHgySEZrNnNoaDZDT1I2YTl2N2o2eXYzZVlPWmRlTTBLbDIySktvbi9ZY3li?=
 =?utf-8?B?VWtHQ3Y5Q2lBblJQZnFZYzQ1SFVTYjB4U05vOEt4ZHY2TWJYM2NJZ3NhMVAr?=
 =?utf-8?B?amE1bU9HTzVXTTRIUGJ2SW1YVndGY0R5RjhCNWZjeVpwcWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjg4UncwUGpIZ01OdklXbjArZGtRNVQzZlBpZGtORFVFTSt5M3ZLcDJTS3Fj?=
 =?utf-8?B?MWZMYkRPaTNjaXpzdUhxZFZ4VTdZWTJ0N1VSK3pFTVRTNWowQ0VVR3dHOEN5?=
 =?utf-8?B?bHljZjcvUXh0M0FpRWRxVHl4RFE0QUU4bG5KNGxxSU9GU0gyMWhMWS9lVmJu?=
 =?utf-8?B?NlNUNXBiRmx0Y0NMLy9GTDZ3S1NxL0hoRUl2Y3o0MTJLRkN3bWJEZnoxWmxU?=
 =?utf-8?B?dWhQdWJtY3dIZ1crNHA4KzRZc2FTRW1mVlFLWmpqamVIYmx4Q2xKb0pkVUdF?=
 =?utf-8?B?T2NZbHNRdWFYMUxoWmlkc1NjNU1BcERvenpOVG5mbU9GRVplSGRqb2VGWjFq?=
 =?utf-8?B?anpqY1FqdXQ5aDQwSmg4UGxoRFJpLzF3UjBUdlVESHdVcnM2amV0cmVpQU5i?=
 =?utf-8?B?dWV3aXZnUFQrRzBJWFIzZ2I0SFZDdUl1b3FibDd5am93blJKM09zOG9FVUdR?=
 =?utf-8?B?QWZ5Y3kycHFCQnYzdTVhakJJQ2EvR1c1Um1rUnVZcGZIdmRXMUNMSnp4R0E1?=
 =?utf-8?B?VUx6dFhyT2FxbEh5WGgzekpjRG5hN0k2SUh2d2diR0hWclgyOC9NLzkybWp4?=
 =?utf-8?B?UzBpSWVyWDJ3ZUZhcXIvN2tZRytJYXh1MG5lV2xKU2FDZ25ZK1RJZFJEdjN5?=
 =?utf-8?B?dWRjNU8zM0wvZXpRWFhGY0VmM2pXcTQ2L2NrRXpxYzhFaTR5OGVMOUZYWnRX?=
 =?utf-8?B?SGpTaktaSzh3bDN5MEYzVnV2WWNQejJLdGdBQjNaOXR1c3ZPbzdoQit2aW9y?=
 =?utf-8?B?NGpiS2N3QlZURVNqaFhtK3Y2QjlESGdxeUVXd0lFZW9KS21MclBpM2lCNmU1?=
 =?utf-8?B?OW9vbFF2Qm5zdU9uTjFOSEQwVFl2dFpBMk96N2xoeWtsRjVEWkp5dVBldzZS?=
 =?utf-8?B?M0hOemo4UXJlRXVVa0s4emZMMzRKZnpvYi85a3ZaTEduQURrVG5tMkZaSGJQ?=
 =?utf-8?B?QkMzTUo5WnRjSmkzYWpGNUs1L2tZQUhzNU1VclB0Z0ExanNUazZ3S01DTDdI?=
 =?utf-8?B?YXVzS3A4Ni82U0MvMXptOXd3SkdKSU8xUFZSTDdhVnFTQ3YvUXl4UjVuSVBz?=
 =?utf-8?B?QmtvekNVL1JMOUwzOXVFU05pQ2FNNEZNOUdqYm5rWWZUV1dhVWhxanZzUzFa?=
 =?utf-8?B?YkN1YXF6NUdtVDFHenk5STEzVm5Gd01vbmlyZUJERzh6eW9xQisxMzFQYWo1?=
 =?utf-8?B?ZDBVNWFEK2hIeVBXK1BVN1AycVVIZWgyRWFVcVowQW9vTVo1em53NDJPUVU5?=
 =?utf-8?B?L25BSGRzcW9KZktqSlBFQ3lwanNBanFsaTJjclc4bDArc2RvOXNlSU4wcEZz?=
 =?utf-8?B?V0VNazBHWVlEdG9sU2Q3NmFuank3bWdPVm5tRDhvaDVTK3hCTlFnKzRXdkIr?=
 =?utf-8?B?Q3Z3RzRyYW5XNXN1dDg3SS9tREhNVFZHM2NiUUZQSys3RUE5NWRXYVlIcnRY?=
 =?utf-8?B?U3k4SC8xU3RkN3lBUUNyM3BvQnEyTFkxZkMvTlIxMjlicXpZbUI5aGlqNlJt?=
 =?utf-8?B?MitiT0dTbG9sM3BDajl1MXMvUWpuZk9ZbmhETDg3Nlh6UEkxZkhPaEQvdHdK?=
 =?utf-8?B?WDl0RHlOeVJpYWx0VHpsVThDcDVxb1U3MTVSbURSelVCbkFHQ1JvU1dGVW1R?=
 =?utf-8?B?UUZGTU1OVEJRUlRETk9oWUZ0YU9aaW1DMjIzUDdHcEZHalFoSVNTdW51bzdm?=
 =?utf-8?B?c0hjZGEwQmwvNWRKSDUrTUQwYmJvMHFncG1KTXZqVWU1dGE3MFp3YW1RVjN6?=
 =?utf-8?B?SE5NbC8yUitWcEtNZ1hNUStNcDJtOHJGbjhNOStrd2dRclNmb2pGS2V5c01l?=
 =?utf-8?B?UkFxVmY2VHc0N0J1SXNIZzRZT1kyeUhPV2svTHlnNGlhWUlZcDhBdUVOZjdQ?=
 =?utf-8?B?bDlKOW1nMFZxWGlGV1h1YlJxTHNOdGhPTUtWUStFUW94L3BXRTV2UnJGMTZa?=
 =?utf-8?B?WVViYXVEVnVJSUFNYzY5MEFmSzhsWmFYb1BXQTJIK0FNdElIclh4NVVDditL?=
 =?utf-8?B?NDl1R09IWVZHZW1aWnQyZ0gvZUNaVEZLNmtpK2tOY3JGSnJMQUtBMmFnNFNO?=
 =?utf-8?B?bzcxQmwyZmxDUjVmYWpqdVVHVU0xcTdTYjYyUzVFemtiRnd3azJYY3pYcU80?=
 =?utf-8?Q?v6HCZIX9rWFmi4EWpj2PR76mF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd57c39-43b8-4b22-ba30-08ddeec822d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:09:10.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nqby7LEXjvf5/2cEDU0EE5gtkPEX9sLlR0NTDqfuebe3Ia99VIDqtIaavHkG4Wt8Ig4yQ3SeuV8Vcm76X33pjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967



On 2/9/25 09:49, Alexey Kardashevskiy wrote:
> 
> 
> On 30/8/25 12:37, dan.j.williams@intel.com wrote:
>> Alexey Kardashevskiy wrote:
>> [..]
>>>>> We have pdev in pci_tdi, pci_tsm and pci_tsm_pf0 (via .base), using
>>>>> these in pci_tsm_ops will document better which call is allowed on
>>>>> what entity - DSM or TDI. Or may be ditch those back "pdev"
>>>>> references?
>>>>
>>>> Not immediately understanding what change you want here. Do you want
>>>> iommufd to track the pci_tdi?
>>>
>>> I'd like to either:
>>>
>>> - get rid of pdev back refs in pci_tsm/pci_tdi since we pass pci_dev
>>> everywhere as if a pdev from pci_tsm/pci_tdi is used in, say, 1-2
>>> places, then it is just cleaner to pass pdev to those places
>>> explicitly
>>
>> Maybe if we see that that are unused then they are easy to delete later.
> 
> It is way easier to do now than later when it grows. I'll dig a bit.

So far it appears so that the only use for these backrefs is pci_tsm_ops's hooks which take pci_tsm/pci_tdi instead of pci_dev. So the backrefs are only needed because unbind()/remove() do not take pci_dev.

My problem with these backrefs is that for a new reader of the code  it won't be immediately obvious whether we need pci_dev_get/pci_dev_put for those, are pci_tsm/pci_tdi ever detached from pci_dev, etc. Dunno, I won't be nak-ing of this though. Thanks,


-- 
Alexey


