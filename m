Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F032CB44F
	for <lists+linux-pci@lfdr.de>; Wed,  2 Dec 2020 06:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgLBFWx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Dec 2020 00:22:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:16203 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLBFWx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Dec 2020 00:22:53 -0500
IronPort-SDR: 71g2VhOWdKxOLVWEzuAqS2COeXevpWAbzWJUVU1sgyuOKyYcaGOILee+TOJgy9BGGtnlM8lpZH
 icI8VDL/Hu1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="173115011"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="173115011"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 21:22:02 -0800
IronPort-SDR: XMVBev2PZwUl8yfwZO0REj2+XoMYS4GyyauvKnGusEB8MXMNtvbcncAINz6WQc4/6lHDbJOKon
 rWBhIdlzXumA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="367867923"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2020 21:22:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Dec 2020 21:22:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 1 Dec 2020 21:22:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 1 Dec 2020 21:22:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Thg+PvAWV6Rfxhl7lNpiA/Elri7/yDSTyVPPfeGV5XTOXX/Z/rDw65bmg/h2aUL6e+IOqfIL9nLa3UEXs1mfQVG8Ev024As4YdLMh0J1iVdyYTBdLin/ZHQL4iOcuD9YwyqqM8hL8a4yBolbRz0ClUoted8WOfDtS7zp/DhKZILTDao68POBOUjWI7Odqg6HFI1RLuBzGAMKAFyk0cLm1DpGjqWfZeemiQ764ep1cC/oTxrWQYc8hKkuDpRFU0iK4b73KC2NFTfHNBhDp/dhmozxh60f71OUbr2H8xX3W4XvBIvlRFOLNgrllkLsk9ikVtmHtL9saupAxq9exO1PHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiICI7828dziubYl8u7BStRMGwVdEqIaYdRmPTe262k=;
 b=IxtI4J0NSP49blhGhNf780lzrI+DY5UyEfH4mGu1W45sH4ybT28yKEszzKoEGsyOfv5KyEerWUju4IWbPrqdVpkRLOUKJaKtzMDsqhSZX5dffvjBTSTpCcFtNt1BXTfBlE4X6rNG1MPVxniflew3wMjYOTktgqtWzcExswM6oTDrdjTV+ear5S9DHmPTciNZbR4vXYcnkFFckQ1rqK9vJq3pX28KMgtSBcl5cwNu4oEPBA7HV202ASjiS+ytMbifXnnWk3sZ9GJiVpjT+KGMJnFWsaQsWcuUHKZhRUts2dvRaIZLpxZY0ycMtweRFZvnSYAjDZUxBTN5ALvZILRVdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiICI7828dziubYl8u7BStRMGwVdEqIaYdRmPTe262k=;
 b=KPP4By1ZgRklSOCDvQ+L8kROhtWn2uMAvES5rO1B3iLPjp6zWYn8j2tm/n/qpuyjBUurVmN7y6JLt0ETHuWXuqXo8+qv1EM/DfcNkNvuOjzGy780khfd4OknIWofP7gh8nVD7J+xfYuYRuCPHjasfpgn9pYIeafo1vw8fXdLWDQ=
Received: from SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27)
 by SN6PR11MB2878.namprd11.prod.outlook.com (2603:10b6:805:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 05:21:58 +0000
Received: from SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::a975:345b:8dcc:50ff]) by SN6PR11MB3421.namprd11.prod.outlook.com
 ([fe80::a975:345b:8dcc:50ff%6]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 05:21:58 +0000
From:   "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Jesse Barnes <jsbarnes@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Pandey, Hariom" <hariom.pandey@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Subject: RE: [PATCH] x86/gpu: add JSL stolen memory support
Thread-Topic: [PATCH] x86/gpu: add JSL stolen memory support
Thread-Index: AQHWstDzxN2Pwg+4lUqs/o8gwa6wpqm5S1QAgABL34CAAUSNAIATRwMAgABjNQCAABWMgIAArfUAgACitgCAAC1YAIAQi95ggABnAACAAmNxkA==
Date:   Wed, 2 Dec 2020 05:21:58 +0000
Message-ID: <SN6PR11MB3421F97AA179145AA86369B6DFF30@SN6PR11MB3421.namprd11.prod.outlook.com>
References: <SN6PR11MB34217B7C62F1587D417F8608DFF50@SN6PR11MB3421.namprd11.prod.outlook.com>
 <20201130165114.GA1086333@bjorn-Precision-5520>
In-Reply-To: <20201130165114.GA1086333@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.7.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d069b356-135c-4263-dbaf-08d896823103
x-ms-traffictypediagnostic: SN6PR11MB2878:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB28789A3F851F20B40A54724BDFF30@SN6PR11MB2878.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQrMwbTnVN9JPNXewQWdEOUVfPh8ChnKl5A0kx69HPB+WIP1gYfFFkiUGRDlnxh68x8399vuu/KjQNcSSfm6223Eq6FoEXKNOQA9MbVt0j24vYvPOgtkkjYC6gkGhRWDqNy+zj2KDFbQCfc0VBO2QdcxdBiIU9E2ZzVcSGdvWF5IAGrt9Ea/rDrdYFWuK2L3WPcwmxJjDXXjXkuUDciFl1d30PWo7ioUwKT04Cm8Fll+nTCgsd87AwAiAcx8UEqfIY1fwxQtKnuQ/vjmHSXv4fyOIU0vSYm/Fk7uv78XC4kyMwnJYyxf112eEsEyjgUgD9u8WvRzzTxT1gYvjMCVo0R9+4OtZ7Ja0XVojdbRI5/0TFnricZlZ1pMbMNWmBMAovbx9YiW69vjoSfEY7NZ5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3421.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(6916009)(83380400001)(7416002)(71200400001)(7696005)(316002)(6506007)(186003)(26005)(52536014)(5660300002)(30864003)(55016002)(966005)(9686003)(76116006)(53546011)(66476007)(54906003)(8676002)(8936002)(4326008)(66556008)(2906002)(64756008)(66446008)(478600001)(33656002)(86362001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B0RkaWxK/NGdCDEBVfu3TqhyzNxB+VR+6viWOcL7h1cCbE7g9PqE0Gc02p7V?=
 =?us-ascii?Q?kEpNAS/HHW0frEkyiv8dg8q0K1Ml3H0qLlILyW97h3E3M9axUK4oBzoi3Q/P?=
 =?us-ascii?Q?X2V2AUOPfDn5ZDt6EDidzX9asHAjAC2aohFsw5tne3rHgbTTT/RBVPHHXNsp?=
 =?us-ascii?Q?RcXKXvNtIxfkQorEImY6N628n/m03r3iBDPpIzrjMuWzeszOsrmItXOlmZf2?=
 =?us-ascii?Q?Obw2Ba520iIqOhmvVdK6k/pz3/yPeM5h0TFgNy/9i13+dkrTfpisLLJZa9Un?=
 =?us-ascii?Q?4iXmeLrRN6O6Vek0qxrNhNdLlyH0sNrTN7uqcJegD6U6vYBIwJVz6cMs1pvl?=
 =?us-ascii?Q?AkewbYTw6QVQXDMrX4OxI85TqFIP9hqjUWEG5YiJwIbU26Z5pQviMFTpKz7V?=
 =?us-ascii?Q?Yz3Er/smZlrQMYme9Q4+YVzb4+8RYeuVTtmRHi8zkPGHD5iVsKGbPbJ4c1DB?=
 =?us-ascii?Q?btvTVJ9O9wJRetlWQ7hlSMdP9c745XYlUagh8gexmxVlWcbUL94YkDU80BGh?=
 =?us-ascii?Q?E1Xj/kiX7lT868D/j3YGUXJq8/Z6ts7ScZ1ZPLGfRmVb2zzeTiQo2MCURYBt?=
 =?us-ascii?Q?t4NaDF/AghSNFCpo2ab8EsI7RxLlYwL2l6GIFi2wH++P24CBG6FdPvQen0fP?=
 =?us-ascii?Q?DmZS6KbDeeIqHFzr5AJHCqd8qi0EPoxtp0XElfwABoIfmUDS7/9oqzXHXeNA?=
 =?us-ascii?Q?+GGFZupjzNlqRnAE46D390BqGYJ+6w1XhpoxZGaZnXMFOK1v0dxd2M3/a5ul?=
 =?us-ascii?Q?G7PC3WiPUfeV9XgCPO9uKaZbNIppno+vPhTBoQvK+I6QTTnZMkq4EVS8PUPN?=
 =?us-ascii?Q?Npa9pul/H7HJN8qglEnAL6b4GZ2Wo+R+THELFhNE3/7zrXSuDY9doVBsQnlA?=
 =?us-ascii?Q?hzlMMt1I4zvlGrQIv2cC2KHgmhCBgLnjtozum7A0SF3spCF5ukxI96D6A68w?=
 =?us-ascii?Q?4jNma4uWt/gHHn5K0+79SmKtd82dKSAtgBpp7u9yPI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d069b356-135c-4263-dbaf-08d896823103
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 05:21:58.3427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SfR2LMDMRJnE+q07DnbbcndKjtokQW+8bK8xMwiihchnTIRowEab+pH+ys0udiKNuSdc//KmGB/ec2TnvK6r0/8nfWq0i3usTuR8lviRRpCxxUSii7pAgFxV/bzUG5QUaHvgluVjndNZmLVPkKaqMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2878
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yes it fails all the tests which are allocating from this stolen memory bun=
ch. For example IGT tests like " igt@kms_frontbuffer_tracking@-[fbc|fbcpsr]=
.* | igt@kms_fbcon_fbt@fbc.* " are failing as they totally depend to work o=
n stolen memory.

Thanks,
Tejas

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: 30 November 2020 22:21
> To: Surendrakumar Upadhyay, TejaskumarX
> <tejaskumarx.surendrakumar.upadhyay@intel.com>
> Cc: Jesse Barnes <jsbarnes@google.com>; Daniel Vetter <daniel@ffwll.ch>;
> Joonas Lahtinen <joonas.lahtinen@linux.intel.com>; Linux PCI <linux-
> pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> <hariom.pandey@intel.com>; Jani Nikula <jani.nikula@linux.intel.com>; Viv=
i,
> Rodrigo <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
>=20
> On Mon, Nov 30, 2020 at 10:44:14AM +0000, Surendrakumar Upadhyay,
> TejaskumarX wrote:
> > Hi All,
> >
> > Are we merging this patch in?
>=20
> Does it fix something?  If something is broken without this patch, can we
> collect information about exactly what is broken and how it fails?
>=20
> But I don't object if somebody else wants to apply this.
>=20
> > > -----Original Message-----
> > > From: Jesse Barnes <jsbarnes@google.com>
> > > Sent: 20 November 2020 03:32
> > > To: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>; Joonas Lahtinen
> > > <joonas.lahtinen@linux.intel.com>; Surendrakumar Upadhyay,
> > > TejaskumarX <tejaskumarx.surendrakumar.upadhyay@intel.com>; Linux
> > > PCI <linux- pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> > > <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> > > Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> > > <hariom.pandey@intel.com>; Jani Nikula
> > > <jani.nikula@linux.intel.com>; Vivi, Rodrigo
> > > <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> > > Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
> > >
> > > On Thu, Nov 19, 2020 at 11:19 AM Bjorn Helgaas <helgaas@kernel.org>
> > > wrote:
> > > >
> > > > [+cc Jesse]
> > > >
> > > > On Thu, Nov 19, 2020 at 10:37:10AM +0100, Daniel Vetter wrote:
> > > > > On Thu, Nov 19, 2020 at 12:14 AM Bjorn Helgaas
> > > > > <helgaas@kernel.org>
> > > wrote:
> > > > > > On Wed, Nov 18, 2020 at 10:57:26PM +0100, Daniel Vetter wrote:
> > > > > > > On Wed, Nov 18, 2020 at 5:02 PM Bjorn Helgaas
> > > <helgaas@kernel.org> wrote:
> > > > > > > > On Fri, Nov 06, 2020 at 10:39:16AM +0100, Daniel Vetter wro=
te:
> > > > > > > > > On Thu, Nov 5, 2020 at 3:17 PM Bjorn Helgaas
> > > <helgaas@kernel.org> wrote:
> > > > > > > > > > On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas
> > > > > > > > > > Lahtinen
> > > wrote:
> > > > > > > > > > > Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> > > > > > > > > > > > [+cc Jani, Joonas, Rodrigo, David, Daniel]
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas
> > > > > > > > > > > > Upadhyay
> > > wrote:
> > > > > > > > > > > > > JSL re-uses the same stolen memory as ICL and EHL=
.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > > > > > > > > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > > > > > > > > > > > Signed-off-by: Tejas Upadhyay
> > > > > > > > > > > > > <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > > > > > > > > > > >
> > > > > > > > > > > > I don't plan to do anything with this since
> > > > > > > > > > > > previous similar patches have gone through some
> > > > > > > > > > > > other tree, so this is
> > > just kibitzing.
> > > > > > > > > > > >
> > > > > > > > > > > > But the fact that we have this long list of Intel
> > > > > > > > > > > > devices [1] that constantly needs updates [2] is a
> > > > > > > > > > > > hint that
> > > something is wrong.
> > > > > > > > > > >
> > > > > > > > > > > We add an entry for every new integrated graphics
> > > > > > > > > > > platform. Once the platform is added, there have not
> > > > > > > > > > > been
> > > changes lately.
> > > > > > > > > > >
> > > > > > > > > > > > IIUC the general idea is that we need to discover
> > > > > > > > > > > > Intel gfx memory by looking at device-dependent
> > > > > > > > > > > > config
> > > space and add it to the E820 map.
> > > > > > > > > > > > Apparently the quirks discover this via PCI config
> > > > > > > > > > > > registers like I830_ESMRAMC, I845_ESMRAMC, etc,
> > > > > > > > > > > > and tell the driver about it via the global
> > > "intel_graphics_stolen_res"?
> > > > > > > > > > >
> > > > > > > > > > > We discover what is called the graphics data stolen
> > > > > > > > > > > memory. It is regular system memory range that is
> > > > > > > > > > > not CPU accessible. It is accessible by the integrate=
d
> graphics only.
> > > > > > > > > > >
> > > > > > > > > > > See:
> > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torv
> > > > > > > > > > > alds
> > > > > > > > > > > /linux.git/commit/arch/x86/kernel/early-quirks.c?h=3D=
v
> > > > > > > > > > > 5.10
> > > > > > > > > > > -rc2&id=3D814c5f1f52a4beb3710317022acd6ad34fc0b6b9
> > > > > > > > > > >
> > > > > > > > > > > > That's not the way this should work.  There should
> > > > > > > > > > > > some generic, non device-dependent PCI or ACPI
> > > > > > > > > > > > method to discover the memory used, or at least
> > > > > > > > > > > > some way to do it in
> > > the driver instead of early arch code.
> > > > > > > > > > >
> > > > > > > > > > > It's used by the early BIOS/UEFI code to set up
> > > > > > > > > > > initial
> > > framebuffer.
> > > > > > > > > > > Even if i915 driver is never loaded, the memory
> > > > > > > > > > > ranges still need to be fixed. They source of the
> > > > > > > > > > > problem is that the OEM BIOS which are not under our
> > > > > > > > > > > control get the
> > > programming wrong.
> > > > > > > > > > >
> > > > > > > > > > > We used to detect the memory region size again at
> > > > > > > > > > > i915 initialization but wanted to eliminate the code
> > > > > > > > > > > duplication and resulting subtle bugs that caused.
> > > > > > > > > > > Conclusion back then was that storing the struct
> > > > > > > > > > > resource in
> > > memory is the best trade-off.
> > > > > > > > > > >
> > > > > > > > > > > > How is this *supposed* to work?  Is there
> > > > > > > > > > > > something we can do in E820 or other resource
> > > > > > > > > > > > management that would
> > > make this easier?
> > > > > > > > > > >
> > > > > > > > > > > The code was added around Haswell (HSW) device
> > > > > > > > > > > generation to mitigate bugs in BIOS. It is
> > > > > > > > > > > traditionally hard to get all OEMs to fix their BIOS
> > > > > > > > > > > when things work for Windows. It's only later years
> > > > > > > > > > > when some laptop models
> > > are intended to be sold with Linux.
> > > > > > > > > > >
> > > > > > > > > > > The alternative would be to get all the OEM to fix
> > > > > > > > > > > their BIOS for Linux, but that is not very realistic
> > > > > > > > > > > given past experiences. So it seems a better choice
> > > > > > > > > > > to to add new line per platform generation to make
> > > > > > > > > > > sure the users can
> > > boot to Linux.
> > > > > > > > > >
> > > > > > > > > > How does Windows do this?  Do they have to add similar
> > > > > > > > > > code for each new platform?
> > > > > > > > >
> > > > > > > > > Windows is chicken and doesn't move any mmio bar around
> > > > > > > > > on its
> > > own.
> > > > > > > > > Except if the bios explicitly told it somehow (e.g. for
> > > > > > > > > the 64bit bar stuff amd recently announced for windows,
> > > > > > > > > that linux supports since years by moving the bar). So
> > > > > > > > > except if you want to preemptively disable the pci code
> > > > > > > > > that does this anytime there's an intel gpu, this is what=
 we
> have to do.
> > > > > > > >
> > > > > > > > I think Windows *does* move BARs (they use the more
> > > > > > > > generic terminology of "rebalancing PNP resources") in
> > > > > > > > some cases [3,4].  Of course, I'm pretty sure Windows will
> > > > > > > > only assign PCI resources inside the windows advertised in
> > > > > > > > the host bridge
> > > _CRS.
> > > > > > > >
> > > > > > > > Linux *used* to ignore that host bridge _CRS and could set
> > > > > > > > BARs to addresses that appeared available but were in fact
> > > > > > > > used by the platform somehow.  But Linux has been paying
> > > > > > > > attention to host bridge _CRS for a long time now, so it
> > > > > > > > should also only assign resources inside those windows.
> > > > > > >
> > > > > > > If this behaviour is newer than the addition of these quirks
> > > > > > > then yeah they're probably not needed anymore, and we can
> > > > > > > move all this back into the driver. Do you have the commit
> > > > > > > when pci core started observing _CRS on the host bridge?
> > > > > >
> > > > > > I think the most relevant commit is this:
> > > > > >
> > > > > >   2010-02-23 7bc5e3f2be32 ("x86/PCI: use host bridge _CRS info
> > > > > > by default on 2008 and newer machines")
> > > > > >
> > > > > > but the earliest quirk I found is over three years later:
> > > > > >
> > > > > >   2013-07-26 814c5f1f52a4 ("x86: add early quirk for reserving
> > > > > > Intel graphics stolen memory v5")
> > > > > >
> > > > > > So there must be something else going on.  814c5f1f52a4
> > > > > > mentions a couple bug reports.  The dmesg from 66726 [5] shows
> > > > > > that we *are* observing the host bridge _CRS, but Linux just
> > > > > > used the BIOS configuration without changing anything:
> > > > > >
> > > > > >   BIOS-e820: [mem 0x000000007f49_f000-0x000000007f5f_ffff]
> usable
> > > > > >   BIOS-e820: [mem 0x00000000fec0_0000-0x00000000fec0_0fff]
> > > reserved
> > > > > >   PCI: Using host bridge windows from ACPI; if necessary, use
> > > "pci=3Dnocrs" and report a bug
> > > > > >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > > > > >   pci_bus 0000:00: root bus resource [mem 0x7f70_0000-0xffff_ff=
ff]
> > > > > >   pci 0000:00:1c.0: PCI bridge to [bus 01]
> > > > > >   pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> > > > > >   pci 0000:00:1c.0:   bridge window [mem 0xfe90_0000-0xfe9f_fff=
f]
> > > > > >   pci 0000:00:1c.0:   bridge window [mem 0x7f70_0000-0x7f8f_fff=
f
> 64bit
> > > pref]
> > > > > >   pci 0000:01:00.0: [1814:3090] type 00 class 0x028000
> > > > > >   pci 0000:01:00.0: reg 10: [mem 0xfe90_0000-0xfe90_ffff]
> > > > > >   [drm:i915_stolen_to_physical] *ERROR* conflict detected with
> > > > > > stolen region: [0x7f80_0000 - 0x8000_0000]
> > > > > >
> > > > > > So the BIOS programmed the 00:1c.0 bridge prefetchable window
> > > > > > to [mem 0x7f70_0000-0x7f8f_ffff], and i915 thinks that's a conf=
lict.
> > > > > >
> > > > > > On this system, there are no PCI BARs in that range.  01:00.0
> > > > > > looks like a Ralink RT3090 Wireless 802.11n device that only
> > > > > > has a non-prefetchable BAR at [mem 0xfe90_0000-0xfe90_ffff].
> > > > > >
> > > > > > I don't know the details of the conflict.  IIUC, Joonas said
> > > > > > the stolen memory is accessible only by the integrated
> > > > > > graphics, not by the CPU.  The bridge window is CPU
> > > > > > accessible, of course, and the [mem 0x7f70_0000-0x7f8f_ffff]
> > > > > > range contains the addresses the CPU uses for programmed I/O to
> BARs below the bridge.
> > > > > >
> > > > > > The graphics accesses sound like they would be DMA in the
> > > > > > *bus* address space, which is frequently, but not always,
> > > > > > identical to the CPU address space.
> > > > >
> > > > > So apparently on some platforms the conflict is harmless because
> > > > > the BIOS puts BARs and stuff over it from boot-up, and things wor=
k:
> > > > > 0b6d24c01932 ("drm/i915: Don't complain about stolen conflicts
> > > > > on
> > > > > gen3") But we also had conflict reports on other machines.
> > > >
> > > > The bug reports mentioned in 814c5f1f52a4 ("x86: add early quirk
> > > > for reserving Intel graphics stolen memory v5") and 0b6d24c01932
> > > > ("drm/i915: Don't complain about stolen conflicts on gen3") seem
> > > > to be basically complaints about the *message*, not anything
> > > > that's actually broken.
> > > >
> > > > Jesse's comment [6]:
> > > >
> > > >   Given the decode priority on our GMCHs, it's fine if the regions
> > > >   overlap.  However it doesn't look like there's a nice way to dete=
ct
> > > >   it.  In this case, part of the range occupied by the stolen space=
 is
> > > >   simply "reserved" per the E820, but the rest of it is under the b=
us
> > > >   0 range (which kind of makes sense too).
> > > >
> > > > sounds relevant but I don't know enough to interpret it.  I added
> > > > Jesse in case he wants to comment.
> > > >
> > > > > GPU does all its access with CPU address space (after the iommu,
> > > > > which is entirely integrated). So I'm not sure whether we've
> > > > > seen something go boom or whether reserving that resource was
> > > > > just precaution in
> > > > > eaba1b8f3379 ("drm/i915: Verify that our stolen memory doesn't
> > > > > conflict"), it's all a bit way back in history.
> > > > >
> > > > > So really not sure what to do here or what the risks are.
> > > >
> > > > I'm not either.  Seems like we're not really converging on
> > > > anything useful we can do at this point.  The only thing I can
> > > > think of would be to collect data about actual failures (not just w=
arning
> messages).
> > > > That might lead to something we could improve in the future.
> > >
> > > I don't have any brilliant ideas here unfortunately.  Maybe it's
> > > worth talking to some of the Windows folks internally to see how
> > > these ranges are handled these days and matching it?  Historically
> > > this has been an area fraught with danger because getting things
> > > wrong can lead to corruption of various kinds or boot hangs.
> > >
> > > Jesse
