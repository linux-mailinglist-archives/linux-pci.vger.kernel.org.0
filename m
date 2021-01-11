Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B802F1B23
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbhAKQhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 11:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbhAKQhv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 11:37:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D4E120B1F;
        Mon, 11 Jan 2021 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610383030;
        bh=otGJuyIa9vFyZVEEoFSX8ezfjOBJvmAPRERlGFysvAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aj5jWPI6LnL8Cfxup+FJ8+cO30qpnmMtjgQGeZA0VMBi0kMHIUQ6kEnBsEKoVw10i
         DOw5jCcOx02t0xKwYTXsnLGa8aCHaED0AYcANxpCSvF+s3LdemAVJ+7TFxDj19AepV
         +Xw8QOKyjiF5wWY+MiM1Jfty1/5sdnS1XcR/DGo+/loLK9E7qBUWpog+wWCZshYQb7
         xF46LUwFaa6euSlR3CfhNNMB6NTYG8FcOxq6Uo3Bk4pZevmFV64YtsAuKh6cLFQ5YY
         ylqvpiydcQCNlCUTJ1/sgEgpUREDEGstgVOVoD0yZhNLAUBXq+9iVl8cyaWprM6MvW
         Njmr1GK6hV1nw==
Date:   Mon, 11 Jan 2021 08:37:08 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210111163708.GA1458209@dhcp-10-100-145-180.wdc.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <bcc440b0-0ab9-c25f-e7d5-f7ce65db5019@ess.eu>
 <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
 <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
 <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
 <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
 <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
 <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 11, 2021 at 02:39:20PM +0100, Hinko Kocevar wrote:
> Testing this patch a bit more (without the 5/5) resulted in the same CPU
> lockup:
> 
> watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [irq/122-aerdrv:128]
> 
> as I initially reported with the 5/5 of this patch included.
> 
> It seems more infrequent, though. For example, after reboot this is not
> observed and the recovery process is successful, whereas when 5/5 is also
> used every recovery resulted in CPU lockup.

I am assuming this soft lockup is still when restoring the downstream
port's virtual channel capability. Your initial sighting indicates that
it doesn't appear to be a deadlock, but the stack trace never existed
pci_restore_vc_state() either. I did not find any obvious issues here
just from code inspection, so if you could try applying the following
patch and send the kernel messages output, that would help.

---
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5fc59ac31145..4834af7eb582 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -28,6 +28,7 @@ static void pci_vc_save_restore_dwords(struct pci_dev *dev, int pos,
 {
 	int i;
 
+	pci_warn(dev, "%s: pos:%d dwords:%d\n", __func__, pos, dwords);
 	for (i = 0; i < dwords; i++, buf++) {
 		if (save)
 			pci_read_config_dword(dev, pos + (i * 4), buf);
@@ -110,6 +111,8 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev))
 		return;
 
+	pci_warn(dev, "%s: pos:%d res:%d\n", __func__, pos, res);
+
 	ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
 	status_pos = pos + PCI_VC_RES_STATUS + (res * PCI_CAP_VC_PER_VC_SIZEOF);
 
@@ -165,6 +168,8 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 	if (link && !pci_wait_for_pending(link, status_pos2,
 					  PCI_VC_RES_STATUS_NEGO))
 		pci_err(link, "VC%d negotiation stuck pending\n", id);
+
+	pci_warn(dev, "%s: pos:%d res:%d return\n", __func__, pos, res);
 }
 
 /**
@@ -190,6 +195,7 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 	int i, len = 0;
 	u8 *buf = save_state ? (u8 *)save_state->cap.data : NULL;
 
+	pci_warn(dev, "%s: buf:%d pos:%d\n", __func__, buf != NULL, pos);
 	/* Sanity check buffer size for save/restore */
 	if (buf && save_state->cap.size !=
 	    pci_vc_do_save_buffer(dev, pos, NULL, save)) {
@@ -278,6 +284,8 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 		pci_read_config_dword(dev, pos + PCI_VC_RES_CAP +
 				      (i * PCI_CAP_VC_PER_VC_SIZEOF), &cap);
 		parb_offset = ((cap & PCI_VC_RES_CAP_ARB_OFF) >> 24) * 16;
+		pci_warn(dev, "%s: i:%d evcc:%d parb_offset:%d\n", __func__, i,
+			 evcc, parb_offset);
 		if (parb_offset) {
 			int size, parb_phases = 0;
 
@@ -332,6 +340,7 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 		len += 4;
 	}
 
+	pci_warn(dev, "%s: len:%d\n", __func__, len);
 	return buf ? 0 : len;
 }
 
@@ -399,6 +408,7 @@ void pci_restore_vc_state(struct pci_dev *dev)
 		if (!save_state || !pos)
 			continue;
 
+		pci_warn(dev, "%s: i:%d pos:%d\n", __func__, i, pos);
 		pci_vc_do_save_buffer(dev, pos, save_state, false);
 	}
 }
--
