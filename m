Return-Path: <linux-pci+bounces-25058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA84A7786E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 12:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E79C3AA0FC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A841F09AE;
	Tue,  1 Apr 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMVBBK3G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4C1F09AA;
	Tue,  1 Apr 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501942; cv=none; b=OIoK/WyctHKLRFNeqYxQZBqRf8lfUCixAansixcyHK7RZaGPRYCbujBohXq/Xzq92RWGMXMYUYkhrxPqrS1IGGECzbV06PO03cNXeBKMXCjkYBwvjJveNiktc/cXtV9yr61PXgA22DhS53ZF6daB4ZyRb6jbFJuDYqXdUMO87uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501942; c=relaxed/simple;
	bh=Ji2lkGP1TL66HcrWlzJS1peLnaL9SmcZgErm3flM6Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4rF7Bij0NcfQ/TcctC5sDHEne4BV55mW82IjX+5SrSdvgL66pMkbAbBln4mmF8t5H8EOaxvMeSIYvfMGoPLvB7sTMffaAQYsc3YtgWYfZGmgoaupmJ+LioHfCX8HAUWJ1g/8akq9L27r61tQqnQBh7srRfHMocn73ur63DaE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMVBBK3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAC9C4CEE4;
	Tue,  1 Apr 2025 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501941;
	bh=Ji2lkGP1TL66HcrWlzJS1peLnaL9SmcZgErm3flM6Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMVBBK3Gsi3w+BSoNVNJbEEGqM5n7gouBqJlC3S0IJVGsewTCr3GrY8UXsZeRarSs
	 hPRee+83o398+JrceezEanxqvPQ6Q65N8klkWcydPv8LpEIAwpb7YHYCYMvfHprAsH
	 M6/JQWTCQ9j6Yy2J9bQdyECuydGrfZCcsXbcjdw9rO/PrnbJy/cEuw0FmvoSO7t1pl
	 1GB1FoSVSDnzZDpeJWqYLy/PEnEYQUAQiI4MLw+z9G8uvAYGMueH0eywvHZOwE0BU8
	 aWp0dduLIcgrHwhShLg/fLY2FAO09bI0SGiYYdvF8lT3p2wPe4YUvyZiioMoMBkdAv
	 ZIY+to7BmaTag==
Date: Tue, 1 Apr 2025 12:05:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] misc: pci_endpoint_test: Set .driver_data for
 PCI_DEVICE_ID_IMX8
Message-ID: <Z-u6cZs6qncIWF98@ryzen>
References: <20250331182910.2198877-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331182910.2198877-1-Frank.Li@nxp.com>

On Mon, Mar 31, 2025 at 02:29:10PM -0400, Frank Li wrote:
> Ensure driver_data is set for PCI_DEVICE_ID_IMX8 to specify the IRQ type,
> preventing probe failure.
> 
> Fixes the following error:
>   pci-endpoint-test 0001:01:00.0: Invalid IRQ type selected
>   pci-endpoint-test 0001:01:00.0: probe with driver pci-endpoint-test failed with error -22
> 
> Fixes: a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d294850a35a12..da96dba7357c6 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1125,7 +1125,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
> -	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_IMX8),
> +	 .driver_data = (kernel_ulong_t)&default_data,
> +	},
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
> -- 
> 2.34.1
> 

So the problem appears to be that:
a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'")

did:

@@ -939,15 +930,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
        test->pdev = pdev;
        test->irq_type = IRQ_TYPE_UNDEFINED;
 
-       if (no_msi)
-               irq_type = IRQ_TYPE_INTX;
-
        data = (struct pci_endpoint_test_data *)ent->driver_data;
        if (data) {
                test_reg_bar = data->test_reg_bar;
                test->test_reg_bar = test_reg_bar;
                test->alignment = data->alignment;
-               irq_type = data->irq_type;
+               test->irq_type = data->irq_type;
        }
 
        init_completion(&test->irq_raised);
@@ -969,7 +957,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
        pci_set_master(pdev);
 
-       ret = pci_endpoint_test_alloc_irq_vectors(test, irq_type);
+       ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);


So pci_endpoint_test_probe() calls pci_endpoint_test_alloc_irq_vectors(),
but test->irq_type is only set if driver_data is defined.

You seem to only fix IMX8, but if we go with your solution, I think that
you should also update the other entries that do not specify driver_data:
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774A1),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774B1),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774C0),},
        { PCI_DEVICE(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_R8A774E1),},


But... I suggest that we just remove the pci_endpoint_test_alloc_irq_vectors()
call from pci_endpoint_test_probe().

We know that all tests that requires IRQs will call ioctl(PCITEST_SET_IRQTYPE)
(which will call pci_endpoint_test_set_irq()), before doing the actual ioctl(),
and test->irq_type is by default set to PCITEST_IRQ_TYPE_UNDEFINED
(even if it is overriden with driver_data if it exists), so performing any irq
allocation in probe seems wrong to me.

Thus, I think we should just do:


diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d294850a35a12..c4e5e2c977be2 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -122,7 +122,6 @@ struct pci_endpoint_test {
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
-	int irq_type;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -948,7 +947,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		test_reg_bar = data->test_reg_bar;
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
-		test->irq_type = data->irq_type;
 	}
 
 	init_completion(&test->irq_raised);
@@ -970,10 +968,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);
-	if (ret)
-		goto err_disable_irq;
-
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 			base = pci_ioremap_bar(pdev, bar);
@@ -1009,10 +1003,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		goto err_ida_remove;
 	}
 
-	ret = pci_endpoint_test_request_irq(test);
-	if (ret)
-		goto err_kfree_test_name;
-
 	pci_endpoint_test_get_capabilities(test);
 
 	misc_device = &test->miscdev;
@@ -1020,7 +1010,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	misc_device->name = kstrdup(name, GFP_KERNEL);
 	if (!misc_device->name) {
 		ret = -ENOMEM;
-		goto err_release_irq;
+		goto err_kfree_test_name;
 	}
 	misc_device->parent = &pdev->dev;
 	misc_device->fops = &pci_endpoint_test_fops;
@@ -1036,9 +1026,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 err_kfree_name:
 	kfree(misc_device->name);
 
-err_release_irq:
-	pci_endpoint_test_release_irq(test);
-
 err_kfree_test_name:
 	kfree(test->name);
 
@@ -1051,8 +1038,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-err_disable_irq:
-	pci_endpoint_test_free_irq_vectors(test);
 	pci_release_regions(pdev);
 
 err_disable_pdev:
@@ -1092,23 +1077,19 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_endpoint_test_data default_data = {
 	.test_reg_bar = BAR_0,
 	.alignment = SZ_4K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data am654_data = {
 	.test_reg_bar = BAR_2,
 	.alignment = SZ_64K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data j721e_data = {
 	.alignment = 256,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data rk3588_data = {
 	.alignment = SZ_64K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 /*




Or, if we want to keep allocating some kind of IRQ vector in probe(),
just to rule out totally broken platforms, I guess we could also do:

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d294850a35a12..ab2088c7937a7 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -122,7 +122,6 @@ struct pci_endpoint_test {
 struct pci_endpoint_test_data {
 	enum pci_barno test_reg_bar;
 	size_t alignment;
-	int irq_type;
 };
 
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
@@ -948,7 +947,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 		test_reg_bar = data->test_reg_bar;
 		test->test_reg_bar = test_reg_bar;
 		test->alignment = data->alignment;
-		test->irq_type = data->irq_type;
 	}
 
 	init_completion(&test->irq_raised);
@@ -970,7 +968,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 
 	pci_set_master(pdev);
 
-	ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);
+	ret = pci_endpoint_test_alloc_irq_vectors(test, PCITEST_IRQ_TYPE_AUTO);
 	if (ret)
 		goto err_disable_irq;
 
@@ -1092,23 +1090,19 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_endpoint_test_data default_data = {
 	.test_reg_bar = BAR_0,
 	.alignment = SZ_4K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data am654_data = {
 	.test_reg_bar = BAR_2,
 	.alignment = SZ_64K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data j721e_data = {
 	.alignment = 256,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 static const struct pci_endpoint_test_data rk3588_data = {
 	.alignment = SZ_64K,
-	.irq_type = PCITEST_IRQ_TYPE_MSI,
 };
 
 /*

