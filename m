Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B67F573F0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 23:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFZVxF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 17:53:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41029 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZVxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 17:53:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so294190oia.8;
        Wed, 26 Jun 2019 14:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jh0+2mAWjXJNoSTW5MRBB2B6YwXLkK5uhGK/sZ0vNz0=;
        b=VYKYI7LG9M+IoA76H4gvkGz990KdpGz8P0USFriJ56mo8vhlMB0owIY+FVVDICdLr7
         3iRzy9PdwMb7KqJ3PHwrOJcq9wn7MjaaOIwufaVkmZY0vzbtHMuJetd+hi7Nu9CDLRsH
         foxhJXlhiRa+R+Q8C9BDyVqnj+UvarZ/sBlI2Oe+xfhFgenjKDfnNxD3Fj3qQM5UdvpV
         ETFM3kt7yY1RNbqWpK1/bktTmpF3cU75k4UKzlVnwJhb8VpB6tIfKbu2kZnw9vMpVWXK
         y9t3VhZCeahpUs1ZXuaCGjp7NZcdNK5QURN0/5ThpTaGsVeiHG+deiWuHya8jU1WNgKT
         VW6A==
X-Gm-Message-State: APjAAAWYU89iHA5CDxlT2R3NUPtN2UQb0XUvJNbtoGXbpoqMdcL40sB2
        STW+WzXdKOrUlvkNcl7S+I3gVa2haAP80qrpqTc=
X-Google-Smtp-Source: APXvYqyMH6FBcdjQemrvt91EvobeYBF97A7D7wROknFepaWD+3MoOnQN4+IIFpySjm5YjkeHs4OWeFsy0d2f+J2wJ4c=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr344550oih.103.1561585984728;
 Wed, 26 Jun 2019 14:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <14605632.7Eqku7tdey@kreacher> <20190626125605.GT2640@lahna.fi.intel.com>
In-Reply-To: <20190626125605.GT2640@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jun 2019 23:52:54 +0200
Message-ID: <CAJZ5v0gAejzYYo1TO01K3xTfZDr-1UT6XsVxY=u4LvnHmNcc9w@mail.gmail.com>
Subject: Re: [PATCH] PCI: PM: Avoid skipping bus-level PM on platforms without ACPI
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 2:56 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Wed, Jun 26, 2019 at 12:20:23AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are platforms that do not call pm_set_suspend_via_firmware(),
> > so pm_suspend_via_firmware() returns 'false' on them, but the power
> > states of PCI devices (PCIe ports in particular) are changed as a
> > result of powering down core platform components during system-wide
> > suspend.  Thus the pm_suspend_via_firmware() checks in
> > pci_pm_suspend_noirq() and pci_pm_resume_noirq() introduced by
> > commit 3e26c5feed2a ("PCI: PM: Skip devices in D0 for suspend-to-
> > idle") are not sufficient to determine that devices left in D0
> > during suspend will remain in D0 during resume and so the bus-level
> > power management can be skipped for them.
> >
> > For this reason, introduce a new global suspend flag,
> > PM_SUSPEND_FLAG_NO_PLATFORM, set it for suspend-to-idle only
> > and replace the pm_suspend_via_firmware() checks mentioned above
> > with checks against this flag.
> >
> > Fixes: 3e26c5feed2a ("PCI: PM: Skip devices in D0 for suspend-to-idle")
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I tested this patch on top of your (and mine) previous patches touching
> the ACPI/PCI PM and did not see any issues over several suspend-to-idle
> cycles with and without TBT device connected.
>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
