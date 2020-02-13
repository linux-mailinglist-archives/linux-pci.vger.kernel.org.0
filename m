Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6EC15B768
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 03:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgBMC7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 21:59:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45959 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgBMC7p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 21:59:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so2130053pgk.12;
        Wed, 12 Feb 2020 18:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMqWCu/u8fAYYp7TtyU/fjTB445DYU069x8bI/Oq0Zg=;
        b=twrJNR34IPBlGalnU5Q52YnLdupQZkfEwe0uaVoLaN6r4c2PsX88QgCj94Du6QR3v9
         zWvbwZi1zK6YUR2y6oXz/pRthxJcDK0MhpTlxEiZLhBtvu8EnWVH7dvPWM8RIJQC1XyJ
         PPyHqzcQKIb89W+ieGEGosUrsDsDyXAj/qhf1jonavRKUKLJ51aygQnQcy7TdF/uPja9
         xm3/qSqur6xuTNVWABGBtU5Dls/AwVyo97EI6ylo82Nizglf3jJV0CKjatXm/PbwIG7O
         B0U2dGb1riq294KmUlXdr/qsDoJPdn3gZ4hhfatpJt6tfT2fC/BncL0sGHxeQaB1yqJg
         tQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EMqWCu/u8fAYYp7TtyU/fjTB445DYU069x8bI/Oq0Zg=;
        b=SCcS9PIaGE/IfaJMNbcPfh16vGwlN5dLx18cjFnE9m3Tmz53ALnbvFUWENhqEVBVnO
         PTtu5Z/d9DqZQjIJf8ptM2XDksg5+qPviqXgonpmbK/6VaYAQ5se137bLY82+0dgCVx7
         O0GqmEqZ/pU+oPgcBCY9QDFAJoBcOgmk4nAzRHVEx10YbEoQ6Wqoc9BKttuwi/nq9PVJ
         iLrfRJa94EXSW/Pp+x2TPmhd3/IbIFcMw4oxwVM/rIQINRb6w7D+6r5/P7fypmjZsvI0
         2H+ZH+SPR0BB4/v318SIv1sr7D3NBBTtzk+/9GopKbTWhE4NaOTZYWB8raz43HG/P+89
         Gg7Q==
X-Gm-Message-State: APjAAAUc1KE0jYIR+aSz4fNkCZ62IOGvgs7kIAy0yMpeyqZ29x4+1d3v
        spuw/XrG3dSAnew/Q50MeKg=
X-Google-Smtp-Source: APXvYqwfRLPbJj1XCkk9zW4lToole8BO75rcB3EUWEwDHaxO6U1oC1lDB/SeSCgM5EHX3VkDbKaALA==
X-Received: by 2002:a63:a019:: with SMTP id r25mr11678998pge.3.1581562783322;
        Wed, 12 Feb 2020 18:59:43 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 64sm602643pfd.48.2020.02.12.18.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 18:59:42 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 0/3] PCI: brcmstb: Add Broadcom STB support
Date:   Thu, 13 Feb 2020 11:59:27 +0900
Message-Id: <20200213025930.27943-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series enables the ARM based Broadcom STB SoCs and supports GPIO
based regulators for its power supplies. and this has an improvement on
devm_ APIS.

Jaedon Shin (3):
  PCI: brcmstb: Enable ARCH_BRCMSTB
  PCI: brcmstb: Add regulator support
  PCI: brcmstb: Drop clk_put when probe fails and remove

 .../bindings/pci/brcm,stb-pcie.yaml           |  8 +-
 drivers/gpio/gpio-brcmstb.c                   | 13 +++-
 drivers/pci/controller/Kconfig                |  2 +-
 drivers/pci/controller/pcie-brcmstb.c         | 78 ++++++++++++++++++-
 4 files changed, 97 insertions(+), 4 deletions(-)

-- 
2.21.0

