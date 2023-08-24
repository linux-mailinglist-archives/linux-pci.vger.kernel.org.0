Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5E7865A2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 04:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbjHXC5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 22:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjHXC5K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 22:57:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2138.outbound.protection.outlook.com [40.107.113.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75056124;
        Wed, 23 Aug 2023 19:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPuoHwsjN308ej3hBcJ7aV7my6Vqnz+gg0yw0fEBWYV3z46eF3lbnd4xftqWHYe5qoDDJfsLLZO9AfEF/ZZ1Svz9u3DEunf5+uWix+yzFzzUskYSXsN9VEgY+/8SIMd8Mx+iMUn2tht1i1xm/Ts+SbAFVsa/nH6NVANG+Dog/LYln8fBSRZTHGiqgA8DBwF3jgV+N/5qzLdZGZp6rcf4fMYMdVcs13WcnuXWfBXJ0JAgFKyxerF74AvUeBYT36VejQGbdkZlEbfFZxAK7qGPzBJjTycUpyJnwByXknDndVsj9cOnn1uFCc6tnlnV+vCx+naaWOkh17pQQHidixd6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPbiM1rO7G5wUbE4OD+h/yTx6cDT2iKF1DIy1TTR/T4=;
 b=NUW8edQ+bBCxmhylonjiTqDRt6EYQyahYiljG/7vnlcE5OKVU6n6xLD7g2JXFnN/NtgTxbkTVNQtUA0Eiog+6hGb1cr46mhdVBcQxxhWe22xdGpSP3ugqeOFMkq5rl7SDHfd+pF/yRiFzNem+/pFUk720p0O/qIjmA6QV+KeiLdxIxhNx5AufKEt28YiZtTYCtLBNK0NEokD7co3DYNm361Uxaakd3xJTrgxJ3muipVbPdZE/odD8a1chHtdtqETLg+/yxai6t9Fi+vpF6pRGrRxwQ51DDtklhwy++3UmS/cMKI35AR15hZFfqflXR4MQ6Er1pg7TVbyP0YOZfz7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPbiM1rO7G5wUbE4OD+h/yTx6cDT2iKF1DIy1TTR/T4=;
 b=dvbzhT7kID8NE0b4vs92MEm2kJuYN3gBJvaqzIG9x46+9EqzMrm86onrUFQgRCMeMxuQrXYKHtCzVziqKv+qClSUq3P5D4CSNTU/u+2lklafefPznubiAWIMXov9V6/zxp7/3mPvDoJ2KDaYcW/0lk/kbtFi5su/YdPB17M49qU=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TYVPR01MB11277.jpnprd01.prod.outlook.com (2603:1096:400:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 02:57:02 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 02:57:02 +0000
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
Subject: RE: [PATCH v19 01/19] PCI: Add INTx Mechanism Messages macros
Thread-Topic: [PATCH v19 01/19] PCI: Add INTx Mechanism Messages macros
Thread-Index: AQHZ1aHjYEIA8d5x2E2JamSlG+1v7a/3qwEAgAEWqVA=
Date:   Thu, 24 Aug 2023 02:57:02 +0000
Message-ID: <OSYPR01MB53348B98013A3F446C69609DD81DA@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-2-yoshihiro.shimoda.uh@renesas.com>
 <iutmgdc4ux7bnbfvl6bqtyifxw6kytx2pge66pvsbhe2tzisrm@wjsp5aahbymc>
In-Reply-To: <iutmgdc4ux7bnbfvl6bqtyifxw6kytx2pge66pvsbhe2tzisrm@wjsp5aahbymc>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TYVPR01MB11277:EE_
x-ms-office365-filtering-correlation-id: f0284d7b-c06d-4a1f-8f17-08dba44dcaef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ew6BJYymryAXstJMP1vm041niJJBJsHVXry+l9LGvQOSDkCeHh/sfzFxxyIWe0UkbjGZUwwGBi+qH7yGmI+G9ocl9Qya1kMJJlLEt4jR6s/0+wSIzCkg3oGrR47u6cqdFADuH3F6I41W7zkZIw0YoFG0UPT/Pj1+CZvmazgb20W1qt3UgNiutdrzHR49OLdMJ2150cj5agRQR0uaAiU+8QoWbHYljhAUtbarE+XPi5byGXYWovbQtJjH/BfDLu0eMgd0Ww8qBLj43A9EqjZCdhbHj91ULknW0fgdHJhoTtP1igixUTf/mF6cjQKPM6jUBZXr0InoQzhfqFfXTP/ZzbUyV4D13JROnhXAPXLgUzjuDJHg+BOpzNVQop9kbhuiM9AbUCoAdkSXxjuKoOgPfngv/g1HUyml916zVKhsprPxO1fiJW5i9JRr0BDgWX3l4cpy6two9XNRAL1iVuHKZlXU00lqVC2lI3TNDWzubKsPmdntrTyUcomXWd1DZbzm6FjHSjTLPcrdbpttobG7dJSLg1mCflekdLN9L+au708oCXW18z++0GU0dJ28RnG6+mwCc3ybnLW1CeCgMOpxnWw/kKj9swxqZ3d298PW0CiqMIWQqTsNt84uKX2OGX3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(186009)(1800799009)(451199024)(52536014)(5660300002)(4326008)(8676002)(8936002)(83380400001)(15650500001)(7416002)(33656002)(55016003)(71200400001)(38070700005)(38100700002)(122000001)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(6916009)(478600001)(41300700001)(9686003)(2906002)(6506007)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qWGULiCtVJcHd2mqxpR+UZBqLoa6U24Fbo/Lj7eQZEFJXRsCmvQ72LilZ0hq?=
 =?us-ascii?Q?SiwhiuTgG8saftEtgbqOMVL9iopy2l3M73L0wQBX1PdJGsVvNAWLUhnsuXxt?=
 =?us-ascii?Q?xJZ819Nxld2yg2t0eVHuGldXdaYgD1O326L11M8+0nLdKkdlD5bTC482TF3a?=
 =?us-ascii?Q?VyaHG0ndZVv7WBLFTg0JN6AjVQXUqJRH3Y/F9s+lKuDMIpvZIeEPJcYJGNZK?=
 =?us-ascii?Q?wNNmfF4+fYMOog9qop7/S9v7QzmfitsR4t3YeS+KzWCP5y8dx1KMK2dmDINJ?=
 =?us-ascii?Q?iZ7P5M6NXgSTs8zO638U7YBiVSHtIcKaaLhXfV/bDI0yYndQb9se0rtT5pkf?=
 =?us-ascii?Q?5iAI5W2AdBeUk21pEWdxK/V+bHlDE1AdBwMUVD5td+0xuUlimIc8kFApm9Ve?=
 =?us-ascii?Q?qEytb74hsROPB6FKJEi3JCkx03SfTA7uwRzHmMOjptXlwKiFpkVkM2CwUuxm?=
 =?us-ascii?Q?JD5zkzi+g87WaLbNlhyQ/bFd22eMSibGtLsZ0490MvKw4B7m8hdyt76Dyl39?=
 =?us-ascii?Q?90RdONJUskQJwagl3npYqbHY5axWqQVgtTGRFpt8AuOYTP8DRtzVjZcNLn/p?=
 =?us-ascii?Q?bSbRe7MDoONMVJWVPyATBsLZ7P4rDz7yfq7QCixpVt1zPr010y98LHWuZIid?=
 =?us-ascii?Q?3KjdoYA4/+nU4YeEatQ5U7DlbLBXm2him2cwB7ceeXM0zS9Py/go3oU3JGXL?=
 =?us-ascii?Q?b3rPMHeXFZmdolKIAM0OfgszKIqVwP50VCgxE7f4OTxuM0MiOVlhgrzM4cs4?=
 =?us-ascii?Q?qXp2sqzKB29/jDo0+SXkCqXdv8SIUWRDRvRrumysQH5uMaszspIZMO6wwiV4?=
 =?us-ascii?Q?uFAjw+mzHOdxK3eV3z2SL7OYRQTFUwfn4M7iaJugYEzp08UalZfXiiV4WqOp?=
 =?us-ascii?Q?Wzf+dea9XU/vYmQq5rP2W/I5ivRCBoENqhKcGK8OS77hyVGSgNcdudmXXaKs?=
 =?us-ascii?Q?9+t/OIkBw4w9Bm77IR2hDSwl9SG9bK5hb3sybTsAiXNbhOgG21MPyw1sVHGs?=
 =?us-ascii?Q?RigUA27AsAB0ik3r9HUet/E3WMfQLLzhCzjTgiqXK00d4QounBZyJ4+QATG1?=
 =?us-ascii?Q?1RE4MYXjVbLCiYs7H1PMtoU4P9a8frQvshBxvXAjQrXqz/MZpdQ2iZt5bluN?=
 =?us-ascii?Q?VOYClSM4xnqz6RhRJ3JzVXkuJKvusHK91JNtyqT5GPCSDTFIrF9EbBqaetZY?=
 =?us-ascii?Q?MtZJ05bAoclgEXeoOlQTC5VfhAa/M+BMz0L6ZwMT27bB59DHuYxLOaCtcQOK?=
 =?us-ascii?Q?ovZFHx790yLdjzkgHtagxD69uubESUFWpBHuObzjjDO/UQ8aEBTI7mRAHPtb?=
 =?us-ascii?Q?mFTHXbapPDNlJ6jF1ufkOy7nxaH57zNDdRhnoXkaXnLt1HsZL5sJPWoRJL5z?=
 =?us-ascii?Q?A63G95Bb9++jDCVYct5XE8/LBGoklRc+sU4L32xKXokDTtOdY8bDt7RYpKe6?=
 =?us-ascii?Q?x8kyjptzRVToRfsZdqCRNLobOwSJ2uBj0dakd2ajdh/+bBanZU4wX0hiF00Z?=
 =?us-ascii?Q?VkY6XBKqtbwCIu1KXaiIkisiI8j+Kxyr5RyHuHh4UiH74LcN8K0YEuzji6Yr?=
 =?us-ascii?Q?xMd+lWka9XCM0iSXWCInP5ey9WyJocnmxyiPa9pFiLW3JxMQodeRghZuM2hI?=
 =?us-ascii?Q?51FZ2rkGKgRGlQtZx+4u8wlszOnYm+yrOAfJNlyU1MxNbrMsVhkJzhzld5ZU?=
 =?us-ascii?Q?WSoIgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0284d7b-c06d-4a1f-8f17-08dba44dcaef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 02:57:02.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q9LKNFmWn84KZnaj0lz7ePI8savPm9c2YRVqC5YXw4qk0qM+JH3pYPtvPzmgA7zd44ABsEcQM46txxIYU7wsSdFF9Mqt2qtNOs7E7ONCVBcRLvOoRap8pUeABPqQVaEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11277
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Wednesday, August 23, 2023 7:18 PM
>=20
> On Wed, Aug 23, 2023 at 06:11:35PM +0900, Yoshihiro Shimoda wrote:
> > Add "Message Routing" and "INTx Mechanism Messages" macros to enable
> > a PCIe driver to send messages for INTx Interrupt Signaling.
> >
> > The "Message Routing" is from Table 2-17, and the "INTx Mechanism
> > Messages" is from Table 2-18 on the PCI Express Base Specification,
> > Rev. 4.0 Version 1.0.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/pci.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index a4c397434057..0b6df6c2c918 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -13,6 +13,24 @@
> >
> >  #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
> >
> > +/* Message Routing (r[2:0]) */
>=20
> > +#define PCI_MSG_TYPE_R_ROUTING_RC	0
> > +#define PCI_MSG_TYPE_R_ROUTING_ADDR	1
> > +#define PCI_MSG_TYPE_R_ROUTING_ID	2
> > +#define PCI_MSG_TYPE_R_ROUTING_BC	3
> > +#define PCI_MSG_TYPE_R_ROUTING_LOCAL	4
> > +#define PCI_MSG_TYPE_R_ROUTING_GATHER	5
>=20
> I've just noticed. Using "R" and "Routing" simultaneously is
> redundant since "R" means routing. Just "R" would be enough.
> Thus PCI_MSG_TYPE_R_* would mean the R[2:0] subfield of the Message
> (Msg/MsgD) TLPs and we would shorten out the name length.

I'll remove "_ROUTING" from these names on v20.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +
> > +/* INTx Mechanism Messages */
> > +#define PCI_MSG_CODE_ASSERT_INTA	0x20
> > +#define PCI_MSG_CODE_ASSERT_INTB	0x21
> > +#define PCI_MSG_CODE_ASSERT_INTC	0x22
> > +#define PCI_MSG_CODE_ASSERT_INTD	0x23
> > +#define PCI_MSG_CODE_DEASSERT_INTA	0x24
> > +#define PCI_MSG_CODE_DEASSERT_INTB	0x25
> > +#define PCI_MSG_CODE_DEASSERT_INTC	0x26
> > +#define PCI_MSG_CODE_DEASSERT_INTD	0x27
> > +
> >  extern const unsigned char pcie_link_speed[];
> >  extern bool pci_early_dump;
> >
> > --
> > 2.25.1
> >
