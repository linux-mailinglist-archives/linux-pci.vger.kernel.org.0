Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD472C9013
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 22:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbgK3VaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 16:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388554AbgK3VaW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 16:30:22 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D415CC0613CF;
        Mon, 30 Nov 2020 13:29:41 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so397883pjr.2;
        Mon, 30 Nov 2020 13:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DWjJunM0Wmbz4s0jLkRrF2o5zQCdYXKHU/3KOiaHX/M=;
        b=S6efCwhAKHYgtmjmpD8Hzvbp9i8StDx5Lz4NYJ+CYPPhd1Zdg6rHUdBz7jUbMNU6pc
         941P4fvSONwd1o6AMsUgGYvTHbO7j4sVS79F+79/J/xzbJHw9JBfyKb4BUH7OXiwlsuT
         SVWeo/63fBGZs4O9zdSnhq4K4rSof2wTCioSBw1rdW87M7bJOVKhjR0aThQohLTNLxcR
         sMLmqwIdwPZ9azDp5kJsdiZTbQqrZeXL9d6Dd3FlLJX1OCIShw9PpGR6fBjz3406BkSU
         qOl+hWW4gB3cABxugXx+xI2D9dQs72JNVxS8BWQKU5ZSBboje0eKCKEFjYw4WyQEzr41
         aZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DWjJunM0Wmbz4s0jLkRrF2o5zQCdYXKHU/3KOiaHX/M=;
        b=k/OTXOQdqmbEpQxFftaQr+3jva5w5rc2YDvb9G00uuKb3tthCYUk1HiJIUXeZq1vvo
         6/OsSOlEZCpwwNNLDXReGHWTbte+kw6o6pBwB6HI54ZtDO2h8GxlnBq6VD/uY5cWug65
         Td69Jri7vVwywwUQR3ml3A7OCiokVoREXwvv0vwFwk/lXSQIVF0Wbm3w60wVx8tiUIJu
         VMOUVRh9T7REg9MPTb8VDRagsjMaPxvzTilJfybWzEzZXnY9O/PFEgv6N5Lbjo/JuXCL
         RM4GAVmh8UJOMu19VZMWkUS5N6S00SN0GRN9rNHcWQE/os3isw8G6o8nDPwSozqWuNvF
         XaGw==
X-Gm-Message-State: AOAM533XceXxsj2PmUqlCOf6xFPaLJRd7/OgLtBhtXxHRIN8HAqTjgzX
        1QRb856cARs56tN1ivzcyBglGqlg7Fk=
X-Google-Smtp-Source: ABdhPJx6xEcDW4s+3ILXmaqfiWlW4K6oWLF0llNuwsYlkl0IYU3Vc3Vujp6Hom2s3vThV73o2mcYqw==
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr897481pjj.206.1606771781097;
        Mon, 30 Nov 2020 13:29:41 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g6sm3923074pjd.3.2020.11.30.13.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:29:40 -0800 (PST)
Subject: Re: [PATCH v2 3/6] PCI: brcmstb: Do not turn off regulators if EP can
 wake up
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-4-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <611680c5-d889-41c6-a9ff-ac69b47cdb24@gmail.com>
Date:   Mon, 30 Nov 2020 13:29:37 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130211145.3012-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/30/2020 1:11 PM, Jim Quinlan wrote:
> If any downstream device may wake up during S2/S3 suspend, we do not want
> to turn off its power when suspending.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Looks good to me, just one minor typo below:

> +enum {
> +	TURN_OFF,		/* Turn egulators off, unless an EP is wakeup-capable */

s/egulators/regulators/

> +	TURN_OFF_ALWAYS,	/* Turn Regulators off, no exceptions */
> +	TURN_ON,		/* Turn regulators on, unless pcie->ep_wakeup_capable */

-- 
Florian
