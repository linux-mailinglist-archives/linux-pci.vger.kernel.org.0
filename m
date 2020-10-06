Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10865284647
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 08:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgJFGsA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 02:48:00 -0400
Received: from mail-eopbgr1320090.outbound.protection.outlook.com ([40.107.132.90]:22112
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbgJFGr7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Oct 2020 02:47:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBum74X5sMFgCPPSJEbCay9QjFEYc3G03vAytP98xjyv69n8augFd4ulJnyb+nwLk7KUZ8Uu05Y54lwt9/vgE/tMDQnjaYCuHVeGx0M4UAuaNJVWJ21b6ecruOszL3HEbaxmuCE59smqLGjHxoBmLwVqLaOwFjHpglulxX6swQQnlTQRYswcobvUFmD0+IpuJJQh5/WZu7Ad9UYD4C/D1LDtwi/Bc1LLBlYt4XQQuS25DMKfXcm3Cn4DGBbkM+eQxo06U7wFKC70Gqg5SrlVZRw7YhjXIlNfbG2o389RplJJUVTjo0h3HvNrA/Ehcw/ovl4oUFZ62BkD+lwaLyCj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srKEMQW5ZX8c5irQH0CrbA5OENVdARfyYlRvAFlh6YY=;
 b=JfhnejT4QlOsLXpCzQmDUW50x2uvawqiLOIqdPOoWRqJWH6LbmqZiK/u25LIionr37fIzS2aL0OmW+Rpuylqd1e0R1vwz/zr7XZ6JG17T3AlXnR1bvjkMXpcY644T8V0EVXiNDlHIv9Pw9BTHuaPzBrxbw+nkvr5z9JDhhPILeJsH44sNiALZFhXntLFHW8xf+u9YNjddgxuzD+cOb/GY8xGF6W5JFcn4F/kVujsUar2DUOu1ahxJC5Mgw2IlNTBbhkd2juaR5IUP5OxmHypOk+dws333vPraJ4sjSWz/AsiBJcV1W3xpOKZcPgy4fEEaQEdQv8TVx5lM3lbBgUxVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srKEMQW5ZX8c5irQH0CrbA5OENVdARfyYlRvAFlh6YY=;
 b=CpD82TAOUPimMQUP2pcBHiCqv9vgQscdp9wVinp9jI3NDKOSD7oPO43NkzKWZ+kCb5G6nhuoI/qdvxPgsAbWZFFn2uPWU5YFr+7rVXTF1Ydjln+fz1EpNbhKFO83rdu34WoJ4tUljyfBhcBBsWqjHKP5IAxv1Io/Lmfa76C04Uo=
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1a::17)
 by KL1P15301MB0005.APCP153.PROD.OUTLOOK.COM (2603:1096:802:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.10; Tue, 6 Oct
 2020 06:47:45 +0000
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::31a4:e5b8:86ec:1413]) by KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::31a4:e5b8:86ec:1413%9]) with mapi id 15.20.3477.011; Tue, 6 Oct 2020
 06:47:45 +0000
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
Subject: irq_build_affinity_masks() allocates improper affinity if
 num_possible_cpus() > num_present_cpus()?
Thread-Topic: irq_build_affinity_masks() allocates improper affinity if
 num_possible_cpus() > num_present_cpus()?
Thread-Index: AdabnwA0SBdvouNFQ4iAnKm72ZKc6Q==
Date:   Tue, 6 Oct 2020 06:47:45 +0000
Message-ID: <KU1P153MB0120D20BC6ED8CF54168EEE6BF0D0@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=964c4bb6-4b17-4071-82b8-a4096ef94de1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-10-05T06:20:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:e92f:2b81:6f33:777]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78cb545e-ede0-49f7-6e7e-08d869c3bb8c
x-ms-traffictypediagnostic: KL1P15301MB0005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1P15301MB00057DB7A4B11635876E8642BF0D0@KL1P15301MB0005.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XuXpjKLsOaAcbCWtWlu6ehp8ZOuuSOrgwqrBtVTJqCNCnwJnIoL9ATVb3BEqjLD2swicJuceumz/eZwqb0NjmC2RmFXpEABqKahutcl98K3EA9wDlRZtwmxLnZ6fjoVBS+AiFMReoVdNEtiCyVCJ/T6743SMxN68qd3gtlMjz5rW5RNk0w9MIWg75NAcj0lj23hRvDHwa29MFSeXho+lyTHZQ/H7V3nCe/fxd5eDpQWHHOS3U0F2VP9raeTJn738qnYq04aOlW5P+KLk8/SabDwGq/PpTaPQ5jUv3JwnrPL2YBJlc/uwQt4Kr3oJJuwU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0120.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(86362001)(2906002)(71200400001)(5660300002)(52536014)(82960400001)(82950400001)(10290500003)(4326008)(9686003)(8936002)(8676002)(107886003)(8990500004)(83380400001)(478600001)(7696005)(6506007)(110136005)(55016002)(54906003)(33656002)(66446008)(66476007)(66946007)(66556008)(64756008)(76116006)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BPcugSDuIB2h/dw+ZT7P1E11Wzy3DMarAnjF0/z7KIPzkpyP8BfG31yUqRlsGrIS1Q0iqoLgVHAx9f6Qa51zvYlcVVKOLaK4PjA/e8+7dFv6ff1jGJO4l43OUgfEIcrbe4eczN1tfYN0/CJ7/vyQTwMkiXTxCLiVHr/ZtVvNN/gaKyFhp18B6+58F2Yas+B5Q6+JM7vhau3LuiZmnKIp6lPNsdwd/O9ThEFV1ia4l5yDVZ3usWUxPLcxDxFhDWD6loAqWBFwG0y8SI5asQYqLfngveOk3FrmWPH1Ae+5wCk+75Q4zNqpSPyzep0yN1VLsS2cF6CZU5vFxKY96ih8pOujhb9MggXq5fSitgZCXk58p+Ct4duUoCCvmqb/8CKfPkXyyQ3bRKiJEKz0l2tXayduSFijIuSAWAYGxJjtfOnPbIc/XOjYVIQGRqUzicdNL+xlVvFy/Rdz4aH5sxjoN1vG7utUr36g2cvBs/7ZOiymbrLn3eXTzIauuSK6b0OzttT2zcxRVihYk25hEt4ZWGhazp5ChbB2ZftcN4Qe+CHjqvDKZcfBrMm9kVlhbJcG6hsBAGD335LlK3E3G5+u8CE73oFTdoYevUAvNI4Mg2OQ0invQCq8s88y4gmtnYwsoVxFFvzjiC46QP5L+j0gKTpt1pbMwUVml6/r864N9HPgsKVfDZNgNTzOs9x2pkMqG91IdS1rbqNWytkgB1Fm2w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cb545e-ede0-49f7-6e7e-08d869c3bb8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 06:47:45.4549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HzcfM4bDN9pekRntqiF016s9zco2Oqu5uae/SMLdr0ZmNa6VikUhFi0U63zcfAPuYKyg1Xsn+fPpZZJU8Oy/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0005
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,
I'm running a single-CPU Linux VM on Hyper-V. The Linux kernel is v5.9-rc7
and I have CONFIG_NR_CPUS=3D256.

The Hyper-V Host (Version 17763-10.0-1-0.1457) provides a guest firmware,
which always reports 128 Local APIC entries in the ACPI MADT table. Here
only the first Local APIC entry's "Processor Enabled" is 1 since this
Linux VM is configured to have only 1 CPU. This means: in the Linux kernel,
the "cpu_present_mask" and " cpu_online_mask " have only 1 CPU (i.e. CPU0),
while the "cpu_possible_mask" has 128 CPUs, and the "nr_cpu_ids" is 128.

I pass through an MSI-X-capable PCI device to the Linux VM (which has
only 1 virtual CPU), and the below code does *not* report any error
(i.e. pci_alloc_irq_vectors_affinity() returns 2, and request_irq()
returns 0), but the code does not work: the second MSI-X interrupt is not
happening while the first interrupt does work fine.

int nr_irqs =3D 2;
int i, nvec, irq;

nvec =3D pci_alloc_irq_vectors_affinity(pdev, nr_irqs, nr_irqs,
                PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, NULL);

for (i =3D 0; i < nvec; i++) {
        irq =3D pci_irq_vector(pdev, i);
        err =3D request_irq(irq, test_intr, 0, "test_intr", &intr_cxt[i]);
}

It turns out that pci_alloc_irq_vectors_affinity() -> ... ->
irq_create_affinity_masks() allocates an improper affinity for the second
interrupt. The below printk() shows that the second interrupt's affinity is
1-64, but only CPU0 is present in the system! As a result, later,
request_irq() -> ... -> irq_startup() -> __irq_startup_managed() returns
IRQ_STARTUP_ABORT because cpumask_any_and(aff, cpu_online_mask) is=20
empty (i.e. >=3D nr_cpu_ids), and irq_startup() *silently* fails (i.e. "ret=
urn 0;"),
since __irq_startup() is only called for IRQ_STARTUP_MANAGED and
IRQ_STARTUP_NORMAL.

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -484,6 +484,9 @@ struct irq_affinity_desc *
        for (i =3D affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
                masks[i].is_managed =3D 1;

+       for (i =3D 0; i < nvecs; i++)
+               printk("i=3D%d, affi =3D %*pbl\n", i,
+                      cpumask_pr_args(&masks[i].mask));
        return masks;
 }

[   43.770477] i=3D0, affi =3D 0,65-127
[   43.770484] i=3D1, affi =3D 1-64

Though here the issue happens to a Linux VM on Hyper-V, I think the same
issue can also happen to a physical machine, if the physical machine also
uses a lot of static MADT entries, of which only the entries of the present
CPUs are marked to be "Processor Enabled =3D=3D 1".

I think pci_alloc_irq_vectors_affinity() -> __pci_enable_msix_range() ->
irq_calc_affinity_vectors() -> cpumask_weight(cpu_possible_mask) should
use cpu_present_mask rather than cpu_possible_mask (), so here
irq_calc_affinity_vectors() would return 1, and
__pci_enable_msix_range() would immediately return -ENOSPC to avoid a
*silent* failure.

However, git-log shows that this 2018 commit intentionally changed the
cpu_present_mask to cpu_possible_mask:
84676c1f21e8 ("genirq/affinity: assign vectors to all possible CPUs")

so I'm not sure whether (and how?) we should address the *silent* failure.

BTW, here I use a single-CPU VM to simplify the discussion. Actually,
if the VM has n CPUs, with the above usage of
pci_alloc_irq_vectors_affinity() (which might seem incorrect, but my point =
is
that it's really not good to have a silent failure, which makes it a lot mo=
re=20
difficult to figure out what goes wrong), it looks only the first n MSI-X i=
nterrupts
can work, and the (n+1)'th MSI-X interrupt can not work due to the allocate=
d
improper affinity.

According to my tests, if we need n+1 MSI-X interrupts in such a VM that
has n CPUs, it looks we have 2 options (the second should be better):

1. Do not use the PCI_IRQ_AFFINITY flag, i.e.
        pci_alloc_irq_vectors_affinity(pdev, n+1, n+1, PCI_IRQ_MSIX, NULL);

2. Use the PCI_IRQ_AFFINITY flag, and pass a struct irq_affinity affd,
which tells the API that we don't care about the first interrupt's affinity=
:

        struct irq_affinity affd =3D {
                .pre_vectors =3D 1,
				...
        };

        pci_alloc_irq_vectors_affinity(pdev, n+1, n+1,
                PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);

PS, irq_create_affinity_masks() is complicated. Let me know if you're
interested to know how it allocates the invalid affinity "1-64" for the
second MSI-X interrupt.

PS2, the latest Hyper-V provides only one ACPI MADT entry to a 1-CPU VM,
so the issue described above can not reproduce there.

Thanks,
-- Dexuan
