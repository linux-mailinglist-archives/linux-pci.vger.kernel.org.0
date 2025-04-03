Return-Path: <linux-pci+bounces-25203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5CA79B3D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B23188D1B1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEC019CC3D;
	Thu,  3 Apr 2025 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXt96YAT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93E19C574;
	Thu,  3 Apr 2025 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743657987; cv=fail; b=MnROW8tVkj0zkO3DymScwLiYisZgpqeqqshKV6MYy4fBL6BrMlmaHy/t0+FJaKsOH28/12SycErDIrRKxVWOiiZAk2QPZydglgKnWxU++Ot8BfRa0uabc5VOxkPfiTbPQX9BtThQM8GhNerVtqQS+jtiBYAwDLAyQg4/otoxpNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743657987; c=relaxed/simple;
	bh=4P9SrwmfKHD4pw23aK8NF7ofUZdTELn1d3PGQ5Nr8nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G6BLvq28/qFRIV049rcsz5MQqGZSw01IDvrF4MIpwF29pvunNI+rucONR1u8E0ZBpBM/RzIGoTeMLlu1u0rBg2s2lJ9w5WWMBFiC07Fpi2LYYxJ7oBb0lllvP67ntfAmxjdFKy4DI1OmftxuKklJiY8jYP0jq7gUqc6B+kHBviM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXt96YAT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743657985; x=1775193985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4P9SrwmfKHD4pw23aK8NF7ofUZdTELn1d3PGQ5Nr8nU=;
  b=gXt96YATKQ8GIbrRf6zCzrurQd34Ezw9d6JjxRDYNGbeEcygbMvneK/8
   jciyKGAlxKq6/LdzQvX+mChL+kq1FCYpHIhBUH2G7FWgyoSsc0RQUUOgk
   k4tFJFUNZI0cFLkqLwHPwMMDadNZ25a4hFXVUiOAsM7sA91EocCTbO9jW
   Kx9f2u8/kRglbv0TYdv2YmKV0fJP7Djwj0JWl9UXskm01/Ii5qXlGaC7I
   Y14PzEGFsurkZgQ7koUwG6LvYP33sIspbE0yjJb1X2WjzNp5GAlcTPdo/
   1Q4KQuWe6dP8d9ijZTXP4McbQMqd6XjtbsoFVHo8wD5vcPiYnU8AttNUr
   g==;
X-CSE-ConnectionGUID: hq+rPk1QSG+pAqAW6pC+Rg==
X-CSE-MsgGUID: IcoUkncnQqGrUUU/JrXzFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="56411835"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="56411835"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 22:26:24 -0700
X-CSE-ConnectionGUID: CRtjET9lRjuZAZpbrYmIEw==
X-CSE-MsgGUID: FLEwf3sTQyanoSScbfKH8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="131612121"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 22:26:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 22:26:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 22:26:23 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 22:26:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDB5+cwgsLK/b6V+Vn7KkNOZmMZZMRw+lbaOo8uVtlQMI+1ZVoN9LmKIV+3wZ7tgt1IZ/LZ50jO86WbsS/zntlS0PkYc0PIL9uz7ML5/66AyJiyf/ETsT9Ml3IuW8bCCI3w5N/bqzRYeTDKjY6AY7VPf6BpXb+vNKwJDCaI3PdLchgIQ1pCu6PydpFCjWqFBIh1aOzpF2wKZkUaNKMmriRvK38L92byXSoDf6F3rFukKXgdlxFmGQAztc4Fa5jrgRTxNq1iaMqRkXDXRqYWY09ZuLZ6w9nQKEXySHOXgTQsDdMhwGttJw2YAjjZiT5s3Zcnj12B8CHQpDJ0hApzAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLuamujwKmhuqFpm8IcGw+sht8bdawMRxlLPev1sHIc=;
 b=QIb9IKACDUWwFW4Qv45Gimo6vdqKMhpFMsSR2SCJ392Oli7L/BUxXSmWhAWM9ZwSm2pQkgqniZMurbCk/TxaAGouIb3apOz5AUfex/9th7YZSNkkRsM/KlQ5NxQ4W847pv+HSbsu5Fxfgor5wzUvO2cs5+PKSBPRy9cqWSDROoTTTds6F79bnrDn/NkCjtHBBfaUjj271FnMWhLoyraLqTS62HXBPF578X/cvWBjn8iYyiY1JnCu6oYrBOG2AUHu5adZtkI97479pU1I2473nV0/EwDefhAPN5l+oTXAq+VvWczBAtB3IsIqt5LN/vHPG9gEnlKMc0c1Pji9iDkuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Thu, 3 Apr
 2025 05:25:53 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::df5a:a32c:8904:15f1%7]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 05:25:53 +0000
From: "Gupta, Anshuman" <anshuman.gupta@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "De Marchi, Lucas"
	<lucas.demarchi@intel.com>, "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"Nilawar, Badal" <badal.nilawar@intel.com>, "Gupta, Varun"
	<varun.gupta@intel.com>, "ville.syrjala@linux.intel.com"
	<ville.syrjala@linux.intel.com>, "Shankar, Uma" <uma.shankar@intel.com>
Subject: RE: [PATCH 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
Thread-Topic: [PATCH 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
Thread-Index: AQHboxvQ0Mcm365YvE+AgvzdU5tss7OPIL+AgAJDvZA=
Date: Thu, 3 Apr 2025 05:25:53 +0000
Message-ID: <CY5PR11MB6211B826D9C5DA3B5429FEE195AE2@CY5PR11MB6211.namprd11.prod.outlook.com>
References: <20250401153225.96379-2-anshuman.gupta@intel.com>
 <20250401182545.GA1675819@bhelgaas>
In-Reply-To: <20250401182545.GA1675819@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6211:EE_|DM4PR11MB6065:EE_
x-ms-office365-filtering-correlation-id: 32fc3784-4b89-433a-1509-08dd72700138
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6nVYcUc5CaipqV1BngfJUqfEj/+XXZHcvWJj3mTbnyXuFAm7TgmIFVmMvjk3?=
 =?us-ascii?Q?kFMu53dvnNd+NK+M/W7ypleimBlsJDS5CfpYIGeV9LN9XQLfn86Imgpnk4EM?=
 =?us-ascii?Q?2/k8LWgmU2ujJOtTuzB//urM0BOrIDknWqti+wkSyLqMAmLRYS2NA8ayRaw5?=
 =?us-ascii?Q?3bxUFZKJAhdnms1GdLc5d7hWENfXY+bWkDbNfdGGcdY+nIL9Ybd+qL53qBfl?=
 =?us-ascii?Q?12DKJzFTIlES8dEW6+A12+V621bGzofC35wwggl0kNxdC3dvoWXtjgCxg0VI?=
 =?us-ascii?Q?QqkpQBtah28xnlJwoOixIZHvZoVZTWfU97yeEgUQv2PbOf+XAq6OUTdgWq7O?=
 =?us-ascii?Q?nFLx5IBELOXClcs/nExkLN8RaqvaRG1GxFNjZDIES7m7Qsn1dcM/b4KfPkQT?=
 =?us-ascii?Q?6YOPzfTnTQ3B3QL0lNYFEUXwKAjr/35ol3c5fojdoG3vXU8gOmT0K/G67i5a?=
 =?us-ascii?Q?aktAlgMDeoHvmcfSJkXE7Med2W9KmNTVhngNkoKCZ7EyMhOPYI3ulF9EmBau?=
 =?us-ascii?Q?iKQaimkPAI63xeyVCXCI692lnCDaL23qj/VBUn6KyZihVit6L17957Voh5ya?=
 =?us-ascii?Q?lFlXjsGfhkZYZiFI/AeAY+hjhQu26wdAJpyT4xEs80cYQM+TLNJNIPmw3F3P?=
 =?us-ascii?Q?BpMF+j2c82OWhREkRRzjW81MdBQRxA0OGY6n/oEjl7E9NTZ7rg8f6yLcC7pc?=
 =?us-ascii?Q?v7Kv6ayQcTim+6cp6kU1PKYBwKKViBCZVKAIhpgIxXkk/6wzywW8kNkQGZse?=
 =?us-ascii?Q?2o4H+Vk2xjJcHWTObXFr4GEyFqGrpXtQrdjLeXTsreVYejpyqlb3qnbKY96e?=
 =?us-ascii?Q?bklYfvZHA/EFeNXUCzZD0zuJCpFXU/Sn6rQhNR25PNBEs+iTMdmasE8sq9RV?=
 =?us-ascii?Q?iNYWnx/5OTbeIL0tXcW8Xa1eXS6Hs1eHwMd5Z+2jCR/67skahHlbNgNySR8O?=
 =?us-ascii?Q?YoIF8YfB4iL75v+rXHY0fEqEiLW5PjDY0HFHIL3EPJUfHTCYSO0O8ciNq6Mn?=
 =?us-ascii?Q?5DqVAaQ9JmkBxv6g+jFXa2zMbd2WuN8JvUU8NXvUrXEM6oYtbGrYJ+VULexG?=
 =?us-ascii?Q?/1noYmWVHlWgDvEJAgub0vv4ydNV5hbT5hVmITU2i5pdiHIJYZi1gmYlf8FD?=
 =?us-ascii?Q?8SVUTKEM1vkcDakbsUuE81TT3G4FaHbP152kticCWP/KwUOJwCVZGPLzQ6yr?=
 =?us-ascii?Q?cxHXAaoXOEv1klm5iN7MPo9K1LxB6ZjoLqgwgctXiB9Zfh92SKm7aO1f+OuF?=
 =?us-ascii?Q?84YMPVEIsvA1InU46wpl07kswAsvbXSJzGdxBg84gdBqV16fKPunqQtxtGcx?=
 =?us-ascii?Q?XP1auOVA5IJbjMOGOrQFhgsacApF4KWDyVcrGByn4+PRSeEzSteUpE7lAT/n?=
 =?us-ascii?Q?4FCmNjlTwgPI+CY7Y+LJ50Zdxhcm8Uy2fRcPgU2Cj/yYfJ73z5Dp/KRvuAXM?=
 =?us-ascii?Q?AnVqxzQl3yHwQM5gB9HmFCKFijkrWIOQT9yd9f73bd4w/EyV5W59CX+8qV8E?=
 =?us-ascii?Q?Y3nSa9VPsFPq5cI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wk/kDlzeBVZBbHKeTZlbw2nHqQ0ERnoQsWbFurK5FoDncz5ys+t/P9jqi0Bp?=
 =?us-ascii?Q?JvGaAosWBiN47FcthHkeLZnLDKAjNmM+ib1Fhzf6Zudd7P9Zu/NcEfv6/GcH?=
 =?us-ascii?Q?eLgNs/5IViUcwJHNP6nVigAxrHKKBPqwd8BhHfCj3JZadoPiEAeDFc3jB4b5?=
 =?us-ascii?Q?GAzRmDnpi+Hb46GnG63i23pJ5EKAHkrdCtLeu0wAil8MWIBV9ecSJ8qgPqe1?=
 =?us-ascii?Q?KftGAmH6tC9E7iYBeAPpRRfNhY2/uzLii+0nl83Y77jdXx2qY3OvzGMnlozN?=
 =?us-ascii?Q?gBxN+pMvqdoD3gCaPRSGXVqIAObpHQcv73MdOkUgsdfdFsbWsnWG7qSeY3Zt?=
 =?us-ascii?Q?84N2c9wbWR0gW8bffWJCBZxlEPoAqw5PjFEHwVggX6JARkasDVeTM52Qcl1K?=
 =?us-ascii?Q?NglNLVGzL+HKIKVGmoe5svx2rSjarqIJza5pdJH2RbWSPKCGkOp/nZ7YXK9l?=
 =?us-ascii?Q?dMp5HzBrue60iYLeJCkjKTO+wVfDBmoEzT9Z+L6euzwgfaMq0vH2VOLS2tL/?=
 =?us-ascii?Q?Xi48EA9t7JxhTj4zgH6nXIXZ0E9LBIpWu5WtjTMt88dYmiVlVyk2tLmC/qhU?=
 =?us-ascii?Q?EL80uj2QzidjrLrJDn1hszbbqRKbw6VD6Ehvc1Du4QZ2aWzSqhjDR7JOVMEG?=
 =?us-ascii?Q?rE4X+YOlAN46LqIZ8LBJbENq6LFx7elGiLpUTWWFH9vrsa2tyEAav2HIXAg9?=
 =?us-ascii?Q?v77awG8DThGhN+hp+W4TvrPv4Yj5MvAx3cFuIKjd8YrP2bFKHh/SQO5l9lt4?=
 =?us-ascii?Q?uiXHoCVLLS3NTM0vcTHJCgZY74LN8fv8KJ/VkhKVJBAnCXdLDgQeXvobmWPC?=
 =?us-ascii?Q?9JVmSQyUYEYqXQn8a+CS01ioNwUdcBGEc1xQV+uhiy0vdJjpk9vPCqaTTJ1D?=
 =?us-ascii?Q?cXN16Y14U/PHVfLNKZIx0jP/etE/a8CxogCjo5+6euViHzGVNYd9OidrpF7y?=
 =?us-ascii?Q?F34IH/LsZ1QE9IMnttsQ8ykweLUTEmor1ezWXpFsRaD9Bd7DwN5Qaj57eV2v?=
 =?us-ascii?Q?yI9t6aKu7W0edk7YY4jDcAFQxUOXgCOGzy0HpiY5ckXAKSREXPvbnMqLLpDZ?=
 =?us-ascii?Q?UEAUhQyQtqQNNQ3zBi81oMuj9trhFDMg537DykduCv1boRhstLh4KeB2OaE6?=
 =?us-ascii?Q?g+8FqvXVDhEox2X0as5Hu/DMaq2oLkzneOTSAvY+WqYLxDy6m8LoankuwBTP?=
 =?us-ascii?Q?VCYiNX29xshT6rPAOgqRdQJJsfrS0wyLqbIo+R1kCWgD7Ar8o+XAdE2MgZvI?=
 =?us-ascii?Q?ISnlLghb68spXHsbhQ/L36Hj/K4iwntgeuOo5OqtdEf1tJ7KFCtC3jOeOQHE?=
 =?us-ascii?Q?K1b/mXDrRKFCVd1geZPhK4r7TezzvG/161N2ju+EJwDwx4krZhtUssOw2nuY?=
 =?us-ascii?Q?MxspPcnDyOSL3JeN1PzKBxsV+x/W3ZgCowJjHOAZGiLExABN3TOrdlouDbMl?=
 =?us-ascii?Q?ABVSNoG/JMKgSnWUT8rD77wxccOQILaoofjkKZtG+WUst6q4Ye+LVpVKlxLq?=
 =?us-ascii?Q?elGsuLNYU6YZ9e5t71LqQa0LY2oGac8WsJQRG5G+8ck+OG5LWDxh3O1v+G6P?=
 =?us-ascii?Q?RmOk1D8k8bdEbsze5BjOF6PJweJJaHgLblazig/k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fc3784-4b89-433a-1509-08dd72700138
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 05:25:53.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRS6DKntkMVA6+jnl1EamQyOsx2dRpwOIyMf4WsPwzeV8INdZbDs2dUgCo9mako7oQpMajaXizBZvSxeFMVnPhw+bsrck6eyrv2yWynJC84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, April 1, 2025 11:56 PM
> To: Gupta, Anshuman <anshuman.gupta@intel.com>
> Cc: intel-xe@lists.freedesktop.org; linux-acpi@vger.kernel.org; linux-
> pci@vger.kernel.org; rafael@kernel.org; lenb@kernel.org;
> bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; De Marchi, Lucas
> <lucas.demarchi@intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; Nilaw=
ar,
> Badal <badal.nilawar@intel.com>; Gupta, Varun <varun.gupta@intel.com>;
> ville.syrjala@linux.intel.com; Shankar, Uma <uma.shankar@intel.com>
> Subject: Re: [PATCH 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM
> method
>=20
> On Tue, Apr 01, 2025 at 09:02:14PM +0530, Anshuman Gupta wrote:
> > Implement _DSM method 10 and _DSM Method 11 as per PCI firmware
> specs
> > section 4.6.10 Rev 3.3.
>=20
> Thanks for splitting this into two patches.  But I think now this only
> implements function 10 (0x0a), so this sentence needs to be updated.
>=20
> I would write this consistently as "0x0a" or "0Ah" to match the spec
> description.  I don't think the spec ever uses "10".
Thanks for Review, will fix the commit log.
>=20
> > Note that this implementation assumes only a single device below the
> > Downstream Port will request for Aux Power Limit under a given Root
> > Port because it does not track and aggregate requests from all child
> > devices below the Downstream Port as required by Section 4.6.10 Rev
> > 3.3.
> >
> > One possible mitigation would be only allowing only first PCIe
> > Non-Bridge Endpoint Function 0 driver to call_DSM method 10.
> >
> > Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> > Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > ---
> >  drivers/pci/pci-acpi.c   | 78
> ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-acpi.h |  6 ++++
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> > af370628e583..ebd49e43457e 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1421,6 +1421,84 @@ static void pci_acpi_optimize_delay(struct
> pci_dev *pdev,
> >  	ACPI_FREE(obj);
> >  }
> >
> > +/**
> > + * pci_acpi_request_d3cold_aux_power - Request D3cold aux power via
> > +ACPI DSM
> > + * @dev: PCI device instance
> > + * @requested_power: Requested auxiliary power in milliwatts
> > + *
> > + * This function sends a request to the host BIOS via ACPI _DSM
> > +Function 10
> > + * to grant the required D3Cold Auxiliary power for the specified PCI =
device.
> > + * It evaluates the _DSM (Device Specific Method) to request the
> > +Auxiliary
> > + * power and handles the response accordingly.
> > + *
> > + * This function shall be only called by 1st non-bridge Endpoint
> > +driver
> > + * on Function 0. For a Multi-Function Device, the driver for
> > +Function 0 is
> > + * required to report an aggregate power requirement covering all
> > + * functions contained within the device.
> > + *
> > + * Return: Returns 0 on success and errno on failure.
>=20
> Write all this in imperative mood, e.g.,
>=20
>   Request auxiliary power while device is in D3cold ...
Will address this in V2.
>=20
>   Return 0 on success ...
>=20
> > + */
> > +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32
> > +requested_power) {
> > +	union acpi_object in_obj =3D {
> > +		.integer.type =3D ACPI_TYPE_INTEGER,
> > +		.integer.value =3D requested_power,
> > +	};
> > +
> > +	union acpi_object *out_obj;
> > +	acpi_handle handle;
> > +	int result, ret =3D -EINVAL;
> > +
> > +	if (!dev || !ACPI_HANDLE(&dev->dev))
> > +		return -EINVAL;
> > +
> > +	handle =3D ACPI_HANDLE(&dev->dev);
>=20
> This needs an acpi_check_dsm() call to find out whether the platform supp=
orts
> DSM_PCI_D3COLD_AUX_POWER_LIMIT.
>=20
> We have several _DSM calls that *should* do this, but unfortunately they
> don't do it yet, so they're not good examples to copy.
Thanks for comment, I would like to understand what shall be the Rev used t=
o invoke this ?
 acpi_check_dsm(handle, guid, 4 , DSM_PCI_D3COLD_AUX_POWER_LIMIT).

TBH I am not able to understand the discussion about Rev 4 in the next patc=
h.
I hope it is ok to use 4 as constant here for  Revision ID.
>=20
> > +	out_obj =3D acpi_evaluate_dsm_typed(handle,
> > +					  &pci_acpi_dsm_guid,
> > +					  4,
> > +
> DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> > +					  &in_obj,
> > +					  ACPI_TYPE_INTEGER);
> > +	if (!out_obj)
> > +		return -EINVAL;
> > +
> > +	result =3D out_obj->integer.value;
> > +
> > +	switch (result) {
> > +	case 0x0:
> > +		dev_dbg(&dev->dev, "D3cold Aux Power %umW request
> denied\n",
> > +			requested_power);
>=20
> Use pci_dbg(dev), pci_info(dev), etc.
Will change all dev_{dbg, err, info} with pci_{dbg, err, info}.
>=20
> > +		break;
> > +	case 0x1:
> > +		dev_info(&dev->dev, "D3cold Aux Power request granted:
> %umW\n",
> > +			 requested_power);
> > +		ret =3D 0;
> > +		break;
> > +	case 0x2:
> > +		dev_info(&dev->dev, "D3cold Aux Power: Main power won't
> be removed\n");
> > +		ret =3D -EBUSY;
> > +		break;
> > +	default:
> > +		if (result >=3D 0x11 && result <=3D 0x1F) {
> > +			int retry_interval =3D result & 0xF;
> > +
> > +			dev_warn(&dev->dev, "D3cold Aux Power request
> needs retry."
> > +				 "Interval: %d seconds.\n", retry_interval);
> > +			msleep(retry_interval * 1000);
>=20
> It doesn't seem right to me to do this sleep internally because it means =
this
> interface might take up to 15 seconds to return, and the caller has no id=
ea
> what is happening during that time.
>=20
> This seems like it should be done in the driver, which can decide
> *whether* it wants to sleep, and if it does sleep, it may give a nice ind=
ication to
> the user.
>=20
> Of course, that would mean returning some kind of retry interval informat=
ion
> to the caller.
Sure will modify the function to return a output which will have the retry =
delay.
>=20
> > +			ret =3D -EAGAIN;
> > +		} else {
> > +			dev_err(&dev->dev, "D3cold Aux Power: Reserved or "
> > +				"unsupported response: 0x%x.\n", result);
>=20
> Drop periods at end of messages.
Will fix it.

Thanks,
Anshuman
>=20
> > +		}
> > +		break;
> > +	}
> > +
> > +	ACPI_FREE(out_obj);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);

