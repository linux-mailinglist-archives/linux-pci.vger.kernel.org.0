Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003352C3027
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404307AbgKXSpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 13:45:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36029 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404231AbgKXSpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 13:45:11 -0500
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1khdJM-0008AX-2l
        for linux-pci@vger.kernel.org; Tue, 24 Nov 2020 18:45:08 +0000
Received: by mail-qk1-f198.google.com with SMTP id d206so17885875qkc.23
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2020 10:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:autocrypt:in-reply-to
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=r/r7ULfVekojLsHfSnb9aS6YtiIa7A47tHqm9zQA1j0=;
        b=clmdY/HOdnlDYjBBrKrI3JshGj6uHd+uKwkdBuXIAaZusFQZcBipl5U5ZEKOHONM5A
         6QKzV1dGkxXQ/Ly5nTprRmVbfH40aq0+fcBFtbbN5Z4A0iJVMT5h9/pk9wedDxyGCB1y
         QnCfhQfEJZFuEI9ZT/6S/7gZxhEEgutMsvffKHIhU2DUcMQ3ys0mApM8IcTR6BjSUt6v
         OHJQZgZwIasu2UeRvyZpVYpH+tFPwBGb2lZv1xVvACZkkckKwJHiGOU0pURWBFCAGu2R
         3J0GzeSssSw+GzcY+t80PPYeOJ1wp6fciiEldMKTfz2vX1DZl420oLMLlcasRuIfxfWz
         ftEg==
X-Gm-Message-State: AOAM531Gs+oNpsm2BjW2XiszNYcomKm9hcfC8GXzU3r2d9h+K1S+3EFJ
        WVYRot1bP38PTUHv65O5S/NSHyD2hXFYZoulF0EXPnY2+G1YH9CnBN0p133Bpx4E74gA0c8zCTr
        XcKSt2ixQBWYdS0sYI5/yld87ypiKDbI8OIHh6w==
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr5764783qta.158.1606243506154;
        Tue, 24 Nov 2020 10:45:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzme549lMfN9A38G6UG77xqRXskQXzbWCOLSaKjdJlep2kO86zF16x9adoSCSLdbEiVbFQoBQ==
X-Received: by 2002:ac8:58d1:: with SMTP id u17mr5764752qta.158.1606243505869;
        Tue, 24 Nov 2020 10:45:05 -0800 (PST)
Received: from [192.168.1.75] (200-158-226-203.dsl.telesp.net.br. [200.158.226.203])
        by smtp.gmail.com with ESMTPSA id h8sm9263078qka.117.2020.11.24.10.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 10:45:05 -0800 (PST)
To:     sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, ashok.raj@intel.com,
        knsathya@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Sinan Kaya <okaya@kernel.org>, haifeng.zhao@intel.com,
        chris.newcomer@canonical.com, gpiccoli@canonical.com
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: [PATCH v7 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 xsBNBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAHNLUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPsLAdwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltvezsBNBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAHCwF8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
In-Reply-To: 
Message-ID: <6349d22f-cf49-bab4-ad0f-a928e65622af@canonical.com>
Date:   Tue, 24 Nov 2020 15:45:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kuppuswamy Sathyanarayanan (and all involved here), thanks for the
patch! I'd like to ask what is the status of this patchset - I just
"parachuted" in the issue, and by tracking the linux-pci ML, I found
this V7 (and all previous versions since V2). Also, noticed that Jay's
email might have gotten lost in translation (he's not CCed in latest
versions of the patchset).

I was able to find even another interesting thread that might be
related, Ethan's patchset. So, if any of the developers can clarify the
current status of this patchset or if the functionality hereby proposed
ended-up being implemented in another patch, I appreciate a lot.

Thanks in advance! Below, some references to lore archives.
Cheers,


Guilherme


References:

This V7 link:
https://lore.kernel.org/linux-pci/546d346644654915877365b19ea534378db0894d.1602788209.git.sathyanarayanan.kuppuswamy@linux.intel.com/

V6:
https://lore.kernel.org/linux-pci/546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com/#t

V5:
https://lore.kernel.org/linux-pci/162495c76c391de6e021919e2b69c5cd2dbbc22a.1602632140.git.sathyanarayanan.kuppuswamy@linux.intel.com/

V4:
https://lore.kernel.org/linux-pci/5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com/

V3:
https://lore.kernel.org/linux-pci/cbba08a5e9ca62778c8937f44eda2192a2045da7.1595617529.git.sathyanarayanan.kuppuswamy@linux.intel.com/

V2:
https://lore.kernel.org/linux-pci/ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com/#t

Ethan's related(?) patchset, V8 :
https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/#t

