Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890D1623461
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 21:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKIURl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 15:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiKIURa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 15:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAD425D0
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 12:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668024997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLOxLVFZV4zQpDgDTPUVeEgHz0GzCmM4oZzrRys5s/c=;
        b=LmNPjTI/dAOVoM9UODV98NXgijS0S1/hkyKNW36O9PfOVMUzxdTulKNgnGr5XYcZ2BGguG
        NmoXZGTTx1268Wr32B5iI7VxHdbC8McQxIak5fiTEtekgu3o9062nzphqerkv2/samnVbL
        QkQehK2rtm/wNUxk7L3ySoJah2+p9YI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-_-F971XFPD-EdTUabfUnUQ-1; Wed, 09 Nov 2022 15:16:36 -0500
X-MC-Unique: _-F971XFPD-EdTUabfUnUQ-1
Received: by mail-io1-f72.google.com with SMTP id i3-20020a5d8403000000b006c9271c3465so12027778ion.4
        for <linux-pci@vger.kernel.org>; Wed, 09 Nov 2022 12:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLOxLVFZV4zQpDgDTPUVeEgHz0GzCmM4oZzrRys5s/c=;
        b=EC9ILM3Yv2PKcysZMFmZKsLm4q1exCKetJt1Kx/3pVb9cfmG++TDSa7GA7RoxSRDqV
         Wzn06F1RmkaYX/e9K1MfaYg7fBFkzmZg2H4OETqT+noIDomh8Aca8aNnYDx2CUMY/S6L
         7wmFJxXvtLUhU5gUA3ehgrPr9JyV5SuZLV8PgI+vmeh9+S+iwwGlLywOPF9Qw8XRJI4Q
         G4S/Yqnx43q3T9Q1dcIqyExYt1zdq7cgnj3jIq5xDHnlz1v9H8OZrPKK5bd5Ez9Qa8ew
         r23bMp7bos+Kkp6FWCys0WhTNQ5kTcZCS4875iZMffK0uenZpA48Xxno+YSOICNhZWb8
         6S0A==
X-Gm-Message-State: ACrzQf0QSazDODMO8BnW8lz6M3ztEpm1mt0tXpIRLpUMDFSczkmMJKzc
        c1YdV5/VfV7a1I+7vtWA9S1o+ahiQZ2T4qllk04CRM9/QUJJ6oM9S80+dOmmm2cUw1Gx6MC4aHh
        Jz7sRaPw7Ie0dt0aaDUmB
X-Received: by 2002:a02:b90e:0:b0:375:afa6:ad1 with SMTP id v14-20020a02b90e000000b00375afa60ad1mr13614030jan.288.1668024995268;
        Wed, 09 Nov 2022 12:16:35 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6gzjCuqJ1aA3BafM719bcGvXRLswKT7STqsQHrDo3cNgtfnX8AghXAYSnm4DwyTRlE/cER8g==
X-Received: by 2002:a02:b90e:0:b0:375:afa6:ad1 with SMTP id v14-20020a02b90e000000b00375afa60ad1mr13614020jan.288.1668024995032;
        Wed, 09 Nov 2022 12:16:35 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s27-20020a02cc9b000000b00363dee286edsm5154294jap.60.2022.11.09.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:16:34 -0800 (PST)
Date:   Wed, 9 Nov 2022 13:16:32 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Stefan Roese <sr@denx.de>,
        Jim Wilson <wilson@tuliptree.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] PCI: Work around PCIe link training failures
Message-ID: <20221109131632.6a059bd9.alex.williamson@redhat.com>
In-Reply-To: <20221109050418.GA529724@bhelgaas>
References: <alpine.DEB.2.21.2211090014500.15287@angie.orcam.me.uk>
        <20221109050418.GA529724@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 8 Nov 2022 23:04:18 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex, in case he has any reset-related comments]
> 
> On Wed, Nov 09, 2022 at 02:57:57AM +0000, Maciej W. Rozycki wrote:
> > Hi Bjorn,
> > 
> >  Thank you for coming back to this patch series.  I'll try to address your 
> > concerns, but it may take a little.  The reason is I'm currently on site 
> > at my lab until the end of the week and barring my day job, etc. I want to 
> > focus on items to do (and I do have a bunch) that require local hardware 
> > access.  The issue concerned with this patch series does not, so I'll get 
> > to looking into it in more depth hopefully from next week.  For the time 
> > being however please see below.
> > 
> > On Thu, 3 Nov 2022, Bjorn Helgaas wrote:
> >   
> > > > > > Also check for a 2.5GT/s speed restriction the firmware may have already 
> > > > > > arranged and lift it too with ports of devices known to continue working 
> > > > > > afterwards, currently the ASM2824 only, that already report their data 
> > > > > > link being up.  
> > > > > 
> > > > > This quirk is run at boot-time and resume-time.  What happens after a
> > > > > Secondary Bus Reset, as is done by pci_reset_secondary_bus()?  
> > > > 
> > > > Flipping SBR bit can be done on any PCI-to-PCI bridge device and in this
> > > > topology there are following: PCIe Root Port, ASMedia PCIe Switch
> > > > Upstream Port, ASMedia PCIe Switch Downstream Port, Pericom PCIe Switch
> > > > Upstream Port, Pericom PCIe Switch Downstream Port.
> > > > (Maciej, I hope that this is whole topology and there is not some other
> > > > device of PCI-to-PCI bridge type in your setup; please correct me)  
> > 
> >  There is actually a PCIe-to-PCI bridge device further downstream (device 
> > 0000:08:00.0 in the listings below; bus 09 is conventional PCI), but it 
> > doesn't matter for the issue concerned; the issue triggers whether the 
> > bridge module has been plugged or not.
> >   
> > > > Bjorn, to make it clear, on which device you mean to issue secondary bus
> > > > reset?  
> > > 
> > > IIUC, the problem is observed on the link between the ASM2824
> > > downstream port and the PI7C9X2G304 upstream port, so my question is
> > > about asserting SBR on the ASM2824 downstream port.  I think that
> > > should cause the link between ASM2824 and PI7C9X2G304 to go down and
> > > back up.  
> > 
> >  That would be my expectation as well.  Is there a reliable way to request
> > that however without actually writing a piece of code to do so from inside 
> > the kernel?  Sadly our documentation is vague on the matter, in particular 
> > Documentation/ABI/testing/sysfs-bus-pci, but here's what I have obtained:
> > 
> > # lspci -t
> > -[0000:00]---00.0-[01-0b]----00.0-[02-0b]--+-00.0-[03]--
> >                                            +-02.0-[04]----00.0
> >                                            +-03.0-[05-09]----00.0-[06-09]--+-01.0-[07]--+-00.0
> >                                            |                               |            \-00.3
> >                                            |                               \-02.0-[08-09]----00.0-[09]--+-01.0
> >                                            |                                                            \-02.0
> >                                            +-04.0-[0a]----00.0
> >                                            \-08.0-[0b]--+-00.0
> >                                                         \-00.1
> > # for name in /sys/bus/pci/devices/0000\:??\:??.?/reset_method; do echo "$(basename $(dirname $name)): $(cat $name)"; done
> > 0000:01:00.0: pm bus
> > 0000:02:00.0: pm bus
> > 0000:02:02.0: pm
> > 0000:02:03.0: pm
> > 0000:02:04.0: pm
> > 0000:02:08.0: pm
> > 0000:04:00.0: bus
> > 0000:05:00.0: bus
> > 0000:06:01.0: bus
> > 0000:07:00.0: bus
> > 0000:08:00.0: bus
> > 0000:09:01.0: pm bus
> > 0000:0a:00.0: flr bus
> > 0000:0b:00.0: pm bus
> > 0000:0b:00.1: pm
> > # 
> > 
> > (mind that the problematic link is between 0000:02:03.0 and 0000:05:00.0), 
> > and then:
> > 
> > # echo 1 >/sys/bus/pci/devices/0000\:05\:00.0/reset
> > -sh: echo: write error: Inappropriate ioctl for device
> > # 
> > 
> > (which I gather is supposed to poke at 0000:02:03.0's SBR) so it doesn't 
> > seem to be effective.    
> 
> 05:00.0 supports the "bus" method, i.e., pci_reset_bus_function(),
> which tries pci_dev_reset_slot_function() followed by
> pci_parent_bus_reset().  Both of them return -ENOTTY if the device
> (05:00.0) has a secondary bus ("dev->subordinate"), so I think nothing
> happens here.

Right, the pci-sysfs reset attribute is only meant for a reset scope
limited to the device, we'd need something to call pci_reset_bus() to
commit to the whole hierarchy, which is not something we typically do.
vfio-pci will only bind to endpoint devices, so it shouldn't provide an
interface to inject a bus reset here either.

Based on the fact that there's a pericom switch in play here, I'll just
note that I think this is the same device with other link speed issues
as well:

https://lore.kernel.org/all/20161026180140.23495.27388.stgit@gimli.home/

This fell off my plate some time ago, but as noted there, enabling ACS
when the upstream and downstream ports run at different link rates
exposes errata where packets are queued and not delivered within the
switch.

Could enabling ACS on this device be contributing to the issue here,
for example triggering the Asmedia downstream port to get into this
link reseting issue?  A test with
pci=disable_acs_redir=0000:06:01.0;0000:06:02.0 could be interesting
assuming this occurs on an platform that has an IOMMU, ie. calls
pci_request_acs().  Thanks,

Alex

