Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2441F4032C2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 04:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347302AbhIHCyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 22:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbhIHCyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 22:54:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E75C061757
        for <linux-pci@vger.kernel.org>; Tue,  7 Sep 2021 19:53:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h1so950031ljl.9
        for <linux-pci@vger.kernel.org>; Tue, 07 Sep 2021 19:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjvpMqPdNZFQsYmJZHelUV/clBYJUUkWHVd43X/arJo=;
        b=OPV6yfb2KvxvQvVoEx2dtPnNZNoGBs6s1nUmz1enVOwBZLubjzkZqjxpzBWalY8UGt
         icqdafw8DgsyMogRySKd8EoEnE30gQTUJzi0d69tvAdBC1jlE4TwMXN+qDTeglbnd8nU
         HqLrA1idTwI5PHzQyFj1h4a8p0IzQgUpN3Ks8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjvpMqPdNZFQsYmJZHelUV/clBYJUUkWHVd43X/arJo=;
        b=MzrXoVr42VR1ScFfKzcSP2cot/tkgKXW8g0+fhcm/L5MG/oEx53oecFp7ZGG0xP5qo
         P+I0SytDSSIfWQajX4YJBrLwvyLBDaMZOx40f8KDYtX4G8rPBe3aA+Gf+c2RoCYTy7JF
         yPyqDmc2GIvti0EVwqP/SiBeCVICiAV8CoIClzPO/kK+cPW04qlA3pfRGE2/37vA3/VL
         JfmNoZJ4cvpvekfumUeiLkCcseN+ChUS5KMh/yK5iPdIBfS9AeZEVmB50Cc8uyseTlj3
         2AoxVL7+pv5k59cHZzmAd2CTJsU7k0HvvQa+pYUYw9BA8W5RAKzOjJG+lJJhP7eQj0az
         1xWA==
X-Gm-Message-State: AOAM532Zi/71Z7EBDlYsVDhryIuMcuCc/5weiCWCGOMEE7b4yYkZAq7L
        TqaeAF45any8Bd9Ruaibv45/ITl17QL73QzgAUw=
X-Google-Smtp-Source: ABdhPJz9JJyeKTvqiESWuD1NOGwwHj+epsFF9T0v4mlyulApPWKfDcKQyE7wBoOGzPBLcdf0k0V/Vg==
X-Received: by 2002:a2e:9049:: with SMTP id n9mr982430ljg.425.1631069580725;
        Tue, 07 Sep 2021 19:53:00 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m5sm81002ljg.55.2021.09.07.19.53.00
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 19:53:00 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id e23so1830336lfj.9
        for <linux-pci@vger.kernel.org>; Tue, 07 Sep 2021 19:53:00 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr1044974lfg.402.1631069579859;
 Tue, 07 Sep 2021 19:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiCgh_V-g74LE4pQKqakbiK+CM5opVtH1t2+Y3R=uH9EA@mail.gmail.com>
 <20210908022620.GA845134@bjorn-Precision-5520>
In-Reply-To: <20210908022620.GA845134@bjorn-Precision-5520>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 19:52:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whk-OFqqFbiyuY3_f2h2gp4+vQ7ZR-mhm=h2-=V07y4vA@mail.gmail.com>
Message-ID: <CAHk-=whk-OFqqFbiyuY3_f2h2gp4+vQ7ZR-mhm=h2-=V07y4vA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.15
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 7, 2021 at 7:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> I was a little mystified about why there was a conflict at all, since
> I expected those patches to apply cleanly on top of the revert, and I
> should have investigated that more instead of just chalking it up to
> my lack of git-fu.

It's because that wasn't the only change to that function.

So for example, the networking tree had that "bnx2: Search VPD with
pci_vpd_find_ro_info_keyword()" commit, and then reverted it.

Fine - that's a no-op, right? So then the fact that the PCI tree had
that change - and other changes - should just merge cleanly.

Except the networking tree *also* had "bnx2: Replace open-coded
version with swab32s()", and that wasn't reverted.

End result: the networkling tree and the PCI tree touched the exact
same code, and did it differently.  So - conflict.

And the bnxt.c case is similar, except there the networking tree _did_
revert the "other" commit too, but it seems to have actively done
something else as well. See how the networking tree actually has that
"This reverts commit 58a9b5d2621e725526a63847ae77b3a4c2c2bf93"
_twice_, because it did it wrong.

Anyway, because of that "revert twice", my tree actually had (before
your pull) that

        i = pci_vpd_find_tag(vpd_data, vpd_size, PCI_VPD_LRDT_RO_DATA);
        if (i < 0) {
                netdev_err(bp->dev, "VPD READ-Only not found\n");
                goto exit;
        }

code duplicated twice, so now the conflict was due to that.

And the thing is, the revert for some merge reason is always the wrong
thing to do, but it's doubly wrong when it's done badly.

I'd *much* rather see a few more conflicts, and then go "oh, tree X
and Y both did Z, but Y also did ABC". That's a very straightforward
conflict, and I can go "I'll take the Y side" because it's clearly and
unambiguously the "superset" of the changes.

The revert actually made things harder. Now neither branch had a
superset of changes, and the networking side in particular looked like
the original change had actually been in error, and should be reverted
entirely (and the PCI side had just missed the problem). See? It
actually technically looked like the networking tree did more, and
knew more.

A revert is additional work, and by default I assume that a revert was
done for a sane reason (ie "that commit was broken, so I'll revert
it").

In this case I had to take the hint from your pull request that it
wasn't that the commit was broken and thus reverted.

So the networking tree did two really horribly bad things: doing extra
work for a bad reason, and then not even *documenting* that bad
reason. Either of them is bad on its own. Together, they are really
really bad.

Anyway. I obviously _think_ my merge is all good (and it wasn't really
a complicated merge despite the annoyance), but considering the
confusion, it's always a good idea to double-check.

Because mistakes do happen. I'm pretty good at merges these days, but
they most definitely happen to me too.

            Linus
