Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2490A6B5497
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 23:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCJWjH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 17:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjCJWjF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 17:39:05 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316F12B7F2
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 14:39:03 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536c2a1cc07so125783207b3.5
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2023 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fy1fGIL2bpoDt3NLA0Y/Pd+S2vU/897Q5DSocMtRARg=;
        b=OUSRD4Q6LAbVnpah9wnrAMnccjh6wCex45l1qPZ+Ir7Wxjpr8hPNxIjwbD/oDDZKpA
         Z3IbVI+s+1BHghIdCman7gLgpDHoHNPVGwlLKDlUaT+vS5+h3T3C+LcBFxEpewIJXDa5
         tlrPFJ9idj45ssWlFzdTQ+lSdQuX1/80vqn84LxiNmlPd/RKj/2elt1Ox674BzN+7607
         h9rE5X/SCMRTswjHlT/017+/zkZdKze+1MYZ3KDExjdNNzeKfFer/5i/BX+3tKjDP5ny
         c//uYh6hDzSipLxFsQEBqlifGkPQNfI4YtAi01tqCxKGx4PSPzhxHGLLevqqbqBuEiWs
         frtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fy1fGIL2bpoDt3NLA0Y/Pd+S2vU/897Q5DSocMtRARg=;
        b=j/duXBs8KqXmFi3++MBh8HaT0e0bD3g/jaQYf2UWkztAri8LRv3rJ8+D+1utY99Rt1
         OMbIqNKsUPB/d6caps6sdjnR7QaCvQT27vmlArKap7MhzAYUHBxlZqXP6nG7AKskx/Qa
         zuMgH/b5piaeNMUWGvw3UJPii4bwnjTo6AXToGPHcFR0++AwaBR9TzEG9v5aiYepQBfs
         CSmtLfzBksAVCq4GGg9wyr0i/wytFBt6JVyTxDo/3+Y+kcFUi1x4G/Bm1PsXQHU29qd1
         h+hKk65p/fLhp6+PuPbzO8LX9rfX+TsbFEwds7u3QdYuPuoS5jgAtSZTDuuH4M8zXYMK
         UByg==
X-Gm-Message-State: AO0yUKVDc5AJpxOm+GtsIUIR1IYf+1pPqkstzG5EpcfQqo/MAv5kVqLz
        3udO3rCaFeKg+3V8tfk4xztP5fnLmRoqWQRnbE2fRQ==
X-Google-Smtp-Source: AK7set9GSqXjAMs5/5vdSSS4bpRTDuTGgYofIyyJ3iCHBzSDnSF+Jf2SlfUdi/I9iKS/kGdJUgniqkrHAUGGWDgCg6I=
X-Received: by 2002:a81:ac51:0:b0:540:b6c9:66cd with SMTP id
 z17-20020a81ac51000000b00540b6c966cdmr882596ywj.10.1678487942014; Fri, 10 Mar
 2023 14:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20220928122539.15116-1-pali@kernel.org> <CACRpkda-WcnRdwYNi0oeZsvX9xO+ECBF15rd41+Pr+MWmrZuBg@mail.gmail.com>
 <ZAs3SgNsYb31x4UU@lpieralisi>
In-Reply-To: <ZAs3SgNsYb31x4UU@lpieralisi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 23:38:50 +0100
Message-ID: <CACRpkdZN=Rid894wruY14b+yFt3su8ejJbKbEH57ynoDxce8qQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 2:57=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
> On Tue, Oct 04, 2022 at 09:56:18AM +0200, Linus Walleij wrote:
> > On Wed, Sep 28, 2022 at 2:25 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> >
> > > Simplify pci-ixp4xx.c driver code and use new PCI_CONF1_ADDRESS() mac=
ro for
> > > accessing PCI config space.
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> >
> > I have no way to evaluate this change in my head, once the kernel test =
robot is
> > happy I can test the patch on IXP4xx.
>
> If you can manage to test it I can go ahead and merge it.

I managed to test it with a oneliner to add the right include on top
of v6.3-rc1.

Yours,
Linus Walleij
