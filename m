Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C713B1C5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 19:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgANSPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 13:15:10 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55277 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANSPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 13:15:09 -0500
Received: by mail-pj1-f67.google.com with SMTP id kx11so6045013pjb.4;
        Tue, 14 Jan 2020 10:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zddj/vBs8SHk/P9jRlTfxYFVFUJBwKnsmlB3w97mUhs=;
        b=oZUdrtFqiPq1NFvf9ur/SQpY36VdNst4WeVxa1yGP7NMu8nnvWEmaIjrCN8RQEMsIU
         n2vWzI7OFch3tm9V8McQfh765jr/ddUFeLRKjemvsG4U9XcgbVb+wuYFv0g2cUj0TKoe
         qh4CahhbXFYZMobT7u1BxDrHGvBkvfzhCemQYLAG6gIXIOutDj+/ChSQNDJTymdNOjE1
         Dc5twPrhXlwitxvPCqIuLAEn33zsfnpu9vq/rPNjJz6RxN84S06Gi7wNQ/Ea43LsF0eW
         23hJYZbIbX9i2yWqaw6fE+rOim1Eq1PlBCJZZXg9fRK2qzMleK+IH71izJatV1JuZB8Y
         uAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Zddj/vBs8SHk/P9jRlTfxYFVFUJBwKnsmlB3w97mUhs=;
        b=k1VaIVUDjSJeE3dQxCUNcc8F1NFAKI5oJ4TQGWfZUsR4PalVT40ytcqeq7YNkfd+GD
         yp5lWjLqvp97h+Bj7zNyIXSm5xzGDV7c6vabFaLJEiVnqY9zlfX5HV90tzJHp30eAVGt
         5+WNjfu5LByiEPs4PHYtiMwq1Raut8zqYgAlIZ9nuWZ1jMqzRSAXM/I8veVJmB3A68eE
         szV/oUAXvFWnMf0wa4j2L8lc4BQEqTvPuTTNkh1bI0hzYpYMvRTlBNVY87WOxWyXCuwr
         kj6dTv9s/+bQIn7p1LZFCE6zfJg3t3IEFW+7cVa4YJBHBOpJKWaBWL3QaQZdz0z7XlBY
         84iA==
X-Gm-Message-State: APjAAAV4xwCJil8p9VaL7MbVqcIZczX7xe//u/32FwNNm50yiD22oTc4
        Rb0vn6sRQ/hK9lNrEfjLnWA=
X-Google-Smtp-Source: APXvYqz4I9vWvZgp+ei1k5O0CSsxl4FHpcMqm/JDrkJYsEi11kLymg9fPWJ6vAAvRLIPt8BJCTn0WQ==
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr12883220pju.46.1579025708556;
        Tue, 14 Jan 2020 10:15:08 -0800 (PST)
Received: from [10.67.50.41] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a10sm18357391pgm.81.2020.01.14.10.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 10:15:08 -0800 (PST)
Subject: Re: [PATCH v5 2/6] ARM: dts: bcm2711: Enable PCIe controller
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        olof@lixom.net
Cc:     andrew.murray@arm.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        james.quinlan@broadcom.com, mbrugger@suse.com,
        phil@raspberrypi.org, wahrenst@gmx.net, jeremy.linton@arm.com,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
References: <20191216110113.30436-1-nsaenzjulienne@suse.de>
 <20191216110113.30436-3-nsaenzjulienne@suse.de>
 <20200114181159.GB11177@e121166-lin.cambridge.arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <5eda2060-7a57-1212-2fd5-3d4fb8a81732@gmail.com>
Date:   Tue, 14 Jan 2020 10:15:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114181159.GB11177@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/14/20 10:11 AM, Lorenzo Pieralisi wrote:
> On Mon, Dec 16, 2019 at 12:01:08PM +0100, Nicolas Saenz Julienne wrote:
>> This enables bcm2711's PCIe bus, which is hardwired to a VIA
>> Technologies XHCI USB 3.0 controller.
>>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>
>> ---
>>
>> Changes since v4:
>>   - Rebase commit taking into account genet support series
>>
>> Changes since v3:
>>   - Remove unwarranted comment
>>
>> Changes since v2:
>>   - Remove unused interrupt-map
>>   - correct dma-ranges to it's full size, non power of 2 bus DMA
>>     constraints now supported in linux-next[1]
>>   - add device_type
>>   - rename alias from pcie_0 to pcie0
>>
>> Changes since v1:
>>   - remove linux,pci-domain
>>
>> [1] https://lkml.org/lkml/2019/11/21/235
>>
>>  arch/arm/boot/dts/bcm2711.dtsi | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> Olof as we discussed previously, I will not merge this dts change and
> drop it from the series - Nicolas should redirect it to arm-soc, please
> let me know if my understanding is correct.

Correct, I will take patches 2, 5 and 6 through the Broadcom ARM SoC
pull requests and you will take 1, 3 and 4.
-- 
Florian
