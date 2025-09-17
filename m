Return-Path: <linux-pci+bounces-36338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A58B7E02F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7327D1BC5523
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61C34F462;
	Wed, 17 Sep 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCxD/Qso"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C330B53A;
	Wed, 17 Sep 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103840; cv=none; b=qqxxwt3J0Bbhw5ddjJdTwCONJm/NSR6BvjSF/+jsP9infQGTz7hR5bmiVOG7wwYcINVd4nx12+zo4weARK/VQ+T0R5OYhNu8Mwnlbf4/NZkepSOyUFuVcd+Kg+Eb98Hx6K/Qte7AHjR9UDf/WwJqbu08jXBM7nt14eBQiG1jNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103840; c=relaxed/simple;
	bh=fxBhSVRS6bOcA+leORFJ7MYoYKjXLh84X9wt1eKH1Rs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hy1bSFc5LgsklH5YvKyYIeWkQEz+mHsgYCWjHzHRZmZLsftVmbSn6mkjCmMU7gS4nhmSNmsvcuz7ayuPZ7/OSpe9zgDF9/QN5YjQymvyZ6M8ymDVQlZya/PlDaiWr0I5rVEKj6EF1brJpHMpooLsg+dKIqvoI3KuBZ+eliz4Hb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCxD/Qso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7448C4CEF0;
	Wed, 17 Sep 2025 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758103840;
	bh=fxBhSVRS6bOcA+leORFJ7MYoYKjXLh84X9wt1eKH1Rs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dCxD/QsoJpVub0T44kKAemN+6+9BP0qsd0yiyTWphn1SNJpmT768/IGiPvbsLlFr8
	 2CxRJ4ZeSSyq6YfI9tzCq9QsLnAgglEWRbaBMfJMNTERD6+u1PSyPAk8NhEqEZ+9vd
	 qHt9e6Dv4HnQR+IKixDefLcpMI0mz+uW4Wo5e8Wkx2CU5U64DvpxQiHFN/KslkbcXD
	 5dEgNRDMZv2bRtdKY26PtAGgzUuu3+7917+/93PGWrgluhjUJXI6JTeiT8GMBDBzvV
	 0a1MzKpad/RIc/jkG7a+AApACp5bh8tJC/ALL13zyHsq3rtTs/tAVPnFyi4447h3mg
	 z1nBtV3JIRO5g==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, Bjorn Helgaas <helgaas@kernel.org>
In-Reply-To: <20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com>
References: <20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/4] PCI/pwrctrl: Allow pwrctrl framework
 to control PERST# if available
Message-Id: <175810383525.37722.6338178642788441926.b4-ty@kernel.org>
Date: Wed, 17 Sep 2025 15:40:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 12 Sep 2025 14:05:00 +0530, Manivannan Sadhasivam wrote:
> This series is the proper version for toggling PERST# from the pwrctrl
> framework after the initial RFC posted earlier [1].
> 
> Problem statement
> =================
> 
> Pwrctrl framework is intented to control the supplies to the components on the
> PCI bus. However, if the platform supports the PERST# signal, it should be
> toggled as per the requirements in the electromechanical specifications like
> PCIe CEM, Mini, and M.2. Since the pwrctrl framework is controlling the power
> supplies, it should also toggle PERST# as per the requirements in the above
> mentioned specifications. Right now, it is just controlling the power to the
> components and rely on controller drivers to toggle PERST#, which goes against
> the specs. For instance, controller drivers will deassert PERST# even before the
> pwrctrl driver enables the supplies. This causes the device to see PERST#
> deassert immediately after power on, thereby violating the delay requirements in
> the PCI Electromechanical specs.
> 
> [...]

Applied, thanks!

[2/4] PCI: qcom: Move host bridge 'phy' and 'reset' pointers to struct qcom_pcie_port
      commit: af8df709bf365f5583d31091280354e1ef0b201f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


