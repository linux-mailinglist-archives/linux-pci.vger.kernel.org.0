Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271575F6420
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 12:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiJFKIi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiJFKIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 06:08:34 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34138B2F2;
        Thu,  6 Oct 2022 03:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665050913; x=1696586913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iYEdCNesRlQWbZglMDlT/Pm4/qGqVLhxqobtVJx/fHc=;
  b=Dp4eib/dvH/Lmz8pvgdwPFhGNlsfK98ZXRMcYFjaiq2MFK+OwZHHBWgV
   wvPNh3QcyHLwW0hPOym+54pL6npEhRVyuvvF2tlRDjpqRKkxvYYwsmPKo
   FaXFUJmghz0RhEHdUVlcjxiLW+1820FB594T8a/p8ogqJG1Pb+uPoggFQ
   G5hS1v46DggIWTY8DhuldzINTO9IqA/X4Q8waXyYv1h//qhGAJdDFIwsI
   v3YMdrsslW9zNGKYixKywCEvhKlTYf5NCM37QVs5bSbiu+XbeQoEvFjsP
   p8cEZzwgzt/DuNioCuGHsJwbt7DUAhvPy1n0K++WWoGsXNbVxAZ40Y+Cw
   w==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661810400"; 
   d="scan'208";a="26592554"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Oct 2022 12:08:30 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 06 Oct 2022 12:08:30 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 06 Oct 2022 12:08:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665050910; x=1696586910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iYEdCNesRlQWbZglMDlT/Pm4/qGqVLhxqobtVJx/fHc=;
  b=NlaC3R03tm8Y3jG6ruvBcQ6JFaRqQzCw4R35Ct6vT8r71WJzDrKximQm
   R4tar3f+nJp0D2Rz8ydIoh3ugY1SFWwsjLkb/y48x+MiojhbIuliXVDYx
   UHNvDlh8IYFg/fIkfefMVq9D1Z+hyOsTAp6ZyToXAnzPZko8GxqK+vSzv
   qvGpLi70lg1QI/rx6fyWKldTKhdsVI88fhY3dY/bPLn0qMhpc7AS9jqsA
   A324Ad8npY0Rz18Qj+HlMJvKDOWkUZxLHj+Pv7UBYDzt4jxv8sydRinvR
   I3hFs0jJrwRW58v2q3Du/USRSj6xpg9deBetD+at3LnwsrJwLT1T2vuk6
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661810400"; 
   d="scan'208";a="26592553"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Oct 2022 12:08:30 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 79D43280056;
        Thu,  6 Oct 2022 12:08:30 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Korneliusz Osmenda <korneliuszo@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Guard pci_create_sysfs_dev_files with atomic value
Date:   Thu, 06 Oct 2022 12:08:27 +0200
Message-ID: <5610142.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <4469eba2-188b-aab7-07d1-5c77313fc42f@gmail.com>
References: <4469eba2-188b-aab7-07d1-5c77313fc42f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Am Montag, 29. August 2022, 21:14:43 CEST schrieb Korneliusz Osmenda:
> On Gateworks Ventana there is a number of PCI devices and:
>   - imx6_pcie_probe takes longer than start of late init
>   - pci_sysfs_init sets up flag sysfs_initialized
>   - pci_sysfs_init initializes already found devices
>   - imx6_pcie_probe tries to reinitialize device
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=215515
> 
> Signed-off-by: Korneliusz Osmenda <korneliuszo@gmail.com>
> ---
>   drivers/pci/pci-sysfs.c | 6 ++++++
>   include/linux/pci.h     | 2 ++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index fc804e08e3cb..a6648239e235 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1378,6 +1378,9 @@ int __must_check pci_create_sysfs_dev_files(struct
> pci_dev *pdev)
>   	if (!sysfs_initialized)
>   		return -EACCES;
> 
> +	if (atomic_cmpxchg(&pdev->sysfs_init_cnt,0,1) == 1)
> +		return 0;		/* already added */
> +
>   	return pci_create_resource_files(pdev);
>   }
> 
> @@ -1392,6 +1395,9 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
>   	if (!sysfs_initialized)
>   		return;
> 
> +	if (atomic_cmpxchg(&pdev->sysfs_init_cnt,1,0) == 0)
> +		return;		/* already removed */
> +
>   	pci_remove_resource_files(pdev);
>   }
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 060af91bafcd..5477de2ef057 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -465,6 +465,8 @@ struct pci_dev {
>   	pci_dev_flags_t dev_flags;
>   	atomic_t	enable_cnt;	/* pci_enable_device has been 
called */
> 
> +	atomic_t	sysfs_init_cnt;	/* pci_create_sysfs_dev_files has 
been called */
> +
>   	u32		saved_config_space[16]; /* Config space saved 
at suspend time */
>   	struct hlist_head saved_cap_space;
>   	int		rom_attr_enabled;	/* Display of ROM 
attribute enabled? */

Is there any feedback here? I'm hitting the same issue on TQMa6x+MBa6x.
Having this patch applied my PCIe device using several bridges is detected 
fine.

root@tqma6-common:~# lspci
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
02:01.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
02:02.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 
PCI Express Gigabit Ethernet Controller (rev 0c)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 
PCI Express Gigabit Ethernet Controller (rev 0c)

root@tqma6-common:~# lspci -t
-[0000:00]---00.0-[01-ff]----00.0-[02-04]--+-01.0-[03]----00.0
                                           \-02.0-[04]----00.0

Best regards,
Alexander



