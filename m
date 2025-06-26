Return-Path: <linux-pci+bounces-30829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82720AEA847
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A9F1773C0
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8462EF9BC;
	Thu, 26 Jun 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHgHBJIx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634AF2ECEB9;
	Thu, 26 Jun 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750970157; cv=none; b=FiTTV7AH833NoclyAe1VJF4Flc79mDtAlckwkylOa112ghl7x0lmsrwh5FsU7Hsp64fUscKhB4vBK0GcEo/Y17VkgstaUtl8wI1ooo8Odsm8xqo96rsFNBERhe13ZbzMWHaZ/xXi8vbRMVfnMc8aIRsSE45jTAt9qptYCGtwFQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750970157; c=relaxed/simple;
	bh=G27+9ny70XAvAWH0VdR/rLXNs/weTxodMw4X8b59d+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Kcu7L58yE0fob6OdUnQS9913hAx4W+5jaVFdaTp9JO92ReGGCByCVdHsUtiyEcRUsfBUmPLZbUkcGgGlEJwj8NvFhiUkqiwLrVoZfcYl6VEp1wn2rbIfk9oUwK4B98mUorOyTs9vPeHFHscu6nOOFvQf5+7eLhM4LDHapg4SmP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHgHBJIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DB2C4CEEB;
	Thu, 26 Jun 2025 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750970156;
	bh=G27+9ny70XAvAWH0VdR/rLXNs/weTxodMw4X8b59d+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cHgHBJIxJM9faOGginu5RI/CEezykKEhPS/GpXNku7uZs1JQ+4YE4fvtI2R6Qo7hU
	 WA9NI+T6TjtcENY6BTviJqok6KFSoRtRAOa1EA/w21xl+x1zGq2suEjcRSSS4DxsIi
	 iN6CN7VK/9SXvqGnSfV8jI7V4IGV3RRXy0fXpyymMbLcrRRWrpdGUz1k+HYvpsS5yK
	 kwNCC5q0dVoufA73GzJ/zNGQL9KhkJ7sr29mxB8tmWlNh/bEtEREuhhsZalQBNC/Tz
	 90X74swL9/GNfvo53rWyl33PN0ZOV+z7PHmoUb431VEzGjDvzjidiiC1mgzhtVR6i5
	 hjsQyT+k70OXw==
Date: Thu, 26 Jun 2025 15:35:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: bhelgaas@google.com, mani@kernel.org, manivannan.sadhasivam@linaro.org,
	kwilczynski@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	ilpo.jarvinen@linux.intel.com, Jonathan.Cameron@huawei.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, lukas@wunner.de,
	shuah@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Add error message when
 AER_MAX_MULTI_ERR_DEVICES limit is hit during AER handling
Message-ID: <20250626203555.GA1637877@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250619185041.73240-1-akshayaj.lkd@gmail.com>

On Fri, Jun 20, 2025 at 12:20:30AM +0530, Akshay Jindal wrote:
> When a PCIe error is detected, the root port receives the error message
> and the threaded IRQ handler, aer_isr, traverses the hierarchy downward
> from the root port. It populates the e_info->dev[] array with the PCIe
> devices that have recorded error status, so that appropriate error
> handling and recovery can be performed.
> 
> The e_info->dev[] array is limited in size by AER_MAX_MULTI_ERR_DEVICES,
> which is currently defined as 5. If more than five devices report errors
> in the same event, the array silently truncates the list, and those
> extra devices are not included in the recovery flow.
> 
> Emit an error message when this limit is reached, fulfilling a TODO
> comment in drivers/pci/pcie/aer.c.
> /* TODO: Should print error message here? */
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>

Applied to pci/aer for v6.17, thanks!

> ---
> 
> Changes since v1:
> - Reworded commit message in imperative mood (per Shuah’s feedback)
> - Mentioned and quoted related TODO in the message
> - Updated recipient list
> 
> Testing:
> ========
> Verified log in dmesg on QEMU.
> 
> 1. Following command created the required environment. As mentioned below a
> pcie-root-port and a virtio-net-pci device are used on a Q35 machine model.
> ./qemu-system-x86_64 \
> 	-M q35,accel=kvm \
> 	-m 2G -cpu host -nographic \
> 	-serial mon:stdio \
> 	-kernel /home/akshayaj/pci/arch/x86/boot/bzImage \
> 	-initrd /home/akshayaj/Embedded_System_Using_QEMU/rootfs/rootfs.cpio.gz \
> 	-append "console=ttyS0 root=/ pci=pcie_scan_all" \
> 	-device pcie-root-port,id=rp0,chassis=1,slot=1 \
> 	-device virtio-net-pci,bus=rp0
> 
> ~ # mylspci -t
> -[0000:00]-+-00.0
>            +-01.0
>            +-02.0
>            +-03.0-[01]----00.0
>            +-1f.0
>            +-1f.2
>            \-1f.3
> 00:03.0--> pcie-root-port
> 
> 2. Kernel bzImage compiled with following changes:
> 	2.1 CONFIG_PCIEAER=y in config
> 	2.2 AER_MAX_MULTI_ERR_DEVICES set to 0
> 	Since there is no pcie-testdev in QEMU, it is impossible to create
> 	a 5-level hierarchy of PCIe devices in QEMU. So we simulate the
> 	error scenario by changing the limit to 0.
> 	2.3 Log added at the required place in aer.c.
> 
> 3. Both correctable and uncorrectable errors were injected on
> pcie-root-port via HMP command (pcie_aer_inject_error) in QEMU.
> HMP Command used are as follows:
> 	3.1 pcie_aer_inject_error -c rp0 0x1
> 	3.2 pcie_aer_inject_error -c rp0 0x40
> 	3.3 pcie_aer_inject_error rp0 0x10
> 
> Resulting dmesg:
> ================
> [    0.380534] pcieport 0000:00:03.0: AER: enabled with IRQ 24
> [   55.729530] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addition of PCIe devices for AER handling
> [  225.484456] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addition of PCIe devices for AER handling
> [  356.976253] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addition of PCIe devices for AER handling
> 
>  drivers/pci/pcie/aer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac66188367..3995a1db5699 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1039,7 +1039,8 @@ static int find_device_iter(struct pci_dev *dev, void *data)
>  		/* List this device */
>  		if (add_error_device(e_info, dev)) {
>  			/* We cannot handle more... Stop iteration */
> -			/* TODO: Should print error message here? */
> +			pci_err(dev, "Exceeded max allowed (%d) addition of PCIe "
> +				"devices for AER handling\n", AER_MAX_MULTI_ERR_DEVICES);
>  			return 1;
>  		}
>  
> -- 
> 2.43.0
> 

