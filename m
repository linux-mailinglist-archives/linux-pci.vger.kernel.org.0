Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3041730D583
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 09:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhBCIrs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 03:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhBCIrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 03:47:47 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1134C061573
        for <linux-pci@vger.kernel.org>; Wed,  3 Feb 2021 00:47:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m13so23206416wro.12
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 00:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=o6AMCjBmcUopUOvsKp0ZrY4Gx7sy0RLfMISVl53nM7w=;
        b=UzqB4mRyrP4af5/dwmXr22/yXk+80ShhshHdtH60fGz6Msgsb4AcpiGp6d9Dt4ZYtK
         tj/iWm2Sr4R6ZaDdafIoEOyPKff7iy7+eW/O382arJgC2I73AalPitk6Aqlq9vVTwQ9g
         Y6tLEKfxGAhuI7X5Rm0hszVx7S6db1928gOVbKTzfJhCqhxf35FtqZr40eq66EleGjRb
         2o5hwuH5KhvY/CwUpVzjz4ecQi0FtMVEPly6XZ6LCyNRQPD/1Ru8GGwTqyrXb9bzNYbD
         x6pNZZuJ9f73LJFLjNvUYwtpoGmqT67KQxyU3Wl9boEKpWirlTKxsgKXjF25LgFvRIXZ
         l9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=o6AMCjBmcUopUOvsKp0ZrY4Gx7sy0RLfMISVl53nM7w=;
        b=gqp6kwdWmXCW3vG8MdgRotSqyDreCHPeXCgb9/DSwszDqBnYXLz19d4VQqUP55V4n7
         wlM3B23A5kpryX820rrRDyb+BcnfGTCQwi02IR6HCxMoeMYF9wNBx12gEEKOiWxefz9T
         ktAu9GoamqB51IYZnlJaGPPN1cyKWZ2dHex8RonY86s15ICzDvHu2PJoZikLAA9AK4MH
         /Gu3ariF/gepRs3QvToyDCnDA7Vl99g8jneVk1HgN79pUQeHhN8Dnk81eumEblzILkKe
         5w3vzXri13wTZ6I4eqbK0iEm5Pdgqf9ouo0ZhcQ5fl6i0uTJn9bOMzGFePX1YABliZpG
         CTww==
X-Gm-Message-State: AOAM532VEmCKWzT/RMaDXx7mrm2Ddw0LhUUNuttZMby1/m+/ZLG4b3H5
        2tj2lPJQXYJ4YfZZXXypmkxsz0hKTOc=
X-Google-Smtp-Source: ABdhPJxyIRlWJFFPy1jn+jjR9/6XanIGOnPRjacxMhpJEldqLq5RebX3KUIQg60a/Ngm7DBmyZhHFA==
X-Received: by 2002:a05:6000:1372:: with SMTP id q18mr2184709wrz.280.1612342025394;
        Wed, 03 Feb 2021 00:47:05 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:ad00:f08f:200e:76bc:9fee? (p200300ea8f1fad00f08f200e76bc9fee.dip0.t-ipconnect.de. [2003:ea:8f1f:ad00:f08f:200e:76bc:9fee])
        by smtp.googlemail.com with ESMTPSA id t205sm1760932wmt.28.2021.02.03.00.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 00:47:05 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/2] PCI/VPD: Improve handling binary sysfs attribute
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <305704a7-f1da-a5a0-04e6-ee884be4f6da@gmail.com>
Date:   Wed, 3 Feb 2021 09:46:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
there's nothing that keeps us from using a static attribute.
This allows to significantly simplify the code.

v2:
- switch to using PCI sysfs core code in patch 2

Heiner Kallweit (2):
  PCI/VPD: Remove dead code from sysfs access functions
  PCI/VPD: Let PCI sysfs core code handle VPD binary attribute

 drivers/pci/pci-sysfs.c | 54 +++++++++++++++++++++++---------
 drivers/pci/pci.h       |  2 --
 drivers/pci/vpd.c       | 68 -----------------------------------------
 3 files changed, 40 insertions(+), 84 deletions(-)

-- 
2.30.0

