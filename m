Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FD12EE766
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 22:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbhAGVGi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 16:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbhAGVGi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jan 2021 16:06:38 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C36C0612F8
        for <linux-pci@vger.kernel.org>; Thu,  7 Jan 2021 13:05:57 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z9so5257196qtn.4
        for <linux-pci@vger.kernel.org>; Thu, 07 Jan 2021 13:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FadgRMCjqSfK1p2dGVB6UAyZWKTELanycTILncMf0V4=;
        b=sGo2d1y0YMj5ISVaYjlg8g3gbdADAkFDo37t100vvlXkZ7fFkSjTKQlrRrDsWKrCUM
         B9fjXz6qkpzTNKXFbHd55FTLqcolca7TUsDvwQ7Qw1p07zeCbweNnbTQPGLqeJC4qfLk
         pfsdgzeSMhVkyGhAvRqERvfnbdNMRB62RIUJlS2xH18378mAiB/Lihu8zG8NQhZs0PSb
         M1dVPiSWzEk+H73tJds4x3i+3rBdMB8kyna/2wZju6dAE98GHRyraV9Ep1HAVl7e/LJB
         BoWdt9dOB9e8LsAFNOmGTiNscYDBr5FnTi232BdHBrW3cbyDUb9qEdhBSddIfGWn7Vtu
         R27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FadgRMCjqSfK1p2dGVB6UAyZWKTELanycTILncMf0V4=;
        b=CLPcWpn8lX6UZjbYNVa/JA5y+28tW7/A2n/me3aRFsydm95JxxOg/5QD8IiF8MlIed
         2QuvZ04szNxdm9un+WBTTUpXzkh3WEV/rdC8yWWQU39zEVYxJ2eJHY/FwKSA0s7wN3y6
         f45DSTH8wmQFvXb0vNuxPMtEwyNkt6kVrUWx8GZXkuesW71yhHp9K4JJ1usBJTkQ2QsH
         a2iOhAAp5NSYuHiyjLS73grHIF7UVTFUbR7U3jXvK8y4t1bzLoTV7auHeQtfulxdbaoT
         CSq3WYvwIN9oNyo69XpY8aM90a8/iOVFL3bfp2D+9WcdM258IGgYQ51UKsbmDbJIILZ7
         xGhg==
X-Gm-Message-State: AOAM531T06xz0CRB2eF+J6NUN4DucfModAArbn0Ad9/EAgv3Ot2FEGoQ
        t0tV/jyNy1gfMzfBWr7M02rNVA==
X-Google-Smtp-Source: ABdhPJxzXggeoNZjF84y+uAKodjui60LUjdVr31/hQwxp5mzN5dQTNGemD+VGIcUnS8c9gEW3/0GGA==
X-Received: by 2002:ac8:5514:: with SMTP id j20mr479421qtq.387.1610053556805;
        Thu, 07 Jan 2021 13:05:56 -0800 (PST)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id z20sm3873243qkz.37.2021.01.07.13.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 13:05:56 -0800 (PST)
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
Date:   Thu, 7 Jan 2021 16:05:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20210107181416.GA3536@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi will, everyone,

On 1/7/21 1:14 PM, Will Deacon wrote:

> On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
>> Given that most arm64 platform's PCI implementations needs quirks
>> to deal with problematic config accesses, this is a good place to
>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
>> standard SMC conduit designed to provide a simple PCI config
>> accessor. This specification enhances the existing ACPI/PCI
>> abstraction and expects power, config, etc functionality is handled
>> by the platform. It also is very explicit that the resulting config
>> space registers must behave as is specified by the pci specification.
>>
>> Lets hook the normal ACPI/PCI config path, and when we detect
>> missing MADT data, attempt to probe the SMC conduit. If the conduit
>> exists and responds for the requested segment number (provided by the
>> ACPI namespace) attach a custom pci_ecam_ops which redirects
>> all config read/write requests to the firmware.
>>
>> This patch is based on the Arm PCI Config space access document @
>> https://developer.arm.com/documentation/den0115/latest
> 
> Why does firmware need to be involved with this at all? Can't we just
> quirk Linux when these broken designs show up in production? We'll need
> to modify Linux _anyway_ when the firmware interface isn't implemented
> correctly...

I agree with Will on this. I think we want to find a way to address some 
of the non-compliance concerns through quirks in Linux. However...

Several folks here (particularly Lorenzo) have diligently worked hard 
over the past few years - and pushed their patience - to accommodate 
hardware vendors with early "not quite compliant" systems. They've taken 
lots of quirks that frankly shouldn't continue to be necessary were it 
even remotely a priority in the vendor ecosystem to get a handle on 
addressing PCIe compliance once and for all. But, again frankly, it 
hasn't been enough of a priority to get this fixed. The third party IP 
vendors *need* to address this, and their customers *need* to push back.

We can't keep having a situation in which kinda-sorta compliant stuff 
comes to market that would work out of the box but for whatever the 
quirk is this time around. There have been multiple OS releases for the 
past quite a few years on which this stuff could be tested prior to ever 
taping out a chip, and so it ought not to be possible to come to market 
now with an excuse that it wasn't tested. And yet here we still are. All 
these years and still the message isn't quite being received properly. I 
do know it takes time to make hardware, and some of it was designed 
years before and is still trickling down into these threads. But I also 
think there are cases where much more could have been done earlier.

None of these vendors can possibly want this deep down. Their engineers 
almost certainly realize that just having compliant ECAM would mean that 
the hardware was infinitely more valuable being able to run out of the 
box software that much more easily. And it's not just ECAM. Inevitably, 
that is just the observable syndrome for worse issues, often with the 
ITS and forcing quirked systems to have lousy legacy interrupts, etc. 
Alas, this level of nuance is likely lost by the time it reaches upper 
management, where "Linux" is all the same to them. I would hope that can 
change. I would also remind them that if they want to run non-Linux 
OSes, they will also want to be actually compliant. The willingness of 
kind folks like Lorenzo and others here to entertain quirks is not 
necessarily something you will find in every part of the industry.

But that all said, we have a situation in which there are still 
platforms out there that aren't fully compliant and something has to be 
done to support them because otherwise it's going to be even more ugly 
with vendor trees, distro hacks, and other stuff.

Some of you in recent weeks have asked what I and others can do to help 
from the distro and standardization side of things. To do my part, I'm 
going to commit to reach out to assorted vendors and have a heart to 
heart with them about really, truly fully addressing their compliance 
issues. That includes Cadence, Synopsys, and others who need to stop 
shipping IP that requires quirks, as well as SoC vendors who need to do 
more to test their silicon with stock kernels prior to taping out. And I 
would like to involve the good folks here who are trying to navigate.

I would also politely suggest that we collectively consider how much 
wiggle room there can be to use quirks for what we are stuck with rather 
than an SMC-based solution. We all know that quirks can't be a free ride 
forever. Those who need them should offer something strong in return. A 
firm commitment that they will never come asking for the same stuff in 
the future. Is there a way we can do something like that?

Jon.

-- 
Computer Architect
