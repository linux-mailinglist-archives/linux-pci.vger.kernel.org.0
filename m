Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770196C3CE0
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 22:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCUVjv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 17:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCUVjt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 17:39:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531E13504;
        Tue, 21 Mar 2023 14:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOZT/hhjMmB2nX/GEm4tDYXfqxuzx/tEBuYv01bx+8sfE2ePRoNGyLxg7vfgSc/LsbQt6/jpVW+Kkmi9Yb8rBhHVjoXpBEtT8ZrfcnChufmzfwcwvJJZRIug4CEluqhofj71olWCjo8gwzH5vFL7hiV9K5zn9z6OhmMY866/0AY1kS26OIc9E/8kYI7wJzfplPa1fP13+mZD7Ow9piJemG4+eM5E48ejMX/qzS3EDvdQAIJgwUs1Z4gMLtvshy6A7BS1rIW4/hGRXyW+jIUhtptEE7Dht/uIqoZssK/BVE4eRxb873bvya5kKN9VynQLtWpWbe9fzAom6AQVcTPkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYSs6jtwoemC3IlQIUlvpME9iFhyqtdxDQPVKjeqyAU=;
 b=kWHzxrJJQyetlCdeKAimauXALjmmmKxfgRfR0IWRj/twsg0sSJq8nb72hibt3o6C/GslfVY+KIas7RuETfv15vya4afeDAiu3TTXOki6Dy1hy1Q1tIdj6opzQkXU6y+afU7XDPvuLRnlA7WuVTSp300FalBcYvdmvwiH5rWTEXAPbROF7IYR9XBoujkxMOPlPeHVd0uCvpwtrxCc2H5k4CPsNhikrXldVitw8RgSwxyx03YiYvSj0+rN4MWlAps+TVyDmOUh6p8IFAuKwBwABlVY5DkctcmRkbzXXyk3WHdEh2MGrcdmDvvT/Ysdd+AzUaK7x6cPwbfvLldrFVkl5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYSs6jtwoemC3IlQIUlvpME9iFhyqtdxDQPVKjeqyAU=;
 b=phRyQvEj7kWZar/LHq9wMlKIjb7WBemjy987NL2Lt/MTju2GlMxAVfmhD9gaQTFgY8gTVrMn+weEqwnQC99swRzrXZgJ7F102rwkR88+3AK8s/l1C5pA1bZy6kyKvSwAjiF81c6lZOfkA8b7Zw06g725h+IHXpDjbtsnZJJgd3M=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8995.eurprd04.prod.outlook.com (2603:10a6:20b:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 21:39:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 21:39:44 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Leo Li <leoyang.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Roy Zang <roy.zang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 1/1] PCI: layerscape: Add power management
 support
Thread-Topic: [EXT] Re: [PATCH v2 1/1] PCI: layerscape: Add power management
 support
Thread-Index: AQHZXA6PSaLDkGRHdESmsagVtVM/668Ft9mAgAAHn1A=
Date:   Tue, 21 Mar 2023 21:39:44 +0000
Message-ID: <AM6PR04MB4838BC2054AA11A2C29189F788819@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230321160220.2785909-1-Frank.Li@nxp.com>
 <20230321205909.GA2409982@bhelgaas>
In-Reply-To: <20230321205909.GA2409982@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|AS8PR04MB8995:EE_
x-ms-office365-filtering-correlation-id: 8343c13a-1506-4d0c-c434-08db2a54c92d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ZLILHCABMdUt77OWimzBzQft2wAc20vs9fXrPdFGhxtS3aaNYHCWrTAaX2vhgzMg1kNXkUkWqgniuOnZ5CZ8EDcv5CEEc0nD0DA5na6az0mxYlXq/Pa7bPE/nGhByVTSPXaBtBx+MYYN4qpwYUtkENIx3tMnifPbXviou9/iHzDoRjApiYxfiRpDaojli8JfB+H7SobcVH3x0NocjuRel6OdHInSUCNc6yJPf32D7kxPW1e6ZPcAFoLq0m6T6vDqU20y7+LQM+YN5gP+9CK1nHo25FNkeTl4L+FN3nl4bdIESX6h/W4QYnwolbcPNKQ5LOYHtSbdU/5iuO/8r8WF9BliwJjrm5bdI3z8rENjiXAtrxByqp+RMv8Xjiu31Uc149jIpQJ368RLVrtxCzAvJBwJmcJIzKNjsWAXcAkMiYPiwtcgRQNsHWRhkjaD+tO0FuRusF9PzlNX8a3nSnGaXlqcH8LKAxqEa7FyaEQvO2FXczW4Mg2UsBd7GLJBtdU6dlFOC5Mn0toRf2ooYEx9MA1T62hSRudjlEhb/i+1C+vgLhhlv+RQ9Ecpk4zdY5Z7J4WxJsie3sV98r0Z6FDVnMxGqzbCjUkJKt1gumTze4ShSEr+uDyRTBIWbeJ1rGxQpCpUFWfjp5bFC60eFr7ahchOU7F2SpGZs3uSh6DGrI7EsMbc7d8TfUlEPkwi919zLTBB9OY7a+C30JsvMWGEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199018)(9686003)(54906003)(26005)(6506007)(83380400001)(4326008)(6916009)(64756008)(66476007)(66946007)(66446008)(316002)(53546011)(186003)(76116006)(478600001)(55236004)(8676002)(66556008)(44832011)(5660300002)(7416002)(41300700001)(122000001)(2906002)(8936002)(52536014)(71200400001)(7696005)(38070700005)(38100700002)(86362001)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+E4M+jzqc0UZboVZfSxxxygTs8IsK0vjjZsN46T7tQAmuedJ4mIOoBO6br8p?=
 =?us-ascii?Q?UZ8J6MhRR47wrhKX/OFIt0u3LmP2J4euGUyn3YQ7CtcdzV8XTW987PKqy4dt?=
 =?us-ascii?Q?qdg58C2Fe0S8hSrXPUglqwdFot+rcdZUn2fWGTB5ilVxKn7yUAnF0r3GJEKN?=
 =?us-ascii?Q?ymHuofsJJZjUs2TVVnaydtyhubTFSy+SydHaWS7C3m1nv5+scpDQTm2kD0dN?=
 =?us-ascii?Q?PVVucGYWZIpY3w9SrZEzoH5ljSOjbWvP5IK4sqQJ8ILb2AWhkdSkLHLCyahd?=
 =?us-ascii?Q?abgilreaBSAXgO9yvDE5XR8ORc2A7oFiaJIVLYPLhIlp102Zl/8D4kcckNaW?=
 =?us-ascii?Q?IzSX8+B3OAae27TdBIQY1uWqltT3A9gIFNRDseELHZPwmBda4F+btagzQU2Z?=
 =?us-ascii?Q?kpMz+q90w2PH85xXNNJPVP6dEqBN6/N3AI5ky+dzjIHs55dtEIIdqOH97hfX?=
 =?us-ascii?Q?hDl7CYne+Rxd+hb/PLd56ofuWpH3EbMtqs/SW+ANslI5rV+F+BVW7b6zqpbb?=
 =?us-ascii?Q?0tN+BzyY3nOdJZSFR/6BY+15PfTMpTh6rjH+v9XwIzb3OAVVSahX7n4pCoE3?=
 =?us-ascii?Q?ewbAFXi4+Wf7u8xIg03UqjKRP80Td1+0sxXLNarfGfmf7NiDYiqSItHlaNEN?=
 =?us-ascii?Q?OD7w7MMTCr3GaHxuYC9lZFcbL7nN7uwMx8JuL/zg2YoRwjUDHm5QtJx4JILx?=
 =?us-ascii?Q?HEg1krz9X95fy0/ZuOKAAiaNfgKW0OUGfew8A1kxRmCU/PcIYqopH4Vz2gHo?=
 =?us-ascii?Q?nPh9xYpt5YZkP5TzAWs/M+8PgX596zoOmky4E+Rp1RNj838DwZhd6MwOaf32?=
 =?us-ascii?Q?1IeoZoQj9CcdYZpsv2schZIRnc2TemMfDOJo0kJwvwZEM1lnhTTjEu1bHVYx?=
 =?us-ascii?Q?RBzHN0XmXl2Y+NVLUDfOGWRnMyx2nYhcOBrOFY79cXEEAZBgjKc8s5mYw7fc?=
 =?us-ascii?Q?7tG6MsFwXpt3Y/pe6zECZupFPPYsr+oD1qYuSk/SbwZcH9GDKhAoTd2A6mqr?=
 =?us-ascii?Q?+N6XeyDbskmiICIpqfC7rfN+kl8SarRKA4n1QQbyxafew8/snXzeI5bMsDQr?=
 =?us-ascii?Q?aSWqAFu+XHzr91csxh4IWctjsfWfg/0Z0+9rO+lEf+tcsfsAVh0mz5uMLal2?=
 =?us-ascii?Q?CWzoNO1Elct97mLQyp8LGMczzUQOWHuPgoSarDRNhAvp3u5wBkqI+3cmDUUR?=
 =?us-ascii?Q?8JiXSVAfixWka3Wv0P/QLZ1/Te+pb8PURJWMECpwrWIw3qWcMNPDDnbeaNRY?=
 =?us-ascii?Q?OsHeojsEE5N+zN4Q2TTzoVpBhTT2NQVWyTI5rtc9MG/v3sWZ6IJNpDOVa0KE?=
 =?us-ascii?Q?aNUCeXzPScIUWNmD+exlCTy2zBN5oL2BvxYJ9U9BiXQ91gaoKv0HOnf8g3j/?=
 =?us-ascii?Q?x26TfX4wp42MBGiwmrY2BwQJ8+a0xAg4kZNlihLN8OEL1kxxyJcJDfi0B+gy?=
 =?us-ascii?Q?fkHGZTOQsO9BGEcJzc0NojmXf8MgwSSnj8Iab4HXA3cOz0uCvA38MpUAQhPw?=
 =?us-ascii?Q?yOTuFz+ZpaXWXkPeCOD52mZuSbUuZVkGqscvX5PKGmYBFUoWgYx5Xet3XJCo?=
 =?us-ascii?Q?9YZfN4GeoqMmhDn95uKcLCcF+mI6tqSTxM1KLtBT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8343c13a-1506-4d0c-c434-08db2a54c92d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 21:39:44.3427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0Z6ucB089cccqLMFJXbc7qeefhe6N9yI5ZJZ1uU1/aAdhKv2p/D1pENvubMnZmAJgWfqaFvgljDbXDaeWMLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8995
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, March 21, 2023 3:59 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: bhelgaas@google.com; Leo Li <leoyang.li@nxp.com>; dl-linux-imx <linux=
-
> imx@nxp.com>; devicetree@vger.kernel.org;
> gustavo.pimentel@synopsys.com; kw@linux.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; lorenzo.pieralisi@arm.com; M.H. Lian
> <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>;
> robh+dt@kernel.org; Roy Zang <roy.zang@nxp.com>;
> shawnguo@kernel.org; Z.Q. Hou <zhiqiang.hou@nxp.com>
> Subject: [EXT] Re: [PATCH v2 1/1] PCI: layerscape: Add power management
> support
>=20
> Caution: EXT Email
>=20
> On Tue, Mar 21, 2023 at 12:02:20PM -0400, Frank Li wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add PME_Turn_Off/PME_TO_Ack handshake sequence to PCIe devices,
> such as
> > NVME or wifi module, and finally put the PCIe controller into D3 state
> > after the L2/L3 ready state transition process completion.
> >
> > However, it's important to note that not all devices may be able to
> > tolerate the PME_Turn_Off command. In general, fixed PCIe devices
> > connected to Layerscape, such as NXP wifi devices, are able to handle
> > this command.
>=20
> I know this paragraph is here because I asked whether all PCIe devices
> could tolerate PME_Turn_Off.  I don't know much about that level of
> the protocol, but it does look to me like PME_Turn_Off is required,
> e.g., PCIe r6.0, sec 5.3.3.2.1, 5.3.3.4.
>=20
> So I'm not sure this paragraph adds anything useful.  If the spec
> requires it, this paragraph is like saying "it's important to note
> that some PCIe devices may not follow the spec," which is pointless.
>=20
> This functionality results in any downstream devices being put in
> D3cold, right?  I think that *would* be worth mentioning.  There are a
> few cases where we try to avoid putting devices in D3cold, e.g.,
> no_d3cold, and I suspect this functionality would put them in D3cold
> regardless of no_d3cold.  Those are corner cases that you would
> probably never see on your platform, so a brief mention here is
> probably enough.
>=20
> > +static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
> > +{
> > +     struct dw_pcie *pci =3D pcie->pci;
> > +     u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> > +     u32 val;
> > +
> > +     val =3D dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> > +     val &=3D ~PCI_PM_CTRL_STATE_MASK;
> > +     val |=3D dstate;
> > +     dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
>=20
> Is this a power management register for the *Root Port*, i.e., as
> defined by PCIe r6.0 sec 7.5.2?
>=20
> Or is it a similar register for the *Root Complex* as a whole that is
> defined by a Layerscape or DesignWare spec and coincidentally uses the
> same Capability ID and control register layout as the PCIe one?

I think it is root port. Does linux framework can do that for it automatica=
lly?=20
Or need call pci_set_power_state here instead of write register directly?

>=20
> The Root Port programming model is defined by the PCIe spec.  Things
> like .send_turn_off_message() and .exit_from_l2() are clearly part of
> the Root *Complex* programming model that is device-specific and not
> defined by the PCIe spec.
>=20
> I'm asking about ls_pcie_set_dstate() because it's written using the
> PCIe constants (PCI_CAP_ID_PM, PCI_PM_CTRL, etc) but it's mixed in
> with these Root Complex things that are *not* part of the PCIe spec.
 >=20
> > +static bool ls_pcie_pm_supported(struct ls_pcie *pcie)
> > +{
> > +     if (!dw_pcie_link_up(pcie->pci)) {
> > +             dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
> > +             return false;
> > +     }
> > +
> > +     return pcie->pm_support;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int ls_pcie_suspend_noirq(struct device *dev)
> > +{
> > +     struct ls_pcie *pcie =3D dev_get_drvdata(dev);
> > +     struct dw_pcie *pci =3D pcie->pci;
> > +     u32 val;
> > +     int ret;
> > +
> > +     if (!ls_pcie_pm_supported(pcie))
> > +             return 0;
> > +
> > +     pcie->drvdata->pm_ops->send_turn_off_message(pcie);
> > +
> > +     /* 10ms timeout to check L2 ready */
> > +     ret =3D readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
> > +                              val, LS_PCIE_IS_L2(val), 100, 10000);
> > +     if (ret) {
> > +             dev_err(dev, "PCIe link enter L2 timeout! ltssm =3D 0x%x\=
n", val);
> > +             return ret;
> > +     }
> > +
> > +     ls_pcie_set_dstate(pcie, 0x3);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ls_pcie_resume_noirq(struct device *dev)
> > +{
> > +     struct ls_pcie *pcie =3D dev_get_drvdata(dev);
> > +     struct dw_pcie *pci =3D pcie->pci;
> > +     int ret;
> > +
> > +     if (!ls_pcie_pm_supported(pcie))
> > +             return 0;
>=20
> How does this work?  You're checking whether the link is up *here*,
> and if it's already up, you go on below to (I guess) set the PCIe
> controller to D0, call dw_pcie_setup_rc() and dw_pcie_wait_for_link().
> Most drivers call dw_pcie_setup_rc() *before* starting the link.
>=20
> It looks like when you call ls_pcie_pm_supported() here,
> dw_pcie_link_up() should always return false because the link isn't up
> so it looks like there's no downstream device.  But I must be missing
> something because if that were the case you would never wake anything
> up below.
>=20
> > +     ls_pcie_set_dstate(pcie, 0x0);
> > +
> > +     pcie->drvdata->pm_ops->exit_from_l2(pcie);
> > +
> > +     ret =3D ls_pcie_host_init(&pci->pp);
> > +     if (ret) {
> > +             dev_err(dev, "PCIe host init failed! ret =3D 0x%x\n", ret=
);
> > +             return ret;
> > +     }
> > +
> > +     dw_pcie_setup_rc(&pci->pp);
> > +
> > +     ret =3D dw_pcie_wait_for_link(pci);
> > +     if (ret) {
> > +             dev_err(dev, "Wait link up timeout! ret =3D 0x%x\n", ret)=
;
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
