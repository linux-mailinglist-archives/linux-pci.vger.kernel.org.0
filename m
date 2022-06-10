Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3140546047
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348343AbiFJIs4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348283AbiFJIr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:47:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754254F90;
        Fri, 10 Jun 2022 01:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b20ixY+SUTI4x3n8XiXNPgGGX9m606UJHSP9Irav7U56woFUxhdfxg4NLVAxhVoU5HIC5k2FrEwoKddJNsJFDVzzF1SrE3Eb4swXTBGyLxgi+8et17cWeKAHasAsjswR84FUyBnTGyeeOF3KPJef+6Av9BvcpioGPrWcH7ufy3ZQOOefc7J9EbYyOSqRuecf0QfPX5AvFQxcqecw7EX+Sdp5uYIDA/S5f3uydJCg2h6NJzGtFbsBVXpBLDwATN4rDOy1e00NcY9tUNUbm2Y21aUgN32NeagyGTnsFarVDl763sBnKh7A+aJyj831IOOXi1PB5ZQG4qy8unMXokU2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CswBTp/3De9I3mBZzaMMzAH7wAz/XwokV++BT376T7c=;
 b=ZIctDRVPlSKXV9fGqCVEACd8Qjx0TEP1/DRG3RQ5+3tK229NantOeRpjNeidvzLzjAWpncCW0Gr7W018gpS2Qg15rF/i+eTh5Oasvvii5sZ3x6CEk21Jp5CH1gwP9KwtLwXgowl7FsALj4KhhRuFkBu9THYHIP9oW2MuSAWF8ErwdOHopAJgjGsiFDM1ibvTB7Fydg9JASZaoArPGC5skLjp9XIc6Hqdmpw9qySb2rTcS6Q0RE98AJYl4XhpeipsDMkKfQK72fqxX3S8khtHFM5uMOr2vf3orFGi/mY/hb5PGUvZuopPoO+egek27DyO4l22LcFCdaruSfNWx/cSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CswBTp/3De9I3mBZzaMMzAH7wAz/XwokV++BT376T7c=;
 b=VQscvN8M0c5gt3hqrRyEaI1Q2+yocV5ON44TjiYfLqKwEE0KDmU8c2c0ozjR7QG6RyEij5EqLbSGYYXJK3B1edda3UqPUo5/UyRAlcCw7Gks9dCpK0hpqzC9Sm+3aK7vgYqIoyUARWngNXwaiDYOwmqxf4Hz2tpvxM/VisPu4SU=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by CO6PR02MB7825.namprd02.prod.outlook.com (2603:10b6:303:b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 08:47:43 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88%9]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 08:47:42 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Thread-Topic: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port
Thread-Index: AQHYe1aa0KIWTujVEEyCPx8mQaEs/q1F4U+AgAJ1SlA=
Date:   Fri, 10 Jun 2022 08:47:41 +0000
Message-ID: <BY5PR02MB69470346E9E634F6C699FB95A5A69@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220608164046.3474-3-bharat.kumar.gogada@xilinx.com>
 <20220608191437.GA411770@bhelgaas>
In-Reply-To: <20220608191437.GA411770@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b453b6b-dc20-47ae-3962-08da4abde197
x-ms-traffictypediagnostic: CO6PR02MB7825:EE_
x-microsoft-antispam-prvs: <CO6PR02MB782579440FC33FEFCE600DBEA5A69@CO6PR02MB7825.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAMMOyKm0xh5yWvqAm68iP92S1lNVQQm3LZzLz+1XvTkltDDk6q8NR7lat3OmKdSnLRLbwWVK5SqbzTtHLWtvdUN/UorD5RBTLpZEOIygX1v4giceYskJ1L6SqHQb0ZVtgw/2p7GD0KsjqCCpt7JggAtxNtw9QKC+4vBa9JX1azA+d5/Gbw3WJ1zuYwP46WPYtEAvDcS5Ve74m91GYCQauhQu08qj99WhZf5V+/BN3id6H8BFyvAFHV38rZOwKwI6Kxj8hXH/XL+FnVV30u9qPjVmjkDeVr2AvD7/ZYV5jjwZqVpUaiPF0vKennwM/BHqLBB7+ScOFwccPZrq5gZxmR6mCCDYBCND/rB8hGFwNpjeROAbIHN7vKW7azfY2BPcVQ8Nj1zwNxNZ/CEvM/V2W1mD3/i3YaWr91Ef326JQWXGA2MTYF8Neayi/8CKvme+kWss9C44JJ5lhVUH1YgXI0dpGjkQ3hZZPT+3mRAVzlsaZi3P25IFlapGdcV5AdsCRID7uJn/pkHRQrnLntmVDcayxUBdJT+l5wDiUDQWDOZyjNz0FMtp+IpSOUAObslIVI99hT5AZkdQBP1oyhr3jrv1f/KIn+F79ydOjlOvc+l55dIzNSVQPj1rZCdpvVvBj4TbpaKtuiKJl9tyLWyFn9jsxm9kxw6I/6881JDGCoeJCe/vi+v72U3zxx0xZPimq9hhLhI5fp4AHaFy4nDOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(55016003)(52536014)(508600001)(122000001)(2906002)(71200400001)(38100700002)(38070700005)(86362001)(26005)(186003)(83380400001)(9686003)(66946007)(76116006)(4326008)(64756008)(8676002)(66476007)(6916009)(54906003)(66556008)(55236004)(33656002)(66446008)(7696005)(316002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M0VGmjyjMRB5H4o/9sMMJeYa/VJwaR7EeQSypklEFhFG3tv2fRVHRocDkfRm?=
 =?us-ascii?Q?MFRcc6ZvIEPY5kmGYmn/xhz0kYByvteXE9bo3mnEHgR4TNs990ZHJ33aOdBM?=
 =?us-ascii?Q?R16/HCx4iqPrdWz4qJuWP+6XSonHHWg+y4RPRD2UJ3bduEqM4MvneefCVIri?=
 =?us-ascii?Q?aVkGpfLr2LbVdgX7RogGLfycNRRPBorXynOuFmKGrQsQHYvacWL+QB8qgH9T?=
 =?us-ascii?Q?wX7Pj95skKv8moz6nE3UqchmSaSxO0E3P0ifjpdHu6Ps8qi4Cxz3ye2NcB5A?=
 =?us-ascii?Q?x2FBPufrEWBfBfQLv07+KbtfD5yGYG0nYQ08cS6gOBNmuSKZKMxGGIp2nRRM?=
 =?us-ascii?Q?fyI7OC6QBujsmow8pcJ802oz7ww0CjsrTDefpFiV3HayI3J+3bpmhRFg5P+z?=
 =?us-ascii?Q?85HVhtJgmN2+T0sqsCVPrzrhflNEqh2ufzmtIFcVtjgpyeklCzZgWbEX/ujr?=
 =?us-ascii?Q?7QV3AQ2xVE75KRDsYqR9IjszoDnBCV3/vuFeVtVibtF/Phu+D+SHKHInSW8U?=
 =?us-ascii?Q?IauaCCXo18nyJtj29Hy7yopP0bqAK20pAXhuc9IjSU1NbKeRlBHcMv4ZTkOB?=
 =?us-ascii?Q?eCAZxfGZZWt8L2993MVG447R2ccUWGNMkHMN4sk4hZ9TVQrEHw9nLTtUpKuW?=
 =?us-ascii?Q?yd4uSHUNcKpCAJ1fVW9rbE2kjTlzLBnUGwq+shSBNL509enM3xp1cdCYtQpr?=
 =?us-ascii?Q?lm/cv5jTBHXM2Sp/hZUiggtLWUrS4K8bIxJSxEEYN+ImFPBj6dSqom6Xz/FO?=
 =?us-ascii?Q?PaxAP8YkohscsQK2LlMfFXfBMZiq2Vmfk5MOdxa/oQYWuK43rhJ0Z9epTZ4u?=
 =?us-ascii?Q?ZpGUT74VMqDiYRc5rUkAVLfMCn8+yUvOj+oXqIFlIMYC6tIO64Qd77Hz1aaB?=
 =?us-ascii?Q?+Ds4Xf7v11tTbNQf8EITL6JV1HpB5h/61HmDsK3mMTATi24U3mGzDMcJK70q?=
 =?us-ascii?Q?mIJSdJzfyFgOOlt/I/UThpBVnb6IaccYYXagORWn2svjsR8NQjWx+M1fe+Yv?=
 =?us-ascii?Q?qYOa3Oc+g8/C1PYd2t4W3fLhKl8FIPnQAMfOzViC1Qxh7ZYAB1pG5KJtDhcB?=
 =?us-ascii?Q?pC2A79XUXJZqhXVTbbp+AOmEe0khLLaK2P7WRdFpHqfMUoXF05sowSowQmCj?=
 =?us-ascii?Q?p+CABlACmBpJd2DeZ8/qUVWma6yzZpWUKCqkkJnZ3jy8JmUxpaQIC3BDvLxQ?=
 =?us-ascii?Q?UwStgo9UMd8D2ESD0W2Bz5OnKwPImRzCHygTeiXDjlIRF9z2QmMSjs2ssPO+?=
 =?us-ascii?Q?MhLUV9ofItI0E9k/InRjnl1oozC0h+BZqSQb5UP2RgCCKUMzvvtTcAlryV9u?=
 =?us-ascii?Q?irxPWHb1BFJ6WSQF3dRVvwReW7iw+u6PuL0BWOGnrNa5URmFsd3Ui6Cfl4LP?=
 =?us-ascii?Q?QcpyL2X/rm8lMWRNz5xqA0zxXYm7Ol6UV1gtb7qzLhH0i7fVhJYFmbxJMcD2?=
 =?us-ascii?Q?D3PsVlMO4thuvuekNbm3ovfom+H+n8eGK0k9cLfUvOBMxZn4q6bbvSwlW5VU?=
 =?us-ascii?Q?8mvlWYDWHxDotLq5z9nEBwKz6zBAl5FdzJGH1GZC+gZHQi7fF+xDnUxez8fe?=
 =?us-ascii?Q?Ry7m38zVmCcoFYJXJz3nASZAfm5Q3TNuy96GCz4J2W2fVoXNLiG6Ov1OAbIY?=
 =?us-ascii?Q?sNOb8BvUqN1eFwF4xRMpPhkZHqfyaUDT3hsLd4ZBFtGW5FJEt++b28i0Hcl9?=
 =?us-ascii?Q?EaqZ/rJ0AztLviRwXBd+A91DsLVvtUrcOv5Oa8TPNdamXPnq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b453b6b-dc20-47ae-3962-08da4abde197
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 08:47:42.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkzTpLSE+q7bMXAP5drrrk30xytBspRRp6uDeI6cAk0bYesekX87wQoLqYnu/hWshjqk1AKUf2Ox6ht1mC+JvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7825
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> On Wed, Jun 08, 2022 at 10:10:46PM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > functioning at Gen5 speed.
> >
> > Xilinx Versal CPM5 has few changes with existing CPM block.
> > - CPM5 has dedicated register space for control and status registers.
> > - CPM5 legacy interrupt handling needs additional register bit
> >   to enable and handle legacy interrupts.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-cpm.c | 33
> > +++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> Per MAINTAINERS, xilinx-cpm lacks a maintainer.  Can we get one?
>=20
> > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> > b/drivers/pci/controller/pcie-xilinx-cpm.c
> > index c7cd44ed4dfc..a3b04083b6b3 100644
> > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > @@ -35,6 +35,10 @@
> >  #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
> >  #define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
> >
> > +#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
> > +#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
> > +#define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)
> > +
> >  /* Interrupt registers definitions */
> >  #define XILINX_CPM_PCIE_INTR_LINK_DOWN		0
> >  #define XILINX_CPM_PCIE_INTR_HOT_RESET		3
> > @@ -109,6 +113,7 @@
> >   * @intx_irq: legacy interrupt number
> >   * @irq: Error interrupt number
> >   * @lock: lock protecting shared register access
> > + * @is_cpm5: value to check cpm version
>=20
> s/cpm version/CPM version/ to match commit log usage.
>=20
> > +	port->is_cpm5 =3D of_device_is_compatible(dev->of_node,
> > +						"xlnx,versal-cpm5-host");
>=20
> One use of of_device_is_compatible() is OK, I guess, but
> of_device_get_match_data() is a better pattern if we ever need more.
>=20
> I would lean toward of_device_get_match_data() even here, just to reduce
> the number of ways to identify device-specific things across drivers.
>=20
Thanks Bjorn, will add this change in next patch.

Regards,
bharat
