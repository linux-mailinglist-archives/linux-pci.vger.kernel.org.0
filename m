Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435D51EDB78
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 04:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgFDC5i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 22:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgFDC5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 22:57:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB9C03E96D;
        Wed,  3 Jun 2020 19:57:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ce8so3420701edb.8;
        Wed, 03 Jun 2020 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xh7btXBNMEYUZq0LZjljkkYADCcryAmArXqL32iifI0=;
        b=FcD1vFhLChf77HXzWJ4t/9ekQz0DXQqA8VSMkM5Jdws1lSqWaS/dUvTrEqZWKiSQWT
         aLVVkzAiv6ySw2r0AVfidd9VT55sQDb/T18QRUOomJnucuFymwwAFLbVkXN3LRTGb32G
         QBzUrS9LqsJv78rkT0VaHOZfTsdppu8Xug+rfpR0eO1lGvpb0ZK7tqOVmrmZoTao5rme
         N5kW1IN+qIksTGf5N+H56U0y7M3EjvHiizQxyjk63QCkZZxbnA4NaJJRXjF185PtzFlw
         vmN7KFrdKfKtVt+0grkvdOHLqcHtdQrbWSgrRgItP3mu2GuoWWZ4pg4IGj4z14IzDMhR
         oZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xh7btXBNMEYUZq0LZjljkkYADCcryAmArXqL32iifI0=;
        b=nUKhvqxqDPJrWZhG8evzerL2S827q5jZj635o+N3qfURfe24IfDX1BnUvAKXu8BQgk
         YOSzNp3JyX4HhrS0+AyIf4Ot0HyJ63raq46OJWP2qGxttjfhjDYlqOi/2dEZK02UjkR6
         8szwW65DxO73OQX0YKaIdYcXgXqvpSx1RNPbmafDSAW1nEZzwkwwVHg4P51mqbgf3bre
         jukHXHhvyEmgyTKj58m5WjJA+VbXFb55ZoCWtHH35uZL7Uzfmou5eB4m00z5a81YgOJv
         4GYqhgT3N+y84l+G1TKHKfJkLueCxPoDkmtrpQ8O+CgG5BTUv/wrbn8PtA1YRcy7ML+l
         uLsw==
X-Gm-Message-State: AOAM530NOZFpPe9EQV5UJoKjcuuO67JFLf34xo7ktmsLncByoNR8FRmT
        wl8/DrjtF6N9R29GBNvsAiJhAi3B
X-Google-Smtp-Source: ABdhPJz93uAL6tcuQXE2UNXeoTpLyVZC9g3cixCoeqjvZQuJY0pGnc3zKMSla4w2+Ge2+QuUtidMGA==
X-Received: by 2002:a50:8467:: with SMTP id 94mr2255361edp.249.1591239455567;
        Wed, 03 Jun 2020 19:57:35 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id fw16sm862160ejb.55.2020.06.03.19.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 19:57:34 -0700 (PDT)
Subject: Re: [PATCH v3 02/13] ata: ahci_brcm: Fix use of BCM7216 reset
 controller
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200603192058.35296-1-james.quinlan@broadcom.com>
 <20200603192058.35296-3-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <90c04979-5510-ee9e-2edf-aa45119f1a92@gmail.com>
Date:   Wed, 3 Jun 2020 19:57:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603192058.35296-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/3/2020 12:20 PM, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> A reset controller "rescal" is shared between the AHCI driver and the PCIe
> driver for the BrcmSTB 7216 chip.  The code is modified to allow this
> sharing and to deassert() properly.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> 
> Fixes: 272ecd60a636 ("ata: ahci_brcm: BCM7216 reset is self de-asserting")
> Fixes: c345ec6a50e9 ("ata: ahci_brcm: Support BCM7216 reset controller
> name")
> ---

[snip]

> @@ -479,10 +478,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> -	if (priv->version == BRCM_SATA_BCM7216)
> -		ret = reset_control_reset(priv->rcdev);
> -	else
> -		ret = reset_control_deassert(priv->rcdev);
> +	ret = reset_control_deassert(priv->rcdev);
>  	if (ret)
>  		return ret;

Do we need a similar change for brcm_ahci_resume()?
-- 
Florian
