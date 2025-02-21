Return-Path: <linux-pci+bounces-21951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF8A3EAB3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE007A1DB8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 02:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287181728;
	Fri, 21 Feb 2025 02:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TEHV+1+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B683453AC;
	Fri, 21 Feb 2025 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104427; cv=none; b=dKFyjdW/kuKBfM7cAGI8yNhYzpsub0IgdO7yZUvVHnRJUv/eWDyfzmmuAGtfIt88TxiZVVY4MRlqCOB/gXGS0IE1Zg6xEUPvmgX0owS6hLW3nFz7f+spazDTEzyFfed/2iIUqC4JuTVh6m6gISo6iZh/npQqIRfsPQHF0K0vVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104427; c=relaxed/simple;
	bh=lCA4hhYmOv5gYMao8xUMteua/5701IKNUWSeDJMLAkA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qn4xUDl8N4XbUFuEH9bzHLPcAt4bf40D7g4EC+u0OfkVXwZFyKGnCTQepSgdgNV6/gbx2y44NcMP7eVicrqdfypNdIPIBRXAqK9Qm82DVIHxzrgYFDodYvdxEg/hJCpFZwVEMVsO6BwkngIIRmwJtB/Lg8v5rR0OxA1n+Ym7lMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TEHV+1+V; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740104425; x=1771640425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZ6R8bvQH0PzNlUlEuECVUoHo8jt+Wqy6pW+mnsbG+s=;
  b=TEHV+1+VHNU3TzlL+5p7+5FQnigkx7Y7VpbSLH4Gi7jIsY8lLwsiXzBb
   dvlSGxLSOJb5VL/0vDKzQGwzb8v3k3GTCHiEy3/fg+XN76FiFfYxdFRrW
   j1uklLeTjmpNIQ5TgFImtY6TTgc5yTxWvl3l6EMSPFs5nXYG0kTrbsTYO
   k=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200"; 
   d="scan'208";a="474046324"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 02:20:21 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:64636]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.176:2525] with esmtp (Farcaster)
 id 621287b5-5e73-44d7-8138-65357e4436d2; Fri, 21 Feb 2025 02:20:21 +0000 (UTC)
X-Farcaster-Flow-ID: 621287b5-5e73-44d7-8138-65357e4436d2
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 02:20:20 +0000
Received: from b0be8375a521.amazon.com (10.37.244.7) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 02:20:17 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <helgaas@kernel.org>
CC: <alex.williamson@redhat.com>, <bhelgaas@google.com>,
	<ckoenig.leichtzumerken@gmail.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<takamitz@amazon.co.jp>, <kuniyu@amazon.com>, <kohei.enju@gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Avoid pointless capability searches
Date: Fri, 21 Feb 2025 11:20:08 +0900
Message-ID: <20250221022008.69533-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250215000301.175097-2-helgaas@kernel.org>
References: <20250215000301.175097-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Many of the save/restore functions in the pci_save_state() and
> pci_restore_state() paths depend on both a PCI capability of the device and
> a pci_cap_saved_state structure to hold the configuration data, and they
> skip the operation if either is missing.
> 
> Look for the pci_cap_saved_state first so if we don't have one, we can skip
> searching for the device capability, which requires several slow config
> space accesses.
> 
> Remove some error messages if the pci_cap_saved_state is not found so we
> don't complain about having no saved state for a capability the device
> doesn't have.  We have already warned in pci_allocate_cap_save_buffers() if
> the capability is present but we were unable to allocate a buffer.
> 
> Other than the message change, no functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c       | 27 ++++++++++++++-------------
>  drivers/pci/pcie/aspm.c | 15 ++++++++-------
>  2 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..503376bf7e75 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1686,10 +1686,8 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  		return 0;
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> -	if (!save_state) {
> -		pci_err(dev, "buffer not found in %s\n", __func__);
> +	if (!save_state)
>  		return -ENOMEM;
> -	}
>  
>  	cap = (u16 *)&save_state->cap.data[0];
>  	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &cap[i++]);
> @@ -1742,19 +1740,17 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  
>  static int pci_save_pcix_state(struct pci_dev *dev)
>  {
> -	int pos;
>  	struct pci_cap_saved_state *save_state;
> +	u8 pos;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> +	if (!save_state)
> +		return -ENOMEM;
>  
>  	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
>  	if (!pos)
>  		return 0;
>  
> -	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> -	if (!save_state) {
> -		pci_err(dev, "buffer not found in %s\n", __func__);
> -		return -ENOMEM;
> -	}

When devices don't have PCI_CAP_ID_PCIX, this change in order appears to 
cause a functional change.
Since probe functions of some drivers (e.g. Intel e1000) rely on the return 
value, I think they fail after that change in this situation.

Actually in my QEMU VM, e1000 driver failed to probe the device due to 
-ENOMEM from pci_save_pcix_state().
```
[root@localhost ~]# dmesg | grep e1000
[    0.400303] [      T1] e1000: Intel(R) PRO/1000 Network Driver
[    0.400805] [      T1] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.710970] [      T1] e1000 0000:00:03.0: probe with driver e1000 failed with error -12

[root@localhost ~]# lspci -nnvs 00:03.0
00:03.0 Ethernet controller [0200]: Intel Corporation 82540EM Gigabit Ethernet Controller [8086:100e] (rev 03)
        Subsystem: Red Hat, Inc. QEMU Virtual Machine [1af4:1100]
        Flags: fast devsel, IRQ 11
        Memory at febc0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at c000 [size=64]
        Expansion ROM at feb80000 [disabled] [size=256K]
lspci: Unable to load libkmod resources: error -2
```

Regarding pci_save_vc_state(), I found that similar comments were provided in 
this context:
https://lore.kernel.org/all/7dbb0d8b-3708-60ba-ee9e-78aa48bee160@linux.intel.com/

However, the same type of order change is still left in 
pci_save_pcix_state().

> -
>  	pci_read_config_word(dev, pos + PCI_X_CMD,
>  			     (u16 *)save_state->cap.data);
>  
> @@ -1763,14 +1759,19 @@ static int pci_save_pcix_state(struct pci_dev *dev)
>  
>  static void pci_restore_pcix_state(struct pci_dev *dev)
>  {
> -	int i = 0, pos;
>  	struct pci_cap_saved_state *save_state;
> +	u8 pos;
> +	int i = 0;
>  	u16 *cap;
>  
>  	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
> -	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> -	if (!save_state || !pos)
> +	if (!save_state)
>  		return;
> +
> +	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
> +	if (!pos)
> +		return;
> +
>  	cap = (u16 *)&save_state->cap.data[0];
>  
>  	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e0bc90597dca..007e4a082e6f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -35,16 +35,14 @@ void pci_save_ltr_state(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return;
>  
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +	if (!save_state)
> +		return;
> +
>  	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
>  	if (!ltr)
>  		return;
>  
> -	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> -	if (!save_state) {
> -		pci_err(dev, "no suspend buffer for LTR; ASPM issues possible after resume\n");
> -		return;
> -	}
> -
>  	/* Some broken devices only support dword access to LTR */
>  	cap = &save_state->cap.data[0];
>  	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
> @@ -57,8 +55,11 @@ void pci_restore_ltr_state(struct pci_dev *dev)
>  	u32 *cap;
>  
>  	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +	if (!save_state)
> +		return;
> +
>  	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
> -	if (!save_state || !ltr)
> +	if (!ltr)
>  		return;
>  
>  	/* Some broken devices only support dword access to LTR */
> -- 
> 2.34.1

Regards,
Kohei

