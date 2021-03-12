Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD28339725
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 20:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhCLTHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 14:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbhCLTH3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 14:07:29 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5173C061574;
        Fri, 12 Mar 2021 11:07:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w8so5600088pjf.4;
        Fri, 12 Mar 2021 11:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JiFLEUi4honPFdgXnpeoFFjZ5HjkFjhcI3Iwp3vvM/U=;
        b=FWP1+zknMpuFWB+QtPq/mPsssB4E4Bp1K4QHTJRTtmitbw3myWffnNOSTcIKrK/nBA
         Q7nxX5+oCtUafVS4wfddox88WnWO2z5XzNma+UsFj2jKkJmyRtY1ehqtGrW4hwQ9I7qk
         HrIkpL21QInpOIXY71G12yIRufNzGzV28q3LHIOhgvkh85D4dn1T7hfaMeaypaPygKcl
         3cQSsjfHe5NpUSehLXEp79YeWxU1ACQlUkFVvaqSTC3MIxRy8+DwbfclowAmG5XP9yVI
         VOmcpbb5fMRYbP8mu7SomqN4l/p8Vk+FqCEjdLAsdKZ9SloK7k82aXozcTXsQR1L8tG8
         rqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JiFLEUi4honPFdgXnpeoFFjZ5HjkFjhcI3Iwp3vvM/U=;
        b=BtbOWYLXU+/0HVyxizmuY9jmE2Hfs9MXZHgPIJ8dupDbhyLHmhMKTwoNPUBDqbx+Vf
         boaqI8nIRPkrOd4qI8WajcHwGqTPLdp6Oa24+q2Mcroxd/L5MEP/gLYGaMhya4WlRA0D
         /3fte3+DtYlRFj5yr5hokA1duTdSNNUguLAh3SZ/GqcjpeqSNjIdiO4LeTCmjZB7rLNN
         ps6iJ6BJ9Li/CT06c6NHSFUl6aeQ2q6eX26xaxpXhTQVGvCdplK5PAtbaKDskTictpy3
         XaJetGX7Ff781nNwg4lkhY65GWpK2WI2XgwuXPMcBy/he8aonOf+nKH+JdlnOWKe6d0V
         jPiA==
X-Gm-Message-State: AOAM531AJ6TnZoNdkh/dNbewhqoL7K8MzaWoRIzLHw4JEgv8ofez42K8
        nFluPu4X247lhVsGKM8jV1Y=
X-Google-Smtp-Source: ABdhPJyh8Bxntb9MrWdror0mcqFF7kAuwgLUDAz2+Sv7bzU6mzBGQDNVvY443sFxmRARSuvYtsoZyg==
X-Received: by 2002:a17:902:eb11:b029:e4:a5c3:42e8 with SMTP id l17-20020a170902eb11b02900e4a5c342e8mr516519plb.26.1615576048345;
        Fri, 12 Mar 2021 11:07:28 -0800 (PST)
Received: from localhost ([103.248.31.144])
        by smtp.gmail.com with ESMTPSA id b140sm6537220pfb.98.2021.03.12.11.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 11:07:28 -0800 (PST)
Date:   Sat, 13 Mar 2021 00:36:49 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        raphael.norwitz@nutanix.com
Subject: Re: [PATCH 0/4] Expose and manage PCI device reset
Message-ID: <20210312190649.hulyrpkdg6btn6y7@archlinux>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312112043.3f2954e3@omen.home.shazbot.org>
 <20210312184038.to3g3px6ep4xfavn@archlinux>
 <YEu5vq4ACcupBpRC@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEu5vq4ACcupBpRC@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/12 07:58PM, Krzysztof Wilczyński wrote:
> Hi Amey,
>
> Thank you for sending the series over!
>
> [...]
> > > Reviews/Acks/Sign-off-by from others (aside from Tested/Reported-by)
> > > really need to be explicit, IMO.  This is a common issue for new
> > > developers, but it really needs to be more formal.  I wouldn't claim to
> > > be able to speak for Raphael and interpret his comments so far as his
> > > final seal of approval.
> > >
> > > Also in the patches, all Sign-offs/Reviews/Acks need to be above the
> > > triple dash '---' line.  Anything between that line and the beginning
> > > of the diff is discarded by tools.  People will often use that for
> > > difference between version since it will be discarded on commit.
> > > Likewise, the cover letter is not committed, so Review-by there are
> > > generally not done.  I generally make my Sign-off last in the chain and
> > > maintainers will generally add theirs after that.  This makes for a
> > > chain where someone can read up from the bottom to see how this commit
> > > entered the kernel.  Reviews, Acks, and whatnot will therefore usually
> > > be collected above the author posting the patch.
> > >
> > > Since this is a v1 patch and it's likely there will be more revisions,
> > > rather than send a v2 immediately with corrections, I'd probably just
> > > reply to the cover letter retracting Raphael's Review-by for him to
> > > send his own and noting that you'll fix the commit reviews formatting,
> > > but will wait for a bit for further comments before sending a new
> > > version.
> > >
> > > No big deal, nice work getting it sent out.  Thanks,
> > >
> > > Alex
> > >
> > Raphael sent me the email with
> > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com> that
> > is why I included it.
> > So basically in v2 I should reorder tags such that Sign-off will be
> > the last. Did I get that right? Or am I missing something?
> [...]
>
> I am not sure about the messages outside of the mailing list between
> you, Alex and Raphael, as normally conversation and any reviews would
> happen here (on the mailing list, that is), but as long as everyone
> involved is on the same page, then every should be fine.
>
> In terms of how to format the patch, have a look at the following,
> especially before you send another version, as there are some good tips
> and recommendations there (including how to order things):
>
>   https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
>
> Krzysztof
Basically whole thing boils down to I'm not good at handling terminal
email clients. I'll surely keep those points mentioned by Bjorn
in my mind.

Thanks,
Amey
