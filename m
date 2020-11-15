Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101F32B3975
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 22:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKOVT1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 16:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgKOVT0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 16:19:26 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8CC0613CF;
        Sun, 15 Nov 2020 13:19:26 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so16634253wrw.10;
        Sun, 15 Nov 2020 13:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJf2dmVXH1a/IOMc2vY/SImgMDeWPmPkQk0mds6NUSM=;
        b=HC3jgIu8MNYh2QgAobTdGwhFcal2nwtKiGTOpSJaPHXDkICoLe6OOy5TQNg7D6Lzyl
         1q0PVXakWmQT9vgGHXh4XBh61N+oJ8VHw49Wcq++KmAxwbdV+x1r2Tna+Vn4TQ7eqd6x
         OYadwt60UwBhvRoPFLjt5S+GavE+olM7vphmTUP2J07O9w17+Uqdbrj87nzrrbwy9m+k
         /QZguBf5pYLU2zNc+TGuwBY+zDkLv9PiH8NXSgyUUJgM57AugfX9rfLDAgtlkOomEw2i
         FbCyQ7dvtwj4lASSswUlRFuJO+NGiPS0K0cCNBraCZMm+wW/RVSsf6UxEZCFxm/zglUX
         5PWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJf2dmVXH1a/IOMc2vY/SImgMDeWPmPkQk0mds6NUSM=;
        b=GQ/BHcijxCP5W1c+n1gTY5VK1z9oqnD2JQ3IFZ+7fm2O2NJIM7sVTSGOBkkcCvnVon
         M8s8BnsDadx0LYc/sgf4bUiVShAlT4g4A3hmn185YojroM/567jPzM0n46C98anaoXOg
         a+149MbNGeL27hzhGfJTzL631gb6J5wGMvcBnfaJE3wlG7fl9Qv+wNeRMDTDrTh7gfnD
         0GmIvoIFEEq6xb8lWV1blF94zkQJusS8NodmvhrExwDHhE68kB/rGUtslEhaidf5r9ef
         sxnQjjOknS7IGB+2c9YL8L3fEuidwNtuQaHaomLdioTox/TpnVPEH4OCcPt91Jg+swEj
         gDZQ==
X-Gm-Message-State: AOAM530RHRPXjfuLlb2wMwnnZRddFLogfcWycGdsPwuxiFnOXxBNzZf9
        be7lnotzDUGdnDRGGJ/3hfJ4DHZ2lAw=
X-Google-Smtp-Source: ABdhPJxEheK3VzYA3RBZzYVxv+/GtG0KybvdLam+70zBZlE1MB2Ze2HFfiTXnQvoaxhM1xTmvHQ4UQ==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr16440269wrn.277.1605475164374;
        Sun, 15 Nov 2020 13:19:24 -0800 (PST)
Received: from [192.168.2.202] (p5487b28b.dip0.t-ipconnect.de. [84.135.178.139])
        by smtp.gmail.com with ESMTPSA id f16sm20347063wrp.66.2020.11.15.13.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 13:19:23 -0800 (PST)
Subject: Re: [PATCH] PCI: Add sysfs attribute for PCI device power state
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201115202719.GA1239987@bjorn-Precision-5520>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <96da5aa3-a6ff-aeee-430b-bc9958f5aefa@gmail.com>
Date:   Sun, 15 Nov 2020 22:19:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201115202719.GA1239987@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/15/20 9:27 PM, Bjorn Helgaas wrote:

[...]

> I think something read from sysfs is a snapshot with no guarantee
> about how long it will remain valid, so I don't see a problem with the
> value being stale by the time userspace consumes it.

I agree on this, and the READ_ONCE won't protect against it. The
READ_ONCE would only protect against future changes, e.g. something like

     const char *state_names[] = { ... };

     // check if state is invalid
     if (READ(pci_dev->current_state) >= ARRAY_SIZE(state_names))
             return sprintf(..., "invalid");
     else    // look state up in table
             return sprintf(..., state_names[READ(pci_dev->current_state)])

Note that I've explicitly marked the problematic reads here: If those
are done separately, the invalidity check may pass, but by the time the
state name is looked up, the value may have changed and may be invalid.

Note further that if we have something like

     pci_power_t state = pci_dev->current_state;

the compiler is, in theory, free to replace each access to "state" with
a read to pci_dev->current_state. As far as I can tell, the whole point
of READ_ONCE is to prevent that and ensure that there is only one read.

Note also that something like this could be easily introduced by
changing the code in pci_power_name(), as that is likely inlined by the
compiler. I'm not entirely sure, but I think that the compiler is allowed
to, at least theoretically, split that into two reads here and inlining
might be done before further optimization.

On the other hand, the changes that could lead to issues above are
fairly unlikely to cause them as the compiler will _probably_ read the
value only once anyways.

> If there's a downside to doing two separate reads, we could mention
> that in the commit log or a comment.
> 
> If there's not a specific reason for using READ_ONCE(), I think we
> should omit it because using it in one place but not others suggests
> that there's something special about this place.

I'd argue that there is indeed something special about this place:
current_state is accessed without holding the device lock (unless I'm
mistaken and sysfs attributes do acquire the device lock automatically)
and the state is normally only accessed/changed under it.

Apart from (hopefully) preventing somewhat unlikely future issues and
highlighting that it is (somewhat of a) special case, the READ_ONCE does
not serve any purpose here. As the code is now, omitting it will not
cause any issues (or really should not make any difference in produced
code).

All in all, I'm not entirely sure that it's a good idea to drop the
READ_ONCE, but I'll defer to you for that judgement.

Regards,
Max
