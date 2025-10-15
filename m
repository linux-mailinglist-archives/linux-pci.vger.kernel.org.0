Return-Path: <linux-pci+bounces-38183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9298EBDD9CD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6794E5A87
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B730AD0C;
	Wed, 15 Oct 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LygnzaNK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC54307ADE;
	Wed, 15 Oct 2025 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519349; cv=fail; b=ahrOGZdqtguHdgjgFVGkeB1HRLdZqGNNsoQZ8iMt80Uxx9bmhLEzYSJ5hyeiNoTkq+r9fnRSXhynsurJuG/CYJ8/gwWL6B1us9pVXIaFJ771tqB8BV4MNlIZlMSizptYwR2PJU3dniZSLQEdMulQlphhBqld+Rt3mqgQYrPJjaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519349; c=relaxed/simple;
	bh=ZWNQhYdjlDKsxnqyETAQx5YqM5nwa+jcplBG2DtvVwU=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tCF1bvW/PjCHDSXP9wz36UbTqLWPn9ufeihKuf4J1I1KCtIJx2ISnWUy7JMOsfKl4pS60yPwt5KIqcfnV7yHgOQ9FTQ1VEkYv+7MXHOVF2DKuCbpNGpm4Uida/Xtsl2FahUE9ylHFUXgjQ5L9cONHosWgwLUnWOL63epiNkFneU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LygnzaNK; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760519348; x=1792055348;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZWNQhYdjlDKsxnqyETAQx5YqM5nwa+jcplBG2DtvVwU=;
  b=LygnzaNKnt4u4VOI8DPIipXGXMPm+SW0NQC9Ns3TtQTg3aPl60jIKOYO
   UoHrZNKnm6iNmx4uY/1/wDuo00JkShl2y8OpxMnbUdBsMK49y+LTsA3OC
   CXBlkcKaNdaYAOBQ96TQzqG9HgJcuI9TuDagC+GmTVkQIBc9cCdXq5rab
   0YDVaf7W5zrprePW5tf6KvYRD71qpLa3A+sbi1TsZwz1jfRe0pZrm7hzk
   LKXh9XNqIHbCjEd28O0q+j5rum2gjJ/oI3v1X4vDFF2EADx+k3NWTcGsp
   FlWCeAm5OLmNYSO5If6PimfnDp/F6RUMqA3A1voT0JW12UZWtc7JkgQPZ
   g==;
X-CSE-ConnectionGUID: 79o/p/LZTiyM9OMUF8q3KQ==
X-CSE-MsgGUID: h0SRVfdKSJi9vrqLZLsZUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73289895"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="73289895"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:09:05 -0700
X-CSE-ConnectionGUID: 8aI/sgjSTgO8gSd0hjCsjA==
X-CSE-MsgGUID: O1jIGY1JTYWejWrUyiHOug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="187413133"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:09:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 02:09:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 02:09:04 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 02:09:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJZDk63Sxm/r/r0wRAuWcEYhsWqPzfAXQlM95HXbJqyNJGSoKSvjwHN7jQHpqAYFGFYlQfj0o/EKXvsGdD7wX9WsQRYFaTP+OCSPKnEwAO8nayvPg52pujylaqgpZNQaWfJhXcdO9Q0rNWnK8OHbV67HStDt2w3VRAE5wsP5MgSfJ7DTl6Bx3famnXrQ/cMgtiXIA/6S+MAXfErPaSaqfmC1cJxsW12ce+l3HjA1qOd9FkGfmO3alTuT7zsnyyWqIvU+YSxVz7QqBSRIZKL/mKd7IWuFMLVptKSAV+bzlWQND7C9w8MOstAvLG3r/C6wwtuymkg8cAEJ/3rqWorevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fA9sJpEGjBlx1xCd7I5cXFdEvtR8yav5GEoqakZMmQ=;
 b=n+np+ozX/IhIfHHBCSo0ojzNiKYD5Iu+TC2BCC24e9be+go/GkWubmKZv45ecKT6Uyp2qRxL+BD7vArFIks3KFDqY6B+NmwfBCRcri4UYUshbhv7l0vU6vzAOMDqpvNlSnNlUYzelbvU8nxragOXHdD3uXEb0cA3nChluTvw3rXxaeJlrVWCJ2PlX2FWhWnKCmV/3dyeoVk0/p9eXNbisDMGAFbl0SBozaEBMdASJMNuXgdL7XcThICm8j92A+EH9VBiNO2/0nl6qavZCSr2vawjVVTQRbLeJ5CKb0PBtDlDok4HFFVR4JMvQUB98DCr0eHbxF5ZmOR0O8/6ZicAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 09:08:56 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 09:08:56 +0000
Message-ID: <785b97fb-19ce-4e39-addb-6bc8fc59b4c5@intel.com>
Date: Wed, 15 Oct 2025 14:38:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] drm/xe/vrsr: Refactor d3cold.allowed to a enum
From: "Nilawar, Badal" <badal.nilawar@intel.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>, <karthik.poosa@intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
 <20251015080710.1468409-9-badal.nilawar@intel.com>
 <aO9dsvZ-SmGlEh4T@black.igk.intel.com>
 <18f84e75-ea8b-4a6e-b1b6-1d07dcd4f778@intel.com>
Content-Language: en-US
In-Reply-To: <18f84e75-ea8b-4a6e-b1b6-1d07dcd4f778@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0076.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::10) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|MW3PR11MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fe8de0-b6fe-48ae-5b40-08de0bca7803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzd1WE5WSzJ6MlQ0dDF6c0RBUUhYM3VBcExWNWtPVVgzOERuYUxjVTlCQlJk?=
 =?utf-8?B?VkZYZXl4OXp1YUdkbzUwdUNGaW9Uczl2U2YvM3NUMFZUcnY1R3R0MnNlaVpG?=
 =?utf-8?B?UW1jNkYvRUttUGxVMXB0TnJuMzN6NU0wMldvK3cwUkxueHZPZm5qWnlCMyts?=
 =?utf-8?B?K0lyemlzY0IrY1RPZ2NDYlF2eTVJVzdOMVZBM0NwaW1ZdElJckM3NlMrek1v?=
 =?utf-8?B?Z0F5UHhuT2dKNk9oOXNFRlRNYnQ3a3NTNS9MMW1jS0xGYXU1THJuekMxOUk2?=
 =?utf-8?B?ZzFHY0EvVzdlSzVMckZ4ZExROTh0SzVZVlhmL1dqRW5NVWdtZUQvL0YvNUdh?=
 =?utf-8?B?b25GZjJ2bmJlN2ZNN0dVUFFWVVk3akdVUm9iZFpSbVVka0xQNXpaMW04R0sz?=
 =?utf-8?B?elJod0x2dUI3TnBDR3haQkhTK0tqRW54YXd0QXlyQVMwS1hjN04vSmdncmI2?=
 =?utf-8?B?OUNqdXAwNmZFNXA3R0FvT3ZRYWd0Mm50cVVSZDBMR2R5d2VtVTE3T21HcXRu?=
 =?utf-8?B?anNZOFBONTlPR1NhWkQ5cHcwUDZJWFJxZFM0YWphbDdDMm9ZOVArQytieGs4?=
 =?utf-8?B?L1FBLyt3eXhNemxnL3ZTcmJwZ0VzV3AwVzhHdEk4aFBPdDN2VXlzV0tyZmhl?=
 =?utf-8?B?eGhSS3dvTDVmd1owT1ZTdG0xNDBKaHBDTEhFNnhJa3ByWDVLWFV3YlI0N1NK?=
 =?utf-8?B?bjREOW85MWRFMUdkdHo4TnNOTmN0emlGNnljRGtYb3piTzAzM05VNllSenVv?=
 =?utf-8?B?YXVnVTdHdzhmVSszMk5ncWNPZUhhWXJyWlgvM0ViaUgzVXJQaHQ4TVBWZWhi?=
 =?utf-8?B?Tnpyc2QxUjR2WTNid3M5QXdrVm41dHRscFZjZmR6N3dLQW5vZU9mc1M3ZDRh?=
 =?utf-8?B?NVNlb2FEcjg1blZ5VStXY2dBSktjZFdZMTUrOTQxSXJyODVYaWV3WXlSY09p?=
 =?utf-8?B?SnFxL1ZXU29iSVdkZmlBcG1aRFplUXNURnNMaER4ZE85M0Z0ekI1VG1zMFcv?=
 =?utf-8?B?Q3JBSXp2cCtnZzFIK0FYUW5yZGJENGdGbTF0TDlxNVllTFdFbHk4cHZQRnp6?=
 =?utf-8?B?Q2pPSGtIemdRU2QxUGw0VDZjY0plSjMzZmd4cEpmK0FDN1VtVHQyM080TjZl?=
 =?utf-8?B?ZFp1NStSUzNBK2lCWHBQYnF4WFFzOGQ5eGI4SWtVM05CZi84bzV2UWFXWEhY?=
 =?utf-8?B?bDcyTTNVMDJCU21zMUJ4bjRadnN4UmQyZmFFZy9RKzlCd1lnbTZyMEpndmo0?=
 =?utf-8?B?YWhYUy9SeE9aU3VZY2g1WmI1NUJ3bm81S25SWXZhRWQxbEdlVnFDN1hHOVgw?=
 =?utf-8?B?RU9FMU0rSkNmK3NvTWloUTBvb0VOTjZhcnI0bWhUL1pCNjJtaGNpMGdwUWVV?=
 =?utf-8?B?VWlHY0tqYVFtMFFrQjNzOUhMbmZ6bmpjbnBqbzJXNnZUTzJpZTIyOFI2QmV1?=
 =?utf-8?B?NEI1UG9JSzhtVXFLMXZ3NVZWNy9ldGQ5TDNzUFdVVkc0SmFOTlBMM2lFanZi?=
 =?utf-8?B?RjlPL1B2a2ZkU0FEOWhDdHR5K0FOL1ExaTJOanVNempOUHl0ODI1ZDNqMDBo?=
 =?utf-8?B?bkFYMno1ZEpCb0l2REZVYVNTV3FaclNBZ0JlYlNUcklKTG42clpUblJ0c3Aw?=
 =?utf-8?B?NTVjdytJeFA3L3BOVUhYYk9KTzFFQTJIZENLUXN2c2RWSnRlTEdtQVlHY0ZZ?=
 =?utf-8?B?UzBFc1FQaGZ3SDhEZ1BzYTZ2MC9JS0w2dVoyQ3pFcXJmN0Z5UjEydVAwbXJo?=
 =?utf-8?B?NzJoOTFTeFloSjY4aW4xVmtDZ1dDU2RaNWh5ZHpidTNFaldTNUJmNTNpRXdX?=
 =?utf-8?B?WTVWWUpCRW0ycmJrTHF0dGNFc1JaRDQyRFI3V2tKNFpoS3hwcWREUzdKM3Uv?=
 =?utf-8?B?ZFZHMXFWWGtEaTBTeE9BQzE0QkNsb0RBMUNvWXo4dmc4WE5BY2hlK2RobnhW?=
 =?utf-8?Q?zaBmbYkxZP/4gOqLdlxoGo9XfcQweC5T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHY3QzZmTHZsamtDclBZWmVTOUdPS3dLaUsyRk5wcW5QUExNcndoZ0ttSVZ3?=
 =?utf-8?B?NCttZUNiZ3JtR2NXbEZjWm92U0JkYTBQd0pvbGgxSzR6eW5DVE5HMTFXWEcy?=
 =?utf-8?B?WmRqb1lKRTQrcENGcnUzcStkUEh0MnNNTXU5c2lrNExmQzVCcElDK2lxbTJC?=
 =?utf-8?B?VE5VQm5kZEtBMy95TWZWVkdYaU1QUms0dlJ3dTA5Vi9wUGtBMGh3dFJkcklv?=
 =?utf-8?B?emZkNXB4QTBQQXBVd3ZTOTh1eUM1Tnkyd0d0a2UxU0JkUkpWdXZNOTh0VCtT?=
 =?utf-8?B?bjZiV2FFUnJDRzE5aUZUQU1Iak9qWW9GZytrdFcxQTRDdXFTeDhpTS8rSTI5?=
 =?utf-8?B?d2lpclZuYWF0dHZ4SjZ6S2lneEp5a2o5Y2M0YU0yZ3dDbGdLWCtBbDduSERx?=
 =?utf-8?B?bExQcFlVNE1Qb0ZYYnZZUU1HWjcyaVlIcjNMSTNaZ3RGMnVVY1RyWkFSQWpE?=
 =?utf-8?B?UzY5aWhsZWhJaVJ1KzZBaHJocFlSZ2dUMG1kWFJsNTJyYWs0aE9NRFNLY0F3?=
 =?utf-8?B?UzVHc1RiUzFUWEtBVzNlUDBDQU54WElITitmRWtWVXhnbmFxT2FLVWljM3VM?=
 =?utf-8?B?WmsxanhIcEMwbktGbkRFV011VkFLRGJla0xGb2hzYWdvV0dUR2VVenZoWnV4?=
 =?utf-8?B?K3dmVlFDVEV5aFZJVHJCMjI2c1IyaGZFS3VORmQ4aFVRVGM3K0dNSC9wTzht?=
 =?utf-8?B?ZGp5czV0NytPbmkrT1l6VVBIdmM4MjFjVmRVL3NId1BaS2dOaGpCejlPTWVF?=
 =?utf-8?B?aXlQRjNWRVFBZWI4Vnp0OURRUVFISmVzZjlJZnlLSUdlRnFCOVNEWWZRMm54?=
 =?utf-8?B?Uk1zWk1iMzVRRDFjcVJOVkI3akpVQU1LZU1qMFNjdkptc0FhTnJpL0QvU0VQ?=
 =?utf-8?B?QmduK0dBdWJTUit5YmZvcTZRRzNYcGhucDNhRHNLcGYyeG9DVXFrak4zNW5D?=
 =?utf-8?B?WmN0bHRCL0ZnVWhZNkNOa09HUkF2VjdlY090NlBHUnpHWCtzbFYxNzBMN3pX?=
 =?utf-8?B?dXFvOS84VGdFbmw1eTFKOEh4NWk5VHBseHVJaU05TGVTMGU0a1FyWERnYlJW?=
 =?utf-8?B?YUJCd080cHo3SjZXR1Z1VU9LRlBmcmI3Mmd2L2duZ2tLR2RiRlE4YXYwYzhQ?=
 =?utf-8?B?SVZyTEpRUWQwaGcwTnJqOUduZzFPN3BCL1B3N25kOUY1dCsrTzN6RVNaTCs3?=
 =?utf-8?B?S1kvTmZPN08wNjBUby9ZN0dHcTI5dUhYZjFQa1hsZUJzelRMdjVSYTRQZnZQ?=
 =?utf-8?B?aHJyNkhoa0VyeFE1ZE0vampJMVBsbWRMd2JTdTBadDhDNG5FK1NkcDFSNkpN?=
 =?utf-8?B?cDQwcGRrejBaaStMOVR0ZG45WnZwQ0dpUjNmVThVQmpRUnBkajV1Qy9XN1lr?=
 =?utf-8?B?ZkNKYWRZSUtTNXNjUHpmUnM1bWZwdVdkdEd0RWYxV3pCRFovd2tmTW0zUzlu?=
 =?utf-8?B?UWNUcFdNNVoyR0pEaDhSQysxcmpCeFpBSWZvM1lQWHRlRENydlJqd25lZFZv?=
 =?utf-8?B?dmJZR0NUSjloR09Qc2wvQm5td0wzTEF2a2Rpb3Q4Y0hzVkNTZnRXWVFWRFp1?=
 =?utf-8?B?NTEvK2JVNS8rNjVJTGxlK1RNYzk4Wm1RSHluc2lwR2h1Q3F3bGcxTlZkS1p5?=
 =?utf-8?B?Z0htSjNyai9iVnJRdTZHMW9raFA1OUxiMTNNR3kvM1l2eG5VSTJlQUdEQWo4?=
 =?utf-8?B?UGl0MXdrT2Rlck16WHczZExvdk14T0l3MjVxaktQa1FuNzBXbVNSbUJoaW0r?=
 =?utf-8?B?VDNla1BYWTZiUEdWcHNySXJ5L1N1ZHA4MGZJdkNSeEFBTFQwaEhubFpvdFBp?=
 =?utf-8?B?ejhOYkVCYkRmWXFTZmUva0JVV3RZUXdIbGNiZmtieFNPUUJZOHRqYll5cW5M?=
 =?utf-8?B?Yy9CRkwrNldOYUZOQW1TYng1MVlpOEVMWnFkaWdsT1lNNytFTzRtcEZUVVdF?=
 =?utf-8?B?RDhjcS9LRXhiR0UwNTJsVmJQZkxzV01kbW42WmM1UURxRnhGeFcvdkVUQ2Ez?=
 =?utf-8?B?RG5ieEhhRXhjRjc3Ukw4Zy9WSVlEb0g5Y011dzJTaUg3VjBidVBhL0VGeVEw?=
 =?utf-8?B?VUt3dVRyQTljVTJVdWFmN2FrUWJ2a0NMS2xEWloyMWMzaDRUdWFhb1RZa1l0?=
 =?utf-8?Q?pCXwxtbbBUn6xxwq5ER8bi8I+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fe8de0-b6fe-48ae-5b40-08de0bca7803
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:08:56.2513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0LL7ERk3I4zp4gacboD0R+ozvO+eGwP7n9HZj5Y/rCFEuK0Ip+URkS+2rPKuO0z3weVTSqFeS75Dpl3zV24/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com


On 15-10-2025 14:34, Nilawar, Badal wrote:
>
> On 15-10-2025 14:09, Raag Jadav wrote:
>> On Wed, Oct 15, 2025 at 01:37:06PM +0530, Badal Nilawar wrote:
>>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>>
>>> Add xe_d3_state enum to add support for VRAM Self Refresh
>>> d3cold state.
>>>
>>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>>> Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>
>> ...
>>
>>> @@ -787,7 +787,8 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>>>               goto out;
>>>       }
>>>   -    xe_i2c_pm_resume(xe, xe->d3cold.allowed);
>>> +    if (xe->d3cold.target_state != XE_D3HOT)
>>> +        xe_i2c_pm_resume(xe, true);
>> Does this require an if condition?
>
> Added it to handle D3cold and D3cold-VRSR target state. Am I missing 
> something?

Got it, to re-configure PMCSR need to handle false case as well.

>
> Thanks,
> Badal
>
>>
>> Raag

