Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A5E166DCD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 04:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgBUDgz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 22:36:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44426 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgBUDgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 22:36:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id g3so269192pgs.11;
        Thu, 20 Feb 2020 19:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ZVITalxr0zACv67WhCn8mXrnEG7g8ElF3YeRI2boGk=;
        b=ACaSaiEVherPWZpY/4OhNEaNJCeHRnGC0qiiAfVBniFEjAdY0MOlJZIcDV8yBF4veE
         lcsxsyJcTZ0YIMDqQ/CKYzqI+eg319ks8PIlv+6YyHmygs5ZCz9OM0tjpATNuDAOC12H
         +M9iAuji08j3cwakHNrIbfpBtHalWZLoeptIqHWzZ6Joxegiox25CjOBltcwJEChhT+2
         +3fZ89oenXQiPPMAAjZV3Oel6xCGHLQdjensxfa2rw4kBbyNbhitPXNGP/d/dqHkC8jG
         WN7MQoobVFjRMUP0ZPFWBdvXxyAewa7Bi14Sd1YtnXwNyMPggMHtKVdBGcZ8TAXvlmVl
         r16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ZVITalxr0zACv67WhCn8mXrnEG7g8ElF3YeRI2boGk=;
        b=brMHTgupXTzjgjiESNX3JXkt4X8GEL7M4YsZDcCAn2Vbm/+mosQQlPX6qxgcBOZgWl
         gsJjkoqKF8m+E52xcRnYC5dgh9e9yJcH6cgr9TIa2lpQrrxQvS5ahp7gRNrnFC2xNSRX
         jGcINReFaLAtW4M+LNYgLnElzJ9nNWyTdrSTQPtAgMYa/0WH5b1nRFLW8OiiLEN3BCOS
         7uTKmBLXPDSLV4olpOXTXWCQ8CprZfiJ+YJBKBg6UHGiOywj0jugnUpD/JqYeTjjTOuk
         2wM6CgD6OMkObvByCZ5oLFQS0Offd+TASAA1BTQedKcX1yJs18ztNpA8nI/k7Mm3/FAn
         Z+3Q==
X-Gm-Message-State: APjAAAWq6EZ7Ef+88shnDEQXikctj6NCWexhbNrSTgBIBUHqbh8/Q+N8
        pLRMiXK362yUe+WBJTn1/Ss=
X-Google-Smtp-Source: APXvYqz3vCnJLqlVJxxqA+HHKpIJcZ0nTQQOE9j3jO9o9J1n5iRzsN1qIxwi9EnSS0fkXtv5NQiq4g==
X-Received: by 2002:a65:420c:: with SMTP id c12mr35065463pgq.270.1582256214283;
        Thu, 20 Feb 2020 19:36:54 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id d4sm781340pjz.12.2020.02.20.19.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 19:36:53 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
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
Subject: [PATCH v2 0/2] PCI: brcmstb: Add Broadcom STB support
Date:   Fri, 21 Feb 2020 12:36:38 +0900
Message-Id: <20200221033640.55163-1-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series supports GPIO based regulator supplies for its power supplies.
and this has an improvement on devm_ APIs.

Changes v2:
- Remove incomplete 7445 based Broadcom STB SoC enable codes.
- Add devicetree description for supply-names.
- Use -EPROBE_DEFER if the GPIO system is not available.
- Remove unnecessary #ifdef CONFIG_REGULATOR
- Use devm_regulator_bulk_* instead of devm_regulator_*

Jaedon Shin (2):
  PCI: brcmstb: Add regulator support
  PCI: brcmstb: Drop clk_put when probe fails and remove

 .../bindings/pci/brcm,stb-pcie.yaml           |  3 ++
 drivers/pci/controller/pcie-brcmstb.c         | 37 ++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.21.0

