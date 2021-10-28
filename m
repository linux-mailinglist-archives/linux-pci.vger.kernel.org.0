Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D85043D9D4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 05:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhJ1DZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 23:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhJ1DZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 23:25:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E863C061570
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 20:23:20 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v138so6166647ybb.8
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NPjIQfctzixLv7pT3zjBhQeVIlz8HY7I9t7l7QHSP68=;
        b=iYCfC8s6dhNlPkDBW1QcuO8AreZ+ePCINviCVJ/TCd7sMXqC9xonMa7/9Gm26ZsepA
         WLMsC9FlnDbTgRkOqpo1aCrHsjpj690WcQs8ykJCSW/eYg3wyp0GDkY5w5iZez/Gyg7A
         AuYTVnbXWCrtNpGW+xaL59fvFX7C84gcwfzGCCPDo5WU0VWHNKKnuqAtYb1r9wVD813L
         05kuY5INn0+ZlZSPYTIgTlb7iT4iBbA2GZ8oUC1jsy1NddrAw+XujpRS5aboUrK8gFtt
         KIXthXLit30XV81D6H2PuhxJO1T7/WA5nGxzzbMOkg8GeB+exJY1+T8oVfQTcNhSVPKK
         e5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NPjIQfctzixLv7pT3zjBhQeVIlz8HY7I9t7l7QHSP68=;
        b=ad4j0F2yWhdx+51XFSYXzY3gx8fk5T/EORJUcgaZycrMYz/+0d6YUbNlYZ931zcPYq
         5V9B3RehXfF30ejDySQ5V/tZPrCupIw/zExGe0ntRzPuIqlGO27jYU24FUdJu3QJ8iRx
         9BYXiFZ3SImwgSzi5JTCoRW3OxY0hC//1LRjsZHRNHsNnhg/1aZ2iGdnr4ypQdbKcwit
         V+sCx2TVY/mImnecoGl/CsJHf9K3D5zheXVN0ovBTquDFoeG3wNPYwdfbikpfmXvR8Ih
         KwZnTwU6Qf1fKtqK5dEfM0xwBf68wi84udu4bg6+jrVRXNbPaJ6vXHKOnNFkgdGqYcml
         c/aA==
X-Gm-Message-State: AOAM532saymjsa1NUfuQbtc6u6ilOL1uHjS8WjUJJLoXe2iUE1VUJaDw
        7SaRHNKt3IhErEEtOuHHwmxM6VOqW9IHnTM/2ghVjYyGEng=
X-Google-Smtp-Source: ABdhPJxkfOrbk4vB2qfYoOGojcCvU0AilKW5xeXPkZMEN19E7IO7/mBd0x5ZnNE7Eoyjw/9VMTe0LSMCuaWyWnkNNCU=
X-Received: by 2002:a25:c344:: with SMTP id t65mr1883294ybf.409.1635391399633;
 Wed, 27 Oct 2021 20:23:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:97cb:0:0:0:0 with HTTP; Wed, 27 Oct 2021 20:23:19
 -0700 (PDT)
From:   Amol <suratiamol@gmail.com>
Date:   Thu, 28 Oct 2021 08:53:19 +0530
Message-ID: <CA+nuEB9ZyD-uX3GFV=9LDWXibqekwvNDV+UEu8EwyL7NG6YjsA@mail.gmail.com>
Subject: pci_check_and_set_intx_mask(dev, true)
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

If pci_check_and_set_intx_mask is called with the intention of masking,
and if there indeed is an IRQ pending, then the comparison
"mask != irq_pending" evaluates to false: the 'mask' variable is 1, and
'irq_pending' is 0x80, in that case.

This state causes the function to return without masking, contrary to the
behaviour expected of it as given by a comment:

"Check if the device dev has its INTx line asserted, mask it and return true
in that case. False is returned if no interrupt was pending."

My vfio/pcipassthrough setup sees INTx line asserted as the VM is being
shutdown, but the line is not masked; the host kernel panics saying
"nobody cared" - there's no handler.

Is the inconsistency with the pci intx masking really a problem, or just a
misunderstanding on my part?

Thanks,
Amol
