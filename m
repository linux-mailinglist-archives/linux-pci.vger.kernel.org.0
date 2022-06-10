Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D954607C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 10:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347744AbiFJIu0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 04:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348365AbiFJIuN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 04:50:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F42A1ACE76;
        Fri, 10 Jun 2022 01:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ge9TT69oLV76YB1TkZeMV42txQpr1Z2+6hK+iZSd8m7FeD8o7v8OgCquxZty/1GSUInHnxloJz45dIjavVWf1K1TttHMnZ7TD4+vZeADS9NgL3sC8psGRG6koTBgjqHExjkwdobIVLSS6269vY3O58E+JTLkpudClg5P0S7itR5UVYCPM1z90qTSHW/MhVERv+0rR7S7eSPwnD8uwhZklZivZDSl9kgHJ5lWZ3YihWolPmO466PIP68QpdtrhjhNzP86G3Whkl91H3b+rr7Y/lyP0es2PNvpaRLfhh+/YUPmeJP6jkl52uc4MBvnMs4YpL4K6H86NIDRIYCDbZ6MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyGQecI5wqvqWkOiLH3ineqPveGXqrV7Mblj0s/Rv6U=;
 b=UtX+Li+ruSEIloeK3m+K6z9ypSkKd9qTSBRq7HXL2WUl4mesZgDDRXwihm1kCYDOZvdvu4dhfIGIxnlbEVhJXTqqyDRJvST+uw82H/fZCkX8+1xo2OlJRy8oTRH6Tn06MfUYuZ2aMYrjvbUETkStA1mPWGm2Kftp1wy2Su0m/znccLHaJzFG7pxqZg/U5/rtUmQC1n3QkOqgFKxC0E1f0ogQbv2y+B3MYZdWMUbI6Bcg/FSUjkVjoHjN4jF1hZagbEYGnq4wFg7/l9jLmVFXMBifxasLTY797z4jinEMvd8kIqcQnxXNSycaiMQOtnFjsQpbyv1ieNkIj6ZVleRp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyGQecI5wqvqWkOiLH3ineqPveGXqrV7Mblj0s/Rv6U=;
 b=KxvtNVmTnMHAs9gJkqE7cVO1p0S7L/sbGLnHvZ2CFkmN9RBsiLKZYYAnObP4Yv02Gg7VH/YtRPV7smzihbIJ2OJ5gjWN6Q9YaxaGHrTphZa4ecmi4sYewAfkbPAwgRIFSQnIhHQMD3+y3QZF4TW8pLYRY2YbufFB/axa3TtraNM=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by BYAPR02MB5366.namprd02.prod.outlook.com (2603:10b6:a03:65::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Fri, 10 Jun
 2022 08:50:08 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88%9]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 08:50:07 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root
 Port
Thread-Topic: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Thread-Index: AQHYe1aUovnAhRDa9kGWI7WlN6nEm61HlAuAgADDS8A=
Date:   Fri, 10 Jun 2022 08:50:07 +0000
Message-ID: <BY5PR02MB69477D4EDA359F6C6E249337A5A69@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220608164046.3474-1-bharat.kumar.gogada@xilinx.com>
 <20220608164046.3474-2-bharat.kumar.gogada@xilinx.com>
 <20220609211035.GA102003-robh@kernel.org>
In-Reply-To: <20220609211035.GA102003-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce9661ec-bd91-4c3a-ffed-08da4abe3878
x-ms-traffictypediagnostic: BYAPR02MB5366:EE_
x-microsoft-antispam-prvs: <BYAPR02MB53661B2749C738FF0A7F5727A5A69@BYAPR02MB5366.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xNiwYZ/up7Q6HQDvuuMN9f5npq7qrqDxtieFaU9wlHUFmk/NMxO5eySLB16UxDKVX2yCBXnNVlWecx7tN4Jscjpd/h9xXYDLPK/xHEJdjAb4WjS2/mHHvr5WbFage+F/GKZHDOzHsGNsupT0KavrIsYtud6gdurJeaHk/Wl7ubK9uwje7h+0pUQjg0nOgA5AspOu7dU7tCRWZceLwVTae+d3GQybnN+anarFRz3JdwZNAay6Hra0iiYOHNOrPg2SipoGz0D/HQmRQB2f+MjUJzXWshwNScR9qoWEQs7ZuG60bCLOaN32HbulVGc2Mk4e0kWD41sa+aJPL808wg4Gw6q9FB8uLvYQiNfWiEeHEukTW+FAsvSjmc/AzZsqX9/Ihll0DGSb+LraI769yv6fZX5drH6T3Gt0nU0iaZaOTRdYNjV2KCKN+XtsahPUZaUsANhgklr41mhQh9f/oQMcSsBlTYltQYvd29RIhisZqw8IgPoPb6TjkhC3KTCmSM7GaUOyXa55aCSWqhmXjKlGMo9tsR6uYdEMcUIRUo9prXm+p4Dzp4HzJVf5rhjF1/zo5pdzsxWJMKgHjyXa0r4Ki4HL6AjL5lGkz9+tK6BgKJWhBUSqYSfGuDcNm/mqzDGkVJ14CMQNrBpsSt/waT3okFlqLr6mBWOdt94JEhmDPLdC2ky5ogfP/d5MVeBZi9EYEYizxTpFcGIpADZcU0gCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(38100700002)(38070700005)(86362001)(83380400001)(9686003)(26005)(107886003)(122000001)(6506007)(55236004)(186003)(7696005)(508600001)(6916009)(52536014)(8936002)(5660300002)(54906003)(71200400001)(66556008)(66476007)(76116006)(66446008)(4326008)(8676002)(64756008)(66946007)(316002)(2906002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4akcEeiPGpIG5OlvTYHnPRCNKsOu0ojm/FZowkp3W0+9UNIBI+tG4fjJDDM0?=
 =?us-ascii?Q?RKqqgX0PB6umF1TB6QgE9TY9VuZhyuUGlLiRPxpYdKaP2txEo5quuB68tGey?=
 =?us-ascii?Q?ktfxb2lTRyb/mi/OOSB8kpoIv+LOxNi3WylWaB8NwaZj+POl/zzAY7f+Dbck?=
 =?us-ascii?Q?3wlMSzrAljS19NuS9LBhLC2YigNOgvBw3lUbK+wnn4RLcsTDhQGEGrXAJ5Cl?=
 =?us-ascii?Q?EcbVsb2rX2SmfcxEadLy8w8ADrJ8xQQ6W9Xe3S6C6KgBO/Qa+ieTQsCoxjs/?=
 =?us-ascii?Q?CjcHYwq7xJwSC5K4+z361k5wx3kEsUUFiW/dAsJulnV/JDwOan6m9jt9iqlc?=
 =?us-ascii?Q?kLjc0mdJn6RRWF6L0g6JOSv5G6wo2I6VgOYV2btDCltAYcwJGfIOsKuefFwV?=
 =?us-ascii?Q?laTdvyxJwcfX0rnUS4VGoVFu+9s7nJIdnIyg1A3M4Jw/y5aD7fMVijkUTuqp?=
 =?us-ascii?Q?qhFO1xZtEysxX8hLpj2E2+PfqiWM7+K4lphaWYVdq76Kj+uJv4AJV+c4tCd4?=
 =?us-ascii?Q?dinNcbP2Txe5ljg+SZSvTx7uCvNNjH3NyMNclAVf0G3UBrKOPbB1fuQ9tGtu?=
 =?us-ascii?Q?vpBKf48xvnUYCGeC7MgxCjfYXU+on4GHFBRcTOJQsvOp5NyVZXvuER8LuqYP?=
 =?us-ascii?Q?okodt5lRlDY/sWKo6sZ8x+72MmvBg3IOYdFjsMn4T3YLrEqMbTFnviSXCZGu?=
 =?us-ascii?Q?FlSqarFfZC+y2lQXsqXkUr2Vc+WCY8WlXegT03Vi0qTzxENYh12qOhLdzgOI?=
 =?us-ascii?Q?gmLIgMeK0aYv7lKKpabfOqQLZAAZlpc4FjZt1jsu0uzBnF1KY6dyySI10eOm?=
 =?us-ascii?Q?Ld2IEz+s9GovEGK96YP7xwQtXfjfwBQWD9GYAkPi+5yuJQQHYECxlGwTsBgq?=
 =?us-ascii?Q?cH9HX558mhD930MjMBA+kg65EnjaFrIuf3ZpS+7x55txL5Cv4jzVPwFlfHjq?=
 =?us-ascii?Q?MtrKyiLJJ0wBreqzr+MCDJ0Enw+6R82cgVch6jK2t2p3/j2kE5sF0OcErtvW?=
 =?us-ascii?Q?xsp9wP0fKvPMoQg63K1e0JQcQnmlju2M7/mg2u/PmFzNq0AH4WfaS3/aoyVJ?=
 =?us-ascii?Q?Xv8/R/moTQfEoG6Q0L0stcnthtYhyq3N4P7JHY+msfHuXLwTNmLwqqZgRSVW?=
 =?us-ascii?Q?dxCTRmW57YL5Zg9cNdCtcvwPgYAp8L5DVZjZVzPqsJFe2IsiMKQTG0C25nqV?=
 =?us-ascii?Q?91UMJQC0lg8OGQ8dadzTANbvKO/TRo5mbnXQaqmVuby1i1nvJ7GymeM7FD/F?=
 =?us-ascii?Q?JBF8BtjLg+JbhYIF/rpdnm3cuVQBbIf2+LzFMIUmiZKEjeMkad319herjmts?=
 =?us-ascii?Q?LNJsnmlTSXew8fzI2JaW4YDIZJiwojG4JLGvskasWxKTWAYbvI3cN1VuCN5O?=
 =?us-ascii?Q?oqjA4MxT048WqFwyhrwpWOaT+AWzLw+zU2w3yemPQOeVUND3qQ9/ZiNkuICI?=
 =?us-ascii?Q?+CoA/rrfkpg3Yw2/nIgvL0y9VqK4RUvcJa7HZkZaaM6SWFM2ZTM9XZYKI58o?=
 =?us-ascii?Q?IeVinU6tLrLuAXYMbgIAMDPk536I8l5qr58iV+gUtT9cZqZPoq6f4Olgzu/D?=
 =?us-ascii?Q?rcLkwvBNazCN/FAqpsXmsHk55ItEosJxaiacsUT1OfqWgTRAnRO+V5bCQ0A4?=
 =?us-ascii?Q?dUe8eX8xXLZuvgpzibXmm6yNZrzn/obWLuvGJO41tZxnhi+T/HKHxWf80oAw?=
 =?us-ascii?Q?dJx6MT5OXXJv41YThQP/Vj7woDnwLZxafZhSn26zDf+XS+Nr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9661ec-bd91-4c3a-ffed-08da4abe3878
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 08:50:07.7417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQATQg+Sh0/c/NT/uksDt8MU9Fvyk4GCe/vlcOMfvOMm2cPAl2iuSeuOhGU4RnXpXgbnPvUzQR8FZbZfKR0BWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5366
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Wed, Jun 08, 2022 at 10:10:45PM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > functionality at Gen5 speed.
> >
> > Add support for YAML schemas documentation for Versal CPM5 Root Port
> driver.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  .../bindings/pci/xilinx-versal-cpm.yaml       | 48 +++++++++++++++++--
> >  1 file changed, 44 insertions(+), 4 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > index cca395317a4c..80597f2974e5 100644
> > --- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > @@ -14,17 +14,27 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: xlnx,versal-cpm-host-1.00
> > +    contains:
>=20
> Drop 'contains'.
>=20
> > +      enum:
> > +        - xlnx,versal-cpm-host-1.00
> > +        - xlnx,versal-cpm5-host
> >
> >    reg:
> >      items:
> >        - description: CPM system level control and status registers.
> >        - description: Configuration space region and bridge registers.
> > +      - description: CPM5 control and status registers.
> > +    minItems: 2
> >
> >    reg-names:
> > -    items:
> > -      - const: cpm_slcr
> > -      - const: cfg
> > +    oneOf:
>=20
> You don't need oneOf.
>=20
> > +      - items:
> > +          - const: cpm_slcr
> > +          - const: cfg
>=20
> > +      - items:
> > +          - const: cpm_slcr
> > +          - const: cfg
> > +          - const: cpm_csr
>=20
> Just add 'minItems: 2'
>=20
Thanks Rob, will change this in next patch.

Regards,
Bharat
