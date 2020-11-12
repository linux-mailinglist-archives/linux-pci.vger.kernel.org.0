Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2056B2AFFA7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 07:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKLGaZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 01:30:25 -0500
Received: from z5.mailgun.us ([104.130.96.5]:25395 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKLGaY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 01:30:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605162623; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=H1GQ/wzwfZTSYJc8uA3tOXtcsIOPIPU7HMa2zWU0eTo=;
 b=kvxSNavBb8yC0chmw5BgqrM0JleCxxXEDyMw+ap0DJLVvA+vxe0YssDp+VyIKBS+mrandmVa
 IAOaZcmLKCXUMRZhmvD9HPqz9+dzxrRaQABOU8pmLbY/Hzng2Pt+WAfYfSiLM3DPNfK7rBuR
 JLeNXywxaYez4SY2XbV1u3OqCKA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5facd6678bd2e3c222ea285f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Nov 2020 06:29:59
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7DF33C433CB; Thu, 12 Nov 2020 06:29:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E7E7C433C6;
        Thu, 12 Nov 2020 06:29:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Nov 2020 14:29:53 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     wi nk <wink@technolu.st>
Cc:     Stefani Seibold <stefani@seibold.net>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        Devin Bayer <dev@doubly.so>, ath11k@lists.infradead.org,
        Thomas Krause <thomaskrause@posteo.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
In-Reply-To: <CAHUdJJWsCo6NJ6qr6kj=SASs+jO+fJFc3HhOO=fyek=OxSQa2Q@mail.gmail.com>
References: <20201103160838.GA246433@bjorn-Precision-5520>
 <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
 <87mtzxkus5.fsf@nanos.tec.linutronix.de> <87wnz0hr9k.fsf@codeaurora.org>
 <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
 <87v9ec9rk3.fsf@codeaurora.org> <87imab4slq.fsf@codeaurora.org>
 <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
 <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
 <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
 <CAHUdJJUkvcShSXw4mkFUDcEh101xNQbOUc0YEv6-TyLdyTs4Og@mail.gmail.com>
 <CAHUdJJWsCo6NJ6qr6kj=SASs+jO+fJFc3HhOO=fyek=OxSQa2Q@mail.gmail.com>
Message-ID: <5f7f39fc69a6bc4219297f2d2c25e224@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-12 10:31, wi nk wrote:
> On Thu, Nov 12, 2020 at 2:11 AM wi nk <wink@technolu.st> wrote:
>> 
>> On Thu, Nov 12, 2020 at 2:10 AM wi nk <wink@technolu.st> wrote:
>> >
>> > I've yet to see any instability after 45 minutes of exercising it, I
>> > do see a couple of messages that came out of the driver:
>> >
>> > [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
>> > [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
>> >
>> > then when it associates:
>> >
>> > [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
>> > [   16.722636] wlp85s0: authenticated
>> > [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
>> > [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
>> > (capab=0x411 status=0 aid=8)
>> > [   16.738443] wlp85s0: associated
>> > [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes ready
>> >
>> > The adapter is achieving around 500 mbps on my gigabit connection, my
>> > 2018 mbp sees around 650, so it's doing pretty well so far.
>> >
>> > Stefani - when you applied the patch that Kalle shared, which branch
>> > did you apply it to?  I applied it to ath11k-qca6390-bringup and when
>> > I revert 7fef431be9c9 there is a small merge conflict I needed to
>> > resolve.  I wonder if either the starting branch, or your chosen
>> > resolution are related to the instability you see (or I'm just lucky
>> > so far! :)).
>> >
>> > On Thu, Nov 12, 2020 at 1:24 AM wi nk <wink@technolu.st> wrote:
>> > >
>> > > On Wed, Nov 11, 2020 at 11:02 PM Stefani Seibold <stefani@seibold.net> wrote:
>> > > >
>> > > > On Wed, 2020-11-11 at 21:10 +0200, Kalle Valo wrote:
>> > > > >
>> > > > > The proof of concept patch for v5.10-rc2 is here:
>> > > > >
>> > > > > https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-1-git-send-email-kvalo@codeaurora.org/
>> > > > >
>> > > > > Hopefully it makes it possible to boot the firmware now. But this is
>> > > > > a
>> > > > > quick hack and most likely buggy, so keep your expectations low :)
>> > > > >
>> > > > > In case there are these warnings during firmware initialisation:
>> > > > >
>> > > > > ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
>> > > > > ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
>> > > > >
>> > > > > Try reverting this commit:
>> > > > >
>> > > > > 7fef431be9c9 mm/page_alloc: place pages to tail in
>> > > > > __free_pages_core()
>> > > > >
>> > > > > That's another issue which is debugged here:
>> > > > >
>> > > > > http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
>> > > > >
>> > > >
>> > > > Applying the patch and revert patch 7fef431be9c9 worked on the first
>> > > > glance.
>> > > >
>> > > > After a couple of minutes the connection get broken. The kernel log
>> > > > shows the following error:
>> > > >
>> > > > ath11k_pci 0000:55:00.0: wmi command 16387 timeout
>> > > > ath11k_pci 0000:55:00.0: failed to send WMI_PDEV_SET_PARAM cmd
>> > > > ath11k_pc
>> > > > i 0000:55:00.0: failed to enable PMF QOS: (-11
>> > > >
>> > > > It is also not possible to unload the ath11k_pci, rmmod will hang.
>> > > >
>> > > >
>> > >
>> > > I can confirm the same behavior as Stefani so far.  After applying the
>> > > patch, and reverting commit 7fef431be9c9, I am able to connect to a
>> > > network.  It hasn't disconnected yet (I'm sending this email via that
>> > > connection).  I'll report what I find next.
>> > >
>> > > Thanks again for the help!
>> 
>> Sigh.... sorry for the top post again.  I'll now get a real email 
>> client.
> 
> So the connection remained super stable for a while, so I decided to
> tempt fate and suspend the laptop to see what would happen :).
> 
> [ 5994.143715] PM: suspend exit
> [ 5997.260351] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> [ 5997.260353] ath11k_pci 0000:55:00.0: failed to send 
> WMI_PDEV_SET_PARAM cmd
> [ 5997.260356] ath11k_pci 0000:55:00.0: failed to enable dynamic bw: 
> -11
> [ 6000.332299] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> [ 6000.332303] ath11k_pci 0000:55:00.0: failed to send 
> WMI_PDEV_SET_PARAM cmd
> [ 6000.332308] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
> [ 6003.404365] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> [ 6003.404368] ath11k_pci 0000:55:00.0: failed to send 
> WMI_PDEV_SET_PARAM cmd
> [ 6003.404373] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
> [ 6016.204347] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> [ 6016.204351] ath11k_pci 0000:55:00.0: failed to send 
> WMI_PDEV_SET_PARAM cmd
> [ 6016.204357] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
> [ 6019.276319] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> [ 6019.276323] ath11k_pci 0000:55:00.0: failed to send 
> WMI_PDEV_SET_PARAM cmd
> [ 6019.276329] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
> [ 6031.052272] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> [ 6031.052275] ath11k_pci 0000:55:00.0: failed to send 
> WMI_PDEV_SET_PARAM cmd
> [ 6031.052279] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
> [ 6034.128257] ath11k_pci 0000:55:00.0: wmi command 16387 timeout
> [ 6034.128261] ath11k_pci 0000:55:00.0: failed to send 
> WMI_PDEV_SET_PARAM cmd
> [ 6034.128265] ath11k_pci 0000:55:00.0: failed to enable PMF QOS: (-11
> [ 6039.500241] ath11k_pci 0000:55:00.0: qmi failed set mode request,
> mode: 4, err = -110
> [ 6039.500244] ath11k_pci 0000:55:00.0: qmi failed to send wlan mode 
> off
> 
> I was able to remove the ath11k module using rmmod -f , and then
> modprobe ath11k + atk11k_pci and the device was able to reassociate
> and bring the connection back up.

Please apply below to have a try:
https://patchwork.kernel.org/project/linux-wireless/patch/20201112062555.3335-1-cjhuang@codeaurora.org/

