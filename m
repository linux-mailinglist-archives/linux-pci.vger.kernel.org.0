Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485E922D664
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 11:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYJSj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Jul 2020 05:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGYJSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jul 2020 05:18:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999A2C0619D3;
        Sat, 25 Jul 2020 02:18:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so12330282ljp.6;
        Sat, 25 Jul 2020 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tt4lBP8eHDcChTcrk6HpzOZG+ZscpSQCi8G310B6EEA=;
        b=SsJ6neoxYIFGtlNWPoyAvoOlaM8lvGNtgbgtaZD/UQltNSFJfBPBIHqsdRF88KKdtJ
         f3DUCdYuHgDEeMOBtFqaW0rDKpLRPV+MUaOuUxKpI67PAAuDGnJlQfD8EQUuX6Xb/tb2
         oVop7ZBCmena9OX27q+XdEBlPk8mAwa0BH7t+r4uevtYzT8zMRKqwU2rcL3RfA0YkSSo
         VYtiZLFshXQWUzuoxFGrAYKtf8/XPYr6nGuylX5b6iL5k23tefbaG/b4D/feMoTu6Ujv
         yYHOrrEaUqi1Gne4Zhv7VWyfcSqwJxriBgozPG7cnrzZYp2Qn/YUfN1UOswhR3w+bw4Y
         A0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Tt4lBP8eHDcChTcrk6HpzOZG+ZscpSQCi8G310B6EEA=;
        b=mba8pNNbfBi/7CzBLGy22BtHEWliQy/fViriza95n5XX+7Fa9cqHozhkpuIULcbUlb
         vIvRnajKeaGp047boIrbwVNNeqCDKnYiRomRi7AiB9BtG/xCcWcLOnqTtt/lr3c5qUqi
         U8jxyZZbpziTBxWCEXXCIIEsRE4ySHe9qPFk0iSYJYffpzTs3qSFtKxhzosEIoHPF7kF
         hmEkGX1l3fFqw24YTphS98JYSdm7zA0jrzUrvZwDiSuYx4++dwQc9qAXCzyubEBxUwiP
         H1VtaKtNZNxQ6NsjzMlE1RBjEtX3PJ6BkktrHs7Ew3TBqDFGd/MtCfBuZWOFOkMoZRnF
         gw5g==
X-Gm-Message-State: AOAM5330+pUeq/n+MxTgM8upKaQ/keX0sP8I7mOoxAmdgrxElA9M70e+
        PLbMSXZ/oPAQ1Kl/5nPKwCisnIuUGYw=
X-Google-Smtp-Source: ABdhPJzHxnxj5UPJ9LFQGOyklSNEPZ4gVbk/cPhkmFeEURr4kF3VAybMQ8Q1RkYu0E3EgNGoJmZ87w==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr963221lji.292.1595668716933;
        Sat, 25 Jul 2020 02:18:36 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:253:4416:cc94:657b:2972:b01d? ([2a00:1fa0:253:4416:cc94:657b:2972:b01d])
        by smtp.gmail.com with ESMTPSA id e22sm876553ljb.12.2020.07.25.02.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 02:18:36 -0700 (PDT)
Subject: Re: [PATCH v9 02/12] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200724203407.16972-1-james.quinlan@broadcom.com>
 <20200724203407.16972-3-james.quinlan@broadcom.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <4950d265-5aea-8d0b-7984-553e53f421f6@gmail.com>
Date:   Sat, 25 Jul 2020 12:18:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724203407.16972-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 24.07.2020 23:33, Jim Quinlan wrote:

> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> A reset controller "rescal" is shared between the AHCI driver and the PCIe
> driver for the BrcmSTB 7216 chip.  Use
> devm_reset_control_get_optional_shared() to handle this sharing.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> 

    Shouldn't break up the tag area with the empty lines.

> Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller name")
[...]

MBR, Sergei
