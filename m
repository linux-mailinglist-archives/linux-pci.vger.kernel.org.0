Return-Path: <linux-pci+bounces-31163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E2AEF7A1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970607ABD69
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECAD2749E5;
	Tue,  1 Jul 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCvpBbTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CB2749CF
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370949; cv=none; b=WDs9RKftz/Ko/Lt0WDXRHXu8cLGCgFjMITnHTowLT7gpXTrD9lFTg3508XjzZkp1lYiDBcF8zrkJ0GxLBUfnqRpwrcdxcBq/lh79+ZTK9CRxZYeV/I+rHQY3/dK8GAs3dZ7yuUHXlqdIeTertaNbJUcblWls52jGBcjA0we0W5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370949; c=relaxed/simple;
	bh=GtXCufAOk5EVbCLVPR1JO3Sa8rQreS6SSV95Qk73oNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ik0BpZa+XwvwL1Ws9cQZKQW1KHmJMuV71EyylyYumnfCqXEXqCIl1n9Bns+EzU5MfpqdAzDYMuEVM2MSY+7JMLcN1aOuLt7HGWfVXgQaaS7g4+tGdrZwE+R4SsjYbT+bWQ9lbOUd7YARtzqx0XJj7+B/amZbWJ7pK4mAPbeQQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCvpBbTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4D0C4CEEB;
	Tue,  1 Jul 2025 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751370949;
	bh=GtXCufAOk5EVbCLVPR1JO3Sa8rQreS6SSV95Qk73oNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCvpBbTwZVQzu4LM0GMhxCrCIOutdpNNURyWhp38d4audOVK6XxiZJOv6WNZCfEZ5
	 UDF/pI2pUrNFLMNqIkrxuwpVlVUmcGLtr04Yx+mHmgzJBETHkG2yGlqwHhWLWox07j
	 xByGlnKo9gKeNhoWan1KF0akjL+pOzmlCy6RCmK3g6GWh1QojOsrh6cjCg+k8MtZNw
	 xGUbBvDYPQeomT4EctVDwBTotY9dOCk3F2HnJQHUWq99XJB2NRWAKHgp1X8CKJ0b6G
	 CxUSi5KcROIHrLU03rdSQyiBy+ilwWQJtJIwP0WwV8oEpVVDGEfamG1sQiSkPVT+I8
	 R/vFFrUyJ/vNA==
Date: Tue, 1 Jul 2025 13:55:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <aGPMv8ny9+2wm7pY@x1-carbon>
References: <20250625102347.1205584-14-cassel@kernel.org>
 <20250630201902.GA1798294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630201902.GA1798294@bhelgaas>

Hello Bjorn, Mani,

On Mon, Jun 30, 2025 at 03:19:02PM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 25, 2025 at 12:23:51PM +0200, Niklas Cassel wrote:
> > As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> > greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> > training completes before sending a Configuration Request.
> > 
> > Add this delay in dw_pcie_wait_for_link(), after the link is reported as
> > up. The delay will only be performed in the success case where the link
> > came up.
> > 
> > DWC glue drivers that have a link up IRQ (drivers that set
> > use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
> > perform this delay in their threaded link up IRQ handler.
> > 
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 4d794964fa0f..053e9c540439 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -714,6 +714,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  		return -ETIMEDOUT;
> >  	}
> >  
> > +	/*
> > +	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
> > +	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> > +	 * after Link training completes before sending a Configuration Request.
> > +	 */
> > +	if (pci->max_link_speed > 2)
> > +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> 
> Sec 6.6.1 also requires "100 ms following exit from a Conventional
> Reset before sending a Configuration Request to the device immediately
> below that Port" for Downstream Ports that do *not* support Link
> speeds greater than 5.0 GT/s.
> 
> Where does that delay happen?

Argh...

In version 3 of this series, the wait was unconditional, so it handled both
cases:
https://lore.kernel.org/linux-pci/20250613124839.2197945-13-cassel@kernel.org/

But I got a review comment from Mani:
https://lore.kernel.org/linux-pci/hmkx6vjoqshthk5rqakcyzneredcg6q45tqhnaoqvmvs36zmsk@tzd7f44qkydq/

That I should only care about the greater than 5.0 GT/s case.

Perhaps the confusion came about since the comment only mentioned one of the
two the cases specified by PCIe r6.0, sec 6.6.1.

So I think the best thing is either (on top of pci/next):

1) Make the wait unconditional and mention both cases in the comment:

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..c30b1d8d833c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -718,9 +718,15 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 	* As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
 	* speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
 	* after Link training completes before sending a Configuration Request.
+	*
+	* As per PCIe r6.0, sec 6.6.1, a Downstream Port that does not support
+	* Link speeds greater than 5.0 GT/s, software must wait a minimum of
+	* 100 ms following exit from a Conventional Reset before sending a
+	* Configuration Request to the device immediately below that Port.
+	*
+	* For either case, perform the wait here.
 	*/
-	if (pci->max_link_speed > 2)
-		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);


Or:

1) Make the wait unconditional and mention none of the cases in the comment:

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..ce3b5b319550 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -714,13 +714,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
-	/*
-	* As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
-	* speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
-	* after Link training completes before sending a Configuration Request.
-	*/
-	if (pci->max_link_speed > 2)
-		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);


Please tell me what you prefer and I can send a patch on top of pci/next.



Also note that some drivers already do an explicit wait after PERST# has been
deasserted (in addition to the wait while PERST# is asserted), e.g.:
https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pci-imx6.c#L885
https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pcie-qcom.c#L294
https://github.com/torvalds/linux/blob/v6.16-rc4/drivers/pci/controller/dwc/pcie-keembay.c#L89


Kind regards,
Niklas

