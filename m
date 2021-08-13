Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8083EBDD2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 23:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhHMV2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 17:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhHMV2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 17:28:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6B1C0617AD
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 14:27:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l11so13705372plk.6
        for <linux-pci@vger.kernel.org>; Fri, 13 Aug 2021 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIuqP4Yz2mMXyBFDc+vWEGTE5nozItHKoX69RiBlK9c=;
        b=vJ4OFEkcbG1agdPxGccwQbBc8rAuR9cGgCsYwGAV+KW85F0NTQ9u9u6kv62Sr91ufO
         h44HljNo1fS7MZN/dn1k7xMIgM/v+ynUOPHCN3PlOMIMj59SBLALsuiRcEMj8/X0uAH3
         BMCyChW78mKbnoLLz7SfV6ri1HFHLCqS0abdKjAKsoB9yrW8nkL/ci8srOl1+j71MigB
         r+kNJLMwIQZDVgvZxr4yjbfWqMluBWnLXpTKIYijwcXLwrVHMwcO6cNjGTfT4uI/D8y5
         RnVKHojA3v1dbA7tAMYV1f/CJdJkR4GJLD3trYzde7/0NJumsKbW2WmC3pI1Cv+6Z4u5
         MGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIuqP4Yz2mMXyBFDc+vWEGTE5nozItHKoX69RiBlK9c=;
        b=F6m7jNNZ1dc1QmzUIkWMIocxOn5vn6mTsDW/AjBOWjLmZQl8TzpA6F2mGDLp5vgNHF
         2n0KXRTID4swJFcI/Co3X+xYHYk0rEMBFh1TnyuGqfDB5xCv3tl+olIaHE4BJSuiJxwf
         ZddthB2CB+ZrwWUiphzZlF1DcMzJHCFxKF4MZqME5wnuaKRfQjpIyZvodv1aKLKJLChq
         CNWt8u/+mdzM+IYXTWN2ZeQHuSIdMRvfMtKfpKNlzIak6Dz4UktKN9sfsRRt4oREFOq9
         cGLrFPyuoNufwtKw8ejrbiWYJDscEuNph43TNdGSQ7bUncjCcVbb9WFLcdCHpxfyicvZ
         X6sQ==
X-Gm-Message-State: AOAM5325bh2zEG3GY+gQc75j9Gc+81P36BSGqB6O5wcWA2jcOmFzyWt/
        VwgL8iA6I6/tGzDJ1SaJDYZM2MfINtQ5/pD6GYxo1w==
X-Google-Smtp-Source: ABdhPJyeEo2GV1LHXrjsMojC83k03WtHncas+SnV0s9fpP+5J5WcDDtW7g6EGcAAsdn4yPgsmmawAkdI4/LU2VXVzTQ=
X-Received: by 2002:a63:311:: with SMTP id 17mr4040003pgd.450.1628890070229;
 Fri, 13 Aug 2021 14:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR12MB2534D383B0226498DD7F2005BDFA9@DM5PR12MB2534.namprd12.prod.outlook.com>
 <20210813171421.GA2593219@bjorn-Precision-5520>
In-Reply-To: <20210813171421.GA2593219@bjorn-Precision-5520>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Aug 2021 14:27:39 -0700
Message-ID: <CAPcyv4gQz7EBkvPdu_y8hBqQ_S12B5cAz4x42C1mx7dsBXKV9w@mail.gmail.com>
Subject: Re: CXL Hot and Warm Reset Testing
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vikram Sethi <vsethi@nvidia.com>,
        Chris Browy <cbrowy@avery-design.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 10:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Amey (working on PCI resets), linux-pci]
>
> On Fri, Aug 13, 2021 at 05:01:32PM +0000, Vikram Sethi wrote:
> > Hi Dan,
> >
> > > -----Original Message-----
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > On Wed, Aug 11, 2021 at 9:42 AM Chris Browy <cbrowy@avery-design.com>
> > > wrote:
> > >
> > > /sys/bus/pci/devices/$device/reset is a method to trigger PCI
> > > device reset, but I do not expect that will ever gain CXL specific
> > > knowledge.
> > >
> > CXL reset may need some thought, specially for devices that don't
> > expose FLR but do expose CXL reset (while former does not affect
> > CXL.cache/mem, the latter wipes out CXL.cache/mem state in the
> > device and there is discoverability as to whether or not memory
> > contents can be cleared as part of CXL reset). We may need a way of
> > triggering CXL reset from userspace, and if the existing
> > /sys/bus/pci/devices/$device/reset won't have knowledge of CXL
> > reset, there still should be a prioritized order in the kernel in
> > which CXL reset is attempted before more drastic resets like SBR.
> > IIRC CXL reset can also impact all functions that use CXL.cache/mem,
> > but not legacy PCIe functions on the device which do not use
> > CXL.cache/mem (there is discoverability as to which functions are
> > not impacted by CXL reset).

What's the Linux use case for supporting CXL reset for a CXL memory
expander? PCI reset is useful for device assignment, and CXL reset
might be useful for similarly assigning an accelerator. CXL.mem on the
other hand can be directly assigned at a per-page level without also
needing to assign the device. How could a VM reliably program HDM
decoders when it cannot perceive the host physical address space? I
understand the utility of CXL reset for device bring-up and test
software that knows what it is doing can write config space directly,
but that software would assume all responsibility.
