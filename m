Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3A32265C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Feb 2021 08:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhBWHXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Feb 2021 02:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhBWHXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Feb 2021 02:23:16 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85361C061786
        for <linux-pci@vger.kernel.org>; Mon, 22 Feb 2021 23:22:35 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id s107so14644850otb.8
        for <linux-pci@vger.kernel.org>; Mon, 22 Feb 2021 23:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpaF+XrlRPqLNZ9QA+WPiUs8joOVV3LopnoOJY64BvY=;
        b=NNHrJmW2jS2V+5T5AnL3km3Re94L4xGJBmhxFBh2hds03thqQwHd7qJsFgwTZivSdQ
         NSO3FN0AG5yjRNFwS65SNpwo53eWoeYKuUazm8g91zmj8b91UhpkIFl/QsUA84rbArMP
         C7qosv5wai1B+yRpvR75pcLBJGTVy5QbiJJC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpaF+XrlRPqLNZ9QA+WPiUs8joOVV3LopnoOJY64BvY=;
        b=V/8e9iy6oophg6CCMF/Lz6ineHw4HDzo+yBEufcC68LaRQO1x3LBNfUqxd7M8TGm3N
         0nuwq7bq7kZHRu4D61BIkEZBRk9IoafWMbt0hYOr8LjgewYxiJIKZ10q8x5On1v2hAJI
         doe6iPpr2WsWwEBTo1p5btg6g8M/7tBg1qbRkobMzYuuVanHyJCJSkr7QTeIwYWykfox
         oZIhm+ADxU878EYpvjogwtjvGX54dSyUNPiCetCAoea6Lt2cEQPnKl2JWeBRjy51TaTs
         U6mnpxwu79cTe7bULRylBtUzXlcmueQuA9KmLkFJltw/HAzP7jdItClvXFJVsBt+JrX4
         3Ong==
X-Gm-Message-State: AOAM530+OWPd+IkshCsO8YqCyVqhgGkDX3fwca4/Qz1KTmr/QtS9Hg+X
        x1qtHh5Ogg4WbJsmrqFOeD/yoboipyIPnaWry7UWdEnGc1E=
X-Google-Smtp-Source: ABdhPJxtl+72oyQ1eandtDlxtpzvuP13KO1x4mZOnmum5QmMKuXAKYArHHVy/wyUyz+iO6PacAYQlwwOj30kkS2JMcw=
X-Received: by 2002:a9d:2265:: with SMTP id o92mr19488004ota.188.1614064954922;
 Mon, 22 Feb 2021 23:22:34 -0800 (PST)
MIME-Version: 1.0
References: <YDOGERvNuU3+2WWe@phenom.ffwll.local> <CAKMK7uHQ=6OJcRguCUtiB456RWdCfwSNEXV8pQsfsPodTJ6uxw@mail.gmail.com>
 <CAHk-=wjNv9izaVO5+1n5zk01zP3mndqdd2zKsX_syq9ntgY2YQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjNv9izaVO5+1n5zk01zP3mndqdd2zKsX_syq9ntgY2YQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 23 Feb 2021 08:22:23 +0100
Message-ID: <CAKMK7uG2fg0Q9fSPxHRFuBGRX-=dmCRp+_030B70jhST0hVNYg@mail.gmail.com>
Subject: Re: [PULL] fixes around VM_PFNMAP and follow_pfn for 5.12 merge window
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 23, 2021 at 2:42 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 22, 2021 at 2:25 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Cc all the mailing lists ... my usual script crashed and I had to
> > hand-roll the email and screwed it up ofc :-/
>
> Oh, and my reply thus also became just a reply to you personally.
>
> So repeating it here, in case somebody has comments about that
> access_process_vm() issue.
>
> On Mon, Feb 22, 2021 at 2:23 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > I've stumbled over this for my own learning and then realized there's a
> > bunch of races around VM_PFNMAP mappings vs follow pfn.
> >
> > If you're happy with this [..]
>
> Happy? No. But it seems an improvement.
>
> I did react to some of this: commit 0fb1b1ed7dd9 ("/dev/mem: Only set
> filp->f_mapping") talks about _what_ it does, but not so much _why_ it
> does it. It doesn't seem to actually matter, and seems almost
> incidental (because you've looked at f_mapping and i_mapping just
> didn't matter but was adjacent.

Yeah it doesn't matter, it just confused me, so I wrote a patch to
remove it and get experts to tell me it actually really doesn't
matter. So that's really the entirety of that one. Like I said, I
mostly stumbled into this rat hole because I had some questions,
wanted to understand stuff better, and the code did not provide
consistent answers :-)

> And generic_access_phys() remains horrific. Does anything actually use
> this outside of the odd magical access_remote_vm() code?
>
> I'm wondering if that code shouldn't just be removed entirely. It's
> quite old, I'm not sure it's really relevant. See commit 28b2ee20c7cb
> ("access_process_vm device memory infrastructure").
>
> I guess you do debug the X server, but still.. Do you actually ever
> look at device memory through the debugger? I'd hope that you'd use an
> access function and make gdb call it in the context of the debuggee?

tbh I had no idea this exists, but yeah I've fired up gdb on some of
the register dumper tools we have that use the pci mmap files, and
after fixing some thinko in the first version it was still working
after the conversion.

From a quick git grep almost nothing wires this up, so yeah no idea
whether it's still used. Definitely not useful for X hackery anymore.
It is wired up for uio framework, and I guess for debugging userspace
drivers this comes handy. Although letting your debugger do
reads/writes to device registers sounds scary.
-Daniel

> Whatever. I've pulled it, and I'm not _unhappy_ with it, but I'd also
> not call myself overly giddy and over the moon happy about this code.
>
>              Linus



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
