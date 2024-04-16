Return-Path: <linux-pci+bounces-6336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 600938A7708
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 23:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C2B1F217C0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 21:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F180E69946;
	Tue, 16 Apr 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgMgIstA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607425A0FE;
	Tue, 16 Apr 2024 21:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304318; cv=fail; b=FwVAIbL2iy62ZlK5xek+D3Wb8EmJNx2b1vQL7rOEa/Wcg9TG4dtXOx/AAUGKjf0/o9yNMVxIYk5B3YU3x7CPmioL0QVDA1Z6fG7dgRXK5/Zey3CYZUujvzsvaMix5/6sd9uFM1iFE03eUQv1Rn8E7iw/ngEMCQI/iN0vKqsaGX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304318; c=relaxed/simple;
	bh=9hl+MstOBg7O+0AjlbW0s41d62S/bEyWCfL51QJNYk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hADVCOpdoEopwI7EDyzCoQdSDTp23eIR7OKjTT9Ny625spb2pbGsIZAFm/xiPqt8BJ0kcMMfg96+foIO6MflthtKyCaFNhoORGSB9Oy//mRL8Ng4KfJSAlJjyy3pimZ+IGKodPCzwapfcTDJSiQ6y44jhiEEAvPoo15ARC/DIRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgMgIstA; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713304317; x=1744840317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9hl+MstOBg7O+0AjlbW0s41d62S/bEyWCfL51QJNYk8=;
  b=PgMgIstAPTYNRbdjBS54SGnUdhkiIl8aDCfxG299yEpt32NIPWZ+YTQM
   QEYoIwB+eaqJIwC9Tb7vMuT1wZnEleGhbPJ9cmDJ9uOCOc3GGtRHkXvnt
   ucPnHX2yCPEIbBY29HSTH9iPHpIYorPjFbsVWHHsPqbzKJfnWgOE8LDlE
   Z+cahaBoZfciVTFzEgZSv0ri9p7I3TU4AYatvEXDqWSZmAmDD5BCrd5Lp
   mcwLjdWGJyhI0/gmjmuHfR7tMkFMJpwt+YCOmX7zgP7IJmt0Xf9rTlV+h
   dGYjAFaygw/ildjXZpXf1F1JOCvyfSwoKNbT2eleDTVBXvh2288040Y9V
   w==;
X-CSE-ConnectionGUID: /uE811YaSMSesxUjJ7sbTA==
X-CSE-MsgGUID: TmmVm3a5Tw24qtqV3wjVKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12553878"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12553878"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:51:46 -0700
X-CSE-ConnectionGUID: Qy4OjMT4RGG3ECGE4q9IBw==
X-CSE-MsgGUID: AuJoDqNaRCGnZOyF3uVp9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22811848"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 14:51:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 14:51:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 14:51:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 14:51:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 14:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHr6CUh47thDE9LA5Riz/TojoYpJoZJVINbIVqFZxjNtBTC4NylO29TzmE8Et8eV1aNgj4rJtpkRqQ242sZwF19eoNunYAjETr306z6AKyF7XoRfSUcb1/NnrziReDiK3hWU6/UyeD1waVTbK0CyYD1kT64zhigadWnC32o867yzfgqLidMZk7YF+Kq3aM+hm4RedvUEV361KzSGGsVxdV/0pAn6LWwrXYZTUnUH5n1q+IAeJr6tLTarsoPtWsHsaFdIAL0d4FnKj+6WYJBYIB8Q5Mr2HyCZhD46bByomTtw2QU/CIWb02P3Z/sN9WNqEleNZ6NxlsqB+sWEY64+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mH2mb+st3r+7lZx9JrwQGDTARYPEesx/n3omDO7Ym1Y=;
 b=O5qOtSSFlsOD4ogfnzMseP/Hug0/hb1S7/6HHhCRm6O1sbwrg7v+ChNh6gFtE34M9P2T9ui3d+Gc4MMOlPkKCcXoOFE70euxF5RSrssVrPXVSEbXKoz2ppND4g8eNoC9h1VgQeS90i6gPBCFZsQZRPqX3VvpdzXPAkR3as+MaWglLsZZ/vi2tFTSIu9j5vd/o4447m4fy7l84pNjXV6LmzhjlBkwEQENTG04HThR1vbnppNqvwGBCVbogaQjxQ0iNjquiT5+HRE8zo7tBA1C/goh+BTUt0wB9F7bcsDXPSuSQss3Fp+Xun2ENr8L3rHDGE97BedNUfWjFrjS8cpCuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV2PR11MB6000.namprd11.prod.outlook.com (2603:10b6:408:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 21:51:43 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 21:51:43 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v3 52/74] x86/cpu/vfm: Update drivers/pci/pci-mid.c
Thread-Topic: [PATCH v3 52/74] x86/cpu/vfm: Update drivers/pci/pci-mid.c
Thread-Index: AQHakEQw0Gncz10eKkqWeLHGxTUzQbFrbDuAgAACu8A=
Date: Tue, 16 Apr 2024 21:51:43 +0000
Message-ID: <SJ1PR11MB608361540C2BE3D9A68FB7C2FC082@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240416212219.9643-1-tony.luck@intel.com>
 <20240416213813.GA171111@bhelgaas>
In-Reply-To: <20240416213813.GA171111@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV2PR11MB6000:EE_
x-ms-office365-filtering-correlation-id: bf384ac0-5196-438a-4ccd-08dc5e5f67c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OneZIkjkXXGG0iaoiWvx4fNsNhVohPdUUWJHh4Wf5zP0k/NeADN5iRWImYuDmZqw9zIynNklrwpPkFLAJi2v6O5rARf/SAK25m8muFGw5BhRwhcCIqvbZVhjHMC3e0dVlp/m1kPqLM/p2JJwxiS3tlw0zNt0ykbC7iV/WjsP12Y9/MmlQLyH0zQAVQ90300cklhWAWZWuZTlAqo4hJ0pD8pVTFhDjOzaJx0fVXpvIon5i4IBuXrBPNcXj2NDow5I/g2vj2+GRwFmEaAdIx8q44epXId2KFIzQjtMTF90W+0KlA8xU6EqKhckArEtksL4Pf/M6bM4rX0mI5upgbvFL+rpJQGhq5hSJnosJDWnhxo/8qKfINig6jyKA47M0NYDDz57/6DETi0jI9JrqxeFXOxJlEJw63Xlkz9P32fKVJAtj6kHeXYgLHoli7o7CziexdLelVmiyHLTx8GKCuGlVKBzqEJA6qES1KfnNf/FpfhPxtcsU3Oebt6P/oGF5ohen9tVPUmiHHlgpbq5LEaPa5kd9qo1BCf18YhkeL74zEmr4Sou9YLm45ZUXAfH8yi7eW2b92r6fc8eQg9lfzndMgiIBL+IGvFW0tKJfI1NC+ZGEBQ4QoJV3clPzqsUPr7qw7dd3Nvij9Z5v/Vd2+v5DD2f3nvXa1huMEULUekskOXZMDNLsTVcQgHO/S59v0Qh/AQoPg7GJaLbLRG+2JfwKAdWeTQx22qIVhWHO020cPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5MxdOGmrjYrfC+UUxrF4QUZ3pLdHdgSKHoXoBAg08GKsN4rBZwmkpYGlCxom?=
 =?us-ascii?Q?hiknfdTykVRjM2vsVoWwKQTdolwZE8FKUwzGZyKIDZo8uG87pbOT3Vr1dsLW?=
 =?us-ascii?Q?2VmzpHmeSke5tXMLN6E+8QO1DeIA8cip4OZSvkJUnqU6fAnwm0YfBP1gadVR?=
 =?us-ascii?Q?dCdSZIoNhjePvy7X+vAlX3LFZxg83K5iz5qHbJpd6773IBFkOxcKQr+7Cx7W?=
 =?us-ascii?Q?OfDntT4WO/RmOpbteiK85FH+O7kaOSHodrVGXs3DWu3Jgy/aVNtIoarvOheF?=
 =?us-ascii?Q?NGQ6HMZl1SjoOEutTKgsN/35knUyL5xQyhASWz/aRhbhJWfrv2Bd1dNdKMxw?=
 =?us-ascii?Q?GxDOTKshfxu8e1GrMqVQEn630EG7gzrf12LVB+eTnGhkjTDOAS0jlcaWJDOP?=
 =?us-ascii?Q?3QtPNKwGAV35QnpEMKXY4+Hv+ZkrrZgfTvSukTMTNubn2ctCwHs6AYqqDOdP?=
 =?us-ascii?Q?aug2tQIm5lVSt4U+FznrmcuoTEPIYpd2dBetNa3A7H3DGuFe+0Sw09Iu6TYN?=
 =?us-ascii?Q?xnLL3XO6jKkWfvzRV8GUqZoc8NIqO4+V0fa/9BeDQc/ObZ8wQlrSqZrZ2eF1?=
 =?us-ascii?Q?9gToAxI9ywYy1H4GslxDkTkNph12QkHoMLeR3Nh9Va0qSkQKsm7r/OGPqWRx?=
 =?us-ascii?Q?yw1q0eNv6ylwx1BTd0X3f8pcCweqAaMkn59kaAnKUdnQCET3xKUZA3cmbu02?=
 =?us-ascii?Q?aTZPrFfxsq/UZ60GjdsE1RRMQAcjw6eZnHtl1HPsFT+zW4QQxTCm4WhD1Y98?=
 =?us-ascii?Q?G2pNPHeFTif9kehzM0pzMJf4t9lJr79nrSnE0PZYlF0R9J+aa+ytoPIetWkZ?=
 =?us-ascii?Q?VBi4vtiMXoMMNpNyAtnHAxhuw8jXyzph3OBL8Nq2S6oGOV03wwSMK4zv1TBG?=
 =?us-ascii?Q?ffC0PMDhvH/F9F8LT6OAwKzmczhxzd7mOpTMXWQil8x6mo4HQ9QOWpIVW3Q+?=
 =?us-ascii?Q?3mjI+xUJhRTRDHeJ5KGNcvmYDXJpavuuGZwB6AWR0RyxcmkTjgRp0eSg1byy?=
 =?us-ascii?Q?LCfwnM5RPz8Gv2cVdb54mo1uEG1c59NW/Cjl71nEzo4j4czaq+SlzvVAWluZ?=
 =?us-ascii?Q?v9mJolKX68rfk35p5eZqV77AEza325sn0L3Sfm8zQp0LAodf8mmMmRf6ErEw?=
 =?us-ascii?Q?deZ98RseEzEeml79cwr8gbR/oHhB1A2tcaIG1dsmGA/nbZw9pUsO+yviPBgo?=
 =?us-ascii?Q?LiGblgvHUiT5BFgjrHlu4O9E/WmXL0sw2QSMV1dkyDDpfmKk0qVhj7GDLd6r?=
 =?us-ascii?Q?pvke80pPvZP3EiL+YUwYAg7aVuC1pxQMXwGPDSQBNV0UnbEInC2ddpTVZMLJ?=
 =?us-ascii?Q?hdHhMgcgcIv+v3Lj2Duxo6J+ufj4y1flcnqEuhAGWKSRw9vAhnMHMfu/GZMr?=
 =?us-ascii?Q?PMHJyp8U5Y615ZBMiacYN3CO1wA+iVuQbCRbT0l5H9tCJuDeEG9XP/+TgNib?=
 =?us-ascii?Q?zkr/4WbzDZW3ujTS99+3QUD7Jy8mKpwW6pIYQlxVt8uhPQKZNrXCroQMiDUH?=
 =?us-ascii?Q?206dkhWVHln7oo6qx/9J8hOdmK3Nxw0gUYcZsJcpK45g37alqpqjAjoL95dj?=
 =?us-ascii?Q?abgpZMNdsW1e67g7/yiAMtnk48AidEwXq3r5SbQU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf384ac0-5196-438a-4ccd-08dc5e5f67c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 21:51:43.5417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ws5NHeN4vts1FJnHXwp2p1oumb4FkGuFPaZYiaP7DdIlp6+j/iufSSJ242Fvvr/S0XsklsZgrPHERucRxAAjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6000
X-OriginatorOrg: intel.com

> > New CPU #defines encode vendor and family as well as model.
> >
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks. You win the medal for the fastest turnaround!

> Possibly consider updating subject line with a hint about what
> "update" refers to, since every commit is an update.  I guess "vfm" is
> some kind of a hint, but I don't know what it means.  I suppose it is
> for "vendor, family, model".

Yes. vfm is indeed vendor-family-model.  Agreed the commit comment
is lacking details without the context of the cover letter and the other
patches in this series.

-Tony

