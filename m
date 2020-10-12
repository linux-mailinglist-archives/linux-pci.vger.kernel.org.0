Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2DC28C194
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgJLTow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 15:44:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbgJLTov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 15:44:51 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602531890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYmlo3gIKnvyGkQNhEFsh3Oj9v54efF9SX1zqLsGXmY=;
        b=JzApwxHT7TdexbrKX5jSdk0hhGkEuUFBp8qLxFICke/Ufi6teCqQ3omDorsjZpuYlryHs4
        uZm4ziYvZo+CCsGbUgF72uX+hrkHZxa8bIVmo5swohrrGWV9qf2NW60hziBJtj+KUUUanh
        1iqFxFRr9+z1Fk0wkkQjxMNwr7b9IKHjKdBoFinmNoJ6pFOFfj1wuGehZwRI+yHwzYtrYx
        5huWFowMZyTrd1nFvUQ2tbid+6Xu/+3Sy+vfPdbawV9ZfKEoP3ZD2lON4eMW1DamqntpoD
        GR+AYqzfyQROiCfbq9X2Ue/Vde/vjqnxGfYhZRVYHUxTwDlK9GzOi4DzqvRaBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602531890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYmlo3gIKnvyGkQNhEFsh3Oj9v54efF9SX1zqLsGXmY=;
        b=BJI5PA0sW6SDYm4qmQWoRAVPcAS0l0GPX0RWlEk/cczPFIlc91aknewh+URiQMRmlWOzUh
        7vpXr5M1QlY0yiAQ==
To:     Keith Busch <kbusch@kernel.org>,
        Chris Friesen <chris.friesen@windriver.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: PCI, isolcpus, and irq affinity
In-Reply-To: <20201012190726.GB1032142@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201012165839.GA3732859@bjorn-Precision-5520> <87a6wrqqpf.fsf@nanos.tec.linutronix.de> <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com> <20201012190726.GB1032142@dhcp-10-100-145-180.wdl.wdc.com>
Date:   Mon, 12 Oct 2020 21:44:49 +0200
Message-ID: <87tuuzp6tq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12 2020 at 12:07, Keith Busch wrote:

> On Mon, Oct 12, 2020 at 12:58:41PM -0600, Chris Friesen wrote:
>> On 10/12/2020 11:50 AM, Thomas Gleixner wrote:
>> > On Mon, Oct 12 2020 at 11:58, Bjorn Helgaas wrote:
>> > > On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
>> > > > I've got a linux system running the RT kernel with threaded irqs.=
=C2=A0 On
>> > > > startup we affine the various irq threads to the housekeeping CPUs=
, but I
>> > > > recently hit a scenario where after some days of uptime we ended u=
p with a
>> > > > number of NVME irq threads affined to application cores instead (n=
ot good
>> > > > when we're trying to run low-latency applications).
>> >=20
>> > These threads and the associated interupt vectors are completely
>> > harmless and fully idle as long as there is nothing on those isolated
>> > CPUs which does disk I/O.
>>=20
>> Some of the irq threads are affined (by the kernel presumably) to multip=
le
>> CPUs (nvme1q2 and nvme0q2 were both affined 0x38000038, a couple of other
>> queues were affined 0x1c00001c0).
>
> That means you have more CPUs than your controller has queues. When that
> happens, some sharing of the queue resources among CPUs is required.
>=20=20
>> In this case could disk I/O submitted by one of those CPUs end up
>> interrupting another one?
>
> If you dispatch IO from any CPU in the mask, then the completion side
> wakes the thread to run on one of the CPUs in the affinity mask.

Pre 4.17, yes.

From 4.17 onwards the irq thread is following the effective affinity of
the hardware interrupt which is a single CPU target.

Since 5.6 the effective affinity is steered to a housekeeping CPU if the
cpumask of a queue spawns multiple CPUs.

Thanks,

        tglx
