Return-Path: <linux-pci+bounces-39474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F7C11C77
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A5B3353526
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B59340D91;
	Mon, 27 Oct 2025 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0W+ZAG2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9533EB0C;
	Mon, 27 Oct 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604513; cv=none; b=dM1JwlgzZdJPp/yBWvY3Y35bbauguJTNdMkyzwL5+xNOZqzustNN8HGhaO6WDFUpE+DNqSIg/CLDTaTirjHEhSYSBTEZgQczbXEacy91aVFEduN9wdaYy7hRoCcsqGqDMoXqeNON9qvIrLz3NMef4yVeCtDpe75/hh5sxTfJsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604513; c=relaxed/simple;
	bh=8d8T0fVc3CjMiXz7m56xc6NAEMg4W2X4YzFd3c3H4FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjDKioRrEMbDzLckB+pbkgzFFDas2F6whoG0wYmAmShKp52oMmDXDKqdwrw5yf85vris7VIi+0X2Y4BdqSMQ8vCWwgImG9IZ2jhE1bykjKdabhvva/VpHmqrZZNXR9TuVzm/XVe4GQmUwPCNq06kgG7Qk4XBaLBcn5ReHrJiDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0W+ZAG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B64C4CEFB;
	Mon, 27 Oct 2025 22:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761604513;
	bh=8d8T0fVc3CjMiXz7m56xc6NAEMg4W2X4YzFd3c3H4FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0W+ZAG2oU7yEc3Y0S0vR+iiv/RFKRDFOfI6d1LWXbtmx6eMlCOrkb9qD1w3qOD+S
	 u8KPBjcVsSBo3uNllxHFWJlKP1CnqbWowyrVE3rECJe+Jc+Nc+aL9+XeYhvXTryxG+
	 9m6/aDQ2+u6uU8E2gmtZpybU6bDgFx74cYuAu9c5IqBpTJx9pyxXYXXPUqtx0JO/jv
	 cUml4vfvx04wRd9Nzap9bFaY+i2lmIkwC0bzxWtp1B6l/9Puun3hRu2SfAg0Brdsl1
	 T0GsyBf0YBktlBL6WYr2AZYpqETSi1gtajb2TA4Mvo8QM9WZExvtp4lhxleVEAfo95
	 dM3x6CZw8kxYg==
From: Bjorn Andersson <andersson@kernel.org>
To: cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com,
	quic_vpernami@quicinc.com,
	mmareddy@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v8 0/5] PCI: dwc: Add ECAM support with iATU configuration
Date: Mon, 27 Oct 2025 17:37:06 -0500
Message-ID: <176160465177.73268.9869510926279916233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 28 Aug 2025 13:04:21 +0530, Krishna Chaitanya Chundru wrote:
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> would be matched against the Base and Limit addresses) of the incoming
> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
      commit: 03e928442d469f7d8dafc549638730647202d9ce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

