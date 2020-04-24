Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D631B784D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgDXO3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726848AbgDXO3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 10:29:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAABC09B045
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 07:29:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so11106701wrt.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4PkQlgpl5JvrIZoagBQZ9ZIVdlJwsq2jVwpCTUrfXMw=;
        b=WyLJaDNUxnjgEwI9ff4i7SayXCqgyddwtyPgSrnNmn083QuURxE/YlCJszeWdgK/lh
         3H59CfdSd6LwJi6wopFCiiJDoqTywDQm4AUS9ssv25XLe343bhl8dSPWthIC+yQVvGTz
         WKuRbcuSTjAuPLwiYpvZOmRKb3O8vNe8FqAhoRgWrQdWU5nbXmchSc0cvLUfxku2tiY+
         2iihtjKes2HRdNMpCLYkZxLFmut8xmZxFHVhh+epFKKVP/qJnVfvAminGgs+J/oPrssF
         CmolnMVxRQVY9Z9quVRAZOnpsuEra0eVtpHtWOPD/TdbsdmQc10TevXM62Pr5KI+yuKE
         rQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4PkQlgpl5JvrIZoagBQZ9ZIVdlJwsq2jVwpCTUrfXMw=;
        b=ugIdmRIw3Zwxlox5CoU1sGwBly4T7hUdUkkQ8CKyiWPtbuefbWEcgmvTzuKerLuQDv
         6APQdX5Qb83GMz4d7Mabm8W6h54MkExAwyZRJlghYBEQ9tqQoU+/if3/4bIklDerGi0I
         MLn9jJZchQXCjDtFBskYJjMalzltPfnuSLLlpy3bYbMbz84JjtKn1md+agOuCX48u1wo
         WUNLdDSiepdix3WrmDBkj24qQHv3g2vNJOkj7yge3m2i6LKEq1xFg9TQLyktzAoH4V67
         MoR+PY0PhSsn1VdMbvHY3bMnyCivoeGS6eyCQYVrkJDnGWVqZtUXmcwEOsqtUlNUxs8x
         PoTg==
X-Gm-Message-State: AGi0PuYfCmLJwJ+oWJ4hdGUtChtd7nwyNaI01q96jbPEFIX6FIYV0pVI
        zVx/bkzbbGIH4aBRhsvjH1Q=
X-Google-Smtp-Source: APiQypKzLc/msf3Ot2HnhDrS0CYe+A4sKCfmLEo5yoxjZPl24M3GSYFpMtt0MvGDYibAK0iJDZ9n6Q==
X-Received: by 2002:adf:dec9:: with SMTP id i9mr11353839wrn.197.1587738552593;
        Fri, 24 Apr 2020 07:29:12 -0700 (PDT)
Received: from localhost.localdomain (563BD1A4.dsl.pool.telekom.hu. [86.59.209.164])
        by smtp.gmail.com with ESMTPSA id k9sm8777536wrd.17.2020.04.24.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 07:29:11 -0700 (PDT)
From:   Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, yangyicong@hisilicon.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: [PATCH v4] pci: Make return value of pcie_capability_read*() consistent
Date:   Fri, 24 Apr 2020 16:27:11 +0200
Message-Id: <20200424142711.2557-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_capability_read*() could return 0, -EINVAL, or any of the
PCIBIOS_* error codes (which are positive).
This is behaviour is now changed to return only PCIBIOS_* error
codes on error.
This is consistent with pci_read_config_*(). Callers can now have
a consistent way for checking which error has occurred.

An audit of the callers of this function was made and no case was found
where there is need for a change within the caller function or their
dependencies down the heirarchy.
Out of all caller functions discovered only 8 functions either persist the
return value of pcie_capability_read*() or directly pass on the return
value.

1.) "./drivers/infiniband/hw/hfi1/pcie.c" :
=> pcie_speeds() line-306

	if (ret) {
		dd_dev_err(dd, "Unable to read from PCI config\n");
		return ret;
	}

remarks: The variable "ret" is the captured return value.
         This function passes on the return value. The return value was
	 store only by hfi1_init_dd() line-15076 in
         ./drivers/infiniband/hw/hfi1/chip.c and it behave the same on all
	 errors. So this patch will not require a change in this function.

=> update_lbus_info() line-276

	if (ret) {
		dd_dev_err(dd, "Unable to read from PCI config\n");
		return;
	}

remarks: see below
=> save_pci_variables() line-415, 420, 425

	if (ret)
		goto error;

remarks: see below

=> tune_pcie_caps() line-471

	if ((!ret) && !(ectl & PCI_EXP_DEVCTL_EXT_TAG)) {
		dd_dev_info(dd, "Enabling PCIe extended tags\n");
		ectl |= PCI_EXP_DEVCTL_EXT_TAG;
		ret = pcie_capability_write_word(dd->pcidev,
						 PCI_EXP_DEVCTL, ectl);
		if (ret)
		     dd_dev_info(dd, "Unable to write to PCI config\n");
	}

remarks: see below

=> do_pcie_gen3_transition() line-1247, 1274

	if (ret) {
		dd_dev_err(dd, "Unable to read from PCI config\n");
		return_error = 1;
		goto done;
	}

remarks: The variable "ret" is the captured return value.
         These functions' behaviour is the same on all errors, so they are
	 not be affected by this patch.

2.) "./drivers/net/wireless/realtek/rtw88/pci.c":
=> rtw_pci_link_cfg*() line-1221

	if (ret) {
		rtw_err(rtwdev, "failed to read PCI cap, ret=%d\n", ret);
		return;
	}

remark: The variable "ret" is the captured return value.
        This function returns on all errors, so it will not be affected
	by this patch.

3.) "./drivers/pci/hotplug/pciehp_hpc.c":
=> pciehp_check_link_active() line-219

	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
		return -ENODEV;

remark: see below

=>pciehp_card_present() line-404

	{Same code as above}

remark: The variable "ret" is the captured return value.
        This 2 functions will not be affected by this patch since they are
	only testing for *DEVICE_NOT_FOUND error.

4.) "./drivers/pci/pcie/bw_notification.c":
=>pcie_link_bandwidth_notification_supported() line-26

	return (ret == PCIBIOS_SUCCESSFUL)
			&& (lnk_cap & PCI_EXP_LNKCAP_LBNC);

remark: see below

=>pcie_bw_notification_irq() line-56

	if (ret != PCIBIOS_SUCCESSFUL || !events)
		return IRQ_NONE;

remark: The variable "ret" is the captured return value.
        In these 2 functions returning PCIBIOS_BAD_REGISTER_NUMBER instead
	of -EINVAL as done in this patch will not affect the behaviour.

5.) "./drivers/pci/probe.c":
=> pci_configure_extended_tags() line-1951

	if (ret)
		return 0;

remark: The variable "ret" is the captured return value.
        This function will not be affected by this patch since it retuns 0
	on ALL error codes.

6.) "./drivers/pci/pci-sysfs.c":
=> current_link_speed_show() line-180

	if (err)
		return -EINVAL;

remark: see below

=>current_link_width_show() line-215

        {same code as in the above function}

remark: The variable "err" is the captured return value.
        This 2 functions will not be affected directly by this patch since
	it retuns -EINVAL on ALL error codes. However, depending on the
	intent, after this patch, this may now be to too generic. This is
	because it will then be possible to use the returned PCIBIOS_*
	error code to identify the error.

7.) "./drivers/dma/ioat/init.c":
=>ioat3_dma_probe() line-1193

	if (err)
		return err;

remark: The variable "ret" is the captured return value.
        This function passes on the return value. Only ioat_pci_probe()
	line-1392 in the same file persists the return value and it's
	behaviour is the same on all errors. So this patch will not change
	the behaviour of these functions.

8.) "./drivers/pci/access.c":
=>pcie_capability_clear_and_set_word() line-493

	if (!ret) {
		val &= ~clear;
		val |= set;
		ret = pcie_capability_write_word(dev, pos, val);
	}

	return ret;

=>pcie_capability_clear_and_set_dword() line-508

    {same as above function}

remark: The variable "ret" is the captured return value.
     This 2 functions will not be affected directly. But after this patch
     they will now be returning PCIBIOS_BAD_REGISTER_NUMBER instead of
     -EINVAL. No case was found where the return value of any of both
     functions were persisted. But their return values are passed on
     directly by:
	- pcie_capability_set_{word|dword}() and
	  pcie_capability_clear_{word|dword}() in ./include/linux/pci.h
          lines(1100-1136): these pass on the received return values
	  directly to:
          - pcie_capability_clear_dword() is not referenced anywhere
          - pcie_capability_set_dword() is referenced but it's return
	    values are not cached
          - pcie_capability_{set, clear}_word() : return value passed on
	    by pci_enable_pcie_error_reporting() in drivers/pci/pcie/aer.c
	    lines-(350,362) these are used by other drivers to log errors,
            in all examined cases all errors are treated the same.
	  - pcie_capability_clear_word() : return value passed on by
	    pci_disable_pcie_error_reporting() in drivers/pci/pcie/aer.c
	    lines-362 which treats all errors are treated the same.

	- pcie_set_readrq() line-5662 and pcie_set_mps() line-5703 in
	  ./drivers/pci/pci.c : both functions pass on the return value of
	  pcie_capability_clear_and_set_word() but also return -EINVAL in
	  cases of some other errors. Currently these errors will not be
	  differentiated, this patch will help differentiate errors in
	  this kind of situation. The function will not be affected but
	  rather it will be enhanced in correctness.

        - pqi_set_pcie_completion_timeout() line-7423 in
	  ./drivers/scsi/smartpqi/smartpqi_init.c : This function will not
          be affected. Although, it passes on the return value, all error
          values are handled the same way by the only reference found at
          line-7473 in the same file.

Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
---
Changes in version 4:
 - make patch independent of earlier versions
 - add commit log
 - add justificaation and report on audit of affected functions

 drivers/pci/access.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..f0baab635b66 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -402,6 +402,10 @@ static bool pcie_capability_reg_implemented(struct pci_dev *dev, int pos)
  * Note that these accessor functions are only for the "PCI Express
  * Capability" (see PCIe spec r3.0, sec 7.8).  They do not apply to the
  * other "PCI Express Extended Capabilities" (AER, VC, ACS, MFVC, etc.)
+ *
+ * On error, this function returns a PCIBIOS_* error code,
+ * you may want to use pcibios_err_to_errno()(include/linux/pci.h)
+ * to convert to a non-PCI code.
  */
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 {
@@ -409,7 +413,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 
 	*val = 0;
 	if (pos & 1)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
@@ -444,7 +448,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 
 	*val = 0;
 	if (pos & 3)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
-- 
2.17.1

