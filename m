Return-Path: <linux-pci+bounces-42004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E61C8361B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB4224E12A2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 05:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1654B2853E9;
	Tue, 25 Nov 2025 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXrYd7oJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C8283FDD;
	Tue, 25 Nov 2025 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764048105; cv=none; b=dG24Xu6TQkxSlr3BVXuC6VCXgyOF2cufbBdBnv+rrnujHOhOExGNLTmHUJqaj/e4yS/qR3YwwIu1i0ePVYO7lMHMFtgMDwPbrUpnzOcMO2ht+gCOHQ1bcbg32UgWK7JjpnqnLZ5S+0RD9Ae5d4Wp3IJdKGPDrTQ56tLlJYdf5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764048105; c=relaxed/simple;
	bh=qed1tIlgYImH+5jgHrPf6vSo6U9oFRv/oP55UdFhWMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnzU/E79DF1YDu+kB2OQQzv2fJ9MIilrHMQkJ10lMrr4yvedvyTvYmWa0RWM6IxxPzrOQsf3Ox1rpSV9C0n3MnsT8eqwpxDP8d+++xbhwfHt4StRUhEMY6LiTBLGpnA136DmzRbxUYTVsO71S6csx/rbOGjjfp3UYxrzL6TGubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXrYd7oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09132C4CEF1;
	Tue, 25 Nov 2025 05:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764048104;
	bh=qed1tIlgYImH+5jgHrPf6vSo6U9oFRv/oP55UdFhWMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXrYd7oJTu2M2fgDwzIjyrsaKTIIUE3Vbbqiiom3OYz4r70MZ48cdh33Dwi9WHsrz
	 W5MOhQmsutGsFP5gcQ1Q6MnjpnCk6t0FhVCMaqmnSakKaNYglhekorZCQhc2lLwuJs
	 PuLnODdoWwbBQKvGEMcCJqCisSn93G4uOoWjt4lnolGCoQJOMxjlH5E4QVfIH31fWZ
	 0NiZTum8t32AHI8qAoP5+qoCJXWRlAjly8azuY/I3Dd6hV9VXZiGFthSaqG09uth6E
	 8a8P8WJHrGcQsiGVg/fw1TmuG8CtMuFrtKghTUsDM7fz+NvEpRDVRwseFoN3yj8rvf
	 yGQFedtEIzLMA==
Date: Tue, 25 Nov 2025 10:51:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>, 
	Jeffrey Lien <Jeff.Lien@sandisk.com>, Avinash M N <Avinash.M.N@sandisk.com>
Subject: Re: [PATCH v2] PCI: Add quirk to disable ASPM L1 for Sandisk SN740
 NVMe SSDs
Message-ID: <tiadpmogdxom5h2bquct2ch6hoc6ozh6bgnzdmnj3mia22vtue@c5yjxbx65lsm>
References: <20251120161253.189580-1-mani@kernel.org>
 <20251124235307.GA2725632@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124235307.GA2725632@bhelgaas>

On Mon, Nov 24, 2025 at 05:53:07PM -0600, Bjorn Helgaas wrote:
> [+cc Alexey, Jeffrey, Avinash]
> 
> On Thu, Nov 20, 2025 at 09:42:53PM +0530, Manivannan Sadhasivam wrote:
> > The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream Root
> > Port of PCIe controller in Microsoft Surface Laptop 7, when ASPM L1 is
> > enabled:
> > 
> >   pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
> >   nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> >   nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
> >   nvme 0006:01:00.0:    [ 0] RxErr
> 
> Do we have any information about whether this error happens with the
> SN740 on platforms other than the Surface Laptop 7?  Or whether it
> happens on the Surface with other endpoints?
> 

This device comes pre installed with the Surface Laptop 7 I believe. It is not
very convenient to replace the NVMe in a laptop for testing.

> I'm a little hesitant about quirking devices and claiming they are
> defective without a solid root cause.
> 

There are a couple of points that made me convince myself:

* Other X1E laptops are working fine with ASPM L1.
* This laptop has WCN785x WiFi/BT combo card connected to the other controller
instance and L1 is working fine for it.
* There is no known issue with ASPM L1 in X1E chipsets.

Because of these, I was so certain that the NVMe is the fault here.

> Sandisk folks, do you have any insight into this?  Any known errata or
> possibility of looking into this with an analyzer?
> 

I don't think Konrad has access to the analyzer, neither any of us.

If you are still hesitant, I'd suggest adding the platform check so that this
quirk is only limited to the Surface Laptop 7:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index adc54533df7f..1655757ba66a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -29,6 +29,7 @@
 #include <linux/ktime.h>
 #include <linux/mm.h>
 #include <linux/nvme.h>
+#include <linux/of.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
@@ -2527,15 +2528,19 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PASEMI, 0xa002, quirk_disable_aspm_l0s_l1);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, quirk_disable_aspm_l0s_l1);
 
+/*
+ * Sandisk SN740 NVMe SSDs in Microsoft Surface Laptop 7 cause AER timeout
+ * errors on the upstream PCIe Root Port when ASPM L1 is enabled.
+ */
 static void quirk_disable_aspm_l1(struct pci_dev *dev)
 {
-       pcie_aspm_remove_cap(dev, PCI_EXP_LNKCAP_ASPM_L1);
+       struct device_node *root __free(device_node) = of_find_node_by_path("/");
+       const char *model = of_get_property(root, "compatible", NULL);
+
+       if (!strcmp(model, "microsoft,romulus13"))
+               pcie_aspm_remove_cap(dev, PCI_EXP_LNKCAP_ASPM_L1);
 }
 
-/*
- * Sandisk SN740 NVMe SSDs cause AER timeout errors on the upstream PCIe Root
- * Port when ASPM L1 is enabled.
- */
 DECLARE_PCI_FIXUP_HEADER(0x15b7, 0x5015, quirk_disable_aspm_l1);
 
 /*

This check is similar to the DMI checks we have currently non-DT platforms.
Infact, we have also use the DMI checks on this laptop as it comes with SMBIOS.

Note: I'm not sure if Konrad's lapto is based on "microsoft,romulus13" or
"microsoft,romulus15".

- Mani

-- 
மணிவண்ணன் சதாசிவம்

