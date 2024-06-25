Return-Path: <linux-pci+bounces-9240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CBD916ACF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318941F28044
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F240916EC0A;
	Tue, 25 Jun 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wyuuuHIc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC1156883;
	Tue, 25 Jun 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326501; cv=fail; b=TJB9mcD9TTjTuQQTFu0xZMqMtlk6gYmAhIhNCDMQUPW4RuDs4VlpPBNf+57Qmfl2/RjTiTIcYGFFWzOZ27ApJDBVB2AGWjA8ViT5ZAt4HD6UvnwqQw826n4bjfqFFtJakp9dJOYRotcLIGYYEMkzmyGBHNJPlZ7LlbO72yQLb6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326501; c=relaxed/simple;
	bh=teaUSGWjJcw7Gv4dMNjNwk2KSBFiPeRnmkZOPhOC1Nk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JywNy2m9fdFD5v16hd5QSMfgLdA47ZprdAHAdvyEPV0KV8mlUfOcLx/Y0FGfggfOT0TLpn4suZjHU6VEfAtGpA4/Ek4j3PG9RMg6pE2EYFoYjtXiZhx1gpgmZ1G7hSk5YLoX4yCIctj9Fsnqy51zDdXfH6P6Ad+eqno2B1gfEWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wyuuuHIc; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1Qkskeb4Da7v+itMZrejovTLubg1Z/nvkDcgRtF3DnjjxOMdFxnAM6oXYS3TUeCuARuXwNNisf64OFPM5GUJxXYvHBay46SWLJOlFQi9EWuyHKx1JTz2p/+gbwHr/FB71aXdRCFJdNjqP9ej3ZWo5/qqV9WLqYxpBe2rmd80eeQ12pM5XrH+9thkgLpAh3/xciXHX0cat/86BSI3I3cqtiCx5LLqeZsVqDigvwsGFRRYRCEjf9w4IC5K75uWWji1QJ4dICNs3aPwP0MvquTgOUuAZQY9O+DDvqLnYYYN+a2SItKhEi5wZD0jy8vqzctyLMrW4kXtwYH37A5hbKx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLEH/pibRn6dJp1nH+c2dObdF/nfZssuw8sVqJQnAmo=;
 b=EDdPu0ZCV0NcW/2REJx/536ebxL6lf+beVEykv6uitvm05qbTJKAbDKMUUXmNTN4x1phGurNHasRMeUb742112U53ou3PsTfl2Vkr+BJvHLYizjHcyTLfz2dzDhFuiKV7sDElr4PX/13Orwwu9TVVwiF/A8Wbeou84XuRyjwvLPw9Svz4abR4qFOM3pTY5psVa7tOPlImXFZ1JLG7hGlpfeemqNa5mpg7skasaTCbDEm/UdcJgE/oiv/fOBZgoBKWFU/A61urkiSKt0zVugTXutmpx1Wix+ZNyN3LLxdvLKoTpU6Ob+/dOiXCrDdbo7jSOOqH+iiRkj5hSIy0XU5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLEH/pibRn6dJp1nH+c2dObdF/nfZssuw8sVqJQnAmo=;
 b=wyuuuHIcUXN3s8iJCxHoktKMe/3mgCM7JH1imt7kfPe5nukKUj5u6yXWuc6YeOP1JhaEg2W7xg7I//F0eP3zI/HsAs5gpDU5ABk6oF5EcnS0k5Zkg4iXtm7cIJnfT1yk/3/XOLo7IpEdk5nUln/Nhvnd6r4yFa/h9MDvfTosDHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Tue, 25 Jun 2024 14:41:37 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:41:37 +0000
Message-ID: <9b44e1b6-9f56-4dea-8993-d3f3d43e9dd2@amd.com>
Date: Tue, 25 Jun 2024 09:41:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic
 notifier for reporting AER internal errors
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
 dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 ming4.li@intel.com, vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-4-terry.bowman@amd.com>
 <6675d622447ac_57ac2942c@dwillia2-xfh.jf.intel.com.notmuch>
 <ce191d03-c228-4f1e-b96a-0388220bc586@amd.com>
 <6679e94411f1d_56392941e@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6679e94411f1d_56392941e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:806:d2::7) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac91b2e-53c5-4629-d5ba-08dc9524eaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|366013|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3lYQnNnTlBLQlhXUyt1RU9Hdng2MGtCZ2dXNGpHOTRST2xhZXJlaVpacDk4?=
 =?utf-8?B?M3poN2VjdjJFYkJ5UG15QklYVkRIK0MyYUM2dXJHUFVGTWNWRDJuOUFyV0pz?=
 =?utf-8?B?VVNlOU84YWJiQTdQMHkzL1JKVXdBL0loSHYvMGl4RWRSNTRocHJLT1NBS0xz?=
 =?utf-8?B?dTgrblpnNm5udHVmL3hFODJOemZpa3pnb2JXb3JTQlpVVStVVGZqY2N4T255?=
 =?utf-8?B?cUtLTnB5YW1PZzJCcFhGRlRtQmdKRDZzemV1WEFGZkdmT0NJaUpYVjhsWTN4?=
 =?utf-8?B?N1ovdXJONDhRUndZOStwK2srYmhkS25hWE5EekFIZVBRZFZFSis2TitoVDVO?=
 =?utf-8?B?STZFSFNoU092c3VMbHhaZ1M2YnloZWJqeEZPR3NPUzJZT3dsNUtKSWE1bzdP?=
 =?utf-8?B?eWJDV25BMjNUWklBTVpuMHFwUnNjQ2pXdnlGNEg5ZEk5OWgvOTRibFhiMTBE?=
 =?utf-8?B?MEkrZTBsOHZjNzM1VWRVelFnKzhzN0tSZDJxNjBaMm1HeDJQb3lZcHFpUUlo?=
 =?utf-8?B?dU9hTlo0cnh0YThpSWVhYXVObFhyNmFCbFlMUlZDT3pGeEwwTCtiOCtwN2Zz?=
 =?utf-8?B?cXkvK0dVM3BrS013MWdpTmFweDlDWkRZNytwNGNxZFl3aTlPZ05vYUMzL1F3?=
 =?utf-8?B?ME9EVm50UE91bnViYUo4QjhnS1IraWVjLzhlZXFJQnpQSzVRUGtxbmtXR1FU?=
 =?utf-8?B?YUZvYjVpZlBSVVJYa2hySSt1VHpKc09XM3RVWVRnc3JjeDFvcU10alNCQmQv?=
 =?utf-8?B?Nnd6LzhVN29NMUxhb2VoRytLcUhnLzlLVXRuR2FFTk1JeklGdDlVbnNvcUhV?=
 =?utf-8?B?MXlhNXZUQ0Q0SCtYWWp4SWpzVUg1Ry9ZQ25NeDF4cHUxVFNHNkYvSlVzMlZa?=
 =?utf-8?B?ellLbGpiSUpOc1lCUW9Sc3g5UWtOSlhxZ0hodkJ3R0NBYjJOL0N1UkRoSjdC?=
 =?utf-8?B?YUxQdld4VWsvNjB4Z0w2NWtCWW94N2hsWWRIajdkcXJOa2J0Vytmb2RoR0U3?=
 =?utf-8?B?VTRjakM2ajR4cUxRak5XNUhrdDZTQUJuakJMSGozMHJvY0swa1NEWEtTVmNW?=
 =?utf-8?B?RU5lak9Va21JRkpkVWJlUlN0N0Q2MHB4a2U3OE1TbzNLZFRtUDk5dkF6RXlN?=
 =?utf-8?B?aC9xT3Nwai8wMVdPUGFRNHJ3V0llSlgyRDV2R0RoTzhTTGplbmxlcTBFUzZJ?=
 =?utf-8?B?ZzEyMlRFQVVIbnRvL2U1dlVIS0Q5MGxHK2pRMnp2bUx5MWdJdFVSb2I0YUto?=
 =?utf-8?B?emRsaUx0a1kwOGQ0N3V4c3Q5ZWdzcmhrRmpNTmZPdTJsL1lteXJ3aU4yRjNt?=
 =?utf-8?B?eHNKNm9ROUtDblR1ajBpeWJsNHVYWS9OYzJPZ3RzOXFWc25vcHFDaGh1THR6?=
 =?utf-8?B?T1lvT0FiKzNBYW84T2pnQi9ONDBKU0xIZEprREJiWXJKek53eVVjRHhpL1h0?=
 =?utf-8?B?SmNnZjF2WlA1M1FqNCtJR2pkbC9pa1dUa0tNYUkrV1ZYRTVza2RuM2hKL2RE?=
 =?utf-8?B?d2xUazdnbXB1YmxiZ2QwdTRLbFl2VVJweTIvSXhwTG43L0R4S29yL2FrSHM1?=
 =?utf-8?B?bDN1czZlOWRBT3pNT3JHRWJiQjZWRjEwOXdHRmd3K0FsMTlETUJCVGFIWTNM?=
 =?utf-8?B?ZkJmVEpFeDI3aUd2b2N4SkVzbUcxdFl2THVBOENyeU85YkZBNFJwY2dMcmsz?=
 =?utf-8?B?aEtVSVIwVW9FR2NLMkVEZTVQUkNJVmY1aWxJdU1MejVPbjFjd3VJRHhrMXdv?=
 =?utf-8?B?MjFvLzZZc1NyVU5Dbm5Ld3diYlE0OG1RYmVCOWgzdGRvVTlMYXlSOXhkZUNm?=
 =?utf-8?B?L3VpdVJVeVN1OW5wZ2RnR1gxQ0t6VCtpclZZN2o4U3JwejlmMFZaWFArQnU2?=
 =?utf-8?Q?jCMZS1y8G6elu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUlsOXN4K3Q0anJFTWR2YmdBdHl3RHN1Zi8xWWQxKzAzTjBUWjlNU0NkckFD?=
 =?utf-8?B?YXhpckhwaW04NnhmME4zRzNjNzZCbGxjbzhNQ0NzcDVmUldEUXRlSVhWTXFV?=
 =?utf-8?B?UlhZR1VTNkNwMitNTm9GOSt4dHFFSlZ4YzhuUVNGSW5RN2s2UXI5c3RSaUlL?=
 =?utf-8?B?Mmp0TGp1aVBGeDZ0cGR3OTNBT1ZzZFBtVFJvY1J2aGppa2hHazRYdkZHb0sy?=
 =?utf-8?B?YTQxUmlrRFdaUGV2aU5GcXNDNngzamsvaURLbC9BRGYwZldiMDRGblM5RSti?=
 =?utf-8?B?TXp4VlZhRElRK3QwZW4xTG5JWHAwcmtHck5sVDFJRXBYU2hiM25qZlZ4WG51?=
 =?utf-8?B?VC9pWTB5UGJlVm9BRGUrUFUrbC9mbnF6MEVLMDBXUWdqVE83cmU5aDI0NzEx?=
 =?utf-8?B?NkxnSktzcmd5S2Ztc2N0K00wWERzUWhKTzFRaTlQVHRyVnNSbnVWZW1RVlBx?=
 =?utf-8?B?cXNZV20wc3oyUC94VHJXQnJuemZBdVVZWityZ2tzNWQrQnhVK2wxZHBSa2pW?=
 =?utf-8?B?SGFYVjBWVEp0QzR1MDhZc1pZZzE0amZWb1lDK2kvUUxmc0xtakkxUGdHK2F6?=
 =?utf-8?B?UTBoem1JeitiRnE5eGZ2ZWtqbzhzSFlUUzdXUEdaT1RDOGxEMTkwOWlmN1ZQ?=
 =?utf-8?B?TStpUHdNYlBCK1pZQWhmaFZWZGthK1ZidU95Q0tsampGTWg4djYzelROS1cz?=
 =?utf-8?B?LzVhT1NTNkRLYU92V1h0MFYzd1NkdWZaRUlZZEkxQ2tzV0Z3WlNPZUhNUDI3?=
 =?utf-8?B?dG80M2NZQnJhVXdtK3MySlIwRGxZTjd0SXFtTCtHSHVOL2ZUZXUydllPbC9Q?=
 =?utf-8?B?RDAvekE1L1M0Yy9RN09yc21OdDNRUUFHeTRXSHV5SGR0cnJ3eit2ZFJOMmVN?=
 =?utf-8?B?QWFLSkhHZURGZ2FreVhlQndvNzkwSUZIcGtiV1g1REdUUEIrdGVVMnFsdkFT?=
 =?utf-8?B?TlBFQjEwZGUvLzgrcXhHS05ja1Vlei9DRDk4dVVJSWJEdWgrbGFBTjNqMlRW?=
 =?utf-8?B?S2IvSVRJd1Q3cGk3SURiRE5wakQrRGtIdnNETnBPdnFGN01PQ280akZVWkV2?=
 =?utf-8?B?TjVENktaMHRGdEpWb01iZjVzaEkvMnFjYkhkM2xQQXhOVXArMlF1VEo4aVBB?=
 =?utf-8?B?U3FTUXdrYlh3dHl3akkveTRTaTZQTjhwOWRUazl0a1YzRU0xY2lNaEp5NVRY?=
 =?utf-8?B?SmRxamRnWjRSbVNtZHl1YTBOTE8zWm05d2IrUEF5S2VmdW14aUdZc09EWW1x?=
 =?utf-8?B?WkdKbUNDY3VRT3pTaklxSjNFY3JVdUViSThZaTN6ZFRidjVPNHVSbXdJYXRo?=
 =?utf-8?B?STk0V1l2ZnVMRjQyS0s2T2poSkJyQ1AwbTBsZStHd2pNUFZJU3dqdDJORVY3?=
 =?utf-8?B?ZEtZa1l4Zit1VHdkN2dRYWdTVTZpTmtuWlk2WmFJNUUwaFhLeTNSSnRVTWNY?=
 =?utf-8?B?VUdsZkJGdVRYK0hNZjh4NXJYbXExaEszWEYvcG80MUJ0UEpPV3NFd0RoTGZa?=
 =?utf-8?B?aUdnSTBsUVdFWmpnc2FQK1JsUUlhVzlqRExsUnhiUFFad25EWXBmZjlEaFpn?=
 =?utf-8?B?ZUxSZ3ZyU0hPeHo0Qml0WFptcDZwSWpTLzdJV2s5V2xsYTYvRE02RWdqNWpS?=
 =?utf-8?B?Y0lBM3pQNTVHeDJJM01jcFBJZE1tQTl6TTlSNmMwOXVMaG9EdTZtL1ZaMUsv?=
 =?utf-8?B?RmRTRkRsMUFZeE56anNXU1FtU3pvTzROTVo4WlJncFA5U2VSeGhsdW90blVt?=
 =?utf-8?B?aXdNQkt5TFl6MzY5cWMvMlhpdWFMR1cvQjd1cFBCMVhkTmFFaEIzOHpQYmRq?=
 =?utf-8?B?WkZNR3Fkdm91WlA0WDlyd1huaFk4ZER4czg2MlRlejZHa2hNVzVzcTdHRWVY?=
 =?utf-8?B?N1AwNjd6UVlta0V4cC9HZzA5bklGVDBteWIwbWJiRnFpNW9HbzZmSXEzZGNS?=
 =?utf-8?B?aFdjZlM1bkpIdXI5b1Y2NXQ2MDdLSFkvdEhGQ29qcTZZdkg5TmUrcUJsbUNm?=
 =?utf-8?B?SE5UVEdzQ0JxRXF4aVFQek8xeStoU1QvNCtxVUlJckFEZHhuSnByZVdadE5q?=
 =?utf-8?B?S2h4L1FaOHFsdFZmSzh1bGdLWVlqTXRBczBYMDZHS050dnRwTlkrSHNGNkNL?=
 =?utf-8?Q?YUYmamO7bllg/0u6KkC35d9AH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac91b2e-53c5-4629-d5ba-08dc9524eaec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:41:37.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6yokkWjrb7XNJ0IcanwrZxWnm2ybPozrNDcw7N/y1Ya30a9wJfufYMFz+aKm/ZbnLOn+JLpw6FlNFMHIegErA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417



On 6/24/24 16:46, Dan Williams wrote:
> Terry Bowman wrote:
>> Hi Dan,
>>
>> I added responses inline below.
>>
>> On 6/21/24 14:36, Dan Williams wrote:
>>> Terry Bowman wrote:
>>>> PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
>>>> does not implement an AER correctable handler (CE) but does implement the
>>>> AER uncorrectable error (UCE). The UCE handler is fairly straightforward
>>>> in that it only checks for frozen error state and returns the next step
>>>> for recovery accordingly.
>>>>
>>>> As a result, port devices relying on AER correctable internal errors (CIE)
>>>> and AER uncorrectable internal errors (UIE) will not be handled. Note,
>>>> the PCIe spec indicates AER CIE/UIE can be used to report implementation
>>>> specific errors.[1]
>>>>
>>>> CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
>>>> are examples of devices using the AER CIE/UIE for implementation specific
>>>> purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
>>>> report CXL RAS errors.[2]
>>>>
>>>> Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
>>>> notifier to report CIE/UIE errors to the registered functions. This will
>>>> require adding a CE handler and updating the existing UCE handler.
>>>>
>>>> For the UCE handler, the CXL spec states UIE errors should return need
>>>> reset: "The only method of recovering from an Uncorrectable Internal Error
>>>> is reset or hardware replacement."[1]
>>>>
>>>> [1] PCI6.0 - 6.2.10 Internal Errors
>>>> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>>>              Upstream Switch Ports
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Cc: linux-pci@vger.kernel.org
>>>> ---
>>>>  drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
>>>>  drivers/pci/pcie/portdrv.h |  2 ++
>>>>  2 files changed, 34 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>>> index 14a4b89a3b83..86d80e0e9606 100644
>>>> --- a/drivers/pci/pcie/portdrv.c
>>>> +++ b/drivers/pci/pcie/portdrv.c
>>>> @@ -37,6 +37,9 @@ struct portdrv_service_data {
>>>>  	u32 service;
>>>>  };
>>>>  
>>>> +ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
>>>> +EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);
>>>> +
>>>>  /**
>>>>   * release_pcie_device - free PCI Express port service device structure
>>>>   * @dev: Port service device to release
>>>> @@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>>>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>>>>  					pci_channel_state_t error)
>>>>  {
>>>> +	if (dev->aer_cap) {
>>>> +		u32 status;
>>>> +
>>>> +		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
>>>> +				      &status);
>>>> +
>>>> +		if (status & PCI_ERR_UNC_INTN) {
>>>> +			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
>>>> +						   AER_FATAL, (void *)dev);
>>>> +			return PCI_ERS_RESULT_NEED_RESET;
>>>> +		}
>>>> +	}
>>>> +
>>>
>>> Oh, this is a finer grained  / lower-level location than I was
>>> expecting. I was expecting that the notifier was just conveying the port
>>> interrupt notification to a driver that knew how to take the next step.
>>> This pcie_portdrv_error_detected() is a notification that is already
>>> "downstream" of the AER notification.
>>>
>>
>> My intent was to implement the UIE/CIE "implementation specific" behavior as 
>> mentioned in the PCI spec. This included allowing port devices to be notified if 
>> needed. This plan is not ideal but works within the PCI portdrv situation
>> and before we can introduce a CXL specific portdriver.
> 
> ...but it really isn't implementation specific behavior like all the
> other anonymous internal error cases. This is an open standard
> definition that just happens to alias with the PCIe "internal"
> notification mechanism.
> 
>>
>>> If PCIe does not care about CIE and UIE then don't make it care, but
>>> redirect the notifications to the CXL side that may care.
>>>
>>> Leave the portdrv handlers PCIe native as much as possible.
>>>
>>> Now, I have not thought through the full implications of that
>>> suggestion, but for now am reacting to this AER -> PCIe err_handler ->
>>> CXL notfier as potentially more awkward than AER -> CXL notifier. It's a
>>> separate error handling domain that the PCIe side likely does not want
>>> to worry about. PCIe side is only responsible for allowing CXL to
>>> register for the notifications beacuse the AER interrupt is shared.
>>
>> Hmmm, this sounds like either option#2 or introducing a CXL portdrv service 
>> driver. 
>>
>> Thanks for the reviews and please let me know which option you 
>> would like me to purse.
> 
> So after looking at this patchset I think calling the PCIe portdrv error
> handler set for anything other than PCIe errors is likely a mistake. The
> CXL protocol side of the house can experience errors that have no
> relation to errors that PCIe needs to handle or care about.
> 
> I am thinking something like cxl_rch_handle_error() becomes
> cxl_handle_error() and when that successfully handles the error then no
> need to trigger pcie_do_recovery().
> 
> pcie_do_recovery() is too tightly scoped to error recovery that is
> reasonable for PCIe links. That may not be reasonable to CXL devices
> where protocol errors potentially implicate that a system memory
> transaction failed. The blast radius of CXL protocol errors are not
> constrained to single devices like the PCIe case.
> 
> With that change something like a new cxl_do_recovery() can operate on
> the cxl_port topology and know that it has exclusive control of the
> error handling registers.

Ok, I'll refactor the existing AER RCH downstream port handling to support
CXL USP, DSP, and RP as well. I can incorporate much of the feedback from 
this RFC into the new patchset.

Thanks Dan.

Regards,
Terry

