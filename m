Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3346420E3C8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 00:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgF2VSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 17:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729795AbgF2Swu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2020 14:52:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FA7C030F19;
        Mon, 29 Jun 2020 09:26:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i4so8248442pjd.0;
        Mon, 29 Jun 2020 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w+DmP+C5HpOoE0pF5Z5NBc0Vqj5wfx4GqPu5fUO5SGM=;
        b=NhrbggVY5sSA7Uyq25kP4AEcu29RMFWffcjdoxn8fLYgfOV5WcqwQ+YNsQo+QMriEo
         vBkbD0/gUBC4SMrWBXdHrfVIwe2gSA+ICRHqVuafLo9YZ8qmhSQVanuTROaYj5Pw7LJv
         5S7uEacqlfYOmg1qQEHcf834yWYWQRAsGaPxYkxQyvpjJmnRI4n+C8tSrKNaoJ6VaGH2
         yVUsvnNDIji/TzBiS2aYdSB4wozC0ZIpPYyZ37Om2hWvgzpVEp6kaZgIue60O01DKAQp
         PujheshRs6shypUCOuemDko9Xkl6aVdsWJ1EetsmsFkAM5rsfOkbEWbeJqyEbNCn8XDb
         lKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w+DmP+C5HpOoE0pF5Z5NBc0Vqj5wfx4GqPu5fUO5SGM=;
        b=T5btMXH3oGlE5XHM1I+kCQyJBYviGmqKhjhgdOlpPgMuk29RGxTWlfjijwGKLY8H1p
         CtwGzgU2r9IeDjpwGjHnLgBAmBnCF7GOEgOUWMuD6OQAnCXBfQ3Z02ai5z77nk9B9E1l
         ci9T36esAvJdQ5zeGPIbb1gUJHJYx/SIwcX5YPntdRRtOtRplybHqSSAre6/AKethiZW
         Ow6UHMvA/9OXY+imvwhzshFSU7W5taPawwqnHgK0BvMW9dNKrGkonTVwtehNaw+eMVmn
         L1ok8+6Pt3vUERqcXUtP+Q/3P2QD1Rq6Rqp/mv0sv7XoFHNC9sPYQwLKFYAJUPKpP+oj
         uzPA==
X-Gm-Message-State: AOAM532RNayVw5zCbfV0MAIa7oA1CP4bB4XY+ki+h3+Xa6zYR2NyQn4/
        kurJLbhnP3cjOQPML+Wt6Fg=
X-Google-Smtp-Source: ABdhPJwYMqR9MGGMB/wlqZcfyW8f9Ks2SubK7+20EyaN9ZO5KJ9PLbCQa+GSdhDr4AMPO4oeLPCiiw==
X-Received: by 2002:a17:90b:f97:: with SMTP id ft23mr15508228pjb.21.1593447970738;
        Mon, 29 Jun 2020 09:26:10 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x7sm206783pfp.96.2020.06.29.09.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 09:26:09 -0700 (PDT)
Subject: Re: [PATCH v5 4/9] ARM: dts: bcm2711: Add reset controller to xHCI
 node
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de, andy.shevchenko@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com, lorenzo.pieralisi@arm.com
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
 <20200629161845.6021-5-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8490b6d4-1e9f-f7c4-71f1-8b04605924a9@gmail.com>
Date:   Mon, 29 Jun 2020 09:26:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629161845.6021-5-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/29/2020 9:18 AM, Nicolas Saenz Julienne wrote:
> The chip is hardwired to the board's PCIe bus and needs to be properly
> setup trough a firmware routine after a PCI fundamental reset. Pass the
> reset controller phandle that takes care of triggering the
> initialization to the relevant PCI device.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
