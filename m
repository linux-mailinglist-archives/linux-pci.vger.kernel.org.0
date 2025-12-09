Return-Path: <linux-pci+bounces-42815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 674BACAEEE0
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 06:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB433062938
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 05:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365626ED3E;
	Tue,  9 Dec 2025 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sazKFdSW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43F1F4CBC;
	Tue,  9 Dec 2025 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257184; cv=none; b=e5FkBwfPjWNUAbiIgIFQqd7e7erEz0VwW5WnjgJu1ufusVdFbXc5LuSyuMRZeNP7v7iA2izeqfGvV79dsYtHlecnGiHYx0JBwdGTyH/JBELTHQcJC49Pk+B5aMTmbt7Q8bRcnqRvD10qEEQhk7/LZx+Af+mB5r8qgNOWw9MKu8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257184; c=relaxed/simple;
	bh=0UpfkC2c4D2AjDkEHDoWovoe4wrrk4/oR22Da28ye+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frmlXU28SsV4cgZ1zAld3l8FVj7L/bZHLMT1SXxvolIclAREK7LTDl+jPkcq6e1mfKfyznN2bAqc2tYdbb10YLa+oI2ie7pxz+eQsrCXfX94pWbi3vcstcpGc1zIPZ9Kh0+wL0qvqAGPI0aKY5FufqEozBubQOW8CEqSX/ER0iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sazKFdSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F5DC4CEF5;
	Tue,  9 Dec 2025 05:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765257183;
	bh=0UpfkC2c4D2AjDkEHDoWovoe4wrrk4/oR22Da28ye+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sazKFdSWa0wMtDxy+VTYLX992oV+EjaZ4V9qMKEdH/u2iWcnXKlaN3QOSLdC3rTXS
	 V7i/ydbAZEOzKSABfnWoTg3t5CAD17TT79+d+YZt3Y48MEWjg9BXyRHGyEZ7aPm08f
	 jS3CnhgQVfhoNBApnFvzWyIAyetvMFf1xi967Bhocjm8A9EgdcJyUDij7x8/EbN1LG
	 DjBx+gElwCa29Z1FOOUKV1r/Qi83i3DOZY7wDSFg8CXDc7+VcMvyYPt/gPgfVSYTam
	 ja22DJiLlZ9b+6oRfO0VGbQndTjI4i3+zW6dNr689TKzCpPL1/F/B53fmjVteea7AA
	 Wc7tfA5ejyUZw==
Date: Tue, 9 Dec 2025 14:12:59 +0900
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Make Link Up IRQ logic handle already
 powered on PCIe switches
Message-ID: <aTev28wihes6iJqs@dhcp-10-89-81-223>
References: <20251201063634.4115762-2-cassel@kernel.org>
 <f1059d5d-3fa5-423a-8093-0e99b65d5f4c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1059d5d-3fa5-423a-8093-0e99b65d5f4c@oss.qualcomm.com>

Hello Krishna,

Currently:
For controllers with Link Up IRQ support, the pci_host_probe() call (which
will perform PCI Configuration Space reads) is done without any of the
delays mandated by the PCIe specification.

This seems quite bad.

A device might not be fully initialized during during the time of these
PCI Configuration Space reads, but might still return some bogus values
that are actually different from the Configuration Space reads if done
after respecting the delays mandated by the PCIe specification.

I think the options are:
1) Keep the pci_host_probe() call in dw_pcie_host_init() for controllers
   with Link Up IRQ support, but make sure that we respect the delays also
   in this case.
or
2) Remove the pci_host_probe() call from dw_pcie_host_init(), and make sure
   that pci_host_probe() is done by the first Link Up IRQ
   (i.e. what this patch does).


One big thing with using the Link Up IRQ is to not do any delay during PCIe
controller driver's probe(), which reduces startup time, exactly as your
commit message in commit 36971d6c5a9a ("PCI: qcom: Don't wait for link if
we can detect Link Up") explains.
Therefore, I don't think that 1) is a good solution, so that leaves us with
2).


If pwrctrl drivers are created as part of the pci_host_probe() call,
I think that perhaps an alternative would be to create an explict
pwrctrl_init() function, and let the PCI controller drivers that actually
use pwrctrl call that from their probe().
(And just remove the same from pci_host_probe() ?)

In fact, looking at your suggested patches (that hasn't landed yet):
[PATCH 3/5] PCI/pwrctrl: Add APIs for explicitly creating and destroying pwrctrl devices
[PATCH 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs

https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-5-78a72627683d@oss.qualcomm.com/
https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-3-78a72627683d@oss.qualcomm.com/

Seem to do exactly that:
Call pci_pwrctrl_create_devices() explicitly from the PCIe controller drivers
directly, and removes the pci_pwrctrl_create_device() call from pci_host_probe().

So I don't really understand your concern with this series, at least not if
it goes on top of your series:
https://lore.kernel.org/linux-pci/20251124-pci-pwrctrl-rework-v1-0-78a72627683d@oss.qualcomm.com/


Kind regards,
Niklas

