Return-Path: <linux-pci+bounces-1489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A839781F603
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 09:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC421C22809
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1535687;
	Thu, 28 Dec 2023 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afZniHgg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49553B4;
	Thu, 28 Dec 2023 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703752735; x=1735288735;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iQkISEg9+U1CHrzW+S8ZrGs8Cc39CMUBbYEEfetB4Yo=;
  b=afZniHgg8mKrYCZy/qc1Hr6+/LeU+yTPQQcsx0CTpXzIHgLdVnPkxpUK
   f4SZdeOxod1DdLVf1K8ZDuwV8MKb6ts351rrZtjL6SAcfiuMv0UsWVOJ5
   d/21R0gas+/n9YaXuuNcKsUoFNb+swq3QZVvWovgwHFjKSWy2tr8wCiPZ
   k4mSMBysVMDuLitBPX2UT6DIAyPAQEcdmdnBqc87mM3Zlg/dMY/ZjFadL
   QeB7j5+z7rCDPo8SmumXinX7yjEvVAr/Yt2Pdr/wVtiUnJLIHm3+eKZK6
   KjDH67N5s0Amlh/kqdCviQgGTtLUkJJRYsyEiv6SICeUkSmYZirc2hRty
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="386960446"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="386960446"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:38:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1025609681"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="1025609681"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:38:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:38:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:38:53 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:38:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCGgXchMTmQelFjIYvygRMuTL6cb4gL0e/Ub8sgAdWkldBDE0mgRi6hKRSx6fJYM6+myLyOQWpKsTHkm4mIEJQKEDH3uq3r1kUchFPGJFoyIfr6f7eTR/AEqmNbL7GqjmT2/1EIcBezDhT4YGPRz84vfcI1mRzXMKLMlzxYe+R3Nwyg9fRBEFqHRuS72JwKm+SlBFSRvVKRNV/23tcFKC8IG+ghit4e/s00EowqOxcS/5B4zCIqicN1SWb3B0XBy9rzT6rcluWgpB2aNhC98a3jbo8hCSQUbOAWRUri1r/56hlMiVWKBoOJKYmq0fJnhPauMWi/RKeU+XGWUVvxqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1JGaYq46fUQnRJeQeCptye5hNfNS1IvvK6NEzMPc+4=;
 b=EFGIBipTeH+KRAU57B/yZq/kR/qgNfXufbY37P3d+ETlG6CECYMPxcqZvh6fR+dDfmW9Ib7LDrrFHHC7xkzh3G6TaLd3MO4gSA/x9rOxhrFpeY1mrlZovQLDmAj17bbNxwcLu8zcsqBHEUUtYiMqXPsnSlDMgNFh78ynrLgepJ92V1aBkyLsClytHntdF4ef5JM4o6RcoKSvYOPjo6rmnaHizuRaLb0x+1teW87FF84Piil28CPhEgZcYiNMilgKJ0ObXk3ZDD4hQJrL6T6wXa9bN4aShB41CFvT8qECG9sZioRoxubSansey9j6PSpbfZxiTT+Cn3A0oQxXXnI65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 08:38:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 08:38:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v9 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
Thread-Topic: [RFC PATCH v9 5/5] iommu/vt-d: don't loop for timeout ATS
 Invalidation request forever
Thread-Index: AQHaOSNeLqk7OMC1FUmomOwsRPnbNLC+Xgtw
Date: Thu, 28 Dec 2023 08:38:50 +0000
Message-ID: <BN9PR11MB527651C1A108721CFF057BCF8C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-6-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231228001646.587653-6-haifeng.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH0PR11MB5330:EE_
x-ms-office365-filtering-correlation-id: ab7ea261-a750-4b16-44b1-08dc07806ad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fLtGLegqwsc8Hocih0A/RP7way03qs7R/Q3YBoME4QfTsN9Tdf2TGQ7ib1zR8shl5NJa473wU5JiyP4+J1OUgeubC8vnncuYXP6Gbz5OjX5yfH9twcVeRUOoJWq8+a7hue5J+L2ij4gPnTw/L1qzitXCdtT5mPEnfqQas+DvyCAcD5+8FIzcfOs93FMD3VtFnKcqyPtiNrk+HtGKwE6Xw5gZVNZAjlpYWMTBRUO/2SE1lpxZG/ITNflbwEfJe92BFBaLQA28ReEm+jFQp7cYT5MIQrG6nFRDclLAYJI2sucV+cpadxPO5H9/SheQ5i13vCYaj2RGp6T9dNE3rvjsOIZJy5Lsu+MR6y10DTFeI2V0Rwo1JaacGz/ZvPy28Ql3pwbSYwfKqtBeO7SgjyfqrFwpO8srEWO2eX0DU4En/TtSWqguN+sdttzztrW6CmtFA29qG92GR+LWtbrg88XFByPArRaIWHHGNnLIPY9U4hHhyWA3iRcxfMHcRNKyBVQdkjA+7ztWoth3fcCdWLgWr+fdMEd5dvuxc4lHKJ31rXwyxKWzASdFI/jjCPAsKQaXk4mjIMAG5e2EqKZoxQ+MGkFcXkn4rkcpetBJEPjItpQ7MAUck22G3t4Q9UMzGB3l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(86362001)(478600001)(7696005)(9686003)(2906002)(6506007)(71200400001)(26005)(66446008)(64756008)(66476007)(110136005)(66946007)(76116006)(8676002)(8936002)(52536014)(54906003)(316002)(4326008)(5660300002)(7416002)(66556008)(122000001)(41300700001)(82960400001)(38100700002)(83380400001)(33656002)(55016003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xmhiLA2RCY7gdLiy6StThtfCIFjHL+S41MH7xJoUP7eyy9icDuOtxTrpfefH?=
 =?us-ascii?Q?mSa8mQt/DzbbEsXK6oD8AevDIoEmN6r5i4S80L+zWlRwhqiJU+trkOopn3af?=
 =?us-ascii?Q?j1uuiFrlWiMquXYJeIGvU7qV7DdRichUGB/gSRPl9Nxu6TqVEESrnEiCA+U9?=
 =?us-ascii?Q?NKQdpuFpQvEqxQZRmaklTz9aTHijFXZS26PA8LKl7hH/KAm5Y2AwGaD84h3s?=
 =?us-ascii?Q?aR00VZ6ycCphgQyzXPumQ9LR5G+L660bJkk7emhpU7I/D1lRhlyt3/c+vfMp?=
 =?us-ascii?Q?6xqV1VpjoehpA1LN+pL3Wpdx3ypiFlVnAZfbaF1JL2DORhU0+wFxYPdz5pJI?=
 =?us-ascii?Q?CgG1Tz1yElR6xv+o9TeyPL2d0v1rPFhJjRDnuCFmO3sJj4PUxJpLS5cN4N1R?=
 =?us-ascii?Q?WXxiMLumKbUxkcwA4hQdEOPV7BNIhD8wtBjQQnJn8tUwSUt4LCPb6tKz/xiD?=
 =?us-ascii?Q?+TcY5Bho1bO6CUzv0qzF9w6gAGQtC12ONG+292Ta5TfLWHGEKFNYHdzDULlA?=
 =?us-ascii?Q?ht9stCwHYPnyCHFxuCW449jLF1qBNFitfiWWB60qoVjpQHE9jKR2LW8v+27T?=
 =?us-ascii?Q?Z6c0Zi2dZDDPv3SAvm9zzKD/eCU/SCa9+qxBT0T3y/in00XzTxOVRhTjwFLc?=
 =?us-ascii?Q?1MfRgEXIMfW8MgBj+k609XuAiJSH4OS3vMfghKFg0CYeh8DLUIL4lYHy2Seu?=
 =?us-ascii?Q?rIQr/5k/CEWNGvcgn77BgDc2uSq54Tl+MMCu3Ta1HaQF447hyGJi0uEjJqi+?=
 =?us-ascii?Q?74hlqpJvvCEt3kg0CwqCGnfX50Gha6xv27of/z28tWm9c/4xr0mxTRSUzbHq?=
 =?us-ascii?Q?hKdwyEu+AxTTbLF/xpe5rJGRg8VaieYhPnOzcsaSTODHzc8UJCjU0K6dri2p?=
 =?us-ascii?Q?H2LSbY3TlFL3oxhhZMLXczpssZoB43oNQWDkmnVuy92SIZJk37d11V4LEuZZ?=
 =?us-ascii?Q?NknKUYQBKwfsFqzz6KSpk7vEgNgM/adyXwmtFhxA6DbwTrVmigkB1933qXRz?=
 =?us-ascii?Q?XiDD6UB1KoVKZ7Sx6z8Ig07n3Dbs0PGuz+n8SFIA47vUSvCM3YJFeeHdG4IV?=
 =?us-ascii?Q?tw1GwXqgXAHzZTUTNuKFhIcic4xX3nR9AyvfNlQrSaB9N61FyEMeZxd+zvbo?=
 =?us-ascii?Q?iAGYAIa8tOCCndwtBiLS39lDphivhkW6GkG0KidIzKm5HbYjtMe8xA8l4jnF?=
 =?us-ascii?Q?4GIj3VVCK0ehAjxaiQRTmzXjoalof8YFnfj2+aRmltCCRYy/gtCixHlAHOf6?=
 =?us-ascii?Q?QRhd+IsiNHKXeu/ki6gbrSNH/yp7XrbzrjI2vIPRU2QipIqZ9Mtn5uRH9lBU?=
 =?us-ascii?Q?xBQ5hmOr/lOEjOAfr6/GqExzkTOmJ+vh4daPmZGIp9NAEBuxGhYQFpVNh2Wm?=
 =?us-ascii?Q?B13kR5ptM3jGeIgYUEnKel+gbazt8YWu8wmC2S1wZBu3iVbYxK5EnRg5FiN6?=
 =?us-ascii?Q?/ZGwH6Shl06r3T3VNvZRs4uNIl6DGiv/am09lOUSEurSCn5FJgphnc45RU+6?=
 =?us-ascii?Q?NazNqs35r//dex3DAQWcoNCioTQe508s+bAL6IThkBbv90vUThvbHoUWHtgD?=
 =?us-ascii?Q?yyVtwVs70I5aP1f+9mD2MoZAqwy49R8mrePN7uV9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7ea261-a750-4b16-44b1-08dc07806ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 08:38:50.8939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uE0APQzuBo0btI50QBu8Pw0EXyC4BAwJGKOvonjQVpzluQKtmqbSsT/pHVsV08jeotOpUUV8FS3L7BbwcHr9bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5330
X-OriginatorOrg: intel.com

> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Sent: Thursday, December 28, 2023 8:17 AM
>=20
> When the ATS Invalidation request timeout happens, the qi_submit_sync()
> will restart and loop for the invalidation request forever till it is
> done, it will block another Invalidation thread such as the fq_timer
> to issue invalidation request, cause the system lockup as following
>=20
> [exception RIP: native_queued_spin_lock_slowpath+92]
>=20
> RIP: ffffffffa9d1025c RSP: ffffb202f268cdc8 RFLAGS: 00000002
>=20
> RAX: 0000000000000101 RBX: ffffffffab36c2a0 RCX: 0000000000000000
>=20
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffab36c2a0
>=20
> RBP: ffffffffab36c2a0 R8: 0000000000000001 R9: 0000000000000000
>=20
> R10: 0000000000000010 R11: 0000000000000018 R12: 0000000000000000
>=20
> R13: 0000000000000004 R14: ffff9e10d71b1c88 R15: ffff9e10d71b1980
>=20
> ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
>=20
> #12 [ffffb202f268cdc8] native_queued_spin_lock_slowpath at
> ffffffffa9d1025c
>=20
> #13 [ffffb202f268cdc8] do_raw_spin_lock at ffffffffa9d121f1
>=20
> #14 [ffffb202f268cdd8] _raw_spin_lock_irqsave at ffffffffaa51795b
>=20
> #15 [ffffb202f268cdf8] iommu_flush_dev_iotlb at ffffffffaa20df48
>=20
> #16 [ffffb202f268ce28] iommu_flush_iova at ffffffffaa20e182
>=20
> #17 [ffffb202f268ce60] iova_domain_flush at ffffffffaa220e27
>=20
> #18 [ffffb202f268ce70] fq_flush_timeout at ffffffffaa221c9d
>=20
> #19 [ffffb202f268cea8] call_timer_fn at ffffffffa9d46661
>=20
> #20 [ffffb202f268cf08] run_timer_softirq at ffffffffa9d47933
>=20
> #21 [ffffb202f268cf98] __softirqentry_text_start at ffffffffaa8000e0
>=20
> #22 [ffffb202f268cff0] asm_call_sysvec_on_stack at ffffffffaa60114f
> --- ---
> (the left part of exception see the hotplug case of ATS capable device)
>=20
> If one endpoint device just no response to the ATS Invalidation request,
> but is not gone, it will bring down the whole system, to avoid such
> case, don't try the timeout ATS Invalidation request forever.
>=20
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 76903a8bf963..206ab0b7294f 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1457,7 +1457,7 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  	reclaim_free_desc(qi);
>  	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>=20
> -	if (rc =3D=3D -EAGAIN)
> +	if (rc =3D=3D -EAGAIN && type !=3DQI_DIOTLB_TYPE && type !=3D
> QI_DEIOTLB_TYPE)
>  		goto restart;
>=20

this change is moot.=20

-EAGAIN is set only when hardware detects a ATS invalidation completion
timeout in qi_check_fault(). so above just essentially kills the restart lo=
gic.

I'd wait for the maintainer of this driver to comment. this part doesn't
look good but there might be some history reason so carefulness must
be paid.

