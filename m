Return-Path: <linux-pci+bounces-9019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99D91085E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072ED1C2308C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E891AED4C;
	Thu, 20 Jun 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AutipYDt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67D1AE093;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893851; cv=none; b=qm7oL/15LQOXD8fJ3ffk4zGvb1fbAhRtKBAwmiwyUL9mpABDYiFkNH2E7TzuPqj9hwEbmzzfGUSv2vBmEXS1BL2gQU2LTBqqRn2FVfs5ojw38+ksvJH6E6hJVIp/01dJiO7g4rZb2whaG3UQJG/0LR4Jy5UtmyQz7TzwBSwNsPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893851; c=relaxed/simple;
	bh=lFnvmyEqgdYMJeF8dWD9Fuq9BZ+u9+Ev069om7FPMpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=apoVPmhEOHRfcajFi2y8g9R364PHtl+XeiYECm80cFx6k6EW7Rf+gKRH02x3ndhC88xGH7PXlpx1nZTna9awKnulriuo1c1vVQrW3wwRKSZMALfuEa40KOM9vJ6VPYb83kJDEhS9Q650HnmOcr6oVclBAJUMmI7l8cbMs7YzX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AutipYDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E671C4AF0B;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893850;
	bh=lFnvmyEqgdYMJeF8dWD9Fuq9BZ+u9+Ev069om7FPMpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AutipYDt61pdZCchXMSoqgfIdvPa6FKNlhIbdWjsyMmefRUobYSzMDwsaDlyod2kv
	 sCAqR265rGA6cmHjiRX/iqw4Iqk36RSjWfZ+3ySyVatuPBKp2M1wRPmwzFf9XLTH9E
	 GoDQGMn/l7y4tHjhFyNij9Esy2NciNDerQmXvuJphkNx9mAlyMqlJcLFNj2qgKPy7E
	 FRFInMLlYQDRf8ye/ThTL3pQ8O3zaPnYVU22bzjphx0K2SuSbdId/iapNsodUAx523
	 +K3J38wVFzunMlN5qEtbaf17DADoKcPKWbXk0aRxVztFFunpGHuyDmDb1WhazTy3I/
	 4QAhhUTNKrDaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67D0FC39563;
	Thu, 20 Jun 2024 14:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 00/17] power: sequencing: implement the subsystem and
 add first users
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171889385042.4585.381673079448841277.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 14:30:50 +0000
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, quic_bgodavar@quicinc.com,
 quic_rjliao@quicinc.com, kvalo@kernel.org, jjohnson@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, bhelgaas@google.com,
 srinivas.kandagatla@linaro.org, quic_eberman@quicinc.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 dmitry.baryshkov@linaro.org, elder@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 quic_jjohnson@quicinc.com, ath12k@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 bartosz.golaszewski@linaro.org, kernel@quicinc.com,
 krzysztof.kozlowski@linaro.org, amit.pundir@linaro.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 May 2024 21:03:08 +0200 you wrote:
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
> [...]

Here is the summary with links:
  - [v8,01/17] regulator: dt-bindings: describe the PMU module of the QCA6390 package
    (no matching commit)
  - [v8,02/17] regulator: dt-bindings: describe the PMU module of the WCN7850 package
    (no matching commit)
  - [v8,03/17] dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
    https://git.kernel.org/bluetooth/bluetooth-next/c/251180e6dba5
  - [v8,04/17] dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on QCA6390
    (no matching commit)
  - [v8,05/17] dt-bindings: net: wireless: describe the ath12k PCI module
    (no matching commit)
  - [v8,06/17] arm64: dts: qcom: sm8550-qrd: add the Wifi node
    (no matching commit)
  - [v8,07/17] arm64: dts: qcom: sm8650-qrd: add the Wifi node
    (no matching commit)
  - [v8,08/17] arm64: dts: qcom: sm8650-hdk: add the Wifi node
    (no matching commit)
  - [v8,09/17] arm64: dts: qcom: qrb5165-rb5: add the Wifi node
    (no matching commit)
  - [v8,10/17] power: sequencing: implement the pwrseq core
    (no matching commit)
  - [v8,11/17] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
    (no matching commit)
  - [v8,12/17] PCI: hold the rescan mutex when scanning for the first time
    (no matching commit)
  - [v8,13/17] PCI/pwrctl: reuse the OF node for power controlled devices
    (no matching commit)
  - [v8,14/17] PCI/pwrctl: create platform devices for child OF nodes of the port node
    (no matching commit)
  - [v8,15/17] PCI/pwrctl: add PCI power control core code
    (no matching commit)
  - [v8,16/17] PCI/pwrctl: add a PCI power control driver for power sequenced devices
    (no matching commit)
  - [v8,17/17] Bluetooth: qca: use the power sequencer for QCA6390
    https://git.kernel.org/bluetooth/bluetooth-next/c/4029dba6b6f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



