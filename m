Return-Path: <linux-pci+bounces-13194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C37978A46
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 22:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802621F23582
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FCD149C41;
	Fri, 13 Sep 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P3S6NCCM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951E42042;
	Fri, 13 Sep 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261014; cv=fail; b=nweUMloIfLIUbAswAHin4ueUo/x6HAoqa38oGrVdKQVtJ1eI+MuFqv5Inb3qsgBouzy7COnJW+eYakyxR9ehjHZTbkuDYzAWn4HDyV8Kw1pPOXe9S5vKASbzo7gUB7VhzLwpqHFZldpYf/MnxfUUkedXPjOUnZyxtwDa8PKPz8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261014; c=relaxed/simple;
	bh=3Spt3GQOkN6ZldmZRQDo0acptcOsjbCCu7ZUBnixsoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=daPp7HzTPpOXzaBw2J1gnV0k5LuEsi9dq+OPJRN3CieBPYGQx83Ojfip6W2FBal4WCIDQ4K3fiUSPCgLh+rJx4a+12qB/4IAObe/HHfv0zVXdZocQZ0pZKZ/4mQ9uK68JhIeaw2ZVxqRv701/ogZM7I2QsjNU6DpR7YuXZUbtO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P3S6NCCM; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gb4OGC2m0TaRYfdrkw5cPDrmbvwQlrBRGLub7CGzWt6J4RbnGlWoCOfhgN2CpYDNo4e8N1zrJ/aKom39qs4NnKyZhDB16EdYbKS7VU4aZuLwdf6jMUK2SWNfaQiAhuM6+kzi/83JzmFvLrFJJPyW+vl7pgJEcQJ/Fy9H6V9hro9y98qksUWOGZZq93leY3uXHlBUXsNRY8yZcJ7LgxP2EfSlvkIqI1qRwaSps21aYXS/M7QuHjEDRMeAHdvwc/1kw/ykD4hCuSvsXhy5NPpUqqz4jvS+HH33sIASlwcMHPJeBzchz7aa22jvu5RrXHMTC695LWobuZR8ub5QaNcxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLF0v7aT61du0dsWdycXLbBHl0HrzzE22669qcbuPns=;
 b=JvvS5rQiitpxVsDHS5jqY2vEdyzSkIeVJkeIZAPOI48+ZlCy6XmKPSPxkwU5rDTChPDIM+9tUaoYBeWunt17iJqmwSW/T8cddWRrvAkqIP3n4lZxKru/EMAHoiRwMJjL5MmaUY8rtlTQLfgQJRR6SRVrB03MQoVKt2MSNYNEVHyIufGT8dt2LsxxuuJqqOjsMfu5M06f3ZSk5Iex+nqPo9P1gQLgK5YL/Peutd9d2p0x2A/EzTJ65opTBycJLZEJ+gi5cs9ZfQ2C8FaAnVsVxCbMI3vplYAUgS00tZJTCWC8be2RoIEfTqU6clCB6mmb/Mpa8gbj46khgN/PQaed8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLF0v7aT61du0dsWdycXLbBHl0HrzzE22669qcbuPns=;
 b=P3S6NCCM7jXCmV8FzGfaTM6sv2XhKliYoePGMJSXf7SK9+41ho/+jCrcHJMldSJcHu0lSNuYGMEii+wicPFja9Ox0fKDk80S3Cthym6i9OUNcI7earrbYt3XKuaq9dHqWa0ZQyv2A3Jz0n4/Qduy46Pdnghh5j2E18zUDgEkTbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 20:56:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 20:56:49 +0000
Message-ID: <dabbd8fa-f5ec-46fe-994b-695058195d47@amd.com>
Date: Fri, 13 Sep 2024 15:56:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Gary Li <Gary.Li@amd.com>, Mario Limonciello <superm1@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman
 <mathias.nyman@intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240903182509.GA260253@bhelgaas>
 <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
 <20240904120545.GF1532424@black.fi.intel.com>
 <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>
 <20240905093325.GJ1532424@black.fi.intel.com>
 <b4237bef-809f-4d78-8a70-d962e7eb467b@amd.com>
 <20240910091329.GI275077@black.fi.intel.com>
 <66019fa3-2f02-4b03-9eb7-7b0bed0fd044@amd.com>
 <20240913045807.GM275077@black.fi.intel.com>
 <20240913072356.GO275077@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240913072356.GO275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0fc324-d012-422b-4fad-08dcd436965a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmhHNWZXa241OUJhNGcxclcwc2M0K1BIdTJWY0JMUWNGS3E3TDBHb1ZsblRx?=
 =?utf-8?B?OHBaVHc5bTBRQnk2WHBxM1ppditJQW56RFJNenE2Um83M3Ivajk5KzNZQjRM?=
 =?utf-8?B?UHlaNzFWYXJLK0lrczdLYmMzamxwWnZxOXRCbDFJOENhampCUmhseWFxY3hk?=
 =?utf-8?B?eUJDWGdicS8vOXM2RDZyS2dYcFZwdk53SUJSRmIwUkk3eFMwYi9mM0FxKzJh?=
 =?utf-8?B?NGxtNUxUN2w5RGtORWFDZ0RwbWtWYzlSQ3lRdFBmSmVEbFVDMXJ3ekpya1M1?=
 =?utf-8?B?QW9IczUxSllHUzI2RWZGemQ2QlhWOUFqRFgxaXhzYXRGdHdmcGRML2lvWUo5?=
 =?utf-8?B?eUJoc08wVCtPKytabW1ZNlRhWFNHRHdydzI4WmJadlNtOExKQjRGeEtYY2hr?=
 =?utf-8?B?TkorSjc1YXR1SzJpeFdXdXZmQnBVRDhHY2p5R2tPWnBjcnhQK1I1WmZnU0wz?=
 =?utf-8?B?SUVQRGdHMkJrQ3RZYkRqMWRzREpoU01yS00xU0J4QWdBcDc0WkJ5Vzc5eXda?=
 =?utf-8?B?bzFCY3hsVVFGR0h3MW9zdXlGQlhrMkh0bDRQcEd3eC8rQnFYWVVhSVIvYnZt?=
 =?utf-8?B?YXFXTHVtRmU4WkFkb3dXbysrbnF4R3pVd0FrU0o4QW1yeFd1eFZuckV6L3Fl?=
 =?utf-8?B?V0d3ZnVBTVlZWlI3T2YxaDgzWFBZRjR0M1FrWGdjaUh0a2NVY2tNT0FUYS9x?=
 =?utf-8?B?Y2J5cWlpTlIzcVROZWRBY1luUVpjTkRIUUR0U2Z2dGgreXRQSS9VMzJoaTNt?=
 =?utf-8?B?V0pYR2dncDBGUm1wRDZRNE81elVGUHpDOFAwWFpmSkhlVUNTZ0FIekxiUFdr?=
 =?utf-8?B?Sk1wU2Z1ZUlJb0Z6YkhDdEpsNDJqZzdNbWxqM3BJTFFxRGo3ak1kSEM0ajgw?=
 =?utf-8?B?c050YWtvWlpkUUNwZUlMUmlKOCs0U3BOVk52eCt4SlFzRGU0SG1NUTdnSVRv?=
 =?utf-8?B?cEY5d0MreXBvSEVaR054bW9MZDdKdVBVWDlzd2Iwc2hsZURKM2MzQ3V3OGht?=
 =?utf-8?B?Ym1vVndEZnFlWVpXekxBTmxCS2t2bmtXY0JkU085R1Bad1VhS1dUMWJuT1RH?=
 =?utf-8?B?bUdsMVo4Z0pCVHdSOW1tNUhkcFJVOEdLWTVnQU1wQWRaUGZrSmdHanZoZFZM?=
 =?utf-8?B?cGZmdTR4TGZrQjFGaHg5SHhMYmk3N0pId3VDaDdtVU5CU3prTzNVUlF0d2hJ?=
 =?utf-8?B?STBZU09JaXAxUVVNU1YxQWZISjFxTG5GVnRvV0FJclZBY25XV3BDWndRRVFi?=
 =?utf-8?B?LzNZMXBSNFpiWDVaMUxMVWRBcG11bGxHN2dETGZKRTVYVCtKNjEzcmVieW1w?=
 =?utf-8?B?Zm4wTjRBeWtFV01vVnN3VDdXVnhtYkhwV2FJK1E0K2VNL2JtUk5yams5U2lH?=
 =?utf-8?B?UFYyVGowZlErUGpJVWo1WldlRWxKeXJRLzl3cTAxM3FLRCt4Sk9rVThpRllx?=
 =?utf-8?B?Z3RKNGNQK3JMci95YjBraUxCZTRYZmovek05WHZSUE1HTU1zc0t6VjNFRGFx?=
 =?utf-8?B?QUU0OUdLdytNN09DUVcyenV3ZFR0MXE1NElYT0tuOUprdzM0WjhJQk9pUm9X?=
 =?utf-8?B?V0J5Nnh6UUlEMjVrRTZ6TkNxb09UTFYyRWRxTEJwaE1maUZ2ajQvbkhVWjl0?=
 =?utf-8?B?VXk0RlV4WG80WXZWMHE0SjNyWTFLWFhFTExjSVlnNzZaTmw2WkZ3R1lzemV6?=
 =?utf-8?B?a0oxcU9WdzhQa0RXK01qdU5hSmE2L1BsWUI5SkkvWmVkZVppYnI1ZXBzUjRz?=
 =?utf-8?B?aERKV0c4WlVDc3FwdFNzM2xXR1FpV0hKSVpTbHFjTW5FZm9TeGtDbkhreVZZ?=
 =?utf-8?B?OXIrTFZpUkx2VnBNMnVXQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TSsrYURjRXk1OFJRWWE0Vld1OTNDQWIvZWVYOVNEbUtYZU9zU3FHZm82Njl2?=
 =?utf-8?B?Z3M1c0FsQWIvWWtDbjM1Z092WFNHMlhEUlk4clJvMTllK1VLbloydHlXb1Nu?=
 =?utf-8?B?amt1bUtpSkpuSXQrQlAwUEJuVWE2U1lHU0xjc3p3WXdoMzNaTjVUTXBpUDZm?=
 =?utf-8?B?ZlB4WnZrT0NFaFBGN0hSeC8yTEFIUjRxMTBWbXVtMWcrYTIwdHY0VkFlbjFR?=
 =?utf-8?B?YzNlV3FjN2JSeGx4Mitjc3psNkxVQm9QcFU4RG45UEt2ZkgwYU9KdTBnSHg5?=
 =?utf-8?B?S3FISFZYOTUyRllXTTNWWmQrRW85YVU2ejNCZEVRMEVMMXpPSUJGZ0tHdFlZ?=
 =?utf-8?B?b2dQbWpSL09QeGhweUY1ais2RHRHRFFGNlRQZ2hML3NqYXpKU0tJQ3Yxd0ZT?=
 =?utf-8?B?TkxySUZJTTVSMzJaczhnTndsbjIrTkZOWUtIc1grNkVOMDBsMytMeml6YjJj?=
 =?utf-8?B?eXdldDRWcVkyWUZkbXpPOWhhRjZJd3NxNGpYZFhWalJzNnRJTE5MUUNRL2pC?=
 =?utf-8?B?Yjk5THlBN3VTV0puQW1zQTJ2aUJrTmlsNXVINlowUUoxUjdHNFZsSnVhbCtL?=
 =?utf-8?B?ZDFJQk1NNEZYOG1rdGlJYnpDOUVxZnFVeVcrMEtCNlg2SDFGZnZLclpTeFdt?=
 =?utf-8?B?R096OEU0OVBvNmVuWUtOUEtldTQyZTJXeTZFbngyNTd6bUU0QTVQWXZzVGpJ?=
 =?utf-8?B?dVo5d1NVODdjY2F4R1pKR0creXVIQ085QUh6RG0vZXBqclhmOWlOaysvRGVp?=
 =?utf-8?B?dEluTzhVVXhBOGN6OW9CM2NnZTV0L001ZC81KzZFSVF1SnExeFAxamZ1QmEz?=
 =?utf-8?B?Q3NqdGlLbkdGTFlrd2ZrWXl4NlE3SE5DN2tRbFUzY3ZPQ3I2eEdJTEYycWVR?=
 =?utf-8?B?U1FIeXpySFMwRXVqeGxZTTlkdXpqR290dUZHMnhtTkd4eUkyZzNOMko0WUQ5?=
 =?utf-8?B?ZDB2aUNJMTh5YUFSMW9LNDl1aUlvcjhKVmN4OGozTVpkMkVCa2pZMHYvVGdw?=
 =?utf-8?B?dVU5dFFMWVFaa2x1UlVCZ0pveGsvWHhBM2pCR1pwL1ROVmYxMUtjNG83dFR4?=
 =?utf-8?B?d2ZyZmxCeXZKV1pERjV2T2pBRWozWVBWckx5UDhDdlBTdlRIdndhbEttMitT?=
 =?utf-8?B?aXNUMXpDS09VT1VObGVZeU0rUDFSUW1MUVJOU29QUHl0WDlYVkJFNUtuL25y?=
 =?utf-8?B?bjRwMHBKTVI5K3RFZ0t1SkU4Z2h1NDVLR1VLcnRaalNGUG5pdmZ6cVZBSmx0?=
 =?utf-8?B?TDdoemE2QUtES04vMDRMdlNwZ3gwdVVRdkNmaVV1YlU5VUpYa1hPTXdwVWhG?=
 =?utf-8?B?bkhCR05LY3ZaZGJOR1ltazViY3VnWThZTGI1enRrNVgyNGtFV05iem0yRStW?=
 =?utf-8?B?OE8wOUtRYURIOVNhOHd6ODRSNkd0WEJMQWxOZTRPRCsvWUdRSzNBeHc2RHVC?=
 =?utf-8?B?S241RGNobDgyRUFWTUV1cnVVeml6NTJRN01Sc1l1MHZWdEgzZ2R2Uno0MEs3?=
 =?utf-8?B?NCtBYTJVS2prSFQ0Yy9haVNPTHZTeTZWUTZoUnllZ3VndG9LN3FmSFhXNmJx?=
 =?utf-8?B?MDIyUGtoNythSEloKzcwR1NqbUEyaHd3OTdJelBoQ05kdjJMbGFqU2NBdzBY?=
 =?utf-8?B?ZUVZT2pzUzB6aGlSTFFzcTRiTmJnclRvOXNiZVRQVmlmd0xHaEVqb1c3ZnFy?=
 =?utf-8?B?eTA0dXlaNktkSVBwZHpTQmtOTlV5cDdTR2lGemVoRkJQWm5PSGhPWW45R3Va?=
 =?utf-8?B?VnpSMUp3VGdVTHlhOEtQaWZ2ejZpYUdGcHhjVWlxRzRaRnBGYWNIT3pkS0NJ?=
 =?utf-8?B?aS93ZkpYNnVsWG5oMGx2VUtMVDZ0M3FmWm02a1MxU2pZRnB1K0V2SWU0WEdo?=
 =?utf-8?B?bkhJYm9jS1BlRmxjSTkxZkpVVlBMUEU4bk1YVndHbUxmb0xTekV3Zmw1TENM?=
 =?utf-8?B?clFGUHJHaDI0SlBkbGViYktqWVhKeThTRFI3WFVQWUJtT2hnNXJ6ei8wMzNv?=
 =?utf-8?B?VGY1NDVTWDA1Y2dzV21MSWFHSjVrejJ4K2JzejR0cXJKUjQ5VDd4UmpNengr?=
 =?utf-8?B?NFhMbWROUHhMc0EyR1EwRDVUSFJGVEpkVU9Vb3VZUmFYSkpNaFR1M09EZmtX?=
 =?utf-8?Q?W/cCBb88SFB80yzaxLTOZTTkC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0fc324-d012-422b-4fad-08dcd436965a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 20:56:49.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXjVZaRB5mK+u7M0w+XQVRkRNQY94VTWIocfZc0p2d29HtNWtnA9yM3XHqQJl0PpkUR8oXG7uill0fHJo8XoeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

On 9/13/2024 02:23, Mika Westerberg wrote:
> Hi again,
> 
> On Fri, Sep 13, 2024 at 07:58:07AM +0300, Mika Westerberg wrote:
>> Yeah, I agree now. It does not look like the methods are messing each
>> other here. We don't see the GPE handler being run but I don't think it
>> matters here. For some reason the device just is not yet ready when it
>> is supposed to be in D0.
>>
>> Sorry for wasting your time with these suspects.

Don't worry about it.  It validates that we're coming to the right 
conclusions about where the problem is.

> 
> One more suggestion though ;-) I realized that my hack patch to disable
> I/O and MMIO did not actually do that because it looks like we don't
> clear those bits ever. I wonder if you could still check if the below
> changes anything? At least it should now "disable" the device to follow
> the spec.

This actually causes the system to fail to boot.  I guess some deadlock 
from other callers to pci_disable_device().

We also double checked putting the PCI_COMMAND writes just into the 
runtime suspend call backs instead (to narrow down if that is part of 
the issue here).  Putting it there fixed the boot hang, but no change to 
the actual issue behavior.

Bjorn,

Considering this finding, are you more amenable to the polling approach?

> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f412ef73a6e4..79a566376301 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1332,6 +1332,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
>   
>   	if (!pci_dev->state_saved) {
>   		pci_save_state(pci_dev);
> +		pci_pm_default_suspend(pci_dev);
>   		pci_finish_runtime_suspend(pci_dev);
>   	}
>   
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ffaaca0978cb..91f4e7a03c94 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2218,6 +2218,13 @@ static void do_pci_disable_device(struct pci_dev *dev)
>   		pci_command &= ~PCI_COMMAND_MASTER;
>   		pci_write_config_word(dev, PCI_COMMAND, pci_command);
>   	}
> +	/*
> +	 * PCI PM 1.2 sec 8.2.2 says that when a function is put into D3
> +	 * the OS needs to disable I/O and MMIO space in addition to bus
> +	 * mastering so do that here.
> +	 */
> +	pci_command &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
> +	pci_write_config_word(dev, PCI_COMMAND, pci_command);
>   
>   	pcibios_disable_device(dev);
>   }


