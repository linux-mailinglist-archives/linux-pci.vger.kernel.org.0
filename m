Return-Path: <linux-pci+bounces-26758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B46A9CAC6
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7244C83C9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F3F61FF2;
	Fri, 25 Apr 2025 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVkHX+kq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03C78F4B;
	Fri, 25 Apr 2025 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588837; cv=none; b=iy77VImQMuM8zFHSOvbpeDKjUQa7nE4pvVwCzO5+yYXbv+atjO5hz3BvPyYj7fqxnXO0CxLi9FX26tZgfObdZhDFqC8Oy80CyyFXkM8mP/uw9rdYR3fhLqzvuBxZewlMVfWWsOIwqFNRCNKI2fPi4O+4edaE3exZaQ0XS6UPQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588837; c=relaxed/simple;
	bh=qi5h6vjHGkHHkMx48KdWOPGfCyT72085egpIwqt06EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE3+Z6Ix4Lh8k6q+/TmfGVmOXPdjWCSseHfHpC9/Hvg/myHennu+RWiMEkYT58WRU3oXG0NEsonm4qhvsuEL6DWS4IJaEld7rBgDsAPywK6gHvnixq0jyKMD2QZJ+9aW5a2DWaP6/fBYN7xzg7OjDOHemyiAI6+e1y+sAYpfSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVkHX+kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C85DC4CEE4;
	Fri, 25 Apr 2025 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745588837;
	bh=qi5h6vjHGkHHkMx48KdWOPGfCyT72085egpIwqt06EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVkHX+kql50+epGydmhjz+95MQSE8WEDlV87c70IY7HI4V1UG99qCiZRm1luxGYeO
	 BVUaapBHvKfebXlGIwSGgPRO1pnmU00p2MUxCjvBFZEvNQ0Wke+4d9nmwMNwSkqjeK
	 7DvdYe2JdWwvsenW+3ms5MsvBk4A7gUXIGS614Xh0d3FeRP9g+JidG4w5MUU5wef+B
	 u7JuJ2bVjV1wS5LpFglBj3eelV/u0rhDOWAQqec5PEBdJELIg64PiO6k90NX4ZRriR
	 drDucaxBTBnQHYnuTN84bbCm6mX7qLCkKbxUde4DshAfnex+OCWaQYmKoHHZgOyCvw
	 eF4uPsyzoOzqA==
Date: Fri, 25 Apr 2025 15:47:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, thomas.petazzoni@bootlin.com,
	manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/2] PCI: Configure root port MPS to hardware maximum
 during host probing
Message-ID: <aAuSXhmRiKQabjLO@ryzen>
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-2-18255117159@163.com>
 <aAtikPOYlGeJCsiA@ryzen>
 <a4963173-dd9a-4341-b7f9-5fdb9485233a@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4963173-dd9a-4341-b7f9-5fdb9485233a@163.com>

Hello Hans,

On Fri, Apr 25, 2025 at 06:56:53PM +0800, Hans Zhang wrote:
> 
> But I discovered a problem:
> 
> 0001:90:00.0 PCI bridge: Device 1f6c:0001 (prog-if 00 [Normal decode])
>          ......
>          Capabilities: [c0] Express (v2) Root Port (Slot-), MSI 00
>                  DevCap: MaxPayload 512 bytes, PhantFunc 0
>                          ExtTag- RBE+
>                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                          RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                          MaxPayload 512 bytes, MaxReadReq 1024 bytes
> 
> 
> 
> 			Should the DevCtl MaxPayload be 256B?
> 
> But I tested that the file reading and writing were normal. Is the display
> of 512B here what we expected?
> 
> Root Port 0003:30:00.0 has the same problem. May I ask what your opinion is?
> 
> 
> 		......
> 0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
> NVMe SSD Controller PM9A1/PM9A3/980PRO (prog-if 02 [NVM Express])
>          ......
>          Capabilities: [70] Express (v2) Endpoint, MSI 00
>                  DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                          ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> SlotPowerLimit 0W
>                  DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> FLReset-
>                          MaxPayload 256 bytes, MaxReadReq 512 bytes
> 		......

Here we see that the bridge has a higher DevCtl.MPS than the DevCap.MPS of
the endpoint.

Let me quote Bjorn from the previous mail thread:

"""
  - I don't think it's safe to set MPS higher in all cases.  If we set
    the Root Port MPS=256, and an Endpoint only supports MPS=128, the
    Endpoint may do a 256-byte DMA read (assuming its MRRS>=256).  In
    that case the RP may respond with a 256-byte payload the Endpoint
    can't handle.
"""



I think the problem with this patch is that pcie_write_mps() call in
pci_host_probe() is done after the pci_scan_root_bus_bridge() call in
pci_host_probe().

So pci_configure_mps() (called by pci_configure_device()),
which does the limiting of the bus to what the endpoint supports,
is actually called before the pcie_write_mps() call added by this patch
(which increases DevCtl.MPS for the bridge).


So I think the code added in this patch needs to be executed before
pci_configure_device() is done for the EP.

It appears that pci_configure_device() is called for each device
during scan, first for the bridges and then for the EPs.

So I think something like this should work (totally untested):

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -45,6 +45,8 @@ struct pci_domain_busn_res {
        int domain_nr;
 };
 
+static void pcie_write_mps(struct pci_dev *dev, int mps);
+
 static struct resource *get_pci_domain_busn_res(int domain_nr)
 {
        struct pci_domain_busn_res *r;
@@ -2178,6 +2180,11 @@ static void pci_configure_mps(struct pci_dev *dev)
                return;
        }
 
+       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+           pcie_bus_config != PCIE_BUS_TUNE_OFF) {
+               pcie_write_mps(dev, 128 << dev->pcie_mpss);
+       }
+
        if (!bridge || !pci_is_pcie(bridge))
                return;



But we would probably need to move some code to avoid the
forward declaration.


Kind regards,
Niklas

