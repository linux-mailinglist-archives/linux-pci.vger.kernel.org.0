Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB7666AFC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 06:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbjALFvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 00:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbjALFur (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 00:50:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B3496C5;
        Wed, 11 Jan 2023 21:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673502646; x=1705038646;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rYb0ZlFG38CyP3z0nP7Q3HjGEiExOw8HAbYX8qKOAwE=;
  b=GTkYrcJhQ8zWDqDW+5kCzmsv8YLpw5OUbldLn0nqOZ0Epm826KOkBrQB
   gKeGQ0JHrtDf0NtACaX6IhhYMkTnZLTcmd/kIVbDaXKXt7IFtodIcSJda
   BJuMI10Gs1OlPaQp48+eeccYZ9ybPXbloRH0a6Hit1+5VVHJ+gj8FFB1P
   r+l72912V6brIGKuyvgwDisHD+ZMXCNDBMQ3BvkzGuTUespzqhKU7vSBO
   T2zT6HbNXD7DnqipjrqI3sndHjVJuPGzfGxA2WbdRgSvzcE1dHHFi5Hk9
   upVFN+alsjCV9vGKJC/dDQnqxGX2SgbzbVRWTT3k3cyq0qzRQAS6NZTZa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325643771"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="325643771"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 21:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="726193206"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="726193206"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jan 2023 21:50:38 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 21:50:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 21:50:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 21:50:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 21:50:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVebel3sITSoc2ipPbUvXbAkFZlDWG2GoCF8iVMXb0jQ2m2f3H6SIrpftUyNwACQszmurFtK+qwMzYkgFV2oNTZ476VhZ5V5bFmzvKUzRa2vCXgb0demYkt0DnDttM8vALAZvU5tnO56GGYZIlyTwuM0P73J2/FxD7IyjtkSdm3+Q8dIC608NmAxCUP7JXkLzu89PjRknGY5JyOlYpOewAAhPrxeRzQC943SPrFl3KgR/o60rRKW/Ha8W9/+QkC1kt7YwOK20uCqJrmAvFAU89rnrhZHpSIOu7pUSQ15eP029NEG3WwViUgoGwTL5yAb6X4+qbuDy9PHog9QvilUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ci2LI2dyAsBWdoy1wKHz0uNZxJGSmZorC9Yu8YLnQpg=;
 b=HOEiz/ae0wJGTMM+QAWeAvwDdmMGxU/Ue0ixv97yCGvO9On3/B0oQ4XWeAMJo6awyL0/9+fPQCpDHGY4QFrIhtOPnaOsA5k7e+Hhz4dZNLJqHBLScBYBukclhVxFZl0XJ6YPDUdOD+Omcmbf4JZtf1HVjTB0c2wzbVZShUiYlaNezix+ipCLCFdVgfPoDMZIDMS9mAHsPDiM+Da58FxvtwsxueFaUgLQ/ftLL4pXVpmLfqFilNQu2N+zK3Rqf0j86SRzPHYuRi/xU8tBz2lmCQmlIoV7plq+0bwoq+hQlhyAfuQ6F44ssweaViwFKZ/1hdDY0pUsAcS+j1dz/oi3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4092.namprd11.prod.outlook.com (2603:10b6:5:192::24)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 05:50:33 +0000
Received: from DM6PR11MB4092.namprd11.prod.outlook.com
 ([fe80::a2b4:899c:a82b:eb14]) by DM6PR11MB4092.namprd11.prod.outlook.com
 ([fe80::a2b4:899c:a82b:eb14%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 05:50:33 +0000
From:   "Sun, Yunying" <yunying.sun@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Hans de Goede" <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        =?iso-8859-1?Q?Benoit_Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 0/2] PCI: Fix extended config space regression
Thread-Topic: [PATCH 0/2] PCI: Fix extended config space regression
Thread-Index: AQHZJR3Xndf5rFZtTUi/O30oa9oeZ66aSKEg
Date:   Thu, 12 Jan 2023 05:50:32 +0000
Message-ID: <DM6PR11MB40920805703B4B8485A0450DF2FD9@DM6PR11MB4092.namprd11.prod.outlook.com>
References: <20230110180243.1590045-1-helgaas@kernel.org>
In-Reply-To: <20230110180243.1590045-1-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4092:EE_|BL3PR11MB6436:EE_
x-ms-office365-filtering-correlation-id: fd68d573-1085-4f6f-2b37-08daf460eb7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g2aPm4IOOIinuAyQTepzJD5P+UA0TuSqdZiIUWdpEFiu9EGuyNqmkq64vMmJJrMMSHDnlpEBKZRFpiRQ0X1kRznTCTzJZaZQtE9jq3y/JVED1K1IUwhMPKHZUtks7PI9K55+6niWyjXJRZtPq6p6v5l9jme1nYlRQMHS9GGv1fINEc+SfyEJl/0GAXR5CX1CbHpbGYGBIw+B9KF2U18a6nbNOmAtDEqkZSIC3KDadCDNS6yDb4i1NXn7JiQ84RJPjHePb2lbXE1Y+a3RJireEYbj6L+AiC3TktTvSFvEdqOopsTvTNv5IaGN4epc66VWvUtbZMWosZdx8Itgv18+yrkdex57uiVqi7TozKhzRa5s61ajYLdfm6EBaF6K/IkBxPVwjQFapcvHyqiXr8TG2j1gevecmtHW8gvgNWFvVgTp/aiJj0c4471f0g/USzO2RFA67i3WO/eMnQ4PfRopMv5mtDSOzglundh4Bi1jtz/kXmdyKIy80Vtupdg4pscQ7ZA+fmKjzfS26ZiGFsv9ZYKoQl7Ej6VDvyHDjy45o61W6YxSJOYXWT721iWH1LCTojGKktmtt23/orFTD7pYRhiHzefpu8xSoEMaSCOZ2avlnux/I1DHs42lfKj9NDshzESBDAgSaBBOhnvyBE7BnJD0IHsSudJ6I7lILAe1L7WeBc3dBJTwVHCVJXy9lNKBy/RGXep3k2leuF7i+Y8m5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4092.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199015)(9686003)(82960400001)(478600001)(33656002)(41300700001)(38070700005)(38100700002)(71200400001)(86362001)(316002)(110136005)(54906003)(55016003)(66556008)(66946007)(26005)(66476007)(186003)(7696005)(76116006)(64756008)(4326008)(53546011)(5660300002)(7416002)(6506007)(2906002)(83380400001)(66446008)(8676002)(52536014)(8936002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7m7i6LEVqDHRKKMDy1Dw6d0eYgDD2f0UD76SGjEoCfGk8sS8TL2M2DUo8H?=
 =?iso-8859-1?Q?94a/+gPYAGivZLU+1UG6Hgxkt30wSPeHYFa0Xtrdu/+dKx1sWDP5Fv3iwr?=
 =?iso-8859-1?Q?u7U5kaPhuOHDPbawDJgIod8ksLGqmImc/0P217itvszTUU7j2NbMplPc+8?=
 =?iso-8859-1?Q?ubv7Ds2zqga50mG3PR3CJni6XhxNWeg1KkDesGCr8g1kDoaUlTSvTekSJw?=
 =?iso-8859-1?Q?dSfmjuL3FTS69LD70lHIhNFqKbfLkBwmHO+VpC0uSLG0dTpBleFd3WUqWx?=
 =?iso-8859-1?Q?rdvprCjMCnklW75j1GZRWcx+4hjuqDQjLNn7+SlTpOW3ejcbnxbGl10pvT?=
 =?iso-8859-1?Q?UupBrf50d8NZ3xvW+z2CvnDJSKvr+7cP3fymnIzjsVBEcK6+LUlkGrDuiK?=
 =?iso-8859-1?Q?DVAlRmLv9FZemtNBuUArO4tDkOuh4/Gylhd9sdo6lE6B6xQRUaVXkwsHfT?=
 =?iso-8859-1?Q?wgEVCPC2BxA/EuHorR2m97pV3OYpQGN2jzZDHPWFwrhqK9DQ/ehgoG3vdb?=
 =?iso-8859-1?Q?rCD1NYHs/oDZBzCT8/qctaps3tdYbiFsOcaJoqjutgfaVAqm0yTNUUYeqc?=
 =?iso-8859-1?Q?eHOMvx1vNGW6ZTm0jRIVxf5iQGSFTEYtsIcvwhg6Gon3C+g6eGbI2xVnwz?=
 =?iso-8859-1?Q?lGJyPb/sB7YOVter6aXaOB4N6i9UwtcMN28Sd4lP6hsbrbuTJH6riy58MC?=
 =?iso-8859-1?Q?5aJff2by1ADT4cefXVP6R13uEt3EJvr/F8YT+X1F93mZYJEpNwKuzOnj17?=
 =?iso-8859-1?Q?LdNochwVcDryRRMIhqFJDO1q15oFKg2ITiemSTi0kqvbTb+dEGLjTsM7DI?=
 =?iso-8859-1?Q?9VZ8OZtgx4JNpSWI8e8JaC9IMRoo3P4CVo+pfcDEGELKsMmcIOysUBNmur?=
 =?iso-8859-1?Q?5INvodLU8AI5ii94A2QbL9bqnVhIG3GgfCTwt//mQG+e7Ano61+majfYRf?=
 =?iso-8859-1?Q?MnDXnDYkY/z6AknYQwPJYaaJsUkuPvaWsiljAMKSOs+K8DpQZ0plO/SubA?=
 =?iso-8859-1?Q?P1/mEcQTboBlgLERW3xPRd+Jrfn9ZrxyfhDrueNG3gSm//0bQtgoJX+e9r?=
 =?iso-8859-1?Q?H0dUyG5wJOWCy20IyQ/0eaFpTwYOKg07MneoHY8woVnImS9DvrTA76v5FW?=
 =?iso-8859-1?Q?qlKUR5HH5G9dDWh+JnSMn9ArUhtc2NW2UefPdG4mPtBPlgGLaEOqhnHSwr?=
 =?iso-8859-1?Q?dGyCkfg9CLrIrIFRmSv6PBEnd6taz8D+gm4QuOWST/h4dsO8+Y1sWubty5?=
 =?iso-8859-1?Q?ae0LsME4B8wHsWduB5IJAVuh5nBxPh5GDwF20Q/i3GjjwQ2ExNDI+TPkoB?=
 =?iso-8859-1?Q?m7YOdAO7ir9REu59CwpI9nlAlvY75pW79VUOd3hmWjjsI4B+jqI04UR55u?=
 =?iso-8859-1?Q?zO9+KTybAx4xTqm3bOLpghWdygBY2K32DBuY+3Qo2DEd46xwPDl4hBQi2Z?=
 =?iso-8859-1?Q?xvEkSLpscx+R/K3B/rjST4P8CzsuDpxy4Zl6jVfpx8yqv9bUVK8JwxOJ7m?=
 =?iso-8859-1?Q?SwM5buVwbVKrC86RN5iB5913RZT90Ra9epsRT4R6w4CVbcOmF64vUIZLCI?=
 =?iso-8859-1?Q?wBYrfEpp5epeUqhtOPR1j4y8vl6ElzS9uSOCNO4qBkZUGrDNy/ktJhyORH?=
 =?iso-8859-1?Q?ozZq5sWRAxFtL1cLEWTNCtDEM5dcIZtdbb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4092.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd68d573-1085-4f6f-2b37-08daf460eb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 05:50:33.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YK8n6Tsf3ot2w+Cv3BZmqB4zpuWvfsNVuv1mpHq5HhsS/L6Fp2sb3Y4RNDH13oGci54R5o3vBasEG0k0VAEaUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With this updated patches, perf uncore works fine on SPR(tested on both DNP=
 and MCC).

Tested-by: Yunying Sun <yunying.sun@intel.com>

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Wednesday, 11 January, 2023 02:03
To: linux-pci@vger.kernel.org
Cc: Williams, Dan J <dan.j.williams@intel.com>; Kan Liang <kan.liang@linux.=
intel.com>; Luck, Tony <tony.luck@intel.com>; Box, David E <david.e.box@int=
el.com>; Sun, Yunying <yunying.sun@intel.com>; Jiang, Dave <dave.jiang@inte=
l.com>; Mika Westerberg <mika.westerberg@linux.intel.com>; Cabiddu, Giovann=
i <giovanni.cabiddu@intel.com>; Herbert Xu <herbert@gondor.apana.org.au>; H=
ans de Goede <hdegoede@redhat.com>; Florent DELAHAYE <linuxkernelml@undead.=
fr>; Konrad J Hambrick <kjhambrick@gmail.com>; Matt Hansen <2lprbe78@duck.c=
om>; Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>; Benoit =
Gr=E9goire <benoitg@coeus.ca>; Werner Sembach <wse@tuxedocomputers.com>; mu=
mblingdrunkard@protonmail.com; linux-kernel@vger.kernel.org; Bjorn Helgaas =
<bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: Fix extended config space regression

From: Bjorn Helgaas <bhelgaas@google.com>

07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") appeared i=
n v6.2-rc1 and broke extended config space on several machines.

This broke drivers that use things in extended config space, e.g., perf, VS=
EC telemetry, EDAC, QAT, etc.

This happened because mmconfig-shared.c checks to see that ECAM space is re=
served in E820 or ACPI motherboard resources.  If it's not, it assumes ECAM=
 doesn't work.  07eab0901ede removed some E820 entries, so it looked like E=
CAM was no longer reserved, so we stopped using it.

The machines where this broke don't reserve the ECAM in ACPI PNP0C02 device=
s (which seems to be what the PCI Firmware spec requires), but they do ment=
ion it in the EFI memory map as EfiMemoryMappedIO.

Bjorn Helgaas (2):
  x86/pci: Simplify is_mmconf_reserved() messages
  x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space

 arch/x86/pci/mmconfig-shared.c | 44 +++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

--
2.25.1

