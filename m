Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A9A1F7C73
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLRYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLRYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2020 13:24:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F87C03E96F;
        Fri, 12 Jun 2020 10:24:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l63so2175034pge.12;
        Fri, 12 Jun 2020 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yyx3aGH1IHsk8WwCSPgIF039LEqkrtOiEcxMrYeLSY4=;
        b=A+ATlkXI9Yn9pkdpGFh7hZhvaRHi4S8bNSQAlaaQ25dacfgjH5T3vn4K3ZTQv2urqZ
         30YuNP+iY2a8FZ89Z3Rfbsufy3rP9Hf7xO3DKkdSv4E35poG0rdTBUm1LNoUpfERvBmd
         yXzC2VrZhxFcWaCMCHpWEhUKnUDYl8KwnlSBxWv0gzxYdm7ZfU2fdi3FuwpQGPHLBSvV
         HvWUYmgpf6oE/Ehnfvzbf/zsCwK44SNy4J+ALNiq9APSP10xOmH2KWjmAW7G3jXPmxCU
         2WfYxMmx0rSleKywVZCoPOVBvixlE0cf4xDXI10MD9luPNDRH+rBiUvTqKeY0tmJeeYk
         6kYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yyx3aGH1IHsk8WwCSPgIF039LEqkrtOiEcxMrYeLSY4=;
        b=aEeyNA88rClrtKaq0y9BK3Dd2u3/9VmMB8scRQEeQzISXw4vtA9NlmYNG12c9Xw04g
         5CsYkOOX/p8WvBWzmlokTBzU4Hdl+i8UI8lUl9VmV8w1bsIPr/tk1jFZP5imgGHjDBqL
         YEYBVu4MmeyQAruoqE+Ne/i3nQ/ShfZ/Xp/2K9EdN8jHeQbzSoAUw7ZaWkBDBrOOANIf
         X8kdb+Akov25yJ1OHuolNJndRuufAd3TUwdVccN3o4fQWjnkjvgOz/lPjYc0kzk0dXKx
         3y2yY0vfCwMSAMgdGLMwLdB2acqglsmAbzkLZ3NXGhbpq8aAB2mC88/+RVyeykwAyeb8
         zGgA==
X-Gm-Message-State: AOAM532m4pMD5PRMWTyD32PCb7sCbbhOEXUphAPLU2VexZG/WR+bnrmn
        wSR6zpSU86dcwRhMo6QDrGE=
X-Google-Smtp-Source: ABdhPJzcMXRAo4TANZWsgs8un+/4P47C64drTFdnZEtpz2AR5bK8rHPpQQZyegMFr8iPbXvYl6TNwg==
X-Received: by 2002:a63:461c:: with SMTP id t28mr12227620pga.316.1591982662374;
        Fri, 12 Jun 2020 10:24:22 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h7sm5903409pgg.17.2020.06.12.10.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 10:24:21 -0700 (PDT)
Subject: Re: [PATCH v3 5/9] usb: xhci-pci: Add support for reset controllers
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
 <20200612171334.26385-6-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4ef2d78f-64ea-b56e-7971-a60190a05a92@gmail.com>
Date:   Fri, 12 Jun 2020 10:24:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612171334.26385-6-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/12/2020 10:13 AM, Nicolas Saenz Julienne wrote:
> Some atypical users of xhci-pci might need to manually reset their xHCI
> controller before starting the HCD setup. Check if a reset controller
> device is available to the PCI bus and trigger a reset.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
