Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41602FBACC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 16:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390563AbhASPMm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 10:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389689AbhASPMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jan 2021 10:12:33 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C8C061575;
        Tue, 19 Jan 2021 07:11:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ke15so21291369ejc.12;
        Tue, 19 Jan 2021 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T684pbRiyXTHMjiyj9K2qNkRy+PGwfHnHIkUTOyJyoc=;
        b=rwBg1iZ0GoU89hgJR18WBQvxOXb9/628zja19HwjUGMulIOy/0KmK6IqkjxMHiVfEj
         bTTadX4Iy+kKHnmY+oTOXSLkazhXICmv7dI3rl1EDzAeKsSiG+vNHCbImcHOAycUV4kD
         GtQra359abpwz4RpgVAbEnfXjXNJ42WSzqh2QKh5nB92G9HFFFdrJlF/80ToHu8DJAAR
         DD8AeGBEPhGVtSJlrVX9qKs/M4ueUDJVuNW9reTyHIZhsvv6q3iwlUVYz6P3H+NNd8C1
         ujhVtPMdukkBsOkzwkOS+7GgdutVUxD0InXM8zTabUtFG68IUHFX8WIQJ3ACrYudHtfc
         0uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T684pbRiyXTHMjiyj9K2qNkRy+PGwfHnHIkUTOyJyoc=;
        b=JL0fByPUw2NlzgLbTCSXWWbKoAbC0MQG6TsKUaQTlfwkQtxFfo7HmaZ+hsP2A5kMeE
         uE7x5EGAJiL0Lb+Ufif1TULt8aJVxgccsNdk0B6gOLm0FdrjnOBb5IR3rTdw/jbtCqzr
         JntHGOLeA08uUR7TX/TDUHYzMbb7nUttUtEHI/VZfotU8CDKdBjsdVW5M5gMC8fLfEH7
         S3JIzEISMsb6vX7moY7rzuq+Wt1ny3cOEPBIT/dHIXbrMaKORyIdEkLSwqLRRbK3NYix
         C64DDUvGlnoOQgUVCpH9JDNSCL3sQX1BVqMuh7MhxrDiJgsUPhID859a44ovF+SuvI7T
         liog==
X-Gm-Message-State: AOAM530npxWitZA2hBdvmHAu2PnLofyLDQSxJot+vFbPVRAjzWkJvRtf
        z2eiwboWuoqjqaI52H88HixW3u5AP2A=
X-Google-Smtp-Source: ABdhPJzFqLgbC9mdVhryq9kB69wAPD08K3GAiGu/JoWn1hmEvjzNPYCzX2bcVz/GW8glarmpD4P5cA==
X-Received: by 2002:a17:906:a20e:: with SMTP id r14mr3240679ejy.404.1611069110542;
        Tue, 19 Jan 2021 07:11:50 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x17sm13053730edq.77.2021.01.19.07.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 07:11:50 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20210118091739.247040-1-xxm@rock-chips.com>
 <20210118091739.247040-2-xxm@rock-chips.com>
 <e143ad9e-1cfd-e59d-0079-513c036981ba@gmail.com> <2336601.uoxibFcf9D@diego>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <677c102d-0b9b-1a12-0ac6-4dd0a1023b68@gmail.com>
Date:   Tue, 19 Jan 2021 16:11:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2336601.uoxibFcf9D@diego>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Simon, Heiko,

On 1/19/21 2:14 PM, Heiko Stübner wrote:
> Hi Johan,
> 
> Am Dienstag, 19. Januar 2021, 14:07:41 CET schrieb Johan Jonker:
>> Hi Simon,
>>
>> Thank you for this patch for rk3568 pcie.
>>
>> Include the Rockchip device tree maintainer and all other people/lists
>> to the CC list.
>>
>> ./scripts/checkpatch.pl --strict <patch1> <patch2>
>>
>>  ./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
>> --nogit <patch1> <patch2>
>>
>> git send-email --suppress-cc all --dry-run --annotate --to
>> heiko@sntech.de --cc <..> <patch1> <patch2>
>>
>> This SoC has no support in mainline linux kernel yet.
>> In all the following yaml documents for rk3568 we need headers with
>> defines for clocks and power domains, etc.
>>
>> For example:
>> #include <dt-bindings/clock/rk3568-cru.h>
>> #include <dt-bindings/power/rk3568-power.h>
>>
>> Could Rockchip submit first clocks and power drivers entries and a basic
>> rk3568.dtsi + evb dts?
>> Include a patch to this serie with 3 pcie nodes added to rk3568.dtsi.
>>
>> A dtbs_check only works with a complete dtsi and evb dts.
>>
>> make ARCH=arm64 dtbs_check
>> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>
>> On 1/18/21 10:17 AM, Simon Xue wrote:
>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>>> ---
>>>  .../bindings/pci/rockchip-dw-pcie.yaml        | 101 ++++++++++++++++++
>>>  1 file changed, 101 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>> new file mode 100644
>>> index 000000000000..fa664cfffb29
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>> @@ -0,0 +1,101 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: DesignWare based PCIe RC controller on Rockchip SoCs
>>> +
>>
>>> +maintainers:
>>> +  - Shawn Lin <shawn.lin@rock-chips.com>
>>> +  - Simon Xue <xxm@rock-chips.com>
>>
>> maintainers:
>>   - Heiko Stuebner <heiko@sntech.de>
>>
>> Add only people with maintainer rights.
> 
> I'd disagree on this ;-)

All roads leads to Heiko... ;)

It takes long term commitment.
Year in, year out.
Keeping yourself up to date with the latest pcei development.
Communicate in English.
Be able to submit patches without errors... ;)
Review other peoples patches.
Respond in short time.
Bug fixing.

If that's what you really want, then you must include a patch to this
serie for MAINTAINERS.

Check patch with:

./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS
--order

Otherwise it's safe to include that person mentioned above.

> 
> The maintainer for individual drivers should be the persons who are
> actually know the hardware. We have individual Rockchip developers
> taking care of other drivers as well already.
> 
> And normally scripts/get_maintainer.pl should already include me
> due to the wildcard for things having "rockchip" in the name.
> 
> 
> Heiko
> 
> 
> 

