Return-Path: <linux-pci+bounces-10764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E358593BC70
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 08:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76641B21797
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B6C15FA67;
	Thu, 25 Jul 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp7yPmeL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB41CA8A;
	Thu, 25 Jul 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888274; cv=none; b=mUpr1TUcpDb7/I2J5DO2LkDxr28NX0XmPGne2g15zBP8Zt5kL3LxemJwPkCOovEVMjlHfRF/jf7e2VR+glcKS1fXcnLAxXRZrFlhyiX3J7gYNZSj2UP6euvC6lc81DQryc2/8PDZrKW8Q16U22u/9uXNSNa2KgPdwvaOrdnf7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888274; c=relaxed/simple;
	bh=iqW6sJvc25bsmnZbAhXI5ixAD8RqziptNaP/wBtMiK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVhhRWZIKUJnpbESYv0aAF3Zf4dXkKGDqBDLJ96vrZPCrPlRWOiuzVf2HHwQ5enhlqqrZAqiL41EMcCjRCEGZYMlaRyXQ/kFLBhM/n7wa0uf+C5kiz1gZEp2ZE3SRgYs4wldkm7Gf9OUnJNP+YFCVj/t4OL8MiXlyZrmI0FRVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp7yPmeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F07C116B1;
	Thu, 25 Jul 2024 06:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721888274;
	bh=iqW6sJvc25bsmnZbAhXI5ixAD8RqziptNaP/wBtMiK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cp7yPmeL/DAW9lXgHvZezv+yeEA1No6qFv8q5neg0UaXVPLZVDZwRVdcdz3xMTRKy
	 Y98g4Dx+Vb51rHpYiCrzhq/pCCMQJfuk5YsdEzBAYT7M+YvFnXEjo/3gG9FItzjcyl
	 m108xuqv4GsemfZtfQQzvd69sZFpQi5gGyt1o+W8ssBAt04MDSFeiEZ89x1YQG5d3U
	 TV1LAvTeIdhJPTNi52C/25LxGC2/qnUWQzaEMtbWgTgJIoUQA/iIWeCMc9Eg7MRgbM
	 qScMUuZYSQpu/eyKYGVYy5X8/7QSuvMp4G9554IiRBN9ENY1zT0xntlaplswz5xUBx
	 1bjrhCpfObeVw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sWrnX-000000007pD-2lw2;
	Thu, 25 Jul 2024 08:17:55 +0200
Date: Thu, 25 Jul 2024 08:17:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <ZqHuE2MqfGuLDGDr@hovoldconsulting.com>
References: <20240723151328.684-1-johan+linaro@kernel.org>
 <nanfhmds3yha3g52kcou2flgn3sltjkzhr4aop75iudhvg2rui@fsp3ecz4vgkb>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nanfhmds3yha3g52kcou2flgn3sltjkzhr4aop75iudhvg2rui@fsp3ecz4vgkb>

On Wed, Jul 24, 2024 at 08:22:54PM +0300, Dmitry Baryshkov wrote:
> On Tue, Jul 23, 2024 at 05:13:28PM GMT, Johan Hovold wrote:
> > Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
> > dedicated schema") incorrectly removed 'vddpe-3v3-supply' from the
> > bindings, which results in DT checker warnings like:
> > 
> > 	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb: pcie@600000: Unevaluated properties are not allowed ('vddpe-3v3-supply' was unexpected)
> >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> > 
> > Note that this property has been part of the Qualcomm PCIe bindings
> > since 2018 and would need to be deprecated rather than simply removed if
> > there is a desire to replace it with 'vpcie3v3' which is used for some
> > non-Qualcomm controllers.
> 
> I think Rob Herring suggested [1] adding the property to the root port
> node rather than the host. If that suggestion still applies it might be
> better to enable the deprecated propertly only for the hosts, which
> already used it, and to define a new property at the root port.

You seem to miss the point that this is just restoring status quo (and
that the property has not yet been deprecated).

I assume you've already read my reply to Rob's bot, but here it is for
reference for others:

Link: https://lore.kernel.org/lkml/Zp_LPixNnh-2Fy5N@hovoldconsulting.com/	

Johan

