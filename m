Return-Path: <linux-pci+bounces-32521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D018B0A0A8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 12:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51ED6A8485C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54122957A0;
	Fri, 18 Jul 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOF4Nqqm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E84221297;
	Fri, 18 Jul 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834524; cv=none; b=lbKchX05X0DVTG7DMRb5yKMxfaDwRDzlkuM6chIWpvmF9TV4udW7pAYUVi6Hp4dM9wl/3pOmkbDO6HBqH0F4WtBAchA2d0Dnv/3r5dKi3hcl2u/SvMqLc0oL0Jow6VQymjT+D6zPgIk0LdS8Y9FhxIWqE0vwUXoizjYXXTXLKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834524; c=relaxed/simple;
	bh=mLEIXOd7eZdISffuLnCpahYVvfWHAggJn8bBD65Jk+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQsS2nA6hs5tKAKOyQ33LRHC+IyVY7nedVQQhH19RMi509S+nuKFl4JeXhh3Z1rsNW58sFWz46W2bmjnR/ja//9MpR+Bzz4W9pG+7nf11O2mA2JyyWoN3ETnQ1udcKNwdRJbb5TzI/sHiKuKKPTn/pR7dRwFG4UPe68Z5Dhb5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOF4Nqqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F19AC4CEEB;
	Fri, 18 Jul 2025 10:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752834524;
	bh=mLEIXOd7eZdISffuLnCpahYVvfWHAggJn8bBD65Jk+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOF4Nqqmy62wOTE6iyDUN+If8Qx8CfTpC+N5PVoQWCe5WQhj+WWHU6Tyv3hi9eNhr
	 FIoXTkuUWVi3cRj6W8FENzyay4s+zTghm5Vc8MYJeCWKF0Bw2h413GvxFcYuAR9NAR
	 AsrElcNhPyoTnVlsCVCrQaopu97MxZTemFopAhXFV4BOoUGeXjbUQVsadiEe+JLuav
	 yW4WCznBsJ0bxTwTsqy3Tg/wFN93AxwPEFWVFLdH8LZz/8Qm3JTU1utMKG2qb9dBji
	 6qVErsWOPsaWploLev2unOE7h5UtBN5Bu1SJAkGsv/Rx6PACnsIUF3Gl6VH3Kjssvn
	 2XjO0g8ZNrKhw==
Date: Fri, 18 Jul 2025 12:28:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
Message-ID: <aHoh1XfhR8EB_5yY@ryzen>
References: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>

On Tue, Jul 15, 2025 at 07:51:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Testing
> -------
> 
> I've lost access to my test setup now. So Krishna (Cced) will help with testing
> on the Qcom platform and Wilfred or Niklas should be able to test it on Rockchip
> platform. For the moment, this series is compile tested only.


Since this patch series implements two things:

1) Testing sysfs initiated reset:

selftests before sysfs initiated reset:
# FAILED: 14 / 16 tests passed.

# echo 1 > /sys/bus/pci/devices/0000:01:00.0/reset

[  145.567748] pci-endpoint-test 0000:01:00.0: resetting
[  145.638755] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x3
[  145.639472] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x230011
[  145.640063] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!
[  145.682612] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
[  145.683162] rockchip-dw-pcie a40000000.pcie: Root Port reset completed
[  145.810852] pci-endpoint-test 0000:01:00.0: reset done

selftests after sysfs initiated reset:
# FAILED: 14 / 16 tests passed.

(Without this patch series: # FAILED: 7 / 16 tests passed.)

So for this part:
Tested-by: Niklas Cassel <cassel@kernel.org>




2) Testing link down reset:

selftests before link down reset:
# FAILED: 14 / 16 tests passed.

## On EP side:
# echo 0 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start && \
  sleep 0.1 && echo 1 > /sys/kernel/config/pci_ep/controllers/a40000000.pcie-ep/start


[  111.137162] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x4
[  111.137881] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x0
[  111.138432] rockchip-dw-pcie a40000000.pcie: hot reset or link-down reset
[  111.139067] pcieport 0000:00:00.0: Recovering Root Port due to Link Down
[  111.139686] pci-endpoint-test 0000:01:00.0: AER: can't recover (no error_detected callback)
[  111.255407] rockchip-dw-pcie a40000000.pcie: PCIe Gen.3 x4 link up
[  111.256019] rockchip-dw-pcie a40000000.pcie: Root Port reset completed
[  111.383401] pcieport 0000:00:00.0: Root Port has been reset
[  111.384060] pcieport 0000:00:00.0: AER: device recovery failed
[  111.384582] rockchip-dw-pcie a40000000.pcie: PCIE_CLIENT_INTR_STATUS_MISC: 0x3
[  111.385218] rockchip-dw-pcie a40000000.pcie: LTSSM_STATUS: 0x230011
[  111.385771] rockchip-dw-pcie a40000000.pcie: Received Link up event. Starting enumeration!
[  111.390866] pcieport 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[  111.391650] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01

Basically all tests timeout
# FAILED: 1 / 16 tests passed.

Which is the same as before this patch series.

So AFAICT, this part does not seem to work as advertised.

Instead of quickly stopping and starting the link, I also tried to reboot the
EP board, which does the configfs writes and starts the link automatically on
boot, but that had the same result as quickly stopping and starting the link.


Kind regards,
Niklas

