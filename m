Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF04A672E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 22:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbiBAVl6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 16:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiBAVl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 16:41:57 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56EBC06173B
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 13:41:57 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c9so16479254plg.11
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B337aRtqMuEmTm8G9iWp7Wr5dtwAERr5gBHq9BXh+r8=;
        b=sEfR5UBxXHngxSYqVPtWWCzf98rkx84JocAxVqQoS2137n96hTkPnPJt2O6wnpOCqm
         D5f9cBGZgCDG3EV6D5jXF/kiH8CGyv2vHI7zqLPncGvZN4VtLGiQEGM9lNTGeJ7Qs04o
         n7wfTUuNkxh87jsV8LBHB3R6uI21VdcjhMd0GvJMRRuKOJnsv9zLHjuL7zV6BoPGc/WU
         D2f5bclQGYDYH9Z+yGWoAckwWnWtw1VP1C57SUVqKNwaSES7EPueTf6MMq7WF1I7/rh0
         SpmxJgbRPXAlyrCxJtqOdrQMu36WjkAmAIl9PvTRytSlwhueYicqpkccy++EmmLPP7Di
         +apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B337aRtqMuEmTm8G9iWp7Wr5dtwAERr5gBHq9BXh+r8=;
        b=Boc9+ez8uiqEgJXvyTC0k+6ypuCVp8elcXrNbSTf08MbzfuMqbKvxuXj3oVYGOcIzC
         14w6w4TaDO5VKxjLHF3P5FVzmkBfDVg9GIRzX5dmsApCd4etttKozZOrffiOBQMJIOxZ
         sOejSFzchKQltU9i39vW0iZkgKeAx8b6YWYcQ1pdGOHcWGONe5MhwTS6ajsqo+hb2zum
         T3iEKp4Z8dJ4pYFqMO1ausFKOp9UsXbgwSS91TAF8x53keDxKJVSF4p6T8CVLm+5SFVJ
         QkzKnhDlQeFYBkHPPCr2g2+1feFVhHTV4Prk5O1Q8fUWT+JbgCryZBk77ra9WyFpmceO
         hAiw==
X-Gm-Message-State: AOAM532jTlf7vjyQCbkL9GtAgNVDJSxqdREq0g8OX3bStEDOEa1bXm7Y
        1aSfkX21NvxvAEXNXVFn5hgqwj49gaIHAAhhPnl3mQ==
X-Google-Smtp-Source: ABdhPJyJZrY7ag0jqM0zrCzWZYtrPMyJJqmEiUEYPMEpyQQtFp81+CiV91skXJ5Xoa8qHfR8E2W1at9V/iXZhCSYj7Y=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr26957372ply.34.1643751717133;
 Tue, 01 Feb 2022 13:41:57 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298426273.3018233.9302136088649279124.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131181924.00006c57@Huawei.com> <20220201152410.36jvdmmpcqi3lhdw@intel.com>
In-Reply-To: <20220201152410.36jvdmmpcqi3lhdw@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 13:41:50 -0800
Message-ID: <CAPcyv4iyRKfviJNtHP=wsqRtppDb+BrmhNeum+ZcyBAJ5VSPtA@mail.gmail.com>
Subject: Re: [PATCH v3 27/40] cxl/pci: Cache device DVSEC offset
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 1, 2022 at 7:24 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-31 18:19:24, Jonathan Cameron wrote:
> > On Sun, 23 Jan 2022 16:31:02 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
> > > be implemented by CXL 2.0 endpoint devices. Since the information
> > > contained within this DVSEC will be critically important, it makes sense
> > > to find the value early, and error out if it cannot be found.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Guess the logic makes sense about checking this early though my cynical
> > mind says, that if someone is putting in devices that claim to be
> > CXL ones and this isn't there it is there own problem if they
> > kernel wastes effort bringing the driver up only to find later
> > it can't finish doing so...
>
> I don't remember if Dan and I discussed actually failing to bind this early if
> the DVSEC isn't there.

On second look, the error message does not make sense because there is
"no functionality" not "limited functionality" as a result of this
failure because the cxl_pci driver just gives up. This failure should
be limited to cxl_mem, not cxl_pci as there might still be value in
accessing the mailbox on this device.

> I think the concern is less about wasted effort and more
> about the inability to determine if the device is actively decoding something
> and then having the kernel driver tear that out when it takes over the decoder
> resources. This was specifically targeted toward the DVSEC range registers
> (obviously things would fail later if we couldn't find the MMIO).

If there is no CXL DVSEC then cxl_mem should fail, that's it.

> I agree with your cynical mind though that it might not be our job to prevent
> devices which aren't spec compliant. I'd say if we start seeing bug reports
> around this we can revisit.

What would the bug report be, "driver fails to attach to device that
does not implement the spec"?
