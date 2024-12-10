Return-Path: <linux-pci+bounces-17986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1199EA88C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 07:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13178286D10
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 06:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF29226197;
	Tue, 10 Dec 2024 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yJlXJUFm"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935122838D
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733810951; cv=fail; b=f72MsQ7xdQZs2v+ZmXGfhzjBPvKQr4pWvjkUMxo5CxXIpdi+trfE6zsldP9f6X0SNNZggtb0Z3oyyPteH4QbcsbWEYOwv8zKZZBIKKLgoTU2XxkfV1r675qBmE/vf8+BOu1nUQTNX2lQ1OFKE7A93BhfjoAwdDsd4JLnNssLEgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733810951; c=relaxed/simple;
	bh=vK6ft1lCedoTdSsD3hn/XZBsHI19dkf3kwgXSJAhXnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WmoxlSQ2y7zR6lXP9oWaVdehcSfI2QpmS6wtugYokl4yORAGAe5X/xj7Ys6bWexV95yWjvzrnQq9MX1N/XO7hFeLIjTndq7YJBs4hi1tpsIiy01XNcAL3QqNOP/Y2V+LuAbhkXySdboXmmd6CkwJ3kjEnSLRO2PpZU9PYy4kHWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yJlXJUFm; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaB93hybnPc/uMmv7BMSEADOE5G20UHVN/PY24k5ujLfSHh1YCGdYB1mGNRxYHbvB/tt/CKwzOeLVN02M0a6Qv9/saXaZKStN23vZNYwQ8SPnMoGGkonYkFlnlGvqObjxrNvsiogH5kwA/NLVyNQOaKQQlLtsZzNCegiw8CEBJDddGv90pDPVW9btN9TZYieYA0AvOhGkZt88cA+46tsM1L92Nu89VnVhEInGRiZe0OXYz67wtxV2F1hYodb6E+Xxv1tzn5oSD1F9CXYxTbCKwS48x2YZTbhOGAP+GAJWkTFE7etEJOVhjkDF7Wup+DFhYsiqFlMIMXYSs1e3WYmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPQ/Dq0IEYmn35Q4ojnErb/lfB7CpmMILmCQeAWQkvk=;
 b=GvJ9zlbNovRzTag7ihGJX+atryWhuCqbJRByWygMIHb1nsBOaARnFPENaEYXUVd2Qn/kzJU2StVxnBUP7bKpWzjUMV5jylY1krJFtw3XajJ2PfB2aAI/HJZWTLgOIcaOJe3opQ827ca6fC8VdVSn+HhT2mGapwSmyH0bwR73SPI3oVLW7ZbWKNGDeHfudSbW+C1tlKYvSS+g0cen8cX6PZAhWeNf8qpB70GolaSm11Sn3Yit2NS5oZGDKXRsr07ovoRWLWwbZm6g6FNb6/AACy8gDwDpngamilVNbFrD9j0efTWXvy0F0Qif0Z4xTaXvooqWqxNg9PsKyXLaqcz6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPQ/Dq0IEYmn35Q4ojnErb/lfB7CpmMILmCQeAWQkvk=;
 b=yJlXJUFmC74RDIK6gJ2lZhUVl6l3aoiLaGN4E8tj6dII5IuoT/AZcLrOR7/GyP+MHd2ki+iosJzrTZDHLqjDcMww9FEBZVFRNbaMywZ0t0TNiq+D8dEyyicYtmXki1n74XMtFlI55F0rHlBc8E+l0SUk3ciKC0J5nEjtP5YrQzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ0PR12MB5612.namprd12.prod.outlook.com (2603:10b6:a03:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Tue, 10 Dec
 2024 06:09:06 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 06:09:06 +0000
Message-ID: <a0268068-05a8-4f50-925f-d3dced88b71e@amd.com>
Date: Tue, 10 Dec 2024 17:09:03 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 02/11] coco/guest: Move shared guest CC infrastructure to
 drivers/virt/coco/guest/
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343740777.1074769.15850350070210009497.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <173343740777.1074769.15850350070210009497.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ0PR12MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: ca73d8d6-4d80-4438-794b-08dd18e1271d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkEyZXdxYkdHZit1c1QxWmFhU0lUMGV5YTNKcUZWWXJLd1dtQ2Zla3R2TjNY?=
 =?utf-8?B?Tkh5dTRMdlJSVUtVcEJMdlFRa1hqMkQvZEZrZXhadzBmUmpzK3BlYzVFSHU0?=
 =?utf-8?B?V0hUWnZ2MWlpR0JQbWFmdTE1V3Ztb0V1dmEyNFdidmpXUWRJTHFHeTZqZmFq?=
 =?utf-8?B?dXY0NUo1WnlsbzJlOTlqRlVnMlRFb091ZkQyV25DZlAxTlBWOTNremVqUVdN?=
 =?utf-8?B?ZHNQbDdhVExrcW43SEgyenNOUjloUEZzM2hIclgxbzVjRFF6aHNSTXdHc2Rh?=
 =?utf-8?B?Ky9oSDdGMEdrV3graWFFTUtCUmxrSGNVb1VlRHpMZWNOb1l4N1NvaWZLRExh?=
 =?utf-8?B?TmNyY2xUS0lwYlpvQlRhRVZIRTFCTmN6SWQ1YjdOem5aSTlQL1o1elBFRklG?=
 =?utf-8?B?eDBDNktvVzQyMVdTTWFyNU1FRE9yQzl0NjJNOVBaQzMrVzA0ZzBHVCt1YVAz?=
 =?utf-8?B?aVIrK2llYW0zbHNYeEJyTTJ2ZHRkY21aMENkdkRBOFhoemdVSTEwYTlWdERM?=
 =?utf-8?B?UStGemhibjU5Um8rUGwvUW1WWGFpQmVlVVMzRkl2SlB5anYwbDJwa2Y2T1Ir?=
 =?utf-8?B?bVc4S0tBeXVYQ3lBRnhGMWs4TXhoWGJENVdoOTFmWGwwRUtETmdEOFhHOUxJ?=
 =?utf-8?B?bXJkRnVLdFVMYVVkZlRMampHWDJ1UDFIM1o1dTMyTzREc21uRHR4TWR1VUR5?=
 =?utf-8?B?M2pEa1N3TXR1WWtIQktqNlQvNG1NTHE0ZE5xWENEYTRtYTJaNDlJbVM3blVw?=
 =?utf-8?B?RGpxMUVsSU5zcWZ6SWpMNVh6TU9tY1JtcmFDTEk1Y3VTaWkwZzlvcjhIbmVQ?=
 =?utf-8?B?RkQ2c2lUTk9xK0wraHhmSmdKVCsxcWFpckRHeWVjc1ZjK2RIc1dmcXNRYmVu?=
 =?utf-8?B?SWNNZWRPWlZreU1XNEhJQmtFMUUwTStnOHU3Mm53UDhKcHIyNFRFbDRQc2Zx?=
 =?utf-8?B?eWxaTWx5NURjMUh5Mit5OHdkdEh3am9pS3ZKVUhtUUk1RDBKZjVTNk5DbHda?=
 =?utf-8?B?WmFLMEhyME5PL0JnQUpYZW5PUHJVekdSQTlRcmJiVEkyTTByWU05ZE14d010?=
 =?utf-8?B?aHRMenlZOHhFUzY3YnNoK1ZLVUloOXZiZ3ZTNGEveUFMR0V1Qzc2c3BkN1Uz?=
 =?utf-8?B?em9KQmJPclkvNisyMncyMzhvSGlOZTFZQk1heUUwcTkzanpjY0FIK0pyYzdw?=
 =?utf-8?B?MzhlV0M2SzBqQ1JQemxYb09CTFhZU2tKVWJ4Z2VnR2tSVS9peU9hczk4U3Vp?=
 =?utf-8?B?L0YwTk5BY3BiWmk1S1BtOTllNHdEb1ppVGdRTGZXSXhjaHh6VjJpNEpNZjE3?=
 =?utf-8?B?VVdxMlg4MzZpazdCcEpySTltSERJelVNM00vQ0JxYVI3Qk9lTmRXeGt2K2NK?=
 =?utf-8?B?ZXc4RUIxV242NnFsQW5CSmNoNEJnN2IzNXB4RXJaSjlFK0c0cEJNdCtLWW91?=
 =?utf-8?B?RG14VEtXV05OOGVxQUJwNVNzUkV6a005d3dPMUQ3akt6MnNIWkI3VXlWQ3Z6?=
 =?utf-8?B?Y2ZlM216aG9FVCt3NjJmZWgzTmwxaXNZSVYvWVQzaFlKckU3aFROdTd4WlIv?=
 =?utf-8?B?Y0xuanhnMjVtRVFjeW1rQ1VUL3MyYXdSSW1JSUVjUFoxZHNkTnZOd0dqNm03?=
 =?utf-8?B?Qk5qc0lCcC82dUkyQWtvcmVPSXM4ZXdNOG5RcXAvNkdLS3VWZWRLdndzaGxx?=
 =?utf-8?B?MEpEODgrZmtFZVdQamNqaGIyQWJCa2M3UmxQbDdqaFRFSXFVQWlEaWJ0elRN?=
 =?utf-8?B?MHkwdVpneXNVampHdUEyZmFaUWdleUlhWVVWMWNUUzZNb0Z5c25QVkNOVnh0?=
 =?utf-8?B?ZVJVdmVJTmpVbEVkTmxBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXRNTFhhWXBsaDFEZ2h5MWswMVRBMm5qVzR3WDZHcS9vM2d3TDZIY2o0TXIy?=
 =?utf-8?B?cmlEbURnSld2enQrZks3QTB5Nmswb3dnd2NiQ3BZdVFQdERBQU50SVJIRTZS?=
 =?utf-8?B?bWw3TityTUlralhVTXJNZ3VIeWt0V3ZNeEhzYjBaVDFMQU85S3VNZWlqSjh3?=
 =?utf-8?B?RFRCcGtlUzdPd2pDOTUxN29FMGxtZ1o1MysrRmNsTURuNUp0a09DSDR2NWE4?=
 =?utf-8?B?cHpUMG5FdHRRZzMxNjEvNlRiOExlQVVLZTVWTkcxK0RVL253dGVneVovWUFu?=
 =?utf-8?B?eExickJvTjNteE9uRGNKbEl0dmVldk5YVFN3aWUxUk1yWEQ5NDBSU2ZPcEVu?=
 =?utf-8?B?MVdLY0JOMzZtWGpUd011N1VOcy9DckFmclY2OWw4aURWRm5ycVg1NWEyeXlX?=
 =?utf-8?B?S2xMN3dnUDVMRFgzUlVVSzhvaXZCcXZVNE9uT0ZMZkdqVHUyNEZUWXllbGpx?=
 =?utf-8?B?bk9KK1lIdVMrV0lHSHA0U2paTTcrTkUzeHdpclNRZzhsOFZJTGpHUmU5a2pY?=
 =?utf-8?B?dDNaN2lSelZRRXd1YVFldTJpUE8rZU52djltcDE3SVdCbnhKcmROVXZMdFda?=
 =?utf-8?B?b2RheFBGbkdnWlhwR3hRbHhoRU5UTXF3YVJNaVlQRTZ3NjBzRkhuVUx0SW14?=
 =?utf-8?B?NTEwYWdieWpNdzlqclU5OVFDNnVDalJST0RaMXlWYlJHOUd0a1lYTjlhcmI2?=
 =?utf-8?B?YmxxTUNXOWpmQVZCdVI2ckVsVUttd0x0d2c5VmZ3UlUzS0VOZFBOb242MGlx?=
 =?utf-8?B?bkxjVWU3Z2Jucm03ZjFqMkpON0xwSjIwZmw5dVRrR1RDU00rTHlIbXMzb0o3?=
 =?utf-8?B?TmJPUUN3R0dXdFRxVUg5TXdGa0puRXhEWjRBeUt4L3BkRUJsR1Q5WkZ1VytB?=
 =?utf-8?B?VENFMC9UNjBaK1pCNEJIZStwWkQ0ZVB1YzFra1JocmpLakFKQkQ2RDl6eXZX?=
 =?utf-8?B?VXA0K2F1Vm0xQm94bWM0Zm1vby9RTGJtYkhzOExCeFM2S0ZBK3IwMkJ2amJk?=
 =?utf-8?B?OVcvdE5RaDV0YWZidGZrQTY2dCtjV25MbGNYM3ZZekVWS0lGd3ZYaDFxQ2JS?=
 =?utf-8?B?NmhCK1VFZUN0dEdQU0taYVcxaU9BS1dNdGNVWVU5aS8weWF1RGxWUWh2UEIz?=
 =?utf-8?B?Z25ZZDVrZE0wSTRWQ0R6RFpWQnVQNVpxYXovV05RZ0crOFlqb3pUbVFTcHdX?=
 =?utf-8?B?ZnZadnRLWTc0Wk50a3FVa0NqSWNkdUFTYVNQWW1iRWY2ek9qVzdqcGZhN09Q?=
 =?utf-8?B?MkNrbkFTQzlGa0RISHZYbGF5dDZGeHdXcEVsaEJpUWtuRk16MExncUVhTkd1?=
 =?utf-8?B?a1ZJdjA5YVVSMWhjTVNlQ04yMk1vV2ZhVldYLzc1OENkQiswQnU0c082WnpK?=
 =?utf-8?B?dnJEUjlXazFsemcxaS9ZcTZKZmZmN1R2d3Y2eDVMaERYTlhPT1pKY0ZBai8x?=
 =?utf-8?B?ZnBRZjdtRStFZy9RSTNyV1Z3RGUrbGlMRWRyNTl1bG40N3g0Y1VtQ09Tc05q?=
 =?utf-8?B?QkJTdE9EUXFueUZTZUxIQkd4ekNBSDNsQUFLSFV0cnBzNXBjV1A1MFhmZTVi?=
 =?utf-8?B?UWpCenhVVWJCY2RnNU5LSUlWSXRGelQ1Z0FWZnVBYXlrZVdPcmZzbzBXTXV3?=
 =?utf-8?B?ZXIyUXBBNng1ZjlaTGJZaTRDNW9IbktoSTRMWkhST3pHQjJQVytaVjl0a09T?=
 =?utf-8?B?S2NPMU5RbGllOWFvVnRTOHltVFhRUEIzUnJkellzWHh0ZFNkdTlENnQyeE1N?=
 =?utf-8?B?TjUwbDhhd01DWEJWazVsZ0cyT29VZEsvZHAzSVltQ095cE54dVlvVzREWHB2?=
 =?utf-8?B?R1d6Rmk3NHQxNjlxS1NpdXNVdlBNNDI4cmVZRzNXbUxLM1J3ME5vUVVRUkEy?=
 =?utf-8?B?Y0FrcVo2bXRTNk1FRVRYVnVmZnZKcEF2VnRYUUx6aW9pbkpFOE40ekhqY2ZT?=
 =?utf-8?B?TitpKzlBZzNlUFRaTDdBQlo1dUpBRURqQUp0eXVTeDNDWlZmUUxucmJHSVVn?=
 =?utf-8?B?UVg4ZVN4MXVTL3pWSlhZTHQvMk9GcFd0c1dXWkhHSFlVb2dOSzE1T0ljSEZF?=
 =?utf-8?B?clUwRVZ4S2QxcnR4SStCWWZkN0dsbWdCNFlHSWFUUSs3Uk5EU2doQUx1NU5R?=
 =?utf-8?Q?YhNP1AjxF5o14sj5Ka1fqWerE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca73d8d6-4d80-4438-794b-08dd18e1271d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 06:09:06.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfohPbgdZjJiDsqvFJmdgvGzogl0A/pk+CvQENu0ES1DecMOGlY14S4cgY/hrb9oj/cvCCFVy9h8KgSvllnF+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5612

On 6/12/24 09:23, Dan Williams wrote:
> In preparation for creating a new drivers/virt/coco/host/ directory to
> house shared host driver infrastructure for confidential computing, move
> configfs-tsm to a guest/ sub-directory. The tsm.ko module is renamed to
> tsm_reports.ko. The old tsm.ko module was only ever demand loaded by
> kernel internal dependencies, so it should not affect existing userspace
> module install scripts.
> 
> The new drivers/virt/coco/guest/ is also a preparatory landing spot for
> new / optional TSM Report mechanics like a TCB stability enumeration /
> watchdog mechanism. To be added later.
> 
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

> ---
>   MAINTAINERS                      |    2 +-
>   drivers/virt/coco/Kconfig        |    6 ++----
>   drivers/virt/coco/Makefile       |    2 +-
>   drivers/virt/coco/guest/Kconfig  |    7 +++++++
>   drivers/virt/coco/guest/Makefile |    3 +++
>   drivers/virt/coco/guest/report.c |    0
>   6 files changed, 14 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/virt/coco/guest/Kconfig
>   create mode 100644 drivers/virt/coco/guest/Makefile
>   rename drivers/virt/coco/{tsm.c => guest/report.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 53f04c499705..0c8f61662836 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23843,7 +23843,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
> -F:	drivers/virt/coco/tsm.c
> +F:	drivers/virt/coco/guest/
>   F:	include/linux/tsm.h
>   
>   TRUSTED SERVICES TEE DRIVER
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index ff869d883d95..819a97e8ba99 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -3,10 +3,6 @@
>   # Confidential computing related collateral
>   #
>   
> -config TSM_REPORTS
> -	select CONFIGFS_FS
> -	tristate
> -
>   source "drivers/virt/coco/efi_secret/Kconfig"
>   
>   source "drivers/virt/coco/pkvm-guest/Kconfig"
> @@ -16,3 +12,5 @@ source "drivers/virt/coco/sev-guest/Kconfig"
>   source "drivers/virt/coco/tdx-guest/Kconfig"
>   
>   source "drivers/virt/coco/arm-cca-guest/Kconfig"
> +
> +source "drivers/virt/coco/guest/Kconfig"
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index c3d07cfc087e..885c9ef4e9fc 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -2,9 +2,9 @@
>   #
>   # Confidential computing related collateral
>   #
> -obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
>   obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
>   obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
>   obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>   obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
>   obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
> +obj-$(CONFIG_TSM_REPORTS)	+= guest/
> diff --git a/drivers/virt/coco/guest/Kconfig b/drivers/virt/coco/guest/Kconfig
> new file mode 100644
> index 000000000000..ed9bafbdd854
> --- /dev/null
> +++ b/drivers/virt/coco/guest/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Confidential computing shared guest collateral
> +#
> +config TSM_REPORTS
> +	select CONFIGFS_FS
> +	tristate
> diff --git a/drivers/virt/coco/guest/Makefile b/drivers/virt/coco/guest/Makefile
> new file mode 100644
> index 000000000000..b3b217af77cf
> --- /dev/null
> +++ b/drivers/virt/coco/guest/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_TSM_REPORTS)	+= tsm_report.o
> +tsm_report-y := report.o
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/guest/report.c
> similarity index 100%
> rename from drivers/virt/coco/tsm.c
> rename to drivers/virt/coco/guest/report.c
> 

-- 
Alexey


