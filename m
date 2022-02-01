Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210684A679B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 23:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiBAWPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 17:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiBAWP3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 17:15:29 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4DC06173B
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 14:15:29 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id e16so16660651pgn.4
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 14:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lcMIoP/jHkOrDBdh7YfG3YTgWtU2wGo4Ba0w3LhmBk=;
        b=afbFAARJkoHS4pWZ0vUBRJPgIfnOqYZwucjuZLq6xeZPyo0burwAueHbReZoyKlMXg
         BG2s5RJxrnwruBFcRQRCvhFDrcVjjdgz0+KWc0qz//R8pt3v2gu/0TpUPe5QTVQHApkx
         H/Qz9HGRSD4lGZ+0deuZGdfwi/2mKtsM1I3LQVaqiSEyo1pwtrqYjkvJqf9zhobEcc7g
         CGBSXm7X+GWRz70YSzwTz0jwFtFqQ9hnVw15VcjLG1m7S6/wCHXtpGoEdUvQLiaI6LHB
         rclUXG5uqiW07B0xDC6Y2qvc8L8U+uzD4EFa+Jr2P7drnEgYbOUsIN7R5fDYpW7IV2Ze
         QNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lcMIoP/jHkOrDBdh7YfG3YTgWtU2wGo4Ba0w3LhmBk=;
        b=dBShstK9pDaXbHgTrmQp329V+dX1nc9Fl5i2Az+EUhsaLMjCna3p+3eCy01hqRREkG
         4swm/rVVFgo8S77D/CaeI9rF7OWpKPI4sKUSPI+d8qz9ldI1oHLidm0iDObsECvUqzqK
         oH/oq7Z634VFVt4T9AcsU5qRWtVFzxm/zjprhTKODptmVlLebh80RVYYZcGeJ0t6fFHk
         zKviOOG/ZoFJdipVw64u6fuGqrKKIkxWriaNE9RCwxow5TkoJnH/JDsBH5yipQpsy90r
         fr1Y4S3YHW0kNbFTVggEGmjZNiHNXOLISK0QsjTuyKZ7cvofltUOxFoXfYrTFAyDF63P
         N+kg==
X-Gm-Message-State: AOAM5313LeNf0JABstu2GhI7kuXqtLGhozeJ+/M6qvK9GRhPi1S9KhNa
        Z4SZnFP11FH97pTxDbdgUmZ+lAqn6IKlLi5xueX5JSCkCgLXOA==
X-Google-Smtp-Source: ABdhPJwfvJzchvNflrDe9GlJOyttxlmX1KkpKMR7XP6+YRQzFCoV3LZM5GUDP9/jhHXiSOAIEdQOCObqAll0xjZasmM=
X-Received: by 2002:a63:550f:: with SMTP id j15mr22064347pgb.40.1643753729140;
 Tue, 01 Feb 2022 14:15:29 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298426273.3018233.9302136088649279124.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131181924.00006c57@Huawei.com> <20220201152410.36jvdmmpcqi3lhdw@intel.com>
 <CAPcyv4iyRKfviJNtHP=wsqRtppDb+BrmhNeum+ZcyBAJ5VSPtA@mail.gmail.com> <20220201221114.25ivh5ubptd7kauk@intel.com>
In-Reply-To: <20220201221114.25ivh5ubptd7kauk@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 14:15:22 -0800
Message-ID: <CAPcyv4hYSm+q1RYnrdNvr_dXsU-OZ-v94RRvNGtr5-wtHc97=w@mail.gmail.com>
Subject: Re: [PATCH v3 27/40] cxl/pci: Cache device DVSEC offset
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 1, 2022 at 2:11 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-02-01 13:41:50, Dan Williams wrote:
> > On Tue, Feb 1, 2022 at 7:24 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 22-01-31 18:19:24, Jonathan Cameron wrote:
> > > > On Sun, 23 Jan 2022 16:31:02 -0800
> > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > > >
> > > > > The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
> > > > > be implemented by CXL 2.0 endpoint devices. Since the information
> > > > > contained within this DVSEC will be critically important, it makes sense
> > > > > to find the value early, and error out if it cannot be found.
> > > > >
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > Guess the logic makes sense about checking this early though my cynical
> > > > mind says, that if someone is putting in devices that claim to be
> > > > CXL ones and this isn't there it is there own problem if they
> > > > kernel wastes effort bringing the driver up only to find later
> > > > it can't finish doing so...
> > >
> > > I don't remember if Dan and I discussed actually failing to bind this early if
> > > the DVSEC isn't there.
> >
> > On second look, the error message does not make sense because there is
> > "no functionality" not "limited functionality" as a result of this
> > failure because the cxl_pci driver just gives up. This failure should
> > be limited to cxl_mem, not cxl_pci as there might still be value in
> > accessing the mailbox on this device.
> >
> > > I think the concern is less about wasted effort and more
> > > about the inability to determine if the device is actively decoding something
> > > and then having the kernel driver tear that out when it takes over the decoder
> > > resources. This was specifically targeted toward the DVSEC range registers
> > > (obviously things would fail later if we couldn't find the MMIO).
> >
> > If there is no CXL DVSEC then cxl_mem should fail, that's it.
> >
>
> If there is no CXL DVSEC we have no way to find the device's MMIO. You need the
> register locator dvsec. Not sure how you intend to do anything with the device
> at that point, but if you see something I don't, then by all means, change it.

I see:

pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);

...and:

pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_REG_LOCATOR);

...aren't they independent?
