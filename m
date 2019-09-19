Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F07B80BF
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2019 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391360AbfISSZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Sep 2019 14:25:47 -0400
Received: from mail-eopbgr10079.outbound.protection.outlook.com ([40.107.1.79]:23694
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390186AbfISSZr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Sep 2019 14:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmtwJCx5M9a9CGWJtgax6D3wvn40e853FJ/bfFoxk15ts/Rk9hqoea2CFvQ9WoSiO7cg+B0auQEityGk79kb6oQElUiT83X/zfN4TSYhbgjuUIrgvykB12Ki+P/OFfObYzXq+Ma+JU7fuo4+TR/lsE6wv9xOQZpaP6ZTwAKviWt8QPgDISf2JI6h/8R4/xd8LVKjONPGqYoOqCyYQn0IitLDNjpJ0muutZSL4GllJmiyrLmDQcvKBRi332m5hBKcXtEtP9RaQ4Z36edbzrYF6XNGEUMO3Sjpt36pK3yRFD13E/ma45sFFPIr69p52ChH8G5jkgMeF7s1L8hSmb0+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bLjVPAn/e0z6SUkTV3xdrwDVP22Dv2PXQw6Ej+YXtw=;
 b=UHlQkHVPlJxULyKSGOObLK+Eg+Ant1B75Dg6TmAZs3X0KSfYSInmKCYseAXnWRllGplL3jrWx7zM8wVLKzCHN7UM4PdUCPtQl0DFZc7s3UhQxvKUkZOUgVWuZpRVg5JacbN8QvZ+gkmpc2zoXYWQv6RrMTo5SoIaTUE3WdF/iuKs4zsKGvloNAYo8uVDEJarNO33jGRusABmOkXM2W4Q8IDVhOI+KBCuzxwhc8Usur5RdULRQziqAZWJj00kg70a9GRjbwG/0qYo1Wvz94Vmke5/4fM7pRkzhH0lOUyxXUXPN+DNd3lCHaJ75jsub/mrnlB7XYLVz5wGDlbnQ4ZUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bLjVPAn/e0z6SUkTV3xdrwDVP22Dv2PXQw6Ej+YXtw=;
 b=LLwFxWNenAItgBHPL47/JvcWDyjpP22b1IQdYwLPebTRfL3blLA1ShgZXn88Qe9FFTiLOMA6ktTkl4vJWDG/mq3H8kWjw4wpaBe71kYapvGPD0wHCDVuRuwb4TO5I8vGvh0o9H7/S2MLHnHEN6WGUyHelHDEPYdtyUP39esNjgo=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5967.eurprd05.prod.outlook.com (20.178.126.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 19 Sep 2019 18:25:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::d9ac:7e4e:9520:29a6]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::d9ac:7e4e:9520:29a6%6]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 18:25:42 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
CC:     Megha Dey <megha.dey@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>
Subject: Re: [RFC V1 0/7] Add support for a new IMS interrupt mechanism
Thread-Topic: [RFC V1 0/7] Add support for a new IMS interrupt mechanism
Thread-Index: AQHVadCis80jNXQJ7ESbv2tE+P8b86cpe96AgACTvQCACUwHgA==
Date:   Thu, 19 Sep 2019 18:25:42 +0000
Message-ID: <20190919182537.GS30961@mellanox.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
 <VI1PR05MB4141EAE19EE47DA20A75AE21CFB30@VI1PR05MB4141.eurprd05.prod.outlook.com>
 <20190913202710.GA999@otc-nc-03>
In-Reply-To: <20190913202710.GA999@otc-nc-03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 925894c2-f9f7-42af-4564-08d73d2ec7bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5967;
x-ms-traffictypediagnostic: VI1PR05MB5967:
x-microsoft-antispam-prvs: <VI1PR05MB59671A1E67F514948067DBFCCF890@VI1PR05MB5967.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(81156014)(81166006)(6246003)(256004)(33656002)(76176011)(14454004)(316002)(52116002)(36756003)(7416002)(5660300002)(6916009)(6486002)(54906003)(99286004)(1076003)(6512007)(11346002)(6436002)(86362001)(66476007)(66066001)(71190400001)(66556008)(8936002)(229853002)(66446008)(8676002)(4326008)(305945005)(6506007)(64756008)(71200400001)(66946007)(26005)(2906002)(7736002)(2616005)(476003)(25786009)(386003)(446003)(486006)(6116002)(3846002)(478600001)(186003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5967;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 862ZkM4epSk+udoBZqLa6r30v1jZ9vuwfdsXrEdS7gbZRFVp3Dgrh4ZteQRVXfFfbV2r0r+qZ8sC86wAZ7I8/D4ngNdy8AR/jp1ZcFvEZFxTJ9syhZS8fA/NSVtb6w4I1knG2ZmMLICe4ETpCpiQXJ2wgJub2X12kGO4hp/370eOOF619GcorkFE6OTQUZnIhPcAjbr5dT3XZm47MF8Yf4/ljK6zem2m6VrDXiUNUL6Kd9wNfWgDw7z863coexKTgWMukTvtxJn9dEJuwGX+OoAU8bduGt84Mocx75Abjy+wpwGovHIlilS2nRMuQ91Hzx3Lb9JdPsvxztm7eJwGlfIDLmnbh6w2FnT4n5s3fGF+o9La4ERCtvg8JDsfCm+0/lR5tX0rItwmPpPFG7wwJsPT+/CQN/R4t9w81tgewk4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFA492F5B86A2B49B5A2935F788CD314@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925894c2-f9f7-42af-4564-08d73d2ec7bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 18:25:42.6308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TkZXkF/5MHPq96veannt+eapaD3czEPGp1Mpi/t+7PvAcs2SsM2IJykFj6jaFBH/G0WzmBK4zJmk1rBIIAsc8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5967
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 13, 2019 at 01:27:10PM -0700, Raj, Ashok wrote:
> On Fri, Sep 13, 2019 at 07:50:50PM +0000, Jason Gunthorpe wrote:
> > On Thu, Sep 12, 2019 at 06:32:01PM -0700, Megha Dey wrote:
> >=20
> > > This series is a basic patchset to get the ball rolling and receive s=
ome
> > > inital comments. As per my discussion with Marc Zyngier and Thomas Gl=
eixner
> > > at the Linux Plumbers, I need to do the following:
> > > 1. Since a device can support MSI-X and IMS simultaneously, ensure pr=
oper
> > >    locking mechanism for the 'msi_list' in the device structure.
> > > 2. Introduce dynamic allocation of IMS vectors perhaps by using a gro=
up ID
> > > 3. IMS support of a device needs to be discoverable. A bit in the ven=
dor
> > >    specific capability in the PCI config is to be added rather than g=
etting
> > >    this information from each device driver.
> >=20
> > Why #3? The point of this scheme is to delegate programming the
> > addr/data pairs to the driver so it can be done in some
> > device-specific way. There is no PCI standard behind this, and no
> > change in PCI semantics.=20
> >=20
> > I think it would be a tall ask to get a config space bit from PCI-SIG
> > for something that has little to do with PCI.
>=20
> This isn't a standard config capability. Its Designated Vendor Specific
> Capability (DVSEC). The device is responsible for managing the addr-data
> pair. This provides a hint to the OS framework that this device has
> device specific methods.
>=20
> Agreed its not required, but some OSV's like a generic way to discover
> these capabilities, hence its there so device vendors can have
> a common guideline.

I think it would be reasonable for a specific device driver to test
the DVSEC, if it wishes too.=20

Since it is not required it does not make sense for the core kernel to
enforce this on all devices, at least for such a nebulous reason.

Jason
