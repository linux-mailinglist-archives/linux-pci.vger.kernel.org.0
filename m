Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC622A35C7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 22:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKBVHo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 16:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBVHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 16:07:44 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5E8C0617A6;
        Mon,  2 Nov 2020 13:07:44 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so11854294pgk.4;
        Mon, 02 Nov 2020 13:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S6chzrEL1+q5/HgauCqurdMSLx7xx9lDVZhCmcZkHvI=;
        b=i20qXrob8eGMOn++YWhc8yAwCQckMLo+ZPm91OcoTYfl+jq+woJXpCvWm/OOEBOtx2
         9gm7lUogEu6BD2HCCHzZwe1wJuVEXcaxDXHaHO9ucDvVooLYG4tcIyk5HQUScWxPbNEx
         TIyH0ztC4G7M7rKVjmGzuMnIg+tykKdGK9V4RXGHH5XUT6JG3c+7wfGZgsr3lIOxI85c
         t2QBdiOVde3K8h++x37RRf66mbJadAQPy7ciwLyh7t7XbOiT4L9E12EgBR2jgmAoVztd
         EWnZKr7xpnS6BQFUyYM6cZ2jnz+RWJHLL6teiMm4lithfBWRtCGxqeHc+/WYvPtWUpk3
         +toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S6chzrEL1+q5/HgauCqurdMSLx7xx9lDVZhCmcZkHvI=;
        b=Yd5UwDfGKHz6E9YaC8Xf+RKf8seuGuZebaglfD5/jHIe+HggLd/53E8FocS67AShvZ
         9Q+EMOa4jUzEWs1Yi8tS+f9gfCuJHDHIzKq2X0DMIHHRnB20IVHyMf0dNRHMY/0lNLuh
         IndHXcRFBKFGkLr4Ri6eHgQTaerMDVyc2K2of2GZUxY8Q/PwmMbMSvsMi13qR2P8ixlu
         o4izxYY+ROcNc6rDol+J16+8+l5/p8v98gRD2Ww+pLj4+ajMkOBeDsJxJZaRNv4aoe2D
         Khw7RYYJ3Fi03X4gYqLh+WhchqaMZcgVSKNzRfzTOe8eC0SDhGRorwWVhClFW+4Nm/YC
         z9TA==
X-Gm-Message-State: AOAM531Xp0rMvH+tyTWVJzUpoFwAM21t+DCBopIS6RQCqffDMljayurZ
        E7SlwkLA1X+GnthmKHmyLKze8JJMGEI=
X-Google-Smtp-Source: ABdhPJwhwhWAg/9kMC4uwU1P0g1QPS9Bt7HIzzhx08xEMh/G2gJZAhWia0xLfQUhPM7oNFyIiWhIpg==
X-Received: by 2002:aa7:8a01:0:b029:15c:de46:5b2f with SMTP id m1-20020aa78a010000b029015cde465b2fmr22706776pfa.81.1604351263613;
        Mon, 02 Nov 2020 13:07:43 -0800 (PST)
Received: from [10.230.28.234] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g4sm3802203pgu.81.2020.11.02.13.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 13:07:42 -0800 (PST)
Subject: Re: [PATCH v1] PCI: brcmstb: variable is missing proper
 initialization
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201102205712.23332-1-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ad4cbee6-c52e-cedc-fa79-3805e36377b4@gmail.com>
Date:   Mon, 2 Nov 2020 13:07:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102205712.23332-1-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/2/2020 12:57 PM, Jim Quinlan wrote:
> The variable 'tmp' is used multiple times in the brcm_pcie_setup()
> function.  One such usage did not initialize 'tmp' to the current value of
> the target register.  By luck the mistake does not currently affect
> behavior;  regardless 'tmp' is now initialized properly.
> 
> Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> Suggested-by: Rafał Miłecki <zajec5@gmail.com>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
