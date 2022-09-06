Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3905AEFC7
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiIFQAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 12:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiIFQAJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 12:00:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632C83F3D;
        Tue,  6 Sep 2022 08:19:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fg1so1952572ejc.2;
        Tue, 06 Sep 2022 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ma2iDt0aE81Ahc9ZUJZycp2jvO5tJvy1n9qVt6gCQwI=;
        b=mZ+FcifZ+4aqabfna498JJgJVm7ZJdYQe8WPPtTpmukN0ltsFgbqVaNbL1sFWPnx0F
         +kFG3VCNFENVAovNsysmwpOZ9RuJ0ufsyH/pTm2Y0z5gRcOpO/R+heCj40VC0B/407ah
         gIy12X9ei8z3+szxvE4NyRdxrjANyShKAEl2/x/Zm5O/QSiE8OYXer9bdBZdxhHaAE7q
         f4tiV5HYLbiMy7AqJzsjwqwX5vSbICO2tfPlRmT+E50cm2MApRR8eNqmx5TuhyMcbdUY
         7WrJdlicqbcwsKebKLfXD1Wod6uRLkMhZP+32t59uXM5n6TIYOGjSb2jPimnfwACXEvM
         IUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ma2iDt0aE81Ahc9ZUJZycp2jvO5tJvy1n9qVt6gCQwI=;
        b=QH4OiwHDUmSV5zbjGts8jFsfEsjPJy8my6Y58o3F0l05IgPR3o9NrNwBtGFY6aQ48W
         IXTH+NPQ/Mo0c9mymKo0BcfB20okmT3c0ZQTj52Eu8TTxs5exf0dj/8wLdvnKSzxXtEj
         bZzUz/WD6ZS0eLKIJrN9OKxENRQy/zGiSU8HTikjywdchJ0U+rCnHmizDuSJFKiIPYtn
         D3vr/2aGJ26S4ruj0ZemXKpjiP/d6x5mSZ5TCcO1DEDhUOpEzmZ+UrveL3hpJCxDod5d
         2x4lZb91CQo5hwNI00Va9x1VCf2E6LFgFTmKWjzp/4quKqhoXbhR3Rvki0aoC7Wq0qW0
         gEPg==
X-Gm-Message-State: ACgBeo1CXck8HreLTMMATX3x1WXuulmWxjPTlvGkevh5pTOuuyAocotS
        NqYOQj3Q0qDah5YLcctkhX9NAbDI0br2mVOBf7A=
X-Google-Smtp-Source: AA6agR5G9HfMrf0VgwjZaDpL+Bw3LD81rl/8ufqZpYLsPbGzQjkQjICo51PcirHskBDNf2s6ND3MqbShzMKHHJ8IDw0=
X-Received: by 2002:a17:907:2ce7:b0:741:6e62:4558 with SMTP id
 hz7-20020a1709072ce700b007416e624558mr31784827ejc.273.1662477550254; Tue, 06
 Sep 2022 08:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220829151536.8578-1-jandryuk@gmail.com> <20220902165921.GA354189@bhelgaas>
In-Reply-To: <20220902165921.GA354189@bhelgaas>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Tue, 6 Sep 2022 11:18:58 -0400
Message-ID: <CAKf6xpt9DDjQoMsu9e09Gq_Bb_VFe2gzU9faARTsfS6c45E0bg@mail.gmail.com>
Subject: Re: [PATCH] xen-pcifront: Handle missed Connected state
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 2, 2022 at 12:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> The conventional style for subject (from "git log --oneline") is:
>
>   xen/pcifront: Handle ...
>
> On Mon, Aug 29, 2022 at 11:15:36AM -0400, Jason Andryuk wrote:
> > An HVM guest with linux stubdom and 2 PCI devices failed to start as
>
> "stubdom" might be handy shorthand in the Xen world, but I think
> it would be nice to consistently spell out "stubdomain" since you use
> both forms randomly in this commit log and newbies like me have to
> wonder whether they're the same or different.
>
> > libxl timed out waiting for the PCI devices to be added.  It happens
> > intermittently but with some regularity.  libxl wrote the two xenstore
> > entries for the devices, but then timed out waiting for backend state 4
> > (Connected) - the state stayed at 7 (Reconfiguring).  (PCI passthrough
> > to an HVM with stubdomain is PV passthrough to the stubdomain and then
> > HVM passthrough with the QEMU inside the stubdomain.)
> >
> > The stubdom kernel never printed "pcifront pci-0: Installing PCI
> > frontend", so it seems to have missed state 4 which would have
> > called pcifront_try_connect -> pcifront_connect_and_init_dma
>
> Add "()" after function names for clarity.
>
> > Have pcifront_detach_devices special-case state Initialised and call
> > pcifront_connect_and_init_dma.  Don't use pcifront_try_connect because
> > that sets the xenbus state which may throw off the backend.  After
> > connecting, skip the remainder of detach_devices since none have been
> > initialized yet.  When the backend switches to Reconfigured,
> > pcifront_attach_devices will pick them up again.

Thanks for taking a look, Bjorn.  That all sounds good.  I'll wait a
little longer to see if there is any more feedback before sending a
v2.

Regards,
Jason
