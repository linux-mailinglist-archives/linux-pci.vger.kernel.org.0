Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACACAAD81
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 23:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfIEVBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 17:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbfIEVBF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 17:01:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0985C20640;
        Thu,  5 Sep 2019 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567717264;
        bh=NQJ3aMo3ua2SkkGbIaCQJL4Vu0OkMWqaAQcWo+0TUok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxK4M1SySAK/POxJrgL2hnYRRW35WOe71MMWin7nd+L6+B9hKBA88KV8dWx7avqm6
         cUAYFL7rKgzD3eTJSz52A7T6wiFjNMPTZtE6U3nBxfvWHCdG2hbwT8rMm7R2yW8m6s
         4/wN8YSJCinAy2IiucIWPII4LrnGz5XNN8DHXPNk=
Date:   Thu, 5 Sep 2019 16:01:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Simplify PCIe hotplug indicator control
Message-ID: <20190905210102.GG103977@google.com>
References: <20190903111021.1559-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903111021.1559-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 03, 2019 at 02:10:17PM +0300, Denis Efremov wrote:
> PCIe defines two optional hotplug indicators: a Power indicator and an
> Attention indicator. Both are controlled by the same register, and each
> can be on, off or blinking. The current interfaces
> (pciehp_green_led_{on,off,blink}() and pciehp_set_attention_status()) are
> non-uniform and require two register writes in many cases where we could
> do one.
> 
> This patchset introduces the new function pciehp_set_indicators(). It
> allows one to set two indicators with a single register write. All
> calls to previous interfaces (pciehp_green_led_* and
> pciehp_set_attention_status()) are replaced with a new one. Thus,
> the amount of duplicated code for setting indicators is reduced.
> 
> Changes in v4:
>   - Changed the inputs validation in pciehp_set_indicators()
>   - Moved PCI_EXP_SLTCTL_ATTN_IND_NONE, PCI_EXP_SLTCTL_PWR_IND_NONE
>     to drivers/pci/hotplug/pciehp.h and set to -1 for not interfering
>     with reserved values in the PCIe Base spec
>   - Added set_power_indicator define
> 
> Changes in v3:
>   - Changed pciehp_set_indicators() to work with existing
>     PCI_EXP_SLTCTL_* macros
>   - Reworked the inputs validation in pciehp_set_indicators()
>   - Removed pciehp_set_attention_status() and pciehp_green_led_*()
>     completely
> 
> Denis Efremov (4):
>   PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
>   PCI: pciehp: Switch LED indicators with a single write
>   PCI: pciehp: Remove pciehp_set_attention_status()
>   PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()
> 
>  drivers/pci/hotplug/pciehp.h      | 12 ++++--
>  drivers/pci/hotplug/pciehp_core.c |  7 ++-
>  drivers/pci/hotplug/pciehp_ctrl.c | 26 +++++------
>  drivers/pci/hotplug/pciehp_hpc.c  | 72 +++++++------------------------
>  include/uapi/linux/pci_regs.h     |  1 +
>  5 files changed, 45 insertions(+), 73 deletions(-)

Thanks, Denis, I applied these to pci/pciehp for v5.4.  I think this
is a great improvement.

I tweaked a few things:

  - Updated comments to refer to "Power" intead of "green",
    "Attention" instead of "amber", and "Indicator" instead of "LED".

  - Replaced PCI_EXP_SLTCTL_ATTN_IND_NONE and
    PCI_EXP_SLTCTL_PWR_IND_NONE with INDICATOR_NOOP because I didn't
    want them to look like definitions from the spec.

  - Dropped set_power_indicator().  It does make things locally easier
    to read, but I think the overall benefit of having fewer
    interfaces outweighs that.

The interdiff from your v4 is below.  Let me know if I broke anything.


diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index dcbf790b7508..654c972b8ea0 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -110,9 +110,9 @@ struct controller {
  *
  * @OFF_STATE: slot is powered off, no subordinate devices are enumerated
  * @BLINKINGON_STATE: slot will be powered on after the 5 second delay,
- *	green led is blinking
+ *	Power Indicator is blinking
  * @BLINKINGOFF_STATE: slot will be powered off after the 5 second delay,
- *	green led is blinking
+ *	Power Indicator is blinking
  * @POWERON_STATE: slot is currently powering on
  * @POWEROFF_STATE: slot is currently powering off
  * @ON_STATE: slot is powered on, subordinate devices have been enumerated
@@ -167,9 +167,7 @@ int pciehp_power_on_slot(struct controller *ctrl);
 void pciehp_power_off_slot(struct controller *ctrl);
 void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 
-/* Special values for leaving indicators unchanged */
-#define PCI_EXP_SLTCTL_ATTN_IND_NONE -1 /* Attention Indicator noop */
-#define PCI_EXP_SLTCTL_PWR_IND_NONE  -1 /* Power Indicator noop */
+#define INDICATOR_NOOP -1	/* Leave indicator unchanged */
 void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
 
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
@@ -187,9 +185,6 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
-#define set_power_indicator(ctrl, x) \
-	pciehp_set_indicators(ctrl, (x), PCI_EXP_SLTCTL_ATTN_IND_NONE)
-
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 7a86ea90ed94..b3122c151b80 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -95,7 +95,7 @@ static void cleanup_slot(struct controller *ctrl)
 }
 
 /*
- * set_attention_status - Turns the Amber LED for a slot on, off or blink
+ * set_attention_status - Turns the Attention Indicator on, off or blinking
  */
 static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 {
@@ -108,7 +108,7 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 		status = PCI_EXP_SLTCTL_ATTN_IND_OFF;
 
 	pci_config_pm_runtime_get(pdev);
-	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_NONE, status);
+	pciehp_set_indicators(ctrl, INDICATOR_NOOP, status);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index d0f55f695770..21af7b16d7a4 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -30,7 +30,10 @@
 
 static void set_slot_off(struct controller *ctrl)
 {
-	/* turn off slot, turn on Amber LED, turn off Green LED if supported*/
+	/*
+	 * Turn off slot, turn on attention indicator, turn off power
+	 * indicator
+	 */
 	if (POWER_CTRL(ctrl)) {
 		pciehp_power_off_slot(ctrl);
 
@@ -65,7 +68,8 @@ static int board_added(struct controller *ctrl)
 			return retval;
 	}
 
-	set_power_indicator(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
+			      INDICATOR_NOOP);
 
 	/* Check link training status */
 	retval = pciehp_check_link_status(ctrl);
@@ -100,7 +104,7 @@ static int board_added(struct controller *ctrl)
 }
 
 /**
- * remove_board - Turns off slot and LEDs
+ * remove_board - Turn off slot and Power Indicator
  * @ctrl: PCIe hotplug controller where board is being removed
  * @safe_removal: whether the board is safely removed (versus surprise removed)
  */
@@ -123,8 +127,8 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
 			   &ctrl->pending_events);
 	}
 
-	/* turn off Green LED */
-	set_power_indicator(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+			      INDICATOR_NOOP);
 }
 
 static int pciehp_enable_slot(struct controller *ctrl);
@@ -171,7 +175,7 @@ void pciehp_handle_button_press(struct controller *ctrl)
 			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
 				  slot_name(ctrl));
 		}
-		/* blink green LED and turn off amber */
+		/* blink power indicator and turn off attention */
 		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
 				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
@@ -312,7 +316,8 @@ static int pciehp_enable_slot(struct controller *ctrl)
 	ret = __pciehp_enable_slot(ctrl);
 	if (ret && ATTN_BUTTN(ctrl))
 		/* may be blinking */
-		set_power_indicator(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF);
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+				      INDICATOR_NOOP);
 	pm_runtime_put(&ctrl->pcie->port->dev);
 
 	mutex_lock(&ctrl->state_lock);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 9fd8f99132bb..1a522c1c4177 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -418,17 +418,32 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	return 0;
 }
 
+/**
+ * pciehp_set_indicators() - set attention indicator, power indicator, or both
+ * @ctrl: PCIe hotplug controller
+ * @pwr: one of:
+ *	PCI_EXP_SLTCTL_PWR_IND_ON
+ *	PCI_EXP_SLTCTL_PWR_IND_BLINK
+ *	PCI_EXP_SLTCTL_PWR_IND_OFF
+ * @attn: one of:
+ *	PCI_EXP_SLTCTL_ATTN_IND_ON
+ *	PCI_EXP_SLTCTL_ATTN_IND_BLINK
+ *	PCI_EXP_SLTCTL_ATTN_IND_OFF
+ *
+ * Either @pwr or @attn can also be INDICATOR_NOOP to leave that indicator
+ * unchanged.
+ */
 void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
 {
 	u16 cmd = 0, mask = 0;
 
-	if (PWR_LED(ctrl) && pwr > 0) {
-		cmd |= pwr;
+	if (PWR_LED(ctrl) && pwr != INDICATOR_NOOP) {
+		cmd |= (pwr & PCI_EXP_SLTCTL_PIC);
 		mask |= PCI_EXP_SLTCTL_PIC;
 	}
 
-	if (ATTN_LED(ctrl) && attn > 0) {
-		cmd |= attn;
+	if (ATTN_LED(ctrl) && attn != INDICATOR_NOOP) {
+		cmd |= (attn & PCI_EXP_SLTCTL_AIC);
 		mask |= PCI_EXP_SLTCTL_AIC;
 	}
 
