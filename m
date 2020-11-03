Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DEE2A3B92
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 05:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgKCE6c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 23:58:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:37101 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgKCE6b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 23:58:31 -0500
IronPort-SDR: gm+MVKXMI6XriYtlQAlj0+uKgP5Mw17X5v6PE7qhux5UbH5tEacA0t4v83Scf7nmdVCr2eSMMp
 bKTAK7VlQkRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="156777904"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="156777904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 20:58:30 -0800
IronPort-SDR: KNAtPU1J7zajvZK5g3/3xJKpmvBW9AV6eiqoXSE48MxFf4vnyxz5PfxjuiAraRKvU4RT8FXDNv
 oUkbcSjylBrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="396438552"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 02 Nov 2020 20:58:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 20:58:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Nov 2020 20:58:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 2 Nov 2020 20:58:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOa4vogwrIruB6l8Znouv6hS4W6QJ1Miyhp1aAlC0eJF00W57UgczKlfTfPEZIb4kbMnbUcMGAut7Mrrc97L+zvd49/CyvH6JhLvW8uVdmc8B1PeA1sH+LL8dLN0Iz/MdUZU4lCNrI1kELy79g+12UqtXyNBz4xj8FwMQnp21SDfeorbWk+C+57ylRBD9JscDMxoRzsq07ix4srwcy8ZiqeKmIQyNliYCKMjgdIq82Y1hhK+tGN8tQBWGBPS3mpWSgAWMilqbw3u0ZnOrxZcZ7pPKOOjqTw2UreOrmXx4S0Jp8ecEcImxtzEQUtN4dC/1VuTfHOCCnStPPap7SYVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHmGqobfxtQ+zD6b2FrEmEdI2jdnaqeoCR9S2hmDnC4=;
 b=WZAum+8LCBxiWjiO2CPto8OBpUKIErp4hOOMhFNIjXDTPIeoQWEK15yj8Oc4USLLkKWzE+A4728MVXa3Lk9qzflWEPl1R7befIRMzTTEI2sWsCLawSfpxLUxgHqV2DNH4hzNm81q0ie7vxdlae6V0+ThdDwFIH5DvJ5coup3V/JxaKzTpQMVHbnatr4iPCky+nOgu/rnWpXAH/prAUIm4yjUjhPoBIoR8OGoNEmzvA8DW2VfM1ZC91wXPVoja2pp8QC7oe0qztkZ8UGVFB9KhZetb/gf/QViI0vMYmoC1nO8b/U+hUG81qo/x5RgqW6vHLvuklHDMpaxm0AP1MYKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHmGqobfxtQ+zD6b2FrEmEdI2jdnaqeoCR9S2hmDnC4=;
 b=KFwKIyNlZ4Lx9jYI4KC/gNjo298BULzONLgqA0Eao4WovP7oyJpEbh2+BDpeMCEIZp9cT+XejyEgqaKojaqQWWQ5p9ea8QI+5SIwRPE478N8hbLQ2/D5M7VAcVXORBBKMgv2y6QRhGHp6wFxGCW9HWyRmqftDSMZY4KiTZFF83E=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB2890.namprd11.prod.outlook.com (2603:10b6:5:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Tue, 3 Nov
 2020 04:58:28 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 04:58:28 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Rob Herring <robh@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHWrCa/7JSqkgie50uK+30dhAeVBKmtE1CAgAjD5oA=
Date:   Tue, 3 Nov 2020 04:58:28 +0000
Message-ID: <DM6PR11MB37215A5A1DC0CC114A014E9CDD110@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201027060011.25893-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201028142247.GC3932108@bogus>
In-Reply-To: <20201028142247.GC3932108@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.225.240]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8ef7322-e740-4840-7e0b-08d87fb51a85
x-ms-traffictypediagnostic: DM6PR11MB2890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2890A93CC9341EA66E6413C9DD110@DM6PR11MB2890.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPxyfo8n5SV1hRq7Lu+VAdD9yiJI69EqamJCWPjvzCF+o4YEFUwG4G7fobOHr/JIQH0XvW/Nk+Rjrn1aQ4AlFzk7+8VucoagOBnDhsQCb5SNBQR9umvmyNb+OvRRo4JA+cmvg6m4fhtp9OyQtgCOwkV3vAeFP0ApUaKkPJmV2aYKA/s7nEsHXkpliwnCiY3fDlrkEYac30IIR2Cev3jjY5tmt+UnIyFrldr38VjLxcJUvkWcJZ1pwG3Vsr4ufgnWZqAMA35egO/6wH6l98oUjWE6rHRGGvmpLAlXgQJx2q6KaouEn5l4R7KkNb1zPC9ymRd4r1/kJtWx0iu/wVZhqJh/IyVHuGIUoHVQWs+CDntapLeDFjlzREYrFCX5JG9R3s43R54HvL6pISWHbDnLNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(71200400001)(316002)(6506007)(9686003)(66446008)(2906002)(66946007)(66556008)(76116006)(66476007)(5660300002)(53546011)(8676002)(30864003)(55016002)(8936002)(83380400001)(4326008)(7696005)(64756008)(86362001)(33656002)(52536014)(6916009)(186003)(478600001)(966005)(26005)(54906003)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4AnRC0jv3/RFWa/uUiqDpXr7rlRYGVyUCfmmYnmoALbRDwwZOVxLqvFZGMOphdQiJ9eetSL7swpqPCUT/SHoa8Znb9WDQWt+MxqdVrbxSrLZrU9PRa7oFRob6U86grJzUFLyJh21QeM8g5lerC9GWe8LnzQAVLi+jLEYIrR+teG2Z/Llh87pS4uwqIFbxZ3PzxcKPSDW98WUVo7SRSJ0Y3N490hUsTXJYM7MB8zMob9dId8bg7kxNCwhwthVq5D/Q+eNQLmNv5LsQnaLpgW3cAJGLz5/7ig9RRBHElPTrz/IsQqGE5n9rnSF7mr1VxVXcRooThM+64QNzCJkHlwaF+cxd7q3ONAr3WAnfiWlb3IC3RnyLZjDqbaa1i2Mq1XZOVFPGAzsPLvji1y823nV8pjAhFnsilcLHVWhZ4olADnExlzkbVMbpNgiT7AjuPbm3Th0FBAu3HVg+AZ/Iu8fa3xfCzY8BLDDv+6r1OleJXi/0SS6dMoVYNvMc430gH3PDUyO8ZWIKo5sxibc4CRXkohlmxv1VE5HcveeNQ/L1hgkjvacAnfV/fN2BMUigiuGgsMu5F8TCUZh/Xb8S+ninRmtE5a/whxC1RxbLxMvLuAko7WeEnf3UP+OFnrXIIqR/YViWRDW70cn/k3EqWpFVw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ef7322-e740-4840-7e0b-08d87fb51a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 04:58:28.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abUzhl1NYQCdZ9mmzHtAOrBxoy5FXcIdN+xUy/7hhN1cutG1e3W1i05BROz9ltN7jiJiUxGUm2+2phucHOdOYhI5tF9oqsF8T4qnl0Hy7R0+jkraCjvXlVuZ2KAg7JD1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2890
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob.

Thanks for the review.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, October 28, 2020 10:23 PM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: bhelgaas@google.com; lorenzo.pieralisi@arm.com; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
>=20
> On Tue, Oct 27, 2020 at 02:00:11PM +0800, Wan Ahmad Zainie wrote:
> > Add driver for Intel Keem Bay SoC PCIe controller. This controller is
> > based on DesignWare PCIe core.
> >
> > In root complex mode, only internal reference clock is possible for
> > Keem Bay A0. For Keem Bay B0, external reference clock can be used and
> > will be the default configuration. Currently, keembay_pcie_of_data
> > structure has one member. It will be expanded later to handle this
> > difference.
> >
> > Endpoint mode link initialization is handled by the boot firmware.
> >
> > Signed-off-by: Wan Ahmad Zainie
> > <wan.ahmad.zainie.wan.mohamad@intel.com>
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig        |  24 +
> >  drivers/pci/controller/dwc/Makefile       |   1 +
> >  drivers/pci/controller/dwc/pcie-keembay.c | 658
> > ++++++++++++++++++++++
> >  3 files changed, 683 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig
> > b/drivers/pci/controller/dwc/Kconfig
> > index bc049865f8e0..694a1fcacb73 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -219,6 +219,30 @@ config PCIE_INTEL_GW
> >  	  The PCIe controller uses the DesignWare core plus Intel-specific
> >  	  hardware wrappers.
> >
> > +config PCIE_KEEMBAY
> > +	bool
> > +
> > +config PCIE_KEEMBAY_HOST
> > +	bool "Intel Keem Bay PCIe controller - Host mode"
> > +	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
>=20
> Why only ARM64 for compile test?

Andy did response to this.
https://lore.kernel.org/linux-pci/20201028153454.GV4077@smile.fi.intel.com/

I did not receive it my mailbox, so I copy paste here, in case.

>=20
> > +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> > +	select PCIE_DW_HOST
> > +	select PCIE_KEEMBAY
> > +	help
> > +	  Say Y here to enable support for the PCIe controller in Keem Bay
> > +	  to work in host mode. This uses the DesignWare core.
> > +
> > +config PCIE_KEEMBAY_EP
> > +	bool "Intel Keem Bay PCIe controller - Endpoint mode"
> > +	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
> > +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> > +	depends on PCI_ENDPOINT
> > +	select PCIE_DW_EP
> > +	select PCIE_KEEMBAY
> > +	help
> > +	  Say Y here to enable support for the PCIe controller in Keem Bay
> > +	  to work in endpoint mode. This uses the DesignWare core.
> > +
> >  config PCIE_KIRIN
> >  	depends on OF && (ARM64 || COMPILE_TEST)
> >  	bool "HiSilicon Kirin series SoCs PCIe controllers"
> > diff --git a/drivers/pci/controller/dwc/Makefile
> > b/drivers/pci/controller/dwc/Makefile
> > index a751553fa0db..95da2c62c426 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
> >  obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
> >  obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
> >  obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
> > +obj-$(CONFIG_PCIE_KEEMBAY) +=3D pcie-keembay.o
> >  obj-$(CONFIG_PCIE_KIRIN) +=3D pcie-kirin.o
> >  obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
> >  obj-$(CONFIG_PCI_MESON) +=3D pci-meson.o diff --git
> > a/drivers/pci/controller/dwc/pcie-keembay.c
> > b/drivers/pci/controller/dwc/pcie-keembay.c
> > new file mode 100644
> > index 000000000000..30401ef223ca
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> > @@ -0,0 +1,658 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe controller driver for Intel Keem Bay
> > + * Copyright (C) 2020 Intel Corporation  */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/init.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +/* PCIE_REGS_APB_SLV Registers */
> > +#define PCIE_REGS_PCIE_CFG		0x0004
> > +#define  PCIE_DEVICE_TYPE		BIT(8)
> > +#define  PCIE_RSTN			BIT(0)
> > +#define PCIE_REGS_PCIE_APP_CNTRL	0x0008
> > +#define  APP_LTSSM_ENABLE		BIT(0)
> > +
> > +#define PCIE_REGS_PCIE_INTR_ENABLE	0x0018
> > +#define  LBC_CII_EVENT_EN		BIT(18)
> > +#define PCIE_REGS_PCIE_INTR_FLAGS	0x001c
> > +#define PCIE_REGS_PCIE_ERR_INTR_ENABLE	0x0020
> > +#define  LINK_REQ_RST_EN		BIT(15)
> > +#define PCIE_REGS_PCIE_ERR_INTR_FLAGS	0x0024
> > +#define PCIE_REGS_INTERRUPT_ENABLE	0x0028
> > +#define  MSI_CTRL_INT_EN		BIT(8)
> > +#define  EDMA_INT_EN			GENMASK(7, 0)
> > +#define PCIE_REGS_INTERRUPT_STATUS	0x002c
> > +#define  MSI_CTRL_INT			BIT(8)
> > +
> > +#define PCIE_REGS_PCIE_SII_PM_STATE	0x00b0
> > +#define  SMLH_LINK_UP			BIT(19)
> > +#define  RDLH_LINK_UP			BIT(8)
> > +#define PCIE_REGS_PCIE_PHY_CNTL		0x0164
> > +#define  PHY0_SRAM_BYPASS		BIT(8)
> > +#define PCIE_REGS_PCIE_PHY_STAT		0x0168
> > +#define  PHY0_MPLLA_STATE		BIT(1)
> > +#define PCIE_REGS_LJPLL_STA		0x016c
> > +#define  LJPLL_LOCK			BIT(0)
> > +#define PCIE_REGS_LJPLL_CNTRL_0		0x0170
> > +#define  LJPLL_EN			BIT(29)
> > +#define  LJPLL_FOUT_EN			GENMASK(24, 21)
> > +#define PCIE_REGS_LJPLL_CNTRL_2		0x0178
> > +#define  LJPLL_REF_DIV			GENMASK(17, 12)
> > +#define  LJPLL_FB_DIV			GENMASK(11, 0)
> > +#define PCIE_REGS_LJPLL_CNTRL_3		0x017c
> > +#define  LJPLL_POST_DIV3A		GENMASK(24, 22)
> > +#define  LJPLL_POST_DIV2A		GENMASK(18, 16)
> > +
> > +#define PCIE_REGS_MEM_ACCESS_IRQ_ENABLE	0x0184
> > +#define  MEM_ACCESS_IRQ_ENABLE		GENMASK(31, 0)
> > +
> > +#define PCIE_DBI2_MASK		BIT(20)
> > +#define PERST_DELAY_US		1000
> > +#define AUX_CLK_RATE_HZ		24000000
> > +
> > +struct keembay_pcie {
> > +	struct dw_pcie		*pci;
>=20
> Make this a struct, not a pointer. Then one less alloc.

I will fix in v2.

>=20
> > +	void __iomem		*apb_base;
> > +	enum dw_pcie_device_mode mode;
> > +
> > +	int			irq;
> > +	int			ev_irq;
> > +	int			err_irq;
> > +	int			mem_access_irq;
>=20
> There's no need to store the irq numbers forever.

I will fix this in v2.
Need to modify keembay_pcie_setup_irq().

>=20
> > +
> > +	struct clk		*clk_master;
> > +	struct clk		*clk_aux;
> > +	struct gpio_desc	*reset;
> > +};
> > +
> > +struct keembay_pcie_of_data {
> > +	enum dw_pcie_device_mode mode;
> > +};
> > +
> > +static inline u32 keembay_pcie_readl(struct keembay_pcie *pcie, u32
> > +offset) {
> > +	return readl(pcie->apb_base + offset); }
> > +
> > +static inline void keembay_pcie_writel(struct keembay_pcie *pcie, u32
> offset,
> > +				       u32 value)
> > +{
> > +	writel(value, pcie->apb_base + offset); }
> > +
> > +static void keembay_ep_reset_assert(struct keembay_pcie *pcie) {
> > +	gpiod_set_value_cansleep(pcie->reset, 1);
> > +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500); }
> > +
> > +static void keembay_ep_reset_deassert(struct keembay_pcie *pcie) {
> > +	/* Ensure that PERST has been asserted for at least 100ms */
> > +	msleep(100);
> > +
> > +	gpiod_set_value_cansleep(pcie->reset, 0);
> > +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500); }
> > +
> > +static void keembay_pcie_ltssm_enable(struct keembay_pcie *pcie, bool
> > +enable) {
> > +	u32 val;
> > +
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_APP_CNTRL);
> > +	if (enable)
> > +		val |=3D APP_LTSSM_ENABLE;
> > +	else
> > +		val &=3D ~APP_LTSSM_ENABLE;
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_APP_CNTRL, val); }
> > +
> > +static int keembay_pcie_link_up(struct dw_pcie *pci) {
> > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > +	u32 val, mask;
> > +
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_SII_PM_STATE);
> > +	mask =3D SMLH_LINK_UP | RDLH_LINK_UP;
> > +
> > +	return !!((val & mask) =3D=3D mask);
> > +}
> > +
> > +static int keembay_pcie_establish_link(struct dw_pcie *pci)
>=20
> _start_link() to align with the ops name.

I will fix in v2.

>=20
> > +{
> > +	return 0;
>=20
> Shouldn't this call keembay_pcie_ltssm_enable?

Prior to changes in for-kernelci branch, start_link ops is
used for endpoint mode only. Since Keem Bay endpoint
initialization is done by boot firmware, I override this ops
to return 0.

>=20
> > +}
> > +
> > +static void keembay_pcie_stop_link(struct dw_pcie *pci) {
> > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > +
> > +	keembay_pcie_ltssm_enable(pcie, false); }
> > +
> > +static const struct dw_pcie_ops keembay_pcie_ops =3D {
> > +	.link_up	=3D keembay_pcie_link_up,
> > +	.start_link	=3D keembay_pcie_establish_link,
> > +	.stop_link	=3D keembay_pcie_stop_link,
> > +};
> > +
> > +/*
> > + * Initialize the internal PCIe PLL in Host mode.
> > + * See the following sections in Keem Bay data book,
> > + * (1) 6.4.6.1 PCIe Subsystem Example Initialization,
> > + * (2) 6.8 PCIe Low Jitter PLL for Ref Clk Generation.
> > + */
> > +static int keembay_pcie_pll_init(struct keembay_pcie *pcie) {
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	u32 val;
> > +	int ret;
> > +
> > +	val =3D FIELD_PREP(LJPLL_REF_DIV, 0) | FIELD_PREP(LJPLL_FB_DIV,
> 0x32);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_LJPLL_CNTRL_2, val);
> > +
> > +	val =3D FIELD_PREP(LJPLL_POST_DIV3A, 0x2) |
> > +		FIELD_PREP(LJPLL_POST_DIV2A, 0x2);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_LJPLL_CNTRL_3, val);
> > +
> > +	val =3D FIELD_PREP(LJPLL_EN, 0x1) | FIELD_PREP(LJPLL_FOUT_EN, 0xc);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_LJPLL_CNTRL_0, val);
> > +
> > +	ret =3D readl_poll_timeout(pcie->apb_base + PCIE_REGS_LJPLL_STA,
> > +				 val, val & LJPLL_LOCK, 20,
> > +				 500 * USEC_PER_MSEC);
> > +	if (ret)
> > +		dev_err(pci->dev, "Low jitter PLL is not locked\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static irqreturn_t keembay_pcie_irq_handler(int irq, void *arg) {
> > +	struct keembay_pcie *pcie =3D arg;
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	struct pcie_port *pp =3D &pci->pp;
> > +	u32 val, mask, status;
> > +
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_INTERRUPT_STATUS);
> > +	mask =3D keembay_pcie_readl(pcie, PCIE_REGS_INTERRUPT_ENABLE);
> > +
> > +	status =3D val & mask;
> > +	if (!status)
> > +		return IRQ_NONE;
> > +
> > +	if (status & MSI_CTRL_INT)
> > +		dw_handle_msi_irq(pp);
> > +
> > +	keembay_pcie_writel(pcie, PCIE_REGS_INTERRUPT_STATUS, status);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t keembay_pcie_ev_irq_handler(int irq, void *arg) {
> > +	struct keembay_pcie *pcie =3D arg;
> > +	u32 val, mask, status;
> > +
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_INTR_FLAGS);
> > +	mask =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_INTR_ENABLE);
> > +
> > +	status =3D val & mask;
> > +	if (!status)
> > +		return IRQ_NONE;
> > +
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_INTR_FLAGS, status);
>=20
> Why an interrupt handler that doesn't do anything?

I will fix in v2, remove unused interrupt handler.

>=20
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t keembay_pcie_err_irq_handler(int irq, void *arg) {
> > +	struct keembay_pcie *pcie =3D arg;
> > +	u32 val, mask, status;
> > +
> > +	val =3D keembay_pcie_readl(pcie,
> PCIE_REGS_PCIE_ERR_INTR_FLAGS);
> > +	mask =3D keembay_pcie_readl(pcie,
> PCIE_REGS_PCIE_ERR_INTR_ENABLE);
> > +
> > +	status =3D val & mask;
> > +	if (!status)
> > +		return IRQ_NONE;
> > +
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_ERR_INTR_FLAGS,
> status);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int keembay_pcie_setup_irq(struct keembay_pcie *pcie) {
> > +
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	int ret;
> > +
> > +	pcie->irq =3D platform_get_irq_byname(pdev, "intr");
> > +	if (pcie->irq < 0)
> > +		return pcie->irq;
> > +
> > +	pcie->ev_irq =3D platform_get_irq_byname(pdev, "ev_intr");
> > +	if (pcie->ev_irq < 0)
> > +		return pcie->ev_irq;
> > +
> > +	pcie->err_irq =3D platform_get_irq_byname(pdev, "err_intr");
> > +	if (pcie->err_irq < 0)
> > +		return pcie->err_irq;
> > +
> > +	if (pcie->mode =3D=3D DW_PCIE_EP_TYPE) {
> > +		int irq;
> > +
> > +		irq =3D platform_get_irq_byname(pdev, "mem_access_intr");
> > +		if (irq < 0)
> > +			return irq;
> > +
> > +		pcie->mem_access_irq =3D irq;
> > +		return 0;
> > +	}
> > +
> > +	ret =3D devm_request_irq(dev, pcie->irq, keembay_pcie_irq_handler,
> > +			       IRQF_SHARED | IRQF_NO_THREAD, "pcie-intr",
> pcie);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to request IRQ: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_request_irq(dev, pcie->ev_irq,
> keembay_pcie_ev_irq_handler,
> > +			       0, "pcie-ev-intr", pcie);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to request event IRQ: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D devm_request_irq(dev, pcie->err_irq,
> keembay_pcie_err_irq_handler,
> > +			       0, "pcie-err-intr", pcie);
> > +	if (ret)
> > +		dev_err(dev, "Failed to request error IRQ: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int keembay_pcie_rc_establish_link(struct dw_pcie *pci) {
> > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > +	u32 val;
> > +	int ret;
> > +
> > +	if (dw_pcie_link_up(pci))
> > +		return 0;
> > +
> > +	keembay_pcie_ltssm_enable(pcie, false);
> > +
> > +	ret =3D readl_poll_timeout(pcie->apb_base +
> PCIE_REGS_PCIE_PHY_STAT,
> > +				 val, val & PHY0_MPLLA_STATE, 20,
> > +				 500 * USEC_PER_MSEC);
> > +	if (ret) {
> > +		dev_err(pci->dev, "MPLLA is not locked\n");
> > +		return ret;
> > +	}
> > +
> > +	keembay_pcie_ltssm_enable(pcie, true);
> > +
> > +	return dw_pcie_wait_for_link(pci);
> > +}
> > +
> > +static void keembay_pcie_enable_interrupts(struct keembay_pcie *pcie)
> > +{
> > +	u32 val;
> > +
> > +	/* Enable interrupt */
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_INTERRUPT_ENABLE);
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > +		val |=3D MSI_CTRL_INT_EN;
> > +
> > +	keembay_pcie_writel(pcie, PCIE_REGS_INTERRUPT_ENABLE, val);
> > +
> > +	/* Enable event interrupt */
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_INTR_ENABLE);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_INTR_ENABLE, val);
> > +
> > +	/* Enable error interrupt */
> > +	val =3D keembay_pcie_readl(pcie,
> PCIE_REGS_PCIE_ERR_INTR_ENABLE);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_ERR_INTR_ENABLE,
> val); }
> > +
> > +static int __init keembay_pcie_host_init(struct pcie_port *pp) {
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > +	int ret;
> > +
> > +	dw_pcie_setup_rc(pp);
> > +	ret =3D keembay_pcie_rc_establish_link(pci);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > +		dw_pcie_msi_init(pp);
> > +
> > +	keembay_pcie_enable_interrupts(pcie);
> > +
> > +	/* Disable BARs */
>=20
> Why? I don't see other DWC drivers doing this.

Looks like it is a Keem Bay specific requirement.

It is specified in Keem Bay data book [1]. I quote Section 6.4.9.3.2,
"As BAR0 is configured to have its incoming requests routed to TRGT0 in EP =
mode,
then you must disable that BAR (through a DBI write) when operating the con=
troller
in RC mode."

[1] https://cdrdv2.intel.com/v1/dl/getContent/615086

>=20
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0 | PCIE_DBI2_MASK,
> 0);
> > +	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1 | PCIE_DBI2_MASK,
> 0);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_host_ops keembay_pcie_host_ops =3D {
> > +	.host_init	=3D keembay_pcie_host_init,
> > +};
> > +
> > +static void keembay_pcie_ep_init(struct dw_pcie_ep *ep) {
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > +	u32 val;
> > +
> > +	/* Enable DMA completion/error interrupts */
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_INTERRUPT_ENABLE);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_INTERRUPT_ENABLE,
> > +			    val | EDMA_INT_EN);
> > +
> > +	/* Enable CII event interrupt */
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_INTR_ENABLE);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_INTR_ENABLE,
> > +			    val | LBC_CII_EVENT_EN);
> > +
> > +	/* Enable link request reset */
> > +	val =3D keembay_pcie_readl(pcie,
> PCIE_REGS_PCIE_ERR_INTR_ENABLE);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_ERR_INTR_ENABLE,
> > +			    val | LINK_REQ_RST_EN);
> > +
> > +	/* Enable host memory access interrupt */
> > +	keembay_pcie_writel(pcie, PCIE_REGS_MEM_ACCESS_IRQ_ENABLE,
> > +			    MEM_ACCESS_IRQ_ENABLE);
> > +}
> > +
> > +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8
> func_no,
> > +				     enum pci_epc_irq_type type,
> > +				     u16 interrupt_num)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_LEGACY:
> > +		/* Legacy interrupts are not supported in Keem Bay */
> > +		dev_err(pci->dev, "Unsupported IRQ type\n");
> > +		return -EINVAL;
> > +	case PCI_EPC_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no,
> interrupt_num);
> > +	case PCI_EPC_IRQ_MSIX:
> > +		return dw_pcie_ep_raise_msix_irq(ep, func_no,
> interrupt_num);
> > +	default:
> > +		dev_err(pci->dev, "Unknown IRQ type\n");
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct pci_epc_features keembay_pcie_epc_features =3D {
> > +	.linkup_notifier	=3D false,
> > +	.msi_capable		=3D true,
> > +	.msix_capable		=3D true,
> > +	.reserved_bar		=3D BIT(BAR_1) | BIT(BAR_3) | BIT(BAR_5),
> > +	.bar_fixed_64bit	=3D BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> > +	.align			=3D SZ_16K,
> > +};
> > +
> > +static const struct pci_epc_features *
> > +keembay_pcie_get_features(struct dw_pcie_ep *ep) {
> > +	return &keembay_pcie_epc_features;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops keembay_pcie_ep_ops =3D {
> > +	.ep_init	=3D keembay_pcie_ep_init,
> > +	.raise_irq	=3D keembay_pcie_ep_raise_irq,
> > +	.get_features	=3D keembay_pcie_get_features,
> > +};
> > +
> > +static inline struct clk *keembay_pcie_probe_clock(struct device *dev,
> > +						   const char *id, u64 rate)
> > +{
> > +	struct clk *clk;
> > +	int ret;
> > +
> > +	clk =3D devm_clk_get(dev, id);
> > +	if (IS_ERR(clk))
> > +		return clk;
> > +
> > +	if (rate) {
> > +		ret =3D clk_set_rate(clk, rate);
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(clk);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	ret =3D devm_add_action_or_reset(dev,
> > +				       (void(*)(void *))clk_disable_unprepare,
> > +				       clk);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	return clk;
> > +}
> > +
> > +static int keembay_pcie_probe_clocks(struct keembay_pcie *pcie) {
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +
> > +	pcie->clk_master =3D keembay_pcie_probe_clock(dev, "master", 0);
> > +	if (IS_ERR(pcie->clk_master))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->clk_master),
> > +				     "Failed to enable master clock");
> > +
> > +	pcie->clk_aux =3D keembay_pcie_probe_clock(dev, "aux",
> AUX_CLK_RATE_HZ);
> > +	if (IS_ERR(pcie->clk_aux))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->clk_aux),
> > +				     "Failed to enable auxiliary clock");
> > +
> > +	return 0;
> > +}
> > +
> > +static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
> > +				      struct platform_device *pdev) {
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	struct pcie_port *pp =3D &pci->pp;
> > +	struct device *dev =3D &pdev->dev;
> > +	u32 val;
> > +	int ret;
> > +
> > +	pcie->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(pcie->reset))
> > +		return PTR_ERR(pcie->reset);
> > +
> > +	ret =3D keembay_pcie_probe_clocks(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Set SRAM bypass mode. */
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_PHY_CNTL);
> > +	val |=3D PHY0_SRAM_BYPASS;
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_PHY_CNTL, val);
> > +
> > +	/* Set the PCIe controller to be a Root Complex. */
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_CFG,
> PCIE_DEVICE_TYPE);
> > +
> > +	ret =3D keembay_pcie_pll_init(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Deassert PCIe subsystem power-on-reset. */
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_CFG);
> > +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_CFG, val | PCIE_RSTN);
>=20
> Doesn't EP mode need to do all this setup too?

For Keem Bay, endpoint mode link initialization should be done by
boot firmware.

>=20
> > +
> > +	keembay_ep_reset_deassert(pcie);
> > +
> > +	ret =3D keembay_pcie_setup_irq(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pp->ops =3D &keembay_pcie_host_ops;
> > +
> > +	ret =3D dw_pcie_host_init(pp);
> > +	if (ret) {
> > +		keembay_ep_reset_assert(pcie);
> > +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int keembay_pcie_add_pcie_ep(struct keembay_pcie *pcie,
> > +				    struct platform_device *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	struct dw_pcie_ep *ep;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	ep =3D &pci->ep;
> > +	ep->ops =3D &keembay_pcie_ep_ops;
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "addr_space");
> > +	if (!res)
> > +		return -EINVAL;
> > +
> > +	ep->phys_base =3D res->start;
> > +	ep->addr_size =3D resource_size(res);
> > +
> > +	ret =3D keembay_pcie_setup_irq(pcie);
>=20
> Both RC and EP mode call this. Should be done from a common spot
> (probe?).

I will fix in v2, call keembay_pcie_setup_irq() from probe().

>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D dw_pcie_ep_init(ep);
> > +	if (ret)
> > +		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int keembay_pcie_probe(struct platform_device *pdev) {
> > +	const struct keembay_pcie_of_data *data;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct keembay_pcie *pcie;
> > +	struct dw_pcie *pci;
> > +	enum dw_pcie_device_mode mode;
> > +	int ret;
> > +
> > +	data =3D device_get_match_data(dev);
> > +	if (!data)
> > +		return -ENODEV;
> > +
> > +	mode =3D (enum dw_pcie_device_mode)data->mode;
> > +
> > +	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	pci =3D devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > +	if (!pci)
> > +		return -ENOMEM;
> > +
> > +	pci->dev =3D dev;
> > +	pci->ops =3D &keembay_pcie_ops;
> > +
> > +	pcie->pci =3D pci;
> > +	pcie->mode =3D mode;
> > +
> > +	pcie->apb_base =3D
> devm_platform_ioremap_resource_byname(pdev, "apb");
> > +	if (IS_ERR(pcie->apb_base))
> > +		return PTR_ERR(pcie->apb_base);
> > +
> > +	pci->dbi_base =3D devm_platform_ioremap_resource_byname(pdev,
> "dbi");
> > +	if (IS_ERR(pci->dbi_base))
> > +		return PTR_ERR(pci->dbi_base);
> > +
> > +	/* DBI2 shadow register */
> > +	pci->dbi_base2 =3D pci->dbi_base + PCIE_DBI2_MASK;
>=20
> This should be a 'dbi2' reg entry in DT.
>=20
> FYI, I'm working on moving that and 'dbi' setup into the core code.

Noted. I did take a look into for-kernelci branch.

I need advice on how I should move forward.
Should I rebase my changes to for-kernelci or mainline branch?

>=20
> > +
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	switch (pcie->mode) {
> > +	case DW_PCIE_RC_TYPE:
> > +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> > +			return -ENODEV;
> > +
> > +		ret =3D keembay_pcie_add_pcie_port(pcie, pdev);
> > +		if (ret < 0)
> > +			return ret;
> > +		break;
> > +	case DW_PCIE_EP_TYPE:
> > +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> > +			return -ENODEV;
> > +
> > +		ret =3D keembay_pcie_add_pcie_ep(pcie, pdev);
> > +		if (ret < 0)
> > +			return ret;
> > +		break;
> > +	default:
> > +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct keembay_pcie_of_data keembay_pcie_rc_of_data =3D {
> > +	.mode =3D DW_PCIE_RC_TYPE,
> > +};
> > +
> > +static const struct keembay_pcie_of_data keembay_pcie_ep_of_data =3D {
> > +	.mode =3D DW_PCIE_EP_TYPE,
> > +};
> > +
> > +static const struct of_device_id keembay_pcie_of_match[] =3D {
> > +	{
> > +		.compatible =3D "intel,keembay-pcie",
> > +		.data =3D &keembay_pcie_rc_of_data,
> > +	},
> > +	{
> > +		.compatible =3D "intel,keembay-pcie-ep",
> > +		.data =3D &keembay_pcie_ep_of_data,
> > +	},
> > +	{}
> > +};
> > +
> > +static struct platform_driver keembay_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "keembay-pcie",
> > +		.of_match_table =3D keembay_pcie_of_match,
> > +		.suppress_bind_attrs =3D true,
> > +	},
> > +	.probe  =3D keembay_pcie_probe,
> > +};
> > +builtin_platform_driver(keembay_pcie_driver);
> > --
> > 2.17.1
> >

Best regards,
Zainie
