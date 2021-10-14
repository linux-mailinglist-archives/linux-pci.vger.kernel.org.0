Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013A342D07D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 04:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhJNChb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 22:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNChb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 22:37:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F389CC061570;
        Wed, 13 Oct 2021 19:35:26 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i20so17633379edj.10;
        Wed, 13 Oct 2021 19:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYewlEnLh1xEH6fv6mA/Vp3Qb4QrtKs48P+b1W7Yd2E=;
        b=foYJfeyJYtGj52Yv7GfTbfnZPED2j9Ph52FZ2sMYwOLOyMaNhyH+bQZ/OG7Mgob7gE
         hac/W4i+gA9NlPmfiIvV1tbNUhq0oV7fs+gs0CPmx1TLReIwsGoGhk5MhN6b6wjg/4vK
         QrqavYmLUNlCWG48lh28v8Yxw75FHiTBKuvzqd6ZzGoAE+9hFSIfvg21Q/8a4B3ZA4VN
         pbaA8V9Pjqk6BBeDeBDlA6A1EyL8wVuS19MjNDjUvJ4RlSWGcnjaV+4gqnfIsVQbSMy4
         jx2bOvZjKveOF+vbv0gvi7p8lxGjEwF6YS8Cw/ADKyazzcG0iWyGFBrXYMgiz8FEvj//
         AE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYewlEnLh1xEH6fv6mA/Vp3Qb4QrtKs48P+b1W7Yd2E=;
        b=ddnN8qCe/k3UU9WFy4MbxmC209SttYIdEA2bHUzhKR4aVIJZnapTKwQ2OGpBvLI4q3
         UEhRe2FU0mnnYdKW3O15IgRlXrBXVeTOfwMO59zBqXm6Vu9mJO0zIbV4v+aVTHRpVxug
         ektwwkdf5PWlFKkJPkrnqMguFZ6Rm6izvP/Ucg5VFG+LuZ3vL8xah1KADUHMODuBsFUW
         CT+AFxeTu549c5vb6BwBpBHw6zI7ZhpZ0b8h22dfA5SiY5tdCpKaFVWUdA6IfrFWzz4I
         jrIzkmItKuNjXHPJP0gES6bXmtmQrIZdhSt0vO7Tl9mYMcRaluk2enYZMBwIH8/xiIQq
         weBw==
X-Gm-Message-State: AOAM531G6i+AsXGQrH2wkYm1McvhMLbWahOQ1RrXRW4NaGafqUoisD1V
        I4fnjBpeB5LO5cMTYWa+K2d1RtYLlSzVYs8K/3I=
X-Google-Smtp-Source: ABdhPJxSGOsE6nhwBEHGZXdn8PXn1whsbMWu/Lccr3YsEns9RkrD+teDx4HcLWhuKPDgKri9hcpJib52+nDpjxZsTSU=
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr591240ejb.139.1634178925562;
 Wed, 13 Oct 2021 19:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211013125542.759696-1-imagedong@tencent.com> <20211013190014.GA1909934@bhelgaas>
In-Reply-To: <20211013190014.GA1909934@bhelgaas>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 14 Oct 2021 10:34:52 +0800
Message-ID: <CADxym3aDdT+gUJrhxKT3DXcP-V0_vCa2sHNZuP1RUxgLKJAGaA@mail.gmail.com>
Subject: Re: [PATCH] pci: call _cond_resched() after pci_bus_write_config
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, Oct 14, 2021 at 3:00 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
[...]
>
> s/pci/PCI/ above.
> Add space before "(".
> Add "()" after function names consistently (some have it, some don't).

Thanks, get it!

>
> What exactly is the problem?  I expect __pci_bus_assign_resources() to
> be used mostly during boot-time enumeration.  How much of a problem is
> the latency at that point?  Why is this particularly a problem in the
> KVM environment?  Or is it also a problem on bare metal?
>

In fact, this is a problem on KVM when hotplug virtual devices. The
initialization
of this devices will be done in a workqueue, which can be seen from the call
stack:

62485   62485   kworker/u8:0    pcibios_resource_survey_bus
        b'pcibios_resource_survey_bus+0x1 [kernel]'
        b'acpiphp_check_bridge.part.13+0x11c [kernel]'
        b'acpiphp_hotplug_notify+0x14b [kernel]'
        b'acpi_device_hotplug+0xe0 [kernel]'
        b'acpi_hotplug_work_fn+0x1e [kernel]'
        b'process_one_work+0x19f [kernel]'
        b'worker_thread+0x37 [kernel]'
        b'kthread+0x117 [kernel]'
        b'ret_from_fork+0x24 [kernel]'

And __pci_bus_assign_resources() will be called too. However, as the device
is virtual, it is simulated by qemu, which makes its pci config can't be written
directly. During pci config writing, it will cause KVM exit guest mode and qemu
in HOST can process the pci config writing. Therefore, the kworker in KVM will
block the CPU.

It is't a problem on bare metal.

The latency can be different in different machines. With 4-core CPU and 2G
memory, single pci config writing can cost 1-2ms, and
__pci_bus_assign_resources()
can cost up to 30ms.


> Are there other config write paths that should have a similar change?
>
> _cond_resched() only appears here:
>
>   $ git grep "\<_cond_resched\>"
>   include/linux/sched.h:static __always_inline int _cond_resched(void)
>   include/linux/sched.h:static inline int _cond_resched(void)
>   include/linux/sched.h:static inline int _cond_resched(void) { return 0; }
>   include/linux/sched.h:  _cond_resched();
>
> so I don't believe PCI is so special that this needs to be the only
> other use.  Maybe a different resched interface is more appropriate?

Seems _cond_resched() is not directly used any more. cond_resched()
should be used here.

Thanks!
Menglong Dong
