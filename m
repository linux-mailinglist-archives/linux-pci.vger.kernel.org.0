Return-Path: <linux-pci+bounces-3370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B44851FA6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 22:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062C4285098
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 21:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FCD4CE18;
	Mon, 12 Feb 2024 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhJpNc53"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3174EB35;
	Mon, 12 Feb 2024 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773539; cv=none; b=B8c5UsOj9T9qoRjj7EU49Fqq+hs/5jDsv+bgPTRuekCQKTp7OPF8iPze51xjxvr/QYctT2Sidzu9WgphQ0XAW11qGh1ZKgY7z7YaGQXJgbL+bTkKpYsgNacxuD+0cJWQeCDitLh9Gfy1tS5F+6apvjk2eIEvJbCentcIKBfw5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773539; c=relaxed/simple;
	bh=FYSTPAl8BA0rERUjwLoiIkMN4CipOjAn7ze5V8Zg8Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qsnBjdpz8Js+WuvAfLDcV9tGgtLtJcbELTHPW1YWZZdCRsueOB70y5rPZXrdp4/gOOkllMWmSWa8/8aTDDs3fap++TX/PWV/U9pDDAYb6FZ8bKc1AGsiT1T1QymLeYu5uBhUja/M5zbZtTRrGjLY7L8Rk2z2C0q0dn05whxAY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhJpNc53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966DBC433F1;
	Mon, 12 Feb 2024 21:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707773538;
	bh=FYSTPAl8BA0rERUjwLoiIkMN4CipOjAn7ze5V8Zg8Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XhJpNc53Ub0QKZ+KSDZUPOW9DERkY3dq+UG+uP3dmNmEwJTwZnIRdDEAyhkizfJjW
	 amJIRrp9pUr/gYbkmd6OXhMCLwWJd4487kkhuxdK8v31GhPSxPG5K908ll8tihz9VJ
	 qIACpvrkjhyKHTAkfGeIyWZrHowHqdlYWGKvRsavHp/5GUZvSe7d6AWu19HlzQnBf1
	 aySA6khM7R9Rc3M3RWaW+OR8cTo1ypEygBCBZDDLAqGlt9YOhVBKsp2QC34rEHxqAL
	 KWV8yELZwiH44tiAp/iVYqkP1OXOqvqYOI7q78Kf2ITeKAAY5UXAXlVyRpmYXtM7N1
	 Ko2/3srkpBjxw==
Date: Mon, 12 Feb 2024 15:32:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 3/3] PCI: qcom: properly implement RC shutdown/power up
Message-ID: <20240212213216.GA1145794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-topic-8280_pcie-v2-3-1cef4b606883@linaro.org>

"Properly" is a noise word that suggests "we're doing it right this
time" but doesn't hint at what actually makes this better.

On Sat, Feb 10, 2024 at 06:10:07PM +0100, Konrad Dybcio wrote:
> Currently, we've only been minimizing the power draw while keeping the
> RC up at all times. This is suboptimal, as it draws a whole lot of power
> and prevents the SoC from power collapsing.

Is "power collapse" a technical term specific to this device, or is
there some more common term that could be used?  I assume the fact
that the RC remains powered precludes some lower power state of the
entire SoC?

> Implement full shutdown and re-initialization to allow for powering off
> the controller.
> 
> This is mainly indended for SC8280XP with a broken power rail setup,
> which requires a full RC shutdown/reinit in order to reach SoC-wide
> power collapse, but sleeping is generally better than not sleeping and
> less destructive suspend can be implemented later for platforms that
> support it.

s/indended/intended/

>  config PCIE_QCOM
>  	bool "Qualcomm PCIe controller (host mode)"
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> +	depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n

Just out of curiosity since I'm not a Kconfig expert, what does
"depends on X || X=n" mean?  

I guess it's different from
"depends on (QCOM_COMMAND_DB || !QCOM_COMMAND_DB)", which I also see
used for QCOM_RPMH?

Does this reduce compile testing?  I see COMPILE_TEST mentioned in a
few other QCOM_COMMAND_DB dependencies.

> +	ret_l23 = readl_poll_timeout(pcie->parf + PARF_PM_STTS, val,
> +				     val & PM_ENTER_L23, 10000, 100000);

Are these timeout values rooted in some PCIe or Qcom spec?  Would be
nice to have a spec citation or other reason for choosing these
values.

> +	reset_control_assert(res->rst);
> +	usleep_range(2000, 2500);

Ditto, some kind of citation would be nice.

Bjorn

