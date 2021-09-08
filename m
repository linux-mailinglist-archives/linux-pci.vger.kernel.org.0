Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2E40327B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 04:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347098AbhIHCKJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbhIHCKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 22:10:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F91C061575
        for <linux-pci@vger.kernel.org>; Tue,  7 Sep 2021 19:09:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h1so812940ljl.9
        for <linux-pci@vger.kernel.org>; Tue, 07 Sep 2021 19:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMfhnZEDUobmgMhlgRrfI9FnzHQ5cBHWiHpC8dZfDL8=;
        b=PaytCRkY84O6DVS1dyHCT8Cfr2TXCcsOW8lD7RUZNnJhHuwUDUmbH8lDBBsT8S60wZ
         TrX2KvKSPjcbxEIdOWtmQs6VTGHmqiTLgkq/Pk/tZNUL+lEd1/5ClG0NwnwYDYmvPgqg
         8x2hDuO8nRlvlVXhOhFPNlqxephWBiaHokPOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMfhnZEDUobmgMhlgRrfI9FnzHQ5cBHWiHpC8dZfDL8=;
        b=HTCyxa27cilBLoz9fzjOIofm3FcVJ/aiG4uzEbeVT+aevZiZ44FIeqeFjQrdURrE7Z
         HYWxj80RwuuXVzq+qY5WXTh3OXFg5jIaElAWR6ZJ1+Y3WBeljCdpxn5BISIFy0Ip4F4o
         XZqIsdm9en+Z1gk1pnJpA6KRnm5Vo3JYZUXMbv9MCu8ExbJYpKTJb+7iWK3+5gk9N/6j
         aZfV0d3dVea8guexZzPmooNDgSGvHWcsaSLzVSEFIOViFjwxsjuiCHYShtKRn0x6Zn15
         HpnWnGK5RQASxabqv/EChZQm5asWrg1BPXvbndKgEpt4oHo8VWOf285ktChEBqC/3cTV
         84uQ==
X-Gm-Message-State: AOAM530hN/aFZTVbNy1DJRievmpE17Fx+qlAteq4yObJNXJD6kLGlY8h
        IoviGRYV26+ZDfDKaILZ8lOwpiJ7pVheW6QKcZU=
X-Google-Smtp-Source: ABdhPJxh+BoyJ6Mw8iJdP5Dznbztl4mYt66jx94F78GG9jBeLHPAeGCdNytp23oy7WbEZEJ3obYjIA==
X-Received: by 2002:a2e:a4db:: with SMTP id p27mr916654ljm.161.1631066939112;
        Tue, 07 Sep 2021 19:08:59 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id y7sm68829ljn.26.2021.09.07.19.08.58
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 19:08:58 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id i28so824865ljm.7
        for <linux-pci@vger.kernel.org>; Tue, 07 Sep 2021 19:08:58 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr867691ljp.494.1631066938338;
 Tue, 07 Sep 2021 19:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210907213943.GA822380@bjorn-Precision-5520>
In-Reply-To: <20210907213943.GA822380@bjorn-Precision-5520>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 19:08:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCgh_V-g74LE4pQKqakbiK+CM5opVtH1t2+Y3R=uH9EA@mail.gmail.com>
Message-ID: <CAHk-=wiCgh_V-g74LE4pQKqakbiK+CM5opVtH1t2+Y3R=uH9EA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.15
To:     Bjorn Helgaas <helgaas@kernel.org>,
        David Miller <davem@davemloft.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 7, 2021 at 2:39 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c
>   drivers/net/ethernet/broadcom/bnx2.c
>     Fallout from the VPD changes below.  These include both PCI core and
>     driver changes, and the driver changes got merged via the net tree and
>     then reverted so everything would be merged via the PCI tree.

Christ.

So the revert from the networking tree has basically _zero_ useful
information. It just says "revert".

David, that's not ok. The natural reaction to this situation is

  "ok, this commit was done both in the networking tree and the PCI
tree, but then the networking tree reverted it. So there must be
something wrong with it, and I should take the reverted state"

but Bjorn's comment implies that it was reverted in order to _avoid_
merge conflicts since it was also done in the PCI tree, which is pure
and utter garbage, because I end up with the merge conflict *ANYWAY*
due to the other changes, and now instead of going "ok, the PCI tree
had that same commit, all good", I have to go "ok, so the PCI tree had
the same commit, but it was reverted in the networking tree, so now I
have both sides making different changes and a very confusing merge".

Here's the thing. There's a couple of very simple and basic rules:

 (a) don't do stupid things. In particular, don't try to make my
merges easier by adding MORE crap on top of the known merge problem.

     This is not that different from "don't rebase merge conflicts
away". You're making things worse.

 (b) INDEPENDENTLY of that "don't do stupid things", the #1 rules for
_any_ commit is to give the damn reason for the commit.

     You can't just say "revert X" in a commit message. That's not a
reason. That doesn't explain ANYTHING at all.

So now I have to basically guess at what is going on.

Yes, yes, I can make fairly informed guesses from looking more
carefully at the code, looking at the *other* commit messages, and
doing something sensible. So my guesses aren't going to be about
tossing a coin. But please don't do these kinds of things!

Don't make my life "easier" by doing stupid things, and DO put a
reason for every single commit you do. Reverts aren't "oh, I'm just
turning back the clock, so no reason to say anything else".

          Linus
