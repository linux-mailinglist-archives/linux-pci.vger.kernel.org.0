Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3637910A368
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2019 18:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfKZRhG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 12:37:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36700 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfKZRhG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 12:37:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so23473468wru.3
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2019 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o3onsAxcdCSVMT9wP5C3pAWBttyu/GDasTVkuGRwxts=;
        b=ZxojlnbpG1chj+2Uk+JMjXt7xE9rT3NDM/A7mr9cdTdLGBaRoswuJ2eY26ff2HP7xZ
         b9ZkX/M8hnGbMV2scgV7tCpgGmY5QYyeRwbU3SOHX8/9YzSUhAou6nZlyvtsoLbxfRxN
         ylCzoDNS9ymH4XmjEKabb8GEtFawb/HpoRSB3RDYCeQL4Il1jCSVqaOvWOUKYvlXogek
         HWRqu0Fb08ZQ6WTPXxQUrw2Ornwn50n4Z7mu7Gw4TDRAlJSgqvdLLerB+fbWEPTIyTJY
         MihphonvI0J7jF+bfAUiolJ1dWHm7PuLS03EZ7FEWbF43uFeFosItlH/EblE8mEjsBP8
         qpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o3onsAxcdCSVMT9wP5C3pAWBttyu/GDasTVkuGRwxts=;
        b=Ijyvaog64faEja2h6U5adMoNSLgPqDhM5wseHN9LManAV+XNB0ritCDj6caKiImNTV
         AkiQCjRdNqZ6O6LmUIjUUD5KJfJ8Tag2oF6rEu8F51sFmJoHuUDyeNIaLLVhxmYNBqVt
         znWsL1YmLdCCs2+b/da+KWMxl2F95G1vg7O4/MUNZoMkUnvSoWB97I7L9h4fmuKm+CkP
         GXL+1PVuBPpu11jgCMSjQlLd8enT6TDfP/Fjk1FtBnXw9GNZdqGLFk12D9EAht1iE/mH
         S7JxaAJ1+8HvA286k3wStLgKlG/VyTc1LK02M6GrtAVKdCpSlm6um03thDfX7/Sgn0AZ
         JJgQ==
X-Gm-Message-State: APjAAAVY9zDPSPRm1oGEONJjTQRBnKXNd4x4kQ8oGR8WFaGk+7xUk+tz
        EF74W7QQI1awE3yQeHwHSKy8/F9bu5xdoY4f
X-Google-Smtp-Source: APXvYqwJXPwldHGk26YVIoxFxkybsks6biw8yM458CHIbggRSvLXKeL4pOZQ+sSYdHSXBH4JwI4vRw==
X-Received: by 2002:adf:f651:: with SMTP id x17mr40181983wrp.114.1574789824259;
        Tue, 26 Nov 2019 09:37:04 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m9sm15092174wro.66.2019.11.26.09.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 09:37:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v3 2/2] PCI: Add DMA alias quirk for PLX PEX NTB
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <8855EF11-4B75-4D09-B1E3-CD668DE94C27@arista.com>
Date:   Tue, 26 Nov 2019 17:37:03 +0000
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C970ED71-21D8-44BF-9664-8B30217C9D2D@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <3cd1d36f-a8ba-92dc-f991-19e2f9196eba@deltatee.com>
 <8855EF11-4B75-4D09-B1E3-CD668DE94C27@arista.com>
To:     linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PLX PEX NTB forwards DMA transactions using Requester ID's that
don't exist as PCI devices. The devfn for a transaction is used as an
index into a lookup table storing the origin of a transaction on the
other side of the bridge.

This patch aliases all possible devfn's to the NTB device so that any
transaction coming in is governed by the mappings for the NTB.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/quirks.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 320255e5e8f8..1ed230f739a4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5315,6 +5315,21 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
 SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
 SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
=20
+/*
+ * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. =
These IDs
+ * are used to forward responses to the originator on the other side of =
the
+ * NTB. Alias all possible IDs to the NTB to permit access when the =
IOMMU is
+ * turned on.
+ */
+static void quirk_plx_ntb_dma_alias(struct pci_dev *pdev)
+{
+	pci_info(pdev, "Setting PLX NTB proxy ID aliases\n");
+	/* PLX NTB may use all 256 devfns */
+	pci_add_dma_alias_range(pdev, 0, 256);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, =
quirk_plx_ntb_dma_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, =
quirk_plx_ntb_dma_alias);
+
 /*
  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS =
does
  * not always reset the secondary Nvidia GPU between reboots if the =
system
--=20
2.24.0

