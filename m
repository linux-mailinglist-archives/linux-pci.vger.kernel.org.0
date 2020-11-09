Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BE2AC405
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 19:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKISoa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 13:44:30 -0500
Received: from z5.mailgun.us ([104.130.96.5]:26814 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKISo3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 13:44:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604947469; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=OPCQOVS1Bd7y/RayUepISOx06qOQfRxt3EDDnq5jY0M=; b=wPRS6XFzCwidmT4Q43Rsu8rqkYYKkoPehqJ8ixFfxDkzYOWPln1FjuzRJq+/n3ymXWtwDhWi
 9n5/93unJUaWeqnbURMSzZaYgeRmRRtQMqnPU/DT3ZNnYNI+pZRZ/SVhgpk67RqtR7Mp7fWN
 8Nr5FATgpDz4BPeGUFAP1ooJ1JQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fa98e0de41a481b55976366 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 18:44:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B280BC43382; Mon,  9 Nov 2020 18:44:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60507C433C8;
        Mon,  9 Nov 2020 18:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60507C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        Devin Bayer <dev@doubly.so>, Christoph Hellwig <hch@lst.de>,
        Thomas Krause <thomaskrause@posteo.de>,
        ath11k@lists.infradead.org, Stefani Seibold <stefani@seibold.net>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
References: <20201103160838.GA246433@bjorn-Precision-5520>
        <874km61732.fsf@nanos.tec.linutronix.de>
        <87wnz2ysd4.fsf@nanos.tec.linutronix.de>
Date:   Mon, 09 Nov 2020 20:44:22 +0200
In-Reply-To: <87wnz2ysd4.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Tue, 03 Nov 2020 23:42:47 +0100")
Message-ID: <871rh2fjzt.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Nov 03 2020 at 22:08, Thomas Gleixner wrote:
>> On Tue, Nov 03 2020 at 10:08, Bjorn Helgaas wrote:
>>>> > But it seems a little greedy if the device can't operate at all unless
>>>> > it gets 32 vectors.  Are you sure that's a hard requirement?  Most
>>>> > devices can work with fewer vectors, even if it reduces performance.
>>
>> Right, even most high end network cards work with one interrupt.
>>
>>>> This was my first reaction as well when I saw the code for the first
>>>> time. And the reply I got is that the firmware needs all 32 vectors, it
>>>> won't work with less.
>>
>> Great design.
>
> Just to put more information to this:
>
> Enforcing 32 vectors with MSI is beyond silly. Due to the limitations of
> MSI all of these vectors will be affine to a single CPU unless irq
> remapping is available and enabled.
>
> So if irq remapping is not enabled, then what are the 32 vectors buying?
> Exactly nothing because they just compete to be handled on the very same
> CPU. If the design requires more than one vector, then this should be
> done with MSI-X (which allows individual affinities and individual
> masking).
>
> That's known for 20 years and MSI-X exists for exactly that reason. But
> hardware people still insist on implementing MSI (probably because it
> saves 0.002$ per chip).
>
> But there is also the firmware side. Enforcing the availability of 32
> vectors on MSI is silly to begin with as explained above, but it's also
> silly given the constraints of the x86 vector space. It takes just 6
> devices having the same 32 vector requirement to exhaust it. Oh well...

Thanks Thomas, this is great info. I'm pushing this internally and we
try to get ath11k working with just one MSI vector.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
