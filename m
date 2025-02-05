Return-Path: <linux-pci+bounces-20723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13801A281C6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 03:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3193A57CB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 02:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8F212D86;
	Wed,  5 Feb 2025 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWuyXvZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978778F4C;
	Wed,  5 Feb 2025 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722496; cv=fail; b=Y5yLD9lb/Ji6AjooShWOPSTwezBgTlZBn+22Nl/FF7RQWAhCucwz06XrD/GHsFkrIHk3IFax2BVYYflKlZ3WIQ1Dt6/ONo2qqKKoeXEIW4cdQySfOBU2X2BUyAOHKT3aY5aFJZtiRUdEMzB2xDrXC8vRPx41PJwY2tBTrSDLuUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722496; c=relaxed/simple;
	bh=KpnIQ1sPabS/3MlRDnd4rVYHRAnuqt7ROScKACN/G44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sj8wyhiBdeDhwzylidscYbAl3f/pgwkPImPHCXUPGYBrayrreJul/hmMRFy1BeRKT9FfvDjTeVGpnxqjUgKReUvBgfqqlkOMglQKRHpABLM+iHWgSzNChs+MOJXA60yRFQo9ij92mceYxmva2s+6HR09SfQdRYwsFcze2Xj9IOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWuyXvZB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738722494; x=1770258494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KpnIQ1sPabS/3MlRDnd4rVYHRAnuqt7ROScKACN/G44=;
  b=gWuyXvZBFhHF9F54GyxdXne4/vGvGN1AAfbMw+g1Mzp9cVt+8kTqSect
   1o1WYEbKuzle5D/q2iEI293iYT1ff/0FWniszH8C7SGdPBjoC5sZF5Sxv
   Qw4gBfXubcHs4YyRXiC6iBMrtUxY3eipAyFwIig14fJZbDZE7vVcq34bb
   X6g1cW+gVF9DVEOIXb2RQFztwK0pSBXQ6zxdciu5BwxN24hzT+CMc4AOZ
   V2OUAXs8nYeC8SzJNRbhnydCDA9HZd5ghbPg/iqKnAv8n1KFXbE6Z3UDC
   ySS/Q/g0iDvLkbVqpCo57QLI1sKh98GNQMNkMflX3xjSBe9h6wLO/CNqh
   A==;
X-CSE-ConnectionGUID: WEAdQ4OVSn+VLE5co59LSA==
X-CSE-MsgGUID: PB5bXeV5SCmYxh8xcNb1WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38978213"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="38978213"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 18:28:13 -0800
X-CSE-ConnectionGUID: m1qS68B0RSaaJLqISPaXzQ==
X-CSE-MsgGUID: NLKEu+1iREmUx/naxtWsdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="111311262"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 18:28:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 18:28:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 18:28:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 18:28:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvfq7mx0YipBO+wBr/EYYp+7cP1pB7kRkPK7LWmDNxA0fhYXHTrcjCUz8EqLUB374AVLP5+pz6tY5/LcFmCq6U1s8Q+yqnO0e49WVvIlgrPf3v6HDX2z9oLlku16LSFGNi0681aV1UxatbWUCNlauT6cudbGm9lP45TYvP2zMyK0Ju6+NMv92HNFiYfGcMCxQz3dqB7T0ul+PB+8/Ghl3VcQy9vGJCXOHZ5tEuyGbVBGe0KabAguY6xtvwKo1hmgaqEgRvC9BK1ud9dPiESFgiixvcWmsQ5X6ZMEfzhulqCPmDfU1MvueRpml64HItclenV9tUBgQmerCTlHoSTnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn60QtAyId2L4rIGc4S7uA54HM8prOLS3a7vHM/pGLY=;
 b=Wx+sIwGxdbxIqsntTD/nSADdYm/lGkQ0nNHKIB3vXnofLN1XyPfZlJeyQphsRdq0NUho/qDz0KjvCZZz42YCxO2jgH1dD43N3d/ACWNo2b5WFK3SikYj/dhjlmwhk6z+IdD49uGwVQ6wh25OU0xhPbWwUH52bby6Tl+pWsu6VD1dUI0JIdR+dpbqbWme3UZhPpM3d3Rh9c/CPGvFn8plv8Sxut3QEkD0d41r0+aOgrZWAnyR9QfWJ4acqcdlO2GpUCxhnNh8K49bmgGi6kLqzg7VDtGGVoIDL0RcqsA3boDE0m/3XGEl2cTIugTKur5ITJZ+U/r/OedUJnygzz+nHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 02:28:09 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::cbbd:ed55:576c:fd55%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 02:28:09 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Philipp Stanner <phasta@kernel.org>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, Mark Pearson
	<mpearson-lenovo@squebb.ca>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
Thread-Topic: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
Thread-Index: AQHbcW1Qev02qCR6X0eV5Ad5QyfDyLM4BrRA
Date: Wed, 5 Feb 2025 02:28:08 +0000
Message-ID: <IA1PR11MB60987BC206B8654F48026EDCF4F72@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20250128101156.77868-2-phasta@kernel.org>
In-Reply-To: <20250128101156.77868-2-phasta@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|CO1PR11MB5026:EE_
x-ms-office365-filtering-correlation-id: a41f8c00-89af-4ebe-827e-08dd458cbaed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4IMKdw/y1zTAUEV+b42K5cIhnK8DXduYfVm3XJaI9eXaZ1YKrMeGLCrNHGQP?=
 =?us-ascii?Q?yoASP0N3NIdTVk3qlwOFLs/ng/DwxUlE3VNlA8CJi07TNZ2BkbwFd3WjqkSR?=
 =?us-ascii?Q?HGtVCF8Z1+N+xE+HNfBVSxVwVW0mfQZyLoNwo/n6tbTub0Fr/hkcNd1gh5R8?=
 =?us-ascii?Q?4LWkpYyd5sXmgfdyx9ke6vlmF1lNZY1+sJ066i88jof6acyv/t2arG0xIRXT?=
 =?us-ascii?Q?CwjzkfDS23mm3SCDa1OL4SdXE28HK5GYcRONlHnQC6uZDj2/OWBON6HI8dEW?=
 =?us-ascii?Q?RKd8ispHk4WxqxAoybuZlaWWIbLr8ExHvuDN1pqk6m+EQcafc58qtYAbIW0l?=
 =?us-ascii?Q?GqOSNX2801HGmD8cAbpwNNdvXywm3OdjpioZ7IFBegX8HOACLnN/eMu/4Xuo?=
 =?us-ascii?Q?sy6Kc+ZaTjOeDbb2/8d7oP24eoX+IK0Uf4gQ86e9jm1Jo2zTmxX85khfO3L3?=
 =?us-ascii?Q?l0LWY4HSreJpib+/nPB0LQhk9V9dYWaviEvPNZuI/m2XnEsj2Ht2v2htM3wg?=
 =?us-ascii?Q?5epmCQpXALeNPLr1uOCXL15JBq0kPHI0kT1ILDfrV0T7aByOw33nC3gaBd73?=
 =?us-ascii?Q?B6DXjwM0emP8yyZlh7V9BKw9DfFL/bH0xRfYrNEbHhZjKpCh+z/t9KRxlnga?=
 =?us-ascii?Q?cc5oVfFxAs7c9lj8NvJA95X+2ZFsepPlpFy2GHMAHEzt+CAczClGiolfpokP?=
 =?us-ascii?Q?3Ln4mXsuIlEL9WDvFnamG038Spa3nmAcUV+RjUXgN+T/EhTaRSDSYhHFJY80?=
 =?us-ascii?Q?gs7tMFCGupb4ExiHB8efYxBx+uDGBKkmegautUreGNdcE0LMr2eL9+C5ekt7?=
 =?us-ascii?Q?n5bf1woiKEoCymzY6loLFPN7tAfnrm9bCkx6paYIzxI8D8bMXiM4vvFM4K+9?=
 =?us-ascii?Q?XE/g4tBkPkvPH07Ep2heuCuIczb++1FB+uZ3vB8LDG90tDPG1Cfm8oxbb3wa?=
 =?us-ascii?Q?cMH2Me09uRVZWIi7hb5NblAw2+3lb6MmjQFZhunZTVqoHNM0EvkpufhfBzO5?=
 =?us-ascii?Q?8L8nX658/DqSkIASzs8SSODzAdWX+XmMXnKIduUyzeAFCwWVSF8sbHvKMilY?=
 =?us-ascii?Q?Ha03ndLISZINtknX70hW9oZupjrQsYE80+vIcAMTn8oLrz1TP3bMXykP2FHc?=
 =?us-ascii?Q?LIaXWAvhPQNEZ/n912Kkqp9YLOVH8KIfSqV81Prt3Tqh6Xt3WdseVayNFNDl?=
 =?us-ascii?Q?hgrRPDDV87epXn0cJ5um0xDSMCxHPhSsBA3grw/tfiSjdPGEpqVaYDWsoviS?=
 =?us-ascii?Q?h9Q1yvQfri0v88Zhtf1nUp8J7ek1baDX4i1TImDPj4zN1P7kWUeCkQ+yuRV4?=
 =?us-ascii?Q?to+27uuEDiELlE2QQPF0Apx4r4BueSClFCPNkgPA9ILZau6HN66MS7fiOGMC?=
 =?us-ascii?Q?fQ2UAgLLo/UJBeWwIj2uEpVCoZ+OVwV5aRi3qdf2SUdPfGOK1E8xOyukEmtu?=
 =?us-ascii?Q?Ra/NuDc+j55sq71sT22AEG6EoOPg5Qze?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Few+vIbIcVPPyn7oc2PnI1Kzwc5uBJFCKKj6RtelQjRoB32E2EA3432+s0CM?=
 =?us-ascii?Q?MT/rxY8hQMIsZDowQbhDdeRACBNP4SXv+jtOUujFmm63I2UofN4D0IDRlFee?=
 =?us-ascii?Q?PxB3rBSEYlJtejwFi61LAGo4+fkU6Y1o+tLOGenDgbFaDQ8LbEOTG4k+HDrE?=
 =?us-ascii?Q?uBbZGNybJXMTayOndioHtFuhUsQR/WLgIuzksUpoT8cAryuLN6VmaE9GoYtI?=
 =?us-ascii?Q?Wk+q0wNMqVZ/ePIxILG4zimmu9yI4cKG7dHaewaK2KhuAK4+wbRcmPXvlcm3?=
 =?us-ascii?Q?sDj9Ohu2sZ4Km8xlzC1Sf7OWBmWN2UuydVJdt+scs3TB3o9j2swqEJhDEu7Y?=
 =?us-ascii?Q?1uArb6iWd5KQki2zpjejWqMYMh6evpxEDx+dof60x1TOa5akoL1585/sUaFL?=
 =?us-ascii?Q?BhvaIP3k720koJX4fQPGaij2cysLqtYMUtikyoJZ1Ogltt8jLl5urpA4a5LK?=
 =?us-ascii?Q?FUFSK50R5oMjCBhGoYFsg5oN1nyEchLG1xQdEm/JbmFckA1NmDTNN4O5wBJm?=
 =?us-ascii?Q?sf4TVTVV74bi6+kJhMwxI7RJDk/GMWs+5YN4QRPQjYTPtzTNOoeliPtnciK9?=
 =?us-ascii?Q?XjZst+z18Mj45eu7TWFw+U3Ihdj+gC+qmQ9hnXCq3LO9Ri4C+RGialmHRZBf?=
 =?us-ascii?Q?LJWqDUAU4HnZ5lk5ChDQb5DLlFiGquohhFoiSDJz+GBz6cJdbvtgOJ65/GqI?=
 =?us-ascii?Q?qVCj0OT8qzL1QqahUj4yJKa0Fx0RIihhUxFkiqU/KWpoCjmYSQ4XzZVY0A0q?=
 =?us-ascii?Q?Gbf3l0VEh1HWQYomrg6YAWA84usQdSHzMBJOPe/F9SRjw5f2ZcYmTeA/2uOX?=
 =?us-ascii?Q?6uV/heSZVDLiEVpx2pnS9TXbI5ahARmWJuBBQH6YXFCQqS7gjkr2SnGQtONH?=
 =?us-ascii?Q?fLt90mbU97uqwiS7WNaosdMRvSzIqaGfjY5s3hi9b3j6Zm5UVPzeyD9IXvUm?=
 =?us-ascii?Q?rmcrenWH9cS3Sedp0Qit3loGZhz2/B34UjWIyROQDZZHan08e+Q2ByYgWi4N?=
 =?us-ascii?Q?e1myOxndqLGqL/Rz1W95F48ZpVsawxT8JOgC99KwF5N+7gGcf32iJdjYGW8I?=
 =?us-ascii?Q?n2EVcDBoGJhtahS0mT67NxvXRRW1P89f+r626Tr1vbWrx2mP79lGJTOu1zRF?=
 =?us-ascii?Q?yjdTtF2hmgsG27lm4j+wauNMnKcn6ZLJnF+ydvXzrO0qYg0m+M9UTs79SVgU?=
 =?us-ascii?Q?1LwhDkw5cfkXqZny30xpgMuohSZc7t5orzqlPAwcIZqYs2yDwsns9QymLWxi?=
 =?us-ascii?Q?eCSZFwgp80k18qVQl0GRedp/TSXfANV6fl6qbFhAr7qiIaT1wKtbNBXvIUBg?=
 =?us-ascii?Q?8jxmwgCUqHM8MMSmqEZWdhgOxs1yAEq7l8wxc+fYj7zNRlaKF1S7QzHu0LNS?=
 =?us-ascii?Q?CbqT6nUQ7V90SdGEXSXZ8mZ0vqnUm7/U7dZtAvVnouawecCybaM1sWuJ387B?=
 =?us-ascii?Q?AGEtxLIiGYCNRp8ZXwEV0YRzKqNjNeUc4LUiWP9jCkG1g63knfnFgtYY1LEB?=
 =?us-ascii?Q?Wjh7TgkRR+zANB+ZAL3plZrnTmheFKAbRv1v47BcHbrNAvL66tgDYuTpZg/Q?=
 =?us-ascii?Q?7/y7wXVX01UBLQb+7iE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41f8c00-89af-4ebe-827e-08dd458cbaed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 02:28:08.9828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NW6/rKUmC/CyE8DF6Ibm3FVu46BO5Y7myHIndZsNIPSuXSiUFYr9jIIZ2NNxPoOrClJ5VwZrmWUB8jthvrylKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5026
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Philipp Stanner <phasta@kernel.org>
> Sent: Tuesday, January 28, 2025 6:12 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>; Srini=
vas
> Pandruvada <srinivas.pandruvada@linux.intel.com>; Mark Pearson <mpearson-
> lenovo@squebb.ca>; Philipp Stanner <phasta@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org
> Subject: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
>=20
> intel-thc-hid reintroduced the already deprecated PCI API functions
>=20
> 	pcim_iomap_table(),
> 	pcim_iomap_regions(),
> 	pcim_iounmap_regions(),
>=20
> none of which should be used anymore.
>=20
> Furthermore, calling managed (pcim_*) functions in remove() and probe() f=
or
> cleanup is not necessary, since the managed functions clean up automatica=
lly.
>=20
> Replace / remove the deprecated functions.
>=20
> Fixes: 61bb2714dc3a1 ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI=
2C
> driver skeleton")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Hi,
>=20
> I'm trying to remove this API since a year. Please pay attention to the d=
ocstrings in
> PCI which mark certain functions as deprecated.
>=20
> Thanks
> P.
> ---
>  .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    | 14 +++++---------
>  .../intel-thc-hid/intel-quickspi/pci-quickspi.c    | 14 +++++---------
>  2 files changed, 10 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 2de93f4a25ca..fa51155ebe39 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -557,20 +557,19 @@ static int quicki2c_probe(struct pci_dev *pdev,
>=20
>  	pci_set_master(pdev);
>=20
> -	ret =3D pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
> +	mem_addr =3D pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
> +	ret =3D PTR_ERR_OR_ZERO(mem_addr);
>  	if (ret) {
>  		dev_err_once(&pdev->dev, "Failed to get PCI regions, ret
> =3D %d.\n", ret);
>  		goto disable_pci_device;
>  	}
>=20
> -	mem_addr =3D pcim_iomap_table(pdev)[0];
> -
>  	ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (ret) {
>  		ret =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32));
>  		if (ret) {
>  			dev_err_once(&pdev->dev, "No usable DMA
> configuration %d\n", ret);
> -			goto unmap_io_region;
> +			goto disable_pci_device;
>  		}
>  	}
>=20
> @@ -578,7 +577,7 @@ static int quicki2c_probe(struct pci_dev *pdev,
>  	if (ret < 0) {
>  		dev_err_once(&pdev->dev,
>  			     "Failed to allocate IRQ vectors. ret =3D %d\n", ret);
> -		goto unmap_io_region;
> +		goto disable_pci_device;
>  	}
>=20
>  	pdev->irq =3D pci_irq_vector(pdev, 0);
> @@ -587,7 +586,7 @@ static int quicki2c_probe(struct pci_dev *pdev,
>  	if (IS_ERR(qcdev)) {
>  		dev_err_once(&pdev->dev, "QuickI2C device init failed\n");
>  		ret =3D PTR_ERR(qcdev);
> -		goto unmap_io_region;
> +		goto disable_pci_device;
>  	}
>=20
>  	pci_set_drvdata(pdev, qcdev);
> @@ -666,8 +665,6 @@ static int quicki2c_probe(struct pci_dev *pdev,
>  	quicki2c_dma_deinit(qcdev);
>  dev_deinit:
>  	quicki2c_dev_deinit(qcdev);
> -unmap_io_region:
> -	pcim_iounmap_regions(pdev, BIT(0));
>  disable_pci_device:
>  	pci_clear_master(pdev);
>=20
> @@ -697,7 +694,6 @@ static void quicki2c_remove(struct pci_dev *pdev)
>=20
>  	quicki2c_dev_deinit(qcdev);
>=20
> -	pcim_iounmap_regions(pdev, BIT(0));
>  	pci_clear_master(pdev);
>  }
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4641e818dfa4..514b199cb884 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -575,20 +575,19 @@ static int quickspi_probe(struct pci_dev *pdev,
>=20
>  	pci_set_master(pdev);
>=20
> -	ret =3D pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
> +	mem_addr =3D pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
> +	ret =3D PTR_ERR_OR_ZERO(mem_addr);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to get PCI regions, ret =3D %d.\n",
> ret);
>  		goto disable_pci_device;
>  	}
>=20
> -	mem_addr =3D pcim_iomap_table(pdev)[0];
> -
>  	ret =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>  	if (ret) {
>  		ret =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32));
>  		if (ret) {
>  			dev_err(&pdev->dev, "No usable DMA
> configuration %d\n", ret);
> -			goto unmap_io_region;
> +			goto disable_pci_device;
>  		}
>  	}
>=20
> @@ -596,7 +595,7 @@ static int quickspi_probe(struct pci_dev *pdev,
>  	if (ret < 0) {
>  		dev_err(&pdev->dev,
>  			"Failed to allocate IRQ vectors. ret =3D %d\n", ret);
> -		goto unmap_io_region;
> +		goto disable_pci_device;
>  	}
>=20
>  	pdev->irq =3D pci_irq_vector(pdev, 0);
> @@ -605,7 +604,7 @@ static int quickspi_probe(struct pci_dev *pdev,
>  	if (IS_ERR(qsdev)) {
>  		dev_err(&pdev->dev, "QuickSPI device init failed\n");
>  		ret =3D PTR_ERR(qsdev);
> -		goto unmap_io_region;
> +		goto disable_pci_device;
>  	}
>=20
>  	pci_set_drvdata(pdev, qsdev);
> @@ -668,8 +667,6 @@ static int quickspi_probe(struct pci_dev *pdev,
>  	quickspi_dma_deinit(qsdev);
>  dev_deinit:
>  	quickspi_dev_deinit(qsdev);
> -unmap_io_region:
> -	pcim_iounmap_regions(pdev, BIT(0));
>  disable_pci_device:
>  	pci_clear_master(pdev);
>=20
> @@ -699,7 +696,6 @@ static void quickspi_remove(struct pci_dev *pdev)
>=20
>  	quickspi_dev_deinit(qsdev);
>=20
> -	pcim_iounmap_regions(pdev, BIT(0));
>  	pci_clear_master(pdev);
>  }

Thanks for the fix!

Reviewed-by: Even Xu <even.xu@intel.com>

>=20
> --
> 2.47.1


