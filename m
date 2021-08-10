Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5FF3E57FC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 12:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhHJKHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 06:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbhHJKHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Aug 2021 06:07:41 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38601C0613D3;
        Tue, 10 Aug 2021 03:07:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q2so20279873plr.11;
        Tue, 10 Aug 2021 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/WTc/jRXHtXJWj+Wad8h2vDSBuhiirpHVCKMKslUCDg=;
        b=TNzlV9OG9ouGtp33JYXV2CuqznwDNP+DLbiBbjPq10lw0tgYJQrVP/+stIoYG4DXet
         B87oFA8bW29TZO5VXi2mOwA9Rk3vZXkZ80ISTqoP0SE3+1OxsVzP9hTM+rLn0uz/LCGE
         +MKiFdsXZ6HFdR5FJTNDZ0dLjDLyMeSu0qmO+2oP7qzz1NQFdYQ0mo7CslWrZtMDxYqk
         ww0SI0/bW4NQaPo5cOCiMiay3F5TWMZkyzimhZYDYpzGde+9z0BW+PP61iFT1w1ZNLb+
         J54pBg8f8UjIP6T0Cmb9kBMSs2oddz0yD3GyW0JYhavYjirW7xymU0js/JVMWdw/eYe+
         EXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WTc/jRXHtXJWj+Wad8h2vDSBuhiirpHVCKMKslUCDg=;
        b=oD98Cq46TLunVWDj+Ii2VmbDhSvUIVCl+Ihr6V+kZbyk2ttKTrfSgpYSN4VEHSqGyr
         +jRR73I5JZG+TsitkVS901iEZ4fmeF2sQyhdWfiIeJmvPDU5PVnH7BTxpK7QWsbd+EE1
         PsXsbMtRJrGZCN828k/JlMz+c6Yt5Sv0hAP76UQ+cnrPGV6ISHd/RmDLW+LvzuTl9ese
         Bocti5GGgrR3I4ieZ3zXgRdf1XQ8pbVf1IdXXzFiuWkQPndLAVt+ROaK0/pZM8H/zWxZ
         Puv1k0NZgmXJlmYPcDtxlI7pPSD3FAWJIAtrYLGmZB/mTbcRhAMPLHS/NOx+vXjpzMfp
         xLCQ==
X-Gm-Message-State: AOAM5311CWx/8+yrRMZ/QiZ/OuVLTx7YmIneuwCd/O0gRdAo39O1fgjj
        m0/sOaidRvQdUbNwKtWi8UIT4jMvcq6BfA==
X-Google-Smtp-Source: ABdhPJzQFOqSq8XNRMUD+FN2uxXqX1t0SFajo0UanRiC2+h2uFmQlLC6oXYrIbW9iIs84t6N9EOIAA==
X-Received: by 2002:a62:ea0f:0:b029:319:8eef:5ff1 with SMTP id t15-20020a62ea0f0000b02903198eef5ff1mr28642049pfh.74.1628590039333;
        Tue, 10 Aug 2021 03:07:19 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id bk24sm2421518pjb.26.2021.08.10.03.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 03:07:18 -0700 (PDT)
Subject: Re: [PATCH 1/3] PCI: brcmstb: Break register definitions into
 separate header
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210805211200.491275-1-jeremy.linton@arm.com>
 <20210805211200.491275-2-jeremy.linton@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f82761b1-fb7e-08b2-8bc3-c84d258e26d3@gmail.com>
Date:   Tue, 10 Aug 2021 03:07:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805211200.491275-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/5/2021 2:11 PM, Jeremy Linton wrote:
> We are about to create a standalone ACPI quirk module for the
> bcmstb controller. Lets move the register definitions into a separate
> file so they can be shared between the APCI quirk and the normal
> host bridge driver.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   drivers/pci/controller/pcie-brcmstb.c | 179 +------------------------
>   drivers/pci/controller/pcie-brcmstb.h | 182 ++++++++++++++++++++++++++
>   2 files changed, 183 insertions(+), 178 deletions(-)
>   create mode 100644 drivers/pci/controller/pcie-brcmstb.h

You moved more than just register definitions into pcie-brcmstb.h you 
also moved internal structure definitions, enumerations, etc. which are 
not required since pcie-brcmstb-acpi.c does not access the brcm_pcie 
structure but open codes accesses to the MISC_STATUS register instead.

There are no include guards added to this file (it is debatable whether 
we should add them), and it is also not covered by the existing BROADCOM 
BCM2711/BCM2835 ARM ARCHITECTURE MAINTAINERS file entry.

Given that there can be new platforms supported by this PCIe controller 
in the future possibly with the same limitations as the 2711, but with a 
seemingly different MISC_STATUS layout, you will have to think about a 
solution that scales, maybe we cross that bridge when we get there.
-- 
Florian
