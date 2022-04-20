Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9B3508D53
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379855AbiDTQbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380586AbiDTQbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 12:31:50 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBD42A30;
        Wed, 20 Apr 2022 09:29:04 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ebf4b91212so23965037b3.8;
        Wed, 20 Apr 2022 09:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3Rwr1wKI0dV8uR+EC2GDva6IlEZo2CoFLIp6LGb97I=;
        b=sUYWJjzRy69A5yeZzYV9RdIpBwaeJYdNnX1jQyODO5JoZQ82xFQInqqeGjyPPo8/ML
         ZBYIlV4qtjdJ9pvqJxeaY5ws/gq+KHA4Db2arAoDEMMzrq1AQbL5vmIbFnsUG6ukeq0f
         AyHp6Il+7MZxneEMa+hIQ7IvIrLW7kO1yRWIDbX6n41lJseei4WZChSMkkGW1yo0hTyK
         3L+WzTC6W80HIrabIYHp75BB5/BVhh0x5zofDOuvNBuswpWz/GADp9VMeDtaLu6BWVgE
         2jn1ZtTL3gutKmeDAmmkgTuPUQMb23lLd/q+huGiUzcaPKZlYcCx6cNoX4X0x5rrGxqa
         pbHQ==
X-Gm-Message-State: AOAM533h3evCJXZep4q2xGL9FKJhg4GCoqoctpn3XINGSYH/GzwQ/AC3
        NHWqSIoexnX3tJGLI7MwRCiYsinascjq+gOmk1Y=
X-Google-Smtp-Source: ABdhPJwdoGEzdO7VSww9jXGLA2Y+/2mWcpCxkyRzV6TVO7t30wQQ5QQcOp/EyX8yf1SUkpF3HcndzTo8xp/ObvTdLmA=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr21040616ywb.326.1650472143738; Wed, 20
 Apr 2022 09:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <5838942.lOV4Wx5bFT@kreacher> <20220420162514.GA1301392@bhelgaas>
In-Reply-To: <20220420162514.GA1301392@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Apr 2022 18:28:52 +0200
Message-ID: <CAJZ5v0i9Qaad_17OsO0dqxZS4_UkRnAApRs1bG=Jey9voAXH9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] PCI/PM: Improvements related to device transitions
 into D0
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 6:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Apr 14, 2022 at 03:00:23PM +0200, Rafael J. Wysocki wrote:
> > On Monday, April 11, 2022 4:17:41 PM CEST Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > > On Saturday, April 9, 2022 3:03:14 PM CEST Rafael J. Wysocki wrote:
> > > > Hi All,
> > > >
> > > > This series supersedes the one at
> > > >
> > > > https://lore.kernel.org/linux-pm/4198163.ejJDZkT8p0@kreacher
> > > >
> > > > It addresses some potential issues related to PCI device transitions from
> > > > low-power states into D0 and makes the related code more straightforward
> > > > and so easier to follow.
> > > >
> > > > Please refer to the patch changelogs for details.
> > >
> > > Here's a v2 of this patch series which is being sent, because I realized that
> > > one of the checks in pci_power_up() added by patch [4/7] in v1 was redundant
> > > and can be dropped, but that affected the last 3 patches in the series and
> > > then I noticed that more improvements were possible and hence the new patches
> > > [2/9].
> >
> > Here's a v3 of this series with some minor review comments addressed and R-by
> > tags from Mika added.
>
> Applied to pci/pm for v5.19, thanks, Rafael!

Thank you!
