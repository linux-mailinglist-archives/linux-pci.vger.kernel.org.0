Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B547AD5C8
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjIYKYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 06:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIYKYS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 06:24:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06A9F;
        Mon, 25 Sep 2023 03:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLBDJrkYgiocpTl8M4ba42sEtypnKbdqxw4KrwxpNwp6ZyM35jYD6iq6xeDdMgYdYcqXA8r68CLut+BGjfswkRU/QLfHUB8m52gqvJSRkK35ehs8wihfjDCV3BUdOChRA9aY/bfhPE/8znjvwi2OdOs16nvb03dOTOA7YH5WpUz+j3LGrcho0M3ZW+JarOP7l1kHMRY2Ta2hc0uUuc8QGC3D69BMqrsjpFZXlvL4umMCi3nD+H5HJuk2ULSQL/5z/KLcebRcuN82PPPAasBImAk4TGOVxcpyXw5edKIDsS7BppyqeePmFp0+/fXYjRYZh2N9EKFLsdpJ09wO0rTiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW8+lUhNE76pefcL5uADh1CtW7rbxH7LNni3yyjlYN4=;
 b=CJQ/FZT9/d/x+jShv0ZUkWD2arroEwTbgtWbof6+t5w26JfFKHFO0cmdJtmxFC6A++0q5Ty8mxC0EOFNNQYgwFtT489SGLVbPPLw/u0SZo47pH+dwiyiENbeNvqblOphf3XKidgnFy3Q6p2xvIsOBNHMy+ukCUS+o4T1sfqZ782rYN/bV0yHiigMsHHWnoIUnz8S9RVzORffXU90UlaF3HHL4Z8IMNxhMQqwdpzYkIxtAZNpr6imMU/lA22QfmaXeI7UG1Up+53etNFxBzYpiush4rmSBrWGu+9LVttd2fJ939xrth5zN9zp4ibMt0CxFRzv+5yshA38A9nGSru00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW8+lUhNE76pefcL5uADh1CtW7rbxH7LNni3yyjlYN4=;
 b=dLKWECWwizbr4s8Hks/WtCj4WFXWRcl2GtWUdNYZY5Cldm8TVepRxzfzD4xySX4kqsNNrWkvRecPdZ8VRW6f+oFZlY4pzqYEPpZkKseC82WcJ8ON+FaPMqKrwLw8ycdlbPUxYnmqO9q8vBUCjMiws9+jZot90Rzfcf8dR0W/GSY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB9518.jpnprd01.prod.outlook.com
 (2603:1096:604:1d4::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 10:24:08 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::1dc4:e923:9916:c0f7%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 10:24:07 +0000
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
Subject: RE: [PATCH v22 08/16] PCI: dwc: endpoint: Introduce .pre_init() and
 .deinit()
Thread-Topic: [PATCH v22 08/16] PCI: dwc: endpoint: Introduce .pre_init() and
 .deinit()
Thread-Index: AQHZ74DrnjBPYQ6reU2dOTf8C4MTg7ArUWkAgAACqFA=
Date:   Mon, 25 Sep 2023 10:24:07 +0000
Message-ID: <TYBPR01MB5341BD0A0B2B7500ED6DBB7FD8FCA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230925072130.3901087-1-yoshihiro.shimoda.uh@renesas.com>
 <20230925072130.3901087-9-yoshihiro.shimoda.uh@renesas.com>
 <enciy4d6trdw5yaltdk6uytllljod7e54e3fsk7a3ht44j3azc@d5bethiemcxj>
In-Reply-To: <enciy4d6trdw5yaltdk6uytllljod7e54e3fsk7a3ht44j3azc@d5bethiemcxj>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSZPR01MB9518:EE_
x-ms-office365-filtering-correlation-id: 1d4a02f2-4d75-4fe6-ab94-08dbbdb18d36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xkZDqPhoIRlQjJVp/MKZPi4HTlSMU9gvDAFkcCxIvEw4/XGFh3RM+Ykw3UggOgycYwgC132yEAPLSXa1WR44I9j+eWSnW9r/tFhz7OSwr0T3KrHISIMQXcxOWtrDQXVm11jLM1Pb3yHQ93WYJv5Wbi5zSochcVWQ6s0o4bq6ivM7+ynIUwFoqIiRau1gilcPpIzfP85oWUp/NBLWcL2Hrpt0IV34U+FX/fG3f964scMNAZ1b30+PjqMrDExnJvrM5B5pLRYQUdLWHB3/VyuT9YFI2ZDXuMuW/JWo2FZU+7MnRZ1iqfc1H9tCFf9wNLnBGMFXJXxt05iHjPST+V7XietlSKuvz8Aroxqjw8enAqCN5SeQ5CE4k1h3JVxBRtPY2+WWNFx0p+ZeSrSey1paAPVakNtMuAVrd6ywEr4C8lHi6vllUo5VaYPV5bvH3cEBdYC6UaoH4y3GQXmepmgLuu0ydbmBogM9GJc0ugMYU7ramD9tMpjgqcFYc+xjt3w5IYTyuiln/tpGWTiY04psgsqcsFo8TfH6fkh/umVIwOxgpdfc761S5nWFsWNaeTiFDGQQ/JBivdp/hfY96GnJL3r7jtShLjbdv2feHEmW3X4clzW/gdbUNOgMNjgl3TfXeunArxEGocYbkXT1v9QhmiWLL4zD8/g84BZ9maAeHNc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(33656002)(122000001)(38070700005)(38100700002)(86362001)(55016003)(9686003)(5660300002)(2906002)(66476007)(478600001)(52536014)(41300700001)(316002)(66556008)(966005)(76116006)(54906003)(64756008)(66446008)(6916009)(66946007)(71200400001)(6506007)(7416002)(7696005)(83380400001)(66574015)(4326008)(8676002)(8936002)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Cn77RklkpZ5YTFhd+TRapVLs0YdZBu1V/FKSvi6GnkSdjfHcLGP4CddBux?=
 =?iso-8859-2?Q?wjqw5mNjSwyAE9EpWCMmJDSASw6hKU+jd9UpG7qjinsAVD3hLNjulq6spT?=
 =?iso-8859-2?Q?anHQT8mG9EW8ASrxsCR3R/tihrmMpSyr/nsFaBCEM6cWkDJwA/G4MyVXDH?=
 =?iso-8859-2?Q?7yEJWsTivcxUWkPDcdpNQ8vbBoOE81zUMxseAxW8mCGVTd5Yu8ZR1vgiTo?=
 =?iso-8859-2?Q?i31Bt9kEbqZDqTlyBkzGxsa1fgLWnRQx6IZy7sZsNAZXw3waaWe1B04/P2?=
 =?iso-8859-2?Q?8im3WJKE6eEEUKsJv9bz1EiGcuobFli7nrmFWkfTSiAg4PTrGrApEVoXMv?=
 =?iso-8859-2?Q?bDSy7m55HgKnbxVE6vS3N66H2fBNV6c5kZXgzI/D2YkHr/ndpX8smM4Kty?=
 =?iso-8859-2?Q?I/mOWNpd1tWxQXQGvI0/Dv+peznrXr8k+D6DJUNVoAVRrL9R8WJaiOyg/B?=
 =?iso-8859-2?Q?oqOOBL6I55GB4y0dJycIbXKhfNVas6+FHwCFPP3nRbgwpQQ5rp95VvVD7V?=
 =?iso-8859-2?Q?OVAYweWS5VrXxLzplXia76mXtHjU4bOw3liSatU1yWgGOfjxyjb/ZQtMmu?=
 =?iso-8859-2?Q?KfMTC8n2bK66Mg9/yB/g8tO7ou03K6eb6AOiiyb302LAJIoJ3FYq0pXoPQ?=
 =?iso-8859-2?Q?0jRVpWL2LwRhvTiRxBsC8dHPk4SRC/0SqJ9NTO6C8Q0QC846Hw3NrGtrrs?=
 =?iso-8859-2?Q?7zlsvoEp0je+3qEx/gA4HhhuTIifkpfSD62i1vHkbX6SFPPHwc8EThGQbD?=
 =?iso-8859-2?Q?CYWqEbRcGEhY7jzGOH1frg4XkBgrlTTCazU11llQJYZ+FYyF4RuRYXlCMq?=
 =?iso-8859-2?Q?e4FCRXE4uIYnLUs0Tp+ZfzV6qqtb5OoPKLIs5hPLuM2SWD6t45QFK27pRS?=
 =?iso-8859-2?Q?naMINIOceY3H55bV6u9zX6hfg4z16NHwP3IRYx7Jy5xQIVrJsRpTKjISvL?=
 =?iso-8859-2?Q?HJwFvhU0P2OKd9i3q5KGzcRVo3V5LrlszBTKDShizgctEw5vBpeU5brA0u?=
 =?iso-8859-2?Q?HAH9tF9FSOThdLL4BBtYmDp0U1NvB25s/MClyedTRSev4aRbLyZ+c3aZtY?=
 =?iso-8859-2?Q?vez4wjoyapwbCaLRb8ljfjRS42ogyR7RSkwnFnObDqAEcM8tpt5Z++zTpw?=
 =?iso-8859-2?Q?Zf/Kc3bU++G0o1tAip9kVUIpo2SF4zwHnOlCtMVEmfRlpijX3BL1oNo4Ku?=
 =?iso-8859-2?Q?3T7uM46BNiSJ2Mf0lRm3b9y7qjYEMWD8veVbobJEoGAqKXuWxPbFAO+Uhx?=
 =?iso-8859-2?Q?T3pgcHqvSYFwzocuzzmA68kuJHi9TFY84I5XI5iVtOfQ+rBvS5ESOTNKm2?=
 =?iso-8859-2?Q?ub3zIW8m7sF+k+pG4IDPkJq3BUi9vyydDG57dEaAdWAMDz+g3nD+VF3Gfw?=
 =?iso-8859-2?Q?Hk+SaSVY3E3tlqUdLrcoN6maYkg3x8ZTef8F+P0ae8mILf+lkMFdQqID7B?=
 =?iso-8859-2?Q?0lAISqX21IN8Q+ofAOExOfTMxaAtcfAGs/5cnwDSysXyDve1FzTajafZBm?=
 =?iso-8859-2?Q?O0BAdZOuzET/vp2kA9OzrgiifF4GkWOujUs2YEDmnatB1Sd3rw6SqTaXxQ?=
 =?iso-8859-2?Q?kr6jVt2iz9hLmkLV+VijhBhlXTp84Zrkx43H+ZOo72QrrnMCFkNNleEQcF?=
 =?iso-8859-2?Q?DkZr9UGMbCvRTu7Y4MIdzhgZyFl7+2iHe8ewEwi4R+3++OiDYoEALoxIrl?=
 =?iso-8859-2?Q?azMnkjEd2/HBrV3NwXc7icInIUymNPZXvWxyMpKn5dYL34K9LYi8IdAUCX?=
 =?iso-8859-2?Q?4slw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4a02f2-4d75-4fe6-ab94-08dbbdb18d36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 10:24:07.8498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMItzFkAXKPwzKLAp+NMtFc9LAt/Mziun3nB2jG04/5lahZrDHS8B+42t3cI6GHvmCDdALYg29gvi9QClcjfynILvQns0dNgLb5s7RlgmuhHRs4puPZC1OPI5QavGOUv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Monday, September 25, 2023 7:08 PM
>=20
> On Mon, Sep 25, 2023 at 04:21:22PM +0900, Yoshihiro Shimoda wrote:
> > Renesas R-Car Gen4 PCIe controllers require vendor-specific
> > initialization before .init().
> >
> > To use dw->dbi and dw->num-lanes in the initialization code,
> > introduce .pre_init() into struct dw_pcie_ep_ops. While at it,
> > also introduce .deinit() to disable the controller by using
> > vendor-specific de-initialization.
> >
> > Note that the ep_init in the struct dw_pcie_ep_ops should be
> > renamed to init later.
> >
> > [kwilczynski: commit log]
> > Link:
> > https://lore.kernel.org/linux-pci/20230825093219.2685912-13-yoshihiro.s=
himoda.uh@renesas.com/
> >=20
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h    |  2 ++
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index a8bcbc57ef86..d34a5e87ad18 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -637,6 +637,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >  			      epc->mem->window.page_size);
> >
> >  	pci_epc_mem_exit(epc);
> > +
> > +	if (ep->ops->deinit)
> > +		ep->ops->deinit(ep);
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_exit);
> >
> > @@ -740,6 +743,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	ep->phys_base =3D res->start;
> >  	ep->addr_size =3D resource_size(res);
> >
> > +	if (ep->ops->pre_init)
> > +		ep->ops->pre_init(ep);
> > +
> >  	dw_pcie_version_detect(pci);
> >
> >  	dw_pcie_iatu_detect(pci);
> > @@ -794,7 +800,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  			       ep->page_size);
> >  	if (ret < 0) {
> >  		dev_err(dev, "Failed to initialize address space\n");
> > -		return ret;
> > +		goto err_ep_deinit;
> >  	}
> >
> >  	ep->msi_mem =3D pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > @@ -831,6 +837,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  err_exit_epc_mem:
> >  	pci_epc_mem_exit(epc);
> >
> > +err_ep_deinit:
> > +	if (ep->ops->deinit)
> > +		ep->ops->deinit(ep);
> > +
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index e10f7e18b13a..8c637392ab08 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -330,7 +330,9 @@ struct dw_pcie_rp {
> >  };
> >
> >  struct dw_pcie_ep_ops {
>=20
> > +	void	(*pre_init)(struct dw_pcie_ep *ep);
> >  	void	(*ep_init)(struct dw_pcie_ep *ep);
> > +	void	(*deinit)(struct dw_pcie_ep *ep);
>=20
> Please, note you promised to release sometime in future a cleanup
> patch which drops the "ep_" prefix from here and from the
> dw_pcie_host_ops structure.)
>=20
> https://lore.kernel.org/linux-pci/20230802104049.GB57374@thinkpad/

Since this patch series is not merged into the pci.git / next branch yet,
I should not include any cleanup patches, I think. In other words, this pat=
ch
series still seems under review now.

Best regards,
Yoshihiro Shimoda

>=20
> -Serge(y)
>=20
> >  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> >  			     enum pci_epc_irq_type type, u16 interrupt_num);
> >  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep)=
;
> > --
> > 2.25.1
> >
