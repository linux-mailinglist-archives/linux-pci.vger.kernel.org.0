Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2151A3CEEED
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243616AbhGSVW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 17:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383624AbhGSR7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 13:59:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC86C061574;
        Mon, 19 Jul 2021 11:26:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n4so10935515wms.1;
        Mon, 19 Jul 2021 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=niGHA44vho3xswp3bGtUo+jGvJWl4PkcLrOhnDSDxcQ=;
        b=BxXPcxXNcwtpfhtjzEe93kaoQhkxXH8e14CRMxgK0kwDLLianfVgAG92SQiWwTEKfR
         VDoiNRH66D3IjpGqxmQzkj03IbV0yrGTNmvM2bTPpXJjnJRbKN/DZwKdVy14q0v3BMXp
         1uqG0RUCv7aJdgGVwnVaMw18Qa2Is7kRUiOFG7QmYgl8PRQ+BwKbwhDbbl1h4us9DZ1t
         BniU0N4Hzbu2pY3k1g6Hbp0MH+5AGrPpN5kHbPHgpF6z8VQDPBK3V0M+t3P24zxf0S+P
         h8DgVaboRwnlQet8MtLgaTmOC+LqZ11uYLCflmsLyJMyHs7YZXEl4RIY9HZgCD6/xqSc
         Pobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=niGHA44vho3xswp3bGtUo+jGvJWl4PkcLrOhnDSDxcQ=;
        b=FupE3mseSf6S6mAh0hCaWAhGVd8qcshdkRj3AV5LgXwdbolYl+rY8ym5sUxMtv4VBI
         W9DXRBtvCv9W7DSwCno6BBsxssCsakzjCXztCWx4dIo7LBTIsXtfxw/uLTvDk4HPPSl9
         cril7U3gp8Ya1yQwjRvhLMdDFH+9TEpnvFCkbOoAUk2dRAqeKKrB3haxlcpBhCA8E7Dq
         d0OfuF02YDLITAztHLpcquXywglOJrbLh84UgDLv2eyoAbbPIgoEGcgnETRLi42b9WsG
         uMcxDzqolLjuwiBeQGTRfCckko7yho5XTkdj8s7s7gpobYLs8qM5A30N5BLB08tVAnuW
         97Pg==
X-Gm-Message-State: AOAM531afEwlmvdOX4oZReIJLcZARUKbRwUUQ/LKUL+CImLfqzFeGPjc
        m9wrBlQrSE1YLwCJkakWgAwok/rafSE=
X-Google-Smtp-Source: ABdhPJyzbAFdIJximxHXRf5AXob7cX2F2iWUtjwnVWfSyF2vdrH+ceceDlGgba7qrb+KDI6P1p4ihw==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr27741035wmf.32.1626719955315;
        Mon, 19 Jul 2021 11:39:15 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id h9sm17345207wmb.35.2021.07.19.11.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 11:39:14 -0700 (PDT)
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20210514200549.431275-1-marek.vasut@gmail.com>
 <20210717173334.GA2232818@bjorn-Precision-5520>
 <20210719085953.GA17481@lpieralisi> <20210719172340.vvtnddbli2vgxndi@pali>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <62e8d92a-806b-15fb-672d-2519d5a2fa4b@gmail.com>
Date:   Mon, 19 Jul 2021 20:39:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719172340.vvtnddbli2vgxndi@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/19/21 7:23 PM, Pali Rohár wrote:

[...]

>>>> The R-Car PCIe controller is capable of handling L0s/L1 link states.
>>>> While the controller can enter and exit L0s link state, and exit L1
>>>> link state, without any additional action from the driver, to enter
>>>> L1 link state, the driver must complete the link state transition by
>>>> issuing additional commands to the controller.
>>>>
>>>> The problem is, this transition is not atomic. The controller sets
>>>> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
>>>> the PCIe card, but then the controller enters some sort of inbetween
>>>> state. The driver must detect this condition and complete the link
>>>> state transition, by setting L1IATN bit in PMCTLR and waiting for
>>>> the link state transition to complete.
>>>>
>>>> If a PCIe access happens inside this window, where the controller
>>>> is between L0 and L1 link states, the access generates a fault and
>>>> the ARM 'imprecise external abort' handler is invoked.
> 
> And if PCIe MMIO access does not happen, what fixes this issue?

Then you have no problem because you don't hit this fault.

> In this
> patch is implemented only arm32 external abort hook handler (which is
> called only when PCIe MMIO access happens and aborts).

Yes, for the aarch64 rcar the same fix is implemented in atf (see below).

>>>> Just like other PCI controller drivers, here we hook the fault handler,
>>>> perform the fixup to help the controller enter L1 link state, and then
>>>> restart the instruction which triggered the fault. Since the controller
>>>> is in L1 link state now, the link can exit from L1 link state to L0 and
>>>> successfully complete the access.
> 
> Link cannot directly goes to L0 from L1. It first goes to Recovery state
> and in this state card can "disconnect" or reset...
> 
> What would happen if PCIe MMIO access is issued when link is not in some
> L* state? (This can be manually triggered by PCIe Hot Reset - toggling
> Secondary Bus Reset bit in Bridge Control register on parent PCIe Bridge
> device) Is R-Car working in this case and does not crash?

This seems to be exactly the situation the commit message describes -- 
the controller is stuck between L states and needs manual register write 
to proceed.

[...]

>>> To be clear, I'm not objecting to the patch.  It's a hardware problem
>>> and we should work around it as best we can.
> 
> I'm not sure if current API of hook_fault_code or rather whole usage of
> it is prepared to expand into more and more drivers. Last time I looked
> at this arm32 part, it was possible to register only one callback from
> driver. So extending usage of this hook API can result that two drivers
> start fighting who register it earlier...

There doesn't seem to be much ongoing HW development on the arm32 r-car, 
so I don't expect this list of hooks to grow much on this platform.

[...]
