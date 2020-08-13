Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7FE243F40
	for <lists+linux-pci@lfdr.de>; Thu, 13 Aug 2020 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMTR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Aug 2020 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMTR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Aug 2020 15:17:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68E4C061757;
        Thu, 13 Aug 2020 12:17:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so3042319plb.12;
        Thu, 13 Aug 2020 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MRBROfM/QBivW8ITTVd4EQniWeWw4srWwUDl7cbY79M=;
        b=a79/AUvRNlzhxoYRRiRjU/REDITgIVZwQ8KSUq6mp6KWaxNElskr7pI6PVmMUqCZqV
         0Tp/JJwX3NHhHE8S6GN5zHMEHGcVobWI55uow67/ZsRCxTbmSKs9WAmeRI7yokTUhVVX
         v3aq7I4wUgV5kUYc9jUYB8OS0TdTI3MBUn/4DZ92C6B6BuzWHM2sa5M+TSnA/b0qWuL+
         1EGEIfdZp4YjokBlOm+ZW93mEtT5qqG8k/VhYPHZlyYMxYQOdIYtG0yHTVch0lLmpRUI
         oKR86FiBwdRKUh8xtoF1rawB371nal9ZVF4vNyLuvm+mQnDD2mK8D32SRf1PAND71K9T
         KdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MRBROfM/QBivW8ITTVd4EQniWeWw4srWwUDl7cbY79M=;
        b=Gh4J964UJX855nINQA9+ZEhrd7U/FdnZ4Qx2E0X6ByYgV/o2mEeIjtN74QfEpHzN6+
         bbyxPHklojTBWAwzjj0BB4fHYcJUQ0uSGgvtHsy2tf4FmGVBKH9yaaXwAwx9rnxbR26c
         pke7BJIbJzE/tiAwCKwwpPZ70FEbCYCYQLPPdNmVoOO7utBFOVRbvLyQNCstrL23akze
         F3SArAJzKQuaOMh5gPDvLiFJdDy0KCc4Qm6iCxqI1A45poEFq1UTjLkBFDa5utSeY/Fm
         hOPiuTdfxK/y250ze6wP47cOOda3YdnkCwPbbGggdCkSfNyKhY4ZOb1KBLGSEHYOKLcl
         IajA==
X-Gm-Message-State: AOAM530wCrdR4y7rNich9DnGLzjeqsCyHXXd9FvvBqRyOrt7idQd9QaX
        o1iL5Jv9Zv+XtVH+KWAbEzE=
X-Google-Smtp-Source: ABdhPJymJYAhCqS1VHSM4jCf+0y4gpw76umObdiyThw611Sp2sMl958GDsw/3zig9eaBh7mJgPM/Og==
X-Received: by 2002:a17:90a:fb4b:: with SMTP id iq11mr6623955pjb.127.1597346277159;
        Thu, 13 Aug 2020 12:17:57 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q2sm6162517pgs.90.2020.08.13.12.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 12:17:56 -0700 (PDT)
Subject: Re: [PATCH v5 0/9] Raspberry Pi 4 USB firmware initialization rework
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org, robh@kernel.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, andy.shevchenko@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
 <a6aecb7a4d270cb23430d25850c85a332555af55.camel@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <01e4b87c-d287-fd72-9f9c-545539127a50@gmail.com>
Date:   Thu, 13 Aug 2020 12:17:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <a6aecb7a4d270cb23430d25850c85a332555af55.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/13/2020 3:01 AM, Nicolas Saenz Julienne wrote:
> Hi everyone.
> 
> On Mon, 2020-06-29 at 18:18 +0200, Nicolas Saenz Julienne wrote:
>> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
>> loaded directly from an EEPROM or, if not present, by the SoC's
>> co-processor, VideoCore. This series reworks how we handle this.
>>
>> The previous solution makes use of PCI quirks and exporting platform
>> specific functions. Albeit functional it feels pretty shoehorned. This
>> proposes an alternative way of handling the triggering of the xHCI chip
>> initialization trough means of a reset controller.
>>
>> The benefits are pretty evident: less platform churn in core xHCI code,
>> and no explicit device dependency management in pcie-brcmstb.
>>
>> Note that patch #1 depends on another series[1], that was just applied
>> into the clk maintainer's tree.
>>
>> The series is based on v5.8-rc3
>>
>> v3: https://www.spinics.net/lists/arm-kernel/msg813612.html
>> v2: https://lkml.org/lkml/2020/6/9/875
>> v1: https://lore.kernel.org/linux-usb/20200608192701.18355-1-nsaenzjulienne@suse.de/T/#t
>>
>> [1] https://lore.kernel.org/linux-clk/159304773261.62212.983376627029743900@swboyd.mtv.corp.google.com/T/#t
>>
>> ---
> 
> We were waiting on a dependency to be merged upstream to get this. They are now
> in, so could we move things forward?
> 
> I can take the device tree patches, I guess philipp can take the reset
> controller code. But I'm not so sure who should be taking the PCI/USB
> counterparts.

Should we route everything through the USB tree since that is where the 
changes that do require synchronization with other subsystems and DTS is 
needed the most?
-- 
Florian
