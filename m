Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C822B71CA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 23:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgKQWrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 17:47:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:24456 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbgKQWrG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 17:47:06 -0500
IronPort-SDR: V2myQ3ufzBVHp3VbHOO4pXi5L+PBFHmZYkwIEh1owTwm9vKmqY56KRMIWP3v55S6kutgWVi7+3
 Oa366kYUIL2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="167516930"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="167516930"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:47:06 -0800
IronPort-SDR: my3ynRfTf4bHA5W/A0odRFCXdHv5sQwGHpVuLd5GqJH8ZNk3REhmPo+XxWOhdZEJ0IAYiohjLX
 Aq/xV3TbN/1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="359082179"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 17 Nov 2020 14:47:05 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 14:47:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 14:47:05 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 14:47:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfYZJQU3Wl5z4ptMWQSgQlrAH9yMu1V2JfRl/Zscki86syhCSRw601nLYz2rKhfmxG2xnEpmey2eLwXAYZGtztlMGj0zHjf0gEcT9+P6IRcxuS+UKvaeSGkazT8HONEFfR4L/u5oM6b4Lg+05s6xRfKdjjQyaL+9nCLfUV04STpGqIwnEsIjQH7mMDpdnzH//M+Z/cLC0DxVeHkjk7F34qD0/Qzg+wf9FyvDh99JogM8yK9lk/FVrh8eFDLs+WUGRBDLCitCVucSAPFSdYXI6FHQJX+lJcpi8/bcnJmPcvna9IOmerMID019ad/xbSeT36ZUO/exxBtLUiddCk/3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOeKwV9drHANwJAIHU5sSxsbiGATg5+qAyO/KYDrbV8=;
 b=PTECmMCgOMryZLBr/pRmj6m/UPiVA9fNXQ97kcJ5ok5WLQn4m2HBEDFQik+02FKg6BJTC1xzLUjvjEbMqbnI4z1hKwyfysa+49d1pdvubEnyy9zOFGEPNg+Cx3wqBSJgOHP07cCTA/vpZKwh80gjADkJzqS9dqEx8tn3fgNMqL+ATEfRiFttCHOLABDeav2QX06+VioE8STA+gK9/3G0TH++jOYs/1MKiUxy08w+HAELOU1juLET8cw0TJhq86D9UJSHz87VXw+34QMX87F8Q1FgSiJiEqsetBAL+DhAcUV9rD50Y++HDksFpRD8AA8+o8R7MpOcwxAJjBJnLrZxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOeKwV9drHANwJAIHU5sSxsbiGATg5+qAyO/KYDrbV8=;
 b=R0E2WIXKWG5YNh6HYueU01KVc3Vw1CFrAxP5g7bSJ8jPEDtCJd/gUHwi2BE5FYo56rjZiQCel9yMi2MC8sQyeU8zFG1mr5fC6YigYmcuPGLnhL7vQxNmtcBEXA6w68akLY4synEr1XbQRp6jC2ZdObDktPHPnIqFi7k50vwwD8g=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:50::16) by BN7PR11MB2724.namprd11.prod.outlook.com
 (2603:10b6:406:b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 17 Nov
 2020 22:47:02 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51%11]) with mapi id 15.20.3564.028; Tue, 17 Nov
 2020 22:47:02 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 07/16] PCI/ERR: Simplify by computing pci_pcie_type()
 once
Thread-Topic: [PATCH v11 07/16] PCI/ERR: Simplify by computing pci_pcie_type()
 once
Thread-Index: AQHWvRbDaedorbFGU06+Qr5o2NHrFanM32gAgAANioA=
Date:   Tue, 17 Nov 2020 22:47:02 +0000
Message-ID: <51D2E6DA-FFD1-4BF8-832E-0D18D79D965D@intel.com>
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-8-sean.v.kelley@intel.com>
 <248d4a59-fa56-60cc-edb1-e3871431664d@linux.intel.com>
In-Reply-To: <248d4a59-fa56-60cc-edb1-e3871431664d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.20.0.2.21)
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a48c6e2-51d4-4350-8313-08d88b4ab35f
x-ms-traffictypediagnostic: BN7PR11MB2724:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2724A1C213D2AD8BF763115DB2E20@BN7PR11MB2724.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DPIiPC7VCmo8d9N4M7GT08F4h82DAjQQEFsPa8QOYYQ28broR2R45YLgtXu/QLvT9qbQtICVYeiaDkFOElxeDjnic24CBy84938HHREf4tO8itqL1eqFRCaNwHHb1nzdObvChSmOjTGtpEoT6uJETv6Cqme+vSGXJvVDRE1kKBI7ua6G1gXRwoMiNQf4lGD+Nckrd/O7WGuoJHaQrqeeURqAb0KI250al6l/4IXsiEbCYwyVIUwaHChro6tkqjlipS8TRsPsBnV2NdF99zgWyC2tTJQ+hz3MxncZnf2t7urj9LzOmnyHC2e07Kz70UtsfZmcwZB8UcTrVGUfnMIbbSfQNxp0hSqtsfiYVZwPkTujpsQfmrdEK/V64e2WtWXLEikL+Yj2d48darD16YjCBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(2616005)(478600001)(8676002)(33656002)(8936002)(5660300002)(91956017)(6512007)(2906002)(4326008)(6486002)(26005)(316002)(83380400001)(76116006)(186003)(71200400001)(54906003)(966005)(86362001)(64756008)(6506007)(66556008)(66446008)(36756003)(66946007)(53546011)(6916009)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OxEHSTwVnOaYrMaUH29kJwzvy/kHxlfFA6FKmx780NGtNawPzT/dbuZrJ7tsfJYK8A8Uxb4hHYB8h0vomg9w3hrgdrgVC+5YT70iLjiXB1lgSqi9cdQQ567IkUmN5jro0ZeKOtLQQTI23k76fo5MEfPw2g8V8FCvKXm6dhdiCq0tKxRsy/Lcq7Fiz0XL9lEElaluIXkYQMMVxW+C3xEDAmH5WGqBuDAGpAGyOPp7GiwP/cIx1NeHd13c/FpqJjyaFNEpHuR7ELStEswgOzTdSewhlqJtcycHTu9UPjy04ZRjBY1WWXjZWGMLZhjyQzz4BVa8mFdvBBJf20GVjXOiwKWIusC/swE6yTh+d0DNMZo39p1XRVe5d7QPlpegVoW3WeG7f5t1Gzc7gy9iKeuXl8VLdoFkAc/Yx/LtguBEuhzV60EqnYAmUacqLt6l3AUFswjms5dF5gGur3ETPc28yryGHMVkmq3r/N5S534wPGf2o6yKLg0TU6UucacRPZ91hcre+n4UUy5XrPJkIoNxEadrUiRX0j6vum6S1dkzHNsJte6lUZC5ROYEr8eenMaEdyFBdCUNBBc11Trl6B5x0jE+D1iu1ejb+AZEzVQQLeH7+5+D+0wS4U9RpN7rFSBggrBPyV05vFWPsbunxjYR8Q==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F0B78E33DAA6D94483F0ADF95CD75CC0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a48c6e2-51d4-4350-8313-08d88b4ab35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 22:47:02.4047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNhlBcCPvjt6o8h7foXkwvG8kol7NT36LXsPQpaIP75SjFigqbXYLzvyuIEUEq/avxXNgOQ+jQM6Cxe/Iy6VwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2724
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sathya,

> On Nov 17, 2020, at 1:58 PM, Kuppuswamy, Sathyanarayanan <sathyanarayanan=
.kuppuswamy@linux.intel.com> wrote:
>=20
> Hi,
>=20
> On 11/17/20 11:19 AM, Sean V Kelley wrote:
>> Instead of calling pci_pcie_type(dev) twice, call it once and save the
>> result.  No functional change intended.
>=20
> Same optimization can be applied to drivers/pci/pcie/portdrv_pci.c and
> drivers/pci/pcie/aer.c.
>=20
> Can you fix them together ?

Makes sense.  I can combine the changes.

Thanks,

Sean

>=20
>> [bhelgaas: split to separate patch]
>> Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oreg=
ontracks.org
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/pci/pcie/err.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 05f61da5ed9d..7a5af873d8bc 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -150,6 +150,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *de=
v,
>>  		pci_channel_state_t state,
>>  		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
>>  {
>> +	int type =3D pci_pcie_type(dev);
>>  	pci_ers_result_t status =3D PCI_ERS_RESULT_CAN_RECOVER;
>>  	struct pci_bus *bus;
>>  @@ -157,8 +158,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *d=
ev,
>>  	 * Error recovery runs on all subordinates of the first downstream por=
t.
>>  	 * If the downstream port detected the error, it is cleared at the end=
.
>>  	 */
>> -	if (!(pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>> -	      pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM))
>> +	if (!(type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>> +	      type =3D=3D PCI_EXP_TYPE_DOWNSTREAM))
>>  		dev =3D pci_upstream_bridge(dev);
>>  	bus =3D dev->subordinate;
>> =20
>=20
> --=20
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

