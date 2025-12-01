Return-Path: <linux-pci+bounces-42362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D8AC97434
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 13:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 428014E2235
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781C30C378;
	Mon,  1 Dec 2025 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9HVmnAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B423EAA5;
	Mon,  1 Dec 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764592019; cv=none; b=q2+Vew2gensZRMFy3r0f8FZGJDcABXU5UIwz4e0PRKI+rUa8vFP1QFOoq041b3L/WEYoKIxxoQEfOPEOcsKGVeEU6qcgijOqlg5VOlaTAPikEZsB9GaqjxuhdYdS8SW8bsIJmSVzo7UAXpr/nZFfzc8+OYhCH/OQd1z0LuvrZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764592019; c=relaxed/simple;
	bh=+IDGYY9tGUu11EgKSvrhVIU134PWi+cKXyPFmJWNbzo=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Ifi5ugye+q0La/wnuCMYkESVgHF/klLFU3gu1fYPLWyaTOrKU50HDQEmtsOj3AoDO1dkOhh6jR7IiroFn1nnMKukaaWz8ZzdlRoJlQSuBFHoT27rd1bsC9QTtfIQhaIBqgm90OLdl1BEND3JvvDEAY/ly9kqPwYQ5RQ4yiiY6O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9HVmnAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2E1C4CEF1;
	Mon,  1 Dec 2025 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764592018;
	bh=+IDGYY9tGUu11EgKSvrhVIU134PWi+cKXyPFmJWNbzo=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=I9HVmnAqoppor3VGHlV4ElRF2YfAYcdgvGlRHtlUxkQUsASBgbdgOEtXV6AtYFoN+
	 7IYbsyQ8MC6HI5gT8rZoueRNzBZGbpomFF4Dn1j8Y4uyMF9QL258JQ9uo3Y3ajMnmc
	 Hv+Q+4VHuBhFHNutNnYBODQF2FQkeRSHzto8m2AxWcWAlWq/AMyN/ocUGe/j5tFI2E
	 akZYrw+kGg0wQeXaHykR8iYIaikM68F0o0gK8jIaUb1CFvq5mLWf0aD2X6V54FO3TV
	 b10AGDN0QWJkGmKUgKUCESofzxKnPqMurYzHDZ8NR0MnXVod6taw46B9tjjMRFlubQ
	 /MH4GnfRQdU0w==
From: Rob Herring <robh@kernel.org>
Date: Mon, 01 Dec 2025 06:26:56 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 cros-qcom-dts-watchers@chromium.org
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
References: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
Message-Id: <176459099396.2908493.10537721212595232836.robh@kernel.org>
Subject: Re: [PATCH 0/2] PCI: dwc: Program device-id


On Thu, 27 Nov 2025 21:00:50 +0530, Sushrut Shree Trivedi wrote:
> For some controllers, HW doesn't program the correct device-id
> leading to incorrect identification in lspci. For ex, QCOM
> controller SC7280 uses same device id as SM8250. This would
> cause issues while applying controller specific quirks.
> 
> So, program the correct device-id after reading it from the
> devicetree.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
> Sushrut Shree Trivedi (2):
>       PCI: dwc: Program device-id
>       arm64: dts: qcom: sc7280: Add PCIe device-id
> 
>  arch/arm64/boot/dts/qcom/sc7280.dtsi              | 2 ++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 ++
>  3 files changed, 11 insertions(+)
> ---
> base-commit: e26d26ba210e5371c153de892ae45a63b1a34ff8
> change-id: 20251126-program-device-id-2a5dd6cafe1b
> 
> Best regards,
> --
> Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: base-commit e26d26ba210e5371c153de892ae45a63b1a34ff8 not known, ignoring
 Base: attempting to guess base-commit...
 Base: tags/v6.18-rc6-196-gb3e528a5811b (exact match)
 Base: tags/v6.18-rc6-196-gb3e528a5811b (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com:

arch/arm64/boot/dts/qcom/.qcm6490-idp.dtb.cmd:52: *** missing separator.  Stop.
make[2]: *** [scripts/Makefile.build:556: arch/arm64/boot/dts/qcom] Error 2
make[2]: Target 'arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1478: qcom/ipq5018-rdp432-c2.dtb] Error 2
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'qcom/apq8096-ifc6640.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-j3ltetw.dtb' not remade because of errors.
make: Target 'qcom/msm8998-fxtec-pro1.dtb' not remade because of errors.
make: Target 'qcom/sm7325-nothing-spacewar.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-asus-zenbook-a14.dtb' not remade because of errors.
make: Target 'qcom/sm7125-xiaomi-curtana.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-dell-xps13-9345.dtb' not remade because of errors.
make: Target 'qcom/msm8998-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-a5u-eur.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-lenovo-thinkpad-x13s.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r3-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-crd-pro.dtb' not remade because of errors.
make: Target 'qcom/sm6115p-lenovo-j606f.dtb' not remade because of errors.
make: Target 'qcom/msm8998-sony-xperia-yoshino-maple.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp454.dtb' not remade because of errors.
make: Target 'qcom/qcs6490-rb3gen2.dtb' not remade because of errors.
make: Target 'qcom/msm8992-xiaomi-libra.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r4.dtb' not remade because of errors.
make: Target 'qcom/sdm450-motorola-ali.dtb' not remade because of errors.
make: Target 'qcom/x1e78100-lenovo-thinkpad-t14s-oled.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-quackingstick-r0.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel360-wifi.dtb' not remade because of errors.
make: Target 'qcom/sdm630-sony-xperia-ganges-kirin.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-coachz-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-dell-latitude-7455.dtb' not remade because of errors.
make: Target 'qcom/sdm845-lg-judyp.dtb' not remade because of errors.
make: Target 'qcom/msm8939-wingtech-wt82918.dtb' not remade because of errors.
make: Target 'qcom/qrb2210-rb1.dtb' not remade because of errors.
make: Target 'qcom/msm8996-mtp.dtb' not remade because of errors.
make: Target 'qcom/sm8750-mtp.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-zombie.dtb' not remade because of errors.
make: Target 'qcom/msm8992-lg-bullhead-rev-10.dtb' not remade because of errors.
make: Target 'qcom/qrb5165-rb5.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-lenovo-yoga-slim7x.dtb' not remade because of errors.
make: Target 'qcom/sm8550-qrd.dtb' not remade because of errors.
make: Target 'qcom/sdm630-sony-xperia-nile-discovery.dtb' not remade because of errors.
make: Target 'qcom/sm8550-sony-xperia-yodo-pdx234.dtb' not remade because of errors.
make: Target 'qcom/msm8939-huawei-kiwi.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-microsoft-arcata.dtb' not remade because of errors.
make: Target 'qcom/sdm845-oneplus-fajita.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb' not remade because of errors.
make: Target 'qcom/sdm660-xiaomi-lavender.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-coachz-r1.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r10.dtb' not remade because of errors.
make: Target 'qcom/msm8939-wingtech-wt82918hd.dtb' not remade because of errors.
make: Target 'qcom/ipq6018-cp01-c1.dtb' not remade because of errors.
make: Target 'qcom/sm8250-samsung-x1q.dtb' not remade because of errors.
make: Target 'qcom/msm8916-motorola-surnia.dtb' not remade because of errors.
make: Target 'qcom/sm8350-microsoft-surface-duo2.dtb' not remade because of errors.
make: Target 'qcom/qcm6490-idp.dtb' not remade because of errors.
make: Target 'qcom/sm8550-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-a3u-eur.dtb' not remade because of errors.
make: Target 'qcom/sdm845-sony-xperia-tama-akari.dtb' not remade because of errors.
make: Target 'qcom/x1p42100-crd.dtb' not remade because of errors.
make: Target 'qcom/sm8250-mtp.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb' not remade because of errors.
make: Target 'qcom/sm8250-xiaomi-elish-csot.dtb' not remade because of errors.
make: Target 'qcom/msm8916-wingtech-wt88047.dtb' not remade because of errors.
make: Target 'qcom/msm8916-thwc-ufi001c.dtb' not remade because of errors.
make: Target 'qcom/msm8998-xiaomi-sagit.dtb' not remade because of errors.
make: Target 'qcom/qcm6490-particle-tachyon.dtb' not remade because of errors.
make: Target 'qcom/qcs8550-aim300-aiot.dtb' not remade because of errors.
make: Target 'qcom/sdm450-lenovo-tbx605f.dtb' not remade because of errors.
make: Target 'qcom/sm8250-xiaomi-elish-boe.dtb' not remade because of errors.
make: Target 'qcom/qcs404-evb-4000.dtb' not remade because of errors.
make: Target 'qcom/qcs9100-ride.dtb' not remade because of errors.
make: Target 'qcom/msm8996-sony-xperia-tone-kagura.dtb' not remade because of errors.
make: Target 'qcom/sm8150-sony-xperia-kumano-griffin.dtb' not remade because of errors.
make: Target 'qcom/sdm670-google-sargo.dtb' not remade because of errors.
make: Target 'qcom/x1e001de-devkit.dtb' not remade because of errors.
make: Target 'qcom/sa8775p-ride.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-crd.dtb' not remade because of errors.
make: Target 'qcom/ipq5424-rdp466.dtb' not remade because of errors.
make: Target 'qcom/sc8180x-lenovo-flex-5g.dtb' not remade because of errors.
make: Target 'qcom/sdm845-lg-judyln.dtb' not remade because of errors.
make: Target 'qcom/msm8953-flipkart-rimob.dtb' not remade because of errors.
make: Target 'qcom/sm6125-xiaomi-ginkgo.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r3-kb.dtb' not remade because of errors.
make: Target 'qcom/msm8916-motorola-osprey.dtb' not remade because of errors.
make: Target 'qcom/sm8250-xiaomi-pipa.dtb' not remade because of errors.
make: Target 'qcom/sdm845-oneplus-enchilada.dtb' not remade because of errors.
make: Target 'qcom/msm8956-sony-xperia-loire-suzu.dtb' not remade because of errors.
make: Target 'qcom/sc7280-idp.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-evoker-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-homestar-r4.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-rossa.dtb' not remade because of errors.
make: Target 'qcom/apq8039-t2.dtb' not remade because of errors.
make: Target 'qcom/msm8916-motorola-harpia.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-e5.dtb' not remade because of errors.
make: Target 'qcom/sc7280-idp2.dtb' not remade because of errors.
make: Target 'qcom/msm8939-sony-xperia-kanuti-tulip.dtb' not remade because of errors.
make: Target 'qcom/sm8250-samsung-r8q.dtb' not remade because of errors.
make: Target 'qcom/ipq8074-hk01.dtb' not remade because of errors.
make: Target 'qcom/sm8150-mtp.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp433.dtb' not remade because of errors.
make: Target 'qcom/sdm845-sony-xperia-tama-apollo.dtb' not remade because of errors.
make: Target 'qcom/msm8998-lenovo-miix-630.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-karin.dtb' not remade because of errors.
make: Target 'qcom/sdm630-sony-xperia-nile-pioneer.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-grandmax.dtb' not remade because of errors.
make: Target 'qcom/msm8916-alcatel-idol347.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp453.dtb' not remade because of errors.
make: Target 'qcom/sc7180-acer-aspire1.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-r1.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-e7.dtb' not remade because of errors.
make: Target 'qcom/ipq5018-rdp432-c2.dtb' not remade because of errors.
make: Target 'qcom/apq8016-schneider-hmibsc.dtb' not remade because of errors.
make: Target 'qcom/qrb4210-rb2.dtb' not remade because of errors.
make: Target 'qcom/x1p42100-hp-omnibook-x14.dtb' not remade because of errors.
make: Target 'qcom/ipq5018-tplink-archer-ax55-v1.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-evoker.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-kingoftown.dtb' not remade because of errors.
make: Target 'qcom/sm4450-qrd.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-j5.dtb' not remade because of errors.
make: Target 'qcom/msm8998-asus-novago-tp370ql.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r2-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8992-lg-h815.dtb' not remade because of errors.
make: Target 'qcom/sdx75-idp.dtb' not remade because of errors.
make: Target 'qcom/sm8350-sony-xperia-sagami-pdx215.dtb' not remade because of errors.
make: Target 'qcom/apq8096-db820c.dtb' not remade because of errors.
make: Target 'qcom/msm8996-sony-xperia-tone-keyaki.dtb' not remade because of errors.
make: Target 'qcom/msm8916-longcheer-l8150.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-suzuran.dtb' not remade because of errors.
make: Target 'qcom/sdm845-mtp.dtb' not remade because of errors.
make: Target 'qcom/sm6375-sony-xperia-murray-pdx225.dtb' not remade because of errors.
make: Target 'qcom/msm8916-yiming-uz801v3.dtb' not remade because of errors.
make: Target 'qcom/qcs9100-ride-r3.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-hp-omnibook-x14.dtb' not remade because of errors.
make: Target 'qcom/msm8953-xiaomi-vince.dtb' not remade because of errors.
make: Target 'qcom/ipq5332-rdp441.dtb' not remade because of errors.
make: Target 'qcom/msm8992-lg-bullhead-rev-101.dtb' not remade because of errors.
make: Target 'qcom/msm8917-xiaomi-riva.dtb' not remade because of errors.
make: Target 'qcom/msm8996-xiaomi-gemini.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r9.dtb' not remade because of errors.
make: Target 'qcom/msm8998-sony-xperia-yoshino-lilac.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-gprimeltecan.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel360-lte.dtb' not remade because of errors.
make: Target 'qcom/sdm845-shift-axolotl.dtb' not remade because of errors.
make: Target 'qcom/msm8996-oneplus3t.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-zombie-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r3.dtb' not remade because of errors.
make: Target 'qcom/monaco-evk.dtb' not remade because of errors.
make: Target 'qcom/sar2130p-qar2130p.dtb' not remade because of errors.
make: Target 'qcom/sm8650-hdk.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-herobrine-r1.dtb' not remade because of errors.
make: Target 'qcom/msm8916-longcheer-l8910.dtb' not remade because of errors.
make: Target 'qcom/sdm630-sony-xperia-nile-voyager.dtb' not remade because of errors.
make: Target 'qcom/sm8450-hdk.dtb' not remade because of errors.
make: Target 'qcom/msm8929-wingtech-wt82918hd.dtb' not remade because of errors.
make: Target 'qcom/sm8250-sony-xperia-edo-pdx203.dtb' not remade because of errors.
make: Target 'qcom/sm8350-hdk.dtb' not remade because of errors.
make: Target 'qcom/ipq8074-hk10-c1.dtb' not remade because of errors.
make: Target 'qcom/sm8450-qrd.dtb' not remade because of errors.
make: Target 'qcom/msm8916-lg-c50.dtb' not remade because of errors.
make: Target 'qcom/sm8250-sony-xperia-edo-pdx206.dtb' not remade because of errors.
make: Target 'qcom/sm7225-fairphone-fp4.dtb' not remade because of errors.
make: Target 'qcom/sa8155p-adp.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-qcp.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r1-kb.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-grandprimelte.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-zombie-nvme-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-homestar-r3.dtb' not remade because of errors.
make: Target 'qcom/ipq5332-rdp474.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-asus-vivobook-s15.dtb' not remade because of errors.
make: Target 'qcom/sm8150-microsoft-surface-duo.dtb' not remade because of errors.
make: Target 'qcom/msm8996pro-xiaomi-scorpio.dtb' not remade because of errors.
make: Target 'qcom/x1e78100-lenovo-thinkpad-t14s.dtb' not remade because of errors.
make: Target 'qcom/sm8150-hdk.dtb' not remade because of errors.
make: Target 'qcom/sc8180x-primus.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r10-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-j5x.dtb' not remade because of errors.
make: Target 'qcom/x1p42100-asus-zenbook-a14.dtb' not remade because of errors.
make: Target 'qcom/sc7180-idp.dtb' not remade because of errors.
make: Target 'qcom/msm8916-mtp.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-hp-elitebook-ultra-g1q.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-r10.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-zombie-nvme.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-microsoft-romulus15.dtb' not remade because of errors.
make: Target 'qcom/qru1000-idp.dtb' not remade because of errors.
make: Target 'qcom/msm8998-hp-envy-x2.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel-parade.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r9-kb.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb' not remade because of errors.
make: Target 'qcom/qcs615-ride.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-coachz-r3-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7280-crd-r3.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-gt58.dtb' not remade because of errors.
make: Target 'qcom/sa8775p-ride-r3.dtb' not remade because of errors.
make: Target 'qcom/sm8450-samsung-r0q.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-villager-r1.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel-ti.dtb' not remade because of errors.
make: Target 'qcom/qcm6490-shift-otter.dtb' not remade because of errors.
make: Target 'qcom/hamoa-iot-evk.dtb' not remade because of errors.
make: Target 'qcom/qcs8300-ride.dtb' not remade because of errors.
make: Target 'qcom/apq8016-sbc.dtb' not remade because of errors.
make: Target 'qcom/msm8996pro-xiaomi-natrium.dtb' not remade because of errors.
make: Target 'qcom/sdm845-samsung-starqltechn.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8953-xiaomi-tissot.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-dell-inspiron-14-plus-7441.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r9.dtb' not remade because of errors.
make: Target 'qcom/sm6125-xiaomi-laurel-sprout.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-sumire.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-serranove.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-coachz-r3.dtb' not remade because of errors.
make: Target 'qcom/sdm845-sony-xperia-tama-akatsuki.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp449.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8916-lg-m216.dtb' not remade because of errors.
make: Target 'qcom/lemans-evk.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-crd.dtb' not remade because of errors.
make: Target 'qcom/x1p42100-lenovo-thinkbook-16.dtb' not remade because of errors.
make: Target 'qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r9-lte.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel-lte-ti.dtb' not remade because of errors.
make: Target 'qcom/msm8996-sony-xperia-tone-dora.dtb' not remade because of errors.
make: Target 'qcom/sa8295p-adp.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-ivy.dtb' not remade because of errors.
make: Target 'qcom/sdm845-xiaomi-beryllium-ebbg.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r3.dtb' not remade because of errors.
make: Target 'qcom/msm8998-oneplus-dumpling.dtb' not remade because of errors.
make: Target 'qcom/sm8650-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8996-oneplus3.dtb' not remade because of errors.
make: Target 'qcom/sm8550-hdk.dtb' not remade because of errors.
make: Target 'qcom/x1e80100-microsoft-romulus13.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8939-samsung-a7.dtb' not remade because of errors.
make: Target 'qcom/qcm6490-fairphone-fp5.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-huawei-gaokun3.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb' not remade because of errors.
make: Target 'qcom/msm8953-xiaomi-mido.dtb' not remade because of errors.
make: Target 'qcom/msm8916-asus-z00l.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r2.dtb' not remade because of errors.
make: Target 'qcom/sm6350-sony-xperia-lena-pdx213.dtb' not remade because of errors.
make: Target 'qcom/sdm632-fairphone-fp3.dtb' not remade because of errors.
make: Target 'qcom/msm8953-motorola-potter.dtb' not remade because of errors.
make: Target 'qcom/sda660-inforce-ifc6560.dtb' not remade because of errors.
make: Target 'qcom/sm8150-sony-xperia-kumano-bahamut.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pazquel-lte-parade.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-homestar-r2.dtb' not remade because of errors.
make: Target 'qcom/sm8250-hdk.dtb' not remade because of errors.
make: Target 'qcom/sm8650-qrd.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-microsoft-blackrock.dtb' not remade because of errors.
make: Target 'qcom/ipq8074-hk10-c2.dtb' not remade because of errors.
make: Target 'qcom/msm8953-xiaomi-daisy.dtb' not remade because of errors.
make: Target 'qcom/sc8280xp-crd.dtb' not remade because of errors.
make: Target 'qcom/sdm850-samsung-w737.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb' not remade because of errors.
make: Target 'qcom/msm8916-samsung-gt510.dtb' not remade because of errors.
make: Target 'qcom/sdm850-lenovo-yoga-c630.dtb' not remade because of errors.
make: Target 'qcom/msm8916-thwc-uf896.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r10-kb.dtb' not remade because of errors.
make: Target 'qcom/msm8994-sony-xperia-kitakami-satsuki.dtb' not remade because of errors.
make: Target 'qcom/sdm632-motorola-ocean.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-villager-r1-lte.dtb' not remade because of errors.
make: Target 'qcom/sm6115-fxtec-pro1x.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r3-lte.dtb' not remade because of errors.
make: Target 'qcom/msm8998-sony-xperia-yoshino-poplar.dtb' not remade because of errors.
make: Target 'qcom/msm8916-huawei-g7.dtb' not remade because of errors.
make: Target 'qcom/msm8916-wingtech-wt86518.dtb' not remade because of errors.
make: Target 'qcom/sm8350-sony-xperia-sagami-pdx214.dtb' not remade because of errors.
make: Target 'qcom/msm8916-wingtech-wt86528.dtb' not remade because of errors.
make: Target 'qcom/sdm845-db845c.dtb' not remade because of errors.
make: Target 'qcom/sa8540p-ride.dtb' not remade because of errors.
make: Target 'qcom/msm8939-longcheer-l9100.dtb' not remade because of errors.
make: Target 'qcom/qdu1000-idp.dtb' not remade because of errors.
make: Target 'qcom/sm8550-samsung-q5q.dtb' not remade because of errors.
make: Target 'qcom/msm8992-msft-lumia-octagon-talkman.dtb' not remade because of errors.
make: Target 'qcom/msm8916-gplus-fl8005a.dtb' not remade because of errors.
make: Target 'qcom/sm8350-mtp.dtb' not remade because of errors.
make: Target 'qcom/msm8956-sony-xperia-loire-kugo.dtb' not remade because of errors.
make: Target 'qcom/msm8976-longcheer-l9360.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-r1.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-pompom-r1.dtb' not remade because of errors.
make: Target 'qcom/msm8998-oneplus-cheeseburger.dtb' not remade because of errors.
make: Target 'qcom/sc7280-herobrine-villager-r0.dtb' not remade because of errors.
make: Target 'qcom/sm8750-qrd.dtb' not remade because of errors.
make: Target 'qcom/sm4250-oneplus-billie2.dtb' not remade because of errors.
make: Target 'qcom/sdm636-sony-xperia-ganges-mermaid.dtb' not remade because of errors.
make: Target 'qcom/qcs404-evb-1000.dtb' not remade because of errors.
make: Target 'qcom/ipq5332-rdp442.dtb' not remade because of errors.
make: Target 'qcom/msm8994-msft-lumia-octagon-cityman.dtb' not remade because of errors.
make: Target 'qcom/msm8916-acer-a1-724.dtb' not remade because of errors.
make: Target 'qcom/sdm845-xiaomi-beryllium-tianma.dtb' not remade because of errors.
make: Target 'qcom/sm6125-sony-xperia-seine-pdx201.dtb' not remade because of errors.
make: Target 'qcom/sdm845-xiaomi-polaris.dtb' not remade because of errors.
make: Target 'qcom/ipq9574-rdp418.dtb' not remade because of errors.
make: Target 'qcom/msm8216-samsung-fortuna3g.dtb' not remade because of errors.
make: Target 'qcom/sm8450-sony-xperia-nagara-pdx223.dtb' not remade because of errors.
make: Target 'qcom/sm8450-sony-xperia-nagara-pdx224.dtb' not remade because of errors.
make: Target 'qcom/sm7125-xiaomi-joyeuse.dtb' not remade because of errors.
make: Target 'qcom/msm8994-huawei-angler-rev-101.dtb' not remade because of errors.
make: Target 'qcom/ipq5332-rdp468.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-lazor-limozeen-nots-r10.dtb' not remade because of errors.
make: Target 'qcom/sc7180-trogdor-quackingstick-r0-lte.dtb' not remade because of errors.






