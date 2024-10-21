Return-Path: <linux-pci+bounces-14935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC1D9A6029
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 11:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73EC4B29218
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551991E1027;
	Mon, 21 Oct 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4UTpQpL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5F192D69;
	Mon, 21 Oct 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503235; cv=fail; b=YOX7Ukok7MvUurl9g66QcumfRKiXs8cOjL07tif4lFpLp/sxOlNVrvXvSK15Q92+M3Prr73qg20g/UR9jpK5khx65CfXVmkzZYdVYi2k635TtjRePv1W5Cu41tKrnzRj29TDMc7z1kvEr+RG5kB4KQT3XEVnxViph4fNRH4WJas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503235; c=relaxed/simple;
	bh=yLB9juMIDkS2/Nx/eRDH37aubmoutkNbosQCRrTQz80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WPhrfKUqoFhk6BX3hkT9TA1m1TPLiMT7I1cY3UlKniO4DvEewQiKqQe2JBerXMzCksksPNKUO7gJNMXqIblYOpCA7XujD12+zFTbHxML1DwerAx1yvustsxzFnj/nHu9q9kqZit39u9IikRVBsJa63HNQWHg1WkYjm8gvVc9zBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4UTpQpL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729503233; x=1761039233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yLB9juMIDkS2/Nx/eRDH37aubmoutkNbosQCRrTQz80=;
  b=i4UTpQpLAN8sqKu5RLt6rujezFA5yu43wkIrHM6tfvzzroyCj3gRs3xy
   XQ5m4H0FhFvlIZcfiVYj4lq5OS8GuCEh1PPKB3uoOBL/q7nTWz5iGkHfG
   MO+X/1zqrcjEfaTdzidCb3TjZnVkO8xMhK/9ajvkbPcJQxasYBWDWCOuS
   6nhUguD7Qi7GiJIWOF//JtpPZFcXdA/y84Q0+Tr/26U8vO2EXLKX/L9gz
   SPRwLWvxruVI3kPFwmF7F2YEnuhSxz4o/XKecvgN9JmELSs0E8VipN352
   qpAGqlyiSX0TYr0YlPgenqZq06oC/MphVD2LsiAHqNcenCrZ6oik6Ikr1
   w==;
X-CSE-ConnectionGUID: uzhzkkePQr2rS8MkmPDG+A==
X-CSE-MsgGUID: pcmK5aSoSFmfB5FJWSiQaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="54387141"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="54387141"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:33:52 -0700
X-CSE-ConnectionGUID: fQdz/VOJTBSI6JRxAqRi6g==
X-CSE-MsgGUID: 0eLrPtIjS7yqtEbOYB2mqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="83464472"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 02:33:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 02:33:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 02:33:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 02:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeREktQ0Y1z+L9OYS8DVWD9UnMRlSirnJ26C0a0gWvHFEmYsQaBH0Gjfq8QWFUaxGedybpxxHoZqNxtUbrZNNkYIZJ/UGGtPT0HT8/CdS07GlPpkxL7DIEco4yluhYiB43Qt8T2eEg9ffnMb/S+M3t3dHytUVKGFeF2xeIzlWr/6U2yfo6Ebm9fozuAqG3Qqmk3JKpGCqaaNJxuUjxpTENFnqDr+hwJPdXGqqjuFviKmLd1cYZz6FCOYHQEd1b+oe/p0+gLbh/ebF1YoJDKnQLvGgjAgUzuuASXYJBAJmUfMrP9oU0i4N3YjiGoQR0dTcHN+ubhHxFNGMwXzBHBk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEjPvk2kCstrzLcHRQtXCxUYpj2sPyUDoKLPuL1sncI=;
 b=RTzpI62XBgwnCq8SFRZ0cuLY2ACB7lCNmMFhuSudzuhZnAK+ZH8khR0DfE+b/xuQHmCDFaCMUmOHtmX4jWWewfEvQMj7DOhVKnPG5iZq8rKrAuSk9JvShLdbnp5BmSYQzHmnx1vTgbUHNYt3Bat7dLrkUTajp8/kOXvoZui/GX+M5nzHfDd8TlG51C+btRGBF57Tme/2rtqJI0cak39jhsruvS1jWf0sQv0vHVeBeAy4mthzs4RGDQQ1FwHP8hfVfFJ/+1QvB1ZmWMw4AXP74myih5POKtiPjJhfFAx96mSTeipRRwqT0hJGOO2dKTldDnlkP9O0bOEEb3Ai/3IEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 09:33:24 +0000
Received: from DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::c24a:5ab8:133d:cb04]) by DM6PR11MB4610.namprd11.prod.outlook.com
 ([fe80::c24a:5ab8:133d:cb04%2]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 09:33:23 +0000
From: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next 1/2] PCI: Add PCI_VDEVICE_SUB helper macro
Thread-Topic: [PATCH iwl-next 1/2] PCI: Add PCI_VDEVICE_SUB helper macro
Thread-Index: AQHbIJbjj9tJcudR6ECM4cqRzFvsAbKK/qQAgAX31YA=
Date: Mon, 21 Oct 2024 09:33:23 +0000
Message-ID: <DM6PR11MB461085854DE76B33E967BB08F3432@DM6PR11MB4610.namprd11.prod.outlook.com>
References: <20241017131647.4255-1-piotr.kwapulinski@intel.com>
 <20241017142152.GA685610@bhelgaas>
In-Reply-To: <20241017142152.GA685610@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4610:EE_|PH0PR11MB7421:EE_
x-ms-office365-filtering-correlation-id: f31234a2-0212-4305-5def-08dcf1b3685b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NxU4yeXsy03pr3BTxV+8RSTyzItHycs91hhN+dPZqZHWTw1qcWfE1t84UqmB?=
 =?us-ascii?Q?qZ1lTkD7PnRciaEk5Jp8hsm+fiBnh6aYFUHx/YNR3iPnfC2wPECldE0TeO/Z?=
 =?us-ascii?Q?BF1pMZP6aCEywC3dtFsBM5cAHxApKnYX7szQIcGXeFMKgceaederEkoweih9?=
 =?us-ascii?Q?9EMdmPbaZc0/DykSXr4/ZtKoRx8e1X6O5VR7Q4iyQ4SgRD0XiWT6hOw+Z1+J?=
 =?us-ascii?Q?+YmfjuHil7RvuluGbUg94/+8YATIRmLGYM84JQtKdRZFNT4hLEuvXRbCsZtA?=
 =?us-ascii?Q?07HTJcA3J80NKf1xDCCtWK8++q6KkgN4OxcKmimjLr3ytgLiRliAGihCE/5w?=
 =?us-ascii?Q?zQ1GVgKza58iNHUmtWXZheVUPTU/iImN8rtfV5quUCU6lpnXMHfRztkNfzXO?=
 =?us-ascii?Q?WVXqPeJ/B7MR7Owirz2/5xY0vAsHEpxvRuS89GJc6MLX4cKV8jtzOuyhywqw?=
 =?us-ascii?Q?Lb9cEewUZVi+5BpugZBVZrhPqFnGj22VhkajXp3jAcp2f1CC9Wu4Dt4fui7y?=
 =?us-ascii?Q?t7mVWn8e5fIQP65e/7mgS4n6umrpFqrKQ9F9wJaRwc7/kuDyIukz/wmhMYLO?=
 =?us-ascii?Q?Hj3cgZcG/koaAnNBD6qRPsrqdgV/2vAu6EXohVzmJJC3KqRqH2JrVtuk+9mm?=
 =?us-ascii?Q?P+eOuKolb/RRI1A0NG/auvNen3avriwPzsAjEVz/GpDCqpPlT3s7Y4beKX+C?=
 =?us-ascii?Q?J+kh6Lgeg1dq+YCClb4HLUaS9yUm9kR/0UA0SAkQQzLnRHepsFHii5fZ5bwX?=
 =?us-ascii?Q?I6kVF+ku5o/OL6mfzffPS+yrBe+pGDVRt12KtuqJbUpHZsJJt2H8yxgHQGPw?=
 =?us-ascii?Q?MWSiMLwyiGYhAi4VPyLcthwobm0dfzh3P1Coa1X3uvvbK1b9wi5gLw57pnyp?=
 =?us-ascii?Q?sAm2cAOOpDc1A74D9k7aNatwtlyiMdjdwNdoZ0VFKdAMvan/jVfEtyfXIn/P?=
 =?us-ascii?Q?AOETZSxfVvPxufgIdZKCBvoCQXqqnN4pUbaa9E5MS5xi++nBpwBvnM1v39rq?=
 =?us-ascii?Q?a/g/5nqIEwqUl7D9OlE46SLvdSb2yaijsFOJBfdJwdOb3CT+KWL/+x5++NlG?=
 =?us-ascii?Q?4tUOxkC932q8fdaSll+IR2pRzTOe5NJrRSmh/wO+ncamcWZJZQdO7xknYSF2?=
 =?us-ascii?Q?MwtHuy2/CUESNMeu4vKt56iYzACe4NN1nVshL/JiEE9NdWCrTwBXcWn3kaub?=
 =?us-ascii?Q?dOCL4M12fszD8rlKwAdgMlIKDLiAQREfuu5Rxt9uonAhydtesx4zTqVZjDkK?=
 =?us-ascii?Q?pUqTveredjg9DyVDfQQ8XwL9/byWyWj6P8k3pgdznpAy4KHXMCdbSPkEiqFh?=
 =?us-ascii?Q?CE4+OQ4WwTEiRf3vtRrZ4DGZ/6MbPopqoTgARYIoZTvB8jiRSrfJR3Xk4xSU?=
 =?us-ascii?Q?PaDKZoM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4610.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T1aVRUW5dXInUaB+o9YMXiOSj7sIjBFf7XqLuZG7TXK7CKFVPTxzT4gmx7G2?=
 =?us-ascii?Q?x2ocL2Qc+5aWH+XSu+u7pUyuBMPJwXTOdzKDDt206Rdfxkj37CW3DeoqieJO?=
 =?us-ascii?Q?epacFuAQQGCXuJzX8Nk/Xv9USGb1fSXBCdt0QOthNXmmD90LwNf3ktkPfnUV?=
 =?us-ascii?Q?cMBkt8LC8q23SpdVXrzKnP+L3c1WvElht/3fvvfAUoh3FJ58m0T2HPpHB472?=
 =?us-ascii?Q?qQeavbT/ac/TekqByiYTVYez38uRGN4eocljr5XXkt2A7eacvpWAoUGHauK7?=
 =?us-ascii?Q?6ktGySDWjaSUYQk2qSm1iSzln16wUET7FAUZqZKoIzP1+fJhlv3rStQjGvzs?=
 =?us-ascii?Q?20TbnpzdPW3QBzSxIbzla8PXfxR0WWILQmKaDZUsV6uYB4ZSIro9kuahXTkN?=
 =?us-ascii?Q?M2s+WHuLxstCYdYpiNRcN6gh3T1e8+rU8oDpHQUsLSDEYPtreap025RPehFO?=
 =?us-ascii?Q?mjOTObbrx4MsJ+U/37fAcGsN6aEMuRvGHteJHvz+lbkX7YCvRSyg1LJco5ox?=
 =?us-ascii?Q?Z5idBs3OF3M5VA7mXfhI0zLLCpNoHOfpoVFxxiCX51a4YtJm/urn700MZITL?=
 =?us-ascii?Q?8N0YTKBkbQ+hyFZGchpTqGV/F7V0Se2rvDnumew/5nDEp4a5hYffVlvF7bNU?=
 =?us-ascii?Q?UkKhzsJl//NtqFhNoh6SHJSBIf1beEIZEI3Mk6XU9Fy53zIIFyopGUbb5FBb?=
 =?us-ascii?Q?IPIIH27arzVN0kmgRI6LQzLOwZ4zKMQl5vUT4PEDhSvc9KUsVHcJaE9MjgrQ?=
 =?us-ascii?Q?WVxefHW2z0g5Yr9NuKtZjI9E+WD3UiF5ulDD6IFyJepRDptTfhoA1cKI1haj?=
 =?us-ascii?Q?1AshTC76OeIkipWvt8dNJ6rX9yyK/pQSaC7Vb0qIU7m7ByiM/Zzi/m9y9Qov?=
 =?us-ascii?Q?dqx+1h/rvNP8fjPH4L3p2F4BrF+tgaG8AJenGK5Od6EsuNmtjkkr/+fDG4KT?=
 =?us-ascii?Q?AV99Iv8cZIRIKHTZheTR244rj4RI4o/g3EjYF8pECQn7LC/xZlL3xI8Ybofu?=
 =?us-ascii?Q?qx1HtHKQz1wTK57a/Q5J8cjPveud82KsdjLBo7z5cnyWRTQrhZ1OK4f9sWvc?=
 =?us-ascii?Q?UHlxDqbLMu9kBSueNPidPqfErFaohXt0isWsM6b2YoIrwJCmQ5rw4T5r9UgI?=
 =?us-ascii?Q?FGHWxc+gNXPkztroUgvSsjFhNKXpYzBt22ET7m63LNeGrHUCCY+Pdj5egRx9?=
 =?us-ascii?Q?08Kuseipiv+lFxOkKak5oJzbpQPI2aqwEgj3xcLC10vLKdetYIlQ6NYejt8F?=
 =?us-ascii?Q?KTZA2mH+Ck0Z/mwuYlIqkYN/hDu7tX0uZLZO/VqdMJsN/1oZhfvc/8hyJxpd?=
 =?us-ascii?Q?24FwV83Uk7gcU4rotzqVDld8UBabpcLAeAgcDladK8IWL9y+4DVQSyfp3Aym?=
 =?us-ascii?Q?ShQaiizgUG1/n6N3irCqx5uLDqMUWsTwLbRvjJwIeS2OLuCaC6xSRawk10JV?=
 =?us-ascii?Q?uIlyCWuM0AMh27F3+VwoNjy/q0WDFSB5R2SKMdk65YVQQcyny7wOP8nbtygr?=
 =?us-ascii?Q?YJtc0VuTji55mgZmPPvLaWjMHnjJFt6t7f8kn8g1Yt4SniYqXODmSqf9nuKk?=
 =?us-ascii?Q?BkneEmJoLyvjb4CDxnXCDTlQWnKyv3Aq3MSTDEph?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4610.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31234a2-0212-4305-5def-08dcf1b3685b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 09:33:23.1457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVVoIyiKysoTjiJXQtaLX/iljM2E0i3XexCSzk2m0qQ2nbdvrESahkXPpcwvyvPWOjStzslfLaRmgQ3Cn8HJ5GGVhBr1M7XFkAEorlRAxqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Bjorn Helgaas <helgaas@kernel.org>=20
>Sent: Thursday, October 17, 2024 4:22 PM
>To: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
>Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; bhelgaas@goo=
gle.com; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Kitszel, =
Przemyslaw <przemyslaw.kitszel@intel.com>
>Subject: Re: [PATCH iwl-next 1/2] PCI: Add PCI_VDEVICE_SUB helper macro
>
>On Thu, Oct 17, 2024 at 03:16:47PM +0200, Piotr Kwapulinski wrote:
>> PCI_VDEVICE_SUB generates the pci_device_id struct layout for the=20
>> specific PCI device/subdevice. The subvendor field is set to=20
>> PCI_ANY_ID. Private data may follow the output.
>>=20
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
>> ---
>>  include/linux/pci.h | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>=20
>> This patch is a part of the series from netdev.
>>=20
>> diff --git a/include/linux/pci.h b/include/linux/pci.h index=20
>> 573b4c4..2b6b2c8 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1050,6 +1050,20 @@ struct pci_driver {
>>  	.vendor =3D PCI_VENDOR_ID_##vend, .device =3D (dev), \
>>  	.subvendor =3D PCI_ANY_ID, .subdevice =3D PCI_ANY_ID, 0, 0
>> =20
>> +/**
>> + * PCI_VDEVICE_SUB - describe a specific PCI device/subdevice in a=20
>> +short form
>> + * @vend: the vendor name
>> + * @dev: the 16 bit PCI Device ID
>> + * @subdev: the 16 bit PCI Subdevice ID
>> + *
>> + * Generate the pci_device_id struct layout for the specific PCI
>> + * device/subdevice. The subvendor field is set to PCI_ANY_ID.=20
>> +Private data
>> + * may follow the output.
>> + */
>> +#define PCI_VDEVICE_SUB(vend, dev, subdev) \
>> +	.vendor =3D PCI_VENDOR_ID_##vend, .device =3D (dev), \
>> +	.subvendor =3D PCI_ANY_ID, .subdevice =3D subdev, 0, 0
>
>I don't think it's right to specify the subdevice (actually "Subsystem ID"=
 per spec) without specifying the subvendor ("Subsystem Vendor ID"
>in the spec).
>
>Subsystem IDs are assigned by the vendor, so they have to be used in conju=
nction with the Subsystem Vendor ID.  See PCIe r6.0, sec
>7.5.1.2.3:
I'll add the subvendor to the interface.
Thank you for comments.
Piotr

>
>  Values for the Subsystem ID are vendor assigned. Subsystem ID
>  values, in conjunction with the Subsystem Vendor ID, form a unique
>  identifier for the PCI product. Subsystem ID and Device ID values
>  are distinct and unrelated to each other, and software should not
>  assume any relationship between them.

