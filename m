Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60D1B7C92
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 19:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDXRWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 13:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgDXRWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 13:22:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44AC09B047;
        Fri, 24 Apr 2020 10:22:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r16so7881717edw.5;
        Fri, 24 Apr 2020 10:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tUhiZxcOIf4jm93sekkZu5FCILE8XNUpVlz+DrsTEE=;
        b=vb+kZWdhktmIfHd7zaPAGr1zYsH7v+0z/cYdtshN3kuk1Yf+k/12HZtYYAxt0krRtU
         B4nX231ZNzbOwv0p4mbBtjv7NQ7cWQghUniE34JcPdQxen7Vt76xI7NO99jdgkLq8YAN
         KNDAvTwjErBKBAugZfN4f/5tY6Kij80h3dtzk8r7RB3JUN0/eJ0vI+oCxkUakuPQjyqf
         HrmABrZiMo7Z/udpv0IIikjooQQpXiP5O15zqB3il8ihlxg6Ojk4ZLRGtGOr3ExuleRS
         Ppv6lVmURAO3FomhseEuYGyLu1Sy+NJNBdU4xGnCzo73q6KAOkQBp5FvlvyM3cct52ap
         sIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tUhiZxcOIf4jm93sekkZu5FCILE8XNUpVlz+DrsTEE=;
        b=sGxmheAxYCpZ+2ouGLeVIV9NEzjIF1I7kFIlmx7J2HNjChTmyX4Ha7cVIFieHIAwRQ
         HuRlq4LsJV79fN8/XYqCpz7RPOcKK6BqJfmbhcbCSDSwkVndl+Af+gsFDapkOyX8R4o4
         hPtsIGXzCgL3d7QtC26sB+jydriZRBbuVdg026UXnMtBm21ajL8CuC0mztd423SCKOzP
         Y2IKlCEu7fhQs6UxVC7Rg61Jt4uvjtiZD/S1zdkj7MrrOjp6imxOtlviR0TvOA6PlIru
         n8kyeqC/8onyvDd9vm6zyLpeMI1uKEBwC2TPwmCf2ktFkyKbM+4IeYiDtU7rfL2O2/LT
         tEeQ==
X-Gm-Message-State: AGi0PuYf3FNmGi9uxCMV3iraoWXIfv2TaxdOFjBmD8SCLKn0khxnuNga
        5a8AaGQ0kb2pvD10G1DNA70JBgt2s8C1dnRbtto=
X-Google-Smtp-Source: APiQypIAcG1vzHOEm3gHbqdAaIY+XvY1LohhW8JBIJdepYkV2ZAmi1Q+H5phyNCH5cE15btAqnn9Vb9OzrtV2fgTAsc=
X-Received: by 2002:aa7:cdcb:: with SMTP id h11mr7941375edw.264.1587748921092;
 Fri, 24 Apr 2020 10:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200424032305.GA32366@google.com> <20200424035549.GA37906@google.com>
In-Reply-To: <20200424035549.GA37906@google.com>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Fri, 24 Apr 2020 18:21:49 +0100
Message-ID: <CAEzXK1o9grcd7mN2ixNnU-qcitHFrsRWHoC54jb--Mz2r+AChQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v5.7
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I think a "warning" would of great value, as it would be easy to
identify the root cause of such issues pretty quickly.

On Fri, Apr 24, 2020 at 4:55 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Apr 23, 2020 at 10:23:05PM -0500, Bjorn Helgaas wrote:
> > Yeah.  I don't know the history of why we skip PCI_CLASS_NOT_DEFINED.
> > I did consider about the fact that we're skipping it, to make it
> > easier to debug next time.
>
> I did consider *warning* about ...
