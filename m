Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19FF4F1CDA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 23:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380172AbiDDV3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379962AbiDDS1F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 14:27:05 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB53113F48;
        Mon,  4 Apr 2022 11:25:08 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id y38so19170728ybi.8;
        Mon, 04 Apr 2022 11:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCV4HtxKKrFtYUzA08GGtmyQuDrR4SCJ17M7Fnxmr34=;
        b=r3yPEzKhRac9iqyCIM8yg2iRAQmLrVVpU76b6aeqk2sl9JP/JaTv5gMhqiqBATKUlL
         1lx6TJhRXKRFKuNcseFsIMdWIRFLbqII+4nMqSA4xoCp6cFdUvv/65BSe6OjD0QluhkU
         lvpU1R+1PVlbM1LgOArpnn1Le4PvBNMZ0wOUly/1XVRdw+z5qVXoO6t+8SD4mZhmkXZK
         lZiduZENQyxvhyio30T71th5sDUhzn62NOZ3lAiGeE+cnIKZ2yOQy2yWymZnxRXQ4W3P
         P2Q8cfLHqYaM/WAByB9VAYrjJf+xw5vqzPbexcCoZ0xlnGIEeEzPddcklxd2MO66DfXW
         JWDg==
X-Gm-Message-State: AOAM532ywzZkKlVZ+XOcu6IcZJTAN8Xm+eBQFLBrFPURvxW450m/f8ft
        oyxIuZWYdfh5BpoEotgDhFnLpxjLjy/qjbGClyw=
X-Google-Smtp-Source: ABdhPJyZrHKGdImhZK9li020wFi6mVFXiU0hAl7RxyBC2L67Wz55stGtbnyQdQUfeGvM+JTuLG3HrRleXe/zWArnIiw=
X-Received: by 2002:a05:6902:1544:b0:63d:d3a7:8cc4 with SMTP id
 r4-20020a056902154400b0063dd3a78cc4mr1059291ybu.622.1649096708257; Mon, 04
 Apr 2022 11:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0hGVN_=3iU8OLpHY3Ak35T5+JcBM-qs8SbojKrpd0VXsA@mail.gmail.com> <CAPcyv4hCseKbr_XXyeOACYmm0defeSet0LX3YWLKGRnCMS=MFQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hCseKbr_XXyeOACYmm0defeSet0LX3YWLKGRnCMS=MFQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Apr 2022 20:24:57 +0200
Message-ID: <CAJZ5v0gT=aAR=aW0-kkDWv2TotmL_EW4JVPqoh9oKwxtOyZr-A@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Disable suspend
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 4, 2022 at 8:16 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Apr 4, 2022 at 9:00 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sun, Apr 3, 2022 at 2:58 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > The CXL specification claims S3 support at a hardware level, but at a
> > > system software level there are some missing pieces. Section 9.4 rightly
> > > claims that "CXL mem adapters may need aux power to retain memory
> > > context across S3", but there is no enumeration mechanism for the OS to
> > > determine if a given adapter has that support. Moreover the save state
> > > and resume image for the system may inadvertantly end up in a CXL device
> > > that needs to be restored before the save state is recoverable. I.e. a
> > > circular dependency that is not resolvable without a third party
> > > save-area.
> > >
> > > Arrange for the cxl_mem driver to fail S3 attempts. This still nominaly
> > > allows for suspend, but requires unbinding all CXL memory devices before
> > > the suspend to ensure the typical DRAM flow is taken. The cxl_mem unbind
> > > flow is intended to also tear down all CXL memory regions associated
> > > with a given cxl_memdev.
> > >
> > > It is reasonable to assume that any device participating in a System RAM
> > > range published in the EFI memory map is covered by aux power and
> > > save-area outside the device itself. So this restriction can be
> > > minimized in the future once pre-existing region enumeration support
> > > arrives, and perhaps a spec update to clarify if the EFI memory is
> > > sufficent for determining the range of devices managed by
> > > platform-firmware for S3 support.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > A few thoughts:
> >
> > 1. I don't think it is necessary to fail suspend-to-idle too (which
> > the driver will do after the patch AFAICS).
>
> Ah true, I missed that this would also disable suspend to idle.
>
> > 2. Should hibernation fail too?  From the description above it looks
> > like that should be the case.
>
> Yes, any CXL address range that was provisioned by the OS would need
> some off-device save area for the device-state which seems difficult
> to support in the general case.

So it should cause errors to be returned from the hibernation path
too, ideally before the freezing of tasks.

> > 3. If "deep"suspend is going to fail every time, it may be better to
> > prevent "deep" from being written to /sys/power/mem_sleep instead of
> > failing suspend in progress, especially after freezing user space.
>
> Yeah, that sounds much better, let me explore that option.
