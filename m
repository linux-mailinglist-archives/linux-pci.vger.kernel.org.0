Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47971AF7C7
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 08:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDSGxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 02:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDSGxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 02:53:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB7C061A0C
        for <linux-pci@vger.kernel.org>; Sat, 18 Apr 2020 23:53:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so7540941wma.4
        for <linux-pci@vger.kernel.org>; Sat, 18 Apr 2020 23:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mFAEcGeAy+jaugTJGE/cHiqfTfKyAjbMSTMvoXAJbk8=;
        b=cWNx0VqWuLhHFjCGDTF0ZQoYAqQXRHGed0t2xDK1ouWMN6GdY8YNcC8dItZ9BFHiLJ
         5H44jy5vyu+vD/fMEWSnWXkZY5RuIYtnBjTt00mwLseXsLQcQvlLzkBsYiw6Xh4/ZEG/
         QSdDwPuDF0p07K704EHXzJ08dLyW+PbR7uIePW5APwV84WFYNwxuq0hf1OEMn0Kr+myv
         6Do/9W8elrirfprQPLj88fq4KOjiLG/HmH57nSlc/wH0IxuZfiJtLKURrIHOrTsxp67D
         y2vstOEPhqOZXakdfIAa3VzvFvDkevjjyZcwWrK+9RVCxIezkuqdWf9Tuw3TOA7ES4RG
         wtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mFAEcGeAy+jaugTJGE/cHiqfTfKyAjbMSTMvoXAJbk8=;
        b=YU6LcJwUJ1SaA7EupKmK2FrpRN3C+h2JuuQoA9PTCq0aX7/pgODzVpkxOGy5XLdBen
         L1hdcwwzRQu4rnTjN3RmWglAxt9O/exoHkHtiuOautjUMs6fc5wjTbiV3xzAPIYhfs1d
         GEWrITyjK0gGAfcslmEpRUyLKuhKygbMkmCNh5S3Piibn9TzVI38Yp+NAytM+u0qn8y+
         97YPqXdSUh3e+MnG+LDqNAMMYKnSqYf5il1uIHy36bruVf3fDMrzYbeQ7rbM1SQDgfJA
         xVVmafhsw+oDDDaBOq9J4e4SuT0EkSp0Qogn37nmaPrAODU+EihhjIAb5v1veKrGc23b
         2AnQ==
X-Gm-Message-State: AGi0PuaHII9zHy0Xk0X3sd3UoliDhNbhnNkgTkTT+QX1l7C/P2cI8h9A
        EdpXdUFThwT80W6l6OcUBbtNA+94SmE=
X-Google-Smtp-Source: APiQypJdLsODVYJcBTGah0zunf/5Xy7iOB/wii/MlHfaAPZg+nbjcmM9Bxw21omGPDu770xtZ6nUuQ==
X-Received: by 2002:a1c:98c2:: with SMTP id a185mr11863019wme.85.1587279185480;
        Sat, 18 Apr 2020 23:53:05 -0700 (PDT)
Received: from localhost.localdomain (5402C526.dsl.pool.telekom.hu. [84.2.197.38])
        by smtp.gmail.com with ESMTPSA id e2sm19901043wrv.89.2020.04.18.23.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 23:53:04 -0700 (PDT)
From:   Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
Subject: [PATCH RFC] pci: Make return value of pcie_capability_read*() consistent
Date:   Sun, 19 Apr 2020 08:51:13 +0200
Message-Id: <20200419065113.15259-1-refactormyself@gmail.com>
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
a consitent way for checking which error has occured.

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
          lines(1100-1136): these pass on the recieved return values 
	  directly to:
          - pcie_capability_clear_dword() is not referenced anywhere
          - pcie_capability_set_dword() is referenced but it's return 
	    values are not cached
          - pcie_capability_{set, clear}_word() : return value passed on 
	    by pci_enable_pcie_error_reporting() in drivers/pci/pcie/aer.c
	    lines-(350,362) these are used by other drivers to log errors,
            in all examined cases all errors are treated the same.
	  - pcie_capability_clear_word() : return value passed on by 
	    pci_disable_pcie_error_reporting() in /drivers/pci/pcie/aer.c 
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
Changed in version 4:
 - make patch independent of earlier versions
 - add commit log
 - add justificaation and report on audit of affected functions

NOTE:
 Please let me know if I have missed some possible callers
 I am not sure if pcie_capability_write*() needs this kind of fix

 drivers/pci/access.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..451f2b8b2b3c 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 
 	*val = 0;
 	if (pos & 1)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
@@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 
 	*val = 0;
 	if (pos & 3)
-		return -EINVAL;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
 
 	if (pcie_capability_reg_implemented(dev, pos)) {
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
-- 
2.17.1

