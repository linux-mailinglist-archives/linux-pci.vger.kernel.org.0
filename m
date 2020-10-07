Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AE52856DE
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 05:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgJGDIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 23:08:21 -0400
Received: from mail-eopbgr1320120.outbound.protection.outlook.com ([40.107.132.120]:12672
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbgJGDIU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Oct 2020 23:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDrnslNDs70HjiTztT9FEdwXNHQop7O1cMDEhvNeAe7ThC8eIPKrDfDs56s61utzq+zyTy9nmx1y7SKP03qJ3A9pxibKU16V6l4gqOO6Oli+LgiT9X10YdRGRgI3+5IB1ZQs9KIBS9MZ/jzFapn2tmXtxxJXRGYlGsce9PPkOhUhW0brS6v8Hf9zobX8KILSfQP+RwzcQuPNoPrzwmVMgdgy49jdKjXnjB4m8BR5VSVWsbkH4BF8PvcOv7IGjWaI/drcfXToHt+OqyQkPDv0KFjF3iPF+VGlJeaIaWuzU1Y+Hbp9xZquVqlotT7SxEg40iVjuDrNvUqG683H8f8Wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj+Ao37Ogc4x8ba32f77IOp/xoSW6A0ibSoyqJZYEiQ=;
 b=Et+y21xUXx0bjstVSLQ9GBQgesKB8jgNQwKq38Ey/6UCUY2Du5F0OZ2+VTuRgCV87Pk9fFaUbmD375ObrGjnp0gttHQZ+8vTgrSQw0hEc9aLusHuDZEsP8wO/PSqxMb4Amxysa0HVzb1cDzbisXNNwfOqt7Ahz3Rhxz0bKp5eqjWxOQhGNu+vcvQ29D1mEqxDIHrPwg8xzqQ+5WbJvCcLX0REQeFrhRZDpxHsHRRMUjDmJ5ocnJhBw7vKm7zh6O2KsoDIyXx+5aFcHY2UE7vAV2gDZThJ9Q7zfqYp2XqY8K8NlaDCJsOv2ZD2/HhS/9q5ZMXAXSRKJ/IDrp6SwLurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj+Ao37Ogc4x8ba32f77IOp/xoSW6A0ibSoyqJZYEiQ=;
 b=SYe3fQE+ZluG/z9O4ZCczkrEjDXp9U3sxwUmjL7tFJtG4B5xmc60dtMafqf8VBePTYKpGaA4kzQfGglw8xabqp5J7AN70/bZvYWX/K86Uieu7fVxOIlqwoLIlNDSgc8L6oxvyL4Igkth/1xOTwgWvegQ29fB6mU/EBSlrrmQqaY=
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1a::17)
 by KU1P153MB0168.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.10; Wed, 7 Oct
 2020 03:08:10 +0000
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::31a4:e5b8:86ec:1413]) by KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::31a4:e5b8:86ec:1413%9]) with mapi id 15.20.3477.011; Wed, 7 Oct 2020
 03:08:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: irq_build_affinity_masks() allocates improper affinity if
 num_possible_cpus() > num_present_cpus()?
Thread-Topic: irq_build_affinity_masks() allocates improper affinity if
 num_possible_cpus() > num_present_cpus()?
Thread-Index: AdabnwA0SBdvouNFQ4iAnKm72ZKc6QAc4+aAABDIuTA=
Date:   Wed, 7 Oct 2020 03:08:09 +0000
Message-ID: <KU1P153MB0120B72473E50B1B723E25E6BF0A0@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
References: <KU1P153MB0120D20BC6ED8CF54168EEE6BF0D0@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
 <87lfgj6v30.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87lfgj6v30.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2f1cefce-f90a-4392-8907-2db5c9b0b06e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-07T02:58:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:e92f:2b81:6f33:777]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 12dfaa24-504f-485a-8c78-08d86a6e38bf
x-ms-traffictypediagnostic: KU1P153MB0168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1P153MB01680C1299D0DC1CADB6CAEABF0A0@KU1P153MB0168.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j+O755Cg1hltxZ72quYpQvpwhos3QvCj3nkIHZZOPJcJkJ/6r1zr1g0Jpx3/TWO0x8BkZgcC06zDiumNrsQcOY/qrp3GVDxmCG1C+q+RnCga1mN8xRHI2fgLKQ8OF372rY7YcFuZISEiblAHp04EsOAC0vIA0TF1RbJlj5MVT3d0Kbk13Yup3BjBtsLl3VygVgSRnQCZPJrp8+TAogFlExzqMwBBOXqIhrB0WyN5o9CYYdmRv0p86tYWEcO97XllEPWt5wzVTlN4SnOAOiiuCKpIo034B5DE4eLKVrmqc2O51vtriND6kiPf2edsvNRd0X4aqZ2zSG9UUBZUL3I81w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0120.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(55016002)(10290500003)(6506007)(52536014)(316002)(5660300002)(4326008)(76116006)(2906002)(8936002)(82960400001)(82950400001)(478600001)(107886003)(8676002)(33656002)(66556008)(64756008)(66476007)(54906003)(86362001)(186003)(66446008)(66946007)(8990500004)(83380400001)(7696005)(9686003)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ENNaE+et+V7TGE/O1wZ8vZk8ZZAsK2USQxZTwl0s43CARmMLCPRh1trhfbdzVsEYjtw7BKRZlJ8/7uTLT4eNzC4r2n0lFPiz9kxJUUBv9gm00bUEq5YF1qGfwIsWfukNfPIBajHdqtPIdyVFopjXe3OQ6RwF1dOR1wpDIgYtrGdlQh/9e8Gck03Rvhbnhx1tFm5aI7m8O4iX+TQ7xPw8W8w59DV4GoJOGLJzkwzZzr1GtmaDi88tI+Yh2E1sTQ4IEPQMjrMRSJxNO2rJ7q6BwcDJUI47E8Euki4/V5Oj3Ht8LyhMwmGrbtc2S+kKsCeA/0LL213ZGhPYW/hK6gJXrnL2LZES0cKZ8BQuBsKU+lcKkiHAo26PxjBfyw+Xbg3krEuVcSvsKaMV3vf7zqNxc6UrtydD1owT2MfwBcx3JGSpdzQ8o0JI61ITfRd62B/EH1TOZQUv9b0ErOoZkrpfTxih3X1q99tLMof77e2EeZju/Ez/M4uYP8eQ8nS2uFcp3JW7N0y48ilN8G6KdxDjibWBiNLZtS373Krd30A4ayPJlPrzNOdz0uhZXOhfjYirnna7fZ07HBbcha8FMDYQu2fRW6F3nP/hgH4oJjeUfaAsmprCe5K3y6aT5849PD8RFYCeO7AS+XAPVJ9kHiBWaHLvCr//e7Rlk8813YXo4jJ2hEFjrM4XeSU2QxNMXyKYiHRT9KtToYC/fwiyZXSvhg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dfaa24-504f-485a-8c78-08d86a6e38bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 03:08:09.9381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJ4WBD8G3716gL5Pnum1ckEuan/hUEJu0TU3XfuHYHHqz9zd/ZyEvQBx6yH5b9INP98EiCYfr9iG5jDrFj4P5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0168
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Tuesday, October 6, 2020 11:58 AM
> > ...
> > I pass through an MSI-X-capable PCI device to the Linux VM (which has
> > only 1 virtual CPU), and the below code does *not* report any error
> > (i.e. pci_alloc_irq_vectors_affinity() returns 2, and request_irq()
> > returns 0), but the code does not work: the second MSI-X interrupt is n=
ot
> > happening while the first interrupt does work fine.
> >
> > int nr_irqs =3D 2;
> > int i, nvec, irq;
> >
> > nvec =3D pci_alloc_irq_vectors_affinity(pdev, nr_irqs, nr_irqs,
> >                 PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, NULL);
>=20
> Why should it return an error?

The above code returns -ENOSPC if num_possible_cpus() is also 1, and
returns 0 if num_possible_cpus() is 128. So it looks the above code is
not using the API correctly, and hence gets undefined results.

> > for (i =3D 0; i < nvec; i++) {
> >         irq =3D pci_irq_vector(pdev, i);
> >         err =3D request_irq(irq, test_intr, 0, "test_intr", &intr_cxt[i=
]);
> > }
>=20
> And why do you expect that the second interrupt works?
>=20
> This is about managed interrupts and the spreading code has two vectors
> to which it can spread the interrupts. One is assigned to one half of
> the possible CPUs and the other one to the other half. Now you have only
> one CPU online so only the interrupt with has the online CPU in the
> assigned affinity mask is started up.
>=20
> That's how managed interrupts work. If you don't want managed interrupts
> then don't use them.
>=20
> Thanks,
>=20
>         tglx

Thanks for the clarification! It looks with PCI_IRQ_AFFINITY the kernel=20
guarantees that the allocated interrutps are 1:1 bound to CPUs, and the
userspace is unable to change the affinities. This is very useful to suppor=
t
per-CPU I/O queues.

Thanks,
-- Dexuan
