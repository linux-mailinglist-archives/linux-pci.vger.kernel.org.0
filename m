Return-Path: <linux-pci+bounces-10826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF793CEC0
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 09:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F86E1F22151
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 07:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449A2225D7;
	Fri, 26 Jul 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Pr1g6gD1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F303A2A;
	Fri, 26 Jul 2024 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978542; cv=none; b=doRDqSftePnU9TQ8ffyvZh/R2tOH6Z9yoYUTwL+gW/ccZkFyH96RrOUyZTY7fQzIW9dYEKTi67lQ3VheXIeuNPGgRRs6YZACtM00EEnaImVmYpzQ4iyLn2MhjZynkJ9lx2AN5hjS3aSi/zJmO8PErp8oTXJ6CJl6Xm0FJEDrxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978542; c=relaxed/simple;
	bh=2JbLD6jaW6x6BA/sR9/SQ6vyPM670m1NlSV5gm2q91A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixbyGm43r0/dB/F/IiWjoeFVI7BvyeaEdAKQrrWIdb57F+c6qGyhSpjT9N00XsLrU1JfD3/8XGZkGZZms+S8eDBWBU0RaLiroYKFgxlbxIXBHshNpecyZymWu3jn/WS9wspTL/YIyo2tSWODDg4vNO2KozdZLXWZsM91OpzjonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Pr1g6gD1; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.101.195.16] (unknown [10.101.195.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D663E41098;
	Fri, 26 Jul 2024 07:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721978537;
	bh=8Hhfqs0Ybtcs3cAp4OwCwvCol+GXkHQnr9pfIzKwbCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Pr1g6gD1ca9giDUyersdFNyzxGiqFa/p+R9OgVSjcUFyHwi0PIVK+Cw0l8rhhvDlW
	 AkISOaKPfthwAQF8R0jo0vFNePaU4Vjx8Hw5JeJz57tG2vbCesW0jpISNHWfjIBJ3z
	 DIXq8m0iJhHUTNzFdv7hKRqm+ojq27LkuV2lM3nohP5veCJfc8FXOxg+QHpDiKinHF
	 HdUu7szzt0ZDjfSs3KhcdH7Or6BNCZHkwJ5UuCA42GSHsc8z9PKV302vk7WZCNPC/F
	 pvd0bhfaV4Qf2JQ+DGc9riZgVBqmZiU4SSFgTmTv/8DGCrlnPjdcjMlZpOtEGUsjQj
	 t+B18PpzGyaQQ==
Message-ID: <db2d9152-7c33-4fbc-8ca5-d70ab9f7598d@canonical.com>
Date: Fri, 26 Jul 2024 15:22:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: ASPM: Allow OS to configure ASPM where BIOS is
 incapable of
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
 ilpo.jarvinen@linux.intel.com, david.e.box@linux.intel.com,
 AceLan Kao <acelan.kao@canonical.com>
References: <20240530085227.91168-1-kai.heng.feng@canonical.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20240530085227.91168-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I tested the patchset on a Dell machine (the testing result is positive).

Without the patchset, the ASPM is disabled on the NVME controller:

         LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

After applying the patchset, the ASPM is enabled on the NVME controller:

          LnkCtl:    ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-


Regards,

Hui.


On 5/30/24 16:52, Kai-Heng Feng wrote:
> Since commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM
> and LTR"), ASPM is configured for NVMe devices enabled in VMD domain.
>
> However, that doesn't cover the case when FADT has ACPI_FADT_NO_ASPM
> set.
>
> So add a new attribute to bypass aspm_disabled so OS can configure ASPM.
>
> Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
> Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com/
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/pci/pcie/aspm.c | 8 ++++++--
>   include/linux/pci.h     | 1 +
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8..e719605857b1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1416,8 +1416,12 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>   	 * the _OSC method), we can't honor that request.
>   	 */
>   	if (aspm_disabled) {
> -		pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
> -		return -EPERM;
> +		if (aspm_support_enabled && pdev->aspm_os_control)
> +			pci_info(pdev, "BIOS can't program ASPM, let OS control it\n");
> +		else {
> +			pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
> +			return -EPERM;
> +		}
>   	}
>   
>   	if (!locked)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fb004fd4e889..58cbd4bea320 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -467,6 +467,7 @@ struct pci_dev {
>   	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
>   	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
>   	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
> +	unsigned int	aspm_os_control:1;	/* Display of ROM attribute enabled? */
>   	pci_dev_flags_t dev_flags;
>   	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>   

