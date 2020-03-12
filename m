Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AF81827C7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 05:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCLE2t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 00:28:49 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:34344 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLE2t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 00:28:49 -0400
Received: by mail-ed1-f54.google.com with SMTP id i24so1853831eds.1;
        Wed, 11 Mar 2020 21:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kc0+yDmV56P7833fL1rNbt5FwQv4lowS4XpMZL4q1F4=;
        b=Qz/oWCDY3paePBJTYkBCuvoDZKmyiUazg+vNtKS1XBhZnFKfyrFGYXNm20mTcKaA5W
         Ztf911RY6ba21g87k6lg4fdj7NS5jdiLn59gzO7qqafDkchLI6+S6FASYlad3XULJokr
         lXrvIPqn7WQb8VJ+RI+6SsE90UogzPjYEfD9cni2WiF2eECnEvbW+gzXXsJibmeDo3Ty
         IcnUfMiTaC/9qvaVdYkEyPUYAhPT5yZBkjGqLCxj5R+yzD10lTkECEp7QZ+6R07dxv90
         XCo8+z+vkwnZPaKTu7mDBHjPjH2YrsLI3TckiYnJ7WNOSaCTVr5ukIximj+m7tsM6bNi
         zNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kc0+yDmV56P7833fL1rNbt5FwQv4lowS4XpMZL4q1F4=;
        b=H8LbXViJ4TD0eCUK1Xjzh/Apyr2y7YIxkwrSkgj/DvmHzJa4kx2sduXCugeJUAP1t5
         NNw8n7TFrTmu5xxPm1aQWuDIiZVF9PfwIAY+TlRbBer2WWiqAUB6wwt3tzWneZ2D6R7t
         Fq4SwPgtPsH//8IADXyglAMUdcjE06r2T0Z9kW3BN+EnVPMkBzwFOXmAnh7/UA07iE6B
         /DvA4m2B4l0zXJrwv02Nre8NAYpM4HmY2ctSvqS8oNlgsoFaV6AvM0r47qh11h3KaIHv
         cy6F6C7xs33BioFR2AMPLWQabW6UU7lDTX1PgXpaBqOcSx3EkWhKm6oZtjX7gmRDZMhr
         6dAQ==
X-Gm-Message-State: ANhLgQ0IBT3Phk01xVPHYiAv0z4nJCYCfxMg+0bK1GO3+1DwjwWrNCo+
        MGsNKhFVWhyLU2taYJorvqE13ZikQ+Gz80xK/CvkZZ2F
X-Google-Smtp-Source: ADFU+vvvnJ1JgITvEXzhwZtDA0w7guI9cA8QNWVdRZefO+9yGOIIvJ4Bnd4lAUu4L0gzCMgR4OedalS/fm+F3H755vc=
X-Received: by 2002:a17:906:4758:: with SMTP id j24mr5051169ejs.372.1583987325131;
 Wed, 11 Mar 2020 21:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAEdQ38EzZfUJA-8zg-DgczYTwkxqFL-AThxu0_fC2V-GkXGi2Q@mail.gmail.com>
 <20200302224732.GA175863@google.com> <20200308153004.GA17675@mail.rc.ru> <CAEdQ38G1YhEoQUEpDT6k_uwodxTOs=BYigm_VQaDDdfaoXM6Wg@mail.gmail.com>
In-Reply-To: <CAEdQ38G1YhEoQUEpDT6k_uwodxTOs=BYigm_VQaDDdfaoXM6Wg@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Wed, 11 Mar 2020 21:28:33 -0700
Message-ID: <CAEdQ38HhKq9L3UF=Hapmx-BJ7eLLRfo26ZxFUFqXx+ZEY0Axxg@mail.gmail.com>
Subject: Re: Some Alphas broken by f75b99d5a77d (PCI: Enforce bus address
 limits in resource allocation)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yinghai Lu <yinghai@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-pci@vger.kernel.org,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <jay.estabrook@gmail.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 8, 2020 at 12:41 PM Matt Turner <mattst88@gmail.com> wrote:
>
> On Sun, Mar 8, 2020 at 8:30 AM Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
> > Wholeheartedly agree. In fact, changes to generic PCI code required
> > for proper root bus sizing are quite minimal now since we have
> > struct pci_host_bridge. It's mostly additional checks for bus->self
> > being NULL (as it normally is on the root bus) in the
> > __pci_bus_size_bridges() path, plus new bridge->size_windows flag.
> > See patch below (tested on UP1500). Note that on irongate we're
> > only interested in calculation of non-prefetchable PCI memory aperture,
> > but one can do the same for io and prefetchable memory as well.
>
> Thanks Ivan! The patch works for me as well.

Bjorn, what would you like the next step to be?

If the PCI bits are fine with you, I assume you'd like them to go
through your tree, etc? I'm perfectly happy to see the alpha bits go
through the same tree.
