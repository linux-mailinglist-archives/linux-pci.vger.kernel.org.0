Return-Path: <linux-pci+bounces-22268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA07DA43007
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 23:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2422B3AC71C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 22:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F84F1FC7E0;
	Mon, 24 Feb 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPF2LHde"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D32C204687
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435880; cv=fail; b=tlIbZMCCpR6CkYIzhlX8YODE8+QxBlD8n5k1oEj8mEng+aeKKwb61x3gZK5C23BUQojtFkKHLvOgGTR3Ydznz6nGDaVOg3kh8hsgQzDEJ7/gnKFPz2a9FyLdw5IKljg5xPMCnjd+/b8w3GiH+xyD3iwEXpCY3UtKhnbZOFpTslc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435880; c=relaxed/simple;
	bh=8fZ27e7O7n78HfX4D2oqPqOqiwC+UUA+fTtKfZ+6kWc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q/5OPIb0DjOwdlPuLPW6N5Fs55VGUeE3roDxlrEsd8cYMTpaclnXtsf7l8JHNwrYLTj+fhzOYvbnv2fKG8ZW2gdV0qxcWxU0bpqi4Y29C0xE/9lC6vJIQXFHLyvwVWmsjpbN92jCiuVhthiRimIVhsL4t8ieqUL+uxdTU2OoTs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPF2LHde; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740435879; x=1771971879;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8fZ27e7O7n78HfX4D2oqPqOqiwC+UUA+fTtKfZ+6kWc=;
  b=QPF2LHdetB3XRuTE6a3+GlMf4H6BV5nTEE3md514fl9jwFZx2oeOQnwC
   sHf7GyUc83GxxApO2uxo2e/FtScSfm0kv7AvYQBe23FXiiDHzQ+oU9Np8
   i7YFofdYmfkSIMnTEGb5Ef99z9NRm7Z+g2hpjcrLs0iBiHozHUctefbu1
   +Wvhg/6ywqwHH+TTF3zKPBQEMfYlHNEdMSdQZmDHYO+La1cYvpi+tUsfy
   vcY62ntsyH4/eGbpDfk6+T4UYV3XUYZipn3jGpWAhEWEGA1wsfQ2bNAQj
   xgMHsXZPbJh/2ajXWs1B1VnUus/d/fTFw5tMZjGne9qJ7hcXid36BfQNG
   A==;
X-CSE-ConnectionGUID: VvQslt2tT/u0Ufq/RuRrzg==
X-CSE-MsgGUID: y5lw9U6oQuCfHfuY5xDvGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="63680130"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="63680130"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:24:39 -0800
X-CSE-ConnectionGUID: jcP8deFtR4WPySBJxj7ouw==
X-CSE-MsgGUID: KORIL+keQYeuMFtVSkaM+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153392980"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 14:24:38 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 14:24:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 14:24:37 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 14:24:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf8MmK1GEsGUNuk8vTy8jlfHcAE9Ssj+k1a518DnM3KOpoW43CuMz6eocQUYJI4ViW/doXs2tUPZxalHCLsr/JmVnIul6oCrnt4DlDXlWeYrlRxFqWLN+YZ7mMe6/gjUHLOTB0fubkeG0ftWgW/+1y4FHyesQTUSaOizKveBdA5kLV8yB2rm0I4uOtPhn/6c4WOnmb9QoxBrhI8Aic6K98B3GVQVC4kyqPrFFPjiJ8IULAL8NLRaX27aUscwgSlpnx6h7zApNOg/FhxpdDIR70q8funZnZOS2fbQPewkxCSV66PRklvqWsNvfMMqoDgPBB1jrgUeaavA/93aHpQ45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlfAEt80XpgDwICHVR1cJ/S5UzkOnHf5H92CSoKwFgk=;
 b=qXz0beUcmUpQ8Eiy/hs40camupITY5eE19OVBCd1PPiJckAlvCxOkO0KVEflfRXotVAafCYvpF8lD+44cKWSDAgYgxc7jEkj90uZw+bAYmi+emGdVHvHjKN/BVmksiaXDigq7S5j0/jsW0eCWfuzhosGOxU86m7sar956He5awg3dJ5mDH3XqSthArKzgTNC/+oIt2vbB89BxwjuBJWASas+VlAY0DCvIQIgyqXvi6pfjuc0IwQJAiNtzMfD7pxNfeg3lCAsrsouS3fpbMOrH9N4guk5mh1BHQB2q56BMFsgGqL1M9qC8e/+2LRx3EFWOud8zmZ5L3qAltzAooMbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 22:24:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 22:24:30 +0000
Date: Mon, 24 Feb 2025 14:24:27 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Alexey Kardashevskiy <aik@amd.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, "Samuel
 Ortiz" <sameo@rivosinc.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67bcf19bd1c7a_1c530f29449@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
 <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z32H2Tzd1UHCQEt5@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: ceec6977-ad6b-4cb2-e7e7-08dd552201d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VM0mpN9gKpGQrrkcNqsxnQM4ANYhfVDD+W57r93KMHvDQc7/GOntXrADdLj1?=
 =?us-ascii?Q?KpqZCZHK+YaCfqwYF7R1uw/Zhl/cII9qQn5/++amRkhsFkqK3M+Sb8e00bjd?=
 =?us-ascii?Q?YbYS7oQE38JmH3C96IfNBeQostPVSepm7vc09CpU1Bek+lUt4AX4TXDqiekm?=
 =?us-ascii?Q?aWzt0jY4GDGq6wWOrk73dxOIJ1KAlR/11dywDgJcgJjEH3OFsh/mO2WoM257?=
 =?us-ascii?Q?lKCy3puZCBkefef1uS2/3uLjBj3JnJ03LVWhNRRo5Az3r1GIj0+ugl1nI4ml?=
 =?us-ascii?Q?NKCQyf1/EW08cHLQ8Ptfq2G5PfS1Ha45kIpiFcFHeLswUAUDgs0mtPcUZ6Bv?=
 =?us-ascii?Q?dXm1Co3D6MLGNUZjW3ejcdlRiNoMc5KJ0tiqcFc9reo6VpxKy2xmQLNWXHYn?=
 =?us-ascii?Q?V1ag+SmNbqWIy5nssjidJ1GsL66+MuGL7Ko8SUhlAOkhdmW7aC2+0eTr4f9J?=
 =?us-ascii?Q?Xm1gDUY6+htazOPYvGtCcNaM1S6x9aC1O225zxomM31eHwgIipYv32WGlaeI?=
 =?us-ascii?Q?+qg+aZ1JbczHVkudQf3gAFJwu1mui9klC0pecSZkNU2WOtc8nPx/alWk4hJN?=
 =?us-ascii?Q?RRe9g59ujYq92ni3mt4X9BMJj3CW2feKlmJqJEY62ZUQR6OBUv45y559haZu?=
 =?us-ascii?Q?EbUEXsD+ZBQD/eI7lpRanHj8MGRNgOWb3M1JbD2/rJF6spowVDZdfaHZvvly?=
 =?us-ascii?Q?hNPaeUFuM0xUk1waFwujtQktJB3RgA1y/69oz5mZp3DtuLVh4ZTmuwZOg9rz?=
 =?us-ascii?Q?eav9dZRP7P9y61T+iv3h54ja5SQ0+yh4hXj6ya2hdBcnWjyB9C2iKDqok9Ta?=
 =?us-ascii?Q?ACtFARUjXbOjP7XwIKHuSsNuyMO42dvQ42MeYw0FG7gu02/ZWZVgx7iksc4M?=
 =?us-ascii?Q?jxJXaatiKfzwChvrx7B7grQCzxB1L42SVgCQA3PiUxWKqZ/EA7Z2axCxt/M1?=
 =?us-ascii?Q?L9UGjc0W2NEMkvWjsim5v2HcKRKoImYddL5vPFpJzBfWpG07q1joc/z4xZPk?=
 =?us-ascii?Q?/JwmGgelpAW3tE715tf7pehVWO/O/X1qQ/vhE669zDIy9jcSVaApyOGjgW7g?=
 =?us-ascii?Q?4JCty83le7WORe83y9EGGnTJWLBuYAElnyXA+vn8I30/GVkebxRnfS2DOVub?=
 =?us-ascii?Q?6JwGZgRRECokllwsXRv6e0T03hZwuKqnnx9J7ASuK1ngqsZ7JimrYiDN3HEo?=
 =?us-ascii?Q?EB2ffNURoOhgcTo4W/0PwbAxDi5WJumjmKvcuUB6tGqzfxykdKUUCSoKcEGM?=
 =?us-ascii?Q?NAQYxPnIquu2Fq/uhfi5nY+Qcw9xd8+L6W7enrYu7kW6cgL2V9Jm4e37+KZq?=
 =?us-ascii?Q?ostuezZmMJWqUSFnF9ziaxwd2jAC/N2Pp5lky+tYDJjrrjoeWc7j0IQefSqF?=
 =?us-ascii?Q?R9/A+TcTfpum4Kf6N8fgBvkYd+kw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Di+82of41DornCo4I/eyYaC0OJR204H+XYy2MO69gONPlbWPKh3nri4/MdE8?=
 =?us-ascii?Q?HOJFjndS+/qVun7AqJomI7pJuMdhIh2rCyIGK0BVWN8JQiO/mYmSfejvF+wn?=
 =?us-ascii?Q?cj/SMWODudUrxpPiWMUV0sGnijlhhqRKZyXAyMfq22PM20h3Q0rLmUuE1Zmw?=
 =?us-ascii?Q?uvvKDUl5DJrBX1zHzvRJ/7gbG04AfA94Dwx2mf3Dt9uwA7jNwvjdQ/rXcnXq?=
 =?us-ascii?Q?rPgUtXf4yKNkyRAWzKKN0pLGLxU7ZT3KKQYfgOR8ZZbNeicDSM5Zy6i5TQI+?=
 =?us-ascii?Q?0Ntw8pAY7tc1dI2ouJeTlbES7/pB376AW/ngB0zPBTrBjl0w8Frgjra+RBba?=
 =?us-ascii?Q?vwMFBB7Pkuir0dZulQ9ggy+Hcz7tvt2J++gyAoAuD2F1BHjlzjW6Uy3IwZfE?=
 =?us-ascii?Q?LFBoiluYap/U6wa9uLLhmOSIwYSYxwxPPPlubv3nFtDnKPspwX47w8dm1mPq?=
 =?us-ascii?Q?E2zL5qYo3rFoUo2VmpApT86ke9xhi2xKcJ0GyruMN2VCEY8PUViukJr2U+le?=
 =?us-ascii?Q?O0kdtoaC+yHK9q/c8S2hQXNwJ6ufow/x/tT8M/SohqaOEBs6BCiQmjjQIdDP?=
 =?us-ascii?Q?IDDLBXL6ZoZfjbwi7dZVkpIvMUIUb1QE/nXOz/KjnBbP6P6ioVLlApySfjfa?=
 =?us-ascii?Q?t+WgIB0vwVWNnu/Uhi3zcXDcK8S4briveNf31GBbSTpp441Pa4V4vBL/OchF?=
 =?us-ascii?Q?k95r1+4agDytVZdoEQGWYwU6CdN9sf44myry4G3nWX85Ynswle8bEp8FOFlj?=
 =?us-ascii?Q?0pnzvY1+p9OCOW96gDi5MgmukGoAVuryGCHZUfaBoT1Mi4j33rXzFAqv1cpI?=
 =?us-ascii?Q?0yRabKasUAAo8MaWIQk/xTcq7RDx1N/iUYLVgpUJz9+rWPRu7It+JZ8YtXlx?=
 =?us-ascii?Q?hc7J554hEJe53YaQirr649arpXW0GnRp6HElQNV+vpvvLXP6N64nLi4r2tGA?=
 =?us-ascii?Q?iYSQSqScpCSf1Ch/QY9CR36tox4T/E5maSkWA8hCx5MsLyIsI3tDfSmWVcLq?=
 =?us-ascii?Q?jfRcOWYX5ij5Oo9UyA5SwVbRpkGzMAMboZu/xun7hIpxzia3rGL81Wbcz/XT?=
 =?us-ascii?Q?2oI0O4CNJhJScR3eM6IqBEK6a4xqu2Qmb2AIkLuPfABPW9qi3EQdRVByqhCN?=
 =?us-ascii?Q?jmLeVZQzP6+dXkew5+s8Qy8WmusFQHCVMe04NrqKQ/snh5oJxa1lah7aDdAg?=
 =?us-ascii?Q?NyXDG/EWZej6EqyjnLyuAOdHvrzxJ+LSmaBA9irBOG3mnUbn/Uho/CRVjvzM?=
 =?us-ascii?Q?UMHF70Vx+pgefOC7ZT5A3zbrXIMWLTsQhS25ONGvfidUS/eArHmnjVFDkHgh?=
 =?us-ascii?Q?ljhQJIk8pEAoVwikI4Rv2kx+8aTa8HS74ksCLwayNLVr5Pd0ZRTIRv15F6QF?=
 =?us-ascii?Q?f/+VqR2eLIIcBahZkE9y+rH9FWQovty2OpJ1ReM/+PlLaw1JWfm2WZtvqbbJ?=
 =?us-ascii?Q?rKGnDeh8opa6OKtVAu8/J0qGzMFa8nZXDTPekOhuELXb0F6rjIDOFbCR0vkP?=
 =?us-ascii?Q?wLxr4IWmMdhVCuMY4575QOJsJOKKP6j5sIVinxdV842hJeFManiYemvbyNjw?=
 =?us-ascii?Q?eIzdkzl5iDsEk4rRXyxDPD4MDWch8HPxOBQjFi4pkvrHmEOjr4puKPYqwJrz?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ceec6977-ad6b-4cb2-e7e7-08dd552201d5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 22:24:30.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02OSB+YNFUrfQRMvjEzJvOq6RoKSjtUPNFT6ksu3rDr0yVu9XJT2vdyoQRNEHSCpIVE9oqS8OiYVXsiuUKh9hS0QXQfJt5LxcMuv+qtBKxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

Xu Yilun wrote:
[..]
> > 
> > Oh, when we do this, the root port gets the same devid_start/end as the
> > device which is not correct, what should be there, the rootport bdfn? Need
> 
> "Indicates the lowest/highest value RID in the range
> associated with this Stream ID at the IDE *Partner* Port"
> 
> My understanding is that device should fill the RP bdfn, and the RP
> should fill the device bdfn for RID association registers. Same for Addr
> association registers.

So you expect that the endpoint programs RPs and Peer-to-Peer RIDs in
its association register? That makes sense, although I feel like once
Peer-to-Peer operation is considered the RID association loses
effectiveness because it is difficult to capture a constrained range in
that case.

We can start with that for RID as our best current understanding and
circle back later if it causes problems. As for address association I am
not sure Linux needs to worry about it in the first implementation. The
mechanism is too coarse to keep up with IOMMU entries for the device. If
it already needs to be overspecified might as well disable it.

