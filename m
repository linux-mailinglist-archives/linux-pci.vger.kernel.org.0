Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5383313E4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 17:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCHQyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 11:54:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:18282 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhCHQyf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Mar 2021 11:54:35 -0500
IronPort-SDR: mmpe+8Bh/FbOyhjV76REdMv+1ZqhcbiH1gny8Co4UFRFQNEunNEG0RZQGoNGwCu2b6EXwDSm+e
 c+apCcQ3zNcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249443767"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="249443767"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:54:35 -0800
IronPort-SDR: sLtOiRaVPHWc089T0pHoMpCvMlp9sBKktstUin3IIn1YxLKeDI5VNMQuw2iDLAiNvlUVcS5U/U
 f0/NZnKijAoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="602218134"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2021 08:54:35 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 08:54:34 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 08:54:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Mar 2021 08:54:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 8 Mar 2021 08:54:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSBTRpTlhfNEsYS9uvO/+ycwxP2Z6vjXbR/tG/dI9DpUXRIF0drUpcFB/xQOiq+N8KYxsuAaw07t0Nxqe112EjAg+NIWw8aP7PrGWj6QVYN4NUmMgXg5idxfVr99armzGij59A2Amav7ZCPeD6mQuw29a9Lj3Dwp2PDv3JZbC+7oREVzqosC26ObvnHlh+nHrIQRkVlkqwT4EOOmDQUKP57Hpl3LRacsmJxH20GzHclh3Zevp4quj9OHFL9EW7QHGWN1CEOxyuY/rHE3IIlqwflix9heZYArAxoCunHXbrgh6GaXUW+bR9UFpYtefJ73Plkwsfda6nYR0JSDn7Wclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvBM1YtHIo1IWCQmGbALqlXDIDyvOyhY4l6j3DGeWO4=;
 b=e48EblTrkne/RmqJp7MDyLKUcL60tWvMDoVeWiV12KVv/nRSVjiBjobHFVy65xSRPmj0JZ4Rb1drUqnDR+wrMZRzio1C4E9ktoyCG2f1hARLcL4qqKQn8ay8VuYY26ZmH3bSLgmjOogzfWI/HwNrgnd9/mD4ptwELlDkwexZcI3wdeN42oN3nTgwWtx64BHeSzl4ZFxA/ynExAjmtEkSRouMW3xLlq6lYkK+4AKp3lm/EjoeAJbXx6s6npliDciafjIG8TyOTqiGpoMv7jAEjxoTrNCkDV1PUWvHtUcT3xjI9ODoD4TQLhvagwK544pCKKboVyjcGy6Izfp/wMGiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvBM1YtHIo1IWCQmGbALqlXDIDyvOyhY4l6j3DGeWO4=;
 b=b6FliGrYOyijhrtDnEBKUO4xO0yGsc5VdWl9At3mYC+2IGBB0gHGFB2fkx0FogfvkN/sIE/qkShTQOaGtgrqJIZJcEOd/wFNj2zMQq8Hx4j34DPG0/dJYzfJ8cJKKj+o82rRYx79u/eZG2N3vkr04HRimQSGHmcBgEcr8lPyKiU=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by MWHPR11MB2063.namprd11.prod.outlook.com (2603:10b6:300:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 16:54:32 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::89f0:cbc3:d9c2:6e7a%7]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 16:54:32 +0000
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
        <mallikarjunappa.sangannavar@intel.com>,
        "kw@linux.com" <kw@linux.com>
Subject: RE: [PATCH v8 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v8 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXBVou+XdwLl2NikywEE1XCJLSHqp6bD1A
Date:   Mon, 8 Mar 2021 16:54:31 +0000
Message-ID: <MWHPR11MB1406369009012B8CD7063F2085939@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210218021757.21931-1-srikanth.thokala@intel.com>
 <20210218021757.21931-3-srikanth.thokala@intel.com>
In-Reply-To: <20210218021757.21931-3-srikanth.thokala@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [106.200.199.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a34648-80e6-4db9-cb7a-08d8e252d893
x-ms-traffictypediagnostic: MWHPR11MB2063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB20634209AF1CA32B199F4C2485939@MWHPR11MB2063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDMwMznpUjkXPJcRSZqXQQOnVuHPB1akQ9kqeqtbvV4Bdf/irgJ0XLOnKqpDcrWp/gFkh8nD+Q9bqiQ2xZ4/y6rZ0M9mveCnEH5wqV6Krv0zxRH6V3NhYZPqbG0I2SFPSlGIaIIqXCL9x8vCwn9Iwnv52cN/3LL7LJp8py4j5zmN+Ida9zHxbastdMLQDLUq9fOE4nWXaGKzjJxLMO+cNGgzn6tzGrT2bj4P0qCouEqQlEqYsO8g3ImagYEQl51UOpYvNThJm7WhdkI9q1JafGv62zSmZLMrTteZ8UbR/3XTlwTJuOIwprFozqWJ6gsYb9Lc9PUoDVgxlYAdO1F8dKLRAMUMohQgwQ0cmxoGIETLIWjJOYXc2YhQXyTwRm3OWSu2jN6od+z22nVKTCWkTtKOaIVyhf6offIjA4i6tnomnXzsJKQOagHUucovMZtWpPre8tJetw1k8CXAvlREMMBMCIF0v1g6HfyyKLOdFVzpfZktVhcOi2CeNfk9h7ooAIRDkWGSuEYosl6rxfyf6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(9686003)(4326008)(33656002)(7696005)(8676002)(53546011)(8936002)(66556008)(66946007)(76116006)(66446008)(478600001)(83380400001)(55016002)(6506007)(186003)(71200400001)(86362001)(26005)(2906002)(316002)(110136005)(54906003)(30864003)(5660300002)(52536014)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PwfFaUy1rnSz9ZOdBj4YUSdjUzmotpKwJQhj3vyrByMBZyKJIOQGuckHNaOg?=
 =?us-ascii?Q?Qx9ezxz5U9jLH++OJXEj1AaTfRjcoGzhf4I2Mf22U/+6Pw94lLx94Up/6BZt?=
 =?us-ascii?Q?CCrGnQJqAyfcvizI39cWn+7oRKl0/8U7SUirC7K0h3gNKOUPEPfiXND61vd+?=
 =?us-ascii?Q?R/1D0BnQ9xaHMrAcQO1A0kF4YAR4Dl9Hpit8HLO6StP1GrbFcjPr0JGNIT+S?=
 =?us-ascii?Q?+tBB1S9NjsaMQTn91TbYf7Uxw2GSgL58oU4XTP7wCAtdKRgfQ/S9jgZ+weY0?=
 =?us-ascii?Q?G5ku4xSvaQ1slBt48wFKc51xaujs/RNsSDJ1n+Iy3eKrovKMHPL1DuFxvED8?=
 =?us-ascii?Q?1bY6CnymIyGkZD58QzzmTMXtsgJ6pbXmjhlZFMsd5XL3ssCKKZAGsKQaVu58?=
 =?us-ascii?Q?VLp1hugdzQ2Qbavu+H8q869J25CZ/MDkgrHvUXGQRIMmwGpxpRUy4+0wqMzX?=
 =?us-ascii?Q?xh4Y9aeaRWfhUhSo0ianq4WszTsAOe2yh7wUitKlyYUIz9LynIUR3KFJ3onf?=
 =?us-ascii?Q?P9sfHdyWMm/uV89qWwp3jolji5wGTKWl/urkYaI8py/ksEsf8Mz8qXZoz4Wz?=
 =?us-ascii?Q?q1Qym2na94JLfqaklAVMxM7wYvngeyo/oxlpK7CdH2YuoMv1sjRXlnRZvePd?=
 =?us-ascii?Q?cColmls4wB22inABDPUAvea6FtjmtCJ+Gmc+8qzI6bmXADITm+P1GUsWvh/y?=
 =?us-ascii?Q?2Kkn9PeHzR5tQeeLxpm3dO3I7DIFjr/r0CT3qeprBKJVfRtBOVS5ZfQEDKmb?=
 =?us-ascii?Q?bs9g/dTd5B7shpPE9QuKGAMMbS3g6JwMqGzRfa4k0wYmwpm7SyGG4ek/zWG4?=
 =?us-ascii?Q?RbL7M9MP+qggLy3CBzWsJqj0TIeS4Oq1D2dCip/AgfmnWD7PCxV09uXiyFYV?=
 =?us-ascii?Q?OcdJcvjplfl+Xwv05weWVQSCeJt9fRe4Wi30JYq5craKRqV7rXXcBqTEY5B5?=
 =?us-ascii?Q?NmEstoYi/gDMgDUU/ZULNq0Dn2Od+MA4XcqjixwVkB/X6Td71mG21twfpQBX?=
 =?us-ascii?Q?scsITon4JbLaoHoQZOijwWJReHwm3P7PDcxP36sSG907xn7yCzehqs6tg6LX?=
 =?us-ascii?Q?AQ+Ym6+fxNVp87IqObpio5UqKQ3GiSBvV+L2GOj/KX7Efi+wR4O6a/NAGeD0?=
 =?us-ascii?Q?zhRNfOfGPhg+r7Pb78rHskpLIkscT4f8aInwIq7MiAcvgrw3pAImkblTYJeE?=
 =?us-ascii?Q?X9veIsHGBE8rHiikOfuMVkDFskn6OLm4tQnNpzf85zfiQcuS9wcCxvtZPlSU?=
 =?us-ascii?Q?Zh5nPxJyapbxuGS/ZX1tf6PgaGCXWrGhn9d8pNqiq/05LBHEvE6W7dXRpdIP?=
 =?us-ascii?Q?+ovR3SKJzaGA6CKSBNlUS5pJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a34648-80e6-4db9-cb7a-08d8e252d893
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 16:54:32.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rX0h+XEan3CKDxmPnYmXaL57xIqQla6zs5dKpvpDxdl7DbcWmLUDNnaY0QxQFzneKZdGU6VAhrHK+wmms2eSl5cSltSrOz9ZKutrNBtfNP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2063
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
> Sent: Thursday, February 18, 2021 7:48 AM
> To: bhelgaas@google.com; robh+dt@kernel.org; lorenzo.pieralisi@arm.com
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> kw@linux.com; Thokala, Srikanth <srikanth.thokala@intel.com>
> Subject: [PATCH v8 2/2] PCI: keembay: Add support for Intel Keem Bay
>=20
> From: Srikanth Thokala <srikanth.thokala@intel.com>
>=20
> Add driver for Intel Keem Bay SoC PCIe controller. This controller
> is based on DesignWare PCIe core.
>=20
> In Root Complex mode, only internal reference clock is possible for
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
> index 22c5529e9a65..31ad37edfae3 100644
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
> +	  The PCIe controller is based on DesignWare Hardware and uses
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
> +	  The PCIe controller is based on DesignWare Hardware and uses
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
> index 000000000000..b13d0754af50
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
> +	 * Ensure that PERST# is asserted for a minimum of 100ms.
> +	 *
> +	 * For more details, refer to PCI Express Card Electromechanical
> +	 * Specification Revision 1.1, Table-2.4.
> +	 */
> +	msleep(100);
> +
> +	gpiod_set_value_cansleep(pcie->reset, 0);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> +}
> +
> +static void keembay_pcie_ltssm_set(struct keembay_pcie *pcie, bool
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
> +	keembay_pcie_ltssm_set(pcie, false);
> +
> +	ret =3D readl_poll_timeout(pcie->apb_base + PCIE_REGS_PCIE_PHY_STAT,
> +				 val, val & PHY0_MPLLA_STATE, 20,
> +				 500 * USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(pci->dev, "MPLLA is not locked\n");
> +		return ret;
> +	}
> +
> +	keembay_pcie_ltssm_set(pcie, true);
> +
> +	return 0;
> +}
> +
> +static void keembay_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> +
> +	keembay_pcie_ltssm_set(pcie, false);
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

