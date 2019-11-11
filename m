Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88CBF78FA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKQk0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 11:40:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33197 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfKKQkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 11:40:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id a24so8751633edt.0;
        Mon, 11 Nov 2019 08:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YqBIjSX9iDBWRIFU2+z8TXVFC+rFlw2hQ7VKD8Z/ue8=;
        b=aA+O+Yx/rzAXIWBfmd8wFAIOe8iGNf5OQMC5HGy/v+LZYfDbHGwC201BVuxlI2QHXa
         kIom7CkFj3mY/35L1XLq7zUv45OZ/bCEmi+ikNc2KB1l2wcEkN0Ym/674dN9G2Om/7aT
         Wdo8gpEpEp4FKuJkW6mdiVsqpDvBEQPQoUM+fcmQtvYlixq//4WxLXJYL4Vv6Yp1Ta02
         tqJX0gJqO+b3ATX678X2Uie1IKty3WHOzU/KI4RbqYpYBb/RatcKbvtWHk2m4U3fIUjE
         Giuk1KWH5GzVP2wKAYdynjUTiQgZ9QabuLOzsREmieNW34FjmqnmtaYIvO8fydIwSsOG
         h3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YqBIjSX9iDBWRIFU2+z8TXVFC+rFlw2hQ7VKD8Z/ue8=;
        b=d9OPBGVFWXoK5BjCJ5gvQV8/dnFgocW3yiZR++JMwxtob49Dlbfs+ZP0sF4LqF7XjN
         gQrq43blfedEwyZzNDPOgiyfMEZiC4/8iJdGTsucdLc5poTYSGk5LNcCapQsYbRleG5m
         G0NzKnTE7zAm8phhmHFlv5WOroa+mpCbZd8efPf8VYxxEUHAZpAW4AGZXfdx07x0Mepv
         B2M0RXcJUY/lwF45IoqOrs0tGcGzoAklc/uhJ0YXIvp41VJz6tB0w4X+Ylmr8nBCcqP2
         CBpPEi8W6M+x+7FVI9IUfIyU1GUfjQq8GzWt4nMB1vOJhqAGOYX8vGX+j6Gpvox/Swub
         s1ug==
X-Gm-Message-State: APjAAAVTeTngdHbX5uCCuTonCPnz+ipErqgYwdrrLQ/nlkG8eeEzMDSl
        U8nzuxrfJ3KvtoH1pzoIjWSb2dqf
X-Google-Smtp-Source: APXvYqzHY58qvb4XP/RSZQPSq/BQt3FP+8WEE0nggLYS+wifIsfX8CSdINkgk/QcHMBeEE5klzZAbQ==
X-Received: by 2002:a50:9555:: with SMTP id v21mr27838445eda.90.1573490422887;
        Mon, 11 Nov 2019 08:40:22 -0800 (PST)
Received: from [10.67.50.53] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id j19sm150565ejs.88.2019.11.11.08.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 08:40:22 -0800 (PST)
Subject: Re: [PATCH 3/4] PCI: brcmstb: add Broadcom STB PCIe host controller
 driver
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        phil@raspberrypi.org, wahrenst@gmx.net,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
 <20191106214527.18736-4-nsaenzjulienne@suse.de>
 <7d1d2257-f36b-c55f-17a8-1c5579d8f707@arm.com>
 <94213d9b5fa2b4916bcada49ff938e394f0c859e.camel@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <47a9aa83-c385-821e-170a-061afd2bdc9a@gmail.com>
Date:   Mon, 11 Nov 2019 08:40:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <94213d9b5fa2b4916bcada49ff938e394f0c859e.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/11/19 7:29 AM, Nicolas Saenz Julienne wrote:
> Hi Jeremy,
> thanks for the review.
> 
> On Mon, 2019-11-11 at 01:10 -0600, Jeremy Linton wrote:

[snip]

>>> +static const int pcie_offset_bcm2711[] = {
>>> +	[RGR1_SW_INIT_1] = 0x9210,
>>> +	[EXT_CFG_INDEX]  = 0x9000,
>>> +	[EXT_CFG_DATA]   = 0x8000,
>>> +};
>>
>> Given that there is currently only a single set of register offsets, 
>> this seems like it could be simpler.
> 
> You're right, there is no need for it as of this series. But since we know
> we'll be supporting other SoCs in the near future I figured it was harmless to
> leave this as a dt dependent config.

I would rather leave it as is right now because while possibly
inefficient, adding a later series whose purpose is to add register
indirection would just clutter the review process IMHO, the way it is
right now does not hurt.

(please trim your replies to remove what you are not responding to).
-- 
Florian
