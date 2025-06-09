Return-Path: <linux-pci+bounces-29238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811CAD23EA
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B0737A491D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D94219E8D;
	Mon,  9 Jun 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGXgEiwr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DE420A5C4;
	Mon,  9 Jun 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486572; cv=none; b=FeClPL6a/3TgQrVk1vLG7AZeQXzIprRAKFLMPiyJXyKOMH0F/+rONHMlfVnuENzJrzGzGA+1RXAWjRWKyQ3CWnmSZaliZgMDhuyOG1kRNLoQDbWDcuMY3FXP9Gz3Wb7U+UvbhiKSeYyNmVk0Ii4ig0JuGFsfTa4I2Av46u8t9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486572; c=relaxed/simple;
	bh=yXciaEyW1Nu3aWIMvqyhWQB7hBKb6HXfNQvi81A7wts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nO/cxKSNMZrIvplFk88H97uYbUh+Kdm8w3elVidYcBqPvczUhiqtAcx4uE6b2SaiJrC6TE8fEQlbejVV5q9//HzvrDQKMIkZAe18humVxLdLNsGJNpQqxvAuoCMdmNph8rI+0p3BkqlHN5i2NZ6l9cAcfPggHT3AE8wWaqru5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGXgEiwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BDFC4CEEB;
	Mon,  9 Jun 2025 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749486572;
	bh=yXciaEyW1Nu3aWIMvqyhWQB7hBKb6HXfNQvi81A7wts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hGXgEiwrqdKt5fJahWntoVSywnIP0ayMDN+3ECiZopOrsiXt94NGPcAcs5wFA8N4P
	 weYLfD3CkXXY8NLaoC4nAg4L/pWKR5SDxd6uh8nFsZ+xDk6jBiwZ70s6R2sxZKB4uX
	 dn81XsF2YiV3rEg3lzg8TBpAWOLrqWMMTIc1HEaZfknZ5X94zZ+EKhMlhMSz37QOPx
	 5OFU65Qw+WLfFP135yXiWSETBsIQUQg3Kcto+KiFwh4/E0trRmVZycAAuGgspqev43
	 6zX/XAf0kuScmFiIdOJ6vG3ii6cwhET1tARhqWCBaafXsY20QnhWzJpC4dqe0YIl+z
	 yHgxHZn+hEHBA==
Date: Mon, 9 Jun 2025 11:29:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [PATCH v3 2/2] PCI/portdrv: Add support for PCIe wake interrupt
Message-ID: <20250609162930.GA749610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b91b725-6b47-bf8f-e6e5-e4584f274ec4@oss.qualcomm.com>

On Mon, Jun 09, 2025 at 11:27:49AM +0530, Krishna Chaitanya Chundru wrote:
> On 6/6/2025 1:56 AM, Bjorn Helgaas wrote:
> > On Thu, Jun 05, 2025 at 10:54:45AM +0530, Krishna Chaitanya Chundru wrote:
> > > PCIe wake interrupt is needed for bringing back PCIe device state
> > > from D3cold to D0.

> > > +	wake = devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(dn),
> > > +				     "wake", GPIOD_IN, NULL);
> > 
> > I guess this finds "wake-gpio" or "wake-gpios", as used in
> > Documentation/devicetree/bindings/pci/qcom,pcie.yaml,
> > qcom,pcie-sa8775p.yaml, etc?  Are these names specified in any generic
> > place, e.g.,
> > https://github.com/devicetree-org/dt-schema/tree/main/dtschema/schemas/pci?
> > 
> I created a patch to add them in common schemas:
> https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/

Thanks.  I think it will help other DT writers if we can include a
link to the relevant dtschema commit in this commit log.

