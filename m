Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472C1AFCCE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfIKMas (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 08:30:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43767 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfIKMas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 08:30:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so19626489wrx.10
        for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2019 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fUOH2AuBp89861Obcu3EouaC9zAbyMHL1Ch3LrCv81k=;
        b=hpI0SkleDvQmTxx08b5CXBFf11w7qUlvLLv7yGsweA+eX1Lj6Vr7hXzP8qCKL9bdbl
         E51jiLv7rN8D7gVBpJ8vXZu88bOfUCgwhL7TMMdAMFhJv6xds1KsWKohTKCgPRVafyVb
         ElKE+E1SUL7QIf6Ox/2aCaDBdxPxZ3bxMtMOMK7Y8YhijDOMYKqIC4DRig4/J00Ak9RG
         JMEpQZPjX7jKreBo9Ciu8RCSxqy9TY/mfZZ19WQ6yOp0gxPorl76d6o0Eki4ZAo7LplR
         +dtyRFSXj4T/v2MZ9yxaDTDpjv9CqkbDwuNWTQN94H/8isyRJR3OpUq5atOGCyj4bOlb
         9Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fUOH2AuBp89861Obcu3EouaC9zAbyMHL1Ch3LrCv81k=;
        b=IpQdG2+2a4+hLYccK8cTcPPfJBcv6gtYC9vGgdVzhV793YuiufNRe5x1+QvmmAil6i
         J5jChi3J7KOQiOq3dzB2zt6S/hCz0BJ2W4IagWquA4kxbihp5pzzZv62ZNy8yKdSmPcY
         Mhom94M+xjzmNggMvPRkzbKfZrnSgAhfDSGcOzICP64TTVl0zgAEH+3rJ6o0u6Zvo/Cx
         qjx9uxbJ8kuH2JHEEzOumQvhdeQWHQmAi+2WAvypBsSKGJnvhBxsAi+uLEIuZVYwseYq
         Qs7aMPfJz6/YkX/IWKf9dRYzgXThGXATLT8LFRJBPOZa1hyvOvf3keQ7b19+zzqk+kIv
         ut0g==
X-Gm-Message-State: APjAAAVgSc/B/L6faNQlXxtKWoxerS3nOjQbqVC7a5M0oXCCOwIBNeBD
        273/1BybUklphTRPkzEgZDIf51cwIdxJvw==
X-Google-Smtp-Source: APXvYqxVStqpL7Sm3IQPJZJ86JZM9xDCsszzqSVhkyTXj8EMRGljXkLEgwBwVWQb9YSsuGnCvRpfyg==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr25279247wrr.134.1568205045140;
        Wed, 11 Sep 2019 05:30:45 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id s19sm32026440wrb.14.2019.09.11.05.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 05:30:44 -0700 (PDT)
Subject: Re: [PATCH 1/6] dt-bindings: pci: amlogic,meson-pcie: Add G12A
 bindings
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com,
        devicetree@vger.kernel.org, repk@triplefau.lt, maz@kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
 <1567950178-4466-2-git-send-email-narmstrong@baylibre.com>
 <20190911122250.GT9720@e119886-lin.cambridge.arm.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <62994535-1617-9f71-4059-b8c4da8ecbd1@baylibre.com>
Date:   Wed, 11 Sep 2019 14:30:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911122250.GT9720@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On 11/09/2019 14:22, Andrew Murray wrote:
> On Sun, Sep 08, 2019 at 01:42:53PM +0000, Neil Armstrong wrote:
>> Add PCIE bindings for the Amlogic G12A SoC, the support is the same
>> but the PHY is shared with USB3 to control the differential lines.
>>
>> Thus this adds a phy phandle to control the PHY, and sets invalid
>> MIPI clock as optional for G12A.
> 
> Perhaps reword to "Thus this adds a phy phandle to control the PHY,
> and only requires a MIPI clock for AXG SoC Family".

Sure, thanks,
Neil

> 
> Thanks,
> 
> Andrew Murray
> 
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt   | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> index efa2c8b9b85a..84fdc422792e 100644
>> --- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> @@ -9,13 +9,16 @@ Additional properties are described here:
>>  
>>  Required properties:
>>  - compatible:
>> -	should contain "amlogic,axg-pcie" to identify the core.
>> +	should contain :
>> +	- "amlogic,axg-pcie" for AXG SoC Family
>> +	- "amlogic,g12a-pcie" for G12A SoC Family
>> +	to identify the core.
>>  - reg:
>>  	should contain the configuration address space.
>>  - reg-names: Must be
>>  	- "elbi"	External local bus interface registers
>>  	- "cfg"		Meson specific registers
>> -	- "phy"		Meson PCIE PHY registers
>> +	- "phy"		Meson PCIE PHY registers for AXG SoC Family
>>  	- "config"	PCIe configuration space
>>  - reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
>>  - clocks: Must contain an entry for each entry in clock-names.
>> @@ -23,12 +26,13 @@ Required properties:
>>  	- "pclk"       PCIe GEN 100M PLL clock
>>  	- "port"       PCIe_x(A or B) RC clock gate
>>  	- "general"    PCIe Phy clock
>> -	- "mipi"       PCIe_x(A or B) 100M ref clock gate
>> +	- "mipi"       PCIe_x(A or B) 100M ref clock gate for AXG SoC Family
>>  - resets: phandle to the reset lines.
>>  - reset-names: must contain "phy" "port" and "apb"
>> -       - "phy"         Share PHY reset
>> +       - "phy"         Share PHY reset for AXG SoC Family
>>         - "port"        Port A or B reset
>>         - "apb"         Share APB reset
>> +- phys: should contain a phandle to the shared phy for G12A SoC Family
>>  - device_type:
>>  	should be "pci". As specified in designware-pcie.txt
>>  
>> -- 
>> 2.17.1
>>

