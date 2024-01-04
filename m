Return-Path: <linux-pci+bounces-1665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D86824231
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2751F216BE
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385E1224EA;
	Thu,  4 Jan 2024 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WK1xaleo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C8224DC
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3366e78d872so414458f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 05:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704373322; x=1704978122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opVDF4AOHQah3OrT16oGMK2ccRRJHeIMJXkpc+aZwFs=;
        b=WK1xaleoMk7IVXPllfXEUF4Xo7mTNqo5t2Eu1pESyW/Y+enVzlgw2jNS6NG0ix03uW
         R3eEPFGjgzWgVBUx6oChjpFfyhCOFLNySVeIg9x/1AyeyCOnHphPJBYjCU11dCsbNd67
         jD4Hsp6G8K54zNh+9zAbbMQJODkn84rl4B92p9Efk6QQ1cboEVYDHPFVdBH2wLBTzHyc
         o33J/zut+6c66m+g+0Qjkogk7AG+SVphmFVCUlA04TUnXWHsucHF8yBrWPh9MbphLmYk
         Xjo7Y2Xsk+yhKozFeEUyIquoRJwCHZylOWw21UfOv/pobf7YH8XTUf/8rvEGFVGuVWCy
         ABaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373322; x=1704978122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opVDF4AOHQah3OrT16oGMK2ccRRJHeIMJXkpc+aZwFs=;
        b=L7+70NIHcyYMZRwTp73DuvWJqYq38NPsHQ8L3Kon4tjjw5Wif45tK5chXp3mBGW644
         7Pk1tcIedqLHEcE72ThOhqu782k1VNZXRekime758mtaxnGf3IHF9LK2HeNu6vFCOmVM
         rwXvPhpv7Vco98rDwggPLvu38NihXdg33iqCR6ntVjrhx1wrCxQZLU919tj9oHt0b1bx
         bC61e7xhfzcodGaQiMpQPE6afs5wdG+XSzUscPzn3by5uYjqdw9CnRnVXBijZuiGIRCV
         llJMYTJNBpqoMpJrIPoGxDNYT2LlhJ2ZOVPNiET3BJiVW3QUb6adWBG0/UNvuWc2kUKv
         nM6w==
X-Gm-Message-State: AOJu0YwS/SoogDXGyl0OcMQ6FtlS6vkpsMWAHhGCE7Ab1C7ySyshlZye
	Ut7qBi0qfOkVTvP3OLmK2PlviFaBAizmyQ==
X-Google-Smtp-Source: AGHT+IFsoUaWFe3hNCg6/b09WcRv7wsIMJMlEiNm/lu4Y1OTN1yICGktvfbzMdrteuCPKZTBntbM6g==
X-Received: by 2002:adf:cc86:0:b0:337:157:2d3e with SMTP id p6-20020adfcc86000000b0033701572d3emr161961wrj.222.1704373322145;
        Thu, 04 Jan 2024 05:02:02 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:5b69:3768:8459:8fee])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b0033660f75d08sm32887387wrv.116.2024.01.04.05.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:02:01 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 0/9] PCI: introduce the concept of power sequencing of PCIe devices
Date: Thu,  4 Jan 2024 14:01:14 +0100
Message-Id: <20240104130123.37115-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

During last year's Linux Plumbers we had several discussions centered
around the need to power-on PCI devices before they can be detected on
the bus.

The consensus during the conference was that we need to introduce a
class of "PCI slot drivers" that would handle the power-sequencing.

After some additional brain-storming with Manivannan and the realization
that the DT maintainers won't like adding any "fake" nodes not
representing actual devices, we decided to reuse the existing
infrastructure provided by the PCIe port drivers.

The general idea is to instantiate platform devices for child nodes of
the PCIe port DT node. For those nodes for which a power-sequencing
driver exists, we bind it and let it probe. The driver then triggers a
rescan of the PCI bus with the aim of detecting the now powered-on
device. The device will consume the same DT node as the platform,
power-sequencing device. We use device links to make the latter become
the parent of the former.

The main advantage of this approach is not modifying the existing DT in
any way and especially not adding any "fake" platform devices.

Bartosz Golaszewski (9):
  arm64: dts: qcom: sm8250: describe the PCIe port
  arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
  PCI/portdrv: create platform devices for child OF nodes
  PCI: hold the rescan mutex when scanning for the first time
  PCI/pwrseq: add pwrseq core code
  dt-bindings: vendor-prefixes: add a PCI prefix for Qualcomm Atheros
  dt-bindings: wireless: ath11k: describe QCA6390
  PCI/pwrseq: add a pwrseq driver for QCA6390
  arm64: defconfig: enable the PCIe power sequencing for QCA6390

 .../net/wireless/qcom,ath11k-pci.yaml         |  14 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   1 +
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  24 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +
 arch/arm64/configs/defconfig                  |   2 +
 drivers/pci/pcie/Kconfig                      |   2 +
 drivers/pci/pcie/Makefile                     |   2 +
 drivers/pci/pcie/portdrv.c                    |   3 +-
 drivers/pci/pcie/pwrseq/Kconfig               |  19 ++
 drivers/pci/pcie/pwrseq/Makefile              |   4 +
 drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c | 197 ++++++++++++++++++
 drivers/pci/pcie/pwrseq/pwrseq.c              |  83 ++++++++
 drivers/pci/probe.c                           |   2 +
 include/linux/pcie-pwrseq.h                   |  24 +++
 14 files changed, 386 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/pcie/pwrseq/Kconfig
 create mode 100644 drivers/pci/pcie/pwrseq/Makefile
 create mode 100644 drivers/pci/pcie/pwrseq/pcie-pwrseq-qca6390.c
 create mode 100644 drivers/pci/pcie/pwrseq/pwrseq.c
 create mode 100644 include/linux/pcie-pwrseq.h

-- 
2.40.1


