Return-Path: <linux-pci+bounces-43035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFC3CBD4D0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 11:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B7D9300A376
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AFB329E74;
	Mon, 15 Dec 2025 10:00:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45EB329379;
	Mon, 15 Dec 2025 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792814; cv=none; b=JScM+LXvwsFhvpXxr+ojx98rgZn2aOg6lxm6Czcc5n33ed7Sr3s73L3gca1LUMiyU5wuqQ2k9kvUWYNZjcwLUsfMA5++qfebGXO6tDWXnYse1z+qCXOGJvtsZ0Sk1yXPQdR4Y93lCZpfQmoIlTRXs8rs79FmMMYwew/emqCKal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792814; c=relaxed/simple;
	bh=ytwQxqlX9vm3S6/+q4uD8ooGPQtTMot2B9RGAP6ky24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oX45mUsf647pSIUYFzk1l3qLh68ux09e08UEJxsA+0WNYOOa3l99HQ4BtLqMRBNUtPw9rxaf+GRrD8u4Umrf0KbPxCwL/xPBvn/djaF32tgdZCr7zggW1fn5IwGXFoXVYkpBoGdJD8AGVn5s2tibxDP3BwT33YGSAdBOKyC3v9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app2 (Coremail) with SMTP id TQJkCgCn6awD3D9pc5OFAA--.62378S2;
	Mon, 15 Dec 2025 17:59:33 +0800 (CST)
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
	inochiama@gmail.com,
	Frank.li@nxp.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v8 0/2] Add driver support for Eswin EIC7700 SoC PCIe controller
Date: Mon, 15 Dec 2025 17:59:28 +0800
Message-ID: <20251215095928.1712-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgCn6awD3D9pc5OFAA--.62378S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AryfGw47tw45CFyftryUtrb_yoWfKr1Upa
	yvkFWj9rn8Xr1xZrs7AF4F9F4fXan8ZFy5Cw1xW34UZa12q3s7tryvkFW3tasrArZxZrWF
	vF42qan0kF4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Changes in v8:
- Updates: eswin,eic7700-pcie.yaml
  - None

- Updates: pcie-eic7700.c
  - Remove dw_pcie_suspend_noirq/dw_pcie_resume_noirq API and add a
    comment, and remove .deinit.
  - Remove no_pme_handshake flag.
  - Add dw_pcie_dbi_ro_wr_en/dw_pcie_dbi_ro_wr_dis API.
  - Add eic7700_pcie_assert helper function.
  - Update NOIRQ_SYSTEM_SLEEP_PM_OPS to DEFINE_NOIRQ_DEV_PM_OPS.
- Link to V7: https://lore.kernel.org/all/20251202090225.1602-1-zhangsenchuan@eswincomputing.com/

Changes in v7:
- Updates: eswin,eic7700-pcie.yaml
  - None

- Updates: pcie-eic7700.c
  - Update "config PCIE_EIC7700" bool to tristate.
  - Remove fix MSI-X code, depend on new commit [1].
  - Add set no_pme_handshake flag.
  - Update -EINVAL to -ENODATA and add PM runtime function.
  - Add ".probe_type = PROBE_PREFER_ASYNCHRONOUS,".
  - Update eic7700_pcie_perst_deassert function name to
    eic7700_pcie_perst_reset.
  - Update readw to dw_pcie_readw_dbi function.
  - Add comments above reset_control_bulk_deassert function.

- Updates: pcie-designware.h pcie-designware-host.c
 -  The ESWIN EIC7700 SoC lacks hardware support for the L2/L3 low-power
    link states. It cannot enter the L2/L3 ready state through the
    PME_Turn_Off/PME_To_Ack handshake protocol. To address this, add a
    no_pme_handshake flag skip PME_Turn_Off broadcast and link state check
    code, other driver can reuse this flag if meet the similar situation.
- Link to V6: https://lore.kernel.org/linux-pci/20251120101018.1477-1-zhangsenchuan@eswincomputing.com/
- Link to: https://lore.kernel.org/linux-pci/20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com/ [1]

Changes in v6:
- Updates: eswin,eic7700-pcie.yaml
  - Add Reviewed-by: Rob Herring (Arm) <robh@kernel.org>.

- Updates: pcie-eic7700.c
  - Remove pci_root_ports_have_device function judgment during suspend.
  - Remove eic7700_pcie_pme_turn_off and eic7700_pcie_get_ltssm function.
  - Add set no_suspport_L2 flag.

- Updates: pcie-designware.h pcie-designware-host.c
 - The ESWIN EIC7700 soc does not support enter L2 link state. Therefore
   add no_suspport_L2 flag skip PME_Turn_Off broadcast and link state
   check code, other driver can reuse this flag if meet the similar
   situation.
- Link to V5: https://lore.kernel.org/all/20251110090716.1392-1-zhangsenchuan@eswincomputing.com/
- Link to: https://lore.kernel.org/all/e7plmtwtkkd4ymrt2hkztcqdx4ugfjk64oksjyf6lpi2oui53d@vhuo5occyref/

Changes in v5:
- Updates: eswin,eic7700-pcie.yaml
  - Modify reg-names: update mgmt to elbi.
  - Modify clock-names: update pclk to phy_reg.
  - Modify reset-names: update powerup to pwr.
  - Remove powerup modify in "snps,dw-pcie-common.yaml" file.

- Updates: pcie-eic7700.c
  - Update the driver submission comment, mention EIC7700 in the
    "config PCIE_EIC7700" and in the driver title.
  - Update some comments, for examples: "s/PME_TURN_OFF/PME_Turn_Off/",
    "s/INTX/INTx/", "s/PERST/PERST#/", "s/perst/PERST#/", "s/id/ID/".
  - Update "struct *_pcie" name and function name, add the eic7700 prefix.
  - Use PCIEELBI_CTRL0_DEV_TYPE macro and update comment, use FIELD_PREP.
  - Add eic7700_pcie_data pointer in struct eic7700_pcie.
  - Update .deinit callback function name and removed the dw_pcie_link_up
    judgment, add pci_root_ports_have_device function judgment.
  - Remove devm_platform_ioremap_resource_byname function get mgmt, use
    platform_get_resource_byname function get elbi in "pcie-designware.c".
  - Update of_reset_control_get to of_reset_control_get_exclusive, use
    devm_reset_control_bulk_get_exclusive function get resets, update use
    reset_control_bulk_assert/reset_control_bulk_deassert function.
- Link to V4: https://lore.kernel.org/all/20251030082900.1304-1-zhangsenchuan@eswincomputing.com/
- Link to https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/?h=controller/dwc

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
  dt-bindings: PCI: eic7700: Add Eswin PCIe host controller
  PCI: eic7700: Add Eswin PCIe host controller driver

 .../bindings/pci/eswin,eic7700-pcie.yaml      | 167 ++++++++
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-eic7700.c     | 391 ++++++++++++++++++
 4 files changed, 570 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c

--
2.25.1


