Return-Path: <linux-pci+bounces-16109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606259BE21B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 10:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835241C23122
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702D51D9339;
	Wed,  6 Nov 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6YU4Ku6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069B1D9329;
	Wed,  6 Nov 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884533; cv=none; b=f62hp4xkf7ZWPUxw+016rUtprF5U+WhTrjLqnOytDx53PGefD8AG7msMYkMNxqbBzwCKZx+eGc1YUDXFk4WPQ1xyUnLzLxmUsy9VL+K/3Vyi5BYeAMJAHXPxiLc5NGVB7SKLluZpwyRzZ50Ks+jnneqHOqqSPN7zpHd6hFYvNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884533; c=relaxed/simple;
	bh=EwAJq0GjySd0IJ1U4/MaQRX0fXrzwNh3orlaf6pjFQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXWi2PcGjhEV4cZHArjfpKlrlR17MTw8dYvo0xNOwE9Dj7JedOhnSELxXO++IsHS6R6Sp/XHkP2itCymqimJ8tpNqZE+5n5NZs4BgTEoiBQ0GYaaKrwX4PtFXk5hqR/QMvH6Hwj9QfaAluHXdo552JogBHsEeg7dvDOkdogMsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6YU4Ku6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3742C4CECD;
	Wed,  6 Nov 2024 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730884532;
	bh=EwAJq0GjySd0IJ1U4/MaQRX0fXrzwNh3orlaf6pjFQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6YU4Ku6I+ni7xq3vLu1huym1FyGpwUtUsFP63qGYPPMcZSYcOAPNCOAGyE2tnOD+
	 kFp9NuFnyTUGRaydRbvD6qlYt/52XljzLEIsUrpcqHk+nPE70OuiwTo9TX7Gl3FnqQ
	 nCgWygWxFML+BPzrzkG/5Ou5wfHWMigdLdOr4szqgDNxLDipbfMtd5yIHquZirXFMh
	 2e864SNAHbTFdfVNTWpOhIsAHXpd9REuWS66FGdKYT2QIkIj/0cLXkGe20zTwectbe
	 5HjavNReU71zkSJRIlq0SxnPawGfkgQLd0z1hcltKYl19B2IsLUTWRTWJtf9zMKHbn
	 9phjPbWRwVi5g==
Date: Wed, 6 Nov 2024 10:15:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
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
Message-ID: <Zyszr3Cqg8UXlbqw@ryzen>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>

Hello Frank,

On Thu, Oct 31, 2024 at 12:26:59PM -0400, Frank Li wrote:
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> 
> This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
> 
> Original patch only target to vntb driver. But actually it is common
> method.
> 
> This patches add new API to pci-epf-core, so any EP driver can use it.
> 
> Previous v2 discussion here.
> https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/
> 
> Changes in v4:
> - Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
> - Use new method to avoid compatible problem.
>   Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
>   pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
> remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
> driver don't support new command, so failure return, not side effect.
>   After test, DOORBELL_DISABLE command send out to recover original map, so
> pcitest bar test can pass as normal.
> - Other detail change see each patches's change log
> - Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com
> 
> Change from v2 to v3
> - Fixed manivannan's comments
> - Move common part to pci-ep-msi.c and pci-ep-msi.h
> - rebase to 6.12-rc1
> - use RevID to distingiush old version
> 
> mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
> echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
> echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
> echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
> echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
> ^^^^^^ to enable platform msi support.
> ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

Perhaps drop these steps, to not confuse the reader.
They are no longer relevant with the latest revision anyway.

> 
> - use new device ID, which identify support doorbell to avoid broken
> compatility.
> 
>     Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
>     keep the same behavior as before.
> 
>            EP side             RC with old driver      RC with new driver
>     PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
>     Other device ID             doorbell disabled*       doorbell disabled*
> 
>     * Behavior remains unchanged.
> 
> Change from v1 to v2
> - Add missed patch for endpont/pci-epf-test.c
> - Move alloc and free to epc driver from epf.
> - Provide general help function for EPC driver to alloc platform msi irq.
> - Fixed manivannan's comments.

I wanted to try this series on rk3588, which has a MSI controller as part of the GIC
using Interrupt Translation Services (ITS), for the Root Complex DT node:
https://github.com/torvalds/linux/blob/v6.12-rc6/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi#L164
https://github.com/torvalds/linux/blob/v6.12-rc6/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi#L1981-L1999

There isn't any reference to a MSI controller in the Endpoint DT node:
https://github.com/torvalds/linux/blob/v6.12-rc6/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi#L189

When testing your series, I get an error in
platform_device_msi_init_and_alloc_irqs(), because no domain is found.

I assume that is it "msi-parent" that we should add here.

However, looking at:
$ git grep -p msi-parent arch/arm64/boot/dts/freescale/

I do not see any freescale/iMX platform specifying a msi-parent for the EP node.

Is there any additional DTS changes needed for iMX that is not part of this series,
or what am I missing?

When adding "msi-parent = <&its1 0x0000>;
to the EP node
(this is just a guess since RC node has: msi-map = <0x0000 &its1 0x0000 0x1000>;)

I do get a domain, but I do not get any IRQ on the EP side when the RC side is
writing the doorbell (as part of pcitest -B),

[    7.978984] pci_epc_alloc_doorbell: num_db: 1
[    7.979545] pci_epf_test_bind: doorbell_addr: 0x40
[    7.979978] pci_epf_test_bind: doorbell_data: 0x0
[    7.980397] pci_epf_test_bind: doorbell_bar: 0x1
[   21.114613] pci_epf_enable_doorbell db_bar: 1
[   21.115001] pci_epf_enable_doorbell: doorbell_addr: 0xfe650040
[   21.115512] pci_epf_enable_doorbell: phys_addr: 0xfe650000
[   21.115994] pci_epf_enable_doorbell: success

# cat /proc/interrupts | grep epc
117:          0          0          0          0          0          0          0          0  ITS-pMSI-a40000000.pcie-ep   0 Edge      pci-epc-doorbell0

Even if I try to write the doorbell manually from EP side using devmem:

# devmem 0xfe670040 32 1

it still doesn't trigger a IRQ on the EP side:
# cat /proc/interrupts | grep epc
117:          0          0          0          0          0          0          0          0  ITS-pMSI-a40000000.pcie-ep   0 Edge      pci-epc-doorbell0

Any ideas?


Kind regards,
Niklas

