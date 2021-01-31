Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3F309CD4
	for <lists+linux-pci@lfdr.de>; Sun, 31 Jan 2021 15:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhAaOWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Jan 2021 09:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhAaNsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jan 2021 08:48:22 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036DAC061574
        for <linux-pci@vger.kernel.org>; Sun, 31 Jan 2021 05:47:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so13701102wrx.1
        for <linux-pci@vger.kernel.org>; Sun, 31 Jan 2021 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kHPDX/mA2r0E6Yt46pEVCGybNvRisrwzhopl+6yNVpU=;
        b=GhQVznDGmtvLwkayLscQ2S8pJbN1ImCmD2wcAXerJEBdUsXGxNSOxBNjxC3AVBrVW1
         VJx2phNgnEXEQv/boOUTBLYkfm8lXrPeKIYMHf+OV67/Y07qfZ8/oxCBX1vgWGTiKVjE
         2ru4okm8lHpf2kzEN6u3Rt82uls05Mx7uN0eTEs0EIwHr1yHe7IKDmm0Xg5XnXxmhYBj
         pWnbWnBKQgD9ogPKY51l5PghuxCCdnlBO4YzQ/OB6qZ9UUtpTahPJXNILa+VpPTDCTpB
         VT4iZ7l0iLFeMySs0j4jK2Hoj+O7m7mzNaPsFwWIcP5bPoq4Nc+TjEL+INDO/JHGWKDC
         RDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kHPDX/mA2r0E6Yt46pEVCGybNvRisrwzhopl+6yNVpU=;
        b=IkegBPLRLNKLh7Q7CTC2NBCeU4RCQE2XzpxEQy50RkZxTRHoFGikJwIDpflad1MiAE
         QYWIn9OO3jCv1HqLABLBLyCwceWPRKriLxORCqFVjvCHDIgrPRGXAx4QD8S+rRV6afol
         NRZPOoVJT6Z9APPrkUhdSwkN7nwhOeRdSOi/TquIIyGgNJSk/Dai8ai7+k7jeAqVhD3h
         NN7dkLGRELD1AXC+2+W+Dcz4LANe2/UvO9HpZwKiUxKkjKjdVVZQu2izK5uey36huJbm
         UJD1++rtf4HWfiNKaHBl6Z7Q55aydjzUS8Dmdoah7FvwH380baMEnh7tM8bLiXgniJNP
         IziA==
X-Gm-Message-State: AOAM533n3zoJ1GiBEaxK0e8qW58mpGJHNiJF833lDG/2zs7qXQWFKXkm
        bi3Q9uZCzgtnWbnQvxAxi1axp1buZhg=
X-Google-Smtp-Source: ABdhPJxynyFKZ7T+TmuQuEmPrwcfqd9B4oJhZSSuIHZd0cOOUQaL4UFzeqZRxp3FEnsBqWNH2NLrQA==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr13676040wrx.230.1612100860338;
        Sun, 31 Jan 2021 05:47:40 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:f567:4a48:ca7a:6e1e? (p200300ea8f1fad00f5674a48ca7a6e1e.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:f567:4a48:ca7a:6e1e])
        by smtp.googlemail.com with ESMTPSA id m184sm19369559wmf.12.2021.01.31.05.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 05:47:39 -0800 (PST)
Subject: Re: [PATCH v2] PCI/VPD: Remove not any longer needed Broadcom NIC
 quirk
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <daa6acdf-5027-62c8-e3fb-125411b018f5@gmail.com>
Message-ID: <c45e82f0-03ed-397f-474f-30f1a09a5cd6@gmail.com>
Date:   Sun, 31 Jan 2021 14:47:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <daa6acdf-5027-62c8-e3fb-125411b018f5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17.12.2020 21:59, Heiner Kallweit wrote:
> This quirk was added in 2008 [0] when we didn't have the logic yet to
> determine VPD size based on checking for the VPD end tag. Now that we
> have this logic [1] and don't read beyond the end tag this quirk can
> be removed.
> 
> [0] 99cb233d60cb ("PCI: Limit VPD read/write lengths for Broadcom 5706, 5708, 5709 rev.")
> [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

This VPD patch and a handful more are still sitting in patchwork as "new".
I'm inquiring because I have a bigger series of VPD refactoring in my tree
and wonder whether there's a chance to get it into 5.12
(being at 5.11-rc6 already).
