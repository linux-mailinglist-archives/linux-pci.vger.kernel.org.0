Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE33C873B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhGNPWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 11:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhGNPWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 11:22:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD0CC06175F
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 08:19:47 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id f12-20020a056830204cb029048bcf4c6bd9so2822458otp.8
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nA/s4q3xWQ1MrD5GGKsmBhEEWIQqKBBxr9yke92X18k=;
        b=mASXKz3d4VxWdnOhtRGY9xdrq/pnCp4byEIzOE6gDPLvnRfO+Yqrkf1jTieiwkodkW
         lFdpPmwssfHbKute20ufcT2hcU02WypCA1mZDs+33eSDPrKZlsQYs4fEQWY9YTV3uj5m
         oXPDRyB6DxUGa4iH1DK+CseeVPprdDb49bAbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nA/s4q3xWQ1MrD5GGKsmBhEEWIQqKBBxr9yke92X18k=;
        b=FNpcyDZLcIAqqH/RbbrWIxLD0vZMS89CNbftktKlmF4Jo1zHnTS7ou7CoMXD0vYDw8
         NL4eKMPKTT95oSMoauICJGg+GWiqmcejniC+0/+vk64D8jQEVb+rZfBewvbhtw4jtUKd
         VLfvA1p2Q0HS4C5+IT6yRmlcNy4fH7GvBWYqvvAha7t4z7r43XNoQCEhaOTSmbq5wMMm
         eIwSqv94TcFP6nSrBUDsuFXYkGjyP7uxI2URt00c8xU+uUjJ7BmUZbVjPL8M93JEOUA3
         WzgWqHztMvLP7PxrA+lcZ9CuFaRQ4wrGK3wds1HX0l0TefogMY2590ylraqvLPb4OLH+
         cyFg==
X-Gm-Message-State: AOAM5324r5h26HiNsK6/uLjKPnzORsG3uj8rfaw1UHdtnS9ZjCD3bxju
        WO+lwnZwPbvqe3tmAgd3ajHnMzVFi+TFzA==
X-Google-Smtp-Source: ABdhPJzbBCJMoO5CfkJV90lh7WawD0mkB4PL9T9Ir06PTqG6TmkAoRRIc+YKPhugXLuBZQnGSmsc6A==
X-Received: by 2002:a05:6830:447:: with SMTP id d7mr952497otc.253.1626275987205;
        Wed, 14 Jul 2021 08:19:47 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id a44sm469723ooj.12.2021.07.14.08.19.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 08:19:46 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so2810355otq.11
        for <linux-pci@vger.kernel.org>; Wed, 14 Jul 2021 08:19:46 -0700 (PDT)
X-Received: by 2002:a25:8082:: with SMTP id n2mr13261292ybk.79.1626275675582;
 Wed, 14 Jul 2021 08:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org> <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org> <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
 <e3555c49-2978-355f-93bb-dbfa7d09cab8@arm.com>
In-Reply-To: <e3555c49-2978-355f-93bb-dbfa7d09cab8@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Jul 2021 08:14:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XaTqNDn=vLEXfJ2dV+EH2UoxPfzWeiS+_sZ9hrQ274bw@mail.gmail.com>
Message-ID: <CAD=FV=XaTqNDn=vLEXfJ2dV+EH2UoxPfzWeiS+_sZ9hrQ274bw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Rob Clark <robdclark@chromium.org>, quic_c_gdjako@quicinc.com,
        Saravana Kannan <saravanak@google.com>,
        Rajat Jain <rajatja@google.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Jul 13, 2021 at 11:07 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-07-08 15:36, Doug Anderson wrote:
> [...]
> >> Or document for the users that want performance how to
> >> change the setting, so that they can decide.
> >
> > Pushing this to the users can make sense for a Linux distribution but
> > probably less sense for an embedded platform. So I'm happy to make
> > some way for a user to override this (like via kernel command line),
> > but I also strongly believe there should be a default that users don't
> > have to futz with that we think is correct.
>
> FYI I did make progress on the "punt it to userspace" approach. I'm not
> posting it even as an RFC yet because I still need to set up a machine
> to try actually testing any of it (it's almost certainly broken
> somewhere), but in the end it comes out looking surprisingly not too bad
> overall. If you're curious to take a look in the meantime I put it here:
>
> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/fq

Being able to change this at runtime through sysfs sounds great and it
fills all the needs I'm aware of, thanks! In Chrome OS we can just use
this with some udev rules and get everything we need. I'm happy to
give this a spin when you're ready for extra testing.

-Doug
