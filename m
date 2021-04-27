Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338AC36CBBE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbhD0TgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 15:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhD0TgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 15:36:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B00C061574;
        Tue, 27 Apr 2021 12:35:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v191so312748pfc.8;
        Tue, 27 Apr 2021 12:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZMPrTbpcRPZqLLWfJUV6/8gKwil/V2GxAivfmlOoGDU=;
        b=Fo3ZZx2whMOA0w3yRY3563soue/j2+CXIv8haxx8QIgXXkkVtxvvi45s73nOgknLx1
         rvrzZnf55N4G28TWARtQKtNc3guhKts3JLb6n+CEWIIBn/rh/qOBNe9ZvNT5jixYaL6t
         +VJ/FE4amGmMkcmc113faY3jB+wIYJyEKjF8f7TFuAacca3+QIs7JikmfgOOHvsHC/0X
         sJNmn4VpWDvXafeyYnzfXVDnbAOkYziogAW0/JIzdsh+8bnP+7uxCqAQJ/N0K8J2ckVw
         QiOP4maXBsz1acPZA54JA9Kl8Hzzci19rXDb+s/LxckRqrFmbHVJkJX7KHFXkchW9x57
         BlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZMPrTbpcRPZqLLWfJUV6/8gKwil/V2GxAivfmlOoGDU=;
        b=XLeMtTirLBbpEXXwzvHkKEzpedoWQhFXEam4/l3hisbvtHSfw8KTo6DGpLQnDjRL3r
         n0CN7QhIrm0Uo0r7mbNNUhsbIdZytsoWFQW3COI70Xo5W4qTrMtiLr0qZOGYgD2nojPE
         pzT0y6QiHyXG9/maZxsLGTxqwDt1l3dsaXpYo/XwJ3sIp3hYiHb6qDDQcNdk5EWupZdj
         zxrZYwCEHiiHyA47clIS8IBxwNOu42QaJZc+ZixBQu4HYyzUSn2AqcWsjHR/1r07sGUq
         I2Bbb7fIUvZnHw54Ldma9oj3AXcB1Q0YnIYL7RgNUvFdO2NYghYHh3gxN0f4eFrAXbN5
         E/pw==
X-Gm-Message-State: AOAM530Bb/WzFqMj1mBt/u8XmoQo/lXjWXHzQDPMbb82a605pD7HZEig
        qZWcZHEE9HEycN7EII6t90TwXYjZMg0=
X-Google-Smtp-Source: ABdhPJxOyxXu3eWopTKSKy1TEPelHm7VC8hk6tUk0rppNeruFZfSxf9pW4kyeSEpztKiG08TcD1RHw==
X-Received: by 2002:a65:6216:: with SMTP id d22mr22642011pgv.87.1619552137521;
        Tue, 27 Apr 2021 12:35:37 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o127sm3292967pfd.147.2021.04.27.12.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:35:36 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: add shutdown call to driver
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210427175140.17800-1-jim2101024@gmail.com>
 <20210427175140.17800-5-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3a5a67e0-4554-f581-91b2-a8098814a9e9@gmail.com>
Date:   Tue, 27 Apr 2021 12:35:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427175140.17800-5-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/27/2021 10:51 AM, Jim Quinlan wrote:
> The shutdown() call is similar to the remove() call except the former does
> not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
> if it does.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
