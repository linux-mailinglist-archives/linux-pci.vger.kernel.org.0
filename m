Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73092E22E4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 01:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgLXAGE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Dec 2020 19:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgLXAGE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Dec 2020 19:06:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D33FC06179C;
        Wed, 23 Dec 2020 16:05:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z12so236052pjn.1;
        Wed, 23 Dec 2020 16:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RhZlddu07uH3DLklMw0cBddTSdM+bobz0Y1cqIi2B9g=;
        b=BoLGCo1YoGlKEnaXPlQNCxQ/u0PB0gs67txWhm79Ddo51R2SS02sccAA7P/B5JnW2N
         6M58LLKJHBColG9D8zykXo4z2CIvap1umNT8bnLu8PS4NnfLGJajS7pOZ3xWEU1BcJxg
         C2CEdIjHg7o0BBxIfK8uxnA4xTQIZzty/G5nWnE7x9l6qLuGMlgINt7G488Qs1ZUyxn1
         UBv7BfsqCBAQR48tyX0Q/lUa4oM6OSq9FMQl9PPHVAkpu0gHpUkxxaSBe0YKxD3RKQdD
         P7HruDmRLAqHqWjHrS70Wtbx4we45d6A0hH2mkpWeK4FxomAyKD9raDUvF3oS3W7q6jG
         RrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RhZlddu07uH3DLklMw0cBddTSdM+bobz0Y1cqIi2B9g=;
        b=QE+1fr6UR9b79/o8n/cSYk+jZfWVCYlXjvz7K4JR2OzNvXmhabGJOhdTN+HjmWqEPw
         ESSy96CPT8i/bPPWHnhSqfi6SELcKHM8af76oh9IaQ6KMpmTcmPfK7VjifTjsWSwzOk/
         drq23Tp65bxhtaNJh7kTNjNHoNSIWF+yiXC8HWnkZ5yYKDfKlwWmtyM8OoFYDYZZ0rzI
         iG6PdpV75Rb0dws/OAeg1KNiqrArRCl7VnnB7CAK6krEOG1xHnR4o53rIB4yVcEa7WFx
         Aqpgo7EmdZPb05KDX8TcAMIy5gLlAofKz2UTfJObzDXp47GQa6BtnSX/6YcFxByiKFAZ
         s+5A==
X-Gm-Message-State: AOAM531F711AD3l1lK7Z7MhJ42RxaXgmJB+jweGEo7y4KLQZEb3utq6v
        BTLULE+4DB72t04oo6c4aL8=
X-Google-Smtp-Source: ABdhPJxujcHk5jTktWJsfdUCcIHT46rpxPni05SSBnh/KI9n6TsNOAdATpq3I6FAPpO4G3brj+JxoA==
X-Received: by 2002:a17:90a:4689:: with SMTP id z9mr1826941pjf.87.1608768323630;
        Wed, 23 Dec 2020 16:05:23 -0800 (PST)
Received: from [10.230.29.27] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f126sm24006772pfa.58.2020.12.23.16.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 16:05:22 -0800 (PST)
Subject: Re: [RESEND PATCH v3 0/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
To:     Jim Quinlan <jim2101024@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20201216214106.32851-1-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <92084293-d2fd-1663-0f6a-a10f01e23066@gmail.com>
Date:   Wed, 23 Dec 2020 16:05:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201216214106.32851-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/16/2020 1:41 PM, Jim Quinlan wrote:
> v3 -- discard commit from v2; instead rely on the new function
>       reset_control_rearm provided in a recent commit [1] applied
>       to reset/next.
>    -- New commit to correct pcie-brcmstb.c usage of a reset controller
>       to use reset/rearm verses deassert/assert.
> 
> v2 -- refactor rescal-reset driver to implement assert/deassert rather than
>       reset because the reset call only fires once per lifetime and we need
>       to reset after every resume from S2 or S3.
>    -- Split the use of "ahci" and "rescal" controllers in separate fields
>       to keep things simple.
> 
> v1 -- original
> 
> 
> [1] Applied commit "reset: make shared pulsed reset controls re-triggerable"
>     found at git://git.pengutronix.de/git/pza/linux.git
>     branch reset/shared-retrigger

The changes in that branch above have now landed in Linus' tree with:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=557acb3d2cd9c82de19f944f6cc967a347735385

It would be good if we could get both patches applied via the same tree
or within the same cycle to avoid having either PCIe or SATA broken on
these platforms.

Thanks!
-- 
Florian
