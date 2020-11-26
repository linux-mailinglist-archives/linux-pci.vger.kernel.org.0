Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE72C5688
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgKZN7z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 08:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbgKZN7z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 08:59:55 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6DC0613D4;
        Thu, 26 Nov 2020 05:59:53 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id r18so2470665ljc.2;
        Thu, 26 Nov 2020 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZG3tBvgmcTRtmbn+04hDRbu8RUfmou2BtGKfSHPxAlQ=;
        b=Y1DLSL1vsj8I9mDx8SJOePV7ImL8lcwqbP3DC/tEYyKimc3t9gZ2rGCCMUDOtGumsh
         MURKM36M72eBsJXFQr5zpQwU8cUgSBy58sZf9wBtJWj7JiFpYNbzBUUkdGfk5C8kKksh
         vVukLwQAcTbYaFiTgy7H61shH8QUfzsteOSz92mfuLaXT3TqeByOdfMmAXnsULNZvy8c
         4jVcnpVdHzi3EW4oINZGMsZiz4M+zok+St6MHalyy5BpxXhBXYGgk7Inbba9B1SWO/+V
         pLFN0HeeY3Op9bWL2r1YXjPlqj1Xq2r5MQpRaj7iBPW9B7wifFtZX6dId1xR4E5xLy9L
         kvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZG3tBvgmcTRtmbn+04hDRbu8RUfmou2BtGKfSHPxAlQ=;
        b=bSBXQ6PJtbndGZMwwhr/9ZeqZzftnauymwB7TkNZ2/jmR7BVa51BwQW2H9k2XghpK2
         zZ/PbpLo24UsKh/rFudaurFTzMqY0M3NEcVh4zeB/4UL3hpk4QRAJeW06OcgX3NfkuPn
         UNub/KqV70O/aOkN83OZHWyf97nBoycanI2dPqsBNIQpZrCNWLiwGLnTPQ8Ap1KefCTd
         GRc71si4ivZpAZjyqkm30fICLT+DltMgoqt+D3zBP7E6QRIg2muDO8PbbuI3jeh85kxk
         nIrmjZCjNipQdhOOZkb+piIl54zqVvLWBIPXJJ9zoBzwW/Dg97J9a+KE8FZtH4QX7ZGL
         bR+A==
X-Gm-Message-State: AOAM530oxaulPHOh49FIVbwFbBd5Fv/JCzBvRR23vPxb9zm8n4m9/gFH
        oD9mZdA/Fq7sLuyVrviuZ40=
X-Google-Smtp-Source: ABdhPJxG8wWBowJeUWwXjj4yR924GARKPrvsba4es5fxW2XTe+Y1CEJjvZKXocS+DlISBsuknmyn5Q==
X-Received: by 2002:a2e:f09:: with SMTP id 9mr1381806ljp.261.1606399192056;
        Thu, 26 Nov 2020 05:59:52 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a11sm605188ljj.4.2020.11.26.05.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:59:51 -0800 (PST)
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
Subject: [PATCH 0/2] brcmstb: initial work on BCM4908
Date:   Thu, 26 Nov 2020 14:59:37 +0100
Message-Id: <20201126135939.21982-1-zajec5@gmail.com>
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
 drivers/pci/controller/pcie-brcmstb.c         | 33 +++++++++++++++++--
 3 files changed, 60 insertions(+), 5 deletions(-)

-- 
2.26.2

