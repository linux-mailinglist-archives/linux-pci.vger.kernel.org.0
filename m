Return-Path: <linux-pci+bounces-38839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38CBF457E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 04:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F54718C5C7B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 02:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE621FF45;
	Tue, 21 Oct 2025 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKpNQpQv"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C91F91F6
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761012244; cv=none; b=WztEcAlToXlUzVqUsfKVSoegrqD4osF8QH5VdsobCXkM9q2r1c7hKq0hPVkjugmmofBZOR+0FsLoUMaJaNqtF9mHJitOpDlBul0Bq+mRc3wpVFg1C8gUYZ4dkMSOYFDxn+PmLwhm5VSgCXrboAh/y6G0QOwHju9538A3MOxAn/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761012244; c=relaxed/simple;
	bh=eNcccu+vEler5KVtBYch1RB+GYjLC2GuJ1NINrrxge4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfYwfqgM+NUSnnhbQpZABzcoBUz2c0HDx4soXeThmtI4/+jVY+YqySizcF0tswVncxpu/ACsufg4Z6SH6sv97ZMKQMG0EDQr+YxePBg0MBXXDGaPR+DJjarX8IwI9ikJtpygvSFB7h3TFlyUTwxU5xb+A4Yh30OiytVH+lIYdak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKpNQpQv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761012241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lRwLFO4AfNVfpht0Ivo8PlAeY+jBh+blR/+rewkE7wA=;
	b=OKpNQpQvk0rjT8uGBAFha+nep33ZFdaegBC/IdqGmgqygC++2tVsKeVnwFB27K511NvlLs
	/nYkI9jVi9e2Uc1sXZSWXql+7lZsh5tM/iFqCeEiSaPRZP4GTYOI4+KmHyKgqIEhTQWMj3
	SLGSJ6GlTaXWmNFOInpgNHGbNsnDZA8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-cG0oCSc0MDyQBP7OIrSSAQ-1; Mon,
 20 Oct 2025 22:03:56 -0400
X-MC-Unique: cG0oCSc0MDyQBP7OIrSSAQ-1
X-Mimecast-MFC-AGG-ID: cG0oCSc0MDyQBP7OIrSSAQ_1761012234
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5D01195608A;
	Tue, 21 Oct 2025 02:03:54 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.64.45])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA9E9180035A;
	Tue, 21 Oct 2025 02:03:52 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: samuel.holland@sifive.com
Cc: bhelgaas@google.com,
	jingoohan1@gmail.com,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: Re: [PATCH] PCI: dwc: Use multiple ATU regions for large bridge windows
Date: Mon, 20 Oct 2025 22:03:40 -0400
Message-ID: <20251021020345.151202-1-cmirabil@redhat.com>
In-Reply-To: <20251015231707.3862179-1-samuel.holland@sifive.com>
References: <20251015231707.3862179-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Samuel—

On Wed, Oct 15, 2025 at 04:15:01PM -0700, Samuel Holland wrote:
> Some SoCs may allocate more address space for a bridge window than can
> be covered by a single ATU region. Allow using a larger bridge window
> by allocating multiple adjacent ATU regions.

I had a similar patch floating around that I wanted to upstream, but I
figured I should take a look at lore before sending it in case someone
else had the same idea. Looks like great mind think alike :^). I have
attached my version the patch to this email and will leave some feedback
inline. If you want to incorporate some of my changes, feel free to add

Acked-by: Charles Mirabile <cmirabil@redhat.com>

or even a Co-developed-by and my DCO.

> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> An example of where this is needed is the ESWIN EIC7700 SoC[1]. The SoC
> decodes 128 GiB of address space to the PCIe controller. Without this
> change, only 8 GiB is usable; after this change 48 GiB (6 ATU regions)
> is usable, which allows using PCIe cards with >8 GiB BARs:
> 
> eic7700-pcie 54000000.pcie: host bridge /soc/pcie@54000000 ranges:
> eic7700-pcie 54000000.pcie:       IO 0x0040800000..0x0040ffffff -> 0x0040800000
> eic7700-pcie 54000000.pcie:      MEM 0x0041000000..0x004fffffff -> 0x0041000000
> eic7700-pcie 54000000.pcie:      MEM 0x8000000000..0x89ffffffff -> 0x8000000000
> eic7700-pcie 54000000.pcie: iATU: unroll T, 8 ob, 4 ib, align 4K, limit 8G
> eic7700-pcie 54000000.pcie: PCIe Gen.2 x1 link up
> eic7700-pcie 54000000.pcie: PCI host bridge to bus 0000:00
> 
> [1]: https://lore.kernel.org/linux-pci/20250923120946.1218-1-zhangsenchuan@eswincomputing.com/
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 34 ++++++++++++-------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..148076331d7b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -873,30 +873,40 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +		u64 total_size;

`resource_size_t` might be a better fit for this

> +
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>  
> -		if (pci->num_ob_windows <= ++i)
> -			break;
> -
> -		atu.index = i;
>  		atu.type = PCIE_ATU_TYPE_MEM;
>  		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr = entry->res->start - entry->offset;
>  
>  		/* Adjust iATU size if MSG TLP region was allocated before */
>  		if (pp->msg_res && pp->msg_res->parent == entry->res)
> -			atu.size = resource_size(entry->res) -
> +			total_size = resource_size(entry->res) -
>  					resource_size(pp->msg_res);
>  		else
> -			atu.size = resource_size(entry->res);
> +			total_size = resource_size(entry->res);
>  
> -		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> -		if (ret) {
> -			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> -				entry->res);
> -			return ret;
> -		}
> +		do {
> +			if (pci->num_ob_windows <= ++i)
> +				break;

I think it might be bad if you were to only able to partially map a given
resource. In my version, I keep the original check outside the loop with
merely `break`, but return an error from probe in this check.

> +
> +			atu.index = i;
> +			atu.size = min(total_size, pci->region_limit + 1);

I had to look up the difference because I couldn't remember—I used `MIN`
here instead of `min`. I think `MIN` is approriate, but I am not sure it
really matters so you could keep `min`. 

> +
> +			ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +			if (ret) {
> +				dev_err(pci->dev, "Failed to set MEM range %pr\n",
> +					entry->res);
> +				return ret;
> +			}
> +
> +			atu.parent_bus_addr += atu.size;
> +			atu.pci_addr += atu.size;
> +			total_size -= atu.size;
> +		} while (total_size);
>  	}
>  
>  	if (pp->io_size) {
> -- 
> 2.47.2
> 
> base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
> branch: up/pci-bridge-window

I also included an attempt at the inbound window version after seeing
Nilkas's feedback.

Best—Charlie

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..f30961482799 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -873,29 +873,49 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
+		resource_size_t res_size;
+
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
-		if (pci->num_ob_windows <= ++i)
+		if (pci->num_ob_windows <= i + 1)
 			break;
 
-		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
 		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
 		atu.pci_addr = entry->res->start - entry->offset;
 
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
-			atu.size = resource_size(entry->res) -
+			res_size = resource_size(entry->res) -
 					resource_size(pp->msg_res);
 		else
-			atu.size = resource_size(entry->res);
+			res_size = resource_size(entry->res);
+
+		while (res_size > 0) {
+			/*
+			 * Make sure to fail probe if we run out of windows
+			 * in the middle and we would end up only partially
+			 * mapping a single resource
+			 */
+			if (pci->num_ob_windows <= ++i) {
+				dev_err(pci->dev, "Exhausted outbound windows mapping %pr\n",
+					entry->res);
+				return -ENOMEM;
+			}
+			atu.index = i;
+			atu.size = MIN(pci->region_limit + 1, res_size);
 
-		ret = dw_pcie_prog_outbound_atu(pci, &atu);
-		if (ret) {
-			dev_err(pci->dev, "Failed to set MEM range %pr\n",
-				entry->res);
-			return ret;
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
+			if (ret) {
+				dev_err(pci->dev, "Failed to set MEM range %pr\n",
+					entry->res);
+				return ret;
+			}
+
+			atu.parent_bus_addr += atu.size;
+			atu.pci_addr += atu.size;
+			res_size -= atu.size;
 		}
 	}
 
@@ -926,20 +946,38 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
+		resource_size_t res_start, res_size, window_size;
+
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
 		if (pci->num_ib_windows <= i)
 			break;
 
-		ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
-					       entry->res->start,
-					       entry->res->start - entry->offset,
-					       resource_size(entry->res));
-		if (ret) {
-			dev_err(pci->dev, "Failed to set DMA range %pr\n",
-				entry->res);
-			return ret;
+		res_size = resource_size(entry->res);
+		res_start = entry->res->start;
+		while (res_size >= 0) {
+			/*
+			 * Make sure to fail probe if we run out of windows
+			 * in the middle and we would end up only partially
+			 * mapping a single resource
+			 */
+			if (pci->num_ib_windows <= i) {
+				dev_err(pci->dev, "Exhausted inbound windows mapping %pr\n",
+					entry->res);
+				return -ENOMEM;
+			}
+			window_size = MIN(pci->region_limit + 1, res_size);
+			ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM, res_start,
+						       res_start - entry->offset, window_size);
+			if (ret) {
+				dev_err(pci->dev, "Failed to set DMA range %pr\n",
+					entry->res);
+				return ret;
+			}
+
+			res_start += window_size;
+			res_size -= window_size;
 		}
 	}
 
-- 
2.43.0

base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada


