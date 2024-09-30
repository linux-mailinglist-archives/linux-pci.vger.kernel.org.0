Return-Path: <linux-pci+bounces-13655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0050798AA6F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 19:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E5D2839D0
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D63618E02D;
	Mon, 30 Sep 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1nmGUEu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110095103F;
	Mon, 30 Sep 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715692; cv=none; b=BcaixGwp4LO7EmH/ubgsl5wsFO3ZiSoYGGLMKbSmtN7hHIbuAPyVp/f8ykjDXN6sMF8PtQcuEdWpKcOYH36POzUHr+cxYNNVmC4XH1yZMoU4STqdXU9eVjmT+zHV9vWanmyTDRnTWQWgl2CRHTzf1A1E4rrXKdA9jbbEbZW06L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715692; c=relaxed/simple;
	bh=B4YPzTysm+IhVAyp8WjRmKkZdun68CII1ikCPo9RCEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oxr+J4GoWBp4ez6D0cc7uuoaC9Rnx6l1f++LXHP9ksUSuCPzo9pINcoN5d/kyh/KQXiVykGBCKz8v9xgXnGF/CbbtyD3TEsZMHS/afMSF7Mz8+nCz4ORGarEI20h+5+oMhakcnW/5wrWJFCBBSEqjyYGI8gUEjtP2YiMp2D3B+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1nmGUEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C31C4CEC7;
	Mon, 30 Sep 2024 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727715691;
	bh=B4YPzTysm+IhVAyp8WjRmKkZdun68CII1ikCPo9RCEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N1nmGUEucEZrUCCh87+zdiFFCIGukCupofa8nTc28X3BZouwXrwbc9dXwdAlsXNzU
	 CRQxSMP7IBqSp2pajOi5/JZUKdzHfKQBG3LST1A223pXta6V9HlFfndPnelpdVcfW+
	 9rdF/cDvwqn9P8XOBOS27LWGCYfOpFrUANNJHGN0bC35AT5CKWz417kXwwVxmXEI08
	 ouL/JrW+pqzKS8uJTjLk76rDdBALa1z8KIwNHeWQEHsQ5CaidTsar4ZR39gengzyLZ
	 P5VWqpIYV91T3ffAFMDD255gqBPAuyymthvX4EcAzgaR1SrKzwEln1KrfRIvytbf5c
	 IWs5+BWuxlk1g==
Date: Mon, 30 Sep 2024 12:01:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: qcom: Skip wait for link up if global IRQ
 handler is present
Message-ID: <20240930170129.GA179772@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930074910.yeuujpwqyq32lehw@thinkpad>

On Mon, Sep 30, 2024 at 09:49:10AM +0200, Manivannan Sadhasivam wrote:
> On Fri, Sep 20, 2024 at 03:47:59PM +0530, Krishna chaitanya chundru wrote:
> 
> Subject should be modified to reflect the fact that the link up is skipped in
> the dwc driver.
> 
> PCI: dwc: Skip waiting for link up if vendor drivers can detect Link up event
> 
> > In cases where a global IRQ handler is present to manage link up
> > interrupts, it may not be necessary to wait for the link to be up
> > during PCI initialization which optimizes the bootup time.
> 
> How about,
> 
> "If the vendor drivers can detect the Link up event using mechanisms
> such as Link up IRQ, then waiting for Link up during probe is not
> needed. So let's skip waiting for link to be up if the driver
> supports 'linkup_irq'.

I avoid the "let's do X" structure because "let's do" is a proposal.
The patch actually *does* it, so it's more than a proposal.

Also, it would be helpful to extend this with a note about *why* we
can avoid waiting, i.e., if we can be notified when the link comes up,
we can enumerate downstream devices then instead of waiting here.

I suppose the "global" name is already set by DTs, but the name seems
far too general to me.

Bjorn

