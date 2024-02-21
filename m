Return-Path: <linux-pci+bounces-3811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5631A85D591
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052391F23D0F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C73C5228;
	Wed, 21 Feb 2024 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Prj9SD/T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB736118;
	Wed, 21 Feb 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511457; cv=none; b=l9nwjO5f63Motv1+UYPFAvNsQQKVmzEWG8Hg/yQZC/1tYm/k+ymPzQCHgO4w8znNV9xARzzwwXqkjoxlFrJdGMOlNcCyg7VYAfyORbVS+GtgjfzmDMocCv94v4kLAzb6yggrqEX6ZJogsQePQ7R8K6zJpjgXytI+z7rskF1bDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511457; c=relaxed/simple;
	bh=AyULnxl8eWca9ATWEvMi4RxoJIAaos1kfRJm+tdT0fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwAmnPPsaGV2Xjd217lxFfLZv+JVxposwEgoWT6TEyYhHIiiGDrNDazPUo9JGXg9v9m3Mb46zFmjtgMHkLmC9nivDMpyq0XJCJUq92FXkp5rQG424vqZKdMX8FUwQUq3VejISdZHeztzFh6jv+Q4tcMty+8l39eCBjt2eqHO40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Prj9SD/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBD2C433F1;
	Wed, 21 Feb 2024 10:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708511456;
	bh=AyULnxl8eWca9ATWEvMi4RxoJIAaos1kfRJm+tdT0fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Prj9SD/TT3thrMU98jXSo6RtM1nbzBbYJawWoAMeejKQvddmS8PmNUtqzfTM9NgLm
	 +KECwCrcXSHSLjvVupbrzepUotTmpb8/fsE6BK3RhXHmJySuwmY8nX8k2AgVqPUNNn
	 stkaZz9VPX9tvSfgBp/nX8eZarCPsZDqGgS70ixFktf4j71rAr6MXrANw7Wfzrah+S
	 MlhmLp2CbpzOJDpAyBwnSNmPE7LSSmMKsxU8ZrPEYsNKwE2jW+OCoYqQXkseMuONhM
	 hYLpfjAOnfunhFfava9qqfHGF/ATdLDbYTeqMblmaFQE9YiQ/ZJ5yJs9lqFMPlm26F
	 scmkNBNjnsGOA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcjsQ-000000007Sk-2gBd;
	Wed, 21 Feb 2024 11:30:58 +0100
Date: Wed, 21 Feb 2024 11:30:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: PCI: qcom: Do not require
 'msi-map-mask'
Message-ID: <ZdXQ4h03J9pi81Vq@hovoldconsulting.com>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
 <20240212165043.26961-3-johan+linaro@kernel.org>
 <e396cf20-8598-4437-b635-09a4a737a772@linaro.org>
 <Zcy4Atjmb6-wofCL@hovoldconsulting.com>
 <59bd6e54-0d5d-4e1a-818a-475a96c223ff@linaro.org>
 <20240216165406.GD39963@thinkpad>
 <ZdRXpQnbDbojlMkV@hovoldconsulting.com>
 <20240221052607.GB11693@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221052607.GB11693@thinkpad>

On Wed, Feb 21, 2024 at 10:56:07AM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 20, 2024 at 08:41:25AM +0100, Johan Hovold wrote:
> > On Fri, Feb 16, 2024 at 10:24:06PM +0530, Manivannan Sadhasivam wrote:

> > > msi-map-mask is definitely needed as it would allow all the devices under the
> > > same bus to reuse the MSI identifier. Currently, excluding this property will
> > > not cause any issue since there is a single device under each bus. But we cannot
> > > assume that is going to be the case on all boards.
> > 
> > Are you saying that there is never a use case for an identity mapping?
> > Just on Qualcomm hardware or in general?
> > 
> > It looks like we have a fairly large number of mainline devicetrees that
> > do use an identity mapping here (i.e. do not specify 'msi-map-mask') and
> > the binding document also has an explicit example of this.
> > 
> > 	Documentation/devicetree/bindings/pci/pci-msi.txt
> 
> I don't know how other platforms supposed to work without this property for more
> than one devices. Maybe they were not tested enough?

Seems a bit far fetched since it's also an example in the binding.

In fact, only the two Qualcomm platforms that you added 'msi-map-mask'
for use it.

> But for sure, Qcom SoCs require either per device MSI identifier or
> msi-map-mask.

But isn't the mapping set up by the boot firmware and can differ between
platforms?

The mapping on sc8280xp looks quite different from sm8450/sm8650:

	msi-map = <0x0 &gic_its 0x5981 0x1>,
		  <0x100 &gic_its 0x5980 0x1>;
	msi-map-mask = <0xff00>;

Here it's obvious that the mask is needed, whereas for sc8280xp:

	msi-map = <0x0 &its 0xa0000 0x10000>;

it's not obvious what the mask should be. In fact, it looks like
Qualcomm intended a linear mapping here as the length is 0x10000 and
they left out the mask.

And after digging through the X13s ACPI tables, this is indeed how the
hardware is configured, which means that we should not use a
'msi-map-mask' property for sc8280xp and that this patch is correct.

Johan

