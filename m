Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828992A4665
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 14:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgKCN3D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 08:29:03 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:63763 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgKCN2m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 08:28:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604410122; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=KbJ7uf5ba26n7iQKy0xxLg+5Abs5t9kAoaQgbJ0imWA=;
 b=mh9vCHo2jrQi2Q0CR/M3B4jGuEGBCc/oTk+aO2/ZGnVwssY2i8fZegfRR+iN8rkgYm/mKJaS
 67dbQ1yDqsVbatgEgNV/OM/XQJUJlnXHyH91oeFR3BL7+BvavyKqXj7OceAcMl1vs/2Ty/nS
 qzntekb1wioeE9u8OZiszH+Cixs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fa15af775bebe827a00145b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 03 Nov 2020 13:28:23
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18F86C4344A; Tue,  3 Nov 2020 03:01:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EEF9C433B1;
        Tue,  3 Nov 2020 03:01:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 03 Nov 2020 11:01:56 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        Devin Bayer <dev@doubly.so>,
        Thomas Krause <thomaskrause@posteo.de>,
        ath11k@lists.infradead.org
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
In-Reply-To: <20201102205752.GA34153@bjorn-Precision-5520>
References: <20201102205752.GA34153@bjorn-Precision-5520>
Message-ID: <ea5a2a1956ffd19ae61c42f895d90961@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-11-03 04:57, Bjorn Helgaas wrote:
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
>> I don't know enough about PCI to say if the bridge is a problem or 
>> not.
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
> 

Have you enabled VT-d from BIOS? This is required at least on some old 
laptops.


>> To summarise: Thomas is reporting[1] a problem with ath11k on QCA6390
>> PCI device where he is not having enough MSI vectors. ath11k needs 32
>> vectors but pci_alloc_irq_vectors() returns -ENOSPC. PCI support is 
>> new
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
> 
> But it seems a little greedy if the device can't operate at all unless
> it gets 32 vectors.  Are you sure that's a hard requirement?  Most
> devices can work with fewer vectors, even if it reduces performance.
> 
>> I would first try with a full distro kernel config, just in case 
>> there's
>> some another important kernel config missing.
>> 
>> [1] 
>> http://lists.infradead.org/pipermail/ath11k/2020-October/000466.html
> 
> Tangent: have you considered getting this list archived on
> https://lore.kernel.org/lists.html?
> 
>> [2] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/ath/ath11k/pci.c#n633
>> 
>> --
>> https://patchwork.kernel.org/project/linux-wireless/list/
>> 
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
