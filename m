Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0DF2D17E8
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 18:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgLGRyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 12:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGRyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 12:54:04 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683E4C061793;
        Mon,  7 Dec 2020 09:53:18 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so19296982lfe.12;
        Mon, 07 Dec 2020 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8G4LYnNwxuCXfhf4gYNHbwhjYAITksu5+6g315if4w=;
        b=Y1LcgZti3DNwD10J5wHf+Kgo+08202OXzrrmRglhTCPjGbp9NQEJuIvEmsJjCY6cRf
         9XeZWE3kDPP+muUwtGFyioVKnjErRcmeUbowOdExgZe9/NpZn0BQCaanE5RdO+E90h3h
         ajHAymlZD8z5B7p9t4+OaGQ/ADMl/hOdtC1YO4okYKZqo2obNlicGpEkrprs4cNrYcs1
         vVKo8FasiP8k+jCMMIfHiLKeszkFwsxzeU5wlyVpe1kPVBmn4FPAWcmOI5Bob/x6S81S
         puN9svkRCPBYMwGoU9AKsVtFZ1tdJALqD382k3lPvCluzcg6gEFyeypIptTlNU+YfGAT
         JJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8G4LYnNwxuCXfhf4gYNHbwhjYAITksu5+6g315if4w=;
        b=gTWoLeplPfbK4OHv40qQOkqQVj9UO4FRTdD+19iLCugSE+HPyf4N9+u7oLe4j/Kp8i
         zfYvN3xwKqpdr1sUtE0NKAxWZYUxKI2omSB7yo3yLyGibXFMyr0PenpflcycUodlQnU8
         nhF8T/xR2dn8MShfzJbTGv9wxyavhzYTPlxf+80tInZ5K0OE+V9vJucqvlV2gSlQzFVg
         9d3i1nyQwR0leCHh1Ju4+7tRXgJaxnIw/Pf35TbGmz7garlS2fi0ACuUOmSPSBLSqdlf
         Tr2MBYVx5WyprpZJWEEyKDX3CymKJjDs4GsRexejVUrXvrNP+HQka6TAU3YeqYvGinKb
         j9xA==
X-Gm-Message-State: AOAM5334yTwA/haGC3wGe+wgssEtjIj6B0/a90qE5+v8IPj9YMOR/oWS
        ZmtW2y67Or0rsnWC81JclfGJfyJ5GI6IdEhhLMTlIgYU/HcPFrDd
X-Google-Smtp-Source: ABdhPJzprrm7/EaeY0yBGSvRTH8B/M4j7E5+MD895W+M0tXQJFB7tId1YohOWX6O7JXBaKFPfYR4u+bDDSJO8W8ySaY=
X-Received: by 2002:ac2:5503:: with SMTP id j3mr8818154lfk.94.1607363596782;
 Mon, 07 Dec 2020 09:53:16 -0800 (PST)
MIME-Version: 1.0
References: <20201206194300.14221-1-puranjay12@gmail.com> <20201207145258.GA16899@infradead.org>
In-Reply-To: <20201207145258.GA16899@infradead.org>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Mon, 7 Dec 2020 23:23:03 +0530
Message-ID: <CANk7y0jqS+Crf4Z3k82DXh2qxn1JO9KAO_CJGrpqH6xAJYU6Qw@mail.gmail.com>
Subject: Re: [PATCH] drivers: block: save return value of pci_find_capability()
 in u8
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 7, 2020 at 8:23 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Can we take a step back?  I think in general drivers should not bother
> with pci_find_capability.  Both mtip32xx and skd want to find out if
> the devices are PCIe devices, skd then just prints the link speed for
> which we have much better helpers, mtip32xx than messes with DEVCTL
> which seems actively dangerous to me.

The skd driver uses pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
to check if the device is PCIe, it can use pci_is_pcie() to do that.
After that it uses pci_read_config_word(skdev->pdev, pcie_reg,
&pcie_lstat); to read the Link Status Register, I think
it should use pcie_capability_read_word(skdev->pdev, PCI_EXP_LNKSTA,
&pcie_lstat);

Please let me know if the above changes are correct so I may send a patch.
-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
