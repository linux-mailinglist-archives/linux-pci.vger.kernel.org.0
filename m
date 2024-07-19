Return-Path: <linux-pci+bounces-10545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C544D937694
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 12:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E813B1C21394
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA9EEC0;
	Fri, 19 Jul 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEdr+9+s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358582D72
	for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721384585; cv=none; b=Laal8ZcEE3xL6dDSBjQnlDgmoCJUQWl08+wOUW5FHCIdDp7R6dEkp8UrurfenoMX400i0W0KW1VqH3nAMtwWLhShmWhqjMc5bodr0ApbchfjhUOpoYtU141Qf28Ws0lkJCUkydtTiObJONIbVONOslH5dtLmP7Wf7Zm06XU27JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721384585; c=relaxed/simple;
	bh=GJzSjZc4L88JQVGrwqg++2WMdwwRbfyO7WEo3I7pPxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bxiiM/veQy3f5PmXgF280QyfikHn+ZBbLuX1pVCZLovgv2QmXlPkoWfcCbhs6hbwaiZZ//f0aqPtfjOzs7bhmwZYAJamhDeY7RXH8o5H3bRrchUpb8CjUlE7/Z/U9C49WwhS+ywSkjknW6+zHc+7SNjvPiQ18ZE4Xxhv4IoeE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEdr+9+s; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721384583; x=1752920583;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GJzSjZc4L88JQVGrwqg++2WMdwwRbfyO7WEo3I7pPxI=;
  b=EEdr+9+sb8UGZ81cLxyC5chsdAAxHyKIlh6JzP2vCngC4sGfIRIvEE8K
   hQAUhWBlZDY6NpUMd9IAAfqajAqQjk2A4vlo9C/OI3xsr9LX+GwMAXwOY
   DUlwcAubEmZaxxe3z18LSPMS6aUpxAHuhriV8U3zM5LdhxvuLB94miCSQ
   NYewh/ROulzygRpGD0yVgC52Bk5l6g+7Vn2ylCMzTvXVHJWb9GRbauR9+
   Ah8Uejn67rnyz7uEWLRe281NsiY634R8bmmhWJrZwjOB5NaCi63FdtAaQ
   DRO+xGD+CMnYFwVEHdSslvlxrMITtHo6dE6hZwL9aRBZJ+TugePX/aRhU
   w==;
X-CSE-ConnectionGUID: s9CIsjs/T1ixZGZzDaj1fg==
X-CSE-MsgGUID: xYBm6RBgQVeYu/KPm2rY0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="29603583"
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="29603583"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 03:23:02 -0700
X-CSE-ConnectionGUID: CTYj1m5mSfqbpIBRI4mcYQ==
X-CSE-MsgGUID: yoFj20WyRPqBDXRXnYo7sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,220,1716274800"; 
   d="scan'208";a="51350195"
Received: from unknown (HELO localhost) ([10.237.142.103])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 03:23:00 -0700
Date: Fri, 19 Jul 2024 12:22:53 +0200
From: Blazej Kucman <blazej.kucman@linux.intel.com>
To: linux-pci@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 bhelgaas@google.com
Cc: mstowe@redhat.com, mariusz.tkaczyk@linux.intel.com
Subject: [REGRESSION] Setting the LED status via attention stopped working.
Message-ID: <20240719122253.00004b0e@linux.intel.com>
Organization: intel
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

We discovered regression with setting LED state through "attention" for
VMD slot. e.g /sys/bus/pci/slots/2-1/attention.

Expected behavior:
write status into "attention" will set the LED status correctly.

Actual behavior:
write the status causes undefined behavior, "attention" contains a
different value than the one entered, the requested LED status is not
set

After bisection kernel, it turned out that the issue appeared between
kernel v6.6..v6.7-rc1. Tested kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

I found a patch that causes issue:
PCI: hotplug: Use FIELD_GET/PREP()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.7-rc1&id=abaaac4845a0d6f39f83cbaba4c3b46ba5f93170 
I confirmed this by reverting this patch from kernel 6.10.

Issue was discovered by using ledmon utility (ledctl is a part of ledmon
software) https://github.com/intel/ledmon, 
example command: ledctl locate={/dev/nvme6n1 }, should set locate
status on nvme6n1

The values that ledmon writes into "attention"

#define ATTENTION_OFF        0xF  /* (1111) Attention Off, Power Off */
#define ATTENTION_LOCATE     0x7  /* (0111) Attention Off, Power On */
#define ATTENTION_REBUILD    0x5  /* (0101) Attention On, Power On */
#define ATTENTION_FAILURE    0xD  /* (1101) Attention On, Power Off */

Without mentioned patch, writing these values will set the LEDs
correctly.

I was able to determine that the change in behavior was caused by this
change @@ -484,7 +485,7 @@ int pciehp_set_raw_indicator_status(struct
hotplug_slot *hotplug_slot, struct pci_dev *pdev = ctrl_dev(ctrl);
 
 	pci_config_pm_runtime_get(pdev);
-	pcie_write_cmd_nowait(ctrl, status << 6,
+	pcie_write_cmd_nowait(ctrl, FIELD_PREP(PCI_EXP_SLTCTL_AIC,
status), PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
 	pci_config_pm_runtime_put(pdev)
	
I added logging of bit shift values and there is a significant
difference in the operation of this method

int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
                                    u8 status)
{
        struct controller *ctrl = to_ctrl(hotplug_slot);
        struct pci_dev *pdev = ctrl_dev(ctrl);

        pr_err("SET_INDICATOR_ST START");

        pr_err("SET_INDICATOR_ST_INPUT: STATUS: %d %u", status, status);
        pr_err("SET_INDICATOR_ST_OLD d %d, u %u", status << 6, status
        << 6);

        u8 test = FIELD_PREP(PCI_EXP_SLTCTL_AIC, status);
        pr_err("SET_INDICATOR_ST_NEW d %d, u %u", test, test);

        pr_err("SET_INDICATOR_ST END");

        pci_config_pm_runtime_get(pdev);
        pcie_write_cmd_nowait(ctrl, status << 6,
                              PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC);
        pci_config_pm_runtime_put(pdev);
        return 0;
}
LOGS:

[   75.814893] SET_INDICATOR_ST START
[   75.814895] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[   75.818362] SET_INDICATOR_ST_OLD d 960, u 960
[   75.823143] SET_INDICATOR_ST_NEW d 192, u 192
[   75.827634] SET_INDICATOR_ST END
[   75.832880] SET_INDICATOR_ST START
[   75.836167] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[   75.839626] SET_INDICATOR_ST_OLD d 960, u 960
[   75.844408] SET_INDICATOR_ST_NEW d 192, u 192
[   75.848834] SET_INDICATOR_ST END
[   76.225732] SET_INDICATOR_ST START
[   76.229022] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[   76.232481] SET_INDICATOR_ST_OLD d 960, u 960
[   76.237259] SET_INDICATOR_ST_NEW d 192, u 192
[   76.241691] SET_INDICATOR_ST END
[   76.250247] SET_INDICATOR_ST START
[   76.253530] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[   76.256990] SET_INDICATOR_ST_OLD d 960, u 960
[   76.261766] SET_INDICATOR_ST_NEW d 192, u 192
[   76.266189] SET_INDICATOR_ST END
[   77.223562] SET_INDICATOR_ST START
[   77.226852] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[   77.230312] SET_INDICATOR_ST_OLD d 960, u 960
[   77.235091] SET_INDICATOR_ST_NEW d 192, u 192
[   77.239521] SET_INDICATOR_ST END
[   77.244765] SET_INDICATOR_ST START
[   77.248051] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[   77.251510] SET_INDICATOR_ST_OLD d 960, u 960
[   77.256288] SET_INDICATOR_ST_NEW d 192, u 192
[   77.260725] SET_INDICATOR_ST END
[   77.267606] SET_INDICATOR_ST START

# ATTENTION_LOCATE
[   77.270895] SET_INDICATOR_ST_INPUT: STATUS: 7 7
[   77.274356] SET_INDICATOR_ST_OLD d 448, u 448
[   77.278959] SET_INDICATOR_ST_NEW d 192, u 192
[   77.283379] SET_INDICATOR_ST END

With patch PCI: hotplug: Use FIELD_GET/PREP():
after trying to set ATTENTION_LOCATE, file "attention" contains value
0x3 instead expected 0x7.

[  862.150910] SET_INDICATOR_ST START
[  862.150912] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[  862.154375] SET_INDICATOR_ST_OLD d 960, u 960
[  862.159159] SET_INDICATOR_ST_NEW d 192, u 192
[  862.163591] SET_INDICATOR_ST END
[  862.169235] SET_INDICATOR_ST START
[  862.172524] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[  862.175984] SET_INDICATOR_ST_OLD d 960, u 960
[  862.182933] SET_INDICATOR_ST_NEW d 192, u 192
[  862.189190] SET_INDICATOR_ST END
[  862.198302] SET_INDICATOR_ST START
[  862.203290] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[  862.208398] SET_INDICATOR_ST_OLD d 960, u 960
[  862.214780] SET_INDICATOR_ST_NEW d 192, u 192
[  862.220817] SET_INDICATOR_ST END
[  862.231044] SET_INDICATOR_ST START
[  862.235931] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[  862.240994] SET_INDICATOR_ST_OLD d 960, u 960
[  862.247376] SET_INDICATOR_ST_NEW d 192, u 192
[  862.253411] SET_INDICATOR_ST END
[  862.262574] SET_INDICATOR_ST START
[  862.267471] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[  862.272537] SET_INDICATOR_ST_OLD d 960, u 960
[  862.278918] SET_INDICATOR_ST_NEW d 192, u 192
[  862.284945] SET_INDICATOR_ST END
[  862.291705] SET_INDICATOR_ST START
[  862.296596] SET_INDICATOR_ST_INPUT: STATUS: 15 15
[  862.301656] SET_INDICATOR_ST_OLD d 960, u 960
[  862.308039] SET_INDICATOR_ST_NEW d 192, u 192
[  862.314064] SET_INDICATOR_ST END

# ATTENTION_REBUILD
[  862.322480] SET_INDICATOR_ST START
[  862.327388] SET_INDICATOR_ST_INPUT: STATUS: 5 5
[  862.332454] SET_INDICATOR_ST_OLD d 320, u 320
[  862.338662] SET_INDICATOR_ST_NEW d 64, u 64
[  862.344704] SET_INDICATOR_ST END

With patch PCI: hotplug: Use FIELD_GET/PREP():
After trying to set ATTENTION_REBUILD, file "attention" contains value
0x1 instead expected 0x5.

This topic is quite important for us, because this change has been
included in RHEL9.5 kernel and causes LED setting for VMD drives to not
work.

Looking at the above logs, I don't know if it always worked wrong,
because the input status is u8 and the bit shift did not cut off some
of higher bits e.g. for ATTENTION_LOCATE 0x7 (0111),
currently macro FIELD_PREP it does this through "AND" with mask.

Regards,
Blazej


