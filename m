Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6798223008
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGQAoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 20:44:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31239 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726316AbgGQAoH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 20:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594946645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rmdg41JQUJq8opOuNZqgZDP9AkGwDIAIjz0rPo/9Gto=;
        b=COc5egj66ufcJXjDWAILUQJ0E2ILBLJoYpYm0kznwfBMkLpUW+SN0oqKy9QPQQgVHFZDo1
        KvP+IDKtszbkbSnXbcDC9V1W1NNVsYuSGEQsujkBV/wqE2xM+4EOkHL0lv0O8gFYylK8Q9
        //f/1VAUvf3Tf9YNHQ0H63ukiOsPlXk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ih2hoKBxMsqamKdoCKdTtw-1; Thu, 16 Jul 2020 20:44:03 -0400
X-MC-Unique: ih2hoKBxMsqamKdoCKdTtw-1
Received: by mail-qv1-f72.google.com with SMTP id em19so4551676qvb.14
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2020 17:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rmdg41JQUJq8opOuNZqgZDP9AkGwDIAIjz0rPo/9Gto=;
        b=EI+y+bYYs6WCG8zPoVRvc1+fph94u0UgyDZIBewBJpn4u9mdy2nBOb4R+DbKu7Al7w
         mEgPqT6ZJV6Zr9daXOaONZJzRA/rNBE0SIzFyxkIrmL8n1KX40GhnKMn79WbeXzTvUVn
         v2On8Gefj3Iv0uP7pXL+YBwAutPdlMZvlE2mW8byG3TQDs9pT/ZONcqu1UlzVL2Q3coT
         670let2+zhgbSlKztn/Kk6rwkIwUordd6dU22pTU/c2UyNYTlDfz6FRNMg+4MELG4Tgv
         PknZccFKsuXFutplpqOhAxF/AfD78JPWCxzfKb9328mteMHcdwpwOEQJLcc+9CR18aRT
         7B9A==
X-Gm-Message-State: AOAM5305KhgiQRhXE3aGymg3TydFQmXdSG1KJcSpVCfZBv3hslSeMOE3
        mvaEYGRIhxp+68pgrqjqEnCWdC9GZ6oIi4x+lUqpBwvME1poPYnP90FwXV5F5C4wbX4vEFyjqEc
        HaOrloM/1kzez8OMYbM87XwWH5jQIhhSN5EL8
X-Received: by 2002:a37:5c04:: with SMTP id q4mr6803731qkb.192.1594946643133;
        Thu, 16 Jul 2020 17:44:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8dZ0LhZ5SZX3kNAbkEg8LM0oFyVFb+CHDpbaDZnEmRN7ua1G6U67YJDaEwNT4OIDFAmfBXBb89RLpG2bg22A=
X-Received: by 2002:a37:5c04:: with SMTP id q4mr6803712qkb.192.1594946642833;
 Thu, 16 Jul 2020 17:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520>
In-Reply-To: <20200716235440.GA675421@bjorn-Precision-5520>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 17 Jul 2020 02:43:52 +0200
Message-ID: <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 1:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Sasha -- stable kernel regression]
> [+cc Patrick, Kai-Heng, LKML]
>
> On Fri, Jul 17, 2020 at 12:10:39AM +0200, Karol Herbst wrote:
> > On Tue, Jul 7, 2020 at 9:30 PM Karol Herbst <kherbst@redhat.com> wrote:
> > >
> > > Hi everybody,
> > >
> > > with the mentioned commit Nouveau isn't able to load firmware onto the
> > > GPU on one of my systems here. Even though the issue doesn't always
> > > happen I am quite confident this is the commit breaking it.
> > >
> > > I am still digging into the issue and trying to figure out what
> > > exactly breaks, but it shows up in different ways. Either we are not
> > > able to boot the engines on the GPU or the GPU becomes unresponsive.
> > > Btw, this is also a system where our runtime power management issue
> > > shows up, so maybe there is indeed something funky with the bridge
> > > controller.
> > >
> > > Just pinging you in case you have an idea on how this could break Nouveau
> > >
> > > most of the times it shows up like this:
> > > nouveau 0000:01:00.0: acr: AHESASC binary failed
> > >
> > > Sometimes it works at boot and fails at runtime resuming with random
> > > faults. So I will be investigating a bit more, but yeah... I am super
> > > sure the commit triggered this issue, no idea if it actually causes
> > > it.
> >
> > so yeah.. I reverted that locally and never ran into issues again.
> > Still valid on latest 5.7. So can we get this reverted or properly
> > fixed? This breaks runtime pm for us on at least some hardware.
>
> Yeah, that stinks.  We had another similar report from Patrick:
>
>   https://lore.kernel.org/r/CAErSpo5sTeK_my1dEhWp7aHD0xOp87+oHYWkTjbL7ALgDbXo-Q@mail.gmail.com
>
> Apparently the problem is ec411e02b7a2 ("PCI/PM: Assume ports without
> DLL Link Active train links in 100 ms"), which Patrick found was
> backported to v5.4.49 as 828b192c57e8, and you found was backported to
> v5.7.6 as afaff825e3a4.
>
> Oddly, Patrick reported that v5.7.7 worked correctly, even though it
> still contains afaff825e3a4.
>
> I guess in the absence of any other clues we'll have to revert it.
> I hate to do that because that means we'll have slow resume of
> Thunderbolt-connected devices again, but that's better than having
> GPUs completely broken.
>
> Could you and Patrick open bugzilla.kernel.org reports, attach dmesg
> logs and "sudo lspci -vv" output, and add the URLs to Kai-Heng's
> original report at https://bugzilla.kernel.org/show_bug.cgi?id=206837
> and to this thread?
>
> There must be a way to fix the slow resume problem without breaking
> the GPUs.
>

I wouldn't be surprised if this is related to the Intel bridge we
check against for Nouveau.. I still have to check on another laptop
with the same bridge our workaround was required as well but wouldn't
be surprised if it shows the same problem. Will get you the
information from both systems tomorrow then.

> Bjorn
>

