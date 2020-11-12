Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A903D2B0170
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 10:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKLJAC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 04:00:02 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:23189 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgKLJAC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 04:00:02 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605171600; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=KASQ32+IowFQpz4KHPHvDSZn71B4QARWpgK+oQm39qY=; b=GZLBPmwsnlilVzxM6QmwJfJndBanwn1qur+XHz7Rf46BusS39WgUfQPIYD1Q+XoEM7JzV86f
 ec9/3vFsBT8AAHaKvQFr7ZAuw6qVPVePuxvK2uyqtcor4X+WBP+MfWJBjIOWzZ8uZVYAc4pa
 YObYCOFPcq2heAOZf6cyVAZXT9E=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5facf99037ede2253b10ee37 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Nov 2020 09:00:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E90AFC43387; Thu, 12 Nov 2020 08:59:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19626C433C8;
        Thu, 12 Nov 2020 08:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19626C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     wi nk <wink@technolu.st>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Krause <thomaskrause@posteo.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
References: <20201103160838.GA246433@bjorn-Precision-5520>
        <874km61732.fsf@nanos.tec.linutronix.de>
        <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
        <87mtzxkus5.fsf@nanos.tec.linutronix.de>
        <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
        <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
        <87v9ec9rk3.fsf@codeaurora.org> <87imab4slq.fsf@codeaurora.org>
        <b2129a70db2b36c5015b4143a839f47dfc3153af.camel@seibold.net>
        <CAHUdJJVp5r55NtE+BNz5XGtnaks6mDKQBFodz63DdULBVhD0Lg@mail.gmail.com>
        <CAHUdJJXRDKs9NRugUAFgNr51DJ=OcssuiV8ST5CaV1CKiNTFfA@mail.gmail.com>
        <0b58872b4f27dbf5aad2a39f5ec4a066e080d806.camel@seibold.net>
        <875z6b3v22.fsf@codeaurora.org>
        <CAHUdJJVK1vH2_9YkCQ99n5mak3oGN09422gG0APkWwcy=ZDQ-Q@mail.gmail.com>
Date:   Thu, 12 Nov 2020 10:59:53 +0200
In-Reply-To: <CAHUdJJVK1vH2_9YkCQ99n5mak3oGN09422gG0APkWwcy=ZDQ-Q@mail.gmail.com>
        (wi nk's message of "Thu, 12 Nov 2020 08:41:08 +0100")
Message-ID: <87pn4j2bna.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

wi nk <wink@technolu.st> writes:

> On Thu, Nov 12, 2020 at 8:15 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>>
>> Stefani Seibold <stefani@seibold.net> writes:
>>
>> > Am Donnerstag, den 12.11.2020, 02:10 +0100 schrieb wi nk:
>> >> I've yet to see any instability after 45 minutes of exercising it, I
>> >> do see a couple of messages that came out of the driver:
>> >>
>> >> [    8.963389] ath11k_pci 0000:55:00.0: Unknown eventid: 0x16005
>> >> [   11.342317] ath11k_pci 0000:55:00.0: Unknown eventid: 0x1d00a
>> >>
>> >> then when it associates:
>> >>
>> >> [   16.718895] wlp85s0: send auth to ec:08:6b:27:01:ea (try 1/3)
>> >> [   16.722636] wlp85s0: authenticated
>> >> [   16.724150] wlp85s0: associate with ec:08:6b:27:01:ea (try 1/3)
>> >> [   16.726486] wlp85s0: RX AssocResp from ec:08:6b:27:01:ea
>> >> (capab=0x411 status=0 aid=8)
>> >> [   16.738443] wlp85s0: associated
>> >> [   16.764966] IPv6: ADDRCONF(NETDEV_CHANGE): wlp85s0: link becomes
>> >> ready
>> >>
>> >> The adapter is achieving around 500 mbps on my gigabit connection, my
>> >> 2018 mbp sees around 650, so it's doing pretty well so far.
>> >>
>> >> Stefani - when you applied the patch that Kalle shared, which branch
>> >> did you apply it to?  I applied it to ath11k-qca6390-bringup and when
>> >> I revert 7fef431be9c9 there is a small merge conflict I needed to
>> >> resolve.  I wonder if either the starting branch, or your chosen
>> >> resolution are related to the instability you see (or I'm just lucky
>> >> so far! :)).
>> >>
>> >
>> > I used the vanilla kernel tree
>> > https://git.kernel.org/torvalds/t/linux-5.10-rc2.tar.gz. On top of this
>> > i applied the
>> >
>> > RFT-ath11k-pci-support-platforms-with-one-MSI-vector.patch
>> >
>> > and reverted the patch 7fef431be9c9
>>
>> I did also my testing on v5.10-rc2 and I recommend to use that as the
>> baseline when debuggin these ath11k problems. It helps to compare the
>> results if everyone have the same baseline.
>>
>> --
>> https://patchwork.kernel.org/project/linux-wireless/list/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
> Absolutely, I'll rebuild to 5.10 later today and apply the same series
> of patches and report back.

Great, thanks.

> I'll also test out the patch on both versions from Carl to fix
> resuming. It stands to reason that we may be seeing another regression
> between Stefani (5.10) and myself (5.9 bringup branch) as I don't see
> any disconnections or instability once the interface is online.

Yeah, there is something strange happening between v5.9 and v5.10 we
have not yet figured out. Most likely it has something to do with memory
allocations and DMA transfers failing, but no clear understanding yet.

But to keep things simple let's only discuss the MSI problem on this
thread, and discuss the timeouts in the another thread:

http://lists.infradead.org/pipermail/ath11k/2020-November/000641.html

I'll include you and other reporters to that thread.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
