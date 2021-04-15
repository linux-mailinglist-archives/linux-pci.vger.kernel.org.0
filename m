Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27E33612A6
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhDOTBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 15:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234404AbhDOTBt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 15:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618513285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYVCigDOhP1Z6RDm5xBc1B6mJwj25xs6NOyVujWcORI=;
        b=HvOdU82UBPSy6c/m1pGKObBS9ARnFLf1AV+JFXgDVknY3+xSXQT0+eZ2RSYgh2WowfRJDD
        fe8AP1D7uMbIKRUA+deuWLwt9lqvUuMaBu1vHaflEzhyTY3eWxomtrMBlSQIHgaGS9mHl+
        8AVz/9h6lSqfe3WfBtD/pk34iqD6xEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-2nHFFo4hN9SllxZ5kbXnzg-1; Thu, 15 Apr 2021 15:01:22 -0400
X-MC-Unique: 2nHFFo4hN9SllxZ5kbXnzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22E25189C446;
        Thu, 15 Apr 2021 19:01:21 +0000 (UTC)
Received: from redhat.com (ovpn-117-254.rdu2.redhat.com [10.10.117.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 214676267F;
        Thu, 15 Apr 2021 19:01:19 +0000 (UTC)
Date:   Thu, 15 Apr 2021 13:01:19 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ingmar Klein <ingmar_klein@web.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: QCA6174 pcie wifi: Add pci quirks
Message-ID: <20210415130119.42bf5b8a@redhat.com>
In-Reply-To: <eec3bb3b-9eba-a0cb-73da-88353a0d3e99@web.de>
References: <08982e05-b6e8-5a8d-24ab-da1488ee50a8@web.de>
        <20210414210350.GA2537653@bjorn-Precision-5520>
        <20210414203650.1f83a5dd@x1.home.shazbot.org>
        <eec3bb3b-9eba-a0cb-73da-88353a0d3e99@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc +Pali]

On Thu, 15 Apr 2021 20:02:23 +0200
Ingmar Klein <ingmar_klein@web.de> wrote:

> First thanks to you both, Alex and Bjorn!
> I am in no way an expert on this topic, so I have to fully rely on your
> feedback, concerning this issue.
> 
> If you should have any other solution approach, in form of patch-set, I
> would be glad to test it out. Just let me know, what you think might
> make sense.
> I will wait for your further feedback on the issue. In the meantime I
> have my current workaround via quirk entry.
> 
> By the way, my layman's question:
> Do you think, that the following topic might also apply for the QCA6174?
> https://www.spinics.net/lists/linux-pci/msg106395.html
> Or in other words, should a similar approach be tried for the QCA6174
> and if yes, would it bring any benefit at all?
> I hope you can excuse me, in case the questions should not make too much
> sense.

If you run lspci -vvv on your device, what do LnkCap and LnkSta report
under the express capability?  I wonder if your device even supports
>Gen1 speeds, mine does not.

I would not expect that patch to be relevant to you based on your
report.  I understand it to resolve an issue during link retraining to a
higher speed on boot, not during a bus reset.  Pali can correct if I'm
wrong.  Thanks,

Alex

> Am 15.04.2021 um 04:36 schrieb Alex Williamson:
> > On Wed, 14 Apr 2021 16:03:50 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >  
> >> [+cc Alex]
> >>
> >> On Fri, Apr 09, 2021 at 11:26:33AM +0200, Ingmar Klein wrote:  
> >>> Edit: Retry, as I did not consider, that my mail-client would make this
> >>> party html.
> >>>
> >>> Dear maintainers,
> >>> I recently encountered an issue on my Proxmox server system, that
> >>> includes a Qualcomm QCA6174 m.2 PCIe wifi module.
> >>> https://deviwiki.com/wiki/AIRETOS_AFX-QCA6174-NX
> >>>
> >>> On system boot and subsequent virtual machine start (with passed-through
> >>> QCA6174), the VM would just freeze/hang, at the point where the ath10k
> >>> driver loads.
> >>> Quick search in the proxmox related topics, brought me to the following
> >>> discussion, which suggested a PCI quirk entry for the QCA6174 in the kernel:
> >>> https://forum.proxmox.com/threads/pcie-passthrough-freezes-proxmox.27513/
> >>>
> >>> I then went ahead, got the Proxmox kernel source (v5.4.106) and applied
> >>> the attached patch.
> >>> Effect was as hoped, that the VM hangs are now gone. System boots and
> >>> runs as intended.
> >>>
> >>> Judging by the existing quirk entries for Atheros, I would think, that
> >>> my proposed "fix" could be included in the vanilla kernel.
> >>> As far as I saw, there is no entry yet, even in the latest kernel sources.  
> >> This would need a signed-off-by; see
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.11#n361
> >>
> >> This is an old issue, and likely we'll end up just applying this as
> >> yet another quirk.  But looking at c3e59ee4e766 ("PCI: Mark Atheros
> >> AR93xx to avoid bus reset"), where it started, it seems to be
> >> connected to 425c1b223dac ("PCI: Add Virtual Channel to save/restore
> >> support").
> >>
> >> I'd like to dig into that a bit more to see if there are any clues.
> >> AFAIK Linux itself still doesn't use VC at all, and 425c1b223dac added
> >> a fair bit of code.  I wonder if we're restoring something out of
> >> order or making some simple mistake in the way to restore VC config.  
> > I don't really have any faith in that bisect report in commit
> > c3e59ee4e766.  To double check I dug out the card from that commit,
> > installed an old Fedora release so I could build kernel v3.13,
> > pre-dating 425c1b223dac and tested triggering a bus reset both via
> > setpci and by masking PM reset so that sysfs can trigger the bus reset
> > path with the kernel save/restore code.  Both result in the system
> > hanging when the device is accessed either restoring from the kernel
> > bus reset or reading from the device after the setpci reset.  Thanks,
> >
> > Alex
> >  
> 

