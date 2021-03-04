Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7332DCB9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 23:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhCDWMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Mar 2021 17:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhCDWME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 17:12:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11192C061574
        for <linux-pci@vger.kernel.org>; Thu,  4 Mar 2021 14:12:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bm21so33666397ejb.4
        for <linux-pci@vger.kernel.org>; Thu, 04 Mar 2021 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vJrs7m2vVdztlp5PzLwfvwSSimhcL4JW1krYeqArfg=;
        b=UktOGFeJAipd7hoGqxI1g/V2n1K9hMx0Ei2sez8434TJHtaNF55FJzSp3IhjM19Hug
         rFhbepT/wfbD6gNJWavcUueX8iuQAZ5HpwKQzgK7bXDJaKReRf9BFNPAp34Y+TGQDs15
         HkQnZb500kudVU9nAX2DeFCQBiLtnTCoDgdfU/2NKs4ZGSfSEreIQ5Pf/T/QqcK+S+j4
         DYrLqKGFfvlpbcT16lNO6z14NXSjB7A+7jirCj6G1ft94SLy1AlOJTfLMIhx0KjCSvx1
         pC9stVM3Kasa6kn0xyUAcl95GWYdVwumUIW7Z9ormfSIuNoHMecZrmZCJR/BEfLJjYmb
         cx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vJrs7m2vVdztlp5PzLwfvwSSimhcL4JW1krYeqArfg=;
        b=dd88ZFsnkzbLXoVoXyyb7ZCzyF04fFLW+IhsxIDip0SQHLpwiM2uLYDxzsLR7Oqxh4
         mYBNzutCxF2eAr595xr4cFtNVKBkdySQRoBG5anuJtAc8ileUE8fw4JIJ82VHrikc7LQ
         gy3p0m6hoGznswwrDx7rgUMt1m2S/rpYcEAdtnH5gxpuPt0HrmqwPzJdlb7Ou/5wFg6F
         Ilu/ycpoW1GDgVN0/GIIV+K+rGn6kqwwdVIUDIEeWuvZcNqK6B/vVS8d/bDcXO6yi396
         lm8+B72jCMoNeoNj6Mj2AP2cjy+oO0hvZIIuL9bBDe7opeesMQ8VNtIXgFTgW/bPYiJC
         Ynsw==
X-Gm-Message-State: AOAM5337H3k/NIjYYSrWtX0IeiVGStgCtysPBnk0Hge/2fzkepRC+BcE
        tvNfgPACTrrdYheJL+yiOed0Va4k1nLqCdoSvwglbg==
X-Google-Smtp-Source: ABdhPJx3LnwR60lKodD14I/PmtQEyEj8A5DyfUPSILHozIwaOgRZPcJtnF+bPzET4pkRAbICZwA75DTNEeNNOoMXBA8=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr6479883ejz.341.1614895922788;
 Thu, 04 Mar 2021 14:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20210104230300.1277180-1-kbusch@kernel.org> <20210104230300.1277180-4-kbusch@kernel.org>
 <fe1defb66b5438f45093d67e05ef4153d0ae60eb.camel@intel.com>
 <d9ee4151-b28d-a52a-b5be-190a75e0e49b@intel.com> <20210304200109.GB32558@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210304200109.GB32558@redsun51.ssa.fujisawa.hgst.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Mar 2021 14:11:55 -0800
Message-ID: <CAPcyv4gZPc3izOaRBx8sBBM_1YV3F3OMjjZX8Ha0m3PxzJhiCw@mail.gmail.com>
Subject: Re: [PATCHv2 3/5] PCI/ERR: Retain status from error notification
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "hinko.kocevar@ess.eu" <hinko.kocevar@ess.eu>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 4, 2021 at 12:03 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Mar 02, 2021 at 09:46:40PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> >
> > On 3/2/21 9:34 PM, Williams, Dan J wrote:
> > > [ Add Sathya ]
> > >
> > > On Mon, 2021-01-04 at 15:02 -0800, Keith Busch wrote:
> > > > Overwriting the frozen detected status with the result of the link reset
> > > > loses the NEED_RESET result that drivers are depending on for error
> > > > handling to report the .slot_reset() callback. Retain this status so
> > > > that subsequent error handling has the correct flow.
> > > >
> > > > Reported-by: Hinko Kocevar <hinko.kocevar@ess.eu>
> > > > Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > Just want to report that this fix might be a candidate for -stable.
> > Agree.
> >
> > I think it can be merged in both stable and mainline kernels.
> >
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Just FYI, this patch is practically a revert of this one:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=6d2c89441571ea534d6240f7724f518936c44f8d
>
> so please let me know if that is still a problem for you.

For what it's worth I think "6d2c89441571 PCI/ERR: Update error status
after reset_link()" is not justified. The link shouldn't recover if
the attached device is not prepared to handle DPC events. As far as I
can see it's just a cosmetic fix, right? Sathya, was there some end
user visible need to make the DPC recovery report "success" in this
case?
