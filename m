Return-Path: <linux-pci+bounces-8083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18818D4EFB
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 17:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A6E287A62
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB817C222;
	Thu, 30 May 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NN7zrjuF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2218757D
	for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082550; cv=none; b=LGcnJ1nQcsrJZtgSVMYDvexvET3hLuZShSzxQtxkWy9C0WUjVl9R4jTLBYLES1o2kibGc4OpNzYsqSn3QvWE/Nbd7Lxj3bmrxscP3ci2wFBAkZ7LT1vcYFrr2WLXYBkvX4S0VyiFG/DxUTbXxf77m7z0pbhRMzx62o+cCRUTl/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082550; c=relaxed/simple;
	bh=ZLkLYS+nI3TmIjQjKRBU9TTIBrrHnqyjVRgE2oXoL9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fE3OJ/i4Vr5aeIErmXKOwggfmbMXFAfkVgpsXyVmSgjmWBLRbWX0H8ST/OA92G8bQ3OcW6/SIQDenqZZzCbC5nEeONIuuW/yRWErb5OKUscON3g4CdtBf0TnOuR392AzxNGUATzuol5n6DxuPGcIcjW5rRcANNxf0VEPJlZA818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NN7zrjuF; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-57a20c600a7so955484a12.3
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2024 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717082545; x=1717687345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlbYcaGmQGFsV1sehLmZbxnPkjSV0MdjvuWjLVG2/Zs=;
        b=NN7zrjuFogPpEMbWhAaZNmGdrE09xlbTzSMqFers77oqRO36veIDx84ihJWK+FDevQ
         33W+4dY0oix+++D5t2bIn3dfJVAGLOWuHH3ByimXxNwZGuWje+zfs1Aoe/9MkVigmSUM
         Zol7AL3ImdoLxyaEzniDNoeAp8pkW5NHJEyhQI5M/ED4LAMlKzkfrPHAndLSngu6zFR9
         HdXpqHdy+EOM5O08v3N2sOqLRS9TbzNQKbO09SHZbIQ5kiYTagTvzNyON7vTaQWFy/Zp
         WBcAqBOhFwXXGT91YWCMma3I5v6RM1pGdnc6YN6BVLJIMUV0SlBW9AJ/QgVWmgXC10Kt
         YE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082545; x=1717687345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlbYcaGmQGFsV1sehLmZbxnPkjSV0MdjvuWjLVG2/Zs=;
        b=QATkuAXb5PkbcnG8BddCNwftMsdyOGAG1DRfPI1EuQNWgyGe5sjVwgctO+vqtktgn3
         kcKLfwsG3FdrF92xFgcr3ayyFsnJ64v77qgQ3Uy7O8yz//R1zUPa4L9HVG8GQ/0ztwRZ
         BqzKPyY85RY6yqe1ArsoERVF90xFwpcLSLkIDPsdQReVMPlnYQX/6NxR4PUoI322jP6F
         sNLXlIG9egr8Ek82oEOTK37IkuQ2o/ibb4VbKMp1SzGs6rMh6YBeTWQW+OTXlY9Wmdh9
         SJYWAIk6EJmfz1C5eOfH5OoK5wHNuXJGsiEzV3RGfcs2lhSTS1xE5aidAi/3Ig/RUy1q
         5vJw==
X-Forwarded-Encrypted: i=1; AJvYcCXc/dMj0H2oV5m5NuzNzvNjpOvYaMZSK7h/QXIitAZjGVjFfUl5gfUhE4/pufSVyX6t5kA0t68tTbT7dgOIn3CQF4FJrhG9cZgd
X-Gm-Message-State: AOJu0Yy71xlXZiFgBqRATr/gQkQfP5ZIVwqSl0MCAEkpL0Gs9hK/O/AW
	RPJGYsxzdF26kf7jCDiGok9FOKyjutdV2d2BmPnrqa/vADOVauuDwHajFGKfhqs=
X-Google-Smtp-Source: AGHT+IG+tJgnNeX8A5ChbrSgXDuYb3kudcf3QBAiphyKUtKgJJjw7Q78kAbnwAtCrj2/WRtZtz86Qw==
X-Received: by 2002:a17:906:b894:b0:a66:b27:f9d4 with SMTP id a640c23a62f3a-a660b27fbaamr135561966b.42.1717082545053;
        Thu, 30 May 2024 08:22:25 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a660947c20fsm62189866b.175.2024.05.30.08.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 08:22:24 -0700 (PDT)
Message-ID: <c160155e-bf15-48fb-b4c1-bc8d7bf8776b@linaro.org>
Date: Thu, 30 May 2024 17:22:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/17] power: sequencing: implement the subsystem and
 add first users
To: Bartosz Golaszewski <brgl@bgdev.pl>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Amit Pundir <amit.pundir@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/05/2024 21:03, Bartosz Golaszewski wrote:
> Note: I am resending this series in its entirety once more for
> discussions and reviews. If there won't be any major objections, I'll
> then start sending individual bits and pieces to appropriate trees.
> 
> Merging strategy: The DT binding and DTS changes are a no-brainer, they
> can go through the wireless, regulator and arm-msm trees separately. The
> bluetooth and PCI changes have a build-time dependency on the power
> sequencing code. The bluetooth changes also have a run-time dependency on
> the PCI pwrctl part. In order to get it into next I plan to pick up the
> power sequencing code into my own tree and maintain it. I can then
> provide an immutable tag for the BT and PCI trees to pull. I wouldn't
> stress about the BT runtime dependency as it will be fixed once all
> changes are in next.
> 
> The actual cover letter follows:
> 
> --
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
>      pwrseq = devm_pwrseq_get(dev, "bluetooth");
> 
> The pwrseq core then knows that when the driver calls:
> 
>      pwrseq_power_on(pwrseq);
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
> Tested on RB5, sm8650-qrd, sm8650-hdk and sm8550-qrd.
> 
> Changelog:
> 
> Since v7:
> - added DTS changes for sm8650-hdk
> - added circular dependency detection for pwrseq units
> - fixed a KASAN reported use-after-free error in remove path
> - improve Kconfig descriptions
> - fix typos in bindings and Kconfig
> - fixed issues reported by smatch
> - fix the unbind path in PCI pwrctl
> - lots of minor improvements to the pwrseq core
> 
> Since v6:
> - kernel doc fixes
> - drop myself from the DT bindings maintainers list for ath12k
> - wait until the PCI bridge device is fully added before creating the
>    PCI pwrctl platform devices for its sub-nodes, otherwise we may see
>    sysfs and procfs attribute failures (due to duplication, we're
>    basically trying to probe the same device twice at the same time)
> - I kept the regulators for QCA6390's ath11k as required as they only
>    apply to this specific Qualcomm package
> 
> Since v5:
> - unify the approach to modelling the WCN WLAN/BT chips by always exposing
>    the PMU node on the device tree and making the WLAN and BT nodes become
>    consumers of its power outputs; this includes a major rework of the DT
>    sources, bindings and driver code; there's no more a separate PCI
>    pwrctl driver for WCN7850, instead its power-up sequence was moved
>    into the pwrseq driver common for all WCN chips
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
>      referred to back then as PCI power sequencing:
> 
> https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/
> 
> v3: RFC for the DT representation of the PMU supplying the WLAN and BT
>      modules inside the QCA6391 package (was largely separate from the
>      series but probably should have been called PATCH or RFC v3):
> 
> https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/
> 
> v4: Second attempt at the full series with changed scope (introduction of
>      the pwrseq subsystem, should have been RFC v4)
> 
> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/
> 
> v5: Two different ways of handling QCA6390 and WCN7850:
> 
> https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Bartosz Golaszewski (16):
>        regulator: dt-bindings: describe the PMU module of the QCA6390 package
>        regulator: dt-bindings: describe the PMU module of the WCN7850 package
>        dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
>        dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
>        dt-bindings: net: wireless: describe the ath12k PCI module
>        arm64: dts: qcom: sm8550-qrd: add the Wifi node
>        arm64: dts: qcom: sm8650-qrd: add the Wifi node
>        arm64: dts: qcom: qrb5165-rb5: add the Wifi node
>        power: sequencing: implement the pwrseq core
>        power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
>        PCI: hold the rescan mutex when scanning for the first time
>        PCI/pwrctl: reuse the OF node for power controlled devices
>        PCI/pwrctl: create platform devices for child OF nodes of the port node
>        PCI/pwrctl: add PCI power control core code
>        PCI/pwrctl: add a PCI power control driver for power sequenced devices
>        Bluetooth: qca: use the power sequencer for QCA6390
> 
> Neil Armstrong (1):
>        arm64: dts: qcom: sm8650-hdk: add the Wifi node
> 
>   .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   17 +
>   .../bindings/net/wireless/qcom,ath11k-pci.yaml     |   46 +
>   .../bindings/net/wireless/qcom,ath12k.yaml         |   99 ++
>   .../bindings/regulator/qcom,qca6390-pmu.yaml       |  185 ++++
>   MAINTAINERS                                        |    8 +
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |  103 +-
>   arch/arm64/boot/dts/qcom/sm8250.dtsi               |    2 +-
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   97 ++
>   arch/arm64/boot/dts/qcom/sm8550.dtsi               |    2 +-
>   arch/arm64/boot/dts/qcom/sm8650-hdk.dts            |   89 ++
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   89 ++
>   arch/arm64/boot/dts/qcom/sm8650.dtsi               |    2 +-
>   drivers/bluetooth/hci_qca.c                        |   74 +-
>   drivers/pci/Kconfig                                |    1 +
>   drivers/pci/Makefile                               |    1 +
>   drivers/pci/bus.c                                  |    9 +
>   drivers/pci/of.c                                   |   14 +-
>   drivers/pci/probe.c                                |    2 +
>   drivers/pci/pwrctl/Kconfig                         |   17 +
>   drivers/pci/pwrctl/Makefile                        |    6 +
>   drivers/pci/pwrctl/core.c                          |  137 +++
>   drivers/pci/pwrctl/pci-pwrctl-pwrseq.c             |   89 ++
>   drivers/pci/remove.c                               |    3 +-
>   drivers/power/Kconfig                              |    1 +
>   drivers/power/Makefile                             |    1 +
>   drivers/power/sequencing/Kconfig                   |   28 +
>   drivers/power/sequencing/Makefile                  |    6 +
>   drivers/power/sequencing/core.c                    | 1105 ++++++++++++++++++++
>   drivers/power/sequencing/pwrseq-qcom-wcn.c         |  336 ++++++
>   include/linux/pci-pwrctl.h                         |   51 +
>   include/linux/pwrseq/consumer.h                    |   56 +
>   include/linux/pwrseq/provider.h                    |   75 ++
>   32 files changed, 2717 insertions(+), 34 deletions(-)
> ---
> base-commit: 6dc544b66971c7f9909ff038b62149105272d26a
> change-id: 20240527-pwrseq-76fc025248a2
> 
> Best regards

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T


-- 
// Caleb (they/them)

