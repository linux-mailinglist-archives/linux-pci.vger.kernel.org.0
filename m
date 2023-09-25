Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2D97AD0B9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjIYGy4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 02:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjIYGyw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 02:54:52 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC48A9;
        Sun, 24 Sep 2023 23:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUbQLp1QVaheg4PMzAcvAuMwkEbC/iqa34vTMhC3kjo9qmFVrx/UPR5VfKui4WOUqSLOP0fqppYxfp/LISn84eUfS7CazCgLyqtn4yuAUbOzBziCPvO8/Tefw2HCrFpPoPGeQiwLbSFIyLb8sH9xfdEDOlzeDSApPdSynWNdLLLfrRN8cJUPZSa+cqgwjJnrS9IS6VBl04ncq5Y7D9lHV0YSR83Z7fW4e7ha6x200vHpS4PfI46Xf+CorkLA3HXev77ObrfV3OKuW4UYM/NQy/cXC8zDUn1ibVa7Zdcgj8VhuKqsik53xddZhRuTV3qTAkVKLwXcfZgywY/Dz/+hug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoRM0M4oCzFMS+TMpuoaSAunr4+fiRRqJlUvFWWffsQ=;
 b=TZ7hyt01DBZrfvFRF7N+Y9m9rdh72YP6cClMd56kMGfSFCQoUia1o8nm51Wl3JogrLOCRK0ewOSNsTm7ZODlPce7WUfvg+Hij/pwaPgjmbThjL4w6bIUVda+RVQYDyVtxZ8Lvg9qVK2DP9HHouTAYZ4vx6IIe9IARYubCbei4RgH0fS4ZH7hrYI6e7jIxtrAh51M4a7nP3QAE8yiEtyr1r5PiW7wT084DPGrgoBfUxMofdJdYytiHBnoSZJPV9OgGImKcjLSV+3TiS6yeSQak5QfpgyCXizFWMUaEHOLElXXuMl8EkVaEQi+7Tjpg/J+JEsrl4G26t3siNODLM2yZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoRM0M4oCzFMS+TMpuoaSAunr4+fiRRqJlUvFWWffsQ=;
 b=Nf2/Uuzw50cteSmB5dcPb6N8X8fHSU0xxk0J/s8SoWrCcL52YHmc7Hp+VTTrrmkhaDImBnSEPSn/5ETlXvtXgSRQ6Aa5rsjqDXA22giNT8bK1OEyP4r6LTJwSNxRJ/0tya4tUwXY9Jwb5smAiy01xi5kzOgZfXS9zfaVeo1KX/8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB8739.jpnprd01.prod.outlook.com
 (2603:1096:400:18f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 06:54:40 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:54:40 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kernel test robot <lkp@intel.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: RE: [PATCH v21 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support
Thread-Topic: [PATCH v21 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support
Thread-Index: AQHZ7SGG731ZoKcWlUmOj881Ilc+nrAm3FiAgARDKvA=
Date:   Mon, 25 Sep 2023 06:54:40 +0000
Message-ID: <TYBPR01MB53413B00BEFA34B4ACA4AD68D8FCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230922065331.3806925-14-yoshihiro.shimoda.uh@renesas.com>
 <202309222125.KiN4nFhD-lkp@intel.com>
In-Reply-To: <202309222125.KiN4nFhD-lkp@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB8739:EE_
x-ms-office365-filtering-correlation-id: fc6a8593-d0fe-43d9-d61d-08dbbd944a48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQapwxoXrN1HYkAowGGDGOmeV3rxrp/Qr+aEBgf6Ssosn3ISly2qomUAojLSZ/cfRq44uG3sw0KjiBlhGbn1nj7tBt3VmLW7b2atZKovGZw2bXGUiKJ5LQU6pUWLGRauQquJXLzkqqzaDUeaASlWX9/d6zPr41F0l3PGNkODtaknpvycS1tenwggOwFzErp1kIedg+KKzK7xYLsUuuvczH9qjguYZbD8SD/KlN20Y3YH14r0N70OH8C3CyCE0xajVFj6zjjl3UR0m5klDA1S4QMIi1f4rZslI0CFvNuv1ztvWKnyJvlkOFct0N2nYDT9Qd6cWWj2APyXE7regWcy/7q1XsK4CGn/4ZajgA39flvb2kTKaFLclmYePVVR6/6rdoPup4Po4zvcEEB5plGZ7YfwmDKblds6fCBloOBFmPLEZ7pCOYFqg/TOFPkSlCcqtQxoLNpVO8No+5k1rHbiogylFlnbSObs48AItLHkXx371gyKHqt7B/vHhwaQlr5odHUH0zcA07HdWopjWAtDutvXXMytWO3K97RlSfAgbpbqR0Ir25ykSP+CjfEBz7apTHq5QFbuDp5Y8TTNukX327fRXk6LZq+NOy+cxtRVSqNBJGxBfMsxIqUl9Wm8xaJH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(33656002)(122000001)(38100700002)(38070700005)(86362001)(55016003)(5660300002)(9686003)(45080400002)(2906002)(66476007)(478600001)(41300700001)(52536014)(966005)(76116006)(316002)(66556008)(54906003)(64756008)(66446008)(110136005)(66946007)(71200400001)(6506007)(7416002)(7696005)(83380400001)(921005)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xcRcuxwzkkgucWk/5KwGVpeqn2IR44X6lNmGWNjgjVoMaggICub7YO+pabF1?=
 =?us-ascii?Q?9s8e+8gj+CJvphV6FdW+7AhmJ3BQuzoLW3jc9XGyNRZrocvwctuLiYRI6MlX?=
 =?us-ascii?Q?KYVluTCQUmdglLtd9/AY1sDrU1HAobDX0VW40oih8EE6RZRkbZlJTURKbXLo?=
 =?us-ascii?Q?XZXLRZkoLNKRi0WrVOjL9EDkpZizCgBB6oysGUsLWEfuVMyN2XfNT0OElLwb?=
 =?us-ascii?Q?vFktUa+Slxi06Z9R94VkuYUm+GV7GaiMNWI+Nx6LXXJh76NCLt2Yotfq5A08?=
 =?us-ascii?Q?ayQQPvYj2xzWHI0KX1siz1Q5aDP7pnMVfdhpt0vURAJntxzMlpywS3aHij+K?=
 =?us-ascii?Q?Xm5g/VjP80gpANJP0RXrSztgus+8OMMPXdGz8hLoEpN0mLJQrd2Zq8XYzr1H?=
 =?us-ascii?Q?Nu6R0Vs/6BTuJZAWtUy/Ks/bSlTWRGdXQiuEDC6Q1StKoiVT8pbBE+IqE2Wi?=
 =?us-ascii?Q?YTE9bffIhg7SA9tuZtoCsSGJoESDeWV3wSMVdhs14kJjKJx/a2PsaowWfnW6?=
 =?us-ascii?Q?4GAHi21IAlZLKmuJ9wl149wwutFNuaCKrkFjq6M/TpUQ+cIJrzrKpfDVCg7f?=
 =?us-ascii?Q?S2UpGorcm80yUCrdbljzll/SDeqWYicPi89QaDKMIfDaorGcBbg6+Fr3ozSG?=
 =?us-ascii?Q?57O4a7+x2FuEDB4fK8taeVDnQ1RP0IMCJusk9JqFGFvgzVuzUtoXYW6Ud+/i?=
 =?us-ascii?Q?qWDlGNkSaMlHBq2WbGumZ64hRZEmyFUduykfAWvbAtSxOOt+6V+uFWuo5x7R?=
 =?us-ascii?Q?c9bvdUqsQQ2x08WDKYAtP7+5hvDvUw1ezVQ71DdSO7Csde/Hk+q3nWVwv3Vo?=
 =?us-ascii?Q?qwtIBJTURHS8QZcZsx81hCCUzUmKk+WDY5+k8ppae+44iHqKpwMOfkP9xEEZ?=
 =?us-ascii?Q?5kzahOQK5GlwzpFxvGdj4dYKWZ6g5P3Iuyf81zAqYeTvUYzwY5hVlqw5aKym?=
 =?us-ascii?Q?lZN0TPGyDiWagnJNmel2HrBkrmB0bIH1bkCjli2BrbEIooBcuqv0oRi393nX?=
 =?us-ascii?Q?Xx7dghvR+7s3gV1rsBXLpYLuJ2Ez2CFLsZ2R2hKrDaF76Rwijs2mLZn2kCuW?=
 =?us-ascii?Q?su+TrmbXlYzb+2zxZ6xdOnI5YnX9YALhhx7aPiWmf8qZC5NB/kurR7YMl7ff?=
 =?us-ascii?Q?mCECFBVCCsBAoeZJ/EaMAVIDtHvfhta07olOx0NDhmqMVVOHRU1OA3jBZNE0?=
 =?us-ascii?Q?Cw/IXqCAMnPeiI2OMORPuarg5E0CRNXg0IjKSoGZiklaG7n+mCXfSA1i5iFz?=
 =?us-ascii?Q?A1/TWqyTkhQt0/S3BtJFJRNzZqqhRelfamqJN2wEWkz1nBnnWIyoQ6ebTazL?=
 =?us-ascii?Q?PUgPnfFTFxUGqVXEfInvCRPbYJl2/1pqv8kyBAhgu4gf51p7AMeo7XDCNJB3?=
 =?us-ascii?Q?CGeu0i/614yYqtIRuX6mV3zZHJ2LNeFq6ODYoz5xTwWU/f4Lm0W47Qtn8SV0?=
 =?us-ascii?Q?fM4/Vct2DmEuu0h4OYk/Y5Jg46uConpywbevXyJ66hRUz9xnkTfQcPnOoLZF?=
 =?us-ascii?Q?9gG5PtME03uNNJEo7xV8rKAnYg80zJUc5PKjzEgkxOYfsF0b5w1J9qvHWn2E?=
 =?us-ascii?Q?h30tmSJUrbNsOo82uBYu6J1VcglS7707vPE0c4mdvxedvwSec2PXvW93ey0N?=
 =?us-ascii?Q?H5P9v0ZCpilEp3k9xM9UAS+b27N7HZ5oqVMy5q9FzG2XQ8SrPPJIh7lg5j/e?=
 =?us-ascii?Q?UN9+ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6a8593-d0fe-43d9-d61d-08dbbd944a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 06:54:40.2022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIe6KSU5aqVPiH5Z/tjyI8+HTdle9Lz7qS5G6GMoT8PsjbZdGuF2TXl3aWAn24du3FRYRW42+rcqi3itgWWYZoa1+vhUZ0uf9VRzDBgTyTaOzljtzQNp4+vEasorBS+8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8739
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi kerenl test robot,

> From: kernel test robot, Sent: Friday, September 22, 2023 10:47 PM
>
> Hi Yoshihiro,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on pci/next]
> [also build test WARNING on pci/for-linus linus/master v6.6-rc2 next-2023=
0921]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
<snip URLs>]
>
> url:
...
> base:
...
next
> patch link:
...
> patch subject: [PATCH v21 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe=
 controller support
> config: sparc-allyesconfig
...
> compiler: sparc64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build):
...
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
...
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/pci/controller/dwc/pcie-rcar-gen4.c:155:5: warning: no previou=
s prototype for 'rcar_gen4_pcie_common_init'
> [-Wmissing-prototypes]
>      155 | int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/controller/dwc/pcie-rcar-gen4.c:197:6: warning: no previou=
s prototype for 'rcar_gen4_pcie_common_deinit'
> [-Wmissing-prototypes]
>      197 | void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/controller/dwc/pcie-rcar-gen4.c:205:5: warning: no previou=
s prototype for 'rcar_gen4_pcie_prepare'
> [-Wmissing-prototypes]
>      205 | int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
>          |     ^~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/controller/dwc/pcie-rcar-gen4.c:220:6: warning: no previou=
s prototype for 'rcar_gen4_pcie_unprepare'
> [-Wmissing-prototypes]
>      220 | void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/controller/dwc/pcie-rcar-gen4.c:228:5: warning: no previou=
s prototype for 'rcar_gen4_pcie_get_resources'
> [-Wmissing-prototypes]
>      228 | int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/controller/dwc/pcie-rcar-gen4.c:242:24: warning: no previo=
us prototype for 'rcar_gen4_pcie_devm_alloc'
> [-Wmissing-prototypes]
>      242 | struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct platfo=
rm_device *pdev)
>          |                        ^~~~~~~~~~~~~~~~~~~~~~~~~

Thank you for the review! I should have added "static" to each function.
I'll submit v22 patch series later.

Best regards,
Yoshihiro Shimoda

>
> vim +/rcar_gen4_pcie_common_init +155 drivers/pci/controller/dwc/pcie-rca=
r-gen4.c
>
>    154
>  > 155        int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>    156        {
>    157                struct dw_pcie *dw =3D &rcar->dw;
>    158                u32 val;
>    159                int ret;
>    160
>    161                ret =3D clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CL=
KS, dw->core_clks);
>    162                if (ret) {
>    163                        dev_err(dw->dev, "Failed to enable ref cloc=
ks\n");
>    164                        return ret;
>    165                }
>    166
>    167                if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR=
_RST].rstc))
>    168                        reset_control_assert(dw->core_rsts[DW_PCIE_=
PWR_RST].rstc);
>    169
>    170                val =3D readl(rcar->base + PCIEMSR0);
>    171                if (rcar->mode =3D=3D DW_PCIE_RC_TYPE) {
>    172                        val |=3D DEVICE_TYPE_RC;
>    173                } else if (rcar->mode =3D=3D DW_PCIE_EP_TYPE) {
>    174                        val |=3D DEVICE_TYPE_EP;
>    175                } else {
>    176                        ret =3D -EINVAL;
>    177                        goto err_unprepare;
>    178                }
>    179
>    180                if (dw->num_lanes < 4)
>    181                        val |=3D BIFUR_MOD_SET_ON;
>    182
>    183                writel(val, rcar->base + PCIEMSR0);
>    184
>    185                ret =3D reset_control_deassert(dw->core_rsts[DW_PCI=
E_PWR_RST].rstc);
>    186                if (ret)
>    187                        goto err_unprepare;
>    188
>    189                return 0;
>    190
>    191        err_unprepare:
>    192                clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, d=
w->core_clks);
>    193
>    194                return ret;
>    195        }
>    196
>  > 197        void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rc=
ar)
>    198        {
>    199                struct dw_pcie *dw =3D &rcar->dw;
>    200
>    201                reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST]=
.rstc);
>    202                clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, d=
w->core_clks);
>    203        }
>    204
>  > 205        int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
>    206        {
>    207                struct device *dev =3D rcar->dw.dev;
>    208                int err;
>    209
>    210                pm_runtime_enable(dev);
>    211                err =3D pm_runtime_resume_and_get(dev);
>    212                if (err < 0) {
>    213                        dev_err(dev, "Failed to resume/get Runtime =
PM\n");
>    214                        pm_runtime_disable(dev);
>    215                }
>    216
>    217                return err;
>    218        }
>    219
>  > 220        void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>    221        {
>    222                struct device *dev =3D rcar->dw.dev;
>    223
>    224                pm_runtime_put(dev);
>    225                pm_runtime_disable(dev);
>    226        }
>    227
>  > 228        int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rca=
r)
>    229        {
>    230                /* Renesas-specific registers */
>    231                rcar->base =3D devm_platform_ioremap_resource_bynam=
e(rcar->pdev, "app");
>    232
>    233                return PTR_ERR_OR_ZERO(rcar->base);
>    234        }
>    235
>    236        static const struct dw_pcie_ops dw_pcie_ops =3D {
>    237                .start_link =3D rcar_gen4_pcie_start_link,
>    238                .stop_link =3D rcar_gen4_pcie_stop_link,
>    239                .link_up =3D rcar_gen4_pcie_link_up,
>    240        };
>    241
>  > 242        struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct pla=
tform_device *pdev)
>    243        {
>    244                struct device *dev =3D &pdev->dev;
>    245                struct rcar_gen4_pcie *rcar;
>    246
>    247                rcar =3D devm_kzalloc(dev, sizeof(*rcar), GFP_KERNE=
L);
>    248                if (!rcar)
>    249                        return ERR_PTR(-ENOMEM);
>    250
>    251                rcar->dw.ops =3D &dw_pcie_ops;
>    252                rcar->dw.dev =3D dev;
>    253                rcar->pdev =3D pdev;
>    254                dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
>    255                dw_pcie_cap_set(&rcar->dw, REQ_RES);
>    256                platform_set_drvdata(pdev, rcar);
>    257
>    258                return rcar;
>    259        }
>    260
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> %7Cyoshihiro.shimoda.uh%40renesas.com%7Cbcb9117ada5545f21dd908dbbb7279cf%=
7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%
> 7C638309872567098849%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00%7C%7C%7C&sdata=3DhZzw8jndtIs8RuMO9fvilRhybUCLFgA7gEyUSEdxZuI%3D&reserv=
ed=3D0
