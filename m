Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CDA4A535C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiAaXiz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiAaXiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 18:38:52 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B58C061714
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 15:38:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c9so13880980plg.11
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 15:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vOCLYMOxUbUApT9HbI5FSaW7HrkYDiGCAlYIBP1qU8=;
        b=y5Gc5mz9i67hNtmNqXv8utVOziwwRl+j5ZyQ5cW/fPpfTUfAUWiDK1v8K35o7f1Vsk
         T91L4zpwTpHpPQOtWr2aeQ2Lsy5aZZaFDuq82GiBOyNEDWH6vPJn4vQRkjQ4eBB3n33J
         tLPzWhrrbaR7acnXPJrRVi7Cxj0TELu/Qj0nsI8jguFQRvpg8M0OFyAAKLlGSGExEWh1
         Q3SJLGDy0SzmOzGU8U9AeemuFYzoe0lcqL5VEb+WZNmtPBefnXbT/gB781pU4lBUSdoo
         cnELrFsISGbUygEtKEWZu5WDKZSIlzDZfZIojiLpEQtDe5kF5C8uEuxsbr/j6z2QWxGe
         iEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vOCLYMOxUbUApT9HbI5FSaW7HrkYDiGCAlYIBP1qU8=;
        b=5aDI8OfzAumSHwo23ryOGHKyuRPRkQMy2PS83G89ojukEJtS2DfWXpRlqbZW7hKG9J
         VtfjoTeQOKVRFqAtqiS232vlYDa3n4vxd2KQCRvwt5P3IivQG32gAppIGeFxcHyZGCCm
         iwH2JwE3N17mCTNh74SjhIn9B/YrpXYy9nrLKuBbejwCK1AFht2D7FlvpSsav9KD44Bj
         SV5ptE+K0wcg+wKKl7wKe6YfU2iTEEuTflp6oq3Bk7vk7qj8Zj0pDse2hJKc1/3MAYhS
         0509kIE7NQWvbbQdXfDYSUCxXAZP+2X3uXUm3/Vnl8OEFgP7wkOHt1GGOcm/HigNxfu+
         UGqQ==
X-Gm-Message-State: AOAM530Tt8uXXadhjcZDGqwo1OwhwaJnVZo5x5PdHT97mkthzqWH1MNe
        bFsv+ElatdI5eSiKUrtDVRfKeGNzYl8L/8M7inzf1UHb5nk=
X-Google-Smtp-Source: ABdhPJwguyNOPmFwDrco2lLS7Rj3fKLBxsK1kYtPGwPykoCdnEFPqdFwq9bgloA8zzisbdGyCWOoppLClYsF+LP7oC8=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr22895008plr.132.1643672331921;
 Mon, 31 Jan 2022 15:38:51 -0800 (PST)
MIME-Version: 1.0
References: <164298420439.3018233.5113217660229718675.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131233422.xo6sugw4bvoyh6ia@intel.com>
In-Reply-To: <20220131233422.xo6sugw4bvoyh6ia@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 15:38:44 -0800
Message-ID: <CAPcyv4hD9jPaTJZE47hx1mg66T44KWCyiaCZGrqG1i-mNAfKqA@mail.gmail.com>
Subject: Re: [PATCH v4 16/40] cxl/core/port: Use dedicated lock for decoder
 target list
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 3:34 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-25 18:54:36, Dan Williams wrote:
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
> > ---
> > Changes in v4:
> > - Fix missing unlock in error exit case (Ben)
>
> Could you help me understand why we need a lock at all for the target list? I
> thought the target list remains static throughout the lifetime of the decoder at
> which point, the only issue would be reading the sysfs entries while the decoder
> is being destroyed. Is that possible?

This is emitting the target list per the current configuration. If
another thread or the kernel is configuring the decoder and while the
target list is being read it should get a coherent snapshot, not the
intermediate settings.
