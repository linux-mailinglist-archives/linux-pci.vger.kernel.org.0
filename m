Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A31175EC9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Mar 2020 16:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgCBP4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Mar 2020 10:56:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:51256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgCBP4G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Mar 2020 10:56:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE405AB6D;
        Mon,  2 Mar 2020 15:56:03 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net
Subject: [PATCH v3 1/4] soc: bcm2835: Sync xHCI reset firmware property with downstream
Date:   Mon,  2 Mar 2020 16:55:25 +0100
Message-Id: <20200302155528.19505-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302155528.19505-1-nsaenzjulienne@suse.de>
References: <20200302155528.19505-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The property is needed in order to trigger VL805's firmware load. Note
that there is a gap between the property introduced and the previous
one. This is also the case downstream.

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
2.25.1

