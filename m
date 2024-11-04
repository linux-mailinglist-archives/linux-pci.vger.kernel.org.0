Return-Path: <linux-pci+bounces-15966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD779BB7C8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A69284C21
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29660185B4D;
	Mon,  4 Nov 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI6LSM0r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56F72AEFE;
	Mon,  4 Nov 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730562; cv=none; b=mhaRqLfuaz4z6RYWJOELftbD9wC6o/87QDJhYc2g9wceFENrOzUpLnWI7L6wInRzt3knR2X05+VsNJAOivMXKQx+LjUIEoZx2PcbNGJrrX4iOQvpgy+zkouzxpaE8ByXzz89TGNC3buGrw8lfvsfnU3UhGoklDTfNGr+reszbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730562; c=relaxed/simple;
	bh=EXddGjljuXfiyst3teC3kH4+6NzpEAOhemaF87o1HEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPXi1QezbWb6c5W5Q4siHcHgO6jtVmmx+cgibA4C4gQXSmsmp7UhTH/ZsHkrZKk3vqtuS/oEVvPhoBp08vMig3amzI1ghA9w6MsvG+IL282eLGFVEAyk82iBLi6xtqRiBwObBhOe69f8oizMQzvQGVapi0uyFnyWgSzUfYjSd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI6LSM0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4ADC4CECE;
	Mon,  4 Nov 2024 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730730561;
	bh=EXddGjljuXfiyst3teC3kH4+6NzpEAOhemaF87o1HEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VI6LSM0rNQv+75kEV8qCjeTF/lBf5PCB1iwVeAFYrDNCyw0yWDtIx0iBL4qJIBo25
	 w8TW5FpmWM/N67WF8UWtQihC+CaXwAMN6/TFERLSNW50+ffDQLSKD4s+nc5CgMJWCE
	 fjdJcsNldAlHHwXuMlD8oDawBI/9rMVrNFAbIeRh3HXKz1nophDh1nUNnpa5qvyGDe
	 cZKn/6lsOF2ptEXxcLVlvlB7UaKemEq30MqnxxW69dH01/XdghIDGarEGGpdbsWbuH
	 i/kg9r6SQm3BmPTTntIEvjwDmqXV1EgMeCUzvzObmLN5Tr/rxMyk2jXFsJNkjVzlZW
	 IUuKPhAtpBUOQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t7y50-0000000087N-0Es2;
	Mon, 04 Nov 2024 15:29:18 +0100
Date: Mon, 4 Nov 2024 15:29:18 +0100
From: Johan Hovold <johan@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	johan+linaro@kernel.org
Subject: Re: [PATCH v8 4/5] PCI: qcom: Disable ASPM L0s for X1E80100
Message-ID: <ZyjaPtGtRlsIO64b@hovoldconsulting.com>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
 <20241101030902.579789-5-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101030902.579789-5-quic_qianyu@quicinc.com>

On Thu, Oct 31, 2024 at 08:09:01PM -0700, Qiang Yu wrote:
> Currently, the cfg_1_9_0 which is being used for X1E80100 doesn't disable
> ASPM L0s. However, hardware team recommends to disable L0s as the PHY init
> sequence is not tuned support L0s. Hence reuse cfg_sc8280xp for X1E80100.
> 
> Note that the config_sid() callback is not present in cfg_sc8280xp, don't
> concern about this because config_sid() callback is originally a no-op
> for X1E80100.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This one should also have been marked for backporting:

Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
Cc: stable@vger.kernel.org	# 6.9

Looks much better now either way:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

