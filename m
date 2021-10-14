Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AEA42CFA3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 02:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJNAuv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 20:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJNAuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 20:50:50 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A47C061746
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 17:48:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w14so2983456pll.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 17:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMEPUd0bnmyPK+GWusr2x7qSdOZyoA5r8EgpsaItTRU=;
        b=18FxLEnLXEcupJumxY4RNarxB91OSKVlArPhspKAMnmMtalRdNQ0yxM+2Yrpdb/3Ti
         DrGSMjoFinXFulkMcqA00lWlF96vItEisUMmbOltiNgqb9ZqjbE75vI8PXIIB8PVm9Xa
         u4q3mulmE3TyEWop1eb3ZM/3UTMk/oKud/uSvytENKpqYVPqES/MWPulpLzPgMXw7Wjp
         wHaYru1CLgcHJJtypnpIMxuWJDa+Oy3rP5JRPbA2saRfjt/5znsyhGYPT+aZ331BGYZz
         kakESKJ+6QCOFYN0h3mlVCUUm+XNlI440yfaukmTZFY2MN5TwCbHkInpB9i3OXssysjp
         dXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMEPUd0bnmyPK+GWusr2x7qSdOZyoA5r8EgpsaItTRU=;
        b=Y9OmPCzm3GOHIlPoC8gH1F0vBf8WO1EVn6SPva7otkeFIIls5jD2xUpxOqrHGBU7b0
         5LAFdmu7g123dz3kHLeoVQWP7gJW2zDR+zXNqTgyxxwfoJiKp2U/n2Lbr/KostCpdMNi
         mtZW7Sv0ZE8wuta+u36FFrNwNck6NBTZAVC40zIR0EBga6mf5JvjYaSgpeAxGHW3Ia6g
         E+lokdPA+8R5QLsjmwlcUUU3+aApWzPcdc5NIm6kQ43l7WOV6v8dXM29uVyQy5KuUdzv
         clbIZAlUbjPzx0YxW7iEPRdZmGCA8SO8b2FzsPsv4e2T7Ohhm9tlzK1obb+11Wa8kPzZ
         65og==
X-Gm-Message-State: AOAM533jLQRYL+7QdorISA4p58cDP/YiP+EMoAZYFjKGYXUEGj/2RF/s
        QL/4gfdr2mJOuePaZzGQR0Ezf9hpqKiXhCoCuxFKFQ==
X-Google-Smtp-Source: ABdhPJx+b2tandDrjEJMpw3BEXffZ+Diw2BvRT0TGS6Et0y5Psg9VDo9oV2fFWF7ObFwj/MDco4HHHmS+aeySwoidQU=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr2897150pjb.220.1634172526202;
 Wed, 13 Oct 2021 17:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211013224523.rxyt2mg75ebxismi@intel.com> <CAPcyv4jHxWJQSgGFg4e5tSg8dgDcYVKrzXEN8gtg7TjNRj3h0g@mail.gmail.com>
 <20211014001236.aohtmzrrvmcq6dpo@intel.com>
In-Reply-To: <20211014001236.aohtmzrrvmcq6dpo@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Oct 2021 17:48:35 -0700
Message-ID: <CAPcyv4iyo54VWoamuJbwZBYrAX2eSy7wKmRKjNDk19fCB2gjHQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] cxl/pci: Split cxl_pci_setup_regs()
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 5:12 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-10-13 15:49:30, Dan Williams wrote:
> > On Wed, Oct 13, 2021 at 3:45 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-10-09 09:44:34, Dan Williams wrote:
> > > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > >
> > > > In preparation for moving parts of register mapping to cxl_core, split
> > > > cxl_pci_setup_regs() into a helper that finds register blocks,
> > > > (cxl_find_regblock()), and a generic wrapper that probes the precise
> > > > register sets within a block (cxl_setup_regs()).
> > > >
> > > > Move the actual mapping (cxl_map_regs()) of the only register-set that
> > > > cxl_pci cares about (memory device registers) up a level from the former
> > > > cxl_pci_setup_regs() into cxl_pci_probe().
> > > >
> > > > With this change the unused component registers are no longer mapped,
> > > > but the helpers are primed to move into the core.
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > [djbw: rebase on the cxl_register_map refactor]
> > > > [djbw: drop cxl_map_regs() for component registers]
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > [snip]
> > >
> > > Did you mean to also drop the component register handling in cxl_probe_regs()
> > > and cxl_map_regs()?
> >
> > No, because that has a soon to be added user, right?
>
> In the current codebase, the port driver gets the offset from cxl_core, not
> through the pci driver. I know you wanted this to be passed from cxl_pci (and
> indeed it was before). Currently however, the functionality is subsumed by
> cxl_find_regblock and is used by cxl_pci (for device registers), cxl_acpi (to
> get the CHBCR) and cxl_core (to get the component register block for switches).
>
> I have no user in cxl_pci for the component registers, and as we discussed, we
> have no good way to share them across modules.

Are you saying that cxl_probe_regs() will not move to the core in your
upcoming series? I was expecting that cxl_find_regblock() and
cxl_probe_regs() go hand in hand.

>
> We can ignore this for now though and discuss it on the list when I post. If
> there is a better way to handle this, I'm open to it.

It's hard to have discussions about API uses without the patches, but
I'm ok to leave further cxl_probe_regs() refactoring to your series.
