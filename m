Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5EE76A908
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 08:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjHAG1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 02:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjHAG13 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 02:27:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3171BF5;
        Mon, 31 Jul 2023 23:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfwmxHJWDD89k7XTRZNg+fLWM4Dzb1HTJWjIkrm22L8owXjg9HVJQCJisfQMRH8cSopPvhHJS97ZJevXGVa86vyJNRoDM8NwS6YWHAKIw30j7R1NriVT/MWFxS/VS06eCu3Uk8KSWJrGfoYvt4pL2lsZidX1SsEBHVQdqu6zpxVZL3A4c8ilArzckJzPVSxUay4HHVGlQ7M90eNDrIj4YvFijVJB3saUMJoAFR3ohUu4YB+srxQYFJ1teDv1TIgkDeWegvN2VcQ8K8a6i4G/uLXKBbrhatk550cJTYiqe81CUcalx/wnQmBIgCMWMkOqyD2d91W0OSDe5f2xbFoNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXM1YLqHS9VSL/nR+aympyWspvEm9yXwbA6/unwQYs4=;
 b=K7K7VK6xeoviq5buP1ok3xEHcvfXP98qscjdUqBYPDMPNeV+xPdqG1HSCcprHtGNYhpS4SOqWK+jNebVfctqPaLqnZY6yU546iiSdTBM11I/jgErnJxGhkXZTTl5ggXSNFPsSvH8QCZWNL0dIxld14Ed3SuGYMKSaHdP6aR5TtvcyNIGiuoLkIc0qjf78Osr+eF/t5QVlCusKqLtjSlieqkotdfVZ5ngBjsWFRza+T/RkJq0FCpJrinGiIKR1SXUtE22FUElA/EpyRs9d1ZotMboT4nuUleJCUSvub8GbzEo+4m5QU0QqomdX6ucY2O5AsMYwwd37WXutCDCOJtB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXM1YLqHS9VSL/nR+aympyWspvEm9yXwbA6/unwQYs4=;
 b=kdKYvUGBAhQGuekJAniye88r3t8wKLDG6VrlIVyJ/iGfWNJbSq9kVcUPyRa0AtIUXIrz0e31fe0eLy5sTRhWhpUL9lyfGVH74bJ7NPCfOAI2MqpKbzLJPVKUtRoOP4eskZOk05ArhB4OanXIOeAjqyggg0JZ0kGAlui001d9uq8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5801.jpnprd01.prod.outlook.com
 (2603:1096:404:8056::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 06:27:11 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 06:27:11 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Thread-Topic: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Thread-Index: AQHZu6dDbPirdu9Cv0mYGgD3jy/19q/UpTSAgABlsfA=
Date:   Tue, 1 Aug 2023 06:27:11 +0000
Message-ID: <TYBPR01MB53414660AC54EBE9CC203136D80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
 <tv2zdgteqgbk4pxa5mh7eihbtif3hokjemy7gui6uof6rkxj4s@ffxyoqfs5fsj>
In-Reply-To: <tv2zdgteqgbk4pxa5mh7eihbtif3hokjemy7gui6uof6rkxj4s@ffxyoqfs5fsj>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB5801:EE_
x-ms-office365-filtering-correlation-id: 7e875579-8e17-4a86-e9dd-08db925856ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jdSeSvZawpr+F/i9qIfDK6+cMitXOof7aTXCEmlEfg/erRLtMQW5bVQ4WqiIWH+G3LTE6b9FdxYX2oTqFQeEzdpixGFDzgY1EL5QCVg1tljmNAsQfjtyeDuNZqbiDC8GlW9Tzk2zsME1j4TBuMXACsyad6Fd1b2WyCBfxRCpDI3NuKdXR7AbT0XVgbbDRz8ffIiU4Mya6tF3x9EB1+AEbkS+/3emMhW7YYZKQlZE3f70O66iJDrxta57KaeHAG/5czpJmdz+tqI+c7Mg3LKIhM8otCDO/gFseO5bkOP5TSr/DmbPYkudecUradEEygydJPTx48TZ+uIhkH9GCw3PavUrB7zOXgLb7JcS9E0He4G/NfoB37bv/e/OpsQftYRxGGTRrUcGxQU7hIfAvsKd8oP0Vs43qjGIWl2XNY7Y67v3Gk4UNQiw1Z1P7niTQEPAGdiYu9xITImCaiYX6sCrNQpvldQyyZMbEJ4288uStv8cTlOVU2udZuv11rDZVx2tn99iyGT6iB5BAZXZDPjijKERonpiytna0tBQV2u26sutL2bYpkURDpMW4XxHxtf/DPAzyv2yn3d0ZhT2mPBZ+9QDdr0E7MnYnEV3lo2N1uktyNvrqREoS7hYeL+SUYTndi/EF6qaS8fG4A9o0UlN3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199021)(8676002)(8936002)(26005)(38100700002)(86362001)(122000001)(41300700001)(38070700005)(83380400001)(2906002)(6506007)(186003)(33656002)(5660300002)(55016003)(52536014)(7416002)(6916009)(4326008)(66446008)(66476007)(66556008)(64756008)(66946007)(76116006)(9686003)(71200400001)(54906003)(478600001)(7696005)(316002)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VnhV0+I2sxygOwS1figMeHACC27k+2G3YIcdx+oj8gST5xJ7m95SGAczRagm?=
 =?us-ascii?Q?W/jlq8xiQMcDvZkrMSD+BowXwEQPBiYjgbIe2b6mFsu6fpuZgRHMz1Nxpgtl?=
 =?us-ascii?Q?QXWC3WB1KRirLTTy9Ia2aTeF24hdsoShKp4gST6n87Cc2ZXXfZJDqzwiZubG?=
 =?us-ascii?Q?r4Ux0a9pZ5+HEy9twprwp6LT3hYQoMv8iRvlTXCa+f7obkco0q1bfy1B7Bm3?=
 =?us-ascii?Q?eprncxoXI7OQpGhcbh4Lj2ygky8PYYcYQjgTQDSjmfVyzkLxiJ9rAaanB9JW?=
 =?us-ascii?Q?H34oQdGI41o6ENd5Z9yOKPj2VuOii/BNUwCA1FZcipR1D2P0v+3nPpIrxfqf?=
 =?us-ascii?Q?adgdQNZ+06Tb9QlZn7Dx/Z5Np+Jz+6mK9O3VrwYGo3iLXvY0PYgyEX7e3Xio?=
 =?us-ascii?Q?cJoo1LjIi2ew73TZza4CRmnk97MhCiWekNC+mna1eqgiyN0O/5Tff904cA5y?=
 =?us-ascii?Q?v/wgPndY3u+RH+zO+rV97YK1+7jdU+eGyL8KUk6B4huOwy1BB4UJexsvVXm9?=
 =?us-ascii?Q?lT2ey2+ru0zl9C81nCybJAx1NkItnkto9ssshfQ+ZB9lmkgNzvNv5HtGQRZs?=
 =?us-ascii?Q?67/x3Le7rwEcjTI7yncvz8uHYPDIST+/kZ5tsLhyjmnvBzWmlDmhf7emQBH/?=
 =?us-ascii?Q?bs8BsrP6Cpv41HpSUzHLNX7jDeY3Y/rWKJrUzhRAvl8TLJ+iOmkrJgX3uQPm?=
 =?us-ascii?Q?EzxOoYLRMXmtuJYB0MxWZYD+Ovytoj16IC0hMNaCD2TPFtkg3OOMX0GTOkHb?=
 =?us-ascii?Q?W//5OVNL5a3h4MqwvzgTWYpPCb3IU3Qs2VvA/cRSqHHW+WPJyH88H0ddi+Ty?=
 =?us-ascii?Q?Xkk8qFZM9ky2NLvf2tFByABcfkfdsULrF26oAAwLCwmsSBEiHM7z0TVmp1NZ?=
 =?us-ascii?Q?zXEKKvEwqeqj+fSrb4JmiWRN0oN/9E8yzsXE8OLjsn80sojTcvoeOx7TaF7i?=
 =?us-ascii?Q?OqFfKBkRyatJoyG3G6qUNYKdbYTGvnAsCq/kUoCLSIowNtEUYWAkBh+Qdcxg?=
 =?us-ascii?Q?d9vGXfF8UMBvE/Jk9QHEndFQICExXoK7s6qlkouMP/xAKVRsMf90MM5owuzl?=
 =?us-ascii?Q?EIAnEYSk6ppyCH7nhRXpqTXJzG1qLetXwfr7esZfFotISNA8IDIGTXbXwjxE?=
 =?us-ascii?Q?WoLjtUUCdoyPiVHMrg2ivXEVuhmcGjAJyY+bRiaM9VKgllZNQ88jV9bSAqPg?=
 =?us-ascii?Q?V8XuGbx6QLn01ycwd3LSzl6yOK1cLAcLK7bqrhRQ9umr35vJufXmNU9rAiQ6?=
 =?us-ascii?Q?zsnr6xd8JgKrafYct19dgE5gNtn9IS6jDGOzdZNRsxnVM/XHptbRc/FheJI1?=
 =?us-ascii?Q?qcMDDo/wMZ+NihyA27CR8s2Y19HVkLWGpTyNO7PLaw6QM6rwQ945gVJyVh7b?=
 =?us-ascii?Q?74XALFnZoJsU34VCLsOM60hnM3J3kNpqN9c8WcaYqAbUucbjzM4Mjn+UVjfe?=
 =?us-ascii?Q?SfjpAPn8u8nRsF/jIIieCdRIpztddXDfMf4AXaiE/CYSfCfbVOcoELfpahPw?=
 =?us-ascii?Q?ZxDSQe+Z3mu1G0eLm4yORJIts9+K7/LFqM6PTFxeeSGNs7aSbnTHzlrnhFS6?=
 =?us-ascii?Q?bYLvpX5vEPZnORG+hPftw2yHyF2GwN6EU97MhBPDubTJd+peDNxnHG0apCmk?=
 =?us-ascii?Q?UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e875579-8e17-4a86-e9dd-08db925856ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 06:27:11.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABI0RUFOI7/hMr0fPRQWQZKwznDGc0jkehADmw1AcIQH+eqNDcnvgBl0aeRU+nrKyCWNn8OBx1D5ezjzXGvELC1b3zA6tLnfCAUW75vS12WAWelhc8UpP4OInwvFYy23
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5801
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, August 1, 2023 9:22 AM
>=20
> On Fri, Jul 21, 2023 at 04:44:45PM +0900, Yoshihiro Shimoda wrote:
> > Renesas R-Car Gen4 PCIe controllers require vender-specific
> > initialization before .ep_init(). To use dw->dbi and dw->num-lanes
> > in the initialization code, introduce .ep_pre_init() into struct
> > dw_pcie_ep_ops. Also introduce .ep_deinit() to disable the controller
> > by using vender-specific de-initialization.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 ++++++
> >  drivers/pci/controller/dwc/pcie-designware.h    | 2 ++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 14c641395c3b..52b3e7f67513 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -684,6 +684,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	struct pci_epc *epc =3D ep->epc;
> >
>=20
> > +	if (ep->ops->ep_deinit)
> > +		ep->ops->ep_deinit(ep);
> > +
>=20
> This doesn't seem like a correct place to call the de-initialization
> callback. I also don't see you adding the de-initialization to the
> cleanup-on-error path of the dw_pcie_ep_init() method. You need to add
> it there it. Afterwards you'll see a correct place for it in the
> dw_pcie_ep_exit() function.

I understood it. I'll fix these functions on v19.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >  	dw_pcie_edma_remove(pci);
> >
> >  	if (ep->intx_mem)
> > @@ -797,6 +800,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> > index 6821446d7c66..c3aeafd0f4c9 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -332,7 +332,9 @@ struct dw_pcie_rp {
> >  };
> >
> >  struct dw_pcie_ep_ops {
> > +	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
> >  	void	(*ep_init)(struct dw_pcie_ep *ep);
> > +	void	(*ep_deinit)(struct dw_pcie_ep *ep);
> >  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> >  			     enum pci_epc_irq_type type, u16 interrupt_num);
> >  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep)=
;
> > --
> > 2.25.1
> >
