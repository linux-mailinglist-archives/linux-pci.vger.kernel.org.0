Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5114303DDF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 13:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391915AbhAZM4n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 07:56:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404138AbhAZM4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 07:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611665691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/k87fvwAVxIbqpDlDjqYev8POnbfvLdlH/1Fc3eH7k=;
        b=VWZZ8/Qo37R3/73dMaGgmDiwhZtRXVce3lWkESYcAHLK1pVUCpbEfeju7d32+H1ymwIPyG
        h2aK3npbdCEjBWArHRYKYhTUZEqJGPTfihDyMntOvdNU1lA+qlOgn9Oh0A4e1CbaNbGJzf
        QhQCBl/u5jESthhHp9NfRydyb5hV8Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-sr84HsX9PeyKyHEQrtn-uQ-1; Tue, 26 Jan 2021 07:54:49 -0500
X-MC-Unique: sr84HsX9PeyKyHEQrtn-uQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9E54801AAC;
        Tue, 26 Jan 2021 12:54:47 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404805D751;
        Tue, 26 Jan 2021 12:54:47 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     prarit@redhat.com
Cc:     bhelgaas@google.com, corbet@lwn.net, leon@kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        mstowe@redhat.com
Subject: Re: [PATCH] pci-driver: Add driver load messages
Date:   Tue, 26 Jan 2021 07:54:46 -0500
Message-Id: <20210126125446.1118325-1-prarit@redhat.com>
In-Reply-To: <20210126063935.GC1053290@unreal>
References: <20210126063935.GC1053290@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  Leon Romanovsky <leon@kernel.org> wrote:
> On Mon, Jan 25, 2021 at 02:41:38PM -0500, Prarit Bhargava wrote:
> > There are two situations where driver load messages are helpful.
> >
> > 1) Some drivers silently load on devices and debugging driver or system
> > failures in these cases is difficult.  While some drivers (networking
> > for example) may not completely initialize when the PCI driver probe() function
> > has returned, it is still useful to have some idea of driver completion.
> 
> Sorry, probably it is me, but I don't understand this use case.
> Are you adding global to whole kernel command line boot argument to debug
> what and when?
> 
> During boot:
> If device success, you will see it in /sys/bus/pci/[drivers|devices]/*.
> If device fails, you should get an error from that device (fix the
> device to return an error), or something immediately won't work and
> you won't see it in sysfs.
> 

What if there is a panic during boot?  There's no way to get to sysfs.
That's the case where this is helpful.

> During run:
> We have many other solutions to get debug prints during run, for example
> tracing, which is possible to toggle dynamically.
> 
> Right now, my laptop will print 34 prints on boot and endless amount during
> day-to-day usage.
> 
> ➜  kernel git:(rdma-next) ✗ lspci |wc -l
> 34
> 
> >
> > 2) Storage and Network device vendors have relatively short lives for
> > some of their hardware.  Some devices may continue to function but are
> > problematic due to out-of-date firmware or other issues.  Maintaining
> > a database of the hardware is out-of-the-question in the kernel as it would
> > require constant updating.  Outputting a message in the log would allow
> > different OSes to determine if the problem hardware was truly supported or not.
> 
> And rely on some dmesg output as a true source of supported/not supported and
> making this ABI which needs knob in command line. ?

Yes.  The console log being saved would work as a true source of load
messages to be interpreted by an OS tool.  But I see your point about the
knob below...

> 
> >
> > Add optional driver load messages from the PCI core that indicates which
> > driver was loaded, on which slot, and on which device.
> 
> Why don't you add simple pr_debug(..) without any knob? You will be able
> to enable/disable it through dynamic prints facility.

Good point.  I'll wait for more feedback and submit a v2 with pr_debug.

P.

> 
> Thanks

