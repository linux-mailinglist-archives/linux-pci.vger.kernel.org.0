Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7E1AFBA4
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDSPOL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 11:14:11 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:41020 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgDSPOK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 11:14:10 -0400
Received: by mail-oo1-f68.google.com with SMTP id t3so1534346oou.8;
        Sun, 19 Apr 2020 08:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o4eGY9TLJHufi4vAG1QGgq29m2UtPv1KIcyHNOs1Kx0=;
        b=AqmMr1xZsfqYN4Jyo4AWjNoG78nqaLH6lOGGnLDHaWkeNtO9OG2++mXX+cE6SyPme+
         hinGRcf08VaJlCmdjj371EONrtwX+ZbVMB+rUOqplSEdjypgtJL3a5VyGrWZGDNr7c0v
         uers7m8j1T/3+CQN9pAbEGqeK2dtTet3/y6v/goajwlgBir7cOBpuTgN2z7mcX9+5/rx
         rvwBd3BCCgfd8kdgzjzbKJhfpdz02rBnTFGuBUuBvxuF02lCsE9HLKPCKzFecHBgfIlY
         cOoGTqS8zcZMYurnppGIRzHEItnHGJ/TJkdnpGf+UcZc9X3ODe/453+rIeOeqWTN8IRi
         So8w==
X-Gm-Message-State: AGi0PuZ0k/bRv9DIBSXKwx/v/G2NsjTv/0J7GrPS34B62o0lzo8cWNe/
        kwQnabFSBY6qG8qk1DWZfX4OmJMxqX5mNalTCRY=
X-Google-Smtp-Source: APiQypLtUEOee3fsi1dMjAxiswAhSnzkTuk8dq4mD9gM6SE25cC+IXvIALybg7nOSGvvGzTUJGOYfLISZPWyfOFmufQ=
X-Received: by 2002:a4a:4c46:: with SMTP id a67mr9508805oob.1.1587309249893;
 Sun, 19 Apr 2020 08:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <5673945.BT02kTCndr@kreacher> <Pine.LNX.4.44L0.2004191040400.29527-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.2004191040400.29527-100000@netrider.rowland.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 19 Apr 2020 17:13:58 +0200
Message-ID: <CAJZ5v0hdO5d9bwA00oW1=WLtXzsMeAJHzm_xv6uMM1Q-c3GkMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 19, 2020 at 4:43 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, 18 Apr 2020, Rafael J. Wysocki wrote:
>
> > Hi,
> >
> > This is an update including some fixes and extra patches based on the
> > continuation of the discussion [1].
>
> The new code in pm.h and main.c all looks good.  Please add my
> Acked-by: or Suggested-by: to the portions of the patches that affect
> those files.

I will, thank you!

> It's nice to see that, aside from the documentation, the patches ended
> up removing more lines than they added.

Indeed.

Cheers!
