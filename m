Return-Path: <linux-pci+bounces-5511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896CD894987
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 04:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8492864BD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 02:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F951119B;
	Tue,  2 Apr 2024 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8+3lKmr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A76FB5;
	Tue,  2 Apr 2024 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026078; cv=fail; b=nTb01pxS50rmtxz0SpCi6Bz/Hw6v7AtV+WRPsKoUBddj8aiy0eEAIZx3YS64oevru7fu4mhFDTIvfYSrF7modwBINzPa3TuF4si4GJ2VR79ajheX0rJ34XfGMPLsxB7XOJP18W/T8XSbMNtm0CrsFBHEzmubscEbBH2bwkrFl+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026078; c=relaxed/simple;
	bh=2S06/SPJMNoEV0Nri9IkSBsAnfeCRCRR/47apk1cN8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DlMQ0Ya+vLkV4L4oItb9FynfArqhHJjn4vvrmcjAhAYCffAbPYwwvFnheTkRw1TZklK0WzRgjp2zRXE+baK4xbuCp6JPtdf6Tat/RSU1EM4+8ZreM17ZM5Mz+AiHi3AfKQNCkRjG4G2N+3EEEjRjjKqW5y9vVtiUKvDHJlpTjCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8+3lKmr; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712026077; x=1743562077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2S06/SPJMNoEV0Nri9IkSBsAnfeCRCRR/47apk1cN8I=;
  b=c8+3lKmrcUoBBxZWidzYTVy3tzUe8H5EPDFSShYIu6gG17vOI5+qTAQB
   sc2HHrsS6PY2UR82IFRyyi15a3rK8n/ijxiLou+RA9vVfgO5VJ52VYrOH
   OW/nSMkEQpO1E8VQMMoJD+U/t1NaiwdeO2nr0eRa/nge1XF69KFZmTYZW
   mA9W2KH9dh9yd0Y4CP7wgyCy2wmz6Oq0PYDib9XFBeqHzwzNu+X4wucbz
   slEP3hMa2u/sSWGW7EOlXVTbxFe8WJTK8lrEzkt0CGM/S2OtQUUvmdF8z
   3D0JcA5bojvsxJ6/6Uiog4llX2/GauySpoTLqlV1OcAGpc6AWbfYdN/ug
   Q==;
X-CSE-ConnectionGUID: FT4ViYKERx6bWSnFN2Y7nQ==
X-CSE-MsgGUID: nT1rJRgRTF+ottPgFUv5rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7075423"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7075423"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 19:47:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="18368611"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 19:47:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 19:47:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 19:47:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 19:47:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MME2s4Ibd3/f6ghnnUMIEQgDRNW/alF57iDcYc94OJYpg+U7YWFDmxeEl/PXRa3efZEgp5SwczPUvwpHjMOUyiLEpZR8TCR8PQSXilFJliHteTKFFd656aMzMmzMVr4IN/D28RlS0RddUhqUaxiVyt2/z3Y9U9nPuCtn+f7HaYmeIYdPRg+K+inhJy0bRMxLaqBHog2kCRSIswNO04N6N5eB9pbbGdik4t4i3zhf09ww4Ilh0YLCVqcKdwNjg+A78f3iCwy3xXZhx3+c6mr8lEmGdqSyktMQ5+OUarQdBXMQjPwqlYMfSk9TIjoRO//qrt0EU0YUZSyQ3W94+VhO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnKqSjbH2Suhv3oz0ZIyaiVfJUqFBBxhprKa7G9oq/M=;
 b=IfKZGFCEI/ng3EtWnzG6OoITcFWe9Vok/EsiUZMNX7+Ey40fw1DqyujhwOL1SwwXCXNqZyo7Q4oUcbK4w9Tr0LqT5QhtBXqcP1dXNidkLjidHb94RegsjHPdPQD3MmHDkmpRusq7/iRtGsehpdFVFcLWAKFu00dALrXlXbdiBHfZj5jz36vvWPS6DWwUVqj1jeL/+tnReg4EtPQMvTuSK78Z17vg3EgtpIgN0CVBD/WGpN4Dvj7X1mZAFr7Ra9ESKpwJaochuRMwC8kFRaMn2RG0Y07m08pUOpRDhjJkCPF0VGJuspUbzUjJBlrN8GQYAbkmB/k2m24ol7rwY+a3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6515.namprd11.prod.outlook.com (2603:10b6:208:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Tue, 2 Apr
 2024 02:47:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 02:47:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, Megha Dey <megha.dey@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: RE: [PATCH 2/3] Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
Thread-Topic: [PATCH 2/3] Revert "PCI/MSI: Provide pci_ims_alloc/free_irq()"
Thread-Index: AQHahIuliRyuVzARvkqtnqbJY4rvQLFURsVw
Date: Tue, 2 Apr 2024 02:47:50 +0000
Message-ID: <BN9PR11MB52760177EFA980DB3B3125B38C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <e5bacec0-28ca-4cd9-9ffe-92feaf5fbfef@kernel.org>
 <20240401232326.1794707-1-helgaas@kernel.org>
 <20240401232326.1794707-3-helgaas@kernel.org>
In-Reply-To: <20240401232326.1794707-3-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6515:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a3LEuGEatyOAIDeKomvwThtKxbGfynBl4rfCgJOREg/qXjhzJmv7LYt5mOe1ENy594hwPwrMo7zlP/idbjjdjHko58WjN/y4InA3esrGsysZyqA4lSjze+gGVmmfJDs1eG2vRipvZrAiRzg719RWrxjgqrDZ3yuEnvBvxOIrniWSTRPCaBgASY60DrOE/+FcgKwJpZa0a+zruFXgSkQTeltv5bcsCh+jAsvW5GYLH1uBzvQg0ZgRljG7Xd2op2jXU87o2cGOFBvnakdFnhzkja9OFrgDYxYwX3pcgvaNaYLxhV8v6ihk2hKmTumX44eaUMMrGB/Mlxo8Y3g8MePUPWsw8NGh/ckU1jhT7G/PNYzatU27/vrKOiKxWuWxNA3lSOxM2Ch7fTPY74+4yhnXMLecbSLRrHbHPx3YtBiJOdH9kvsCmZnNJKQ5b+vyw6z2PSi6YF2jEjbEuOYr9DtquMoshehU6UBEDyEA9JMO3jjqrrGw+iFls8129wVNlzcsuxW+ELyBB+6AyJLgpLEbqOYvRrvvNVKM8i1eZl615h8E043kbcWyZJUm38Ir6c3H9VNad3BNn5ubk+tuvGhQLf12ProavqwUy/RhD91t3QDCP3eGP+58Wl1/jynNjJYM3CNpy1ehwREdVBDPcWRYy5ZBJOQRF1PLplZIrByvsKI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBugXunfD7iYcaNJLouQXlrEMOqLveCEnJU1AAjB0r0VoDJHazDTj47p2BYF?=
 =?us-ascii?Q?3hNpNCpMSAaVt5qAp9QyHKY7XEO8J4JxlTOHSUW/UzDftaRkBDpI9H2EGN66?=
 =?us-ascii?Q?AqbqrJkZWJ2i3TRxBaB7rD7pJDQ5tnSxnjo7EHDR1eTXvUc9fH6+tUngiAYp?=
 =?us-ascii?Q?MktqAC6/GYL2NUjHadubJhy1hgAP6w4c9eCoEeZOAzKyoN9lH2wXPf26owgf?=
 =?us-ascii?Q?qRWKApfw10negSuHuVQV9AHcBtNYyT9jRm5eYNq7mhISDGmBeTf6ByA7GnG4?=
 =?us-ascii?Q?hz9TNAcM3/aWVo4bk/7xdd4/v/+PQjGerLvJc8ZCLyPeU5fzW0YMtvxjOmfV?=
 =?us-ascii?Q?taxx5PpCr6/irtyOzlGYwKof2nMZL2DTyEr1odMeZoOxx1TYcwllOK5evj6N?=
 =?us-ascii?Q?OzbyDDP9JABqDadCmtvwKikDXqnHr2vh2MOnRVDFfbtgkzw6113bPuGJ5rps?=
 =?us-ascii?Q?moagxoArtg4RUG0iKVX/d3hWjowkb0ZMPKOKNwttUwLQWKf1s+zGDYRGOKCg?=
 =?us-ascii?Q?mz9/Ks+CtmvuLMXGXGEKl9zYR7NPLIj/7sWFI1yoTzu1ZAB0m5YOdVlwSyFL?=
 =?us-ascii?Q?4J8ZC7Ebjz6/HPzmedLKxQdzX/kBUUmNOQgcqSKMpWoJzJ2my+CLou7KapOl?=
 =?us-ascii?Q?JnhosdoijEi5vQln1IBv5AuzuZEerQuDTR0VfbyHNIJgtDQdps2bJl8NSCqV?=
 =?us-ascii?Q?Pj9l8Y4Yu+NzsCGiA+wIw2HjhGXbMmhrEjCktEmJKHgrxSbHGkVnL33MVshK?=
 =?us-ascii?Q?lz0QXapXx3YCsAvfkx8HNfu/qHy9GC0EXWM33AhLn7Cc5l9VgTXcG1NOM94u?=
 =?us-ascii?Q?ALClt+UwxrqdKWv8dFjc1oIihZ+zON4s+a6ieNHwnmgHrZWsGMNVquHHE9dZ?=
 =?us-ascii?Q?2KB19KL56C2kyErXPlS84gJ/bXJsHIiMypbmxoNh4JOJOas69HNbg7IN2MQS?=
 =?us-ascii?Q?yvfeKOHGDOC/I6itpgi3yG39JMBdXGhGrg4yud+K0RS3IYCkOwjds/UvVvp0?=
 =?us-ascii?Q?HrlHVnJqyG/CjAT0lIAHIaF5B/aP8MdbuboVFir8FQQUbl599ZjNzmqmlVTP?=
 =?us-ascii?Q?/1W5An7TUMv6Lm7oGvlKpVTDdF2TXhLH/eVhfI6JASkpHUNjRUNuLEDV/Oc2?=
 =?us-ascii?Q?6ZJ+twCw5VzSItWZKksW7NZ3GP97wL1ZIOJgKCbFfE6KyLayFfJ0w8ZxVyTp?=
 =?us-ascii?Q?NtstX0iCZylY2a/aGefghX/+FtOZGX06/lc7qenZSomryAu2ye7TSVjTP0Nm?=
 =?us-ascii?Q?9EYHP36hJ8DW+OvHJffXX3pZwJMxY40xqLpkjLemfvPL+Ea2RfIDGCw1lkCs?=
 =?us-ascii?Q?3VqcYLZAodRHym1X6hZYBeOTWLy7tCgHGhPM1cxBGGB0JCF0T6/YsMTEXunG?=
 =?us-ascii?Q?cMjb0xn8CyuYRTrpe9uwJLQhbDT1ZZ87ckxNMHOtObHWUkp78kA4E7IgDd3f?=
 =?us-ascii?Q?wxe4AiWLcNLIKAcLNzMf0nK2/w+jxHpWPpCAITPbi1FOxDJqc8xqC6FGMp4j?=
 =?us-ascii?Q?ZMsAuMoNaDXM6olp701FEoxHYg1juJn/uz6hgnEEAzk+rGPTeb/6A7798t+G?=
 =?us-ascii?Q?Rc1wpO/Bv2SM1b3OaoXK53Z6KSbA7NZvc3JIhOUH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8645e1a-4ebb-42ab-5cfd-08dc52bf498d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 02:47:50.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/FWCVfHGg8eCAC19RlIkjjKxa5Lh/kStKhhbxIoj1LrzT7hr0jVQoKUPPhPsEezHT/9XRFbYHKZImvTi40tZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6515
X-OriginatorOrg: intel.com

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, April 2, 2024 7:23 AM
>=20
> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> This reverts commit c9e5bea273834a63b5e9ba90ad94b305ba50704e.
>=20
> IMS (Interrupt Message Store) support appeared in v6.2, but there are no
> users yet.
>=20
> Remove it for now.  We can add it back when a user comes along.  If this =
is
> re-added later, the relevant part of 41efa431244f ("PCI/MSI: Provide stub=
s
> for IMS functions") should be squashed into it.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

