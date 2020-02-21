Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED0168592
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgBURuv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 12:50:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37807 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgBURuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2020 12:50:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so1609177pfn.4;
        Fri, 21 Feb 2020 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XItSRW7WA1+G48/zW+lo5mgJjBabFFXGFt1P0onf3ns=;
        b=ZUROM7eQP19ysqSz9mbaQBoBaK4zmF6QmjOa8srB59G2D6hwHNj8v3GLuRmgqugyJ4
         aTFzXTu6M11rZd9tMFJ2416HPBIn7HEVzqEYvXwEM5xS9m12tTEs3DVkRHFquphb4DXO
         Cw7tauy0EvrNxhUGUaWNPRDLoiOtoGEVwtuDb5XotgV3aWsx0o8vmiWEVlDt1H2DEm6v
         5XVsjd1/ae+7QEVT/4cvTSagv4WxM3PUV3bIpq/H5XzlguMGRD+5wekWiaXn0fCdtyfI
         oUIDDuKvKqIah3V5H4InY6Uk+Qw/7kw/1rmW4vILAC+04Pc5w0noY7z1z8Lyh2kYullK
         wzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XItSRW7WA1+G48/zW+lo5mgJjBabFFXGFt1P0onf3ns=;
        b=cWaghgdp7vqxp5TF71WPMiRUzxuNlhOGvMINu9idqkt0537/q1rc4fRVRkqfTUCHWm
         i1dpg3RTT6JKIYXDdJ5vtNsQWUQSU+o2zOyXd4Cvpdi6D/y3lj3K4oKmds7jRgXPIciM
         KqMNlpJySI8R++p5fhn1zGsS7QcXo9ObOx3H1S36E11l/YhGoT23Tfa9YlMw/8k+v02T
         hZKRXcWhA+pxJJU0v1pdVaXlp5sbpdlev9aW8+PYCT/oJzQ90dUfG/D/3bLk3VxgPkHW
         oUeossAYvKX63LqR2cLnPh6TtaPL/4MdtlZNy8Mnm8bOGzGrQn2bw9JOrTpewGf+XAz3
         35lw==
X-Gm-Message-State: APjAAAXv6Yl8912zY6KHLTaxYSnJLC5rl6SwGnFiuYFeQNmDaWPkGEzM
        0MnXVoiQHWHKqXKBn7GTbCM=
X-Google-Smtp-Source: APXvYqwE0a3+jpVNEFF88xJhTVjxIBm3TWf3xePQkST8/2iZlbj6HyGHPPEkDQ/F+cvufzgqHbdxVw==
X-Received: by 2002:aa7:9d87:: with SMTP id f7mr38339095pfq.138.1582307449719;
        Fri, 21 Feb 2020 09:50:49 -0800 (PST)
Received: from [10.67.49.61] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u26sm2789114pfn.60.2020.02.21.09.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:50:48 -0800 (PST)
Subject: Re: [PATCH v2 1/2] PCI: brcmstb: Add regulator support
To:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Jim Quinlan <james.quinlan@Broadcom.com>
References: <20200221033640.55163-1-jaedon.shin@gmail.com>
 <20200221033640.55163-2-jaedon.shin@gmail.com>
 <20200221121231.GA5546@sirena.org.uk>
 <40c4de9c-efdc-4fae-ad6d-1ba51fbbece1@gmail.com>
 <20200221171127.GH5546@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <aff7e72b-c6d3-9d66-2726-1014a040b601@gmail.com>
Date:   Fri, 21 Feb 2020 09:50:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221171127.GH5546@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2/21/20 9:11 AM, Mark Brown wrote:
> On Fri, Feb 21, 2020 at 08:33:36AM -0800, Florian Fainelli wrote:
>> On 2/21/2020 4:12 AM, Mark Brown wrote:
> 
>>> No, this isn't a good idea - the set of supplies the device has is
>>> fixed when the silicon is produced, it's not something that needs to
>>> vary per board.  This means that the binding should have a fixed list of
>>> supplies, per SoC if that's needed.
> 
>> These are not the supplies for the PCIe I/Os on the SoCs side, but the
>> supplies for the PCIe end-point connected to the SoCs. More on that below.
> 
> Then the "slots" (obviously at least some of these are soldered down
> rather than on actual slots) should be represented in DT and the
> controller or bus should know that it needs to iterate over them to
> bring up the chips.  I would also expect that there are standard names
> in the PCI specs for the standard supplies that go into devices as part
> of the bus spec which would mean that there should still be no need to
> encode names like this.

Agree.

> 
>> If you describe the regulators as properties of the PCIe EP nodes which
>> are child nodes of the PCIe RC node (as we should), you will not be able
>> to manage all of them within your pci_driver instance, because if there
>> is no power to the EP you just do not enumerate it, therefore no
>> pci_device is created.
> 
> The framework and/or driver can enumerate firmware information without
> actually powering up the devices of course.

The issue is not enumeration, it is ensuring that you will be able to
establish the PCIe link with the EP. If there is no pci_device created
because the bus scanning returned a link down, there is not much that
can be done. Also the question is whether this logic belongs in the PCI
bus layer or the driver.

> 
> I would not be surprised to learn that most systems just mark the device
> supplies always on, it's not like the devices will be able to use them
> normally anyway.

In the downstream PCIe driver which is this one is just a subset of
until we close the gap, we have some additional logical to determine
whether the EP device is wakeup enabled in order to leave its regulators
turned on during system sleep so as to permit Wake-on-WLAN for instance.
-- 
Florian
