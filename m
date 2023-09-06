Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2E7936FB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 10:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjIFIQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIFIQU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 04:16:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53601BF;
        Wed,  6 Sep 2023 01:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxBEBisUSOYpP4xccTSJM/ivLENYizQbfFmsHen8TY3MLO72NPkxZ/9MuyglhNXFJwVODOCJl+CaWYR+Vj+ubN07a3oSX6w086lVXucIftnPKqr+rtDTb8K0Idrb5NHbkJOX5ahWv9ky2ftNmwdv3u/xg/INH2ZIGUOxcmjp/ATXO7kMzSItxMEFZj74DyjVvYoh0uyJy/0exrAkE1xmXKFsNdJM/TbEqK3U4yLI9jPttnZ9D4Gf8ogaRY598KADhE/QBtMusUBu+ZcslQZFrsqulxTAvpd0N1XjJ79v/geSPIg7P3ddGkvCMIfbX6S6tch+4TfH6w5zBUhnx7Ln9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXTMzOCR60V4LTsTp5EdWxyWIVVJVeUCi7G+jqk+Jc4=;
 b=NrhCq3LW3CgyaBPSUE6NnKtxsyHfbA6TEWwa9vznM4P0d1Sh5jbbZzALAyFuTs0/iiLPOQVP9i1Zz18mMqLRu6kYjhknjjZcbL97tnE0fG280TeR/Rkc9j32oeWfLoxBSRE9FEzkfUtdH6RvGj6UigcHoQf+N3b11sKc96rdqBO0qbwyYZHxAru5QOlgfzJZ4MwYLe2KCL6C18CQzdXWdiDgxU+LKpOZBv4JadfF13SgwgVUwJiEfJ3ZQ+cayvpGroAym+mlDLpB8qviaDSGqlAlfFzbphSySEvtjqYv6XUtnwUkSBJijkzAvxEA4mX06iFjUaL/3NStgxaFp4437g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXTMzOCR60V4LTsTp5EdWxyWIVVJVeUCi7G+jqk+Jc4=;
 b=SV3JCImg2sns7e4HthSxxindvnmxraW9m38MsByClurlWce6fEirQVyybTo1cMfEkPQxDAs06G21XO9MHMuPtLzbuQEEIOxWW8072QkQw//y6wpxHDH1IZsluO7jEiUI1pwbYnKUk7gjoF/5TNtRs9rctHESjA8vDvZ4uXtK41E=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by CH0PR12MB5172.namprd12.prod.outlook.com (2603:10b6:610:bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 08:16:11 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 08:16:11 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZ2yFzmgP1DqzAKkibvVhsFiULHbANfmlQ
Date:   Wed, 6 Sep 2023 08:16:10 +0000
Message-ID: <SN7PR12MB720118DA5F3059C4308FB59C8BEFA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230830090707.278136-1-thippeswamy.havalige@amd.com>
 <20230830090707.278136-4-thippeswamy.havalige@amd.com>
In-Reply-To: <20230830090707.278136-4-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|CH0PR12MB5172:EE_
x-ms-office365-filtering-correlation-id: ef69736e-c0dc-4aa9-a1d2-08dbaeb18790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgcTIu2d9wRuOH81vB446vPqTHTWjUbjM3HKokytWUaBrCebiXZ2Nnj0714h7sLJEZntbj32P8/DajO3zNH2zfKJtwszUrGZL4RnVYKzpZBHmnS0zqFrzQiQ7neLaYrrdtCpdikhAzvo4mPW+SGckdEVdR1SqRuDJMKK+M4SCHdfdKIlaTIROgouB+VopdHTgOI8KQgNantJ1iwuSu7CH9LjdAhKdHfHxul8mHFgiHpq25WA9aguaDat8oMniu+Vn38cISQbiGOT55WwHIKA+YIdikFtPtsMd+KbTCwFZT+t0BgBHZPGL1RSAOseaiS7HTGQMGxupiU1dZG0/KRwudXvUwL1IB2YwNM6mc6cn1vgSudPiGsK24SrtV6FZDrylKqZxhHFmBvG0cr3kn0sEDz9/sFQM/54uTuwh2dpfTAxSlNwArdybYDLyyU8v1Zb0iK3Xc/AUUIyUl8iiiGn+6i0mmGKPkPk5DiEiGDOy6bw7Is4hmH+kpXmgZNpQecxxIkATNrhTSXvd8Tf23mCwmp3h54y5dkTwhYIyVChiX4+bBNKQmYOeOzotBureHDOFhpKa2DSciUD9F9uPF7355rUTgj0uHvYv1ofBAGnxaqVDFVTZVeaPikdMDtDHWml
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(8936002)(8676002)(4326008)(83380400001)(52536014)(478600001)(66946007)(66556008)(76116006)(66476007)(66446008)(54906003)(64756008)(110136005)(26005)(6506007)(7696005)(71200400001)(53546011)(9686003)(41300700001)(2906002)(30864003)(316002)(38070700005)(38100700002)(122000001)(5660300002)(55016003)(86362001)(33656002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oU8emgK7KbmxpVEo8YmBAPeKaISSgPlPPbYSnekW+zg+nL6YHqYtKj1eZvi2?=
 =?us-ascii?Q?WvKm0IA+gbd1PDFeqfagGXcY65lSqPsU4e2RzuQWOF6LyPkpBhpDjBn2QikF?=
 =?us-ascii?Q?BIdBfMBFRChwrbtBO9o2LCT82Na3KFE89qbN3RhmBbzt97QsFchxy9jEnkVB?=
 =?us-ascii?Q?UL0CM9cd2zO9HQN+7LW2gv+sLVnyb4450jU1EuS3R7cPUngceWKNbpb4pUkr?=
 =?us-ascii?Q?ZCCbW/OS02rhph/gsEIw1S05eJVbhNtF3jQeomAB82RUfnanuiQ47RL2uinp?=
 =?us-ascii?Q?Dqthh8fOmDAbwWDwbBK53sV/XHbtOJX6gZWTHrdLgnR11HJqxTaD7GgLLVL2?=
 =?us-ascii?Q?gLzCfDzwoCOOldELU+KS3b4f0FvFdHh0qrRGB3TTtOJCy/OuCi+VozYcW8OA?=
 =?us-ascii?Q?1ufZI/M6jFhEdrV/p40/mVvvuQm6b8Sx/ncT71e7gT6WPIubXfzi8cdaWLjj?=
 =?us-ascii?Q?9Z2ftIjRDMiD9A7yWIe4A8PAzRNGNRE685pImruJUHik4xWwe0Ld+ImCShK5?=
 =?us-ascii?Q?Ud9gmLQhT/lWt5a1zQtLgEQy6qcyKW4J+lXzZMZXxUnvWugrklVWKwyZlFAl?=
 =?us-ascii?Q?lW1fqNDSdXoLPIvKxd5kEI9CIubhG9mKCGENtBrLgrzl3Pb2H0SM6vnX7Ycc?=
 =?us-ascii?Q?m/DVlOV26TD+ekPEBjVGK705pghd/vnHNxKGeXMI3d3/d3AWx/931edqmfbi?=
 =?us-ascii?Q?m4lMG/D8MBKZdcvR4OGdnZiy1U0ZwkNIe7a+otIZZm4YMYBtExqxIyJclLoL?=
 =?us-ascii?Q?dsn0ZrEFUunQLSkOwWNRtqgPuyIdG6w2m+xryJRt7Z9gdjkapyEcsWCoM0Vu?=
 =?us-ascii?Q?Mvy1EAYy6Ur8sPDRAUn4bF4LKM+aG+KRyBWP8DHyeJ/Fc+hlQ0mozTw3m/ge?=
 =?us-ascii?Q?NX0YzOSI6NHQ0OEX8FU0q+vd7bmiFYIL5gQdG1ADvP0NsOXNo6TQN+MYzWIk?=
 =?us-ascii?Q?xYWeJ/Azb9S7Cn1RuQGCckqOAxVv8rAoTqAT2K/cY1gHbZo0cgAg8HdgZf/m?=
 =?us-ascii?Q?ddPx9/qRN7k6oKF0ACpuk9H5KWGPLBvcXBC5kT7AjfTIX9PVmmezGUC4Phsn?=
 =?us-ascii?Q?q96+wczhIUaax+LE9bG+Y019n8+W4TC6iBgHHkhT30FfNFb7djjzNxbB4rGi?=
 =?us-ascii?Q?5fhI4H1fcJFRIp8E2Bfi3TDWHFRNpCgmjVDfM9sRVgvlUiAPXGsGtXvxTr9j?=
 =?us-ascii?Q?zzret56vFf4mB+ZoMyp+BAB1g0cBxQSoYIdMc31F6H8lJId81a/jc5ua/2pk?=
 =?us-ascii?Q?GD0Jd09jV6nJwco6jZbQ9t40HIKHvsVHBIiy6AEGBnesU7AEKN51FBJyaYwX?=
 =?us-ascii?Q?vC1QUWeLOk09pGPg9Pu6tTd9caYVOqFPeb0phqbzunrs17dSv1eKL05LAh21?=
 =?us-ascii?Q?mO4zdByA8bfIXzj/s+SXUzuy59d4Np58MfGiG03irEXz/YGhG9DWv1OEANRv?=
 =?us-ascii?Q?Nch13EGMfNLbRUqH7xg1bvbhF4k8dhwXgF/G9U1Y/8H44YQvlAtYjEa5EoCO?=
 =?us-ascii?Q?xEnb7BTKZHANh+tw5BZ+15H6GhkBvqRYzfjgn2y4guq9mA67ezu5HBt16u/D?=
 =?us-ascii?Q?vZH3p1HXX5jMJnLCD4Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef69736e-c0dc-4aa9-a1d2-08dbaeb18790
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 08:16:10.9567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ndxs9IKKmUuumzCQYUqubTUBXXvSE4QRgmIwZdoJ7B5n0AKN24woqQhXsjTCk4maCxt6qUrzuVQ39VE8dWfcZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5172
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Please provide update on this patch.

Regards,
Thippeswamy H
> -----Original Message-----
> From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Sent: Wednesday, August 30, 2023 2:37 PM
> To: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> bhelgaas@google.com; krzysztof.kozlowski+dt@linaro.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org
> Cc: lpieralisi@kernel.org; robh@kernel.org; conor+dt@kernel.org; Simek,
> Michal <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port drive=
r
>=20
> Add support for Xilinx XDMA Soft IP core as Root Port.
>=20
> The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> programmable logic.
>=20
> The integrated XDMA soft IP block has integrated bridge function that can=
 act
> as PCIe Root Port.
>=20
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v7:
> - Modify link-up check comments.
> - Wrap few lines to 80 columns.
> changes in v6:
> - Replaced chained irq's with regular interrupts.
> - Modified interrupt names.
> - Aligned to 80 columns
> changes in v5:
> - Added detailed comments for link_up check.
> - Modified upper case hex values to lower case.
> changes in v4:
> - Fixed unsigned integer to integer.
> - Fixed return type to EINVAL.
> changes in v3:
> - Changed license to 2023.
> - Added bitfield header to avoid implicit warning.
> - Fixed indentation issue.
> - Fixed code-style.
> changes in v2:
> - Remove unnecessary inclusion of headerfiles.
> - Added a subset of interrupt error bits to common header files.
> - Added pci_is_root_bus function.
> - Removed kerneldoc comments of private function.
> - Modified of_get_next_child API to of_get_child_by_name.
> - Modified of_address_to_resource API to platform_get_resource.
> - Modified return value.
> ---
>  drivers/pci/controller/Kconfig              |  11 +
>  drivers/pci/controller/Makefile             |   1 +
>  drivers/pci/controller/pcie-xilinx-common.h |   1 +
>  drivers/pci/controller/pcie-xilinx-dma-pl.c | 803
> ++++++++++++++++++++++++++++
>  4 files changed, 816 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c
>=20
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig index
> 0859be8..b9e8fb7 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -324,6 +324,17 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
>=20
> +config PCIE_XILINX_DMA_PL
> +	bool "Xilinx DMA PL PCIe host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCI_HOST_COMMON
> +	help
> +	  Add support for the Xilinx PL DMA PCIe host bridge,
> +	  The controller is soft IP which can act as Root Port.
> +	  If you know your system provides Xilinx PCIe host controller
> +	  bridge DMA as soft IP say Y; if you are not sure, say N.
> +
>  config PCIE_XILINX_NWL
>  	bool "Xilinx NWL PCIe controller"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST diff --git
> a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile index
> 37c8663..f2b19e6 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_PCI_HOST_THUNDER_PEM) +=3D pci-
> thunder-pem.o
>  obj-$(CONFIG_PCIE_XILINX) +=3D pcie-xilinx.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) +=3D pcie-xilinx-nwl.o
>  obj-$(CONFIG_PCIE_XILINX_CPM) +=3D pcie-xilinx-cpm.o
> +obj-$(CONFIG_PCIE_XILINX_DMA_PL) +=3D pcie-xilinx-dma-pl.o
>  obj-$(CONFIG_PCI_V3_SEMI) +=3D pci-v3-semi.o
>  obj-$(CONFIG_PCI_XGENE) +=3D pci-xgene.o
>  obj-$(CONFIG_PCI_XGENE_MSI) +=3D pci-xgene-msi.o diff --git
> a/drivers/pci/controller/pcie-xilinx-common.h b/drivers/pci/controller/pc=
ie-
> xilinx-common.h
> index e97d272..1832770 100644
> --- a/drivers/pci/controller/pcie-xilinx-common.h
> +++ b/drivers/pci/controller/pcie-xilinx-common.h
> @@ -19,6 +19,7 @@
>  #define XILINX_PCIE_INTR_PME_TO_ACK_RCVD	15
>  #define XILINX_PCIE_INTR_INTX			16
>  #define XILINX_PCIE_INTR_PM_PME_RCVD		17
> +#define XILINX_PCIE_INTR_MSI			17
>  #define XILINX_PCIE_INTR_SLV_UNSUPP		20
>  #define XILINX_PCIE_INTR_SLV_UNEXP		21
>  #define XILINX_PCIE_INTR_SLV_COMPL		22
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> new file mode 100644
> index 0000000..96639fe
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -0,0 +1,803 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe host controller driver for Xilinx XDMA PCIe Bridge
> + *
> + * Copyright (C) 2023 Xilinx, Inc. All rights reserved.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +
> +#include "../pci.h"
> +#include "pcie-xilinx-common.h"
> +
> +/* Register definitions */
> +#define XILINX_PCIE_DMA_REG_IDR			0x00000138
> +#define XILINX_PCIE_DMA_REG_IMR			0x0000013c
> +#define XILINX_PCIE_DMA_REG_PSCR		0x00000144
> +#define XILINX_PCIE_DMA_REG_RPSC		0x00000148
> +#define XILINX_PCIE_DMA_REG_MSIBASE1		0x0000014c
> +#define XILINX_PCIE_DMA_REG_MSIBASE2		0x00000150
> +#define XILINX_PCIE_DMA_REG_RPEFR		0x00000154
> +#define XILINX_PCIE_DMA_REG_IDRN		0x00000160
> +#define XILINX_PCIE_DMA_REG_IDRN_MASK		0x00000164
> +#define XILINX_PCIE_DMA_REG_MSI_LOW		0x00000170
> +#define XILINX_PCIE_DMA_REG_MSI_HI		0x00000174
> +#define XILINX_PCIE_DMA_REG_MSI_LOW_MASK	0x00000178
> +#define XILINX_PCIE_DMA_REG_MSI_HI_MASK		0x0000017c
> +
> +#define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
> +
> +#define XILINX_PCIE_INTR_IMR_ALL_MASK	\
> +	(					\
> +		IMR(LINK_DOWN)		|	\
> +		IMR(HOT_RESET)		|	\
> +		IMR(CFG_TIMEOUT)	|	\
> +		IMR(CORRECTABLE)	|	\
> +		IMR(NONFATAL)		|	\
> +		IMR(FATAL)		|	\
> +		IMR(INTX)		|	\
> +		IMR(MSI)		|	\
> +		IMR(SLV_UNSUPP)		|	\
> +		IMR(SLV_UNEXP)		|	\
> +		IMR(SLV_COMPL)		|	\
> +		IMR(SLV_ERRP)		|	\
> +		IMR(SLV_CMPABT)		|	\
> +		IMR(SLV_ILLBUR)		|	\
> +		IMR(MST_DECERR)		|	\
> +		IMR(MST_SLVERR)		|	\
> +	)
> +
> +#define XILINX_PCIE_DMA_IMR_ALL_MASK	0x0ff30fe9
> +#define XILINX_PCIE_DMA_IDR_ALL_MASK	0xffffffff
> +#define XILINX_PCIE_DMA_IDRN_MASK	GENMASK(19, 16)
> +
> +/* Root Port Error Register definitions */
> +#define XILINX_PCIE_DMA_RPEFR_ERR_VALID	BIT(18)
> +#define XILINX_PCIE_DMA_RPEFR_REQ_ID	GENMASK(15, 0)
> +#define XILINX_PCIE_DMA_RPEFR_ALL_MASK	0xffffffff
> +
> +/* Root Port Interrupt Register definitions */
> +#define XILINX_PCIE_DMA_IDRN_SHIFT	16
> +
> +/* Root Port Status/control Register definitions */
> +#define XILINX_PCIE_DMA_REG_RPSC_BEN	BIT(0)
> +
> +/* Phy Status/Control Register definitions */
> +#define XILINX_PCIE_DMA_REG_PSCR_LNKUP	BIT(11)
> +
> +/* Number of MSI IRQs */
> +#define XILINX_NUM_MSI_IRQS	64
> +
> +struct xilinx_msi {
> +	struct irq_domain	*msi_domain;
> +	unsigned long		*bitmap;
> +	struct irq_domain	*dev_domain;
> +	struct mutex		lock;		/* protect bitmap variable */
> +	int			irq_msi0;
> +	int			irq_msi1;
> +};
> +
> +/**
> + * struct pl_dma_pcie - PCIe port information
> + * @dev: Device pointer
> + * @reg_base: IO Mapped Register Base
> + * @irq: Interrupt number
> + * @cfg: Holds mappings of config space window
> + * @phys_reg_base: Physical address of reg base
> + * @intx_domain: Legacy IRQ domain pointer
> + * @pldma_domain: PL DMA IRQ domain pointer
> + * @resources: Bus Resources
> + * @msi: MSI information
> + * @intx_irq: INTx error interrupt number
> + * @lock: Lock protecting shared register access  */ struct pl_dma_pcie
> +{
> +	struct device			*dev;
> +	void __iomem			*reg_base;
> +	int				irq;
> +	struct pci_config_window	*cfg;
> +	phys_addr_t			phys_reg_base;
> +	struct irq_domain		*intx_domain;
> +	struct irq_domain		*pldma_domain;
> +	struct list_head		resources;
> +	struct xilinx_msi		msi;
> +	int				intx_irq;
> +	raw_spinlock_t			lock;
> +};
> +
> +static inline u32 pcie_read(struct pl_dma_pcie *port, u32 reg) {
> +	return readl(port->reg_base + reg);
> +}
> +
> +static inline void pcie_write(struct pl_dma_pcie *port, u32 val, u32
> +reg) {
> +	writel(val, port->reg_base + reg);
> +}
> +
> +static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port)
> +{
> +	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
> +		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? true : false; }
> +
> +static void xilinx_pl_dma_pcie_clear_err_interrupts(struct pl_dma_pcie
> +*port) {
> +	unsigned long val =3D pcie_read(port, XILINX_PCIE_DMA_REG_RPEFR);
> +
> +	if (val & XILINX_PCIE_DMA_RPEFR_ERR_VALID) {
> +		dev_dbg(port->dev, "Requester ID %lu\n",
> +			val & XILINX_PCIE_DMA_RPEFR_REQ_ID);
> +		pcie_write(port, XILINX_PCIE_DMA_RPEFR_ALL_MASK,
> +			   XILINX_PCIE_DMA_REG_RPEFR);
> +	}
> +}
> +
> +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
> +					    unsigned int devfn)
> +{
> +	struct pl_dma_pcie *port =3D bus->sysdata;
> +
> +	if (!pci_is_root_bus(bus)) {
> +		/* Checking whether the link is up is the last line of
> +		 * defense, and this check is inherently racy by definition.
> +		 * Sending a PIO request to a downstream device when the
> link is
> +		 * down causes an unrecoverable error, and a reset of the
> entire
> +		 * PCIe controller will be needed. We can reduce the
> likelihood
> +		 * of that unrecoverable error by checking whether the link is
> +		 * up, but we can't completely prevent it because the link may
> +		 * go down between the link-up check and the PIO request.
> +		 */
> +		if (!xilinx_pl_dma_pcie_link_up(port))
> +			return false;
> +	} else if (devfn > 0)
> +		/* Only one device down on each root port */
> +		return false;
> +
> +	return true;
> +}
> +
> +static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
> +						unsigned int devfn, int where)
> +{
> +	struct pl_dma_pcie *port =3D bus->sysdata;
> +
> +	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
> +		return NULL;
> +
> +	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn,
> where); }
> +
> +/* PCIe operations */
> +static struct pci_ecam_ops xilinx_pl_dma_pcie_ops =3D {
> +	.pci_ops =3D {
> +		.map_bus =3D xilinx_pl_dma_pcie_map_bus,
> +		.read	=3D pci_generic_config_read,
> +		.write	=3D pci_generic_config_write,
> +	}
> +};
> +
> +static void xilinx_pl_dma_pcie_enable_msi(struct pl_dma_pcie *port) {
> +	phys_addr_t msi_addr =3D port->phys_reg_base;
> +
> +	pcie_write(port, upper_32_bits(msi_addr),
> XILINX_PCIE_DMA_REG_MSIBASE1);
> +	pcie_write(port, lower_32_bits(msi_addr),
> +XILINX_PCIE_DMA_REG_MSIBASE2); }
> +
> +static void xilinx_mask_intx_irq(struct irq_data *data) {
> +	struct pl_dma_pcie *port =3D irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	mask =3D BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
> +	pcie_write(port, (val & (~mask)),
> XILINX_PCIE_DMA_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->lock, flags); }
> +
> +static void xilinx_unmask_intx_irq(struct irq_data *data) {
> +	struct pl_dma_pcie *port =3D irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 mask, val;
> +
> +	mask =3D BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val =3D pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
> +	pcie_write(port, (val | mask), XILINX_PCIE_DMA_REG_IDRN_MASK);
> +	raw_spin_unlock_irqrestore(&port->lock, flags); }
> +
> +static struct irq_chip xilinx_leg_irq_chip =3D {
> +	.name		=3D "pl_dma:INTx",
> +	.irq_mask	=3D xilinx_mask_intx_irq,
> +	.irq_unmask	=3D xilinx_unmask_intx_irq,
> +};
> +
> +static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain,
> +				       unsigned int irq, irq_hw_number_t hwirq)
> {
> +	irq_set_chip_and_handler(irq, &xilinx_leg_irq_chip,
> handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +/* INTx IRQ Domain operations */
> +static const struct irq_domain_ops intx_domain_ops =3D {
> +	.map =3D xilinx_pl_dma_pcie_intx_map,
> +};
> +
> +static irqreturn_t xilinx_pl_dma_pcie_msi_handler_high(int irq, void
> +*args) {
> +	struct xilinx_msi *msi;
> +	unsigned long status;
> +	u32 bit, virq;
> +	struct pl_dma_pcie *port =3D args;
> +
> +	msi =3D &port->msi;
> +
> +	while ((status =3D pcie_read(port, XILINX_PCIE_DMA_REG_MSI_HI)) !=3D
> 0) {
> +		for_each_set_bit(bit, &status, 32) {
> +			pcie_write(port, 1 << bit,
> XILINX_PCIE_DMA_REG_MSI_HI);
> +			bit =3D bit + 32;
> +			virq =3D irq_find_mapping(msi->dev_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t xilinx_pl_dma_pcie_msi_handler_low(int irq, void
> +*args) {
> +	struct pl_dma_pcie *port =3D args;
> +	struct xilinx_msi *msi;
> +	unsigned long status;
> +	u32 bit, virq;
> +
> +	msi =3D &port->msi;
> +
> +	while ((status =3D pcie_read(port, XILINX_PCIE_DMA_REG_MSI_LOW))
> !=3D 0) {
> +		for_each_set_bit(bit, &status, 32) {
> +			pcie_write(port, 1 << bit,
> XILINX_PCIE_DMA_REG_MSI_LOW);
> +			virq =3D irq_find_mapping(msi->dev_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t xilinx_pl_dma_pcie_event_flow(int irq, void *args) {
> +	struct pl_dma_pcie *port =3D args;
> +	unsigned long val;
> +	int i;
> +
> +	val =3D pcie_read(port, XILINX_PCIE_DMA_REG_IDR);
> +	val &=3D pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
> +	for_each_set_bit(i, &val, 32)
> +		generic_handle_domain_irq(port->pldma_domain, i);
> +
> +	pcie_write(port, val, XILINX_PCIE_DMA_REG_IDR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#define _IC(x, s)                              \
> +	[XILINX_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> +
> +static const struct {
> +	const char	*sym;
> +	const char	*str;
> +} intr_cause[32] =3D {
> +	_IC(LINK_DOWN,		"Link Down"),
> +	_IC(HOT_RESET,		"Hot reset"),
> +	_IC(CFG_TIMEOUT,	"ECAM access timeout"),
> +	_IC(CORRECTABLE,	"Correctable error message"),
> +	_IC(NONFATAL,		"Non fatal error message"),
> +	_IC(FATAL,		"Fatal error message"),
> +	_IC(SLV_UNSUPP,		"Slave unsupported request"),
> +	_IC(SLV_UNEXP,		"Slave unexpected completion"),
> +	_IC(SLV_COMPL,		"Slave completion timeout"),
> +	_IC(SLV_ERRP,		"Slave Error Poison"),
> +	_IC(SLV_CMPABT,		"Slave Completer Abort"),
> +	_IC(SLV_ILLBUR,		"Slave Illegal Burst"),
> +	_IC(MST_DECERR,		"Master decode error"),
> +	_IC(MST_SLVERR,		"Master slave error"),
> +};
> +
> +static irqreturn_t xilinx_pl_dma_pcie_intr_handler(int irq, void
> +*dev_id) {
> +	struct pl_dma_pcie *port =3D (struct pl_dma_pcie *)dev_id;
> +	struct device *dev =3D port->dev;
> +	struct irq_data *d;
> +
> +	d =3D irq_domain_get_irq_data(port->pldma_domain, irq);
> +	switch (d->hwirq) {
> +	case XILINX_PCIE_INTR_CORRECTABLE:
> +	case XILINX_PCIE_INTR_NONFATAL:
> +	case XILINX_PCIE_INTR_FATAL:
> +		xilinx_pl_dma_pcie_clear_err_interrupts(port);
> +		fallthrough;
> +
> +	default:
> +		if (intr_cause[d->hwirq].str)
> +			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +		else
> +			dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct irq_chip xilinx_msi_irq_chip =3D {
> +	.name =3D "pl_dma:PCIe MSI",
> +	.irq_enable =3D pci_msi_unmask_irq,
> +	.irq_disable =3D pci_msi_mask_irq,
> +	.irq_mask =3D pci_msi_mask_irq,
> +	.irq_unmask =3D pci_msi_unmask_irq,
> +};
> +
> +static struct msi_domain_info xilinx_msi_domain_info =3D {
> +	.flags =3D (MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> +		MSI_FLAG_MULTI_PCI_MSI),
> +	.chip =3D &xilinx_msi_irq_chip,
> +};
> +
> +static void xilinx_compose_msi_msg(struct irq_data *data, struct
> +msi_msg *msg) {
> +	struct pl_dma_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> +	phys_addr_t msi_addr =3D pcie->phys_reg_base;
> +
> +	msg->address_lo =3D lower_32_bits(msi_addr);
> +	msg->address_hi =3D upper_32_bits(msi_addr);
> +	msg->data =3D data->hwirq;
> +}
> +
> +static int xilinx_msi_set_affinity(struct irq_data *irq_data,
> +				   const struct cpumask *mask, bool force) {
> +	return -EINVAL;
> +}
> +
> +static struct irq_chip xilinx_irq_chip =3D {
> +	.name =3D "pl_dma:MSI",
> +	.irq_compose_msi_msg =3D xilinx_compose_msi_msg,
> +	.irq_set_affinity =3D xilinx_msi_set_affinity, };
> +
> +static int xilinx_irq_domain_alloc(struct irq_domain *domain, unsigned i=
nt
> virq,
> +				   unsigned int nr_irqs, void *args) {
> +	struct pl_dma_pcie *pcie =3D domain->host_data;
> +	struct xilinx_msi *msi =3D &pcie->msi;
> +	int bit, i;
> +
> +	mutex_lock(&msi->lock);
> +	bit =3D bitmap_find_free_region(msi->bitmap, XILINX_NUM_MSI_IRQS,
> +				      get_count_order(nr_irqs));
> +	if (bit < 0) {
> +		mutex_unlock(&msi->lock);
> +		return -ENOSPC;
> +	}
> +
> +	for (i =3D 0; i < nr_irqs; i++) {
> +		irq_domain_set_info(domain, virq + i, bit + i, &xilinx_irq_chip,
> +				    domain->host_data, handle_simple_irq,
> +				    NULL, NULL);
> +	}
> +	mutex_unlock(&msi->lock);
> +	return 0;
> +}
> +
> +static void xilinx_irq_domain_free(struct irq_domain *domain, unsigned i=
nt
> virq,
> +				   unsigned int nr_irqs)
> +{
> +	struct irq_data *data =3D irq_domain_get_irq_data(domain, virq);
> +	struct pl_dma_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> +	struct xilinx_msi *msi =3D &pcie->msi;
> +
> +	mutex_lock(&msi->lock);
> +	bitmap_release_region(msi->bitmap, data->hwirq,
> +			      get_count_order(nr_irqs));
> +	mutex_unlock(&msi->lock);
> +}
> +
> +static const struct irq_domain_ops dev_msi_domain_ops =3D {
> +	.alloc	=3D xilinx_irq_domain_alloc,
> +	.free	=3D xilinx_irq_domain_free,
> +};
> +
> +static void xilinx_pl_dma_pcie_free_irq_domains(struct pl_dma_pcie
> +*port) {
> +	struct xilinx_msi *msi =3D &port->msi;
> +
> +	if (port->intx_domain) {
> +		irq_domain_remove(port->intx_domain);
> +		port->intx_domain =3D NULL;
> +	}
> +
> +	if (msi->dev_domain) {
> +		irq_domain_remove(msi->dev_domain);
> +		msi->dev_domain =3D NULL;
> +	}
> +
> +	if (msi->msi_domain) {
> +		irq_domain_remove(msi->msi_domain);
> +		msi->msi_domain =3D NULL;
> +	}
> +}
> +
> +static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie
> +*port) {
> +	struct device *dev =3D port->dev;
> +	struct xilinx_msi *msi =3D &port->msi;
> +	int size =3D BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
> +	struct fwnode_handle *fwnode =3D of_node_to_fwnode(port->dev-
> >of_node);
> +
> +	msi->dev_domain =3D irq_domain_add_linear(NULL,
> XILINX_NUM_MSI_IRQS,
> +						&dev_msi_domain_ops,
> port);
> +	if (!msi->dev_domain)
> +		goto out;
> +
> +	msi->msi_domain =3D pci_msi_create_irq_domain(fwnode,
> +						    &xilinx_msi_domain_info,
> +						    msi->dev_domain);
> +	if (!msi->msi_domain)
> +		goto out;
> +
> +	mutex_init(&msi->lock);
> +	msi->bitmap =3D kzalloc(size, GFP_KERNEL);
> +	if (!msi->bitmap)
> +		goto out;
> +
> +	raw_spin_lock_init(&port->lock);
> +	xilinx_pl_dma_pcie_enable_msi(port);
> +
> +	return 0;
> +
> +out:
> +	xilinx_pl_dma_pcie_free_irq_domains(port);
> +	dev_err(dev, "Failed to allocate MSI IRQ domains\n");
> +	return -ENOMEM;
> +}
> +
> +/* INTx error interrupts are Xilinx controller specific interrupt, used
> +to
> + * notify user about errors such as cfg timeout, slave unsupported
> +requests,
> + * fatal and non fatal error etc.
> + */
> +
> +static irqreturn_t xilinx_pl_dma_pcie_intx_flow(int irq, void *args) {
> +	unsigned long val;
> +	int i;
> +	struct pl_dma_pcie *port =3D args;
> +
> +	val =3D FIELD_GET(XILINX_PCIE_DMA_IDRN_MASK,
> +			pcie_read(port, XILINX_PCIE_DMA_REG_IDRN));
> +
> +	for_each_set_bit(i, &val, PCI_NUM_INTX)
> +		generic_handle_domain_irq(port->intx_domain, i);
> +	return IRQ_HANDLED;
> +}
> +
> +static void xilinx_pl_dma_pcie_mask_event_irq(struct irq_data *d) {
> +	struct pl_dma_pcie *port =3D irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val =3D pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
> +	val &=3D ~BIT(d->hwirq);
> +	pcie_write(port, val, XILINX_PCIE_DMA_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static void xilinx_pl_dma_pcie_unmask_event_irq(struct irq_data *d) {
> +	struct pl_dma_pcie *port =3D irq_data_get_irq_chip_data(d);
> +	u32 val;
> +
> +	raw_spin_lock(&port->lock);
> +	val =3D pcie_read(port, XILINX_PCIE_DMA_REG_IMR);
> +	val |=3D BIT(d->hwirq);
> +	pcie_write(port, val, XILINX_PCIE_DMA_REG_IMR);
> +	raw_spin_unlock(&port->lock);
> +}
> +
> +static struct irq_chip xilinx_pl_dma_pcie_event_irq_chip =3D {
> +	.name		=3D "pl_dma:RC-Event",
> +	.irq_mask	=3D xilinx_pl_dma_pcie_mask_event_irq,
> +	.irq_unmask	=3D xilinx_pl_dma_pcie_unmask_event_irq,
> +};
> +
> +static int xilinx_pl_dma_pcie_event_map(struct irq_domain *domain,
> +					unsigned int irq, irq_hw_number_t
> hwirq) {
> +	irq_set_chip_and_handler(irq, &xilinx_pl_dma_pcie_event_irq_chip,
> +				 handle_level_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +	irq_set_status_flags(irq, IRQ_LEVEL);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops event_domain_ops =3D {
> +	.map =3D xilinx_pl_dma_pcie_event_map,
> +};
> +
> +/**
> + * xilinx_pl_dma_pcie_init_irq_domain - Initialize IRQ domain
> + * @port: PCIe port information
> + *
> + * Return: '0' on success and error value on failure  */ static int
> +xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port) {
> +	struct device *dev =3D port->dev;
> +	struct device_node *node =3D dev->of_node;
> +	struct device_node *pcie_intc_node;
> +	int ret;
> +
> +	/* Setup INTx */
> +	pcie_intc_node =3D of_get_child_by_name(node, "interrupt-
> controller");
> +	if (!pcie_intc_node) {
> +		dev_err(dev, "No PCIe Intc node found\n");
> +		return -EINVAL;
> +	}
> +
> +	port->pldma_domain =3D irq_domain_add_linear(pcie_intc_node, 32,
> +						   &event_domain_ops, port);
> +	if (!port->pldma_domain)
> +		return -ENOMEM;
> +
> +	irq_domain_update_bus_token(port->pldma_domain,
> DOMAIN_BUS_NEXUS);
> +
> +	port->intx_domain =3D irq_domain_add_linear(pcie_intc_node,
> PCI_NUM_INTX,
> +						  &intx_domain_ops, port);
> +	if (!port->intx_domain) {
> +		dev_err(dev, "Failed to get a INTx IRQ domain\n");
> +		return PTR_ERR(port->intx_domain);
> +	}
> +
> +	irq_domain_update_bus_token(port->intx_domain,
> DOMAIN_BUS_WIRED);
> +
> +	ret =3D xilinx_pl_dma_pcie_init_msi_irq_domain(port);
> +	if (ret !=3D 0) {
> +		irq_domain_remove(port->intx_domain);
> +		return -ENOMEM;
> +	}
> +
> +	of_node_put(pcie_intc_node);
> +	raw_spin_lock_init(&port->lock);
> +
> +	return 0;
> +}
> +
> +static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port) {
> +	struct device *dev =3D port->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	int i, irq, err;
> +
> +	port->irq =3D platform_get_irq(pdev, 0);
> +	if (port->irq < 0)
> +		return port->irq;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		int err;
> +
> +		if (!intr_cause[i].str)
> +			continue;
> +
> +		irq =3D irq_create_mapping(port->pldma_domain, i);
> +		if (!irq) {
> +			dev_err(dev, "Failed to map interrupt\n");
> +			return -ENXIO;
> +		}
> +
> +		err =3D devm_request_irq(dev, irq,
> +				       xilinx_pl_dma_pcie_intr_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD,
> +				       intr_cause[i].sym, port);
> +		if (err) {
> +			dev_err(dev, "Failed to request IRQ %d\n", irq);
> +			return err;
> +		}
> +	}
> +
> +	port->intx_irq =3D irq_create_mapping(port->pldma_domain,
> +					    XILINX_PCIE_INTR_INTX);
> +	if (!port->intx_irq) {
> +		dev_err(dev, "Failed to map INTx interrupt\n");
> +		return -ENXIO;
> +	}
> +
> +	err =3D devm_request_irq(dev, port->intx_irq,
> xilinx_pl_dma_pcie_intx_flow,
> +			       IRQF_SHARED | IRQF_NO_THREAD, NULL, port);
> +	if (err) {
> +		dev_err(dev, "Failed to request INTx IRQ %d\n", irq);
> +		return err;
> +	}
> +	err =3D devm_request_irq(dev, port->irq,
> xilinx_pl_dma_pcie_event_flow,
> +			       IRQF_SHARED | IRQF_NO_THREAD, NULL, port);
> +	if (err) {
> +		dev_err(dev, "Failed to request event IRQ %d\n", irq);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +static void xilinx_pl_dma_pcie_init_port(struct pl_dma_pcie *port) {
> +	if (xilinx_pl_dma_pcie_link_up(port))
> +		dev_info(port->dev, "PCIe Link is UP\n");
> +	else
> +		dev_info(port->dev, "PCIe Link is DOWN\n");
> +
> +	/* Disable all interrupts */
> +	pcie_write(port, ~XILINX_PCIE_DMA_IDR_ALL_MASK,
> +		   XILINX_PCIE_DMA_REG_IMR);
> +
> +	/* Clear pending interrupts */
> +	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_IDR) &
> +			 XILINX_PCIE_DMA_IMR_ALL_MASK,
> +		   XILINX_PCIE_DMA_REG_IDR);
> +
> +	/* Needed for MSI DECODE MODE */
> +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK,
> +		   XILINX_PCIE_DMA_REG_MSI_LOW_MASK);
> +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK,
> +		   XILINX_PCIE_DMA_REG_MSI_HI_MASK);
> +
> +	/* Set the Bridge enable bit */
> +	pcie_write(port, pcie_read(port, XILINX_PCIE_DMA_REG_RPSC) |
> +			 XILINX_PCIE_DMA_REG_RPSC_BEN,
> +		   XILINX_PCIE_DMA_REG_RPSC);
> +}
> +
> +static int xilinx_request_msi_irq(struct pl_dma_pcie *port) {
> +	struct device *dev =3D port->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	int ret;
> +
> +	port->msi.irq_msi0 =3D platform_get_irq_byname(pdev, "msi0");
> +	if (port->msi.irq_msi0 <=3D 0) {
> +		dev_err(dev, "Unable to find msi0 IRQ line\n");
> +		return port->msi.irq_msi0;
> +	}
> +	ret =3D devm_request_irq(dev, port->msi.irq_msi0,
> xilinx_pl_dma_pcie_msi_handler_low,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "xlnx-pcie-
> dma-pl",
> +			       port);
> +	if (ret) {
> +		dev_err(dev, "Failed to register interrupt\n");
> +		return ret;
> +		}
> +	port->msi.irq_msi1 =3D platform_get_irq_byname(pdev, "msi1");
> +	if (port->msi.irq_msi1 <=3D 0) {
> +		dev_err(dev, "Unable to find msi1 IRQ line\n");
> +		return port->msi.irq_msi1;
> +	}
> +	ret =3D devm_request_irq(dev, port->msi.irq_msi1,
> xilinx_pl_dma_pcie_msi_handler_high,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "xlnx-pcie-
> dma-pl",
> +			       port);
> +	if (ret) {
> +		dev_err(dev, "Failed to register interrupt\n");
> +		return ret;
> +		}
> +	return 0;
> +}
> +
> +static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,
> +				       struct resource *bus_range)
> +{
> +	struct device *dev =3D port->dev;
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct resource *res;
> +	int err;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "Missing \"reg\" property\n");
> +		return -ENXIO;
> +	}
> +	port->phys_reg_base =3D res->start;
> +
> +	port->cfg =3D pci_ecam_create(dev, res, bus_range,
> &xilinx_pl_dma_pcie_ops);
> +	if (IS_ERR(port->cfg))
> +		return PTR_ERR(port->cfg);
> +
> +	port->reg_base =3D port->cfg->win;
> +
> +	err =3D xilinx_request_msi_irq(port);
> +	if (err) {
> +		pci_ecam_free(port->cfg);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct pl_dma_pcie *port;
> +	struct pci_host_bridge *bridge;
> +	struct resource_entry *bus;
> +	int err;
> +
> +	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*port));
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	port =3D pci_host_bridge_priv(bridge);
> +
> +	port->dev =3D dev;
> +
> +	bus =3D resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	err =3D xilinx_pl_dma_pcie_parse_dt(port, bus->res);
> +	if (err) {
> +		dev_err(dev, "Parsing DT failed\n");
> +		return err;
> +	}
> +
> +	xilinx_pl_dma_pcie_init_port(port);
> +
> +	err =3D xilinx_pl_dma_pcie_init_irq_domain(port);
> +	if (err)
> +		goto err_irq_domain;
> +
> +	err =3D xilinx_pl_dma_pcie_setup_irq(port);
> +
> +	bridge->sysdata =3D port;
> +	bridge->ops =3D &xilinx_pl_dma_pcie_ops.pci_ops;
> +
> +	err =3D pci_host_probe(bridge);
> +	if (err < 0)
> +		goto err_host_bridge;
> +
> +	return 0;
> +
> +err_host_bridge:
> +	xilinx_pl_dma_pcie_free_irq_domains(port);
> +
> +err_irq_domain:
> +	pci_ecam_free(port->cfg);
> +	return err;
> +}
> +
> +static const struct of_device_id xilinx_pl_dma_pcie_of_match[] =3D {
> +	{
> +		.compatible =3D "xlnx,xdma-host-3.00",
> +	},
> +	{}
> +};
> +
> +static struct platform_driver xilinx_pl_dma_pcie_driver =3D {
> +	.driver =3D {
> +		.name =3D "xilinx-xdma-pcie",
> +		.of_match_table =3D xilinx_pl_dma_pcie_of_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe =3D xilinx_pl_dma_pcie_probe,
> +};
> +
> +builtin_platform_driver(xilinx_pl_dma_pcie_driver);
> --
> 1.8.3.1

