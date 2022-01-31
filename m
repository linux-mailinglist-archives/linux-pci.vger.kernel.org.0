Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20424A533E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiAaXba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAaXba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 18:31:30 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B543C061714
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 15:31:30 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s16so13579738pgs.13
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6tEMYobP7+G4jgA5hVF3vhoENh1fbXIUfhfOrDsbEg=;
        b=1aEb90z5eqGyOxcarrvJThvqXMyh8ALG56+4thL0dF+8CIPbqWAnk7IVMQlCU1M3Qp
         pjsoLfrZo+4J0VYeoWqbb9GEqp+VdZmvSFvQ5oDfE+ijMUGeg5uIeiJBcDZsv8rcIo9n
         N8eqUDUOIhZIle12u9t7K9eC2xRerq9LX/tA4bD4Iu3xp0woty3u4eil+xbo2zLj4nBa
         SuhiGNsan/KgHqKqiTJMP+enjOopH3wqG81fQv3eIzccQJl1/Yz637I0qFrrVmpC6qYc
         MN41vR5ymojqwhYMI0N7vvV99LcIMJRbACq2HhaMggktsTZpIqNFP+k2RcQsZhkB5Nst
         013A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6tEMYobP7+G4jgA5hVF3vhoENh1fbXIUfhfOrDsbEg=;
        b=bKGAZXFLMta2UcbJbdPLrcdNKZ5q+HeXZGWqpYnr/He6PePXrvtWKq/Msnl4LVLgNf
         tti5wQBfWqXTzh5RHfZ1wkTQHCyvJkC1Gs32NE4kJ3j2+Ldi2hJRJLVNijFpnKRzd6XK
         EJ2UNU0ahUE+NJkn7XKktsImY94wkMQDHotJHuF9T7lZxA9Yk7mU86KbSItqltm7Qcoa
         +lwL0R1lHnJWZghE3iqGFRBX4uS7hyAzyOFHwMaIuCHbGjLiJ8IlP3IjQv5jVQBmMu4B
         PZ3eD/ZYbHN89T6CsYQybwq26/eXZDgCKF7jWrefVFnvQlf+WV/46snCnqZbwoE/j6Q3
         hE3w==
X-Gm-Message-State: AOAM532/By38FcFBPv8sD4YOGn/wkSwPmlLwZ+XqiyK7pZGgWIw0SSA5
        JTTK2h2d+XtEsuZcRxKXj7/R6Vxxuv4B/6+m70ysmmx+/aw=
X-Google-Smtp-Source: ABdhPJx0H6KJhvBY/aAzniN8BZM2cYXpwW59Ub1gGMlKc9Vx4sLVb4Q4obNYuwyLveRbjpENPuLJYBiDEj+cdEsL3ho=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr18348635pgd.437.1643671890007;
 Mon, 31 Jan 2022 15:31:30 -0800 (PST)
MIME-Version: 1.0
References: <164298420439.3018233.5113217660229718675.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131155934.000064ac@Huawei.com>
In-Reply-To: <20220131155934.000064ac@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 15:31:22 -0800
Message-ID: <CAPcyv4irL1aT_xEWFaM=0YZz8U99qK6TeyAQxWyKriom4uzCBQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/40] cxl/core/port: Use dedicated lock for decoder
 target list
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 7:59 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 25 Jan 2022 18:54:36 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Lockdep reports:
> >
> >  ======================================================
> >  WARNING: possible circular locking dependency detected
> >  5.16.0-rc1+ #142 Tainted: G           OE
> >  ------------------------------------------------------
> >  cxl/1220 is trying to acquire lock:
> >  ffff979b85475460 (kn->active#144){++++}-{0:0}, at: __kernfs_remove+0x1ab/0x1e0
> >
> >  but task is already holding lock:
> >  ffff979b87ab38e8 (&dev->lockdep_mutex#2/4){+.+.}-{3:3}, at: cxl_remove_ep+0x50c/0x5c0 [cxl_core]
> >
> > ...where cxl_remove_ep() is a helper that wants to delete ports while
> > holding a lock on the host device for that port. That sets up a lockdep
> > violation whereby target_list_show() can not rely holding the decoder's
> > device lock while walking the target_list. Switch to a dedicated seqlock
> > for this purpose.
> >
> > Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Suggested additional tidy up inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> > Changes in v4:
> > - Fix missing unlock in error exit case (Ben)
> >
> >  drivers/cxl/core/port.c |   30 ++++++++++++++++++++++++------
> >  drivers/cxl/cxl.h       |    2 ++
> >  2 files changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index f58b2d502ac8..5188d47180f1 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -104,14 +104,11 @@ static ssize_t target_type_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(target_type);
> >
> > -static ssize_t target_list_show(struct device *dev,
> > -                            struct device_attribute *attr, char *buf)
> > +static ssize_t emit_target_list(struct cxl_decoder *cxld, char *buf)
> >  {
> > -     struct cxl_decoder *cxld = to_cxl_decoder(dev);
> >       ssize_t offset = 0;
> >       int i, rc = 0;
> >
> > -     cxl_device_lock(dev);
> >       for (i = 0; i < cxld->interleave_ways; i++) {
> >               struct cxl_dport *dport = cxld->target[i];
> >               struct cxl_dport *next = NULL;
> > @@ -127,10 +124,28 @@ static ssize_t target_list_show(struct device *dev,
> >                       break;
> >               offset += rc;
> >       }
> > -     cxl_device_unlock(dev);
> >
> >       if (rc < 0)
> >               return rc;
>
> Now you don't have a lock to unlock above, the only path that can
> hit this if (rc < 0) is an if (rc < 0) in the for loop.
> Perhaps just return directly there.

Yeah, looks good.
