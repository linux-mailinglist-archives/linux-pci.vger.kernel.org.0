Return-Path: <linux-pci+bounces-6493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B498AB69A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 23:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046142830F8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248513CFAC;
	Fri, 19 Apr 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxqTaFhI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9929CE5;
	Fri, 19 Apr 2024 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713563301; cv=none; b=stXthpPgJYgJ4dIwPiNZzw5a0Wm1IjaS23XHVcIteA/XC1Ug7jD1RfHY3e2T1WIIqcTmKvj5XfUz2ODC/lwtKFl1mSt8e9vUjZHgZC7ioBEJPE0UgIS0Ab82ABvPMgQQaBHltam1vczSlh/68opriHEy7DNYhsbjGKjNFzXv7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713563301; c=relaxed/simple;
	bh=3ZlAGatLrUPVKYAsJKumqoP+8kWa0EUDFzvFfHY02FU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sPi6vIc4GSlZo/cDXvk+UGvzIVzFmrGWTUZaYuhZjMJXwHOsvUZU/wTfOemtGvmhRf+m+6tzS9xptcvcl6UCx98IH21yR1FVL005424sS+lKKmFKip6fDQamvqQUU7cEhFcYBW186Xws8pM0l2Zp9HKdUKJfD22k2eEFY1CemlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxqTaFhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D045C072AA;
	Fri, 19 Apr 2024 21:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713563301;
	bh=3ZlAGatLrUPVKYAsJKumqoP+8kWa0EUDFzvFfHY02FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VxqTaFhIYOUAZuASy2lOS9wM6D/fpN+HDbQDGL5XtxBbyaPllLebOvL5TKvBVrDBH
	 5dGSmqCKMv0J2p7tVPK7a6NLTVZ4NdV6+uS99EfO8d9qiDOZrLOZNAeI7u8rU+Y1ys
	 /Q6dqbE1TdC1BIsM0+aiiiv6rca+7nrfyZiNu1w8rIE9UGeZYwo8k/eiTah71V92sR
	 KfWVB0Y4svSpMZEA6evgjMP2WOkHXvDKZI9PfpdKEZsvYYclfVPA16ehhxGNajcxjI
	 mRiEAbYx0f+rcP5hWwVOQF+G9hn0eF99GQcSv7zl0dOsFoDXTRYRpbDRVRV6uNDc+a
	 6o+eEpxSwd9hg==
Date: Fri, 19 Apr 2024 16:48:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 3/9] PCI: endpoint: Rename BME to Bus Master Enable
Message-ID: <20240419214819.GA307192@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419093847.GB3636@thinkpad>

On Fri, Apr 19, 2024 at 03:08:47PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 18, 2024 at 11:12:09AM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 18, 2024 at 05:28:31PM +0530, Manivannan Sadhasivam wrote:
> ...

> > > - * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
> > > - *			  the BME event from the Root complex
> > > - * @epc: the EPC device that received the BME event
> > > + * pci_epc_bus_master_enable_notify() - Notify the EPF device that the EPC
> > > + *					device has received the Bus Master
> > > + *					Enable event from the Root complex
> > > + * @epc: the EPC device that received the Bus Master Enable event
> > >   *
> > >   * Invoke to Notify the EPF device that the EPC device has received the Bus
> > > - * Master Enable (BME) event from the Root complex
> > > + * Master Enable event from the Root complex
> > 
> > There's no "set Bus Master Enable" transaction that would appear on
> > the PCIe link, so I assume "the Bus Master Enable event from the Root
> > Complex" is a way of saying something like "host has written the
> > Command register to set the Bus Master Enable bit"?
> > 
> 
> Yes. But looking at it again, it could be reworded as below:
> 
> 'Invoke to notify the EPF device that the EPC device has generated the Bus
> Master Enable event due to host setting the Bus Master Enable bit in the
> Command register.'

Sounds good.  Could even s/Invoke to notify/Notify/.

