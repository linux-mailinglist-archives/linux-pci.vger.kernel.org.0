Return-Path: <linux-pci+bounces-14951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1F9A7373
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 21:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423F7B21AE0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A81F470E;
	Mon, 21 Oct 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIFbNXvL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8E1CF7A6;
	Mon, 21 Oct 2024 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538555; cv=fail; b=elnRTVwGD7kfhUXN4SwgwDCLj+k/bTsdekhg5bmousd/CDy/pXnllOZRVdILkPtIeDiiNGPtu/Ul6S++KtJOj7EJT3dfWrrrGR+Mp9OCIc2A76aBq5aqtljZ0lap1IjcScu5z4XxgI4ffS7qrNJ8/LKaQkQ+mKOMGWRSsOVRDUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538555; c=relaxed/simple;
	bh=wZJS5+jwAyXbWBd/dIKEeNzlP6cw0FD3FnPAnrR2SV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PWsJEO75Iuw6iy1CXPWFu3OBN3ZerglrFvTFJU5wmCPGB/OKfSjuA20PRtN9ZfLn9Oqw/C0cyBW0flgp7jsVM3tyeicKG9AJeILJRIvNCSCjxgHbtSzGX+NkUBeainprxBNTEhVGPEh/ROSrH+PPWPKyHuMnZrTI3UP/Ru1++rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIFbNXvL; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3YITQx5/Xb60IPw0gDxkrKBOh42vvqZB8QR5JGpTY2d+EB8TqCOqDMJRb00csIw6zEnu8/KWQ8jU0/60wXBDoBILfxUGuJral4y6NmPuPg9iVFaIHI0t5G57761mZoMEsknYaDP8XBbl0tLrwifex8DaJ7viEWFw+4TkjRZTpuycgMBe8r8BFj7wRG6ep3STLbAh9ZbKntZIw+jCddvIrE25Pa1SW9y3MdY64YtZhIH41Hkan39g4uIogspYipCHFSgoQF8qbyjh+RyTxvQu3yV2zqlWcaSgzxUiFOl4d0FQm/bxyzhzeIZ7rnztFw4jyL45Pm+3S8eHz/IASksrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0rg2CByZpEmb+z46lprbi/QwJOqYHF7D46Ale1e9Sc=;
 b=lKa2niagXtDBQd7jp5Xp6qt//iVXvUB7+Nql6UhJt0sIgXBRUP2zodJPRxlQqMF+0/ji7ou3LPReAJtmUE7Ov5Qy5PnTBm0wJOHbR25o+dENJV2+YhqIBdYBrpO3y2NeTh98YpTbe5x5EwIfbY1utgn+Rxtv74b4rAx4lcmUs450Yav20041b7NeVRdkReKqXaJf1W21TMT6qYzhsXNtGJfkzM/VdUriOiruRMRz21MmF+5oVaKddDKXk3bb54cfrI9FDEn6zo4iTr2zALlNdeipEQHDYeZiZ5mAgiukeTgDTdRjS5AtSOQaqxerhCUvluSTZOcftWR9NSt1bZXYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0rg2CByZpEmb+z46lprbi/QwJOqYHF7D46Ale1e9Sc=;
 b=cIFbNXvLgaCRTsjtuhYILZl1UyUKujj6jSkpFZqRlG8CDrMe4zOIuN8EgJ8WHT3fCOl9jNR8vzqoY0+6W/W1CGT7zETLMBartyBJmKB+7ynOlHdOgumJzmJo4MB7/RIzbJgnCDjdfb4WQaqKeFLP003dEXxOhXuDwd3xwGNidLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Mon, 21 Oct
 2024 19:22:27 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 19:22:26 +0000
Message-ID: <e8287712-5046-4b94-bcba-8a5aaca114b0@amd.com>
Date: Mon, 21 Oct 2024 14:22:24 -0500
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
References: <20241018232240.GA768749@bhelgaas>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241018232240.GA768749@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:806:d1::8) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 3535097f-aa3f-43cf-6261-08dcf205b27c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0FqT1NJcEt0TEFBYzl6SnpDd1E3Q3JWcE1ZTkZHL0ZaQVdhMGhnZ1BlbHR6?=
 =?utf-8?B?NUMyOGN5QUVBWUIwRVQ1a3JLWmJoaGhSOU5KbUtEOGJpbExMemd6dDdiOHBK?=
 =?utf-8?B?OVI2Snk1TVdlTXVnaVhzU0wraDVFZ2p6L2xlMHdDVXlSWjhuTkVWalpzaVFQ?=
 =?utf-8?B?UkhzWWR6aTQ3RVpHOCt3bndodmVGQ1loVlJaOFN2OWNmNE40R1l5RFdISTFY?=
 =?utf-8?B?aTVTVnA4eWd1WGEraTNiSXBIM1JKeURVb1lVYVlaVytWM0lmK1YwSGh4MW9a?=
 =?utf-8?B?NEJjcXNCa2RJQUdSZkNjb09nVnRUQTdybEdOUGpTcTVCUjBYTlRIVWZheTRX?=
 =?utf-8?B?cFVERDlnYWVpOWxucWtFSG52SjFOdm1COWVCSSsrYVhkM2JkRVhkU3JjeFc5?=
 =?utf-8?B?K3ZlWXBpZGJ4dEtwY3IwYjV5RFpvV2xWeW5qU0tHWUJpc1lvUTlOUjBWZmJD?=
 =?utf-8?B?alArZ1cyTjdkVitDbWlkOXJTSjFkR2p0UHU4cmxuMGxTTGJTOHA3WmZtNm96?=
 =?utf-8?B?eVBGdysrRzk0U1lobnRwbmJFcC9Ram5ncDNXRm9yMkZiUEx5S2FSS2FoSngv?=
 =?utf-8?B?b0tUTWQ4Y0piTWNGbVlDKzhjSWpxcmNRZEc2YXQ2cnZDYzRBNUtlYWJoYk8y?=
 =?utf-8?B?VldicjFhaXRrcUlNV1lqT0VXQW5aWlFvNjU4Q1ZvTnBSSUxDQ3pKZ2lvK2Nl?=
 =?utf-8?B?bnhqRm1LTWljRjRCVk1tZll0QitEby9vVUMvU1pLT0tMS05xQW1MSjJEQ3U5?=
 =?utf-8?B?MTFwNFRQN2VXbURxMkoyVUFJajZYQVRiam9RK0djdGZ0K080SU11anVsS21w?=
 =?utf-8?B?UHpwcjV3WTNId3BoY3lOQldhNHVYSjV3ZFRVaXBhV1lITFB0V3d2aVBaZXhY?=
 =?utf-8?B?cVJ5aTkvUUZqZTVyYmo5dVJWTEpTejlLeVZlbG82d0k1VVlPSTdMZ2p5WVo3?=
 =?utf-8?B?d0JrK1pSakw1ZkhCd3hTNEtQMWw4N2xCSTIvVjBKSHp2RGpweHdPeVJyTE5x?=
 =?utf-8?B?cWVIWCtHYVlQeE1XaUVZdkJ5eWx4K1VTckFrUjRPeEhQOVRzWkVHWVZHUkdG?=
 =?utf-8?B?RlNXbWorem5VV05LdnBYVWMvTi9yYitmMEtTL1d6cXVlSWlxcTJFbCt5YldL?=
 =?utf-8?B?VnIya3JKLzJCUVplNkZkaTY0TTVwTGM2ZDVKV1VaR0dDNGF3dTlJODJ6MjNl?=
 =?utf-8?B?T2dzTWZENkJkVjlPaVh5ODV5YmoyM3dEcjRmR2lTT3AyQTRWMWlQZUVWQy9J?=
 =?utf-8?B?UVNkYnk4VHorNVNZSEJ0YUtKMVdFNlA1eThGV3NMKzJDV1RyYms0dXlhZ05t?=
 =?utf-8?B?dmp5ZXJ4dnIzOTBRenZRUHY4TzVGT1NnSjI0bVdwT2w3M04zV0s3V2RGMFhl?=
 =?utf-8?B?MGVBM2pjMFJZbExhTmluNGMxa0krSkJtUzUraVRVOVBLTldyc1JrQ1ZqM3Yx?=
 =?utf-8?B?QTl0bjVaQU5mdC95eTIwTk9MMVFVVCtMNzNqM1kxOWRwRUs4N1hjakpMRWtW?=
 =?utf-8?B?WlFJUVRTbnJERS9iOFBVK0hwRm1xdTFWdGhpcGdXUmp2Z0N6Mm9KTGlydk5U?=
 =?utf-8?B?cmVKamdVUGhIRVFyczNPOVBXVlBycHU3Q1VwbGcza3hNcUNsRk1ib1ZHVkYr?=
 =?utf-8?B?R3ZEbU9KVjlOcFllK0lYOTJrTkxEWEFyRXJpRFhBR1BmTnNkL0syazRHeVJZ?=
 =?utf-8?B?bEduMUVCb0JyQjNPbkx4RmpYNFRUV1RZVkp6RDBzMjZxNytVMXZDWkg4K0pR?=
 =?utf-8?Q?IF88jA27kmqGR+tUUZOSfvMzM2S2lzAAcs28J+P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdtRFhKenZMNTNsZ0RPejNnVEttR3FIVUd6Q0ZnajBhcXZKUkhxcTNqaVp0?=
 =?utf-8?B?WEFuZjZCN2NScVVlVHA3c0FESDJZeFE5VU55Mm10YWNSRnVldG04a3NXVFcz?=
 =?utf-8?B?MW1ycUJ5cDNZbHVTTkFUTXZ1NVJRNkZVTTVKQ1BZbzFUazVUMDdoZ1k2TTRF?=
 =?utf-8?B?MkxBc0EzMitUZ3c0emQrVVhkaTJ5VFFBTXhFM01HODFZMmFzdG5YZ0FvV1ZV?=
 =?utf-8?B?NUxrOHVxZFZING5udTNVRzlVanQwd0lJckMvSnVPUWJzNy95U3h3TWtCYTVk?=
 =?utf-8?B?UlRGYVY0bmtUNmgvQnF4VnprbVJDYmxEQ2xVdGxwc2hIYVpwT2tWUmxRZGIx?=
 =?utf-8?B?N041bm42aTk2R2U3c0E1b2pPb1BFTkVTZG1MVm9zbWtCUHdFTll5MzhzUS9W?=
 =?utf-8?B?Smo2cGtOVnMvM05zbUJ1KzhOS1BGc01SYVFyS2l5UXZqUkdVTk5sekZTc3l6?=
 =?utf-8?B?MG1jU1gyY3FmK08yN3Rvc3QwTXdiSWlFYTN3b2FnZjBVM1NGb2RwSDhtcmts?=
 =?utf-8?B?b0ZMb2NGZkE3Z3cwcDBEeWp2N2U3N2h3dkRqL01Ia1BxTC9iZnZ6KytFL09S?=
 =?utf-8?B?elJhdjhReTdFSUNhOHh3UVlnRVUxaVNxaDZWdjJuSHJLQ2lmUk8wVzRVUmNy?=
 =?utf-8?B?Q0M5azUrNGhjWCtYTVdQdlN4bmJLUjNLWUdPbHJueFJPd2FTQ0xWY2VkTHB6?=
 =?utf-8?B?aE52MXBsRkY1NWJUOVNRRS9rNjFnK1lRVFZRUHlQcjV3YVowWEVRbVdMY0xJ?=
 =?utf-8?B?c2JSOGZxK1B4QXdpbjMwd1V3WHNZRkRhaTRlNnIvVC8zd1VaRDZ6YkxMV3px?=
 =?utf-8?B?TWxoTjRKMjh4bmpoME0rMmJTRVArVTNSdkJhMDFwci9xYUcxcjZ4aUtaaXlv?=
 =?utf-8?B?enlFanJkZElwaVQza01iSnhiM2hNV0FYanpZTmhVclFDSG5XZm1RSjBxN01x?=
 =?utf-8?B?V3RQcVJmMTVKYkNsWlVDSlFnei9nODBzVG5OTktZdVJ5YmIrYnNoQXZxY3dY?=
 =?utf-8?B?QzhBbi9VczljcnZGblFOaTVrcFFZdjZMWktFcmVnRm1LTVZIT0FZY210WUxO?=
 =?utf-8?B?NFAxUXA0Sk5QWkdKOGYxVVdTOXlBUFNiSkZ1MEtjVXBkZTZSY0xnL056ei83?=
 =?utf-8?B?NUFMK0pUNndTRVFLWE5DTzg4WnJIeWNJd1hkWVVQUHF1RTZoTjRDdmFHZ3Ni?=
 =?utf-8?B?MjJxQUs5K3FoeVI4VWRqUGhBcWp5ejhGTVRCbGdGaXJPMTNKLzZnZUlFeGJ6?=
 =?utf-8?B?aUdrWWdLbXYraUd5QlpzdTR0VDJuSkxwWlZiNS9aS25EbDZVVWhBSEhETnlq?=
 =?utf-8?B?RWo0bmF4MVNoKzhNNXdLVFBHRC9QNUtzNEZwb2h0M3FDR3pVYXhOcEtrSWto?=
 =?utf-8?B?SGZGdFIzNFNzV2E1Y3lrZHAwV0FwU1lySmowaXJWQTVzdjc4Zk9zelNOeFdP?=
 =?utf-8?B?S08vdUJnb2RSTHBrQWdUWms3YXdYazI1Q2J5dWtxTm8xWFlqMXFWVEVXRDR3?=
 =?utf-8?B?aG83M1IvcEFOcFRmaytGUHFGcGZQcUtkQzR2SEZnNnI5dUQxN1lndVdnOWNx?=
 =?utf-8?B?WlRjWVI4YVlNSTM4TDZxaFhEY0t3dTJSZ0pJOWV6ZHU0U3FuRW90dktRZE5q?=
 =?utf-8?B?OUhGMW52WFliQXhwdGlUY0IwZXhHTk8zSUVCbklwVUNoaHNKbHdidmFMMjRB?=
 =?utf-8?B?dEl5UEFKNWxnKytHLzhaT1NTZXUzWVoxd3F1UHc3eE15U1g5NXJ3a296TWhR?=
 =?utf-8?B?MjJSS2M1YjJIaVlxT1JNSW44dTFqdkhrTWIvNllNMW5ZODBJSHhiMk9QbjdI?=
 =?utf-8?B?TDFQZnpxY0RaNEdDeERodEpNMktTbENRVHg1cFlHa3NqVnpOYnB5U3czRmhN?=
 =?utf-8?B?UzBYR1BDRlRmRVNLd2hGVm1mV0xGR0phWHBWdTB6ajJQVUJ6ODFwdlpRc2dT?=
 =?utf-8?B?QUFleXBZVG1Qc3pqeVYrU2VBRituOHlTam1oTHMrY3kzYVJVL3QzeVcvVHBF?=
 =?utf-8?B?NjJ1cDJkOXE3am5PYmZqUndmNnZ1WXZhbUpJMEJvQk5WazJLbDBCbHlaeFhW?=
 =?utf-8?B?SFVHcERlT2s2cnYxd0hSSE1RMitkM3V6YlJHSDBwQ2NIODdqbmxSRVhibGtE?=
 =?utf-8?Q?xY5XIObLcl6K/sa+2lEWzZzO8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3535097f-aa3f-43cf-6261-08dcf205b27c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:22:26.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNu1lnwh3I8QNks3DZ24ZmqGCo8iwREXRqtGh9stjVa/SRnFC5+20eCnzNrSWX7EklCCm8XZSIlPyutXUdaOiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

Hi Bjorn,

I added a response below.

On 10/18/24 18:22, Bjorn Helgaas wrote:
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
> 
> Looks like all my comments at
> https://lore.kernel.org/r/20241010190726.GA570880@bhelgaas still
> apply.
> 
> URL broken across lines, distracting timestamps, patch subjects,
> no clue about the base commit.

I added changes for code reuse in pcie_do_recovery() as recommended. I am finishing
testing now and will have v2 upstreamed shortly.

Regards,
Terry

