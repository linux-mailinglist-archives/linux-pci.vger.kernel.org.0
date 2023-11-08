Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2F7E6132
	for <lists+linux-pci@lfdr.de>; Thu,  9 Nov 2023 00:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjKHXtP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 18:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHXtP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 18:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E921211C
        for <linux-pci@vger.kernel.org>; Wed,  8 Nov 2023 15:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699487314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IP8wbH5v3RFTRMGuEbmVq1QmCj9XqYX84MFeNvSej60=;
        b=DFHfFJDZxn2X5Q6gVkB48VPZlfH1i9dH9PWs8FhNidWmJIYmETvxwpxnEF9X9CgcDJFgW7
        la0uk5LamivqlONrkzQhStlVk+Yhk28OBVURYmNzEBBPk4n2P9d6bPBkWfvWZ0toQ6H9wu
        ZDSdBugM67OIJ1sKlLUFPcDtV5zjMPE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-rQC5izG0MkuzF3BsyHaDeQ-1; Wed, 08 Nov 2023 18:48:33 -0500
X-MC-Unique: rQC5izG0MkuzF3BsyHaDeQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-408508aa81cso1277245e9.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Nov 2023 15:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699487312; x=1700092112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IP8wbH5v3RFTRMGuEbmVq1QmCj9XqYX84MFeNvSej60=;
        b=QGrOSz1CNE9LFhQTHNSJlxwqYIihkKf49hIVTWzCHNSNOdxlRDBlpyC/JrPkmPervS
         nKw2cGA2HbNuY/ovum9Sij+/mf+wKGt1XFOVJMQPTw/d82b+Vh8KA4tPqOgyhBqFvyDV
         Iqh+yXPkdHN/pTuEdwmIdoWGHbyeyyOrvpsD9wsoxfy1QeJQWn5FNcHpvEZGSfkh3P2i
         4tx+vF2ZKARZNoHpnMUmDrnUcd4yDYXgegKpJ8vqTbSfiKzHGBW62JjbxwDoUO8JsmcG
         3UOSw7wbS4R/Er7dQqpC5/gpyN5fZbd1znu7qNZGUBRRPwLB7Kk5RVIun/Oh5Xbl0fgs
         ai2A==
X-Gm-Message-State: AOJu0Yw3/drG+jDDfU5Yy58pSpxp3P/c/LAExDSOYuK2PRifLVtbrvOL
        CoJ21dCdSXGnUZ0FRR669Tnep10wXaMDhjPSO6uEl8HcW8uFspk5fMR1efzeqIVVrJITN8e/AFY
        3HAeHNs/XX98l8c7X8eN8
X-Received: by 2002:adf:d1cf:0:b0:32d:d2ef:b0e4 with SMTP id b15-20020adfd1cf000000b0032dd2efb0e4mr2588639wrd.0.1699487312160;
        Wed, 08 Nov 2023 15:48:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkKb07P7NHzLxLvXkt4f6tEsys3qOth6k77j7hZZ1vEF+4YwIERwZ7anMUdO8vcdR91SInRw==
X-Received: by 2002:adf:d1cf:0:b0:32d:d2ef:b0e4 with SMTP id b15-20020adfd1cf000000b0032dd2efb0e4mr2588630wrd.0.1699487311860;
        Wed, 08 Nov 2023 15:48:31 -0800 (PST)
Received: from pollux ([2a02:810d:4b3f:de9c:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d6611000000b003142e438e8csm6001346wru.26.2023.11.08.15.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 15:48:31 -0800 (PST)
Date:   Thu, 9 Nov 2023 00:48:29 +0100
From:   Danilo Krummrich <dakr@redhat.com>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <htejun@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, jeff@garzik.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Implementation details of PCI Managed (devres) Functions
Message-ID: <ZUweTfT7ehduedf9@pollux>
References: <84be1049e41283cf8a110267646320af9ffe59fe.camel@redhat.com>
 <1e964a74ca51e9e28202a47af22917e468050039.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e964a74ca51e9e28202a47af22917e468050039.camel@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 08, 2023 at 10:02:29PM +0100, Philipp Stanner wrote:
> So, today I stared at the code for a while and come to a somewhat
> interesting insight:
> 
> 
> On Tue, 2023-11-07 at 20:38 +0100, Philipp Stanner wrote:
> > Hi all,
> > 
> > I'm currently working on porting more drivers in DRM to managed pci-
> > functions. During this process I discovered something that might be
> > called an inconsistency in the implementation.
> 
> I think I figured out why not all pci_ functions have a pcim_
> counterpart.
> 
> I was interested in implementing pcim_iomap_range(), since we could use
> that for some drivers.

I think you don't need all the "per bar" stuff below for that. You can just use
the existing pci_iomap_range() (which simply uses ioremap() internally) and
connect it to devres.

> 
> It turns out, that implementing this would be quite complicated (if I'm
> not mistaken).
> 
> lib/devres.c:
> 
> struct pcim_iomap_devres {
> 	void __iomem *table[PCIM_IOMAP_MAX];
> };
> 
> void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
> {
> 	struct pcim_iomap_devres *dr, *new_dr;
> 
> 	dr = devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
> 	if (dr)
> 		return dr->table;
> 
> 	new_dr = devres_alloc_node(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL,
> 				   dev_to_node(&pdev->dev));
> 	if (!new_dr)
> 		return NULL;
> 	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
> 	return dr->table;
> }
> 
> That struct keeps track of the requested BARs. That's why there can
> only be one mapping per BAR, because that table is statically allocated
> and is indexed with the bar-number.
> pcim_iomap_table() now only ever returns the table with the pointers to
> the BARs. Adding tables to that struct that keep track of which
> mappings exist in which bars would be a bit tricky and require probably
> an API change for everyone who currently uses pcim_iomap_table(), and
> that's more than 100 C-files.
> 
> So, it seems that a concern back in 2007 was to keep things simple and
> skip the more complex data structures necessary for keeping track of
> the various mappings within a bar.
> In theory, there could be an almost unlimited number of such mappings
> of various sizes, almost forcing you to do book-keeping with the help
> of heap-allocations.
> 
> I guess one way to keep things extensible would have been to name the
> function pcim_iomap_bar_table(), so you could later implement one like
> pcim_iomap_range_table() or something.
> But now it is what it is..
> 
> That still doesn't explain why there's no pcim_request_region(),
> though...
> 
> 
> P.
> 
> > 
> > First, there would be the pcim_ functions being scattered across
> > several files. Some are implemented in drivers/pci/pci.c, others in
> > lib/devres.c, where they are guarded by #ifdef CONFIG_PCI
> > – this originates from an old cleanup, done in
> > 5ea8176994003483a18c8fed580901e2125f8a83
> > 
> > Additionally, there is lib/pci_iomap.c, which contains the non-
> > managed
> > pci_iomap() functions.
> > 
> > At first and second glance it's not obvious to me why these pci-
> > functions are scattered. Hints?
> > 
> > 
> > Second, it seems there are two competing philosophies behind managed
> > resource reservations. Some pci_ functions have pcim_ counterparts,
> > such as pci_iomap() <-> pcim_iomap(). So the API-user might expect
> > that
> > relevant pci_ functions that do not have a managed counterpart do so
> > because no one bothered implementing them so far.
> > 
> > However, it turns out that for pci_request_region(), there is no
> > counterpart because a different mechanism / semantic was used to make
> > the function _sometimes_ managed:
> > 
> >    1. If you use pcim_enable_device(), the member is_managed in
> > struct
> >       pci_dev is set to 1.
> >    2. This value is then evaluated in pci_request_region()'s call to
> >       find_pci_dr()
> > 
> > Effectively, this makes pci_request_region() sometimes managed.
> > Why has it been implemented that way and not as a separate function –
> > like, e.g., pcim_iomap()?
> > 
> > That's where an inconsistency lies. For things like iomappings there
> > are separate managed functions, for the region-request there's a
> > universal function doing managed or unmanaged, respectively.
> > 
> > Furthermore, look at pcim_iomap_regions() – that function uses a mix
> > between the obviously managed function pcim_iomap() and
> > pci_request_region(), which appears unmanaged judging by the name,
> > but,
> > nevertheless, is (sometimes) managed below the surface.
> > Consequently, pcim_iomap_regions() could even be a little buggy: When
> > someone uses pci_enable_device() + pcim_iomap_regions(), wouldn't
> > that
> > leak the resource regions?
> > 
> > The change to pci_request_region() hasn't grown historically but was
> > implemented that way in one run with the first set of managed
> > functions
> > in commit 9ac7849e35f70. So this implies it has been implemented that
> > way on purpose.
> > 
> > What was that purpose?
> > 
> > Would be great if someone can give some hints :)
> > 
> > Regards,
> > P.
> > 
> 

