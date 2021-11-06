Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F0F446F9D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 18:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhKFR6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 13:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhKFR6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 13:58:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A96C061570;
        Sat,  6 Nov 2021 10:55:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r4so43906495edi.5;
        Sat, 06 Nov 2021 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zgc5pP1VxU3Q5Xe2Bd5MwgwRWQTa9N08JUnp9m7NMII=;
        b=kcpQGRkJedLF8i6bCPMo+ZGUotORkW9NoYeOYOWxyKcRwwWj4eB/ucVvAxuyeCwMNs
         nizGsEKF6RBLOHdDdvosrvSY88F0iCpP/7foH1Q+/YBI4+RPtlt+y/t0mzYiKvgUsWBQ
         m0gIJWjrN7a4J+Ry3+nuWMx+MdUKisesbTNzh9WeImO6MqpVshjsyfpy5bvhmgkdZ8gb
         CzZyOYyzqhu9SeIM96ysPg/PkMvFJdAxW3r/0rq1r0BnbDEUpA7Y1BaMniQINoix5UKs
         S5svPfi+df2YtW67xU6gKgijhtRBH71toYLrB6z2+ke5qMRbNx2cmgjx7qFBzXt9Ko3H
         kR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zgc5pP1VxU3Q5Xe2Bd5MwgwRWQTa9N08JUnp9m7NMII=;
        b=ySKyLitXkA0qCKSDLcivWMpck9oxP67fZH92tnHcIF9EwIFxAUHnDmSp7M/HjMZZkT
         9Uik+jstngzkSywnoN57j+9YbqZz851muoLcDmxn/lcPABJMKfR3RLOt6TN1hljurkQd
         af057ezVSY4VU72xedLTvbqR2rlLcCzwXmiOuWESs/4IWD4qOo96iYeR1VIF27JAh6gS
         4VRZOz4R2oE8Cp67gueQmj6LY9ZktR1ERcfEAgKYuBxKi/NXR+A50QPSaltBE4mq65ZO
         b2qQsiYRQR7zcwf3OOZrfufxoPxSQ9RWtcGpTi5ZLITS9hPS7OSTb8x1uVpHpjXVxjXW
         QKIA==
X-Gm-Message-State: AOAM533CAjD4TPReFfGpasgnzSzsMhsP2kcZbjOYwwSXaqiSeggL6U++
        gsguPnHF7elIq4DVNcd15kY=
X-Google-Smtp-Source: ABdhPJzPbl75zdGWSbvzGRgVtT4k/BD0ax/olw3Vf/AJhOvl6Q77Suu/peUI/QqEYwTRerwSNbPo3Q==
X-Received: by 2002:a50:d50c:: with SMTP id u12mr90209644edi.118.1636221349878;
        Sat, 06 Nov 2021 10:55:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:109:9f0:f6a6:7fbe:807a:e1cc])
        by smtp.googlemail.com with ESMTPSA id j3sm5742310ejo.2.2021.11.06.10.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 10:55:49 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] Remove struct pcie_link_state.clkpm_*
Date:   Sat,  6 Nov 2021 18:55:43 +0100
Message-Id: <20211106175546.27785-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These series removes the Clock PM members of the
struct pcie_link_state. Another member is introduced to mark
devices that the kernel has disbled.

VERSION CHANGES:
 - v2:
	- clkpm_default and clkpm_disable are now left out.
	- improve pcie_is_clkpm_capable() based on review.
	- replace pcie_get_clkpm_state() with pcie_clkpm_enabled().

MERGE NOTICE:
These series are based on
»       'commit e4e737bb5c17 ("Linux 5.15-rc2")'

Saheed O. Bolarinwa (3):
  PCI/ASPM: Merge pcie_set_clkpm_nocheck() into pcie_set_clkpm()
  PCI/ASPM: Remove struct pcie_link_state.clkpm_capable
  PCI/ASPM: Remove struct pcie_link_state.clkpm_enabled

 drivers/pci/pcie/aspm.c | 82 +++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

-- 
2.20.1

