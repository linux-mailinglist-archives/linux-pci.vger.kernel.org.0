Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26710358917
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 17:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhDHP7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 11:59:01 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:14272
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231791AbhDHP7A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 11:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLJTRIa2dr+DYp4kIFwWwRLHmoWuRzKuqAdJR1Jw0YHMfWHVjioM66PjeT8NSEDW0v8mODwdXsI/7DCxy29NViQU6OjSM2XfAz3gLr0hYgKG1WB+4ZOTneFxHg7igvnkODKfcEYMQdD8LoFKKHcYHkzF+OCY0bJtrOO3Vvmn+qGv/02Y/vJc9iJjhjDdA4dfbgl7NLsor03iLDozzOiEMNJe83ZQHBM+8in3sFtx4WV+z1jLA5j9bJQIprpikGqUvKFE0QApDOS26FXDtLFfe8w0Lo9h0zYrDdriW9SjWOq//a5KEh5DfpENDgukKOgUkYOKwdxQtEn9XNFr1OPNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uexLqQRLcSOv/cTHGL+8juxws2csu3ew7gN/WB7lWjQ=;
 b=mNgW6ovVHBdxiY6zj/OTZdtkkaOFtFY0ZtOAnSae7jQAek0/LqXgv/NruK9k+Kg1EfWG3FeE01wBidalZl4USsuA/3WzuN7+gJIqRT7ICG6w/cAeeQab/6PacEt6GP3XrSjvuM81kTuSN0NWG2+qgVtziBs6Z0NhchQpGCoIdkYYWimo94Xm8P5GYuo0l4ogypAXG/u4RRegO0+WHuwmQs1a84xLOr79ZSFAr7u6n+aI2BUwpCX6ElDbPL2L+rB77Wu0MxVh/Rfm//Ilei5cTrdyDbfMrrlwOVcKX67b+S7u6TIEb5lBt2Y3t/5Z4fUusjgdsGHJ2Ok79i4cUnqB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uexLqQRLcSOv/cTHGL+8juxws2csu3ew7gN/WB7lWjQ=;
 b=NGzoGzw+2IMWUNNw4JktWSj1U1YPCozbPyZGXcpoT0dj/abwi10ml4v9CAhNb5PutShmwqN87dMBpAVvTtEEUONsq1h9RKYeUX/aCbAG3aUX4RAcdYYNR+D2iKWX+z8+i0i4YG/gdL4d6PocJkS8/ZgRPwF37qDWO77+jKgQa3g=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4071.namprd02.prod.outlook.com (2603:10b6:a02:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 15:58:46 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::2418:b7d2:cbb:27f%5]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 15:58:46 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Topic: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Index: AQHXCPdf8/XRKTi3FEaC06+ar6fH8aqpfLQAgAGRbUA=
Date:   Thu, 8 Apr 2021 15:58:46 +0000
Message-ID: <BYAPR02MB5559A07B5A9C3B304DF55E1EA5749@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
 <161781127065.668.2308248891622722223.b4-ty@arm.com>
In-Reply-To: <161781127065.668.2308248891622722223.b4-ty@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b77b6b7-444d-49ca-04a6-08d8faa7315d
x-ms-traffictypediagnostic: BYAPR02MB4071:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB40713A64FFA23293094EA7C4A5749@BYAPR02MB4071.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w4dCqrqhMtsLoI80WJohDm3+OIaJL1z9nifjMQzHTqIUbLD213iyDKUPrZJ/wZD3TmoMzYnPY9llCZvmNi4O2SD9VwBdRHlUx1kC3HS9G4qYX9Grn3uiy8Ko6LLDf0p93ey4KZyHu0y+Mt5ESnN5Mi8AWy8OUxIIGHgUgIrJwHkvKlPwzfTznpHeOTMakKu5XEPe0URMzw8J16IeJusL1wTt0EgwKrVQ8RqfZ+3e2xBEDxpLo2RZM/R2Ef2Nb9Tf+svG/osgCZHf9FoEls5m12kG/xW7+wuRNSnzQUDhf5bIZM/lZjXwY58LkTgUjnvx+AmIymOGuePZAawMobygQVjbncc0UkHuwhoTNvLsHruWYpgfTycBvHa/ZzNON+EnYKiuVeD/+Oa7KY52cNxseubHILVhNkUdeyT9k+rtFt9CFl6gE2CDQMBb4lVhmuhBz6kdVtqbokfjxYyYYohTo0xcO4Gl5qXH2h0LiE+aLehPBJ+Pjg3TiY4eWnmAsvRWaxvGq7t8VkOkPKP8/bpoGe0ytWoH6MXf6E+Q72ZG+WyCzoqIoGE2zsJuoXKp3AwPGYDuGC03mr+bxv4OL++qCTsbcGLvQwfSFznX41fN3plsmsglSqRzz7FZXe1QHXDKbUPwEJP+oan1A83+MH8Q430GOXOzJJGtdIPMr5uIxzZTIzBcCmPI9bh4iuAJgIbUsAoz/U8xba34MFphxkr6uuki8rYSritUaW7aB7qF3xhKvtD8rUQLrtxblsLXJ7z2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(316002)(33656002)(26005)(53546011)(66556008)(6506007)(76116006)(8936002)(66946007)(66446008)(64756008)(66476007)(110136005)(38100700001)(966005)(5660300002)(4326008)(83380400001)(55016002)(86362001)(478600001)(71200400001)(7696005)(2906002)(8676002)(9686003)(54906003)(186003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Upi6wqWECb9vfHq62sbQmQjc8jLtsD0F6kIdGmZZskjGL2bq9Wn4EIPKXuFP?=
 =?us-ascii?Q?ipYV2G1ucNngNG/e4RCQP+oLXYMmojPwsVvidcMYMRaMysdUX9H9w6ACe/f3?=
 =?us-ascii?Q?xHhNCHQZv/eh8BxU4Mfy2QBBxEYLLUnqO+KzgVGWDqiheULoK4cRaIq4r7iB?=
 =?us-ascii?Q?fzahwKKosEqkJtJybJLuMyfG9WdDzQZn0dUuz09yYDPzJqxH84ZO39kwIPMn?=
 =?us-ascii?Q?2wrHjye+5TmisRJ0a0+h6avmOPBOFqSEmgeN+LM4UsMZUAoMp6aIixGO4MVX?=
 =?us-ascii?Q?uupm3t8DlXU3EN2LwRUgcw3EO2eTnp4CSimSxkDzRsRDEtvSa61g5qUqxAtT?=
 =?us-ascii?Q?p9/xlDy9EzNNxvnItZQHGLez4IBGulqPnvfhwqaeJ3eqHYn3JgN+5yWoxOFu?=
 =?us-ascii?Q?SqYDl9uj2ZgGvsU8Iq5fKWdxBqCtUk4rmayhdx456AJ2qhaOvuM/ntB+Xwob?=
 =?us-ascii?Q?gg0K1zd8czL5/NEdv6eyKitSdprwXhDk+oHEkKXWeN9YwdchfF3Fj94RCPFd?=
 =?us-ascii?Q?UmU1gQZSGX3WJGMoVhO73WQBH++xo1yAs8skCGznvB9/57HO6mr2XkdmtaGW?=
 =?us-ascii?Q?2fgi2jbox5BJ+tB/3R83OeWA0R5Fa40AJTNPRkdypcsCaHa8vlKtajRur2QS?=
 =?us-ascii?Q?ZoMtAcBwlYwLK5aSlEe5k/D86PRaBlAfUdXSukKoefZujIGiZ3ssEfbogyXR?=
 =?us-ascii?Q?IPB8D/2mHUp5+XRL0VLrpz47caTGYUaY1/baPsQ+kH/S4HfrDgaAhFKXa05v?=
 =?us-ascii?Q?ySsaPLmfUIkZ9r4xbOvxepyODrXRjuRcSoVaHac5m0zySnfJCCAJttPg30z3?=
 =?us-ascii?Q?sESeSPJGZ49uMk3OheAEo8P/2HmzP1WV34En/wTQq/exlcsh72WY1Hr3lrhb?=
 =?us-ascii?Q?mOs6sDk5ZkXGZngSB8p7yCH9L5V9U+gBtBx1K3RZa7ccIDiGXEgLPV2Mv5fd?=
 =?us-ascii?Q?PihCalAuAGakXpClVu0W+8PVssozBya/AmRx9+F7edMu48Mz9odkK0EwvADR?=
 =?us-ascii?Q?WIG6gJPW9lzzJrfJ1Twp7epjsnrCBvvth/l7N6t7Bw8lJLYzCvkxRnfZ+GM7?=
 =?us-ascii?Q?DSDNz47TDkk+mJQ3So01aYAfaGV6mr0P0sivz4WP/nSDcYXyS9z/ECIjioFa?=
 =?us-ascii?Q?gG5q8i+C3U5h9krDe+JxagVfWA0+EUD60I9FV33VNldYCXxdWE/7g1b/bbDY?=
 =?us-ascii?Q?Mz7zmphbNsbIIhHfgjRE+FN6fIxYbhqpvop0P2aq3bNc6qliANaXPfU+IAqy?=
 =?us-ascii?Q?6C0ESos/iMJ2E5THyOIqZdstNjzlFhkt/BmYR6aThD78sR4p66oqnWneDXkn?=
 =?us-ascii?Q?vZ4GgtAWBiwFR7uc9JsFlciH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b77b6b7-444d-49ca-04a6-08d8faa7315d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 15:58:46.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/eLUDSeqCWeCeYSkzkOx1lV1ujmAnaxZ8F83nf8ftDu7vFvsD7/Uf+Rtr5ysk5Bzh7WbuPVTVg0oXEK5KpBCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4071
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Lorenzo.

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, April 7, 2021 9:32 PM
> To: linux-pci@vger.kernel.org; Bharat Kumar Gogada <bharatku@xilinx.com>;
> linux-kernel@vger.kernel.org
> Cc: lorenzo.pieralisi@arm.com; bhelgaas@google.com
> Subject: Re: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA tra=
ffic
> using CCI
>=20
> On Mon, 22 Feb 2021 14:17:31 +0530, Bharat Kumar Gogada wrote:
> > Add support for routing PCIe DMA traffic coherently when Cache
> > Coherent Interconnect (CCI) is enabled in the system.
> > The "dma-coherent" property is used to determine if CCI is enabled or
> > not.
> > Refer to https://developer.arm.com/documentation/ddi0470/k/preface
> > for the CCI specification.
>=20
> Applied to pci/xilinx, thanks!
>=20
> [1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic using CCI
>       https://git.kernel.org/lpieralisi/pci/c/213e122052
> [2/2] PCI: xilinx-nwl: Add optional "dma-coherent" property
>       https://git.kernel.org/lpieralisi/pci/c/1c4422f226
>=20
> Thanks,
> Lorenzo
