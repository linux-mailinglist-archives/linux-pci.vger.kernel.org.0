Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1220B421607
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 20:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhJDSGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 14:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbhJDSGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 14:06:19 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA4DC061745
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 11:04:30 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 24so22785020oix.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v8xO+4vZI73uOmZkA7HgKBkA2xAQ2Mbya8e5l4z7JE4=;
        b=Jyu3+9Xys8gQ9I8c2k6q+VZuHlDlj2qmmgFKJ4cmo8wqGoChLKCm4khgMIb3q44U4W
         zXlDVJlgPmt4K5xcVcOKEg/MpogxmmgcY8SaV6USrhs4pehmy0DqcK9tLFVSex/KP0La
         RIxgMoweosXXgM4ROnVmkSvuMOM3GDaJedOsC5EkLDTDP11sPek7Sii6X74dbcIc3czh
         t8jAJekNtGnb3YjJ8qA8QOc1w9nLThixYxJC0MYF1nsIUPZMscsgz+FpNAX1B4NEjzGY
         h41tuN/hVqcv9qL1V/cKgCxzTkvU9z7fChGFtSND7Eog89xA2fFc3gH+ZYVkIRPw7NRt
         iMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v8xO+4vZI73uOmZkA7HgKBkA2xAQ2Mbya8e5l4z7JE4=;
        b=EdCcOQib0hFRKAmiXxTtMoC5UCV+f24a/jX/qNJR2g4fQDn5yi1eHFyQUDC/B2fidk
         VLBzV7CEyUKlB9oHx8EfHdocx6n+Q24QOY2q6V+J8SSBFqUcBEr4WJugIoiN+3kjSJ6R
         SmwaJCAwYcZU+BAEcoQor3YQQw3EDeW83cwEyj3riaapDCEDzXuJkHiJHtw1oppCk80S
         is42bREq93Px8Bwagh2k6TNWutJiHbgQfiMqOccgtCPRfEfwTK0c9fNMKuiWbwqtibZl
         DxgK/7o62hIkx65lD/REstHqc36QGEasvB6NKiCYPTk7eZdOjSMFW5UkpBai09YN2ypv
         z48g==
X-Gm-Message-State: AOAM530NMyIS0CM3b6S5kfhN7/WsZNyOoKIDcDZMWbUMXlg0CEwLIwTb
        Li3kqHcXCl8FgFqLRcwvD0pmn5yWPa8=
X-Google-Smtp-Source: ABdhPJxc0LYRYp5PoNKRN8Sl6coMOL1qGCxN279wdFtpDev0sqFowNDsWgof1QcEF9ZKKKPrQTOmeA==
X-Received: by 2002:a05:6808:198b:: with SMTP id bj11mr14590109oib.105.1633370670013;
        Mon, 04 Oct 2021 11:04:30 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:c5d3:8f2f:d5f0:22e6? (2603-8081-2802-9dfb-c5d3-8f2f-d5f0-22e6.res6.spectrum.com. [2603:8081:2802:9dfb:c5d3:8f2f:d5f0:22e6])
        by smtp.gmail.com with ESMTPSA id x62sm2863552oig.24.2021.10.04.11.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 11:04:29 -0700 (PDT)
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
 <20210818070503.GF22282@amd>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <4909152d-7517-5ed9-393c-9c020e901688@gmail.com>
Date:   Mon, 4 Oct 2021 13:04:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210818070503.GF22282@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/18/2021 2:05 AM, Pavel Machek wrote:
> Hi!
> 
>> This patch adds support for the PCIe SSD Status LED Management
>> interface, as described in the "_DSM Additions for PCIe SSD Status LED
>> Management" ECN to the PCI Firmware Specification revision 3.2.
>>
>> It will add (led_classdev) LEDs to each PCIe device that has a supported
>> _DSM interface (one off/on LED per supported state). Both PCIe storage
>> devices, and the ports to which they are connected, can support this
>> interface.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> I believe these are not LEDs, right? This is something that displays
> information to the user, but how exactly it is implemented is up to
> BIOS vendor.
> 
> I don't think it is good fit for LED subsystem.
> 
> Best regards,
> 								Pavel
> 

I think it very likely these will be LEDs on most, if not all, systems 
(likely enough that the PCI ECN has "LEDs" in the name)... they have 
been LEDs on every system I've seen.  I would suspect that systems which 
support more than one or two of the states won't have a 1-to-1 mapping 
of logical LEDs to physical LEDs, though, but might instead use 
something like IBPI (SFF-8489) to use fewer LEDs and be easier to read 
at a glance.

I'm not sure I understand why the LED subsystem would be that much worse 
a fit for this than for keyboard (or other) indicator LEDs.  I 
understand that many other indicators are more likely to have each 
single kernel LED mapped to a single physical LED, but functionally they 
are both kernel LEDs controlling on/off indicators which are likely 
displayed on LEDs that are always visible on the system.
