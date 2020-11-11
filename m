Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260D22AF945
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 20:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKKTpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 14:45:46 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:59842 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgKKTpp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 14:45:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605123945; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=5HNjHfHNvcTfTg1jzj9sGI/9W7fuKIxxtW0/iZHh/mg=; b=cySgn7+MbPOtqkRKsjc6tx7CFgtgL0jQabCSzQ3/k6ISXcUUBd6gzzD12nYf5Ht7F5Q5lUL5
 Cf6hPhue5Bdpn1ZpKtibRlPfuNqTJ9PfDPO3hfPv8shX5oC78AdMC4cMGucyfHeEoUpkqJhI
 GembTlzaVN5Z+T7lrxG6MF2z+xE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5fac3f5324ba9b3b021b9d77 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 11 Nov 2020 19:45:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 020EDC433C8; Wed, 11 Nov 2020 19:45:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 438F4C433C8;
        Wed, 11 Nov 2020 19:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 438F4C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     wi nk <wink@technolu.st>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        ath11k@lists.infradead.org, Thomas Krause <thomaskrause@posteo.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
References: <20201103160838.GA246433@bjorn-Precision-5520>
        <874km61732.fsf@nanos.tec.linutronix.de>
        <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
        <87mtzxkus5.fsf@nanos.tec.linutronix.de>
        <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
        <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
        <87v9ec9rk3.fsf@codeaurora.org> <87imab4slq.fsf@codeaurora.org>
        <CAHUdJJVfrBGHcT1Sjmqn=HK4=ptk3xKmAOLrF8Rd=fONUne-0A@mail.gmail.com>
        <CAHUdJJVVj3y-mHxAyUx=P51hG=NspuHe=cOWWRxEjYF0nVquyw@mail.gmail.com>
Date:   Wed, 11 Nov 2020 21:45:17 +0200
In-Reply-To: <CAHUdJJVVj3y-mHxAyUx=P51hG=NspuHe=cOWWRxEjYF0nVquyw@mail.gmail.com>
        (wi nk's message of "Wed, 11 Nov 2020 20:30:33 +0100")
Message-ID: <87a6vn4r02.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

(please don't top post, makes it harder to read emails)

wi nk <wink@technolu.st> writes:

> Ok with 7fef431be9c9 reverted, it doesn't seem to change the initialization any:
>
> [    7.961867] ath11k_pci 0000:55:00.0: WARNING: ath11k PCI support is
> experimental!
> [    7.961913] ath11k_pci 0000:55:00.0: BAR 0: assigned [mem
> 0x8e300000-0x8e3fffff 64bit]
> [    7.961930] ath11k_pci 0000:55:00.0: enabling device (0000 -> 0002)
> [    7.962009] ath11k_pci 0000:55:00.0: MSI vectors: 1
> [    8.461553] ath11k_pci 0000:55:00.0: Respond mem req failed,
> result: 1, err: 48
> [    8.461556] ath11k_pci 0000:55:00.0: qmi failed to respond fw mem req:-22

I also see this -22 error (see my logs in [1]), even when the firmware
reboots normally. Do you see anything after these messages?

The problem which reverting 7fef431be9c9 helps has these errors:

ath11k_pci 0000:06:00.0: qmi failed memory request, err = -110
ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-110

[1] http://lists.infradead.org/pipermail/ath11k/2020-November/000641.html

> and just for thoroughness, here are my firmware file checksums (sha256):
>
> 9cc48d1dce819ead4112c6a8051c51e4d75e2b11f99ba9d8738cf8108967b70e  amss.bin
> 5081930c3b207f8ed82ff250f9b90fb77e87b2a92c3cf80ad020a58dea0bc5b7  board.bin
> 596482f780d21645f72a48acd9aed6c6fc8cf2d039ac31552a19800674d253cc  m3.bin

But these do not look same. I have:

a101dc90f8e876f39383b60c9da64ec4  /lib/firmware/ath11k/QCA6390/hw2.0/amss.bin
4c0781f659d2b7d6bef10a2e3d457728  /lib/firmware/ath11k/QCA6390/hw2.0/board-2.bin
d4c912a3501a3694a3f460d13de06d28  /lib/firmware/ath11k/QCA6390/hw2.0/m3.bin

Download them like this:

wget https://github.com/kvalo/ath11k-firmware/raw/master/QCA6390/hw2.0/1.0.1/WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1/amss.bin

wget https://github.com/kvalo/ath11k-firmware/raw/master/QCA6390/hw2.0/1.0.1/WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1/m3.bin

wget https://github.com/kvalo/ath11k-firmware/raw/master/QCA6390/hw2.0/board-2.bin

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
