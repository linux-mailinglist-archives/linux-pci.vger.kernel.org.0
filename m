Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC52C528B7F
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiEPRBj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbiEPRBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 13:01:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399071FA64
        for <linux-pci@vger.kernel.org>; Mon, 16 May 2022 10:01:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so3512131pju.1
        for <linux-pci@vger.kernel.org>; Mon, 16 May 2022 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kIsSnaw8orIslw424fHicKF35fPEwzrqGDoMb7keQtA=;
        b=1iCaLn8jhpaxZfLnHCR1cqCMRHr/Klck6jGzgFQ7ljDFVZLzmWHoZfNYXPmS9j/g6U
         ohYjH+DZo+bhDnNrdQgluvJ91PWqYm2kRJQ/g6Fr9x1igJ+x0Rf32c0UYwkQBApSfLht
         wPyqNGTxaHyEWv6bqUI62wmJ8f6lYlw2R1an3bljVpsgZu6HO8HDDTtAOGwANcr/M6mp
         TkBb5IyJt6KA9eyxIWNJ1xL4GWuSlfwRszxhFz2Bv3DkEbLBuEuxYtAVv239Shf/N9Ly
         Ja247Lw4G1t9jCFLtd5WjNg7Yil3s5eToGwpc3S2MVgwHmJJfazyBl7EaJCLr8Ar2d7j
         Eymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIsSnaw8orIslw424fHicKF35fPEwzrqGDoMb7keQtA=;
        b=3CBqsfDeaDPLCOmFWmBcitIdJIDYZ5OMB+KSzxRgF1rs2kAlOv2VC/cJjtFrj7Kx9x
         BbqkaLGbTVK9ZC8DYdBM+6Z2+iKdHPmOJ1HOS02H1aiYwOZK3bEsdZiTO0ky6f3HUPl5
         XS/0iqMv8Nk2Yx9+eapbWjxfxyQ4krNQ6b2NifElgwAcSZEvTbemlr20RuFGtFsBdzfo
         lN2mStHhKgGRBY6N9BMHEEBzAeO6hexccd9oEHsY/kHzUDtHEdwHQUyLTIwCaCDAKuH4
         9mxiBpYCKSGAHm7C0o9/5Ss5KpQgvbFzL3Wz5r9rVnKBSb9OoSql3Grht6qBlrxUYpcp
         32cg==
X-Gm-Message-State: AOAM530Zt2lMEvtHh5DoqF/DDaxkFcAtInc2r50atFwAMzFRzO1m90Jh
        d9HkbnpYXGq0sxdIu8sVb4PRtQsjPqGAsSMZH6k+/X07AV9ZBQ==
X-Google-Smtp-Source: ABdhPJxuaYM6L0XNs+yZqORMULtGWSrGNHDEzJk9QbNoMp20hWlrn9GFyIA4km+CEyh01Gk5SD4oBDkNJX+yffOb+es=
X-Received: by 2002:a17:90b:388f:b0:1dc:6e0f:372b with SMTP id
 mu15-20020a17090b388f00b001dc6e0f372bmr20031688pjb.93.1652720495744; Mon, 16
 May 2022 10:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <20220511191943.GB26623@wunner.de>
 <CAPcyv4hUKjt7QrA__wQ0KowfaxyQuMjHB5V-=rZBm=UbV4OvSg@mail.gmail.com> <20220514135521.GB14833@wunner.de>
In-Reply-To: <20220514135521.GB14833@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 May 2022 10:01:26 -0700
Message-ID: <CAPcyv4izKEGKw0L=QkTxp8MMfuWxzF9Rz4Bb_F0rRRiy_+2m8w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

On Sat, May 14, 2022 at 6:55 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, May 11, 2022 at 12:43:34PM -0700, Dan Williams wrote:
> > On Wed, May 11, 2022 at 12:20 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > But the reset argument still stands:  That same section says that all
> > > IDE streams transition to Insecure and all keys are invalidated upon
> > > reset.
> >
> > Right, this isn't the only problem with reset vs ongoing CXL operations...
> >
> > https://lore.kernel.org/linux-cxl/164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> The above-linked cover letter refers to AER.
>
> I believe with AER, the kernel is notified of an error via an interrupt
> and asynchronously attempts recovery through a reset.
> Obviously, an eternity may pass until the kernel gets around to do that
> and whether accesses performed between the initial error and the reset
> succeed is sort of undefined.  So it's kind of a "best effort" error
> recovery.
>
> With the advent of DPC, the situation has improved considerably as the
> hardware (not the kernel) automatically disables the link upon occurrence
> of the initial error.

DPC, as far is I can see, is broken for CXL, any link going down
causes the entire active interleaved memory range to be lost. Hence
the "hopeful" designation in that patch set, if the link is going down
to DPC the chance that the kernel runs long enough to even report the
error is at risk.

> Any subsequent accesses will fail and the kernel
> does not perform a reset itself (the hardware already did that) but merely
> attempts to bring the link back up.  That has made error recovery pretty
> solid and NVMe drives now seamlessly recover from errors without the need
> to unbind/rebind the driver.  Data centers heavily depend on that feature.

Works great for NVME.

>
> Perhaps if CXL.mem used DPC, it would be able to recover more reliably?

So far all I can see are attempts to fail a bit more gracefully, but I
would not consider this a reliable architecture for recovery:

https://www.computeexpresslink.org/_files/ugd/0c1418_f63f7f1a9f474ba2b00f5e77429867cb.pdf

> Circling back to the SPDM/IDE topic, while NVMe is now capable of
> reliably recovering from errors, it does expect the kernel to handle
> recovery within a few seconds.  I'm not sure we can continue to
> guarantee that if the kernel depends on user space to perform
> re-authentication with SPDM after reset.  That's another headache
> that we could avoid with in-kernel SPDM authentication.

What is missing from this conversation is what constitutes a device
leaving the trusted compute boundary and is the existing attestation
invalidated by a reset. I.e. perhaps the kernel can just do a
keep-alive heartbeat after the reset with the already negotiated key
to confirm the session is still valid.
