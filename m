Return-Path: <linux-pci+bounces-11163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6919457CD
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913971C213A9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD06B41C75;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+5O7gA3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E622EE4;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578119; cv=none; b=gIXfVurZf/x9XXyGFKx5KO2g5HXkETJ4cohkAzr8arYrYWz2v3+XL26Tks8ep0P7yZEZZ7dCh4b1dARBkdQ6pKsms8XaDDBybLmZU+oyvONgRDrKvK3raZ6aDICN6AIksD0wY0VEvEH3zn7QDfwD18RPJQIe9Smb9+QxxWlc7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578119; c=relaxed/simple;
	bh=ukMBOMVf5/SQqEc9ERVW/jAC++xbTeCq9CS0IIw4Y+w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nt6AzjHgtyx43N9zc8zL6gF2pk3iPCPka6xTWOyU64D4nbXkCPHnAbLTaOtOeyrkZRaCPEz1SBfRUsQT1yytqf4ustkZ7cteoFqjljCbBYjuYJnd/4NqlecUedmuAVNeTMp9aM1E6iOUzBPIoFcwlNc3EzM0cPLJsY+tV1BTmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+5O7gA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29D1EC32782;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722578119;
	bh=ukMBOMVf5/SQqEc9ERVW/jAC++xbTeCq9CS0IIw4Y+w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D+5O7gA3S1IbT9qsfvEmzGKDQvjt8//tVfqAIUdVzcde8h3TShRzL4wzTAQcXENQl
	 sArCmMWdwtDbMPyaffI7M20UjcrbUJJ/PpAANWlTNTPDFcsZACmWu/M5xzvjhC+a6I
	 jBdYQRegE89Y3MXVE2Bgws2wZeNZq353N26dHHiB21bWicRX30Sp0cwucF/6wceLl4
	 ZHc0B1E64VRq/G9K59aoU7CZ4yxYni4sdw57wjMQyFty/jyIQgvuOAR+8k1ES1YhV6
	 mQqgRVNgyReZZqkPP8pIRiwpvDRIdgp1ZrxGAD0MhOrcbefIe3EusupyHyzwyI20oC
	 rE9x9XjTVEV3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E21C52D71;
	Fri,  2 Aug 2024 05:55:19 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Subject: [PATCH v5 0/4] PCI: Allow D3Hot for PCI bridges in Devicetree
 based platforms
Date: Fri, 02 Aug 2024 11:24:59 +0530
Message-Id: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALN0rGYC/x2MywqAIBAAf0X23IKsBtWvRAcfW+3FRCGC8N+Tj
 sMw80LlIlxhUS8UvqXKlTqMg4JwunQwSuwMpMlqQxpzEPRFYjfRoJ6JybML1kzQm1x4l+f/rVt
 rH7oVnQtfAAAA
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, lukas@wunner.de, 
 mika.westerberg@linux.intel.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3410;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ukMBOMVf5/SQqEc9ERVW/jAC++xbTeCq9CS0IIw4Y+w=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmrHTCfSo/mfFS/bxOe2eefyfjz9u0G2yanEM6y
 b7OClN0PvGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqx0wgAKCRBVnxHm/pHO
 9TDeB/9/SM6+JeQrrSF8L7RpM5SG+czu6Nqa/lDyoya3UHWXfH3GoynxyrD804Qri4+v18lyLnj
 Ua5WXEN3k65ZEblnnDx1ozNT5xW6EX1GoZqdaHOteXknjvWyA1G7YZVhgBB4GzNHCDtAdCxS9sg
 F1a94OxCo4WAuk2QWBLNKlltoSNubuRCgGUqDIBmCriPN9ew/bfGJ8q+eZH4sVJbIB2zHLFfhnx
 8vTfcd3yMQCecOeWHPm/AAjlpVgM0yJ4E2joqlXZ/x8dqU3HCBYBdQpuxwEZl/UFQMrTHlf04Ld
 v0aJaiqwSNb2AGmKH8+XPcahfXEOycvtP4gh9uyNWmsrRmic
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

Hi,

This series allows D3Hot for PCI bridges in Devicetree based platforms.
Even though most of the bridges in Devicetree platforms support D3Hot, PCI
core will allow D3Hot only when one of the following conditions are met:

1. Platform is ACPI based
2. Thunderbolt controller is used
3. pcie_port_pm=force passed in cmdline

While options 1 and 2 do not apply to most of the DT based platforms,
option 3 will make the life harder for distro maintainers.

Initially, I tried to fix this issue by using a Devicetree property [1], but
that was rejected by Bjorn and it was concluded that D3Hot should be allowed by
default for all the Devicetree based platforms.

During the review of v3 series, Bjorn noted several shortcomings of the
pci_bridge_d3_possible() API [2] and I tried to address them in this series as
well.

But please note that the patches 2 and 3 needs closer review from ACPI and x86
folks since I've splitted the D3Hot and D3Cold handling based on my little
understanding of the code.

Testing
=======

This series is tested on SM8450 based development board on top of [3].

- Mani

[1] https://lore.kernel.org/linux-pci/20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org/
[2] https://lore.kernel.org/linux-pci/20240305175107.GA539676@bhelgaas/
[3] https://lore.kernel.org/linux-arm-msm/20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org/

Changes in v5:
- Rebased on top of v6.11-rc1
- Fixed the function name in Kdoc of patch 3/4
- Collected tags
- Link to v4: https://lore.kernel.org/linux-pci/20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org

Changes in v4:
- Added pci_bridge_d3_possible() rework based on comments from Bjorn
- Got rid of the DT property and allowed D3Hot by default on all DT platforms

Changes in v3:
- Fixed kdoc, used of_property_present() and dev_of_node() (Lukas)
- Link to v2: https://lore.kernel.org/r/20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org

Changes in v2:
- Switched to DT based approach as suggested by Lukas.
- Link to v1: https://lore.kernel.org/r/20240202-pcie-qcom-bridge-v1-0-46d7789836c0@linaro.org

To: Bjorn Helgaas <bhelgaas@google.com>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: lukas@wunner.de
Cc: mika.westerberg@linux.intel.com

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (4):
      PCI/portdrv: Make use of pci_dev::bridge_d3 for checking the D3 possibility
      PCI: Rename pci_bridge_d3_possible() to pci_bridge_d3_allowed()
      PCI: Decouple D3Hot and D3Cold handling for bridges
      PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms

 drivers/pci/bus.c          |  2 +-
 drivers/pci/pci-acpi.c     |  9 ++---
 drivers/pci/pci-sysfs.c    |  2 +-
 drivers/pci/pci.c          | 90 ++++++++++++++++++++++++++++++++--------------
 drivers/pci/pci.h          | 12 ++++---
 drivers/pci/pcie/portdrv.c | 16 ++++-----
 drivers/pci/remove.c       |  2 +-
 include/linux/pci.h        |  3 +-
 8 files changed, 89 insertions(+), 47 deletions(-)
---
base-commit: 705c1da8fa4816fb0159b5602fef1df5946a3ee2
change-id: 20240320-pci-bridge-d3-092e2beac438

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>



