Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220E6173E1
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2019 10:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEHIbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 May 2019 04:31:48 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50773 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfEHIbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 May 2019 04:31:48 -0400
Received: by mail-it1-f193.google.com with SMTP id r17so222180ita.0
        for <linux-pci@vger.kernel.org>; Wed, 08 May 2019 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PO7Ld+9ooRoIQAYoKOrZVC1JwjL/3MhjUy/68sJWDzc=;
        b=dgAXJ4H5fYqcpWefDSpkR8brhpgeH8EGQD6EGIbbnY3tOeRnRgH6MtH2SD50HglgjM
         C8MTpn1amkNLRrxHM6qA55Ht58gLlXK6p3kl4wTpq8ywtrShMhw9mstLE8FHFglB1z4Y
         msn2Se/ma+H+updh7Nt0NgeVRHC71PhiW3IPjNRgTRRe7BuDZ0bB53dqkDuwhb0ZJ7fE
         WVCPs8Ep+aeVqzmBFQ5o1osVqvNXP5Duwsj+RGFHazLeC34D6yqTQll99yNHf8WfNFX5
         zmOP86PTZgEXYFeM4yzxRXPaJVmGbgNf3woxes093w7ogx4aDXX79dwStGhZ/95sMVMC
         aPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PO7Ld+9ooRoIQAYoKOrZVC1JwjL/3MhjUy/68sJWDzc=;
        b=J6c+Fg5rVb69FZbygK0sy4eInrWWQgPgvgF/14W2TxMu5p6dFckCLGe5mEJqvtanW4
         NSfqu6/JTs9tnvoX0BvxenZ0sxQYYE2Sx/9mcg6nR6/hLHGbGafwI149VBPMWQ9tOPuz
         YOEvFGdBM7g2sDdhLM12MPOggcuknA6XGfoNEp/Srm4WdWhMTj9fqJIiqDXSM0XZGZTj
         Lkja/9/H+9TwJYGo4WhG9kfbkg5/hnP3+MdGXLuQDmT5hZ0ylpkcLWXMBsFgvqHyNMnA
         Vn0UYCqT9tluPiODgq1Tlhi4TPnVXvPMMjeIWXeNOPk44eHPp2OVkn717wkFHEE4Ti0u
         C9rw==
X-Gm-Message-State: APjAAAXitNfux8TVR90xcd1IwGWczyjX/CvaL/ZT3ZepKHDbc8zfVq2S
        1teRid58xcSg5PbHvdh+mCAmZ5y+p56t3YTkva0fVsd4
X-Google-Smtp-Source: APXvYqyVhxGTxDQK62hA3S1W7PdxKy+jy1WNJI1aFBZTZyw7XlicBvrMhnP0CrQH61e5Ev80+H4iIVQAHVzdS9MUW3I=
X-Received: by 2002:a24:d45:: with SMTP id 66mr2653222itx.9.1557304307372;
 Wed, 08 May 2019 01:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190410074455.26964-1-oohall@gmail.com> <20190507194037.GE156478@google.com>
In-Reply-To: <20190507194037.GE156478@google.com>
From:   Oliver <oohall@gmail.com>
Date:   Wed, 8 May 2019 18:31:35 +1000
Message-ID: <CAOSf1CGe3yqfV154gPm2nUL3qA=3Ab462wNvGgayVr_n3runkw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add a comment for the is_physfn field
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 8, 2019 at 5:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Oliver,
>
> On Wed, Apr 10, 2019 at 05:44:55PM +1000, Oliver O'Halloran wrote:
> > The meaning of is_physfn and how it's different to is_virtfn really
> > isn't clear unless you do a bit of digging. Add a comment to help out
> > the unaware.
> >
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> > ---
> >  include/linux/pci.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 77448215ef5b..88bf71bfa757 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -393,6 +393,10 @@ struct pci_dev {
> >       unsigned int    is_managed:1;
> >       unsigned int    needs_freset:1;         /* Requires fundamental reset */
> >       unsigned int    state_saved:1;
> > +     /*
> > +      * is_physfn indicates that the function can be used to host VFs.
> > +      * It is only set when both the kernel and the device support IOV.
> > +      */
>
> The comment is certainly accurate, no question there, but it sounds
> like the reason for adding it is because you stumbled over something
> in the confusing SR-IOV/PF/VF infrastructure.  If we can, I'd really
> like to improve that infrastructure so it's less confusing in the
> first place.
>
> It seems like part of the problem is that "is_physfn" is telling us
> more than one thing: "CONFIG_PCI_IOV=y" and "pdev has an SR-IOV
> capability" and "pdev is a PF".
>
> Many of the uses of "is_physfn" are in powerpc code that tests
> "!pdev->is_physfn", and the negation of those multiple things makes it
> a little confusing to figure out what the real purpose it.
>
> Maybe we should cache the PCI_EXT_CAP_ID_SRIOV location in the
> pci_dev.  That would simplify some drivers slightly, and if we had
> "pdev->sriov_cap" and "pdev->is_virtfn", I think we could drop
> "is_physfn".  But I don't understand the powerpc uses well enough to
> know whether that would make things easier or harder.

The powerpc bits were what I was looking at. Some parts use !is_virtfn
and other parts use !is_physfn which threw me a bit. Caching the
SR-IOV cap offset would be an improvement since all the is_physfn
usages are just tests to determine if any platform specific SR-IOV
setup needs to be done for the device.

> >       unsigned int    is_physfn:1;
> >       unsigned int    is_virtfn:1;
> >       unsigned int    reset_fn:1;
> > --
> > 2.20.1
> >
