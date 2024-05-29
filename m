Return-Path: <linux-pci+bounces-8060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9198D3DA4
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 19:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3081C2127C
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED44184116;
	Wed, 29 May 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC7hPauH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F1184115
	for <linux-pci@vger.kernel.org>; Wed, 29 May 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004896; cv=none; b=gE03M1bn01qRqpe5V+DS3jn5W7Zlzqen4AEH7FXFRSfhdLt8JUFfK/GDFuOHr99OKWaxXts8T0wiJ1v8gsEBYBRSqTezrZsCt0khAYuNyQhcgkQLqzAdwY10CsxTlauf1+Il2CFWjTn0vADhcm3kc2z6WUvvL1kSvS65uEXoWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004896; c=relaxed/simple;
	bh=3fxB6LOEPeXZzuejlTFUAapIukKi0oA8uD0DG8XWNVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATFYq4k2hT0wfbFxVaR4qXZVrTKXNerGCNnIbhvmxnPJAAyUClrLOs3Ifn6ghwcKaBVfL9gHn/LXOy4lplyYJF9rEfpCYGAlxE9eB0VvSSebMn6Slrzarnc58vC/fUlinuqZ7T4QOafPwJ1ogH84uyplwZIn2WyfaJ1XoEn2qKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC7hPauH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A281CC113CC;
	Wed, 29 May 2024 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717004895;
	bh=3fxB6LOEPeXZzuejlTFUAapIukKi0oA8uD0DG8XWNVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pC7hPauHMh1yDRI83w+YW8mmNLI6aQxzEeLFPJQkeEih3a/3k0XmVrduMTO9mgq0r
	 DkLBP4Rq2NVaiduBqIYvZuBbNsVqK852crwRp74dd46ZnrX839VnpeHptYCh7YXmPH
	 pkYvfErBxnZ9DL5PqHO1PY7/909OYhm1RKWHSR2ODOYJcZjLS9obegv3JzCCJxr26k
	 OHHTfVlogrGs/e4NFNNj1xKQsthx0EyZI0pDrXfrDXiWPXimOF7XS6tewNkBBC8g8C
	 IZYOnZJ6WI7jTYFo+b/KZkdgYMRe/Nn4JI80q6Meu3iDd9bwhwLMg2VIycF/T5nkks
	 7dgdDkV1BQTTQ==
Date: Wed, 29 May 2024 19:48:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <ZldqWqTbYMDlL7c1@ryzen.lan>
References: <ZldBwUwyekUM-b9i@ryzen.lan>
 <20240529172515.GA511985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529172515.GA511985@bhelgaas>

On Wed, May 29, 2024 at 12:25:15PM -0500, Bjorn Helgaas wrote:
> On Wed, May 29, 2024 at 04:54:57PM +0200, Niklas Cassel wrote:
> > ...
> 
> > We should probably also address Bjorn comment:
> > "ls and qcom even use *both*: pci_epc_linkdown() but dw_pcie_ep_linkup()."
> > 
> > As far as I can tell, it is only ls (not sure why Bjorn also mentioned qcom):
> > drivers/pci/controller/dwc/pci-layerscape-ep.c:         pci_epc_linkdown(pci->ep.epc);
> > But this should probably also be fixed to use dw_pcie_ep_linkdown().
> 
> qcom_pcie_ep_global_irq_thread() calls both pci_epc_linkdown() and
> dw_pcie_ep_linkup():
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom-ep.c?id=v6.10-rc1#n628

I see, you were looking at old code (Linus' tree) ;)
In pci/next there is just ls :)

qcom-ep was fixed in:
813c83de4ac0 ("PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event")

Anyway, since Mani wanted to keep the wrapper, both qcom and ls should use
the wrapper after his series.


Kind regards,
Niklas

