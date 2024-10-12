Return-Path: <linux-pci+bounces-14348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA0799AFC3
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 02:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D84A1C2098D
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 00:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CF4C8E;
	Sat, 12 Oct 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="csIqE4V7"
X-Original-To: linux-pci@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F369454
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728694163; cv=none; b=D0g/QQaM5p9wLL0Kzm7owSbzPxcbjECSr+i7x4wu4NcaKYuKaxuBjwJwXknFdSEFSPaqkRdZE/WZFpWbmOUq0gMy7lrU5bSOvbgybhEtwOGVuJHgVnbRPt0uGZEl8IPo+J0zkN5mLdaF2Lo1cr5lzo95bGYlcplqoGISxlE1X04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728694163; c=relaxed/simple;
	bh=8o/zrm3ec3Qn/gMD4SRhqt+suF+mK2qZRemCpkb0kFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyRTcl8TpDjqKXFGflSChoxZvk80CS+IVtnPEhspP61HecSoBSKYk4qu9SxiJ/d/4trnKdJbakyxJnUbrX3sL9rVOga9evTwvCfPto1b+UOmGI7ecOHsLHodiVkRkmMtV1a8aZmjDjZNPldtWh5Uoco4xPP0vmDeRWHXGtAzMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=csIqE4V7; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1F6B489435;
	Sat, 12 Oct 2024 02:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728694154;
	bh=k8G0aVFo4A2s8zjkrvdJNXe/U25JMAnZE3wFAyMbmO0=;
	h=From:To:Cc:Subject:Date:From;
	b=csIqE4V7Nc9r25y/Ypp7HSM6A79+OiwV7OrvQ9msXvQ7ibdh8K+vUemGQC183jZvj
	 hOAWdUZaeNRysMBARm5kTl7bUySUa5HUDNZTAFin2b7j7fybOqpB3G+Z5ckWiL+nl6
	 xwG3phDKrztuxPftk3YUTlsSsoReEhzqBj9QVyLr3+nBxo6TRec7qY6eMZxEv1nHVs
	 i2CTLeKNx1cSxp6NKwA0jtBit3GJ1q1KGR26Ikea7Wzg+HENRJaBbyAUChhCu4jpBd
	 7jWZmzeT5rEUGYlO6RJR5aPxqlGZWls7Pc607RHd2tAR2kvOeSdN6hcQMrhm67/Iu8
	 dRhPFGEcGRwoA==
From: Marek Vasut <marex@denx.de>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH] [RFC] PCI/PM: Do not RPM suspend devices without drivers
Date: Sat, 12 Oct 2024 02:48:48 +0200
Message-ID: <20241012004857.218874-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

I am sending this as RFC, because I can only trigger it sporadically on
Linux 6.6.54 , but I believe this was around for a while. The rationale
might also be far from perfect. This is NOT a proper fix for the issue.

The pci_host_probe() and pci_bus_type RPM suspend seem to race against each
other at least in Linux kernel up to 6.6.54 . The problem occurs when the
PCIe host controller driver, in this case DWC i.MX6, is sufficiently delayed
by EPROBE_DEFER from one if its clocks, in this case the PCIe bus clock
provided by RS9 clock synthesizer driver which is compiled as a module and
loaded about a minute after boot. Once the RS9 module is loaded and the
bus clock become available, the probe of DWC iMX6 controller driver can
proceed.

At that point, imx6_pcie_probe() triggers pci_host_probe(), while at the
same time, devices instantiated with pci_bus_type can already enter RPM
suspend via pci_bus_type pci_pm_runtime_idle() / pci_pm_runtime_suspend()
callbacks.

The pci_host_probe() does reallocate BARs for devices which start up with
uninitialized BAR addresses set to 0 by calling pci_bus_assign_resources(),
which updates the device config space content.

At the same time, pci_pm_runtime_suspend() triggers pci_save_state() for
all devices which do not have drivers assigned to them to store current
content of their config space registers.

This leads to a race condition between pci_bus_assign_resources() and
pci_save_state(). In case pci_save_state() wins and gets called before
pci_bus_assign_resources(), the content stored by pci_save_state() is
the incorrect pre-pci_bus_assign_resources() content, which is usually
one with BARs set to invalid addresses and possibly other invalid
configuration.

Once either a driver or manual RPM control attempts to start the device
up, that invalid content is restored into the device config space and
the device becomes inoperable. If the BARs are restored to zeroes, then
the device stops responding to BAR memory accesses, while it still does
respond to config space accesses.

Work around the issue by not suspending pci_bus_type devices which do
not have driver assigned to them, keep those devices active to prevent
pci_save_state() from being called. Once a proper driver takes over, it
can RPM manage the device correctly.

Invalid ordering and backtrace is below, visualized with this extra print
added to drivers/pci/setup-res.c :

"
@@ -108,6 +108,8 @@ static void pci_std_update_resource(struct pci_dev *dev, int resno)
                        resno, new, check);
        }

+       pci_err(dev, "BAR %d: updated (%#010x != %#010x)\n", resno, new, check);
+
        if (res->flags & IORESOURCE_MEM_64) {
                new = region.start >> 16 >> 16;
                pci_write_config_dword(dev, reg + 4, new);
"

"
[   47.042906] pci 0000:01:00.0: save config 0x10: 0x00000004
...
[   47.079863] pci 0000:01:00.0: BAR 0: updated (0x18100004 != 0x18100004)
...
"

"
[   47.274095]  pci_update_resource+0x1f0/0x260
[   47.278370]  pci_assign_resource+0x22c/0x234
[   47.282643]  assign_requested_resources_sorted+0x6c/0xac
[   47.287959]  __assign_resources_sorted+0xfc/0x424
[   47.292669]  __pci_bus_assign_resources+0x68/0x1f4
[   47.297463]  __pci_bus_assign_resources+0xec/0x1f4
[   47.302258]  pci_bus_assign_resources+0x1c/0x24
[   47.306792]  pci_host_probe+0x88/0xa4
[   47.310457]  dw_pcie_host_init+0x17c/0x530
[   47.314560]  imx6_pcie_probe+0x698/0x708
[   47.318487]  platform_probe+0x6c/0xb8
[   47.322153]  really_probe+0x140/0x278
[   47.325818]  __driver_probe_device+0xf4/0x10c
[   47.330177]  driver_probe_device+0x40/0xf8
[   47.334277]  __device_attach_driver+0x60/0xd4
[   47.338638]  bus_for_each_drv+0xb4/0xdc
[   47.342476]  __device_attach_async_helper+0x78/0xcc
[   47.347357]  async_run_entry_fn+0x38/0xe0
[   47.351369]  process_scheduled_works+0x1cc/0x2b8
[   47.355991]  worker_thread+0x214/0x25c
[   47.359744]  kthread+0xec/0xfc
[   47.362804]  ret_from_fork+0x10/0x20
"
"
[   47.575814]  pci_save_state+0xcc/0x224
[   47.579567]  pci_pm_runtime_suspend+0x44/0x16c
[   47.584013]  __rpm_callback+0x48/0x124
[   47.587764]  rpm_callback+0x70/0x74
[   47.591254]  rpm_suspend+0x26c/0x424
[   47.594831]  rpm_idle+0x190/0x1c0
[   47.598149]  pm_runtime_work+0x8c/0x9c
[   47.601900]  process_scheduled_works+0x1cc/0x2b8
[   47.606524]  worker_thread+0x214/0x25c
[   47.610278]  kthread+0xec/0xfc
[   47.613338]  ret_from_fork+0x10/0x20
"

Trigger:
"
$ modprobe clk_renesas_pcie
$ echo on > /sys/devices/platform/soc\@0/33800000.pcie/pci0000\:00/0000\:00\:00.0/0000\:01\:00.0/power/control
"

Useful hint in the BAR0 direction:
https://forums.developer.nvidia.com/t/intel-9260-wifi-on-jetson-nano-jetbot/73360/46

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 35270172c8331..2c21ae4b15217 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1378,7 +1378,7 @@ static int pci_pm_runtime_idle(struct device *dev)
 	 * always remain in D0 regardless of the runtime PM status
 	 */
 	if (!pci_dev->driver)
-		return 0;
+		return -EBUSY;
 
 	if (pm && pm->runtime_idle)
 		return pm->runtime_idle(dev);
-- 
2.45.2


