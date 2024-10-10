Return-Path: <linux-pci+bounces-14223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FE0999250
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEED8B2FFC4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0E61E5726;
	Thu, 10 Oct 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTRD7SRr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9319CD17;
	Thu, 10 Oct 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587249; cv=none; b=rCsGbu5Yo/QyPbzkJ718qL5Ji4Nz31WJ/n2Xz8GxhyTypjVLGhmqv/KJtxWQVgy9ft3fZm9gy6kMpwlKf91KlTgjl168+T2OFpjWg6ocTV2rnINvMhkgQz/KaOdv3oxNfIzqKfKrYYtiQJ001l5Qkty8dS/EZht9b+jQC17cBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587249; c=relaxed/simple;
	bh=4FyLCZ7OLTy+fgNteG8kX8j3xWeYO0/AKTh/Grmb0oY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XnY5oz45w2xtXK/1GqgNkWMybG/QlujwdYJxYTEpSLtOSiircVDGS6uaVWdG0AGVEljxe8HOiI5Iy5hwHeu9zqi91+fHtr/jQor3Y3VlflXzU1FaLfgvhcw9OqvnMl4oCzg4oOKgoSC2q6XDQwG2xjEsrsBh/8Fitv6ZosgI0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTRD7SRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD778C4CEC5;
	Thu, 10 Oct 2024 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728587249;
	bh=4FyLCZ7OLTy+fgNteG8kX8j3xWeYO0/AKTh/Grmb0oY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iTRD7SRrCnIRO/krFncVj3Ov/hK7kc/9xuHLBZDjWzil9InHhPACGxsseTRIm+QUN
	 vPcwiXqEjGVYB3zhun0ggw34PIh4CM2B0HNtaAzEiWcBDtKq2+dn51sJP58xWyNU01
	 XGsOl1R6XU38MZmrg1c+jg0YQKWI55/FfAOOlrxk4sD2rct4S7CZ7h10FAtgomQ7nY
	 c3X6TXadh5eqIQz2acEIzORqiv8+RcZT6o8/pQtWfQWMOM+LqND72j4KsTdf2i72Tx
	 jNQmCsGgehtMJyIgtmFB/qa7kTQ15E1bmlBd7xMpLNbJNNSbPOYoNz8ZdKBMi+LOAe
	 X9eyOHPkT2BtA==
Date: Thu, 10 Oct 2024 14:07:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Message-ID: <20241010190726.GA570880@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>

On Tue, Oct 08, 2024 at 05:16:42PM -0500, Terry Bowman wrote:
> This is a continuation of the CXL port error handling RFC from earlier.[1]
> The RFC resulted in the decision to add CXL PCIe port error handling to
> the existing RCH downstream port handling. This patchset adds the CXL PCIe
> port handling and logging.
> 
> The first 7 patches update the existing AER service driver to support CXL
> PCIe port protocol error handling and reporting. This includes AER service
> driver changes for adding correctable and uncorrectable error support, CXL
> specific recovery handling, and addition of CXL driver callback handlers.
> 
> The following 8 patches address CXL driver support for CXL PCIe port
> protocol errors. This includes the following changes to the CXL drivers:
> mapping CXL port and downstream port RAS registers, interface updates for
> common RCH and VH, adding port specific error handlers, and protocol error
> logging.
> 
> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554
> -1-terry.bowman@amd.com/

Makes life easier if URLs are all on one line so they still work.

> Testing:
> 
> Below are test results for this patchset. This is using Qemu with a root
> port (0c:00.0), upstream switch port (0d:00.0),and downstream switch port
> (0e:00.0).
> 
> This was tested using aer-inject updated to support CE and UCE internal
> error injection. CXL RAS was set using a test patch (not upstreamed).
> 
>     Root port UCE:
>     root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>     [   27.318920] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>     [   27.320164] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>     [   27.321518] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     [   27.322483] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>     [   27.323243] pcieport 0000:0c:00.0:    [22] UncorrIntErr
>     [   27.325584] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>     [   27.325584]
>     [   27.327171] cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error'
>     first_error: 'Memory Address Parity Error'
>     [   27.333277] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>     [   27.333872] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g1fb9097c3728 #3857
>     [   27.334761] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>     [   27.335716] Call Trace:
>     [   27.335985]  <TASK>
>     [   27.336226]  panic+0x2ed/0x320
>     [   27.336547]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>     [   27.337037]  ? __pfx_aer_root_reset+0x10/0x10
>     [   27.337453]  cxl_do_recovery+0x304/0x310
>     [   27.337833]  aer_isr+0x3fd/0x700
>     [   27.338154]  ? __pfx_irq_thread_fn+0x10/0x10
>     [   27.338572]  irq_thread_fn+0x1f/0x60
>     [   27.338923]  irq_thread+0x102/0x1b0
>     [   27.339267]  ? __pfx_irq_thread_dtor+0x10/0x10
>     [   27.339683]  ? __pfx_irq_thread+0x10/0x10
>     [   27.340059]  kthread+0xcd/0x100
>     [   27.340387]  ? __pfx_kthread+0x10/0x10
>     [   27.340748]  ret_from_fork+0x2f/0x50
>     [   27.341100]  ? __pfx_kthread+0x10/0x10
>     [   27.341466]  ret_from_fork_asm+0x1a/0x30
>     [   27.341842]  </TASK>
>     [   27.342281] Kernel Offset: 0x1ba00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>     [   27.343221] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
> 
>     Root port CE:
>     root@tbowman-cxl:~/aer-inject# ./root-ce-inject.sh
>     [   19.444339] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
>     [   19.445530] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
>     [   19.446750] pcieport 0000:0c:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     [   19.447742] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
>     [   19.448549] pcieport 0000:0c:00.0:    [14] CorrIntErr
>     [   19.449223] aer_event: 0000:0c:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>     [   19.449223]
>     [   19.451415] cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'
> 
>     Upstream switch port UCE:
>     root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
>     [   45.236853] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
>     [   45.238101] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
>     [   45.239416] pcieport 0000:0d:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     [   45.240412] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
>     [   45.241159] pcieport 0000:0d:00.0:    [22] UncorrIntErr
>     [   45.242448] aer_event: 0000:0d:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>     [   45.242448]
>     [   45.244008] cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error'
>     first_error: 'Memory Address Parity Error'
>     [   45.249129] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>     [   45.249800] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g1fb9097c3728 #3855
>     [   45.250795] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>     [   45.251907] Call Trace:
>     [   45.253284]  <TASK>
>     [   45.253564]  panic+0x2ed/0x320
>     [   45.253909]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>     [   45.255455]  ? __pfx_aer_root_reset+0x10/0x10
>     [   45.255915]  cxl_do_recovery+0x304/0x310
>     [   45.257219]  aer_isr+0x3fd/0x700
>     [   45.257572]  ? __pfx_irq_thread_fn+0x10/0x10
>     [   45.258006]  irq_thread_fn+0x1f/0x60
>     [   45.258383]  irq_thread+0x102/0x1b0
>     [   45.258748]  ? __pfx_irq_thread_dtor+0x10/0x10
>     [   45.259196]  ? __pfx_irq_thread+0x10/0x10
>     [   45.259605]  kthread+0xcd/0x100
>     [   45.259956]  ? __pfx_kthread+0x10/0x10
>     [   45.260386]  ret_from_fork+0x2f/0x50
>     [   45.260879]  ? __pfx_kthread+0x10/0x10
>     [   45.261418]  ret_from_fork_asm+0x1a/0x30
>     [   45.261936]  </TASK>
>     [   45.262451] Kernel Offset: 0xc600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>     [   45.263467] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
> 
>     Upstream switch port CE:
>     root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh 
>     [   37.504029] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
>     [   37.506076] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
>     [   37.507599] pcieport 0000:0d:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     [   37.508759] pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
>     [   37.509574] pcieport 0000:0d:00.0:    [14] CorrIntErr            
>     [   37.510180] aer_event: 0000:0d:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>     [   37.510180] 
>     [   37.512057] cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'
> 
>     Downstream switch port UCE:
>     root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
>     [   29.421532] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
>     [   29.422812] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
>     [   29.424551] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>     [   29.425670] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
>     [   29.426487] pcieport 0000:0e:00.0:    [22] UncorrIntErr
>     [   29.427111] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>     [   29.427111]
>     [   29.428688] cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error'
>     first_error: 'Memory Address Parity Error'
>     [   29.430173] Kernel panic - not syncing: CXL cachemem error. Invoking panic
>     [   29.430862] CPU: 12 UID: 0 PID: 122 Comm: irq/24-aerdrv Not tainted 6.11.0-rc1-port-error-g844fd2319372 #3851
>     [   29.431874] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>     [   29.433031] Call Trace:
>     [   29.433354]  <TASK>
>     [   29.433631]  panic+0x2ed/0x320
>     [   29.434010]  ? __pfx_cxl_report_normal_detected+0x10/0x10
>     [   29.434653]  ? __pfx_aer_root_reset+0x10/0x10
>     [   29.435179]  cxl_do_recovery+0x304/0x310
>     [   29.435626]  aer_isr+0x3fd/0x700
>     [   29.436027]  ? __pfx_irq_thread_fn+0x10/0x10
>     [   29.436507]  irq_thread_fn+0x1f/0x60
>     [   29.436898]  irq_thread+0x102/0x1b0
>     [   29.437293]  ? __pfx_irq_thread_dtor+0x10/0x10
>     [   29.437758]  ? __pfx_irq_thread+0x10/0x10
>     [   29.438189]  kthread+0xcd/0x100
>     [   29.438551]  ? __pfx_kthread+0x10/0x10
>     [   29.438959]  ret_from_fork+0x2f/0x50
>     [   29.439362]  ? __pfx_kthread+0x10/0x10
>     [   29.439771]  ret_from_fork_asm+0x1a/0x30
>     [   29.440221]  </TASK>
>     [   29.440738] Kernel Offset: 0x10a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>     [   29.441812] ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
> 
>     Downstream switch port CE:
>     root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
>     [  177.114442] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
>     [  177.115602] pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
>     [  177.116973] pcieport 0000:0e:00.0: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     [  177.117985] pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
>     [  177.118809] pcieport 0000:0e:00.0:    [14] CorrIntErr
>     [  177.119521] aer_event: 0000:0e:00.0 PCIe Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>     [  177.119521]
>     [  177.122037] cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'

Thanks for the hints about how to test this; it's helpful to have
those in the email archives.  Remove the timestamps and non-relevant
call trace entries unless they add useful information.  AFAICT they're
just distractions in this case.

> Changes RFC->v1:
>  [Dan] Rename cxl_rch_handle_error() becomes cxl_handle_error()
>  [Dan] Add cxl_do_recovery()
>  [Jonathan] Flatten cxl_setup_parent_uport()
>  [Jonathan] Use cxl_component_regs instead of struct cxl_regs regs
>  [Jonathan] Rename cxl_dev_is_pci_type()
>  [Ming] bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can
>  replace these find_cxl_port() and device_find_child().
>  [Jonathan] Compact call to cxl_port_map_regs() in cxl_setup_parent_uport()
>  [Ming] Dont use endpoint as host to cxl_map_component_regs()
>  [Bjorn] Use "PCIe UIR/CIE" instesad of "AER UI/CIE"
>  [TODO][Bjorn] Dont use Kconfig to enable/disable a CXL external interface
> 
> Terry Bowman (15):
>   cxl/aer/pci: Add CXL PCIe port error handler callbacks in AER service
>     driver
>   cxl/aer/pci: Update is_internal_error() to be callable w/o
>     CONFIG_PCIEAER_CXL
>   cxl/aer/pci: Refactor AER driver's existing interfaces to support CXL
>     PCIe ports
>   cxl/aer/pci: Add CXL PCIe port correctable error support in AER
>     service driver
>   cxl/aer/pci: Update AER driver to read UCE fatal status for all CXL
>     PCIe port devices
>   cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to pci_ers_result type
>   cxl/aer/pci: Add CXL PCIe port uncorrectable error recovery in AER
>     service driver

I had to look at the patches to learn that all the above only touch
drivers/pci, aer.h, and pci.h.  Can you use the PCI subject line
conventions (e.g., "PCI/AER: ...") to make this more obvious?  Almost
all already include "CXL", so I don't think we'd really lose any
information.

>   cxl/pci: Change find_cxl_ports() to be non-static
>   cxl/pci: Map CXL PCIe downstream port RAS registers
>   cxl/pci: Map CXL PCIe upstream port RAS registers
>   cxl/pci: Update RAS handler interfaces to support CXL PCIe ports
>   cxl/pci: Add error handler for CXL PCIe port RAS errors
>   cxl/pci: Add trace logging for CXL PCIe port RAS errors
>   cxl/aer/pci: Export pci_aer_unmask_internal_errors()

Ditto here, and add something about CXL in the subject since this
doesn't export universally.

>   cxl/pci: Enable internal CE/UCE interrupts for CXL PCIe port devices
> 
>  drivers/cxl/core/core.h  |   3 +
>  drivers/cxl/core/pci.c   | 172 +++++++++++++++++++++++++++++++--------
>  drivers/cxl/core/port.c  |   4 +-
>  drivers/cxl/core/trace.h |  47 +++++++++++
>  drivers/cxl/cxl.h        |  14 +++-
>  drivers/cxl/mem.c        |  30 ++++++-
>  drivers/cxl/pci.c        |   8 ++
>  drivers/pci/pci.h        |   5 ++
>  drivers/pci/pcie/aer.c   | 123 ++++++++++++++++++++--------
>  drivers/pci/pcie/err.c   | 150 ++++++++++++++++++++++++++++++++++
>  include/linux/aer.h      |  16 ++++
>  include/linux/pci.h      |   3 +
>  12 files changed, 503 insertions(+), 72 deletions(-)
> 
> 
> base-commit: f7982d85e136ba7e26b31a725c1841373f81f84a

This doesn't apply cleanly on v6.12-rc1, and
f7982d85e136ba7e26b31a725c1841373f81f84a isn't upstream yet.  Where
is it?  I guess it relies on some other series that hasn't been merged
yet?

Bjorn

