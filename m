Return-Path: <linux-pci+bounces-14666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518489A0FBC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830681C22444
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934F210C2B;
	Wed, 16 Oct 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y6C0XCQb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qHeBuB60"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA8121262D;
	Wed, 16 Oct 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729096244; cv=none; b=uyV5EUu8iZPIJKJdC50JOfgNukXjSCN+DTAdMrk/sipGZu4trydXwz5JG9yNg5Wc9hlHrJNh5Xah/K+iD13W8TPRW38fK1YoYM5np+pvWPvBwZ2H2NRXvqxUZxJcBUQczm5+KWyhAydsyf9w+RPjnYPjIQYdbzj13VFlKIYZ6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729096244; c=relaxed/simple;
	bh=cDmL46+7Ku1CNJyK9Pw37iodZ7eTlrRbqtcHf6yfnVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a0B98CM6RMDIx5gBtF7uxvp2IfAN+zEyoUCEKOCclmlkg95frD7iEZxrnpiQj9E5NkJuh22zYsjKudxecTE5JfrezW0WK9aVqF3fhA3Ot6VAndexEbv6X2XRI+1nfXjmXGIxaRZdtVdsHZdvOIIly5SuO7g7B9SzbUQJkoLGhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y6C0XCQb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qHeBuB60; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729096240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SWyLDPM1si1whstwx/9ABSaUWaUgglk4Hprd/du6iYw=;
	b=Y6C0XCQbnjXu9g+n7ipBQO4mi2O8D6Yj4e4zkTe6iEyN5gezy/VlLmZCJd3+lc570n/oTN
	ObHrXxAE6/Q1Yk0QuLlNoo19QmId5Yv6nj3/PmWEhrGyTqz5/Gw3dmRoWCc6t5Quu8e1AR
	qjIXbgatuF3iAbeKZxW2BTdp+gEDzfUYvef+bR4LFPn/8f/vgW1tiI4O2v1wRmKkjQ42Ol
	saKriitcideFKMmPaVFr906BhCiMAd4rVH47eIyKLaLZyFyiUk/tmkQCRa4KKFH9sBBSwN
	O0nSbblOSWl7/N5GvPY7phHDZONfp3S1sL0Kaoe2kNsfCUizgRTktHW1kazKfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729096240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SWyLDPM1si1whstwx/9ABSaUWaUgglk4Hprd/du6iYw=;
	b=qHeBuB60aYAix5Z9uU78up425Aybm/bfCt6Zy73SAyWJWcD2rHExAaLg/mXZ9+EUM7daqn
	/LA+K/BCsIz8hWDg==
To: Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
 dlemoal@kernel.org, maz@kernel.org, jdmason@kudzu.us, Frank Li
 <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 3/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
In-Reply-To: <20241015-ep-msi-v3-3-cedc89a16c1a@nxp.com>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-3-cedc89a16c1a@nxp.com>
Date: Wed, 16 Oct 2024 18:30:40 +0200
Message-ID: <87bjzkau33.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 15 2024 at 18:07, Frank Li wrote:
> +static int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_db)
> +{
> +	struct msi_desc *desc, *failed_desc;
> +	struct pci_epf *epf;
> +	struct device *dev;
> +	int i = 0;
> +	int ret;
> +
> +	if (IS_ERR_OR_NULL(epc))
> +		return -EINVAL;
> +
> +	/* Currently only support one func and one vfunc for doorbell */
> +	if (func_no || vfunc_no)
> +		return -EINVAL;
> +
> +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> +	if (!epf)
> +		return -EINVAL;
> +
> +	dev = epc->dev.parent;
> +	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
> +	if (ret) {
> +		dev_err(dev, "Failed to allocate MSI\n");
> +		return -ENOMEM;
> +	}
> +
> +	scoped_guard(msi_descs, dev)
> +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {

That's just wrong. Nothing in this code has to fiddle with MSI
descriptors or the descriptor lock.

        for (i = 0; i < num_db; i++) {
            virq = msi_get_virq(dev, i);

> +			ret = request_irq(desc->irq, pci_epf_doorbell_handler, 0,
> +					  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i++), epf);
> +			if (ret) {
> +				dev_err(dev, "Failed to request doorbell\n");
> +				failed_desc = desc;
> +				goto err_request_irq;
> +			}
> +		}
> +
> +	return 0;
> +
> +err_request_irq:
> +	scoped_guard(msi_descs, dev)
> +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> +			if (desc == failed_desc)
> +				break;
> +			kfree(free_irq(desc->irq, epf));

All instances of interrupts get 'epf' as device id. So if the third
instance failed to be requested, you free 'epf' when freeing the first
interrupt and then again when freeing the second one.

Thanks,

        tglx

