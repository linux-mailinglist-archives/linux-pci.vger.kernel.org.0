Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C427AEB8A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Sep 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjIZLec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 07:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjIZLeb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 07:34:31 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F916101;
        Tue, 26 Sep 2023 04:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBFJyAPWrm9oPFEKZoc7xW/Jf/vyg7rAp3zqskO+kX/LqrmUoOfcU8IWusZdjnjCocqt/xji8WVZsE5jtrE1k32i0rnQ5ku4KPy6UUEpqh0Z+nhRrY2flNEUFzV0yB49yqn018l3S09TmQ+gv9v06OhnfV9jQyoCmK4Q/H8NhC+bEEirl4jCZCsT+l7kHqxnZSqmut/3/8mrc92/kieqtmwiv1S4JRaQ7xUU6RBCyo+ayMHEfJPetn0N3xI1hcOVNuQ/sJlH2Uh8z5eqD10/300XFlRvTT9hJaX5Jzi9nIacAvudVbkQZTUOn3qp47UCtJssaELL/yYKj0F5zk9lFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHkBfeG1nL0v+eEmaej18WluIpAngi4KvDaAjNOCb2c=;
 b=Pt+y6T5fpMCcjAsVzq0WBHHDHSnAWtx3y4wmRE4WXAAkJiI4W4ZPPXCqvvJd+Ke5Ja/yCTninKGkeBL8HOLNtt5sLpGezgQu6LSt9MJL2GVGNFctQWXpPXfuRWX6ZdRXPddMdFxBewMSq0/tSsFoOsSCdU/8+m67Xr4aa5SOvH44s7VCNa87EZwJoRtK7bbeVsHdTk6IsmnqrVHXwAId81dlYi4dkcfAG3YqPFP1xGJRXhU7cwREyqyhuwXpE+gMMYvFWAHBEAyrZ3iTPWWtivxCX3jDmZwFZUMxHWXN16M1mkIx/zCm/QjlCvpakfulrLyx2pR76zVMOt8QOP75wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHkBfeG1nL0v+eEmaej18WluIpAngi4KvDaAjNOCb2c=;
 b=AtIopUoblXTBJGEmnsHySxLcxNwmafo7+cgLlzHUdZzReHhScsN8FKT89NGcA6JHvAA/VeqsnhO9UbdplrsiKWkEDcFULeLZQKfTzUt8OwGqtk8IZ4ZEXkqV4UZT7UhHwdPTQIB6f3zjWAEzm+C/t6TqPEDiCZUx0AT2ZuDf3/I=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB10046.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 11:34:20 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 11:34:20 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v22 14/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 Endpoint support
Thread-Topic: [PATCH v22 14/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 Endpoint support
Thread-Index: AQHZ74DtC4H0PaS3oEW1NvpAjGE6JLArXesAgAGdYsA=
Date:   Tue, 26 Sep 2023 11:34:20 +0000
Message-ID: <TYBPR01MB5341853C91713F02DDF32DFED8C3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230925072130.3901087-1-yoshihiro.shimoda.uh@renesas.com>
 <20230925072130.3901087-15-yoshihiro.shimoda.uh@renesas.com>
 <bdv2lgm42igl2anvmyvekasiyioa43prhi3cxskxk33r2zxmba@2mbrybbdyo3i>
In-Reply-To: <bdv2lgm42igl2anvmyvekasiyioa43prhi3cxskxk33r2zxmba@2mbrybbdyo3i>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB10046:EE_
x-ms-office365-filtering-correlation-id: bc98b631-bbb0-422c-74f6-08dbbe8486bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFkyW7pwgHXQ53v2u6yvXIReCbwq6uy+eDI8t/7RKwl4n7daDZ9MwlnTxVlVF80vCyt574Cc6DyNT2KetzK1MipACssPdbclt8PHMwuY/LvlwXwwtMOENfaKHLCjySv3DjQVI2y8ToQkeSgxs5PZVFBFPxGcj2gizBZqe514f2GTRCd9OMWUV2VuAJ9PudXlE1l1RrYtWBxlxUqkhooDl0b71bucShfmcKIw4s3nag97AlalzI46vuhsHoKIAGlU6bUFFabjlvrQWTDawHHLhuYNxr9taHv+rDDIvU8JpU4gLB3vAEGErMowUOgsfdzWc+9nWTBOgLi3oVaUoDsu3+WN8EF+UIoMt2vDf9uk91Vr31emrwy6von/Bb27ikKNZHT/uKLwkgFaDW0G3CWn07vkV3ilBwy4UJIaiLuA7KebMcvrAsav1mBTW3UW4iHXPVyYAuVqiaMYHWvggKu2605Dz95KDWpzcK3chU3rci0FPmXjnKbVMyaKJoicvTP1s8CNC2jt90BHQ8Qlw5rgGuNYOTlDPKJBjljbbxIRVig868uscdkNdUqWslnqFfvmDMeJ2ZWIjx/Eid/xYmVbtvDAe1S3dSOBZEpsQssd6MkPs1uuSbo4n5wu86Qv/IPP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(1800799009)(55016003)(83380400001)(5660300002)(8936002)(8676002)(4326008)(9686003)(52536014)(316002)(478600001)(41300700001)(66946007)(66446008)(64756008)(54906003)(76116006)(66476007)(53546011)(2906002)(6916009)(7416002)(71200400001)(6506007)(66556008)(7696005)(86362001)(33656002)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Ic2QKPZOQlheGyAr4GTY2h3YQzdt9S0ZuVrGemj1DvQNOtL+ICFvvgvhcg?=
 =?iso-8859-2?Q?3PZCuESgGlA1vwyvjVMGhUuG8DcdN1kzqYjA61rA+5H0ypSn/tIafVdSJ/?=
 =?iso-8859-2?Q?CYOpSzsUASf/BrmZNaSuUrxQNA3RVNIhQctoLtnUFNtH+axyZEAYArLhil?=
 =?iso-8859-2?Q?Ti1lKuTP9GkklKVDeU5S92jcu/08HHOdWJFzCsFFyA0Qa8gj9R6wVDgIKF?=
 =?iso-8859-2?Q?BeZl3q7AaWUAMOfnEKTBZ4a9BYJMA2UM8nsNSwsY2sNEZD+36Q0QMRHii1?=
 =?iso-8859-2?Q?7onDr0Ti6va28T6YuPSYXcPx45hR+BfLgeEdHPC1wvCl7V6VHD9uV6qo8n?=
 =?iso-8859-2?Q?goCWWo1LCIXHtd6e7gDqsvqjvW25Dc21HQFsvnixnNA8vGQ3fmS+ShrisS?=
 =?iso-8859-2?Q?kT+oiQXxwWap8B7DBvz++xaPhdPsCIbpCuQUU+Gp6s2IAlz6NqUqAZP8Nq?=
 =?iso-8859-2?Q?seZjds+wiNeUv6cYccthXLg4zSbczfQRN04d3L9PDHag4eJU3M4mBiTlHP?=
 =?iso-8859-2?Q?Bxhp/L6mN1fEcpuxQqKKSGe9ZnUoq9j65iOBAwWYLa/eF2mUOWnxR90KeP?=
 =?iso-8859-2?Q?fTvwyhhvtBEslyJEMa09znc0J024488msYsgJhzQgMP2jvCeDvfKLxMgm9?=
 =?iso-8859-2?Q?a71mh4SXeGTa+G7yDlBcan3p9vY/BuLi9uIEsxNXAAPAn03j0I5Tww1s3N?=
 =?iso-8859-2?Q?qxtZzspV4w8tYn7UigjM/B7pz+lFrvqK7tk0ov0ryvawvKi85LwuZ5Kh1o?=
 =?iso-8859-2?Q?c9wLDNtFi5SehK6BmF2JcBKcio2SMVFwNCcP8q+j8zlKqfrWaG1YKKi8Db?=
 =?iso-8859-2?Q?x+A7lfnp82o+Cj38jV2bVLOvYziI4wdrubsIyvCtNMZRedY6peElCePnOk?=
 =?iso-8859-2?Q?nImgQaJU7CwPEBXuRSD1wTEgB55/IvFwPgMKtkoj+J+EKl11Rmo6SJAbER?=
 =?iso-8859-2?Q?PKL9TKNZAF0lsDj7SxfFnVZRiNM6hfZkyTi/Qh1JlIH6KqDEPTMmOHQNML?=
 =?iso-8859-2?Q?tl+7mMikLK1nLRGZ5+nSjLE9MAnR1nKR5swLSKhvVCChm5Ljm6Q0tFpNav?=
 =?iso-8859-2?Q?hDPkZNgfkNbJDAvIxi9tJ6+HvQf11xn4jljjsUrOJ81IBNyBGKRr1MQCH9?=
 =?iso-8859-2?Q?7T5PTx46ekYIJfxBDQXzSytCrRAt7iIWc9Bkma1pXKNPc8ERy8DRjMCLkR?=
 =?iso-8859-2?Q?xiAIELcktEwZ7pnYcFL167FZsbvJZVrJjbSkXqlZdT3tV6BhR+APrfsVX8?=
 =?iso-8859-2?Q?5pJsOCgxvDMRRYutUKDzqUGP3XHop/LQO4qqF7N1jTee7QZGGDXJfsiIC/?=
 =?iso-8859-2?Q?YnYgHwjQl0pp2XcJVDdbZoPv+N7JW5VgDpyzXwi8MCN9dUFfE35dv63j0v?=
 =?iso-8859-2?Q?jHBPbp49ETGPbEYIDrUGrRU1UrENzENgGIebb4Jos4ubk0dlBmt6yuBi3Q?=
 =?iso-8859-2?Q?osLwaLbamLgC1nMDTifl2BdKT0TUQMTPkuVcscVXSjq+501CgSYPzhbTlf?=
 =?iso-8859-2?Q?kx94ZZlqTruaOcbitQFrE89msS42KzVLlguIHTwU4FCCqnODdkJ1/5BDKj?=
 =?iso-8859-2?Q?4JsrnZpch9KmwXvmB2o4H3hKQeHybOB2zgsyOOkAQ7mM5rTc3UocaSrY2Q?=
 =?iso-8859-2?Q?GQOhnB1VdmeSIK63AG25kx9EXSME/MUVujyLmshiWhZxraNSupJEhQdqX/?=
 =?iso-8859-2?Q?701EfaifgNR1fT9gOxWODaB+XnBMmeak8j8QwOJ7zd3acWl5Alq3zEa560?=
 =?iso-8859-2?Q?q51w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc98b631-bbb0-422c-74f6-08dbbe8486bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 11:34:20.8502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpebflay+EuaN15+bp0enuwPNMYq8jnVycAWac9pZh5g4dg/rvpOYmJ+YOqDHbYdyq/1X6uVcNAbDL1yq5DaA3A4rJlw+IZ37frZPPCNH22l/+24nO8Pj3RkamCT78qo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, September 25, 2023 7:53 PM
> To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org; bhelgaas@google=
.com; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; jingoohan1@gmail.com; gustavo.pimentel@synopsys.com;=
 mani@kernel.org;
> marek.vasut+renesas@gmail.com; linux-pci@vger.kernel.org; devicetree@vger=
.kernel.org;
> linux-renesas-soc@vger.kernel.org
> Subject: Re: [PATCH v22 14/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe E=
ndpoint support
>=20
> On Mon, Sep 25, 2023 at 04:21:28PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe controller for endpoint mode. This controller is ba=
sed
> > on Synopsys DesignWare PCIe.
> >
> > Link:
<snip>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig          |  11 ++
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 136 +++++++++++++++++++-
> >  2 files changed, 144 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controlle=
r/dwc/Kconfig
> > index bc69fcab2e2a..e7fd37717998 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -429,4 +429,15 @@ config PCIE_RCAR_GEN4_HOST
> >  	  To compile this driver as a module, choose M here: the module will =
be
> >  	  called pcie-rcar-gen4.ko. This uses the DesignWare core.
> >
> > +config PCIE_RCAR_GEN4_EP
> > +	tristate "Renesas R-Car Gen4 PCIe controller (endpoint mode)"
> > +	depends on ARCH_RENESAS || COMPILE_TEST
> > +	depends on PCI_ENDPOINT
> > +	select PCIE_DW_EP
> > +	select PCIE_RCAR_GEN4
> > +	help
> > +	  Say Y here if you want PCIe controller (endpoint mode) on R-Car Gen=
4
> > +	  SoCs. To compile this driver as a module, choose M here: the module
> > +	  will be called pcie-rcar-gen4.ko. This uses the DesignWare core.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/=
controller/dwc/pcie-rcar-gen4.c
> > index f6b3c3ef187c..d1b31ea909ba 100644
> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -45,6 +45,9 @@
> >  #define RCAR_NUM_SPEED_CHANGE_RETRIES	10
> >  #define RCAR_MAX_LINK_SPEED		4
> >
> > +#define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
> > +#define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
> > +
> >  struct rcar_gen4_pcie {
> >  	struct dw_pcie dw;
> >  	void __iomem *base;
> > @@ -53,6 +56,7 @@ struct rcar_gen4_pcie {
> >  };
> >  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie=
, dw)
> >
> > +/* Common */
> >  static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
> >  					bool enable)
> >  {
> > @@ -311,6 +315,9 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen=
4_pcie *rcar)
> >  {
> >  	struct dw_pcie_rp *pp =3D &rcar->dw.pp;
> >
> > +	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_HOST))
> > +		return -ENODEV;
> > +
> >  	pp->num_vectors =3D MAX_MSI_IRQS;
> >  	pp->ops =3D &rcar_gen4_pcie_host_ops;
> >  	rcar->mode =3D DW_PCIE_RC_TYPE;
> > @@ -323,8 +330,114 @@ static void rcar_gen4_remove_dw_pcie_rp(struct rc=
ar_gen4_pcie *rcar)
> >  	dw_pcie_host_deinit(&rcar->dw.pp);
> >  }
> >
> > +/* Endpoind mode */
> > +static void rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +	int ret;
> > +
> > +	ret =3D rcar_gen4_pcie_common_init(rcar);
> > +	if (ret)
> > +		return;
> > +
> > +	writel(PCIEDMAINTSTSEN_INIT, rcar->base + PCIEDMAINTSTSEN);
> > +}
> > +
> > +static void rcar_gen4_pcie_ep_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +	enum pci_barno bar;
> > +
> > +	for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++)
> > +		dw_pcie_ep_reset_bar(pci, bar);
> > +}
> > +
> > +static void rcar_gen4_pcie_ep_deinit(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> > +
> > +	writel(0, rcar->base + PCIEDMAINTSTSEN);
> > +	rcar_gen4_pcie_common_deinit(rcar);
> > +}
> > +
> > +static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_=
no,
> > +				       unsigned int type, u16 interrupt_num)
> > +{
> > +	struct dw_pcie *dw =3D to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_IRQ_LEGACY:
> > +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +	case PCI_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(dw->dev, "Unknown IRQ type\n");
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
> > +	.reserved_bar =3D 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
> > +	.align =3D SZ_1M,
> > +};
> > +
> > +static const struct pci_epc_features*
> > +rcar_gen4_pcie_ep_get_features(struct dw_pcie_ep *ep)
> > +{
> > +	return &rcar_gen4_pcie_epc_features;
> > +}
> > +
> > +static unsigned int rcar_gen4_pcie_ep_func_conf_select(struct dw_pcie_=
ep *ep,
> > +						       u8 func_no)
> > +{
> > +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET;
> > +}
> > +
> > +static unsigned int rcar_gen4_pcie_ep_get_dbi2_offset(struct dw_pcie_e=
p *ep,
> > +						      u8 func_no)
> > +{
> > +	return func_no * RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops pcie_ep_ops =3D {
> > +	.pre_init =3D rcar_gen4_pcie_ep_pre_init,
> > +	.ep_init =3D rcar_gen4_pcie_ep_init,
> > +	.deinit =3D rcar_gen4_pcie_ep_deinit,
> > +	.raise_irq =3D rcar_gen4_pcie_ep_raise_irq,
> > +	.get_features =3D rcar_gen4_pcie_ep_get_features,
> > +	.func_conf_select =3D rcar_gen4_pcie_ep_func_conf_select,
> > +	.get_dbi2_offset =3D rcar_gen4_pcie_ep_get_dbi2_offset,
> > +};
> > +
> > +static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
> > +{
> > +	struct dw_pcie_ep *ep =3D &rcar->dw.ep;
> > +
> > +	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_EP))
> > +		return -ENODEV;
> > +
> > +	rcar->mode =3D DW_PCIE_EP_TYPE;
> > +	ep->ops =3D &pcie_ep_ops;
> > +
> > +	return dw_pcie_ep_init(ep);
> > +}
> > +
> > +static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
> > +{
> > +	dw_pcie_ep_exit(&rcar->dw.ep);
> > +}
> > +
> > +/* Common */
> >  static int rcar_gen4_pcie_probe(struct platform_device *pdev)
> >  {
> > +	enum dw_pcie_device_mode mode;
> >  	struct rcar_gen4_pcie *rcar;
> >  	int err;
> >
> > @@ -340,7 +453,13 @@ static int rcar_gen4_pcie_probe(struct platform_de=
vice *pdev)
> >  	if (err)
> >  		return err;
> >
>=20
> > -	err =3D rcar_gen4_add_dw_pcie_rp(rcar);
> > +	mode =3D (enum dw_pcie_device_mode)of_device_get_match_data(&pdev->de=
v);
> > +
> > +	if (mode =3D=3D DW_PCIE_RC_TYPE)
> > +		err =3D rcar_gen4_add_dw_pcie_rp(rcar);
> > +	else if (mode =3D=3D DW_PCIE_EP_TYPE)
> > +		err =3D rcar_gen4_add_dw_pcie_ep(rcar);
> > +
>=20
> So now you have two places with the controller mode initialization:
> 1. rcar_gen4_pcie_of_match
> 2. rcar_gen4_add_dw_pcie_rp() and rcar_gen4_add_dw_pcie_ep()
> It looks a bit clumsy and less maintainable than could be. What I
> suggest is to create a new method which would do what is done above,
> but also would initialize the rcar_gen4_pcie->mode field:
>=20
> static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
> {
> 	rcar->mode =3D device_get_match_data(&rcar->pdev->dev);
> 	switch (rcar->mode) {
> 	case DW_PCIE_RC_TYPE:
> 		return rcar_gen4_add_dw_pcie_rp(rcar);
> 	case DW_PCIE_EP_TYPE:
> 		return rcar_gen4_add_dw_pcie_ep(rcar);
> 	}
>=20
> 	return -EINVAL;
> }

Thank you for your suggestion. This code is better than my code.

> Of course the rcar_gen4_pcie->mode field initialization should be
> dropped from the rcar_gen4_add_dw_pcie_rp() and
> rcar_gen4_add_dw_pcie_ep() methods.
>=20
> and ...
>=20
> >  	if (err)
> >  		goto err_unprepare;
> >
> > @@ -356,12 +475,23 @@ static void rcar_gen4_pcie_remove(struct platform=
_device *pdev)
> >  {
> >  	struct rcar_gen4_pcie *rcar =3D platform_get_drvdata(pdev);
> >
>=20
> > -	rcar_gen4_remove_dw_pcie_rp(rcar);
> > +	if (rcar->mode =3D=3D DW_PCIE_RC_TYPE)
> > +		rcar_gen4_remove_dw_pcie_rp(rcar);
> > +	else if (rcar->mode =3D=3D DW_PCIE_EP_TYPE)
> > +		rcar_gen4_remove_dw_pcie_ep(rcar);
> > +
>=20
> ... similarly I would have added a respective antagonist:
>=20
> static void rcar_gen4_remove_dw_pcie(struct rcar_gen4_pcie *rcar)
> {
> 	switch (rcar->mode) {
> 	case DW_PCIE_RC_TYPE:
> 		rcar_gen4_remove_dw_pcie_rp(rcar);
> 		break;
> 	case DW_PCIE_EP_TYPE:
> 		rcar_gen4_remove_dw_pcie_ep(rcar);
> 		break;
> 	}
> }
>=20
> which would have been called from here instead of the open-coded
> switch-case statement. Thus the driver design will be preserved (a set
> of the init/deinit, add/remove, probe/remove and functional helper
> methods) and the mode initialization will be localized in a single
> place.

I understood it. I'll fix them on v23.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >  	rcar_gen4_pcie_unprepare(rcar);
> >  }
> >
> >  static const struct of_device_id rcar_gen4_pcie_of_match[] =3D {
> > -	{ .compatible =3D "renesas,rcar-gen4-pcie", },
> > +	{
> > +		.compatible =3D "renesas,rcar-gen4-pcie",
> > +		.data =3D (void *)DW_PCIE_RC_TYPE,
> > +	},
> > +	{
> > +		.compatible =3D "renesas,rcar-gen4-pcie-ep",
> > +		.data =3D (void *)DW_PCIE_EP_TYPE,
> > +	},
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
> > --
> > 2.25.1
> >
