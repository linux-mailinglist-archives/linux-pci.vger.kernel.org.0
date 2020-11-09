Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF43F2AC41F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 19:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgKISsh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 13:48:37 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:34959 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730331AbgKISsg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 13:48:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604947716; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=58Mu0ASC/w5nguEqxIJa+k/Ebz+3T6IKxwh6iickRNk=; b=rDi52KWq4A43QgntTYUJaOzYWLLPrEflCAA5OOA5s9igbYrWcttAiJ/VJDd5Vs5IrybNIhL4
 B+gR5Lq5FR87nG9ysiuZ7d0khj0bQ5+bOe3MZSjaOhJzqY67H2cBAIiOWDCzy2YYp/WHuGZV
 Y68jvTu8LA+nba4W2XwC0mvwDNo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fa98f030fe4be3f433f1183 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 18:48:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E8797C433AF; Mon,  9 Nov 2020 18:48:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE83AC43382;
        Mon,  9 Nov 2020 18:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE83AC43382
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Krause <thomaskrause@posteo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
References: <20201103160838.GA246433@bjorn-Precision-5520>
Date:   Mon, 09 Nov 2020 20:48:28 +0200
In-Reply-To: <20201103160838.GA246433@bjorn-Precision-5520> (Bjorn Helgaas's
        message of "Tue, 3 Nov 2020 10:08:38 -0600")
Message-ID: <87wnyue58j.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

>> > Tangent: have you considered getting this list archived on
>> > https://lore.kernel.org/lists.html?
>> 
>> Good point, actually I have not. I'll add both ath10k and ath11k lists
>> to lore. It's even more important now that lists.infradead.org had a
>> hard drive crash and lost years of archives.
>
> Or you could just add linux-wireless, e.g.,
>
>   L:      ath11k@lists.infradead.org
>   L:      linux-wireless@vger.kernel.org
>
> or even consider moving from ath10k and ath11k to
> linux-wireless@vger.kernel.org.  I think there's some value in
> consolidating low-volume lists.  It looks like ath11k had < 90
> messages for all of October.

The background here is that linux-wireless is quite high volume list and
not everyone have time to follow that, so having specific ath10k and
ath11k lists make it easier for those people. So I'm hesitant to
shutdown driver lists for that reason.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
