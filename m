Return-Path: <linux-pci+bounces-5086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4FA88A6F9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B63A325C64
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280B13E409;
	Mon, 25 Mar 2024 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="w/WjBPg4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36DB13E3E6
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372620; cv=none; b=Zh8tYx5rZzTf/8WFh522BM/4t+PJyGYxuWaCP05C+mlNomKrItKun2vURSTeLSTFqeLEuIo9vGwTrcrUCJgMKPW8ltWnwFlT6b8gmvFF8TB72u0yv976nzr7qATCTHAId7ujkaW+iEti9Kp8pPDZzsZTg62VUgrN50OLKCZyRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372620; c=relaxed/simple;
	bh=QmnIJL3nNR9+zKW6yXAUDe/cZgsADvcZTb9qeXedrZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V3iJfWY92xQFwQNmP7eN5oIj5FOamyS+bqhyWd/krDkkPXn4+/lmrWD4picL4xBQjzEtkOfcT6N9bL1cpklcKi+6JoSczayhsMxSca4D9Krj7ekMYLIJNl3yk9y5Mk+rvpiQ4i6B0UHGqoMrq4xdZvlqEJhubJIMLiEO9O/9Tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=w/WjBPg4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e285a33bdso2348350f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711372616; x=1711977416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6XN7ZpqzE5zYx59YDbBIPeXPDFjIdhS0XqCX5auA4/U=;
        b=w/WjBPg4BQc1bUiBiK9ozDvRCL8S9uX+XAQZXBM+gL2w/Rl14zx3GZ7O5iaPgwl/Q4
         weMCJVBjmswr8NkJld6iwOYrWjROsLbEpZ6zwSfo6ctN9x41Fk7MLtuJTCmGy+Nv4XIa
         ettMuFFUTfQjbauT/dREv2zVaeYN8SpkMgh586EcYCsOvvI9SFMISD92IxOpGtmLY/Y/
         CSoGq+WfnSDy1yU5mzimF1A1XUywnTzdnj166p4P6opJ46MwJzk73QzRumhcBhKFqSUI
         3Hrtgm0dU71s96KCBpaEbfarheT8/KG960N9jnL4+2wqM4LdQxHh5omurOFG/jOhNOUi
         IPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372616; x=1711977416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XN7ZpqzE5zYx59YDbBIPeXPDFjIdhS0XqCX5auA4/U=;
        b=TvMhJHHRCJ3Tzs/uVFpPqTOqQe8v96/LZuyTdaOGvtVgQ4LPq5YQ1Ia9fXX3HpRGnY
         198JM+e4LsQc0O1wvoBhwQZWcJFkuySVBifuWeCfp73bzMvlxKR8tVoFgkieoW1bLMBq
         t3WBzwAfs6kAvmSijAUVwFVSEvbjtryTT14pzWxJMKBliwu0c4RAZuWpgI9rl6KidbhX
         ScycQw1RDuvcVlk2X5WJfjhe+mva5W5QmoA33GmQtcQTX77K1BUq9bYIcpkfijfVSvkc
         +OCSx8Zp2K7/hshC2t2lKFXnK6yKUk14m09nT8VVPGDjim4q52KPzrd7ei4zThrbpnlI
         NTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc6zDzusFx31R70ewarueMAaGo8ghUXr1rpsMO5kY3Bx/9eoCff+t2mq/CNe7Ru+AsWIOr92Rm1rJZ89mKIrRQqa0X+gc7eM+R
X-Gm-Message-State: AOJu0YzR54+kKeCNIamF6AQJlCWvKC73UhBANAmHcxiMPMGO9HypQoNa
	flRZGGDyREb+rGnbxrlRqmVx+idfn8cdd71psmSJ5FWQSPipZIYgyplerTnyZDk=
X-Google-Smtp-Source: AGHT+IG11BOeeCkEAckxI39fvS0eu0rxIdYr3GApKfs4ARiNWzFQ1oPCqFmN8Ecb361gganrIc+ExQ==
X-Received: by 2002:a5d:5710:0:b0:33e:8c7e:608c with SMTP id a16-20020a5d5710000000b0033e8c7e608cmr4716235wrv.13.1711372615843;
        Mon, 25 Mar 2024 06:16:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:861d:8b72:a859:4ce9])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b0033e75e5f280sm9485245wrx.113.2024.03.25.06.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 06:16:55 -0700 (PDT)
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
Subject: [PATCH v6 00/16] power: sequencing: implement the subsystem and add first users
Date: Mon, 25 Mar 2024 14:16:08 +0100
Message-Id: <20240325131624.26023-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Note: I dropped most of the the review and test tags on purpose, the code
changed significantly and warrants a new round of reviews and tests.

===

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
WLAN-enable GPIOs.

A similar design with a discreet PMU is also employed in other models of
the WCN family of chips although we can often do without the delays. With
this series we add support for the WCN7850 as well.

===

We introduce a new subsystem here - the power sequencing framework. The
qcom-wcn driver that we add is its first user. It implements the power-up
sequences for QCA6390 and WCN7850 chips. However - we only use it to
power-up the bluetooth module in the former. We use it to driver the WLAN
modules in both. The reason for this is that for WCN7850 we have
comprehensive bindings already upstream together with existing DT users.
Porting them to using the pwrseq subsystem can be done separately and in
an incremental manner once the subsystem itself is upstream. We will also
have to ensure backward DT compatibility. To avoid overcomplicating this
series, let's leave it out for now.

===

This series is logically split into several sections. I'll go
patch-by-patch and explain each step.

Patches 1/16-5/16:

These contain all relevant DT bindings changes. We add new documents for
the QCA6390 & WCN7850 PMUs and ATH12K devices as well as extend the bindings
for the Qualcomm Bluetooth and ATH11K modules with regulators used by them
in QCA6390.

Patches 6/16-8/16:

These contain changes to device-tree sources for the three platforms we
work with in this series. We model the PMUs of the WLAN/BT chips as
top-level platform devices on the device tree. In order to limit the scope
of this series and not introduce an excessive amount of confusion with
deprecating DT bindings, we leave the Bluetooth nodes on sm8650 and sm8550
as is (meaning: they continue to consumer the GPIOs and power inputs from
the host). As the WCN7850 module doesn't require any specific timings, we can
incrementally change that later.

In both cases we add WLAN nodes that consume the power outputs of the PMU.
For QCA6390 we also make the Bluetooth node of the RB5 consume the outputs
of the PMU - we can do it as the bindings for this chip did not define any
supply handles prior to this series meaning we are able to get this correct
right away.

Patches 9/16-12/16:

These contain the bulk of the PCI changes for this series. We introduce
a simple framework for powering up PCI devices before detecting them on
the bus.

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

Patch 13/16 - 14/16:

These add a relatively simple power sequencing subsystem and the first
driver using it: the pwrseq module for the PMUs on the WCN family of chips.

I'm proposing to add a subsystem that allows different devices to use a shared
power sequence split into consumer-specific as well as common "units".

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

Patch 15:

This patch makes the Qualcomm Bluetooth driver get and use the power
sequencer for QCA6390.

Patch 16:

While tiny, this patch is possibly the highlight of the entire series.
It uses the two abstraction layers we introduced before to create an
elegant power sequencing PCI power control driver and supports the ath11k
module on QCA6390 and ath12k on WCN7850.

With this series we can now enable BT and WLAN on several new Qualcomm
boards upstream.

Tested on RB5, sm8650-qrd and sm8550-qrd.

Changelog:

Since v5:
- unify the approach to modelling the WCN WLAN/BT chips by always exposing
  the PMU node on the device tree and making the WLAN and BT nodes become
  consumers of its power outputs; this includes a major rework of the DT
  sources, bindings and driver code; there's no more a separate PCI
  pwrctl driver for WCN7850, instead its power-up sequence was moved
  into the pwrseq driver common for all WCN chips
- don't set load_uA from new regulator consumers
- fix reported kerneldoc issues
- drop voltage ranges for PMU outputs from DT
- many minor tweaks and reworks

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

v5: Two different ways of handling QCA6390 and WCN7850:

https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/

Bartosz Golaszewski (16):
  regulator: dt-bindings: describe the PMU module of the QCA6390 package
  regulator: dt-bindings: describe the PMU module of the WCN7850 package
  dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
  dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on
    QCA6390
  dt-bindings: net: wireless: describe the ath12k PCI module
  arm64: dts: qcom: sm8550-qrd: add the Wifi node
  arm64: dts: qcom: sm8650-qrd: add the Wifi node
  arm64: dts: qcom: qrb5165-rb5: add the Wifi node
  PCI: hold the rescan mutex when scanning for the first time
  PCI/pwrctl: reuse the OF node for power controlled devices
  PCI/pwrctl: create platform devices for child OF nodes of the port
    node
  PCI/pwrctl: add PCI power control core code
  power: sequencing: implement the pwrseq core
  power: pwrseq: add a driver for the PMU module on the QCom WCN
    chipsets
  Bluetooth: qca: use the power sequencer for QCA6390
  PCI/pwrctl: add a PCI power control driver for power sequenced devices

 .../net/bluetooth/qualcomm-bluetooth.yaml     |   17 +
 .../net/wireless/qcom,ath11k-pci.yaml         |   46 +
 .../bindings/net/wireless/qcom,ath12k.yaml    |  100 ++
 .../bindings/regulator/qcom,qca6390-pmu.yaml  |  185 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  103 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   10 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |   97 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |   10 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |   89 ++
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |   10 +
 drivers/bluetooth/hci_qca.c                   |   74 +-
 drivers/pci/Kconfig                           |    1 +
 drivers/pci/Makefile                          |    1 +
 drivers/pci/bus.c                             |    9 +-
 drivers/pci/of.c                              |   14 +-
 drivers/pci/probe.c                           |    2 +
 drivers/pci/pwrctl/Kconfig                    |   17 +
 drivers/pci/pwrctl/Makefile                   |    6 +
 drivers/pci/pwrctl/core.c                     |  136 +++
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c        |   89 ++
 drivers/pci/remove.c                          |    2 +
 drivers/power/Kconfig                         |    1 +
 drivers/power/Makefile                        |    1 +
 drivers/power/sequencing/Kconfig              |   28 +
 drivers/power/sequencing/Makefile             |    6 +
 drivers/power/sequencing/core.c               | 1065 +++++++++++++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c    |  336 ++++++
 include/linux/pci-pwrctl.h                    |   51 +
 include/linux/pwrseq/consumer.h               |   56 +
 include/linux/pwrseq/provider.h               |   75 ++
 31 files changed, 2614 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
 create mode 100644 drivers/pci/pwrctl/Kconfig
 create mode 100644 drivers/pci/pwrctl/Makefile
 create mode 100644 drivers/pci/pwrctl/core.c
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
 create mode 100644 drivers/power/sequencing/Kconfig
 create mode 100644 drivers/power/sequencing/Makefile
 create mode 100644 drivers/power/sequencing/core.c
 create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c
 create mode 100644 include/linux/pci-pwrctl.h
 create mode 100644 include/linux/pwrseq/consumer.h
 create mode 100644 include/linux/pwrseq/provider.h

-- 
2.40.1


