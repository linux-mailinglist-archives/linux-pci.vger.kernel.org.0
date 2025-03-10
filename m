Return-Path: <linux-pci+bounces-23285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD2A58DC5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BEB1886118
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F44D1D6DA1;
	Mon, 10 Mar 2025 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiY8OyqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A3223311
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 08:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594496; cv=none; b=uBfZhtSmPRFyZ0ysZJNuEbtO+mwzLvpaYD/2abXCjLGFBfOq5yHkbRo5jg2nrG4kl/Q6oGP+3HamlUIDrcWPv04EcPbDEgcavY86e04SOm8MICH5CYKcZVXTSskFk+GQhuWV+87wBliP16VS1sXNTgQiw3gchilbIYX8z0+qLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594496; c=relaxed/simple;
	bh=ieOnLpKZdMXwTRsppKzD3lKC3vFircXxUr3yv6CciMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMHjs5eH096WtkIdRCdBqbyOAjSRxzzdLag/tZGS2f9nossNY2vKlzLzbd4nDPmwkA6xNvuhIf2+sAN+slVooVUpiLL7oCgD5W4Ls4vw8uGz7Dr6xKQkdq0g9nwJkPVOV5ifXMH7/rsVc7KjZIP8ZA3OzkyT8NiKd9fVUUr0KAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UiY8OyqV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf257158fso4973315e9.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741594493; x=1742199293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KkC1l654ivSQJHfpAMIQ+ZSAHbGtBz6q5j4dS4aJJk=;
        b=UiY8OyqVgacSrWHw1GPNIkDbhjH4eOWnwdUVt6yw0y7kv144F1WiiedWDrSbzhGmAn
         JBhASm/L9e03ZSWcXTZCqiUX24LKaWJWTOImPF7/HtQLjNJTnKaeG3cLI1QduFW/xbQ/
         iwQNW5pwFXo/PdRKdi8cOsdJTlT5jSG1GywVOCxfvmoOANQaBzn8rKVUKneVdE4mtl2S
         RpQmgFQwKdWf27Wepeing+arITkyq0hpBDTCuPCl4PsanZQc72eeqf1xJMUJuJ6Dn4a9
         73GiAEDLMX/ULaWEKKKyhz44BevDkUd5yDg1AN6vxaTzlNyu40ljJPwG4rTCnO6y4BGu
         /pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741594493; x=1742199293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KkC1l654ivSQJHfpAMIQ+ZSAHbGtBz6q5j4dS4aJJk=;
        b=Zi5UCiwJcpAWtIkCVspxTeJEyrI8hZ1wKqgmseSK9J77sfQuS8D/PnyiVCkbu3UB3M
         OmGLUSrCV8CK9rYv1aEi9fqiJwtbsLfXlSKaJowDmRY68Y4W3BghwxRsmCLX1NxQtaxm
         fUwVosgrUS8GCJd5hYJOFya9Ok4VcmZHBjexNjvlk6LPrOlUMP05bDqwqCQGfSzGa3rd
         Jw+zIVgZLhFWZJq4QgylPSJ6yjrNH9HPoLVwHdvZHkEaZOGCRUKFVB8ix8SdVFOJcM8Z
         mXBqtGMe9wDJS0yQ0i65puqTljy6wC6i0SLol6YCPGuUIGVCkrF4kcaZ0rE9nRn//zxI
         L7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ1XKs7z9vz3alhUTZcKpMgpjD1lswXjADfWpuDQR2vM2J3c6hdLwgohZf9XtDaJThYF038FBnE7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdw659KpNkqX7bBRYmtTbmia5GScalwjJNzc8DSQKps2LvMn4o
	xA7zyB0Oo7TgKeGGpxET0KRrexE9VxW07L8KwAS9XLs30tSjIocWw4txskTVcKM=
X-Gm-Gg: ASbGncsEfZXR7hvZVJQzHEfvctAMyZXHg/JdPR8T1BIt/njn5Uyw3LIw5WG52LlG57j
	VtskBfx/0GRMoSdhiA2zeU3bNuUIIZqtEqsoFCIZMX4EU1vhsZmOawA4VVBeQrWr+upfGyq/58B
	mE90QOiUkRWVJqju56BatVI76PvR8dq0kJQGgzNPvmSAZZcfk4CfRWzAziPIEegFyrnl3CgCuAM
	8Zkw2rjEVffZyVsYJX0+CoUqLT+zfpDiYbpKh4g0E23Tnt3b1JnxFiKqXN43r2VbCrU61I6zJbt
	09I0ttMSm+OntRD5ekfVac80ZuUegUTeuhd4aUqKGdCX3gEi5w==
X-Google-Smtp-Source: AGHT+IGAuAAY07Q8AHFN3C6TD8HtaPVPa6Tfe7wsUJ+gFJZ+qrYDD1atk9hsCbpXzVbCKHdNzeFEDw==
X-Received: by 2002:a05:600c:3b1f:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-43cf6c6588bmr17772455e9.15.1741594492829;
        Mon, 10 Mar 2025 01:14:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bd91338cesm156803745e9.7.2025.03.10.01.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:14:52 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:14:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Aun-Ali Zaidi <admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>,
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Message-ID: <f483ac12-c731-4dc8-9de5-059e07ff2c85@stanley.mountain>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>

On Sun, Mar 09, 2025 at 08:40:31AM +0000, Aditya Garg wrote:
> diff --git a/drivers/staging/apple-bce/apple_bce.c b/drivers/staging/apple-bce/apple_bce.c
> new file mode 100644
> index 000000000..c66e0c8d5
> --- /dev/null
> +++ b/drivers/staging/apple-bce/apple_bce.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "apple_bce.h"
> +#include <linux/module.h>
> +#include <linux/crc32.h>
> +#include "audio/audio.h"
> +#include <linux/version.h>
> +
> +static dev_t bce_chrdev;
> +static struct class *bce_class;
> +
> +struct apple_bce_device *global_bce;
> +
> +static int bce_create_command_queues(struct apple_bce_device *bce);
> +static void bce_free_command_queues(struct apple_bce_device *bce);
> +static irqreturn_t bce_handle_mb_irq(int irq, void *dev);
> +static irqreturn_t bce_handle_dma_irq(int irq, void *dev);
> +static int bce_fw_version_handshake(struct apple_bce_device *bce);
> +static int bce_register_command_queue(struct apple_bce_device *bce, struct bce_queue_memcfg *cfg, int is_sq);
> +
> +static int apple_bce_probe(struct pci_dev *dev, const struct pci_device_id *id)
> +{
> +	struct apple_bce_device *bce = NULL;
> +	int status = 0;
> +	int nvec;
> +
> +	pr_info("apple-bce: capturing our device\n");
> +
> +	if (pci_enable_device(dev))
> +		return -ENODEV;

	ret = pci_enable_device(dev);
	if (ret)
		return ret;

> +	if (pci_request_regions(dev, "apple-bce")) {

Same everywhere.  Propagate the error code.

> +		status = -ENODEV;
> +		goto fail;

Instead of "goto fail;" it's better to use a full unwind ladder
with better label names.
https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

> +	}
> +	pci_set_master(dev);
> +	nvec = pci_alloc_irq_vectors(dev, 1, 8, PCI_IRQ_MSI);
> +	if (nvec < 5) {
> +		status = -EINVAL;
> +		goto fail;
> +	}
> +
> +	bce = kzalloc(sizeof(struct apple_bce_device), GFP_KERNEL);

	bce = kzalloc(sizeof(*bce), GFP_KERNEL);

> +	if (!bce) {
> +		status = -ENOMEM;
> +		goto fail;
> +	}
> +
> +	bce->pci = dev;
> +	pci_set_drvdata(dev, bce);
> +
> +	bce->devt = bce_chrdev;
> +	bce->dev = device_create(bce_class, &dev->dev, bce->devt, NULL, "apple-bce");
> +	if (IS_ERR_OR_NULL(bce->dev)) {
> +		status = PTR_ERR(bce_class);


device_create() can't return NULL.
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

> +		goto fail;
> +	}
> +
> +	bce->reg_mem_mb = pci_iomap(dev, 4, 0);
> +	bce->reg_mem_dma = pci_iomap(dev, 2, 0);
> +
> +	if (IS_ERR_OR_NULL(bce->reg_mem_mb) || IS_ERR_OR_NULL(bce->reg_mem_dma)) {
> +		dev_warn(&dev->dev, "apple-bce: Failed to pci_iomap required regions\n");
> +		goto fail;
> +	}
> +
> +	bce_mailbox_init(&bce->mbox, bce->reg_mem_mb);
> +	bce_timestamp_init(&bce->timestamp, bce->reg_mem_mb);
> +
> +	spin_lock_init(&bce->queues_lock);
> +	ida_init(&bce->queue_ida);
> +
> +	if ((status = pci_request_irq(dev, 0, bce_handle_mb_irq, NULL, dev, "bce_mbox")))

I think checkpatch will complain about this.  Do it as.

	status = pci_request_irq(dev, 0, bce_handle_mb_irq, NULL, dev, "bce_mbox");
	if (status)

> +		goto fail;
> +	if ((status = pci_request_irq(dev, 4, NULL, bce_handle_dma_irq, dev, "bce_dma")))
> +		goto fail_interrupt_0;
> +
> +	if ((status = dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(37)))) {
> +		dev_warn(&dev->dev, "dma: Setting mask failed\n");
> +		goto fail_interrupt;
> +	}
> +
> +	/* Gets the function 0's interface. This is needed because Apple only accepts DMA on our function if function 0
> +	   is a bus master, so we need to work around this. */
> +	bce->pci0 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> +#ifndef WITHOUT_NVME_PATCH

Delete dead code?

> +	if ((status = pci_enable_device_mem(bce->pci0))) {
> +		dev_warn(&dev->dev, "apple-bce: failed to enable function 0\n");
> +		goto fail_dev0;
> +	}
> +#endif
> +	pci_set_master(bce->pci0);
> +
> +	bce_timestamp_start(&bce->timestamp, true);
> +
> +	if ((status = bce_fw_version_handshake(bce)))
> +		goto fail_ts;
> +	pr_info("apple-bce: handshake done\n");
> +
> +	if ((status = bce_create_command_queues(bce))) {
> +		pr_info("apple-bce: Creating command queues failed\n");
> +		goto fail_ts;
> +	}
> +
> +	global_bce = bce;

Do this right before the "return 0;"?

> +
> +	bce_vhci_create(bce, &bce->vhci);

Check for errors.

> +
> +	return 0;
> +
> +fail_ts:
> +	bce_timestamp_stop(&bce->timestamp);
> +#ifndef WITHOUT_NVME_PATCH
> +	pci_disable_device(bce->pci0);
> +fail_dev0:
> +#endif
> +	pci_dev_put(bce->pci0);
> +fail_interrupt:
> +	pci_free_irq(dev, 4, dev);
> +fail_interrupt_0:
> +	pci_free_irq(dev, 0, dev);
> +fail:
> +	if (bce && bce->dev) {
> +		device_destroy(bce_class, bce->devt);
> +
> +		if (!IS_ERR_OR_NULL(bce->reg_mem_mb))
> +			pci_iounmap(dev, bce->reg_mem_mb);
> +		if (!IS_ERR_OR_NULL(bce->reg_mem_dma))
> +			pci_iounmap(dev, bce->reg_mem_dma);
> +
> +		kfree(bce);
> +	}
> +
> +	pci_free_irq_vectors(dev);
> +	pci_release_regions(dev);
> +	pci_disable_device(dev);
> +
> +	if (!status)
> +		status = -EINVAL;

This is like saying "if the code is buggy then fix it" but it's better to
just not introduce bugs.  Which sounds difficult and unreliable, but it's
even more difficult and unreliable to predict which bugs people will add
and fix them correctly.

> +	return status;
> +}

regards,
dan carpenter


