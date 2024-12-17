Return-Path: <linux-pci+bounces-18624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2179F4C36
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6CC16C6DF
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99F1F4E5E;
	Tue, 17 Dec 2024 13:14:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96881F1917;
	Tue, 17 Dec 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441279; cv=none; b=u7CNAGEIwXWY68Nkspel4E95flDDNJedlrdabI/E2FxP/Lo1jWYaCi9KrhNvXpelQdzML32/bGfdkIlocdpMLdurzRcW28MOhja7NSnEdQ+UeUO9GyHe5g7oxEfBB6V//Ur+EhKzmEj6SBSSFaaNbCRyiV66KY3o4oPiQ/x8SOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441279; c=relaxed/simple;
	bh=Cjpr9CcVpVM25bPTQuttBnuv0tom7ghF6pk8/NpXFdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLxys4Qadkdb1UVy4t+A+hJzc+1ZunG7oPtQeEEDtgtEz34zRtw6r06Z9tX3mfBWzLd7Pe0idJhab3UVdwJ9iuowZiEcIhYapQzV4OnbM0gVbluRjSD3O1JtQzRYgY49aEVsRFcb18cJNp5FiJ8+c8QSTvBBgnlSL8NqbQKLFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7D7A82800B4B5;
	Tue, 17 Dec 2024 14:14:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 67A895FFC39; Tue, 17 Dec 2024 14:14:34 +0100 (CET)
Date: Tue, 17 Dec 2024 14:14:34 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>
Subject: Re: [PATCH 1/4] PCI/pwrctrl: Move creation of pwrctrl devices to
 pci_scan_device()
Message-ID: <Z2F5Oph2o8o_LiZc@wunner.de>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <20241210-pci-pwrctrl-slot-v1-1-eae45e488040@linaro.org>
 <Z18Pmq7_rK3pvuT4@wunner.de>
 <20241216051521.riyy5radru6rxqhg@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216051521.riyy5radru6rxqhg@thinkpad>

On Mon, Dec 16, 2024 at 10:45:21AM +0530, Manivannan Sadhasivam wrote:
> On Sun, Dec 15, 2024 at 06:19:22PM +0100, Lukas Wunner wrote:
> > On Tue, Dec 10, 2024 at 03:25:24PM +0530, Manivannan Sadhasivam wrote:
> > > diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> > > index 2fb174db91e5..9cc7e2b7f2b5 100644
> > > --- a/drivers/pci/pwrctrl/core.c
> > > +++ b/drivers/pci/pwrctrl/core.c
> > > @@ -44,7 +44,7 @@ static void rescan_work_func(struct work_struct *work)
> > >  						   struct pci_pwrctrl, work);
> > >  
> > >  	pci_lock_rescan_remove();
> > > -	pci_rescan_bus(to_pci_dev(pwrctrl->dev->parent)->bus);
> > > +	pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
> > >  	pci_unlock_rescan_remove();
> > >  }
> > 
> > Remind me, what's the purpose of this?  I'm guessing that it
> > recursively creates the platform devices below the newly
> > powered up device, is that correct?  If so, is it still
> > necessary?  Doesn't the new approach automatically create
> > those devices upon their enumeration?
> 
> If the pwrctrl driver is available at the time of platform device creation,
> this is not needed. But if the driver is not available at that time and
> probed later, then we need to rescan the bus to enumerate the devices.

I see.  Sounds like this can be made conditional on the caller
being a module.  I think you could achieve this with the following
in pci_pwrctl_device_set_ready():

-	schedule_work(&pwrctl->work);
+	if (is_module_address(_RET_IP_))
+		schedule_work(&pwrctl->work);

Though you'd also have to declare pci_pwrctl_device_set_ready()
"__attribute__((always_inline))" so that it gets inlined into
devm_pci_pwrctl_device_set_ready() and the condition works there
as well.

I'm wondering whether the bus notifier is still necessary with
the new scheme.  Since the power control device is instantiated
and destroyed in unison with the pci_dev, can't the device link
always be created on instantiation of the power control device?

Thanks,

Lukas

