Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1480F8235
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 22:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKKV1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 16:27:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37221 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKKV1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 16:27:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id z24so10285015pgu.4;
        Mon, 11 Nov 2019 13:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=asyCBRvRcKbMUSjYGLa6UVcsxuO3UXyeQd3+ufvAjXA=;
        b=WvdL71IzIYytD6CxcaYdxSBdywLZNf/Z1w0TFsbwV6oTkwrW0jkN2kJKQ/ue+hsLDN
         W+NIRFOy4My/I95joUSwgaZKM3A7IcEYgg8ct3tGg1UsCYKd04dVss3wklglSH+DWFDh
         IMZscmYrP122TYd45DSOaqGOxuhtUUF2hFwMp6OQ6XiAnhY2U1hdio1X2Q/0/pYRXAaW
         VEy2GlqWFJEsxu3uQSTFN4Ia0i+mimIA94ylpjuS8lACUPBf3ZhCPjzjig6gux85vYUK
         sO86msE2SgYSiZoEQ25oz0bGb3r1SCvY/klhW2YmmZLCHUSSM8erNJ8q6vOOg63fNXUa
         Ss6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=asyCBRvRcKbMUSjYGLa6UVcsxuO3UXyeQd3+ufvAjXA=;
        b=fQqCu0IsnQXKuY3dYQN5HFxPt854c3DJu5YUmYOzckJ+bOxbEjsg2AyI5h3hgCb8NZ
         hejVRs2ROsA+1QvEvaIAZZNWGGu8vsDUmrNEiOH/mYkSzD+pPeMBa8oWZ5Xj8768RWG8
         LTkF8j5LHzS/D4M6GnSY7iOsiBkYRBMnHkMkUTqcva/uphdoAQIKw2VQeD08WH+TEki6
         9VYygjydgZd6pOXMP4hmFmCDWr6rHmwemT42UVixAfGxa+MzhhE02TMcKGDvChFoMWK6
         vZfNUNSB8KdNO4MRrMd8SdeLd6WeE71b2DPlA/wXnXsYB7wiZUXAhgTEZs4fZzNe4qBR
         P5GA==
X-Gm-Message-State: APjAAAV10ZvrwGJSjiFxVCpOA0FlP+r5p+ivgifKNQ2W4YOB7nUr/x/P
        /gq3Zsz7rE2Ok15+YYLMZowY3ogz
X-Google-Smtp-Source: APXvYqxy8gtKXg94B8G9Mb659vM8oEqP3yxX5ul4Zsgrlmnj6xW9xM//x2+Wb2aTDc32rSscRsi98w==
X-Received: by 2002:a17:90a:3390:: with SMTP id n16mr1452923pjb.53.1573507665752;
        Mon, 11 Nov 2019 13:27:45 -0800 (PST)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id n15sm18395533pfq.146.2019.11.11.13.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:27:44 -0800 (PST)
Subject: Re: [PATCH 3/4] PCI: brcmstb: add Broadcom STB PCIe host controller
 driver
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     james.quinlan@broadcom.com, mbrugger@suse.com,
        phil@raspberrypi.org, wahrenst@gmx.net,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
References: <20191106214527.18736-1-nsaenzjulienne@suse.de>
 <20191106214527.18736-4-nsaenzjulienne@suse.de>
 <7d1d2257-f36b-c55f-17a8-1c5579d8f707@arm.com>
 <94213d9b5fa2b4916bcada49ff938e394f0c859e.camel@suse.de>
 <a5586548-350f-35c2-cee1-eb8c06a7e508@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <ea24cc0e-7577-5ec3-f4fe-ad6cf9f03078@gmail.com>
Date:   Mon, 11 Nov 2019 13:27:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a5586548-350f-35c2-cee1-eb8c06a7e508@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/11/2019 12:00 PM, Jeremy Linton wrote:

[snip]

>>> Presumablly users will want to use PCIe at some point in the future for
>>> booting/etc. That means the firmware will perform sufficient setup that
>>> you shouldn't need much of the code in this function if the address
>>> windows, serdes, etc are functional when linux boots. Similarly for
>>> suspend/resume.
>>
>> I see what you mean, although it's not the case for now as RPi's firmware
>> doesn't initialize anything. Though I can imagine some people might
>> want this
>> if the RPi4 compute module ever comes out.
>>
>> If it's OK with you I think we can let it be for now.
> 
> Well this is actually why I commented on the whole set. A large part of
> this driver appears to be working around the shortcommings in the
> current firmware when it comes to programming the bridge. Once the
> firmware integrates that functionality (there appear to be rpi ports
> underway in uboot/edk2/atf) large parts of this driver will become
> unessisary. Not to mention the other OS's that have historically wanted
> to support the rpi will have an easier time of it as well.

You are making this assumption based on the current submission which
specifically targets 2711 for now, the latter which could, in premise
gain support for an uboot/edk2/atf doing a fair amount of configuration
on behalf of Linux. This same driver is used on MIPS platforms (no
firmware), on ARMv7a 32-bit platforms with no ATF, and on ARM 64-bit
platforms with an ATF that we purposely have made unaware of PCIe. Those
platforms also support suspend to DRAM and S2. In Suspend to DRAM, all
register contents are lost since PCIe is not on the always-on island,
which is why a fair amount of (re)configuration also occurs there.

There is not to my knowledge any firmware, or software prior to Linux
configuring the PCIe bridge (2711 or otherwise) because it historically
has not been required/deemed necessary/desirable and for the vast
majority of platforms where this driver is used, I expect that situation
to remain for the years to come. For Broadcom STB platforms where this
has been used for the most part, none of our customers have used PCIe to
connect a southbridge to gain SATA/USB/Ethernet peripherals, since we
have all of those on-chip already, therefore even the boot loader(s)
used on these platforms do not support boot from PCIe. The vast majority
(98%) of use cases are WLAN, and occasionally NVMe.

Since there are a few @arm.com participants in this thread, if
standardization of the PCIe host bridge is so important, maybe
entertaining the idea of delivering a PCIe MAC (and leaving the PHY as
something to be done by the integrator) as another IP in your portfolio
would given some give some incentive to avoiding doing that piece of HW
(and FW, and SW) and save the pain of compliance, memory semantics,
bridging and all of those things easy to get wrong.
-- 
Florian
