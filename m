Return-Path: <linux-pci+bounces-35165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18743B3C77A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 04:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B822EA26583
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 02:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1625DD1E;
	Sat, 30 Aug 2025 02:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJkMRgew"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0666257845
	for <linux-pci@vger.kernel.org>; Sat, 30 Aug 2025 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756521489; cv=fail; b=XlzoRFCk2hQwaETvj7IvTZ2NyBjDurLkUF5Um61M1PEDTT83VKq5nfqMkoRwYwAF9qmDpVNAKziI6h5N2uxSTU3MLQbAMqIHo7T6RrePuz42n+qlPQozyIKJ3pSL43SJ0ZFBi8YbkAySE/0H0IpmH8ghgjnqkOvM+HrMhRs74ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756521489; c=relaxed/simple;
	bh=CTuUmr9WbYqYx73fBqQNdw3wG1G8rO1v2SsIeVMRzIk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=PP20k3OLLq1fMZ2fL1YoBK1T0D2dL1rt04t0hQhC/ToPZR6x09ENIj+dGTJ1EBlhssnKE4KUhvU+zPa7cJmbZAWk4lLX0+FMdBeT431nCX3gCW1kPhLr0cbvQRCfcaJuK4d529V0MAWTXXUEhYcxUStMc4s97novpfKrR9c/EsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJkMRgew; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756521487; x=1788057487;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=CTuUmr9WbYqYx73fBqQNdw3wG1G8rO1v2SsIeVMRzIk=;
  b=CJkMRgew5TdQS3cxOkzK1F4duP16jpUH7jhNao79FJ2Kb+H3tYm8Dwpk
   V5sAGcenYS3mkrOGjP6wxKBx3HwmoMvYgG2/Mz8YXRdyhY5rOX4ZcUkA/
   MsBnjOZPClt9L4QDAGCNK+sA2eHDoOjgcvDXcMTca79J7d1XssoY5HI9E
   L1PTDTlzattlpm14J5V+xEpGCpJ3aaBcg/WpOnDzvrv+NhmBZ1zCsD/LZ
   bKAUtT2f4zkpT9CG25Sq2pUOaIkDlGODwgye+dJO72rbkKVMYC9U7Agc/
   uJVoq3e+l6jj+cAaESK2jg0OwayzG9AQCpebuF4AiVX/kefjjqdSlEv+7
   g==;
X-CSE-ConnectionGUID: qWzIDSTWQeSPMeywAZfFQw==
X-CSE-MsgGUID: qtmX4XqDQzGFB8aYhLEXnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="58958354"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58958354"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 19:38:07 -0700
X-CSE-ConnectionGUID: 4JehqGTaRZOlGy1u6bUZdg==
X-CSE-MsgGUID: qfQVv/4HTgKzK4CLCdfQ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170428572"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 19:38:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 19:38:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 19:38:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.55)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 19:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDfcyRftfHdZt6xxly8nBB7bmCzXnkrTqV8uEhma22hFiQ7eZIv7pBFUtg2P6CRato3FZLaEsClKEeuurF8k4kzxstJRy38G0HWO+1rJLUpxpDSbG7Mdy7ISRcbYD4g4hkm7ywxhBmQjzGq/xi0NzrqtIJkmh1c//hphfOXYF+QGdxR00iIIpsoaSMlvWZXw03zsMfrSyVoN0GiIoc6JiwIR5MWI/1GtBdeGPzhYlDsWekQvMqUGYHo/Pf5kXLRVz1dyZxrUvqDg2orjCeQDT4//smft+hxPsR7dlHzN9hFmRYTSCPVgD5+pWjLhIwEFxGxCzU3oLsLCDF/dFZNqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioCUbemOQD3DM6Kqfszabl8YKV536VoMsPUquYnQsbQ=;
 b=lnBh9iZMjOHS+cn9TTgzruf6+7Cjx92zK5zy/ROs75wL3NbQBpM6+wUo41mQ++xHnWGRtxYtno0Jsk/pDTtey0cHiy7x81DStaW97RDEkYIveaMAsxj2bZ89SzA/Wj7mJmZ07yNio8+/PiNiCsk18GtBzV+dQA7rebypigZtwEPl6H1aIoEpoQAvQcm+bw4uZ7VNEE20Fak4lJ+/2/CEUN/ltE5GtDj4gQMwafD/xlLHiyxqnyCJWqIMPBHHsd8rsl1U0YZ939ynWK1ADrDJInmIUCAGQMDJeLc02coMOjvhuE4MGVHJYsWLgAFh210xZ/+YKwtJUjVZS0KrUXhorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sat, 30 Aug
 2025 02:38:00 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 02:38:00 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 29 Aug 2025 19:37:59 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>
Message-ID: <68b2640726bd8_75db1000@dwillia2-mobl4.notmuch>
In-Reply-To: <101dc0bb-d6d1-4f29-81fb-fb1ff78891ba@amd.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-3-dan.j.williams@intel.com>
 <e680335b-bd40-4311-aa13-58bc2b0b802c@amd.com>
 <68b0d30e2a18c_75db10050@dwillia2-mobl4.notmuch>
 <101dc0bb-d6d1-4f29-81fb-fb1ff78891ba@amd.com>
Subject: Re: [PATCH 2/7] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: d724bd5d-30ae-4016-3223-08dde76e3ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUpId3Q3aWs2Vnd1cWloQ1o4NnRkOXNvS0tPRnhPclpwdzhncWhFb09GMnBR?=
 =?utf-8?B?alZhT1RKcXg2VSt5ZGs3WUxPcUVDSmlLM01jdTRBUjBrUTVrUEU4UENHK1Bt?=
 =?utf-8?B?cS9GRHJpeldIWndqUEdnSzAzSHloNWRPNXVGaE1CU0pxTGVTYnZ6dE11SktB?=
 =?utf-8?B?aFBtZ2Z4Nm12QTdCakptcDcxK2duWHduOVdDamFCbUVNREl2QTFNM1pkTkov?=
 =?utf-8?B?M09iYkxhR1pnc3MzbGk5dDU2NGIrWjBrK1ordFJDdFJKYTlCRnJJU3J3SWRO?=
 =?utf-8?B?a1paYUJuMUpUOVg0RFFGcDRUWUVpQ1oyQTFuS1pmQ0V5SURMRlo3MDBNTEZ0?=
 =?utf-8?B?bDk1azk1RGczeGp6eXVpN2RsYmhyNXdvMXg5ejFPdFFRZ1BlUEp1R0tINVBM?=
 =?utf-8?B?QjBvVFg3WHNMbDlidnVNY0xpOGF2SmdkV25Lb09DUWprd3ZtTnpEclBZNzUy?=
 =?utf-8?B?MTBlZXU0L1p1OHkwd2JkN2pNZkh3ajAvRmxSaC9BaU1UZ3VKUDM4V2dwSytX?=
 =?utf-8?B?NU16aVMwc24wS040TmRLaXhFK0g3VzI3RlYxQlc3TFF1d1ZLZmUvZEw3VnBD?=
 =?utf-8?B?MFJYNElwZ3VPU0x1WWFQRHJjTFJnT3dCK3hsVkpFVERYNXlWeUUyd2RwRzhB?=
 =?utf-8?B?ZGF4SjB3a0VQVnQ2UU84U0ZRZzdHcUthaUsrWms2NFh1OUV3VlUvN0NMVGR1?=
 =?utf-8?B?L1k4clJXeUZXcWk2U2VpemdaWWVPa3JyRHV3cHhIdVh1OUxZZkRtRnA0Mm9M?=
 =?utf-8?B?UHliTFUvUWg5YVNtSGovUHNadUZqTlI3Rm9KNmMvcGNXV3AySWZrY1NwNEkx?=
 =?utf-8?B?cHhMck5QdGdKTlcvMXFpUFZKbmJETWlnTlJvRTVuL1p1Q0I2U1Bva0cxeGhP?=
 =?utf-8?B?UUxqWXNqQ29OYkRQOWtQMHNvYUxrNmtPUVJ5b0JFcmZQYUNpZDJEeHFQUGFR?=
 =?utf-8?B?VmZsUjEvU2gvZXQvenhlK05uaVNYcHI5Wkx0c2M1aVhDT1VWOGJjVTFzaGdr?=
 =?utf-8?B?ZS9kczNQeThvVG5aVFc4cG9pZWxrVXBRdStpT1JrUkdEcXZnemNDYXJ3REIx?=
 =?utf-8?B?YXI2ckN4WWFGelFRd2Z0ZXBiNTRRVFF1Zm1mVjZBMFdJTENTZ0V0ZUg4djAr?=
 =?utf-8?B?WTVqR2c4N2diRjJzSG1xeC9Jc0d6ek5KalRya00vNkVtNkYwY2o2c1JWZlpK?=
 =?utf-8?B?TUZzcDVDN2VPZEJLMGhOeWJSQllzenA3eDM1enhuSjloVk5DMlNhY01JVHhY?=
 =?utf-8?B?amlmNk01WTJIRjRyZWl5VEU3SnQvODJESzhyRXFYeFpQZXZsZ0s5K1d2VzRo?=
 =?utf-8?B?S0Zua2VTOFZDZkliUENOd2ZBMnIwdk43SU1UWGJ2RHRrZlg0bGZwQUVadDl0?=
 =?utf-8?B?WUt1Uk9sTWZIQkVHTXVwVWhiUXFZNFF1MEhYL0J4NFNTUW92aXhsR2g3VmFu?=
 =?utf-8?B?SUlsaEFJdjJQSnBCZkhvcytHRXNKbjZ5ZVl3QWYwRjB1eStuY1Z2eHd0TTJN?=
 =?utf-8?B?cnhtSUJVN1R5bUJnVVpBNmFlS1FsWHNnSXVaN1pYUjBrZk5qdGZtTGROaitS?=
 =?utf-8?B?M2RqaDZRNkZSTnZyV01SU0hDRVVKZFM2UjdTa2NmNlJrNWJuVzVpSEtiYStN?=
 =?utf-8?B?S2lTaDlkSEo2N3RNM2FDZCtSQnQzcS9mMktrNUV3QXRVZWdxSVFDVk55Tmls?=
 =?utf-8?B?TllZbHlxMDB2TkFENUxpU2lDQTJNTHAyRnZVWldVczBTZmJhR2F2dmMzcHkx?=
 =?utf-8?B?YUJ4bEFqTkZMVm9Vcy9OYm1ydUFpTGdONXN3Z1JUTFcvcTR0dldPS0liRHE0?=
 =?utf-8?B?VzBnMzVYbUVDNUg4L05yYjQwVkZhTkl5UFVQaHRsYWorQnNPMERhaUVkMG9Y?=
 =?utf-8?B?MXIwNytCZWp1bTFNMVVHK2NGazdsUmp3UWZiUUJiT1ZBWXFCOGJ6MG9NMXgy?=
 =?utf-8?Q?KhcQILY326c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVXOWFLNThhTzNwZXBBUTVHY09yaEZPRjc1L1BhVHlyZmVVYTdJbTdnNkhZ?=
 =?utf-8?B?bEpBNmtvSHBvR0NUVXloSkF4MklNaEdrd1hpQ2pUSW94RmNlT0EvanBQZXIy?=
 =?utf-8?B?RGxlWmYxTUhSbzcvRktFUHBJYm5zSWxSbWNUSGYwazYrNzMvcnUydGNNRlZk?=
 =?utf-8?B?QVVVUk9uKzA2S3N5VUFKU3VveUs2NWdabnN0WitSTGlhc0Y4VU5rVW5ORzI0?=
 =?utf-8?B?dWRxTTdQRVRCa0Z3eUg4c1IzVThsSGU3UTNrUnh4dzZrZDJxbmhqNTJZNGMv?=
 =?utf-8?B?VFhjbjh5cGN1MVA0eE9qd3JZdXNYblFRbDJCZ0w4MTUyQnNCcHQ2Z1l0U21l?=
 =?utf-8?B?YzJzRlRIUDBidkNISUg1WGhZVjBWTG9WQnZPTjdrU2g5YXllL1J3ZDk5Q3Ry?=
 =?utf-8?B?N1JZODBmMzhqdEdhOW9SNjFEWjdqdmw1clVYTVRZL1ZwZE8zeGVTYVlmVXhU?=
 =?utf-8?B?aXVTUVdSL1VxMXdaV1BWdC9KaDF2TW52Q0FBTVl4UnFuRVIzdURwN1UzUXBx?=
 =?utf-8?B?YVdJMnRveEw3Ri9hamMvbWZ5MjY3OFJRcDR1V0gySFBIaUk2SFIvc3F6dE1w?=
 =?utf-8?B?ZWNtNHU1TU9aQ1ozUndoRXgxbCt6ejc5ZkhCd0V6NjNvSXVjaVhxZW5keUE0?=
 =?utf-8?B?WEZUQzdtaVNqV3JhcWhkUXBnU1VlLzR3NzAzS211S0tCb3NESnpWdTdyMWt1?=
 =?utf-8?B?NThCSHpLRUNsRFVCM0RlUVdpQzVHdXJxTkFvenN4N1lYVklKZW1JeGJZUkdt?=
 =?utf-8?B?aVQ2eCs5WTF0MlFualIwWkc5U0E5UUZoZmlMZnRiYkRwYW5XNHNoeW52RnpJ?=
 =?utf-8?B?UG5yR1BIdFZpUXZ3WlVmR1BKUEtpOXBMUzNmRlhjSy9vaExKRW5qcnVrL1RP?=
 =?utf-8?B?ZkFieDFBSk9hRXRoaTZORGdjcDFZaFBtaDBWZUNsZGF6WGFtUyt2WUpnM2F2?=
 =?utf-8?B?SGJqRkVKOFNYdk1uK0l4emhqa3c3RGNvaUNDU1NvR1ZQc0luajlUd1JDaU5R?=
 =?utf-8?B?YmVKa1dqcWs3UjVZTitxeW5nRGVMWlE1NkVkYU5PbjcrVk1SVThCS3FqVkRi?=
 =?utf-8?B?VW9VOXgrMlVaSGE3QkFHSUFLVGdMOHBHQ0dpci9yZEV5M1BFUWVuWWR1NDh3?=
 =?utf-8?B?NmdKVWUrQVNvT0NIWU5BMmVEczBqc3ZvbXExcFdSOVpFejA1aWZJWjJkeG1I?=
 =?utf-8?B?N1NrYXQzblUxRkFublROSVdHaDVRR3ZLeHF6WkhQYkxzUDNoaGNTeExySWdL?=
 =?utf-8?B?UCtJNXdBVU1vSkg4SG9QVFUzYUVNYkVZelpvNFlEYy93SlQ0Qmt3YWpoVVBy?=
 =?utf-8?B?bUxDN2x6bDlrbHJ1cXcyU2k3MkJBK3R1Um9rTkQxRzFvRFRMQUM1TkV4M1FU?=
 =?utf-8?B?c3RjNzFOelEvbjBUS3R1YTBQOE9qdnR2cDNYNC9iQXhUZ09wdmh2UUNBZ0pZ?=
 =?utf-8?B?NUtaeTlpaHpGSjVPeFNidU9EMkRkNG41WGQxWjlncjFXbHdCTlIzMldBbGx0?=
 =?utf-8?B?U0lzZ21vTFcwY2RPM3hLZnI3UnlCaGIxdjM3TnA3czVVaHA1cVlCbnIydVdx?=
 =?utf-8?B?OStxNnVpejMrWk0yMEtMNkZmRG95eDVBbE1DMThCTnlkeHNla3RwSFVHb1Z5?=
 =?utf-8?B?b1FIQkc3Y0tKYndxOWEwV0R0OFRGNzhWcFY3OXZROVdYUm1PTTBoekdGUU1x?=
 =?utf-8?B?bm42Q0dkNWhFVUdFZ0Y0WlAyNjZSTE9NNmNhcXptT2ZxRHhwdDFZR01uT3RI?=
 =?utf-8?B?YXdRU1RMOEh6TTdPVVZiakNkSDJZREV5V3I4c0FNTVNCUTF5Z00vbExoMkJR?=
 =?utf-8?B?U09KUG51YTlNcjVxdG1JMlFpQWh0RG5pT080V09EOXpTbkFhMzRSdlpwdUNt?=
 =?utf-8?B?bncyVHJWM0lZWjhBT2xtT25nT3dWZlhqbGR0ZkJPTnZScCthclREZnJzOG1T?=
 =?utf-8?B?azE2T1RiZXVVVkNja255NS9RdjVPL1IvakZOaDZpY0NBT1VxbUg3TEV2SGdW?=
 =?utf-8?B?Z0F6aGhBbHlxRjhYRWxXTTRHSGowWnBEV29IdHJENm8vOGd4b1RxU2NMd1FW?=
 =?utf-8?B?djF5WUxjUlpGaU92Rm05QVB3ci9nSkI4bTJmZGp2MkhIQmpQUzFrZHNTYUhl?=
 =?utf-8?B?TWlWdFFDWGxJT2thM3h6M2JHRmZiV2JleVZXQzNocVR2R2kxNDc0UlNCZGlG?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d724bd5d-30ae-4016-3223-08dde76e3ca6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 02:38:00.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9dI08Pqn+KCPpddPsAry9BKYOaFit7QW4V4fz24g3fir7ILeA4wQktnRjUfmPEeymifpU16uZd4HTpydpixsarzJ8xHbXlj/q8VhCbWe0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
[..]
> >> We have pdev in pci_tdi, pci_tsm and pci_tsm_pf0 (via .base), using
> >> these in pci_tsm_ops will document better which call is allowed on
> >> what entity - DSM or TDI. Or may be ditch those back "pdev"
> >> references?
> > 
> > Not immediately understanding what change you want here. Do you want
> > iommufd to track the pci_tdi?
> 
> I'd like to either:
> 
> - get rid of pdev back refs in pci_tsm/pci_tdi since we pass pci_dev
> everywhere as if a pdev from pci_tsm/pci_tdi is used in, say, 1-2
> places, then it is just cleaner to pass pdev to those places
> explicitly

Maybe if we see that that are unused then they are easy to delete later.

> oooor
> 
> - pass pci_tsm/pci_tdi to pci_tsm_ops hooks and use pdev in those when
> needed, this way it is clearer from the hook prototype what it
> operates on.

I think all of the operations need the pdev + extra data so it is always
operating on the pdev to some extent. I think this is another, get
"Aneesh and Yilun onboard" case.

> >> Out of curiosity (probably could go to the commit log) - for what kind
> >> of request and on which platform we do not know the response size in
> >> advance? On AMD, the request and response sizes are fixed.
> > 
> > I don't know. Given this is to support any possible combination of TSM
> > and ABI I took inspiration from fwctl which is trying to solve a similar
> > common transport problem.
> 
> If guest_req() returns NULL - what is it - error (no response) or
> success ("request successfully accepted, no response needed")? The PSP
> returns fw_err (which I pass in my guest_request hook), does this
> interface suggest that my TSM dev should allocate a sizeof(fw_err)
> buffer at least, and if there is more - then
> sizeof(fw_err)+sizeof(response)? I thought TDX does return an error
> code too, surprised to see it missing here.

As we talked about on the CCC call it sounds like at least TDX also
wants to pass an explicit FW response code separate from the response
buffer, so I will fix this up to not follow fwctl.

[..]
> >> What is going to enforce this and how? It is a guest request, ideally
> >> encrypted, and the host does not really have to know the nature of the
> >> request (if the guest wants something from the host to do in addition
> >> to what is it asking the TSM to do - then GHCB is for that). And 3 of
> >> 4 AMD TIO requests (STATE_CHANGE is a host request and no plan for
> >> DEBUG) do not fit in any category from the above anyway. imho we do
> >> not need it at least now.
> > 
> > While the TSM is in the trust boundary of the TVM, the TSM and the TVM
> > are not necessarily trusted by the VMM. It has a responsibility to
> > maintain its own security model especially when marshaling opaque blobs
> > on behalf of a guest. This scope parameter serves the same purpose as it
> > does in fwctl to maintain a security model and explicitly control for
> > requests that are out of scope.
> > 
> > The enforcement is market and regulatory forces to make solutions are
> > not bypass security model expectations of the operating system.
> 
> I get the idea, it just sounds like it should be a mask -
> READ|WRITE|TDISP_STATE|DEBUG. Which category would MMIO_VALIDATE fall
> (set "validated" in RMP)? Thanks,

Curious why is MMIO_VALIDATE separate from other Guest Physical Address
validation? I think if it needs to be separate from other GPA validation
then it would be in the PCI_TSM_REQ_STATE_CHANGE scope as it is just
another expected step in the LOCKED->RUN transition.

