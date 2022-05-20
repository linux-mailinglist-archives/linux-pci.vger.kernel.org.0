Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7266952EF52
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350891AbiETPiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350894AbiETPh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 11:37:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16A9D05F
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 08:37:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so7672477plg.5
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqeiI/7vhG2ub3w04cBZvW6Ap5WsemzUG12oj+4DA/I=;
        b=WuNx7l2NISSZOxlCsi+09Nj6LDX8yDQD7hPRIEkNijKtu+uWjWY+AH68YEIug4L+LR
         XZc3PtQ57OQKFPsri/zYLlNlaQ6ZtwxXpGLHVUJ9vyisA2v+76uOUqhJq8JY/HNMwmJz
         PBP74atLr9VW8BrpXW8slqVQ8dEsrcywyMCJEvCWrAICtNzsoUKl1XgfrSY93Y/bKeOG
         MOLZt+PAdg9WUkT5k4vimEJAA15wJXVGumL/h/QguLwidUtQXFSV/5trM7e7NOrLa1Hj
         JNLpmH2IIf5wM62lCCUtuI4CovypAtb6/Zu/THR3sA027PqcVBqjj3fcdca6X/YIri2u
         oU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqeiI/7vhG2ub3w04cBZvW6Ap5WsemzUG12oj+4DA/I=;
        b=j2RPVepL/Qwym81OQ49YAvXvRk0toGGWUiVXTwuZOjBN/RgpsNY/idkC7FY9Du8nD0
         n9o1egRAyx/jvNjRZe1POspdYsE29dMFPxGYU9w1vni6lLZUM2qSPAJLNyJhpbzkxgWv
         mFEfEUZ18y5QqsZhU6E4QI/w9Hmkjv49L2BU7iHblGQgWPflCt2c9s2xF2Oyqv6cacMN
         gHNR2P41P4zgiyQe0f9yAPEE01iyz28jvLG0XW5ZYbGVyosodPjhEm99mRCbJ4i2wguh
         0RCL3ZK9oPct29ZhFjo9BNU+s5GU3yrPe9Fn1YuBvVlz6Cr6M2z8wZYLhWy/59lREHIc
         JkFQ==
X-Gm-Message-State: AOAM5335b+AobEufjkAIxJd7GEIDcwuED6oo6++fUsRY+b4SQvWQADDG
        nz7rO/h84FWjhQIRNUazm1jYJoIMPXuLt/Ac6BrMAA==
X-Google-Smtp-Source: ABdhPJweIVN4dvihbIGlOHjdQ/wzSfnFu055d5x1QnAq0lXCBWN+eyOhuY5EJM7Oigu+ugSitr35F6jot8sZIXVJ45o=
X-Received: by 2002:a17:902:ea57:b0:15a:6173:87dd with SMTP id
 r23-20020a170902ea5700b0015a617387ddmr10417526plg.147.1653061076530; Fri, 20
 May 2022 08:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com>
 <20220514135521.GB14833@wunner.de> <YoT4C77Yem37NUUR@infradead.org> <20220520054214.GB22631@wunner.de>
In-Reply-To: <20220520054214.GB22631@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 May 2022 08:37:50 -0700
Message-ID: <CAPcyv4iWGb7baQSsjjLJFuT1E11X8cHYdZoGXsNd+B9GHtsxLw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 19, 2022 at 10:42 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, May 18, 2022 at 06:43:39AM -0700, Christoph Hellwig wrote:
> > On Sat, May 14, 2022 at 03:55:21PM +0200, Lukas Wunner wrote:
> > > Circling back to the SPDM/IDE topic, while NVMe is now capable of
> > > reliably recovering from errors, it does expect the kernel to handle
> > > recovery within a few seconds.  I'm not sure we can continue to
> > > guarantee that if the kernel depends on user space to perform
> > > re-authentication with SPDM after reset.  That's another headache
> > > that we could avoid with in-kernel SPDM authentication.
> >
> > I wonder if we need kernel bundled and tightly controlled userspace
> > code for these kinds of things (also for NVMe/NFS TLS).  That is,
> > bundle a userspace ELF file or files with a module which is unpacked
> > to or accessible by a ramfs-style file systems.  Then allow executing
> > it without any interaction with the normal userspace, and non-pagable
> > memory.  That way we can reuse existing userspace code, have really
> > nice address space isolation but avoid all the deadlock potential
> > of normal userspace code.  And I don't think it would be too hard to
> > implement either.
>
> Just as a reminder, on resume from system sleep, IDE needs to be
> set up by pci_pm_resume_noirq() to comply with the existing assumption
> that a PCI driver's ->resume_noirq callback may access the device.
>
> At that point (device) interrupts are disabled, so it's not possible
> to e.g. read certificates from disk or perform an OCSP request.
> So the bundled userspace code would have to conform to a number of
> severe restrictions to avoid resume issues.

Recall that OS managed IDE is somewhat of a stop-gap / special case as
typically the OS kernel is outside of the platform trust boundary for
things like TDX. I imagine suspend in the presence of IDE would be
platform firmware managed, not OS managed. Certificate validation can
always move internal to the kernel later if a concrete need arises,
but it is difficult to go the other way, to kick out certificate
validation from the kernel if it proves not to be needed. Otherwise, a
ring3/ userspace helper that can live in non-pageable memory to avoid
scenarios like this sounds like a capability that would be worth
having regardless.
