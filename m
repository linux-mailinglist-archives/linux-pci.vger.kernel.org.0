Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF634D56D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhC2Quk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhC2QuS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 12:50:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D9AC061574;
        Mon, 29 Mar 2021 09:50:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c17so10243743pfn.6;
        Mon, 29 Mar 2021 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4Uo8oC0q+k3/BuQcrCo0FLHeLVxH/nrRmm5Yh0sXuo=;
        b=W1d57UJnJq+zVXdWhh1fBDsFoR/Ax++MBqi9TwsiwD5HqR9kEy14TbZ+fC64mCZMO4
         6LQouzK9oF43qBDPgQL5ha4dGt5ea14MkOlGxQor6bxp83W7K81/wgtsmfmpZ5CPScAA
         Z8soUsdfyrMoipb3c73AYkO+JFJ+T4ZrOb23L+E6+ZjyaitFFJqFjcz7Vm9S9o3rWCx5
         wmBrVNaqDXC594pgCYdMC3fYTVDvhZJ4yKEctr4pm1woe8xQhHDX39r4siTNpG2s2oQu
         +Ry5FZ4Q7N66v2TpYRIJTmbXD57kuYTYQGNK0AaIyaAtZHOTeh5WPjE71n8dZYC8pMTn
         Dsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4Uo8oC0q+k3/BuQcrCo0FLHeLVxH/nrRmm5Yh0sXuo=;
        b=p1Bzgb6vcdkzWs8iB33frE0V9QgpUm/Nz745lzul8afeZtnhmzNk9kromlhnWm/8/g
         /VeARzygB1kQQZUCr4pbnmWtIEvgJSGXEnXA0G+UExOToUHX0QB3Z1KLv9NQZHsM2I1i
         X8xPhasUpEN4VlxCQ+O3TP38SBSfDSG/3lE+fKdj9gkUFMbM8oEh8li332j1ohJ6o/Ct
         VoJcNFtIZZ+MXOndik3rM/n2r6vJNrUUkfcy3BMaXZ2QeWDTEPFDRS+ewHjgK6HYjN/n
         vTVVCm+7BPlqhfH0YpWm0xg6lyxuTaZrQSQuBd0eEBvsFI8ztSypIwGSOFCgkTCQzec4
         grKg==
X-Gm-Message-State: AOAM533RmCIYK04f4xRYk8IcfJSyZdS9aOBERldlcgFKUObOsalWKstg
        N6/+VP3XCLrL0rwKifYJRE+ym9HNJN4=
X-Google-Smtp-Source: ABdhPJx1aSGZR/V4p9ArJLKexrO6w/tcuIGBi3Xug+TG0A2hl9p1z1ZDAbPksQ8QTTGYe45Mbev5GQ==
X-Received: by 2002:a05:6a00:b86:b029:207:8ac9:85de with SMTP id g6-20020a056a000b86b02902078ac985demr25341671pfj.66.1617036616584;
        Mon, 29 Mar 2021 09:50:16 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m1sm20482pjf.8.2021.03.29.09.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 09:50:15 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] PCI: brcmstb: Use reset/rearm instead of
 deassert/assert
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jim Quinlan <jquinlan@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210312204556.5387-1-jim2101024@gmail.com>
 <20210312204556.5387-3-jim2101024@gmail.com>
 <20210329161040.GB9677@lpieralisi>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <71903454-c20c-31f7-aaee-0d05eb22db7f@gmail.com>
Date:   Mon, 29 Mar 2021 09:50:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210329161040.GB9677@lpieralisi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/29/21 9:10 AM, Lorenzo Pieralisi wrote:
> On Fri, Mar 12, 2021 at 03:45:55PM -0500, Jim Quinlan wrote:
>> The Broadcom STB PCIe RC uses a reset control "rescal" for certain chips.
>> The "rescal" implements a "pulse reset" so using assert/deassert is wrong
>> for this device.  Instead, we use reset/rearm.  We need to use rearm so
>> that we can reset it after a suspend/resume cycle; w/o using "rearm", the
>> "rescal" device will only ever fire once.
>>
>> Of course for suspend/resume to work we also need to put the reset/rearm
>> calls in the suspend and resume routines.
> 
> Actually - I am sorry but it looks like you will have to split the patch
> in two since this is two logical changes.

I do not believe this can be easily split, since there is currently a
misused of the reset controller API and this patch fixes all call sites
at once. It would not really make sense to fix probe/remove and then
leave suspend/resume broken in the same manner.
-- 
Florian
