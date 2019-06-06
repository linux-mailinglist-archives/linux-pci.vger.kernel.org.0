Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C51243769F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfFFO1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 10:27:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38086 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfFFO1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 10:27:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so2127664oth.5;
        Thu, 06 Jun 2019 07:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7GKWCLG/GT2LktE691tccL1tmESYFiwnVBBPoKD3Vvg=;
        b=nHDpEgYJImFjEymA5iiaD18kt11l9aiha0jTcfOUdYXvq5YE5Weoann526lmYfYydY
         enz2uxITrY7bD4onq0TSjBTX207K70H/lumFU6bDe02Twmbo7dRptI+OdYaNuUxrgRm6
         JO5vDgtAOC65uYplSQYP9+6rbH/NMtWSrBcmwZOq3ifV883KAPIjWj3qE8Jf6Ey9JXXk
         GYOJZERCQSfoD8e+47SMP0+6PnsgIFMwZ7/XpgDjRAsG1tz0FsXThZy0utMBbJ7oE+PV
         wuq5Rb8dK14FvBIvrOQ4o6WRJWGSVdSrXeExU+ECDkZ3srKp25i7G1BXCEcxJaEx1kes
         OGSQ==
X-Gm-Message-State: APjAAAVZzJ7f9Q38z2wUlw3rUh73UGXBCFyXOXX3Cq17+FH7RTTyn7Qe
        d0w3u0P/6gMUKHGmB9hRfUTNuCpaQqMQIk+Ocs0=
X-Google-Smtp-Source: APXvYqxheBPppPgzN6lTA9fJVQ1RTMgc+9yV/fTgzHdgpDDSiM4e4guFQq8Qyymr+tRVo2CYmNEzkEanbAjekD/fkao=
X-Received: by 2002:a9d:3285:: with SMTP id u5mr15751944otb.266.1559831252101;
 Thu, 06 Jun 2019 07:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
 <20190605145820.37169-4-mika.westerberg@linux.intel.com> <CAJZ5v0iGu8f6H68082RGDmDCQsmQZNTULLwnb5JzpKA7m1QvVA@mail.gmail.com>
 <20190606112640.GA2781@lahna.fi.intel.com> <20190606134419.GL2781@lahna.fi.intel.com>
 <CAJZ5v0gHTVPNc_LJzPCOLZpHU=wsbYQs__WabOQHmu8GPCChag@mail.gmail.com> <20190606141717.GM2781@lahna.fi.intel.com>
In-Reply-To: <20190606141717.GM2781@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jun 2019 16:27:21 +0200
Message-ID: <CAJZ5v0gwqMd0W43KQoU80=fdYooLkgPg1n0cbbAWjPqrOepYsg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power resources
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 6, 2019 at 4:17 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Jun 06, 2019 at 04:08:11PM +0200, Rafael J. Wysocki wrote:
> > That isn't necessary IMO as long as the device are not accessed.  If
> > the kernel thinks that a given device is in D3cold and doesn't access
> > it, then it really doesn't matter too much what state the device is in
> > physically.  On the first access the device should be reinitialized
> > anyway.
>
> But if the device is configured to wake. For example when it detects a
> hotplug that state is gone when it goes to D0unitialized.

For this we'll need a pm_runtime_resume() of the dependent device on
the resource going "on".

That means we need a list of devices to resume when the resource goes
"on" after being taken "off".
