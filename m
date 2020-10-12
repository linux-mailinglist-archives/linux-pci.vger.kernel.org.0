Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C6F28C180
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgJLTbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 15:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgJLTbN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 15:31:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA330C0613D0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 12:31:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602531072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHrabMxYiUMlfO+zneVI5FcOiTzjdvrskyScyersJz8=;
        b=jRdYcyr2ax2zPYHYK0Pcgck+baGKDxApdmGEDyqdAQVLpaSV/Awm90bM+C8mJLF3gNvpu6
        TwObJNNWhooAULVCf/lldKbiqC+ckCLqZs5Zxgi1c9pjMHuHgiHczvXwiiqO7w667hQn4D
        u+qbrhsN01ez1nqQT68VxIKaA+Tm99BbF+EeVbiOVQHedMVYElPQf5j4v9PQKk2VrX5LyY
        UWwQJeiOntALIAEXZjL0Lwi9MbiqEBKpN6e56taKKJ20yOqyhlI84mMReFaPlJgjM8A9k9
        GfKCpdxpo0wJfDuYhGcvQPYm71M42jzb2nKCpHdzn67BMoxmnD09p+SNtAe0JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602531072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHrabMxYiUMlfO+zneVI5FcOiTzjdvrskyScyersJz8=;
        b=RZMY9ELNlcShjqWy/Kz+ioDChl0Bv16ePgyG8wxfwgEI2iL/crZQ14OhPqXRW0MuJ9S2YC
        ZSBXXOPL6+fVteCA==
To:     Chris Friesen <chris.friesen@windriver.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: PCI, isolcpus, and irq affinity
In-Reply-To: <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com>
References: <20201012165839.GA3732859@bjorn-Precision-5520> <87a6wrqqpf.fsf@nanos.tec.linutronix.de> <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com>
Date:   Mon, 12 Oct 2020 21:31:11 +0200
Message-ID: <87zh4rp7gg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12 2020 at 12:58, Chris Friesen wrote:
> On 10/12/2020 11:50 AM, Thomas Gleixner wrote:
>> On Mon, Oct 12 2020 at 11:58, Bjorn Helgaas wrote:
>>> On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
>>>> I've got a linux system running the RT kernel with threaded irqs.=C2=
=A0 On
>>>> startup we affine the various irq threads to the housekeeping CPUs, bu=
t I
>>>> recently hit a scenario where after some days of uptime we ended up wi=
th a
>>>> number of NVME irq threads affined to application cores instead (not g=
ood
>>>> when we're trying to run low-latency applications).
>>=20
>> These threads and the associated interupt vectors are completely
>> harmless and fully idle as long as there is nothing on those isolated
>> CPUs which does disk I/O.
>
> Some of the irq threads are affined (by the kernel presumably) to=20
> multiple CPUs (nvme1q2 and nvme0q2 were both affined 0x38000038, a=20
> couple of other queues were affined 0x1c00001c0).
>
> In this case could disk I/O submitted by one of those CPUs end up=20
> interrupting another one?

On older kernels, yes.

X86 enforces effective single CPU affinity for interrupts since v4.15.

The associated irq thread is always following the hardware effective
interrupt affinity since v4.17.

The hardware interrupt itself is routed to a housekeeping CPU in the
affinity mask as long as there is one online since v5.6.

Thanks,

        tglx

