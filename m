Return-Path: <linux-pci+bounces-37836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E2BCEFAA
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 06:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67D6834E140
	for <lists+linux-pci@lfdr.de>; Sat, 11 Oct 2025 04:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03B042050;
	Sat, 11 Oct 2025 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJUcnssh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28034BA49;
	Sat, 11 Oct 2025 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760155749; cv=none; b=A61+gvd9PKTqJVpsV48vYHNIVW2s0TKLcN6w6qzfHFcO4KMw3aWjVHmw77wMH5uk/e51D//IsFwxkLRDlgSum9II5wUyO4PHLb5MkReZ30la8bY21fLne9OcyOlmAq4dp5k2/V5GxsHBvt1gvopZwQEalva5RjB5rGyKIAMu6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760155749; c=relaxed/simple;
	bh=dHJoTvSQpgNLs9J0VBG50JGYREfFLnhm8Clc1KzA8OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHgeMUVnjJGvctTm1rifYOjOHIbeowKXIMK2+smHBQ8eVuWCM7wyAlF32daqjKBcii/YJ80Tm9awrp7LqViG5H3gWYqYhoSq4dn+Wibjbw+DieUYGNBf0SvpLO8B08JNgHbTS+m9xeThz2woUCc0Z3cwW8hY09y9/HBkDYmuF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJUcnssh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FD2C4CEF4;
	Sat, 11 Oct 2025 04:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760155749;
	bh=dHJoTvSQpgNLs9J0VBG50JGYREfFLnhm8Clc1KzA8OY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJUcnssh/jCWmnQvUxU6X3P4t3+WJ6ozh9bGPNhEoneyXLgQLZWkPu46OyGcbUd6v
	 NMZxQkdZOZgZwVUrOe8uE+k84j25q92oEEjjQwJ9ICenMhIWhgdY8TijZOB7y+YEkM
	 q7eDoauifGfrWHpjO1BTtz5ncSPorlL9d9EKr6hLAutzc78rhQV8ReWDf564wp68Ek
	 4ZqHguKadPwx8Qme0Md+OjQ2xqhvy+dEZ3sD4O/iQYSfABXtahwzFbbZqKxWosZ11J
	 Kbx+SPzK7/6dEZFuLRi/W0/Ua62QHIs0U89YX4UQ90jIoZ+NoOm/09uudAxMLF5i/d
	 dqvH8Kdpv7Ztg==
Date: Fri, 10 Oct 2025 21:09:06 -0700
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linus.walleij@linaro.org, brgl@bgdev.pl
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abraham I <kishon@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] PCI: qcom: Treat PHY and PERST# as optional for the
 new binding
Message-ID: <yvbghnxttchfvte3nxr4ru62wqilceil2n7x7dgpa5gnm57ywu@ljrbw3c44qpw>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-3-947c004b5699@oss.qualcomm.com>
 <4532e2e6-51bd-4443-ad51-41fc02065a7d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4532e2e6-51bd-4443-ad51-41fc02065a7d@oss.qualcomm.com>

+ GPIO folks for the below API query

On Fri, Oct 10, 2025 at 08:32:51PM +0200, Konrad Dybcio wrote:
> On 10/10/25 8:25 PM, Manivannan Sadhasivam wrote:
> > Even for the new DT binding where the PHY and PERST# properties are
> > specified in the Root Port, both are optional. Hence, treat them as
> > optional in the driver too.
> 
> I suppose this makes sense if the PHY is transparent to the OS
> or otherwise pre-programmed and PERST# is hardwired or otherwise
> unnecessary.. both of which I suppose aren't totally impossible..
> 

PERST# is by definition an optional signal, but I'm not sure about why PHY is
not used by the controller driver.

> > 
> > If both properties are not specified, then fall back to parsing the legacy
> > binding for backwards compatibility.
> > 
> > Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 805edbbfe7eba496bc99ca82051dee43d240f359..d380981cf3ad78f549de3dc06bd2f626f8f53920 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1720,13 +1720,20 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
> >  
> >  	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> >  				      "reset", GPIOD_OUT_HIGH, "PERST#");
> > -	if (IS_ERR(reset))
> > +	if (IS_ERR(reset) && PTR_ERR(reset) != -ENOENT)
> >  		return PTR_ERR(reset);
> 
> Please introduce an _optional variant instead
> 

Linus, Bartosz, are you OK with devm_fwnode_gpiod_get_optional() API? Just
wanted to confirm before I go ahead as there are existing users checking for
-ENOENT explicitly. Not sure if they are doing it for a reason other than the
absence of the _optional variant or not.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

