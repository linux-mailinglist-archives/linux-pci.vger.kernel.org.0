Return-Path: <linux-pci+bounces-31334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E8AAF6AFE
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A34227AC454
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B329A300;
	Thu,  3 Jul 2025 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW3r2rNO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325129A310;
	Thu,  3 Jul 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751526008; cv=none; b=HIgF3SgZ1zmW1atA48UXoBxCz2DMCgmFHCF+N1uAsHnSCr5Uw0m9mzAnAUpsksjH4T0tdrlvS6Y1x7BPXTMycpXmU+TauRGMD0vg31pu+DbwSpUFYSwYd7/a7JC0wT7P3E4Y3QUSE0pz3cFCakgY2Nd41YuJ3vOsA7G6JTy/JSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751526008; c=relaxed/simple;
	bh=0UqQoGyGCJdBkTLY79bVUov7xcs469Jf8oLtoorXfHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJtpOkvtmwdwA0MMfkAFSdikQkygQJX0GEq7h1qoYV1uyIJePfXOK0EYB4SA66cNoUY4GTn6xiba4eUc2tspe3oMXc/aY93Oqr3vHYxF/5W/CjTiyFVUQhW27ZFGf3XvGq7z65WUClpUp5sWFTiswTHDNlSnrhhjqGcy5rgOWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW3r2rNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D32C4CEEB;
	Thu,  3 Jul 2025 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751526007;
	bh=0UqQoGyGCJdBkTLY79bVUov7xcs469Jf8oLtoorXfHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oW3r2rNOsBKm3SoNDBkwC9IzK20FQbPCqH82+d/g0/tQsgALAXcbSx1Fxfn6a59tU
	 6qGG8xlF08J49DFYuSfkiXJ+/Ql37D0AyPi1QZQsz5iLCc/b76Vi67vjul8K5f1WF6
	 M43X+ZErw2lDXuu7CbHhY16FG4n+WrfUEh2jJz/wO/hR0O/lXxzWS/Bzu0T1BZ+F6x
	 Xq5y68Ks7KSHVk7CBZZDT0LlQ9w6PuF/gkKDT2dq1Hbq3Aoscyy9VmK4eY21AdZLzT
	 r1VdJPJp9ywUhQf0AbXn9vPEN90WL1e2vNOr6wje5xzQ46APLzFSm0G4zLbQPjuait
	 guc9sPaWxMIXA==
Date: Thu, 3 Jul 2025 12:29:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v5 2/2] PCI: qcom: Add support for multi-root port
Message-ID: <g3lapumfhr27nm54e54d6qwkbswfkfjybhdkmr4g67rnqihukt@qqwdfsh4p6pm>
References: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
 <20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm.com>
 <ws2kdznvbrvuvb6k4jov5cd4qzvadeaffjqgeso7u72stormlg@2ffiexejkrk6>
 <cbf32980-8608-42ba-99c7-deed56afae32@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbf32980-8608-42ba-99c7-deed56afae32@oss.qualcomm.com>

On Thu, Jul 03, 2025 at 09:48:17AM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/2/2025 9:03 PM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 02, 2025 at 04:50:42PM GMT, Krishna Chaitanya Chundru wrote:
> > 
> > [...]
> > 
> > > -	ret = phy_init(pcie->phy);
> > > -	if (ret)
> > > -		goto err_pm_runtime_put;
> > > +	for_each_available_child_of_node(dev->of_node, of_port) {
> > > +		ret = qcom_pcie_parse_port(pcie, of_port);
> > > +		of_node_put(of_port);
> > > +		if (ret) {
> > > +			if (ret != -ENOENT) {
> > > +				dev_err_probe(pci->dev, ret,
> > > +					      "Failed to parse port nodes %d\n",
> > > +					      ret);
> > > +				goto err_port_del;
> > > +			}
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	/*
> > > +	 * In the case of properties not populated in root port, fallback to the
> > > +	 * legacy method of parsing the host bridge node. This is to maintain DT
> > > +	 * backwards compatibility.
> > > +	 */
> > > +	if (ret) {
> > > +		pcie->phy = devm_phy_optional_get(dev, "pciephy");
> > > +		if (IS_ERR(pcie->phy)) {
> > > +			ret = PTR_ERR(pcie->phy);
> > > +			goto err_pm_runtime_put;
> > 
> > Shouldn't this and below be err_port_del?
> > 
> This is a legacy way of parsing property, if the execution
> comes here means the port parsing has failed and ports are not created.
> so err_port_del will not have any effect.
> 

Oops. I got confused by the if (ret) flow. It would be more clear if a goto is
used to indicate that the legacy codeblock is skipped. I'll just incorporate it
while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

