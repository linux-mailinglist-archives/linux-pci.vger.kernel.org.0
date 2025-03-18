Return-Path: <linux-pci+bounces-24001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B0BA66720
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 04:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9643AE685
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5230E1537C6;
	Tue, 18 Mar 2025 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RG8+Sa81"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708735280
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267901; cv=fail; b=sjujefepoARNxdETJZnskS2IMfe+BSIxEQvcJwaiZ+wDh9y32tQWwVc5fiOuwHEZpJ/Elgkk0EfoJCiKHvdd+glX2K/0BwpleunuY882crb65mDf5Jk1almC6YQMo2DDJ48Oe6AXu2FnD49mY9eYqywk81B/56tfh0hWdhCoaNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267901; c=relaxed/simple;
	bh=KRLnegSZUplalAisValsmRRO3m2hgd8WiJrqjtgjBKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0wJxlrYGR+Ui+K7Y6xSLcQCzZSY/gRtdhp4ZssXKCXAg3IwCUemlJScmFhTP5MlDE4vnZqkUtvgQsqqEZnV//L8rYZ1S2FeQpx360gMuAXbhXY94Djyp9dG9SgUhJcmKESH46CLvjGli+d9360g+nLt3yHqUqRH8iW0GR0lyRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RG8+Sa81; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQ8EGosFjoWfyW1dYIeimWXVmc3PxRWhi3/opM+s0GY2kkHvi50VNSXZBAKJWr03xwoie/shoJOREndf7VtPOKAdH1XidikwaKxJS+CiPeBi8SIhgcYJLfkQ5T9YbmXxd0EluzRtNjLS1UlvueWqE0FNyx+il5z12jHU5SEiNgj7XLtNXUS4AwwHBG3Za0tJrxgn4aQGZzGl+bqaYuiRdMD495ZWlACowQuxGAJ8rJU56PJfGW04JjdwWKUOtTwSwsO/H1a26Y9ucQr3MmYfsejyYdVUZD2konxaJpuWuQdyqT2/UZekeWl4qooqY6UaNTXcZHGsmHPl6jEZe4bBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBWeZnFxgStrYcXWNKr4PFDBzfYyLyjRjGNoQDbWK/4=;
 b=wwwFrZWypISWM1A5D65BDCZcjAjwZJzZNuiww6Ls6dHlcrseLjgXOr/LozkNPzHPkRWJWO0Xu4onUHQGV5AuwzwD9VGbw0gj2InZpRi+PtxThVwKjlb4c8rOeGIVDj0l3p0EbYKD8L9rqt0NZlD69yzg0S3eG3RsMD+5VnG4yzv7gSSe0JCu9Tss2QqCq9xUnotafsovK+bTBAWIt8csNK2Ge4T33ZC+6bx5EYacjzLrDnXC3v8fOqz6i/PxIhQkYR+XemVT5/eGt445KvhYHDqAMyeJIjyU/4M88s+NG1/jrJ5DPYMQ+hj9AB8fZIUUsH3MwDxjQSJ/6RQzDRjRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBWeZnFxgStrYcXWNKr4PFDBzfYyLyjRjGNoQDbWK/4=;
 b=RG8+Sa812qdJyMyuqbn+l5JCh9G+R0iHkGTdSN8f+EX31HHhXmK+7omVyuMreq6XPyBweyrsn9vu+a+wsriho91rET/8btoi9bhsIJ6FJpVlKLVvgOnzvFTvp4oAPN2pVrwu3YqsqEJYIa0npcJxFcwsKzJFzDkhfxNopu01jdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:18:16 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:18:16 +0000
Message-ID: <e4be5f20-c3f5-47aa-aa8b-1ac714a0f238@amd.com>
Date: Tue, 18 Mar 2025 14:18:07 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 08/11] PCI/IDE: Add IDE establishment helpers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <174107250147.1288555.16948528371146013276.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME3PR01CA0037.ausprd01.prod.outlook.com
 (2603:10c6:220:f7::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a059ed7-28df-4270-07ab-08dd65cb861a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnVXWXVHSkd0dnJ1RXNwVUNGejZKcG8vYkdPWUNMcDFNVllMVkN0SGZXNmZi?=
 =?utf-8?B?YlgwYi9MdkdiWG8yUmJldThacVpFTjFWVzZnUStaUm50SUNMS0VaV3ZjZnhR?=
 =?utf-8?B?Z1FITjhNVVgwbGdmMGJIOXlkUHZpcU5jQndMcTBmaGlPOXFUd2lRU1ZxRGd1?=
 =?utf-8?B?dWwvdm8rV3dWb1J4bkM2Nm10b0JvVXJ6TzNmN043N2JXZU9BVUlHZjJnbDdD?=
 =?utf-8?B?U3o2Q3dTQUV4T1JDODllNWY3YkVHMitkSEQyZVA2TnRuVko5WExJazduM3V0?=
 =?utf-8?B?L3FjdWtTdzk5Q1BlUHBBVlVuNDU1a3oyMzlBY2ttblhKUTEyTUFNSjQwTHhK?=
 =?utf-8?B?VzMzcDhBRjI3Um5tOHdlbm45b1JQOWM1eTRnaTBvSUtFUmRqcmtxV1ZoV2NF?=
 =?utf-8?B?c1ozZlBETGZDTm9rUmZKTTBiQ3RtR3gwaTJKUjFsYWVILzg2MGMxUFY3KzZ0?=
 =?utf-8?B?a1JwY1JQV3ZoNUk1cU1wdk11TCtwRU9uZ2FYdG1xNWtLeDA3dmVlQUU5OGlr?=
 =?utf-8?B?NEgrZHUzaFhvSWt0RXBmT0tDVzFFOUJSTEkxUEtQZnVWZDdrUVJqODVuWnRV?=
 =?utf-8?B?WWRqS3pmUVZPQVRuVysyOXQzNkZYS2ZnSmVuelVCSUZwaUR5anNpeTFiNTAx?=
 =?utf-8?B?UzR2d1hEdkp3UzVuV1ZEYWJoZ0NIOS8reCtuU3VQaDd2WWRxSEVOVlJCYWVX?=
 =?utf-8?B?Qm96SERQRlhiRkkyZFFrcUdHN1NzQXVJb1lkUmdFbnJteW9mOTNJclRVYmJm?=
 =?utf-8?B?aENlWEN6K2RPeTRWOTcyYTlRdnRZb2d6MVltam9jSnlycHYwSTV1Y1ROWnpC?=
 =?utf-8?B?Rk14SEZRQjN1aDh4a1ZJTXJ6REpkb211dVBJL3RCKzkxMnhJRDJYdm5TMDZN?=
 =?utf-8?B?R2dySk1XanNXczUzb3RlUHZGVnh5K29mVm5RZTd5N0hmcHJDN3JSbTRpN0Nh?=
 =?utf-8?B?amlFSHUzVkl0ZENmVFNWQ2E1NjZRQnYyVmFOTUdPdTVIaVlaUFcyWU5XaXQ5?=
 =?utf-8?B?THZwbEZob1gyUlJMMjQzMEFXZVVCY2hZcnNYbHIzWHo5SWFxbmswQ1QvVDFk?=
 =?utf-8?B?a3pKQTRUUmE1T2xiR0tUaVFocXBkNnQ2REJjNXV4WlNzNnpNUURqbmFNNGxV?=
 =?utf-8?B?Y1JVTS96aXBiZE9JMENrVUhwNlkxa1pHN1R5aTVhRUg0Y094OUlHa1RRWEJa?=
 =?utf-8?B?TXdhQUFCUjZpejlZTzJoZXJJbG5WSmJjMlJFaFdBaE51UGcrcitPSVFzYXlD?=
 =?utf-8?B?QlZmeHhqMmFvUWx5dHc1ekorQ0VFQVE4R21jWEpweFJkMmtsOGJkeklFc2lH?=
 =?utf-8?B?ZXEvK2l0dDAyd1ptdXVzaTlnMmpwZzJXVk1UZXNRMU5tczArNzZJL1hhWjE1?=
 =?utf-8?B?eXo2bXhwSzlMTWprLzB6M0VVTVQ5aysvanoycTFpdVdYSlprZ3BSVnVZcGtH?=
 =?utf-8?B?NVVYeDVFYk1yaWo2OUx0M2JzRXAxbEprQzVXZ2k0ZG9ER3Z1d08xeEFXMmJo?=
 =?utf-8?B?VWZQeGs5THNSajVCVnEvVHVnQkoxL2dmSGhaaS93VzNVK2NJTTNxK0dSSWph?=
 =?utf-8?B?UThyUFU5Wjd4UXl0T2kycXN4VjJTQlVwOVZualFlSUlISndNN1VHZGhJaktp?=
 =?utf-8?B?bWExZUd4VllKUUZWQ1pSZnJ4TnFVWmhQUXpudVBxdXNSNWpCemQ4azMvNXVB?=
 =?utf-8?B?RzFkOFZJNjB3VXZtMHdNNlRvZjdYSUVBTnFWTE04YjVnS09NbzYzczBCR04x?=
 =?utf-8?B?SVRicFFwdDkwMkpWZmtUcUs1THVLNVdwNlJlQnJnNW5Oc21rZHIvVWdPK3o5?=
 =?utf-8?B?cnNhUWdudFFCam1VN3NRNFpwaThKZnlDMCtRTnBUQ0ljaklGMkpCQ3VkVEpn?=
 =?utf-8?Q?w0iiTOSW10tKQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUxnQ2VaMllDRkR2b3NMYm44eGM3VnJaK1VnTXlpSERpVjhrOGtNbmJrblRH?=
 =?utf-8?B?cGNXcTJDTE9vZENzK1dnbTMrM1BJbXFSZ1V3MHRoVUNWWGVEL1ZvRWVSanZ2?=
 =?utf-8?B?dnYvM0Fkdmw0dEFCSzdwZzZkTDRtV1JwbUREbGZNTC9pYlhjVy9SQ2g4Z1NC?=
 =?utf-8?B?SzI4anBzcHM1TUgzWmxrckswTS9TbFYwTXFDYUJwcUtrVnYzTDJOQWtINUhS?=
 =?utf-8?B?NDdnSUVNNEdkR3BiUGNudDdEUCs5U3hkSW5vT2hIcjRUaXk1SnZIaEJGM08v?=
 =?utf-8?B?U3FQdFh1ZWo2V2JScHJVT3d2RC83WWJ0V1dxdi9iM0trTGxsNHJOVjFHRllj?=
 =?utf-8?B?dGUvK1FyUkkyalpLSnZqeHo0N0xQbzgxTng1VDFURSs0a3c0SDQwZDNIcTQ2?=
 =?utf-8?B?WkhBU09uVUljZXdoYW9MWlg2dytqVDhpaFhUckFoUkZQRVFxeEsxeG5wdENU?=
 =?utf-8?B?OUVRN0NHRnJFTDBVZ25MQnpsbnVXb0I4NmJheTc3bVNLa1QwYnFuZEo2Z0xz?=
 =?utf-8?B?SmNnTVoyMVJYdWYvOUo1Wm10NUc0QTNrL0xFc3R0UFBpUjh3YVEwUWdDVEZ2?=
 =?utf-8?B?bjN3enJvcldyUTFyTGtwZVhweFE5UFJ0c2IxQ0cvTkVOVThFUVBRdnkvZHhI?=
 =?utf-8?B?clo3MHZZRXZrRkFkSFU5Tkk5QWVHZ1liT3ExY0NncDNaeVZHejg4UThUV2sv?=
 =?utf-8?B?T2JyU0phTjJ6dDl4MnF6TkdVZlNwaDJ2a0NUNkEwcTFwVDgrbTBNK2hObFc3?=
 =?utf-8?B?Z3hqNmxGZUVOeUprcWNadlhkMkRGZDY2RFFsLzRNQ0NDc0cxTG5USTJNWWMx?=
 =?utf-8?B?aitiRDFMRXdQWmxKZlcyWTdySkZkajlUeUpSbFl2WXpBOGhLOVNWQ1ZZMUYx?=
 =?utf-8?B?VEI3eUV5Vmw1RERoT2hTZmJEYUhyVm5lanRVVnFFM1RXY1JaY3dSbmNKZEdn?=
 =?utf-8?B?czJwM2I4OXo2V3grY0xjM2hqVXNlSVFqcTh2amV5MVpDOTFnV3B4cU9kbGcx?=
 =?utf-8?B?cTR3V1VTUG5GVUJjZFBrcTkwMHRXSzRjUWpKbVJOL0dxZ2ZSenkxQ21lVmVF?=
 =?utf-8?B?UGMyY0VmeC9SMEtaWUZuQkVFVkRVQm1oNklWUEw3YWxwK1JocnFMQjlxMXA0?=
 =?utf-8?B?R3AvdVN2QXFoL3kzbHl5RW4xbmUyNWExc1paNWtteGZSM1lNQTJ3MDZuWVBk?=
 =?utf-8?B?Mm1wdWZCT2kwazR5TlZSN2F3cExLRXFuYlJTaHY2STVoeGlKUDI1RDEvNUxk?=
 =?utf-8?B?ckYyTE9VVTlBR2ExaEZpWG42WVNYM205NWM3YSsyQm04a3Rabm8zVnNBdjkw?=
 =?utf-8?B?YW43Wjlpb2p0QitNVUNkcGhHUzNRRkFhZm10dUlXcU1yZVFLR01RZmxSL3l5?=
 =?utf-8?B?MHBmaEFEL2IwYUUybUpXVG5XQmFqRmwrNUdBWEkweHNDc3hNaVJmS2dFNXcw?=
 =?utf-8?B?ZXFoN29NK0hQMmlOWUZPWmxBTGNkUEJkY1lnZW5ZSlhJbVVpNG1tQndGRXV6?=
 =?utf-8?B?Mldpa3NzNXJyWHVmVEhJRk5OVThLVHJYL1JwMHNZNE96MWljLzl4cm1oLzR6?=
 =?utf-8?B?VzlpL2pUbmNUOWxkYXYrTGZzcFMrMGdld3dkc29iMXJ0L3pKNjVnT0Q4Sk11?=
 =?utf-8?B?SWlhZDdCTDg0TUdhMnhlVEZFd2NPVU9Ob2loaVJwUmRCV2VTTmtZclllbWV6?=
 =?utf-8?B?Y05RbGRLOUppeTNGTkQ3cTQzWGxIeERlbG9qQTBOcjdXYlBDbXpvZzBySk0r?=
 =?utf-8?B?YlVPd0duR1ZUc01mQzNqYmJzNS8weUlpSkdPRXRvVXRHcXpCaGw2R2NYQjdz?=
 =?utf-8?B?Z2RaRXorVFVTUENFNkgxSm9EWjY5am1pYkpFNjZRQ2VIVTd2Y3I0ODBuR0NI?=
 =?utf-8?B?djN2T0FGcFhjSXlsRmEvNm1EdEhicU1HcTVTak9rTGtUQUVsUWlEcEM3K0J1?=
 =?utf-8?B?dTliYkVUcC9MbFlBR1JQOHl5UEwwOE8rWC9EZ0Z5YlpHbll6SVZDYUtVNURP?=
 =?utf-8?B?SldJOHJkV3BpR3FyWkhZdnRJTjhhTFBRNjNnM3NRM3N1WWZmYjgxMEVocUZZ?=
 =?utf-8?B?UUxsemZMOUxuM2gzei8yOTJybCtXNVpRTzQwVU9mbkRzVEVxSmhLR28yS3BZ?=
 =?utf-8?Q?zwChuAdiXwrBb45rQ91IAPsGC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a059ed7-28df-4270-07ab-08dd65cb861a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 03:18:16.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkMNF5MAvHgKWGZBUperc8kDndxP7zWz1FM6LRS5bAJk41T9Mi2WHZaFYHXCAcoev21/7jFgKpYNswTzVLM5vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326



On 4/3/25 18:15, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc()
>    Allocate a Selective IDE Stream Register Block in each Partner Port
>    (Endpoint + Root Port), and reserve a host bridge / platform stream
>    slot. Gather Partner Port specific stream settings like Requester ID.
> pci_ide_stream_register()
>    Publish the stream in sysfs after allocating a Stream ID. In the TSM
>    case the TSM allocates the Stream ID for the Partner Port pair.
> pci_ide_stream_setup()
>    Program the stream settings to a Partner Port. Caller is responsible
>    for optionally calling this for the Root Port as well if the TSM
>    implementation requires it.
> pci_ide_stream_enable()
>    Run the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>      stream%d.%d.%d:%s
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values,
> and the %s is the endpoint device name.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../ABI/testing/sysfs-devices-pci-host-bridge      |   32 ++
>   drivers/pci/ide.c                                  |  352 ++++++++++++++++++++
>   include/linux/pci-ide.h                            |   60 +++
>   include/linux/pci.h                                |    6
>   4 files changed, 450 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>   create mode 100644 include/linux/pci-ide.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> new file mode 100644
> index 000000000000..51dc9eed9353
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -0,0 +1,32 @@
> +What:		/sys/devices/pciDDDD:BB
> +		/sys/devices/.../pciDDDD:BB
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		A PCI host bridge device parents a PCI bus device topology. PCI
> +		controllers may also parent host bridges. The DDDD:BB format
> +		conveys the PCI domain number and root bus number of the
> +		host bridge.
> +
> +What:		pciDDDD:BB/firmware_node
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) Symlink to the platform firmware device object "companion"
> +		of the host bridge. For example, an ACPI device with an _HID of
> +		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00).
> +
> +What:		pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a platform has established a secure connection, PCIe
> +		IDE, between two Partner Ports, this symlink appears. The
> +		primary function is to account the stream slot / resources
> +		consumed in each of the (H)ost bridge, (R)oot Port and
> +		(E)ndpoint that will be freed when invoking the tsm/disconnect
> +		flow. The link points to the endpoint PCI device at domain:DDDD
> +		bus:BB device:DD function:F. Where R and E represent the
> +		assigned Selective IDE Stream Register Block in the Root Port
> +		and Endpoint, and H represents a platform specific pool of
> +		stream resources shared by the Root Ports in a host bridge.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 193380763812..b2091f6260e6 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,6 +5,8 @@
>   
>   #define dev_fmt(fmt) "PCI/IDE: " fmt
>   #include <linux/pci.h>
> +#include <linux/sysfs.h>
> +#include <linux/pci-ide.h>
>   #include <linux/bitfield.h>
>   #include "pci.h"
>   
> @@ -85,5 +87,355 @@ void pci_ide_init(struct pci_dev *pdev)
>   
>   	pdev->ide_cap = ide_cap;
>   	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_sel_ide = nr_streams;
>   	pdev->nr_ide_mem = nr_ide_mem;
>   }
> +
> +struct stream_index {
> +	unsigned long *map;
> +	u8 max, stream_index;
> +};
> +
> +static void free_stream_index(struct stream_index *stream)
> +{
> +	clear_bit_unlock(stream->stream_index, stream->map);
> +}
> +
> +DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
> +static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
> +					       struct stream_index *stream)
> +{
> +	do {
> +		u8 stream_index = find_first_zero_bit(map, max);
> +
> +		if (stream_index == max)
> +			return NULL;
> +		if (!test_and_set_bit_lock(stream_index, map)) {
> +			*stream = (struct stream_index) {
> +				.map = map,
> +				.max = max,
> +				.stream_index = stream_index,
> +			};
> +			return stream;
> +		}
> +		/* collided with another stream acquisition */
> +	} while (1);
> +}
> +
> +/**
> + * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
> + * @pdev: IDE capable PCIe Endpoint Physical Function
> + *
> + * Retrieve the Requester ID range of @pdev for programming its Root
> + * Port IDE RID Association registers, and conversely retrieve the
> + * Requester ID of the Root Port for programming @pdev's IDE RID
> + * Association registers.
> + *
> + * Allocate a Selective IDE Stream Register Block instance per port.
> + *
> + * Allocate a platform stream resource from the associated host bridge.
> + * Retrieve stream association parameters for Requester ID range and
> + * address range restrictions for the stream.
> + */
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
> +{
> +	/* EP, RP, + HB Stream allocation */
> +	struct stream_index __stream[PCI_IDE_PARTNER_MAX + 1];
> +	struct pci_host_bridge *hb;
> +	struct pci_dev *rp;
> +	int num_vf, rid_end;
> +
> +	if (!pci_is_pcie(pdev))
> +		return NULL;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return NULL;
> +
> +	if (!pdev->ide_cap)
> +		return NULL;
> +
> +	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
> +	if (!ide)
> +		return NULL;
> +
> +	hb = pci_find_host_bridge(pdev->bus);
> +	struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
> +		hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
> +	if (!hb_stream)
> +		return NULL;
> +
> +	rp = pcie_find_root_port(pdev);
> +	struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
> +		rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
> +	if (!rp_stream)
> +		return NULL;
> +
> +	struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
> +		pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
> +	if (!ep_stream)
> +		return NULL;
> +
> +	/* for SR-IOV case, cover all VFs */
> +	num_vf = pci_num_vf(pdev);
> +	if (num_vf)
> +		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> +				    pci_iov_virtfn_devfn(pdev, num_vf));
> +	else
> +		rid_end = pci_dev_id(pdev);
> +
> +	*ide = (struct pci_ide) {
> +		.pdev = pdev,
> +		.partner = {
> +			[PCI_IDE_EP] = {
> +				.rid_start = pci_dev_id(rp),
> +				.rid_end = pci_dev_id(rp),
> +				.stream_index = no_free_ptr(ep_stream)->stream_index,
> +			},
> +			[PCI_IDE_RP] = {
> +				.rid_start = pci_dev_id(pdev),
> +				.rid_end = rid_end,
> +				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +			},
> +		},
> +		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> +		.stream_id = -1,
> +	};
> +
> +	return_ptr(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
> +
> +/**
> + * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
> + * @ide: idle IDE settings descriptor
> + *
> + * Free all of the stream index (register block) allocations acquired by
> + * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
> + * be unregistered and not instantiated in any device.
> + */
> +void pci_ide_stream_free(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
> +			 pdev->ide_stream_map);
> +	clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
> +			 rp->ide_stream_map);
> +	clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
> +	kfree(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_free);
> +
> +/**
> + * pci_ide_stream_register() - Prepare to activate an IDE Stream
> + * @ide: IDE settings descriptor
> + *
> + * After a Stream ID has been acquired for @ide, record the presence of
> + * the stream in sysfs. The expectation is that @ide is immutable while
> + * registered.
> + */
> +int pci_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	u8 ep_stream, rp_stream;
> +	int rc;
> +
> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> +		pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
> +		return -ENXIO;
> +	}
> +
> +	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
> +	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
> +	const char *name __free(kfree) = kasprintf(
> +		GFP_KERNEL, "stream%d.%d.%d:%s", ide->host_bridge_stream,
> +		rp_stream, ep_stream, dev_name(&pdev->dev));
> +	if (!name)
> +		return -ENOMEM;
> +
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
> +	if (rc)
> +		return rc;
> +
> +	ide->name = no_free_ptr(name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_register);
> +
> +/**
> + * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
> + * @ide: idle IDE settings descriptor
> + *
> + * In preparation for freeing @ide, remove sysfs enumeration for the
> + * stream.
> + */
> +void pci_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	kfree(ide->name);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
> +
> +#define SEL_ADDR1_LOWER_MASK GENMASK(31, 20)
> +#define SEL_ADDR_UPPER_MASK GENMASK_ULL(63, 32)
> +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,          \
> +		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (base))) | \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,         \
> +		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (limit))))
> +
> +#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> +	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> +	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, (base)) | \
> +	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, (domain)))
> +
> +static int ide_domain(struct pci_dev *pdev)
> +{
> +	if (pdev->fm_enabled)
> +		return pci_domain_nr(pdev->bus);
> +	return 0;
> +}
> +
> +static struct pci_ide_partner *to_settings(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return NULL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pdev != ide->pdev) {
> +			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_EP];
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
> +
> +		if (pdev != pcie_find_root_port(ide->pdev)) {
> +			pci_warn_once(pdev, "setup expected Root Port: %s\n",
> +				      pci_name(rp));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_RP];
> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return NULL;
> +	}
> +}
> +
> +/**
> + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> + * settings are written to @pdev's Selective IDE Stream register block,
> + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> + * are selected.
> + */
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> +			     pdev->nr_ide_mem);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, settings->rid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, ide_domain(pdev));
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> +
> +/**
> + * pci_ide_stream_teardown() - disable the stream and clear all settings
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * For stream destruction, zero all registers that may have been written
> + * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
> + * settings in place while temporarily disabling the stream.
> + */
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> +			     pdev->nr_ide_mem);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
> +
> +/**
> + * pci_ide_stream_enable() - after setup, enable the stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control Register.
> + */
> +void pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> +			     pdev->nr_ide_mem);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_CTL_ID_MASK, ide->stream_id) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
> +	      FIELD_PREP(PCI_IDE_SEL_CTL_EN, 1);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);


PCIe 6.1-1.0 provides an example at "Figure 6-62 IDE_KM Example":
===
Host and Device are configured with credentials for authentication.
System Firmware/Software programs, in both Ports, the IDE Extended 
Capability for the Stream to be established.
...
SPDM VENDOR_DEFINED_REQUEST (IDE_KM K_SET_GO(Tx))
SPDM VENDOR_DEFINED_RESPONSE (IDE_KM K_GOSTOP_ACK) 3 times
...
System Software / Firmware sets the Enable bit and IDE is established
===

1. write to the IDE stream cap everything except "enabled".
2. program the keys into the device.
3. write "enable" to the IDE stream cap.

Doing it in one go as you suggest works with one of my devices but not 
the other.

And to make things "clear", the spec also says:
===
It is strongly recommended to complete key programming for a Stream 
before Setting the Enable bit in the IDE Extended Capability entry for 
that Stream.
◦ It is permitted, but strongly not recommended, to Set the Enable bit 
in the IDE Extended Capability entry for a Stream prior to the 
completion of key programming for that Stream
====

So are we going to do "permitted" or not "not recommended" (== 
recommended)? Thanks,


> +
> +/**
> + * pci_ide_stream_disable() - disable the given stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Clear the Selective IDE Stream Control Register, but leave all other
> + * registers untouched.
> + */
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev->nr_link_ide, settings->stream_index,
> +			     pdev->nr_ide_mem);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..7a3f72915ee2
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#ifndef __PCI_IDE_H__
> +#define __PCI_IDE_H__
> +
> +#include <linux/range.h>
> +
> +enum pci_ide_partner_select {
> +	PCI_IDE_EP,
> +	PCI_IDE_RP,
> +	PCI_IDE_PARTNER_MAX,
> +	/* pci_ide_stream_alloc() uses this for stream index allocation */
> +	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
> +};
> +
> +/**
> + * struct pci_ide_partner - Per port IDE Stream settings
> + * @rid_start: Partner Port Requester ID range start
> + * @rid_start: Partner Port Requester ID range end
> + * @stream_index: Selective IDE Stream Register Block selection
> + */
> +struct pci_ide_partner {
> +	u16 rid_start;
> +	u16 rid_end;
> +	u8 stream_index;
> +};
> +
> +/**
> + * struct pci_ide - PCIe Selective IDE Stream descriptor
> + * @pdev: PCIe Endpoint for the stream
> + * @partner: settings for both partner ports in a stream
> + * @host_bridge_stream: track platform Stream index
> + * @stream_id: unique id (within Partner Port pairing) for the stream
> + * @name: name of the stream in sysfs
> + *
> + * Negative @stream_id values indicate "uninitialized" on the
> + * expectation that with TSM established IDE the TSM owns the stream_id
> + * allocation.
> + */
> +struct pci_ide {
> +	struct pci_dev *pdev;
> +	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
> +	u8 host_bridge_stream;
> +	int stream_id;
> +	const char *name;
> +};
> +
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
> +void pci_ide_stream_free(struct pci_ide *ide);
> +DEFINE_FREE(pci_ide_stream_free, struct pci_ide *, if (_T) pci_ide_stream_free(_T))
> +int  pci_ide_stream_register(struct pci_ide *ide);
> +void pci_ide_stream_unregister(struct pci_ide *ide);
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
> +#endif /* __PCI_IDE_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b5ea9869c2b1..0f9d6aece346 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -536,6 +536,8 @@ struct pci_dev {
>   	u16		ide_cap;	/* Link Integrity & Data Encryption */
>   	u8		nr_ide_mem;	/* Address association resources for streams */
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> +	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>   #endif
> @@ -603,6 +605,10 @@ struct pci_host_bridge {
>   	int		domain_nr;
>   	struct list_head windows;	/* resource_entry */
>   	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE
> +	u8 nr_ide_streams;		/* Track available vs in-use streams */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +#endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>   	void (*release_fn)(struct pci_host_bridge *);
> 

-- 
Alexey


