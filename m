Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92B92C8003
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 09:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgK3Idd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 03:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgK3Idc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 03:33:32 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D9C0613D2;
        Mon, 30 Nov 2020 00:32:52 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d20so19856157lfe.11;
        Mon, 30 Nov 2020 00:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClilvVMD2tJwffd8c7E32QkN5iyGyLKhnLofRhHkx8o=;
        b=coCwTFLIURYzAqQ+hJgwYw/cJWD5nVvcij3P2Ghzycv8m+IWfUsun9lAFw6yUFG8bL
         7ym1Q4DQEeOo7sOhHIBBy0MrhSkYKSNzocakhmsK83DfI7CvOLvZoTX1sguFOLeR7kJc
         ckTetdBXR1L3ohX6ZLFyjLlXNZHvctPyZadZocBYYB5LDuZp8ebj68lJtwopJ3HUOWwJ
         G/XMgHC/VFuqq5ELdnHVNqCWIkc4hyRHqQE/Ow/6rZcMsD/vOH1rCz43tQeE0xgprfT0
         fpSXB9reArgi0i7/5BbVl7Kup06tCXZOHYa1c68ZjlikMBxy/7H3pwwJ9ddsp3l2AsWD
         de0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ClilvVMD2tJwffd8c7E32QkN5iyGyLKhnLofRhHkx8o=;
        b=YY+pDtycloOHavD3poeLlDsnadfelulIWutCIGQDbv2WvLReEZ6BDPIWBgfZoPfXUc
         Ysk4ghOFCp8XF7AQd2YLAleyXjp5FtlPFWsb226vcZwXpJuV/70tV2QH0YjoYNWAOGS5
         z7jgdZArIFodfWN/yYlFP1qy/qCA0d7zkFLdZ8O5UhyeF4PItS4ZuUaYaMor9l69+5ct
         4xMmrEG/RZjQWdkyesK5/3FNOYfXaijZVsH4xnzrLubpaUGM2J53nEZOhEu+PbYikxI8
         4K2hG9EBlZU6F3p/a5t/GHb+trXuLkOxQPHy/rCZpOwqnTNOQ2EPoKdekms9vU87mKkE
         5GGg==
X-Gm-Message-State: AOAM533P031bXVcBNIU6GLswG9EbQGikRY0PKH74G86p4s3QCDOYL2f7
        buRQPUH/v/fOMOMqGS/+Agw=
X-Google-Smtp-Source: ABdhPJx9nfT7AThLEG2ZaKttdKqqE63vSdmMCVAdV76InzuzBVoV0VtnGu5+6BqvoX/Qu+QnHml7ZA==
X-Received: by 2002:a19:c8ca:: with SMTP id y193mr8624445lff.150.1606725171006;
        Mon, 30 Nov 2020 00:32:51 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y81sm2355420lfc.100.2020.11.30.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:32:50 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 0/2] brcmstb: initial work on BCM4908
Date:   Mon, 30 Nov 2020 09:32:21 +0100
Message-Id: <20201130083223.32594-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 uses very similar hardware to the STB one. It still requires
some tweaks but this initial work allows accessing hardware without:

Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP                                                                                                                                                                                                          

Rafał Miłecki (2):
  dt-bindings: PCI: brcmstb: add BCM4908 binding
  PCI: brcmstb: support BCM4908 with external PERST# signal controller

 .../bindings/pci/brcm,stb-pcie.yaml           | 30 +++++++++++++++--
 drivers/pci/controller/Kconfig                |  2 +-
 drivers/pci/controller/pcie-brcmstb.c         | 32 +++++++++++++++++++
 3 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.26.2

