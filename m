Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC3793701
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjIFIRF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIFIRE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 04:17:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B5BE75;
        Wed,  6 Sep 2023 01:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPWcrFN6KPKJd55uOwyd56vXK2ycX6c5I01iUaB1tmtGjZFCIno2puYJ1zchnuV3QckJ/mKjEYiltVu0yVPv7hfNpwYoVU8Nh+vEZs2XfaIuQrtnkIJDYfbh+FjA9DneEKr6JlbNza9l9GUmKnd9zxYwF/+FoD3o5aNEl2DkM294SA2Ld837+VYWZY+diJCouMnhBVCh4qUezMw1/5y5YFBQGsI1/w0BS/+lHSPeNeUbg0OMKzbW29K1J8r93UlUu3Em2lMkQxG0Agrskhxqf9/fKIA5rNhH++lsTuOzQ80bNIGHeHCH+OL7pi+CxL1TFwPvsVTIgnTBeMCKztkX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+e+hJd2j+okOf1mfEo1+jD5r/GwNqpwzzPEGoGxtoY=;
 b=D+seWjbjL9+qvmWLUjeLuw19D8YAMunyq7H4CA6N/g3C9lnF50b12Qwa0200DV2JuI+bnYcahtsBGWNkSxLWN5bQLrpHnTE3Q3hlA//0bT9yqG1ShguisecrW5syzGWasA4U7OZj1bdY2oYEMR2olL+QzL9LjktAtjgsPr/tda2IeMi3ZtX1oFSTklnQMEsrWoZkbEMEDL2OmL0tpoiG1wljRwLW3PHVAcqAtInf+Ils7cJMi6WzEg8abRpBjVpBIYNFQq9UCv92Dt3GdsF/HqI65ucFC9XtCggThc4ScF9Kjeedn3ox6Qy7HIDg84znVrnQQSvbut8rnizf03oxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+e+hJd2j+okOf1mfEo1+jD5r/GwNqpwzzPEGoGxtoY=;
 b=ewtg2TjhrtiH4buvpj8H8lOQRP6fJe5xgEhjAFoCouEtmHxjsR3Si4xZWALfGhgCSjmCuOa8S64LJqIYH26q+JTCGlDCDyCOOarPrSJ6+l5IyPdbJCtQ34TpLe2+YlW0VVFWwXTdAH7VyRO3LIIwAGzvs/LIMQgPrR6wOqctQpU=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 08:16:47 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 08:16:46 +0000
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
Subject: RE: [PATCH v7 1/3] PCI: xilinx-cpm: Move interrupt bit definitions to
 common header
Thread-Topic: [PATCH v7 1/3] PCI: xilinx-cpm: Move interrupt bit definitions
 to common header
Thread-Index: AQHZ2yFqEgtNHLTSA0i/r1WrzFF1XbANfoyw
Date:   Wed, 6 Sep 2023 08:16:46 +0000
Message-ID: <SN7PR12MB7201AC85590CB85F6EE00CCA8BEFA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230830090707.278136-1-thippeswamy.havalige@amd.com>
 <20230830090707.278136-2-thippeswamy.havalige@amd.com>
In-Reply-To: <20230830090707.278136-2-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|CH3PR12MB8401:EE_
x-ms-office365-filtering-correlation-id: becbe0f1-302c-4b32-0f46-08dbaeb19cc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GUBTUH5uI+5NXSHf4UdE7+4B0AJ/dZ4hR6KplSfilrUY+RZaCCf4tw5eUIvQ6Vh0b68Lj88WoB8/DA4Y157w8Ka0P8HfGgxd0j1ySs7W95RjijzfHWsKlF8mnxt7TO90aVojUl+skPD31bQcfiphaDM/oJMIcWuT7EqHAKLxHlH2or6GQSMOYYTNWAMcrc0KtgMX7cqYMXDd4g7pg26jQO9jC8sNbBUU6bCHnlZHCKNlTdkdB3KzcrHa4qXlBczmu/1CRru5kCcvS5EN9ZRvV3Bqlg9Cu3gF4BTnsBjSmV2sDP2afs9AzMx9QMYgkUm9ncBaGq7bt0AmAXr25vz13FUK/4WR/z0H588PDiGeuFGURONoerzpXXpo1b2yvkW+0e+RUElLcgYfXZJz7omJsPxeXVheoAEq8OcXGK9W52wTEnUSrxZIow2G0i0EVSOFI0k3hzcwupu6e5BuV8QX951AWXgCs0u2kElqqEXl3tgPnUPY56nXl/1/caCL5NYlVxvImjnqUhMfDA7HHGJyzDK+XYcCX4nN88uFhmg9rGPu2iud8OCdrKPAmg6U6/GydLJL16LPXFEV60odDwfCt1T487nBOUmgrsn5NkY1avNTITKAzUtsO7FzemNpYYu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(1800799009)(451199024)(186009)(41300700001)(71200400001)(478600001)(122000001)(33656002)(86362001)(38100700002)(83380400001)(38070700005)(26005)(9686003)(6506007)(7696005)(53546011)(55016003)(76116006)(66446008)(2906002)(66476007)(64756008)(316002)(110136005)(54906003)(66556008)(66946007)(8936002)(5660300002)(4326008)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?klKlozpPNuFDU2YBLfK69eGTETqXIy0VlnkaBOgjQ5wr4L2TqSEBh7bvcDMO?=
 =?us-ascii?Q?FAHPJty6hkmpHnHct4vvDXP1i7hrM1mc7YKSezmCBVJUq80Y0lDQxXVsl4Gy?=
 =?us-ascii?Q?kwE4o4fAyi3iL3d8qKGCtOhJDucrfWq72eiVwc+E5TOU1wjjopL+Xi0FCZhP?=
 =?us-ascii?Q?I/unZcRRILhqV8h9Tv1idNn0e8x0gwxHVXQYBJAt/VSGwVQk833VJ70rtv/e?=
 =?us-ascii?Q?W9frzBSevclcqTG8447uGuNyDIoV/+HHKIKkFyLYV61WgJmPPTi9050r4M7V?=
 =?us-ascii?Q?JiX6wv9I6DP8KTYrY7CY0hRi8dvzU3+UJRqWKMr1mftl8LBzbkTaNBgnU+ZS?=
 =?us-ascii?Q?msMET+fopZXGNpXfXVW43f9FTJsOuwjaK5dX48uQrEfONE3E0oC9b+dlI+4r?=
 =?us-ascii?Q?4dBrPkTCH48Dqosge2iFtJ8ClO77MfL9bws5Mvp1N1OU/ffJoimDo+eIlunc?=
 =?us-ascii?Q?ORk+dCRxGCrtpu5NxNJWHYYXaThI5jLGGISK5/GME657fzAtf6Hejnu26wek?=
 =?us-ascii?Q?poCbizmCC8ZQqmOY6eW75+biW1PHXglhOfDVrIIlIypGl6hZU4//QSkopGiX?=
 =?us-ascii?Q?GRQ9U0kWBAWTpXM47GE070K3ZXRlmUPp0wwwVsS5uALu/JFdccCCuAuP+ljl?=
 =?us-ascii?Q?ysGCGRkb4BOHm7yEPeMU6UoL/qKSkvc9CPMdhqBXBClzDRBrt5wE7ZevBYrF?=
 =?us-ascii?Q?Uz0bA4x/onu0t4dPQWBttFSHU36o/DvvILNzD1xAvKhobdWsrQAxxEb+Kjbc?=
 =?us-ascii?Q?nQ1/WhWEz8oJmRK1zoFPA0rT28cmB8XIffzRGVDJuj2cp2pIaHvceEnFRqvL?=
 =?us-ascii?Q?23p2Y0pg4vnVZ6uVpauC/1NfsLp/qQz80JV0L3gzNHGRPZGW/Un5tXlW2N4i?=
 =?us-ascii?Q?BbBEuGkm467qA1P2DNzfNm9H3VQ1kkEgQPjSXUahVJwR0uTaG9eGclHmiJ3R?=
 =?us-ascii?Q?LS9WOCA2L4ck9wHURbVBRJ2i+K+ce62yvx4aB+KNp6OdtCLCaXX2vrZYaED6?=
 =?us-ascii?Q?iKRwJYNSEmfxf0pJjrPgQfrHjzkiHe9Lc8B9zfL1LORIhjktvqERJX7w7NRI?=
 =?us-ascii?Q?D9wVoQKhCRyPTGRX7rQIVCEzHs7NSnwHrc+VwsBPQbKz0pKwzCJtHr4ZG0oh?=
 =?us-ascii?Q?N2stk7SBomAfx5J64MeeocQhtLLAlV22PMDQS/7EnH2nNUyeLHK6le84+iJq?=
 =?us-ascii?Q?3SmnO6JhM16TttJbTy2RwQXjGZylRfO6ruU7uIYtq8cL0F9/jaBquT4q9cSb?=
 =?us-ascii?Q?DrG8F9gIvx3iGciAeXIxjgCUQ/7ZRzbIROHCXac95HhwTzT1PnO48UBXlDMn?=
 =?us-ascii?Q?RD/r3oMz9mbX/cCPrRupEI8ooOu1s3Vhg9oWGk70XAekAo00X7m32R0pzMtf?=
 =?us-ascii?Q?9m2fa7BTl2FUfF7k79uQxwCLF8nIs6tl1DWSCDNl/+qgtWqThkeHFfBZzd47?=
 =?us-ascii?Q?YDgp37BlX1lbtEGkrG7SVJVx8X7KNlPlPF+DM5i8dDot3UCzWk/yFCy177Jq?=
 =?us-ascii?Q?HTCMPMjoHbmRsIWb8J4yJP3DOx5utPAKeqIWEhiR6gljdFTRHJuMgXKXNVbd?=
 =?us-ascii?Q?/zs6329UjDne0Cu4HSw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becbe0f1-302c-4b32-0f46-08dbaeb19cc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 08:16:46.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MKzG+YjL5MyzJZNQ4siY4egp9l6o2W+iullKm2LS3LEBsntHax5D/nyTJk5UzNprO02j9uLsXvi4PCxhEYUBPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
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
> Subject: [PATCH v7 1/3] PCI: xilinx-cpm: Move interrupt bit definitions t=
o
> common header
>=20
> Rename Xilinx interrupt bit definitions so they are not CPM-specific. Mov=
e the
> definitions to pcie-xilinx-common.h where they can be shared between pcie=
-
> xilinx-cpm and the new xilinx-xdma driver.
>=20
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v7:
> - None
> changes in v6:
> -  subject line and commit message
> changes in v5:
> - None
> changes in v4:
> - None
> changes in v3:
> - changed licensing year to 2023
> ---
>  drivers/pci/controller/pcie-xilinx-common.h | 30 +++++++++++++++++++++++
>  drivers/pci/controller/pcie-xilinx-cpm.c    | 38 ++++++-----------------=
------
>  2 files changed, 37 insertions(+), 31 deletions(-)  create mode 100644
> drivers/pci/controller/pcie-xilinx-common.h
>=20
> diff --git a/drivers/pci/controller/pcie-xilinx-common.h
> b/drivers/pci/controller/pcie-xilinx-common.h
> new file mode 100644
> index 0000000..e97d272
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-xilinx-common.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * (C) Copyright 2023, Xilinx, Inc.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/platform_device.h>
> +
> +/* Interrupt registers definitions */
> +#define XILINX_PCIE_INTR_LINK_DOWN		0
> +#define XILINX_PCIE_INTR_HOT_RESET		3
> +#define XILINX_PCIE_INTR_CFG_PCIE_TIMEOUT	4
> +#define XILINX_PCIE_INTR_CFG_TIMEOUT		8
> +#define XILINX_PCIE_INTR_CORRECTABLE		9
> +#define XILINX_PCIE_INTR_NONFATAL		10
> +#define XILINX_PCIE_INTR_FATAL			11
> +#define XILINX_PCIE_INTR_CFG_ERR_POISON		12
> +#define XILINX_PCIE_INTR_PME_TO_ACK_RCVD	15
> +#define XILINX_PCIE_INTR_INTX			16
> +#define XILINX_PCIE_INTR_PM_PME_RCVD		17
> +#define XILINX_PCIE_INTR_SLV_UNSUPP		20
> +#define XILINX_PCIE_INTR_SLV_UNEXP		21
> +#define XILINX_PCIE_INTR_SLV_COMPL		22
> +#define XILINX_PCIE_INTR_SLV_ERRP		23
> +#define XILINX_PCIE_INTR_SLV_CMPABT		24
> +#define XILINX_PCIE_INTR_SLV_ILLBUR		25
> +#define XILINX_PCIE_INTR_MST_DECERR		26
> +#define XILINX_PCIE_INTR_MST_SLVERR		27
> +#define XILINX_PCIE_INTR_SLV_PCIE_TIMEOUT	28
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 4a787a9..a0f5e1d 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -16,11 +16,9 @@
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -#include <linux/pci-ecam.h>
>=20
>  #include "../pci.h"
> +#include "pcie-xilinx-common.h"
>=20
>  /* Register definitions */
>  #define XILINX_CPM_PCIE_REG_IDR		0x00000E10
> @@ -38,29 +36,7 @@
>  #define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
>  #define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
>=20
> -/* Interrupt registers definitions */
> -#define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
> -#define XILINX_CPM_PCIE_INTR_HOT_RESET		3
> -#define XILINX_CPM_PCIE_INTR_CFG_PCIE_TIMEOUT	4
> -#define XILINX_CPM_PCIE_INTR_CFG_TIMEOUT	8
> -#define XILINX_CPM_PCIE_INTR_CORRECTABLE	9
> -#define XILINX_CPM_PCIE_INTR_NONFATAL		10
> -#define XILINX_CPM_PCIE_INTR_FATAL		11
> -#define XILINX_CPM_PCIE_INTR_CFG_ERR_POISON	12
> -#define XILINX_CPM_PCIE_INTR_PME_TO_ACK_RCVD	15
> -#define XILINX_CPM_PCIE_INTR_INTX		16
> -#define XILINX_CPM_PCIE_INTR_PM_PME_RCVD	17
> -#define XILINX_CPM_PCIE_INTR_SLV_UNSUPP		20
> -#define XILINX_CPM_PCIE_INTR_SLV_UNEXP		21
> -#define XILINX_CPM_PCIE_INTR_SLV_COMPL		22
> -#define XILINX_CPM_PCIE_INTR_SLV_ERRP		23
> -#define XILINX_CPM_PCIE_INTR_SLV_CMPABT		24
> -#define XILINX_CPM_PCIE_INTR_SLV_ILLBUR		25
> -#define XILINX_CPM_PCIE_INTR_MST_DECERR		26
> -#define XILINX_CPM_PCIE_INTR_MST_SLVERR		27
> -#define XILINX_CPM_PCIE_INTR_SLV_PCIE_TIMEOUT	28
> -
> -#define IMR(x) BIT(XILINX_CPM_PCIE_INTR_ ##x)
> +#define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
>=20
>  #define XILINX_CPM_PCIE_IMR_ALL_MASK			\
>  	(						\
> @@ -323,7 +299,7 @@ static void xilinx_cpm_pcie_event_flow(struct
> irq_desc *desc)  }
>=20
>  #define _IC(x, s)                              \
> -	[XILINX_CPM_PCIE_INTR_ ## x] =3D { __stringify(x), s }
> +	[XILINX_PCIE_INTR_ ## x] =3D { __stringify(x), s }
>=20
>  static const struct {
>  	const char      *sym;
> @@ -359,9 +335,9 @@ static irqreturn_t xilinx_cpm_pcie_intr_handler(int i=
rq,
> void *dev_id)
>  	d =3D irq_domain_get_irq_data(port->cpm_domain, irq);
>=20
>  	switch (d->hwirq) {
> -	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
> -	case XILINX_CPM_PCIE_INTR_NONFATAL:
> -	case XILINX_CPM_PCIE_INTR_FATAL:
> +	case XILINX_PCIE_INTR_CORRECTABLE:
> +	case XILINX_PCIE_INTR_NONFATAL:
> +	case XILINX_PCIE_INTR_FATAL:
>  		cpm_pcie_clear_err_interrupts(port);
>  		fallthrough;
>=20
> @@ -466,7 +442,7 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pci=
e
> *port)
>  	}
>=20
>  	port->intx_irq =3D irq_create_mapping(port->cpm_domain,
> -					    XILINX_CPM_PCIE_INTR_INTX);
> +					    XILINX_PCIE_INTR_INTX);
>  	if (!port->intx_irq) {
>  		dev_err(dev, "Failed to map INTx interrupt\n");
>  		return -ENXIO;
> --
> 1.8.3.1

