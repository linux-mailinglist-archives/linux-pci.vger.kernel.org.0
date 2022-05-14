Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA3527342
	for <lists+linux-pci@lfdr.de>; Sat, 14 May 2022 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiENRM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 May 2022 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiENRM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2022 13:12:56 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC63B205CE;
        Sat, 14 May 2022 10:12:55 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7c57ee6feso117799137b3.2;
        Sat, 14 May 2022 10:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARYo/f15fkpOFA40ZR3JDA70StrlLOsPpijtOSDAnu4=;
        b=JgGFlhCBhWy1uxHZr5QyECyS6ISGBWIu4qDAtz8iyllWA1QaiVxCK3MltYbj50h2du
         PoyUpztoF8Oia89Co0EIfbN+wGWqkQYyUjTg4Dtg8OPFTLKfybJV+6M0JLLUypiwY+jB
         31w54WH8Vspss0nR172hgP/2Q+/57VC22SMcsR9HryHjsI6OcQH6N4CH38OBE8zVqEkY
         cX82TuC3H0H247Jx4BbcnuyvHx35SqQHcnNFY9WdAiajFr7L6W1OqxrO0/QYGyqK1A1u
         tYW59ReUxmjQKKHghBWA9qiY02UpZVrkr5numv58Pi1h/83LiredqdCciaBxgVOuefOx
         xkQQ==
X-Gm-Message-State: AOAM530H89O4YSStgEZbEks4c5GSK8VjH5+1HQgVJkT2be6EBYZEkTbI
        ZZblFvNmCcER9J2xzv/9usyhlJGXpYknFyL4AfE=
X-Google-Smtp-Source: ABdhPJxgI42R2wt7RchmcTdowww+/QM/FvFuk1vjbPOi5zZORwRnAbtLw578zenvitEYjUex3PE+sDT5f7rJhZ/YhUQ=
X-Received: by 2002:a0d:ddce:0:b0:2f8:c9f7:8f7c with SMTP id
 g197-20020a0dddce000000b002f8c9f78f7cmr11916578ywe.301.1652548374869; Sat, 14
 May 2022 10:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0g_p+Yb-VLo8b6-SYU17=GQOqZh2E5-52dkq-3rzU=57A@mail.gmail.com>
 <20220512183540.GA859016@bhelgaas> <SJ0PR11MB5070B095B8A28634B43A231F9ECA9@SJ0PR11MB5070.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5070B095B8A28634B43A231F9ECA9@SJ0PR11MB5070.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 14 May 2022 19:12:43 +0200
Message-ID: <CAJZ5v0gPKHDpCuM98UgRFXhxaZxvx1NkzrLArvxhuZ3a-iso=Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
To:     "Jingar, Rajvi" <rajvi.jingar@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Sat, May 14, 2022 at 12:01 AM Jingar, Rajvi <rajvi.jingar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, May 12, 2022 11:36 AM
> > To: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Jingar, Rajvi <rajvi.jingar@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Bjorn Helgaas <bhelgaas@google.com>; David Box
> > <david.e.box@linux.intel.com>; Linux PCI <linux-pci@vger.kernel.org>; Linux
> > Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux PM <linux-
> > pm@vger.kernel.org>
> > Subject: Re: [PATCH v5 2/2] PCI/PM: Fix pci_pm_suspend_noirq() to disable PTM
> >
> > On Thu, May 12, 2022 at 07:52:36PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 12, 2022 at 7:42 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, May 12, 2022 at 03:49:18PM +0200, Rafael J. Wysocki wrote:
> >
> > > > > Something like this should suffice IMV:
> > > > >
> > > > > if (!dev_state_saved || pci_dev->current_state != PCI_D3cold)
> > > > >
> > > > >         pci_disable_ptm(pci_dev);
> > > >
> > > > It makes sense to me that we needn't disable PTM if the device is in
> > > > D3cold.  But the "!dev_state_saved" condition depends on what the
> > > > driver did.  Why is that important?  Why should we not do the
> > > > following?
> > > >
> > > >   if (pci_dev->current_state != PCI_D3cold)
> > > >     pci_disable_ptm(pci_dev);
> > >
> > > We can do this too.  I thought we could skip the power state check if
> > > dev_state_saved was unset, because then we would know that the power
> > > state was not D3cold.  It probably isn't worth the hassle though.
> >
>
> We see issue with certain platforms where only checking if device power
> state in D3Cold is not enough and the !dev_state_saved check is needed
> when disabling PTM. Device like nvme is relying on ASPM, it stays in D0 but
> state is saved. Touching the config space wakes up the device which
> prevents the system from entering into low power state.
>
> Following would fix the issue:
>
>  if (!pci_dev->state_save) {
>                 pci_save_state(pci_dev);
>
>                pci_disable_ptm(pci_dev);
>
>                 if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>                         pci_prepare_to_sleep(pci_dev);
> }

Well, the point is to also disable PTM for devices that were put into
D3 by their drivers.

In addition to D3cold, the check could cover D0 too, that is

if (pci_dev->current_state > D0 && pci_dev->current_state < PCI_D3cold)
         pci_disable_ptm(pci_dev);

> > Ah, thanks.  IMHO it's easier to analyze for correctness if we only
> > check the power state.
> >
> > Bjorn
