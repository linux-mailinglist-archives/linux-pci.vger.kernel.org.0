Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B04A5383
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiAaXsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiAaXsD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 18:48:03 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333DEC061714
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 15:48:03 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 192so14271960pfz.3
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 15:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0G8dZ1GCfzkhtqrBWLb6gnXyNz+D2k3FfyQfwdQOgp4=;
        b=f9VQv4a9PF+CFo2tM/WJL+9udZCOAzvfmNxb0YrA4Gicc/3lEJPJl6kg70TrZMaNv3
         Qm5A1Y4ZQdv4eCN4L9xGZsITa1tCgklwcNYcpqK1kohmEca25Yet1Vp56zl7QRM9or2j
         EMyJDU0sqT3XA9Ogudm4Rgl3FtLQawm+0kDeKk6dfqCOo4XocRmZDyUG9p/t06IqMaIv
         Yz8PN6tVjBexX0uf1C2ZheSsVtvHfDpM/rXhXtW202jS6SRcc5Co+omVczqUv45Atuhe
         xZUChYkIcte4rbRflxQdKOodzUp4Fi1oLlwPkk08w5AXvE4JaplAZy8GHxVeqWm9mpvA
         Wxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0G8dZ1GCfzkhtqrBWLb6gnXyNz+D2k3FfyQfwdQOgp4=;
        b=AvkZaAcpGGO/81GgPDSx5l4pZxGskAK1TTmi8JXn+RqvXmrLzT2UnjSWZHGYF3JSDU
         17Q6eEKwpwcc1S0ns47vxRawVwdjFcvlKfUcUPx0C/r5UEAANxIptySooPYtgCTEjeTV
         2ndxw7rcydM6SURueWGPQvWEOqe6StsyFtPkQCyBJPZE+PRTpl32sUHQKiZhIDJmkEwf
         VSHVzerDVH11iVXfSjqsDD1xWYezGB7ivsAk63/sfZMhMUECDlA2Tu9U5aNRNxVAMb3D
         KpcriOfdj6Nl5oKPmfhP/r9AqxzYoiQ6cmTOGLMErHHaD4/YCgw0nnvOO34lXrp2ayMh
         oC+g==
X-Gm-Message-State: AOAM531NXnpnhl2ww/KHQKaGnH5KgrwMU6DXcBTXtJDLUUbcnqrnTCya
        qKGPAfg9dLu1PmpqC4qDmQSrjWejaw7xantgxBTIUg==
X-Google-Smtp-Source: ABdhPJz6CI65gEVw4auMYRXEcpuHeNp6TxLY/yGPgMuREV6pGOVc3SKMESmPeQeaCOvBpYYNpQVhpLN0meyqn7ZeGKg=
X-Received: by 2002:a62:784b:: with SMTP id t72mr22731014pfc.86.1643672882725;
 Mon, 31 Jan 2022 15:48:02 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298412919.3018233.12491722885382120190.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131222101.tckwbcxheuuorkiq@intel.com> <CAPcyv4gGMsUbJ=Cu8U0B2Znz6+jE6PcDCALNfxJzvAHZZccVvQ@mail.gmail.com>
 <20220131232507.jz4tsjk4uzcunnre@intel.com>
In-Reply-To: <20220131232507.jz4tsjk4uzcunnre@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 15:47:55 -0800
Message-ID: <CAPcyv4hFgbGV3k82_A=FOTjc_xrx_ruWjvV9BryuNOkkAEc0iQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/40] cxl/pci: Implement Interface Ready Timeout
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 3:25 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-31 15:11:05, Dan Williams wrote:
> > On Mon, Jan 31, 2022 at 2:21 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 22-01-23 16:28:49, Dan Williams wrote:
> > > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > >
> > > > The original driver implementation used the doorbell timeout for the
> > > > Mailbox Interface Ready bit to piggy back off of, since the latter does
> > > > not have a defined timeout. This functionality, introduced in commit
> > > > 8adaf747c9f0 ("cxl/mem: Find device capabilities"), needs improvement as
> > > > the recent "Add Mailbox Ready Time" ECN timeout indicates that the
> > > > mailbox ready time can be significantly longer that 2 seconds.
> > > >
> > > > While the specification limits the maximum timeout to 256s, the cxl_pci
> > > > driver gives up on the mailbox after 60s. This value corresponds with
> > > > important timeout values already present in the kernel. A module
> > > > parameter is provided as an emergency override and represents the
> > > > default Linux policy for all devices.
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > [djbw: add modparam, drop check_device_status()]
> > > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/cxl/pci.c |   35 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > >
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index 8dc91fd3396a..ed8de9eac970 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -1,7 +1,9 @@
> > > >  // SPDX-License-Identifier: GPL-2.0-only
> > > >  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > > >  #include <linux/io-64-nonatomic-lo-hi.h>
> > > > +#include <linux/moduleparam.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/delay.h>
> > > >  #include <linux/sizes.h>
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/list.h>
> > > > @@ -35,6 +37,20 @@
> > > >  /* CXL 2.0 - 8.2.8.4 */
> > > >  #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
> > > >
> > > > +/*
> > > > + * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> > > > + * dictate how long to wait for the mailbox to become ready. The new
> > > > + * field allows the device to tell software the amount of time to wait
> > > > + * before mailbox ready. This field per the spec theoretically allows
> > > > + * for up to 255 seconds. 255 seconds is unreasonably long, its longer
> > > > + * than the maximum SATA port link recovery wait. Default to 60 seconds
> > > > + * until someone builds a CXL device that needs more time in practice.
> > > > + */
> > > > +static unsigned short mbox_ready_timeout = 60;
> > > > +module_param(mbox_ready_timeout, ushort, 0600);
> > >
> > > Any reason not to make it 0644?
> > >
> >
> > Are there any tooling scenarios where this information is usable by non-root?
>
> Just for ease of debug. If I get a bug report with this, first thing I'm going
> to do is ask for the timeout value. Perhaps it's expected the person who filed
> the bug will have root access.

They would have already needed to be root to change it from the
default in the first instance, or the kernel command line from the
dmesg would show it being overridden. That said, there's nothing
security sensitive about emitting it, so 0644 it is.
