Return-Path: <linux-pci+bounces-7083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0910C8BBD55
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 19:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B388E2825C6
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D755A788;
	Sat,  4 May 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6GU0mNS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B981E871
	for <linux-pci@vger.kernel.org>; Sat,  4 May 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714842346; cv=none; b=i4piCcr5p4epGl7SU0zTgHkNOa1DZtMm5yo+NzSySC9SrsVdmjTmnxugA2tDzCLc3vPUrzXvyA4+Vhsj5pt5y7VkKgJPHLFoEeu7du+qZM4KBxx3bNECi3buCILhvbI4Faht7HEJjaQJliJTcvBG2lACRqU8VbhUMW4d70KFtks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714842346; c=relaxed/simple;
	bh=gUdfwYP50T/6/WAzHJaKoSsAEwx02m/3tQKnaZDkEZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+vRr4LU33FS5S8xixyhR+5sJVayh4wdukBGzhvSaqrcNNFlu/FgIHxAu3m2ARqJvna/TlhjeuYn1vK7nMv7wos/MRsuMdnftcGIHUC3rpJ4RWnsQYRToPuV9aQ66uZ9HZHf4eyoDmyD8YBiIuMCokRQwQJT1iBWrscEpiDtGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U6GU0mNS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4302187c0so2318193b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2024 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714842344; x=1715447144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gEDQu0iPediq8YknFSqatkKh/zmK51CAx7luQ6oOIuI=;
        b=U6GU0mNS+f/IrBE3EfTXhy8tyU+da16vciLPF2qwbbadKPXzRymza7rtXTsF9mpEjc
         1+S03r25OxXchEpdafr2w/aF5NoLftCptIHRtqzGS1dgYhVKE5VDv25nzxnAw9/Eme3k
         upEt4iyf0sd76jEs5FeyfHHTYXi87fZBTZL1PiEXhzlzpMXjIrdZEHGj4XFJY2YO9PCb
         kGsE+5v5Trrxf9i/60kkMGnw1pgLAx+YSBnwVJc8kgPNQmy1c/18uMSbpTigzjASN00F
         nmOk1Ad0EmPovviZPW2pdidDwmgKhUNS2Cr5wf2d+hz5YzJd1ysVH15FckP/9PmhNYNT
         YnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714842344; x=1715447144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEDQu0iPediq8YknFSqatkKh/zmK51CAx7luQ6oOIuI=;
        b=n7d4ZxiobYroVGS8ylZ9zl+V0lnVuZ/zjB8/7ylJsbauSdWolPmInnf4eJmvokpvx+
         S+yVbYZO/SJhSD+okHRQemt2StqKaR109p7AQgyKgBwIxJacdM8XjPG5NoWVViry9NO5
         1coNHxfmQsJUF960elCYuecF/WDSZNPx6URcLxMe17sWZaIyZvW+IPXCHFuabGsRfxrO
         EYpZhhvJjI0vjwSxaTdqAgDOjeUBpUCqzzVMGwwrevcLkaN10O7phCnt6xAA37YjHomA
         UK1PpypN9E3GZYES4KUDpjvSj+dxxhVF5+I1hm7vbZAgknxSYsO2LceXoKdKkm2g/mQ4
         rnOA==
X-Forwarded-Encrypted: i=1; AJvYcCV3qocyllgQlwRESThIGQhQ6UlXi1bfo7TX4yGBtBwXe7MWzYn+D351ineWYVNmFvYxygSxDw+LZ/9qr8LKDN30+F6Sa1RYMrjY
X-Gm-Message-State: AOJu0YxeQMVQ1LrR1HZ+gspLTWRT/2L16Hhtham1+C7DD83zgNEOwecJ
	CCEkku97Nag530Tx74QhWo9i42/FVbsg5SUHja4ZBpvfJWMeOZthtwQ69B3rZg==
X-Google-Smtp-Source: AGHT+IGC5O/fHtMu8vfsIig8UHsJIDaY4Sv/TdqE0tlvGnhwz9JOZiv6XL60PFyhbBkXJAL8czdYlg==
X-Received: by 2002:a05:6a20:1014:b0:1af:672c:3d8a with SMTP id gs20-20020a056a20101400b001af672c3d8amr5576097pzc.31.1714842344114;
        Sat, 04 May 2024 10:05:44 -0700 (PDT)
Received: from thinkpad ([220.158.156.237])
        by smtp.gmail.com with ESMTPSA id m8-20020a634c48000000b0061ea00c2aefsm2605002pgl.55.2024.05.04.10.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 10:05:43 -0700 (PDT)
Date: Sat, 4 May 2024 22:35:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 00/14] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <20240504170537.GC4315@thinkpad>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>

On Tue, Apr 30, 2024 at 02:00:57PM +0200, Niklas Cassel wrote:
> Hello all,
> 
> This series adds PCIe endpoint mode support for the rockchip rk3588 and
> rk3568 SoCs.
> 
> This series is based on: pci/next
> (git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git)
> 
> This series has the following dependencies:
> 1) https://lore.kernel.org/linux-pci/20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org/
> The series in 1) has not been merged to pci/next yet.
> 
> 2) https://lore.kernel.org/linux-phy/20240412125818.17052-1-cassel@kernel.org/
> The series in 2) has already been merged to phy/next.
> 
> Even though this series (the series in $subject) has a runtime dependency
> on the changes that are currently queued in the PHY tree, there is no need
> to coordinate between the PCI tree and the PHY tree (i.e. this series can
> be merged via the PCI tree even for the coming merge window (v6.10-rc1)).
> 
> This is because there is no compile time dependency between the changes in
> the PHY tree and this series. Likewise, the device tree overlays in this
> series passes "make CHECK_DTBS=y" even without the changes in the PHY tree.
> 
> This series (including dependencies) can also be found in git:
> https://github.com/floatious/linux/commits/rockchip-pcie-ep-v2
> 
> Testing done:
> This series has been tested with two rock5b:s, one running in RC mode and
> one running in EP mode. This series has also been tested with an Intel x86
> host and rock5b running in EP mode.
> 
> BAR4 exposes the ATU Port Logic Structure and the DMA Port Logic Structure

Is this for configuring the EP from host? Just curious.

> to the host. The EPC controller driver thus disables this BAR as init time,
> because if it doesn't, when the host writes the test pattern to this BAR,
> all the iATU settings will get wiped, resulting in all further BAR accesses
> being non-functional.
> 
> Running pcitest.sh (modified to also perform the READ and WRITE tests with
> the -d option, i.e. with DMA enabled) results in the following:
> 
> $ /usr/bin/pcitest.sh
> BAR tests
> 
> BAR0:           OKAY
> BAR1:           OKAY
> BAR2:           OKAY
> BAR3:           OKAY
> BAR4:           NOT OKAY
> BAR5:           OKAY
> 
> Interrupt tests
> 
> SET IRQ TYPE TO LEGACY:         OKAY
> LEGACY IRQ:     NOT OKAY
> SET IRQ TYPE TO MSI:            OKAY
> MSI1:           OKAY
> MSI2:           OKAY
> MSI3:           OKAY
> MSI4:           OKAY
> MSI5:           OKAY
> MSI6:           OKAY
> MSI7:           OKAY
> MSI8:           OKAY
> MSI9:           OKAY
> MSI10:          OKAY
> MSI11:          OKAY
> MSI12:          OKAY
> MSI13:          OKAY
> MSI14:          OKAY
> MSI15:          OKAY
> MSI16:          OKAY
> MSI17:          OKAY
> MSI18:          OKAY
> MSI19:          OKAY
> MSI20:          OKAY
> MSI21:          OKAY
> MSI22:          OKAY
> MSI23:          OKAY
> MSI24:          OKAY
> MSI25:          OKAY
> MSI26:          OKAY
> MSI27:          OKAY
> MSI28:          OKAY
> MSI29:          OKAY
> MSI30:          OKAY
> MSI31:          OKAY
> MSI32:          OKAY
> 
> SET IRQ TYPE TO MSI-X:          OKAY
> MSI-X1:         OKAY
> MSI-X2:         OKAY
> MSI-X3:         OKAY
> MSI-X4:         OKAY
> MSI-X5:         OKAY
> MSI-X6:         OKAY
> MSI-X7:         OKAY
> MSI-X8:         OKAY
> MSI-X9:         OKAY
> MSI-X10:                OKAY
> MSI-X11:                OKAY
> MSI-X12:                OKAY
> MSI-X13:                OKAY
> MSI-X14:                OKAY
> MSI-X15:                OKAY
> MSI-X16:                OKAY
> MSI-X17:                OKAY
> MSI-X18:                OKAY
> MSI-X19:                OKAY
> MSI-X20:                OKAY
> MSI-X21:                OKAY
> MSI-X22:                OKAY
> MSI-X23:                OKAY
> MSI-X24:                OKAY
> MSI-X25:                OKAY
> MSI-X26:                OKAY
> MSI-X27:                OKAY
> MSI-X28:                OKAY
> MSI-X29:                OKAY
> MSI-X30:                OKAY
> MSI-X31:                OKAY
> MSI-X32:                OKAY
> 
> Read Tests
> 
> SET IRQ TYPE TO MSI:            OKAY
> READ (      1 bytes):           OKAY
> READ (   1024 bytes):           OKAY
> READ (   1025 bytes):           OKAY
> READ (1024000 bytes):           OKAY
> READ (1024001 bytes):           OKAY
> 
> Write Tests
> 
> WRITE (      1 bytes):          OKAY
> WRITE (   1024 bytes):          OKAY
> WRITE (   1025 bytes):          OKAY
> WRITE (1024000 bytes):          OKAY
> WRITE (1024001 bytes):          OKAY
> 
> Copy Tests
> 
> COPY (      1 bytes):           OKAY
> COPY (   1024 bytes):           OKAY
> COPY (   1025 bytes):           OKAY
> COPY (1024000 bytes):           OKAY
> COPY (1024001 bytes):           OKAY
> 
> Read Tests DMA
> 
> READ (      1 bytes):           OKAY
> READ (   1024 bytes):           OKAY
> READ (   1025 bytes):           OKAY
> READ (1024000 bytes):           OKAY
> READ (1024001 bytes):           OKAY
> 
> Write Tests DMA
> 
> WRITE (      1 bytes):          OKAY
> WRITE (   1024 bytes):          OKAY
> WRITE (   1025 bytes):          OKAY
> WRITE (1024000 bytes):          OKAY
> WRITE (1024001 bytes):          OKAY
> 
> Corresponding output on the EP side:
> rockchip-dw-pcie a40000000.pcie-ep: EP cannot raise INTX IRQs
> pci_epf_test pci_epf_test.0: WRITE => Size: 1 B, DMA: NO, Time: 0.000000292 s, Rate: 3424 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1024 B, DMA: NO, Time: 0.000007583 s, Rate: 135038 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1025 B, DMA: NO, Time: 0.000007584 s, Rate: 135152 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1024000 B, DMA: NO, Time: 0.009164167 s, Rate: 111739 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1024001 B, DMA: NO, Time: 0.009164458 s, Rate: 111736 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1 B, DMA: NO, Time: 0.000001750 s, Rate: 571 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1024 B, DMA: NO, Time: 0.000147875 s, Rate: 6924 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1025 B, DMA: NO, Time: 0.000149041 s, Rate: 6877 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1024000 B, DMA: NO, Time: 0.147537833 s, Rate: 6940 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: NO, Time: 0.147533750 s, Rate: 6940 KB/s
> pci_epf_test pci_epf_test.0: COPY => Size: 1 B, DMA: NO, Time: 0.000003208 s, Rate: 311 KB/s
> pci_epf_test pci_epf_test.0: COPY => Size: 1024 B, DMA: NO, Time: 0.000156625 s, Rate: 6537 KB/s
> pci_epf_test pci_epf_test.0: COPY => Size: 1025 B, DMA: NO, Time: 0.000158375 s, Rate: 6471 KB/s
> pci_epf_test pci_epf_test.0: COPY => Size: 1024000 B, DMA: NO, Time: 0.156902666 s, Rate: 6526 KB/s
> pci_epf_test pci_epf_test.0: COPY => Size: 1024001 B, DMA: NO, Time: 0.156847833 s, Rate: 6528 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1 B, DMA: YES, Time: 0.000185500 s, Rate: 5 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1024 B, DMA: YES, Time: 0.000177334 s, Rate: 5774 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1025 B, DMA: YES, Time: 0.000178792 s, Rate: 5732 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1024000 B, DMA: YES, Time: 0.000486209 s, Rate: 2106090 KB/s
> pci_epf_test pci_epf_test.0: WRITE => Size: 1024001 B, DMA: YES, Time: 0.000486791 s, Rate: 2103574 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1 B, DMA: YES, Time: 0.000177333 s, Rate: 5 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1024 B, DMA: YES, Time: 0.000177625 s, Rate: 5764 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1025 B, DMA: YES, Time: 0.000171208 s, Rate: 5986 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1024000 B, DMA: YES, Time: 0.000701167 s, Rate: 1460422 KB/s
> pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: YES, Time: 0.000702625 s, Rate: 1457393 KB/s
> 

Thanks a lot for sharing the pcitest results in the cover letter.

- Mani

> Kind regards,
> Niklas
> 
> ---
> Changes in v2:
> - Rebased on v4 of the pci-epf-rework series that we depend on.
> - Picked up tags from Rob.
> - Split dw-rockchip DT binding in to common, RC and EP parts.
> - Added support for rk3568 in DT binding and driver.
> - Added a new patch that fixed "combined legacy IRQ description".
> - Link to v1: https://lore.kernel.org/r/20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org
> 
> ---
> Niklas Cassel (14):
>       dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific reg-name
>       dt-bindings: PCI: snps,dw-pcie-ep: Add vendor specific interrupt-names
>       dt-bindings: PCI: snps,dw-pcie-ep: Add tx_int{a,b,c,d} legacy irqs
>       dt-bindings: PCI: rockchip-dw-pcie: Prepare for Endpoint mode support
>       dt-bindings: PCI: rockchip-dw-pcie: Fix description of legacy irq
>       dt-bindings: rockchip: Add DesignWare based PCIe Endpoint controller
>       PCI: dw-rockchip: Fix weird indentation
>       PCI: dw-rockchip: Add rockchip_pcie_ltssm() helper
>       PCI: dw-rockchip: Refactor the driver to prepare for EP mode
>       PCI: dw-rockchip: Add explicit rockchip,rk3588-pcie compatible
>       PCI: dw-rockchip: Add endpoint mode support
>       misc: pci_endpoint_test: Add support for rockchip rk3588
>       arm64: dts: rockchip: Add PCIe endpoint mode support
>       arm64: dts: rockchip: Add rock5b overlays for PCIe endpoint mode
> 
>  .../bindings/pci/rockchip-dw-pcie-common.yaml      | 126 ++++++++++
>  .../bindings/pci/rockchip-dw-pcie-ep.yaml          |  95 ++++++++
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  93 +------
>  .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml   |  13 +-
>  arch/arm64/boot/dts/rockchip/Makefile              |   5 +
>  .../boot/dts/rockchip/rk3588-rock-5b-pcie-ep.dtso  |  25 ++
>  .../dts/rockchip/rk3588-rock-5b-pcie-srns.dtso     |  16 ++
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi           |  35 +++
>  drivers/misc/pci_endpoint_test.c                   |  11 +
>  drivers/pci/controller/dwc/Kconfig                 |  17 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c      | 267 +++++++++++++++++++--
>  11 files changed, 588 insertions(+), 115 deletions(-)
> ---
> base-commit: b452acb8fa6fc90851a93300eb0aaf89038a83d5
> change-id: 20240424-rockchip-pcie-ep-v1-87c78b16d53c
> 
> Best regards,
> -- 
> Niklas Cassel <cassel@kernel.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

