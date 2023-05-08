Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA266F9F66
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 08:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjEHGHp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 02:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjEHGHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 02:07:44 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2097.outbound.protection.outlook.com [40.107.113.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB73A262;
        Sun,  7 May 2023 23:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llYw5Thr5sREVDuvpOPd6D5dnBZXILYTTvC4FeBPtEy1tM2RF8Lu6F1O7KwxFNf9W/KmHDjcNTo8rZURziG8LY2lOYqxKfE6WFBqIQz9hH85txXCszMRdWMhFBggetR9PDeSbYLTJlvt5kcrfn9QE7WSJ9lNr6r0l618FJqH5oZkmTzzIb+WzHQxdSo3vIRIbcwytgB1KJhua484ngwx5C8VHaXILejWmhtiJ/dvGu5p5nKI6HEl9p3jhIRPnzHI5H2hYOsTGxJDu1tKZZM182CrKuzCpvBWewrE/kLbUNTVoPR4BGxECiJMZjRsvGE2+VBYFZ7NT/AziuC3q0K+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG2FDPQxvqaMYQmICEPCMx/pw06SfGRhTfwJC5QIFVc=;
 b=a8kxnFlUxAcVpvR/7TG7AHby2gbA4vYQaXXY1yeXxA+2AJ/RVnCS8RKB8sAbOEahxuI7SRsr2Fp+dYTaA6FGtB4hV9SvxsQKo6gfo2AjgCE5Uz5IBi957FHB/kaoiw7yeJFnvs3loVemYcEaQDH0kO26jsRDQ33le2QsCYt0xV1xeqBqVD+5mRUqNFGn175aEHY881kR1o1+3UCpVCpGAxj3vSBke7UtNe0Wu+pwNm1YNwq+uoPWfZ1ncINyOD+IhYuxLqd201tN+CnDKVzpf4oq63i2C1Ea2xhN8Tdx27YO8EzSCD4SATZ3MDL209Y0UBqEcBrRZkKJtHusKkgHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG2FDPQxvqaMYQmICEPCMx/pw06SfGRhTfwJC5QIFVc=;
 b=lMI5kYlOEjS/z6hM/PQ1IIOLU1Gb1/v89A7cYyr9anfsHHU+8+S4nRRd+TCgldHnH9GQgtLWltoc+zelP1cHEOrsDEGlA4zJGKK4mMj3Vmg9rkdWllc65Idoyp/XFQ9jZh7ntTnXNvKybcH3X4mt/yRlpq7h85y+4CHWLJ60coc=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB10859.jpnprd01.prod.outlook.com
 (2603:1096:400:26f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 06:07:39 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 06:07:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v14 07/21] PCI: dwc: Add members into struct
 dw_pcie_outbound_atu
Thread-Topic: [PATCH v14 07/21] PCI: dwc: Add members into struct
 dw_pcie_outbound_atu
Thread-Index: AQHZd/tpTNvFy2osqkSeRjAtKW1r669F0lgAgAoRVHA=
Date:   Mon, 8 May 2023 06:07:39 +0000
Message-ID: <TYBPR01MB5341C55C006F4AE51E3203CFD8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-8-yoshihiro.shimoda.uh@renesas.com>
 <20230501191430.l3ao4ldwlyaidol4@mobilestation>
In-Reply-To: <20230501191430.l3ao4ldwlyaidol4@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB10859:EE_
x-ms-office365-filtering-correlation-id: 6a13e3a1-599b-4465-4d5a-08db4f8a871e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUDQA7++F0VAQFZMPfJC8IYLfZm9FmL6s0C/5Eev9WJODt1fJeDtOQMckD+N8O826ca23eRKFFX8dQxhQ4t7QH7Pqkggxk7DgxwWsNXaJRLrSTTqrr6mLCr59veE1I80J0P2HTPE2xr33eLc/O0225hcvKiP+ZrBaFK7h/jjmledMdWMh3at31eysltzHHyy6b4/p38Idp0EEI6Q8zkqMOFo6prlvXQt2jnPVbVYEVFXt7yCcen1lKzVjtAeBOtZC1uwV1coe+/hpVsFf9vn0KjfWx7l29U8E8R6+Jgj1atjpiqwXR8QFwPkxqM8MLDvpiZVLT76wMl1OHa8pTYSWbaIGB7g4++1YYCco1mcTDXT9aIaNI5Yvk25z7pIJxPHYTjRye2GOI2rWAKSHKrH2RcYq89IgoLliw2sjZPqYb4E0uePjc4zu4A7Td5wO1/EzyhyTGVnGEdmOIH1dbqhn+1MRfUWk5cMNndYDFM53JIvwJYzaeJumQxWP101bZB5JiW3VPLBIUJMS5nSAF2YxgbmASX/1/a13tuMoIlC6s7Lx8tHbWS1zSAHFG/n4ZqPCtFEo+5MTJl06+mRn8IPqLztpXR/ThS8IgBFc5majzTc/N32K/z6C250uyGWWtOb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(376002)(366004)(136003)(451199021)(33656002)(86362001)(4326008)(54906003)(76116006)(316002)(66946007)(6916009)(66476007)(66556008)(64756008)(66446008)(7696005)(478600001)(55016003)(52536014)(5660300002)(8676002)(8936002)(71200400001)(41300700001)(2906002)(7416002)(122000001)(38100700002)(38070700005)(186003)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V6CSMAGRd5UMq7bZ4a9qZ8sdJ7ZcQ4v5Cuen3a+1OP6OshKb35dYkY93b96E?=
 =?us-ascii?Q?GKTJgeTHMVFXK+FpFd8VhjruNwK03cnW0CwGz3RZhZMhU+msbKdTBc7pf2VH?=
 =?us-ascii?Q?C8VyGlpf8xiqJiqPzPlyI/FJZYWkEcW8V+90HTQSEd9/dGiXXiIXh9UM1duy?=
 =?us-ascii?Q?dDuJDnKUhHerVceBtCEvD+BxEH+kcZLqY74nxSOiksr4Uc/QLLYxQPZogkWw?=
 =?us-ascii?Q?smMOH7nQvsYWGsw5Z+ZoKgDtT8mH6I5QbLmKqSjBROPcpkSLKUMTKbZUfhoC?=
 =?us-ascii?Q?5HrNW0BPYNVloPdYH8027WCGL/wn0sh+o/0qODPF/uUsGtaIxt2+FXFZ1Byk?=
 =?us-ascii?Q?f3OdOEsyH0prFpJXqDUyvOSJ9rFy2L28bI6WoNt8okJog6Pa1V4hUXDcZv9X?=
 =?us-ascii?Q?deluitoYWXsu9Fg5aNTx10xnpZ+Ksz0C19YbhPeZQ64Od8J+UqQD+yT5dhK1?=
 =?us-ascii?Q?H9y6CenJyGf+CRB9ObGEz7Q1wuj5SiSfC8i1t5R1Xaldvs1j23ZZTwl+64pp?=
 =?us-ascii?Q?ZOCn4e8/o3Y5bfNvnVlz5nVtBgXg1ZKg/b3SWu0Jf7qShCNnA7HEFE+uApXA?=
 =?us-ascii?Q?1VWKSGjMQ3GE1TNCJxkE1PsKMg9qs9qYzNanXd/xmqxLIO0rShYATpbu/7BZ?=
 =?us-ascii?Q?5HBRzt8T00fqWoYNzIQ1j99oEDExmOzzhx35/ykT7wzI2rVPMZZ5b5/a7hKw?=
 =?us-ascii?Q?2kxQTqUbFrdu+OTHbEPZ0ZN5cZ7IHqiDIv+xpTV3n50b0WcejGgi89xMUwPh?=
 =?us-ascii?Q?wtv0OF5riXdYYjMEq8uZ0CBDtl9pXGTqvpt462lk+EJ2UCgHiMmjkfcEMgrd?=
 =?us-ascii?Q?8ST6cLYM0JwBxYmn88h0VzmK9fNjWh5lEsNHQmPbKIOKlebRlRT8SRRlCwsZ?=
 =?us-ascii?Q?DdFlEmuuB1+s/v5Jet+2Qfpxz38Lk9r90XT0mCreJ8ZHx9OSDPs6QscltiyY?=
 =?us-ascii?Q?TK8Cd6m9bEhBySxnrujG1hJqRjY5YkylVWnXtJDJrJyou5l0YgWxntzsJUR4?=
 =?us-ascii?Q?cuENb0edA8xBloj9DmmiJB/IBE7jCKvjT7flLyK9K9DOHdPS5CWfnHPH/J5N?=
 =?us-ascii?Q?T/B4XbpR6njwnSnD7SyMrwrEAF4R4rGrlhvjr2kA5AK6FMUcp6sS27cniiy1?=
 =?us-ascii?Q?URNBmDyMcXRsjwd9xOpn8EIxtKRnVgz/PBaqoIpbudTZlrPpMF2xE//BEX5n?=
 =?us-ascii?Q?W2yNxuoyhSEFqDTKlFj4eJQiNcguVO5N0zARPVbZo1+0Y/J9hNzqp8ZeY/+P?=
 =?us-ascii?Q?BFIhBRTFL6UTZzlMTiKiX0H0Ur2zkdzDFyeNlM3Cz/iT+lTSSOfOkTGsp2/j?=
 =?us-ascii?Q?v1y+7kPCh2VnkbqjtHv+QJPzBI7cA+VsOXA1CA4q//YreK9Xw97WS2hJGiJI?=
 =?us-ascii?Q?D8bUjbYaqP9goLMbZm5v4Vx1bqCKwT2sCCNOd9q1yEzHcOiovIwEB8XgHb5y?=
 =?us-ascii?Q?dUb++hSlW+lyn8dZm7lsQIRRz+TQWZR7FvIG7dnrH0mKgJRHS6zC8T8mtERN?=
 =?us-ascii?Q?ZV1uml/C8mPRyNIhup/RCq1w7VIZkFa3cC3cXtSpV440a99GcyLnGu1CEjw1?=
 =?us-ascii?Q?cUaHwbwwR4vGO45Vfh0mbi7sh1rIMO6ZDCtoilTBjaZ9/9Njy/7ZWeOUMrwj?=
 =?us-ascii?Q?AHyETQUhiRapoU7UCJPocnu8mCRp88KQk+5WoqXD8qGv9rbwKCFX+x8KPZcS?=
 =?us-ascii?Q?Fxb1Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a13e3a1-599b-4465-4d5a-08db4f8a871e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 06:07:39.3815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heXc6LJGv0XqdzB/8wLQe1wrhvFLPRDEYbkDoG1QaQ+jjnCT3VDoC+f1Rs0UalRMrgbFG+E7rR7OMM1rlWzL3LArNKL5fWR1yMZJq6r1W4w9ND8Fqv4gU5JZ9dX1hdRh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10859
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, May 2, 2023 4:15 AM
>=20
> On Wed, Apr 26, 2023 at 01:55:43PM +0900, Yoshihiro Shimoda wrote:
> > Add "code" and "routing" into struct dw_pcie_outbound_atu for
> > sending MSG by iATU in the PCIe endpoint mode in near the future.
>=20
> [PATCH v14 07/21] PCI: dwc: Add members into struct dw_pcie_outbound_atu
>=20
> what about the next subject:
> "PCI: dwc: Add "code" and "routing" outbound iATU settings"
> or a more generic version:
> "PCI: dwc: Add outbound MSG TLPs support"
> ?

Thank you for the suggestion. The generic version looks good to me.

> It would have been also nice to explain in the patch log (or/and in
> the code) why the "PCIE_ATU_INHIBIT_PAYLOAD" and
> "PCIE_ATU_HEADER_SUB_ENABLE" flags are required to be set.

I got it. I'll add explanation like below:

PCIE_ATU_INHIBIT_PAYLOAD is set for setting TLP type Msg instead of MsgD.
PCIE_ATU_HEADER_SUB_ENABLE is set for issuing the translated TLP header
by using PCIE_ATU_{LOW,UPP}ER_TARGET registers' values.

> Other than that the change looks good.

Thanks!

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
> >  drivers/pci/controller/dwc/pcie-designware.h | 5 +++++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 782c4b34d0a3..e8d4d5bde2d3 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -497,7 +497,7 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pc=
ie *pci,
> >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> >  			      upper_32_bits(atu->pci_addr));
> >
> > -	val =3D atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > +	val =3D atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(atu->cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> > @@ -505,7 +505,10 @@ static int __dw_pcie_prog_outbound_atu(struct dw_p=
cie *pci,
> >  		val =3D dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> >
> > -	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_AT=
U_ENABLE);
> > +	val =3D PCIE_ATU_ENABLE;
> > +	if (atu->type =3D=3D PCIE_ATU_TYPE_MSG)
> > +		val |=3D PCIE_ATU_INHIBIT_PAYLOAD | PCIE_ATU_HEADER_SUB_ENABLE | atu=
->code;
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
> >
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 81c7558a4718..954d504890a1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -150,11 +150,14 @@
> >  #define PCIE_ATU_TYPE_IO		0x2
> >  #define PCIE_ATU_TYPE_CFG0		0x4
> >  #define PCIE_ATU_TYPE_CFG1		0x5
> > +#define PCIE_ATU_TYPE_MSG		0x10
> >  #define PCIE_ATU_TD			BIT(8)
> >  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> >  #define PCIE_ATU_REGION_CTRL2		0x004
> >  #define PCIE_ATU_ENABLE			BIT(31)
> >  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> > +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
> > +#define PCIE_ATU_HEADER_SUB_ENABLE	BIT(21)
> >  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
> >  #define PCIE_ATU_LOWER_BASE		0x008
> >  #define PCIE_ATU_UPPER_BASE		0x00C
> > @@ -298,6 +301,8 @@ struct dw_pcie_outbound_atu {
> >  	int index;
> >  	int type;
> >  	u8 func_no;
> > +	u8 code;
> > +	u8 routing;
> >  };
> >
> >  struct dw_pcie_host_ops {
> > --
> > 2.25.1
> >
