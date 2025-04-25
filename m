Return-Path: <linux-pci+bounces-26789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72305A9D3C7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 23:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59A43B543B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B889217723;
	Fri, 25 Apr 2025 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aeZuSezj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54B19047A;
	Fri, 25 Apr 2025 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615003; cv=fail; b=Ab+f8WLMlbx6Z+ejy6ufcRsDci7Cwiq+eqKSSbb6i+bVTFGGkoRtV6Nl+nZ7VIIFfCgO2DkKJvouCBXrFIRM1nv652iqbzux6BmZDyG45pNzdRKCzkNrfycJZwlhVlwMPt1gfIIg/Q010SHTBfc0TsIfQJzyFVJ/6Wtmh9afUi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615003; c=relaxed/simple;
	bh=nKhhtL+3nIC0Ur/WOjczIYYGSAiVeO8NRaqpZYKYmzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oXdpTY9ekZOOCBVjNj1t0RGmbff/H7Edv05bYp1SheHrMzteLF+gPKYeuDj+qwJKf4NM/9ls6oX5CSQ3iWgM5HIVSvLthCKFyZypzEJstWomqEI5ZPQhnIxg99wTsSEVhKBXKdrsC2uGQ/coSsSOh0WK0UbQck2hk9esPLfOpsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aeZuSezj; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mn9w42t6gCTF8t5+nwSIh0mpOT05OGuy0eBcV6P9kA+O2jLBZR2K4He062q88o1FCmAklRI5aOukG2yfizIGrbH6weJKjvdLKfdRsrd3BZVTIpoRDXObYnEZ1HxHq8nhxSc3trLhNRDeKbOtOdURYbzYuinRQb/eJ3QdOKPMFx9AH45xnVvpGlgzPlwU4/m4ap3r8GV9rT2vAY/fnhktN1sMjMPU3W/yC8OtbaS5AedlzIUV1F/pTxhGR+xz+GdA+WGD8JPm3oC/VeRPvJMb17yzyZShUAiXawJh6yhPWbVD2Hrg4+ycoq8OzI//DTBsrMM8mo5OxpuI0brQsxe64A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QRTYdZFK34J+mOeM9OxNbdy7Ij9m/nMG6fCj+26DeE=;
 b=ree/7WhWQBJAl21zSBgdwYRW2/2GmrkqzjtAyX7RFKQBsqiy6nqrrPccJkytliwlwHMD33EyvFyI7eoyHMbpGYq+yg75Lq3k/iTmwMmdpNO9NMy6FcV3Gvfk81Fm/ou3/gE4I2h+SUVmwQmHt7to/7ZgM4j7u0c8ueKV7cfIHOFjAc0XwE908RQbBnKdMa8Dd5QLNze7yAPAunWkkfslf/defw3fLTlp2Q3zxO2ptGkHYMuw2+hfIlrv0OEvEHcDXSP/zKaT0t2fhoAWG2oD4Vpot6TMKJ7DukEGpq1d2vAMxbgqvV2wLyXVh4OJ5QbePpuNwq8daVKSj9hWdhLYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QRTYdZFK34J+mOeM9OxNbdy7Ij9m/nMG6fCj+26DeE=;
 b=aeZuSezjfBmLVTZCn5YhfUixoX/Y6oWoXR5GL7+fDqddEja5MYdRLpybVmlyfzO6Wj0akEa2rGN6jtgxa8vM2ebanHfnJ8ke8JaO46llQb9fW+IlaI8ydN6oSVr79rJrw3+9kv4cRhH+5rI5ki2r4Ose0IHq7psUKYhQ256JuAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.26; Fri, 25 Apr 2025 21:03:17 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 21:03:17 +0000
Message-ID: <856de824-49a1-4bf4-8d09-8549e90232ee@amd.com>
Date: Fri, 25 Apr 2025 16:03:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
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
 <20250327014717.2988633-5-terry.bowman@amd.com>
 <20250423160443.00006ee0@huawei.com>
 <e473fbc9-8b46-4e76-8653-98b84f6b93a6@amd.com>
 <20250425141849.00003c92@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250425141849.00003c92@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0048.namprd05.prod.outlook.com
 (2603:10b6:803:41::25) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffca2e1-6f52-4546-0ca0-08dd843c99d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWRZTGN1SUtkWVhuWnR6QVBNYW5CdWJpcHZxNGh0N0ZQckpGK21FazBHMlcy?=
 =?utf-8?B?WWVZa096MmtWS0QyRmdCM2Q3WEM4b3pqWmpYZTR1VS9OMFpWa1dqMFlkR1RI?=
 =?utf-8?B?R0tHdlFSS1FYYnlESlcyTHlkbGRuL3RXU09KNm8zR25mMEFGNzBEenM2eUJm?=
 =?utf-8?B?WG1aL3hGOHNiYmJ5bFpFRE81Z3NsVDY2bXRXaU1QMXZtdEFpdFJyTDlGS2hF?=
 =?utf-8?B?bWMvb1MwMTJwL1BEUDUvbkpOUENtTWt2VXo2Z0t5WU54dktjUkJ5SE9ucUdT?=
 =?utf-8?B?ME0wcVZUVHVvU2pBUml4QUVxak1EZHBMK2Y4LzFjUE9zTjAyV0FnWUcyWUpt?=
 =?utf-8?B?U2hrbElkUnVCVHdXK1B4cTFrdWhpQWdjTVpRc0ljSnhETzlLM2JpdUxmcFk3?=
 =?utf-8?B?aWl1bzdtdUpBUkZyekdCcUYwM3lQcm5ock1QeWlHNFRaQ1JlV3lSOGxyaVJO?=
 =?utf-8?B?cmZsaFFzYWY4OGc5OTRWT2ZiVmVvWi9TejFlOU90RVNTaEFCcHFReWI1ZGox?=
 =?utf-8?B?UlJGN1JiOU5taTRvOUNLSUd1VXA0KzRWc0lsMXB1Q0tmaUIyVml5bGZvemda?=
 =?utf-8?B?VmFkWmRBMm56Y0h1dmJheEd0cXlzaHlyaGRwbkwvL0FNb0NKajBjdDZhRkM2?=
 =?utf-8?B?ZFB0M2FMeDlzUTczZk15bm00b1JsbXVETHIrcnlxK3BGZGNPWXgzalY4djNX?=
 =?utf-8?B?YzJOTXFNK3l2U1ErU1BXY1Z0U3BVSGx2em1YM2JwQW9teWlTVVMxd0hiLzg4?=
 =?utf-8?B?MlUxOGE2RHZFUmxpZExJdVYzMkFmVmRmT0NMeXpWTG9Wb3Q3aTExc29na2h4?=
 =?utf-8?B?cU1KTHE5WFlwcUNYNWw5MStrMkloM1MxTXNwM2tGcVZYTENZR0NYZ3VSbHl0?=
 =?utf-8?B?MExQc0ZteHRHSUR5dkZsanJzUzNRZnBQMzhsMk10eHY4YSt0SXRISEVCT215?=
 =?utf-8?B?NitRa0Jyb2Y3Wml5TDNNQzFaY3Roc0k2ZjFSeTZhN09tcHljZjU2WE1jak1i?=
 =?utf-8?B?b0p3T3QrUDI3N1JHaW43RGZESlVabXdtSkljbnRhQUV3cGszZXdxOFBQSEFh?=
 =?utf-8?B?L3JWS1hKOU9hR2dRZmJuSis1RFlucFlSYUZwRC9XSVFaaVZkQ2JpQTM4SmVF?=
 =?utf-8?B?V2hOUzA0Z3R5UDNIWXp6UWxzUzZrR0UyM2o3Qm4vam1OdkU2OUFmTVRuWjNT?=
 =?utf-8?B?Y2tRV1l4M2JyRGl3akxEZVhxdEpNTTlOU0xHRWx0ZjlMZGRCWFZDbzhVV3lq?=
 =?utf-8?B?bHlXNUdoVDA2MGxOL3JyR2poODNrdDlNb3pKVStaZGt0Q3g1SEpsbkwvNUla?=
 =?utf-8?B?K1BxTjJLZktGd1RWd00wcjQ0azdSMTQ5S1htbnJzTkNHZVg2OUFCeGNnWjhp?=
 =?utf-8?B?ZHJMRlV6SGM1TTR6VFNxeXRHeUhucS9COGIxNGlkcWFkSU5UY3NiRG82Vys2?=
 =?utf-8?B?WEQvZnNERzhsSzRyMGxTa212UC9UV2xFT0hLMWpHVkR0VWNkV0lGL2ptOElZ?=
 =?utf-8?B?bk9ib0VsOGdkdnlWYWxKNm41OXFXdjgvQVplbUVuTVdheURTRzhKYXl6aXJ5?=
 =?utf-8?B?bkkxWGNDRkduM2Yra3M2bEZUM1NleGhjQThicWcyMmxXU2wyeWhUSjZydmtI?=
 =?utf-8?B?NWhGVnRpUERESEV5UTFlbU82QnNhbHZkT1l1NXNYNEZxSWw0UmZURS8ydVZK?=
 =?utf-8?B?YXFueTkvbjhzNXplaFpjbmZKOWJGRzZua1J2SEIydUFnQUoyRjUwbzA1cmx2?=
 =?utf-8?B?Ykd4K3FTazRZbGpteThONzd6elNGcWxvN3k0SkRocDFnV2lDb2w5L3ovdkM5?=
 =?utf-8?B?dUl3b3ZBRU1BMVgwOVhPWUVnUzMvdndIOTg1UWh5UW9WaUE3aURKb3l3KzlN?=
 =?utf-8?B?SkVnTWhDcFpDbk1OT1Q3QkNyblFRTFBqRWRibFVQcHpWSk1LNFJ2S1dFb3Bn?=
 =?utf-8?Q?uEteBNdyxtA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2JpNjRndnpnTjlCYjBzdjdvMUd1YWEvM053M3YrMWZWUnBGYTJ4dW5UaUp3?=
 =?utf-8?B?NURhVHB4a2s3TDI2TEgwZHlyc3ZMd1l3VWlzbm5sV1BRSUJELzZlSUJHM0Ro?=
 =?utf-8?B?eFdSWjFTNEtSQWJZbTgxS3JPNXNXZndScTVqZys3dGpPNlR2WVl4YlBMV3hx?=
 =?utf-8?B?alVCZXg5djAyRmFLWllWMlNTdUxqbm45VjJ3SlhlRVNaVFBIa2pBeWEwdUFi?=
 =?utf-8?B?MmJZMDVtdFAxODA0aEtUNERBWHpYWEsyS05kSWQyOEM4Vmg1UUwvTnNwbmU2?=
 =?utf-8?B?ZkpwR0dWMld4SlFMaXhqUTVjd2FIaWdiLyttNVYxNlgyU1l0RDFpT3d1RGlx?=
 =?utf-8?B?dGRXdGVJVHVnVU5FRjBKOHpZbXJzK01jc1JkNGUvRWdPZEN3TjB2WTZBWFJN?=
 =?utf-8?B?aEZrVmtHNE1lc0EzN0dSRFZoWFowTmI0Vkt2TmpDajBrd1h5cW5XVC85Q1pX?=
 =?utf-8?B?dy9ZZkVYcjRkM0c5L2xpQ3F1VnVGN2NzbmhuMytjVEhTd28zQVZXOVNzUjFl?=
 =?utf-8?B?ckF0UFg3MENkeVhZR2NYMEhEYjFXMWRUQXdmWkE3TGtsdmtiaEgvdkNmQkFD?=
 =?utf-8?B?a1pCa2Y1NjA0Wm42VVNhamZzM2Z2UDFMTG15aTFpL0JTWW45eEpyT3pOczl3?=
 =?utf-8?B?SmlGRjB6YXgvK2pXM2liOXh6bUovU2ZzbGoxbkZPQjFRTUlzQnNCOU55cjh1?=
 =?utf-8?B?cnBPYnVsUUk4ZS9CY1hIRlkxQnNZTkNYaXE1ZjhmQS9ZcDk3K1BsVTNjdDR4?=
 =?utf-8?B?Qkh4bU9lc2JCc0toYW53d0tETHVVMXJQVFI3YXF5eXRFckRQWGs1Tkh3ZFVv?=
 =?utf-8?B?NEtnamhWM29zL3N6cFhjcWpGNXBMRWh0SWhkL24wL3RQM1hvUjRPSFBSdDQ0?=
 =?utf-8?B?bmhsM3h4K3BXQVcyZml4blNUbXZPd3I1cllxeUVya3hCd2YvNVRVdGtRK1pD?=
 =?utf-8?B?RE5kcTlscGg3M3RXQk5sZDdrSFhwRnZjSkQ1MzV6YzhJYmQzMS9vbG5Falc5?=
 =?utf-8?B?TXIvdDBvQzhaKzFkMURmNWIrRWFXT3FGMnJGL1BzQWtEdlNLdTV1SmxlWG1Y?=
 =?utf-8?B?SjB1Z3hXejZkMTBjeSt6SU41RFBIdVIvZ2pKYUxkdnJvUGVRTXRGeWpubkJR?=
 =?utf-8?B?YkVsZDBoMmtSckl0L0JhMmwzbUFDTnE3VXRqTVczdWI0bytrZzFzbHIxRkln?=
 =?utf-8?B?c2x5TW15d1Y4clovZ2xQeHNwdExYMGFvWmpCRGJ3MGtBRElXQ3ptQ0FTMXVY?=
 =?utf-8?B?Nk9CdURMbU05SWFEYjdUN2c4U2RQSjhmRHU5ZlFtcTdRRlllWi83Q2VqVCs5?=
 =?utf-8?B?WTFCeGZGRVpMd3RYMXZxNXhoRlNPWEM4a0tISlBpWS8yVms4eXlYREh6NWly?=
 =?utf-8?B?T2wyZVZvRTFhc0ZUNjFPTHgwUCtpMDdCaFJwWXFNanIxNHRNWDZWdUptaU1P?=
 =?utf-8?B?WXV3aU5HOU1EZEtVaEhUcUV0amhHNElzU0RwRlJSd1VWMkdVVmM0d1U5NHJp?=
 =?utf-8?B?eEQrTUJ0SWg3bWdTL1FGRFNtQ1EzUk5vUVducTRac1lkVHZNUkd4aGhoRitY?=
 =?utf-8?B?a3hIU2pTdUpLOFV3V3Q5QzMvS2NKNy9VNThIQkgzLzgwcFlOeGQzYzVsQ2h3?=
 =?utf-8?B?bE1tVlI1enY5WlQ0OEFQaGZjOUJtQ3ExVXd2N0wrcnpwSkd5YTNBakFIa2U3?=
 =?utf-8?B?Z0xDenFlMnoxNkM2NFAzSWRZQk02S1VsTDdOUkRyUTZBZDRVZTB4aTJYQ1gv?=
 =?utf-8?B?UG80YXRQQVV4N0VJTGtOZlh6c0FJQ2VYM1BDSGYveGNkWE1xVG1HVlJ0WWZP?=
 =?utf-8?B?di9kMDluaUhiS1RKbmVPV2hiSnVYRTFMRk9PaFRIaFM0UWVPUmQ0OCtDMHJR?=
 =?utf-8?B?VWNsMk5ZMjhyb0J2U240K25UcGxIQ2JMd2dJZ25lYUxMaTdKVnpFTW5wNUZi?=
 =?utf-8?B?RWRwdnJQOFd0VjEzNVp6MDJTQUJnYXVaUHp1Vko4R0xXUVVpL2xxdGhtemdj?=
 =?utf-8?B?MGd2bmkxd2NOM3l6d1drUEZqMGRHdXY4ZG9wSUR3UkEydktpZklmSkxsRURi?=
 =?utf-8?B?SUxSdEdpYnE3NXpaQVB4MXR5RTRJZFZESXEyNTZUNk9lK1JtYUpDa3JIWUZ1?=
 =?utf-8?Q?YoOmg9MKYPF6/Gw6Hcth/+6Qc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffca2e1-6f52-4546-0ca0-08dd843c99d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 21:03:17.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR7SPfxfAiFr3nMo8knWASdxtCtD3GsD7khwZoOjJCvoOh7q8bMUShNSHd7bBRFPM1BhpxqgaR9eudBhgcAEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557



On 4/25/2025 8:18 AM, Jonathan Cameron wrote:
> On Thu, 24 Apr 2025 09:17:45 -0500
> "Bowman, Terry" <terry.bowman@amd.com> wrote:
>
>> On 4/23/2025 10:04 AM, Jonathan Cameron wrote:
>>> On Wed, 26 Mar 2025 20:47:05 -0500
>>> Terry Bowman <terry.bowman@amd.com> wrote:
>>>  
>>>> The AER service driver includes a CXL-specific kfifo, intended to forward
>>>> CXL errors to the CXL driver. However, the forwarding functionality is
>>>> currently unimplemented. Update the AER driver to enable error forwarding
>>>> to the CXL driver.
>>>>
>>>> Modify the AER service driver's handle_error_source(), which is called from
>>>> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
>>>>
>>>> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
>>>> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
>>>> masks.
>>>>
>>>> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
>>>> as done in the current AER driver.
>>>>
>>>> If the error is a CXL-related error then forward it to the CXL driver for
>>>> handling using the kfifo mechanism.
>>>>
>>>> Introduce a new function forward_cxl_error(), which constructs a CXL
>>>> protocol error context using cxl_create_prot_err_info(). This context is
>>>> then passed to the CXL driver via kfifo using a 'struct work_struct'.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>  
>>> Hi Terry,
>>>
>>> Finally got back to this.  I'm not following how some of the reference
>>> counting in here is working.  It might be fine but there is a lot
>>> taking then dropping device references - some of which are taken again later.
>>>  
>>>> @@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>>>  	pci_info(rcec, "CXL: Internal errors unmasked");
>>>>  }
>>>>  
>>>> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
>>>> +{
>>>> +	int severity = info->severity;  
>>> So far this variable isn't really justified.  Maybe it makes sense later in the
>>> series?  
>> This is used below in call to cxl_create_prot_err_info().
> Sure, but why not just do
>
> if (cxl_create_prot_error_info(pdev, info->severity, &wd.err_info)) {
>
> There isn't anything modifying info->severity in between so that local
> variable is just padding out the code to no real benefit.
>

I was following a common pattern I observed where a local variable pointer is assigned
to a struct member reference when passing as a function call parameter. I suppose it helps
readability but not necessary here.

Sure, I'll make that change.

>>>> +		pci_err(pdev, "Failed to create CXL protocol error information");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);  
>>> Also this one.  A reference was acquired and dropped in cxl_create_prot_err_info()
>>> followed by retaking it here.  How do we know it is still about by this call
>>> and once we pull it off the kfifo later?  
>> Yes, this is a problem I realized after sending the series.
>>
>> The device reference incr could be changed for all the devices to the non-cleanup
>> variety. Then would add the reference incr in the caller after calling cxl_create_prot_err_info().
>> I need to look at the other calls to to cxl_create_prot_err_info() as well.
>>
>> In addition, I think we should consider adding the CXL RAS status into the struct cxl_prot_err_info.
>> This would eliminate the need for further accesses to the CXL device after being dequeued from the
>> fifo. Thoughts?
> That sounds like a reasonable solution to me.
>
> Jonathan
>
Ok.

-Terry

