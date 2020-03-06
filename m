Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1982C17BBFF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFLpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 06:45:52 -0500
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:6125
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgCFLpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 06:45:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK82t11p5Z+qE1WNOFcJ+y1u2POrLeAgj5Ri2dHIqCE9OnV8Nl6itF7BR+pvNhsxx7BfIHCCjH0VdRTHmdWB+YzGXUbDH9CHHSzOIZX9Xc5oR+enN3XNdG5L4Nl3BRzXNCKAQYQ4r0AmBzVHgKdQeNkIzhD1vWQxV3o+jMph8MlN0EBwSRkg5PYwC28HRf2vw5Xx2GZLYVo+Gk9nv3e3iDQ4dwhZl3XvlIc4vkFNuqI9SRjH7RmHSBK4ZM/YIcSddDQrTnBwni3HEkLinp9QZCG54RyD2dR7DmNhhWEFguX43vwsPxSWlLJKXGa7sn4o5EeQm7hNrKWPkfTetEVXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM8TqAovF3wwt8GOhBC+nEGzEqvZcH9gN6EoKWasepU=;
 b=ilCi3YSJL7DdzMNvrux5O5khGCrg4MFe055c7k5T+gC7iM/KVfmKOjUCqErbSWdcXVWnZU7jWU48XPbKl1wpm1fm4j98dQwDzU6sS3K/mdYOK9zKTDjvrYDXLPHscH0ItUGFVWSKkmlkhOrBByDX0UosLxtEQVPqd1tvGNAoVxFufs1eIjNkHXUo0oSNlSO/ySwYQtD70CP7sEl2RiB1DRpMNn0+ubJAP1jHJLFDV72Z9wWNY7pcaRwhVXECZfQSb1EH34VuD/LZDjTQn2+TDx+7z1F6GTth7Vi1TzjXcPgzDd60nhgFLC/zuiSEWpz+ODFOGrfKVEwwa/bBwf/k0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM8TqAovF3wwt8GOhBC+nEGzEqvZcH9gN6EoKWasepU=;
 b=KjzxDw61DDbiD9+pX2w9h+H2oe264EbKynpTPFiKrsS2vC+xyduzvY6PyULU+1fuFdyJKMtDrgDCntMrOK+eHpkMWIdHGGa2BAiBUBms3zgXw5bH7RR12stNHW5w3YLwDw620L64PWLi1AKQeVME3I5wGidj4x4XsVLYq6kcSYk=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (2603:10b6:208:1b8::30)
 by MN2PR02MB5933.namprd02.prod.outlook.com (2603:10b6:208:118::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 6 Mar
 2020 11:45:47 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::b51f:8bc4:7e18:f227]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::b51f:8bc4:7e18:f227%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 11:45:47 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV14gyqXPkldKNt0SLTelX37u03Kgr8Z6AgAAlV5CABIIlAIAAIZtQgArnjQCAAAJtIA==
Date:   Fri, 6 Mar 2020 11:45:47 +0000
Message-ID: <MN2PR02MB6336BBFDCB07F424C36742B0A5E30@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
 <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
 <MN2PR02MB6336569F378683B05B262D4AA5E80@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200306111620.GA10297@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200306111620.GA10297@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7133ba3-4801-46c9-a42b-08d7c1c3e97d
x-ms-traffictypediagnostic: MN2PR02MB5933:|MN2PR02MB5933:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB5933F1EAF20D61438DF3BDB4A5E30@MN2PR02MB5933.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(66946007)(53546011)(81166006)(7696005)(6916009)(76116006)(66476007)(71200400001)(81156014)(26005)(33656002)(6506007)(54906003)(8676002)(316002)(66446008)(52536014)(55016002)(186003)(64756008)(478600001)(8936002)(5660300002)(86362001)(2906002)(66556008)(9686003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB5933;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GrjVgD16yi4AmNNbUpqRvZT+CLnLPA4EKjq4EgjE1Z6omd7JdO6WEHEBwOndaVKO02U/oe1sqLZQ3zQk6HRkZZ/ARNZQTUIlCQUDHa9udiNwG6Zba9Bri4tKCLYbUyPHhIl2VVmnZdadIcFZ6JOFUzeyttE7YNQiPgAlkJX7sKAk/3eXTqgctlpv7xfnNgCZ5ewdCouBQ+AGfrI3Dha7YA++URvH7cHK9+eZNWxLLYocYsfjntZxw1OPoo8rvrpNSyQxBsroYgV3uLQChejwfuPy+h0nPfpWHjrcCfuOfrzvi3uJ1UWLFX3msFVPHQzftPyG2afuyYZB7qqEEZeogzM+2G53eSxrDs14sXRjGdXk5i2HpONzvDRqZn6mbKTs/0VyeMK/rCBwD1nxATThCYvN8buwYNCDQ3blourAL8NtcSLUqeurifFiR0x/b/jj
x-ms-exchange-antispam-messagedata: QTR2d3o1Jc6Dw9/o4gRQPGTNAFLR5XD4vqKe/Q7FPpWe+rkckapbnG1poACEVGrvrMsAWVBqzSqco8kVVF4M2yGDIjxftjxONMCZUykB2/LPO/lfPGd6xLgbTY7kDu8btCGMhJB3F8bn2uSq5J7i7A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7133ba3-4801-46c9-a42b-08d7c1c3e97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 11:45:47.4464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjX4k3gXaqB/L7BaqcwUw2rXxcWhiRnpIqUoI58idrRnx6pZiQtymiWX3pO5M1SXahmQAhSLDhgKtSMPzcW0Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5933
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, March 6, 2020 4:46 PM
> To: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; Ravikiran Gummaluri <rgummal@xilinx.com>;
> maz@kernel.org
> Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> On Fri, Feb 28, 2020 at 12:48:48PM +0000, Bharat Kumar Gogada wrote:
> > > Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root
> > > Port driver
> > >
> > > [+MarcZ, FHI]
> > >
> > > On Tue, Feb 25, 2020 at 02:39:56PM +0000, Bharat Kumar Gogada wrote:
> > >
> > > [...]
> > >
> > > > > > +/* ECAM definitions */
> > > > > > +#define ECAM_BUS_NUM_SHIFT		20
> > > > > > +#define ECAM_DEV_NUM_SHIFT		12
> > > > >
> > > > > You don't need these ECAM_* defines, you can use
> pci_generic_ecam_ops.
> > > > Does this need separate ranges region for ECAM space ?
> > > > We have ECAM and controller space in same region.
> > >
> > > You can create an ECAM window with pci_ecam_create where *cfgres
> > > represent the ECAM area, I don't get what you mean by "same region".
> > >
> > > Do you mean "contiguous" ? Or something else ?
> > Yes, contiguous; within ECAM region some space is for controller regist=
ers.
>=20
> What does that mean ? I don't get it. Can you explain to me how this addr=
ess
> space works please ?
>=20
Hi Lorenzo,
		reg =3D <0x6 0x00000000 0x0 0x1000000>,
		      <0x0 0xFCA10000 0x0 0x1000>;
		reg-names =3D "cfg", "cpm_slcr";

In the above cfg region some region of it reserved for bridge registers and=
 rest for ECAM=20
address space transactions. The bridge registers are mapped at an unused of=
fset in config space
of root port, when the offset hit it will access controller register space.

This region is already being mapped=20
res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
port->reg_base =3D devm_ioremap_resource(dev, res);

Does pci_ecam_create will work along with above API simultaneously ?

Regards,
Bharat=20

