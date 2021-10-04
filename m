Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71EA4218EB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 23:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhJDVGS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 17:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbhJDVGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 17:06:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FF0C06174E
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 14:04:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s16so15616006pfk.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTL71zCsO4wuS7DXxshZZRFAlW1Q/e6e78gucQODCPs=;
        b=XmzdavWE+xPwKjOfD7fVZBYLqzsaZ82tzU8rY7LUQTZzp2u58uvRub2eqnWLAelR42
         wLD6XtFTKQ+DXn86Rk1NjlffjspX7Z4xONQzcrRTl6WpCYAKGNigChzH1USP/+YHqV9S
         vZc+p0UEL2hD82BqL0dO/uxnq3Mnqc8ctr4Gz/pURtRB4rk3jKWFsKsMSYSX2m2E8Azg
         RvMWFiiLTiyyKXeTVFLm1BvWmS9VifSoG/e7OsLK26L+G/3Hp+Ihcr8dknzhk96b2FzO
         e6oEQdoZCpclC6RmTbpgM9m3MeKwU3UAkXLsknw16zQ5X13Esxb3XHzrZsCcKkqqTG+H
         anFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTL71zCsO4wuS7DXxshZZRFAlW1Q/e6e78gucQODCPs=;
        b=H6Cqh/9YOYpQZXjINTBmORTeG8THYDBZZ5JcbO0sX9rt1I0vK1pWutl9j8sHnxvXSi
         Ccd6r31bYTi4L3nsA+Nwy64enF90PLtEVfF3VPszgMWwen292DZX6UyF6d8EI1Ti21D7
         6mC8krA07Umj960YZbiYA0ERuHnN+iG+yt+0rFfFfB9K7SKKVZf98+ZhkdJ0jCpZgnkY
         xkx8rYT59mUXTqsOXEDOIfyNPLQSq3hDP1RFaFgIVYQWlOoLQPGpWW25QlCNGrR6yEfK
         iwUw1CNmo9K7iGtBANxIXR7g2lfx4uZJMMMYc6X+2DBLGOuDrONClT8aCXdjus2AdWfF
         zz4A==
X-Gm-Message-State: AOAM532DDh7kt9FpckuZicQnL2wzN72Bk7H9An2Qd5S82D/g8UpuA4Sc
        ERU9+caXPnB+Wcy6Xmeoai/UpAY81htuvHhvcDMkFw==
X-Google-Smtp-Source: ABdhPJwtA7a1u8MewgFOuQ4ODk6qNf/e8OOxKzSS55rulMOQukdTduuScadVjnccrxY46jGbRZAxi2Ttqu24INezDC8=
X-Received: by 2002:a05:6a00:1a01:b0:44c:1ec3:364f with SMTP id
 g1-20020a056a001a0100b0044c1ec3364fmr19009668pfv.86.1633381468208; Mon, 04
 Oct 2021 14:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org> <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com> <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com> <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com> <20211002070218-mutt-send-email-mst@kernel.org>
 <YVg/F10PCFNOtCnL@kroah.com> <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
In-Reply-To: <95ba71c5-87b8-7716-fbe4-bdc9b04b6812@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Oct 2021 14:04:20 -0700
Message-ID: <CAPcyv4jfdVTMtvhoUJ5B-ka596RgEH_0RLathfKL9aAi9+0apg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 2, 2021 at 7:20 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 10/2/2021 4:14 AM, Greg Kroah-Hartman wrote:
> > On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
> >> On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> >>>>    Do you have a list of specific drivers and kernel options that you
> >>>> feel you now "trust"?
> >>> For TDX it's currently only virtio net/block/console
> >>>
> >>> But we expect this list to grow slightly over time, but not at a high rate
> >>> (so hopefully <10)
> >> Well there are already >10 virtio drivers and I think it's reasonable
> >> that all of these will be used with encrypted guests. The list will
> >> grow.
> > What is keeping "all" drivers from being on this list?
>
> It would be too much work to harden them all, and it would be pointless
> because all these drivers are never legitimately needed in a virtualized
> environment which only virtualize a very small number of devices.
>
> >   How exactly are
> > you determining what should, and should not, be allowed?
>
> Everything that has had reasonable effort at hardening can be added. But
> if someone proposes to add a driver that should trigger additional
> scrutiny in code review. We should also request them to do some fuzzing.
>
> It's a bit similar to someone trying to add a new syscall interface.
> That also triggers much additional scrutiny for good reasons and people
> start fuzzing it.
>
>
> >    How can
> > drivers move on, or off, of it over time?
>
> Adding something is submitting a patch to the allow list.
>
> I'm not sure the "off" case would happen, unless the driver is
> completely removed, or maybe it has some unfixable security problem. But
> that is all rather unlikely.
>
>
> >
> > And why not just put all of that into userspace and have it pick and
> > choose?  That should be the end-goal here, you don't want to encode
> > policy like this in the kernel, right?
>
> How would user space know what drivers have been hardened? This is
> really something that the kernel needs to determine. I don't think we
> can outsource it to anyone else.

How it is outsourcing by moving that same allow list over the kernel /
user boundary. It can be maintained by the same engineers and get
deployed by something like:

dracut --authorize-device-list=confidential-computing-default $kernel-version

With that distributions can deploy kernel-specific authorizations and
admins can deploy site-specific authorizations. Then the kernel
implementation is minimized to authorize just enough drivers by
default to let userspace take over the policy.

> Also BTW of course user space can still override it, but really the
> defaults should be a kernel policy.

The default is secure, trust nothing but bootstrap devices.

> There's also the additional problem that one of the goals of
> confidential guest is to just move existing guest virtual images into
> them without much changes. So it's better for such a case if as much as
> possible of the policy is in the kernel. But that's more a secondary
> consideration, the first point is really the important part.

The same image can be used on host and guest in this "do it in
userspace" proposal.
