Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0265410D54
	for <lists+linux-pci@lfdr.de>; Sun, 19 Sep 2021 22:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhISUd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Sep 2021 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhISUd2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Sep 2021 16:33:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDEDC061574;
        Sun, 19 Sep 2021 13:32:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t6so52589898edi.9;
        Sun, 19 Sep 2021 13:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcJVgPjSz0j9w6YEbM+uE5ixcnUtoWZ/F6Bciss8GDM=;
        b=Iyl2X6uPJSEsXf4CFU/f4V9+XRYRCZP5Px+BxAd8ujPoH2kyY+y6FThp8IgN2D0MTq
         QCu8xVSVnNldb9n6CuJu0rfpIFVxk+iqHsk22rsoFvSKE1sHPQHuzDvqdbzPsBdye8U2
         XBBsaJUH4fwb5GGyrQGFdTWzg2IcJbbQwbX00fX8prDZwqMQIqFHZlGeL4+gPUAWELby
         tXiDRKJiCsdBNcGqh6n4EENQHSMHjU11XMqPoKQDS7FbHpKc/M7GuCEX2DE7O/cMODGn
         ND8a56uoS5Q5+B2a/+6pLPRe/CKI8nKiCs6pG0G1DfaCjaq8sGBq+vRCq7tu5RfncjZ2
         9pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcJVgPjSz0j9w6YEbM+uE5ixcnUtoWZ/F6Bciss8GDM=;
        b=pPWKn3jq7XcvmyrZ84PoDb5a35RRvd2D4Kd/g+nyBA1rWNBgtT2CxZv2/dl8/DETJc
         o5+Lub9JyDHfc2+akygMFo0NBSFTx04WfzTQ1HbFxSRIWMbT0zzV6JqEXd2KlUm+m0wy
         7v0nIjIt8SLqW7jpSnBU+8CPjL+a2FBgC0az48gOO9ky6HlraH5SWTyAqlEKXG6/bKfS
         eRj8j3zlH110X7UyQ94lBfxCMLD34Q1v5Xun0eXaIgfJVvnuLEnUmXcQdgopqyf1vfqM
         cLNlc0YrjYILlrT2pvaP4JVOawtwGprkHxCQppfBXxD6aeGt1AT/BbWOq6Ot1+TyNR9i
         uS7g==
X-Gm-Message-State: AOAM533od88uR8kPdskksZ2yX4jpL6qOiHpMuYqHGJV/QGxigbCDLyCB
        C3CXZvs4AdlkPOxFYKftmaSLK76D+N/ymihq4NsrRrdnlcs=
X-Google-Smtp-Source: ABdhPJwHjrJ6nHgi95mDr5Jobn5IPasjSCAtcR1RmSSFw1/RDHK+gp25CKfc6dd6QNDOtzCP0tW63mZmugbt9iV3xQk=
X-Received: by 2002:a50:e188:: with SMTP id k8mr4539919edl.119.1632083520837;
 Sun, 19 Sep 2021 13:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <8003272.NyiUUSuA9g@kreacher> <1798761.CQOukoFCf9@kreacher>
In-Reply-To: <1798761.CQOukoFCf9@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Sep 2021 23:31:23 +0300
Message-ID: <CAHp75VdoFwH2sQT6dwz4BCorkgJgmYEBHq-+YpT18HZx2cpmrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PCI: PM: x86: Drop Intel MID PCI PM support
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 19, 2021 at 9:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Support for Intel MID platforms has mostly gone away with the SFI
> support removal in commit 4590d98f5a4f ("sfi: Remove framework for
> deprecated firmware"), but there are some pieces of it still in the
> tree.  One of them is the MID PCI PM support code which gets in the
> way of subsequent PCI PM simplifications and trying to update it is
> rather pointless, so get rid of it completely along with the arch
> code pieces that are only used by it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> I am going to post patches removing the rest of MID support from arch/x86/
> and elsewhere, but that is still quite a bit of stuff and I don't want this
> simple PCI PM series to depend on that work.

This is still being used by MID with ACPI assisted (*) support.
Hence, not ack.

*) ACPI layer is provided by U-Boot and can't fulfill all possible
features that ACPI may use in the Linux kernel.

-- 
With Best Regards,
Andy Shevchenko
