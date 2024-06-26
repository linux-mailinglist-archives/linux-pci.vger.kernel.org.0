Return-Path: <linux-pci+bounces-9260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B79917686
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 04:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811811F23E6F
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 02:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAEF22EFB;
	Wed, 26 Jun 2024 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DI7gg5Eg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A47845C07;
	Wed, 26 Jun 2024 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370519; cv=fail; b=UNQiytZQqJ+XCaNMKNXzTKckJuZevSEzwllwl3VaIVflJ36p9ylPczDHxReDU5wgfj94bgQLrWGKNB0vZPuqG3kJ2p/7hOhKlfTJKRpjXs1OG76KJ+CeZvdxcAPWMkZ/SviBGJRV4nylCZ7ABoNF9tUeHfllNIyH+pKc7LjodE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370519; c=relaxed/simple;
	bh=my6fKU7nAfLObte0ofaPvGx+8Gw5Q/XXu7EzTg4xeN4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sAZHFH3NXlp4wQN0DL5EzU19V2Ha+OsoNWBCgd2MDxU4tn+H+NvHDH+I/8WbhKTFSH/SFdzOacSxIQPKRn48/aFtwhTp2EunhjZ1Ij6sQitJVBN1EVcOeYiNVC7zRwM2GCQKLW+g7q8jiI6/LT05cSHapyDjy7HuWxZwKMz3w8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DI7gg5Eg; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719370517; x=1750906517;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=my6fKU7nAfLObte0ofaPvGx+8Gw5Q/XXu7EzTg4xeN4=;
  b=DI7gg5EgJPfFkBKZxrtZCzaeEdCb5JYchYLDYD08XyLw4H8OMFOd8OBF
   Pg5iiEt+0YIZOPkTjARpQuBPScPD8n2asMolgyG/PiUy/KXqJ1+V9jLH1
   Is0If4IQHiZjWIjhiU2neZidTiVgEvAOb8/VymwBYx5lKFLF+47ytjVrV
   EAM+4ZCiQq2caDzEVcFKSgKTnJi6DuPNtto2Z/pJtEdKIIR07Ht6C8Wqb
   XUlg6e940nL0geVaDeRjHVf64Q5vrRjPvrwaeXINQ9IWUNMjet+5peqE1
   GfuDAfIwVpfZJjgslRJQx8XbYEGYr8F3j9zJ/04DHMQXfrrT3gLTvbKsp
   Q==;
X-CSE-ConnectionGUID: 1l2WbralQ7W3SUuvzAkAlg==
X-CSE-MsgGUID: w1N27818QXeTsvcBwNQLBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16298424"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16298424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 19:55:17 -0700
X-CSE-ConnectionGUID: eeCJu4PeSXCoXOowblrT3w==
X-CSE-MsgGUID: yElSg5U3S3KT0ZyA+IqJRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="48431794"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 19:55:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 19:55:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 19:55:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 19:55:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 19:55:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b75q34WbGncLrCuTmxPazdv+2lVTW5ckxzARED3NlYojFV9qImcMC/D9vCa9fTlOkV8Q56b5s5CJZvaC2HNHpXu1183xzszDk0ANa9ah2ZdmNxPXvD8KEokxWFX7AuUZH2gmfBlMkUd87fi+2UdvJvde+vQLopVM1CLLtpnMdt/5Fp31iG2rfJVYGDexFEmU/G7LEm1sSDbR6oicwXFBbvzn02zHrxCMhkqhGrcIPSQd2e0oqMX91LBdbBz0tkiqEv4lpaqyT/akGRyY2eutHvPc8GAvBvN3hta/DF4J3ucK2dcyXeEJHEPR+Feyr4kNIZ0XDJ6UTc+0noukgQdDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8fcWnv2+PGH6Dk/oQYRJKeerN6aVOY8w91u20yG3Tw=;
 b=gwVDgPaXPo2qYC0Z4ogg2uOeaeRSOQKFppaoNAO+jaC34f8KNW3l4kkqjYv9k1aGybgG0ToJ2x9Iup24/224Wc1esXmdQRO/ifHP/r78GmLbO7oFXb3Ag/qCytrOK48OFnPsh0WqnbxdRDC/JYebqH2KpV4TbZpahYI/J3VJhWCFoGIUlGOCY50vNLXNhYntOHaNKL260rJ2bxb+4KXDCG/Dfh7gqziYCpb8ag7zS7LMJoPxQ6CI6+uagyh9pJTMxN72zMnqV22sZYprt3txwqH4r+qHYF8+A3PkDg0t67KmMoL1xpJ2/1aAmCI35yfGqi3N5h9NSysLLAwBn9uT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11)
 by SA1PR11MB5777.namprd11.prod.outlook.com (2603:10b6:806:23d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 02:55:08 +0000
Received: from IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0]) by IA1PR11MB7200.namprd11.prod.outlook.com
 ([fe80::8f47:b4ca:ec7f:d2c0%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 02:55:08 +0000
Message-ID: <6b1bf5ab-0005-4c88-99ec-92edca828f44@intel.com>
Date: Wed, 26 Jun 2024 10:54:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic
 notifier for reporting AER internal errors
To: Terry Bowman <terry.bowman@amd.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "Jiang, Dave"
	<dave.jiang@intel.com>, "Schofield, Alison" <Alison.Schofield@intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>, "jim.harris@samsung.com"
	<jim.harris@samsung.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "ardb@kernel.org" <ardb@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yazen.Ghannam@amd.com"
	<Yazen.Ghannam@amd.com>, "Robert.Richter@amd.com" <Robert.Richter@amd.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-4-terry.bowman@amd.com>
Content-Language: en-US
From: "Li, Ming4" <ming4.li@intel.com>
In-Reply-To: <20240617200411.1426554-4-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To IA1PR11MB7200.namprd11.prod.outlook.com
 (2603:10b6:208:42f::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7200:EE_|SA1PR11MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc13560-b629-43bd-3d5e-08dc958b6333
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012|921018;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG43VitVSzFCMmNtV05Xb1hiclp0YTdVSTRNUG9URjdUeVcwUkFSdmNNdzJo?=
 =?utf-8?B?REUxNEp1UjNOMlAzTmwwT1JKYUpLNnhxMEl5NTBmQnd5RmRmUU5uSDZ2M2Vm?=
 =?utf-8?B?eTg5VE1hbXJoc3V0Y0Y3M09KT2k3bjdYOVZBRGhZSVordU16bU5jUEN3Z2Zp?=
 =?utf-8?B?VE1ZMU5NcUF5KzBsYWFERnVKc01mOUZjL1J5d0FISzdsZU51d1B4Z1V5cFkv?=
 =?utf-8?B?ell0bFQvYjJpOGdRKzY4bGFGWElkaUJDcW44WmdlcWdsOUYrWHBlTUVGd25P?=
 =?utf-8?B?cExteGxtU0RhMjltVUNTaTRwNlJ1WG1YbzlnODJabkFxMkxERWRDVUtHTHNE?=
 =?utf-8?B?Nlh4UFRwWlJjWlRlMkttdVBSVlA4TmhmSTVuRUYvV0tBeW9GbmwwMmxCMUg1?=
 =?utf-8?B?M05sUDU5T3RsL3E2bkVYcFIzQTVGcnF2dkxlZC9yWWpUUHBOWVVGSzAyT2tS?=
 =?utf-8?B?TGxOL2JwMjRUYWh5ZGcyU1dZRHd1UFlYekRtQ3pEN1VpQklWZEc2STJ5VDhn?=
 =?utf-8?B?ano0RE9WR3lEU1VOR2ZDTEIrUHJQMDlGMWtheTBNK1FZOXRTdk51eWFaOTJt?=
 =?utf-8?B?VGEvNXJ1cWdMMXdTeHhudXV2aC9OUUpWaWhTcU1wWFRGMUIxd0lNWmVmNkxu?=
 =?utf-8?B?aDZ6VjFWenIrMkczU1BVMDRNNWtZTVg2YW1RbTl2eWtPelgzcG9NUnU0enhr?=
 =?utf-8?B?bDI4ekZ0R0JYNlV6S09kbklzaHpyOGt5MHdMcVJldzdFSSsrSE9ocFY4Z1RM?=
 =?utf-8?B?Lzd1SG9ndndUaVQ3MUY4R0NUNEJqM3h0R0dlSnNzdTErVHBMV3dHbXRKOHJn?=
 =?utf-8?B?TXNEQUJ3dmhUMGx0L01RWUFwMDRYZlVBSXlOZUs1djZteTNkUVcxdDlVZjFT?=
 =?utf-8?B?bXNzemRZUkJsTS9QK01pQ3phSG94bTAxZ29Vbk9FamVlMlNMeDA2aTdhSVp4?=
 =?utf-8?B?WURnNHRZdkk5MEw0L2YvblNPdmR5THBUcXJELzJUTlBZcVhhbXVLYmN1OVhq?=
 =?utf-8?B?N1dlWVh1RUZFY2FoTUNKbzhna0p3MHh4dVBaVE0vT0Jtd1hTWVZEQ1REUUJm?=
 =?utf-8?B?bGxxWUFvREFVRnN0UUp6YXVvZVFsMm8wWXRXb2FxNDFYMHIySnhrdk9GeHlN?=
 =?utf-8?B?RWNNKzVuVGpZbG04bHpHQzU3SlMwWllkSGQ0bXJmMVRKeHBnelhuNi9mU2xQ?=
 =?utf-8?B?dlp3Q0dPQWdxRTdQZkpmNTI0RVFlV3c3Q3ZodzJyZFo2cDMxRzRlakRuL0ZG?=
 =?utf-8?B?QXdqNEpid2NkQ2o0TjQyNE8wRE50QVpIY1VSUVhjUWM3d3ZIWmgvRG9uWklM?=
 =?utf-8?B?OFIya1pIZUxkRUxDTS9UeEVzMjdnbERBNkZSckdrTGVWbFlWSngybXJGVWNW?=
 =?utf-8?B?UmYrcUxzRHhTVW9QVjZoc0VIQ0lqZVo4bkFSUjZJbVBZMWhJODBGZjE2MFlE?=
 =?utf-8?B?ekU5dFZaS1VDZHFxdGFJR2EyL1Flc2F4cXdFaUN3UzYrbkFrTXk5enNuNnB4?=
 =?utf-8?B?SGZtd3FtNGQ4NERvNnhza2pHOGVKVEY2M1hGUXozaHFUVGtvL2dQb0NkYWNL?=
 =?utf-8?B?NFdFMktZdmZleXZ4bjRIcFVhRzd3Wm5NaEdZenF5TExZRHNsWFNrNGlKV2I2?=
 =?utf-8?B?UlR6dDhCaENNZThZSm5vOGdYd3d3Zk9qNng3d3htNWJROWZVQXoxME95ZmRl?=
 =?utf-8?B?UDQxQ0J6WDJuMThJaHRDME84T0JtcGM3VzZRZUcrZy9GNFExUUtWMHVDc3h2?=
 =?utf-8?B?MmpuRGRWZHBtanNmZVFwN1pBZGNZdFQyM2NzaTRpWlFIWEo0RitNQW1OMVFO?=
 =?utf-8?B?UHBOakVrQ2tTZXd3VUZMd1JDMU5MNTUrdUJ0QmwxeGZBSG54WTZ3c0JFeTRL?=
 =?utf-8?Q?AMfJg82/lxXcI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVBmTXZMQjREOXRDRU5rN3hhRG9ybGFuSDlTRXFJVlBKNmE2bmpZYTRZRVc3?=
 =?utf-8?B?MmhtekJLcHZSQlFCZFk5MHZVZzFXdGlFZmlwWGF6dDN0RGM4Z0VxUysyQUx0?=
 =?utf-8?B?WXFzR21ybUxXK3VsQkt4VVBHekNBUldCMEIzY3pMMHIvN3ZYM28xYUlsOTlZ?=
 =?utf-8?B?WGFGb1BFd2RITFBEdFNRcEN5RnNFVmNRVjRVV1dwdHg3OW90RGk3cldLVlVB?=
 =?utf-8?B?VHJqTkZES1UwSlIxZ0s5aDdFeVJwdGV4eU9aanpST2VVOXAwWHVPN2pXUjJS?=
 =?utf-8?B?Y1ZzRENkcDJQem0rLzlrbDBlRE9QcEwya0FYQzB1Vm44SjVpeGx1UEdDOHlB?=
 =?utf-8?B?YmRNWDNMLzZpWjdEV3V5a3liUElWNW45NksxRnJ3dGhrNyt3TVFyVU5Ib0xU?=
 =?utf-8?B?TitmV3k0YTRvb0xRUGJhQ2Fnd2doa1Y4eVZYZTdaNFdWb1lqbnQ3M2ozRVBt?=
 =?utf-8?B?ZnQvZkYzRUtrcE5QR1FGenpocWNGSFVlTjBpcXlYVXJwUHY5TEQrWlplT1Ir?=
 =?utf-8?B?MWhDNUlTYWpYcFBzVlZTNTJGY3RWd0hlUkV6Y3Y4anluSWpqbXZoOUdmTmVx?=
 =?utf-8?B?VUJJR2dQdFgyYmFLcjlyUmFQd1Z1dGpnd3JDdGlGL1BQT1ljZVEwUmtVTDBP?=
 =?utf-8?B?YzhwdFVEQVl3UlM0WDNzZEJ0VFM4bFp1eFlHOHplV3d6TS85WkNnUGdSOFJz?=
 =?utf-8?B?SGRwVE1SVWozMTZqTFR1VjdHcU9sdWpzNHJFZlVNTUI3THpUY0xYL3A0ZTRt?=
 =?utf-8?B?cWNoOXd3azVDMjRIZWxXZWoxU0dtL0htbitHdWNUYVB3eTF6dVRrVDI4VlZv?=
 =?utf-8?B?bXhSdEdkazBNajZlcUw5VlZNT0J2d3p0ZDZMTDY0VnoyOTRVUjhBMG9DKzdE?=
 =?utf-8?B?S2xwUXlyVG5SaHU0R041UU5yUis1UkNvb1duV2NlNXdjcHJzZ2MyTXlRU3RC?=
 =?utf-8?B?cTIxcWcwU0ZFMEZoWWI3eFpCZ0ZSN1dPSjFGZEJmMTNkSm4rVjZQb25PRTdC?=
 =?utf-8?B?Tk9IMTVyWkhsV1VXM2hlbHlvQ3kwRzhvWVFuS29ueXlWeGdFL0hobUNsUkdN?=
 =?utf-8?B?Ym5kZU8wTWJPa3dVL1F0OE5memlaUU5NSEtpQk9nOTN1aFRvQVUrS3E2b3BI?=
 =?utf-8?B?aHhxSFBFeFJCWllHZTQ3aWFiL1BYeElVb2RyOHp5c3ZQRzF5U05yRVpCSnZr?=
 =?utf-8?B?SnpocWZrUVlZdzg5NlNabWNJUE9STy9mQlgrc1hlWnBrd2xzQUN3Zk1sNHRR?=
 =?utf-8?B?Y3kxMnkxbm1GODg1VHVtbmphTzJtYlp0OVZGNnpzZCt6V2puNVVGdEhIZHlt?=
 =?utf-8?B?Tk9QeU5tMHNOeTA0ZkZUMkdHMHRTakNZNjEyQVFIYWlRS2UzVkVqbXlWRUxj?=
 =?utf-8?B?ZzIxb3ZkVGlCRDhncGUzTkFXc3ltaEdCaDg0MXpOb2dLemNCTVlxVzlWK2xl?=
 =?utf-8?B?VmZBbXRHYzFhVExOTVo0cHlZS01IS3pObHJWMmFwbFFvUXBsQnRyKzI1cnBF?=
 =?utf-8?B?WjZ5Q3dFQWNzZmtUbWRVTHpiL2pVVXJPRjdVMG92SGZ6YU1MTTJPWGk2RUw0?=
 =?utf-8?B?cFJUd09HcXZuSzJxc2RyWEprNHoxY1ZwQ1dDcWhOaTJFYm9SMGdyUkxYeWZ6?=
 =?utf-8?B?SjdPcnhISFRudGJmVEpXbysxbDRYYzRwdFkwRlBpWkg2Q0Zob1V0QnNmUWJ2?=
 =?utf-8?B?Ni9JUlZIK1FUalVUUEtmVVhXOEFoRjRzS1h4NjBuNHc4REJJUi9vUmlGN0Vx?=
 =?utf-8?B?cVNmdmlrOVdoeUpjcS9oVnA4eFFISHRHTkl6TW5JNmt1S3RsSyt5U1Z2cFdw?=
 =?utf-8?B?U2FWTGtZM3VleXI3SndiejlKZ2tST0NlSllncnFXSForT1ovM0ZUUmwvVjcx?=
 =?utf-8?B?RXVaSUhxVm5ENlhtdFd1SUxiYWVzMlRkRk5rYjhDVWlZV0ZKclFsVXpwK0E4?=
 =?utf-8?B?bWZmellKSDJrREZ0VnFtUWVLbC9WczJydk5xZm5SOG55T2wxZnE3YXp6UFJ1?=
 =?utf-8?B?STdFOC9WNnF3cm1SamNzOE5JcjJ1TzAvaGx5UERyQmlTNnk0NG9KOVhGRHBy?=
 =?utf-8?B?R2w3NEtDeHR0M2lsSUMxaGZjdkdMejQrcWlWVVU5OEJIMDhaaG5iem9WMFlK?=
 =?utf-8?Q?SpZvl5KLZhIrF+D32ax2B1G3a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc13560-b629-43bd-3d5e-08dc958b6333
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 02:55:08.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l0HQiwWVEuAdRWzWJPoLywjuO2n0qdYRfDBB3JNKBDvrCppnOJBCTNQI71Ta/v8epmPCaDYHWaUvylAKYmqGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5777
X-OriginatorOrg: intel.com

On 6/18/2024 4:04 AM, Terry Bowman wrote:
> PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
> does not implement an AER correctable handler (CE) but does implement the
> AER uncorrectable error (UCE). The UCE handler is fairly straightforward
> in that it only checks for frozen error state and returns the next step
> for recovery accordingly.
>
> As a result, port devices relying on AER correctable internal errors (CIE)
> and AER uncorrectable internal errors (UIE) will not be handled. Note,
> the PCIe spec indicates AER CIE/UIE can be used to report implementation
> specific errors.[1]
>
> CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
> are examples of devices using the AER CIE/UIE for implementation specific
> purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
> report CXL RAS errors.[2]
>
> Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
> notifier to report CIE/UIE errors to the registered functions. This will
> require adding a CE handler and updating the existing UCE handler.
>
> For the UCE handler, the CXL spec states UIE errors should return need
> reset: "The only method of recovering from an Uncorrectable Internal Error
> is reset or hardware replacement."[1]
>
> [1] PCI6.0 - 6.2.10 Internal Errors
> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>              Upstream Switch Ports
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h |  2 ++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..86d80e0e9606 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -37,6 +37,9 @@ struct portdrv_service_data {
>  	u32 service;
>  };
>  
> +ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
> +EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);
> +
>  /**
>   * release_pcie_device - free PCI Express port service device structure
>   * @dev: Port service device to release
> @@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>  					pci_channel_state_t error)
>  {
> +	if (dev->aer_cap) {
> +		u32 status;
> +
> +		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
> +				      &status);
> +
> +		if (status & PCI_ERR_UNC_INTN) {
> +			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
> +						   AER_FATAL, (void *)dev);
> +			return PCI_ERS_RESULT_NEED_RESET;
> +		}
> +	}
> +
>  	if (error == pci_channel_io_frozen)
>  		return PCI_ERS_RESULT_NEED_RESET;
>  	return PCI_ERS_RESULT_CAN_RECOVER;
>  }
>  
> +static void pcie_portdrv_cor_error_detected(struct pci_dev *dev)
> +{
> +	u32 status;
> +
> +	if (!dev->aer_cap)
> +		return;

Seems like that dev->aer_cap checking is not needed for cor_error_detected, aer_get_device_error_info() already checked it and won't call handle_error_source() if device has not AER capability. But I am curious why pci_aer_handle_error() checks dev->aer_cap again after aer_get_device_error_info().

> +
> +	pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_COR_STATUS,
> +			      &status);
> +
> +	if (status & PCI_ERR_COR_INTERNAL)
> +		atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
> +					   AER_CORRECTABLE, (void *)dev);
> +}
> +
>  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
>  {
>  	size_t off = offsetof(struct pcie_port_service_driver, slot_reset);
> @@ -780,6 +811,7 @@ static const struct pci_device_id port_pci_ids[] = {
>  
>  static const struct pci_error_handlers pcie_portdrv_err_handler = {
>  	.error_detected = pcie_portdrv_error_detected,
> +	.cor_error_detected = pcie_portdrv_cor_error_detected,
>  	.slot_reset = pcie_portdrv_slot_reset,
>  	.mmio_enabled = pcie_portdrv_mmio_enabled,
>  };
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 12c89ea0313b..8a39197f0203 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -121,4 +121,6 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>  #endif /* !CONFIG_PCIE_PME */
>  
>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
> +
> +extern struct atomic_notifier_head portdrv_aer_internal_err_chain;
>  #endif /* _PORTDRV_H_ */



