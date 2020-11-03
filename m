Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF302A4669
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 14:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgKCN3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 08:29:12 -0500
Received: from z5.mailgun.us ([104.130.96.5]:35548 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgKCN2Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 08:28:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604410103; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=bvAtK86qzMGJH9G/9rCYFInJ28k7Z3FFPLRcYF1MVg0=; b=ht3qVmJM1cunG0Pfuxa5Cp8BOX+Qp3Eso0YStNdO3HktMOFbmtv0Dgf7UNbNCE/BaMeOF6Ck
 Vb5fy17oGCNsjr+wbejb0lbdxvPOOyf0z7/4VxPMov+h9+DDXfnZkpH0w1kRBeBkapq3/ZXS
 AT+LtWWj0KmgbRVhXTQeMkmVeLk=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa15af7978460d05b541871 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 13:28:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E365EC4A5E2; Tue,  3 Nov 2020 06:49:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79D45C384E4;
        Tue,  3 Nov 2020 06:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 79D45C384E4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Thomas Krause <thomaskrause@posteo.de>,
        ath11k@lists.infradead.org
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
References: <20201102205752.GA34153@bjorn-Precision-5520>
Date:   Tue, 03 Nov 2020 08:49:06 +0200
In-Reply-To: <20201102205752.GA34153@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Mon, 2 Nov 2020 14:57:52 -0600")
Message-ID: <87k0v3szod.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> [+cc Govind, author of 5697a564d369 ("ath11k: pci: add MSI config
> initialisation")]
>
> On Mon, Nov 02, 2020 at 08:49:51PM +0200, Kalle Valo wrote:
>> + linux-wireless, linux-pci, devin
>> 
>> Thomas Krause <thomaskrause@posteo.de> writes:
>> 
>> >> I had the same problem as well back in the days, for me enabling
>> >> CONFIG_IRQ_REMAP helped. If it helps for you also I wonder if we should
>> >> mention that in the ath11k warning above :)
>> >
>> > CONFIG_IRQ_REMAP did not do the trick. I noticed that the Wi-Fi card
>> > is behind a PCI bridge which is also disabled, could this be a
>> > problem?
>> >
>> > 00:1c.0 PCI bridge: Intel Corporation Device a0b8 (rev 20) (prog-if 00
>> > [Normal decode])
>> > 	Flags: bus master, fast devsel, latency 0, IRQ 123
>> > 	Bus: primary=00, secondary=56, subordinate=56, sec-latency=0
>> > 	I/O behind bridge: [disabled]
>> > 	Memory behind bridge: 8c300000-8c3fffff [size=1M]
>> > 	Prefetchable memory behind bridge: [disabled]
>> > 	Capabilities: [40] Express Root Port (Slot+), MSI 00
>> > 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
>> > 	Capabilities: [90] Subsystem: Dell Device 0991
>> > 	Capabilities: [a0] Power Management version 3
>> > 	Capabilities: [100] Advanced Error Reporting
>> > 	Capabilities: [220] Access Control Services
>> > 	Capabilities: [150] Precision Time Measurement
>> > 	Capabilities: [200] L1 PM Substates
>> > 	Capabilities: [a00] Downstream Port Containment
>> > 	Kernel driver in use: pcieport
>> 
>> I don't know enough about PCI to say if the bridge is a problem or not.
>
> I don't think the bridge is an issue here.  AFAICT the bridge's I/O
> and prefetchable memory windows are disabled, but the non-prefetchable
> window *is* enabled and contains the space consumed by the ath11k
> device:
>
>   00:1c.0 PCI bridge: Intel Corporation Device a0b8 (rev 20)
> 	Bus: primary=00, secondary=56, subordinate=56, sec-latency=0
> 	Memory behind bridge: 8c300000-8c3fffff [size=1M]
>   56:00.0 Network controller: Qualcomm Device 1101 (rev 01)
>      Region 0: Memory at 8c300000 (64-bit, non-prefetchable) [size=1M]

Good to know that the bridge shouldn't be the problem. Do you have any
ideas how to make more vectors available to ath11k, besides
CONFIG_IRQ_REMAP? Because QCA6390 works in Windows I doubt this is a
hardware problem.

>> To summarise: Thomas is reporting[1] a problem with ath11k on QCA6390
>> PCI device where he is not having enough MSI vectors. ath11k needs 32
>> vectors but pci_alloc_irq_vectors() returns -ENOSPC. PCI support is new
>> for ath11k and introduced in v5.10-rc1. The irq allocation code is in
>> drivers/net/wireless/ath/ath11k/pci.c. [2]
>
> This code is needlessly complicated.  If you absolutely need
> msi_config.total_vectors and can't settle for any less, you can do
> this:
>
>   num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
>                                       msi_config.total_vectors,
>                                       msi_config.total_vectors,
>                                       PCI_IRQ_MSI);
>
>   if (num_vectors < 0) {
>     ath11k_err(ab, "failed to get %d MSI vectors (%d)\n",
>                msi_config.total_vectors, num_vectors);
>     return num_vectors;
>   }

True, this should be cleaned up. But of course this won't solve the
actual problem.

> But it seems a little greedy if the device can't operate at all unless
> it gets 32 vectors.  Are you sure that's a hard requirement?  Most
> devices can work with fewer vectors, even if it reduces performance.

This was my first reaction as well when I saw the code for the first
time. And the reply I got is that the firmware needs all 32 vectors, it
won't work with less.

>> I would first try with a full distro kernel config, just in case there's
>> some another important kernel config missing.
>> 
>> [1] http://lists.infradead.org/pipermail/ath11k/2020-October/000466.html
>
> Tangent: have you considered getting this list archived on
> https://lore.kernel.org/lists.html?

Good point, actually I have not. I'll add both ath10k and ath11k lists
to lore. It's even more important now that lists.infradead.org had a
hard drive crash and lost years of archives.

Thanks for the help!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
