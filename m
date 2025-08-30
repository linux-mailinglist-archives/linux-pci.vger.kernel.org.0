Return-Path: <linux-pci+bounces-35185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FF3B3CB51
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B5B5659D4
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA95220F35;
	Sat, 30 Aug 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMFz3lHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F61A9FBC;
	Sat, 30 Aug 2025 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756561116; cv=none; b=F42zsBzmAs3ftnR0/XjR55Qpop5h41UKbYgOlUs03laUY5NZM93gHrUdchWusNeaEI/pptONMcnZFnfYlOSTclQvx93luP2drHEXeplCHeJJIZtWOufHAlFBr3i76bbyhsBpC4YxTEeuAkeqz6talHOkbdSChHyNvMSvYtJYFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756561116; c=relaxed/simple;
	bh=e6huc+3grspR/uOx+2CxjoiJbJxmK3UfucZQBCt/WSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMtlptYcwNvKn5IWouFoLyO7IpbVJPfWinsRScggVssUQeKQrzmoK/tUbLBdIf8lWE567BVb0RweWqm4CruxBHU5TnLZWv04o8NfKfJPEwPMlOhBs2FZLzhuMD77bDNyGKM+Z4uF4kcnsG0cIdvNi6Ycp8qnARDx2OQwDHSjJOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMFz3lHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0036C4CEEB;
	Sat, 30 Aug 2025 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756561116;
	bh=e6huc+3grspR/uOx+2CxjoiJbJxmK3UfucZQBCt/WSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMFz3lHZgfC8OCrPzZ+KJ9CvPN7+Bot7NWie7S9GFzwfdYcM+HCnwt7lD3l2RQouP
	 89eMgUkFBP0VPdIPBTuZzs67KFNFEBPYnPx6RbkPfG98Lebz1bT7EhCJIs5+dnNblx
	 ZwY9d73Lnc9kpm32ycAkYfOMbzHgro0Okn0JMtflD1h3+ia+Vc5k4hucmHX1YuCfV/
	 +rOM0XUIxhHDOJLaKlEWvVYXoqU/NRQsz38ZOxOtihzjyBICe/FurFbKjMPxD4r3rq
	 EIjhBsIMeOqX+wjUJVRlopG9IFTamUxXcivXo5AtrBdOdW67ANJU5zysKFMZYVDiz+
	 xRKg3UKdTZIxw==
Date: Sat, 30 Aug 2025 19:08:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/15] Enhance the PCIe controller driver for next
 generation controllers
Message-ID: <epz5rpofsw7yxxz6pga2ja37zl2xwauqxk2j45q4slj35ja27x@nmbaeo2jbdrb>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>

On Tue, Aug 19, 2025 at 07:52:24PM GMT, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> ---
> Dear Maintainers,
> 
> This series is Cadence's HPA PCIe IP and the Root Port driver of our
> CIX sky1. Please help review. Thank you very much.

IIUC, sky1 only supports RC mode of the Cadence HPA architecture and not EP. But
you have added the library functions for EP mode also and it is currently
unused. So you should drop those EP related code from this series and add
whenever the corresponding platform driver is added. It also makes patch 8
smaller.

- Mani

> ---
> 
> Enhances the exiting Cadence PCIe controller drivers to support
> HPA (High Performance Architecture) Cadence PCIe controllers.
> 
> The patch set enhances the Cadence PCIe driver for HPA support.
> The header files are separated out for legacy and high performance
> register maps, register address and bit definitions. The driver
> read register and write register functions for HPA take the
> updated offset stored from the platform driver to access the registers.
> As part of refactoring of the code, few new files are added to the
> driver by splitting the existing files.
> This helps SoC vendor who change the address map within PCIe controller
> in their designs. Setting the menuconfig appropriately will allow
> selection between RP and/or EP PCIe controller support. The support
> will include Legacy and HPA for the selected configuration.
> 
> The TI SoC continues to be supported with the changes incorporated.
> 
> The changes address the review comments in the previous patches where
> the need to move away from "ops" pointers used in current implementation
> and separate out the Legacy and HPA driver implementation was stressed.
> 
> The scripts/checkpatch.pl has been run on the patches with and without
> --strict. With the --strict option, 4 checks are generated on 3 patch,
> which can be ignored. There are no code fixes required for these checks.
> All other checks generated by ./scripts/checkpatch.pl --strict can be 
> ignored.
> 
> ---
> Changes for v8
>         - Fixed the error issue of DT binding. (Rob and Krzysztof)
>         - Optimization of CIX SKY1 Root Port driver. (Bjorn and Krzysztof)
>         - Review comments fixed. (Bjorn and Krzysztof)
> 	      - All comments related fixes like single line comments, spaces
>               between HPA or LGA, periods in single line, changes proposed
>               in the description, etc are fixed. (Bjorn and Krzysztof)
>         - Patches have been split to separate out code moves from
>           update and fixes.
>         - "cdns_...send_irq.." renamed to "cdns_..raise_irq.."
> 
>         The test log on the Orion O6 board is as follows:
>         root@cix-localhost:~# lspci
>         0000:c0:00.0 PCI bridge: Device 1f6c:0001
>         0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>         0001:90:00.0 PCI bridge: Device 1f6c:0001
>         0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
>         0002:60:00.0 PCI bridge: Device 1f6c:0001
>         0002:61:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>         0003:00:00.0 PCI bridge: Device 1f6c:0001
>         0003:01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
>         0004:30:00.0 PCI bridge: Device 1f6c:0001
>         0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller (rev 05)
>         root@cix-localhost:~#
>         root@cix-localhost:~# uname -a
>         Linux cix-localhost 6.17.0-rc2-00043-gb2782ead460c #185 SMP PREEMPT Tue Aug 19 19:35:34 CST 2025 aarch64 GNU/Linux
>         root@cix-localhost:~# cat /etc/issue
>         Debian GNU/Linux 12 \n \l
> 
> Changes for v7
> https://patchwork.kernel.org/project/linux-pci/cover/20250813042331.1258272-1-hans.zhang@cixtech.com/
> 
>         - Rebase to v6.17-rc1.
>         - Fixed the error issue of cix,sky1-pcie-host.yaml make dt_binding_check.
>         - CIX SKY1 Root Port driver compilation error issue: Add header
>           file, Kconfig select PCI_ECAM.
> 
> Changes for v6
> https://patchwork.kernel.org/project/linux-pci/cover/20250808072929.4090694-1-hans.zhang@cixtech.com/
> 
>         - The IP level DTS changes for HPA have been removed as the SoC
>           level DTS is added
>         - Virtual FPGA platform is also removed as the CiX SoC support is
>           added
>         - Fix the issue of dt bindings
>         - Modify the order of PCIe node attributes in sky1-orion-o6.dts
>           and delete unnecessary attributes.
>         - Continue to simplify the RC driver.
>         - The patch of the Cix Sky1 platform has been accepted and merged into the linux master branch.
>         https://patchwork.kernel.org/project/linux-arm-kernel/cover/20250721144500.302202-1-peter.chen@cixtech.com/
> 
> Changes for v5
> https://patchwork.kernel.org/project/linux-pci/cover/20250630041601.399921-1-hans.zhang@cixtech.com/
> 
>         - Header and code files separated for library functions(common
>           functions used by both architectures) and Legacy and HPA.
>         - Few new files added as part of refactoring
>         - No checks for "is_hpa" as the functions have been separated
>           out
>         - Review comments from previous patches have been addressed
>         - Add region 0 for ECAM and region 1 for message.
>         - Add CIX sky1 PCIe drivers. Submissions based on the following v9 patches:
>         https://patchwork.kernel.org/project/linux-arm-kernel/cover/20250609031627.1605851-1-peter.chen@cixtech.com/
> 
>         Cix Sky1 base dts review link to show its review status:
>         https://lore.kernel.org/all/20250609031627.1605851-9-peter.chen@cixtech.com/
> 
>         The test log on the Orion O6 board is as follows:
>         root@cix-localhost:~# lspci
>         0000:c0:00.0 PCI bridge: Device 1f6c:0001
>         0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>         0001:90:00.0 PCI bridge: Device 1f6c:0001
>         0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
>         0002:60:00.0 PCI bridge: Device 1f6c:0001
>         0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
>         0003:00:00.0 PCI bridge: Device 1f6c:0001
>         0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>         0004:30:00.0 PCI bridge: Device 1f6c:0001
>         0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>         root@cix-localhost:~# uname -a
>         Linux cix-localhost 6.16.0-rc1-00023-gbaa962a95a28 #138 SMP PREEMPT Fri Jun 27 16:43:41 CST 2025 aarch64 GNU/Linux
>         root@cix-localhost:~# cat /etc/issue
>         Debian GNU/Linux 12 \n \l
>  
> Changes for v4
> https://patchwork.kernel.org/project/linux-pci/cover/20250424010445.2260090-1-hans.zhang@cixtech.com/
> 
>         - Add header file bitfield.h to pcie-cadence.h
>         - Addressed the following review comments
>                 Merged the TI patch as it
>                 Removed initialization of struct variables to '0'
> 
> Changes for v3
> https://patchwork.kernel.org/project/linux-pci/patch/20250411103656.2740517-1-hans.zhang@cixtech.com/
> 
>         - Patch version v3 added to the subject
>         - Use HPA tag for architecture descriptions
>         - Remove bug related changes to be submitted later as a separate
>           patch
>         - Two patches merged from the last series to ensure readability to
>           address the review comments
>         - Fix several description related issues, coding style issues and
>           some misleading comments
>         - Remove cpu_addr_fixup() functions
> ---
> 
> Hans Zhang (6):
>   dt-bindings: PCI: Add CIX Sky1 PCIe Root Complex bindings
>   PCI: Add Cix Technology Vendor and Device ID
>   PCI: sky1: Add PCIe host support for CIX Sky1
>   MAINTAINERS: add entry for CIX Sky1 PCIe driver
>   arm64: dts: cix: Add PCIe Root Complex on sky1
>   arm64: dts: cix: Enable PCIe on the Orion O6 board
> 
> Manikandan K Pillai (9):
>   PCI: cadence: Add module support for platform controller driver
>   PCI: cadence: Split PCIe controller header file
>   PCI: cadence: Add register definitions for High Perf Architecture
>     (HPA)
>   PCI: cadence: Add helper functions for supporting High Perf
>     Architecture (HPA)
>   PCI: cadence: Move PCIe EP common functions to a separate file
>   PCI: cadence: Move PCIe RP common functions to a separate file
>   PCI: cadence: Move PCIe controller common functions as a separate file
>   PCI: cadence: Add support for High Perf Architecture (HPA) controller
>   PCI: cadence: Update PCIe platform to use register offsets passed
> 
>  .../bindings/pci/cix,sky1-pcie-host.yaml      |  83 +++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  20 +
>  arch/arm64/boot/dts/cix/sky1.dtsi             | 126 ++++
>  drivers/pci/controller/cadence/Kconfig        |  21 +-
>  drivers/pci/controller/cadence/Makefile       |  11 +-
>  drivers/pci/controller/cadence/pci-sky1.c     | 232 +++++++
>  .../controller/cadence/pcie-cadence-common.c  | 141 +++++
>  .../cadence/pcie-cadence-ep-common.c          | 251 ++++++++
>  .../cadence/pcie-cadence-ep-common.h          |  36 ++
>  .../controller/cadence/pcie-cadence-ep-hpa.c  | 528 ++++++++++++++++
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 233 +------
>  .../cadence/pcie-cadence-host-common.c        | 179 ++++++
>  .../cadence/pcie-cadence-host-common.h        |  24 +
>  .../cadence/pcie-cadence-host-hpa.c           | 585 ++++++++++++++++++
>  .../controller/cadence/pcie-cadence-host.c    | 156 +----
>  .../cadence/pcie-cadence-hpa-regs.h           | 182 ++++++
>  .../pci/controller/cadence/pcie-cadence-hpa.c | 204 ++++++
>  .../cadence/pcie-cadence-lga-regs.h           | 228 +++++++
>  .../controller/cadence/pcie-cadence-plat.c    |  20 +-
>  drivers/pci/controller/cadence/pcie-cadence.c | 139 +----
>  drivers/pci/controller/cadence/pcie-cadence.h | 412 ++++++------
>  include/linux/pci_ids.h                       |   3 +
>  23 files changed, 3056 insertions(+), 765 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
>  create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-common.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-common.h
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-ep-hpa.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-common.h
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa-regs.h
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-hpa.c
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-lga-regs.h
> 
> 
> base-commit: be48bcf004f9d0c9207ff21d0edb3b42f253829e
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

