Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADB96BF728
	for <lists+linux-pci@lfdr.de>; Sat, 18 Mar 2023 02:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCRBPZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Mar 2023 21:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCRBPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Mar 2023 21:15:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400F326877;
        Fri, 17 Mar 2023 18:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fn0YCf0DTyaR+t0WDzGpgLTwxU+h0FGw+fLshb6P0Iq1HyHALE5WyqVRpQcHOfrrvTKuH3b+3x5oVi5QTdop0/4/SOiJQ1OywRDD/3smbT+MGG4QXCptlJoU9IJIX9hrueyw2s0cmQxSIj2UwMi9uJspZcTqSREGMPRXcJMvHbTMkZN+Q/2KLgpxgjQx91yPoKm7Mnd15i46quCsr24Jb5H8lI/wmiuBoi5VKSYN8O/aZ97kKUabpryOKSMidRCD3OMTtfhoI7M8v9CBsPvx8otHeapM6QkD0k/rkSn6lsJAUhFxFJIcR/KKGGTzRDwQVFEc7mg6InU/ptCFbjbOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7OECjqMlAunvWrejHze0okvppZMDxYzCxLEtOOKVNo=;
 b=QyErwWDzE9Huez7Ab5NtG/PS239K5JiYFjpVO8qgS9K6m654vMOAvRqh79tKP6/ioaD9t/t59Q38GlKsDHdSMEpsTsPQJQlXYqndkGH8F3CezAC9sp/iB5YTCFTc4GRj6OSk6CMlpmVBtvQcUJdxJerpV7kzEtM+geL02BbV7pmOqkTsYfyZjfug7vzzAel8VMOZL/I+syP+TIIhxhxhPAKQf0dfbFp7Vpj6dn3xCjhEnntGsOXujrb8BMcuSQuE0xHhl86nYc5PozDCPR2Gj5jeafdLLSucx9RLtOTspg2xlbd5yJOkNVP3bAHMbG/EJ5qy4cRLdkrbEAGACh0whQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7OECjqMlAunvWrejHze0okvppZMDxYzCxLEtOOKVNo=;
 b=G87g0BdwJJJCd3aqda7LZq1vXNTh6XA2C1A0n9/YgXuzRll/m+AHWADGbdyRq6CxrrL6F0SFlyeGqh094BlS+sOPlyJOV1+GZR+twFgNBAkov6JWNbcxtghsQ0uHRmwfStR9kt/8+e78c39O3bpovFrxEgNEXrZLgNk5+gD18lw=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VE1PR04MB7344.eurprd04.prod.outlook.com (2603:10a6:800:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 01:15:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Sat, 18 Mar 2023
 01:15:18 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Roy Zang <roy.zang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] PCI: layerscape: Add power management
 support
Thread-Topic: [EXT] Re: [PATCH 1/1] PCI: layerscape: Add power management
 support
Thread-Index: AQHZWQvcKZpyqx0+SEScdfAvHOGtp67/hKkAgAA1GBA=
Date:   Sat, 18 Mar 2023 01:15:18 +0000
Message-ID: <AM6PR04MB4838980A1243C5ECDDDF454F88829@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230317200528.2481154-1-Frank.Li@nxp.com>
 <20230317215650.GA1973940@bhelgaas>
In-Reply-To: <20230317215650.GA1973940@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|VE1PR04MB7344:EE_
x-ms-office365-filtering-correlation-id: 12490ae3-6243-48f3-ce6c-08db274e3cb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RA9tgpKe/G+aDqrKATzVrTwyuw9V6r9c8LAdxhfAs7Rjp13iGXHy2x5yYypT3wCiVy8W/MA7csWSIknCe2rhmrOZpVhDOkQUtLEh6FEc/dD1xbfVXR1Rtpo99d2fwdpK++V3aLuBe7Kf+7uRJbm+9OI57yub7Av5Fq0B8sto3tUeYrjZ+nBrpNG/yZQWWDjslnxs61v8IfYkZG1VghhA3ZftjgRPf6ahFAogOduHpcEMfJZkQKJiU3uoE+/Msyaaj+yADF+vZwpKYYpV8AZI4jX1qH/6s5k3/rHf4nEFDkNryeiun+mX4JFaglYwcLORx7nLpK5q21AfKl56rwcbgJ1Va69Fc7K1W0FwErhfR+e4zniUmilvOfXurZ5U5IYSQamiTk2x+Nqx5wdSzsT8ZLO9o3NiOYx/bEPMQ9pFidITM8/bZWAICPIjKRHk8H2oJ+j94WAI+ppYKLCH8XEYOXsUqcxIVzLFhnz7FmmqaT779Xkj3n/BThYXcMkv3nFfaL9tzMvV+zk0NJ/b76IeIQEunGdBTLqIP4W7w5LOIJ/4Dr9bZvZkwkV1nuTBDrIj+jUbTPc9m6q9lwrE4iQGT9muYJ7KXJziHbf5bX7ED12XMK1WFbAywd52ui11Ytj6J2L/VoUvXDJMXxRVsBfHIa+81Oy93T3T62P0pWGCBWaammfkERWXOrY0Gvv6i3WliuHFQWqMRf6D81qPPRQRMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199018)(186003)(9686003)(6506007)(26005)(316002)(71200400001)(55236004)(54906003)(4326008)(66476007)(8676002)(66946007)(66556008)(66446008)(64756008)(76116006)(478600001)(83380400001)(44832011)(52536014)(122000001)(41300700001)(7416002)(8936002)(2906002)(5660300002)(6916009)(38070700005)(7696005)(38100700002)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+YtQsMeZd9ssbG2HfGT3++pLOX+ZQduTXwxYj6/PRaJW9O+UfLurkrxGq2Tr?=
 =?us-ascii?Q?85e0jeY4l2s0PYUll8vqITtosILHAW5Ka18MmewF2a6ohXoNQBVlm5ygz3Ku?=
 =?us-ascii?Q?rqq06GbtUSL9a0sJjknJGfHji65mrDN7mAG9t5ujwDr9Qpyo5Mx1Wi+FnChn?=
 =?us-ascii?Q?u5x+vPwIRz45SOtLF4pgP9cKhDVEWWY3DmNy3o/q7O6sLZ3D5nCoQePh63gY?=
 =?us-ascii?Q?U8DWpa60zM4zCdMFcD5nQvoZ86G2CSu2ElrsEIGa0NQmO8HGuEZDJh7omOFG?=
 =?us-ascii?Q?Ya/UmoWFdj5NL1qowjnf+Rke4qiil1qbeeXsK2Dl7Jgfqm73MKjCgmZ7cLxr?=
 =?us-ascii?Q?h7wedTJO/sVcMC0x6HGWNu972mvQGx7LdGUju40Lt2JuQyqxDhK4UDrl9JrN?=
 =?us-ascii?Q?OvYvsBxGlqSkUycVM+xQGeJq4Nvthx04VBf9lMYsqsluY1lK2cPGRJ4b2IHp?=
 =?us-ascii?Q?hvrDqsvEVLLsY1Ub4KjjvNfu+7elMUChOOppKsBNz9nthPoSGWGmkzMd1rwi?=
 =?us-ascii?Q?VYeYZKJmzGl+IECWAWkI1pkopt4pMAe9yHj4Rp8UDbLWTp2FAecsus4D4FjX?=
 =?us-ascii?Q?08bxo/q5It8qi5RvLYtyrfJ9jch69vmiZAuE7lmGkEK064UXQ37Of0X1hKE8?=
 =?us-ascii?Q?7rPACr49Oqe26L/4zyZ4bLRbtJWzmAzF77NtA0o+xqs16uAlK/N5MBAltCrQ?=
 =?us-ascii?Q?/QbqcXMkM8LUH+0zRiK1qaK+00u/og+ewOTnmfC4MrK+Pe7YEh7U9A3TPEEO?=
 =?us-ascii?Q?ldWrQxxdAVuaGs4hVMzxTaPZN/sHF/U6/1rdjktJdEKXEfzm3mSKus/TcmSy?=
 =?us-ascii?Q?yGRFT+G1+yWsAHwiztRuc3E+ZPJlL542fP5xX4g+WGnU0EQDpskJEUl4jYQc?=
 =?us-ascii?Q?4CSnaUlq+gSzsOFv85zfDVCx2ck2GaWXt5+NHxIR8q10K/KZjanDZZyIM+jw?=
 =?us-ascii?Q?szjF9FoahoxE/DgiHma/6e5usZGnFGCZeNKWcdOSqQ3WQyUTCVh7LtWkm4Az?=
 =?us-ascii?Q?wYWjzhdY5GO0ycTxr02UbQzD7zQpZ+8wW7qDPZxs/wvElF3pG8SrtiTLkqm4?=
 =?us-ascii?Q?GDVN2aKThl1mK+z8/AQQAOXpBg7pGOaUVZ4KkR3H/LFmAPW315uOEVoBgvtY?=
 =?us-ascii?Q?ymvtTdizP4XF9iGl78vEK0PWyhNvCQkDM9CnjhWmsL4n1rhoHhYwqdcnnz/W?=
 =?us-ascii?Q?oqjzExHBL/fGbKOJXV4vxp8ADQN7RBXiJTP9/5n5FRPBFB+C9x/hOiRLo4Ca?=
 =?us-ascii?Q?IV+EncqndtRXOFLapUZhuG3g5LOkwdh5BkojnwCMMVW+eWosXHNO13gHWPOb?=
 =?us-ascii?Q?yMQz3jvcVRFbWGL7/f1BrUOtk7UI4yL1t1BeJylkB4qnkz6ENvkX0MTeoEaK?=
 =?us-ascii?Q?gcbmLkiVa16TUTg0lncVaADy61M2x8ZIicUSQwxBxzXRzrkUMJ5KjJ4d6MKr?=
 =?us-ascii?Q?7w+qywjj0Y/x72kdXVnaB+Lo8ogTuMgSsnoZ9cjyhkOzGT9qcC/8KosZsXXQ?=
 =?us-ascii?Q?w+wmbYAwvbm/QAZXpgjYM/ezlg1uAHzepuYBPuX7N6/ffzL/dzHZuvnTdGzV?=
 =?us-ascii?Q?s48xxqUvq3fqNUV3qIY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12490ae3-6243-48f3-ce6c-08db274e3cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2023 01:15:18.2053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrdfT2z8G8tAJz3MVMqZXWoO1uFESGtc3N12I2eSZS/1NaGreG0RzD49PKXi/SmeFfI9wC6o3/SwKrQmNjai5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> Caution: EXT Email
>=20
> On Fri, Mar 17, 2023 at 04:05:28PM -0400, Frank Li wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add PME_Turn_Off/PME_TO_Ack handshake sequence, and finally
> > put the PCIe controller into D3 state after the L2/L3 ready
> > state transition process completion.
>=20
> Can you please include a sentence or two about what this means for
> devices below the PCIe controller?  Is this guaranteed to be safe for
> them, i.e., can all PCIe devices tolerate PME_Turn_Off, etc., and
> resume correctly afterwards?

We can't guarantee all PCIe devices tolerate PME_Turn_off etc. We just
follow PCI Spec and test some available devices to make sure our implement
 is correct.

Anyways, it was still better than nothing. =20

>=20
> I suspect other drivers will copy this sort of pattern if it is safe
> and useful.
>=20
> >  struct ls_pcie {
> >       struct dw_pcie *pci;
> > +     const struct ls_pcie_drvdata *drvdata;
> > +     void __iomem *pf_base;
> > +     void __iomem *lut_base;
> > +     bool big_endian;
> > +     bool ep_presence;
>=20
> This means "any downstream device present", right?  Could be an
> Endpoint or could be a Switch Upstream Port?  I guess it's basically a
> cache of dw_pcie_link_up() at ls_pcie_host_init()-time.

Should be an Endpoint.  Most of our user case is that connect pcie
wifi module.  =20

>=20
> > +     bool pm_support;
> > +     struct regmap *scfg;
> > +     int index;
> >  };
>=20
> > +static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
> > +{
> > +     u32 val;
> > +
> > +     if (!pcie->scfg) {
> > +             dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
> > +             return;
> > +     }
> > +
> > +     /* Send Turn_off message */
> > +     regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> > +     val |=3D PMXMTTURNOFF;
> > +     regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> > +
> > +     /*
> > +      * Components with an upstream port must respond to
> > +      * PME_Turn_Off with PME_TO_Ack but we can't check.
> > +      *
> > +      * The standard recommends a 1-10ms timeout after which to
> > +      * proceed anyway as if acks were received.
>=20
> Spec citation please.
>=20
> > +      */
> > +     mdelay(10);
> > +
> > +     /* Clear Turn_off message */
> > +     regmap_read(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), &val);
> > +     val &=3D ~PMXMTTURNOFF;
> > +     regmap_write(pcie->scfg, SCFG_PEXPMWRCR(pcie->index), val);
> > +}
>=20
> > +static bool ls_pcie_pm_check(struct ls_pcie *pcie)
>=20
> This is used as a boolean ("if (!ls_pcie_pm_check())") so it needs a
> better name.  "Check" doesn't give any hint about what a true or false
> return value means.  Something like "pm_supported" *would* give a
> hint because "if (!ls_pcie_pm_supported())" is a sensible question to
> ask.
>=20
> > +{
> > +     if (!pcie->ep_presence) {
> > +             dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
> > +             return false;
> > +     }
> > +
> > +     if (!pcie->pm_support)
> > +             return false;
>=20
> Why test the negative ("!pcie->pm_support") and then return false?
> How about:
>=20
>   if (pcie->pm_support)
>     return true;
>=20
>   return false;
>=20
> or even better, just:
>=20
>   return pcie->pm_support;
>=20
> > +     return true;
> > +}
