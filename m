Return-Path: <linux-pci+bounces-15087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01B9ABCCA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 06:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5551C22C73
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 04:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240361531EF;
	Wed, 23 Oct 2024 04:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/9AMxLQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95681531D5;
	Wed, 23 Oct 2024 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656982; cv=none; b=Iq5Nuc7M+po3LlnEs6QBpJkyljq+jD9F2Xg1CHiTnBDsCIH7uNf/HeCEv2NmyHlenhBewTt70QKskxBGJSw5yD9XfNsKWHRvP5HJ08QYT6nbc0wFBF3TuR/F/+ReMi7AIIs5R1n7jomEyd6gbvsSpqLQMk5lMVyborVmDCM8R0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656982; c=relaxed/simple;
	bh=K2Km0MA/CydEwXnO08OoydV2jYx7vunjjMa5JkF9eUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcaDoyrFBAK+Aa5jOcNHGoLOPQqVhvq4DVejZSPIu/aP0HyGKDzwAQ6rKTHu6JQYB3Dgaw3s+3ZaK6gOn5SQbPkyiOYG8HvMcW0wqYaDiqdu4AT0WqlAlpohxc+3CFj6LN0OfoVuKHdn0czXh1QTCs+zPNvAimuyRsBhazxQQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/9AMxLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03CCC4CEE7;
	Wed, 23 Oct 2024 04:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729656981;
	bh=K2Km0MA/CydEwXnO08OoydV2jYx7vunjjMa5JkF9eUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/9AMxLQMD/ii018Bz/pU2ecVtX2E5y6odmm9GnSqbeqzeLMQxKLnbDT6yvzBCJJt
	 6QIAWl6z9kYCRYAxNPuwY0f8PH9mGpu/geQosFrJFUu71RLnRyCgQb5pjyakDklnPX
	 CJmpEebBftRFCr6b9kfuNG8p8EPRkkElk4+0af2sgq0+RzTBuuZ1cmRmusE9q5WyWL
	 UoAd4mVFoJsZK5Uej4X9MXfmcl+TPgQ6Gypta7y5x3Oggr4ddRyacDA6I2ASVf1XU8
	 +9/KDYHcwmea0mBMW487J0hzlcqqizw9haEb2Aq1vo1KE1H/5gmS6umWAH0a/IQ9pZ
	 b1ByMN1ejLjtQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/12] PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt
Date: Tue, 22 Oct 2024 23:15:58 -0500
Message-ID: <172965696407.224417.4025107228766337178.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 28 Aug 2024 21:16:10 +0530, Manivannan Sadhasivam wrote:
> This series adds support to enumerate the PCIe endpoint devices using the Qcom
> specific 'Link up' event in 'global' IRQ. Historically, Qcom PCIe RC controllers
> lacked standard hotplug support. So when an endpoint is attached to the SoC,
> users have to rescan the bus manually to enumerate the device. But this can be
> avoided by rescanning the bus upon receiving 'Link up' event.
> 
> Qcom PCIe RC controllers are capable of generating the 'global' SPI interrupt
> to the host CPUs. The device driver can use this interrupt to identify events
> such as PCIe link specific events, safety events etc...
> 
> [...]

Applied, thanks!

[09/12] arm64: dts: qcom: sa8775p: Add 'linux,pci-domain' to PCIe EP controller nodes
        commit: 9e8f38da6e240a71b860c4a895ea583f63964c45
[12/12] arm64: dts: qcom: sm8450: Add 'global' interrupt to the PCIe RC node
        commit: 7dc36be39c96f00d0d7c577cc91ff6b108b1d444

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

