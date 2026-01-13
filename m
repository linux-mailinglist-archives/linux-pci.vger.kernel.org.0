Return-Path: <linux-pci+bounces-44646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12973D1A628
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C955430DA3A4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C4328B43;
	Tue, 13 Jan 2026 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC1H/3Pt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0853246EE;
	Tue, 13 Jan 2026 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322599; cv=none; b=KIYHNc5LtC5T4dOCFZVr0tCMCSVmkh/TR+NI24QjuJzCqmJu2OielHbzoJ6+PmsRlC5Qa7Qwaq1W2v45p43j6brA3NCGR/s8cGt1pz8sQFcJy80d9mtL60+QuOX4efRiixqVv/Pb9Mf1HWoxo7QsCDeDzLaqLcyiIrG8p//96pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322599; c=relaxed/simple;
	bh=Y1mpJt9qvaLbi5B87D95AFRcMvuKwM1TnjtpoOuRPW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/ERvep0N09FeHkDw/aZpyHmRdlUWtQT+p1qIbKtRWf0Dl5LcqydijAubCBE4a1rM8A0sj1SCCvVBSofU6EsGoA8Nc3XhWgTZlnF68P2AI+P5DDKloL+4sFHTcjpIbpi3SkgEWDu791IJQlgVpF18q8SovVr/uEdv4GuoFxn+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC1H/3Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC7BC116C6;
	Tue, 13 Jan 2026 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322599;
	bh=Y1mpJt9qvaLbi5B87D95AFRcMvuKwM1TnjtpoOuRPW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BC1H/3PtnQxiwTF+fIhCNsvJQyJzxoWjpExwOngg4Yaej9GrR/wR0ss/zmwamVgd5
	 A8QNLIWDdTrhey//z7t3KxMDrXZmznwyHEi8i+csWFgDAPih1RkdCNXUWDM/szBmdu
	 9R+cnTMgb2JUF+SkTL/CAtFsMAI3tBIcx0AHiOC6srYsdwhkPuqi4zIibEXJSbtEbN
	 zUwYg9kr1rofpVVmXN2lFG7l7TWgPWAzkveJVfQP+y5whbz4gDTmhrx+oO7JD53fx0
	 lKXxEMaUZg8jM3iutSWAiXu2bXuDPOCoyO6m+hAYr/SMWgJ3hWt+YxyjhLO0VKRCOX
	 46PT6rBAHi7Ww==
Date: Tue, 13 Jan 2026 10:43:18 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Nathan Chancellor <nathan@kernel.org>, devicetree@vger.kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pm@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Hans de Goede <hansg@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-bluetooth@vger.kernel.org,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 4/9] dt-bindings: serial: Document the graph port
Message-ID: <176832259781.3925075.6465150730329929595.robh@kernel.org>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-4-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-pci-m2-e-v4-4-eff84d2c6d26@oss.qualcomm.com>


On Mon, 12 Jan 2026 21:56:03 +0530, Manivannan Sadhasivam wrote:
> A serial controller could be connected to an external connector like PCIe
> M.2 for controlling the serial interface of the card. Hence, document the
> OF graph port.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


