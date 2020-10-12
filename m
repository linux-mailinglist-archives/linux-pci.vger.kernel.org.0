Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E404728BF35
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404029AbgJLRuG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403994AbgJLRuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 13:50:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9427BC0613D0
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2020 10:50:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602525005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VeZlZ50ReymhYGkvS+jYSRXaJvWO98RlP7GMjyjOzUo=;
        b=AmPX+aKJ0nHSE0AudD4qHsKLf4v/LVzgBkRGOkGkvdg9aNqQAfE1OVQ4NRgSMxbmtZl+sH
        k0e5pEEfin9fbPIPXXO+Vhc5xmbvM+X4DqOjQ+jrC2fj8/8g1Eu47mlLXvAuNOAbz0gwcC
        Wj3Nl10qYjUDwH3Hdo0CLFcYcLxBklCLB1xYY/MJvwlR4CCvJdZZLVHRLkeAEuh4+JxBgK
        46DWmvmTIptTWJFMDMq+JpOw6mszySgD66Zxd98w/jEByM43c9GTg4Jgl/sJNplBqi+e49
        KKExIalsGri2FKnuD3bSoneiC05Ol+qgb9jpkQUxagT9W7/vdQT6/7vXan4o5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602525005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VeZlZ50ReymhYGkvS+jYSRXaJvWO98RlP7GMjyjOzUo=;
        b=A3nSupvBGV5DiczXQ/psRppMi2Ki2Qv/AkNnIBCvCbX+wq+Jl153v1xmUmmotfk/LD5cIj
        nqHLcjsvY0a16KCQ==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Chris Friesen <chris.friesen@windriver.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: PCI, isolcpus, and irq affinity
In-Reply-To: <20201012165839.GA3732859@bjorn-Precision-5520>
References: <20201012165839.GA3732859@bjorn-Precision-5520>
Date:   Mon, 12 Oct 2020 19:50:04 +0200
Message-ID: <87a6wrqqpf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12 2020 at 11:58, Bjorn Helgaas wrote:
> On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
>> I've got a linux system running the RT kernel with threaded irqs.=C2=A0 =
On
>> startup we affine the various irq threads to the housekeeping CPUs, but I
>> recently hit a scenario where after some days of uptime we ended up with=
 a
>> number of NVME irq threads affined to application cores instead (not good
>> when we're trying to run low-latency applications).

These threads and the associated interupt vectors are completely
harmless and fully idle as long as there is nothing on those isolated
CPUs which does disk I/O.

> pci_alloc_irq_vectors_affinity() basically just passes affinity
> information through to kernel/irq/affinity.c, and the PCI core doesn't
> change affinity after that.

Correct.

> This recent thread may be useful:
>
>   https://lore.kernel.org/linux-pci/20200928183529.471328-1-nitesh@redhat=
.com/
>
> It contains a patch to "Limit pci_alloc_irq_vectors() to housekeeping
> CPUs".  I'm not sure that patch summary is 100% accurate because IIUC
> that particular patch only reduces the *number* of vectors allocated
> and does not actually *limit* them to housekeeping CPUs.

That patch is a bandaid at best and for the managed interrupt scenario
not really preventing that interrupts + threads are affine to isolated
CPUs.

Thanks,

        tglx

