Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226E136B501
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhDZOhT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhDZOhT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 10:37:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB9EC061574
        for <linux-pci@vger.kernel.org>; Mon, 26 Apr 2021 07:36:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id o21so13586193qtp.7
        for <linux-pci@vger.kernel.org>; Mon, 26 Apr 2021 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgN12ocE0EK9JtgtGYMMlRTcuo1FA3PKpVpOsbNTaR0=;
        b=QyTmBHst1XVfezg5OXrsHuMLEhG2osH9WuiqeSwJ+ZOqyG+4tEO4XqV1ME/TTzM/32
         uPMBLK33d9pNe8tFYS8qw8kfGphaeD1ebCpiSYlmpTeHsRmRsU5UG5bnRTL6d0TrZpg6
         6280a7ODrP7Ai1MPHEiPP+iZDlxMcdHvIichxk4wr1/r9uwb02qRtz3Hb0oM2+xQOJdq
         hMxBmyzGUUvfHz4ScBV4CR3DnKZ4nMa+1pE+bYeBCC3aX25UXh99w22P7/bX8n9F74Zp
         wb2HGAS5cCkmOKC6eISOXtWRYijNzbRnM9NON7whd+ZqekL1aVmZHKtb3x530kV8QvRh
         VLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgN12ocE0EK9JtgtGYMMlRTcuo1FA3PKpVpOsbNTaR0=;
        b=Nnzj3M/VFvaoSLoL4U/NGlWyVvineilsNjogvsNQN4LetBYO0/8P9gZ86WOi1xd9Sh
         F4fQqPQRC25tTzw2JN2w/PAdkamwdFwO33u7HREX3/ORT4hsoLCXoksXfJFm1ciOm/im
         1CZK98zb/HPqMqPS8tJzLI1TeS9NBZh0S7NbUSWwBdZ0qQvpvbGRKRy7Zibn5EjdJbxe
         jpOanNvJlZF2L2o5kqz//KHAaVkDBPl3/LOzyebRZssOulK7ltemGFaalhtY/HLjKcj2
         oIKsRToZP9pluSUlneSAcLQa8PkiBAPQh+QAG+Pyf/NE0G2hA5Cku9l48zQqvX+WpysG
         OL3Q==
X-Gm-Message-State: AOAM5325/IT1wNEy/NNAb1ZcIKqiNpa5AJWzBNBUPlX3u1ctuVC+/nIY
        PpHrPicoaSLvc9GeCjSSRGMTdXKm1z6tzn/iYEs=
X-Google-Smtp-Source: ABdhPJxz1lpaCCvy0wQw87Ns1UDaPolfKhi2kKtvJ71VCbrO4YZn6kEyCJUm+ydFzkjyfqGu2qpwx3eaLuwhmqsWbeI=
X-Received: by 2002:a05:622a:1341:: with SMTP id w1mr16972795qtk.347.1619447795763;
 Mon, 26 Apr 2021 07:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZuSZck+mTnCTkGikuxQpmNyiShmrbhUUtv91rZARL5Jsw@mail.gmail.com>
 <20210225220305.GA35159@bjorn-Precision-5520>
In-Reply-To: <20210225220305.GA35159@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 26 Apr 2021 16:36:24 +0200
Message-ID: <CAA85sZvZ2o5EXK+yM2JBy5wnLb9NL6sfdFyzvqRjq_ZvO8P-aw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/ASPM: Use the path max in L1 ASPM latency check
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 25, 2021 at 11:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Feb 24, 2021 at 11:19:55PM +0100, Ian Kumlien wrote:

[... 8<...]

> I think the most useful information would be the ASPM configuration of
> the tree rooted at 00:01.2 under Windows, since there the NIC should
> be supported and have good performance.

So the AMD bios patches to fix USB issues seems to have fixed this
issue as well!

There are still further fixes to bioses available, but currently that
is in beta form
