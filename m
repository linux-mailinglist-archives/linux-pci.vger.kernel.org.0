Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8B4723D56
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbjFFJ3A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjFFJ27 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 05:28:59 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42EE5F;
        Tue,  6 Jun 2023 02:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkDjtz6zzXk0Wc+rN6WooNH1ifWFQRUI9BrAZDT7H9/EUOWXgu4z+Q0aDffIOOhi/r1mR4b/Ji0uubeePaycpQoBpz+SrDSrytApoPVwEpdIkmMP1m1IErfQ8S9U1a5E+sZQIYkWmHtfRhy2tEjzBXF0KBpy7vCZPsql51lYUWozOuwtPGNrbxY2eQFUMGOBGozOwLnM1Pp4uJm8ZZ8ZBDCPMrs3nXX3Cse0kzpIEugzfqK04XlnxpvgAd8yXq4bAXtHOa3sRoRUgpndjkqrBviqoCopQbungWUcwLyDdfISdnyAZxf9dLQCh9Dh74WD8pFet2MV13wa0PBnNiCEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvcoB70J/QurM5A66y72xu32KICLcmKiT/rhwoAVh1s=;
 b=Uh4/+QyLQ6Eap8HvGUfyqvDHItvCdNoZhVLPmvLP+Oik9KGKlEmjC2qNe1S+5/UAOaz8sE69Z+YL+8Pe4AZBvWARS0IXiJ4ErG4YgomXNzxGTAeZtkgJZ9lEBEzuykcp1F9VAinBRLhMq12qpCjmBGVg+0HWo6dHTQqNDk9tttw2EN/+WsomeZTOskCya6LRZCtvkNGSXTA9fOQkTjrUl6MtSS1NtsGA/BlN1e0kHWl4GoRpb/0npKPFEeykWCt0jMx5B/QXqpdykjJexVIejkcHfyZ5fkHh9K+ogtdYfMX7WpE+/WmcVhbSCDeabAWw+s6q1miSxgm2dAU0pHJW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvcoB70J/QurM5A66y72xu32KICLcmKiT/rhwoAVh1s=;
 b=l7eXYAAKS/v4puZ9e5cd0A2Jc4L7tvLC/C0pCmNlh3C2FNE1Wg1P3TpHxvHcaNFaU5e7LjmDP7tXxMYGXNPnpIjo7Nm7bLJ8q2PEyTzuFS8ACdCUe0RORf/o0UH12NLNlCMGSanYJV0KzOjrL4zlyRljD0kbIWcpEhlGapyRLt0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB8808.jpnprd01.prod.outlook.com
 (2603:1096:400:167::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:28:55 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:28:55 +0000
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
Subject: RE: [PATCH v16 10/22] PCI: dwc: Modify PCIE_PORT_LINK_CONTROL
 handling
Thread-Topic: [PATCH v16 10/22] PCI: dwc: Modify PCIE_PORT_LINK_CONTROL
 handling
Thread-Index: AQHZgwfRIvGyi4exN022S1Uv63z/ta98MdQAgAF4aiA=
Date:   Tue, 6 Jun 2023 09:28:55 +0000
Message-ID: <TYBPR01MB5341D8166C735011795A369BD852A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-11-yoshihiro.shimoda.uh@renesas.com>
 <20230605105322.orc3rtgu5rr3ovot@mobilestation>
In-Reply-To: <20230605105322.orc3rtgu5rr3ovot@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB8808:EE_
x-ms-office365-filtering-correlation-id: 20e090f1-f9d3-4631-6dd1-08db667072fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiI29M1XHNtyJXApZqymR06dlHa0aAU4dr3DenYHtwQf69sUGcwC8ECP7ClEW67mVznK28KVVQRd9niVRbsyowgslNh9b1kd5LNVcI110sWWiXdH9Vnb8Dx11NojJ2AZDN1DcTuMe6aswq3UQ509SGYbnskZOH+E9Jouk5hGBW3Q8N7GpHBi3X7Bx8Is/+S+gTR+JZIyMzWEKo1dlFl4Gau+C5SRWE1MmthQQ4XONHDvEPP0HSddhyxyl8KRXA8Sbb+UXkGz75DAosnXSS5LRseZvRQ7pCyr2huiIxYj9gnKfB/J1vdhBFNWVf9O1m0k80HGJEJgYxpt/plV8Ydjo+EyeNRWndDsa9VpmuQMAzw7Su07zeWNgvn7az7fNXkf6gBb/qtIHzE0ixCv7tSBZSShTFJuB0SIvFwmvR1RNRRp//TPZXsv1Q3mWcaIVNFDxzlqipVQtWtGN/wydvvOyHpy65rKK3dsTTJ9/AOc6ei67S18Z6guYI6NZiJWRpoP9SJ6FXgaOQw86PwMjIwLniSBPa0zISUHo5O3AGrrll46jnohN4w+qy7uN3PUhyn354cB2JxyPXnMuEdOImv+S0kS4aFzeCWguHTzf3J/Qhxv7I9PaSBXeUXefNdhRZAJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(54906003)(71200400001)(478600001)(5660300002)(8936002)(52536014)(7416002)(86362001)(2906002)(38070700005)(8676002)(33656002)(122000001)(4326008)(66476007)(6916009)(66556008)(64756008)(66446008)(316002)(66946007)(55016003)(76116006)(38100700002)(83380400001)(41300700001)(6506007)(9686003)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bVLtye/Abp4VBVMkLeUYlDNTd5pM9yl5c9lVHskrgq49rf3WjGxFjc8zWSfA?=
 =?us-ascii?Q?pUmrCQeujMNYII0hFYImPDJ41XeAPZWmhIV0rf6dcaukZlXNlDU8y2yxIdy/?=
 =?us-ascii?Q?GdSoai3rQFyXc9sEPKkICSpzPIW+X0Ng/S6eT5OsXXA+/zdT1eEaZPNJLJWm?=
 =?us-ascii?Q?NEoFD7yIg2DccmGZGb3xn8j5MUuXEBHLExmV7gSOsLeCX7MQzfj3K0t7IPd4?=
 =?us-ascii?Q?RlY5X62sRz++q7v/sjKVbqaqMpbO94iwkqyrgaX4BkrsMII4dx1X8JdDIprS?=
 =?us-ascii?Q?PT8s4JDnVbRfHgXwYjnMJuH6FEZRpbvQ/JbznskBkPQNHpLoEzZ5RC/ScgAz?=
 =?us-ascii?Q?Pp32YX9jDuSGcfFE1/nIEM91WjhJrR5ldWQZy9EGQaGIHsFsbSDvCaUVYaJJ?=
 =?us-ascii?Q?mQhYiRj0dsvXjPsUg5R4bhMULKAKte8hkrqEBBOeGJ/USMhYF8EVn1t1s1Pr?=
 =?us-ascii?Q?1XUiwxH5SPwejLTGcR/HLqCUxXJizG3pFKVVXS8hV1YIyKXX91/0BoKaE5sd?=
 =?us-ascii?Q?BohIQRldBpRwP6d6dvgPPiAupKniKzdXW3Q4H0HEGGAi+3h64dELH4Ac4eOZ?=
 =?us-ascii?Q?JBJ7OKVg+jZxVOmq1HasO1Cwp2gvCTatsIqdh6diTa6lMALd2xmpVbA8b1Y3?=
 =?us-ascii?Q?yohkp+4FbN2RLDJgQCHRHNvu1weeWB4hCW9AxPI7tXJyxjShGnMR1a5vRsai?=
 =?us-ascii?Q?3wMfQzDOGdoHnQtjSZmmaXrZfFtgLuH67e+wQmjzQVzPJSe439gapnkBmxaU?=
 =?us-ascii?Q?lqxTgZ+NI6Kanh1mBQ7isvpploDNE0mGjkrzZZMg0UWNnRXawSI1MFdlpUlz?=
 =?us-ascii?Q?Rcf33RMd9yo3KOO3CAPRN/c9gdS47ruB+ysN8vhywdp7Slvn0RuC5NsZf8qa?=
 =?us-ascii?Q?BeR3YK6B6b4zmqjcqVMBtHH8y+N8tNuqzkLvPBK/m4Lbz9OSQTDNcz0FuB2K?=
 =?us-ascii?Q?RxjOR3vKcpjoDktudy82mGmE90DAJoAycWVPMP8fp3A5/ldxWWIFXTZThXJp?=
 =?us-ascii?Q?wrrw1+DWJ4JyY45yluGZGKzOuvgH++ZLGphV39OUPu4qhj58WUNbvImnUZgc?=
 =?us-ascii?Q?27dHh2L9C8qyIA3N6K8W17iEF4HDvHLCfo32TQPUHmZ3evFjDAUuES9bmQg5?=
 =?us-ascii?Q?PFXH3pka1FTFEKG7MXfki+GqS7fU+BdQc7+nvJyj331Mei9vF4djN4KsiAT6?=
 =?us-ascii?Q?I64SOYP99OGFz5eB/u3Z6zIDn2p8VK/py+9mQ5Guwytnznp8yaCEjNW/TwAg?=
 =?us-ascii?Q?qTVUJvIwR1qP5F0yxlLIAsO/lSg8CvObhjVV+EOO9UGX0ZBRNEnKSC2UrDw6?=
 =?us-ascii?Q?u7ZomlayoMYMtEi76WjqUSqQY8YZIYK1uhKixoIdaAwoJeIu+eKRILXWVkoV?=
 =?us-ascii?Q?CnJ1FRQsTIL0u6Syb/KVhvPkXNKAM9mGIrcxYw9aRVVnRhAQN47TYfAygVor?=
 =?us-ascii?Q?fZ1cRZ8kNpxtnGYWcIM5ceWvDsbwAa0hnAOLEN7WIfwvvsRwvnJvispZFLMy?=
 =?us-ascii?Q?+z30aQKfDftZrBY5zvQGuY6x5AbaVmNsPY3IbtgkmwgfXcohdGLnWAn8lElp?=
 =?us-ascii?Q?c8DOcroVYk0unAa7vHj7FccNClVhbGqgdOl9VBg4DY1vcFfW03HRbGLVHYPJ?=
 =?us-ascii?Q?frGY5Uv+AtFRS21VDo5N34CzRXjpRFIZGYB0jl9q7aq8EQRVdN5wc4SSZmQV?=
 =?us-ascii?Q?B+SdFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e090f1-f9d3-4631-6dd1-08db667072fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 09:28:55.4254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+REyvH8ZOs9F7If94nzC4hT2E/6qsakC+J+kOfRgxW1H+znrerRYC8maDq5lG0Jlz7PPS8kqPNDeOq+ONjST8uDSLhU5F6VnhZ7jebTDqSXdjmlgdYHQuO+u0UUnEiu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8808
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

> From: Serge Semin, Sent: Monday, June 5, 2023 7:53 PM
>=20
> On Wed, May 10, 2023 at 03:22:22PM +0900, Yoshihiro Shimoda wrote:
> > To improve code readability, modify PCIE_PORT_LINK_CONTROL handling.
>=20
> So basically you are doing the same update as in the Patch 9:
> detaching the already implemented link width setups into a separate
> method. Why do you split them up into the incremental updates?

I thought that splitting them was review-friendly. But, it's wrong...

> Just
> squash this patch into the patch 9. The resultant patch would be an
> atomic update and a preparation before adding the PCI_EXP_LNKCAP field
> update. The later would lead to the fully coherent maximum link width
> setup method in accordance with the DW PCIe hardware manual.

I got it.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 40 +++++++-------------
> >  1 file changed, 13 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 68aefbbcd68c..5dc423dd2f21 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -721,28 +721,40 @@ static void dw_pcie_link_set_max_speed(struct dw_=
pcie *pci, u32 link_gen)
> >
> >  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 n=
um_lanes)
> >  {
> > -	u32 lwsc;
> > +	u32 lwsc, plc;
> >
> >  	if (!num_lanes)
> >  		return;
> >
> > +	/* Set the number of lanes */
> > +	plc =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > +	plc &=3D ~PORT_LINK_MODE_MASK;
> > +
> >  	/* Set link width speed control register */
> >  	lwsc =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> >  	lwsc &=3D ~PORT_LOGIC_LINK_WIDTH_MASK;
> >  	switch (num_lanes) {
> >  	case 1:
> > +		plc |=3D PORT_LINK_MODE_1_LANES;
> >  		lwsc |=3D PORT_LOGIC_LINK_WIDTH_1_LANES;
> >  		break;
> >  	case 2:
> > +		plc |=3D PORT_LINK_MODE_2_LANES;
> >  		lwsc |=3D PORT_LOGIC_LINK_WIDTH_2_LANES;
> >  		break;
> >  	case 4:
> > +		plc |=3D PORT_LINK_MODE_4_LANES;
> >  		lwsc |=3D PORT_LOGIC_LINK_WIDTH_4_LANES;
> >  		break;
> >  	case 8:
> > +		plc |=3D PORT_LINK_MODE_8_LANES;
> >  		lwsc |=3D PORT_LOGIC_LINK_WIDTH_8_LANES;
> >  		break;
> > +	default:
> > +		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
> > +		return;
> >  	}
> > +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> >  }
> >
> > @@ -1027,31 +1039,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  	val |=3D PORT_LINK_DLL_LINK_EN;
> >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> >
> > -	if (!pci->num_lanes) {
> > -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > -		return;
> > -	}
> > -
> > -	/* Set the number of lanes */
> > -	val &=3D ~PORT_LINK_MODE_MASK;
> > -	switch (pci->num_lanes) {
> > -	case 1:
> > -		val |=3D PORT_LINK_MODE_1_LANES;
> > -		break;
> > -	case 2:
> > -		val |=3D PORT_LINK_MODE_2_LANES;
> > -		break;
> > -	case 4:
> > -		val |=3D PORT_LINK_MODE_4_LANES;
> > -		break;
> > -	case 8:
> > -		val |=3D PORT_LINK_MODE_8_LANES;
> > -		break;
> > -	default:
> > -		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
> > -		return;
> > -	}
> > -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > -
> >  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> >  }
> > --
> > 2.25.1
> >
