Return-Path: <linux-pci+bounces-10546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FFA93775F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 13:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524F9B220CF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 11:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469EA127E37;
	Fri, 19 Jul 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7BJVgqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AA9127E3A;
	Fri, 19 Jul 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721390293; cv=none; b=kli6WK+w5izp+mcaYyqBsu96H/JxxhV+h5iADvqGnGOCoGlZ4QFsatgHopdZABGsnQLbOVV5Xi8WXZj8RE+nXGDed0QTdurkwm2Oy7mQTh4ruJf8jaTPn88fa2hJpSgb//nLEM1jTMk4a8WHro6xEOpPRdVfojev1QtYokNPBgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721390293; c=relaxed/simple;
	bh=0H/0rGTKUqIingIPW6ihO+2UmRgyKXDsjrpX7maeANo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T0R+fCxNYOeMKVVAqUFVmz0C3dm/DEJXpmlS99ddPF3Tj1R+zH8CsuMuu7xJ556TTgvqHYvs0N9+3M/KUV5CE7mMlgoXF6C+lWVgcP2oIIOh2iOT1GDNIX72++MQ/coG/HUwIW8c9Gy/ibMyXvBBSvJ3/oTwRq7fx+r8jqNm03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7BJVgqU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso486622166b.1;
        Fri, 19 Jul 2024 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721390290; x=1721995090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKLAjrQgCVjhebH7V+4xp3xcQm2st92mvr4mdCJO+LE=;
        b=h7BJVgqUtRorgNTYhNziGruGYx4unWIgyotRgiSr6g+cRXeVyJKYLPvgnkFpW5Crap
         wt14aC3Q/XFuEYhOcD8Y2mE0fykudvL9ivdwuSif5y4aIbCTUHw1V03N1VtStq/iNsvH
         qsHktcUEHxfFDYc1p0mMwD8tdcmOf5c9DkndIKbYhOPTVqLOH9bqTGHKuq8Tb6j0PXGC
         pnqOLNykEwy2/IA2pjTVWSMCt+Tq6c+jebFdKYJ7AZZXo+jOBU7XjnTkm/1k/CyMZiMr
         M5N11bzTVj3IUoicwaZVBGYy8bpHXab4aUQS/HY/32goYLurgv+cWv0g5m9gapm5rXgP
         X74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721390290; x=1721995090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hKLAjrQgCVjhebH7V+4xp3xcQm2st92mvr4mdCJO+LE=;
        b=qe3YUZwP4hVqfxyvmLp+AsfVfjbTe6Jz9VQr+F33DMXfrIU6ZlTgr/5qG6tqy2SMs9
         hLSigyhlfrClZ2GeMY6aEvjy0HX/Qu7r98s3UBHJnLG7Q5rwmV0S2zMbWk16YEGOjE1b
         S1Ri1pJdVdGYLoX2AeniSrMts6jTvjg+jFrcy4BRlTmlry5Wl6KLpYvpoJC382IWPlS4
         Sg5cNFoKcLqeaLp+ebYgnK9pG77G4tCkW/R7rtQ8jBiy51EjMQAPrIhsqQWpUfe//GJp
         kv+78s4gRsfp0e6eKHnNLcY8lFoBHTOc8F+YVt1izkX9ckXuoGTfEH37DwY+eRtumBx5
         ENMw==
X-Forwarded-Encrypted: i=1; AJvYcCUm4dNL33UrS5pNUwfYm6U3s50HaLvttM5eBD3EIpESnUiJdDKStvEE/ijzW++w45LHZNGU/fXaH/YK/oZlaMCUD9rd7IXaT8DbK3c+oQ1nsUnlaBhTGIrZZ7bWnNPpnsG4FQ5xg+BE
X-Gm-Message-State: AOJu0YyOwm93AMy9OxP445j5O+hyqFkuDldpMzMYCIplY7ahrgb9KJj3
	0T026whxdhXH3rS2nLnxcPVdDQNgqUCqbwyOY6ZMXYCKYsKn2n9w
X-Google-Smtp-Source: AGHT+IHPnPazDxP3h2odXNNm28+KeM59itA3KKgZbzjIb/1pKbG8KymWQnDPNgScrExM/Zkqqqzjhg==
X-Received: by 2002:a17:906:6c97:b0:a77:afd5:62aa with SMTP id a640c23a62f3a-a7a0f774519mr546157966b.23.1721390289521;
        Fri, 19 Jul 2024 04:58:09 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c2f869dsm1093824a12.65.2024.07.19.04.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:58:09 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: rick.wertenbroek@heig-vd.ch
Cc: damien.lemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: endpoint: Introduce 'get_bar' to map fixed address BARs in EPC
Date: Fri, 19 Jul 2024 13:57:37 +0200
Message-Id: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I have been exploring the possibility to add FPGA based PCI endpoint controller
support within the current PCI Endpoint Framework [1]. The FPGA IP based
controllers are mostly similar to the ones found in SoCs with one major
difference. As they reside in the FPGA fabric and do not have direct access to
the SoC main memory space they usually come with pre-assigned BAR mappings
within their own memory space (memory space that can be accessed by the SoC CPU
or softcore within the FPGA running Linux, however the physical addresses may be
different). Therefore it is not possible to allocate memory from the CPU running
linux with 'pci_epf_alloc_space' and set the endpoint controller to reroute the
PCI read/write TLPs to that address with 'pci_epc_set_bar'.

Therefore, I suggest to introduce 'pci_epc_get_bar' and the 'fixed_addr'
endpoint controller bar feature to indicate that the BAR resides at a given
address (usually set during the FPGA IP configuration before synthesis). As for
providing this information from the FPGA IDE to Linux, the device tree can be
used. This choice is at the discretion of the specific endpoint controller driver.

The endpoint functions can query the endpoint controller driver on their BAR
features, as is already the case with the features 'fixed_size' or 'only_64bit'.
If the BAR is 'fixed_addr' (new feature) they call 'pci_epc_get_bar' instead of
'pci_epf_alloc_space' followed by 'pci_epc_set_bar'. 'pci_epc_get_bar' will
fill the 'pci_epf_bar' structure with physical address and do an ioremap() to
provide the 'pci_epf_bar.addr' virtual address.

This change it would allow writing PCI endpoint controller drivers for
Intel/Altera and AMD/Xilinx PCI endpoint IPs.

The patches are for linux-next tag : next-20240719

I have successfully demonstrated that it is possible to write such a driver
thanks to the new 'pci_epc_get_bar' function for the AMD/Xilinx PCI endpoint IP
for ZynqUS+ devices [2,3]. And have successfully run the PCI Test Function [4]
as well as NVMe endpoint functions I am working on. (Note: the function is called
'pci_epc_get_fixed_bar' in that example code and drivers).

The new 'pci_epc_get_bar' function would also allow to write virtual / emulated
PCI endpoint controllers that run on the host machine where both the PCI
endpoint function and the driver for the PCI device on the virtual bus run on
the same machine. For now this is not possible because the BARs backing memory
allocated with 'pci_epf_alloc_space' are in RAM (non reserved part of RAM) and
when a PCI driver will need to be loaded e.g., '/drivers/misc/pci_endpoint_test'
for the PCI Test Function [4]. It will fail to request the regions for the BARs
in '__pci_request_region' (drivers/pci/pci.c) because the memory space allocated
is in RAM and will cause a conflict. Normally this problem does not appear
because the endpoint function driver and the PCI driver are not running
on the same machine (the function driver is running in the endpoint, e.g., an
SoC connected to the host PC via PCIe and the PCI driver is running on the host
PC). With the new 'pci_epc_get_bar' function one could mark part of the RAM as
reserved memory and use it for the BARs, and then because it is reserved memory
when loading the PCI driver, there will be no conflict in '__pci_request_region'.
This would allow to run the PCI endpoint functions on the host. This is useful
for research and development of new functions and very similar to the NVMeVirt
project [5], where they emulate an NVMe PCI device on the host PC, in RAM. With
the proposed changes I could introduce a "virtual PCI endpoint controller" driver
that would allow to run the endpoint functions available in the Linux PCI
Endpoint Framework [1]. This would allow for a much lighter setup to develop new
functions without the need of an SoC board for most of the development.


The suggested change does not break any compatibility with the existing endpoint
controllers drivers or endpoint function drivers and could be introduced without
further changes. I provided the changes in the 'pci-epf-test' driver to show how
endpoint function drivers would take advantage of this new function to be able to
become compatible with endpoint controller drivers with fixed address BARs.

Cheers.
Rick

[1] https://www.kernel.org/doc/html/latest/PCI/endpoint/index.html
[2] https://github.com/rick-heig/nvme_csd/tree/main/platforms/zcu106
[3] driver (Linux 6.5) https://github.com/rick-heig/linux-xlnx/blob/csd_20231212/drivers/pci/controller/pcie-xilinx-ep.c
[4] https://www.kernel.org/doc/html/latest/PCI/endpoint/pci-test-function.html
[5] https://github.com/snu-csl/nvmevirt

Rick Wertenbroek (2):
  PCI: endpoint: Introduce 'get_bar' to map fixed address BARs in EPC
  PCI: endpoint: pci-epf-test: Add support for controller with fixed
    addr BARs

 drivers/pci/endpoint/functions/pci-epf-test.c | 38 +++++++++++++++++--
 drivers/pci/endpoint/pci-epc-core.c           | 37 ++++++++++++++++++
 include/linux/pci-epc.h                       |  7 ++++
 3 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.25.1


