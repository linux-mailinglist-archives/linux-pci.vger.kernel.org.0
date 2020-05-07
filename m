Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1811C9C06
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGUR6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGUR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 16:17:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDD2C05BD43;
        Thu,  7 May 2020 13:17:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so8305515wmh.0;
        Thu, 07 May 2020 13:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RGbtCswDTgsFLypisMjHemhGa1gfh6xqfnI2J9mGaYg=;
        b=R8QxXSAb86c/ioq5vI1vsHGKZAkJnzS0DjY/yFt4eMsepV8vaoHS7ZCD83RtZ/885H
         TxzAt2Cte98AukbnMPo/tifw8WNX4jiywLIHbptOiZigyefuc0CvUA5MkOtVtBxaqIGq
         28BfQPRl7QrOU5sTJBZUZkpEoXENQdthEOrYEBeA8BiI5nh9g32reDAGMkTQTBx51I2c
         iXasH7C4hOpwVoKs5JSUhkMUm2KlWVp3ZRyBYoSj3pQ3sL86cGXRr7U5edt3AT0+3i5Y
         tGijdyZsEJal8BjKIYa/ta6q2A7x0hPVAc5BhcrJyavNicNvpBoUBwphuj767IOzFX1/
         xZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RGbtCswDTgsFLypisMjHemhGa1gfh6xqfnI2J9mGaYg=;
        b=XBlM1dPQqrTbhOlzQ/g9qCU8NN01jD7F6bzIJybkgor87hs+g6TNXrNqbVK9k6MBxf
         IUjDWARtep77jv6uhmoRseucBWLQWlz4QwqVp8NNYYMq04VKp6DRCYhVPetGCcRstyOm
         0SN5XYrF0Gvu3/DeDyb6mzIYR6nGZ7RAENcovibSIuNqVofLzA9PL6F8HFqPYv69ZYRq
         rt1SgVVWuCjxOciJ6VyP7OW/1oz+DagOWtFXrw5Kt6B8pxVHEWSkB5FP3y1KflY1z66I
         98hReRVoySYFv1UVHK5i5qPjsWGOm5YwQKzSt04+cVCPzV7RFDDxVkMHXA51IzKemVnb
         WP8A==
X-Gm-Message-State: AGi0PuaJ1c57BUoGK2pV5bBn7h0VGRxLLdb2DhB3V4UoyTUKMVsAoepd
        L64TmTzowof9B9H2qvnVN7pEIkug
X-Google-Smtp-Source: APiQypKwYfOoUWjK0tabjGOtcz+Wjakktm4C1Yp0U1VLzErywtiaT2qObR3zUpmGxLPYLmn62ifkmA==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr11401308wmh.141.1588882675802;
        Thu, 07 May 2020 13:17:55 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u74sm9942459wmu.13.2020.05.07.13.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 13:17:55 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] PCI: brcmstb: Don't clk_put() a managed clock
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200507201544.43432-1-james.quinlan@broadcom.com>
 <20200507201544.43432-2-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8c8ac461-c6e9-0362-a30c-eab48cfbdae1@gmail.com>
Date:   Thu, 7 May 2020 13:17:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507201544.43432-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/7/2020 1:15 PM, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> clk_put() was being invoked on a clock obtained by
> devm_clk_get_optional().
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

This one should also have:

Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host
controller driver")

not sure if Bjorn can add it while applying.
-- 
Florian
