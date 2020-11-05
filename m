Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C032A7F9C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 14:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgKENXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 08:23:36 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:10853 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbgKENXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 08:23:23 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604582603; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=7EmMPNEDAzLO7WSfl6ZOrdJd05moQ6wsVSmuVmFlWCc=; b=eLACYamKBSIs+55JDUYCr2q/R+YyeE4cm/xFEjfSxqzCB62+609chWzgr7DkF/Yl2o4jiqqr
 KFfAnb6krHqQfv7GM+SOjAqlZWEnKZr8vigiXTDvQUThAA6hhTy1PHCeaCZ/hkhXQpmrb9Yf
 7GoOEcR4NugAJYUKgPe3q226CeQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fa3fcbd3d1b348506d50b70 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 13:23:09
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6B84BC43385; Thu,  5 Nov 2020 13:23:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0CA54C433C6;
        Thu,  5 Nov 2020 13:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CA54C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Thomas Krause <thomaskrause@posteo.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        Devin Bayer <dev@doubly.so>, ath11k@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
References: <20201103160838.GA246433@bjorn-Precision-5520>
        <874km61732.fsf@nanos.tec.linutronix.de>
        <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
        <87mtzxkus5.fsf@nanos.tec.linutronix.de>
Date:   Thu, 05 Nov 2020 15:23:03 +0200
In-Reply-To: <87mtzxkus5.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Wed, 04 Nov 2020 16:26:34 +0100")
Message-ID: <87wnz0hr9k.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, Nov 04 2020 at 14:04, Thomas Krause wrote:
>> config) but CONFIG_INTEL_IOMMU_DEFAULT_ON needed to be set manually. I 
>> hope this helps, if there is more I can do to debug it on my side I'm 
>> happy to do so.
>
>> [    0.050130] DMAR: [Firmware Bug]: Your BIOS is broken; DMAR reported at address 0!
>>                BIOS vendor: Dell Inc.; Ver: 1.1.1; Product Version:
>
>> [    0.103693] DMAR: Host address width 39
>> [    0.103693] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
>> [    0.103697] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 69e2ff0505e
>> [    0.103698] DMAR: DRHD base: 0x000000fed84000 flags: 0x0
>> [    0.103701] DMAR: dmar1: reg_base_addr fed84000 ver 1:0 cap d2008c40660462 ecap f050da
>> [    0.103702] DMAR: DRHD base: 0x000000fed86000 flags: 0x0
>> [    0.103706] DMAR: dmar2: reg_base_addr fed86000 ver 1:0 cap d2008c40660462 ecap f050da
>> [    0.103707] DMAR: DRHD base: 0x00000000000000 flags: 0x1
>> [    0.103707] DMAR: Parse DMAR table failure.
>
> which disables interrupt remapping and therefore the driver gets only
> one MSI which makes it unhappy.
>
> Not that I'm surprised, it's Dell.... Can you check whether they have a
> BIOS update for that box?

I was told that on Dell XPS 15 (with a working QCA6390 setup) there's a
separate "Virtualisation" setting in BIOS. See if you have that and try
enabling it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
