Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0C2B8188
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgKRQMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 11:12:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:21977 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgKRQMF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 11:12:05 -0500
IronPort-SDR: ciOLWwXJ0apmciS8jbJtAMm6Z/B0yPwmDO9+paR/MuCas6xkZCIyWfublPCR6eNuMd5hxxUmz/
 JZpyQBDrHuVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="189216339"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="189216339"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:12:02 -0800
IronPort-SDR: IPTUUFTa0XPlqvTCndubDHcNWWiggPGN/keGrlOXb63JP5utoy0qrM54x3DdTtZ2SSMyjl63WK
 yc//2kliVh1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="476410379"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 18 Nov 2020 08:12:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Nov 2020 08:12:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Nov 2020 08:12:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 18 Nov 2020 08:12:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 18 Nov 2020 08:12:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJieQBVH6f2FvtUspiD3DxKTBRfCefXc/I8o4CD8VSAsSEY1t5CIwuRD8HWe/GnOPkAQMvwP2F3FbqtbTfN/sM4CF3x1PeUZJTwPlGPZkZaFaArm2hr/HZtG5WJtM3jvl5PfjC906FlYgnRvtCMP4UhVzKjIxKXaKC/kO1lhZOhWdJ/DBeNgClhJDd5zQjX5HQurabyozGObHBFuC3ZS02adrV6HknSJb2UiVqQ2bkC7zaGxszoY6cRs8iZ3VrNOP4gAyQ5pJXT/XqvNXQWl9ag9GA9zRrS/pfRk5ymTEmIBrko4KISVaHHGj9iivcUaqRNs36WQKH3sqWQ+s36s/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrwGfNCPzkQKDRtuWg9eFEUjZHRwwQ7id6w2eHBFPpY=;
 b=k6a1w+s2dXosH+I1JI30aFifF2wvj7eU3ZpWmRtVM4py/n1Y5Qx/JX7flsRBhAh7iCd2AH/Tr/G5Zb2R6PycA4hMHmulAP6XT6dWhuvvIzFDf1vk7hFc5Z0kZuErbRu9ZpWPjvnOoqOjp10iYVwmJ6wdaVFblR+i2KHQ/6vhKudJ1A9+Y7Am+9IhHg5gE/75j8URxBtSYqWlytA/bEI6X+yu0aAp82sDOvcYEyB8JLinx9vGNpx104O4eDeZn2mVW/0XftkWDOyl1Hb3cYXpD3j/vWk/9VnJUOWliltWSklsFJHsqkyN6t27cGTkBrilZ2VXL5S1peWKccSMm4c37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrwGfNCPzkQKDRtuWg9eFEUjZHRwwQ7id6w2eHBFPpY=;
 b=ROHrgtq1rWhFLoLA1LMacy6TktMb3odTfLpplKSq4WpxU9u7XbJ9QCW6P804A5NrEc3JcO18UvZjfMZXaKBTUOY2ZBupSQVYLPoJnWOcCq2uui/hSS1xhIBZ8K/cjOBj3A865PvAudY60MOL+GqFeXQj0yVSh/S8uKW+kzZAsdk=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:50::16) by BN6PR1101MB2099.namprd11.prod.outlook.com
 (2603:10b6:405:57::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 18 Nov
 2020 16:11:58 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::bcaa:2da8:af5e:4b51%11]) with mapi id 15.20.3564.028; Wed, 18 Nov
 2020 16:11:58 +0000
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
Subject: Re: [PATCH v11 15/16] PCI/PME: Add pcie_walk_rcec() to RCEC PME
 handling
Thread-Topic: [PATCH v11 15/16] PCI/PME: Add pcie_walk_rcec() to RCEC PME
 handling
Thread-Index: AQHWvRbTIWMdRLvDLUCoR6ZMl866tqnNZu8AgACp9oA=
Date:   Wed, 18 Nov 2020 16:11:57 +0000
Message-ID: <87254CA5-DB37-4DFE-8423-27431E4C3856@intel.com>
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-16-sean.v.kelley@intel.com>
 <daef675b-a5b3-0973-e0a7-f4d0ed6dd7c8@linux.intel.com>
In-Reply-To: <daef675b-a5b3-0973-e0a7-f4d0ed6dd7c8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.20.0.2.21)
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2ded762-9aa3-4b43-a3df-08d88bdcad0c
x-ms-traffictypediagnostic: BN6PR1101MB2099:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2099431B34BC6056DAECA700B2E10@BN6PR1101MB2099.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Es62JX/hlZjuOazLcpfDcBhX5yZSmeoEzJEHNtcg9FjbKyZCCQ/iZYV73rJUN+dYh1mSLQ5chTas5TFIM7rfCWC+FQsr1xexUNOC1rA5aw+Fsi+jC8Ux6PfO4UJGBvPRwSi8h/GzRdG//JJ8InjEMilzWczvSWbhUn6wXbVN9MSM4B3ZLp+R5b9PIvzy/kstldMKy0Hi5YqkGtg82Yh/9IccecvV2hUW9EZG+t0E03CUKwSypM3fmtOwkO3o30fW+rCiIKZNzgzxbc8TpHk4fKlsKQ6ibQlaQz5rh2vTd99QHG7yIEmtZB9JIkpDrC6HwvsFtRXphHJ0852nDtLptA+8mRjKNr75wCsAcb+Fbo+klzTaH62unZpCWupbyJMp8rAo9Ge1pwlJ/HWNYSrirA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(91956017)(54906003)(86362001)(26005)(8936002)(6506007)(6512007)(53546011)(2616005)(186003)(71200400001)(966005)(33656002)(6486002)(316002)(4326008)(478600001)(5660300002)(2906002)(76116006)(83380400001)(6916009)(8676002)(64756008)(66476007)(66446008)(66946007)(36756003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: B63AIDBip4qgx8lTq5bDC45pRT7l3LAD7wZTYzwiYBhhNolxuOb5ZMoa5t0FU2yjojUGF/OwerycxIQ7Rz7j4AcN6ErLL5jusOmy9+3W5VaEJHIi6p/yu0wq2V5JbKAv+Ktdf9ygwaO0++yRfZ4NrXjIqkcLnLc2rT1V3v4xoZNjFWbhFXu1qmAaaUV3eejpivjjwdtAZVKg6jSGa1RQm7umLztBhB0kZaVQJ1Vqv5fMBWHCoZjI4uEu0h4zbQvEfqDLf3hSTYFnvKRVaExs0Qj/56jjxfvHD2aJn2LEzVM08oh8JVP5E9NDGLYtOjXLjWdu1PukMeM+GIoL/U03Kk/WKGgL9FSO/dqbxd+yQMBzPn5d9rAuAvFYes3bmcDj1He2fZ3PjH3O3NqKMulqDexTub+lhMzPKL0GV7MizJ600rw2Y3Kkp7yUJu8ka8NQ92mxpO+J0AUF1rgh7Xp6Wz6ZK2EBmTl1s8kpSCuE/WTzCLZ/2dkm3kHbWXbedpm8C8QtSPFZX/2AIIH/bv1BpIDMSxOVJJBJqPMFASzLGIM9o22Zy4sakqqnaWo1zkP+qkxy92p53fZxVruwgT+TTN1xKz+15/EKx63AeHYLdi1R1T4mHc5QeZ3Jox/bvPVjvvwBUAsi67Hqydl5p7DyXg==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF426557114E4E4F944D8E2DFF065AB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ded762-9aa3-4b43-a3df-08d88bdcad0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 16:11:57.8850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34rqWx36wveD0gQh9NxQEcdd6LTVmSyzXTFU/MMaG7FlwhbFRYMDvDOOZese9u7t6ClSwD1Ud2wfcI93Y0/0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2099
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sathya,

> On Nov 17, 2020, at 10:03 PM, Kuppuswamy, Sathyanarayanan <sathyanarayana=
n.kuppuswamy@linux.intel.com> wrote:
>=20
>=20
>=20
> On 11/17/20 11:19 AM, Sean V Kelley wrote:
>> Root Complex Event Collectors (RCEC) appear as peers of Root Ports and a=
lso
>> have the PME capability. As with AER, there is a need to be able to walk
>> the RCiEPs associated with their RCEC for purposes of acting upon them w=
ith
>> callbacks.
>> Add RCEC support through the use of pcie_walk_rcec() to the current PME
>> service driver and attach the PME service driver to the RCEC device.
>> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Link: https://lore.kernel.org/r/20201002184735.1229220-14-seanvk.dev@ore=
gontracks.org
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  drivers/pci/pcie/pme.c          | 15 +++++++++++----
>>  drivers/pci/pcie/portdrv_core.c |  9 +++------
>>  2 files changed, 14 insertions(+), 10 deletions(-)
>> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
>> index 6a32970bb731..87799166c96a 100644
>> --- a/drivers/pci/pcie/pme.c
>> +++ b/drivers/pci/pcie/pme.c
>> @@ -310,7 +310,10 @@ static int pcie_pme_can_wakeup(struct pci_dev *dev,=
 void *ign)
>>  static void pcie_pme_mark_devices(struct pci_dev *port)
>>  {
>>  	pcie_pme_can_wakeup(port, NULL);
>> -	if (port->subordinate)
>> +
>> +	if (pci_pcie_type(port) =3D=3D PCI_EXP_TYPE_RC_EC)
>> +		pcie_walk_rcec(port, pcie_pme_can_wakeup, NULL);
>> +	else if (port->subordinate)
>>  		pci_walk_bus(port->subordinate, pcie_pme_can_wakeup, NULL);
>>  }
>>  @@ -320,10 +323,15 @@ static void pcie_pme_mark_devices(struct pci_dev =
*port)
>>   */
>>  static int pcie_pme_probe(struct pcie_device *srv)
>>  {
>> -	struct pci_dev *port;
>> +	struct pci_dev *port =3D srv->port;
>>  	struct pcie_pme_service_data *data;
>>  	int ret;
>>  +	/* Limit to Root Ports or Root Complex Event Collectors */
>> +	if ((pci_pcie_type(port) !=3D PCI_EXP_TYPE_RC_EC) &&
>> +	    (pci_pcie_type(port) !=3D PCI_EXP_TYPE_ROOT_PORT))
> may be you can save the value pci_pcie_type(port)?

Good suggestion. Will add.

Thanks,

Sean

>> +		return -ENODEV;
>> +
>>  	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>>  	if (!data)
>>  		return -ENOMEM;
>> @@ -333,7 +341,6 @@ static int pcie_pme_probe(struct pcie_device *srv)
>>  	data->srv =3D srv;
>>  	set_service_data(srv, data);
>>  -	port =3D srv->port;
>>  	pcie_pme_interrupt_enable(port, false);
>>  	pcie_clear_root_pme_status(port);
>>  @@ -445,7 +452,7 @@ static void pcie_pme_remove(struct pcie_device *srv=
)
>>    static struct pcie_port_service_driver pcie_pme_driver =3D {
>>  	.name		=3D "pcie_pme",
>> -	.port_type	=3D PCI_EXP_TYPE_ROOT_PORT,
>> +	.port_type	=3D PCIE_ANY_PORT,
>>  	.service	=3D PCIE_PORT_SERVICE_PME,
>>    	.probe		=3D pcie_pme_probe,
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_=
core.c
>> index 50a9522ab07d..e1fed6649c41 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -233,12 +233,9 @@ static int get_port_device_capability(struct pci_de=
v *dev)
>>  	}
>>  #endif
>>  -	/*
>> -	 * Root ports are capable of generating PME too.  Root Complex
>> -	 * Event Collectors can also generate PMEs, but we don't handle
>> -	 * those yet.
>> -	 */
>> -	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT &&
>> +	/* Root Ports and Root Complex Event Collectors may generate PMEs */
>> +	if ((pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>> +	     pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC) &&
>>  	    (pcie_ports_native || host->native_pme)) {
>>  		services |=3D PCIE_PORT_SERVICE_PME;
>> =20
>=20
> --=20
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer

