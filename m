Return-Path: <linux-pci+bounces-42671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 656ACCA5ECA
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 03:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46E9C308FBF8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 02:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844641EBFE0;
	Fri,  5 Dec 2025 02:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTIWcFY1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8421A317D;
	Fri,  5 Dec 2025 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764902806; cv=fail; b=P5dDVzSfg4J/vUxaiY9njzFjXJunRohiXEcW5WaAYzAbhcJYMAmS6x87ngzuc8VDZDaDFGBhcWINuErTiXGHTJHAxCuWA21sZVMUWM6X5QH8dP3k4LCh/DbyeeDFHm5Y3nj0n7DU1lWHBrJN/KEiYaoiFu/FwiQH//rFqffrSe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764902806; c=relaxed/simple;
	bh=3nKSXZ/W3bxQ8hCdlD6tLCHp3WjgTgujwCzFT6m1b3I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z7livaLmVoiMC24QO6wjVTEi8BnVGo/9dovMcO7Uf4WEjb2vRjeoNNw+I+o63Y2rSpzJ9c8QOrlyXNOJeq8BIb0tSprlSAQymMKuXD2HxT7tOVud/Pn5mfwF9Sx+DFSAVO1gl3RKh2jketIw7Yj/6vNms3FhPjK9N2UgdaI8cy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTIWcFY1; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764902805; x=1796438805;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3nKSXZ/W3bxQ8hCdlD6tLCHp3WjgTgujwCzFT6m1b3I=;
  b=RTIWcFY1WrT1QyP2kcZPPEizE3Wo0mh1v8SB1oZkBUtfXZ+26zHR1q/c
   M7d8O7J+Zb8kp+rTfiV9aZDEBUKZKKrdU3OaLGwUeelyEW24J339aSdqQ
   qiC5FV/vS3lunKQ6yS2H5keMqJEeSQlwz4ez0iGQ5XLZ70OXNSe/sDs5N
   9HxEJ3+KDtQI+Zq3dRI4u+5xIBIrB6/dL1TSHTot/80bnAaF9/WX8rod+
   XoG91X5ja/IYnVljp9pQR1k3zxUppTNiqrw5kuv6rUdYOfonEUdsrIMgp
   KBhKk1NIwi4PWxD1YwqNAa5O0uvfpCrOuqB5fu+EYorsxgDvMcMlnUGJm
   Q==;
X-CSE-ConnectionGUID: 0vkZxPzbRnSavdCUq9DWEA==
X-CSE-MsgGUID: FCdA1ED8SyCo7T50MWaebg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66124381"
X-IronPort-AV: E=Sophos;i="6.20,250,1758610800"; 
   d="scan'208";a="66124381"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 18:46:44 -0800
X-CSE-ConnectionGUID: AQvO2v9uSpik6ejQ5qE5mA==
X-CSE-MsgGUID: TTn1NPk2QaOc3CHHqczuzQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 18:46:44 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 18:46:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 18:46:43 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 18:46:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI8KQ9HPjNQFWDmPJth2j++LC25U79wcJkh31yIpiGpoYu0wvp/aBswYpsOEhmMhImkXHzw72MUnXtpbycoVz6Af0FAA1R/dqzTRK0dk3BadhkVoM6Ipl7CV5v4Mt+2hrhDMlueG+4Kbbi2H0Wl+rROTqs2zTiKjCsDaKfEK8IhQ1ybanIYzX82iOU+pfFPpo76jW8LsktSLIEujB1TK1OWPBHoHRZkdlwks3v7lpeyHFefc0ms6XFDzZVoxSUbDMKwBmcjQLm8d24kQbxYD2qGA0zWMdfNifItpYN1P9jU3XM/6V3bQLiXt16fTx1wSKmoAqBk4ZRNDeudZbYAgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmWkF85ICWhXyot5bqUfM8pHq2a1EJzUZbxHAj8mcSk=;
 b=NDxUr+E43DCxbH07/ktyaBgBk4ySmqQ5h/vVlVx+YSf3m/ohXPD5pTOwiFX/xffICAzKsEpeW2YE9FLz/65cJIRRF1J+g5p+UThafQ7IVma6NBfoIwaxoQHyXS/jqSoH9dl/BOEjyrT/O/8hLzAk6FT8apCOOY8PWb5Wfs+nvPT/buuLjHjQmbtuJLZQV4RFcbQVCFD+7OW19cGCTFFgzJUhVQb/MBqpBjGNYMMbT7hmRlp+jbEgqD0Z/283eGyn59ZXDzh1DYkefr0l0crKZIFarUgPC8dUb4Pf5Mdx9HaMI2WzZCIRj7Xvw7F5JoG1nsSZPu5y/BFHOctgH9eARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB7991.namprd11.prod.outlook.com (2603:10b6:510:25a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Fri, 5 Dec
 2025 02:46:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 02:46:41 +0000
Date: Thu, 4 Dec 2025 18:46:37 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
Subject: Re: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
Message-ID: <aTJHjeQRGD9aKoAd@aschofie-mobl2.lan>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204022136.2573521-2-dan.j.williams@intel.com>
X-ClientProxiedBy: BYAPR05CA0072.namprd05.prod.outlook.com
 (2603:10b6:a03:74::49) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 638651f7-f659-45d9-0345-08de33a88525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HgHuMeDjcLeOWvpukK0A8YWYfQGIX8kAfaFlfF3gC7+VW9VL1xf3kYVt6gBn?=
 =?us-ascii?Q?M8dUgvOl81IwgcIFTQWqhuDwKC3aaSWDB4JzW5ApRYFVi3bqKSw13LUcp4fO?=
 =?us-ascii?Q?GqpcD3MEBpQOnOY4JP6t2iLTYvXq/f4TAWTcgfjOCsTJLAJGcnMc9Pgbx9hx?=
 =?us-ascii?Q?DehUYtUjef9NfsV2kMCE31sAYHPsUHHyH+syXDlqpEku3AJLEYAMqXu3QcaL?=
 =?us-ascii?Q?HuYPQwcT2xOp0MM63TQaNWKYdU6VPMwqD1luI8YL2KDDKk5V/uxaffR7Nv/X?=
 =?us-ascii?Q?q7FZvldmLbH8RqgdQo6yHem/qJkUNH7W1x4v76xOtbOEOIHgO4lvms+PomfC?=
 =?us-ascii?Q?ZUcuZpuzQZnrNalPX26YPS/HsKwc19CwtLT3C62HoaN9dcVyYNxo8jR1BYIU?=
 =?us-ascii?Q?6TXDX7SS51yLFr2N5zHUmMiILSjbrOiiPnZjw/KVT3hFjLh32XGIiaAGcLf3?=
 =?us-ascii?Q?jv/G4xgc3IFHl9iMyAc5HHct/rq9ksVvcmy5+svTWkgLqH6aMByVwLi7PnAm?=
 =?us-ascii?Q?weiHsiSD3neUj6cZTupuGivOfE7ecI2U5GtF2luDH+WMuhp2oydgTtf72IKO?=
 =?us-ascii?Q?iaGu8qx5AbRD1xjm/z/fQ2kgEquOInzNqOA1aWtTiHRZuqKIQzxbOcFrPxZt?=
 =?us-ascii?Q?F4r+GmGyWubEYFEZK2f+5+z+4Gw+18PjxmuAPi221AGFstQNJvOuDYfTLwQB?=
 =?us-ascii?Q?le34vPK8ll72qTAkonY14v0SA5HARmPuYgPEqfscciwKsRPpOGb/6udIKcMw?=
 =?us-ascii?Q?zcfPnGspVImra29kf5zaNNjrOVS/I+YU1MXktKQIK4iI29Soj/HG+nIaSv+/?=
 =?us-ascii?Q?ytnkXrTx0qCGLvJXXpD6HhP8VKV+lZGczSh/lnKsZ3CLD5WB2lJGDgT9v9pa?=
 =?us-ascii?Q?o5FuCYlxrj+sgrbMldTplPk6At820LD4BM1PNkyUFNlTbjzb3oAw0pNWa3om?=
 =?us-ascii?Q?XGdPLOslSEZ08l6vTgrQBEqXela3gjSf2OHwR/0WG6YtqcNLij0w4yle1Ruf?=
 =?us-ascii?Q?qcfAMfGi0Nl1Q+sPQaMy0REop8FdUbGoVabyEvWhmAfaOgxax7pQaNz2Embi?=
 =?us-ascii?Q?TGZo9xaBsTAJgWqrtVKTfsqK/MHFL029sGRSQt9P3Tfxk4Tn2deT8PDHJ6RR?=
 =?us-ascii?Q?wdI3Y5XKLe9GX7DJ8q/owpknJ3AcbStrmn8toPQkBBjf6gXYxE0r3f3q02Z+?=
 =?us-ascii?Q?fQU1PAgL2DM386gxfefQ4lD4mxFtc3m11zwOvlTI6Z3su+nC2m8p3N3BZ4b3?=
 =?us-ascii?Q?9E7PvsgCKNL/ZrjOMOMTHCex3ME6gY4P8H2pdIuH8ubAg/DrBO4H8joeipTV?=
 =?us-ascii?Q?4UNCy+ddZpQH4jTLXwgml+CdRM42yxrD/jZd42gZClRaePkcRPWNqXhAb2aU?=
 =?us-ascii?Q?BT2jq82kD/ooK13QJ1POOg2vLyPRmtxhnr2wRl2yZZYp3t9NQ1zyUzBdMpqU?=
 =?us-ascii?Q?wLWrp5IfF655u4oI2Hq4KhvBP/ZF69+n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sjMvcQg+C6O//h4ac2q96CSjV6zwVVNJm37vpxjSZXOKFArBzYTHnTatgsOH?=
 =?us-ascii?Q?8nKVcdzQ7vNKH+eV7q3VgTOP/5wwp2fhd4SnYJW6HEBRtJ8qgq/A7GKHCBun?=
 =?us-ascii?Q?XP2FtQDC+ZVoVgrX9UyUOHDDEgaGsyYzqrCvn3kUhAZ55KvkCHQSETQdMBuE?=
 =?us-ascii?Q?Dvez+Xo56HHzu3HtXMtOoKT/aV2umasV4JWx/yCp0U5ZwPdQce1HXendRqPx?=
 =?us-ascii?Q?eqDI3cnfoFA9Avr7JmFEVFnob9FUbJvmTiIgU48Zm/2aqnWvMVIHu2+IN+jg?=
 =?us-ascii?Q?byKpDoVcshyq7evJeNIkhsTCuWUVujF1Eyr0y6r/LzeiCW3zsv76F6brFfUA?=
 =?us-ascii?Q?LcGb/NEx03zLHNgHv3MYcdXVGIsjGbWxfyjQkX6nu0EMW/q7CRGFfF4JM7di?=
 =?us-ascii?Q?qBiaIqt+eT23QvUCgkaGx7D+v+LoCDqEg69NKOaOWdX+VLOXUljgCO/IwfB7?=
 =?us-ascii?Q?hcZlAHW5D9pz6dnsw345uVS1SCIDfa60Kygva93V5T+8f5mr08yjAP9vO8i4?=
 =?us-ascii?Q?hk9BozdwHv5pJCbV86jYArctSXoNCgCl4VbO1gIL9oarKd089OlKaJb/nNvu?=
 =?us-ascii?Q?r4oD1yCaq9KrULgtwZzpfC9H8lrYtP0EPidrOETCAbnedXAzRcVLzdRANW1x?=
 =?us-ascii?Q?wSxt/YhzoKPpkCWFI2lBtxQCNh5VyCD9OahwpA7BE211CTA0rc9L9Gi5Vg6J?=
 =?us-ascii?Q?cUXAvVjh/3//4o5by1gYG0JOHWf39GSy688OOSI2kEbdtlJeMKKPkg2E+A6P?=
 =?us-ascii?Q?plvcQjzid7+i7sCR4Vv2Hd7RwLrarSaPLLl/dj+YOPMHi+0yBo4R3IwTuh7/?=
 =?us-ascii?Q?loyx3N4CQSAF5PqN2tId3nNVyy+yuUmflPYgLayBKa2DLvuZ+3m+ub5YKP5V?=
 =?us-ascii?Q?65wgK48DbTPZAtHfR2cRw9YeVOUYaN28KRQOsSzLwQiGtGbOjOlHou5l1H+8?=
 =?us-ascii?Q?q47brhXlcWKCLiqCfwvI3kDsyLaicb7R3TqllTYVyvTKnGtw2/FatrHEVos8?=
 =?us-ascii?Q?u9FSBb4/HYaK6rF3fg7kdRlxEWo9T87aHaZEKAIULgNObmvhxfsDWOiYGz/J?=
 =?us-ascii?Q?DkBd7cyVg0bj7EKfK9CHdBdFysdR3z1hkxl6ZAEl7Th0bgvc0pP2NxpgFf4M?=
 =?us-ascii?Q?wJpq+gI+HMvzlwzaN0Od/EU9ejXA/qtoryChUNFJ7HQurX5gM5ROIQZ6NIux?=
 =?us-ascii?Q?U2xI23CDB8R3wg9cR0upRfHXRTKRbQeQxjYtlKPAcT7A1avgru6XmTTbJvrt?=
 =?us-ascii?Q?uyhj7Sulz/V1kq52po3IxXE52KydzSE0BEvhdyOh/EGwickFdelvT5vOIm89?=
 =?us-ascii?Q?eGJYTLbOPoD55z8B9+kEQXbsv2+zTeLn6HdSCfv5bYqYsJMxJ7niKT9gz2oQ?=
 =?us-ascii?Q?Sf3jnPcFa+1K1od27ZTGIYWVHHcsg+ejKIsVit1RgBF94E9OlES5Q3Zbw+b9?=
 =?us-ascii?Q?NY+31Ht2DOgg5Z8iZopzQoMbUz1JiTRVnW0j7+rm+3fEEfR1X2t2YW5rfFmq?=
 =?us-ascii?Q?KPRRtXidju5QFgRcZi8bky4yiw4jW8haqu6esljdoSADPMN+o0DIT8NqNbIf?=
 =?us-ascii?Q?GTnTyYusUYdq9OA/yLDAxkf0DAVO7Jn4r/f4G4UPh1WG/3kZ0JMLuKAGrS+V?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 638651f7-f659-45d9-0345-08de33a88525
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 02:46:41.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2WVakdTtCajUuqCWAG2kXRZzkvoCmuHa+iSgW2rTabCJBIIFSHdTSsScA+gx7QURE9RJMBhnIqlxm4+3yZklNhph19c4Zf5GVQn6v3wNlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7991
X-OriginatorOrg: intel.com

On Wed, Dec 03, 2025 at 06:21:31PM -0800, Dan Williams wrote:
> A device release method is only for undoing allocations on the path to
> preparing the device for device_add(). In contrast, devm allocations are
> post device_add(), are acquired during / after ->probe() and are released
> synchronous with ->remove().
> 
> So, a "devm" helper in a "release" method is a clear anti-pattern.
> 
> Move this devm release action where it belongs, an action created at edac
> object creation time. Otherwise, this leaks resources until
> cxl_memdev_release() time which may be long after these xarray and error
> record caches have gone idle.
> 
> Note, this also fixes up the type of @cxlmd->err_rec_array which needlessly
> dropped type-safety.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


