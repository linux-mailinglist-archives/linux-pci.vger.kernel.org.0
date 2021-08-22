Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852763F3EB4
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhHVIxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 04:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhHVIxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 04:53:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED90C061575;
        Sun, 22 Aug 2021 01:52:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u1so8594413wmm.0;
        Sun, 22 Aug 2021 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JF6Zh6avYIlDu2Zmhl/mye0nrmkhYSCt6Bp3eS+Tocg=;
        b=O13e2oeA/KYgy+6+k49OkC7C2oEmD2hZ+y7VPhkFOhOGz5Vp0rByHT4Lc/PSUaLvaX
         U5QyrUPJvz7fyjR4YkxJJvCgQh1hHpbd1bzNuF3PdpxfDVGEyNIwLeBVZIihTjV+MsyU
         nhi81okeWZUN8BUEqCHP+R8xB8SnjWsZWEQr1yFSeQBdWt3/CawBiFZhJFDytCLh3lua
         POB/SEatspeXjQD6O7iJF1GfyFZvkBmO1Y8x3nImNGbOUng4eJwp1A4zi4z+K4AclmJp
         Wy+1Uf1ZGjl71WMt2OW1PBvtifFOATE7vFPy/B9JchPy+8Sy0Imv+SXLOQwa/qoyXeZo
         Z+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JF6Zh6avYIlDu2Zmhl/mye0nrmkhYSCt6Bp3eS+Tocg=;
        b=X5prMhiaoRNplLeJiaDvgV4c3ZJbDyIsCLAgLESVRyYtZJSdQj3XeaoI4sH1wI9qt3
         durVZNwBluw5VKPYb2BTqJM/ky7YONtRhqYcIYGMqTGBkOKOQMv+/ZWiakBqqLHjNs9f
         UEpXz68cUiY6tWWW+Px6J7wrSdlJk/VmoyXuO4s700VM2Sr3bIqCzFxmuxB03liH7YJ7
         BXuhyBArcN5UZiot1DcbQUy3XPhrRNdyXeHo7K42PYr7LJMKio11jWt53Vlj2IZLEO9c
         UJ6IMAv6PWHOcPf9hF+KJZqeaCHMAJ1CxhTix6ik/gNAqn/7SgduqqUAZ2T3Cj7/DK8m
         zo1w==
X-Gm-Message-State: AOAM532F3mDX9JPqJnaGYbus6tMhgHM4mh9unJA/E4LdDeDW50UP8gRm
        mrty3+5DUNQE01KOiPxa/QQZGQLdL2r3gA==
X-Google-Smtp-Source: ABdhPJy+5/Qyp89qbqbAg+aFoRbSXqDporku/I9fNp0g6zTjfr7dIfGKfDZbUsHByZ8o8PZv9WckgA==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr11402615wmg.138.1629622347002;
        Sun, 22 Aug 2021 01:52:27 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id r10sm13811735wrq.32.2021.08.22.01.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 01:52:26 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] PCI: brcmstb: Add ACPI config space quirk
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        sdonthineni@nvidia.com, stefan.wahren@i2se.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210819215655.84866-1-jeremy.linton@arm.com>
 <20210819215655.84866-3-jeremy.linton@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f2cc62e2-276b-e6a9-3b2c-48a61061be25@gmail.com>
Date:   Sun, 22 Aug 2021 10:52:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210819215655.84866-3-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/19/2021 11:56 PM, Jeremy Linton wrote:
> The PFTF CM4 is an ACPI platform that isn't ECAM compliant. Its config
> space is in two parts. One part is for the root port registers and a
> second moveable window pointing at a device's 4K config space. Thus it
> doesn't have an MCFG, and any MCFG provided would be nonsense
> anyway. Instead, a Linux specific host bridge _DSD selects a custom
> ECAM ops and cfgres. The cfg op picks between those two regions while
> disallowing problematic accesses.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Once you address Bjorn's feedback, feel free to add:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

I do wonder if squashing patches 2 and 3 would make more sense, 
otherwise we have a bcm2711_pcie_ops that is unused in patch 2.
-- 
Florian
