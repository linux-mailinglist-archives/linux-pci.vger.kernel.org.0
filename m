Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E641E86F6
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgE2Suz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE2Suy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 14:50:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EBFC03E969
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2020 11:50:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j10so4979370wrw.8
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2020 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xjPpNoGha5WCRQkzDxk7x1MBJdV0y0mLCGmaetFIpOQ=;
        b=oipedhNrWFG4+Ocf3H1WeXCSpq0snnOYFAyOgRB2nJBVL8wKIHOD/u6grRSHY/lAfr
         kAMqzDG5Tf1YvTuKSGxjrUsOQS8NZ7tudYVENDGH2EEqS9wVhMdhO1cFYhFo7INPjJtY
         8To54EUr/lobtYMhJ6BZsBe6sL9utF2WhOf5Jc0L8QN+Im84AwI2dvNIl4dxqHi2Z34r
         KLJ4QXMzGRry0Z1vlhkUpgH93sDAL76ZKvuWFOlQKg1yQRv/z1SoVVQrt1iOY9g8IqlL
         JL2yp6eIGZdqTX7GxQsvtGe2e0KD8tCXpRmzP6TxREpqAbhVIRqEqq52CamU2dtdNhFB
         m7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xjPpNoGha5WCRQkzDxk7x1MBJdV0y0mLCGmaetFIpOQ=;
        b=ftpjlPjPG7QoMZTKyaTSE21VqCv5N5VkK47wnamTtUtk/cuBGxn97N3xmQWQV4zPpY
         ebBhzWKFnOlpBTZUN4H4uv6Xp6ciynCL6fUBsJ+YU0PCz/uWazqNaRt8+H7XfMg9g9jc
         3gooohBOaeRKtCEe/FzY7IXIm14wBMBZ/dso54m+MG/N050dtzAHtc9fZrDokQFOWubu
         YoXrXRV+gN7V9+v6CgLNdz+qiCNzRT4obDUw+h/ssAbSxZ7msCvqdfOmtK4Auua2TcXq
         lJU9AN3leCi6Ls6Is27OxPMCESDT4JIkSgVD312uWDecgGKGcIeiaCDxkwHpg0Cx6f7I
         40QQ==
X-Gm-Message-State: AOAM530tHfXkDFbDWlF4uXJJrvTnvAAMR2TNzSTBgI8gyet2hMUDMu3+
        Dx772HMTc6a3G+QL574I69RWm4Di
X-Google-Smtp-Source: ABdhPJwo5EGsaMg1b+7U6dKwr1S6n/XINqFJRZ2Q2Hya52dXr5La2uNZZbJleIPQ4Sv4Qc8iDHlX+g==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr9843610wrq.222.1590778252744;
        Fri, 29 May 2020 11:50:52 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:cfc:56dc:3d49:4699? (p200300ea8f2357000cfc56dc3d494699.dip0.t-ipconnect.de. [2003:ea:8f23:5700:cfc:56dc:3d49:4699])
        by smtp.googlemail.com with ESMTPSA id p7sm10976186wro.26.2020.05.29.11.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 11:50:52 -0700 (PDT)
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <2e1ee784-7493-284b-96f9-96b2e0c4b817@gmail.com>
Message-ID: <e66a6749-29a1-af23-6d07-6b3c4fd45220@gmail.com>
Date:   Fri, 29 May 2020 20:50:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2e1ee784-7493-284b-96f9-96b2e0c4b817@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28.05.2020 23:44, Heiner Kallweit wrote:
> For whatever reason with this change (and losing ASPM control) I also
> loose the PCIe PME interrupts. This prevents my network card from
> resuming from runtime-suspend.
> Reverting the change brings back ASPM control and the PCIe PME irq's.
> 
> Affected system is a Zotac MiniPC with a N3450 CPU:
> PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port A #1 (rev fb)
> 
I checked a little bit further and w/o ASPM control the root ports
don't have the PME service bit set in their capabilities.
Not sure whether this is a chipset bug or whether there's a better
explanation. However more chipsets may have such a behavior.

W/o the "default y" for ASPM control we also have the situation now
that the config option description says "When in doubt, say Y."
but it takes the EXPERT mode to enable it. This seems to be a little
bit inconsistent.

To cut a long story short:
At least on some systems this change has unwanted side effects.
