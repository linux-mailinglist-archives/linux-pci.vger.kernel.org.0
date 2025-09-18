Return-Path: <linux-pci+bounces-36405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA97B831BD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 08:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783B23AA959
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 06:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6617246BCD;
	Thu, 18 Sep 2025 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOZvIUkp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CE29A9FA
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176206; cv=fail; b=t/zXXUJBr0J5z+tWOVsXPoasekreI1inOQNAKtxhVqM1qEYJhawhhv3xfrzYpv6YZvfqrlDbsS9M5HJs4qd4UuMQYMoiGt9oLqwXc+vNoKCF177oZweRC+OsJQJAoh5KpFTBU728gQk3SFCO42qX6Qd7vDl8AvrAElh8Lop4yPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176206; c=relaxed/simple;
	bh=gUepB8tDUNrSR4rfeqLAl8fhVoKInPVlA2gh8+ZDfY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJ1MWG2DAldHBGu2IDG7SM5dtmTOYMd2HFhL6Yu0TtqPgWQhopBJKOkzU9BtUyeqpuayaM/eHwhm0rzTM5GFrUW7Nt2cWatRZhGU30oNEGSZT2YB6byUazvE/4NnSSXhNAhWkkqhA/HVEzWwNymPm5l0RD0Urla1wh8u4w35gIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOZvIUkp; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758176205; x=1789712205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gUepB8tDUNrSR4rfeqLAl8fhVoKInPVlA2gh8+ZDfY4=;
  b=kOZvIUkpRrGuUpmt4qOWl7cpf1EagztIaZ//FCE4at60IpQogZA4kqiF
   iF10daRXmDYISWHwL2bZVGlVcHmmUCcPIkCKS07LFE4weJ+d++PnGqJG8
   CJ34yI1RJcgbcnwqHFSTr2IRmWSm+XC4cFRrUvovYbJ8vT27HVicEtBoo
   svDpfK8Ze8MlqFOsSUDJoNEhCiB6rkV/3xUST6OEWmQtFV3vDDTLJ25lU
   JY5RhNgIeiRoeM5LZsgLIDBSHkP7qFozGbk5tdfilz7NsD1oU7LJc0AYX
   3xEmuF/kphPgSvbD5sVOKxLNzSGDxoKAwzZRu0qSLlP+c+KRfY86ejCex
   A==;
X-CSE-ConnectionGUID: OBGPCHKuT/6bYppHx8sQWQ==
X-CSE-MsgGUID: l24wBV9cTiOsKgCd+qM+AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77933705"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="77933705"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:16:44 -0700
X-CSE-ConnectionGUID: Hk2MW1jGRe2NrcLiyQodWQ==
X-CSE-MsgGUID: AMV3czHHQR+HOxMu8rdBZA==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 23:16:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 23:16:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 23:16:41 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 23:16:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOghBLN/O8xMSrPi/VqLp3Ybu+qCrBYFCfPKmIAfOf2XCyYzzEkMSmN24MMfZTux3AK2YnHhP1YFNtbWAFWVVCO4PoeQT0LMAcH+CXToKOj5XC800SS/aH9ueJpEXtK4+6xK4wmMBA/7uyjKSNyAkp5mr71u8ox7dutgXofKjC6n4qWGO6wazQ1Htx+HiK7LfMkTTb0zPtGaYvGEyDB3kBF99IF+/mqdFwBrip72oqyesrQ5+b9d+DXc/j4OE0qMw0kz7x3IvS1X7H4po8TYLOUuociGLRYh04t+nuhbx5FQaQYNkT++GRgcEIQ3LytamTtzQAfR1Mb+JN6mV2WCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgOKp4qM7+s75gqz+rHRtOT3l+TJsEyPF8kE1X5VD5I=;
 b=Aq9nVppuIPVkdHxhAqY3k1TSv+CNpr5/U/SEkbGSe1Um0Dj6NLNqSC+GvxeYNCp+8i8rIm2Ja1zLdlnp3j2bnoVGcEzwGADKMK9uv3ULUdF+UrBAxkCyPpUrG52xLkOky/cZ1DjV/sKnY7Yap9kcXZwWTxJIC8/Paf87yohIhbrdffyJPULTOHrnmUCZnR5y4Z3LlRv+CKPywc/zT7pWM6WzIorG5If0DUO6tsdpSakmAG+6TraD8HR7GMZjR9vqh8sHt90f46LusN33S/qXu13ztToLNsgeEs8DlhTrNmTNwS+PYD7MX+lVAHJWcFncHkx0az3c2biUP1zHrk/Eyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 06:16:38 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9115.022; Thu, 18 Sep 2025
 06:16:38 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
Thread-Topic: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for device
 functions of Intel GPUs
Thread-Index: AQHcJhH5Hi/XzGn7NEC5e+4cxcvJFLSWGoCAgAIWItA=
Date: Thu, 18 Sep 2025 06:16:38 +0000
Message-ID: <IA0PR11MB7185186F6AB160AA7F8F0FF3F816A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250915072428.1712837-1-vivek.kasireddy@intel.com>
 <20250915072428.1712837-2-vivek.kasireddy@intel.com>
 <20250916175709.GA1324871@nvidia.com>
In-Reply-To: <20250916175709.GA1324871@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DM3PR11MB8758:EE_
x-ms-office365-filtering-correlation-id: 743ebdd7-6266-47b2-05cb-08ddf67aed57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?U0JbB7MswK9BkYX6n4Kkj220SRhZPRrkoCUYu4LuVB4xtbY5QcbrlHz3P74o?=
 =?us-ascii?Q?oEWRDo+J5iuiGm1uXkN8aZKDx3zbJcH20MHKy/LDwkJJoGUV+h4zR8mhziGw?=
 =?us-ascii?Q?gqVwe4WF94yedeqs6oifXSanApODHb5MU5uVepPChi+vmD86PdFZJkziULUc?=
 =?us-ascii?Q?D8MB0UrWYt8HQ1esX8QeF+QdWttUWQmhribjBQKZoCB7Z+GoBkJ2AXMl1jyC?=
 =?us-ascii?Q?QInHuuoxG/8X6zwrvfIApDuzvDduszkISPkfAUnl7REcUhOKGGAR27X2nhmq?=
 =?us-ascii?Q?mehoZx6gSOKfO3HSKHQtVdwbKgO8ZJ9jfcUOCykhBSSCe/nwQlm/VTyICdAk?=
 =?us-ascii?Q?fGeMXGw9xeeVTmkF6RcT7HKCySQ7C31I5/IWSeiodIad+23iDxE7oi/spLrd?=
 =?us-ascii?Q?xcgJ2Lh23G+o0fRVmJ/mdPIPbbUBkvMOvVqsJJZ9VleiIVTEQn+LvuZKrHEk?=
 =?us-ascii?Q?gLLwwqg1TPDSSIpyVLblZeCB/ZMlrYTQV/qsozYGNibqtpnUM48E3S8JEaJV?=
 =?us-ascii?Q?1Qc5XrIC0Obd3FJvWPZXBAZtw9GBj1s6mntMrwrhS6H37ahB8cL7z73y0fJv?=
 =?us-ascii?Q?C6R4zC6UIFGoK47Cb4Cu6kWVmvV4COnhAUoNgRSWlr24dDTjpKusCETPASsn?=
 =?us-ascii?Q?35l4H3bmduF/OPl0ZMf0OmHb4+HrlNVkOCkbprM5G0SBhii/oLtXAcUGkYiB?=
 =?us-ascii?Q?J0T0PZCFRyTXQoWELYVC3DN4PS/4WdhBE5+wlc2wYQpJtKE6SY4aSIep6LpI?=
 =?us-ascii?Q?TTX+oyxAKlBGmu5dZQyMEzRyy0iSkifgyXL4N2L3CeECa90UyO6CZ9POOaaU?=
 =?us-ascii?Q?7mkJyfSWqBRdXkJu3c7/MfH+vEE1YUxGrfFVKKS/NlMosaSnqcOPyydkPZbm?=
 =?us-ascii?Q?kAMyK2+1NPPsC3hp0XfrWFdCq/L77I5UCR+77rZixE3DMey7O8A+wVj3dqtI?=
 =?us-ascii?Q?faJvFEeGwJo37+ls7OAJmKrcJ9aSFIS/MaYiWxG76XSFlVzifiQAARnuU/Gn?=
 =?us-ascii?Q?WDTLDxhH1Si/xALbwi1jG1iu/o22x5DHxDXKXo7pyWJWx31o7fvCCZBOYI+o?=
 =?us-ascii?Q?LXjkSbpoZUH3YnPp/Okv4HGOfT0Y8St8obWh02gcyOFT9w8Un1QB1nTPOROh?=
 =?us-ascii?Q?M3GNwvsHC+ocILDv3vkP4oIQ0dz4x6YX3lOE9Mn4KE/CAeL1rkPWLAPUxW4p?=
 =?us-ascii?Q?ESdzEiTadrnbdksracBqplfNzw2FL3FcJQ9lfmR6GSc7NxCTVJUZg+AuA5aG?=
 =?us-ascii?Q?aqtSDqa1IH0AY8+e/EPxVGTIaqwTy/o8saRoVKKCb4UUrOzpOWOwLWgJNYmC?=
 =?us-ascii?Q?fxEGg/EAWJSXeabs/WZYAM2Tpgi0wYNe/szqBuLQRmpP7NMwrhjBBrZ6/UIf?=
 =?us-ascii?Q?ZqFTUf4Xv9oqIa1IZeIBaiEZtj29qEEKh03mXIDyVdh7vck0dv4w1w4G5MfJ?=
 =?us-ascii?Q?394Eg4LHhvDjxAnEz2W/s5a4v42UprgmXjTNrUisXc572o9QeGLFEA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7185.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y3+msFsvO/d9UahCfbdD6qu0960PomkI86D2LZZgHGnbLK2Ss7UY6UjCfX6S?=
 =?us-ascii?Q?nDNi951kgS3w/v1e2yh33pQJUv5+T596ccEhS6qCnUdo0HbZlkNIu0kPEZIg?=
 =?us-ascii?Q?DApNqrRxmgDabAmIFZZ72ZdPIE1qORqrZo27RkUkRdnFD+jkOPga3uYZAqUf?=
 =?us-ascii?Q?yikO/xK0HkgTLQZY0LsXSBRaRkgLjmHNsrJnrgzalUreQSt4i9dzz69UqpLF?=
 =?us-ascii?Q?SkXn8hSo18FMpb3H1UoXh90rFl70hjIU0+liE7BXU8oBj834Elm7Il1EHAel?=
 =?us-ascii?Q?iFT8zibSujOv1zAw3q131VspdCqQMjxhUzwvZLd8I5G9Aa8+NrKYfA4lNfBq?=
 =?us-ascii?Q?Bzflrc7umf5cBgEMRrpQVuSq/3irkvT7aKe7ljOvsYIZIvdnBLCog+pZtabu?=
 =?us-ascii?Q?Ptw9uJy87gm8HPO7mYXVQS8yhTGDbbYYN6KLhrDPVgAHC08LZ2NQ4SYBAQeu?=
 =?us-ascii?Q?z45HvY0LzsSOrcmCX1QC3izCrM8SL8jV847zxm33yOykJSufjWU1HtzCXHPJ?=
 =?us-ascii?Q?Fn1S92jpAaZNXMzLaMm8lpCOIrnnPDJCfYRsokwZV9HoDN9YeeGD+XO7IbOa?=
 =?us-ascii?Q?i+5khfn8zkPqRHnwse4DVVyyUILcfzT1Op31EpxvIT4xk4dx10VnoLHKkbKE?=
 =?us-ascii?Q?sK/+RV3H4hDX+IY45p7OxdxiEX78taVcnHW+TylHONUtKDnL6ywBID7Yp3sC?=
 =?us-ascii?Q?1UdIMv+6CQgdKupWaJfKwVDV0C3PQYuALHFNnUJEFX5Wqt3dx2qI+ecWqvAD?=
 =?us-ascii?Q?h9HLTZIi6ONL6GEjwq9wIgz5XodqhXaH4yMVO0lyPfLr1M3gMVhkrQn7ejGH?=
 =?us-ascii?Q?AimHE2YBXC1pg8OROkjZEI/8J9LGKTMndKPRuHMDaAtHQQByvH0ZaYiondL2?=
 =?us-ascii?Q?uUAyHdCGnbF1hRFJ9f5v29sk/07bw82s03SbpVQBObxkQ4W4f3AMVTDrbgQw?=
 =?us-ascii?Q?kTVTYk6CzJusEB/HcdAEbOP9yz+JAGf45yGqBsqdfzTYsrHFebSMFUqTt+OU?=
 =?us-ascii?Q?wC87RF7ZnW8ww54OBtiK5rMz0a1en5sz++ETZz7acGaZAvvd7aIGZ5K8v8kK?=
 =?us-ascii?Q?Z/9UBFVo3lXKsMxk6VBpvRRYW1BrMpuz36VEPTRmiqFvXC4S2nbzEGMzNwQC?=
 =?us-ascii?Q?pvbUSRrqLWV6uxouhjMgGGIJ6FInEU/45rZ9UfEypILOQc9bj1zxTOdhy9V4?=
 =?us-ascii?Q?e6fMT/3NcpTsPjTXQPw3LfxwIorkXkD9iPH0k6ZkN3ixc6HqDTeAOzmHeL8U?=
 =?us-ascii?Q?nfLzxKe4mLBRglMGs29Os+hMfzi6Uqgd81VsL8S/5rgUI6Vu9UwEM4nYrvyG?=
 =?us-ascii?Q?uktjrvjogVurK9XzPn6I7pX/pShbFvglUM2M8n9pdbWhm5oW4xpP4gxhlHET?=
 =?us-ascii?Q?vcqSRvd5ab+giGwAln5eUmGWHPQj786L/j91iz8qA+oPfE6/v0ACvK0IGnjl?=
 =?us-ascii?Q?fpYBTLOFmh3Fa1L0KhslIbCh3/rKpeDGvCnU0rdr5RG1oQqTG/Xi2UdseZgK?=
 =?us-ascii?Q?67EdZp3F2ZcS4m3WwN/4G582WWhENFAgUxERKcRFCdZLae+MTDzjIXJUwe1G?=
 =?us-ascii?Q?6lfBZq3wy5NC3/CswnS2cI1IWm1X42qGXHnMyyyg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743ebdd7-6266-47b2-05cb-08ddf67aed57
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 06:16:38.4770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbIswxPoofCQaY4pIYt3nr5FsC16mGx4/9jMbesHG27SyWN/Wqdupv3FHJwlShqAOBPOlAi4Vrbh8j+eHftEceUHcpbNjgfYmlZOCruuXzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
X-OriginatorOrg: intel.com

Hi Jason,

> Subject: Re: [PATCH v4 1/5] PCI/P2PDMA: Don't enforce ACS check for devic=
e
> functions of Intel GPUs
>=20
> On Mon, Sep 15, 2025 at 12:21:05AM -0700, Vivek Kasireddy wrote:
> > Typically, functions of the same PCI device (such as a PF and a VF)
> > share the same bus and have a common root port and the PF provisions
> > resources for the VF. Given this model, they can be considered
> > compatible as far as P2PDMA access is considered.
>=20
> Huh? I'm not sure I understand what this is about. Please be more
> clear what your use case is and what exactly is not working.
>=20
> If it is talking about internal loopback within a single function
> between PF and VF, then no, this is very expressly not something that
> should be expected to work by default!
>=20
> In fact I would consider any SRIOV capable device that had such a
> behavior by default to be catastrophically security broken.
>=20
> So this patch can't be talking about that, right?
>=20
> Yet that is what this code seems to do?!?!?
Here is my use-case:
- Xe Graphics driver, bound to GPU PF on the Host provisions its resources
including VRAM (aka device/graphics memory) among all the VFs.

- A GPU VF device is bound to vfio-pci and assigned to a Linux VM which
is launched via Qemu.

- The Xe Graphics driver running inside the Linux VM creates a buffer in
the VF's portion (or share) of the VRAM and this buffer is shared with
Qemu. Qemu then requests vfio-pci driver to create a dmabuf associated
with this buffer. Note that I am testing with Leon's vfio-pci series includ=
ed
(vfio/pci: Allow MMIO regions to be exported through dma-buf)

- Next, Qemu requests the GPU PF (via the Xe driver) to import (or access)
the dmabuf (or buffer) located in VF's portion of the VRAM. This is where a
problem occurs.=20

The exporter (vfio-pci driver in this case) calls pci_p2pdma_map_type() to
determine the map type between both devices (GPU VF and PF) but it fails
due to the ACS enforcement check.

However, assuming that pci_p2pdma_map_type() did not fail, based on my
experiments, the GPU PF is still unable to access the buffer located in VF'=
s
VRAM portion directly because it is represented using PCI BAR addresses.

The only way this seems to be working at the moment is if the BAR addresses
are translated into VRAM addresses that the GPU PF understands (this is don=
e
done inside Xe driver on the Host using provisioning data). Note that this =
buffer
is accessible by the CPU using BAR addresses but it is very slow.

So, given that the GPU PF does not need to use PCIe fabric/machinery in ord=
er
to access the buffer located in GPU VF's portion of the VRAM in this use-ca=
se,
I figured adding a quirk (to not enforce ACS check) here would make sense.=
=20

>=20
> > +static bool pci_devfns_support_p2pdma(struct pci_dev *provider,
> > +				      struct pci_dev *client)
> > +{
> > +	if (provider->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
> > +	    client->vendor =3D=3D PCI_VENDOR_ID_INTEL) {
> > +		if ((pci_is_vga(provider) && pci_is_vga(client)) ||
> > +		    (pci_is_display(provider) && pci_is_display(client)))
> > +			return pci_physfn(provider) =3D=3D pci_physfn(client);
> > +	}
>=20
> Do not open code quirks like this in random places, if this device
> supports some weird ACS behavior and does not include it in the ACS
> Caps the right place is to supply an ACS quirk in quirks.c so all the
> code knows about the device behavior, including the iommu grouping.
Ok, I'll move it to quirks.c.

>=20
> If your device supports P2P between VF and PF then iommu grouping must
> put VFs in the PF's group and you loose VFIO support.
On my test system, it looks like the VFs and the PF are put into different
iommu groups. I am checking with our hardware folks to understand how this
is expected to work but does it mean that P2P between PF and VF is not
supported in my case?

Also, we do need VFIO support. Otherwise, I don't see any other way as to
how a GPU VF device can be assigned (or passthrough'd) to a Guest VM.=20

Thanks,
Vivek
>=20
> Jason

