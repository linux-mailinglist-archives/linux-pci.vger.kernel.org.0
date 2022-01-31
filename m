Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF64A539D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiAaX6m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiAaX6l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 18:58:41 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69903C061714
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 15:58:41 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id f8so13722377pgf.8
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNJ1Af637EUsfEdH6a2ccu9Mo4j5OqbaUb3RufUGSWY=;
        b=60RjLIW2YUmyS930+but4FzcDG3xNa0qtVpNLi5JD7AlMJKow7DsB9zzn+/pIjcTQO
         CrcXwv1h/gqYxTPy6rLDax0nPqnptjD2/8VEEaJxdeNGDD21ci6lbFIp7yWy3bPs3sq8
         lpgN7Evb8dFXnZeqg3qX4ij/v9Nr4I6hE1Q5aP/j6y+iL4qallwPO3DPYWr0lSu5TqFN
         ZY4ZLbByhxdCtD7ehzbNuEQNG7kTNBW/rgJwBmIG13CfMjvb4goeeA1dUsrqxYLQy03D
         dkP56ruJfgfrug5zPiycMEBRSiscxVtHk7ZusK9LjM6HGlWgs+CxaKPLLcEtGhIIB+YG
         xOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNJ1Af637EUsfEdH6a2ccu9Mo4j5OqbaUb3RufUGSWY=;
        b=nhoOMNFu97I53/X1bq6oT9jNjB2he+4ghfSH4o9OF+tILBX0KAP2Az2emNozL93VL2
         CrSwk9jWtMM98nhaFRTjB3y0zivA8MzxJjwtroFg71cIUUjttFpWVvIv3VBLuYPHc/LJ
         ZPdiIHLkOx9S7C3/fN5Qx8Mh1nPcu3utiUDvWdzyG8cKdsHKI6FmLD2H1yiys3/yyiwt
         ii+Ln86DqTgRaZ+DnUPzG3+SydpDcWZ6g6a3cGgaRVG4RbH5RhV3ps5qEjojOKjNxKcy
         iqioyePM/xXCotEe5qFE3wyytaQsUYMnCLRlGRxU9CKn/44ZSjTLiCeXXzf82k00W0GJ
         GJ3Q==
X-Gm-Message-State: AOAM533eRJOeUAS6h8DT2Yuvrf//LrpgT62K0XH0HtsCIbbLGdvIBvuz
        2LfRyHcXY1Gq0hrInUUOee5SnmRjOF7+JHpQz/Vwg+zbDa8=
X-Google-Smtp-Source: ABdhPJzPF/aTsyybswbESWaWt/tZ7xtIpkCJfezDwJdqphzVn7EcqVMENnKkS/ge15TRYOrA8MtUuKuGfy+m9O8smzo=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr18410261pgd.437.1643673520966;
 Mon, 31 Jan 2022 15:58:40 -0800 (PST)
MIME-Version: 1.0
References: <164298420439.3018233.5113217660229718675.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131233422.xo6sugw4bvoyh6ia@intel.com> <CAPcyv4hD9jPaTJZE47hx1mg66T44KWCyiaCZGrqG1i-mNAfKqA@mail.gmail.com>
 <20220131234259.twqkexaq7emp5ml4@intel.com>
In-Reply-To: <20220131234259.twqkexaq7emp5ml4@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 15:58:33 -0800
Message-ID: <CAPcyv4hS7-gS+M63WFp+u7jSGzHSVDcZ2oW3iMFdwKMSjFcLuA@mail.gmail.com>
Subject: Re: [PATCH v4 16/40] cxl/core/port: Use dedicated lock for decoder
 target list
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 3:43 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-31 15:38:44, Dan Williams wrote:
> > On Mon, Jan 31, 2022 at 3:34 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 22-01-25 18:54:36, Dan Williams wrote:
> > > > Lockdep reports:
> > > >
> > > >  ======================================================
> > > >  WARNING: possible circular locking dependency detected
> > > >  5.16.0-rc1+ #142 Tainted: G           OE
> > > >  ------------------------------------------------------
> > > >  cxl/1220 is trying to acquire lock:
> > > >  ffff979b85475460 (kn->active#144){++++}-{0:0}, at: __kernfs_remove+0x1ab/0x1e0
> > > >
> > > >  but task is already holding lock:
> > > >  ffff979b87ab38e8 (&dev->lockdep_mutex#2/4){+.+.}-{3:3}, at: cxl_remove_ep+0x50c/0x5c0 [cxl_core]
> > > >
> > > > ...where cxl_remove_ep() is a helper that wants to delete ports while
> > > > holding a lock on the host device for that port. That sets up a lockdep
> > > > violation whereby target_list_show() can not rely holding the decoder's
> > > > device lock while walking the target_list. Switch to a dedicated seqlock
> > > > for this purpose.
> > > >
> > > > Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > > Changes in v4:
> > > > - Fix missing unlock in error exit case (Ben)
> > >
> > > Could you help me understand why we need a lock at all for the target list? I
> > > thought the target list remains static throughout the lifetime of the decoder at
> > > which point, the only issue would be reading the sysfs entries while the decoder
> > > is being destroyed. Is that possible?
> >
> > This is emitting the target list per the current configuration. If
> > another thread or the kernel is configuring the decoder and while the
> > target list is being read it should get a coherent snapshot, not the
> > intermediate settings.
>
> How can you see the decoder in sysfs before it is finished being configured?

After cxl_decoder_add() the attribute is visible to userspace. At the
beginning of time a disabled decoder will have zeroes in all "Target
Port Identifier" fields. When region creation changes the target list
to valid values it needs to synchronize against userspace that may be
actively walking the target list as it is being updated.
