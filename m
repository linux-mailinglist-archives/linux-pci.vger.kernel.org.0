Return-Path: <linux-pci+bounces-39760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC1C1EFD6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4535A3AD2F9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1FD337699;
	Thu, 30 Oct 2025 08:29:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706202A1C7;
	Thu, 30 Oct 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812997; cv=none; b=ZWvwGyEa+gyJhxoxfIs1Axp7lwYL/MqdS2isnWQ4Ata+AVk7v5BNTRDXLRW+Lk9Xf2peeMxYa4g+idv+k8FOOBx37BzjQxjutDoauoCjnwjfkpMnJ7YKjNnXY0fuTcxyvyzCWTiJF0OpJisCv6Cd2e/71raK7kCAQj6XfskPsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812997; c=relaxed/simple;
	bh=ls2cGLc8qxKRv9NgAo9J9wR3ZCu34+cE+i+25qBw+oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JcDcl8XAPRm+YzbJUVhAIiUZ6UnBJonqOKeYJiluvaVafuoezRGyjbL+98N4EmPMphVCsbQ/l5eUcosIOByW4zpDPgBr0MVOJy3b3I5N3KcGGqh8+VtADMuFcMX6SQMyCTMxo6srRrBqwKV3CgNTblOlGLxI93PmvygqyM9Uiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app1 (Coremail) with SMTP id TAJkCgD38WnVIQNphLYJAA--.41111S2;
	Thu, 30 Oct 2025 16:29:12 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	mani@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	p.zabel@pengutronix.de,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com,
	mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v4 0/2] Add driver support for Eswin EIC7700 SoC PCIe controller
Date: Thu, 30 Oct 2025 16:28:59 +0800
Message-ID: <20251030082900.1304-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgD38WnVIQNphLYJAA--.41111S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1xWFy8KFyDZFWxWryxAFb_yoW7Zryxpa
	9rKFWYkr95Jr43Zws7Aa109FyfXanxCFy5JwnFg347Za17Cas7tr9FkFy3ta47CrZavrWY
	qa12qanYkFn8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRkwIhUUUUU=
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Changes in v4:
- Updates: eswin,eic7700-pcie.yaml
  - Use snps,dw-pcie.yaml instead pci-host-bridge.yaml.

- Updates: snps,dw-pcie-common.yaml
  - Add powerup reset property, our powerup property is somewhat different
    from the general attributes defined by Synopsys DWC binding.

- Updates: pcie-eic7700.c
  - Update the driver submission comment.
  - Alphabetize so the menuconfig entries remain sorted by vendor.
  - Update use PCI_CAP_LIST_NEXT_MASK macro.
  - Use readl_poll_timeout function.
  - Update eswin_pcie_suspend/eswin_pcie_resume name to
    eswin_pcie_suspend_noirq/eswin_pcie_resume_noirq.
  - PM use dw_pcie_suspend_noirq and dw_pcie_resume_noirq function and add
    eswin_pcie_get_ltssm, eswin_pcie_pme_turn_off, eswin_pcie_host_exit
    function adapt to PM.
- Link to V3: https://lore.kernel.org/linux-pci/20250923120946.1218-1-zhangsenchuan@eswincomputing.com/

Changes in v3:
- Updates: eswin,eic7700-pcie.yaml
  - Based on the last patch yaml file, devicetree separates the root port
    node, changing it significantly. Therefore, "Reviewed-by: Krzysztof
    Kozlowski <krzysztof.kozlowski@linaro.org>" is not added.
  - Clock and reset drivers are under review. In yaml, macro definitions
    used in clock and reset can only be replaced by constant values.
  - Move the num-lanes and perst resets to the PCIe Root Port node, make
    it easier to support multiple Root Ports in future versions of the
    hardware.
  - Update the num-lanes attribute and modify define num-lanes as decimal.
  - Optimize the ranges attribute and clear the relocatable flag (bit 31)
    for any regions.
  - Update comment: inte~inth are actual interrupts and these names align
    with the interrupt names in the hardware IP, inte~inth interrupts
    corresponds to Deassert_INTA~Deassert_INTD.
  - Add Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>.

- Updates: pcie-eic7700.c
  - Update the submission comment and add DWC IP revision, data rate, lane
    information.
  - Optimize the "config PCIE_EIC7700" configuration.
  - Optimize the macro definition, add bitfield definition for the mask,
    and remove redundant comments. optimize comments, make use of 80
    columns for comments.
  - Use the dw_pcie_find_capability function to obtain the offset by
    traversing the function list.
  - Remove the sets MPS code and configure it by PCI core.
  - Alphabetize so the menuconfig entries remain sorted by vendor.
  - Configure ESWIN VID:DID for Root Port as the default values are
	invalid,and remove the redundant lane config.
  - Use reverse Xmas order for all local variables in this driver
  - Hardware doesn't support MSI-X but it advertises MSI-X capability, set
    a flag and clear it conditionally.
  - Resets are all necessary, Update the interface function for resets.
  - Since driver does not depend on any parent to power on any resource,
    the pm runtime related functions are removed.
  - Remove "eswin_pcie_shutdown" function, our comment on the shutdown
    function is incorrect. Moreover, when the host powers reboots,it will
    enter the shutdown function, we are using host reset and do not need
    to assert perst. Therefore, the shutdown function is not necessary.
  - remove "eswin_pcie_remove", because it is not safe to remove it during
    runtime, and this driver has been modified to builtin_platform_driver
    and does not support hot plugging, therefore, the remove function is
    not needed.
  - The Suspend function adds link state judgment, and for controllers
    with active devices, resources cannot be turned off.
  - Add Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>.
- Link to V2: https://lore.kernel.org/linux-pci/20250829082021.49-1-zhangsenchuan@eswincomputing.com/

Changes in v2:
- Updates: eswin,eic7700-pcie.yaml
  - Optimize the naming of "clock-names" and "reset-names".
  - Add a reference to "$ref: /schemas/pci/pci-host-bridge.yaml#".
    (The name of the reset attribute in the "snps,dw-pcie-common.yaml"
    file is different from our reset attribute and "snps,dw-pcie.yaml"
    file cannot be directly referenced)
  - Follow DTS coding style to optimize yaml attributes.
  - Remove status = "disabled" from yaml.

- Updates: pcie-eic7700.c
  - Remove unnecessary imported header files.
  - Use dev_err instead of pr_err and remove the WARN_ON function.
  - The eswin_evb_socket_power_on function is removed and not supported.
  - The eswin_pcie_remove function is placed after the probe function.
  - Optimize function alignment.
  - Manage the clock using the devm_clk_bulk_get_all_enabled function.
  - Handle the release of resources after the dw_pcie_host_init function
    call fails.
  - Remove the dev_dbg function and remove __exit_p.
  - Add support for the system pm function.
- Link to V1: https://lore.kernel.org/all/20250516094057.1300-1-zhangsenchuan@eswincomputing.com/

Senchuan Zhang (2):
  dt-bindings: PCI: EIC7700: Add Eswin PCIe host controller
  PCI: EIC7700: Add Eswin PCIe host controller driver

 .../bindings/pci/eswin,eic7700-pcie.yaml      | 166 +++++++
 .../bindings/pci/snps,dw-pcie-common.yaml     |   2 +-
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-eic7700.c     | 462 ++++++++++++++++++
 5 files changed, 641 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c

--
2.25.1


