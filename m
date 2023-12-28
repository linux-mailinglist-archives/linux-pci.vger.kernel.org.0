Return-Path: <linux-pci+bounces-1487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0745D81F5D7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 09:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71179B22579
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC61333E1;
	Thu, 28 Dec 2023 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7Htuhs+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CE522B;
	Thu, 28 Dec 2023 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703751070; x=1735287070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SFTu9SPxG+x1GdnPjQFRub78n7dNcIiwV+8f4iVRXzE=;
  b=O7Htuhs+IV06igawSai5Z76l9kO0rWt9K8tBIc6xdF/BFyAHr2HTlsvP
   P0xmsUSoQtHNZI6CrbXBjQOgxkydTZLsfk02j7iwJCRUnOmUqU3J1J/oV
   Ta9PcbwazpAyU1RasdGoVdRR+d19tRYRblJtFSmFD8PrJGzqGEKT6QpwT
   zVFUqtM/Qu/6LHFRFQhixNj/GucYJKw1m0yRRHWwtbsds/Hu/v6K8b7+H
   8yQozH8+LMvRdcySx4uVZKvKeQNrEsFdt6H3d3v4qpE77trYi7AVSW6RR
   HAMgXebngNHN0ciQjnjSRLOy0vHI6Qe8/vpBQ5pqXz4MwbuO8LZK6tSBS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="399309309"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="399309309"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 00:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="922045840"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="922045840"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 00:11:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 00:11:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 00:11:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 00:11:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/FlbcmMnupDaehy0ZBHXY/9loQ46ZetiNQ57ERKecjtn0VkLYN/QG4WdknQCLPOCsPCB+LefINPeOiG6O9aUv0kXyE58dLitLJ4pa0SeWgsnIJKBOsQdQoT3ZLUFMbeRBVCWyR1It2se4ww42nDGZotEZgu0P8LIo7VaJLeAsDpqE9Xexay7G47CGbWZIHo3OnjeI38CdzjPxeddCPWuxNOaAqFsVH3H+OcNWJHWVL7LjWGter/Qu51426ALOSdkAQO6snwNPxz1KYUFErAGwd7DcJwKVrNuTC4LOboTY4cmWVDGdoCcj9gas1XD/QauOczUTWBNDQA1mMJilrV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9gXDn/XJmuI7ZBtTyxEx34DUUMqHzIb0UM4R/wyruk=;
 b=obScTRf/HjNAoBa4n/CSyojyCaeUAVjAmIWC1Xgk+ENXo969Pt0I9c6vFexms/PgskvLh9TP6eb9IgXoasXDu3wMW2D/BjC3CO6thTOxx9o8dyzEo56NvVmPK2WEbdPIFa7vucSd70qj2dHbK5Rj4qCkopDgKbBeGweom/jlqxK/yOh/yNtTDj5fn8jh8l6S0Q0eqSZboPjlnXOrnaUe18tKrlj1MZZfir2SjujRpRfFk5xTiKd/wBQgb0Vy0yuH7LYy5gsAww9aseRxweIMN6lpXmbEVH8pFALf1KAqQeZPj9RMqyuHkbouIuejjOv+Z3TUKe0pye2E77Vnu17RAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7054.namprd11.prod.outlook.com (2603:10b6:303:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 08:10:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 08:10:58 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v9 1/5] iommu/vt-d: add flush_target_dev member to
 struct intel_iommu and pass device info to all ATS Invalidation functions
Thread-Topic: [RFC PATCH v9 1/5] iommu/vt-d: add flush_target_dev member to
 struct intel_iommu and pass device info to all ATS Invalidation functions
Thread-Index: AQHaOSM8aFc/Sn24n0WhEo68HXH5iLC+VZYA
Date: Thu, 28 Dec 2023 08:10:58 +0000
Message-ID: <BN9PR11MB5276126B3D950AA2F23520898C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-2-haifeng.zhao@linux.intel.com>
In-Reply-To: <20231228001646.587653-2-haifeng.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7054:EE_
x-ms-office365-filtering-correlation-id: e0bb4595-bdb4-41fe-2175-08dc077c8625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0SlGa15TCeM1hzAx3OdyIEYaMUZqbm4CBzcKNFjA74pmicDjqfApL1cBnrYQUKOEmkKYl7Uy9VU1iTr7i96QQYtTwuuLZV6JYkvqhThlk3EW+6MTPL8/oCrEhPFNtLfdb/nF9jVt2Azi/QwvAs9beLYnsODawIt74i0sE++neMXV+jNg7Xa9wKDt3K9wfpcZZYMQJWvYWwpGC16+7jYfhL9qeREHs9V/+r8dRxHVHHZh18z9VkAmumxsH6gZlrT7yNKOzujnjCpgYCtVW15JyXDArolmxyTDPOOjjw3c4Z0FyDywaSyHeig+rxGAfUXJQtUcW/9FhcR0Wk/z8ka3K2AoeuZoqQcLVkIcIcsPHyvpcjHeM41BPm6pD08UK9t1tP1iqX7z0dZHH+Op/9fsvss810BPZIRbG1wP67VR5wX3iHlZMiLsHftOI8yBkMirvp0mOwxOaB9ZK9IKMjhPG3ARmtj3ZnCWpia4pYurazHmzQB6xusA15EylbtzShkbwmLGnbFDaMpWaqzsrUuT9UW1xHsfWSRH4tXzKT9N6Ed7Z022YggxajYgPpECaOIT8lGq1lfBj8WhTNahHEt7cg8AyEF79ZFKO3pM+mT/fG9WeSnjfwOldoWuvr97Xaw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82960400001)(4744005)(2906002)(38100700002)(122000001)(38070700009)(33656002)(86362001)(41300700001)(7696005)(6506007)(55016003)(8676002)(4326008)(8936002)(83380400001)(54906003)(316002)(64756008)(76116006)(66946007)(66446008)(66476007)(66556008)(71200400001)(110136005)(5660300002)(7416002)(26005)(9686003)(478600001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bL1lnl/hQhLY+KnXTOnZYAj/xcxg+99oVH2+GUlEHBS4UswLILC5ordbeRkw?=
 =?us-ascii?Q?v9UkAe7eDJNHwnbe67X7P+F5YYMOKcl7y0fB0qe2Qt9BUyrgpPSuPn5GfObz?=
 =?us-ascii?Q?NnWdHr9wX6X37/9CLXWGJpVwFULvMIfa0KRgOX2Z8OZ4OT0KG979QpdMhDRu?=
 =?us-ascii?Q?3WvYmudImLbffpEsloIqGe5SXfcReDQVq0vVTV/6cMirjEgVTM+6Qcpc6PvT?=
 =?us-ascii?Q?ugnzsHL7K42Qxg95BLDc8EapbWub3V/pJDBoUqHPHlkgxePgfAv6oDkJ3QbV?=
 =?us-ascii?Q?s8zY9yFe+qoNrwmXH2bg67kkL1iqkIOYIgocZE5s4LLx+q4vWGJcodlEQM9q?=
 =?us-ascii?Q?teqzJdVCHUC75f9vQxcL99TUSdsEZV33JQ7mHQQpgBUST/UIK+nT9ylm9wQ+?=
 =?us-ascii?Q?BD7M7XZI45BHXWtxUh2uFpd/qFzrHOiVccblfkGjueBqApFxMdhL7wcmuQdd?=
 =?us-ascii?Q?ISxk0hvF3aftAPMiXi2LOYOnKPD1oiOloUvs3IyfD9XY7sMREwIeNUgYbOvN?=
 =?us-ascii?Q?6naVZpaNDvHfojwswRD8hAJ5RsAcfE7dNg2iPkLw9U5d1uSxeOrKdhosU0UA?=
 =?us-ascii?Q?HNy250mrx7v6NOrJv6QNPbV8c5HKvEUsd9w2CdVwHlfplMqDL8u0gWmOZWIt?=
 =?us-ascii?Q?rWM3UQazj7Je/8VDQ7M62SnVaapku7FjnXWA7vQ79SD4jAJuEGwWxbPoiUFl?=
 =?us-ascii?Q?C9LV5cmELHO+vMDiVA6k/MqmB0fUUI0cli9s/V9O2r9LKW3XklcJ4rYQXHLT?=
 =?us-ascii?Q?qlnlStE5QHZXJ4ndNbQQ2ynwFKkbYa4oTWIqH1w3cmll1wsfKkK3q9ix6I1/?=
 =?us-ascii?Q?dTwZxDfFMHSrPONqOvJ6gRxnfR5zsxsGfjS4lfQBBO+fa0mDH3O+mm6IkiLx?=
 =?us-ascii?Q?gqXSUazu/pQxq6wU3/NsDu/7e5KsDqTs0YCGh2rk60JL/zoQflA2dHH/U+r1?=
 =?us-ascii?Q?wsQUVZZiRR/8rmQqEo1od4G+gszyWFtjeQVFTRCNDkNyI+lmSwwxfJUMNnk1?=
 =?us-ascii?Q?oAb5f3BD1mFuNwv1+ggDMG/C5eq8hteQJQDty9kXB6N8w7umKMTBlocFuksX?=
 =?us-ascii?Q?XreYiLu3+NvADpGeJz3vGBMjqLofXNwaWdp+2c/2t63Unae+EuXLSC28YoPn?=
 =?us-ascii?Q?/r/l0kdOZew6Wr0LSN7mpUpNOUbzUi6n6Et6L3hVHGE8/hIjei6Ft2qrNRzA?=
 =?us-ascii?Q?t1ED8+zOpvF460j9JZgYinQM+e5jMsh+YCn6PJcFcOjoTUWeOB6b1HSUstBe?=
 =?us-ascii?Q?wICvwbtolrA8CKsNmM00JVLcUcjpx3szNRcaRvTUJ20pr0fHFBEv8iz0CDNB?=
 =?us-ascii?Q?z8R/p10TyeTh48uXhnMzoFAmlyGo3YkkYgY3OQrQXwM31bS4H3wNA2x2XcBu?=
 =?us-ascii?Q?xF3JZuVBum8raBS566YHAkLkEzu1EN6Hjhbq8e978LsJ0ELyEVJaV514TAIX?=
 =?us-ascii?Q?RZFJxfYP29zOmh4KWDohmcA4BNMbnNEyar6iOEvldK9bWF4JxHI48LQi58dT?=
 =?us-ascii?Q?Mq2Dqh2yY6DzaILy47Hvdf0JIfggxD9Bmq4guB3DnOvG0H+90cpz395a/WpI?=
 =?us-ascii?Q?nqDKXP3Up6r1kTq6+q3XVkpFunHgE1rhkmlgrzJ2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bb4595-bdb4-41fe-2175-08dc077c8625
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 08:10:58.7268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlvWPkiAHjju/R1koqbJhbs0Cw3l68edONqAcYqJRC4Nn3OplCgeaBO/8MZ8YfJGuVXK+cJRZvjwECZKhAQhKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7054
X-OriginatorOrg: intel.com

> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Sent: Thursday, December 28, 2023 8:17 AM
>
> @@ -181,6 +181,7 @@ static void __flush_svm_range_dev(struct intel_svm
> *svm,
>=20
>  	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages,
> ih);
>  	if (info->ats_enabled) {
> +		info->iommu->flush_target_dev =3D info->dev;
>  		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info-
> >pfsid,
>  					 svm->pasid, sdev->qdep, address,
>  					 order_base_2(pages));

this is wrong both in concept and function.

an iommu instance can be shared by many devices which may all have
ongoing ATS invalidation requests to handle. Using a per-iommu field
to store the flush target is limiting (and there is no lock protection at a=
ll).

if there is a real need of passing dev pointer to qi helpers, just change
the helper to accept an explicit parameter.

