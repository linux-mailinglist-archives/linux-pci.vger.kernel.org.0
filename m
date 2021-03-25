Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4484E3498C6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 18:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhCYRzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCYRzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 13:55:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB2C06175F
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 10:55:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j3so3380089edp.11
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SszvQ531+uD2WOPYhtL5YAjrwhpYcvb3yQNRuA0Ywb4=;
        b=wCDP/7yBK/xsqLRNiA6sjvp/w29nQg8GjGHwVNWvweNm2OhAfv0a0QwBLsD3iKvzEr
         dthbWbt/HigLvZh1banr11COMFI78WekR8WecCF4ej7H6qTNGvyd0gTknsC97wwVaRnK
         L2KfXQu83W5Qcy+rGuNS9Qn2n4zUbk4+B/z7/ZfFSo9tF/0BYB+YYsOpDbUC70VS3lb/
         V11GPWgpdpit39VgtQtDpOsufIexJkJDdN/bjMZxB7b+UUYyz93Or5zYV3WDVi9MQ1cx
         6jXrVtQEm6ffX2El4VBBW/orm6YEUaLl8Z/H8q1GskouILXcDmNddFvuDDrgqmoiQGTT
         /cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SszvQ531+uD2WOPYhtL5YAjrwhpYcvb3yQNRuA0Ywb4=;
        b=gtSqyD2WGOuYD36kD57tAiTIndeMfcdx1xUOJUIDc1M0K8Oo7GAXROnczQsMvWOyNl
         ovqp8uJ58pnN6Pj185b21vT9+OcB0wknxkNx0y2YnaHgUcV/vzFhm3zjrpojVMzU8EQR
         t2XdSx3BEvqMpHWfKSiNGOfPBUvNKrPJQmqhVOFJWCDr4LldAxRsyiAg2vnr8xQ3d0v5
         JMLM0qm9XaGpfL2BVxpu4bN4jR2lpLHC98QXQiNmBGjFL+IBEdagboR/GlVOKkn2dGyA
         nj4bCeHG3g0Ke+qfQ2HAEeGz9mJku+MBN12Wm+xWfioWWdIeu+qv+u1TG827act1yO+E
         HoFA==
X-Gm-Message-State: AOAM533XIg1/QT4HAFOhiamny/ngqPVFTEpUcxQy4WpEglTqXKq4FeTk
        jf3prkchW8DAApwcMtRyeqj7qddtwUpB3Sppm+p6xQ==
X-Google-Smtp-Source: ABdhPJynBnTvFsp7tfzUUv7Xah9IQACdloEpM+nVs5kOVFQwq+UENbVfzQevNPp4DLGAoArONj+G19xwFunzI02W6nI=
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr10724876edw.354.1616694912172;
 Thu, 25 Mar 2021 10:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YFwzw3VK0okr+taA@kroah.com> <20210325082904.GA2988566@infradead.org>
In-Reply-To: <20210325082904.GA2988566@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 25 Mar 2021 10:55:01 -0700
Message-ID: <CAPcyv4jfq7pqvdKinYJ2wSLSNEa0fmOgCGWjTCpwhgTTpGyY=Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config regions
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 1:29 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Mar 25, 2021 at 07:54:59AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > > configuration cycles. It assumes one initiator at a time is
> > > reading/writing the data registers.
> >
> > That sounds like a horrible protocol for a multi-processor system.
> > Where is it described and who can we go complain to for creating such a
> > mess?
>
> Indeed.  Dan, is there a way to stilk kill this protocol off before it
> leaks into the wild?

Unfortunately I think that opportunity was more than a year ago, and
there's been a proliferation of derivative protocols building on it
since.
