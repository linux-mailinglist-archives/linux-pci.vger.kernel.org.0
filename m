Return-Path: <linux-pci+bounces-34303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E7B2C6BE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EB6A03C18
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31017230D0D;
	Tue, 19 Aug 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4QLHIp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECF2222C7;
	Tue, 19 Aug 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612781; cv=none; b=n1bNHV4KzeZ7nsQr+pZz4FPuFEjDq+pmsU16u0tJg7yCGWGDFJN7IqIt5BouAYhZxWPPtdLVftclIDsdfd6laBdILdCrNt/t/Cx5mZvbmc8jcA3RohHIR4AfPF8Oe2Sr7LuWIjbJSQ/3btcuBdB4kMEHKHCxKNNM6/RFzp49wiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612781; c=relaxed/simple;
	bh=MOnJwN5itMaHqMbl837wey792eccQ3iEgZtzSy1I6gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJgWHO+OfDpwHLWXeNWfNDVp2rCFQ4d1yHiJh3V012xK8iNhLHaq9rYjsTfutjjC/TY6RDtkv3yCvfo6jOBsA90GLgTiWenCVayKuzavp4+d2IXBYMctkRwRPxdVaACPXe/uHFuAeuw2csFOTJ55AxMiqlzvetlVXF9NlE13rNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4QLHIp/; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-618adc251f0so6940101a12.3;
        Tue, 19 Aug 2025 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755612776; x=1756217576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rom/ptDsxRGJM1AJ//ihjpMNAtsF50k3kKj9llJ3pM=;
        b=A4QLHIp/5jaemM7QneCdyKzK0xw1ik3DYAlQ2fAH521SRkxejc8qCtq6ihM2dkUGcR
         RhNgHOxPd4Rc5wM4uq/jSyvl9AyT/SjOoftH6hUCGUdDPkHSj/Sf7hgELVF28NWFJgD6
         7GfCpt3oyiZbcbv8BRCbu7Aw5FEvzj8m0NcsHyT8iUvo+1x6JYDN+rdT9NPCk7QA20op
         YLtrryURexRed6kezcPKbzDk0qcahyvHALs0eyhNHGdk2nIZJSwPht/Cb3cweaie7PP1
         iBqmI0RbD/rCMPcoK+B6uEaquD4Jw5hd8m3Hq4t8f8Q44mZxPf44Yyuu6Fwkw1EtH48S
         I7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755612776; x=1756217576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rom/ptDsxRGJM1AJ//ihjpMNAtsF50k3kKj9llJ3pM=;
        b=jgtb20M8cPZqwsh/X/C5+dhlm/lGORTLTX8BnPQlVpcy64V7VMJqaRMUcTNVd7JSSq
         hcMVyv7jsfvgecfvGgHFU9eSzorgmUnU5zuEDp4JRqDoCQo4oXAdb7bOCM4793npLLOY
         tP8DkMXvRbfsH5n6GlXBDhL9IN1OAJUVjLY/f2EpOhqsfQ+aFU/BKQmDFNKXaUlofd0m
         L966HOvMYrWZ5ghXIkUAdM6F2jCbC2soXr6aoXGWj7kgTbFuPe8d/F+dAjyDs/uThmbT
         8Gzici3gem7QUr3BR3xYqiovB/NVV1zi1fmUblr6d6TudR2P0NEcYPem61WAE4vMGK4x
         RYkw==
X-Forwarded-Encrypted: i=1; AJvYcCUTIzqgGUzEPP1qPF5QmmqzKXaI3XY4CuxNuKq38LqeahiZg9W3kGg+QHcdYv/QR9bMA9Y3aiJ4jQ3PvAVi@vger.kernel.org, AJvYcCUYjM5NqwZh3e2PKGRcsABDFmMgcMaY0IDv+aJLe+1vAHBhPiId87SMrEhHWaHExr/K3EaXz58oLuJX@vger.kernel.org, AJvYcCV54zkTFIqQp3Ayjr3iD7NYV3MHlq87VPTXnRSBcJVkaG926fmYlnL9DhaGGiIcd+pJKew6bAAT6LKt7M0=@vger.kernel.org, AJvYcCVOfhlTzG5HKSvhDTLNmCGSlj9JyqixG5GltjGpCrJh5YqAlzlmE+vcRWUQ+eIPs18EVRGEoExK6RNFYhQobA==@vger.kernel.org, AJvYcCXxcHaWs6yjhhptcQVfotQ2gB7SltOg91wCLHda1GwVpj1YhVO3rCbl+VVJ0IO1aM2EqQS8mbMNoVFI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+TqD4Ufyxgslpf4zornTpQaq2zhlJ+Tn42h1eE23lOeietmY
	wuSoJMzvl+JzAPFPgRtHNj9uSTk0MGpr6kOIsAbLW+4Ry7y5Ii70dx6Z
X-Gm-Gg: ASbGncvlYNpd2v0teVVkXKs0Cf0V3uLgoE7vRAoApp4yJ0a4vOoGZxWo5ZnRfxnAHJA
	GIgyGkCJROpggBC0HSD8B5eOCVXQ95oqdWq0HGjh701zIRjFWMjmIHJEC+eW6bJr4rcDzX0GiwI
	nphmDYHOJbhVGierpvNmQaabePOu0BW/WU31TekH1qwz+4HZcmadI/S3Ap5n7sc3ozBvujmdn52
	JpwV1bw2xNXoTPHJiLewJqNh49r0qPOLNQnXlOoIKyEGa5LFR+2VRE1+ouFSTfVD4Z+eRmrHrYu
	ATgHAsEys9XsprKSg5Dd0vCSL/xdfCb6PDcjGJL2cdC1Heb11JoSNRnfUt5G79bpx/ZDmU4WogY
	nljP3qNK0nLCMOz6Bqo0MFCgHP1UAdSRZiqUu6XRqG+/UL2ZO9SlHXEeeMGgdlkVGGZRn1/LCxt
	RR4ML+P6Q+kzhIJ6sZqMak
X-Google-Smtp-Source: AGHT+IFjds2SJBGycL2SuHhwQHLH3bYoZmPtau2WcISFrPcM8JLn2BauR7tIIFylmYhvn0dRldBLkQ==
X-Received: by 2002:a17:907:9493:b0:af9:74b4:f4b7 with SMTP id a640c23a62f3a-afddd201b61mr242326466b.45.1755612775940;
        Tue, 19 Aug 2025 07:12:55 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdb602ca0esm589785866b.2.2025.08.19.07.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 07:12:55 -0700 (PDT)
Message-ID: <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
Date: Tue, 19 Aug 2025 22:12:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
To: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
 joro@8bytes.org, bhelgaas@google.com, jgg@nvidia.com
Cc: will@kernel.org, robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
 patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
 helgaas@kernel.org
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 6:59 AM, Nicolin Chen wrote:
> PCIe permits a device to ignore ATS invalidation TLPs, while processing a
> reset. This creates a problem visible to the OS where an ATS invalidation
> command will time out: e.g. an SVA domain will have no coordination with a
> reset event and can racily issue ATS invalidations to a resetting device.
> 
> The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
> block ATS before initiating a Function Level Reset. It also mentions that
> other reset methods could have the same vulnerability as well.
> 
> Now iommu_dev_reset_prepare/done() helpers are introduced for this matter.
> Use them in all the existing reset functions, which will attach the device
> to an IOMMU_DOMAIN_BLOCKED during a reset, so as to allow IOMMU driver to:
>   - invoke pci_disable_ats() and pci_enable_ats(), if necessary
>   - wait for all ATS invalidations to complete
>   - stop issuing new ATS invalidations
>   - fence any incoming ATS queries
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/pci/pci-acpi.c | 17 +++++++++--
>   drivers/pci/pci.c      | 68 ++++++++++++++++++++++++++++++++++++++----
>   drivers/pci/quirks.c   | 23 +++++++++++++-
>   3 files changed, 100 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index ddb25960ea47d..adaf46422c05d 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -9,6 +9,7 @@
>   
>   #include <linux/delay.h>
>   #include <linux/init.h>
> +#include <linux/iommu.h>
>   #include <linux/irqdomain.h>
>   #include <linux/pci.h>
>   #include <linux/msi.h>
> @@ -969,6 +970,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
>   int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>   {
>   	acpi_handle handle = ACPI_HANDLE(&dev->dev);
> +	int ret = 0;
>   
>   	if (!handle || !acpi_has_method(handle, "_RST"))
>   		return -ENOTTY;
> @@ -976,12 +978,23 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>   	if (probe)
>   		return 0;
>   
> +	/*
> +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> +	 * before initiating a reset. Notify the iommu driver that enabled ATS.
> +	 */
> +	ret = iommu_dev_reset_prepare(&dev->dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU\n");
> +		return ret;
> +	}
> +
>   	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
>   		pci_warn(dev, "ACPI _RST failed\n");
> -		return -ENOTTY;
> +		ret = -ENOTTY;
>   	}
>   
> -	return 0;
> +	iommu_dev_reset_done(&dev->dev);
> +	return ret;
>   }
>   
>   bool acpi_pci_power_manageable(struct pci_dev *dev)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cdd..d6d87e22d81b3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -13,6 +13,7 @@
>   #include <linux/delay.h>
>   #include <linux/dmi.h>
>   #include <linux/init.h>
> +#include <linux/iommu.h>
>   #include <linux/msi.h>
>   #include <linux/of.h>
>   #include <linux/pci.h>
> @@ -4529,13 +4530,26 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>    */
>   int pcie_flr(struct pci_dev *dev)
>   {
> +	int ret = 0;
> +
>   	if (!pci_wait_for_pending_transaction(dev))
>   		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>   
> +	/*
> +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> +	 * before initiating a reset. Notify the iommu driver that enabled ATS.
> +	 * Have to call it after waiting for pending DMA transaction.
> +	 */
> +	ret = iommu_dev_reset_prepare(&dev->dev);
If we dont' consider the association between IOMMU and devices in FLR(),
it can be understood that more complex processing logic resides outside
this function. However, if the FLR() function already synchironizes and
handles the association with IOMMU like this (disabling ATS by attaching
device to blocking domain), then how would the following scenarios
behave ?

1. Reset one of PCIe alias devices.
2. Reset PF when its VFs are actvie.
....

Thanks,
Ethan> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU\n");
> +		return ret;
> +	}
> +
>   	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>   
>   	if (dev->imm_ready)
> -		return 0;
> +		goto done;
>   
>   	/*
>   	 * Per PCIe r4.0, sec 6.6.2, a device must complete an FLR within
> @@ -4544,7 +4558,11 @@ int pcie_flr(struct pci_dev *dev)
>   	 */
>   	msleep(100);
>   
> -	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
> +	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
> +
> +done:
> +	iommu_dev_reset_done(&dev->dev);
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(pcie_flr);
>   
> @@ -4572,6 +4590,7 @@ EXPORT_SYMBOL_GPL(pcie_reset_flr);
>   
>   static int pci_af_flr(struct pci_dev *dev, bool probe)
>   {
> +	int ret = 0;
>   	int pos;
>   	u8 cap;
>   
> @@ -4598,10 +4617,21 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>   				 PCI_AF_STATUS_TP << 8))
>   		pci_err(dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
>   
> +	/*
> +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> +	 * before initiating a reset. Notify the iommu driver that enabled ATS.
> +	 * Have to call it after waiting for pending DMA transaction.
> +	 */
> +	ret = iommu_dev_reset_prepare(&dev->dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU\n");
> +		return ret;
> +	}
> +
>   	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
>   
>   	if (dev->imm_ready)
> -		return 0;
> +		goto done;
>   
>   	/*
>   	 * Per Advanced Capabilities for Conventional PCI ECN, 13 April 2006,
> @@ -4611,7 +4641,11 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>   	 */
>   	msleep(100);
>   
> -	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
> +	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
> +
> +done:
> +	iommu_dev_reset_done(&dev->dev);
> +	return ret;
>   }
>   
>   /**
> @@ -4632,6 +4666,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>   static int pci_pm_reset(struct pci_dev *dev, bool probe)
>   {
>   	u16 csr;
> +	int ret;
>   
>   	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
>   		return -ENOTTY;
> @@ -4646,6 +4681,16 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>   	if (dev->current_state != PCI_D0)
>   		return -EINVAL;
>   
> +	/*
> +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> +	 * before initiating a reset. Notify the iommu driver that enabled ATS.
> +	 */
> +	ret = iommu_dev_reset_prepare(&dev->dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU\n");
> +		return ret;
> +	}
> +
>   	csr &= ~PCI_PM_CTRL_STATE_MASK;
>   	csr |= PCI_D3hot;
>   	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
> @@ -4656,7 +4701,9 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>   	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>   	pci_dev_d3_sleep(dev);
>   
> -	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
> +	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
> +	iommu_dev_reset_done(&dev->dev);
> +	return ret;
>   }
>   
>   /**
> @@ -5111,6 +5158,16 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>   	if (rc)
>   		return -ENOTTY;
>   
> +	/*
> +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> +	 * before initiating a reset. Notify the iommu driver that enabled ATS.
> +	 */
> +	rc = iommu_dev_reset_prepare(&dev->dev);
> +	if (rc) {
> +		pci_err(dev, "failed to stop IOMMU\n");
> +		return rc;
> +	}
> +
>   	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR) {
>   		val = reg;
>   	} else {
> @@ -5125,6 +5182,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>   		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>   				      reg);
>   
> +	iommu_dev_reset_done(&dev->dev);
>   	return rc;
>   }
>   
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d97335a401930..6157c6c02bdb0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -21,6 +21,7 @@
>   #include <linux/pci.h>
>   #include <linux/isa-dma.h> /* isa_dma_bridge_buggy */
>   #include <linux/init.h>
> +#include <linux/iommu.h>
>   #include <linux/delay.h>
>   #include <linux/acpi.h>
>   #include <linux/dmi.h>
> @@ -4225,6 +4226,26 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>   	{ 0 }
>   };
>   
> +static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
> +				    const struct pci_dev_reset_methods *i)
> +{
> +	int ret;
> +
> +	/*
> +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> +	 * before initiating a reset. Notify the iommu driver that enabled ATS.
> +	 */
> +	ret = iommu_dev_reset_prepare(&dev->dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU\n");
> +		return ret;
> +	}
> +
> +	ret = i->reset(dev, probe);
> +	iommu_dev_reset_done(&dev->dev);
> +	return ret;
> +}
> +
>   /*
>    * These device-specific reset methods are here rather than in a driver
>    * because when a host assigns a device to a guest VM, the host may need
> @@ -4239,7 +4260,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
>   		     i->vendor == (u16)PCI_ANY_ID) &&
>   		    (i->device == dev->device ||
>   		     i->device == (u16)PCI_ANY_ID))
> -			return i->reset(dev, probe);
> +			return __pci_dev_specific_reset(dev, probe, i);
>   	}
>   
>   	return -ENOTTY;


