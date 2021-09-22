Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F27414602
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 12:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhIVKTK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 06:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234808AbhIVKTJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 06:19:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DC1E611B0;
        Wed, 22 Sep 2021 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632305859;
        bh=JXOkDMfnQ1lWmcGq+rc6VpoA+s+ZT66IckZyEPT5MAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=okmEy89UO0f7/y2BvLnZ8RZoPgxAeMMl7SYqIr7F3wFwKBnOtfuIPjcjEuB0Q1/Kx
         jYO+yjbmOuvOQyKSGmWQTZFt2Yhm7bqfaXXokO2Ft2ADZImtrdCzusfMitWbc60CEf
         nLmUveO4U42Xj8MhgCV/yduVIsjPJJmi+YUKDc8ajrquWM6YNu2KcHAHWmb5y27qPA
         bkU8xEONb4CgfXET5wm3VKsZ/3JUogCMFfXUK7cm3TP+tN9/iIrRLDZesFVRrRLjBI
         KCUWtt2DfhhcfAEtwzUT4+ABXS1SkIntyFZJ/Uys0XWmEIoY2w+dxgq47kvFCYvFpY
         rQihjcGgKlVHA==
Received: by pali.im (Postfix)
        id CC47279F; Wed, 22 Sep 2021 12:17:36 +0200 (CEST)
Date:   Wed, 22 Sep 2021 12:17:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Implement re-issuing config requests on
 CRS response
Message-ID: <20210922101736.v6qur3qnarccdoqe@pali>
References: <20210915105553.6eaqakvrmag6vxeq@pali>
 <20210916143257.GA1608462@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210916143257.GA1608462@bjorn-Precision-5520>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 16 September 2021 09:32:57 Bjorn Helgaas wrote:
> On Wed, Sep 15, 2021 at 12:55:53PM +0200, Pali Rohár wrote:
> > On Tuesday 14 September 2021 15:55:26 Bjorn Helgaas wrote:
> 
> > > It is illegal for a device to return CRS after it has returned a
> > > successful completion unless an intervening reset has occurred, so
> > > drivers and other code should never see it.
> > > 
> > > > And issue is there also with write requests. Is somebody checking return
> > > > value of pci_bus_write_config function?
> > > 
> > > Similar case here.  The enumeration and wait-after-reset paths always
> > > do *reads* until we get a successful completion, so I don't think we
> > > ever issue a write that can get CRS.
> > 
> > Yes, in normal conditions we should not see it.
> > 
> > But for testing purposes (that emulated bridge works fine) I'm using
> > setpci for changing some configuration.
> > 
> > And via setpci it is possible to turn off CRSSVE bit in which case then
> > Root Complex should re-issue request again.
> > 
> > I'm not sure how "legal" it is if userspace / setpci changes some of
> > these bits. At least on a hardware with a real Root Port device it
> > should be fully transparent. As hardware handles this re-issue and
> > kernel then would see (reissued) response.
> 
> If setpci changes bits like these, all bets are off.  We can't tell
> what happened, so we can't rely on any configuration Linux did.  I
> think we really should taint the kernel when this happens.

For testing purposes, setpci is still a very good tool.

> > Test case: Initialize device, then unbind it from sysfs, reset it (hot
> > reset or warm reset) and then rescan / reinit it again. Here device is
> > permitted to send CRS response.
> > 
> > We know that more PCIe cards are buggy and sometimes firmware on cards
> > crashes or resets card logic. Which may put card into initialization
> > state when it is again permitted to send CRS response.
> 
> Yep.  That's a buggy device and normally we would work around it with
> a quirk.  This particular kind of bug would be hard to work around,
> but a host bridge driver doesn't seem like the right place to do it
> because we'd have to do it in *every* such driver.

This described firmware crashing & card reset logic I saw in more wifi
cards. Sometimes even wifi drivers itself detects that card does not
respond and do some its own internal card reset (e.g. iwldvm on laptop).
So it very common situation.

But I have not seen that these cards on laptop issue CRS response. Maybe
because their firmware or PCIe logic bootup too fast (so there is a very
little window for CRS response) or because CRS response sent to OS did
not cause any issue.

So no particular workaround is needed for above described scenario.


But anyway, in case that in future there would be need for disabling CRS
feature in kernel (e.g. for doing some workaround for endpoint or
extended pcie switch) then this re-issuing of config request on CRS
response in pci-aardvark.c would be needed to have similar behavior like
real HW hen CRS is disabled.

And I like the idea if driver is "feature complete" and prepared also
for other _valid_ code paths. This is just my opinion.
