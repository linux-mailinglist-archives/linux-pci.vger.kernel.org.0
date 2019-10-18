Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4450DC4A5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442765AbfJRMXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 08:23:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36603 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442702AbfJRMXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 08:23:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id m18so5927247wmc.1;
        Fri, 18 Oct 2019 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sF1xoXZAa72tOqMbAFrDW3UELNNGwx/IW7wZmPXXkto=;
        b=UdOXvlcUndN30QMBAP4UNYSAfIszW1YQ+/TNYgrDKKr8kJcm5z49FnNuGiADGj4R3S
         xDmiWjjWw/yRPGu3l2Y3SweyNN8NwRRb9MJ1q8MN1CSltdDR+sIAsMDPknWijlZxPtcO
         RnnwwZNrBqTyV1L/8M6Ir2p/FeN2gyS43comism9rsViByJjsPSvDxHmtzi1XTFXnxyv
         QlkV16xc5SBprpmn5f8jz21cMcTytrTG6oDl/L4KQ99H+tBNzi0c0iCO4dHbK4xk3dki
         QkxUmYcVaEsVgvG09YmfaM27rfUTsJhtboqthg2h6w8PQasXO18FgXpAHl8yFci+u+AH
         Yfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sF1xoXZAa72tOqMbAFrDW3UELNNGwx/IW7wZmPXXkto=;
        b=eyujfmQZTSTID3DnIaHEd27OA8Tv3WQjA/tplceWF0lEhH9syo5cHIToXW6m8K9Zp5
         JA+dJFDWN1uOgV0UZjndFXqEaFOgnE9KX60R9ItcggpDGaQAYdufTudE9DGk+ZnRwPCa
         JsspAac9Yxewt4SwAAGAJ5VISbPPzzntFIwe4lac/tvuoa4PkgOt3nvJeoapfYumK8ko
         fpaheTDpkAXtusJNHjekcw0kA6+WvdPLR/kKJyKta+y31St9hWE6BpQyHshItmgERow0
         V4hhiEPReaQmH1fvNhs2RhV3GR71wbbNklJAbChx7ay/fWy2fkf+VN4PM8T1CXo98vA1
         T39w==
X-Gm-Message-State: APjAAAXZ8DDksKb0Hyvdo6o0A0ncUoBxYVCAVDcNhvjoPWeX+Np8c04O
        n7ES2Klpfn6QMe3MvZdAukI78vN+
X-Google-Smtp-Source: APXvYqzY5KIf283EQJQ9X5rDECEr+jIX4jC6/qydEY0wydKSPPDoeN0m6+QXPURI0+DiZg0F/wstQg==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr7249794wma.57.1571401412203;
        Fri, 18 Oct 2019 05:23:32 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id n15sm6416333wrw.47.2019.10.18.05.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2019 05:23:31 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        PCI <linux-pci@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>
References: <CAL_Jsq+4uaFJzk5jUPw+KssZvnji0WDh+QcFMok99XXntEhNTQ@mail.gmail.com>
 <88099c4f-4fb4-626e-f66f-3eb8861dfb2c@gmail.com>
 <CAL_JsqLzmk5dfn0Re3y7VjY5ehE29vKLOV-2tM5B_jPbB2YiPQ@mail.gmail.com>
 <06d093b2-dcc2-a01f-fce0-5db0bc47325e@gmail.com>
 <CAMuHMdXjZs6Gvar3o7wXd2-1tkPtpt3qxZLG5vzDfrCG4d9SeQ@mail.gmail.com>
 <ca16e883-27d3-2cd0-7d71-fa9b169dcccd@gmail.com>
 <ccf8a4f9-1758-bafc-797c-714f06810db3@arm.com>
 <6af92fb1-a154-3e03-d239-0417da5a5094@gmail.com>
 <CAL_JsqKEjzO3s=bBf_TxTAXTzLTcX=8ccFXLfowhPOHWzNET9A@mail.gmail.com>
 <5a19fcd3-2071-334a-1c4a-59d07f4a387d@gmail.com>
 <20191018095345.GD25918@e121166-lin.cambridge.arm.com>
Message-ID: <fd53f532-9b78-a64e-6d34-bda5a7639586@gmail.com>
Date:   Fri, 18 Oct 2019 14:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018095345.GD25918@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/18/19 11:53 AM, Lorenzo Pieralisi wrote:
> On Thu, Oct 17, 2019 at 05:01:26PM +0200, Marek Vasut wrote:
> 
> [...]
> 
>>> Again, just handling the first N dma-ranges entries and ignoring the
>>> rest is not 'configure the controller correctly'.
>>
>> It's the best effort thing to do. It's well possible the next generation
>> of the controller will have more windows, so could accommodate the whole
>> list of ranges.
>>
>> Thinking about this further, this patch should be OK either way, if
>> there is a DT which defines more DMA ranges than the controller can
>> handle, handling some is better than failing outright -- a PCI which
>> works with a subset of memory is better than PCI that does not work at all.
> 
> OK to sum it up, this patch is there to deal with u-boot adding multiple
> dma-ranges to DT.

Yes, this patch was posted over two months ago, about the same time this
functionality was posted for inclusion in U-Boot. It made it into recent
U-Boot release, but there was no feedback on the Linux patch until recently.

U-Boot can be changed for the next release, assuming we agree on how it
should behave.

> I still do not understand the benefit given that for
> DMA masks they are useless as Rob pointed out and ditto for inbound
> windows programming (given that AFAICS the PCI controller filters out
> any transaction that does not fall within its inbound windows by default
> so adding dma-ranges has the net effect of widening the DMA'able address
> space rather than limiting it).
> 
> In short, what's the benefit of adding more dma-ranges regions to the
> DT (and consequently handling them in the kernel) ?

The benefit is programming the controller inbound windows correctly.
But if there is a better way to do that, I am open to implement that.
Are there any suggestions / examples of that ?

However, I think the discussion strayed quite far away from the real
goal of this patch. This patch only handles the case where there are too
many dma-ranges in the DT which cannot all be programmed into the
controller. Instead of failing, the patch allows the controller to work
with smaller range and reports that in the log, which I think is better
than outright failing.

[...]

-- 
Best regards,
Marek Vasut
