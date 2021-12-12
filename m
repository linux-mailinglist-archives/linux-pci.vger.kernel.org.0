Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591264717B8
	for <lists+linux-pci@lfdr.de>; Sun, 12 Dec 2021 02:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhLLB4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 20:56:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:6605 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhLLB4f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Dec 2021 20:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639274195; x=1670810195;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nri17UPYaxIPromTz/Ch5tRTRvspeSgScVpqVbJAO+w=;
  b=NJ9sXyLVE77MnBW6c2rc+oyQYNRPdIHEwzYTCbsl5SK2mcvtPVm7w5DT
   h4x8XK9Je5Pn9AY+/Q6txPhy2cQRRw9Yl8r6HZdxKeCmidCXVzUHlCJp/
   t2OaJqPb2Gg8/m59bX1as9R9SLfUugsj49ijILuMBvBNmLtdEbpPLyvmK
   1GxGlDAPVyqtA4OWD+tlM3JQblullqZ7ekL2kOcM+gwro4w6hALSdW3sv
   BvKhEl3XdMO8Yth/UckwH/bkp63dNSZSEfyiMyiohWhozaPpq/GE0ax/V
   tu2vu3tMbXWMAKm0ke4YuXH18FRk2inWY1trtg1b4CQMUfTrE+GH8Xc8n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="219254283"
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="219254283"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 17:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="613374619"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 11 Dec 2021 17:56:34 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 11 Dec 2021 17:56:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 11 Dec 2021 17:56:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 11 Dec 2021 17:56:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrV6ZJ/jT/dzWyogWXpyaqdbp5vSeLdTjWeOHdCy6jX3k2xrqBqscS0GpKsGjOq62PIHLcx36B+cvNg5y/UiZdMHN7HlZVdzLvoLRcoL7u0M46fiPtcpA8ZFx6SgIYBy1ATIbjkbzpGqxlQZmUapbI/BVJhuatkTIrpfyNmH9Y8+9h6hsSKE015Sipar42IsjynlX2cS8GLqgoGMgH9Aw0WnozGWV1oB/KUu77K6Z+QauAmVgBXNOExAvmksHiqeUy+S1k6rI8Ke5T6snKt4wUSrDdKSgDkgD0JcK0vXyPEbW+GqwtkTJh/rTWKxi1lygFFZZKl2TcPNipKc1xu6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s63LHu4YIbBAQJJfSifYoItAZ4cewvwDRjm2hHYfy8s=;
 b=GRbquxK+KpbBsfVcuhG8UmvtGR8Gz/LPyKUNL86AopRULcO4iKLnrZrz/rcDwSV9NdsSIM3GwZ8Rtv7yZy5JZcJZeGvZxS4urAMNDjAVOET/kUrv0ypg08xGybVGAjbUjdVMBIQg36tcpUY3+m5P66kDQxLTZT2ZxbuDGDXmpn8POgcg4lW1DjDkYjFx6ldob8WPIW1cshcP2FINZ1Xl+4EVDl0kL7EK21VtbCTNVL7cVALn2Z4zeatd/9REkvBJA3BntuvcoHp6TN1RZsI9Jfpu1mQUQg+vw59FHMgMQlixZwOzqC09huJqc0g8J9lyqazt48pjKdvQ7pQidI86oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s63LHu4YIbBAQJJfSifYoItAZ4cewvwDRjm2hHYfy8s=;
 b=IqEBYDmtqXR9v408JW4KwO/p85XbLvmsSnYqRmVPh56sYZ00XjBLX1Bji4F8G8HrU19eWweo/wgZDwvkP8zpiq3x3qz9Toslcjf+jcnGLDYvLkU+TSaPLNLYqeQloeBearJTgCyfx342+63WJ7zizOVTELtICDH3auIEDx0KN1A=
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by MN2PR11MB3871.namprd11.prod.outlook.com (2603:10b6:208:13c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Sun, 12 Dec
 2021 01:56:31 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::345d:b67:e8c5:d214]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::345d:b67:e8c5:d214%6]) with mapi id 15.20.4778.017; Sun, 12 Dec 2021
 01:56:31 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAE+oAgAAmHACAAFJ4oIAAem8AgABqWwCAANPscIAAWxoAgADV7aA=
Date:   Sun, 12 Dec 2021 01:56:31 +0000
Message-ID: <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com> <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
In-Reply-To: <875yrvwavf.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5382d6d1-7740-4aba-a189-08d9bd129e59
x-ms-traffictypediagnostic: MN2PR11MB3871:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB387132F76D503DDF486A05F38C739@MN2PR11MB3871.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PL0GpkLz7lglXX7yaVGiNcOg6pt+VM/8rEGcaKD9SuBJfz1M6OilevPnXr2SVNYQsh5TVACbjfM86oqgZvhYT23D/XdweVivT8w6w+Bqi7ZWOZ+qWgmuxE8ULpgazaSZUL30hwmedqZY39KUT3E4nLjvY6XBDjr7mbIQm4qYfxvTi1LZ/cGsj3vfTVpp37ux0ZHW0rJ/6tcH5Ngy/KqIwGjOkGHIQjul59CHhgWBe05DB42PYSblLmc8AV9Nfs3pNqMM/pe8b913CoYHN9gWhGBwaUSR7HUt2ZM2r4ywBTDHde00MtD/7nFrRvnN7Xo358mtq2HRF4PQ/zXjwWUsfaVfFYJAq86fSldtBzf52B/lWvCXC1PQ7HwmZA8Wyw8Td1K8QTzYtM1fxMiBeZBLoJnGA2rGnW7mLtKC1eqTkF0laD1DRp56G14EA2o3Q1AWuEwlc/BJhysypX2jE4JSBtqfEqxR9St8jsDR79qpDHRW7hr9ur1rukfjzmrkvzEa9fjZq3bQUcMvsJRHey/M5OeIwnqgBteT6GZTBPVInYO0hZkKeSX81Nhr1ZuEHaHHEOS5TmzpZWuBWuqKm5+3FjFLDsxkNejav59BDdEaf50WH+YjPFOXDqaRYHFhCfevuzgSGCN/46GvtK+CDuFTeDAnFc9+FlwtYzURk1X6j/+PipFjouQU88VQEvyNAFh6imuaEG+mF0l/kk+zWwmHiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(66556008)(316002)(64756008)(66946007)(66476007)(76116006)(7696005)(4326008)(186003)(110136005)(9686003)(54906003)(71200400001)(86362001)(122000001)(8676002)(8936002)(55016003)(26005)(6506007)(2906002)(38070700005)(5660300002)(33656002)(83380400001)(508600001)(38100700002)(52536014)(82960400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUMXxiXhM3FFRaKsJzHdBEXeSe4LS5TxQ9cAhVIhmKMVs2WF1z48TBZba1nG?=
 =?us-ascii?Q?oLhOp6HW6bRcC3RxPr9t5t/8Vfsm4AQ1ILN0uGe41WYTvet3qdk6SJYuS077?=
 =?us-ascii?Q?rP4pTUIWJJBIgQtMMIkWAM57WHByxMxuDJ7qIqpLWOAfTqqWJIur5pQr5Rh0?=
 =?us-ascii?Q?KF/PpdfvK4PPsmun0Hhoc4CqWhsxoOJnam8NS3Kn8egDqKP2U/yJBNub2ZfH?=
 =?us-ascii?Q?5fB+3NnusRBpGuRWJ8rTIPioDc8hr9mA/XVGD18FvL4HOch5IUG4RiUS93ON?=
 =?us-ascii?Q?NQuyXnEKRu//vpmI/ncQZA/jhzBupsAiCxjwKMncfIV3FXlZaZ3Nekp2HWAf?=
 =?us-ascii?Q?/qHYhkOr7Mi7QXeNb8RwHo8/Sa+IbDasNXrSi64UDD/Noin8ORlo4xwqiO6g?=
 =?us-ascii?Q?IGv3Q/9xcC/lScG4SURGbxSjjJ/ErOx4k/Plg9Zs9Fn89TfJ5y3Ui3SbJ1Bn?=
 =?us-ascii?Q?aiUpl3V0+N8Z/jPSYrijJ8POMjtjZwdtc3nG1L+Mm2x0pJv1D7c4tk3o01jI?=
 =?us-ascii?Q?GFQN+6MLp0FpYgakcKg6a+51hu/apN8VWlE9DG8NWKl3eEpXA+Uiq5PcziWB?=
 =?us-ascii?Q?nI0gGx9RJJBCgY2KAOQH1HAf/We3wrsBPoiujbfi+vVyx4aOl1/9Dgb6vw0l?=
 =?us-ascii?Q?dQcLIXwe2uHN6OHoSwspF2K+eOZ5nseoCy9ZpP7v9qrSHrK4S6oZZo2EDvKY?=
 =?us-ascii?Q?+z3HYnyTQ2jJpAbgL2q1ijsxTmXnCFibcAxvxHJvGKThZ5KCQ8l8jGY5GROI?=
 =?us-ascii?Q?cUB361Jus3pHWvhfqyh9mwtmu1MCva4k45FfL3llgOXspix2jd3M4BLe5ebZ?=
 =?us-ascii?Q?iSwM0vfMaSyF6lis9vdluNMWYFPyC3CaIfZdeQ7pEIgW1rwA11NsHasJQbCR?=
 =?us-ascii?Q?cWk0lz9MnCe+LChnIUPRyxvzFL8iZHEw0NErgmQe8bGnpwPW9suzO7ObkKv3?=
 =?us-ascii?Q?wfzxZgFc7AONHgsKBocdjepHjste4CxL5pVreRFteiavbCx6dSw+2HtvHyU/?=
 =?us-ascii?Q?DGKNwlTlhtMM3pYNrSrz1uEE2DsiHoNAXnLqAl4fYlqA9NXubb3gJ7trLMLY?=
 =?us-ascii?Q?MkRANAKvSNntt1XYpOl45hQU6/jQ/y+ViYTDjiA+nqy73FJony9DLiDsEai/?=
 =?us-ascii?Q?6vppnteZkH2U9EFswPYzFXbY6cH4pmyrKpihV51I53G5C03uRswnyj9Ysgbb?=
 =?us-ascii?Q?kqy2wIfxh9GluthMj8t2Meb+9giwlC5jGHM8KQO5nsf1er07gwN04oeR76kd?=
 =?us-ascii?Q?wG1VI1m39yzmrRri0W47pwDASpgkp8kjH+XOXWQWs5BqpnYZmrKUTRVF4X0c?=
 =?us-ascii?Q?YtE6jq7vGE4aZrCiewF/mPtOaOHA2ZwjgsMYuLveBUfioFgCFdkHjM5CrBR2?=
 =?us-ascii?Q?38//u7NTef2/GI6ryqdcmRXQ3eIK3Bew2RhhKTbwV/ymuIqYTG37+TYWacCb?=
 =?us-ascii?Q?rGjoFUzzrCQ68Nj8lopHshf1haHCVTqn4GP++7wrgYrCm3PTzSuA9kmqlxa1?=
 =?us-ascii?Q?Y5Xt1RkAFC4fz5ygs6R4K2gWHcVyQEgsAjj30Kay8oqmtzdMWAvys2tWcxQx?=
 =?us-ascii?Q?ptpKt5zy+KK60rzIqmNapTnuOENfAsmULWEz6G7A43cLCtnC+LB+1itYZHyd?=
 =?us-ascii?Q?ZXGsGM2sar9pn5C09HQyI4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5382d6d1-7740-4aba-a189-08d9bd129e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2021 01:56:31.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuIDCOJdFjarZFqQ8DWCUKqEi2Z/iX9oNs3EtMUjetsSeGkizPHBnXJReUIlzBRzYsaUzYfHs5FwA/ZUzI0rZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3871
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Saturday, December 11, 2021 9:05 PM
>=20
> Kevin,
>=20
> On Sat, Dec 11 2021 at 07:44, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> On Fri, Dec 10 2021 at 08:39, Jason Gunthorpe wrote:
> >> > It is clever, we don't have an vIOMMU that supplies vIR today, so by
> >> > definition all guests are excluded and only bare metal works.
> >>
> >> Dammit. Now you spilled the beans. :)
> >
> > Unfortunately we do have that today. Qemu supports IR for
> > both AMD and Intel vIOMMU.
>=20
> can you point me to the code?
>=20
> All I can find is drivers/iommu/virtio-iommu.c but I can't find anything
> vIR related there.
>=20

Well, virtio-iommu is a para-virtualized vIOMMU implementations.

In reality there are also fully emulated vIOMMU implementations (e.g.
Qemu fully emulates Intel/AMD/ARM IOMMUs). In those configurations
the IR logic in existing iommu drivers just apply:

	drivers/iommu/intel/irq_remapping.c
	drivers/iommu/amd/iommu.c
	...

As I replied in another mail, the 1st vIR implementation was introduced
to Qemu back to 2016:

commit 1121e0afdcfa0cd40e36bd3acff56a3fac4f70fd
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Jul 14 13:56:13 2016 +0800

    x86-iommu: introduce "intremap" property

    Adding one property for intel-iommu devices to specify whether we shoul=
d
    support interrupt remapping. By default, IR is disabled. To enable it,
    we should use (take Intel IOMMU as example):

      -device intel_iommu,intremap=3Don

    This property can be shared by Intel and future AMD IOMMUs.

    Signed-off-by: Peter Xu <peterx@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Thanks
Kevin
