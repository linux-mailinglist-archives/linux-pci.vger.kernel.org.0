Return-Path: <linux-pci+bounces-3628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C4B8586C4
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEB51F23592
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9421513AA46;
	Fri, 16 Feb 2024 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SvLKzJB9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDDD2D603
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115595; cv=none; b=BHYpyxAmr87N6tqL6U4bDAm5K29XR4lfindS+9yXhWnvBVXXnOnZ0fTtpCXyLnprVLv8Gi5NJnxQZsZgPzPu9L6QeFBtvuMDe0kfQQJbG3jxKzWDsp8TO+Q/bM3SKh0c3r7kdeNamWmkCblY5MwRkW4iYpKSND9VHLjBm/E3Mlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115595; c=relaxed/simple;
	bh=3I4CXuk/WeEk7ajjH2UJMRZxlJ3vRUGIIjnrNU23YiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8tx5cfS0cGcnXGFFlQcVB+lh3v65H/HzYM/N0hfN+Be8bpYDlKROoitSQGIb7vK4vcvUCMEDvgHpmQQrNHAcI0hJTaMvJeFCgHA9dTPD+UkF0YuUwlNR4e0+BTY0jbwrlssLHXfTPi2aerreONPnnCxkyBF9FghRieDJEhVjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SvLKzJB9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso7761905e9.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115591; x=1708720391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=du2HpBcnUVrMPAnFXWJbJn5zTDGPtwpWkU7k3T+cHvo=;
        b=SvLKzJB9VJXgKfrQ9ytONVfFAJaAI6+CwMZQXYEwsfjO2w64AwaodUagZLUBaXIkL1
         HX3iPF3F670KseCCya9cq19NuzDlOnxlIgk+6hj3mRLXKRP5wYGg5HZvLf4NIYa3WXO6
         y9pbmZCFHR5iDxFMfIDqXq5n7it2SA6wcdTqECZK5BmCiHXX8dt/fyZjvDKzyfbSsFfh
         hOLY6J+d9mcJfKWdanfLk22kZgKfmbh3I4dOcOawiJiNt+joUIM9gbSzqe7pjboM0iks
         hoBrP7WtegzaMUrFia/BIvi3LhMBPf4Nt8CsxoFsn6SgyQGpQ3WkWLZsVV2bfihKnoZl
         GPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115591; x=1708720391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du2HpBcnUVrMPAnFXWJbJn5zTDGPtwpWkU7k3T+cHvo=;
        b=ujVLtU75k5qB16Ye+RcsUzXqZRwOudeAFX64Am4n++C7+GQEgQ9XfvZq0ZuOK7Dy0h
         UrfJNK4IPk33hJ/pW5oma5Q6zjQ35+uB2u1ikksHESgxT7UcnnbzrUGtPCFbzUCHAgkK
         qj81QbCAg8pJMBV5Y9gfyji71KrnvDTPAU9jSQhr4mSmB715MNdKqtwXQTH8uHuGfYpg
         3jowh+7VJEG8sHTQuX5TnwC451TH4dyYDiQGC4r53ye0MhURXBR9VY+n2/aPEDEGb7MX
         WOq/+O/pSO/SB8ldYjM0RT3Eu8/gmhdFQrBm2ROSbxtxKt9OeSVcQlFPg5X7UFm8s1SO
         451g==
X-Forwarded-Encrypted: i=1; AJvYcCVKVfZjdIBS/zuIFb38Dk9GDW+kOdxtowRO0KpC5JI5Zts0KB2DLTsoRw4qbo6XePvB/VnjU0loxYctoNN7hMj0lQYIlDIG7bRK
X-Gm-Message-State: AOJu0YxsUfN+yAElLZrz5q06Nn609TAHiDic3aw/NXeWZPpdgKWVrFW+
	v9IhV1AUIIPOyANEgJdz2RfSH68MyB6+7aOLL7cLrMwYLwbmlhGMUueOl/IzvaQ=
X-Google-Smtp-Source: AGHT+IGzTzleiYxNF4Ad09b1VW2/cZN7zSuS7wcp/+RcNzsR+sQhZvtX/87uodOmQzIiZdILeyK85w==
X-Received: by 2002:a05:600c:1553:b0:412:a6b:f3a5 with SMTP id f19-20020a05600c155300b004120a6bf3a5mr4630389wmg.5.1708115590619;
        Fri, 16 Feb 2024 12:33:10 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:10 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 00/18] power: sequencing: implement the subsystem and add first users
Date: Fri, 16 Feb 2024 21:31:57 +0100
Message-Id: <20240216203215.40870-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

First, I'd like to apologize for the somewhat chaotic previous iterations
of this series and improper versioning which was rightfully pointed out
to me. I figured that the scope changed so much that it didn't make sense
to consider previous submissions part of the same series as the original
RFC but others thought otherwise so this one becomes v5 and I'll keep the
versioning going forward.

This is the summary of the work so far:

v1: Original RFC:

https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/

v2: First real patch series (should have been PATCH v2) adding what I
    referred to back then as PCI power sequencing:

https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/

v3: RFC for the DT representation of the PMU supplying the WLAN and BT
    modules inside the QCA6391 package (was largely separate from the
    series but probably should have been called PATCH or RFC v3):

https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/

v4: Second attempt at the full series with changed scope (introduction of
    the pwrseq subsystem, should have been RFC v4)

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/

===

With that out of the way, I'd like to get down to explaining the two
problems I'm trying to solve.

Problem statement #1: Dynamic bus chicken-and-egg problem.

Certain on-board PCI devices need to be powered up before they are can be
detected but their PCI drivers won't get bound until the device is
powered-up so enabling the relevant resources in the PCI device driver
itself is impossible.

Problem statement #2: Sharing inter-dependent resources between devices.

Certain devices that use separate drivers (often on different busses)
share resources (regulators, clocks, etc.). Typically these resources
are reference-counted but in some cases there are additional interactions
between them to consider, for example specific power-up sequence timings.

===

The reason for tackling both of these problems in a single series is the
fact the the platform I'm working on - Qualcomm RB5 - deals with both and
both need to be addressed in order to enable WLAN and Bluetooth support
upstream.

The on-board WLAN/BT package - QCA6391 - has a Power Management Unit that
takes inputs from the host and exposes LDO outputs consumed by the BT and
WLAN modules which can be powered-up and down independently. However
a delay of 100ms must be respected between enabling the BT- and
WLAN-enable GPIOs[*].

===

This series is logically split into several sections. I'll go
patch-by-patch and explain each step.

Patch 1/18:

This is a commit taken from the list by Jonathan Cameron that adds
a __free() helper for OF nodes. Not strictly related to the series but
until said commit ends in next, I need to carry it with this series.

Patch 2/18:

This enables the ath12k PCI module in arm64 defconfig as Qualcomm sm8650
and sm8550 reference platforms use it in the WCN7850 module.

Patches 3/18-6/18:

These contain all relevant DT bindings changes. We add new documents for
the QCA6390 PMU and ATH12K devices as well as extend the bindings for the
Qualcomm Bluetooth and ATH11K modules with regulators used by them in
QCA6390.

Patches 7/18-9/18:

These contain changes to device-tree sources for the three platforms we
work with in this series. As the WCN7850 module doesn't require any
specific timings introducing dependencies between the Bluetooth and WLAN
modules, while the QCA6390 does, we take two different approaches to how
me model them in DT.

For WCN7850 we hide the existence of the PMU as modeling it is simply not
necessary. The BT and WLAN devices on the device-tree are represented as
consuming the inputs (relevant to the functionality of each) of the PMU
directly.

For QCA6390 on RB5 we add the PMU node as a platform device. It consumes
regulators and GPIOs from the host and exposed regulators consumer in turn
by the BT and WLAN modules. This represents the internal structure of the
package.

Patches 10/18-14/18:

These contain the bulk of the PCI changes for this series. We introduce
a simple framework for powering up PCI devices before detecting them on
the bus and the first user of this library in the form of the WCN7850 PCI
power control driver.

The general approach is as follows: PCI devices that need special
treatment before they can be powered up, scanned and bound to their PCI
drivers must be described on the device-tree as child nodes of the PCI
port node. These devices will be instantiated on the platform bus. They
will in fact be generic platform devices with the compatible of the form
used for PCI devices already upstream ("pci<vendor ID>,<device ID">). We
add a new directory under drivers/pci/pwrctl/ that contains PCI pwrctl
drivers. These drivers are platform drivers that will now be matched
against the devices instantiated from port children just like any other
platform pairs.

Both the power control platform device *AND* the associated PCI device
reuse the same OF node and have access to the same properties. The goal
of the platform driver is to request and bring up any required resources
and let the pwrctl framework know that it's now OK to rescan the bus and
detect the devices. When the device is bound, we are notified about it
by the PCI bus notifier event and can establish a device link between the
power control device and the PCI device so that any future extension for
power-management will already be able to work with the correct hierachy.

The reusing of the OF node is the reason for the small changes to the PCI
OF core: as the bootloader can possibly leave the relevant regulators on
before booting linux, the PCI device can be detected before its platform
abstraction is probed. In this case, we find that device first and mark
its OF node as reused. The pwrctl framework handles the opposite case
(when the PCI device is detected only after the platform driver
successfully enabled it).

Patches 15/18-16/18:

These add a relatively simple power sequencing subsystem and the first
driver using it: the pwrseq module for the QCA6390 PMU.

For the record: Bjorn suggested a different solution: a regulator driver
that would - based on which regulators are enabled by a consumer - enable
relevant resources (drive the enable GPIOs) while respecting the
HW-specific delays. This would however require significant and yet
unprecised changed to the regulator subsystem as well as be an abuse of
the regulator provider API akin to using the reset framework for power
sequencing as proposed before.

Instead I'm proposing to add a subsystem that allows different devices to
use a shared power sequence split into consumer-specific as well as
common "units".

A power sequence provider driver registers a set of units with pwrseq
core. Each unit can be enabled and disabled and contains an optional list
of other units which must be enabled before it itself can be. A unit
represents a discreet chunk of the power sequence.

It also registers a list of targets: a target is an abstraction wrapping
a unit which allows consumers to tell pwrseq which unit they want to
reach. Real-life example is the driver we're adding here: there's a set
of common regulators, two PCIe-specific ones and two enable GPIOs: one
for Bluetooth and one for WLAN.

The Bluetooth driver requests a descriptor to the power sequencer and
names the target it wants to reach:

    pwrseq = devm_pwrseq_get(dev, "bluetooth");

The pwrseq core then knows that when the driver calls:

    pwrseq_power_on(pwrseq);

It must enable the "bluetooth-enable" unit but it depends on the
"regulators-common" unit so this one is enabled first. The provider
driver is also in charge of assuring an appropriate delay between
enabling the BT and WLAN enable GPIOs. The WLAN-specific resources are
handled by the "wlan-enable" unit and so are not enabled until the WLAN
driver requests the "wlan" target to be powered on.

Another thing worth discussing is the way we associate the consumer with
the relevant power sequencer. DT maintainers have expressed a discontent
with the existing mmc pwrseq bindings and have NAKed an earlier
initiative to introduce global pwrseq bindings to the kernel[1].

In this approach, we model the existing regulators and GPIOs in DT but
the pwrseq subsystem requires each provider to provide a .match()
callback. Whenever a consumer requests a power sequencer handle, we
iterate over the list of pwrseq drivers and call .match() for each. It's
up to the driver to verify in a platform-specific way whether it deals
with its consumer and let the core pwrseq code know.

The advantage of this over reusing the regulator or reset subsystem is
that it's more generalized and can handle resources of all kinds as well
as deal with any kind of power-on sequences: for instance, Qualcomm has
a PCI switch they want a driver for but this switch requires enabling
some resources first (PCI pwrctl) and then configuring the device over
I2C (which can be handled by the pwrseq provider).

Patch 17/18:

This patch makes the Qualcomm Bluetooth driver get and use the power
sequencer for QCA6390.

Patch 18/18:

While tiny, this patch is possibly the highlight of the entire series.
It uses the two abstraction layers we introduced before to create an
elegant power sequencing PCI power control driver and supports the ath11k
module on QCA6390.

With this series we can now enable BT and WLAN on several new Qualcomm
boards upstream.

I tested the series on RB5 while Neil tested it on sm8650-qrd and
sm8550-qrd.

Best Regards,
Bartosz Golaszewski

It's hard to list the changes between versions here as the scope changed
significantly between each iteration and some versions were not even full
series but rather RFCs for parts of the solution. For this reason, I'll
only start listing changes starting from v6.

[*] This is what the docs say. In practice it seems that this delay can be
ignored. However the subsequent model - QCA6490 - *does* require users to
respect it, so the problem remains valid.

[1] https://lore.kernel.org/netdev/20210829131305.534417-1-dmitry.baryshkov@linaro.org/

Bartosz Golaszewski (15):
  arm64: defconfig: enable ath12k as a module
  dt-bindings: regulator: describe the PMU module of the QCA6390 package
  dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
  dt-bindings: new: wireless: qcom,ath11k: describe the ath11k on
    QCA6390
  dt-bindings: new: wireless: describe the ath12k PCI module
  arm64: dts: qcom: qrb5165-rb5: model the PMU of the QCA6391
  PCI: hold the rescan mutex when scanning for the first time
  PCI/pwrctl: reuse the OF node for power controlled devices
  PCI/pwrctl: create platform devices for child OF nodes of the port
    node
  PCI/pwrctl: add PCI power control core code
  PCI/pwrctl: add a power control driver for WCN7850
  power: sequencing: implement the pwrseq core
  power: pwrseq: add a driver for the QCA6390 PMU module
  Bluetooth: qca: use the power sequencer for QCA6390
  PCI/pwrctl: add a PCI power control driver for power sequenced devices

Jonathan Cameron (1):
  of: Add cleanup.h based auto release via __free(device_node) markings.

Neil Armstrong (2):
  arm64: dts: qcom: sm8550-qrd: add the Wifi node
  arm64: dts: qcom: sm8650-qrd: add the Wifi node

 .../net/bluetooth/qualcomm-bluetooth.yaml     |   17 +
 .../net/wireless/qcom,ath11k-pci.yaml         |   28 +
 .../net/wireless/qcom,ath12k-pci.yaml         |  103 ++
 .../bindings/regulator/qcom,qca6390-pmu.yaml  |  166 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  123 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   10 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |   37 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |   10 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |   29 +
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   10 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/bluetooth/hci_qca.c                   |   31 +
 drivers/pci/Kconfig                           |    1 +
 drivers/pci/Makefile                          |    1 +
 drivers/pci/bus.c                             |    9 +-
 drivers/pci/of.c                              |   14 +-
 drivers/pci/probe.c                           |    2 +
 drivers/pci/pwrctl/Kconfig                    |   25 +
 drivers/pci/pwrctl/Makefile                   |    7 +
 drivers/pci/pwrctl/core.c                     |  136 +++
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c        |   84 ++
 drivers/pci/pwrctl/pci-pwrctl-wcn7850.c       |  202 ++++
 drivers/pci/remove.c                          |    2 +
 drivers/power/Kconfig                         |    1 +
 drivers/power/Makefile                        |    1 +
 drivers/power/sequencing/Kconfig              |   28 +
 drivers/power/sequencing/Makefile             |    6 +
 drivers/power/sequencing/core.c               | 1065 +++++++++++++++++
 drivers/power/sequencing/pwrseq-qca6390.c     |  353 ++++++
 include/linux/of.h                            |    2 +
 include/linux/pci-pwrctl.h                    |   51 +
 include/linux/pwrseq/consumer.h               |   56 +
 include/linux/pwrseq/provider.h               |   75 ++
 34 files changed, 2678 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
 create mode 100644 drivers/pci/pwrctl/Kconfig
 create mode 100644 drivers/pci/pwrctl/Makefile
 create mode 100644 drivers/pci/pwrctl/core.c
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-wcn7850.c
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 drivers/power/sequencing/pwrseq-qca6390.c
 create mode 100644 include/linux/pci-pwrctl.h
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h

-- 
2.40.1


