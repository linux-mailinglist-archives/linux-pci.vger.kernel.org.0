Return-Path: <linux-pci+bounces-40787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CCC49800
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39E504E4A2A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF82F0C7C;
	Mon, 10 Nov 2025 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGfOSeLx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705E2D949F
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813295; cv=fail; b=bHzTOezGmeJOM5Qn34VdI69hW7GZdq8ZTsCtVaLhJDWaW5KHtHIIu7PibybEyFCfJOEvUYJFM9xuTpnYFn0foP9wkzqkF5eTgu3va7rf0wDEz3fYyDJjJFElzrUQgk8BpZYKLNVlfoW3Z90G+XjG83fX6us8mX6bhJjtmarn+wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813295; c=relaxed/simple;
	bh=+SHORmbpog6MNvunEFeS8nVQrm+2IJMjFV0v7FTxgYs=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=i/FKT6aT6feuBCb5kzJBVOA8E9oXswqsXgSovGEDaNxOvWKLBfrKD5F9+6HhHeC27vMAaDo0k8mtFttc+mc6xTdlR9xUFeyDR7mbNzy03w7ceFrWHrmuBHtzLNSQwRbbIDPow93mSY8nqglWlqXA4ymZbpuUhcDbXErUhgi8DPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGfOSeLx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762813294; x=1794349294;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+SHORmbpog6MNvunEFeS8nVQrm+2IJMjFV0v7FTxgYs=;
  b=WGfOSeLxyJ4973ZaepktP2go/mjaRncoJK824mMKEbv04Qf7tR1vPstY
   owZtOAWle1t6zOmPlf45r9owsngbML5+ESoes0tGAOaKxhKocRh6l/vv4
   bYs534dlR8tMhPOrI5SZJzWfz6sX2Hpc+RS+EJA7cZgMi4a4ZnnHoFIIj
   DLz7iJqfq+F1QooLps1FI736DUaFwi5W4O6gcwPPj4P2Vetpr3fHhXhyq
   bjzBDB0ydAgXYrhUEAq1kFaQzkBZDFaRIpVPH2Ys2ZMx+wMcuFroYHVgv
   q/MqM863dKDcuLcxJcMc1gmrhKy6NchnAGs2Ghd4AkG9prXUHkXnr32GJ
   w==;
X-CSE-ConnectionGUID: 7mv7VmNjSSqk/mIVWuuBdg==
X-CSE-MsgGUID: G1/97c7iR1u9Ceq7U7tXOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64800083"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64800083"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:21:34 -0800
X-CSE-ConnectionGUID: +i+m77SrRoig5MWeoouiXA==
X-CSE-MsgGUID: 0/6epewbRBeKT0m8lLn2Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="212170699"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 14:21:33 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:21:32 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 14:21:32 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 14:21:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYypp15A7/euie/bgD4Rsvs4kip09SOPCXymOZWeM3YhrZekHNJBw/PtszjrQvqYeiXgHcnS7g41SHFf2h6WwQf/DRuZ3uMLr/TxEmplAo2lL+14IiRsd+8kUMC00z8KHyyJtRc2jmOqBQeBiwgwD8xzIBiUuQSJV4S+3+mhHskVPyC6+IVYaK46zVH9qS4sQA+FzRnlQkFeppBVwFh//dxkoNZISY40FCzCq3jHxvEiqSDoyDUeZ031EcIKKCCkoXDFuJMEMf+rGPJKxVzkGHPhuI30H4f0x+19CE+McVHzNAJ5p7Yj/rTO5/3JIopjkaA3XxS0FuISH38pG0gVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMZeltuPrEbm4Eh8K3FjXbTRLIo7kDA79/g951T3gS0=;
 b=gNJTPMfowAY9WmbKpkJy9pLYc8QCyc8CY8Bn8wFaMlTNqZxku7BVd5uFzwSi5aGdtcrcPp3wwxQar8n0ijRhZ5EGnShkUKBAEDVYSEn0+hWzuXTPTopUZPFKIy7sOtC6WyMh7243YkrSd1U/xsZvo0V0RA2ppt72o8It48zKDwYc4+wVM8ajeNqxvrs60pJLnskdDZ9qPXMDtn1jPTsmEYKaw4QfRmrDtv1JHAtah183RQzkeodbeK7CRMOt8c0jeYnDE7rMjfMPQeTMLWBCULCfRAHfY7TmY9v7cXXBCuSzqDgE/yjpIBJaduygthBcvyGjaEvzR/clMZQeDl9qqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 22:21:30 +0000
From: <dan.j.williams@intel.com>
Date: Mon, 10 Nov 2025 15:21:28 -0800
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Samuel
 Ortiz <sameo@rivosinc.com>
Message-ID: <691273784b0c2_1d911003a@dwillia2-mobl4.notmuch>
In-Reply-To: <aRFnEMYe9yCic5a3@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-8-dan.j.williams@intel.com>
 <aRFnEMYe9yCic5a3@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH v8 7/9] PCI/IDE: Add IDE establishment helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a99208-ddec-4dba-3e56-08de20a77f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDB2T1BEN2pCRHNVSGhqOGhTU2FDM0hTQzVKVXZPaStKNDA5ZEgvZlVEQWo1?=
 =?utf-8?B?Zlk5TGZiaXBOUWR1aC9IQ3Y2NUdoOWJnSXRQbXNrRExFaSs1cThUVW9Xc1lH?=
 =?utf-8?B?eGRVNnEzak1xT0pLZCt5K1Azd3RFVlVUV29mbnpiaVpoU0ZZWlFmKzIvZEJV?=
 =?utf-8?B?NTVWamNIMkwxdDRrcnZwZndEelNyeXNua0haWUI0THg0RHhVbzE5TXdhazd5?=
 =?utf-8?B?RTFIeWdWVlJlS0NITHRxbXBlVjRxWEI0V1BHWkEzazVybnJJY3ZTZ3UwS0dF?=
 =?utf-8?B?ZUw2ZWRDNWc3ZmtRWXRITGRUNkpzb014TTZYQ1lUbUtYamtzdnJOdldoRVpq?=
 =?utf-8?B?d08xQ1lubk9DUzVRTEtOMzNNOHBYbUlGMjBMZFFITWpndHhEdllrNEpZNUJr?=
 =?utf-8?B?Vy9YemNTL05CQSttQmZmMnZ4WEg4QTlaRWlSUFUvNXFJQUdiWHUzRWVCVmdV?=
 =?utf-8?B?YzFHSThEREg1MVViZXcyV2ZlM1VwR2FoNjJNb3NEZ1R0d2FxMnpvd0pPSTNr?=
 =?utf-8?B?UkR3eklvNEF3UHFnenlHdUxsUFhXYndEQUtLUnVtZUFPRURIWFA0L1Viby9k?=
 =?utf-8?B?ZjFocm1qbzcwSGUwWm1nOGtIdTVkS0sydmJOZDNoWWFaTCtHOGJWeDI0Q3hU?=
 =?utf-8?B?UkNBa1RQSXVpR3Y4d0VJNWZDNFhFelY5U2x5ZFdIK09zclNqN2xHNVg5Ulh1?=
 =?utf-8?B?a2ZSbzkyZXFlSUc5Mm9HTFlVdHFJQlRSY2pvWDBySFRyMW5xdHZRLzArblN4?=
 =?utf-8?B?NFpNbDlpMXd0S0o2ZGhaYm92UEozUzR5VWhDUFZ6TFhXVXFGN1B1MDMrOWRE?=
 =?utf-8?B?eGlwMnFmUlVjYWhnRGFJa2srVkdvUTVkOE1hR1pFVC95bkYvVTUxZlEyY1Vi?=
 =?utf-8?B?L0ZKckJFUzlyWmQwL1FEMnVqYndCUjA2azRCRndmdndnTjRMTC9TYmRqaUJa?=
 =?utf-8?B?VnkwTnQ4ditJQzFEN1hsQUwyQkxjWjMzTkw5UmgxVGlDR3NuNFRJWUZWUUVG?=
 =?utf-8?B?WXU1bmlFSzBqWDlSU3VabXpFWElrTThFc2dSUUVSaEJJQmp3RUV2UEQ3cXdr?=
 =?utf-8?B?OERBeVlKd054c2ZiTCtvQzFXSy9DbmRveWw4OEJucjBtY3ZkSS9ndkhWQ3hT?=
 =?utf-8?B?K1hMS1g2SG1QQkRCR1BTQmp4OWtTRjdMVmFSbmJieUpJNTFlYlQrc0hxWTBI?=
 =?utf-8?B?WG5sN3VLZ0YvaldrWGVTRnY0amNKUWhYTDJLRWdTUk5qT1l3ZjlhK1o2NHI5?=
 =?utf-8?B?MWhmWndUMVRhUEo3dkdPeGExdkJhanNIb28zby9hU0NjZHM2aHhxSWJqSERL?=
 =?utf-8?B?Vjl4alhONEp5NUhHT09GaWp2eVBVY1VFeVlQWGxTdlNVR21XL2pHUDdDaTFw?=
 =?utf-8?B?ZWY4Y1cwVTVmdWxQOGxPZkhJc1hBa0RZQ2IyNnZtZm92SlFpdXFBVHVnNC9p?=
 =?utf-8?B?OWhFb1ZPd2RiMEpucEhTVDdUY3puZUErcDhweFFHZkc0U3hwckd4QnlTQWhJ?=
 =?utf-8?B?dWY0a2QzRXBkNVZHN2tGZWRFWTZIb0JRRndLcmhsUDZwd3p0V2tQclVZQmQ1?=
 =?utf-8?B?bnJuLzhTOWVHU0Z5QVQ0TnJVVG5YWWJMQlYrY0FWdUpybE9FSzVwWjUzTTRM?=
 =?utf-8?B?ZGdlS1lJVUdjajkybGI0ODV3QzlpcFJFdUhsNk1GbHprNzBMRk9ZeVQ3ZFdk?=
 =?utf-8?B?UHNKb05DL1U1WlRwaFdRalhwaThoeHhuTm5rVnRTOTM1OXhjV0hsd1hYUGNG?=
 =?utf-8?B?dkFUeDVMZVRBMUlvUkFURzFtcFZLNVlHY1Aveno0WDl4RHdIMEJDcERDL1NN?=
 =?utf-8?B?cDZENkl1aUUySnZVa1hvT1ZNYnJPK0JrdVlVbVYwNGNFbHdHSWo3ZVozM0xi?=
 =?utf-8?B?M09vTVZmRUc0Mkdpc1VWV3lBOG1qYy96YnA2SjQ1QUtHNGl3ei83UTBGWklu?=
 =?utf-8?Q?1v2Q9fIM6hXmVGCQU8+0WTpRf7yS+TNF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkNOdDFTNjVsMWIzZU0yL2ZLMFNnampRR3JCZ1MxZzlvcVZ6NVF0akF4QklD?=
 =?utf-8?B?UXJxeHF0Mnp2YmFiakFqTW50ZnF2Mlkxd1dVYWR4REdrdnJnSzk3Q2Qwbkc2?=
 =?utf-8?B?am5CbTBpQUE5bVVvYjhueFZ3RkJ6bXBrZUdJcUtKWDUwb28wMHZ2dkh1MXli?=
 =?utf-8?B?Qk5XMHgwN2dHUE1jdEtkNlBaMlZTalF5UVFsL3RzNkViajhYZitlZHVlSzdx?=
 =?utf-8?B?Y2pvaTRwclh4QnlZOFlMM0QxTzV4OEVTZjg0WkxFZjRLWjRuczB2cEwxWUxI?=
 =?utf-8?B?cWRsTllDV2tGQ3dTWXVtY3lPUnRWVGhpTGE4aGFCMVVSK3V2ZnBWUmZMWFhJ?=
 =?utf-8?B?YlNzYkZ1WmNQRFhFRzZoSThMaytSVkNuSTBxYUxNME1aSUdYaXRKQm5tZFRj?=
 =?utf-8?B?ZWZNd3BjSzBNNUp5Mm5TWWRnRzVRWjRTZ2JDWS9JTmcvZlg4MXlVbTMwQnpS?=
 =?utf-8?B?cXRBQVM1T1BHaGFGUzRCNFFYMjlGTC8rYTlBQTduQUJYV0NQOEhMaVduektv?=
 =?utf-8?B?K1BBLzJGRkwwMUNRNEJtTGYwdTNoSXRUczh4TWpvc041R1pMS2k3SEJCVUJJ?=
 =?utf-8?B?bHNabzhGeWUwMmFrN0puR3ArbU1uczBhWm1RR1JRa3lDLzcyYllWVG1Yckxi?=
 =?utf-8?B?YUJQeWRvT2hObmV4WXNJNjV1RVVJSWhwdnVwZzg5Y3RWY0ZRS1hDd1hReUFl?=
 =?utf-8?B?dVRCU1FQRVFjSEdhL2dnT1JIMEhuZ0JNelZVRENrNEJuMm1lVm9reitCdVIy?=
 =?utf-8?B?MUc4ZllMVkkvbE5ldVNTN2w2QkhvWDB3VFpWMTdubFc1aFU2dlNkN21TQ2Ro?=
 =?utf-8?B?QXRxa29NRkJ4WUl4TVFPRHhqaTE3Vit1anBVeFJJa2ErZmc5U1BqQTkrQ0wx?=
 =?utf-8?B?M0pPYVljVGQ4TWhCMnZlVWprWi85dWwwODlvZ1RQZDkza2krMm1iV0h5ZWcw?=
 =?utf-8?B?QmRCMnk5RVNPTGdlR3U2TU1CaTR2VUN4cE14ajdBd0tEZ0JWdUYxZUpBYnVj?=
 =?utf-8?B?TjRaSmt2aVVadUcwY3V5cGpCaDVhUVRnMDFWZ3hMU2R1eGVQMi84MWJ1QS9N?=
 =?utf-8?B?U3ZzVDROc1hPYlQwdk9PUTJrdzlaTjc5ZXByTzYyd2xDTDZFVmJTenJuVlhi?=
 =?utf-8?B?TnBQWTQyMm02TGRwQ3FiaGE4a2ZCYVhERHRrVDZsODdvbzdhMVpucXRxNTIx?=
 =?utf-8?B?VXJuK2poelhrc09Zdm5EV2NJY2VVL0JnK1J4aDJEdm9SemNaMXF6YXE5UGRS?=
 =?utf-8?B?bk9Cd3NCQXNGZjJIaGZUMEFGaFpuWjF5bU9SczdjSmFhbkxPb2pob1ZBaVNn?=
 =?utf-8?B?UkJLYzNCY1Y2SWdhbWZLTVZDeDMxQjRFNWgxQWRIN3NoMStPMXo4KzB0OTho?=
 =?utf-8?B?Q2xWL09CRTNqcFd3QUlQVDNYTjFGNXRSa1BFTDR3b0ZORUtXa0NMSERENjM4?=
 =?utf-8?B?a0dHU0RubFp1ckxHSjZIc3EyY2ROd0NpZ281SmloejY0SFlGZ09kMHo3MTVK?=
 =?utf-8?B?dXJ3SmhoUm1GN0hreW41UjN1cGRSSW5iaEk1SG1xSWZObHI5Y01QMU8xcWMx?=
 =?utf-8?B?QUErcGFPLzMwZ3BudVVKNzcycUxBL2RVazhJQWJFSnNmOG4wUU0rTmlxbGFC?=
 =?utf-8?B?T3d5bGdyRk9CZzZySHYwQ2RHdGdadWJvZDJxdncrMlFpZFdrakgxS1BIYm5H?=
 =?utf-8?B?N09td3pZb1JLMWp6THYwZVdMdXpGYjFIZEtrSTk3WFZhdjEzaUdYYVVPUmNs?=
 =?utf-8?B?Mm81RHVwSTB6RTIvMUF1Ym9NajVjRDVwYTFXOVNjTDdSU3RSaWoyVzRWelBU?=
 =?utf-8?B?bS90Vm1idEZoS1NnNFlubE1nWm1hOXJDZGRzZThERjcweU8yaEdvZUQ3cEkx?=
 =?utf-8?B?cU12aUsyU1ZwK21OZm51Q2lYSlhrbCtGZUZmam44OFdxdTJlZnVGN2lXTmNm?=
 =?utf-8?B?N1N4M1E3aFV6bnI4WFdPd1g1WCtRVi9vUm45bklyUXU5M3lkSHlHeCtCcXA2?=
 =?utf-8?B?OWp3Y1hMT0NJV01tNVcxZjlBUjNVSHhncGJxVllxK3cxWmtkbzhEUUtLMisx?=
 =?utf-8?B?SlRlU1VYVWxkemxKRk9SNlQ1UE5CK0pWdG44Z2RIT3NUWXpjazVpNDlBNW1z?=
 =?utf-8?B?enAwQWFtYXNNdm03WVpWQnNBb1A3ejJWbTNvZ29mODZGVUtWTDNmT0tNQXht?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a99208-ddec-4dba-3e56-08de20a77f6e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:30.4151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkJis9K3pxk3qr9MB1cBxUujxkyDJVNDBJ5b9dSQOUkWspp3dikGS1LZSEl1uvVaOayuerLeFZ+d2lof6TeFILHUlXgXAJ8F3LLrqmoZy08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > +{
> > +	if (!pci_is_pcie(pdev)) {
> > +		pci_warn_once(pdev, "not a PCIe device\n");
> > +		return NULL;
> > +	}
> > +
> > +	switch (pci_pcie_type(pdev)) {
> > +	case PCI_EXP_TYPE_ENDPOINT:
> > +		if (pdev != ide->pdev) {
> > +			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
> > +			return NULL;
> > +		}
> > +		return &ide->partner[PCI_IDE_EP];
> > +	case PCI_EXP_TYPE_ROOT_PORT: {
> 
> No need the braces

Some older ARM compilers apparently still care:

http://lore.kernel.org/032cd284-1b0e-4d52-94d8-e37fc9a759fc@arm.com

...so, leaving this for now.

