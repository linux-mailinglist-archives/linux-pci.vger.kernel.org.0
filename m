Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F21DB03C
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgETKby (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 06:31:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41761 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETKbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 06:31:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id v16so3019592ljc.8
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 03:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZhAJApvdVEbRnnMLJINfcNLhhh6Q2H44kTqbk/8lKo=;
        b=F0ivMuvP2/1EIrEon60Fz7DVCdVkN8V4Lpk3JqEISIShB5AyPscdlkQkDUmxoiC2aK
         kgMdmBV62KB68SCipmDLSxpRWVDzofvLr9s/7gZKzEpH9ddgtYdJTAyMEJgq7iSY8tBF
         j5Q0PRNgpQCQpyZbUZALoHlJ4A5wKx67P1fpu8ibOs4cVFkv7RSyPVxeZwFzp8xZBift
         ky53wbMv/8Uy14OV8551i2VpGlIR+rMZK5/orLignm9CfZf/9pTkA4wvZsFRa3fUAIaq
         mKmiXnK0gHC71JpZx2NIRpxe4D+E9xm9GwMr+39JRc0aV8xNRW4oz2couBvRsfCV+FDm
         V13A==
X-Gm-Message-State: AOAM533JjGweSQTSpu/cOjSa9BVYXzc/dkFGH0ZsZc8VZmYvMBoEV5dt
        HoAnuhdgWnpN4mtSfOjilts=
X-Google-Smtp-Source: ABdhPJwUeJm8FQocI6t8tBtXiPyGoFW0b/UE6gmhzorSuAGFtK/8ZkWgvgsHP08a9kyFZUFPOx81BQ==
X-Received: by 2002:a2e:8511:: with SMTP id j17mr256413lji.136.1589970709907;
        Wed, 20 May 2020 03:31:49 -0700 (PDT)
Received: from localhost.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v28sm967404lfd.35.2020.05.20.03.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 03:31:49 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: Correct the PCI quirk for the ALI M7101 chipset
Date:   Wed, 20 May 2020 10:31:45 +0000
Message-Id: <20200520103147.985326-2-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520103147.985326-1-kw@linux.com>
References: <20200519214926.969196-1-kw@linux.com>
 <20200520103147.985326-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per the specifications from the vendor:

  - "M1543 Preliminary Data Sheet", "M1543: Desktop South Bridge",
    Acer Laboratories Inc., January 1998, Version 1.25, p. 78

  - "M1543C Preliminary Datasheet", "M1543C Desktop Southbridge",
    Acer Laboratories Inc., September 1998, Version 1.10, p. 126

Both the ACPI I/O and SMB I/O registers should be mapped into I/O space,
but the second quirk used to claimed an I/O resource from the memory
window which is not correct.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ca9ed5774eb1..c71fdd8bd6f8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -654,7 +654,7 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
 static void quirk_ali7101_acpi(struct pci_dev *dev)
 {
 	quirk_io_region(dev, 0xE0, 64, PCI_BRIDGE_RESOURCES, "ali7101 ACPI");
-	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES+1, "ali7101 SMB");
+	quirk_io_region(dev, 0xE2, 32, PCI_BRIDGE_RESOURCES, "ali7101 SMB");
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,	PCI_DEVICE_ID_AL_M7101,		quirk_ali7101_acpi);
 
-- 
2.26.2

