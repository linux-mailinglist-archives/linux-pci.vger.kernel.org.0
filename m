Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE62721B26
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 02:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFEAOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 20:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFEAOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 20:14:32 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44111CD;
        Sun,  4 Jun 2023 17:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWiAdVa/K1Z6znM6KZfAHbg2P63A32iqv0om3mPR0Qxw88IW21s3+zMmwoM1SN4VFVGv4yt+s4gSYSwZR/x7iMLeMxRUcQfGE//hQHDroI4T1JkF7ZWza8Fa7sErl8qsku0ASzAyOYSfuQa01iLwtmbARyNBXcJTowImx+3YKMSjhQ2E7ensFjLxyzg7IwxE6w/aW7ASf9s4w5FtQRmNEazW5tJhi7tOw18zX46XLsKrJrQRnUiH6HCfovm9JmCGb+2EXNMo/gYvO2x6lMOqyQMN872Ar+xMza/LIwaNVqgUp3NzYXNTzBV571vsQLcjfX8w4w5QU5M5JY0ysRk1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6iPpzJ0Pjrujk97hKEoL18WBDwxsLU/o+BlqQrUBXc=;
 b=oc+9d3D4LhFjHIQxy49JRaSzeRTP2egc3DufFIigit1xhpOOV9a6P7Z6t1xsjIDmS5s12rS8BfuRy9Porz4pQO7AV9db4Yhz33tuyg5cWIrsUfLzBhehiC9okHme1iIpXjeeTX2rReOO7hRZvexm6v1CviMj9XOqAOBMvl/cPprv1ghV+wHpzP0/9I1pWBx4KJ9RRDjuQN20aRXboeXB0p/tzfdYiKgMU9h2z2dM89m2e/GGQI7Hl/VC4cfz8C0atWyGgET5yzDlly2ZHXYbqlldSgJWJUD8bvFfMuJMUvjuFaKpLxQIILQmHzt4eWJWxKKh/PPcEQ0JfoF32Mm/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6iPpzJ0Pjrujk97hKEoL18WBDwxsLU/o+BlqQrUBXc=;
 b=g2eBRZG019lWv43lpWHxjaKOVqBw6SUkJZ010B6UxcI+mGM8sG3/7CUNmJjk8/jRypQ1AdmlVz/GtRCUZbTFRlHx5Fkdo5r6NZ1LDAvJt9cOnGEWz83BsIYyCRZbMPX8g3KMIE47Qtc//D8Mk8sgNYVpnKiPetBT5+Qhy3UekC8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB10423.jpnprd01.prod.outlook.com
 (2603:1096:604:1ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 00:14:26 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 00:14:26 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 01/22] PCI: Add PCI_EXP_LNKCAP_MLW macros
Thread-Topic: [PATCH v16 01/22] PCI: Add PCI_EXP_LNKCAP_MLW macros
Thread-Index: AQHZgwfRNypZz/ijvkOLsJCqGkmnGa97Z+QAgAAVubA=
Date:   Mon, 5 Jun 2023 00:14:26 +0000
Message-ID: <TYBPR01MB534183482CD31D122C4735C0D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-2-yoshihiro.shimoda.uh@renesas.com>
 <20230604225036.earzdx5dvzc3imoz@mobilestation>
In-Reply-To: <20230604225036.earzdx5dvzc3imoz@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB10423:EE_
x-ms-office365-filtering-correlation-id: 73799d77-1ff9-4281-9c8b-08db6559d278
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UXrUwqTAk+aKk8qxKvqz18X0v0rLRrm2b6+UKlkqz8tB8uPdYzd+JB4BKhJDI6Rnu1prjgKfGI8Uqxhyzu5qI+VdVf52LN7BFcp4/s0MH719/qwjPKAwrTg1IB4NwWkKFQLHvZBPwuJvBu7mtgh7FyTfOJF2YSrP5gfr/qbx2ag8wACVlrARV/QQhmRBpQotyzxSS6dlMq5ba8wpF4Ln9CxOb2dkz3Rj1Bf/3sK6yQRhmI2bNVFk1Npm9kT/t3jm/hFNOobsvhzLTvhb0Rw8gvVd4Ya3QHpyu+Kkh+E5ZDloZ3qlr7pSlEhFF3RUD/ucWRH0bahVN3Jb5e5w5BZ91JZr2PpdB0tJ96OV587E/F1r9WISQjg6C2V/QxOJfsS4KEMCKAs8LrfhriXdf1cJCgwn6BUmekt4r612NqOjohGgWJRMOEJMEIBB8CLl/F7HnLBsi6vXMSMFXCiCpb2NC4of61v9PcV4P5pT/X8S42IQmlD+pLMaSglumS8r81CUoDx7E0+kiM62W94J3/3ajrdIiVuAMTXQjbVHQm3KVDXXlb6p5OReBFFXosfvZdbCoE1giNlgri2GywbY4A1KDgz47T7dx8u7mjWFQKPoF1hLOz3DZylUnn1w6ACI5MNG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(55016003)(110136005)(54906003)(478600001)(8936002)(8676002)(66476007)(4326008)(76116006)(66946007)(64756008)(66556008)(38100700002)(66446008)(122000001)(41300700001)(316002)(186003)(83380400001)(71200400001)(7696005)(9686003)(6506007)(33656002)(86362001)(5660300002)(52536014)(7416002)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zK08e308AOYew9pzFsVm6GG5wh2H2M+pTUaYUcajFBOhDoTbkre7Ohm3yIWJ?=
 =?us-ascii?Q?4ElWfSCdxeiIczrCQbD8N52y9QK7PMcs6TxJfGwK6t/mKuw++8nHUmrZlPxo?=
 =?us-ascii?Q?SDbCv1hoNAqZv5UfIrwRv6LQA9pTkuq77ZaVbxPVA6fanXX1QugZGMEzE95U?=
 =?us-ascii?Q?BgFO4feX/9OnL5PfBPnr6iBnmtWCeNsBqU9LN8OtjUek5ZJGLc8qVJKalJH2?=
 =?us-ascii?Q?xo/lgKcJcscHBJgYMS/le3uyOVqMlcImXe4X5piF3peywkSQ8fvRo7DEjiWt?=
 =?us-ascii?Q?b8t8gAI7OYY7416BZSBsLFPYmZLQu9fb4NGuU51nr7VX6oDXPTG4agmFZQ+7?=
 =?us-ascii?Q?2aDV1p2WiUQM3QY23e7otmak1n7w+bn2yjxKXjychzmoyoM2jD9yuKsLlkX+?=
 =?us-ascii?Q?Unr3pSr4qUQKacGCQt+d6yP/aXmrjwTibvHHJI5v3TcPIzx8qzsqcADh2IMW?=
 =?us-ascii?Q?bNPUlw6CKZrxMqR3gfC45MzleNoVTzRGVUW2YlSHvNJf20X/kSVKmZj3/GNT?=
 =?us-ascii?Q?oqL51oZTaNZGhnprc+6r+V+9VlF4mfNRSV3zxard0gMCAHO6gp9/HN19jyGw?=
 =?us-ascii?Q?bicj4LMRmOv78hK7+tKUFzDPkdFxbK/gOEQhB8Que5voV5G6sAUX/18vb1Uy?=
 =?us-ascii?Q?V83KgCNd5L2l2ujlksqlt/x2FlZXjtfIid3G5UMDrkI2UEdxABiHyP+2nmGR?=
 =?us-ascii?Q?DN2xhQeYSRI96U4X3Z18q0mq1PWS23rmK69c0iygknHLmirhnaW40sNSBXkz?=
 =?us-ascii?Q?KjzQcJZzfqBIBeDwIg03P6gZxIsKqdtsjUxG1UTGWb97U6stFQSdKVmeFyak?=
 =?us-ascii?Q?/cvWGSsG673oOUaL0ih8xRhHuuYDJU4UhfGkDk3woCZ4yVjVdLasCm04Zlm4?=
 =?us-ascii?Q?DeiuSgQexM+2IAlMrXQGtacI5qSUAEOeCxHZfHl7jN+0hDvBETEvRK9FohHJ?=
 =?us-ascii?Q?arlFsJmbCWbo+7i8CaQf3E6YQkKvbai9ZHPN+RBLGwDSCqU6hG562daJuTt2?=
 =?us-ascii?Q?1D4nHRQlw0JJW2xfRWOurqtNMexQUXOKnmSq6PjfvezFWEM2PoJyJPTihSUq?=
 =?us-ascii?Q?mE4+/jKTCTCW0+ps7UNBU4WJxjWJlz2PSZ/ehgr0m2zF0SYv4eYrLiTd7ed9?=
 =?us-ascii?Q?+8kl5EAmF3lRFhQRrY9nv6vnovAPzcAWfhFbTuLYavPyJpiWfJspBGpjZ3l5?=
 =?us-ascii?Q?1BbG6MXavZplq4zMHOSr0Msn8CCAk2ydKcnOVjSoNgkXDMyqhPkce5YlaoUi?=
 =?us-ascii?Q?dXgHE7qK/hHwhPD0cUgqEbnyfPX9u61ZOCr+WuQD9NX1UltPwftDW/1nD6L4?=
 =?us-ascii?Q?wP3R/1ZxOKGKA0HEzB4ROWTrC8AH4aLRCejqeSoyQ/CvPz3+W8S2eyqMnTQX?=
 =?us-ascii?Q?AhKqfx3OkUiF1Zl7jgBp0xwrTansPGElVb7hHzeKixAG559UFWkZuw2uTrHx?=
 =?us-ascii?Q?zloLQ2clpWVG5lFcMyWbJknDFas7BtKJsesACjtY3T1nCLgeEGSkV6zaHmH+?=
 =?us-ascii?Q?38Gi02MWemeb6EbV4e7lZUdc/GkidhUWwhRAKRKfu2BVtxwHnI0Qi1BQmQPd?=
 =?us-ascii?Q?0PoXvdMZIrCVW3adog7fwzMx2UIC7IbNTnwtU7L6XV/FIvVtUithRHp/7rxC?=
 =?us-ascii?Q?WiBxP0KLnNly8bsdreDxXEdKyutdRTUmM+T3MShnL3i5hzM6DfYaHa+/+iZ1?=
 =?us-ascii?Q?q7u1Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73799d77-1ff9-4281-9c8b-08db6559d278
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 00:14:26.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4HpTM8jpPZuYqJ053EoU5VfryK7WgT2Hs4Hfd6ExeyslIU+yx8tfXdt5ZNtgVoYLpXJc/jqhbd57QlZzxfSbC2yRFUiLnWRXwA5Hdi7rPA3i1qgPeTxiNX1UtO1XNTGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, June 5, 2023 7:51 AM
>=20
> On Wed, May 10, 2023 at 03:22:13PM +0900, Yoshihiro Shimoda wrote:
> > Add macros defining Maximum Link Width bits in Link Capabilities
> > Register.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
> You haven't been using these macros in the following up patches since
> v9. Why do you keep submitting this change then? I would suggest to
> drop the patch especially seeing the PCI_EXP_LNKCAP_MLW field directly
> encodes the link width thus these macros unlikely will be of much use.

Thank you for your review! You're correct. I didn't realized that
the macros were not used on the patch series..

However, I also realized that the patch 11/22 used the PCI_EXP_LNKSTA_NLW_S=
HIFT
macro for the PCI_EXP_LNKCAP register. So, I'm thinking that I should modif=
y
this patch as adding PCI_EXP_LNKCAP_MLW_SHIFT instead. But, what do you thi=
nk?

--- on the patch 11/22 ---
> +	cap =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val =3D dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +	val &=3D ~PCI_EXP_LNKCAP_MLW;
> +	val |=3D num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT;

Perhaps, this should be PCI_EXP_LNKCAP_MLW_SHIFT instead.
---

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > ---
> >  include/uapi/linux/pci_regs.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_reg=
s.h
> > index dc2000e0fe3a..5d48413ac28f 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -538,6 +538,12 @@
> >  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bi=
t 3 */
> >  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bi=
t 4 */
> >  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bi=
t 5 */
> > +#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1 */
> > +#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2 */
> > +#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4 */
> > +#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8 */
> > +#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x12 *=
/
> > +#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x16 *=
/
> >  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
> >  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
> >  #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
> > --
> > 2.25.1
> >
