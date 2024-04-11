Return-Path: <linux-pci+bounces-6122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1C58A140E
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 14:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E54AB22CE6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 12:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435E414B09C;
	Thu, 11 Apr 2024 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L204BLKH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8A14C591
	for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2024 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837522; cv=none; b=N+SlNIlATCkcNprVl3IM5FNBKhfvZaqH3nPcd59rsrPBymT0n0TJ5RdcgrPewBTA99U7VFJ/isn3iIRPQAPxf+VZojN5RX8hpDY3xpN89RBnnEr+Q4rY7WsXeH9oyYWgfmLMa10Qw1iVhf8nPe2LG2mCeFaX9IwbfxxAqV/sD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837522; c=relaxed/simple;
	bh=bdW1R4xwvLxfM4kN6Db7+AiZayuS+rX9KhotHqqG9vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR+YTs4uhW7IHpzHAQ9aLtTsVRBPQ6QSB0xPoS9INMdANaNirLBwY5WmgXwS+8Tdz6MPYmjgtCadoOJprvGRDCpbXNRw5ppNMIIZjUlt9eTJB6RMrKw6hTaDuEW60s2P/eh5STmJ7ZfJNyUciHWMXOahUhqyPPWJHSSfpqbIst4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L204BLKH; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ea1692ad19so2257674a34.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Apr 2024 05:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712837509; x=1713442309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GLYhl9aLVMgoCJUAO7RaLP5tWB+goHCagjk+G8s5TTA=;
        b=L204BLKHC9PbcYSeKPq6Ej7ylc/ycLT7ZymhGUC4beVcwinosb6rm+eilemyuxPuOS
         F1npcHLLZT1N1WrF7D38cmYkYXwPiPnP0wmfsOTsukHuP+aPxB5mNkC5IuYPemzupWgt
         ak7SsLyaE+dBKx/0z+xqjemAeiOPc8AaUyeNStkuO7ZB2cqwWUkAVBZVyNX2JHS86heP
         ojMpQE+eA1UB//f5X4cihUOwX4rv0d2E09OEECT6axfFAFISp8i8eomVVsA/sXKLBB6T
         SiuNlP6RggrijuLNyPLAGTDfRxiHvTKs37NCbx0L1EiDyi/Y0w32d4YOoSr8qEcMcUgL
         BqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712837509; x=1713442309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLYhl9aLVMgoCJUAO7RaLP5tWB+goHCagjk+G8s5TTA=;
        b=VgrTiJVRdBCKcACMl7d6+fE25wugSarSCziFF05jggUGgvCkIvGoTHQkrTjc8YTrj8
         tbDqyl+bF9ctk+f59XcUiZUNWNEsyH9r+VixQE9LIzeaiczbDR9M/xMDuOX64ZpZcQfE
         vk6Qe3KI5OU4Jl28JVJSUYl2clczUf9cSmZ8FpiK/w1h+C8ZAYxFZWuMg1h/i23TWud7
         mvzOMkj8rurkEwXnarXll9+Rn1XfCdODPhFgyvj+KszvC+ORv+c1XAPScphdUb/FDQ4z
         KNVLBlredavaqbpEqnSGJBHmLJbECOaR9sZzYtCMzIkwdgZgUXwZSaZlmegCMI+YjqbG
         saAg==
X-Forwarded-Encrypted: i=1; AJvYcCV8tZXYUCn9DOu7JLwvSQylKvPuUTEbtuaoP37XHd7NKhJLHgvAkVDFEXKnUGeZevxAvgNR6MuViWWn5s12STsAftG0FRrzahQz
X-Gm-Message-State: AOJu0YxXE4OqrXZu89QgLu+gJgHoIma2k/NOYK77B2lSPcdngbrnsK6M
	WzmHrZrUhMkjaAXXCMyossGF4Z+4YOgflKL+yNvA8FiKQ9P6va8wOoMJbeK1SY+826AP0RqP7AT
	LoA3pSlLqVAImH8ZvUqgCvEnGz9XbM0b4hNW13A==
X-Google-Smtp-Source: AGHT+IFneEVrDC9Hs5hmDIrt2suzLfWiMdMKqCnhxnGzrXLtLFtKY9zkCfRVnGtY59+YUoiERDHB5UdcQYbBs3v88xY=
X-Received: by 2002:a05:6808:7cb:b0:3c5:fc14:8503 with SMTP id
 f11-20020a05680807cb00b003c5fc148503mr4924639oij.25.1712837509222; Thu, 11
 Apr 2024 05:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410124628.171783-1-brgl@bgdev.pl>
In-Reply-To: <20240410124628.171783-1-brgl@bgdev.pl>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Thu, 11 Apr 2024 17:41:13 +0530
Message-ID: <CAMi1Hd1wc2W02G4SnMhthBgY6GGLW7ZuGzESmoqj5qY_kMkNWA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] power: sequencing: implement the subsystem and
 add first users
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 18:16, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Problem statement #1: Dynamic bus chicken-and-egg problem.
>
> Certain on-board PCI devices need to be powered up before they are can be
> detected but their PCI drivers won't get bound until the device is
> powered-up so enabling the relevant resources in the PCI device driver
> itself is impossible.
>
> Problem statement #2: Sharing inter-dependent resources between devices.
>
> Certain devices that use separate drivers (often on different busses)
> share resources (regulators, clocks, etc.). Typically these resources
> are reference-counted but in some cases there are additional interactions
> between them to consider, for example specific power-up sequence timings.
>
> ===
>
> The reason for tackling both of these problems in a single series is the
> fact the the platform I'm working on - Qualcomm RB5 - deals with both and
> both need to be addressed in order to enable WLAN and Bluetooth support
> upstream.
>
> The on-board WLAN/BT package - QCA6391 - has a Power Management Unit that
> takes inputs from the host and exposes LDO outputs consumed by the BT and
> WLAN modules which can be powered-up and down independently. However
> a delay of 100ms must be respected between enabling the BT- and
> WLAN-enable GPIOs.
>
> A similar design with a discreet PMU is also employed in other models of
> the WCN family of chips although we can often do without the delays. With
> this series we add support for the WCN7850 as well.
>
> ===
>
> We introduce a new subsystem here - the power sequencing framework. The
> qcom-wcn driver that we add is its first user. It implements the power-up
> sequences for QCA6390 and WCN7850 chips. However - we only use it to
> power-up the bluetooth module in the former. We use it to driver the WLAN
> modules in both. The reason for this is that for WCN7850 we have
> comprehensive bindings already upstream together with existing DT users.
> Porting them to using the pwrseq subsystem can be done separately and in
> an incremental manner once the subsystem itself is upstream. We will also
> have to ensure backward DT compatibility. To avoid overcomplicating this
> series, let's leave it out for now.
>
> ===
>
> This series is logically split into several sections. I'll go
> patch-by-patch and explain each step.
>
> Patches 1/16-5/16:
>
> These contain all relevant DT bindings changes. We add new documents for
> the QCA6390 & WCN7850 PMUs and ATH12K devices as well as extend the bindings
> for the Qualcomm Bluetooth and ATH11K modules with regulators used by them
> in QCA6390.
>
> Patches 6/16-8/16:
>
> These contain changes to device-tree sources for the three platforms we
> work with in this series. We model the PMUs of the WLAN/BT chips as
> top-level platform devices on the device tree. In order to limit the scope
> of this series and not introduce an excessive amount of confusion with
> deprecating DT bindings, we leave the Bluetooth nodes on sm8650 and sm8550
> as is (meaning: they continue to consumer the GPIOs and power inputs from
> the host). As the WCN7850 module doesn't require any specific timings, we can
> incrementally change that later.
>
> In both cases we add WLAN nodes that consume the power outputs of the PMU.
> For QCA6390 we also make the Bluetooth node of the RB5 consume the outputs
> of the PMU - we can do it as the bindings for this chip did not define any
> supply handles prior to this series meaning we are able to get this correct
> right away.
>
> Patches 9/16-12/16:
>
> These contain the bulk of the PCI changes for this series. We introduce
> a simple framework for powering up PCI devices before detecting them on
> the bus.
>
> The general approach is as follows: PCI devices that need special
> treatment before they can be powered up, scanned and bound to their PCI
> drivers must be described on the device-tree as child nodes of the PCI
> port node. These devices will be instantiated on the platform bus. They
> will in fact be generic platform devices with the compatible of the form
> used for PCI devices already upstream ("pci<vendor ID>,<device ID">). We
> add a new directory under drivers/pci/pwrctl/ that contains PCI pwrctl
> drivers. These drivers are platform drivers that will now be matched
> against the devices instantiated from port children just like any other
> platform pairs.
>
> Both the power control platform device *AND* the associated PCI device
> reuse the same OF node and have access to the same properties. The goal
> of the platform driver is to request and bring up any required resources
> and let the pwrctl framework know that it's now OK to rescan the bus and
> detect the devices. When the device is bound, we are notified about it
> by the PCI bus notifier event and can establish a device link between the
> power control device and the PCI device so that any future extension for
> power-management will already be able to work with the correct hierachy.
>
> The reusing of the OF node is the reason for the small changes to the PCI
> OF core: as the bootloader can possibly leave the relevant regulators on
> before booting linux, the PCI device can be detected before its platform
> abstraction is probed. In this case, we find that device first and mark
> its OF node as reused. The pwrctl framework handles the opposite case
> (when the PCI device is detected only after the platform driver
> successfully enabled it).
>
> Patch 13/16 - 14/16:
>
> These add a relatively simple power sequencing subsystem and the first
> driver using it: the pwrseq module for the PMUs on the WCN family of chips.
>
> I'm proposing to add a subsystem that allows different devices to use a shared
> power sequence split into consumer-specific as well as common "units".
>
> A power sequence provider driver registers a set of units with pwrseq
> core. Each unit can be enabled and disabled and contains an optional list
> of other units which must be enabled before it itself can be. A unit
> represents a discreet chunk of the power sequence.
>
> It also registers a list of targets: a target is an abstraction wrapping
> a unit which allows consumers to tell pwrseq which unit they want to
> reach. Real-life example is the driver we're adding here: there's a set
> of common regulators, two PCIe-specific ones and two enable GPIOs: one
> for Bluetooth and one for WLAN.
>
> The Bluetooth driver requests a descriptor to the power sequencer and
> names the target it wants to reach:
>
>     pwrseq = devm_pwrseq_get(dev, "bluetooth");
>
> The pwrseq core then knows that when the driver calls:
>
>     pwrseq_power_on(pwrseq);
>
> It must enable the "bluetooth-enable" unit but it depends on the
> "regulators-common" unit so this one is enabled first. The provider
> driver is also in charge of assuring an appropriate delay between
> enabling the BT and WLAN enable GPIOs. The WLAN-specific resources are
> handled by the "wlan-enable" unit and so are not enabled until the WLAN
> driver requests the "wlan" target to be powered on.
>
> Another thing worth discussing is the way we associate the consumer with
> the relevant power sequencer. DT maintainers have expressed a discontent
> with the existing mmc pwrseq bindings and have NAKed an earlier
> initiative to introduce global pwrseq bindings to the kernel[1].
>
> In this approach, we model the existing regulators and GPIOs in DT but
> the pwrseq subsystem requires each provider to provide a .match()
> callback. Whenever a consumer requests a power sequencer handle, we
> iterate over the list of pwrseq drivers and call .match() for each. It's
> up to the driver to verify in a platform-specific way whether it deals
> with its consumer and let the core pwrseq code know.
>
> The advantage of this over reusing the regulator or reset subsystem is
> that it's more generalized and can handle resources of all kinds as well
> as deal with any kind of power-on sequences: for instance, Qualcomm has
> a PCI switch they want a driver for but this switch requires enabling
> some resources first (PCI pwrctl) and then configuring the device over
> I2C (which can be handled by the pwrseq provider).
>
> Patch 15:
>
> This patch makes the Qualcomm Bluetooth driver get and use the power
> sequencer for QCA6390.
>
> Patch 16:
>
> While tiny, this patch is possibly the highlight of the entire series.
> It uses the two abstraction layers we introduced before to create an
> elegant power sequencing PCI power control driver and supports the ath11k
> module on QCA6390 and ath12k on WCN7850.
>
> With this series we can now enable BT and WLAN on several new Qualcomm
> boards upstream.
>
> Tested on RB5, sm8650-qrd and sm8550-qrd.

Tested WiFi-BT on sm8550-hdk running AOSP with a DT patch similar to
sm8550-qrd from this series.

Tested-by: Amit Pundir <amit.pundir@linaro.org>

Regards,
Amit Pundir

>
> Changelog:
>
> Since v6:
> - kernel doc fixes
> - drop myself from the DT bindings maintainers list for ath12k
> - wait until the PCI bridge device is fully added before creating the
>   PCI pwrctl platform devices for its sub-nodes, otherwise we may see
>   sysfs and procfs attribute failures (due to duplication, we're
>   basically trying to probe the same device twice at the same time)
> - I kept the regulators for QCA6390's ath11k as required as they only
>   apply to this specific Qualcomm package
>
> Since v5:
> - unify the approach to modelling the WCN WLAN/BT chips by always exposing
>   the PMU node on the device tree and making the WLAN and BT nodes become
>   consumers of its power outputs; this includes a major rework of the DT
>   sources, bindings and driver code; there's no more a separate PCI
>   pwrctl driver for WCN7850, instead its power-up sequence was moved
>   into the pwrseq driver common for all WCN chips
> - don't set load_uA from new regulator consumers
> - fix reported kerneldoc issues
> - drop voltage ranges for PMU outputs from DT
> - many minor tweaks and reworks
>
> v1: Original RFC:
>
> https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/
>
> v2: First real patch series (should have been PATCH v2) adding what I
>     referred to back then as PCI power sequencing:
>
> https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/
>
> v3: RFC for the DT representation of the PMU supplying the WLAN and BT
>     modules inside the QCA6391 package (was largely separate from the
>     series but probably should have been called PATCH or RFC v3):
>
> https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/
>
> v4: Second attempt at the full series with changed scope (introduction of
>     the pwrseq subsystem, should have been RFC v4)
>
> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/
>
> v5: Two different ways of handling QCA6390 and WCN7850:
>
> https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/
>
> Bartosz Golaszewski (16):
>   regulator: dt-bindings: describe the PMU module of the QCA6390 package
>   regulator: dt-bindings: describe the PMU module of the WCN7850 package
>   dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
>   dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on
>     QCA6390
>   dt-bindings: net: wireless: describe the ath12k PCI module
>   arm64: dts: qcom: sm8550-qrd: add the Wifi node
>   arm64: dts: qcom: sm8650-qrd: add the Wifi node
>   arm64: dts: qcom: qrb5165-rb5: add the Wifi node
>   PCI: hold the rescan mutex when scanning for the first time
>   PCI/pwrctl: reuse the OF node for power controlled devices
>   PCI/pwrctl: create platform devices for child OF nodes of the port
>     node
>   PCI/pwrctl: add PCI power control core code
>   power: sequencing: implement the pwrseq core
>   power: pwrseq: add a driver for the PMU module on the QCom WCN
>     chipsets
>   Bluetooth: qca: use the power sequencer for QCA6390
>   PCI/pwrctl: add a PCI power control driver for power sequenced devices
>
>  .../net/bluetooth/qualcomm-bluetooth.yaml     |   17 +
>  .../net/wireless/qcom,ath11k-pci.yaml         |   46 +
>  .../bindings/net/wireless/qcom,ath12k.yaml    |   99 ++
>  .../bindings/regulator/qcom,qca6390-pmu.yaml  |  185 +++
>  MAINTAINERS                                   |    8 +
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  103 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi          |   10 +
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |   97 ++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi          |   10 +
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |   89 ++
>  arch/arm64/boot/dts/qcom/sm8650.dtsi          |   10 +
>  drivers/bluetooth/hci_qca.c                   |   74 +-
>  drivers/pci/Kconfig                           |    1 +
>  drivers/pci/Makefile                          |    1 +
>  drivers/pci/bus.c                             |    9 +
>  drivers/pci/of.c                              |   14 +-
>  drivers/pci/probe.c                           |    2 +
>  drivers/pci/pwrctl/Kconfig                    |   17 +
>  drivers/pci/pwrctl/Makefile                   |    6 +
>  drivers/pci/pwrctl/core.c                     |  137 +++
>  drivers/pci/pwrctl/pci-pwrctl-pwrseq.c        |   89 ++
>  drivers/pci/remove.c                          |    2 +
>  drivers/power/Kconfig                         |    1 +
>  drivers/power/Makefile                        |    1 +
>  drivers/power/sequencing/Kconfig              |   28 +
>  drivers/power/sequencing/Makefile             |    6 +
>  drivers/power/sequencing/core.c               | 1065 +++++++++++++++++
>  drivers/power/sequencing/pwrseq-qcom-wcn.c    |  336 ++++++
>  include/linux/pci-pwrctl.h                    |   51 +
>  include/linux/pwrseq/consumer.h               |   56 +
>  include/linux/pwrseq/provider.h               |   75 ++
>  31 files changed, 2615 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
>  create mode 100644 drivers/pci/pwrctl/Kconfig
>  create mode 100644 drivers/pci/pwrctl/Makefile
>  create mode 100644 drivers/pci/pwrctl/core.c
>  create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
>  create mode 100644 drivers/power/sequencing/Kconfig
>  create mode 100644 drivers/power/sequencing/Makefile
>  create mode 100644 drivers/power/sequencing/core.c
>  create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c
>  create mode 100644 include/linux/pci-pwrctl.h
>  create mode 100644 include/linux/pwrseq/consumer.h
>  create mode 100644 include/linux/pwrseq/provider.h
>
> --
> 2.40.1
>

