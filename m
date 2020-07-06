Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5401216169
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 00:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGFWTC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 18:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGFWTC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 18:19:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD371C061755
        for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2020 15:19:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so11776825lji.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2020 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+g8b8UDutwpjfN6lizjtfC7IoMCTSDjsjPJug8YnTgg=;
        b=KUh+nyqnQkj9RcybDE5PeCJrAdjLCL6MfvAIePJyXHNRX0F8FKTnKIeG1/vPX6JbR0
         ZkH2vounWJTv0AHW++nq9HTK5t0tj2w7jkJDno0f/aPPilRdMq6kUjJLsLllyc6nZzA9
         gFUpa3s60zoHwqlYS1ibCaFMDpBcrs4toKYyR9eGRtgpjbgUrfwu2ZQtV4h54mS9Dk8Q
         lg38TgKrJ4Lvli78idB1ExZ9K7zVg+JISjzyd/fRrzPpJ9bQnYZblkHcGZJkJsuDKxMs
         /oeUvTOZc6v1rGutbgXAGNSFIyPxvgBklnWYlKvi0d+6iWbY9jFw/OyGoH076u85nh1D
         9QPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+g8b8UDutwpjfN6lizjtfC7IoMCTSDjsjPJug8YnTgg=;
        b=mEZQWYlBFU57PlLHNOBMNSXlFZaNL0ki3ItX4+YXZqysmY9QSdREGvp/MGBe8dJxub
         OIiYuVcUWhegyfJdFUmJSV1JzmFZMg54P679ikKdqb7k6MgTP8JfaTFRP8p4NvxosUoO
         RnFg7JbxzV2XPxEdJ4GHaWKuZKuWTULIjxCqQM54mcXENYv643W2K5Ju+V05w3B9QvTz
         KjX29OC6ZvzcQJK/gMXC6Uq+jigzrt8H0JB30WpiO1naDAI57kyqaE51QrL1DFZGL4nJ
         D29KqLMeGAO1v0yWnQQV6h+MXtZ2QTYtWeZ9Cg5sJCvJMtZs5bCpPVI31j7iqakHCOQ0
         t0Bw==
X-Gm-Message-State: AOAM532yoExYFpqqdd1qdbVqTWG1A3YGJMt7N/gWzV7mENk9Gz4KTJg9
        eKk9xC1cgeq1ce0o3EKVy30jYBwKekMUx3diJYLiUw==
X-Google-Smtp-Source: ABdhPJyJihOFDUusDuGurRmf+ynZe/E6+YCOUFBYwFoV/94U5zmmw6gWFYJpZfrD7hx040m64pq6G+pFjE5iBr5QmJw=
X-Received: by 2002:a2e:b5a8:: with SMTP id f8mr27313685ljn.247.1594073940036;
 Mon, 06 Jul 2020 15:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com> <20200704114452.GA15530@amd>
In-Reply-To: <20200704114452.GA15530@amd>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 6 Jul 2020 15:18:23 -0700
Message-ID: <CACK8Z6HP00o=rextd0-X-u2aH72PNU3t6zEczC2GGO_QfGhUcA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Tighten PCI security, expose dev location in sysfs
To:     Pavel Machek <pavel@denx.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 4, 2020 at 4:44 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > * The first 3 patches tighten the PCI security using ACS, and take care
> >   of a border case.
> > * The 4th patch takes care of PCI bug.
> > * 5th and 6th patches expose a device's location into the sysfs to allow
> >   admin to make decision based on that.
>
> I see no patch for Documentation -- new sysfs interfaces should be
> documented for 5/6.

Yes, sorry. The patches 5/6 have run into discussion and it looks are
not acceptable at the moment.

Thanks,

Rajat

>
>                                                                         Pavel
>
> >  drivers/base/core.c         | 35 +++++++++++++++++++++++++++++++
> >  drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++---------
> >  drivers/pci/ats.c           |  2 +-
> >  drivers/pci/bus.c           | 13 ++++++------
> >  drivers/pci/of.c            |  2 +-
> >  drivers/pci/p2pdma.c        |  2 +-
> >  drivers/pci/pci-acpi.c      | 13 ++++++------
> >  drivers/pci/pci-driver.c    |  1 +
> >  drivers/pci/pci.c           | 34 ++++++++++++++++++++++++++----
> >  drivers/pci/pci.h           |  3 ++-
> >  drivers/pci/probe.c         | 20 +++++++++++-------
> >  drivers/pci/quirks.c        | 19 +++++++++++++----
> >  include/linux/device.h      | 42 +++++++++++++++++++++++++++++++++++++
> >  include/linux/device/bus.h  |  8 +++++++
> >  include/linux/pci.h         | 13 ++++++------
> >  15 files changed, 191 insertions(+), 47 deletions(-)
> >
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
