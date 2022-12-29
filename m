Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0590A659237
	for <lists+linux-pci@lfdr.de>; Thu, 29 Dec 2022 22:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiL2V3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Dec 2022 16:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiL2V3L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Dec 2022 16:29:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4273140DF
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 13:29:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41948B801BC
        for <linux-pci@vger.kernel.org>; Thu, 29 Dec 2022 21:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE229C433EF;
        Thu, 29 Dec 2022 21:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672349347;
        bh=MA66UgPU0vXtg/el5fDMiTVLg83gEnoRtkZ0Oh0wJ8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AKEoxau/F8wbcYwEwrkjx1A7QoxDekHYjIfH7IjUh7G+yaGZAGd4/BGinvYX0/CVc
         93YkPx6OjF0x4et6nCbj7q87FgPw3gAH8umGMr9F2ByIC//jBorhGe95tPJ2nQ0bXa
         cRQ5s9rbA8a820fnQjwsvXuf1HeKyvmgF7se6A/e2PNk5ozHlIilKO+5s+dLP+IDtQ
         TeTQNu2U96euYMjFIQ6pUoK32nYjSdSKCxl2U+Rkl7trQuiY/K6cPY5TcJFzOqaWQF
         wVSq5S02JxD41TWwB9gBGx9B681sN4T20IcN8qWtHf79MAp2AEx8c3hOYDMtDel4eR
         9hU/LOg9Q7OCQ==
Date:   Thu, 29 Dec 2022 15:29:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [RESEND PATCH 1/3] Add SolidRun vendor id
Message-ID: <20221229212906.GA631104@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJs=3_AJnj9udpJ1LRtC+9qvo5Fw-=FjvZRqZkHCaQSEP-FyYg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 29, 2022 at 11:06:02PM +0200, Alvaro Karsz wrote:
> > On Mon, Dec 19, 2022 at 10:35:09AM +0200, Alvaro Karsz wrote:
> > > The vendor id is used in 2 differrent source files,
> > > the SNET vdpa driver and pci quirks.
> >
> > s/id/ID/                   # both in subject and commit log
> > s/differrent/different/
> > s/vdpa/vDPA/               # seems to be the conventional style
> > s/pci/PCI/
> >
> > Make the commit log say what this patch does.
> >
> > > Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> >
> > With the above and the sorting fix below:
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > > ---
> > >  include/linux/pci_ids.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index b362d90eb9b..33bbe3160b4 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -3115,4 +3115,6 @@
> > >
> > >  #define PCI_VENDOR_ID_NCUBE          0x10ff
> > >
> > > +#define PCI_VENDOR_ID_SOLIDRUN               0xd063
> >
> > Move this to the right spot so the file is sorted by vendor ID.
> > PCI_VENDOR_ID_NCUBE, PCI_VENDOR_ID_OCZ, and PCI_VENDOR_ID_XEN got
> > added in the wrong place.
> >
> > >  #endif /* _LINUX_PCI_IDS_H */
> > > --
> 
> Thanks for your comments.
> 
> The patch was taken by another maintainer (CCed)
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=afc9dcfb846bf35aa7afb160d5370ab5c75e7a70
> 
> So, Michael and Bjorn,
> Do you want me to create a new version, or fix it in a follow up patch?
> 
> BTW, the same is true for the next patch in the series, New PCI quirk
> for SolidRun SNET DPU
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=linux-next&id=136dd8d8f3a0ac19f75a875e9b27b83d365a5be3

I don't know how Michael runs his tree, so it's up to him, but "New
PCI quirk for SolidRun SNET DPU." is completely different from all the
history and not very informative, so if it were via my tree I would
definitely update both.

Bjorn
