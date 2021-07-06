Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6C3BC63C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 07:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhGFF7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 01:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhGFF7E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 01:59:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A46CC061574
        for <linux-pci@vger.kernel.org>; Mon,  5 Jul 2021 22:56:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i20so31950989ejw.4
        for <linux-pci@vger.kernel.org>; Mon, 05 Jul 2021 22:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oev8bK/RMJFPIudm5NvU6vH7ZqFEgw7k7Il2DlvsNWQ=;
        b=SbkXHbrTf2HOT6FlQSG7XnQOOAXA7A3XwPZUJoTLGIiawFZrRZoqPU2pLykWC1wVFJ
         3osuQL0+0N7mwdwDpWZF6WmbOg72t8QWWcE5rJBDtF1o0pkqHnCgBS1tZGtTM4isO31Z
         X41vwFuF6g0g/yQUup57mhQpWUmIGUg80h9sHv2xDGiD8zfqTHmp/TT0+YerHfwJYThH
         JgsOGOLhwrr3DTKy72rD9mUKS5ukIJ2CPVDI63ZCFZREywolpB6Kd+SO1/zmE1/en1Ok
         sg6MhfZEU2wiLHBgv+eDuhbBzxNEq7GVnOnwhYbFBQsCd+A37/K0c4j5SSQDMBLDR5Dd
         Fe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oev8bK/RMJFPIudm5NvU6vH7ZqFEgw7k7Il2DlvsNWQ=;
        b=QCOCtnyUcMJHOk4ybIiwRdj/FBE6h/7TnWZFBdBhv9oWrKdOJFEDKUOCJoEMxy98kB
         GgCUf0ov4YXJwQGnN7nkwAGy6HGaH1ydvbQ80EXKn/6rEE15fydgQsXrba6b92Uihchp
         0pCEqmfxbk11K0Sncc5IN458UcTKoIKlKE28Zxw0jwaH4Jb3ghjkT8LeoE/GjK1q712l
         Y3y3+LpujcXpz149rjdNlcX2PPak0zrOe/6NEtDMWwlcfk1JtDlnqe08VLA51gAMKzLP
         N04Jl6hWM06AEy5udM3bXBZXaUo+WncNW7QZgYAr5xPXAabWWMSssEsOOL8t3H2bBUWc
         kZ3Q==
X-Gm-Message-State: AOAM533/e+pRM3doRw+la8jJJNGHvCtCqh4jp6j5fuZK1gdbnrSqbQuB
        2qKWK87l43nB7qtRWziOKYBCvpyszmy9aw==
X-Google-Smtp-Source: ABdhPJzVmIpW+xMnGUmPCQhw4SjLUf+rsXhTp0uNGVv/LR73jSCOE5SQyJHCHpW3N7L6SwoP5wGsgw==
X-Received: by 2002:a17:906:2b0c:: with SMTP id a12mr9282696ejg.429.1625550983852;
        Mon, 05 Jul 2021 22:56:23 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f3f:3d00:24c4:43e4:608a:943c? (p200300ea8f3f3d0024c443e4608a943c.dip0.t-ipconnect.de. [2003:ea:8f3f:3d00:24c4:43e4:608a:943c])
        by smtp.googlemail.com with ESMTPSA id jx12sm5202879ejb.9.2021.07.05.22.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jul 2021 22:56:23 -0700 (PDT)
Subject: Re: [PATCH 0/5] PCI/VPD: Further improvements
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Message-ID: <bfbdfbb5-ffde-c89c-db3a-d69941bf1d76@gmail.com>
Date:   Tue, 6 Jul 2021 07:56:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.05.2021 22:53, Heiner Kallweit wrote:
> Series with further improvements to PCI VPD handling.
> 
> Heiner Kallweit (5):
>   PCI/VPD: Refactor pci_vpd_size
>   PCI: Clean up VPD constants and functions in pci.h
>   PCI/VPD: Remove old_size argument from pci_vpd_size
>   PCI/VPD: Make pci_vpd_wait uninterruptible
>   PCI/VPD: Remove pci_vpd member flag
> 
>  drivers/pci/vpd.c   | 106 ++++++++++++++++----------------------------
>  include/linux/pci.h |  43 ------------------
>  2 files changed, 37 insertions(+), 112 deletions(-)
> 
This series is still sitting as new in patchwork.
Is it simply waiting for free review capacity or .. ?
