Return-Path: <linux-pci+bounces-19208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85670A00542
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 08:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FF61883340
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B81C8FD6;
	Fri,  3 Jan 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2g66Eee"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFAE1C726D;
	Fri,  3 Jan 2025 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890225; cv=none; b=uY3xGTzfUwCZTp8axKQzsRIZy5DTlZTkR0xsEYgcW26TV5FyL8WB7VshHewL2fPEkgSvStLYWQu3oxa2jMN1fbz4xs5ptmPZHgcZ9hKYh1oUwtF6EJLU4in5POT6L9CnaJ4y/+QavL7Fn5MhHvwQsPHN96iJoIkcIJNUMtgI4Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890225; c=relaxed/simple;
	bh=drUm7P/DhAgF+LsK4/DWKOGNqV4CmWIaVrKLfxX+l7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUNgiagnLP6PpD6lVeN7RA/g9q8+uaBV8dXWmROZw1DeWDwlIntqHzpg713/D9JpSCa4tNeQxyHgWXt/VACwF5brBitIrMzAe3teInhRMfX2D2NnojyH8Z3GrlC3KfyDUQdWe6aejS3UymqzIjWi5Z26LOS1HX0d+S3ujetWUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2g66Eee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3772C4CED7;
	Fri,  3 Jan 2025 07:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735890224;
	bh=drUm7P/DhAgF+LsK4/DWKOGNqV4CmWIaVrKLfxX+l7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2g66Eeetvnk2e/qCHKSJXhjmsdGGPd5pUXy7z8dZUTsTiOP83/PT/xk5yWygBB5o
	 X9GssNApZFT5vQtDWeXEzaCcn8oTWxcmuVdOymiPV69PQLUCDK4GcEFec2XpJheamJ
	 XGz0KFc9usjXp9/STVweLwGVdKpKXFKKv8Omt2y3rPLeCdY2CynoM/i22G1N1fCyxy
	 q7VBup+SIt3LV73pJnWR/PhypanR9SkOQpVdYUULKUgK2WnDTOLBKD6p8bQlabH10R
	 nn6cAqcwX8APl3zZkHsTM8wHKo36eRB16BmY96MFbW/k8X5abdIvxM6e7GSNJ8ucQP
	 DvN8A55KKC9PQ==
Date: Fri, 3 Jan 2025 08:43:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, bhelgaas@google.com, 
	lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	andersson@kernel.org, konradybcio@kernel.org, p.zabel@pengutronix.de, 
	quic_nsekar@quicinc.com, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v5 2/5] phy: qcom: Introduce PCIe UNIPHY 28LP driver
Message-ID: <twxesiftakrmxh2k433ws5sb6mdaj7po7m5b2aca4rvprt2ot4@rghove4l6ldn>
References: <20250102113019.1347068-1-quic_varada@quicinc.com>
 <20250102113019.1347068-3-quic_varada@quicinc.com>
 <nudzgkfufp74eyq3vwuf7f47u6u7xy5cpqw2ktb5vdnpwc7uyv@ar7akuo5q6gp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nudzgkfufp74eyq3vwuf7f47u6u7xy5cpqw2ktb5vdnpwc7uyv@ar7akuo5q6gp>

On Fri, Jan 03, 2025 at 07:48:10AM +0200, Dmitry Baryshkov wrote:
> > +	platform_set_drvdata(pdev, phy);
> > +	phy->dev = &pdev->dev;
> > +
> > +	phy->data = of_device_get_match_data(dev);
> > +	if (!phy->data)
> > +		return -EINVAL;
> > +
> > +	ret = of_property_read_u32(of_node_get(dev->of_node), "num-lanes",
> 
> Who will put the reference count which you have just got?

More important: why introducing own pattern of code...

Best regards,
Krzysztof


