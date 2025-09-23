Return-Path: <linux-pci+bounces-36762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B251B95C94
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 14:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6FC2E5BFF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA8322DAC;
	Tue, 23 Sep 2025 12:10:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF55322DCC;
	Tue, 23 Sep 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629450; cv=none; b=IXCYFEc+TcGPNgUkKoKpN8A5v06ecf/Nbc6hI/zFW3o7zY21TqCIFNX9n6Kw4ulDU0CwfcPEpqI6RnSD2wUau0kiFgdd21G5Wo/h5OynxY0HfA4KXXta2N0M0hRsYS2VHAXR7WUWMXENVv2p0+TYl7ot29p8UnkoE6G5m7dpS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629450; c=relaxed/simple;
	bh=8lFhuOZPId9KLsfs+kyMwu30eZP9d7zFnNiEhXXo9ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czRC+FWKqzliO9Z9+KHhgHXhBNBqOBG/iAVRExBEDjP4MMa2uGVxrdqtC1iHkCNT4cLsFYR+JOYD445d6GRCBDKnMhE8Ia6r1AjNSasqgTV4On759hnro6GUqWPU6vZk8EyFL8omh7myQPQK6sUe+8PmaiJ0pQldCbKbmSkb6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app2 (Coremail) with SMTP id TQJkCgA315UUjtJoWSnYAA--.40057S2;
	Tue, 23 Sep 2025 20:10:00 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de,
	johan+linaro@kernel.org,
	quic_schintav@quicinc.com,
	shradha.t@samsung.com,
	cassel@kernel.org,
	thippeswamy.havalige@amd.com,
	mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v3 0/2] Add driver support for Eswin EIC7700 SoC PCIe controller
Date: Tue, 23 Sep 2025 20:09:45 +0800
Message-ID: <20250923120946.1218-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgA315UUjtJoWSnYAA--.40057S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8ZrW5Cw4UZryDCFy8Krg_yoWrtr15pF
	ZrKFWYkr95Jr43Zws7Aa109FyfXanxJFy5GwnFg347ua13Cas7trykKFWFva4UGr92vryF
	qa1jqan5CFn8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRi7KItUUUUU==
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

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

 .../bindings/pci/eswin,eic7700-pcie.yaml      | 173 +++++++
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-eic7700.c     | 446 ++++++++++++++++++
 4 files changed, 631 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c

--
2.25.1


