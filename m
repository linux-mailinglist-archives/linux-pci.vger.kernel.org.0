Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8BC3BB6B1
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 07:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGEFQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 01:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEFQb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 01:16:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D88C061574;
        Sun,  4 Jul 2021 22:13:54 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r4-20020a0568301204b029047d1030ef5cso10215152otp.12;
        Sun, 04 Jul 2021 22:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+VkB/bnz8785c81a+SwRBAk920PLP5ZGWYbA1JiHcE=;
        b=s0uL3AS3xXGDcWhZVTmmu6jCfJfwPK5PiGh3tqu3GzTytFy0/vC9amvNlth+OTzaSb
         eIvEm4WJufO3O0zsQSOYPtZlQF2v4ixqCkjYX2/2ljFBZaG4q75tjF3XYTmgoIFn6KnE
         DmHLPZ3iUbe6OM+huXwgpAm1cNYazdI2KRT6jrQZoJw3eVLDYBKCEhwIwz5qlytgb+8V
         ulV7AoZ6MuVkEXmjSQfOYOoWB3QIm8FL9Fqhx3jPe8tJEmYO118Tqb4+qNtv+uSGAlWW
         AgOUB5Xept9wnOf4ed9JGqI/XkkrD6l2LF/18yIOvO2AWdl9uqahGLvEVVHsdvpBOHoj
         BRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+VkB/bnz8785c81a+SwRBAk920PLP5ZGWYbA1JiHcE=;
        b=JTS3/ovBQrXmocdWUhc0uPcE2aK64tsaR/JD6GoFkuuiVoAXPGn0Yum164HXhfrXFz
         lbCJrrfzCyGURj3D4Zl+Mk+PEkXOsGmn3C5V1+OAYffnLcjM1MpekW3CFmWwOyhRdrRL
         mufLMK9eZ/xQGeZ1VpMOxvVz8VAlKSHqEiyf3zqDckVBQTZ7pUH2tHSZatStXvVp1Vzn
         Tzdmimtru6FYT2Xtsn8s9ovKyiRhcMPNim0LsN8uRnRSBq+S0/PfRj4XYvvvpNACVVqF
         OHSA0c6oDe62dN4rG3YmBNoeBJXZ3KPYE3UsXQS0Y0jAdB9HnnzeTRBHCLAuMP0e4S6S
         VHfQ==
X-Gm-Message-State: AOAM531oJu9BjjZA6LahdeoQs1A062S/ruK6ShKOv8XeGdtJXIt5kz7j
        /yacHxy0GF43Hn6MaM8FxnGg96Dhp1chs46Ixw==
X-Google-Smtp-Source: ABdhPJz9HX2UgYuFSNETAkklZizTRbYB4sZl67P1RqplYekvFnCNC9pmhMhf9A5ZHcZNQROaCEKtU+mKieuGue8jqIA=
X-Received: by 2002:a9d:ecf:: with SMTP id 73mr9867041otj.5.1625462033929;
 Sun, 04 Jul 2021 22:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <1623294161-7917-1-git-send-email-zheyuma97@gmail.com> <20210701223407.GA104070@bjorn-Precision-5520>
In-Reply-To: <20210701223407.GA104070@bjorn-Precision-5520>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 5 Jul 2021 13:13:42 +0800
Message-ID: <CAMhUBj=FKcox+EkFtJm=LVWyBwDHd1SSQLwnKbFc6Nu1t0uUYA@mail.gmail.com>
Subject: Re: [PATCH] PCI: hotplug: set 'thread_finished' flag to be true by default
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     scott@spiteful.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tong Zhang <ztong0001@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 2, 2021 at 6:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Tong]
>
> On Thu, Jun 10, 2021 at 03:02:41AM +0000, Zheyu Ma wrote:
> > In the process of probing the driver 'cpcihp_zt5550', function
> > 'pci_get_device' may fail, at this time 'cpci_hp_unregister_controller'
> > will be called. Since the default value of 'thread_finished' is 0,
> > 'cpci_stop_thread' will be executed, but at this time 'cpci_thread' has
> > not been allocated, which leads to a null pointer dereference.
>
> This looks like the same problem Tong reported here:
>
>   https://lore.kernel.org/r/20210321055109.322496-1-ztong0001@gmail.com
>
> I responded to Tong in that thread, and my response to this patch is
> basically the same: I think "thread_finished" is a hack and we can do
> better.

OK, I will reconsider the patch and send the next version to you.

> > Fix this by set 'thread_finished' to be true by default.
> >
> > This log reveals it:
>
> It's good to have the essential details from the log, but most of this
> is not relevant to the problem and should be omitted.

Thanks for your advice, I will delete it in the next patch.

Regards,
Zheyu Ma
