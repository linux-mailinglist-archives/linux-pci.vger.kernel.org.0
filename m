Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF2217889
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 22:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGGUEM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 16:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgGGUEM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 16:04:12 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46A9420771;
        Tue,  7 Jul 2020 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594152251;
        bh=Ed/3Q7E4vJs5EEEvSsgo4t0m6Y1QmUKPsEeCTSlajUw=;
        h=Date:From:To:Cc:Subject:From;
        b=NpOwVTRcK4pi9d7+Ph7yi1fSUhNU4/YEm+Fl0RXO8wHxTESFYwqoV1mImsIQ2sM06
         P9JVxou3jRy9QRV71ZF69o3kZUYknlCsfn2Eb2nIrfkKCEafLBCy+h5jq3jIq4ZiHZ
         P/6FbXdK5zITYaHFKS/42MdBxKJQEeSQ5IWUJWUg=
Date:   Tue, 7 Jul 2020 15:09:37 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] ACPI: Use fallthrough pseudo-keyword
Message-ID: <20200707200937.GA5056@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/acpi/ac.c             |    2 +-
 drivers/acpi/acpi_processor.c |    2 +-
 drivers/acpi/button.c         |    2 +-
 drivers/acpi/dock.c           |    2 +-
 drivers/acpi/evged.c          |    2 +-
 drivers/acpi/processor_idle.c |    3 +--
 drivers/acpi/resource.c       |    2 +-
 drivers/acpi/spcr.c           |    4 ++--
 drivers/pci/pci-acpi.c        |    6 +++---
 9 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 69d2db13886b..2dfa08f939c6 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -236,7 +236,7 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
-	/* fall through */
+		fallthrough;
 	case ACPI_AC_NOTIFY_STATUS:
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5379bc3f275d..b51ddf3bb616 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -79,7 +79,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 		 * PIIX4 models.
 		 */
 		errata.piix4.throttle = 1;
-		/* fall through*/
+		fallthrough;
 
 	case 2:		/* PIIX4E */
 	case 3:		/* PIIX4M */
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 3c35e57dd854..a4eda7fe50d3 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -405,7 +405,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
 		event = ACPI_BUTTON_NOTIFY_STATUS;
-		/* fall through */
+		fallthrough;
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		input = button->input;
 		if (button->type == ACPI_BUTTON_TYPE_LID) {
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index e3414131bfca..9bd72c26ef46 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -469,7 +469,7 @@ int dock_notify(struct acpi_device *adev, u32 event)
 		surprise_removal = 1;
 		event = ACPI_NOTIFY_EJECT_REQUEST;
 		/* Fall back */
-		/* fall through */
+		fallthrough;
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		begin_undock(ds);
 		if ((immediate_undock && !(ds->flags & DOCK_IS_ATA))
diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index ccd900690b6f..b1a7f8d6965e 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -106,7 +106,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
 
 		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
 			break;
-		/* fall through */
+		fallthrough;
 	default:
 		if (ACPI_SUCCESS(acpi_get_handle(handle, "_EVT", &evt_handle)))
 			break;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 75534c5b5433..9325feaac5f8 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -203,8 +203,7 @@ static void tsc_check_state(int state)
 		 */
 		if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 			return;
-
-		/*FALL THROUGH*/
+		fallthrough;
 	default:
 		/* TSC could halt in idle, so notify users */
 		if (state > ACPI_STATE_C1)
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 3b4448972374..ad04824ca3ba 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -373,7 +373,7 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 	case ACPI_ACTIVE_BOTH:
 		if (triggering == ACPI_EDGE_SENSITIVE)
 			return IRQ_TYPE_EDGE_BOTH;
-		/* fall through */
+		fallthrough;
 	default:
 		return IRQ_TYPE_NONE;
 	}
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index d73b4535e79d..88460bacd5ae 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -111,7 +111,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 			table->serial_port.access_width))) {
 		default:
 			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
-			/* fall through */
+			fallthrough;
 		case 8:
 			iotype = "mmio";
 			break;
@@ -128,7 +128,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	switch (table->interface_type) {
 	case ACPI_DBG2_ARM_SBSA_32BIT:
 		iotype = "mmio32";
-		/* fall through */
+		fallthrough;
 	case ACPI_DBG2_ARM_PL011:
 	case ACPI_DBG2_ARM_SBSA_GENERIC:
 	case ACPI_DBG2_BCM2835:
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7224b1e5f2a8..0d85025c55fd 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -527,8 +527,8 @@ static void program_hpx_type3_register(struct pci_dev *dev,
 			return;
 
 		break;
-	case HPX_CFG_VEND_CAP:	/* Fall through */
-	case HPX_CFG_DVSEC:	/* Fall through */
+	case HPX_CFG_VEND_CAP:
+	case HPX_CFG_DVSEC:
 	default:
 		pci_warn(dev, "Encountered _HPX type 3 with unsupported config space location");
 		return;
@@ -1001,7 +1001,7 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 			error = -EBUSY;
 			break;
 		}
-		/* Fall through */
+		fallthrough;
 	case PCI_D0:
 	case PCI_D1:
 	case PCI_D2:

