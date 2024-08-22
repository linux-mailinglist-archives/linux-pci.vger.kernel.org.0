Return-Path: <linux-pci+bounces-11988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E554B95B127
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 11:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F89E283968
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7AE15920E;
	Thu, 22 Aug 2024 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je9pjWkB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1161E19470;
	Thu, 22 Aug 2024 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317650; cv=none; b=IaGJlnSVmYiyuERkNrTALiip/bz8AJsGTNYwvCS+rLECWlkIcFvfs+0QRs+gegpbfyfybTpRaipYbvdET2OnGdRPNxBR89ynw9VNY95C50AksYlfkyWYWxoUl2KdG40oZuuDZTHiVMj0gjhvCljH1kYKzEtCEV5OESKrIIS0aJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317650; c=relaxed/simple;
	bh=yXE5GwDVy5c4oQacgOA8G6q/nmDaZ8FtwnOwfOX+KS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1edAhDW58wT4F985uHZOHqCs9Se1zFeLrTCUIYSAQwnI90Fw2bXgq749KXYIumNx2tZvIucjITUFcZp62M1zUPJdGVpYfMKLD2Dv2aecxB26lCO/mWZi78j2t1QLXWo+5GdepJPu45UnKhz1XMzuq+8C/WZDr02AMUMZuGERJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Je9pjWkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74879C4AF0B;
	Thu, 22 Aug 2024 09:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724317649;
	bh=yXE5GwDVy5c4oQacgOA8G6q/nmDaZ8FtwnOwfOX+KS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Je9pjWkBR+805tzDEsOm0djHgVbhSh+Ov0BWVmrwoT30J3f0W1ODDi0pM7GHuqjVH
	 sajXJSy+A7c0xgJbKKX+OPAxV8acY1mvzv0/1fnrdNByFpYdsAxaOIvHWQSJzp+v5V
	 yKiLQGta0yKudRvthJ0kG7SyQEdzPaGKSkQcl6GImFL53pg/aJiLe4gQgrb+7l2o4g
	 AwF8c6lIYRSgqWuH6LO+ZGkJAEWnG775GikL6prYG6oVSiyXmcgf0+c6pfgdTH3Hn3
	 W6lJPhnAkTjdplvy/Aww+6WCHXHA5faIufIHa1I9JPPet+mCxU+bKnXYLUE9mBPnVE
	 9FQH79AgT/3iA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sh3n3-000000002gj-2Y2d;
	Thu, 22 Aug 2024 11:07:33 +0200
Date: Thu, 22 Aug 2024 11:07:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <Zsb_1YDo96J_AGkI@hovoldconsulting.com>
References: <20240723151328.684-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723151328.684-1-johan+linaro@kernel.org>

On Tue, Jul 23, 2024 at 05:13:28PM +0200, Johan Hovold wrote:
> Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
> dedicated schema") incorrectly removed 'vddpe-3v3-supply' from the
> bindings, which results in DT checker warnings like:
> 
> 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb: pcie@600000: Unevaluated properties are not allowed ('vddpe-3v3-supply' was unexpected)
>         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> 
> Note that this property has been part of the Qualcomm PCIe bindings
> since 2018 and would need to be deprecated rather than simply removed if
> there is a desire to replace it with 'vpcie3v3' which is used for some
> non-Qualcomm controllers.
> 
> Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Can someone pick this one up for 6.11?

Johan

