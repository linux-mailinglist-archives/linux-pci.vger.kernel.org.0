Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5D01094E7
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 22:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfKYVD0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 16:03:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36279 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfKYVD0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 16:03:26 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so14535314oib.3;
        Mon, 25 Nov 2019 13:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OKrMiztgq6n+4o04Pu0o49C5Fq/AysnEyKzVyb5lLq0=;
        b=UIw4yyh7qFDT5JrbfzE9+B2sRCFPyZO+piBRAfV7WATnqYpS2gy4hjQrxnFSTu9rrx
         JrRi4CUXU3qtXfeza/lEdtmZ3plNhV6faq4CxWqNpChoAGOoQhYc7zKfjt9nJWw0Lql8
         qqrUEhUD8jHIBB7vPB6fIPrcA72eaqDGuaT5HVFL7Hq6f5ycNn/f5d2/BsmyQVfaErnu
         T5OutfcI8SaZHlh6OC1NZ2/MOhr3ZciEjH1w0GN+wDFdFeJWNdtlnvQWCfzAjguRDACa
         ljO6KbVlmEvkQv0mkSYxU9hpDh3UJvCIg5q9D6IOqtfOqOBRf2xteGFvZiEps8wSSKId
         VDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OKrMiztgq6n+4o04Pu0o49C5Fq/AysnEyKzVyb5lLq0=;
        b=gLaZSvnGl9OWVLKtRLEKH4D8TrMFOcoivwOHlQ178OS2LlW4lfaFfi6Q+x3gyDeAwP
         +Fq4EL5jQIvqgqn+IaxM2NQGzMBBcglzErE2VD2cT2W75e4zLgFgYgkcW0ffT6E/kR0/
         Nkdq/IZ7k54ei/Xo2rq9B4uSmdyNmMfnAyfqjVWqOrnTOSGxtLDYsfWynjJQLY0hEMgc
         Xl6GGzMeOs2S0caF8jW1QIA/v5lcWy0D+/M2srkaPwi/vI8auBeKjvBqOsgnulFkXBpC
         Kuc96EekUMybombv1ErUUBSTNAb6pIWloR6RQbKEdTapFdqTo5kHxXao12m/rUynpPjP
         K0eA==
X-Gm-Message-State: APjAAAXzU0NUpcJLog0L62F9i+T1qbk5G5mGsx5u+r/7RAUWHFoVP3y0
        N9VhXA6O+y4KQmkDbIsQmBY=
X-Google-Smtp-Source: APXvYqze3Poy3kLoJa0rRu9uvBn9TVbfFGoKcXl7Nh53myivr11uSmd0qMygwUSk6NYzYZPbJmJKjA==
X-Received: by 2002:aca:f083:: with SMTP id o125mr683892oih.122.1574715805287;
        Mon, 25 Nov 2019 13:03:25 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id m134sm2924071oig.20.2019.11.25.13.03.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 13:03:24 -0800 (PST)
Subject: Re: [PATCH] PCI: pciehp: Make sure pciehp_isr clears interrupt events
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
References: <20191112215938.1145-1-stuart.w.hayes@gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <a7ac93e3-9a1f-2cd5-bf0b-30b562bd707d@gmail.com>
Date:   Mon, 25 Nov 2019 15:03:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191112215938.1145-1-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/12/19 3:59 PM, Stuart Hayes wrote:
> The pciehp interrupt handler pciehp_isr() will read the slot status
> register and then write back to it to clear just the bits that caused the
> interrupt. If a different interrupt event bit gets set between the read and
> the write, pciehp_isr() will exit without having cleared all of the
> interrupt event bits, so we will never get another hotplug interrupt from
> that device.
> 
> That is expected behavior according to the PCI Express spec (v.5.0, section
> 6.7.3.4, "Software Notification of Hot-Plug Events").
> 
> Because the "presence detect changed" and "data link layer state changed"
> event bits are both getting set at nearly the same time when a device is
> added or removed, this is more likely to happen than it might seem. The
> issue can be reproduced rather easily by connecting and disconnecting an
> NVMe device on at least one system model.
> 
> This patch fixes the issue by modifying pciehp_isr() to loop back and
> re-read the slot status register immediately after writing to it, until
> it sees that all of the event status bits have been cleared.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>

Bjorn,

Do you have any comments or issues with this patch set?  Anything I can do?

Thanks!
Stuart
