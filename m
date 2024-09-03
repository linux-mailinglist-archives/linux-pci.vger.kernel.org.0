Return-Path: <linux-pci+bounces-12645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AAF9692E4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 06:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879AB1C21564
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 04:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132B13CABC;
	Tue,  3 Sep 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIzuo3bA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0641CCEFA
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725337742; cv=none; b=CxxmFws9lCJqAVd6Bh/DTr4urz82ZxM+2AOQithzqcrbqswa+1U3uxqTkNgDnP4I62nlBd/+VuvWdPUDh2Gi1ieG40ibQZWBKsMKL8XTR+aJ3+gJvf8Ny/96AkXGQSsJ9P2Pp8RyXob1nk1mplrRpIkMtpUN0by84cupDx9qvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725337742; c=relaxed/simple;
	bh=uaNYjUGylBlzzEwzrRcswPiNmwnv/hrdgOJX/8GbEpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/arEaaAaycwV9HyxGRKG+HDJEkqW1abrjdXsa0jpWrfg5oWUIAiOpJxWxCnvqINH9l5d1OTAM9wGkQ70NVs8xOLu4C6EIDYxTGvWBIz1Ba8/Gclh3SfQs2lTKltob6yhV467h+uafpeZM7aW3YXIzP0NfIXwuPZOWIuEhjqK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIzuo3bA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-715cc93694fso4182412b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2024 21:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725337740; x=1725942540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fuFdv8dhgYOwZKDgHzs4ExbEhbM9qG3eg7uVxG6zS0M=;
        b=LIzuo3bAiHgd5eG3zBhHpF9Xv4TX5Uhyr9v+mMKTybvwZ0aUMl5hPVVWqpFUBK33ew
         elNbNHcpt6bSmqKw2i5CtMepetLs+RhVLV4+m05Ln3hZSyIsCT0s9f8if3lhrlLRu61T
         UxE3aGb/8+0Qqf8FWVMkS5ERgMfjuyC0aW3cxqm7zYkyMl/oL5GOzM6VNhIrGc0moOzY
         n1hlc0zWDtZ29tW6WR/WK/wqMc4rSlu5HYrFyb+bZBhcIILKKq8Mzzojq+oSFp87mw7q
         Z1GatBuqXau3qwiboL4gYUMNhsriNZdgbhiaKnyyh/LcnPxwTembAC5ACVIE1dUi76lm
         lpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725337740; x=1725942540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuFdv8dhgYOwZKDgHzs4ExbEhbM9qG3eg7uVxG6zS0M=;
        b=qZiTxwwaYUjocMCaUmRqAoW4TjGk0BOU5tOpvnOhsz9q5CHSVQnsA00H6WAPgmGlmi
         AwsRisHNRwriyKArHl2mCSFeh6fkpsn3PxZFeySsvlh9zazVtLUQNys5fPszW33JeEmB
         hdIPVzpjdAsTxniNWntGBTJA4X3pWdK0cfZZbXKAyf2AI+sorVO2q3+zwiEEbd8IScrM
         bO/5K/JCT54VQ24PKp3RfxSzoX1G7H6o25O6IewoIlAq+LKA/Wiu30mJ9w6m4oQbTw5a
         BAGg67N/yR2CdkRg14thIdM3v7ojdVnm10dbPinj/HH64cb2kzJ62sD6OJcRSbStTv+r
         s+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYONZ9DDj5HLPWNPmV87W7xKd6ty2MEZo6MEea3ByqCWIoPqouND09Iersy+/y3g8N+TjmejC/pTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJEaGgL0jsQZfntgAsMoAlwCV7M2LQ7Ayx7JjF2q/Lj2XdTEd/
	mmccIeYDC9AsGmjGtKDAsjp0Ezs4t0vVCSRX6l4gd7GRbPqWTD9ITAgwvRBqrg==
X-Google-Smtp-Source: AGHT+IGKutqEntkPYoSNRtZVCU1ZP0p8eGFV9PBE8Bbyg7/tv6SjCSKj7MXOGG3+RJbYvyayBIdkxA==
X-Received: by 2002:a05:6a00:1a93:b0:70b:1b51:b8af with SMTP id d2e1a72fcca58-7173c589968mr10500532b3a.19.1725337739995;
        Mon, 02 Sep 2024 21:28:59 -0700 (PDT)
Received: from thinkpad ([120.60.129.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a45a7sm7600155b3a.53.2024.09.02.21.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:28:59 -0700 (PDT)
Date: Tue, 3 Sep 2024 09:58:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	acelan.kao@canonical.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Delay interrupt handling on MTL VMD controller
Message-ID: <20240903042852.v7ootuenihi5wjpn@thinkpad>
References: <20240903025544.286223-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903025544.286223-1-kai.heng.feng@canonical.com>

On Tue, Sep 03, 2024 at 10:55:44AM +0800, Kai-Heng Feng wrote:
> Meteor Lake VMD has a bug that the IRQ raises before the DMA region is
> ready, so the requested IO is considered never completed:
> [   97.343423] nvme nvme0: I/O 259 QID 2 timeout, completion polled
> [   97.343446] nvme nvme0: I/O 384 QID 3 timeout, completion polled
> [   97.343459] nvme nvme0: I/O 320 QID 4 timeout, completion polled
> [   97.343470] nvme nvme0: I/O 707 QID 5 timeout, completion polled
> 
> The is documented as erratum MTL016 [0]. The suggested workaround is to
> "The VMD MSI interrupt-handler should initially perform a dummy register
> read to the MSI initiator device prior to any writes to ensure proper
> PCIe ordering." which essentially is adding a delay before the interrupt
> handling.
> 

Why can't you add a dummy register read instead? Adding a delay for PCIe
ordering is not going to work always.

> Hence add a delay before handle interrupt to workaround the erratum.
> 
> [0] https://edc.intel.com/content/www/us/en/design/products/platforms/details/meteor-lake-u-p/core-ultra-processor-specification-update/errata-details/#MTL016
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217871
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/controller/vmd.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a726de0af011..3433b3730f9c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -16,6 +16,7 @@
>  #include <linux/srcu.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <linux/delay.h>
>  
>  #include <asm/irqdomain.h>
>  
> @@ -74,6 +75,9 @@ enum vmd_features {
>  	 * proper power management of the SoC.
>  	 */
>  	VMD_FEAT_BIOS_PM_QUIRK		= (1 << 5),
> +
> +	/* Erratum MTL016 */
> +	VMD_FEAT_INTERRUPT_QUIRK	= (1 << 6),
>  };
>  
>  #define VMD_BIOS_PM_QUIRK_LTR	0x1003	/* 3145728 ns */
> @@ -90,6 +94,8 @@ static DEFINE_IDA(vmd_instance_ida);
>   */
>  static DEFINE_RAW_SPINLOCK(list_lock);
>  
> +static bool interrupt_delay;
> +
>  /**
>   * struct vmd_irq - private data to map driver IRQ to the VMD shared vector
>   * @node:	list item for parent traversal.
> @@ -105,6 +111,7 @@ struct vmd_irq {
>  	struct vmd_irq_list	*irq;
>  	bool			enabled;
>  	unsigned int		virq;
> +	bool			delay_irq;

This is unused. Perhaps you wanted to use this instead of interrupt_delay?

- Mani

>  };
>  
>  /**
> @@ -680,8 +687,11 @@ static irqreturn_t vmd_irq(int irq, void *data)
>  	int idx;
>  
>  	idx = srcu_read_lock(&irqs->srcu);
> -	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
> +	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node) {
> +		if (interrupt_delay)
> +			udelay(4);
>  		generic_handle_irq(vmdirq->virq);
> +	}
>  	srcu_read_unlock(&irqs->srcu, idx);
>  
>  	return IRQ_HANDLED;
> @@ -1015,6 +1025,9 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
>  		vmd->first_vec = 1;
>  
> +	if (features & VMD_FEAT_INTERRUPT_QUIRK)
> +		interrupt_delay = true;
> +
>  	spin_lock_init(&vmd->cfg_lock);
>  	pci_set_drvdata(dev, vmd);
>  	err = vmd_enable_domain(vmd, features);
> @@ -1106,7 +1119,8 @@ static const struct pci_device_id vmd_ids[] = {
>  	{PCI_VDEVICE(INTEL, 0xa77f),
>  		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0x7d0b),
> -		.driver_data = VMD_FEATS_CLIENT,},
> +		.driver_data = VMD_FEATS_CLIENT |
> +			       VMD_FEAT_INTERRUPT_QUIRK,},
>  	{PCI_VDEVICE(INTEL, 0xad0b),
>  		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

