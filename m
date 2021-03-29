Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4134D975
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhC2VKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 17:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhC2VKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 17:10:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C413C061574;
        Mon, 29 Mar 2021 14:10:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e14so5031367plj.2;
        Mon, 29 Mar 2021 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+dfSzt8E3k72dQZZN8BYdfUgJulz0l62/VUnuugD/Q=;
        b=e5h7GKzt2mrZjfch0TBXP7PguG7E35lElD54Ng1F3QiItQWma38JgdktTk2DO0exz9
         zOfWWlbDXgoSc82BYUgibxYqflSFx+iLpawgfcKJUwifoGQofjAgTcdpoN+tBvigH1tp
         5QjqTiK1K17lgBL9VfGEP8tqpi0BBY3Y3i56MOhjmjPlDfkaUmuyBBAleTTWBMkykBLP
         l2AINYj/z/utyCNPc4UpXfqNusehv68HfhNCJ3XU1rLTfrTlugQteo3mTVP2d/KU4i3Y
         v4voqfih5IeWIBZ+FT7VgJ9OFVNYJEp0KGIwrv98lmXsvSuGT86isXZvGpidu0vHRHJ5
         +/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+dfSzt8E3k72dQZZN8BYdfUgJulz0l62/VUnuugD/Q=;
        b=cFYVEaiBAmPeAAm8JdbQ8et2gR0QzgCzVVrfBTAlo+e6xDO+hbLhfryGXSSm9IQ66u
         yA1cuhjHO81ExfOtCIvmml71SWxj/SDzbF3t3SHE5M00al0zoXIYIYz46F8YXfksq+5O
         5nPayKvFwS+1mRQhPWiyj+3W0DR97kKHfHMvDO22ofc8PAlb2SvyzxTptJWSZmlRZj6h
         Ttwn1J0GebymxlHgLzSwdoVqp9M6G8eQVcN+adyCRM/+MT2HRur1blM0vRSwj11SGnxS
         1/i16taKfbjE1EbJFtrN7sr9QpHDdxiPNmmqHQcX3UvNUe2jaB423IUk2AAllyyl6+ow
         woVA==
X-Gm-Message-State: AOAM531dvReJJxP3DTOBpAenbBIyfpT9kdQy9jlRmh/8ONLX71HbJYF8
        gG2llkE0xkVLCK8AmHxyBVxqW6bHfrk=
X-Google-Smtp-Source: ABdhPJyrbfYD2rJKpKvbR3PJaNjuBsIrEMBw2ClPZfivbZa6YlEEhIssVwO2ZsJScXl3GgrLMp6lcQ==
X-Received: by 2002:a17:90a:e60b:: with SMTP id j11mr976538pjy.42.1617052204275;
        Mon, 29 Mar 2021 14:10:04 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v134sm17826690pfc.182.2021.03.29.14.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 14:10:03 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
To:     Mark Brown <broonie@kernel.org>, Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-3-jim2101024@gmail.com>
 <20210329162539.GG5166@sirena.org.uk>
 <CANCKTBsBNhwG8VQQAQfAfw9jaWLkT+yYJ0oG-HBhA9xiO+jLvA@mail.gmail.com>
 <20210329171613.GI5166@sirena.org.uk>
 <CANCKTBvwWdVgjgTf620KqaAyyMwPkRgO3FHOqs_Gen+bnYTJFw@mail.gmail.com>
 <20210329204543.GJ5166@sirena.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e364818a-daa3-7313-3ad2-41dbe6e5be62@gmail.com>
Date:   Mon, 29 Mar 2021 14:09:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329204543.GJ5166@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/29/21 1:45 PM, Mark Brown wrote:
> On Mon, Mar 29, 2021 at 03:48:46PM -0400, Jim Quinlan wrote:
> 
>> I'm not concerned about a namespace collision and I don't think you
>> should be concerned either.  First, this driver is for Broadcom STB
>> PCIe chips and boards, and we also deliver the DT to the customers.
>> We typically do not have any other regulators in the DT besides the
>> ones I am proposing.  For example, the 7216 SOC DT has 0 other
> 
> You may not describe these regulators in the DT but you must have other
> regulators in your system, most devices need power to operate.  In any
> case "this works for me with my DT on my system and nobody will ever
> change our reference design" isn't really a great approach, frankly it's
> not a claim I entirely believe and even if it turns out to be true for
> your systems if we establish this as being how regulators work for
> soldered down PCI devices everyone else is going to want to do the same
> thing, most likely making the same claims for how much control they have
> over the systems things will run on.
> 
>> regulators -- no namespace collision possible.  Our DT-generating
>> scripts also flag namespace issues.  I admit that this driver is also
>> used by RPi chips, but I can easily exclude this feature from the RPI
>> if Nicolas has any objection.
> 
> That's certainly an issue, obviously the RPI is the sort of system where
> I'd imagine this would be particularly useful.
> 
>> Further, if you want, I can restrict the search to the two regulators
>> I am proposing to add to pci-bus.yaml:  "vpcie12v-supply" and
>> "vpcie3v3-supply".
> 
> No, that doesn't help - what happens if someone uses separate regulators
> for different PCI devices?  The reason the supplies are device namespaced
> is that each device can look up it's own supplies and label them how it
> wants without reference to anything else on the board.  Alternatively
> what happens if some device has another supply it needs to power on (eg,
> something that wants a clean LDO output for analogue use)?
> 
>> Is the above enough to alleviate your concerns about global namespace collision?
> 
> Not really.  TBH it looks like this driver is keeping the regulators
> enabled all the time except for suspend and resume anyway, if that's all
> that's going on I'd have thought that you wouldn't need any explicit
> management in the driver anyway?  Just mark the regualtors as always on
> and set up an appropriate suspend mode configuration and everything
> should work without the drivers doing anything.  Unless your PMIC isn't
> able to provide separate suspend mode configuration for the regulators?
> 

We have typically GPIO-controlled and PMIC (via SCMI) controlled
regulators. During PCIe enumeration we need these regulators turned on
to be successful in training the PCIe link and discover the end-point
attached, so there an always on regulator would work.

When we enter a system suspend state however there are really two cases:

- the end-point supports Wake-on (typically wake-on-WLAN) and we need
its power supplied kept on to support that

- the end-point does not support or participate in any wake-up, there we
want to turn its supplies off to save power

How would we go about supporting such an use case with an always on
regulator?
-- 
Florian
