Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744FC3156C8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 20:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhBIT0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 14:26:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:51106 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233495AbhBITGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 14:06:44 -0500
IronPort-SDR: qEEy0zfRog9CZZpuIph6yPh1wnII2Kq5NJ5Yl9iG/8y2cs4s1FfM2RVV3v66aqfzEcWKlSYQpv
 oYHt7QzW5FLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161691771"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="161691771"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 11:01:38 -0800
IronPort-SDR: m8MIj9YMZqBA1HPL1zQvQgbt3uOlIQfBTkFqIBbmKrqJbpMOB9t45F4TuWBLPDiHdCFNMGEvYe
 84/KtX2/bIfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="396350176"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 09 Feb 2021 11:01:38 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 11:01:37 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 11:01:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 9 Feb 2021 11:01:37 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 9 Feb 2021 11:01:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr9WH+sZa9IF8oFrnDqeWaaYd/2qnFsqYrg6nkS0xUkO1Vr8CDBkG6r+qkOD0xevnuIbFGrpOKKjNIRAq4uZzBDYBSWuh3qy+2O/7DknFIOFNsIylBOqVJYppymab/8maGJdlFVPyIMjtrFem6yN7F/qIJgoP6f0yZKmDeJPbBo8IVfhOTKunGtH2jKqLh+xXOTE1tqrTHviLZObmge93i9+zKaPpjjSpQ7kLFTG+wQl3Uhj7ML0Ehl6p8dl6vJaISt0nfYvJEZnbqKAJzcRvcoF7/niinpUAFD2IbZJWo2IesiolFF9OtJjsCfvXxnhSmUVZqXb4Ud4w4o/TjqOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPEHD1lFkh7UxbtguWDCt4dnze5hIcFBi//GNfrKcqE=;
 b=Mzm7fBbHC7SmPd1W0j7rOSgild7VS4+jCiLZtzZY5f4TsHAFp9LH68n2TFJVI2GTfGIrcfXrGt7XZ/6JwbzwOrVhxGz+m9fuxdxhoAeJdo9hqgd/5SCm0bDWDn3mIwsF27OIMKQaU6Bx0XLGEcUfQpzS9r4wsbHtFocfTwdpbPTiK1hlYV6ysY9/6g7GlhmwPHP5DwFupLRijWiRcijwNX//5nszpg8B1fDN0oPjIrMtdThk+0LM9Nxy04GgbGlTLchiYTAHyqroC2J9fMu8xpSRB350/Wk5GyhO02n8zsx2Pd/QmRxTuL2rwJQocHHkI+ArY7kMqQsV8xFnIQfLjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPEHD1lFkh7UxbtguWDCt4dnze5hIcFBi//GNfrKcqE=;
 b=r2Mvthqzo7QBXNN7MEbwCK8MRixDTo1jQpXZ9EzlgAv5vs7ZtRwmXMnuDVbXEwb6TJMtFOo0sPduBCn5ZyDV3Zi2n6U4CQMW2vTREIShuUAClbS9w26wZwV7UKwuUHjytFiBy2EPqaQqBSI/JzGsEcGFnfh/eFRG0zJ/LU2txnM=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Tue, 9 Feb
 2021 19:01:35 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 19:01:34 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v7 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v7 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHW8mkhlykVcnGiCUaEVwh+NQ1vHqpQRNzQ
Date:   Tue, 9 Feb 2021 19:01:34 +0000
Message-ID: <MWHPR11MB140643694B7FD22B0D0AB478858E9@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210124234702.21074-1-srikanth.thokala@intel.com>
 <20210124234702.21074-3-srikanth.thokala@intel.com>
In-Reply-To: <20210124234702.21074-3-srikanth.thokala@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [27.59.157.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8447a575-1c60-4dbf-d77a-08d8cd2d1ef1
x-ms-traffictypediagnostic: CO1PR11MB5092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB50924BBECCA8D40900734889858E9@CO1PR11MB5092.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNaEwYfivnJVlVCRllIDSTBxiTZKbwZE9szqnexef9eRcJVAE284c4mObfVferVhRLHRRm0aYNCUrFHGZ6BIFCH8QoUBa7r3lSBFDijWBl6aBom1zo53zTQ7LldXozxLuUXWTbvidWocsz6e3I+JbKAtvoP6rDYpveLuUYcfI/voG9EZRNlcE1v360awP2WXvedfgYtiFNi9+gp1SCP9h4t9HjCj9KlCBrGLCkFuPpXKGcAef/l3ETlv7a1icD1snFtNr6x2GJLWRa4BWXY7tnoY6CJj4Vm44MhQDf2lyjCVWkSWrDSSDG1AeBkfDxEXsNunH4Y5Fu4g5c3XzKIiWq1ji/qLEL7IFs2viyRULgwCKjpnwTAaUDYGtqPiaRHp4cMEPAIVB6pCo2pjE8hrDX771vEEXmMSLmntV9GSG495lZeboIwDlBVSO/LIEzzHLiS1vLFEkqW3OE/awgpoDk+iVuxq4sgBJI1NbKNfu/VCGbVDFdZ60qYhKUZpfqgTlNtNIbVrRrkrrTubNSBi1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(66946007)(8676002)(8936002)(110136005)(30864003)(5660300002)(54906003)(66556008)(66476007)(64756008)(66446008)(76116006)(33656002)(71200400001)(86362001)(83380400001)(7696005)(186003)(53546011)(6506007)(9686003)(2906002)(316002)(26005)(4326008)(52536014)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eEWGlq0BDbHD97xzM0+ZAqY5B346NSC9wyW1DjUPWtWH4rofwYXK4bokgfpU?=
 =?us-ascii?Q?m/zoWbbBR0feI/KMbIQzkRtT5fdEbd+6zkOWx3FCZwFnVzc0NsahD1AHbiPH?=
 =?us-ascii?Q?dPkiwb5NH/znY0SHa6Ypr2+5beYoTd6vlqSrOOGpxO8DyptTwOmCo4AhiLxp?=
 =?us-ascii?Q?JpRieg+Cbsj2HQvyRFAbviQfik9shlv9IjIYarzhrd47okWjMI39oB+IBVBx?=
 =?us-ascii?Q?7ti5/BhybZRXpGNhnlt3nK6FAZJafgEJUw+s3qx+dR2lNdb0PWJ9wCvXX0hz?=
 =?us-ascii?Q?nToc631pbkihSg5eZjxH9YbLUAh6DieJ7/F7yJJ/vSQ4Ty6/Xj/C79Ub59wZ?=
 =?us-ascii?Q?xdQmO1oUDEGQ9EdTDqhK8gx0cT+VmUtE0NVTN3PZQKvnFSZqUJZAG5DDhO6W?=
 =?us-ascii?Q?cqKkSgICnn+MWXJKP0G9qGcPddZSfwOyEfdXWhcOgzaLwVlTBkLc1AWbhjF1?=
 =?us-ascii?Q?xXoUenWH/l5S4uMtBciezA5uJyWyQbcQlmr7c0qQRq8y7ksP5XmqZZ0wUpa9?=
 =?us-ascii?Q?xicBSS/VRyIow+ymIC7xfblkwHq4JPpuMqLnbLjljeaq3hSXoY9jp71OomyE?=
 =?us-ascii?Q?u9aOaZC7VigQTfxI2b8em36j1hKNSXt+kqPVZOqiwC93/ecjemGL2T4w75qa?=
 =?us-ascii?Q?dP/PJ3JgkOxS6d4QmHM+Zhs5jmvZm8HeLZKJIzFdAuQHLlePZ5iHv4oXDHdV?=
 =?us-ascii?Q?F1ZUcGhgFxmH75FtNA6vB0bqDJumcLgxINJN/L8FnvIVD4DU/1jLIKBA0cNJ?=
 =?us-ascii?Q?IQ5KVbzGY2ryyU8JGhtHxwK2TS2Nehn5rF0Ducq8QBnJIfj+84XaBEHT2I6l?=
 =?us-ascii?Q?yvOz+Uet/oopytEV+tDMePjEsny+UZVKnEWVQWmTLjpqqp/Qs2hZ5mFAJnNd?=
 =?us-ascii?Q?UUfoFhSo2MskQU/Iy+4ZW809QQtbZSiE7mNS0ATFgSI2O4S9jfC6xgWnPpke?=
 =?us-ascii?Q?0FKoy8CR8WIUIhh1AjRUoFEveL/XrWqxVteTWG24OXvr1qeGUVvW/dGsn+UT?=
 =?us-ascii?Q?WcZ+mlJ78Pd4Yw58Q/LTKvw/eVI+8l2HK/k6hd1LHW8fI+RWcqCLg6rQjsDJ?=
 =?us-ascii?Q?Bczs7Wv03Rr8672Z0LwKpnYIZO+BeZiSUPBuNBNrxL/oqi6prg0a3kjwt9nb?=
 =?us-ascii?Q?7dkEO8TfNqAl9dozVialGIVvMgeQMuG7UxTFfVp7yVli13QYqu+s4D3HJsqm?=
 =?us-ascii?Q?QZMOX7BAltNbwdMfDLRAQ/cFu1KfO7EU5Qk76ekFGY7bBuhIPIlgqVtRwz3V?=
 =?us-ascii?Q?tu0HnZkuqPRB9/vC1ZsB4T/yyzzIURH53JdKrDXX3YC42+SrE2tmJjcHGNJ2?=
 =?us-ascii?Q?OD5pNUFY9yefAJ5FakciM1Qe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8447a575-1c60-4dbf-d77a-08d8cd2d1ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 19:01:34.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgwazDUWTfsMv1mMecKeiYWOVbFSSIHKwFB1mMCyK2g9iK/kgocfFXg2naLV8b/zGlOuzQG+PXKRHEwJ0zy0olHVQXc93a71npSBtYGuiDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Kindly review the patch and provide comments, if any.

Thanks!
Srikanth

> -----Original Message-----
> From: Thokala, Srikanth <srikanth.thokala@intel.com>
> Sent: Monday, January 25, 2021 5:17 AM
> To: bhelgaas@google.com; robh+dt@kernel.org; lorenzo.pieralisi@arm.com
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> Thokala, Srikanth <srikanth.thokala@intel.com>
> Subject: [PATCH v7 2/2] PCI: keembay: Add support for Intel Keem Bay
>=20
> From: Srikanth Thokala <srikanth.thokala@intel.com>
>=20
> Add driver for Intel Keem Bay SoC PCIe controller. This controller
> is based on DesignWare PCIe core.
>=20
> In root complex mode, only internal reference clock is possible for
> Keem Bay A0. For Keem Bay B0, external reference clock can be used
> and will be the default configuration. Currently, keembay_pcie_of_data
> structure has one member. It will be expanded later to handle this
> difference.
>=20
> Endpoint mode link initialization is handled by the boot firmware.
>=20
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> ---
>  MAINTAINERS                               |   7 +
>  drivers/pci/controller/dwc/Kconfig        |  28 ++
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-keembay.c | 452 ++++++++++++++++++++++
>  4 files changed, 488 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00836f6452f0..a423b16641ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13816,6 +13816,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
>  F:	drivers/pci/controller/dwc/pcie-histb.c
>=20
> +PCIE DRIVER FOR INTEL KEEM BAY
> +M:	Srikanth Thokala <srikanth.thokala@intel.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
> +F:	drivers/pci/controller/dwc/pcie-keembay.c
> +
>  PCIE DRIVER FOR MEDIATEK
>  M:	Ryder Lee <ryder.lee@mediatek.com>
>  L:	linux-pci@vger.kernel.org
> diff --git a/drivers/pci/controller/dwc/Kconfig
> b/drivers/pci/controller/dwc/Kconfig
> index 22c5529e9a65..4dcb4b2773ea 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -225,6 +225,34 @@ config PCIE_INTEL_GW
>  	  The PCIe controller uses the DesignWare core plus Intel-specific
>  	  hardware wrappers.
>=20
> +config PCIE_KEEMBAY
> +	bool
> +
> +config PCIE_KEEMBAY_HOST
> +	bool "Intel Keem Bay PCIe controller - Host mode"
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	select PCIE_KEEMBAY
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in Keem Bay
> +	  to work in host mode.
> +	  The PCIe controller is based on Designware Hardware and uses
> +	  DesignWare core functions.
> +
> +config PCIE_KEEMBAY_EP
> +	bool "Intel Keem Bay PCIe controller - Endpoint mode"
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCIE_KEEMBAY
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in Keem Bay
> +	  to work in endpoint mode.
> +	  The PCIe controller is based on Designware Hardware and uses
> +	  DesignWare core functions.
> +
>  config PCIE_KIRIN
>  	depends on OF && (ARM64 || COMPILE_TEST)
>  	bool "HiSilicon Kirin series SoCs PCIe controllers"
> diff --git a/drivers/pci/controller/dwc/Makefile
> b/drivers/pci/controller/dwc/Makefile
> index a751553fa0db..95da2c62c426 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
>  obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
> +obj-$(CONFIG_PCIE_KEEMBAY) +=3D pcie-keembay.o
>  obj-$(CONFIG_PCIE_KIRIN) +=3D pcie-kirin.o
>  obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
>  obj-$(CONFIG_PCI_MESON) +=3D pci-meson.o
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c
> b/drivers/pci/controller/dwc/pcie-keembay.c
> new file mode 100644
> index 000000000000..1064e9649340
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -0,0 +1,452 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe controller driver for Intel Keem Bay
> + * Copyright (C) 2020 Intel Corporation
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +#include "pcie-designware.h"
> +
> +/* PCIE_REGS_APB_SLV Registers */
> +#define PCIE_REGS_PCIE_CFG		0x0004
> +#define  PCIE_DEVICE_TYPE		BIT(8)
> +#define  PCIE_RSTN			BIT(0)
> +#define PCIE_REGS_PCIE_APP_CNTRL	0x0008
> +#define  APP_LTSSM_ENABLE		BIT(0)
> +#define PCIE_REGS_INTERRUPT_ENABLE	0x0028
> +#define  MSI_CTRL_INT_EN		BIT(8)
> +#define  EDMA_INT_EN			GENMASK(7, 0)
> +#define PCIE_REGS_INTERRUPT_STATUS	0x002c
> +#define  MSI_CTRL_INT			BIT(8)
> +#define PCIE_REGS_PCIE_SII_PM_STATE	0x00b0
> +#define  SMLH_LINK_UP			BIT(19)
> +#define  RDLH_LINK_UP			BIT(8)
> +#define  PCIE_REGS_PCIE_SII_LINK_UP	(SMLH_LINK_UP | RDLH_LINK_UP)
> +#define PCIE_REGS_PCIE_PHY_CNTL		0x0164
> +#define  PHY0_SRAM_BYPASS		BIT(8)
> +#define PCIE_REGS_PCIE_PHY_STAT		0x0168
> +#define  PHY0_MPLLA_STATE		BIT(1)
> +#define PCIE_REGS_LJPLL_STA		0x016c
> +#define  LJPLL_LOCK			BIT(0)
> +#define PCIE_REGS_LJPLL_CNTRL_0		0x0170
> +#define  LJPLL_EN			BIT(29)
> +#define  LJPLL_FOUT_EN			GENMASK(24, 21)
> +#define PCIE_REGS_LJPLL_CNTRL_2		0x0178
> +#define  LJPLL_REF_DIV			GENMASK(17, 12)
> +#define  LJPLL_FB_DIV			GENMASK(11, 0)
> +#define PCIE_REGS_LJPLL_CNTRL_3		0x017c
> +#define  LJPLL_POST_DIV3A		GENMASK(24, 22)
> +#define  LJPLL_POST_DIV2A		GENMASK(18, 16)
> +
> +#define PERST_DELAY_US		1000
> +#define AUX_CLK_RATE_HZ		24000000
> +
> +struct keembay_pcie {
> +	struct dw_pcie		pci;
> +	void __iomem		*apb_base;
> +	enum dw_pcie_device_mode mode;
> +
> +	struct clk		*clk_master;
> +	struct clk		*clk_aux;
> +	struct gpio_desc	*reset;
> +};
> +
> +struct keembay_pcie_of_data {
> +	enum dw_pcie_device_mode mode;
> +};
> +
> +static void keembay_ep_reset_assert(struct keembay_pcie *pcie)
> +{
> +	gpiod_set_value_cansleep(pcie->reset, 1);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> +}
> +
> +static void keembay_ep_reset_deassert(struct keembay_pcie *pcie)
> +{
> +	/*
> +	 * Ensure that PERST# is asserted for a minimum of 100ms
> +	 *
> +	 * For more details, refer to PCI Express Card Electromechanical
> +	 * Specification Revision 1.1, Table-2.4
> +	 */
> +	msleep(100);
> +
> +	gpiod_set_value_cansleep(pcie->reset, 0);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> +}
> +
> +static void keembay_pcie_ltssm_enable(struct keembay_pcie *pcie, bool
> enable)
> +{
> +	u32 val;
> +
> +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_APP_CNTRL);
> +	if (enable)
> +		val |=3D APP_LTSSM_ENABLE;
> +	else
> +		val &=3D ~APP_LTSSM_ENABLE;
> +	writel(val, pcie->apb_base + PCIE_REGS_PCIE_APP_CNTRL);
> +}
> +
> +static int keembay_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> +	u32 val;
> +
> +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_SII_PM_STATE);
> +
> +	return (val & PCIE_REGS_PCIE_SII_LINK_UP) =3D=3D
> PCIE_REGS_PCIE_SII_LINK_UP;
> +}
> +
> +static int keembay_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> +	u32 val;
> +	int ret;
> +
> +	if (pcie->mode =3D=3D DW_PCIE_EP_TYPE)
> +		return 0;
> +
> +	keembay_pcie_ltssm_enable(pcie, false);
> +
> +	ret =3D readl_poll_timeout(pcie->apb_base + PCIE_REGS_PCIE_PHY_STAT,
> +				 val, val & PHY0_MPLLA_STATE, 20,
> +				 500 * USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(pci->dev, "MPLLA is not locked\n");
> +		return ret;
> +	}
> +
> +	keembay_pcie_ltssm_enable(pcie, true);
> +
> +	return 0;
> +}
> +
> +static void keembay_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> +
> +	keembay_pcie_ltssm_enable(pcie, false);
> +}
> +
> +static const struct dw_pcie_ops keembay_pcie_ops =3D {
> +	.link_up	=3D keembay_pcie_link_up,
> +	.start_link	=3D keembay_pcie_start_link,
> +	.stop_link	=3D keembay_pcie_stop_link,
> +};
> +
> +static inline struct clk *keembay_pcie_probe_clock(struct device *dev,
> +						   const char *id, u64 rate)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	clk =3D devm_clk_get(dev, id);
> +	if (IS_ERR(clk))
> +		return clk;
> +
> +	if (rate) {
> +		ret =3D clk_set_rate(clk, rate);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	ret =3D clk_prepare_enable(clk);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret =3D devm_add_action_or_reset(dev,
> +				       (void(*)(void *))clk_disable_unprepare,
> +				       clk);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return clk;
> +}
> +
> +static int keembay_pcie_probe_clocks(struct keembay_pcie *pcie)
> +{
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct device *dev =3D pci->dev;
> +
> +	pcie->clk_master =3D keembay_pcie_probe_clock(dev, "master", 0);
> +	if (IS_ERR(pcie->clk_master))
> +		return dev_err_probe(dev, PTR_ERR(pcie->clk_master),
> +				     "Failed to enable master clock");
> +
> +	pcie->clk_aux =3D keembay_pcie_probe_clock(dev, "aux",
> AUX_CLK_RATE_HZ);
> +	if (IS_ERR(pcie->clk_aux))
> +		return dev_err_probe(dev, PTR_ERR(pcie->clk_aux),
> +				     "Failed to enable auxiliary clock");
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize the internal PCIe PLL in Host mode.
> + * See the following sections in Keem Bay data book,
> + * (1) 6.4.6.1 PCIe Subsystem Example Initialization,
> + * (2) 6.8 PCIe Low Jitter PLL for Ref Clk Generation.
> + */
> +static int keembay_pcie_pll_init(struct keembay_pcie *pcie)
> +{
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	u32 val;
> +	int ret;
> +
> +	val =3D FIELD_PREP(LJPLL_REF_DIV, 0) | FIELD_PREP(LJPLL_FB_DIV, 0x32);
> +	writel(val, pcie->apb_base + PCIE_REGS_LJPLL_CNTRL_2);
> +
> +	val =3D FIELD_PREP(LJPLL_POST_DIV3A, 0x2) |
> +		FIELD_PREP(LJPLL_POST_DIV2A, 0x2);
> +	writel(val, pcie->apb_base + PCIE_REGS_LJPLL_CNTRL_3);
> +
> +	val =3D FIELD_PREP(LJPLL_EN, 0x1) | FIELD_PREP(LJPLL_FOUT_EN, 0xc);
> +	writel(val, pcie->apb_base + PCIE_REGS_LJPLL_CNTRL_0);
> +
> +	ret =3D readl_poll_timeout(pcie->apb_base + PCIE_REGS_LJPLL_STA,
> +				 val, val & LJPLL_LOCK, 20,
> +				 500 * USEC_PER_MSEC);
> +	if (ret)
> +		dev_err(pci->dev, "Low jitter PLL is not locked\n");
> +
> +	return ret;
> +}
> +
> +static irqreturn_t keembay_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct keembay_pcie *pcie =3D arg;
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct pcie_port *pp =3D &pci->pp;
> +	u32 val, mask, status;
> +
> +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> +	mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +
> +	status =3D val & mask;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (status & MSI_CTRL_INT)
> +		dw_handle_msi_irq(pp);
> +
> +	writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int keembay_pcie_setup_irq(struct keembay_pcie *pcie)
> +{
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct device *dev =3D pci->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	int irq, ret;
> +
> +	irq =3D platform_get_irq_byname(pdev, "pcie");
> +	if (irq < 0)
> +		return irq;
> +
> +	ret =3D devm_request_irq(dev, irq, keembay_pcie_irq_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "pcie", pcie);
> +	if (ret)
> +		dev_err(dev, "Failed to request IRQ: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> +
> +	writel(EDMA_INT_EN, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +}
> +
> +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				     enum pci_epc_irq_type type,
> +				     u16 interrupt_num)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		/* Legacy interrupts are not supported in Keem Bay */
> +		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> +		return -EINVAL;
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	case PCI_EPC_IRQ_MSIX:
> +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct pci_epc_features keembay_pcie_epc_features =3D {
> +	.linkup_notifier	=3D false,
> +	.msi_capable		=3D true,
> +	.msix_capable		=3D true,
> +	.reserved_bar		=3D BIT(BAR_1) | BIT(BAR_3) | BIT(BAR_5),
> +	.bar_fixed_64bit	=3D BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> +	.align			=3D SZ_16K,
> +};
> +
> +static const struct pci_epc_features *
> +keembay_pcie_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &keembay_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops keembay_pcie_ep_ops =3D {
> +	.ep_init	=3D keembay_pcie_ep_init,
> +	.raise_irq	=3D keembay_pcie_ep_raise_irq,
> +	.get_features	=3D keembay_pcie_get_features,
> +};
> +
> +static const struct dw_pcie_host_ops keembay_pcie_host_ops =3D {
> +};
> +
> +static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
> +				      struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci =3D &pcie->pci;
> +	struct pcie_port *pp =3D &pci->pp;
> +	struct device *dev =3D &pdev->dev;
> +	u32 val;
> +	int ret;
> +
> +	pp->ops =3D &keembay_pcie_host_ops;
> +	pp->msi_irq =3D -ENODEV;
> +
> +	pcie->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pcie->reset))
> +		return PTR_ERR(pcie->reset);
> +
> +	ret =3D keembay_pcie_probe_clocks(pcie);
> +	if (ret)
> +		return ret;
> +
> +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> +	val |=3D PHY0_SRAM_BYPASS;
> +	writel(val, pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> +
> +	writel(PCIE_DEVICE_TYPE, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +
> +	ret =3D keembay_pcie_pll_init(pcie);
> +	if (ret)
> +		return ret;
> +
> +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +	writel(val | PCIE_RSTN, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> +	keembay_ep_reset_deassert(pcie);
> +
> +	ret =3D dw_pcie_host_init(pp);
> +	if (ret) {
> +		keembay_ep_reset_assert(pcie);
> +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> +		return ret;
> +	}
> +
> +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		val |=3D MSI_CTRL_INT_EN;
> +	writel(val, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> +
> +	return 0;
> +}
> +
> +static int keembay_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct keembay_pcie_of_data *data;
> +	struct device *dev =3D &pdev->dev;
> +	struct keembay_pcie *pcie;
> +	struct dw_pcie *pci;
> +	enum dw_pcie_device_mode mode;
> +	int ret;
> +
> +	data =3D device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	mode =3D (enum dw_pcie_device_mode)data->mode;
> +
> +	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci =3D &pcie->pci;
> +	pci->dev =3D dev;
> +	pci->ops =3D &keembay_pcie_ops;
> +
> +	pcie->mode =3D mode;
> +
> +	pcie->apb_base =3D devm_platform_ioremap_resource_byname(pdev, "apb");
> +	if (IS_ERR(pcie->apb_base))
> +		return PTR_ERR(pcie->apb_base);
> +
> +	ret =3D keembay_pcie_setup_irq(pcie);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	switch (pcie->mode) {
> +	case DW_PCIE_RC_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> +			return -ENODEV;
> +
> +		return keembay_pcie_add_pcie_port(pcie, pdev);
> +	case DW_PCIE_EP_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> +			return -ENODEV;
> +
> +		pci->ep.ops =3D &keembay_pcie_ep_ops;
> +		return dw_pcie_ep_init(&pci->ep);
> +	default:
> +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> +		return -ENODEV;
> +	}
> +}
> +
> +static const struct keembay_pcie_of_data keembay_pcie_rc_of_data =3D {
> +	.mode =3D DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct keembay_pcie_of_data keembay_pcie_ep_of_data =3D {
> +	.mode =3D DW_PCIE_EP_TYPE,
> +};
> +
> +static const struct of_device_id keembay_pcie_of_match[] =3D {
> +	{
> +		.compatible =3D "intel,keembay-pcie",
> +		.data =3D &keembay_pcie_rc_of_data,
> +	},
> +	{
> +		.compatible =3D "intel,keembay-pcie-ep",
> +		.data =3D &keembay_pcie_ep_of_data,
> +	},
> +	{}
> +};
> +
> +static struct platform_driver keembay_pcie_driver =3D {
> +	.driver =3D {
> +		.name =3D "keembay-pcie",
> +		.of_match_table =3D keembay_pcie_of_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe  =3D keembay_pcie_probe,
> +};
> +builtin_platform_driver(keembay_pcie_driver);
> --
> 2.17.1

