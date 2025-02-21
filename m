Return-Path: <linux-pci+bounces-22086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A72A407B0
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F353219C6E7E
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE56620A5CF;
	Sat, 22 Feb 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GYXp/GXq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0847208961
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221844; cv=none; b=ORKEJkE+ElguQt/E+630s/ZdKKpsx4tTnYvJCGgELkquCN4+eNTWmzA4LZI6UkndDzj5Yija++RoXpEIPmCj6z76780TL3v6JYmfKM9IVzKF8xZMNa1Yp9Y4oWs1CkNXCv4+evZMKKEHZGimJknk5VwnRZwmRgWL0iypJFTehDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221844; c=relaxed/simple;
	bh=e0erdF0twJYNSVrbGQobI/jjDPZ3kjL8JPlHMSiooE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=b5IS939LYa/fuPRdVmWyIqHZoAYAxJUzmV3b0C8vH2f5IdapU3PRxl/XM0eMtM/N9cBD96GZgQVcNyYkUznXLLswdzPPd+UbsjLvDB9M0vaU/TtE7+ZmdHLT/mU+Zn+37/lnD+xFB5079IHQjFY/OkGmw6oEuIxOvFMbtucMaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GYXp/GXq; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250222105720epoutp042a3db987a7b27bff95fa4c2cf985727c~mgotTADXj1535215352epoutp04c
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:57:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250222105720epoutp042a3db987a7b27bff95fa4c2cf985727c~mgotTADXj1535215352epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740221840;
	bh=GDrRxJdDKDeQsLoUyWU3HU1LlEhYeBjbVEKvneEwPbA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GYXp/GXqD2Dic8EuXYEAysvkDYMeGSY6HiwnB7lrUzsjwPH2I5Ri2br086yu0o6Z5
	 DRoYb/nrHDIxOtRLoqabNnvczSBlTYr5R5m6Qt4XQ8T610GLftTVQILWsJ77RpzAsE
	 rjalYyCBZdHGaU1l2N/lqxghkwRorDzrCjC/4y08=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250222105720epcas5p30631c60540b66daefad7ce8b0694f303~mgosqZVgq0573205732epcas5p3p;
	Sat, 22 Feb 2025 10:57:20 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z0P8Z29D0z4x9Pv; Sat, 22 Feb
	2025 10:57:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.F1.19710.E8DA9B76; Sat, 22 Feb 2025 19:57:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5~mO8JJOwUe2791427914epcas5p4r;
	Fri, 21 Feb 2025 13:20:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250221132011epsmtrp22f7624b78aa3385ffea22835fa5d06a6~mO8JIRaK91906719067epsmtrp26;
	Fri, 21 Feb 2025 13:20:11 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-8d-67b9ad8eb5a4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.3F.33707.B8D78B76; Fri, 21 Feb 2025 22:20:11 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250221132008epsmtip24b146ccec521cc047535442a2ce80e91~mO8GTgdud0684606846epsmtip2x;
	Fri, 21 Feb 2025 13:20:08 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
	18255117159@163.com, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Date: Fri, 21 Feb 2025 18:45:43 +0530
Message-Id: <20250221131548.59616-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmum7f2p3pBpev8Fhcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2qx4stMdotVC6+xWTT0/Ga12PT4GqvF5V1z2CzOzjvOZnFl6zoWi5Y/
	LSwWd1s6WS2WXr/IZPF3215Gi0Vbv7BbLGx+yWjxf88Odovew7UWLXdMLd7/3MzmIOaxeMUU
	Vo8189YweuycdZfdY8GmUo+WI29ZPTat6mTzuHNtD5vHzoeWHk+uTGfy2Lyk3qNvyypGj8+b
	5AJ4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4C+
	VVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkC
	FSZkZ9w5vYalYLZqxYb7X5gaGB/IdjFyckgImEi83vKXqYuRi0NIYDejxLsX7UwgCSGBT4wS
	u6dkQySA7IMTF7PDdKyZ08QKkdjJKHFn3nso5wujxL2+j2BVbAJaEo1fu5hBbBGBVkaJI8/E
	QIqYBbYxSxxYsQIsISwQJPFjXRsLiM0ioCrx/e98oGYODl4BK4k9K+0htslLrN5wAKycV0BQ
	4uTMJ2DlzEDx5q2zmSFqvnBIfJnNB2G7SCzadQPqUmGJV8e3QNlSEp/f7WWDsNMlVm6eAdWb
	I/Ft8xImCNte4sCVOSwgJzALaEqs36UPEZaVmHpqHRPEWj6J3t9PoMp5JXbMg7GVJb783cMC
	YUtKzDt2mRXC9pDYufkh2EghgViJ/v+2ExjlZyF5ZhaSZ2YhLF7AyLyKUTK1oDg3PTXZtMAw
	L7UcHq3J+bmbGMFJXstlB+ON+f/0DjEycTAeYpTgYFYS4dUt2ZEuxJuSWFmVWpQfX1Sak1p8
	iNEUGMATmaVEk/OBeSavJN7QxNLAxMzMzMTS2MxQSZy3eWdLupBAemJJanZqakFqEUwfEwen
	VAOTyWph2UVGD0z1j0+NvfvEdnGQ413ON1OnCFx4vMfJeqvN3Mp7Kx86NXwKsN+sdkziZXTt
	kesTTnswSfQ/W1W2UrvUr+Mf14yGGbL9V1cY802NfhC1Su7CI57OFPH5lz5En/srKjG9MXbJ
	wbvLF2vMuPtkX2nEE4bFtdvOlN1YvEY1xMF6apLnj5CG0sSSXn3PgKUsajzVWQ/TfU7n/lD5
	bfjrwVJLhqPcRqoTSkq8zi29HTM1wO3dCcNfq6we9H4Sbrx8ef67MN+3L8NLzveyuAo5iV1+
	s8+BVbngfu6khvO+c9YriUadC2QxkJvBY3eiVHQx3yuDqBXzeubVRsnkfzzpt9tl19/cGTOv
	1GuzKrEUZyQaajEXFScCAMosolJ7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvG537Y50g2MLlC2utP9mt5h+WNFi
	SVOGxbEJK5gtmlbfZbVY8WUmu8WqhdfYLBp6frNabHp8jdXi8q45bBZn5x1ns7iydR2LRcuf
	FhaLuy2drBZLr19ksvi7bS+jxaKtX9gtFja/ZLT4v2cHu0Xv4VqLljumFu9/bmZzEPNYvGIK
	q8eaeWsYPXbOusvusWBTqUfLkbesHptWdbJ53Lm2h81j50NLjydXpjN5bF5S79G3ZRWjx+dN
	cgE8UVw2Kak5mWWpRfp2CVwZd06vYSmYrVqx4f4XpgbGB7JdjJwcEgImEmvmNLF2MXJxCAls
	Z5Q4cm4FE0RCUuLzxXVQtrDEyn/P2SGKPjFKnLi3HyzBJqAl0fi1ixkkISLQySix98g7sCpm
	gXPMEjM/tzCCVAkLBEicWbwezGYRUJX4/nc+UBEHB6+AlcSelfYQG+QlVm84wAxi8woISpyc
	+YQFpIRZQF1i/TwhkDAzUEnz1tnMExj5ZyGpmoVQNQtJ1QJG5lWMoqkFxbnpuckFhnrFibnF
	pXnpesn5uZsYwbGpFbSDcdn6v3qHGJk4GA8xSnAwK4nw6pbsSBfiTUmsrEotyo8vKs1JLT7E
	KM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpg4pjMtu2b3EL3R9/vnl2nEvFC55TM2YSA
	my6J94qZeTt8782a/COa5zfzt5k3prcfseJ7luLkekH78Adlm03yN7mZkk1XMM56/M3uTPar
	ex8KP295FMh6s2nhnKm/5osxdX5TKq3b61nX9iT1YXNdyKerQsdqYjgT+VaEJK99GX3A6He8
	1XIWZ2vz9ffnsnQutJ2jtMajR/n7bM0NmbNmena/SZXhnfzD5alN2PFWrd0vK8Je8Blf3/b1
	x9bwBX5/Yl/s/XhNzGKZrer2uvBbUQqvGNOWb17bYhX/xT3W2q3tpEjcHY7SxiIpxtc63+us
	rinukH9y8IUFl3ej4vrW9/u/5z0wPMPHsW9quEntZSWW4oxEQy3mouJEAI4aFoM8AwAA
X-CMS-MailID: 20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5
References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>

DesignWare controller provides a vendor specific extended capability
called RASDES as an IP feature. This extended capability  provides
hardware information like:
 - Debug registers to know the state of the link or controller. 
 - Error injection mechanisms to inject various PCIe errors including
   sequence number, CRC
 - Statistical counters to know how many times a particular event
   occurred

However, in Linux we do not have any generic or custom support to be
able to use this feature in an efficient manner. This is the reason we
are proposing this framework. Debug and bring up time of high-speed IPs
are highly dependent on costlier hardware analyzers and this solution
will in some ways help to reduce the HW analyzer usage.

The debugfs entries can be used to get information about underlying
hardware and can be shared with user space. Separate debugfs entries has
been created to cater to all the DES hooks provided by the controller.
The debugfs entries interacts with the RASDES registers in the required
sequence and provides the meaningful data to the user. This eases the
effort to understand and use the register information for debugging.

This series creates a generic debugfs framework for DesignWare PCIe
controllers where other debug features apart from RASDES can also be
added as and when required.

v7:
    - Moved the patches to make finding VSEC IDs common from Mani's patchset [1]
      into this series to remove dependancy as discussed
    - Addressed style related change requests from v6

v6: https://lore.kernel.org/all/20250214105007.97582-1-shradha.t@samsung.com/
    - Addressed Niklas's comment to make vsec ID finding similar to perf
    - Minor changes in the driver to make the debugfs file common and
      not specefic to RASDES so that other developers can add debug
      related features to this file.

v5: https://lore.kernel.org/all/20250121111421.35437-1-shradha.t@samsung.com/
    - Addressed Fan's comment to split the patches for easier review
    - Addressed Bjorn's comment to fix vendor specific cap search
    - Addressed style related change requests from v4
    - Added rasdes debugfs init call to common designware files for host
      and EP.

v4: https://lore.kernel.org/lkml/20241206074456.17401-1-shradha.t@samsung.com/
    - Addressed comments from Manivannan, Bjorn and Jonathan
    - Addressed style related change requests from v3
    - Added Documentation under Documentation/ABI/testing and kdoc stype
      comments wherever required for better understanding
    - Enhanced error injection to include all possible error groups
    - Removed debugfs init call from common designware file and left it
      up to individual platform drivers to init/deinit as required.

v3: https://lore.kernel.org/all/20240625093813.112555-1-shradha.t@samsung.com/
    - v2 had suggestions about moving this framework to perf/EDAC instead of a
      controller specific debugfs but after discussions we decided to go ahead
      with the same. Rebased and posted v3 with minor style changes.

v2: https://lore.kernel.org/lkml/20231130115044.53512-1-shradha.t@samsung.com/
    - Addressed comments from Krzysztof Wilczyński, Bjorn Helgaas and
      posted v2 with a changed implementation for a better code design

v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/

[1] https://lore.kernel.org/all/20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org/

Manivannan Sadhasivam (1):
  perf/dwc_pcie: Move common DWC struct definitions to 'pcie-dwc.h'

Shradha Todi (4):
  PCI: dwc: Add helper to find the Vendor Specific Extended Capability
    (VSEC)
  Add debugfs based silicon debug support in DWC
  Add debugfs based error injection support in DWC
  Add debugfs based statistical counter support in DWC

 Documentation/ABI/testing/debugfs-dwc-pcie    | 144 +++++
 MAINTAINERS                                   |   1 +
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../controller/dwc/pcie-designware-debugfs.c  | 564 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
 .../pci/controller/dwc/pcie-designware-host.c |   6 +
 drivers/pci/controller/dwc/pcie-designware.c  |  46 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  21 +
 drivers/perf/dwc_pcie_pmu.c                   |  25 +-
 include/linux/pcie-dwc.h                      |  36 ++
 11 files changed, 837 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
 create mode 100644 include/linux/pcie-dwc.h

-- 
2.17.1


