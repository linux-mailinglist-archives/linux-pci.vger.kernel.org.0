Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95DE326142
	for <lists+linux-pci@lfdr.de>; Fri, 26 Feb 2021 11:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBZKaN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Feb 2021 05:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhBZKaH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Feb 2021 05:30:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9278EC061756
        for <linux-pci@vger.kernel.org>; Fri, 26 Feb 2021 02:29:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e9so5081176plh.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Feb 2021 02:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ipeLPmiH0nMH5KiGxsW1RmVlDVVUV3UPS90WzrIlN60=;
        b=d/IfawqDp5VuoQJYzbvaSJKDRvb4K3HW8Uythr9nk8BNAXk9OANSExmPGnwtHpINej
         G9TfHGEVgU7rRapv+nIyLvrT94ER49Lw9u5sxPgdFNDUD5nvqPNUY0DeArLjoPGHyei9
         QtuKmIgRu6vTNNAYE19PLMjv2DrxcAlhyamdn6cMVQW5BoStqo8cyuD+UmRiLHnmqtSC
         hNV6QczTzC1BjfCBbCcOajYkghKP6Wr4B2McCODGenT/md8Ypn5fKgPI+rd9SdGKy4zU
         B5TD70nDtXxpms81oiRtLcTWePiJMas+1Way40tV/abVS1jl+riV3rnDjnFrWeECTh71
         hApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ipeLPmiH0nMH5KiGxsW1RmVlDVVUV3UPS90WzrIlN60=;
        b=BCyuonWG3+D2n0sfAU3qDRYt12yvYADtMYCUHWmNZ2IXLjZpQAm/KS0cF3Pm+ZZm+2
         rBENKBGUEbl9UnaDUQ5FJP8iUDgOlEoIuVhjQeJiaMrZc5tZJF82STv0DDnk0/TRzfxz
         +m2kZ3O0bo/AIPHZu83/HJ2DXHeNbOJlkpV3gXKsVoPYOES4uyttmjEKbKbcmpVx9ovk
         sjMScByRW25L0Rh5emPj7qFviomolov2Ur0CLrA/yYuVupeKkGtPPjrKFDXdEBETOCAN
         avEDZ2cywplrlR6BxTnyOQIdf655Elu7zpKY0b/kvgMiKxTosy8sndYJJp4kPIipKT4a
         QlxA==
X-Gm-Message-State: AOAM531uIY8nOSx0wevz9M7pCbu095Q8OCmIZDDvjguUQRpfQ9d0HlBY
        Ur0nZhmv0iQKI+rLPYE3LS5me+Ywb6LIRsOWAL5rjA==
X-Google-Smtp-Source: ABdhPJwumt1FUFQNjdYx1MlgOTReistnXXA1j/v/guPEdHn5B8bme0IGIKoEXqD1nf/ZfKlbs23jBOyLFrK+rpYigxQ=
X-Received: by 2002:a17:902:8501:b029:e2:d953:212c with SMTP id
 bj1-20020a1709028501b02900e2d953212cmr2660056plb.49.1614335367042; Fri, 26
 Feb 2021 02:29:27 -0800 (PST)
MIME-Version: 1.0
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 26 Feb 2021 11:37:12 +0100
Message-ID: <CAMZdPi9PGWcPOHKk3cNU3Nw+hdVOsivLeXzqyd2FQ7nn8dDfvg@mail.gmail.com>
Subject: PME while runtime suspend
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Trying to support runtime suspend in a driver, which puts the device
in D3hot and wait either for host/driver initiated resume
(runtime_get), or device initiated resume (PME).

But, given that old change: 42eca2302146 ("PCI: Don't touch card regs
after runtime suspend D3")

PME that was enabled from pci_finish_runtime_suspend() is not enabled
anymore for almost all drivers in case of runtime-suspend. The only
way to enable this is by calling pci_wake_from_d3() from the PCI device
driver's runtime_suspend() callback, but this function fails if the
device wake_up is not enabled, which makes sense since it targets
system-wide sleep wake-up (and wake-up is user/distro policy).

So is there a proper way to allow PME while the device is runtime
suspended, without having to tell the user to enabled 'unrelated' wake_up
capability?

Regards,
Loic
