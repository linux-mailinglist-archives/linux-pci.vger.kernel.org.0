Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BA486761
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiAFQJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbiAFQJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:09:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D31CC061245;
        Thu,  6 Jan 2022 08:09:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso1787077pjo.5;
        Thu, 06 Jan 2022 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fC0CiGsNq+HCwmp3jjwL9PAFJwUiw3GqDWvVqeNxRBM=;
        b=mk1AZ7M/s26oyznwaeHtpA3mIhB7kSBVZRL4LG8ZHURkcpD6U/XeBe44HpRPeVqsuJ
         ngNfYR4DEYASBuToJJxdcathKbMyyb0WjIZ0BXzRDfOOtYAdKlSTYfGJ+vQKT6NkhNh2
         xIf3vbHGy7zgB4dXUKJl8yzwdkXJ7EUESncfJbeANkUb930ApMhT2ljuoT5r0xlJL2GH
         cjQ1rxlaApuD+6HeInyd5rLNMnoqVKxsnWWq6bkwVDRtnZ3khQvw2nT1aWCrwjfH+fGT
         7mfizu84Bd14wcoKUJsJOs2Z8Y3a9yMd5faOZXEpdsb40g9LoX1pSRiZI+qgjf6I+EiB
         nVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fC0CiGsNq+HCwmp3jjwL9PAFJwUiw3GqDWvVqeNxRBM=;
        b=MVPndLvsT2jbVzNCM17k5IEQCIfJ7mJU90GL7hfTGkkC+mnBQVghALZCLBmjGLvi6b
         ElCSji2MkxiBa/DgNXG8v9N8u1awgRI5gzm7avJEaJ9HoKRVXDLyulGCCRshgKg0UcVb
         35TeLiult1sG7EGoppjlN58P9cktZUopO4EWTsOYWv4fW6kQvRKYC6rp8arO8e3/aBKA
         fZEn3oikabFMss/542Jwwk17z1gvb2H0GJtGd053Tlk3lsJ9a8dERmJCi6Mi+k0vrfBn
         l0rcpS/VsRaLnIBZq+QjpE7fM8+Ho0USLWYTHj9Jl/i6yU0nQr6R5G0gFK6BXIlREMUV
         anYA==
X-Gm-Message-State: AOAM530Wspv6w3N06IRyxWP7oQRb+XuhZkoORExsD6hxc23slR9J6Xg8
        /sNOgzu3yz5QlX/37flGIctFY7bE6sU=
X-Google-Smtp-Source: ABdhPJyRomRCzjYTTxc0qd4FSDF70Tm7FxgsUtIlOnnnxBWPEHwG0fA80Mep8+HUo5q/1XX/q1DUaQ==
X-Received: by 2002:a17:90a:e7d2:: with SMTP id kb18mr10858620pjb.111.1641485378437;
        Thu, 06 Jan 2022 08:09:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m68sm2381710pga.30.2022.01.06.08.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 08:09:37 -0800 (PST)
Subject: Re: [PATCH v11 3/7] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220106160332.2143-1-jim2101024@gmail.com>
 <20220106160332.2143-4-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <990faca8-a366-c66a-85fa-6ec9361f6b67@gmail.com>
Date:   Thu, 6 Jan 2022 08:09:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220106160332.2143-4-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/6/22 8:03 AM, Jim Quinlan wrote:
> Add bindings for Brcmstb EP voltage regulators.  A new mechanism is to be
> added to the Linux PCI subsystem that will allocate and turn on/off
> regulators.  These are standard regulators -- vpcie12v, vpcie3v3, and
> vpcie3v3aux -- placed in the DT in the bridge node under the host bridge
> device.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/63
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
