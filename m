Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447F53421C6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhCSQYB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 12:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhCSQXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 12:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616171003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yMSSQE+266qMvhoobx6hI2uloJNeAdSSRsEhmgkNvM=;
        b=IqSrRBkw5chkul+IF8gINdPvig1fRaDLoe+XbP/Y7wXHF7wOUSKoNWU7tBSqGg/e6RFGlp
        h1Mo6ofkbbXfeJjGzG61beBjfjVFJbsDbdKxmiNJs39gbWdsiXi0FhJbWuAKIDx2GMdWs2
        Jve9JSJYmxv3pxcQMBbilWz8S1J2ZRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-ND2CEfwjMq-no1d6SPdBxw-1; Fri, 19 Mar 2021 12:23:16 -0400
X-MC-Unique: ND2CEfwjMq-no1d6SPdBxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B6E81044804;
        Fri, 19 Mar 2021 16:23:14 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF0DA1A86F;
        Fri, 19 Mar 2021 16:23:13 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:23:13 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210319102313.179e9969@omen.home.shazbot.org>
In-Reply-To: <YFSgQ2RWqt4YyIV4@unreal>
References: <YFHh3bopQo/CRepV@unreal>
        <20210317112309.nborigwfd26px2mj@archlinux>
        <YFHsW/1MF6ZSm8I2@unreal>
        <20210317131718.3uz7zxnvoofpunng@archlinux>
        <YFILEOQBOLgOy3cy@unreal>
        <20210317113140.3de56d6c@omen.home.shazbot.org>
        <YFMYzkg101isRXIM@unreal>
        <20210318103935.2ec32302@omen.home.shazbot.org>
        <YFOMShJAm4j/3vRl@unreal>
        <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
        <YFSgQ2RWqt4YyIV4@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Mar 2021 14:59:47 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Thu, Mar 18, 2021 at 07:34:56PM +0100, Enrico Weigelt, metux IT consult wrote:
> > On 18.03.21 18:22, Leon Romanovsky wrote:
> >   
> > > Which email client do you use?
> > > Your responses are grouped as one huge block without any chance to respond
> > > to you on specific point or answer to your question.  
> > 
> > I'm reading this thread in Tbird, and threading / quoting all looks
> > nice.  
> 
> I'm not talking about threading or quoting but about response itself.
> See it here https://lore.kernel.org/lkml/20210318103935.2ec32302@omen.home.shazbot.org/
> Alex's response is one big chunk without any separations to paragraphs.

I've never known paragraph breaks to be required to interject a reply.

Back on topic...

> >   
> > > I see your flow and understand your position, but will repeat my
> > > position. We need to make sure that vendors will have incentive to
> > > supply quirks.  

What if we taint the kernel or pci_warn() for cases where either all
the reset methods are disabled, ie. 'echo none > reset_method', or any
time a device specific method is disabled?

I'd almost go so far as to prevent disabling a device specific reset
altogether, but for example should a device specific reset that fixes
an aspect of FLR behavior prevent using a bus reset?  I'd prefer in that
case if direct FLR were disabled via a device flag introduced with the
quirk and the remaining resets can still be selected by preference.

Theoretically all the other reset methods work and are available, it's
only a policy decision which to use, right?

If a device probes for a reset that's broken and distros start
including systemd scripts to apply a preference to avoid it, (a) that
enables them to work with existing kernels, and (b) indicates to us to
add the trivial quirk to flag that reset as broken.

The other side of the argument that this discourages quirks is that
this interface actually makes it significantly easier to report specific
reset methods as broken for a given device.

Thanks,
Alex

