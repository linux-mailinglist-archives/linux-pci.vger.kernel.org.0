Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2CD4FDFC7
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 14:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346724AbiDLMaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352820AbiDLM1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 08:27:46 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C1091350;
        Tue, 12 Apr 2022 04:34:51 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id t67so15741195ybi.2;
        Tue, 12 Apr 2022 04:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1U5xFnCbAJqJlqW5lfTRRnL2eQXPaE2FVgJo9bdhcA=;
        b=ExrDDzN2M0V+2e70wKBDpp4ADkXYieviKaQtsRS6GyG4bqnBkxEMOxHppkwZ02E3mM
         DLbti58FIIRSSp0Dcd82ipRNLpSXJ7Vyxx67zDyiDyG/nFCDQ4pkrzKXaQOyfD3e4ItB
         rShqMZqDE2FY3yF3NaZLSuLHs6TMkNqZEfHflNGjRx1zmTy7lYY+9LiHdLrC/iOMaNFr
         beZjk1UlDHxHs0CFSB0QxvJ9jS5aQCNe2YyDbjwKx5eJ/QLvFdubiEAv8ktncJQ132Ei
         TK+F3qhoLUM1PAwkTTsj1/lAoH/WrWXq0nw7XomRjZTS0ij7JQcZ+hTryZ5kHs9IGzbm
         SMUw==
X-Gm-Message-State: AOAM531PAtwZ8dq+YmboMfV+tYhDONw9S6bbmozjAMxaDauaB4nlxO0W
        bA7u/nDTn8VYrGAyaQLIMSMZwKyVxwom34BHlag=
X-Google-Smtp-Source: ABdhPJzf+3ccXvLG34P7mp8/CQDA1raZe3l1qBOxnaibK6Y8se3ym4rOWOmExQ9+0/cdsmy7jvYZXaKcISy7A1mD6hY=
X-Received: by 2002:a25:e082:0:b0:641:cf5:b91f with SMTP id
 x124-20020a25e082000000b006410cf5b91fmr13366995ybg.482.1649763290879; Tue, 12
 Apr 2022 04:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher> <YlVPhCLcFVbFPN36@lahna>
In-Reply-To: <YlVPhCLcFVbFPN36@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Apr 2022 13:34:39 +0200
Message-ID: <CAJZ5v0idfZ+Zpn7quGtny9-swLMa0VwATmAgtp=JRSqyONqwYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PCI/PM: Improvements related to device transitions
 into D0
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
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

Hi Mika,

On Tue, Apr 12, 2022 at 1:24 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Apr 11, 2022 at 04:17:41PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > On Saturday, April 9, 2022 3:03:14 PM CEST Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > > This series supersedes the one at
> > >
> > > https://lore.kernel.org/linux-pm/4198163.ejJDZkT8p0@kreacher
> > >
> > > It addresses some potential issues related to PCI device transitions from
> > > low-power states into D0 and makes the related code more straightforward
> > > and so easier to follow.
> > >
> > > Please refer to the patch changelogs for details.
> >
> > Here's a v2 of this patch series which is being sent, because I realized that
> > one of the checks in pci_power_up() added by patch [4/7] in v1 was redundant
> > and can be dropped, but that affected the last 3 patches in the series and
> > then I noticed that more improvements were possible and hence the new patches
> > [2/9].
>
> I sent a few minor nits separately. The series looks good to me in
> general and certainly improves readability :)
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!

I'll address the issues that you have pointed out and send a v3 of
this series later this week.
