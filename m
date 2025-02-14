Return-Path: <linux-pci+bounces-21441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6A4A35A89
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 10:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560751891DEB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084D1241660;
	Fri, 14 Feb 2025 09:43:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3732149C7D
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526200; cv=none; b=tq9Zcn+NyiLQ1iFQiHaJWjWe+OH5WNmTAgk4grKxsmi+47qesZx/yCwAnBSND7H/FHxSLc7XyYaOtOydgXem4OrsB9aJaDfXszys5yfyzOkInNKZAQItpXvCVRXdvxz3kObXsG3ocvaApxE1T2dQI/WZwI1+/WRlE14RgkHPxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526200; c=relaxed/simple;
	bh=ACQ7IDDR6WwreCng4hqcg4h0kZDOrlKPPEfdK0d/2wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZoWiQBORsQb0kXbyCY1s1vQlKIsLT09oFfQZsKnzjQwu3jWG92yfuDEqK4twxP/07MktKWQwr6lzBvMAYI/4nsghBFV88OVnih7G42zxqCnHuvZZ0s5d7LlL2LZsWJVUbTaxXv4YS8sTxvWJi27Ja31hJM5sIM7wL1rhbX9vU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC057C4CED1;
	Fri, 14 Feb 2025 09:43:08 +0000 (UTC)
Date: Fri, 14 Feb 2025 15:12:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20250214094255.jmfpkmzwqn5facsy@thinkpad>
References: <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
 <Zeha9dCwyXH7C35j@google.com>
 <20240310135140.GF3390@thinkpad>
 <Z68JlygEqQBSDWPA@google.com>
 <Z68KYxSniCxdMMAg@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z68KYxSniCxdMMAg@hovoldconsulting.com>

On Fri, Feb 14, 2025 at 10:18:27AM +0100, Johan Hovold wrote:
> On Fri, Feb 14, 2025 at 02:45:03PM +0530, Ajay Agarwal wrote:
> 
> > Restarting this discussion for skipping the 1 sec of wait time if a
> > certain platform does not necessarily wish or expect to bring the link
> > up during probe time. I discussed with William and we think that a
> > module parameter can be added which if true, would lead to the skipping
> > of the wait time. By default, this parameter would be false, thereby
> > ensuring that the current behaviour to wait for the link is maintained.
> > 
> > Please let me know if this is worth exploring.
> 
> No, module parameters are a thing of the past (except possibly in vendor
> kernels). The default behaviour should just work.
> 

+1

Btw, you need to come up with a valid argument for not enabling the link during
probe. Also, not waiting for link during probe is also not going to work across
all platforms where the controller is used, unless your hardware supports
hotplug or LINK_UP IRQ.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

