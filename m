Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A9772280
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjHGLed (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjHGLeJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 07:34:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFCF59DC;
        Mon,  7 Aug 2023 04:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0Ik6U9wx4OGcOulDVE+jKwH94z61OnyPRdQaTRopBHOXhhhv329vptGOPAq+XjtkocphFlvpXnm2vSOczkqPeoEIQbTnTgF0ETxFdz/p0tM7GXo9fUsXH/uoBnPNF/D2noJG/nHhI01uFq1tf+7tYTwktq1Ou9glyX15ojpICildtx2LLcns5RBqOXWG4Oz8hGYn2CbfwDHxKbqqg/Sr6NohRmISb/NO8bJgDpZ9zhYVLuI7IgZXko06bsu8IfxsNugqEzTN+QEC+PJEdSMt+x1/g+SANORyy4+joPkWG4qdtVm/VmoWzztUzJ+6JASIiOV8rmrKYgJ5koo3vl2xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/YeSJQ26tpmnb8Wi+56lNiIFaVRuM1zH8BiQ/mU4/c=;
 b=k31w1eY9o6aQB0MBLlm58xAwInSH0euBbLc+JsuS4uQIMLsFZgELYEk+sELfrFeqYBZBSF5K3gpLgXHf5YQy2BW3t8/eO/w2KuJreQ46z267+K2ReehXH/EMPDtzO0VY5EkLjRZbPM7AqDgn5cf71ydqks4V9R5N7nbeQuvfUnYNOBV75/bh+ZVLn8zCMPUHw6RZ2SDc+bmJx2VoGwPqsG8yzSWLXA8VjfzTx2sBTVNOJTyEqkSo7TOy5A0qbGLHkyR1BS9LNLSiRXpHbTlP5ykLweyqtOPJ/Ekj1ujPVcvkIfNiTd4n6N1kTEBqsAQULe015WuE3oTJNfW669lIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/YeSJQ26tpmnb8Wi+56lNiIFaVRuM1zH8BiQ/mU4/c=;
 b=FU8UAWmcippxbI/QdagYR7h99iJABpAAWkDt+szIP+PMBc9oedLQ0iLoBBcYqg35bJhoh7n68IgSLICoZ0hOkMbzo77j7HO39lFoY3o29RHnK7OargRytzRkreKQehfv0FYq3BRohsXSY/ZrBTNQDC/ZNoHuIi+CuECICMd/V3Y=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:14:33 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 11:14:30 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value and
 remove unnecessary code.
Thread-Topic: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value and
 remove unnecessary code.
Thread-Index: AQHZyR78hQp9KI6fLEKY6/ZFN8Meu6/erksw
Date:   Mon, 7 Aug 2023 11:14:30 +0000
Message-ID: <SN7PR12MB7201434F23F0E083925E2FBC8B0CA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230807110436.77287-1-thippeswamy.havalige@amd.com>
 <20230807110436.77287-2-thippeswamy.havalige@amd.com>
In-Reply-To: <20230807110436.77287-2-thippeswamy.havalige@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB8523:EE_
x-ms-office365-filtering-correlation-id: 7505cbe7-58e5-45c5-0a5a-08db973778b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULmS2jCFnd/XSMo8BtSlq44/uOagSC2qpQ8Lkhzkpb19hOts0UdujP82A8nBZIAej+6nCf5IeyAEnPuymU9qYRi5QSht2/handaSFAkw/3+pwJmPVitOsiJ1E2ww4sNdw4YkKeVmYV5A7j7CAgYewG+kyZM3efO80KtjKO97Cvaw+VFgB/EeKkpGZjt8NtFK7i+9DirbAxi+YEIEbeiP5ph7AUifZWIsGu6TN/5FPIMuwW7UdCuGl9i+EBb24lMi3aFE0043k5UOus7EN4Ye5/c2vfpaJiSLprLYAoe3HnVFTZeW7P7JxUqD0C9q/7e8H/WjoOM4sNsuMnAZmSwDVr9DgqgSKbIUsQZIOrH+wRqTaZpg2sQZuT79Fe1486AUGvWrxvY6EjdlXzNX/7De6ipG8VW7oDrPkNDCk/X/GQ3744Fx08yDuW23fBVxyWBVm5fWaU9lD70WvP5vQQBnoe7fHBCa+X1MS5bHPrHvU3FHfzAwwq59+7tsO/iO2SHJPr74lXmM5/LAkXsalc6M2+/WkGXVMHsAZhtu48vzR5JRKsuzHgorkBjtkdSn0wgiSWM1hdkxI/FpW7jjSNZe530bdbavW44Mg9kyoPfhgWM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(1800799003)(186006)(451199021)(83380400001)(55016003)(54906003)(110136005)(2906002)(4326008)(5660300002)(8936002)(316002)(38070700005)(52536014)(8676002)(76116006)(66946007)(64756008)(66446008)(66556008)(66476007)(38100700002)(86362001)(966005)(33656002)(478600001)(122000001)(71200400001)(9686003)(7696005)(41300700001)(15650500001)(6506007)(26005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D7C9TbmC6AbqW1qFicKXzzCijusXvoRB/vEcIfFwmwpnbxDqSXxWT5bcT+Hd?=
 =?us-ascii?Q?5jUo85QLy0k4BjGr9isa7xfokKGA1SYmp915dgeQN80OfhMqaMRz2x98d+1p?=
 =?us-ascii?Q?cR51ciYpZS3jihGlljDXIQbWp8XxqYJU/HuiqTroYLHa+JyPdnOSuT8b+QnY?=
 =?us-ascii?Q?G3TZHmiGQLBT0M5B0ceEHCH3hTkxC5wpwhVyldoFJzuPKpP9XMhDS+d2dL3z?=
 =?us-ascii?Q?QcM6LJ2GLk/inwX14xPCwR5lnhitdUsgk6uhI4bEcRzTMwcsV0gUW+tPrxSd?=
 =?us-ascii?Q?QjH3tff/FB8RtTw8Lt/bWnT+Dmu8Ma4apjrK7z3KTa2LkLFG8B0k4MtyNlL8?=
 =?us-ascii?Q?jWdRU2st6zHXyA5S89QnRhqueoMPU5c5x8NBjVkf53wtXCklMcmMplz4yKYS?=
 =?us-ascii?Q?HUA4l+iaB7iynDeEOlGIn/PB9bOY0APItuR+IK3u8RFpHQz7+W8YVKnCafK1?=
 =?us-ascii?Q?9eixVibsecZQbX9NRIHU6GRwFEiPKF1vef9+DcNa82muBbAjiNV0wETnNCGe?=
 =?us-ascii?Q?ZGlW2SeaVMYo33R3S1JDaBBz+7BGebGMNA6Jrd4Q3xeE6iQqoupTk2fOBqWm?=
 =?us-ascii?Q?coOrGgb+a+Uuoaj3/KoeFx8W8F2EmUYdy3BRmOKH9Liso2KUxJbHbmYC+hjN?=
 =?us-ascii?Q?KaxPhjO6YgN7XrKXyG0bXD8NIyGD9jJMkZBO/PbvlACjf+tiqPNXUOxdLRZN?=
 =?us-ascii?Q?00j91ZixqnTxb3pN7kH9dKu1waj1oKpGtwP93YRwPSz9YWNLCsvDld7dSa4Z?=
 =?us-ascii?Q?L9CMb36j5Hd9mlnKiQp/vgOdMSFNpIpf5B9pO4Og+8iKRXR5IGkvFbNeYuql?=
 =?us-ascii?Q?gstJlewNh1NNhO+URhy4KvZ2PhjakmQ3K65K5rEouOsXdv2oHQmyEra/BKMt?=
 =?us-ascii?Q?IILJ24bJqYRVEivXFpA+BOp3k5UQ5CfL59g4vMratSJcbI1Q7K4RsZvkx+VL?=
 =?us-ascii?Q?+cd69FCqIk2+StbXsAWkNB6ERIOCsgQ9av1ZmNeCsFbYJ8F8CYUKlFP7S8Ak?=
 =?us-ascii?Q?t8YOymG/Fp6jk+ETvQsSaQvaYh6DAKLNbYNnqvGuoPl6TG7M1rjv0D4D8TPp?=
 =?us-ascii?Q?tjEZFfDN1Uhbg45Q22ZM/1ZtK3LLcCBkOJYpA+VbAS0NHr18MMWVdPJ2yFp+?=
 =?us-ascii?Q?dkHNkUSicfMwZdRF9gGXSPQIQ/Pe6un9V2qLMZ2Op/gkEfYW74TjafWflb8b?=
 =?us-ascii?Q?Dah6h+k0jQ1KtaHuFMuH9OGL+2yEvHpxcZrB2LfkoHhORive7ouBDvHJKdP3?=
 =?us-ascii?Q?CuGJnApm3HRDYEERbOvOmiSjqds97p73nJ4osezTXhvPCyZz5Qh+UrJPvBOD?=
 =?us-ascii?Q?PaFAApxvc6dKea/9Xg7B6zSa2J2pWi4lTs0Kc13OxrzmgsKuhHFgHVcyMm4n?=
 =?us-ascii?Q?vyeR1WAliDpRI/enq60PTisDriTfPzF/mdrCd/j7BPpaNSEtCopP6ou/B5eh?=
 =?us-ascii?Q?tRohlSaTXzyySGyOuNCURGHiiO67GqN9W+DF5s5oGKG/uDtG+NQpVrIoFqNK?=
 =?us-ascii?Q?CJJ5MBfm4qB9VLvPaUfrpL3xSlhS5akAbco0ASX4/wyoLzeYlrIdVwPuEuUN?=
 =?us-ascii?Q?deh1seW1d6hKMl6gAwc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7505cbe7-58e5-45c5-0a5a-08db973778b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 11:14:30.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5SFctj1nQjU0OGn+PFFIdkUnsOV1TFcWJ+L06joE6nzfUzI1J51Zoq0e7zT93CjymshV088JbOT06MjB2Arwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ignore this, as I missed adding one patch

> -----Original Message-----
> From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Sent: Monday, August 7, 2023 4:35 PM
> To: linux-kernel@vger.kernel.org; robh+dt@kernel.org;
> bhelgaas@google.com; krzysztof.kozlowski@linaro.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org
> Cc: lpieralisi@kernel.org; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Simek, Michal
> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; Havalige,
> Thippeswamy <thippeswamy.havalige@amd.com>
> Subject: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value and
> remove unnecessary code.
>=20
> Our controller is expecting ECAM size to be programmed by software.
> By programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up
> to 16MB ECAM region which is used to detect 16 buses, so by updating
> "NWL_ECAM_VALUE_DEFAULT " to 16 so that controller can access up to
> 256MB ECAM region to detect 256 buses.
>=20
> E_ECAM_CONTROL register from bit 16 to 20 uses this value as input to
> calculate ECAM Size.
>=20
> The primary,secondary and sub-ordinate bus number registers are updated
> by Linux PCI core, so removing code which is updating primary,secondary a=
nd
> sub-ordinate bus numbers of type 1 header 18th offset of ECAM.
>=20
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202308040330.eMTjX3tF-lkp@intel.
> | com/
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 176686b..b515019 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -126,7 +126,7 @@
>  #define E_ECAM_CR_ENABLE		BIT(0)
>  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
>  #define E_ECAM_SIZE_SHIFT		16
> -#define NWL_ECAM_VALUE_DEFAULT		12
> +#define NWL_ECAM_VALUE_DEFAULT		16
>=20
>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
>  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> @@ -165,8 +165,6 @@ struct nwl_pcie {
>  	u32 ecam_size;
>  	int irq_intx;
>  	int irq_misc;
> -	u32 ecam_value;
> -	u8 last_busno;
>  	struct nwl_msi msi;
>  	struct irq_domain *legacy_irq_domain;
>  	struct clk *clk;
> @@ -625,7 +623,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie=
)  {
>  	struct device *dev =3D pcie->dev;
>  	struct platform_device *pdev =3D to_platform_device(dev);
> -	u32 breg_val, ecam_val, first_busno =3D 0;
> +	u32 breg_val, ecam_val;
>  	int err;
>=20
>  	breg_val =3D nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) &
> BREG_PRESENT; @@ -675,7 +673,7 @@ static int nwl_pcie_bridge_init(struct
> nwl_pcie *pcie)
>  			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
>=20
>  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> -			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
> +			  (NWL_ECAM_VALUE_DEFAULT <<
> E_ECAM_SIZE_SHIFT),
>  			  E_ECAM_CONTROL);
>=20
>  	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
> @@ -683,15 +681,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pci=
e)
>  	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
>  			  E_ECAM_BASE_HI);
>=20
> -	/* Get bus range */
> -	ecam_val =3D nwl_bridge_readl(pcie, E_ECAM_CONTROL);
> -	pcie->last_busno =3D (ecam_val & E_ECAM_SIZE_LOC) >>
> E_ECAM_SIZE_SHIFT;
> -	/* Write primary, secondary and subordinate bus numbers */
> -	ecam_val =3D first_busno;
> -	ecam_val |=3D (first_busno + 1) << 8;
> -	ecam_val |=3D (pcie->last_busno << E_ECAM_SIZE_SHIFT);
> -	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
> -
>  	if (nwl_pcie_link_up(pcie))
>  		dev_info(dev, "Link is UP\n");
>  	else
> @@ -792,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device
> *pdev)
>  	pcie =3D pci_host_bridge_priv(bridge);
>=20
>  	pcie->dev =3D dev;
> -	pcie->ecam_value =3D NWL_ECAM_VALUE_DEFAULT;
>=20
>  	err =3D nwl_pcie_parse_dt(pcie, pdev);
>  	if (err) {
> --
> 1.8.3.1

