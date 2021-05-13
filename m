Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2AA37FF7D
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbhEMUzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 16:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhEMUzA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 16:55:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB88C061574
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:53:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z17so9033963wrq.7
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JQ+t5CMI0lQ+Fa9m6Xr0yhHPfZfx88H3jWVW72Ltt4k=;
        b=Ad56b0e39PkG4Od0HBJlnxZw/xvPUMhValpJkKRwoAfkWcfeq4sMCs3gBCDi6P/m/e
         2tDwLwLcw+6vIQr0nbdL2+BrsR/ML25oTsZLRJDXf335FrCFLAEcdX7pdldA0en2t3zJ
         WHw6v8ggxl2wdV/CwD98+OMwglbWtKVKJddEGskekgXMXCkpCXLSrzuWcSZToFKCLaTP
         RBVDbUwh9MGJekHlIb45pejj4eaQ7hDupmRsUQDZLi0GlGS/P6+NkrTyOr/m36DupJ6A
         gvD5QClbnsnNC+u44+NZJubSeaX1h/7eQ/5PcyACpxuZEs/TF5Di7IcEwh5yUelwJH/W
         Y47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JQ+t5CMI0lQ+Fa9m6Xr0yhHPfZfx88H3jWVW72Ltt4k=;
        b=IdUM+Gi/Sx7cAtp1wAnbJScweoJCbM9+ldsn7bQQfl4ZxwOmTpQfFtH86CLV1KVrvv
         cSqPvguvFXjuarnbu4D+T+JU5XzVNevy4Pm6bqy8PBxZDjF/YJ6XxoHFgAp/N+Tkx33p
         fnpRAklLeoXxvr05Rcjj/cz8l7wwrO7mX2+DnVgOjZK849mgLyHJs1tFMhP5Ix31yP1y
         138fGpJeNFtP/W7wGJv/Je+39yB2beobzGI0fhre4VOjbTim3L37JZo6m9OenuejFOQ1
         iOdq3Fwi07KTniA9yr4yAIR4co1QXKmk43EoOupTvuZ62Nm8p3KEbmYW78ZzQVVWEC9V
         OsIQ==
X-Gm-Message-State: AOAM5319Extt6N5YhGIkb5G91Ltw6+L+ht7I/JLYBW/1V42uVVgMa0Mt
        yjH+rCKnP4Qy3ipaO/TUjOVNVc1PovYSNQ==
X-Google-Smtp-Source: ABdhPJz53i8DPjHzbte7qJ0My2cEKDZgale8YrX1nbkBvTxhAiB/Bsmda1XsxMo+/QfkW1mALvKWTw==
X-Received: by 2002:a5d:64ac:: with SMTP id m12mr7265629wrp.158.1620939228506;
        Thu, 13 May 2021 13:53:48 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:dc15:2d50:47c3:384f? (p200300ea8f384600dc152d5047c3384f.dip0.t-ipconnect.de. [2003:ea:8f38:4600:dc15:2d50:47c3:384f])
        by smtp.googlemail.com with ESMTPSA id f7sm4591536wrg.34.2021.05.13.13.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 13:53:48 -0700 (PDT)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/5] PCI/VPD: Further improvements
Message-ID: <dc566e6c-4c9b-bcd5-1f33-edba94cedd00@gmail.com>
Date:   Thu, 13 May 2021 22:53:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Series with further improvements to PCI VPD handling.

Heiner Kallweit (5):
  PCI/VPD: Refactor pci_vpd_size
  PCI: Clean up VPD constants and functions in pci.h
  PCI/VPD: Remove old_size argument from pci_vpd_size
  PCI/VPD: Make pci_vpd_wait uninterruptible
  PCI/VPD: Remove pci_vpd member flag

 drivers/pci/vpd.c   | 106 ++++++++++++++++----------------------------
 include/linux/pci.h |  43 ------------------
 2 files changed, 37 insertions(+), 112 deletions(-)

-- 
2.31.1

