Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7013F2C8FF5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 22:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbgK3VZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 16:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbgK3VZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 16:25:10 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E776C0613D2;
        Mon, 30 Nov 2020 13:24:30 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r2so7229728pls.3;
        Mon, 30 Nov 2020 13:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8kmpDktJoo+tgdDQX4wx7doucidziNB384DjMU2vgfU=;
        b=OECFAO2Z4EXAK273apV4X6gtv5Igmme0KM1JkZfGxtLkos7GUSVPNpATZvVr/dMu+J
         9+bqK7zJzhwiDXM1ik2B2FOTNSnCSz0hZvcMXNKfExNy10aRW9eGE3WxK2Gl4RRm154Q
         NnmN8ilWx/kDES/Hb8ezdOp0Qsmo4Zac+wxim83OJMFxQucPGM625oYwrcwm0LpJSEnv
         pyREbKkS/X1/6m2nrunKLh28Aww46dVVr/Q9Ft0Ak98g5VHhE2qSjpv4UdYGd00Zff7T
         RD3wkiZHptotqafo9iPT/bg8RwaP6qoquBHKvICU05LtfqDRanXSw8rXJKtVJTeOB6n+
         8XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8kmpDktJoo+tgdDQX4wx7doucidziNB384DjMU2vgfU=;
        b=My1YpcTiSGg4bazNttsxcD1Z+lzQ+FvkPGW2C7iIvnU3PjdCkPaK8r9ixfW4F9djj5
         58VGHrKyspV4N7nIM+O+lYV/1nR+nbYKkLmsP6Klm0YRKD8B+/vMJ1okU64pyjpjBSaZ
         g9sD6NTdk+JuCScCC30d5wgsVq7dyithX0wC1mzf957NJdHR06z5i1GoSGmT3EPJu68V
         ACu8VEHJrLKK/L4bBWsIKcmjPQXHypxHhkH5lrDjrZfBPbSF61+qRTab/lJAH9g3y22T
         R1TUw5FSfDyP6Hf0wanXT+C+ys6vVHGkQcBghhXQyYtflAy/faIc4Oe1od5xaB9OHGu/
         1+Jw==
X-Gm-Message-State: AOAM533Wf8ztWdZlbET5Ouqo5KFw3p1knbwsbbpyR5SPZect70MV0VlW
        HwiUXccYOchstqroHQqcrsTB2OSK724=
X-Google-Smtp-Source: ABdhPJxA7fhHW1/ofDc7MRmxzqtQV6aW3jzgbVKACSS+8SoPHoQDTyjNo7IF4Y5xLzVIRinmrAP7Vg==
X-Received: by 2002:a17:90b:1183:: with SMTP id gk3mr873137pjb.191.1606771469424;
        Mon, 30 Nov 2020 13:24:29 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e23sm17741675pfd.64.2020.11.30.13.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 13:24:28 -0800 (PST)
Subject: Re: [PATCH v2 6/6] PCI: brcmstb: check return value of
 clk_prepare_enable()
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-7-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f2e23cc0-5e74-790e-ee85-6ff36f420b26@gmail.com>
Date:   Mon, 30 Nov 2020 13:24:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201130211145.3012-7-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/30/2020 1:11 PM, Jim Quinlan wrote:
> The check was missing on PCIe resume.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Fixes: 8195b7417018 ("PCI: brcmstb: Add suspend and resume pm_ops")
-- 
Florian
