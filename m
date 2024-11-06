Return-Path: <linux-pci+bounces-16146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD339BF237
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 16:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D8D285551
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB48203709;
	Wed,  6 Nov 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLI4m8V8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8A190079;
	Wed,  6 Nov 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908187; cv=none; b=gXRgo6dWnAAiyJrbO0lN0sWelCYmDpIftOG9wdezfuc0EWE9VblToknNjP+8XPUj5WzJ3jAanFufKxGV1Zd69XbJL58oFlSQBIFdLKlF+QRZ7mJJK+hctSV7QyH6HJYTKrKG4r/dFwCFOi69OdLsDtzOBT60uCigdq6ZgBflr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908187; c=relaxed/simple;
	bh=FgAAS0grrWTmncw1PDMvpu8itvg5qcH9lr5R3c5RBQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qHhLNtrI8mQ0CFaBtn0jFySU/8JUwz/WjEUan/IR5nBY8JGrA8xdVm9GUb15+RWz74Hq9yZGrDBm5RNEg0h7IosJpOcYOoMt/rUZ0INtEP+T6O9A/Aysj/8HaRW1aFMbas7OPDroHrHszfIbZZQ121KAh9plvBfW0vmyvO0FwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLI4m8V8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4902C4CEC6;
	Wed,  6 Nov 2024 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730908186;
	bh=FgAAS0grrWTmncw1PDMvpu8itvg5qcH9lr5R3c5RBQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KLI4m8V8ysxLfzGkQNN5S218DMpJBtzWgzEj8jBhuMUYzU9WyCvKP7K/BRkfUsCe9
	 P25NWjkP63S8LWeClBNKPD3PnkOD6AUqPwThyzj/KW11H7JUkUvjlHWpAlEJSSPvMz
	 lhp2uzdYhHbbOOUGmk7AFTL3jIS7fUf75mJKGznIIK9la6aVCGH825o3I+6ZlxMbSI
	 1MNtwnQlJn5z6TyGjTexY2cTcSKQf96XZGEmY5fXDiotPWjEY229wySOxexnsRZt6h
	 zmb8b6TEUD1/KYCHDUw2Sw4WcUSOW31gGIMb1MMcdKsJzep3tZEOgA5lN4PktQg8lS
	 9ZrhWrXmpUiJQ==
Date: Wed, 6 Nov 2024 09:49:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	kishon@kernel.org, u.kleine-koenig@pengutronix.de,
	cassel@kernel.org, dlemoal@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v2 1/2] PCI: keystone: Set mode as RootComplex for
 "ti,keystone-pcie" compatible
Message-ID: <20241106154945.GA1526156@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5983ad5e-729d-4cdc-bdb4-d60333410675@ti.com>

On Wed, Nov 06, 2024 at 11:36:38AM +0530, Siddharth Vadapalli wrote:
> On Tue, Nov 05, 2024 at 06:57:58PM -0600, Bjorn Helgaas wrote:
> > On Fri, May 24, 2024 at 04:27:13PM +0530, Siddharth Vadapalli wrote:
> > > From: Kishon Vijay Abraham I <kishon@ti.com>
> > > 
> > > commit 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x
> > > Platforms") introduced configuring "enum dw_pcie_device_mode" as part of
> > > device data ("struct ks_pcie_of_data"). However it failed to set mode
> > > for "ti,keystone-pcie" compatible. Set mode as RootComplex for
> > > "ti,keystone-pcie" compatible here.
> > 
> > 23284ad677a9 appeared in v5.10.  
> > 
> > But I guess RC support has not been broken since v5.10 because we
> > never used ks_pcie_rc_of_data.mode anyway?
> > 
> > It looks like the only use is here:
> > 
> >   #define DW_PCIE_VER_365A                0x3336352a
> >   #define DW_PCIE_VER_480A                0x3438302a
> > 
> >   ks_pcie_probe
> >   {
> >     ...
> >     mode = data->mode;
> >     ...
> >     if (dw_pcie_ver_is_ge(pci, 480A))
> >       ret = ks_pcie_am654_set_mode(dev, mode);
> >     else
> >       ret = ks_pcie_set_mode(dev);
> 
> "mode" is used later on during probe at:
> 
> ....
> 	switch (mode) {
> 	case DW_PCIE_RC_TYPE:
> 	...
> 	case DW_PCIE_EP_TYPE:
> 	...
> 	default:
> 		dev_err(dev, "INVALID device type %d\n", mode);
> 	}
> ....

How did I miss that? :)  It is literally two lines down.

> > so we don't even look at .mode unless the version is v4.80a or later,
> > and this is v3.65a?
> > 
> > So this is basically a cosmetic fix (but still worth doing for
> > readability!) and doesn't need a stable backport, right?
> 
> I suppose that "data->mode" will default to zero for v3.65a prior to
> this commit, corresponding to "DW_PCIE_UNKNOWN_TYPE" rather than the
> correct value of "DW_PCIE_RC_TYPE". Since I don't have an SoC with the
> v3.65a version of the controller, I cannot test it out, but I presume
> that the "INVALID device type 0" error will be displayed. Though the probe
> will not fail since the "default" case doesn't return an error code, the
> controller probably will not be functional as the configuration associated
> with the "DW_PCIE_RC_TYPE" case has been skipped. Hence, I believe that
> this fix should be backported.

I guess nobody really cares too much since it's been broken for almost
four years.

But indeed, sounds like it should have a stable tag and maybe a commit
log hint about what the failure looks like.

Thanks!

Bjorn

