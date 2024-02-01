Return-Path: <linux-pci+bounces-2930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C5D845C32
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E1728729A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D52F626D3;
	Thu,  1 Feb 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="g23ux0eh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647306215A
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802945; cv=none; b=VhgFVIeOTRuWj+DSQeDS5xNJ0b3lnE5YFp6+Gxcu1GNPeyuKmS8hBh+8VT7AdcBNIS3bDgvTu7m1KpFU9ifHwMlaVidDbw2XFpVhYNMqzsCNFEayyMQFq7xHmn2iBTWSsDl6GuF5FY1+ne9zEGvLQZdDqh+C2dsjpc7QqDfkhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802945; c=relaxed/simple;
	bh=8NQkfhoBr9JLEjdzguP3BSv+GdLe2ubyahcNgiZHmhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GCZFH+HCiQzk2cu75wPmUu6T1la/H/t+rrlbdP1FylQ1lwNZmHZUU8/n8WN1QdB0dZOVqUjbDWwOTcDJ7EutbGjpsabPhLf5HjFyIniuuwGPzIL8a1u2iewl2biI0K4NsQoRfJFvigO5WAZYwafqygSPbaMTtZiCGHaUucPoDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=g23ux0eh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so9966955e9.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802940; x=1707407740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5qM+DhIAVGaoaijHTK5tqpB0tA35c17btuMlycQtGc=;
        b=g23ux0ehqQ3jhpUM7Aoh7LowdIwQmU3hC3UAQEWi9c28otfoKaOEeQpYug+I8NCm7p
         moSCcaZ2fjGIQi1uRTHtcPpJvpXbeC0c1l7QPiE/LuUCRphZfxIcWI7ce/MA0/Dsxj9J
         RhBvZa1CO/Huiv0CqamMzxG324xrCewglExsP03TvtAaj65mKUrL73brw7BMFn051W3+
         pMivJIrRLRvh9rd1hqdQMM78VII9iWTl7gJMdB/MLkx52l4VR20LqDxb0bI0VVgR87N0
         Tsar8SHjRoNaGJOR6VM8YHp1u4lc4oOKhVhEN376B2qmmUM7DqrbjBlaD6exCkFHlQLX
         V32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802940; x=1707407740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5qM+DhIAVGaoaijHTK5tqpB0tA35c17btuMlycQtGc=;
        b=IG21QME2ODzKMo4LA2soXmM0UHMW0v+pIBlz1IEx4UqTMc9ZDRBtA+yWif6M1pVIsf
         H0k5DkDXhbNbdpCDMnL05dWl558Cl66BS6leMS5CrVNcz2BFpqxh77WmLAUi5fxLw9Pr
         Z+ZwY7EkQkGzt8ylWt2b+36n3F1XBAut5M/t2p+SpEQC5eAMVMYVVzSeS9R24jASFaaV
         IPpucU8AuSfPD85D+xZeXxSNxdb/wI9XE+siTHliXfH+fxWTe4pk+ySq373NEZYWYDE6
         JVtrmpAT89Pl5P7n+b27RXka9fVotsAQdvwXY2WpgcX66HCENhVSdFXGTyGnSvDtRevZ
         EJAw==
X-Gm-Message-State: AOJu0Yx3B/TZwJj0NlPD/VFbstyYQG+CbZvXY6IikePesv11IfMEpgvc
	FmrnTdloP59Nnp74Um0IArp3w4lapmM2rghOSpxhZpub0Y0miZta95hTVMJgpts=
X-Google-Smtp-Source: AGHT+IFUiCpUoqg+Hwif5qU4KpnW7NZcqtWoeDcKn/KB/alf1F0byzO6udrYL9tJwF2Feal1AG/4Xw==
X-Received: by 2002:a05:600c:4f10:b0:40e:d316:8cb8 with SMTP id l16-20020a05600c4f1000b0040ed3168cb8mr4140755wmq.27.1706802940496;
        Thu, 01 Feb 2024 07:55:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZxNUxx4gS4K/kceUjJUevqGmQHTw1rJd6vIRpSv5lJrrJWkuLS1S1vdwD178Lv9W1djE9nJ0mkX0T3sNbVXCgfdKc0btL6jtLQHESt7VMVokV9jyDqC8y7LQMa31bMvmDhErdtqm3lXA5l8dDZp8HowT6kBThwT6ZgoBlacs/C6A69DhvW585i2UVNZ1R80UcdWg3xd8Z4qMcb7gE64scAaJ9DUlv8jYf6dizAmSJTcRcA3Tohmh20wLpYr7LD746bpC4EpeFWPt+sbaWr3kXFF1SKCmEQP7Z667O81fhKoq5f3XZAXS5Bkc9kl8NVR0JiYceI/AFy/UhUHVwRW+DTLqsxCrRK5oApKL92oNofGjI7z8/h4uWIASjhJiT2edMonOuW6gp+prhYpw+RDE1vcyb/3JN0iVNShG/AF3wpRB7N2ufwk4jYZzOgVRZmB0PxNZxyXR4keCYP9GZhCmjInkjKZebYWaSzoFgJb99JQZX9K2cFcndmRHA8PfykOLuCBjf1Agw0FctTgGsIHvLrhjQViX3kvY7ykS16JmD+wPCLFiwXxc0J7Ww7cFnSy4GHJ44mwjDW/ggOa64w6vLhpw9VMkMKaPgcTHjyoEPp2melvRPnIXn391eluQlJ85yin6QOAmfvyFU+Jxftql2KTYuxS4O6t86irppvG/Jzoe7ZZK5AS9mXttMXJhEXORuzg0ta3HQ
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 0/9] power: sequencing: implement the subsystem and add first users
Date: Thu,  1 Feb 2024 16:55:23 +0100
Message-Id: <20240201155532.49707-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'd like to preface the cover letter by saying right away that this
series is not complete. It's an RFC that presents my approach and is sent
to the list for discussion. There are no DT bindings nor docs in
Documentation/ yet. Please review it as an RFC and not an upstreambound
series. If the approach is accepted as correct, I'll add missing bits.

The RFC[1] presenting my proposed device-tree representation of the
QCA6391 package present on the RB5 board - while not really officially
accepted - was not outright rejected which is a good sign.

This series incorporates it and builds a proposed power sequencing
subsystem together with the first dedicated driver around it. Then it
adds first two users: the Bluetooth and WLAN modules of the QCA6391.

The Bluetooth part is pretty straightforward. The WLAN however is a PCIe
device and as such needs to be powered-up *before* it's detected on the
PCI bus. To that end, we modify the PCI core to instantiate platform
devices for existing DT child nodes of the PCIe ports. For those nodes
for which a power-sequencing driver exists, we bind it and let it probe.
The driver then triggers a rescan of the PCI bus with the aim of
detecting the now powered-on device. The device will consume the same DT
node as the platform, power-sequencing device. We use device links to
make the latter become the parent of the former.

The main advantage of the above approach (both for PCI as well as
generic power sequencers) is that we don't introduce significant changes
in DT bindings and don't introduce new properties. We merely define new
resources.

[1] https://lore.kernel.org/all/CAMRc=MckG32DQv7b1AQL-mbnYdx4fsdYWtLwCyXc5Ma7EeSAKw@mail.gmail.com/T/#md5dc62007d12f6833d4e51658b14e0493954ba68

Bartosz Golaszewski (9):
  of: provide a cleanup helper for OF nodes
  arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
  power: sequencing: new subsystem
  power: pwrseq: add a driver for the QCA6390 PMU module
  Bluetooth: qca: use the power sequencer for QCA6390
  PCI: create platform devices for child OF nodes of the port node
  PCI: hold the rescan mutex when scanning for the first time
  PCI/pwrctl: add PCI power control core code
  PCI/pwrctl: add a PCI power control driver for power sequenced devices

 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts  | 128 +++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi      |  10 +
 drivers/bluetooth/hci_qca.c               |  30 ++
 drivers/pci/Kconfig                       |   1 +
 drivers/pci/Makefile                      |   1 +
 drivers/pci/bus.c                         |   9 +-
 drivers/pci/probe.c                       |   2 +
 drivers/pci/pwrctl/Kconfig                |  17 +
 drivers/pci/pwrctl/Makefile               |   4 +
 drivers/pci/pwrctl/core.c                 |  82 ++++
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c    |  83 ++++
 drivers/pci/remove.c                      |   2 +
 drivers/power/Kconfig                     |   1 +
 drivers/power/Makefile                    |   1 +
 drivers/power/sequencing/Kconfig          |  28 ++
 drivers/power/sequencing/Makefile         |   6 +
 drivers/power/sequencing/core.c           | 482 ++++++++++++++++++++++
 drivers/power/sequencing/pwrseq-qca6390.c | 232 +++++++++++
 include/linux/of.h                        |   4 +
 include/linux/pci-pwrctl.h                |  24 ++
 include/linux/pwrseq/consumer.h           |  53 +++
 include/linux/pwrseq/provider.h           |  41 ++
 22 files changed, 1229 insertions(+), 12 deletions(-)
 create mode 100644 drivers/pci/pwrctl/Kconfig
 create mode 100644 drivers/pci/pwrctl/Makefile
 create mode 100644 drivers/pci/pwrctl/core.c
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 drivers/power/sequencing/pwrseq-qca6390.c
 create mode 100644 include/linux/pci-pwrctl.h
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h

-- 
2.40.1


