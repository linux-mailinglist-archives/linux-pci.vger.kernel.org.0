Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC262AED5F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 10:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgKKJWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 04:22:21 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:31862 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgKKJWV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 04:22:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605086540; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=jNEXqnMEOejEKfmGT2h+3mLsSGgVG9M5Dq2tc2meyWI=; b=NyP4ZDUy6FH/Q/OosqEv+VW1bVMfXqJptriiTH1dQdWX9kIfjQUdkLyMmCb+GqSWMZGNlD2A
 gbCiKk0kPT9vNPH8e+hDjGG3n7ZlCyjS/Sb7n+1UN8GtkF25c7AIPBJ7A/Z+Scj8vKtW2YRe
 ubvd+Vlrydj53W3eX03ylW+SpJA=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5fabad431b0f99048353c068 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 09:22:11
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 567BEC433C6; Wed, 11 Nov 2020 09:22:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3AB1C433C8;
        Wed, 11 Nov 2020 09:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3AB1C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thomas Krause <thomaskrause@posteo.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        ath11k@lists.infradead.org, Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
References: <20201103160838.GA246433@bjorn-Precision-5520>
        <874km61732.fsf@nanos.tec.linutronix.de>
        <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
        <87mtzxkus5.fsf@nanos.tec.linutronix.de>
        <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
        <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
Date:   Wed, 11 Nov 2020 11:22:04 +0200
In-Reply-To: <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> (Thomas Krause's
        message of "Wed, 11 Nov 2020 09:53:51 +0100")
Message-ID: <87v9ec9rk3.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thomas Krause <thomaskrause@posteo.de> writes:

> Am 10.11.20 um 09:33 schrieb Kalle Valo:
>>
>>> I was told that on Dell XPS 15 (with a working QCA6390 setup) there's a
>>> separate "Virtualisation" setting in BIOS. See if you have that and try
>>> enabling it.
>> I was informed about another setting to test: try disabling "Enable
>> Secure Boot" in the BIOS. I don't know yet why it would help, but that's
>> what few people have recommended.
>>
>> Please let me know how it goes.
>>
> I have two options under "Virtualization" in the BIOS: "Enable Intel
> Virtualization Technology (VT)" and "VT for Direct I/O". Both were
> enabled. Secure boot was also turned off. BIOS version is also at the
> most current version 1.1.1.

This is good to know, thanks for testing. Now we have explored all
possible BIOS options as I know of.

> Because of the dmesg errors Thomas Gleixner mentioned, I assume it
> would be best to contact Dell directly (even if I'm not sure if and
> how fast they will respond).

I have asked our people to report this to Dell, but no response yet.

> If the driver would manage to work with only 1 vector, I assume this
> would also make it work on my configuration, even with possible
> performance hits.

This is the workaround we are working on at the moment. There's now a
proof of concept patch but I'm not certain if it will work. I'll post it
as soon as I can and will provide the link in this thread.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
