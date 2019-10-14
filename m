Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF0ED5B39
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 08:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfJNGSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 02:18:18 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43667 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfJNGSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 02:18:18 -0400
Received: by mail-qk1-f193.google.com with SMTP id h126so14889740qke.10
        for <linux-pci@vger.kernel.org>; Sun, 13 Oct 2019 23:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqKcVf6BlzXJcN3Dn+3SB+F5+GJnbOOd5dOqKoYVFbQ=;
        b=Dexi5+e+0aNyT+H4oup4xfEmK8vXVLM1adv2RBkDnZW7A8lrje9aaLZBu7g8WFEIOq
         e+zCaPWI7RwJrdB8+psBjEJ6QAkansjm22bMh9HNtuxY090wnm0uV1r/x1by2f0aHL4P
         XSrp1m+CPyQLvv3c5UMSnRJXfvAcSpj7jHKe5CoGlY3SDJgU7zkBvcAMokXz5yODEI2K
         Ek4v3tHipCXet9gCTCd1Vfpf5ciXpjmr5/GfOjNl0uAnsJbfxeUkkMkNk5/NEb4RKdA0
         shWzZzLsdFIV0powDfrCmSEurELoLFxD/hOzL+Y90EvhanJ0n33qlgmLozemlc4cJld8
         VBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqKcVf6BlzXJcN3Dn+3SB+F5+GJnbOOd5dOqKoYVFbQ=;
        b=CVnYC4lRLjINkkV5J6Es6HTgTYI0Ul4IadCg0Q5O4J1EUuYQYXGOZ0emyHMlKRV8ba
         Zp0eKJaB2p8d/q1zHzsbgjAML+sz5TbpnH85Tv4xh8I5toyPrYXyc+ASlTNswkVGgmNS
         sKygQCyryo5vJfjuK0fLWoL6wyKvO7SVwS/qVKpQXG2Hawr0eSnLiyPDDZrHGcKg4apU
         oRz5ZMcTinjJjLw/j2B+XG3M+yoqEKjaCTNDJmcGK2YdQo81eodipmXCkbOmKRE+PSrm
         PN9AFdm4bX+YT9JjBUK7iQtotdLioyN7EZFsZ7wyZDSMbNnPDGd38DWsCq+kn2ylj7Vt
         A9ZA==
X-Gm-Message-State: APjAAAXqHy+hlXdK/zzkxQVRcxX6mul6fGq4rgAd0vmL4jFYs1Ey2BmO
        EvCpYz9mExKlqi1d30SA4GH60OFD+5bm35takNp5NA==
X-Google-Smtp-Source: APXvYqwhDLUMrnCKYP6emCXVillOtZV/837gKLxFSJ6O1Ob9HCMOn9BiV/w7/6uclzMAHaN2b/EdItMMb0VXDQvp/Zs=
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr27866532qkj.14.1571033897385;
 Sun, 13 Oct 2019 23:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190927090202.1468-1-drake@endlessm.com> <261805141.5tZyQaKU0z@kreacher>
In-Reply-To: <261805141.5tZyQaKU0z@kreacher>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 14 Oct 2019 14:18:06 +0800
Message-ID: <CAD8Lp46NF8rq55g0Mz40Mmz1+KzqrTzziK3oYcmfh=1RUCRzug@mail.gmail.com>
Subject: Re: [PATCH] PCI: also apply D3 delay when leaving D3cold
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 11, 2019 at 6:14 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> So I think that we can use pci_restore_standard_config() in the system resume
> patch too, which should address the issue as well.
>
> Basically, there is no reason for the PM-runtime and system-wide resume code
> paths to be different in that respect.

Your patch works without modification when combined with
https://patchwork.kernel.org/patch/11187815/

Can you push this directly or would it be helpful if I update the
commit message and submit it by email?

Thanks!
Daniel
