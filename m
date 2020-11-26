Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E782C4DC0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 04:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgKZDW1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 22:22:27 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbgKZDW1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 22:22:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ChNNd275Sz9sRK;
        Thu, 26 Nov 2020 14:22:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1606360945;
        bh=yX9WEAmDETJStycvdfhm5xjpOuROvlTMfef+2IZNRzo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=caJVE16kPD5T5w1YfQUtCJ82yfv3OPIrIBflantGq+tUNWi4NV9lzL0hp86igcHKG
         mXPBYm3z7KHBmNWucFw+VsUhHCkMEqGu2N1EdLYgGS6NR3XCkYW4MgLPnau1sEugOe
         h2fgo+qYSD4ewJKcXYHIicyXCuFVCHwKdVbSXcclkwcOtrVtozBz0lSB8trFWngWrA
         G3t/eSVPnoZLQNKdAuVGXVvGIVEEEMau9zw0h8aghk5BF1O7ODUOW4kPAMBREPWVaC
         V9GH2Ksr94sZw80vcKoxstOyv43ZsrkdJw+jcPbV3Dk0PJMo/V28gCgnHKak8k8pgB
         OEFipznFGoqQg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Marc Zyngier <maz@kernel.org>, Laurent Vivier <lvivier@redhat.com>
Cc:     Denis Kirjanov <kda@linux-powerpc.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paul Mackerras <paulus@samba.org>, Greg Kurz <groug@kaod.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-block@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to irq_create_mapping()
In-Reply-To: <5419d1790c9ea0d9d7791ae887794285@kernel.org>
References: <20201125150932.1150619-1-lvivier@redhat.com> <20201125150932.1150619-3-lvivier@redhat.com> <CAOJe8K1Q7sGf67bdj-2Mthkj4XNR4fOSskV1dyh62AdzefhpAQ@mail.gmail.com> <7184880b-0351-ae18-d2e1-fab7b79fc864@redhat.com> <5419d1790c9ea0d9d7791ae887794285@kernel.org>
Date:   Thu, 26 Nov 2020 14:22:24 +1100
Message-ID: <87360wztsf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:
> On 2020-11-25 16:24, Laurent Vivier wrote:
>> On 25/11/2020 17:05, Denis Kirjanov wrote:
>>> On 11/25/20, Laurent Vivier <lvivier@redhat.com> wrote:
>>>> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
>>>> 
>>>> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ 
>>>> affinity")
>>>> this is broken on pseries.
>>> 
>>> Please add "Fixes" tag.
>> 
>> In fact, the code in commit 0d9f0a52c8b9f is correct.
>> 
>> The problem is with MSI/X irq affinity and pseries. So this patch
>> fixes more than virtio_scsi. I put this information because this
>> commit allows to clearly show the problem. Perhaps I should remove
>> this line in fact?
>
> This patch does not fix virtio_scsi at all, which as you noticed, is
> correct. It really fixes the PPC MSI setup, which is starting to show
> its age. So getting rid of the reference seems like the right thing to 
> do.

It's still useful to refer to that commit if the code worked prior to
that commit. But you should make it clearer that 0d9f0a52c8b9f wasn't in
error, it just exposed an existing shortcoming of the arch code.

cheers
