Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF593557B2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345634AbhDFP0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 11:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345629AbhDFP0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 11:26:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C241C061756
        for <linux-pci@vger.kernel.org>; Tue,  6 Apr 2021 08:26:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v10so10663631pfn.5
        for <linux-pci@vger.kernel.org>; Tue, 06 Apr 2021 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JRIM6EM2YeerZ4khZjy1QfwvvKqUIOIDPq45/l8KzMk=;
        b=v95OkLHG9mdrpAnJFrYxrccr8IjScxsPF2QZvigNmyiWn/K38wXNOkg8SWiIEUmNzw
         DhgRZWcYj41kW5dgRpdynsWCVpxNUEP6YIe7bLnwtE7zfSmxpoexrJj6I0G84aUi55C2
         bypnk5TkSo7tPh0ULV+bo2+im9F8HFeFuBCmTSnJ7Oy96uXvUayy3NqoSuH8tP9GF9Ne
         ejts0iEbBIRoa8tL5OpS5bsI1mKPy7VgnEJYym7TVzHqODG2BYcwOWOaWbKrzm73ndsg
         mY9VkLsDLGjZ7TV19BVIuLd2lJM/hin4zvLExBEYQT+P9XzotHuhh81V2UQNk1FasNmA
         uOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRIM6EM2YeerZ4khZjy1QfwvvKqUIOIDPq45/l8KzMk=;
        b=cYgFp0q3EEFYYfEydV8lVVfAr9o9ZKxxrsXMhx5+81TeCjUqR1EaUwH/Fv8YIRvqrK
         +IkaGpPZuHqxTc7AoDvxB4xGYppydiaqwhcXw9NvSlqBjgAeyngP+Usa9KRAYmOXzvl7
         mhmCkxcNh3HUjn04C4DMBBTc9GOo6nrRIzFD5i5llixVAkXpnt6aOEYFBxOPNBEPT7vm
         SbUXq5I0JooG6qu72jZ1ABpcO2/ocz+ao9K2aT6/FjORGy+anTSSWbyR1AxWkKcyMino
         X2aVYSbEpPKxHJ6YHEUhLWh9YY+PDh2qSdk/oW8HEmZuhjrruzZwN+tusd7BmXR9ezZj
         EEow==
X-Gm-Message-State: AOAM531MV+US5t6BmOszAIYzItU6lkaSMcdJiws0/T+ADgMlxT2vrxnA
        VtkDcRnl0nqB2BzxfhRMEbdF8w==
X-Google-Smtp-Source: ABdhPJwGk+B+hP8sPCLiqu3rd1u+Xa6OMw8qJOFaJ7FpQ87gs+NV+ZduAerbhnmSJtGUQamY0Luj1A==
X-Received: by 2002:a65:5289:: with SMTP id y9mr27154939pgp.447.1617722776213;
        Tue, 06 Apr 2021 08:26:16 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id c2sm19223740pfb.121.2021.04.06.08.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:26:15 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210312204556.5387-1-jim2101024@gmail.com>
 <20210312204556.5387-2-jim2101024@gmail.com>
 <20210406151604.GA25862@lpieralisi>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c72423a-f743-6feb-8387-3651a1c59d42@kernel.dk>
Date:   Tue, 6 Apr 2021 09:26:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406151604.GA25862@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/6/21 9:16 AM, Lorenzo Pieralisi wrote:
> On Fri, Mar 12, 2021 at 03:45:54PM -0500, Jim Quinlan wrote:
>> This driver may use one of two resets controllers.  Keep them in separate
>> variables to keep things simple.  The reset controller "rescal" is shared
>> between the AHCI driver and the PCIe driver for the BrcmSTB 7216 chip.  Use
>> devm_reset_control_get_optional_shared() to handle this sharing.
>>
>> Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
>> Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/ata/ahci_brcm.c | 46 ++++++++++++++++++++---------------------
>>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> Hi Jens,
> 
> I am happy to take this series via the PCI tree but I'd need your
> ACK on this patch, please let me know if you are OK with it.

That'd be fine:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

