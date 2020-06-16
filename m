Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605711FAA15
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jun 2020 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgFPHj2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 03:39:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:26654 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgFPHj1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 03:39:27 -0400
IronPort-SDR: DXgfB+IFZzJxuKdatj2o+gvtb4Z9H2ajTfRkPKUpCmvjNoanlnX2TWdUsjJDTYwNHMOFcd/z64
 6tfArEMoYMdg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 00:39:26 -0700
IronPort-SDR: 1W3DdSXXjGkg7oywYsMVbHSVcOgXqVmXhvFq0jy6D6pLtB0jXv2mXoBp9typoPxOFjHhaBLIdK
 9Yqz+rNSuVww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="290972077"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 16 Jun 2020 00:39:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 00:39:25 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 16 Jun 2020 00:39:25 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 16 Jun 2020 00:39:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 16 Jun 2020 00:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLZT8Mx6Mh8i6ce1yBAtqfBGPFz2aKtet2yy7oFOmgaghh4JQ+hTCA4R3dZKU3RUZ8+JB86epl9GTcMKVcEgLTdsczsA3iDRXUupWzj13Vy8fcC05DQ7w1YunpLUaduJrFIgy1j2mA5od8/RF3547yUSokq1SstssMoy1Pr/sl58uANN0SSvvoV2BGPqHn0VWyC88rBc5NrJFI2dAorz8kHGqkP1Qa1c5/uEArPaDsmdwlvd1B3Ww0e1eWfoIMRzoJ4cYPTeB8hFqBVqqP0DemrxyVYU9JtGuNfo+Pl4NvBgnh78AFOqLXalVb2M3Giml61djM4QbC+YCelvn7Lv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rgpvhih8QbUbr27RKCPRxM2rgkgcohDSo2AFClAT+Og=;
 b=C46DASjxzv1S55volNEAuMfwtrwLbmBHC3FxamFOQX3qy3CuSZd1oOMbYDivQ/rROkTTuMkjhVgVaUzDOJPvTe7xnddUFg7rFpcF/cm3ToKUObfo99Smu9u0NgnUR6d0fCoWN07ntG/+fRpOrxa502nn1gtCGNkM3oB7042GbszBShVueqKzxiPBldX3LG2ar/SjtuMDAnuW+0dqqTBpxDXkjc7HSdH5hGbu2DWxh9or/x/29GQkmKryezi2TgvU4V4v0tzfoJyKL/5STzydIKt/Wt4Od3pPbWXYUWukFvwajP3UsPnYZ6130gbFSzHiVNsjQPueVg+fQ/LkV157oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rgpvhih8QbUbr27RKCPRxM2rgkgcohDSo2AFClAT+Og=;
 b=nEywYiLUUGgl4xAng+/U8H+d0yYz8fJPWYQAANV/1Cd29zhSEher7RHLt6ker9MGyXbMaYJcqcVE8KoieMly3DC2+e/g2PmWt843M4LepyGUYBbwUIXMfrowBqnomsV4PB/clZDA1e8W/0GNQpLRADRfCTo2pcrtzel+aoGlRNc=
Received: from CY4PR11MB1528.namprd11.prod.outlook.com (2603:10b6:910:d::12)
 by CY4PR1101MB2102.namprd11.prod.outlook.com (2603:10b6:910:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 07:39:16 +0000
Received: from CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd]) by CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd%11]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 07:39:16 +0000
From:   "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Denis Efremov <efremov@linux.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 02/15] PCI: Add macro for message signalled interrupt
 types
Thread-Topic: [PATCH v3 02/15] PCI: Add macro for message signalled interrupt
 types
Thread-Index: AQHWPnpIrTQay+BuJECokccS7LHzDqjRbuwAgAl1o8A=
Date:   Tue, 16 Jun 2020 07:39:15 +0000
Deferred-Delivery: Tue, 16 Jun 2020 07:38:26 +0000
Message-ID: <CY4PR11MB152819DC4268232B2FBA8768F99D0@CY4PR11MB1528.namprd11.prod.outlook.com>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609162243.9102-1-piotr.stankiewicz@intel.com>
 <20200610070828.GA29678@infradead.org>
In-Reply-To: <20200610070828.GA29678@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTc3MWZlYzMtZTBiMC00YjA0LWEyOGMtYWNjMGUyZjgxNTEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidlIrUmdIWEwzamJUZVgwNmJ6Z1BHMTVMYXYyMmdwZEM0S3M5WGZuVlA2RzhRTVhZR09CWUFmclBEZWhQTlwvVWkifQ==
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.221.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53127a9a-aa98-408e-2669-08d811c85f4f
x-ms-traffictypediagnostic: CY4PR1101MB2102:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2102D20A503AF56D25566989F99D0@CY4PR1101MB2102.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQwBYhlfwcJVh++IH8f8ZpW2r3IBMrtX850iJD4aE5YCWAnxn7BjyK6upJLv3hgdlbtQya89VaRQC9Ezp/rvq3v7rLIKn9gh75fyfuqaMvQQjemLWPV1swMBmWvqqyfG+Cie0TRO2aQYGuQ9uEPIBG5cFq47d5CnpinMou1tFL2CcfIqm/9GEKvF69igYt2NnvPBhGNsQpsiMledva25w2hB2udSztqA0ybA5bHR+Hv6Slve5bmJNHeOKsy2pWzLZ5dwv/mcxLazNP5ABX1i6chdnylWkQZm79pqaArE0OJ44JTI8WuYdYuv8gOSWrACTUi1fxDFd6fT0Tsjz4A4MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(396003)(366004)(39860400002)(66476007)(76116006)(66446008)(66946007)(66556008)(64756008)(86362001)(15650500001)(6506007)(4744005)(7696005)(2906002)(186003)(54906003)(5660300002)(52536014)(55016002)(26005)(478600001)(9686003)(6916009)(8936002)(83380400001)(7416002)(71200400001)(8676002)(4326008)(316002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AEJB3Y30sZ0QJcyuu21wIvulz/Czkh+DjZ2fF2Batq7CRxjlnRk6k59mmTTyR+itVhSmv3wDhupuXkdon3/gHFwU3RX9gtsFHsyBG+1EXi/Hi3NC7Ci5UyGnGA/EuKHW0fC35krQmFdgr2G/fJK5u346CbNYAUQ62dAQj5+M7YbiSBts2Hl4omgb0x1M2LkVsgAOE8h6cj//z47QtJs3zrFyk/rhiD0f+x/0+kEM+218w11XlLnblMWeTfQ7MYFtqvPwTwspI5phptmR9DH70vxvkbo8tXSq4zHgVt1ZqAYa3uy8MaeF9UqjwDRmoqE4ueFKcvcSZ+evEZ9Y5bYu8N7tMN1P10WaBFU7eceOaiYRSfO7c3wxS1M6NyI1bUXKSJU7DpjSB5nEeuI12cBTpD+cNwPLYmxMtVBE33o3rksT1ftTh/5f28wRSZSxXZIUv3vnVfwNLZoVMrHNIEknPr/wpMpBp00MnrKocXlZ86dMkdkDIT3JSaUgU/jbMaVG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53127a9a-aa98-408e-2669-08d811c85f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 07:39:16.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ghGgbeeDONQGgAfEEUePPbTS0Gcz74kfFjY+k4nMyv7ZUWoScXMdG5ESO9Qdwsi8RB65hyGes4R3NxnS2oVF1Ywp5pu/vRBIVevBy0UCXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2102
X-OriginatorOrg: intel.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Wednesday, June 10, 2020 9:08 AM
>=20
> On Tue, Jun 09, 2020 at 06:22:40PM +0200, Piotr Stankiewicz wrote:
> > There are several places in the kernel which check/ask for MSI or
> > MSI-X interrupts. It would make sense to have a macro which defines
> > all types of message signalled interrupts, to use in such situations.
> > Add PCI_IRQ_MSI_TYPES, for this purpose.
>=20
> To state my objection voices in patch 3 here again:
>=20
> I think this is a very bad idea.  Everyone knows what MSI and MSI-X mean =
and
> that directly maps to specification.  The new IMS interrupt scheme from t=
he Intel
> SIOV spec for example is a message signalled interrupt type as well and s=
hould
> not be picked up automatically.
>=20
> If we want to change anything in this area we should probably remove
> PCI_IRQ_ALL_TYPES instead..

Thanks, I've resent only the first patch as v4 of the chain, and dropped th=
e rest.
