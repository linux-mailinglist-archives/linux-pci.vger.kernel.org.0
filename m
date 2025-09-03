Return-Path: <linux-pci+bounces-35391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C03B42503
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F0F683DFA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551DA22D7A5;
	Wed,  3 Sep 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5sT4Euy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115B5224B04;
	Wed,  3 Sep 2025 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912981; cv=none; b=p0Sn7d3v3rEH/lbYHXHmcwxe+laFqKYGq9KqksbBWiifoqp9Jwr6qUpvn5dPGfqhfi5DvN3x8ZSdhEgMvH0PSW319Ag2figbX5XsEiXLH1lPVYnBh15Y3fOkhaSI/wL+YmJt/KyxpgJEioWMWT/zQfxUD+ChqYfyMipEjUCQ/qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912981; c=relaxed/simple;
	bh=bhYXOcXvWX1M4NXws9abVTsiqrliZnq46jgaaxlHGWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WRLyhS7GzDkzV+D5I3g2TxMYDDVMzPWTox/IwRQ29C/fDIRAv+R4hvezba1EFHl9tifQcU/jvT67pubedhuP4S5JP8YFhhC3Mcius68DLDdh355Un2kq0E9nHHjficLH9l9ulcJIC/K6t491LTAobtmo1DarL8lVGQ0cmVE9Kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5sT4Euy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5C2C4CEE7;
	Wed,  3 Sep 2025 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756912980;
	bh=bhYXOcXvWX1M4NXws9abVTsiqrliZnq46jgaaxlHGWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n5sT4EuyhdcEYZmfGvSl/RkrFHrCQtPUE8H1tl5NM1urvTsV8091ZyroJI8B8hZK9
	 74zR1/Zg2Us6ZQgwF2txnl0eYSyDRj7cKDMbr3dxmat+Cy+4VvmNgwca1nXpUfTPA4
	 MIpm3tOjnUaLEJ7q0JIpdrTB9VUazMJkJzY4gIovSd3P/9dQemd0AsJzEAeP+qwBJH
	 +jBToESH0RXMzTOKcgBsXI7+Qruhll2May//Mte03FigutdB5kXv6a7qmA8uPRh32y
	 3CLyrVnEPctyRaSqfeBgoG1qNxAXcNqbhK2qsBPC7fmZ7Wnod9MYBfCjhMXvmNQ1fW
	 VdxAbxKQ+RZ9A==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com,
	aik@amd.com
Subject: Re: [PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
 support
In-Reply-To: <20250827035259.1356758-6-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-6-dan.j.williams@intel.com>
Date: Wed, 03 Sep 2025 20:52:52 +0530
Message-ID: <yq5av7lz1rxv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:


....

> +
> +static int pci_tsm_lock(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +	struct pci_tsm *tsm;
> +	int rc;
> +
> +	ACQUIRE(device_intr, lock)(&pdev->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &lock)))
> +		return rc;
> +
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	tsm = ops->lock(pdev);
> +	if (IS_ERR(tsm))
> +		return PTR_ERR(tsm);
> +
> +	pdev->tsm = tsm;
> +	return 0;
> +}
>

This is slightly different from connect() callback in that we don't have
pdev->tsm initialized when calling ->lock() callback. Should we do
something like below? (I also included the arch changes to show how
destructor is being used.)

modified   drivers/pci/tsm.c
@@ -917,11 +917,19 @@ int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
 	pci_tsm->tdi = NULL;
 	pci_tsm->pdev = pdev;
 	pci_tsm->ops = ops;
+	pdev->tsm = pci_tsm;
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_tsm_devsec_constructor);
 
+int pci_tsm_devsec_destructor(struct pci_dev *pdev)
+{
+	pdev->tsm = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_devsec_destructor);
+
 /**
  * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
  * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
modified   drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -217,13 +217,17 @@ static struct pci_tsm *cca_tsm_lock(struct pci_dev *pdev)
 		return ERR_PTR(ret);
 
 	ret = rhi_da_vdev_set_tdi_state(vdev_id, RHI_DA_TDI_CONFIG_LOCKED);
-	if (ret)
+	if (ret) {
+		pci_tsm_devsec_destructor(pdev);
 		return ERR_PTR(-EIO);
+	}
 
 	/* This will be done by above rhi in later spec */
 	ret = rsi_device_lock(pdev);
-	if (ret)
+	if (ret) {
+		pci_tsm_devsec_destructor(pdev);
 		return ERR_PTR(-EIO);
+	}
 
 	return &no_free_ptr(cca_dsc)->pci.base;
 }
@@ -245,6 +249,7 @@ static void cca_tsm_unlock(struct pci_dev *pdev)
 		return;
 	}
 
+	pci_tsm_devsec_destructor(pdev);
 	kfree(cca_dsc);
 }
 
modified   include/linux/pci-tsm.h
@@ -220,6 +220,7 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
 			    const struct pci_tsm_ops *ops);
 int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
 			       const struct pci_tsm_ops *ops);
+int pci_tsm_devsec_destructor(struct pci_dev *pdev);
 void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
 int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
 void pci_tsm_unbind(struct pci_dev *pdev);



-aneesh

