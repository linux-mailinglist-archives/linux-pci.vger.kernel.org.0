Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365AC2851FD
	for <lists+linux-pci@lfdr.de>; Tue,  6 Oct 2020 21:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgJFTA1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Oct 2020 15:00:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFTA0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Oct 2020 15:00:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602010824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8SQ0k7RLei+mK3UMQDWPVDraM3VGYk47tKS5XTJPEU=;
        b=Uy5kBvdctYZXM07+PHqZq72K/MYxqST8WcuVV2aJ7bI2RRp9+Hoo+hIbRMI2jNnG03EeJ/
        dLXkIlnNQhHbLhbqBL/hVKRAn2kLwbwwQML3U8GrRvDa4EQjNe6+O9PpcMqb/h5iUwiKkL
        rpkZR4HWO+gZ16di3YP40M3SwIcAx3lPhg/X7wi65YMTbEQEEJW1HduZKlpYGRX9l5/bZE
        rLrtKoEgZsR5s1wTHeN4sTaEQZkuMAE+hnv65Eq2clUakVBKie1uKpRw2A/V6VQGtdgkMc
        MA2v11SXbE123QdWkpBls2Qm+NbSmEocGjFehwf+118WKPKCzfVh3yhUMiCMYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602010824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F8SQ0k7RLei+mK3UMQDWPVDraM3VGYk47tKS5XTJPEU=;
        b=wO0Hply58Utt7IDcUrnj83TDombhYB2nXAEbIe/4ZPkYf8T75Mg+FtxAoWDAEpUe6q/2Mb
        NCdqgR+aISo8BmCw==
To:     David Woodhouse <dwmw2@infradead.org>,
        Dexuan Cui <decui@microsoft.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Long Li <longli@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: irq_build_affinity_masks() allocates improper affinity if num_possible_cpus() > num_present_cpus()?
In-Reply-To: <65ba8a8b86201d8906313fbacc4fb711b9b423af.camel@infradead.org>
References: <KU1P153MB0120D20BC6ED8CF54168EEE6BF0D0@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM> <65ba8a8b86201d8906313fbacc4fb711b9b423af.camel@infradead.org>
Date:   Tue, 06 Oct 2020 21:00:24 +0200
Message-ID: <87h7r76uyf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 06 2020 at 09:37, David Woodhouse wrote:
> On Tue, 2020-10-06 at 06:47 +0000, Dexuan Cui wrote:
>> PS2, the latest Hyper-V provides only one ACPI MADT entry to a 1-CPU VM,
>> so the issue described above can not reproduce there.
>
> It seems fairly easy to reproduce in qemu with -smp 1,maxcpus=3D128 and a
> virtio-blk drive, having commented out the 'desc->pre_vectors++' around
> line 130 of virtio_pci_common.c so that it does actually spread them.
>
> [    0.836252] i=3D0, affi =3D 0,65-127
> [    0.836672] i=3D1, affi =3D 1-64
> [    0.837905] virtio_blk virtio1: [vda] 41943040 512-byte logical blocks=
 (21.5 GB/20.0 GiB)
> [    0.839080] vda: detected capacity change from 0 to 21474836480
>
> In my build I had to add 'nox2apic' because I think I actually already
> fixed this for the x2apic + no-irq-remapping case with the max_affinity
> patch series=C2=B9. But mostly by accident.

There is nothing to fix. It's intentional behaviour. Managed interrupts
and their spreading (aside of the rather odd spread here) work that way.

And virtio-blk works perfectly fine with that.

Thanks,

        tglx
