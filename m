Return-Path: <linux-pci+bounces-2698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8E84009B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957FF1F20846
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA201AAA5;
	Mon, 29 Jan 2024 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YeUEnX+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628454BCC;
	Mon, 29 Jan 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518242; cv=fail; b=tb3joCZ8Y++++9A2ic95q7ITsANEEL8OBkitt5owRXYsfezAuei8Yx2ZjrTstoSjoZLWdKt1q9rAAt/xeI0e6OBU+na2qa1Oa6sFHMMqRUkp+2cOzKScJIjYIBsNhJ/oAlQIMrdiJKZ5IaE+J6ykRN6PxtiKkYT/TphjiXewcBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518242; c=relaxed/simple;
	bh=UyEyx4TcnnODi04XpxKGe7BzqSrPpR6IXiTByG9dkfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LiH+PtK6W61/uoP03k9helPfAljA4QHtdFdnSWCF9KMfZKiT6ouYbCgSznDF8FvPDU0d/aVEKCUrcie4JuwWf7XKjGpOh+DcBCUvXcUvfauIFDp+AnuvJphtz1BsX9U1/cr7yF7HTjdo7ZD09ZveIl/0nfiefRiqW4MmwFk15mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YeUEnX+a; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706518240; x=1738054240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UyEyx4TcnnODi04XpxKGe7BzqSrPpR6IXiTByG9dkfs=;
  b=YeUEnX+aJyIuVl5Lhgx41KAtNlOQ+Et9bhGg7/pBQY+Vpy/sSefO7clg
   +TLuEO8QkMlz7TwIAByKkrcoSfupbt0Ot/7SYNn4JU3K0vBe6vq99+zvB
   qaN1mHgjtDrZFo1lapCQHbZaV4frVWDzD0IHNXphJCxUirp39tlNX1b2M
   LC/NwgJqUHFkvvn0FXcmdO6jEZZaHSXSs/dmSDzwqk2dT6GbuAVHtqruR
   oL/AkR93/U625dGx49Qziy6ogw8lsrgXI6MjvSQn69+NdeoYO9yQgXSt6
   MLsJ4p+DeCkI6lgjt4xXNTHeK2+3O9g1mTGMzmvW6OwxlzlQm7aBVQlY6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9639438"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="9639438"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 00:50:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3334905"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 00:50:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:50:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:50:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 00:50:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 00:50:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Toex1orcTN5yrmJa8O/qbjc5fnHMfo+NzftqX0/ePDMo1733g2UV+sxFIRva6sO3wUpWC3D9dORzyEfwbn1vRhT6dbXIcco+0Uhq4kcEt8TTuwT/y9TyV14SufjyO5G9lsYmBkQ5AcFLQlg0WdLA3Rq4tp11BS3Vy0UMKID+4q856rtvvMDPrWGG1MdgmY58Gma6NLdLsqOxjE6Abfq9eeGRoMP1EFdOO2v2i+cV6a08n9qVBIhWgM7+WgfVkP7IhWH1ZE0Bhn1n4HiJpgUlLLFCHwIftH4p8l/Hpu+tQ6yJqgyJasteCJ9374RJgl/GUYhqZOOSSg8VtA2EuTWY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyEyx4TcnnODi04XpxKGe7BzqSrPpR6IXiTByG9dkfs=;
 b=LTzmckmzlQnUM6jlu71E3lExT/ZrbKbYMbpt6zscEOEMHkPyGQIq2WGwU0tDLP3ZjIb9RyG/wV79VlXMqQ/Kk31Dh+ji67RU4v2jaldiFHokHWgjPWJey7vfQc8cUBPGahVa1TPliaJ8gl2sCFem1JJPQNQvCjFv9MhNe7nOeg1iyDKXQSZHtCxbKuZ0HSjMeGpDYwLbbj7rfSNQfEUFqdM8W21qxMDhn43Y2j6wfmoO61YAMipDCVmX8T/7hQJM3H5ZyOHdW7W9mDNcM2F2V0vSD2qkYi4M7GEUiOqat2U4AEQZOfiEkrFGEk3SShlB6BJAnLtB+LAj9W8NSttd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7966.namprd11.prod.outlook.com (2603:10b6:510:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 08:50:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:50:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "will@kernel.org"
	<will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Haorong Ye
	<yehaorong@bytedance.com>
Subject: RE: [PATCH v12 1/5] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
Thread-Topic: [PATCH v12 1/5] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Thread-Index: AQHaUmYyZOQ2PispIkqjAdYF1ImrBrDwey1w
Date: Mon, 29 Jan 2024 08:50:14 +0000
Message-ID: <BN9PR11MB5276B0ADF497AEE3D990824A8C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-2-haifeng.zhao@linux.intel.com>
In-Reply-To: <20240129034924.817005-2-haifeng.zhao@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7966:EE_
x-ms-office365-filtering-correlation-id: d8125536-923e-49a6-53a6-08dc20a74f70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XO7D+SpRWizG/qlMEaLksP35DjqCtcYjuGtcqERhtzdFe449GSiHVDtxztO1aP8+SBV4+kDhPEXvdh5LG6hhg8214G1iRPhsF5UPF5ZuSE1PvgddT+l9+KvskaXD1/yzngTHJ4eSsl7oVi7ndSNp0JJ0GLfVHqQJbsrB8QyZBc9iZ8kXNeh1Tpv3lGCNcdwmv9SchX6WMDkMNM5VI/XRvc3R7V4bNUvrUpasgyM7WWOdhrhtZcbjdLvy0XkjxuqSWp08MWlRyHPsLK1+FgZhz8IBwRdmVIEAMLX56v3Lzy72qm2PD9O5h9Ac/ZyHpAVZbwteq6wOWeWlSiiuSaz2OBDM67r9AXRjE4jgZG9AJS66EedZCIZZQ+Z0NHPdWzDoA8nKeclAoo9Ym53ZXLcnZIZY4itQlxIU6ptSq79CwVbYWU/R8dRwO6KhVOdLhkxHynTX1jYGZsvdLsOlhqBCBCloXB18aOKDDVqyPJ3nxS0wJU008vqdfh+2jX8AyIT5lhgCgt7qEOYEe3qP+T95PRdnFv7ZHL5eLlgP5ge2EM1AfA0Rt5Fb6Qns1iVd6igr52jyQtp+OtP+RlAmM0dW3ACaK3SB2IFIUj3ocz1vVBWuBt6cB/JINBAI6mh6Phlh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66446008)(52536014)(8936002)(8676002)(4326008)(33656002)(2906002)(4744005)(7416002)(5660300002)(86362001)(110136005)(66556008)(76116006)(66946007)(66476007)(54906003)(38070700009)(64756008)(316002)(38100700002)(122000001)(82960400001)(6506007)(7696005)(9686003)(478600001)(83380400001)(71200400001)(26005)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j9L1D/uf2W3Iqe08/t11McQbSuHoRqJnTTAZ2VdH82djUrDdwpk+PNKMRSIH?=
 =?us-ascii?Q?9z8RWDOZo2wbyRsb/4SMEIIV9ncLmexs5rgAeL7yLFtaKpnn+IlPhC9q2L0Q?=
 =?us-ascii?Q?3re2WSb8IGXuvuhFhMWZCxHJpw1ixwVmb6Rd/gJcYut+TwcwPVuPUUF2oFQg?=
 =?us-ascii?Q?VxvQA/ec5NVLCNV3Bv8MhnOLMbkAn2ig8uEDrQRfhF86NQND1PpNlJx1c464?=
 =?us-ascii?Q?+sAi22D4jTFE3UkUPOudqF8t1hd4WL9baAxQo4e1wA6+abSdR+OaicjgY4ZE?=
 =?us-ascii?Q?EBHqQveY1Gkop3AIXf67LQFen/Dcm9RcSp3LljrxDQ2jF8isqG1APDrEeN0u?=
 =?us-ascii?Q?EXIEn/1jWCoRPu+VtzlKzvIzgx4xEdI8f8F4e0Rrm7WNUMb5piFu57FNq8UB?=
 =?us-ascii?Q?Eg3UqA1p/bYectsNP6Jvi4XL5+vdRT187qNNVWrlffawWQD2r/Q4dv8v4e4O?=
 =?us-ascii?Q?2Iflu8zwmU6MwAsL66XiVb3E36xh7/RaQwV1J2zGm+tBpuOtHGYLqDo0qg89?=
 =?us-ascii?Q?SduxQJv3L6T2mOBqBJNHaf8YALhYEsG/97BbJXCBCeFRDpCG7blzE/fnTBLb?=
 =?us-ascii?Q?bzVV4ix6Qx35T2AwPjecOoHyo8SCLg5Kycr/iyulXJs9EV2D6cN4V+4WMIAA?=
 =?us-ascii?Q?DPgDUpplpF//0tZ6EMTepR+uXsLP62HKbIc6paXu8covhgTa6ZJUkriR7+mj?=
 =?us-ascii?Q?gpGSmPDNnoiY8C6nX9nxNzsL0sCzUldJ+uaonUpXCYXr1HlmQCftZi3w2BWk?=
 =?us-ascii?Q?9mDKfqqznDQwKsZvRZjjlHlQsfCwYwF4VZ13lWrDJd5CFoKsITrSXA/73nft?=
 =?us-ascii?Q?SvMz7VRSfOwCcc+tZoymb4r0cEnat5HBwo07JeaVANCWCNAwEp8LJXNpalcF?=
 =?us-ascii?Q?SEfrf8og42GF8mP8it5/IDeA2O1/vg6J2/kEgvpQgQE42MxiP42RihGDGWmn?=
 =?us-ascii?Q?zn37Ud1FYQbE/0gcDPEppPZp4qyEA06yC61Hj8CG3HQnP4zf1aAB0m/zIIq/?=
 =?us-ascii?Q?7Q1C/W8iIicXDDna22T9Ui8TW8hvZo95VdjdyJa+GXUzatKpQKMTdyVJ936M?=
 =?us-ascii?Q?fEksdaYbEd5saq+38AMcvvnuN5xyaY6/ounPi3EkuCJVZNC6HLGlT6/T2s/H?=
 =?us-ascii?Q?fSCLqPmozVSrqh3AqcO8YnOF0tKQZ56P2wKyQ//n1J9pVs57hzUP4tDqu5Cq?=
 =?us-ascii?Q?2C5u52MkPoRgLzT16IPMx0TVYNRr9zfDxIVujU0dfUPHEtAC67zgTVa7Jcax?=
 =?us-ascii?Q?zU33vBRRAPKEaZ4G3lD9Pv5u/GOFiwMqKU4QzXANxInsRnAHNsbT/yYpaN52?=
 =?us-ascii?Q?PCbKXvq9hLlm6w2PnW2jmCpODe3/GAw6JBdwCxWtAZ0l/GPILcq48MZ4RtG5?=
 =?us-ascii?Q?RNoUz+YEN3lkPq0Ao6o67dWOqvGvSSbiAUF+Q4mfTCQUBumAzG+C43HwITAY?=
 =?us-ascii?Q?pqoElMvMvb6pzAEnvtrq1LTONs7wTsoJKFiMBuYFgwbjTTPqS7F3Cwvj9pbp?=
 =?us-ascii?Q?jGRfNXNq03L0I0OZZ9OO+NcP+d/HwDNWml/AmWHRaAxWclMZsfKMqicNDZNf?=
 =?us-ascii?Q?PUXz7SQs9IfyXi38zVJ8T0PD484EatnNuSdEIiXD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8125536-923e-49a6-53a6-08dc20a74f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:50:14.3936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKJMw5Sjams0HzPB20Xryzym5pzNdAnzFS+LTdlcCIKdLs/aAbgBi7eUTyuWTPuI7nnoTCdb9As+ag5ZXN7jHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7966
X-OriginatorOrg: intel.com

> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Sent: Monday, January 29, 2024 11:49 AM
>=20
> Make pci_dev_is_disconnected() public so that it can be called from
> Intel VT-d driver to quickly fix/workaround the surprise removal
> unplug hang issue for those ATS capable devices on PCIe switch downstream
> hotplug capable ports.
>=20
> Beside pci_device_is_present() function, this one has no config space

s/Beside/Unlike/

> space access, so is light enough to optimize the normal pure surprise
> removal and safe removal flow.

somehow this paragraph belongs to the patch using it. The 1st paragraph
is sufficient for the reason of exposure.

