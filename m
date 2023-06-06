Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBFB723DE1
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 11:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbjFFJil (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 05:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbjFFJiV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 05:38:21 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2093.outbound.protection.outlook.com [40.107.113.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0E31982;
        Tue,  6 Jun 2023 02:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5exBvIcy6v9wwZWYET3lKdy3Jno6+8FlfBrwn/+nnGQ+pfcv9WjXt6V00hJ3+6jiYZmBSUdZVMrWsiKfHvLmVKD/KdtpvyZM3WMWYX5rVzoS2ICqWdlrhq0TLEpfWD+R54vSReC3wzdpKbfc+cW82XQYodWFh7rdkXI6fVwaNbV44PvUGosWMZr7sgxHh/kTXALNtcQFiUi12IEhyZiK5L0ao2dFrGgDvlSHf1+ICP1qeczV+fNT3ttK81UD/epSOGsR8wxCL5ZcWNZ36wTu4rWfYq2lKFlMctkPwOD7uXw5kl6IopTpIxtosk1I+t9c1NNKNCfyRASiqyPrRguOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n28Uw46v9eNZbLtVWkuGZQb9CZ9bVUTujcyQ3qjNDTw=;
 b=la1ZqXdCdLP/ze3lmaDb2ltEpGdJemzwuKi/MIqCgc4fvKgDo9WxurZ+puJLmDFD/F4kq7XE5w9J1bWcrqg0l3tQAGju6BOmCLbilx0NpMxVDq/v6+cyzaAUq6F5qRYrv9WRlc9soSnDGFAUyjG4v40h9KMug+sT4ZUxBGjHAOYsFyJGK0Voij8b770NyQk1LR0xqilncAsUXnuY8ez2ORokUv+rSpJcUUXAIXyDkbYhtI7p3Qojjs783ELurBQQCouqqHCbeIlnDHCSLX3Fi+eQxtd0uKBIiGGvneVQygwLY83UyjCXujGvspfwus/nZJNSFLUHPt/vbtdK38WKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n28Uw46v9eNZbLtVWkuGZQb9CZ9bVUTujcyQ3qjNDTw=;
 b=ifMhPJBxLvRPBNukyZwJFktkAvsza3jnMU2NBLkAHwAd1XL62+V4OqW4hptG4b9YzEPwM1urjDE1tYkHLhn052A/2eRCU2dvfJYNZjfufCO2ZlQWRPMZ6ArviUShoR8AEdAXB5/KB6rJNiO7SM0Np+x89cy7h59LSwy8XWGfL+w=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB11286.jpnprd01.prod.outlook.com
 (2603:1096:400:3f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:37:28 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:37:28 +0000
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
Subject: RE: [PATCH v16 13/22] PCI: dwc: Add EDMA_UNROLL capability flag
Thread-Topic: [PATCH v16 13/22] PCI: dwc: Add EDMA_UNROLL capability flag
Thread-Index: AQHZgwfU/U4VorFzl0m5QO634KHRsq98OBCAgAF1tIA=
Date:   Tue, 6 Jun 2023 09:37:27 +0000
Message-ID: <TYBPR01MB53416102FD2D1236FF04EC35D852A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-14-yoshihiro.shimoda.uh@renesas.com>
 <20230605111541.sup6ebomse75iae2@mobilestation>
In-Reply-To: <20230605111541.sup6ebomse75iae2@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB11286:EE_
x-ms-office365-filtering-correlation-id: 1a750916-7333-4e8d-2cc8-08db6671a47c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rvIRuDdONbVygwUE3bQnOS/zw/fggqMuE8ygDkDZBIrT4J0Lje/CPcI/xII+86qGCDV1/qNUxWhcatWKtUorCp2VOyrKDTYKsypmoeiIcdOTL/03VjFOY7X/X3fM4GXZ4BcPzAlJR3UpP/8ZTPM/R8ubqFfyjKU1MH2ig8nmOaFTjPYuKvKBNymXIKEm1ErSL8fDZldhJ7ip2KQsHbbwPqTGp3NlvQO3NHdGzQ+/IOgTaRji6/wYqLH3YPOj5mbemnSlnT7luV4ODw7BKPCLh/MKEF3j6XwwaJ8tnaWF8LIHYq61h6qp98jqofrFTRseVnTqoNeXlU9GjSbRa3N4pGZGi290QOYBoGhM+zaBCMSRremAqOanEtcwNczjHA2nlrl5TetN/WOZing4GYWAszBpYyhC22xLdxBD2DYUxU2O2hwjfKEgNQqkQXSHFxqiw5hFRETjHJ+MPD5ikFflMsRhuqr280yJKBZnXwt/BfXR1GRxJtm1dnEfMQnWich7KvjxK+DbbZSgm02DTeIxzIdsys43JoO5+L4XqXsfidoFR303E0M1nt3d9PpLIxopdJe/DLq/FvK06QNkbqvroz+Jpz49xEhsvEdfd39pWGRHF1du22GQ7GFcyUhOI0tq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(9686003)(6506007)(38100700002)(41300700001)(7696005)(186003)(83380400001)(71200400001)(478600001)(54906003)(122000001)(66446008)(66556008)(64756008)(6916009)(66476007)(55016003)(76116006)(66946007)(316002)(7416002)(4326008)(5660300002)(8676002)(52536014)(8936002)(2906002)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?isNDtB1Y+QnVsFc/a4BD/GgtGWyznj5YCR8CVvQK2jjscc7SAOx3PnJDOOrm?=
 =?us-ascii?Q?CluVfNzQVpRHEq9AaVjVsFNR7muwKYAw3i6JblgvuKk508iiCCgspTT3p5Vs?=
 =?us-ascii?Q?b3IwlNDnJyOZ6WkXv3Y140whcqoZAjMojiTyFvZdLenDhG8ZcnMIFiCesfsc?=
 =?us-ascii?Q?hwYtek5fi4oW6QJ8+VvovQYL/y+2hN+4jmGrkFVMkiER6yeMJ+d+a/GYTOHf?=
 =?us-ascii?Q?fCYZ5HhJSyT/cmI/ndOR/OVmeqO4U6MPKhv1zFJK9zo+NM7GkvFUC1cGFJyQ?=
 =?us-ascii?Q?lF3sO4ujo2fNaKpvgeD7rK4KGUsL9C//wJ0jQExWWgV+4LoMgewUPPBHeK/Y?=
 =?us-ascii?Q?KRTCbvPUSWZypVKxx+7+RkH/P9En28bFrOl/NDurlqI1zVWC5AOBBNqyKdBS?=
 =?us-ascii?Q?ZMVzdHaJMRETUc5qtFu7YGsfPSvUYQq8wVJT1fOi05fCKGnI0ed++yOoQH9m?=
 =?us-ascii?Q?qcUpD8JDFx4k7ZNFDpBoFMbNCT/e9RIn+yXVc0kSkItoQfZaR/nhdfdVFv/O?=
 =?us-ascii?Q?xIzEA0HoYyYGSWJNku/JP+zDmgoHHCSba2csifZ1WvjcM0NMo2/eBsz1AQH3?=
 =?us-ascii?Q?sx5PGh65aA0Edb7IQzbUm5OWrS0mXQgnqWJgL3sepuuaeE+tmJ+f/zz0VUZ0?=
 =?us-ascii?Q?+nDBw0BgX/TaaeSwGRn0xidxstr1+Jgz3MDFnhIMImN1VFqRaIGevlyC7JNW?=
 =?us-ascii?Q?ATnCQu0h8/NXk7vq12YRwrsAr7zrBCUqdPBxaQ5yJsF194vD7sVHoIwMqHzH?=
 =?us-ascii?Q?S+EWhMyXPSE1jF0hcWpKoSecnb4KiZwNcRRCD4HKYBnKbpjfKv0T52VsIR9Y?=
 =?us-ascii?Q?n+neaLW4VClD6BUKZ57dvE8SjL0lniIulFaW0E5WnQ6sy+WjYq4Xeh9cFf7e?=
 =?us-ascii?Q?EKVcEcueroMh5kF5HtJSWhVU3SC6rPQj5Wk8p2hA5vhHXgS4xRqaGMfr2/iE?=
 =?us-ascii?Q?PbtU1JRjLX5WTr7zgfmze366NKMThd4oYpRBIqYLJcchcL7L6uEuh9512cvN?=
 =?us-ascii?Q?7+4SNlWkB0SFhyhHV3z+ka4JHZu46NT3j2XhN7Kgm6g65QqmbDGH7BTh6l1x?=
 =?us-ascii?Q?+LnwMAHpmWcdOckUvvznjSxNSTBrg/+O6lul8r54P8cr76ctwsvfESXnJ/ZZ?=
 =?us-ascii?Q?Qb9wxXzGIbf/y09hsvEYyEb6CXrJ3C6dh7Jh9WI44jNKpH/q+6w1PhlJnnKs?=
 =?us-ascii?Q?30t4ESZeTrpmOXXoAASiPNyj9cB06pvapGyukstH4FTNks3DjbaztESg8Mvd?=
 =?us-ascii?Q?oGQwMxEq68POUbkN+m8U5hIHgIdoO2PrQXSk48v5GK6jdfdPT//Q57BTM3J+?=
 =?us-ascii?Q?dKqSrnaULo9NELOgLEGTEyVcoUFiofI9OLeaUWaSlQNySKsKUKnMa4N3eK0E?=
 =?us-ascii?Q?MG/HSwrfPi/KszSy1LQsc7Bpt2+ea5mnRD1+IwOWYp6g+VmhcxGIV/ZAJvD5?=
 =?us-ascii?Q?jH1Z4365o+kRDFLxJ/rvQyzrbJuyV2h8Reyb6ntRfWmICL18EcqUQ4U1i5qc?=
 =?us-ascii?Q?vPcRZS0myjyxjBMLiDCtezwlgGxdz3muyZLykX2FdCur9e6LFVemKJ/6Ao4H?=
 =?us-ascii?Q?SDHe6ISY5Ix1TEZcjoJibi3XiVXCVkX/eKSsstuOLnkV/jM2MuWSqXujl2rD?=
 =?us-ascii?Q?dZbf29QatqOMaCIapmomp61SU27wqZJqrbl/jhh4vYXVDSnpcBtJk62vcd7h?=
 =?us-ascii?Q?0zDXgA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a750916-7333-4e8d-2cc8-08db6671a47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 09:37:27.9971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MP07YvxpU31N1tQj0m29W5oOBaMuqkOPp2qw4cXV4TwMLtVnkgnpmMVFkcPqYWuxCuwoeI1WUoH95w4+082jJ/t3JRLo3jmBjUSiup4yeZH9MUm/WzspXcPfWrdTKcOe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, June 5, 2023 8:16 PM
>=20
> On Wed, May 10, 2023 at 03:22:25PM +0900, Yoshihiro Shimoda wrote:
> > Renesas R-Car Gen4 PCIe controllers have an unexpected register value o=
n
> > the dbi+0x97b register. So, add a new capability flag "EDMA_UNROLL"
> > which would force the unrolled eDMA mapping for the problematic
> > device,
>=20
> > as suggested by Serge Semin.
>=20
> Drop this. Suggested-by tag already means that.

I got it.

> >
> > Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 8 +++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h | 5 +++--
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 8b2978c6eb23..e405bfae0191 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -881,8 +881,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *=
pci)
> >  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
> >  	 * thus no space is now reserved for the eDMA channels viewport and
> >  	 * former DMA CTRL register is no longer fixed to FFs.
> > +	 *
> > +	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
>=20
> > +	 * may have zeros in the eDMA CTRL register even though the HW-manual
>=20
> s/may have/have

I'll fix it.

> (your comment is about a particular device which for sure has the
> denoted problem.)

I understood it.

> Other than that the change looks good. Thanks!
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thank you very much for your review!

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +	 * explicitly states there must FFs if the unrolled mapping is enable=
d.
> > +	 * For such cases the low-level drivers are supposed to manually
> > +	 * activate the unrolled mapping to bypass the auto-detection procedu=
re.
> >  	 */
> > -	if (dw_pcie_ver_is_ge(pci, 540A))
> > +	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
> >  		val =3D 0xFFFFFFFF;
> >  	else
> >  		val =3D dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTR=
L);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 06e044e2163a..2639206b4c18 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -54,8 +54,9 @@
> >
> >  /* DWC PCIe controller capabilities */
> >  #define DW_PCIE_CAP_REQ_RES		0
> > -#define DW_PCIE_CAP_IATU_UNROLL		1
> > -#define DW_PCIE_CAP_CDM_CHECK		2
> > +#define DW_PCIE_CAP_EDMA_UNROLL		1
> > +#define DW_PCIE_CAP_IATU_UNROLL		2
> > +#define DW_PCIE_CAP_CDM_CHECK		3
> >
> >  #define dw_pcie_cap_is(_pci, _cap) \
> >  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> > --
> > 2.25.1
> >
