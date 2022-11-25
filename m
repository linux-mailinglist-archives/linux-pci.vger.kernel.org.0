Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295F76388E3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 12:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiKYLhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Nov 2022 06:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiKYLhQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Nov 2022 06:37:16 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17671CB00;
        Fri, 25 Nov 2022 03:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlAFYN85qFCam6qmcTgZuf1w5uxvg+J+Lviee+ZJQT6oXAYdSq7Gx1vjMrgOo0AfDTH83ny63QP4diqzmEDq4Kg5Nnu6Myqob2J6mEeQUk2E8CvnYQ2XGX0OKHFkAxR8Uyt8maBnbsmqc3jG8KJkmMWniM5dI+yqtiu1AKVlVk9aRyyhrP8WPUG7Eq6080aC7OGAb+PUib1lM3WmMdG3Fi4KNLM3sndK9d+aacTIeqLERViTBxQbV1mE5Mbsm+VkRcz4QM9vJ1zT89UAeb0RiY8gpewoN7yS2YN8MX4PqvZPI5p3Kk+lbIYksSWnwUBh9LwRzuagZLZcl+Yjp8kO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBYzRYh57yTYhUYWFWuCbFXVk4EgVky22JaJJYUG1yI=;
 b=DJKlgkS4+LrbG7Af+YnWVL0sVMM4blcppnrjbBcqBIs9MLm0MQjzxaqhqhFIEVObEpgMg9Ppmel036gfhGcpSGatSmyo4MaIpCPOxkqGCIhaH5YXkpBXUBE3Ix+77saExxfg0YNj1RuNASm25TWTEjFo/ehwPekLernVYSL6vpzaGXTk5wEhdyjO91C0g+nOG8984KwkKzYJ/G/zvVN9CKkLOB4i/zG+jzZxacdZAwMs5+xQiU8T/OXset8YIZMY312vZ7OIOhH2QV+j0hfO5Q7Z9m9jxSm4NhfLYtzJ+eVNl+FryexxpifuUGgVf/yKGQRyPsDHLAq2VRUlRhYWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBYzRYh57yTYhUYWFWuCbFXVk4EgVky22JaJJYUG1yI=;
 b=YxyB+aKVmy0IC+SD11aUvonfRbAsshrwfVL4tthha+CFXHm5rDz1lrfKFtlDY6cLLkMivCyvEl0+eV5JH5u6NM4StCvmSE3mRkk4v5xYGeGQMb9UtgkEfv1Pv5tGcpuC3ui9+cv4CyTSzae9BcOPvEoyJnxM5IKdCRe0fS//y3E=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10131.jpnprd01.prod.outlook.com
 (2603:1096:400:1e7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 11:37:11 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%9]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 11:37:11 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v7 7/9] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Thread-Topic: [PATCH v7 7/9] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Thread-Index: AQHY/ab0XQajxeTlhkalSKpu56XvEK5LDCuAgAR7JwA=
Date:   Fri, 25 Nov 2022 11:37:11 +0000
Message-ID: <TYBPR01MB5341DCB65D17695A48F0884FD80E9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20221121124400.1282768-8-yoshihiro.shimoda.uh@renesas.com>
 <20221122150437.GA187129@bhelgaas>
In-Reply-To: <20221122150437.GA187129@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10131:EE_
x-ms-office365-filtering-correlation-id: 4ccb588e-ced3-4266-68f1-08daced96498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhoWuGT9qKsABjT4EU31ib1JaftszpMNgGF2fsI1YEgUeT8yQfslZRmvLtC1XYXcc+besSlN9Ir+MuvC5o+WAPlW6FYGiL073ayE80JwfO5RaPt3OR1hRmmiMn/fLXxNVOdKBO3Gw+y21Q/yfKTK9S+87d2neLeNcpf4uMDB1yfLZjq+BmEJsD3+Xdz11933d7FB4j60uI08Y+eswiQlUtKef7wGF7/W5NcaD6MXD0hFrVsgrSMhtF4AYZm9mZzMQT12TMsDPsLH2miWuPuALAR1vrrrhM51xNT+fiwYEZBm/PVwKZF/Uh7MVTwiWYcqBHw2zbSOB/N5MmFUxQveQ6dmOZC7PJtWFYv/QfVs399Q/ytHvMkg9PFcbrbBKcV7qPjphb1W8XSEb4Q29ZFQ7Rhyxf5z5DZMzt6VfeZ9sRtjQIluW+xdrUBSEQkMIHVPU4VQsbY7yL6XcinLZXJz+P8hB+OQ0o/4mxAS/7t9YNwipTwPYnqOd3NWkuA4XSlKbi1nk01bxrevNjHZhkfHL3KNlSHXkCm0WRr7fHXSVke4tw49DIN5nSmtrdaApf165QMcZM6YCyZnC2q7Xm8O37/WqOk0GZ0UOaaUaW0NfNqLzoGrCawaxHWT+Bha1M3UhoZm2GP7CkG2+6dmtlh3+129EGDsUaeyK6ovYZeU+AtS6PcT5uYa2wLA7s5HB1qF/d4HsKh9f9rhAxX4aMZdLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(186003)(83380400001)(38070700005)(54906003)(52536014)(7696005)(6916009)(2906002)(478600001)(6506007)(38100700002)(9686003)(316002)(5660300002)(8936002)(86362001)(33656002)(66446008)(55016003)(66946007)(66556008)(4326008)(64756008)(66476007)(76116006)(41300700001)(8676002)(71200400001)(122000001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?al+3+Pk8NIsedX0epOdGio5tOMtAq+/6Y4aaSsIxp6ptiJyblTWPG6aUdbeo?=
 =?us-ascii?Q?r7BOBto83pHNUMILJXEKqOJDUb29boKUbGotohrk5yvdP/c9UqlBNT396eEi?=
 =?us-ascii?Q?mg6v5b3T0fl6WygWfkKXR4/TfoiQKqRaoI/3qcXYnx5b2GCEwVpcalNUpX8U?=
 =?us-ascii?Q?cD1kf5dSNbFyBIS3JTxXMFy+jntvgoOtFInpGPo3oN/9+sK1sGkOmQGUMevR?=
 =?us-ascii?Q?Aa7SXtGUGldJe3sjEY+o9eF0R2LvBPNDNRsyoYcqGBECsvuvdD2XyRW6vbDD?=
 =?us-ascii?Q?5NnLN3HPN3TiRBdGbkNmekFhzha9kCTV7jd20IAcjKoN9phc+bIt0siPNPG4?=
 =?us-ascii?Q?oiq2PcofeCrq4Sxh1hDm+0CXknDk4OY285Rk+rozcxGhPQhMwsiL35GYf40D?=
 =?us-ascii?Q?TR7dklYv4oaguGvhtXzI2dB6dZPg+54gvgvwRXhvJFkMEC44nuE4Z8nmjG3a?=
 =?us-ascii?Q?xXBcSz/tmolFAp8sFv/5yLqPtdzPy15evYF1MbiXfL8+O9pb6C0lQUdrxdxg?=
 =?us-ascii?Q?zv9iDclkY0meJoBSUdaZ2d3bllvsSxDo8x05q/xJnHFfTbHdDjbm7ttVK+rx?=
 =?us-ascii?Q?EzcJ8eH4cbqCu60TpoKooJqE/SOVPB4gEsx7VLzIzcEsnxKHJ3xhJCHPiBa3?=
 =?us-ascii?Q?np6vhCa8VoY61d4pDBoNJBOmI8ug0ehlva361gLMCo2BPIw7m3vCLBTlBgal?=
 =?us-ascii?Q?PMps9xC6bFr/x+njhrVoarJhElFFZP05fj0Ba2LZk4U6U/SFdFBCE0oT++JA?=
 =?us-ascii?Q?b7CJO1hgTny7YEAoBtvZWsV+H4iVBpN7mqiLkLEk0h+Jt3btC5NvPNeTsq21?=
 =?us-ascii?Q?kXGmMztXixGufoOcA6k6dXtycEcwehidMSUVYywmMKGpnIsWI9lNR3ux1X6s?=
 =?us-ascii?Q?b0yYfWSiGgCH/Zime3BHxy8etqao6yCJ+iPDfXfbmzgiM3elh9dZREhGaT15?=
 =?us-ascii?Q?phrVQuMTm5JoEjq6H5hTQJXJ7J6/ujL+3Gb20Xh3hCYZ6ONRJq4j+LzcCQBN?=
 =?us-ascii?Q?u5NUJbdpXO0/jT9jkxG+nnW793y7Imz71LqveLhDADv1iy9nAQef/L70q9po?=
 =?us-ascii?Q?CV7QQV7+dmQL2qmFyuOqU88lH5Z2Esiv/qdQ2x45QSZM1b42oztVGApNs8f4?=
 =?us-ascii?Q?gc82XmHC+hJ2xgRR6xgD5B3UPsN6ND7bc5FnZRqWI3pphV4pfTzKBGdev1KZ?=
 =?us-ascii?Q?s7DGBygYePdKuRKF9lluCFvoYTsUCWGplHLPXScNjHPMKwXMIT0LoE1aDg7U?=
 =?us-ascii?Q?2iNdqSbmUhkOUYbDS40X8lMiHl+40WFRC7/ElPunBJZqjy8wyV8PzWGED1Kd?=
 =?us-ascii?Q?5H1NmyqbKVbv7jRy8bgwuEQeRIfEVkBYaiJY1ETeLuZfI726PUPT2V0GU5F/?=
 =?us-ascii?Q?p5JuE6emk7VSDxg3Ot4ByWMJMs7xUWiaFDdDhL7VfXMXp7WVikkLWTf5ukZH?=
 =?us-ascii?Q?5/0SChkFg8u2ckExZtkcSFlJnJ6jnizbv37bFsS39C6yRers93EkQNGG6au/?=
 =?us-ascii?Q?4YGi1RVfmyqMieurzlEVBsY91ASG8/JAnTeM+HkH9kl8yubUy5hKBL8JPdPa?=
 =?us-ascii?Q?Xll5eygkco6yKz7Lubuyh8zWAwBBNBTDsLnbqGEIR7gpjiPXgkvmJnMk5zvo?=
 =?us-ascii?Q?GG/CkPjYbkUEErlfGeNEgJ8S/GuFgTX/prXlTaB/HmwnfANhEnu+NStQXqzx?=
 =?us-ascii?Q?707dIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccb588e-ced3-4266-68f1-08daced96498
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 11:37:11.6655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7EiZrlTCjwpFf7Vf3P9s9fnca7Hut8dFm8wA8+VK1pei1FsI7xJZ1l6Cbnd6ATHEXiJljsP1I8DVkRhjD45L5PSbamd2uHbVn5bvtGCoGjCJafBWiOqrvvonCTuM1M7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> From: Bjorn Helgaas, Sent: Wednesday, November 23, 2022 12:05 AM
>=20
> On Mon, Nov 21, 2022 at 09:43:58PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car Gen4 PCIe Host support. This controller is based on
> > Synopsys DesignWare PCIe.
> >
> > This controller doesn't support MSI-X interrupt. So, introduce
> > no_msix flag in struct dw_pcie_host_ops to clear MSI_FLAG_PCI_MSIX
> > from dw_pcie_msi_domain_info.
>=20
> > +	/* Enable L1 Substates */
> > +	val =3D dw_pcie_readl_dbi(dw, L1PSCAP(PCI_L1SS_CTL1));
> > +	val &=3D ~PCI_L1SS_CTL1_L1SS_MASK;
> > +	val |=3D PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_1 |
> > +	       PCI_L1SS_CTL1_ASPM_L1_2 | PCI_L1SS_CTL1_ASPM_L1_1;
> > +	dw_pcie_writel_dbi(dw, L1PSCAP(PCI_L1SS_CTL1), val);
>=20
> This seems like something that ought to be done by the PCI core in
> pcie/aspm.c.  L1.2 also depends on LTR being supported and configured.
>=20
> If it needs to be enabled here, can you expand the comment to say why
> and how LTR is being configured?

Thank you for your review! I realized that this driver should not enable
it here, as you mentioned. However, I don't know why but it needs to be
enabled here. Otherwise, this driver cannot work. So, I'm investigating
the issue now.

> > +	rcar_gen4_pcie_disable_bar(dw, BAR0MASKF);
> > +	rcar_gen4_pcie_disable_bar(dw, BAR1MASKF);
> > +
> > +	/* Set Root Control */
> > +	val =3D dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_RTCTL));
> > +	val |=3D PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
> > +	       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
> > +	       PCI_EXP_RTCTL_CRSSVE;
> > +	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_RTCTL), val);
> > +
> > +	/* Set Interrupt Disable, SERR# Enable, Parity Error Response */
> > +	val =3D dw_pcie_readl_dbi(dw, PCI_COMMAND);
> > +	val |=3D PCI_COMMAND_PARITY | PCI_COMMAND_SERR |
> > +	       PCI_COMMAND_INTX_DISABLE;
> > +	dw_pcie_writel_dbi(dw, PCI_COMMAND, val);
> > +
> > +	/* Enable SERR */
> > +	val =3D dw_pcie_readb_dbi(dw, PCI_BRIDGE_CONTROL);
> > +	val |=3D PCI_BRIDGE_CTL_SERR;
> > +	dw_pcie_writeb_dbi(dw, PCI_BRIDGE_CONTROL, val);
> > +
> > +	/* Device control */
> > +	val =3D dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_DEVCTL));
> > +	val |=3D PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
> > +	       PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE;
> > +	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_DEVCTL), val);
>=20
> The above also looks like things that should be configured by the PCI
> core.

I think so. I realized that the following settings are not needed here.
So, I'll drop them.

> > +	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_RTCTL), val);
> > +	dw_pcie_writel_dbi(dw, PCI_COMMAND, val);
> > +	dw_pcie_writeb_dbi(dw, PCI_BRIDGE_CONTROL, val);
> > +	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_DEVCTL), val);


> > +		dev_err(&pdev->dev, "Failed to initialize host\n");
> > +		dev_err(dev, "failed to request resource: %d\n", err);
>=20
> Pick a capitalization style.

I'll fix the style.

> > +		dev_err(dev, "%s: failed to resume/get Runtime PM\n", __func__);
>=20
> The driver name + device ID + message text printed by dev_err() should
> be enough that __func__ isn't needed.

I got it. I'll fix this on v8.

Best regards,
Yoshihiro Shimoda

> Bjorn
