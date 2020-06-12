Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF91F7C5A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 19:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgFLRQH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 13:16:07 -0400
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com ([40.107.237.50]:6096
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbgFLRQG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jun 2020 13:16:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc1ILkdjoUu0TgmNIJziZjESjTKdEpGJD6TCcVNrhjoCuedCbyP3Fmp00rpxmwkDcNCzkbEtqr0L44cuhz3ccnjdzXOiWOyhwkG7VbdrycquxBJG5DCAU0mBxSTLfK6WXAx628EhPbL5Xkcqgk0HxpF9jBqZHhX9LKACjQ2KXjy71Y9baeFvmOKjq3t13YnnqCV3CFLcbPnzSjFIbJTJl2qmv6xYH3fOj7XP0RSPJfeP2zkx3MJBHcs5/u5jM4r8qVmOt/75tgqIge/j5vDaK2ffowal6RJE3T7ELB5WKKqQ0XMt/4RO3EUnYdfKca3hDSovAa8aluBMl3uo/PQbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=451irRM1F7rawJfovfQMHCJO7cwvvMZFX9fgpqUBUco=;
 b=fHJXDGCLZsdnSxUXjX9xcRTdId0PctMliuHyoWB/Kje0YcxlWVaktkBiXbP0+5XHmq0Zb5Zc4G18k0Ru30LwF9A4pvAHYxcGpEmMKrgfXQY+Par+IqPfukxY3QUX/Dzs735H0F4+UO4y8WBXNo3YXDZGn7iOnJJEjtfRyYU+/3wuvuFPuEvPe3zfHvqbE02RxBLj3g76mCgebrJ3XmnUXd3HA5bWngqyPySJ+Ju53Ym7HkC7Sq+wGGPzzUKkklrDNIbKIVPwRnxRKUvN+iPx7yY0AEgYiuGYiK331vwelhtiD05BWDlFy7UR6ZY3WPhmI0+54/RUcnrVR5S52vzVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=451irRM1F7rawJfovfQMHCJO7cwvvMZFX9fgpqUBUco=;
 b=tPfGil6LW4gnCfJLRg6mpg4eBMlfLETg7KYMJil51mpHh5ZukvpjW6Y7yo9zf0KHX+G6Hu9lqTsZt4XYxc1HjGFw/F8fCCLvcky5pgg6slV+GlI69dBYfHi1SsZCpbAuKIjk+d4EiELMB49biJEXUmi9uA48yvD/xZn21NtHn5k=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5127.namprd02.prod.outlook.com (2603:10b6:a03:6c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.20; Fri, 12 Jun
 2020 17:16:02 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ad86:19b4:76ec:28b%7]) with mapi id 15.20.3088.025; Fri, 12 Jun 2020
 17:16:02 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHWPZdq6W68nNHNZEqBlWufdyFfUqjPAbcAgASFrZCAABADgIABo7FA
Date:   Fri, 12 Jun 2020 17:16:01 +0000
Message-ID: <BYAPR02MB55594A0981D979CAEEA02CE3A5810@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1591622338-22652-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1591622338-22652-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <c2e4b1288ce454c6ae2b2c02946d084f@kernel.org>
 <BYAPR02MB5559D2F57E35F8881F5B608CA5800@BYAPR02MB5559.namprd02.prod.outlook.com>
 <777c4abbbfcc99ddf968d2040bc86835@kernel.org>
In-Reply-To: <777c4abbbfcc99ddf968d2040bc86835@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9526978c-7c75-4a78-53d5-08d80ef44884
x-ms-traffictypediagnostic: BYAPR02MB5127:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB512794B9B5FB10744136B10DA5810@BYAPR02MB5127.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: erwwO3lLr+9I/vSr6joJQJRlSOT1kJktHwOC0tsK3b8nL9gnShhh6/jjwd7KuSR6ql8iP309HllCDqv2etR800e1hZv8wIXtwnRN5zGRYnG8hix/lxmLD1mwyuC8EZF7kSYbjOnFTr26lQn3hdlEk4NwbCVOejzZOArboEYAl5PkdAUrejE2/khLnGKFFOyNlGSZkTBPiiriGgvbwLnHZCpm5WV0V0TXXAG/ku+mHvurATj2ZuaSuZ8Ww4dQWd6K6XZIjC4tRaiAtuDFsUMybt93RHb31BZ2gTY0ZqPu545Jh1SOMjVUZv1azE2fN6hQQm2O/622xLxCnP1zi7i6Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(64756008)(2906002)(66446008)(316002)(186003)(6916009)(478600001)(33656002)(53546011)(4326008)(6506007)(76116006)(54906003)(71200400001)(7696005)(66476007)(66946007)(86362001)(66556008)(26005)(52536014)(9686003)(8676002)(83380400001)(5660300002)(8936002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: q68DcR57XxxSCUVbf9nGt2E2iCiwE+n5yRxB6bnOCwi44JXdis+slg5bX/EjQjekJidNF5VJVv7BMvuuGaWuZ7F2ndv+sXxRfjFr8wY0J5hacyNNpnFnZ6zWEsdK79nNvoHVjTZqqknOyzlkMZbCpnCy04QEdwsiq1lEYHXL7MofXh0TUnf7P4Mu6QdVMWbgCTVNpb86IP1aPHHeGBilG/QorQaE6lw5pEt6aTApM4++bdeZappUbH1r/pPxPzLaRRMhB1hL60pz5NTakEehCD5GTopPjBbMY5eAcm+XuVHYf1ty+DBb5mBTt7BEFypJr67C7jqF8ffle8qDXnbxazAKphXDR545VH1BdqQ1EF2ma/K9ihXvJtIoWTgmzo0mpgCpPDgul+2cm8i7HPWlLefcII9pkq74yqIAEx104cA6M8MlFFLi4n86XqdSchsQysN/52mGUzIiW1/Zfb+ORiiNyY/Z7KY6llSff9nMD4xGtPzwa4rPkFy5bWK9vaJ0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9526978c-7c75-4a78-53d5-08d80ef44884
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 17:16:02.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNp/oXZWmPCWT9A9UdVmSL6yJLa6Lo69aYZlu3NouBPBD8F7lIhLR/QFVyCfDAiWiwA9xwqcFSrVGxKcKYAVUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> On 2020-06-11 16:51, Bharat Kumar Gogada wrote:
>=20
> [...]
>=20
> >> > +/**
> >> > + * xilinx_cpm_pcie_init_port - Initialize hardware
> >> > + * @port: PCIe port information
> >> > + */
> >> > +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port
> >> > *port)
> >> > +{
> >> > +	if (cpm_pcie_link_up(port))
> >> > +		dev_info(port->dev, "PCIe Link is UP\n");
> >> > +	else
> >> > +		dev_info(port->dev, "PCIe Link is DOWN\n");
> >> > +
> >> > +	/* Disable all interrupts */
> >> > +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> >> > +		   XILINX_CPM_PCIE_REG_IMR);
> >> > +
> >> > +	/* Clear pending interrupts */
> >> > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> >> > +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> >> > +		   XILINX_CPM_PCIE_REG_IDR);
> >> > +
> >> > +	/* Enable all interrupts */
> >> > +	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
> >> > +		   XILINX_CPM_PCIE_REG_IMR);
> >> > +	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
> >> > +		   XILINX_CPM_PCIE_REG_IDRN_MASK);
> >>
> >> No. I've explained in the previous review why this was a terrible
> >> thing to do, and my patch got rid of it for a good reason.
> >>
> >> If the mask/unmask calls do not work, please explain what is wrong,
> >> and let's fix them. But we DO NOT enable interrupts outside of an
> >> irqchip callback, full stop.
> > The issue here is, we do not have any other register to enable
> > interrupts for above events, in order to see an interrupt assert for
> > these events, the respective mask bits shall be set to 1.
>=20
> I still disagree, because you're not explaining anything.
>=20
> We enable the interrupts as they are requested already (that's why we wri=
te
> to the these register in the respective mask/unmask callbacks). Why do yo=
u
> need to enable them ahead of the request?
HI Marc,
Yes agreed, this is not needed.=20
In xilinx_cpm_unmask_event_irq {
...
val |=3D d->hwirq; 	//which needs to be BIT(d->hwirq)
...
}=20
Did not notice this earlier that the required bit is not being set here.
Will fix it next patch.

Regards,
Bharat
=20
