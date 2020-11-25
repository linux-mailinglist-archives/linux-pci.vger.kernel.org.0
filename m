Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85FC2C470E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 18:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgKYRv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 12:51:58 -0500
Received: from 1.mo52.mail-out.ovh.net ([178.32.96.117]:58771 "EHLO
        1.mo52.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYRv6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 12:51:58 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.21])
        by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 3A81A217625;
        Wed, 25 Nov 2020 18:34:19 +0100 (CET)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 25 Nov
 2020 18:34:18 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-105G006b56b7170-7741-40ac-97e5-c5413baab032,
                    13817E1CA0648EB9EE095497159C33290D197662) smtp.auth=groug@kaod.org
Date:   Wed, 25 Nov 2020 18:34:12 +0100
From:   Greg Kurz <groug@kaod.org>
To:     Marc Zyngier <maz@kernel.org>
CC:     Laurent Vivier <lvivier@redhat.com>,
        Denis Kirjanov <kda@linux-powerpc.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        <linux-block@vger.kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to
 irq_create_mapping()
Message-ID: <20201125183412.351c96ee@bahia.lan>
In-Reply-To: <5419d1790c9ea0d9d7791ae887794285@kernel.org>
References: <20201125150932.1150619-1-lvivier@redhat.com>
        <20201125150932.1150619-3-lvivier@redhat.com>
        <CAOJe8K1Q7sGf67bdj-2Mthkj4XNR4fOSskV1dyh62AdzefhpAQ@mail.gmail.com>
        <7184880b-0351-ae18-d2e1-fab7b79fc864@redhat.com>
        <5419d1790c9ea0d9d7791ae887794285@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: d6bac3c7-d957-44cb-8e9b-55ca8dec327a
X-Ovh-Tracer-Id: 10779928659030088123
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudehtddguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtghomh
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 25 Nov 2020 16:42:30 +0000
Marc Zyngier <maz@kernel.org> wrote:

> On 2020-11-25 16:24, Laurent Vivier wrote:
> > On 25/11/2020 17:05, Denis Kirjanov wrote:
> >> On 11/25/20, Laurent Vivier <lvivier@redhat.com> wrote:
> >>> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
> >>> 
> >>> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ 
> >>> affinity")
> >>> this is broken on pseries.
> >> 
> >> Please add "Fixes" tag.
> > 
> > In fact, the code in commit 0d9f0a52c8b9f is correct.
> > 
> > The problem is with MSI/X irq affinity and pseries. So this patch
> > fixes more than virtio_scsi. I put this information because this
> > commit allows to clearly show the problem. Perhaps I should remove
> > this line in fact?
> 
> This patch does not fix virtio_scsi at all, which as you noticed, is
> correct. It really fixes the PPC MSI setup, which is starting to show
> its age. So getting rid of the reference seems like the right thing to 
> do.
> 
> I'm also not keen on the BugId thing. It should really be a lore link.
> I also cannot find any such tag in the kernel, nor is it a documented
> practice. The last reference to a Bugzilla entry seems to have happened
> with 786b5219081ff16 (five years ago).
> 

My bad, I suggested BugId to Laurent but the intent was actually BugLink,
which seems to be commonly used in the kernel.

Cheers,

--
Greg

> Thanks,
> 
>          M.

