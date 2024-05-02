Return-Path: <linux-pci+bounces-7031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC38BA35D
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 00:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3E72814A3
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D686257CB0;
	Thu,  2 May 2024 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxjgxejm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD157C83
	for <linux-pci@vger.kernel.org>; Thu,  2 May 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689487; cv=fail; b=VxCwz62v0gEnT5RxnyYWfff0gqXLh8wuB96nIARKZ8MN01WYx1W6TqEV8Fwx7Cd4CqCBU3mCyGPs7d64C5DyVmKWiSjbLbC7O0Bvg7JJ+AOx2L4+aAS65sdvVF1v6UoJ3MnNkxTpUSP3RFKtp271kGLNkCk3mYoDYnjMQP60TKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689487; c=relaxed/simple;
	bh=b/+hJcv0aYImmZaQKhnneS74SSCEi/X6y6ood3xsE98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oGPT4yJt40v6c5y1CZlswB9HZ2bW1mnfINz61Px9rl6hwQ5Mswg3nH1jtof+tCb0NxPZzX0GOOVeFcBLt2DB3nThCXojCA2i3R5Fy3g0+R+PMUygncnaWvajz/gZalchQPCPAKOVbrbzK1g+FGJRtifCzow72rj8YTJOCvc6moQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxjgxejm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714689485; x=1746225485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b/+hJcv0aYImmZaQKhnneS74SSCEi/X6y6ood3xsE98=;
  b=cxjgxejmkIjJDEwbOOsssncT6cupSA9iQE5DBDi2lGtWpFRO73475NpP
   vJTJor/dDU3OckQu4gV38vlUfJNzw7pf/pHaJbmjQUF9HycNXnHw3SoY7
   cb4ISAQlfCFFmOXmCZKVD9rbFJRp4gtDMmwMQ8fjSyJDXKLp7K9m4/6gD
   u4MvFXW3kXdn10afciKvKD34aX8ZfVkOihhkAE6JumAbBjK6p3rmIXddU
   0W+DTOmvDzSZcsJi3gS+fw09dsFUUhUxb/Sf1+brMeRC4jabTD/Rh3JjY
   Py+xPN4OFQixWKa04Jv59XPMtYytAWVLqEMfbI/sgvEg5hImdTV271E5w
   A==;
X-CSE-ConnectionGUID: s180c5BQSeapXAklVqqC8A==
X-CSE-MsgGUID: 7/fXjPfpRxC/R/gjla07IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10362420"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10362420"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 15:38:05 -0700
X-CSE-ConnectionGUID: PV5GiL3vS72GPSJNMXGJsA==
X-CSE-MsgGUID: k/K5kRywQBaEpAjBH9X8PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27381117"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 15:38:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 15:38:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 15:38:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 15:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRi8S1XgjrjimGtCUjTXyxoNUmjpAvfumgs0cYdeERwPE05gH9o2D68I0tv4FqLzgTM9EhcpJlMdu2lYDtSE93m4MreYuKRX9IyQZsGhxe+P5DuJ5LBppPsfyz8W5NBao0lsRKm6VKwdUy9WjMYD2C8R6Cgtp0cRsUF3cgCHU0Acu73EBFhsQM1BcLB16L/ZRJIq+uCEDDjjMBTUpV40cVgJiehdRZ3sefpstV3lgrjW9S5bhoCH2bp0sPhkfwFNJLDSDGMdLmdeSd1I9Jm9WaDTDIkRmoLXxVqg6LV9iBr/cquQGs0fZ+OH15i64uDYhW/jPwRIljvBGub2buwc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZzWnPZa44IqW2QIlo037lgLAJE8N414UbgPfkFpGeE=;
 b=iJZqRqN2ZKa+uz8Bwsn8AbecezKc/w3Q6y7E196Z1/xQL8dned5NAll4ThusXmCeP/42N+eHITyDB2+KMGQSSdWle3/irrZOGRPK5eIMnRJ63t0xtesVMZcGptsLQexCkv3WdKCAEwmajA2Neh2W8DNZXQrc4Wnhp+YufbLWta8R4YF400Vq/gDpd7rBufSJiSpdhx4wGt+SPDKrC2L9AGnIiqr7iv3KbP6XR9S19Ahxr+l+FZPnhhSKWaWgRaPatr0kilS7/YCQz08FUfxrqNG5Fzc7ksRiToDMP3TXgyb0IaoIz00kPvCSEQfNrgxGxzBFg+9JiOCIO88JgjoCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Thu, 2 May
 2024 22:38:02 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 22:38:02 +0000
Message-ID: <bafed3eb-f698-41fa-867c-bfec87e429a4@intel.com>
Date: Thu, 2 May 2024 15:38:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: vmd: always enable host bridge hotplug support
 flags
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>
References: <20240502220836.GA1550644@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240502220836.GA1550644@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:303:83::19) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|CYYPR11MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: e91782b7-2b12-4163-0154-08dc6af8868d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGN2bElZSzN1U05tR0JmT1ZneVBHRlNubDFwM0laZktMdjd4TGFIdUtCNkdv?=
 =?utf-8?B?TElMVWRRY1FGUUV2YmFBcjlwSmFFSUVHQzA4QXRBRmRqQ3k2RUtWaXRERGc0?=
 =?utf-8?B?NkNERXJBWWxMZDM2MVBJdzFRTitjVHRIRStkQTcwQUxDeTd0RVNpbDFZaExa?=
 =?utf-8?B?aFplSGVBM2syK2orVDdjZnJpRXl2OXRmSFo4S3prRjFvNzM2dkhWazVWZzc4?=
 =?utf-8?B?VjVocGRyNWE1eVlubEtzcmlYbWU2bC93dkg3M3dpK3dIQ1VxWlQ1azVjVXBQ?=
 =?utf-8?B?dHpzemNCa2JrMUt4TzBpVlhSQ21rTHl5KzNpQ2wzYjkxSlRKK0xudlltbkVz?=
 =?utf-8?B?dzZKaGFSaHhtUlJGSzgzVmZCc0RFdzQyckJQbFFMQkxXSGJnZk5XTXcxbWRE?=
 =?utf-8?B?cXVkM1FncTdXUXFmRHNZd1pXRlZoTGlKVkxJS1c3cG5lYk1oVThTUTBJcHNn?=
 =?utf-8?B?MW45ekxHUUxRbTJUSG54cW5mbnozbkVPT1JkTHdkSnJXeDlvbHpaK3kyaFBy?=
 =?utf-8?B?U0p3REJHcnA2Sjdjbi8xVU1uOWFqREFVMnBpVC8vQW1oTFRwRWtxYWRWZlli?=
 =?utf-8?B?OW1oZ09KNWN5OTB1aEpUVVI0RVNPMVRxMm9rRldYTmNsMkhucW9Fc3ROUHVY?=
 =?utf-8?B?cXdUa2RuTFpvcENFMWVpSnZnM1ZFdkZxcG50SGt6NTF5WC9BRUU5MVQzb1Vj?=
 =?utf-8?B?U2I2VW4wYTg3aDVpY203R29ia0xqNnhjWlliVDlKZmhRbER0SnkvNytiVWp3?=
 =?utf-8?B?Qkt4Z2N4TWNqMHhSZHU3aWpQVFlrU3VUUDBBTGEzRTVXUHlmTlBySFlIL1p5?=
 =?utf-8?B?ODYvUzdPU2wyeHcyaHkrblZSdVUrdVMrZmdla0JRMm9Ud1o5SjhtbXdhYlk4?=
 =?utf-8?B?WGdRL0d3NEJ0SjdkOEltQjhTQit0OWpqaTZQSnNxU1ZjblV5bVROSTc4YWVE?=
 =?utf-8?B?eG85elo2RGFmZzF2NjN4RVNFTnNLNEo2RTd4eER3NVQ5UUhuWVhBdzMxZkV0?=
 =?utf-8?B?SWVMSW5WZitMMXJoK0QvaUlCZlFvVytwc21KdFh0TkFZM2NsNEY4NVUxeHh0?=
 =?utf-8?B?RktHQW5TOEplc1h2VG1LNm9HZ3RUZG5oemhGZzI4UHoyZGRqa3JvRXJyaUNn?=
 =?utf-8?B?Zi94aHprK0pHaVV4aERGS0ZkM1l0TlRKN1FkVk9BdlBqZFkveC9vOVcyTmVi?=
 =?utf-8?B?aXIxQXlrOUwwdGJESlVpRHU4dnRIRnBXTEw1bEJ0R0lFRmVMb3AzNUZyL3Bn?=
 =?utf-8?B?aWhpZXNSSGZHSUZRWDl2MWc0d1VZMDdkZVUrc1NLQzdjeUJiZFEwWENpWWZi?=
 =?utf-8?B?QTVRbmFtc01FSnZ2WVdGd2F1QmM0RENaV0k1S3hhNkRUWWQ3bXBxMzBmNERt?=
 =?utf-8?B?VmhieGltakgzVjdxdzFaaEVUQk5UVnZ3NWJrQWtlQjVOdUdnTXZHVUloU2NU?=
 =?utf-8?B?SnFhbmhRR2FEZUh1eC9yR1c4ZURXaVZ1S3BwYXBEZTRSSXd3Z1FGY01XQmlB?=
 =?utf-8?B?Ni9ES3ljaUdZTk5iNTlmN3JvWDZLUDdCTjJIU21zaS90bnRjSGlUMy9mNU1Y?=
 =?utf-8?B?RjZ1MVVnNDlCWkcvRlM3QlBvNmduSWJsMzJWZ1ZtTGFKbkZpWUUrMTd2VzNE?=
 =?utf-8?B?d2xOWEdrNE9MSndtS0JDN29NQmc0YzFhN29NclhjLzE0MmJiQW54OHJIVDJy?=
 =?utf-8?B?TE1QSUwrMjVzYUdHcHhBQmxkR0RRWlJ3VWpkU3EwSzJrYnJ4SG9hc2dRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amRWblJtRDNNTFl2UTNMWndVSmpJbUtZQTdGcVFmb2I2QTRRUzlsZEljczVv?=
 =?utf-8?B?TGs4eTB0N3FIQWUrL0ZWSnZpdERMMlFTSlc4cDl5M2lIaFdkbENZY09ZN21o?=
 =?utf-8?B?N1dNa1lYTzR5Q1RZVXJMbVRyaDlYdTFKaWt3bEdmRTlzR3grYi9ZNjBXR3BU?=
 =?utf-8?B?UlVDMXlOQjRHWlBPcXN1S0cyWW1DVzZSQnBrdVdlVjRVcFd5dmxCakh2WkJY?=
 =?utf-8?B?aVpMdWtXaGFyNlk1K3UxWDMwcmpNTEtMbzVyTVVGNTdOdXpPMk5TamJqWFE5?=
 =?utf-8?B?OC9EVWtZWWliNFdzTUQrL211bWtWQmlRNjZCeVAvQ256YTJ4SnVNdyttQ2V0?=
 =?utf-8?B?cHNRK0d3RytvVDB5WUhZUzN2bnBGNjRONGV4a1hrM25VZy9sVitqNGcxazFk?=
 =?utf-8?B?dnMvMHRUQ3ZhaU85RlFBOHlZbnBMSnZGOCt2TDZwa25IRWMwaEZmSW1OU29l?=
 =?utf-8?B?UTBnQlkrMlFTSm9IMnJOcEd2djZmb1lFQzVpZ0tOekVncU9PUGZrVU11UXRZ?=
 =?utf-8?B?c0hCeFY2Zm1FMlkzS2FrZjhLQUErd0tXNWVSbnRFWEhKeHBTeHVTd201b3Iv?=
 =?utf-8?B?Wk5tY2Z1MzAxSXliTlVGOVBSQnNpSUNCOFVxbjJqVnNrSk1YcWk0cGQwaFpU?=
 =?utf-8?B?OTZLZ2FJdkhUdWMxTThtRmVacHNJTTcxWDAzSlUrcitVckpXSEhRVG9kcGN3?=
 =?utf-8?B?MUJUMk5xOU8ra0Mrdm1hd2tKdDA2bE9DbGlRNTdmeGdTbS93bW1rUkVYa2tG?=
 =?utf-8?B?OGtKUGRjMW85TjRBVWlpcUFDd0RLeGgwc2RrL2UrVkhTKzNIMHJEaVo2N2w1?=
 =?utf-8?B?a3ZtNklMN1Rzc1VpUWZnUjQyeHp2VDh5MTc2bWVoSnNvWlVBVFg4Sk8vaCtS?=
 =?utf-8?B?QlRWdU5RREdaK01MYXI1UGt6ek5ZQnJuSmNWY0t2Vmx3MkViaExoRlVPVEYz?=
 =?utf-8?B?YTVNQlNvS2MvQ05hajNlbGdFQ3RTRE5CUmVaNEhRd2NZWTJwNmhaRFFIcEtl?=
 =?utf-8?B?NmhYTXFiYkFmTGdLV0NzblUxZ1BGcWo5YmR2L2w5ckR4QUdkczlNb0VvdG44?=
 =?utf-8?B?ZnZ2aVdQcWtxQUFjbXV6dEJ3YjJnTEUvbHJ0dDdla3d6L01sT1lrcXFvMkU0?=
 =?utf-8?B?ZzhLNlRrd0gwKzRLMGYzQ0Z0TkNjS2RKTmc4Y25EWVhFZjN1djMzTXdiQytG?=
 =?utf-8?B?Nks4TnlyMHIycTJieTdtKzZjcm0zMWF2MkhtK3dqN1F3N1o4M0JoaHFoQXVZ?=
 =?utf-8?B?NDY5QVJYODhDN0RRejVpOTBTTDhndkVzVE5CSmp2dmdETk9iODlpd0JZZ1ZJ?=
 =?utf-8?B?T01oNU1ucm1wYkgrRkRGcjNNeEZUQ2s4dWE3YlF1YWxkQ3RSNlh6WmpidmdO?=
 =?utf-8?B?cERqQVBEZ3JhMStsQW55NFRPOVNabGp0MEM3bzhKN3pqZTVGMEs5YUtVNlpB?=
 =?utf-8?B?S3puQ1FCdC9sVWlIM3IvUW83R1lNSUdnY1FGM3dXZjQxZTJkTWoyb2h1VVVa?=
 =?utf-8?B?WjJyaEVMZEVGY2hUZGUvc21RTC9CdksvdDA5QjBMWjFZMEs5dVA2UUNJZDBi?=
 =?utf-8?B?OHlOSG13ZWlwcG5VeVh0cElsSEg4a1lJcFlSQVVjMVJwNEhiaEZ0RXdFZG5N?=
 =?utf-8?B?aDlzZDMzbzF4VXBrUUVseml5MXVQZUd3RlljcTdmWkFrM0c1TS8wNlQrT0tC?=
 =?utf-8?B?WkZ0aFlMejJpV3RYZnQ0MmxVQmZWZ2hlamg5VStDM1FrS0tJWlQ0UmtYV1U0?=
 =?utf-8?B?YmVFZnUyc2RKekNHTDMrZnZWVklwUitBS0VVNEwxZ1Zab1pnMkFDNjhzeHlL?=
 =?utf-8?B?MkIvc0lOUEo1WnhaUnZFc3JiVXMxSzIzYkMwR3hYUlJOZ3d3TnFYSGZqSndw?=
 =?utf-8?B?YmZXQktlL00zZnMvTENHQkpCS1JiTCs1R3pCNmx6dTdmcVpmYmFZYThBMjRQ?=
 =?utf-8?B?aXRGVFRLSVV2a1p0aXFQT010MHdnd01uSlhaUnVnc09tbWRrVXVVNTI5SWRs?=
 =?utf-8?B?Z0xkeTgvRTJhdTJLdjB2M0ozeTNMcHRxVWMxWXZmNXBkczlkSEVqekdxaWtF?=
 =?utf-8?B?ZzRyMFBqZXZFbHQ1eEU2U3RoWHlVeFNyU2hyaWtFS0xaZmNWbDZuM0EwVDV6?=
 =?utf-8?B?VGt1dll1MWtOclBjRnZmNXhwVHg1TFhad2hRRkdtQUsvSjE1UE9VM3ZBbENC?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e91782b7-2b12-4163-0154-08dc6af8868d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 22:38:02.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4/dfIw8R7fgk2xi2xhTVW4oD87ebdMt1Kk+XlB9ir/2VSh9mhDC4KLhqqtsYdeAGijqoM9+x0EhLt43qLd/l0QOxilzQAR5ECC9Vs3igbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com

On 5/2/2024 3:08 PM, Bjorn Helgaas wrote:
> On Mon, Apr 08, 2024 at 11:39:27AM -0700, Paul M Stillwell Jr wrote:
>> Commit 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") added
>> code to copy the _OSC flags from the root bridge to the host bridge for each
>> vmd device because the AER bits were not being set correctly which was
>> causing an AER interrupt storm for certain NVMe devices.
>>
>> This works fine in bare metal environments, but causes problems when the
>> vmd driver is run in a hypervisor environment. In a hypervisor all the
>> _OSC bits are 0 despite what the underlying hardware indicates. This is
>> a problem for vmd users because if vmd is enabled the user *always*
>> wants hotplug support enabled. To solve this issue the vmd driver always
>> enables the hotplug bits in the host bridge structure for each vmd.
>>
>> Fixes: 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features")
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>> ---
>>   drivers/pci/controller/vmd.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 87b7856f375a..583b10bd5eb7 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -730,8 +730,14 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>>   static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>>   				       struct pci_host_bridge *vmd_bridge)
>>   {
>> -	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
>> -	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
>> +	/*
>> +	 * there is an issue when the vmd driver is running within a hypervisor
>> +	 * because all of the _OSC bits are 0 in that case. this disables
>> +	 * hotplug support, but users who enable VMD in their BIOS always want
>> +	 * hotplug suuport so always enable it.
>> +	 */
>> +	vmd_bridge->native_pcie_hotplug = 1;
>> +	vmd_bridge->native_shpc_hotplug = 1;
> 
> Deferred for now because I think we need to figure out how to set all
> these bits the same, or at least with a better algorithm than "here's
> what we want in this environment."
> 
> Extended discussion about this at
> https://lore.kernel.org/r/20240417201542.102-1-paul.m.stillwell.jr@intel.com
> 

That's ok by me. I thought where we left it was that if we could find a 
solution to the Correctable Errors from the original issue that maybe we 
could revert 04b12ef163d1.

I'm not sure I would know if a patch that fixes the Correctable Errors 
comes in... We have a test case we would like to test against that was 
pre 04b12ef163d1 (BIOS has AER disabled and we hotplug a disk which 
results in AER interrupts) so we would be curious if the issues we saw 
before goes away with a new patch for Correctable Errors.

Paul
>>   	vmd_bridge->native_aer = root_bridge->native_aer;
>>   	vmd_bridge->native_pme = root_bridge->native_pme;
>>   	vmd_bridge->native_ltr = root_bridge->native_ltr;
>> -- 
>> 2.39.1
>>
> 


