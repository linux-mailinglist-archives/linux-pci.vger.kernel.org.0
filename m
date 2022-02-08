Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AA24AE03A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 19:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiBHSAL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 13:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiBHSAL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 13:00:11 -0500
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C02C061576;
        Tue,  8 Feb 2022 10:00:10 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id bt13so28200818ybb.2;
        Tue, 08 Feb 2022 10:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ii2RoA70hyPFpWjpQOIgYWVQ0Wgfgxw0SgqMO+aO1f0=;
        b=uuG3OZAleDzvPcCeNVi/PAaL5gysBLxLhgWxySnchelsXxph5tki0dERPRQlIFTb5v
         aXacVFuNFqqwaCw6Tw7R6jO2rdkEbyAlCXqbUYmSnsJ7uFz7lzpLceZ0lBtlMvnGfPC4
         VNUz1MY5LPWBdU74soncENJ82yEe7fpRGfluysj90zg7p+nP4qHIBI7vpdBczYa1OOs6
         DBK3Tg4H7gI0yFciM78krrnH6Nqx/wuXFZ4AAqXGPIFYYlvnbGhO81+XtWrWRzhf+CuS
         EcqhENZM+u4H90yQ3C0X0nCs7rYezpReoYxHeAJBCIJ7Z5fzAHMwysOVU+RYsJ+jGqvt
         aAXw==
X-Gm-Message-State: AOAM533uuDZ6pUDHaD9JOEIEPxUkyHAhiUFqWA0z3Uhugb9zJWXSYEnz
        EWsoTyY+i7n/pn3hLKv6RlHG7N1l3fsuATKqljw=
X-Google-Smtp-Source: ABdhPJxCnkDYQnltfASHHSHrKRxUmAdvsZvnR3ypuO8fhN3qkWtd7TI0tmHnLmkOZf2qb+oEnqgjgxSy6dkjHXlS3/I=
X-Received: by 2002:a05:6902:1545:: with SMTP id r5mr6035694ybu.475.1644343209557;
 Tue, 08 Feb 2022 10:00:09 -0800 (PST)
MIME-Version: 1.0
References: <b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de> <31603144-edec-df2d-fb46-283692c67420@leemhuis.info>
In-Reply-To: <31603144-edec-df2d-fb46-283692c67420@leemhuis.info>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Feb 2022 18:59:58 +0100
Message-ID: <CAJZ5v0hyp1nR5id02abZh4cjw=sT0J_nf9spbUHfuwzjdJb5KA@mail.gmail.com>
Subject: Re: 100 ms boot time increase regression in acpi_init()/acpi_scan_bus()
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 8, 2022 at 1:03 PM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker speaking.
>
> Top-posting for once, to make this easy accessible to everyone.
>
> @Rafael or any other @acpi/@pm developer: what's the status here?
> Neither in this thread nor in the bug ticket anything happened afaics.
> Or is a 100ms boot time increase considered "not a regression"?

It is on my list of things to look into, because it used to work
faster, so depending on what change made it work slower, it may be
possible to restore the previous performance without sacrificing too
much.

I honestly don't think that it is a noticeable issue for users in the
field, though.
