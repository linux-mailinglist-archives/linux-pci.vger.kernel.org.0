Return-Path: <linux-pci+bounces-2701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE78400E2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1C91F23DD9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16B54BFC;
	Mon, 29 Jan 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+P8QcAk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649A54BF4;
	Mon, 29 Jan 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519203; cv=fail; b=JLvaGVm9rmTnk0a7BQfcUzxfJy0kfox9sx/2eLyOZpCyeUEVSqhKT6xrCeEht+8olgfDNWGC+e08VC0m/LHXljvXBVPAGivwHci7Y0FBpRpcp3irPgHpRU1ya/PQHniFAy71Gff5kaXgUOkP7v8uHPb/0KvZLqXJa4bkfQglaJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519203; c=relaxed/simple;
	bh=bThyOuEiIoKkWDWNpxXbcDDeIFQMu5RwUtk5T7K/BG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/OOtRqB6RGBlZotnb9NpNdxb/LtlMAfFHjPXfb5JV+Ebz+d52fQQJdrTV8qtDdiwX8TbdKOa5M0rMw0gBNaIpvN6TChOTAq9rm0epJC++6zLqhYkeRPTqH7qS7BSs/XmuvXKEIvZYt/SrvTNs27rDtFFZVmy+8YSVxIJDLezZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+P8QcAk; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706519202; x=1738055202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bThyOuEiIoKkWDWNpxXbcDDeIFQMu5RwUtk5T7K/BG4=;
  b=J+P8QcAkjx98A+clWYRwHMiCO9roV/VDlrid48KsdBonjFt1Vl0/sDXW
   odf43chzpgk5FD5Ro8BOJi8kcet/SLmCzifGIr6wGNjczkvWf6/b2uB+T
   B3pvun2ocjWM2fJCtzGtANnF610r8mS5yltXuxKnuRWZZril0S4l8GEFw
   CStlB+BiV3BThZof2aCvflrBYWwIucOcJdX7eskN6ha2Wi/pkexcdCz4F
   WBey5RmLV2WtZrd2iaJBDa43+88pkZB4uIDYcrAuAWhrKnGI9B8vc0u9v
   cBjJu2yqZt/+DOpUoWpAYXbm3irdK0908KmDTfRlT28eUVCNsC6y7CXrM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="434060348"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="434060348"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 01:06:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="36069096"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 01:06:40 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 01:06:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 01:06:39 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 01:06:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNSQ1eGYff0f5yCEyZKlCX5IXXpDTZdhCC090nE/5o+/2JKUPDVf2DLuozK8mD9sJVYzELfJIqJmbmeY+Ekd8ror/en3Rp8WTbaO1/bXHKp8WOWCQ1y0WsSH9S23qa4YKkZW+9oijCW6+RES30iaK0+mHj62Q5Iag36K1Z2urYMQRgoC0t0XfthgSatWMQSof1ryBVlJnNIrasguIHA8T/apTRIZERUPgyRG96Rrj/15sIFX4Rrb8pqCa1PpezCFEaj6VL+vjUliiJbbDvL4tgxVGQ0XnY7NHmC4jEPGBT2c2XhukYw4gIcjt2Y7GQFSIjRECvam5WRKitHQvd25CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8Zt51+egWkf9fktvznqcV2nBVElox3ThWXc/s6pr6c=;
 b=XQS2rxhytOtiR6uCFu7tmIF8ZjFUpeoHYIVgx+3z9U7PKH2/R71+GfsNiEF10ZxrRlRAXSwTCXJwNbw4CmocrdUHFF2D55f3IMt1ovEn5jUNBflCciA5IISKVf9SvOe4ck6YiuoUAisMMprG1iTZdE440QtIcszs5QU/dTSfyexIfyHqonlaK+A3mWJQna/b+fMK9CihzkYMnocydfC2R2BcgAu2DgWxblCaqtW1sRva0CvDa2NNU5fVn3OgPrXN9zs90DwOi9Gp3RoEL2iJD4tUY6T01HQSE4QgXgKfvw4H080RYRti1Kr4Hv9s1CEoJ7+aqegRzM0l5gKXcJnqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 09:06:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:06:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Thread-Topic: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
Thread-Index: AQHaUmY538BcsBx6UEOae7WqjB1D5LDweayA
Date: Mon, 29 Jan 2024 09:06:36 +0000
Message-ID: <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
In-Reply-To: <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7596:EE_
x-ms-office365-filtering-correlation-id: 4188209c-dc2a-4515-3bc7-08dc20a998c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrhPFZcmfo7OUIpcrohJeBjB/iw8DRiROiUPx+2TuB9BqcfdW+f+U8itHIrcneIOOAVfdtWzzfS/1q2UyBYNGG5SG8MdHAvxhGro1++ex9pnjHa4kyfmDdPbHSIAq9yf+sBEBM/f+WD8dabtH6k5RNEv34DNhkjCi1sKs/qXZkA1D3l/LUwEEq12MvOiAZ82zvh3CG70z9LuWPP55AVshaSeBOeO5iP6Kzv2YsYI3jJ4KwpE/n2sH6Gw+2Oh+BdV15hF0ZWSXIwkDTryPgnizv+ELIP1zVTIdpV13O2GtbrzNISczpjjfjtcO63sgU+RPXFTRJpw7V2FCTIKgT6RNmoElZ3L+6nDbYw01pJhXhZ9DysJEh45Lm/w0I4CKV3/Y020KT0oCEHI6PeoEUEvqDPCLvHlrEIbq2cM7ilv4h+gINYKspR0Qr2hLcUf6oslxC31YhqA92VBnE65n6xb9QNE6Sq498HIDbWVgaMrdOXBC1d4zPCt5vrL+jGvImaTwEgClLH041B97fS+DGGKH8mA+Zrn3M8PDqvqUbacEEDv3o/P4PsM53Fgi+7gkXMKAwt9GueudsP8v/Ur3dI5eOn4VeYqS4nctriHyfCW81k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(86362001)(110136005)(66556008)(66476007)(66946007)(122000001)(82960400001)(66446008)(76116006)(316002)(54906003)(64756008)(478600001)(38100700002)(55016003)(6506007)(7696005)(8936002)(8676002)(4326008)(71200400001)(52536014)(5660300002)(83380400001)(9686003)(26005)(38070700009)(33656002)(2906002)(7416002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z7iO5wV2mvPbHunK7XcaOMscQ/5q0cC0kqGB6G3Bay3/ybArxJKRMw+hDyRe?=
 =?us-ascii?Q?ayRyRZPBch7rAeMLeD0KdZHZXFvAGrBHSI7ecyexNpxlfOJtmfJMVL94SO9O?=
 =?us-ascii?Q?lwLcXhlcY/rr6ALNfBUtGdCXmpGv34/QCQUCRD63mZJpsPeW7RaRbEA+HmUA?=
 =?us-ascii?Q?S3DurgcVtvn7ZZdTqnGBJ3AxA5m62QqrOrvafT0n3xs2xOx4A8NsxowBcKfB?=
 =?us-ascii?Q?cXzNlK0licPLvvwsTUr4a+dLuAAAgEMymp367Vt21JwtboVOaoP80w8cdB5R?=
 =?us-ascii?Q?5aTut/0SvqnRGtpDPtM2MnZVYx5d3Ul0wFPj2ZYFuZFn/L3Ohg6rnfcHKcqq?=
 =?us-ascii?Q?GV+h8SD57M7weG0utWmh+39pCehqTt/1jqMtRPxkGRwD+HVlc3jfDkp9rSHE?=
 =?us-ascii?Q?c9E/sGmh3JVmtMzmPaUZNBJJIONOLLKkyPtIhM4whesgVsKeWBxPXSniezjx?=
 =?us-ascii?Q?mAJwlIpfoe2L5GuEPp0xQMBBiVOyk04DNEp1F37dvlK+xhLI7MFS5wYbi/0F?=
 =?us-ascii?Q?09gQ2keUw9kh5J/OwPPmRrd6CB6v6kT0lFYsRRlR/ZJoZIUCupoPxz4SqE1J?=
 =?us-ascii?Q?xOpHQC0OZKBMJCaQRmbJJ6VtC3jsY+xOih1Spfv5JRhJTzZFTwUGNslry4GJ?=
 =?us-ascii?Q?Qt8NzdSDi8KcEaPr2k0AzO5VhHWf9lsbFY2YhKMGhVJqH9qQTg26aEhimBUl?=
 =?us-ascii?Q?LAXgXMJr6BmRvv/OBTbECqJAr+kN6tRHPyQDDTjnI+9BIbFkfNbQX7ut/HBb?=
 =?us-ascii?Q?naFXIJUFq7/rDumWU9X4zuqOKmRAkRQX5jvdq7mZElfPF7XHEeONBHPwvOC6?=
 =?us-ascii?Q?rf70tu5rpeEqG13yrjoHQmYi87lHD3+ItEFPtWhKGMxyOnSkN6mFHhdciygu?=
 =?us-ascii?Q?9P5eNRwkkhtfWCnKNkGUy5qJW48bp/IfmCl3bq5almckMlFJ+o/ArfgaEAgK?=
 =?us-ascii?Q?f+Iizli+qV+o5SZucpEBk0eXD5KEbWNlLd2fURraRgGcli7I4aOyJlqT6peN?=
 =?us-ascii?Q?Gedp8qg1QAWW2wEf3OwznY7zlD2uGq+xhK9ayT0IYy2CsspRA1ODU51rTXYY?=
 =?us-ascii?Q?Vo9vEp4ZG16zwFQ6tAQcxeYvjCgVgZEuazJw52qjqyQFTvQVZ6jddzXIvMUy?=
 =?us-ascii?Q?JFDjU+cGZUeuC4nY5PTSV5WBB/pVAYCxQe/DaTPdv+KZU5Tcp/chJqqUOJv/?=
 =?us-ascii?Q?haTakaFVD2huv4alwauJrhE/jDlrfKXCMANtP+XuIEK7hGcfFXGomgqLRXD2?=
 =?us-ascii?Q?14QpycWS+iyGjNcv/3rOwML4MZfqy4a2jQJLBM6wM+jIpLM0QBsDg1Z9mDqt?=
 =?us-ascii?Q?l0B3s/04y52YQz4DMcR2RC+ZIV5Znoboo75CuQWVfu0w9UrCCswtxSet9FO6?=
 =?us-ascii?Q?QcCUx7e/PcwmWZPA4V92wwac06m2uCVU6SVzuA2xlDSLwUvObtpwxRqduxQz?=
 =?us-ascii?Q?GOFIhbufJ9mHusDNqIAagX4Lt6CwygPJFq5/WQgTRO3TLBG6IdMJ8/+97+vk?=
 =?us-ascii?Q?7tcrvoRm6bFCP+Cf6lhuphDq7HkXnpxZ48OecVmZ1BH2tGtfgYQKUPNpn32s?=
 =?us-ascii?Q?swWmV44fuoZPVYraEdXc+E6Ad9Picd3akkmRaIDD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4188209c-dc2a-4515-3bc7-08dc20a998c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 09:06:36.4350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qn705kve2I0PM57S/rUNC+ikfdmeH3DDRLthOlv7uxTY3FEmr0pM0NuwSdAhJtB/O+NYtvbZAOjsBDj6Ukkmrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
X-OriginatorOrg: intel.com

> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Sent: Monday, January 29, 2024 11:49 AM
>=20
> Because surprise removal could happen anytime, e.g. user could request sa=
fe
> removal to EP(endpoint device) via sysfs and brings its link down to do
> surprise removal cocurrently. such aggressive cases would cause ATS
> invalidation request issued to non-existence target device, then deadly
> loop to retry that request after ITE fault triggered in interrupt context=
.
> this patch aims to optimize the ITE handling by checking the target devic=
e
> presence state to avoid retrying the timeout request blindly, thus avoid
> hard lockup or system hang.
>=20
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 814134e9aa5a..2e214b43725c 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu
> *iommu, int index, int wait_index,
>  {
>  	u32 fault;
>  	int head, tail;
> +	u64 iqe_err, ite_sid;
>  	struct q_inval *qi =3D iommu->qi;
>  	int shift =3D qi_shift(iommu);
>=20
> @@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu
> *iommu, int index, int wait_index,
>  		tail =3D readl(iommu->reg + DMAR_IQT_REG);
>  		tail =3D ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>=20
> +		/*
> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
> +		 */
> +		iqe_err =3D dmar_readq(iommu->reg + DMAR_IQER_REG);
> +		ite_sid =3D DMAR_IQER_REG_ITESID(iqe_err);
> +
>  		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>  		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>=20
> @@ -1325,6 +1333,16 @@ static int qi_check_fault(struct intel_iommu
> *iommu, int index, int wait_index,
>  			head =3D (head - 2 + QI_LENGTH) % QI_LENGTH;
>  		} while (head !=3D tail);
>=20
> +		/*
> +		 * If got ITE, we need to check if the sid of ITE is the same as
> +		 * current ATS invalidation target device, if yes, don't try this
> +		 * request anymore if the target device isn't present.
> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
> +		 */
> +		if (pdev && ite_sid && !pci_device_is_present(pdev) &&
> +			ite_sid =3D=3D pci_dev_id(pci_physfn(pdev)))
> +			return -ETIMEDOUT;
> +

since the hardware already reports source id leading to timeout, can't we
just find the pci_dev according to reported ite_sid? this is a slow path (e=
ither
due to device in bad state or removed) hence it's not necessary to add more
intelligence to pass the pci_dev in, leading to only a partial fix can be b=
ackported.

It's also more future-proof, say if one day the driver allows batching inva=
lidation
requests for multiple devices then no need to pass in a list of devices.

Then it's easier to backport a full fix.

