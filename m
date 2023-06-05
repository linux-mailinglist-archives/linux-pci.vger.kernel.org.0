Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3E721BD2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 04:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjFECKY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Jun 2023 22:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjFECKX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Jun 2023 22:10:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96219AD;
        Sun,  4 Jun 2023 19:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by7twbw04CI/5hdvWoUObu5mPqcRcLkXVJuY1Zwqthov9tSy1jZ+UMT3ZyVM6+A/XxC7lC4FtRKPBZBsQTlt/5awaRfGWTdZqBbcN/m9LGxhA/SxgZEO9vydLB7Zu/0pzAwh7JP+/lZTHRLemtpXFgXdmiAWNXaiZpq65UJae8OJA/reYjfkux5kgt3P+2zCUJJ1Gyvhox3vWz+e20Y7wj5Ibtb5vwXNGz4aGd1l/K2zK/xoIe8NXRNl+sX3rUdkhqkdzJMbyZ/zEgwl8gXSqYloKuYFsdWDov2WRjkqkgitK0YkH6Ae7IIhmV9kdYm14ApOve/h0ppyWXMFguVXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XNsdFL7qZGMbQKDYOz7oi3GrfIWo6HNN2mAqZBE/qI=;
 b=gBoBXn5en+T9950JRvAERc8wOEEHkb6wvfRJyAPqaa8pJrLT38a/Hyv157Kh0WQgsVYW9spSj92nzaY+JUGGqUbJtgh/VNaE+FOU5zonlowImwwlfx3VQMqz8X+ofYzoOd8Cd1VnxCpIhYARLiVH5/EA8FdU1k9lCD42amAtz8JbDeTz3CC0RKbY4/2/iBcL6x2T0qj49zRPIaUacyRl4VpcNSkBaBhfrgE9vlWWFXV1hob/O0XvZdjmzTbS5uSdZeU767l9NWz0M2xouY6bjh1+J8QZKOtX1U3jbgeaCfyL9Awkt90CeDvBTHJpViOPBDSTbeWXCI7NwXro/oSZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XNsdFL7qZGMbQKDYOz7oi3GrfIWo6HNN2mAqZBE/qI=;
 b=dC79KWTKIVYuB2CrVR5xF9jUKv/4vzW7ZBab5CLAPqcJambnqRfuDh1AF9ncMHu86cXHMYpNH18OnVkA5mrmy5hhkSOGUKXyBvZ4I3gNldpNmzA+83xSueSMHVbl0+yX686v3rT/kYJoOz/l1nPB19Y0nURwPtvkFG7J3kCXI2w=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY1PR01MB10706.jpnprd01.prod.outlook.com
 (2603:1096:400:31d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 02:10:15 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::711d:f870:2e08:b6e1%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 02:10:14 +0000
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
Subject: RE: [PATCH v16 03/22] PCI: Add INTx Mechanism Messages macros
Thread-Topic: [PATCH v16 03/22] PCI: Add INTx Mechanism Messages macros
Thread-Index: AQHZgwfRbUDY2yQ+f0ON87x4/4GBmq97bKgAgAAysCA=
Date:   Mon, 5 Jun 2023 02:10:14 +0000
Message-ID: <TYBPR01MB5341BD012D7BE2390CBA2075D84DA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-4-yoshihiro.shimoda.uh@renesas.com>
 <20230604230740.criuymkykrq54oln@mobilestation>
In-Reply-To: <20230604230740.criuymkykrq54oln@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY1PR01MB10706:EE_
x-ms-office365-filtering-correlation-id: be5272fc-050b-4aa4-2eb0-08db656a004d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxPHEZSgU/Ws8MLXYeT+UAWOJtBmWSUlen3zWbWekCdXywpk2eUL7CuDwOuubm6SmQ+NS8YCSLqbSs8NeNWWO/ysra9JB69ILUwv2/nGpdhy7rfHryrB1HY+KmuaIJ8F0Sz1YaomJ3c05YctcJv3EJqlgkgX3zeeKl1Fsefef7p36J5PSGcPgZbbcXLpok3f2TYhZ/mKxL33UjyXsET7ujH97hwBwOIYOM6LLGebZwdMM73FoawtFQgcKe5wdJWfihiqFF0PRKKOiKjOFK7Aig3N/GoJtRkjQaUPzMr/zQFCXTM9whZ22k3UnX+S0+Tmd0hVvLay8OgWRyPfxgpak8uNBENx50BkOLE2csdrtHEhNU4keG5+95+q3k2UrqRZQGMJujeEmHd27FGOZtj/qcFbPcokYYoErJPGwMJAunBVgEQNIAUnOyIuzDt1kJ1tFjOsMuVAhDnqfvjGmFPPcJVm92ViTNJofJ0YlatwOwvC9+LbdeHbo4UfZ3L8wd54JQC9t1iLEuk0Ds9ATqsOyb70pQKTgtpAY7aeT39wtpitlXNvI5qMpyNHvSlmIBkeZhq7N3ag07dFL8/JFRXGqHI8lG6CD4aOEBROLK+mT8tG2UqLR/m6Y+Na50Gcx+wS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(15650500001)(478600001)(2906002)(71200400001)(7696005)(33656002)(38070700005)(83380400001)(6506007)(9686003)(86362001)(186003)(122000001)(38100700002)(55016003)(52536014)(5660300002)(8936002)(8676002)(41300700001)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(316002)(110136005)(7416002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sTts/i2PVRtrYKo+SIyUhSkfeceBTC+bfOWFqVBZ+lDKrSU0gDMVyyga3RNF?=
 =?us-ascii?Q?t9gV8mGPR3xoWgo/iK6YHDKooMtpj0bqBuwz0PGqFNvaac9yEeTCMdAqXQ0j?=
 =?us-ascii?Q?O037YJkV00RWmeR6wODOZcFt6p7XNC0miZ/i/9l81odQBusagw5RbqjxQMJt?=
 =?us-ascii?Q?J3jQHIMFaqo/ueWOL+RWn+HaQjAxjr3rwETLE/tc290Ay02yS/ufw/g8kohs?=
 =?us-ascii?Q?6iJp1i/5dUsekBh30rZTxcJq9V0z653KqJOK48XGjCpINelupDc1CQF/BAXB?=
 =?us-ascii?Q?buLZKf5ytBIOmc/gOGIO2ME6ZXfi3IaOuRnyrch/aQ8yLQXQtrgz7YSMe40G?=
 =?us-ascii?Q?IjhwCEOUDtxPFozhExwQ4CgcW0DqUq+qGsFhZ5y/TIdxPmF+ERCRfWVD/86/?=
 =?us-ascii?Q?fR5xgGaivrXV9k/QVn6rdIelGP+2hyqKSZpyDFnZ+lDxAh7li8Hxlhp9Hbrx?=
 =?us-ascii?Q?YNNkdZVJmI55v4MS5P9ZTkkphU42Ot56VU5xc7PajQYCuchCYqxamENbKOWS?=
 =?us-ascii?Q?8nwoo+f6AsYaQ1V5Ipn6VnQ2Oowgycf8bK+Ib+qxdD6sdJB8EX4agGdDtMJJ?=
 =?us-ascii?Q?qs47pY4BqsufjtIsmyRotVh4b8UetEIiqSpTOzk8H/tf+ifAq/VVqaaIeVIN?=
 =?us-ascii?Q?t9E+fbRkeh3GzZbxgqGDHwlz8bf6/Rfn8YeQ2Hjm8uNdpvBcu2eoquGtwEV6?=
 =?us-ascii?Q?pF3tG3SrlXH5gEIoH5EpKrgd/VMc+XS/h0m11OhtvbIkdcMxJap/7+y/KXyS?=
 =?us-ascii?Q?BNVO470v8G7GZ6ksjO27XaNlUQqNlRQy1uzn5D8xsgJmuqu+Q0n4jccbShHS?=
 =?us-ascii?Q?Mzq93UWVWzrriu2Tf/I0tcYi3rndyZWCjCWsnZ/VqsVfgJSZw41bT/cWv1zX?=
 =?us-ascii?Q?Kp75U2hvFzPZ5x2s6YgBpGePLRCvW1qvi73TU/b8Wu+bwy0sdY43ZWDycOuh?=
 =?us-ascii?Q?oy/9oZkt+FtRBpgPLTywBYkbD1HHuVCK3LJIj0nSeL+5JYhrCLVKkYsfTOyo?=
 =?us-ascii?Q?qm/NZRBEKeYtZsxjyY+ALq7F7KEwA8Y/m+iu00OUrpoZ6S3mRQ5tH4BS5ZfO?=
 =?us-ascii?Q?6a5eMug/5ANE4oEfFdJfYT20+QTWweeM70p0SMBZmcpLmAdJDFrocN/ZCC7P?=
 =?us-ascii?Q?/qOk98V9SL+WNbhN2/wDLnI9/2ZpIYJ72JHo9CVkD9XkZvhOHg9NILsFTj+r?=
 =?us-ascii?Q?Dc/cUQQewxnNLR3ietfIe4FUY/y1wer5ZNIQ9Ta8jE+MRF3hz4dI6GThDFqr?=
 =?us-ascii?Q?FXnlPsAArPiwZuhmywUu3+52BBYVfyff5boG5e/opX2i9a9TLJUIci/YXApx?=
 =?us-ascii?Q?Sb0uE85qhce36A0TAtAy6MJFRgroe7MW6RXNjKwbgLS2w7b514o+Oz1vo8KW?=
 =?us-ascii?Q?COVQBKFYsoWk4Zsf1+ast18s/gjtqS8/7xOSidhHJjDVtY+sgTPQZZRqH7nA?=
 =?us-ascii?Q?Xw+GvIIQzBDrX4gQqEG9H2PUonMSvIkB3ICkYRwuiLM+iBIL0ml5YXsc6x3c?=
 =?us-ascii?Q?54LzF9EzWco0kJkcF/F1BC/QjODEVCDdKsH2mDlb5Riwm5rHQcX5MHxEPTpo?=
 =?us-ascii?Q?1vc2wlfftRA1Zq1TCur9SKGBh3nMfn2ZgZQD0ACtTT4CVAEZrNK6pc6+F5rB?=
 =?us-ascii?Q?K8XNIxqHaLQev5u5yDlrT7JSfNDjvBjQAZV91bBQ6Aqd2s11GpHN5FTCLlBy?=
 =?us-ascii?Q?0Zrixg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5272fc-050b-4aa4-2eb0-08db656a004d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 02:10:14.9015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z14x7YOMwRrD+4k0DRQkawYQu2z+xV7gd0QpUAeM/Rb655g2Obvf+So3Q10j7ByW2erm2DrKTHHo6e2VcTZrnxElOSi5s+oNSzh+p3UwT6BVBFsRqylp3wmTOpUKe7oQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10706
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

> From: Serge Semin, Sent: Monday, June 5, 2023 8:08 AM
>=20
> On Wed, May 10, 2023 at 03:22:15PM +0900, Yoshihiro Shimoda wrote:
> > Add "Message Routing" and "INTx Mechanism Messages" macros to send
> > a message by a PCIe driver.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/pci.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 2475098f6518..67badc40e90b 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -11,6 +11,24 @@
> >
> >  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> >
>=20
> > +/* Message Routing */
>=20
> Call it "Implicit Message Routing (r[2:0])" as per the specification.

I got it.

> > +#define PCI_MSG_ROUTING_RC	0
> > +#define PCI_MSG_ROUTING_ADDR	1
> > +#define PCI_MSG_ROUTING_ID	2
> > +#define PCI_MSG_ROUTING_BC	3
> > +#define PCI_MSG_ROUTING_LOCAL	4
> > +#define PCI_MSG_ROUTING_GATHER	5
>=20
> IMO prefix like this PCI_MSG_TYPE_R_{RC,ADDR,ID,BC,...} would be a bit
> better since it would indicate that this routing flags are a sub-field of
> the Message Type field. Bjorn?

I got it. I'll rename them.

> > +
> > +/* INTx Mechanism Messages */
> > +#define PCI_CODE_ASSERT_INTA	0x20
> > +#define PCI_CODE_ASSERT_INTB	0x21
> > +#define PCI_CODE_ASSERT_INTC	0x22
> > +#define PCI_CODE_ASSERT_INTD	0x23
> > +#define PCI_CODE_DEASSERT_INTA	0x24
> > +#define PCI_CODE_DEASSERT_INTB	0x25
> > +#define PCI_CODE_DEASSERT_INTC	0x26
> > +#define PCI_CODE_DEASSERT_INTD	0x27
>=20
> IMO Prefix PCI_MSG_CODE_... would be a bit more descriptive since per
> the specification the respective message field is called "Message
> Code" and not just "Code". Bjorn?

I got it. I'll rename them.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +
> >  extern const unsigned char pcie_link_speed[];
> >  extern bool pci_early_dump;
> >
> > --
> > 2.25.1
> >
