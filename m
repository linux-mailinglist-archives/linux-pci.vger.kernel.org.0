Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4654F22B7CA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 22:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGWUbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 16:31:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42651 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbgGWUbO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2020 16:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595536272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40t+4qcg6UR1VcXiSRsIIDp9z0DXZ4q6WAM4TN0/6lk=;
        b=AMgEn6YSwmFSRGl/JNSbgBMBusMoo0rw8ptxRhhnDe951tpeadcqXiRqQSkTLaVLRKnst8
        Jla9uFleOus1dtV3OVjr5SP+jqTUFVX1o/SfOFAIuQKJogGiecQ+n+KXFNFweeVLQw/73p
        Ij9EH1watsSvsTygoxAQZxkc3+/rN4c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-nH7jXmUgPrm17BPG1qi28g-1; Thu, 23 Jul 2020 16:31:10 -0400
X-MC-Unique: nH7jXmUgPrm17BPG1qi28g-1
Received: by mail-qv1-f71.google.com with SMTP id r19so4375918qvz.7
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2020 13:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40t+4qcg6UR1VcXiSRsIIDp9z0DXZ4q6WAM4TN0/6lk=;
        b=ppcfVLWhgyfjkpulL8DkEmtEVt2rzH1eP4txw+PsbEaQx1L3LjantgobkJ4gjSPIFe
         kXGFi0x79P1kdJKWup62MpglTaOSuQi5LfxVup1RcF2cRBJjd424HOdhQbMpEUZgFcrg
         0LVvX63RqdK7t01TGkjCWN2hImyORNKXJQ6W10n7F+ltcju32ErhgH2rqaPKpbxRg8yF
         pPgf2TCM41V+P3otAej1Xkq7fhKVuTZdvqwj1ZdJD0B79q9zjlHn39c3b6igdXlaE/d+
         DDYbaVgh/ej1fB80gMpBaN4mTBlvNkfou+P42sk+hNkYljMMfMAqSmH/Nz45JDXrjoU2
         eszQ==
X-Gm-Message-State: AOAM530x7lVgezK+hPmgYPoYRGyWTHNkyrmErlnoLckKz477xKFYx7UY
        XcxoWNULM/KJEto6K0Us6koOfgg9cdVCtHXgbEJ3oBgzEqJweAQ0DXMd49LciPZ5XEbBjmnEhPB
        Mmv6pA4fuaptxsOle+4/H88uXBbFq4CFdhDdE
X-Received: by 2002:a37:5c04:: with SMTP id q4mr7263418qkb.192.1595536270056;
        Thu, 23 Jul 2020 13:31:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaz+FKwj1+Qpe9+JR57Hg1bCOgF5rhbZUwIe/feWxQzxhiCYW2p0q4YNTbBH3ZcWu7BRmV4VUvG7uvN9PukuM=
X-Received: by 2002:a37:5c04:: with SMTP id q4mr7263386qkb.192.1595536269773;
 Thu, 23 Jul 2020 13:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520> <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
 <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
 <20200721122247.GI5180@lahna.fi.intel.com> <f951fba07ca7fa2fdfd590cd5023d1b31f515fa2.camel@redhat.com>
 <20200721152737.GS5180@lahna.fi.intel.com> <d3253a47-09ff-8bc7-3ca1-a80bdc09d1c2@gmail.com>
 <20200722092507.GC5180@lahna.fi.intel.com>
In-Reply-To: <20200722092507.GC5180@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 23 Jul 2020 22:30:58 +0200
Message-ID: <CACO55tsv63VP93F7xJ3nfZ7SkOk0c6WkgvuP+8fY14gypmn4Fg@mail.gmail.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Patrick Volkerding <volkerdi@gmail.com>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 22, 2020 at 11:25 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Jul 21, 2020 at 01:37:12PM -0500, Patrick Volkerding wrote:
> > On 7/21/20 10:27 AM, Mika Westerberg wrote:
> > > On Tue, Jul 21, 2020 at 11:01:55AM -0400, Lyude Paul wrote:
> > >> Sure thing. Also, feel free to let me know if you'd like access to one of the
> > >> systems we saw breaking with this patch - I'm fairly sure I've got one of them
> > >> locally at my apartment and don't mind setting up AMT/KVM/SSH
> > > Probably no need for remote access (thanks for the offer, though). I
> > > attached a test patch to the bug report:
> > >
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=208597
> > >
> > > that tries to work it around (based on the ->pm_cap == 0). I wonder if
> > > anyone would have time to try it out.
> >
> >
> > Hi Mika,
> >
> > I can confirm that this patch applied to 5.4.52 fixes the issue with
> > hybrid graphics on the Thinkpad X1 Extreme gen2.
>
> Great, thanks for testing!
>

yeah, works on the P1G2 as well.

