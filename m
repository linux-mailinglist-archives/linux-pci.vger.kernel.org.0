Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845CA3DE397
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 02:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhHCAfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 20:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhHCAfX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Aug 2021 20:35:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ABFC0613D5
        for <linux-pci@vger.kernel.org>; Mon,  2 Aug 2021 17:35:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ca5so27458231pjb.5
        for <linux-pci@vger.kernel.org>; Mon, 02 Aug 2021 17:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xi7k8IuxcGb5LOBYAbguxfQfTtnnwxeja/w2hdMqvk=;
        b=BPBmBK6Oa9Fz1/ejFbBvP9PntE5M4Y/6SY4aMOApSL2NBqNeYpiuuKQDXikcP2is+8
         KwthFSUh59S+lqmZMHGQL/iqOYk5FHP9SnNinoO4RO1xwhcM5rgxlMILuWQmOKxcAIPn
         zJeKBCiGKcqtCYJZisFLf8biie1/ZYgMr5jveWfaC7x1qCTFlIIrCJZk1gP3QbL2B3La
         Ki8/oXSrAOROvW1S45zSi238dvzbRFlHJnddY1BZDizVXmVMNUBr92JGVnZXe7iI0YEZ
         CtoFFJcaY3q9gKDkWDB+mb3Sj0a3DGfi6gqy+vFZujkPJ+AkR329+XyiHF4N0jYmEkuh
         IbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xi7k8IuxcGb5LOBYAbguxfQfTtnnwxeja/w2hdMqvk=;
        b=ZTL+rVetkgeysDDwWgu+wodDXZaWwjX5Km0dV4Bbop93s5pXCMqOnJMCA4RmdLe/xj
         a9wS9GpHlAi9ttBCQ9rwOPIpjyk5ZvzbiUtt9WkFqmYZDlEgz0Ld0WZC4KWzisj2OsbD
         WcJKIfFOV6wDQ+PXdgjIzwO+xzGtiWLawIZABf2O/y+sFZvlW4VdDmV+biht3AHepP6p
         SeNhD2y++h8S44IPO1Oesab3nJaofP7ejhWgvTu0YEzyZFu6C9MUgdWCQB+8ffoW/mNf
         9EL9CIkHNz0ntcj45K5lJ0V0Zh8XEiEJ3rsLGFWyr1d0oPHxzqGIUT7gldvsswFwfzIi
         o23Q==
X-Gm-Message-State: AOAM530nhkZPeoXHTr+akKNjq8Hmh/cOokVZITyn0XkRyOn3dJvqo74+
        BZAwEBy09aq1J6InueeENmAziHtk69Mir9bh0OBelw==
X-Google-Smtp-Source: ABdhPJyD/SoLzWfUHi1/eto0p7V/jbYQ+j7Zgt/Ff2rWqOX90CU7XVmBN71cEqRz0BEe3ypUcORU14MWzQ39UTDFVTA=
X-Received: by 2002:a17:90b:1a92:: with SMTP id ng18mr20057710pjb.86.1627950912360;
 Mon, 02 Aug 2021 17:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org> <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
 <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
 <YOaymBHc4g2cIfRn@8bytes.org> <CAD=FV=U_mKPaGfWyN1SVi9S2hPBpG=rE_p89+Jvjr95d0TvgsA@mail.gmail.com>
 <e3555c49-2978-355f-93bb-dbfa7d09cab8@arm.com> <CAD=FV=XaTqNDn=vLEXfJ2dV+EH2UoxPfzWeiS+_sZ9hrQ274bw@mail.gmail.com>
 <CACK8Z6FV+QYR01=aP4AT8rNUQMkX-WwesHzf5XY8465KuUZ=_Q@mail.gmail.com>
In-Reply-To: <CACK8Z6FV+QYR01=aP4AT8rNUQMkX-WwesHzf5XY8465KuUZ=_Q@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 2 Aug 2021 17:34:36 -0700
Message-ID: <CACK8Z6Hzy+t05kY0VGwEnzcHZXgg9BAuS+DmRf3==J+G62qXgQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To:     Doug Anderson <dianders@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Rob Clark <robdclark@chromium.org>, quic_c_gdjako@quicinc.com,
        Saravana Kannan <saravanak@google.com>,
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

Hi Rob,

On Mon, Aug 2, 2021 at 5:09 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hi Robin, Doug,
>
> On Wed, Jul 14, 2021 at 8:14 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jul 13, 2021 at 11:07 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2021-07-08 15:36, Doug Anderson wrote:
> > > [...]
> > > >> Or document for the users that want performance how to
> > > >> change the setting, so that they can decide.
> > > >
> > > > Pushing this to the users can make sense for a Linux distribution but
> > > > probably less sense for an embedded platform. So I'm happy to make
> > > > some way for a user to override this (like via kernel command line),
> > > > but I also strongly believe there should be a default that users don't
> > > > have to futz with that we think is correct.
> > >
> > > FYI I did make progress on the "punt it to userspace" approach. I'm not
> > > posting it even as an RFC yet because I still need to set up a machine
> > > to try actually testing any of it (it's almost certainly broken
> > > somewhere), but in the end it comes out looking surprisingly not too bad
> > > overall. If you're curious to take a look in the meantime I put it here:
> > >
> > > https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/fq

BTW, is there another mirror to this? I (and another colleague) are
getting the following error when trying to clone it:

rajatja@rajat2:~/rob_iommu$ git clone
https://git.gitlab.arm.com/linux-arm/linux-rm.git
Cloning into 'linux-rm'...
remote: Enumerating objects: 125712, done.
remote: Counting objects: 100% (125712/125712), done.
remote: Compressing objects: 100% (41203/41203), done.
error: RPC failed; curl 18 transfer closed with outstanding read data remaining
error: 804 bytes of body are still expected
fetch-pack: unexpected disconnect while reading sideband packet fatal:
early EOF
fatal: fetch-pack: invalid index-pack output rajatja@rajat2:~/rob_iommu$

We've tried both git and https methods.

>
> I was wondering if you got any closer to testing / sending it out? I
> looked at the patches and am trying to understand, would they also
> make it possible to convert at runtime, an existing "non-strict"
> domain (for a particular device) into a "strict" domain leaving the
> other devices/domains as-is? Please let me know when you think your
> patches are good to be tested, and I'd also be interested in trying
> them out.
>
> >
> > Being able to change this at runtime through sysfs sounds great and it
> > fills all the needs I'm aware of, thanks! In Chrome OS we can just use
> > this with some udev rules and get everything we need.
>
> I still have another (inverse) use case where this does not work:
> We have an Intel chromebook with the default domain type being
> non-strict. There is an LTE modem (an internal PCI device which cannot
> be marked external), which we'd like to be treated as a "Strict" DMA
> domain.
>
> Do I understand it right that using Rob's patches, I could potentially
> switch the domain to "strict" *after* booting (since we don't use
> initramfs), but by that time, the driver might have already attached
> to the modem device (using "non-strict" domain), and thus the damage
> may have already been done? So perhaps we still need a device property
> that the firmware could use to indicate "strictness" for certain
> devices at boot?
>
> Thanks,
> Rajat
