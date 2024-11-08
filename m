Return-Path: <linux-pci+bounces-16296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F187B9C12E2
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 01:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0521C22647
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 00:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B2064A;
	Fri,  8 Nov 2024 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFmd+SSv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1118D;
	Fri,  8 Nov 2024 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024452; cv=none; b=cSvmwLtq904NWE8lyWmqgI3ZQE8WWDrcu/MYZ67WeaJf4aDIuc29he8T4aQ9hYuvwGGvWNzGgQzUwqWOi5q+F10d76doEJhQPbihnLPSdZPk8K0RLcNqkYaMwb2xbvGZarq4GEvHgucQh8I8uO29d2HV7OB/aAqWvkIbH78Msts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024452; c=relaxed/simple;
	bh=E8wrGDQZfr/KqviCWotyEkZrNSzpIQ82LrZTy3eVBtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBMeZgIQEd3qIi45tfqCPXZoAAEwyH3yWQL6vWw+ue9p2LBAbv3JiklnyNJ5+9jkOOUg8tdgnmypOkfmIT7tMnC7e17FcqvazVswv8mDft+R0+0z1XHtI9HLvB6/72ecwE416hlBt49efMvH5ZU6PRjJveyaiYKx9ByiepogqCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFmd+SSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679C3C4CECC;
	Fri,  8 Nov 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731024452;
	bh=E8wrGDQZfr/KqviCWotyEkZrNSzpIQ82LrZTy3eVBtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFmd+SSva8DTBKOo4BeYPtCk7o04LmO7pDTtI/fqG52qn6wZmrxdJtkPZC7Y/B4JR
	 /gnDL8Pbl6D5wwwBltdym09x5Pw4fLQIIZReMUNu436NkGGbDKWSdwnJ/rKMFr90CB
	 DKDM1CvxiJ0WcAU5TXzS0pVzCp2SJe7HFXwjLYXo7/G9pGsg7Ytp75ccYRSG3DK9QZ
	 DznodR+yjp6050DH0kDI5/HWAoGYJgcsz+bKYHSJ8P8OCK+SAFu/p3BGRPGczevZGI
	 TbPBun3gfEkcH6jV/6t2z5ADJ7W3HjHKPlgxsgZcVb2bninuwk2Zpn8GVcJUN0/DJB
	 +fARxQDe3Rbpw==
Date: Fri, 8 Nov 2024 01:07:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v4 0/5] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Message-ID: <Zy1WPo-W6l0ZcSoa@ryzen>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <Zyszr3Cqg8UXlbqw@ryzen>
 <Zys4qs-uHvISaaPB@ryzen>
 <ZyujpT+4bd7TwbcM@lizhi-Precision-Tower-5810>
 <ZywCXOjuTTiayIxd@ryzen>
 <ZywMxnij3wZ9PGmj@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZywMxnij3wZ9PGmj@lizhi-Precision-Tower-5810>

On Wed, Nov 06, 2024 at 07:41:42PM -0500, Frank Li wrote:
> >
> > So there does seem to be something wrong with the inbound translation,
> > at least when testing on rk3588 which only uses 1MB fixed size BARs:
> > https://github.com/torvalds/linux/blob/v6.12-rc6/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L276-L281
> >
> 
> It should be fine.  Some hardware many append some stream id bits before
> send to ITS.

Some more debugging with the IOMMU on.

EP side start:
[   14.601081] pci_epc_alloc_doorbell: num_db: 1
[   14.601588] pci_epf_test_bind: doorbell_addr: 0xf040 (align: 0x10000)
[   14.602162] pci_epf_test_bind: doorbell_data: 0x0
[   14.602573] pci_epf_test_bind: doorbell_bar: 0x1


When RC side does:
pcitest -B
[  109.252900] COMMAND_ENABLE_DOORBELL complete - status: 0x440
[  109.253406] db_bar: 1 addr: 0xf040 data: 0x0
[  109.254094] writing: 0x0 to offset: 0xf040 in BAR: 1
[  119.268887] we wrote to the BAR, status is now: 0x0

EP side results in:
[  117.894997] pci_epf_enable_doorbell db_bar: 1
[  117.895399] pci_epf_enable_doorbell: using doorbell_addr: 0xffffff9ff040
[  117.896517] pci_epf_enable_doorbell: phys_addr: 0xffffff9f0000
[  117.897037] dw_pcie_ep_set_bar: set_bar: bar: 1 phys_addr: ffffff9f0000 flags: 0x0 size: 0x100000
[  117.898504] pci_epf_enable_doorbell: success
[  118.912433] arm-smmu-v3 fc900000.iommu: event 0x10 received:
[  118.912965] arm-smmu-v3 fc900000.iommu:      0x0000000000000010
[  118.913508] arm-smmu-v3 fc900000.iommu:      0x0000020000000000
[  118.914018] arm-smmu-v3 fc900000.iommu:      0x0000ffffff90f040
[  118.914534] arm-smmu-v3 fc900000.iommu:      0x0000000000000000

Looking at the doorbell_addr, it seems to be a IOMMU address already.

If we look at the ARM SMMU-v3 specification, event 0x10 is:
Translation fault: The address provided to a stage of translation failed the
range check defined by TxSZ/SLx, the address was within a disabled TTBx, or a
valid translation table descriptor was not found for the address.

for event F_TRANSLATION:
0x0000ffffff90f040
is input address.

StreamID is: 0x0, so that looks as expected for rk3588.
(And if the SteamID was incorrect, I would have expected a C_BAD_STREAMID
event instead.)


Comparing the address of the IOMMU error:
0xffffff90f040
with the doorbell addr:
0xffffff9ff040
XOR value:
0x0000000f0000

We can see that they are not identical.


When RC side does:
devmem $((0xf0400000+0xf040)) 32 0
it results in the exact same IOMMU error on the EP side as the one above.

However, if I manually append the XOR value:
devmem $((0xf0400000+0xf040+0xf0000)) 32 0

I can see on the EP side:
[  631.399530] pci_epf_doorbell_handler
[  631.399850] pci_epf_test_doorbell



So why is the inbound translation incorrect?

Like I told you earlier, rk3588 has fixed size 1MB BARs,
so the BAR_MASK will be:
~(SZ_1M-1)
0xfff00000

So the physical address that you write in the iATU:
0xffffff9f0000
will actually be:
0xfffffff00000
after reading back the same register from the iATU,
since the lower bits will be masked away.

I'm guessing that you would need to do something like:
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e5b6a65e3e16f..0ab5d61bf0493 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -675,6 +675,9 @@ static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_ep
                return;
        }
 
+       if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
+               align = max(epf_test->epc_features->bar[bar].fixed_size, align);
+
        msg = &epf->db_msg[0].msg;
        doorbell_addr = msg->address_hi;
        doorbell_addr <<= 32;
@@ -1016,15 +1021,22 @@ static int pci_epf_test_bind(struct pci_epf *epf)
                struct msi_msg *msg = &epf->db_msg[0].msg;
                u32 align = epc_features->align;
                u64 doorbell_addr;
+               enum pci_barno bar;
+
+               bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
 
                align = align ? align : 128;
+               if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
+                       align = max(epf_test->epc_features->bar[bar].fixed_size,
+                                   align);
+
                doorbell_addr = msg->address_hi;
                doorbell_addr <<= 32;
                doorbell_addr |= msg->address_lo;
 
                reg->doorbell_addr = doorbell_addr & (align - 1);
                reg->doorbell_data = msg->data;
-               reg->doorbell_bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
+               reg->doorbell_bar = bar;
        }
 
        return 0;



I tested the above on top of your series, and now
pcitest -B
works as expected :) yay!


Kind regards,
Niklas

