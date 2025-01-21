Return-Path: <linux-pci+bounces-20203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E771DA182CF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 18:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B06316B500
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59151F4E37;
	Tue, 21 Jan 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRavGUKD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4E1F4730;
	Tue, 21 Jan 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737480154; cv=none; b=lWIzvBYmW+HHK25sZockIM9AIf4N78B7Dzz5A7Ki4dpLJ9VyMnmCvOxz3e4qbhDrwjY1VreZgxJswStI8tCKPaXFYK+ewaX+dgwB8bgYsEDbmqnwhpDuvJTEaAez7dbbcHh6VyIvWxX3yMxCaonT6PoK7tJS8guBqFQsw2E6ROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737480154; c=relaxed/simple;
	bh=ARMl8+zMiK991I+vqt2RfTK5wgsO2Zui01IQ38sDJ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o35BbCGKVo1G426Lap7Nzisya4OsCvLY5Yr+pGgl/CNjcYLwftcGaskGN9iQAuyZqnJtZYOhPpbxFEEqqhFAIWdaiZiO21tAJwy7Y+oK5gvBZo9sbvhIXjACj5GQKBoHfQfZh80rub8oOs6cwGiC2bE0GZe+Dbx8vaG8ZZ5/M3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRavGUKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA798C4CEDF;
	Tue, 21 Jan 2025 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737480154;
	bh=ARMl8+zMiK991I+vqt2RfTK5wgsO2Zui01IQ38sDJ9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gRavGUKDIaJggaRLJFIucBl4IDARS5EMTevJrwgq2YsY27CFTkW8h3pS2vIJFjB6H
	 zVr6luHV//6A5/y8WMNlgMWeY4T5NiCvElMICjj/TbIVSb4mHPDNcc6TMd4V9knnF0
	 iJh/smc+70PcwfHyiWcHaqLj4koSpv3yb1wDDccTeDhRza01hqSLe0ZZqL3GAO7UZz
	 DL9WF7VTSh5A0dolSV/j93v71QV0UMCqDHY2elB+KctjAsWPDTcBHQgjjhyU6KyYDs
	 yWBf6q3SVzH0BcAH/WlVDFaQljCTdYtYP1e2zJGk+GNPyq4aRALpveMOIObOeHmOr7
	 4Gha4rLsfVrPw==
Date: Tue, 21 Jan 2025 11:22:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	logang@deltatee.com, bhelgaas@google.com,
	kurt.schwemmer@microsemi.com, unglinuxdriver@microchip.com
Subject: Re: [PATCH] PCI: switchtec: Include PCI100X devices support
Message-ID: <20250121172230.GA965969@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120095524.243103-1-Saladi.Rakeshbabu@microchip.com>

On Mon, Jan 20, 2025 at 03:25:24PM +0530, Rakesh Babu Saladi wrote:
> Add the Microchip Parts to the existing device ID
> table so that the driver supports PCI100x devices too.
> 
> Add a new macro to quirk the Microchip switchtec PCI100x parts
> to allow DMA access via NTB to work when the IOMMU is turned on.
> 
> PCI100x family has 6 variants, each variant is designed for different
> application usages, different port counts and lane counts.
> 
> PCI1001 has 1 x4 upstream port and 3 x4 downstream ports.
> PCI1002 has 1 x4 upstream port and 4 x2 downstream ports.
> PCI1003 has 2 x4 upstream ports, 2 x2 upstream ports and 2 x2
> downstream ports.
> PCI1004 has 4 x4 upstream ports.
> PCI1005 has 1 x4 upstream port and 6 x2 downstream ports.
> PCI1006 has 6 x2 upstream ports and 2 x2 downstream ports.
> 
> Signed-off-by: Rakesh Babu Saladi <Saladi.Rakeshbabu@microchip.com>

Applied to pci/switchec for v6.14, thanks!

> ---
>  drivers/pci/quirks.c           | 11 +++++++++++
>  drivers/pci/switch/switchtec.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index eeec1d6f9023..266ab5f8c6e1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5906,6 +5906,17 @@ SWITCHTEC_QUIRK(0x5552);  /* PAXA 52XG5 */
>  SWITCHTEC_QUIRK(0x5536);  /* PAXA 36XG5 */
>  SWITCHTEC_QUIRK(0x5528);  /* PAXA 28XG5 */
>  
> +#define SWITCHTEC_PCI100X_QUIRK(vid) \
> +	DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_EFAR, vid, \
> +		PCI_CLASS_BRIDGE_OTHER, 8, quirk_switchtec_ntb_dma_alias)
> +SWITCHTEC_PCI100X_QUIRK(0x1001);  /* PCI1001XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1002);  /* PCI1002XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1003);  /* PCI1003XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1004);  /* PCI1004XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1005);  /* PCI1005XG4 */
> +SWITCHTEC_PCI100X_QUIRK(0x1006);  /* PCI1006XG4 */
> +
> +
>  /*
>   * The PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints.
>   * These IDs are used to forward responses to the originator on the other
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 5b921387eca6..faaca76407c8 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1726,6 +1726,26 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
>  		.driver_data = gen, \
>  	}
>  
> +#define SWITCHTEC_PCI100X_DEVICE(device_id, gen) \
> +	{ \
> +		.vendor     = PCI_VENDOR_ID_EFAR, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = (PCI_CLASS_MEMORY_OTHER << 8), \
> +		.class_mask = 0xFFFFFFFF, \
> +		.driver_data = gen, \
> +	}, \
> +	{ \
> +		.vendor     = PCI_VENDOR_ID_EFAR, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = (PCI_CLASS_BRIDGE_OTHER << 8), \
> +		.class_mask = 0xFFFFFFFF, \
> +		.driver_data = gen, \
> +	}
> +
>  static const struct pci_device_id switchtec_pci_tbl[] = {
>  	SWITCHTEC_PCI_DEVICE(0x8531, SWITCHTEC_GEN3),  /* PFX 24xG3 */
>  	SWITCHTEC_PCI_DEVICE(0x8532, SWITCHTEC_GEN3),  /* PFX 32xG3 */
> @@ -1820,6 +1840,12 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
>  	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
>  	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
>  	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1001, SWITCHTEC_GEN4),  /* PCI1001 16XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1002, SWITCHTEC_GEN4),  /* PCI1002 12XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1003, SWITCHTEC_GEN4),  /* PCI1003 16XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1004, SWITCHTEC_GEN4),  /* PCI1004 16XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1005, SWITCHTEC_GEN4),  /* PCI1005 16XG4 */
> +	SWITCHTEC_PCI100X_DEVICE(0x1006, SWITCHTEC_GEN4),  /* PCI1006 16XG4 */
>  	{0}
>  };
>  MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
> -- 
> 2.34.1
> 

