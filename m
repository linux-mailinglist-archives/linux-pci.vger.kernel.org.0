Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7057A1BE444
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD2Qrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 12:47:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:58214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgD2Qrv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Apr 2020 12:47:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C680ACF2;
        Wed, 29 Apr 2020 16:47:48 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, wahrenst@gmx.net
Subject: [PATCH v7 1/4] soc: bcm2835: Add notify xHCI reset property
Date:   Wed, 29 Apr 2020 18:47:31 +0200
Message-Id: <20200429164734.21506-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429164734.21506-1-nsaenzjulienne@suse.de>
References: <20200429164734.21506-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The property is needed in order to trigger VL805's firmware load. Note
that gap between the property introduced and the previous one is due to
the properties not being defined.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 7800e12ee042..cc9cdbc66403 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -90,7 +90,7 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_PERIPH_REG =                         0x00038045,
 	RPI_FIRMWARE_GET_POE_HAT_VAL =                        0x00030049,
 	RPI_FIRMWARE_SET_POE_HAT_VAL =                        0x00030050,
-
+	RPI_FIRMWARE_NOTIFY_XHCI_RESET =                      0x00030058,
 
 	/* Dispmanx TAGS */
 	RPI_FIRMWARE_FRAMEBUFFER_ALLOCATE =                   0x00040001,
-- 
2.26.2

