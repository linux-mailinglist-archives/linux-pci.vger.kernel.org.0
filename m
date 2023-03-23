Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476C66C6664
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 12:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCWLST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 07:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCWLSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 07:18:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D8F9774;
        Thu, 23 Mar 2023 04:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngeleWkqRbJpBi2MTR86wJnwwEnfg1xedlMx/eQ/chwGIEbWopBYLO7StMN6O+juxkygLr5ooy5XAZaMcmzDDPlXPBC4BDw19dcBo2mRBczKfTp7dVlvgQxkJNVUUWyh5LBNwK2Gq+5040Si+VEcqs2gAeviRK8aioocUyVoA4hcME5kvW4xESCJGiR0oJ0GWl04pHtck6XTyvyZVKPj1Sqp5KZi46er06l4gnE+nRFJwCW3YvDrW3FBltvOoPEmypT3lf3GHnLR3bTRG2zj7QOPerw/7biiwetCoOfvD8iGfr7nigaxPW3cLUOUoCIgzKP7azDK4Vw+VVCeTywGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPb26vJVzQOtbJA7aPRj1TWKgFH2nkkGWOPEfkPZ+iE=;
 b=mX10GMUOH6K4pdjshAns10FqfDhcozm2KjV97vykob1h0+DDIuynEp7FddRXAsaOksr9UzeA3PbMhcU/pQVyv+AImybSYni5+blersgLskq8JVOwi56W/XdlqWtWk5kG1RI2YGwvavtSrJk04vFpp/OETNlQrnYatmenbZxngXTSuQCkuW3FvwK1lnUPkxD0U4fyXp45Cxo203L6Il9fr7Mz2pFdzb+0KNpV9hD9PWkZMyxGOwnVJnfWTbqCMDX42r+hPnZVF7lFnfMyW7w8E69YE2Ay7uHMF/Hre2BM1i3aOHahGkc2pJO4M3bZeNJ/YNx+mML2SHy5CprlOR8l2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPb26vJVzQOtbJA7aPRj1TWKgFH2nkkGWOPEfkPZ+iE=;
 b=aQioAfWhbuzOV+dY3HInR8Reva2k9u3e4cFymnDNST/lliqxOMgn0g9/vbpeqFluPhwDOzxsykENoaXKMXPqcORt9uEkzjJgBIXfk9ZZE7xc8ttXHSVkduHOX8PpLXIFuvrnvoSLq6FcHViOQBgoe/d6OwTMhAJikWdk86uIZhQ=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB7852.jpnprd01.prod.outlook.com
 (2603:1096:604:161::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 11:18:11 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 11:18:10 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v11 11/13] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint
 support
Thread-Topic: [PATCH v11 11/13] PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe
 Endpoint support
Thread-Index: AQHZU0zER1ry4FpIrEeoK7hT/cNle68HKNsAgAEfNnA=
Date:   Thu, 23 Mar 2023 11:18:10 +0000
Message-ID: <TYBPR01MB534143FDC8A5B1236D306A11D8879@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-12-yoshihiro.shimoda.uh@renesas.com>
 <20230322175712.prq532cic2z3dhja@mobilestation>
In-Reply-To: <20230322175712.prq532cic2z3dhja@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB7852:EE_
x-ms-office365-filtering-correlation-id: b07b3c1a-c978-4b94-2a22-08db2b904951
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVUNnr1BwKwhtgKh6yu1fMm9BFcveeI6pHsgcRBg/bnKamh/wF2WLuwLw88Bu9Y06kvflVMA2SSHyQRPq3d9knF92sVUQE9ebe/c1ran4GoIpoGqYa3zK+T14Z3LeDCSjDLxv8PZIDoMZX2oTiCerwSUlb7e6woB2eAKfJ02yHx/2o6GgyAvtzk9WoWHs4r/9BkpgGc8KaUjqViLIUTQylrQgDXKFCZ/K+KbttAZnBRWz7exkKDBKwm1iHNzN6Zpab6mjPYN+NdEZLB6FAlqaNlvwrTtQ609XmxcC12uaK4hpwsMPygkM/p0c7yrO4660j/JImUxVlScdN9E1hqk1WJWjCdjGNSnKIPgV8dFaD1IiCdPDDzUuOf0uu/WwgqPQU0yusd2jPyd2rpifbPsd1RN9BETtf2lEImzGQ8WFZWAQOmrf5q98zBEfNxdpCz6Bn8xvpXl3DrHq+5t+5jQjuZXSEI1PVm87mbmCpbFG9iGgI7tn08q49P7nMdSWJj1j+2mVLbieTBY0NlwP6/uf5I0p48bsqCBdkWaI56CDloiO2JuFV4Al5w+E9lWmwSSMdXJn0lL9gJEf4cDkeeq7EaJtQ20SuNLTkt5hCoazRoJ+WKlkB9EWX37/WLkCgt8eWud9XCzSxgidCYVD5GvG/g8wWpGwLKJoMH7LfQOyzl/lj8kVwKHTZh38OYZNd5eUesOmBIRDb2UElVZechWtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199018)(8936002)(52536014)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(41300700001)(4326008)(6916009)(86362001)(8676002)(33656002)(38100700002)(122000001)(9686003)(6506007)(38070700005)(55016003)(186003)(83380400001)(316002)(7696005)(478600001)(71200400001)(54906003)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MerIaQHCeFZbTEyp+vyK4szhwdgXXBMl2J1KSS+mIOdSnxG/PRbJSvAs6cgv?=
 =?us-ascii?Q?QvebrkJWSfiU1S3KMoKyV94/v8zYjfqUXp+zesvRnlEwqOKkezxZBbfbeMuI?=
 =?us-ascii?Q?dKHK5KvGZ0bFK2w+RYjKLQt4kwU7wk2W1Y8biyxczyWex2UrCktNfF5yZQRi?=
 =?us-ascii?Q?EahT3YbHyDlbs/miItdIX6Iy42/4yq8137XXA56cRUCxhyOh/vKGOGlb6Npb?=
 =?us-ascii?Q?B75uRXBJZM1hFmaL9YRyBtu0YiWc2UP34GwWB9QfsowOPOu/xjbt6xz6w9R0?=
 =?us-ascii?Q?/Z+DBm2a49HbXubsctX4iv2ExupdGM8Bum0z5QHef8dq2vjFb2gtAUL1W39J?=
 =?us-ascii?Q?ry0pMtHTS93/s67VAn+yKVuhA5FUxLLFBlJwTJekUmxoltApgBmcZwPGcCOA?=
 =?us-ascii?Q?6nLyFfSVCkPEcKnG2rM9z0IxlBdxVMsWSefM+qhbswL9fP0vx3t+9sJgEcZc?=
 =?us-ascii?Q?5iVGTdVILxHEREnu12hFyZbvfwgnApZEo11EOkJyYYYZ7Qqplf1cv8qqXZbr?=
 =?us-ascii?Q?CVQiIqLbkM5+bonwx+hG4szgstQFO2MPfDQGgZse9BgnYGzlQk5ONn+gNlc9?=
 =?us-ascii?Q?LGBa+ZvYJaxgxRxKhEXLIyrD+6eUSt6ymyLngW3a0Et4stCtxf8A09YOmMMa?=
 =?us-ascii?Q?J3WB8onw8e3Ce0ZMKOBAfOJqn4/n2j4XZrZMl6QCFB8eaPlmwDvx7QKwQitD?=
 =?us-ascii?Q?eMohAsPpoJaGPlFdXtRf4l0Bz8ImufNfPskdx7zpsqlCbrDlzsAr8XWEELZQ?=
 =?us-ascii?Q?Dr4jCpk40PGn0FdcCY6Qn1rL+glPehMpPuwkkQ/r0yuMFIf6Q7eI2J0JLVP0?=
 =?us-ascii?Q?6W36++phqGT9Lgd7T8lg1XO7vtT4BWEdlNWPyhOCBfoToTCQGiKaEoU9JFAd?=
 =?us-ascii?Q?oA272CxJP6QK6+Q4mj6GU9yfyUEObgud6XQPi1pcNahN3kj7VzeXKz9NCQUr?=
 =?us-ascii?Q?V0zC4ycihzyXwFblbIgPaY6WUDpFNY62f4pk5goIE1AqZef8/JVEVwUFhodA?=
 =?us-ascii?Q?rAvclMAC1P/BaplyluhgEh03tRehuc5s/Gwtj5cZkYgHj36NhKEijXRDKpd+?=
 =?us-ascii?Q?IaI5MGLnE9adQqQoL3MA5wjbwHU+qShci1vFOEGdJAXpKNPyZfpQqUOKodP2?=
 =?us-ascii?Q?kwBxTzLuh4l2ErpKYKqxqSu3Ik1WKQhz6kkepc/EGa+Ah47b+tDarpGHKZi0?=
 =?us-ascii?Q?qyTuBcjcHp6SkVVsS1I3iOzY1alPRiQjFrdPJUpSgdkjdpGDsJ/cVLyNvDa1?=
 =?us-ascii?Q?8+ZGnvwGTjzvQ84SfanGz+IxRTInuu+Ye+PP6Ec20p91scytps6eWL7sc/0r?=
 =?us-ascii?Q?0BSX5bU/ZHNoctZt9b4tziIJhDFQMYbrp+UbciodcchSEe2CWvzrEY3s0nhc?=
 =?us-ascii?Q?nRMm5gVtKcV/eZy8rJ9lDnyI0ftfgjz1nCqYVdGFfxl7UUoab8VePWU0ExFl?=
 =?us-ascii?Q?y9lu5l6sBuzDV3kCFGG8lzpkfTPZ7bWOO3ZUXh5yXu0GseelMVzYfAHyVQMv?=
 =?us-ascii?Q?SZqlRl3wo1fMpIqPx93RhCpQTPKrHSV1GV5wQ6sEAgZlEufC3urdaD2t04zg?=
 =?us-ascii?Q?HcWTZ414OGSY4QsLdyf+2NF7is0M3pvMsl1M8UszLpLe3oH6umvBuM8o53ee?=
 =?us-ascii?Q?P0hzTkYJ1aODHp/eUcZ4jdiYMa0Aq75BCR+tISUHOd2sr1nP9FYEa8Ys3ilG?=
 =?us-ascii?Q?bmmUQQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07b3c1a-c978-4b94-2a22-08db2b904951
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 11:18:10.7773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HR6EfFT9CWN0vUDUMCgBgU2jzM/apbmebeV/zs20uQrTTIxzEJ0KmkptY5gPDjWdwIPX2bxYGvXXHebmqdyXJeD8hai5AlOQqTZp0HgYFyW5tpHXl0OJzIwYCHGuD4P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7852
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Thursday, March 23, 2023 2:57 AM
>=20
> On Fri, Mar 10, 2023 at 09:35:08PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Endpoint support. This controller is based on
> > Synopsys DesignWare PCIe.
> >
> > This controller requires vender-specific initialization before
> > .ep_init(). To use dw->dbi and dw->num-lanes in the initialization
> > code, introduce .ep_pre_init() into struct dw_pcie_ep_ops.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |   9 +
> >  drivers/pci/controller/dwc/Makefile           |   2 +
> >  .../pci/controller/dwc/pcie-designware-ep.c   |   3 +
> >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> >  .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 170 ++++++++++++++++++
> >  5 files changed, 185 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index 94805ec31a8f..f33e403c7b61 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -423,4 +423,13 @@ config PCIE_RCAR_GEN4
> >  	  Say Y here if you want PCIe host controller support on R-Car Gen4 S=
oCs.
> >  	  This uses the DesignWare core.
> >
> > +config PCIE_RCAR_GEN4_EP
> > +	tristate "Renesas R-Car Gen4 PCIe Endpoint controller"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_ENDPOINT
> > +	select PCIE_DW_EP
> > +	help
> > +	  Say Y here if you want PCIe endpoint controller support on R-Car Ge=
n4
> > +	  SoCs. This uses the DesignWare core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controll=
er/dwc/Makefile
> > index 486cf706b53d..0fb0bde26ac4 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -28,6 +28,8 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) +=3D pcie-uniphier-ep.=
o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) +=3D pcie-visconti.o
> >  pcie-rcar-gen4-host-drv-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-host=
.o
> >  obj-$(CONFIG_PCIE_RCAR_GEN4) +=3D pcie-rcar-gen4-host-drv.o
> > +pcie-rcar-gen4-ep-drv-objs :=3D pcie-rcar-gen4.o pcie-rcar-gen4-ep.o
> > +obj-$(CONFIG_PCIE_RCAR_GEN4_EP) +=3D pcie-rcar-gen4-ep-drv.o
> >
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 73b3844e8a09..8302053fa2da 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -763,6 +763,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	ep->phys_base =3D res->start;
> >  	ep->addr_size =3D resource_size(res);
> >
> > +	if (ep->ops->ep_pre_init)
> > +		ep->ops->ep_pre_init(ep);
> > +
> >  	dw_pcie_version_detect(pci);
> >
> >  	dw_pcie_iatu_detect(pci);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 1be74d2c3729..f2026ac8b02f 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -325,6 +325,7 @@ struct dw_pcie_rp {
> >  };
> >
> >  struct dw_pcie_ep_ops {
> > +	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
> >  	void	(*ep_init)(struct dw_pcie_ep *ep);
> >  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> >  			     enum pci_epc_irq_type type, u16 interrupt_num);
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c b/drivers/p=
ci/controller/dwc/pcie-rcar-gen4-ep.c
> > new file mode 100644
> > index 000000000000..4c763e5a6793
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe Endpoint driver for Renesas R-Car Gen4 Series SoCs
> > + * Copyright (C) 2022-2023 Renesas Electronics Corporation
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "pcie-rcar-gen4.h"
> > +#include "pcie-designware.h"
> > +
> > +/* Configuration */
> > +#define PCICONF3		0x000c
> > +#define  MULTI_FUNC		BIT(23)
> > +
> > +static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int val;
> > +
> > +	rcar_gen4_pcie_set_device_type(rcar, false, dw->num_lanes);
> > +
> > +	dw_pcie_dbi_ro_wr_en(dw);
> > +
> > +	/* Single function */
>=20
> > +	val =3D dw_pcie_readl_dbi(dw, PCICONF3);
>=20
> There is a special macro PCI_HEADER_TYPE for the respective 8bit
> field. You can use it together with the dw_pcie_readb_dbi() method.

Thank you for your comment. I got it.

> > +	val &=3D ~MULTI_FUNC;
>=20
> MULTI_FUNC is defined in the PCIe specification. What about updating
> the include/uapi/linux/pci_regs.h file instead of defining a local
> macro?

I got it. I'll fix this on v12.

> > +	dw_pcie_writel_dbi(dw, PCICONF3, val);
> > +
>=20
> > +	rcar_gen4_pcie_disable_bar(dw, BAR5MASKF);
>=20
> Generically this can be done by calling dw_pcie_ep_reset_bar(). It also
> writes zero to the shadow BARx CSRs. Otherwise please explain what is
> mapped at the 0x2000 offset with respect to the DBI base address.

You're correct. I'll drop this on v12.

> > +
> > +	dw_pcie_num_lanes_setup(dw, dw->num_lanes);
>=20
> * Please see my note to the respective patch.

I got it.

> > +
> > +	dw_pcie_dbi_ro_wr_dis(dw);
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_=
no,
> > +				       enum pci_epc_irq_type type,
> > +				       u16 interrupt_num)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_LEGACY:
> > +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +	case PCI_EPC_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(dw->dev, "UNKNOWN IRQ type\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pci_epc_features rcar_gen4_pcie_epc_features =3D {
> > +	.linkup_notifier =3D false,
> > +	.msi_capable =3D true,
> > +	.msix_capable =3D false,
> > +	.reserved_bar =3D 1 << BAR_5,
> > +	.align =3D SZ_1M,
> > +};
> > +
> > +static const struct pci_epc_features*
> > +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> > +{
> > +	return &rcar_gen4_pcie_epc_features;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> > +	.ep_pre_init =3D rcar_gen4_pcie_ep_pre_init,
> > +	.raise_irq =3D rcar_gen4_pcie_ep_raise_irq,
> > +	.get_features =3D rcar_gen4_pcie_ep_get_features,
> > +};
> > +
> > +static int rcar_gen4_add_pcie_ep(struct rcar_gen4_pcie *rcar,
> > +				 struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *dw =3D &rcar->dw;
> > +	struct dw_pcie_ep *ep;
> > +	int ret;
> > +
> > +	ep =3D &dw->ep;
> > +	ep->ops =3D &pcie_ep_ops;
> > +
> > +	ret =3D dw_pcie_ep_init(ep);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to initialize endpoint\n");
> > +		return ret;
> > +	}
> > +
>=20
> > +	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
>=20
> Most likely this needs to be done either in ep_pre_init or in the
> ep_init callback.

I think so. I'll fix it.

> > +
> > +	dw->ops->start_link(dw);
>=20
> Why do you need to start the link right away thus interfering with the
> PCI EP subsystem? It is supposed to be done by the PCIe EP core on
> demand from the user-space (see pci_epc_start() usage).

Thank you for pointed it out. I also realized this is strange.
I think I can drop this on v12.

> > +
> > +	return 0;
> > +}
> > +
> > +static void rcar_gen4_remove_pcie_ep(struct rcar_gen4_pcie *rcar)
> > +{
>=20
> > +	writel(0, rcar->base + PCIEDMAINTSTSEN);
>=20
> If we had dw_pcie_ep_ops.ep_deinit() this should have been done
> there...

I see. I'll create such a patch which add ep_deinit(), and disable
the irq from the function.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +	dw_pcie_ep_exit(&rcar->dw.ep);
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct rcar_gen4_pcie *rcar;
> > +	int err;
> > +
> > +	rcar =3D rcar_gen4_pcie_devm_alloc(dev);
> > +	if (!rcar)
> > +		return -ENOMEM;
> > +
> > +	err =3D rcar_gen4_pcie_get_resources(rcar, pdev);
> > +	if (err < 0) {
> > +		dev_err(dev, "Failed to request resource: %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, rcar);
> > +
> > +	err =3D rcar_gen4_pcie_prepare(rcar);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D rcar_gen4_add_pcie_ep(rcar, pdev);
> > +	if (err < 0)
> > +		goto err_add;
> > +
> > +	return 0;
> > +
> > +err_add:
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return err;
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> > +
> > +	rcar_gen4_remove_pcie_ep(rcar);
> > +	rcar_gen4_pcie_unprepare(rcar);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > +	{ .compatible =3D "renesas,rcar-gen4-pcie-ep", },
> > +	{},
> > +};
> > +
> > +static struct platform_driver rcar_gen4_pcie_ep_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "pcie-rcar-gen4-ep",
> > +		.of_match_table =3D rcar_gen4_pcie_of_match,
> > +	},
> > +	.probe =3D rcar_gen4_pcie_ep_probe,
> > +	.remove =3D rcar_gen4_pcie_ep_remove,
> > +};
> > +module_platform_driver(rcar_gen4_pcie_ep_driver);
> > +
> > +MODULE_DESCRIPTION("Renesas R-Car Gen4 PCIe endpoint controller driver=
");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
> >
