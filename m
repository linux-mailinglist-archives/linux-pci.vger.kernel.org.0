Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386582A334B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgKBSt6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 13:49:58 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:24515 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKBSt6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 13:49:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604342998; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=a9B3E/1xB3mfBJ1HXK0irk6rmapn8q+xYJ8o7dQyaZw=; b=NQCMqVBQlaIoAOH9oCWQe4ymONSjqy5zBdTTI1PceKh6WmwsoVP2txW8gWA4sZS6EXqB/nha
 HeR5QyYuyI/vr8NlDlceHJUkQjJvtGnhuxEt9Xybenrh5IsZdFML6N/FYM3bl6VT70QNrFjy
 CXxEW8HGCIlYTtUDEIyXIhDv/Yw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fa054d475bebe827afe7f61 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 18:49:56
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DDC83C433F0; Mon,  2 Nov 2020 18:49:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 610B7C433C6;
        Mon,  2 Nov 2020 18:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 610B7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thomas Krause <thomaskrause@posteo.de>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-pci@vger.kernel.org, Devin Bayer <dev@doubly.so>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
References: <2849fd39-a7a6-8366-7c78-fc9fec4dffa4@posteo.de>
        <87tuuqhc1i.fsf@codeaurora.org>
        <1ce6f735-21ff-db7e-c8dc-d567761964aa@posteo.de>
Date:   Mon, 02 Nov 2020 20:49:51 +0200
In-Reply-To: <1ce6f735-21ff-db7e-c8dc-d567761964aa@posteo.de> (Thomas Krause's
        message of "Tue, 20 Oct 2020 22:46:00 +0200")
Message-ID: <871rhbvbjk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ linux-wireless, linux-pci, devin

Thomas Krause <thomaskrause@posteo.de> writes:

>> I had the same problem as well back in the days, for me enabling
>> CONFIG_IRQ_REMAP helped. If it helps for you also I wonder if we should
>> mention that in the ath11k warning above :)
>
> CONFIG_IRQ_REMAP did not do the trick. I noticed that the Wi-Fi card
> is behind a PCI bridge which is also disabled, could this be a
> problem?
>
> 00:1c.0 PCI bridge: Intel Corporation Device a0b8 (rev 20) (prog-if 00
> [Normal decode])
> 	Flags: bus master, fast devsel, latency 0, IRQ 123
> 	Bus: primary=00, secondary=56, subordinate=56, sec-latency=0
> 	I/O behind bridge: [disabled]
> 	Memory behind bridge: 8c300000-8c3fffff [size=1M]
> 	Prefetchable memory behind bridge: [disabled]
> 	Capabilities: [40] Express Root Port (Slot+), MSI 00
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 	Capabilities: [90] Subsystem: Dell Device 0991
> 	Capabilities: [a0] Power Management version 3
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [220] Access Control Services
> 	Capabilities: [150] Precision Time Measurement
> 	Capabilities: [200] L1 PM Substates
> 	Capabilities: [a00] Downstream Port Containment
> 	Kernel driver in use: pcieport

I don't know enough about PCI to say if the bridge is a problem or not.
I'm adding linux-wireless and linux-pci in someone can help. Also Devin
seems to have a similar problem.

To summarise: Thomas is reporting[1] a problem with ath11k on QCA6390
PCI device where he is not having enough MSI vectors. ath11k needs 32
vectors but pci_alloc_irq_vectors() returns -ENOSPC. PCI support is new
for ath11k and introduced in v5.10-rc1. The irq allocation code is in
drivers/net/wireless/ath/ath11k/pci.c. [2]

Can PCI folks help, what could cause this and how to debug it further?

I would first try with a full distro kernel config, just in case there's
some another important kernel config missing.

[1] http://lists.infradead.org/pipermail/ath11k/2020-October/000466.html

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath11k/pci.c#n633

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
