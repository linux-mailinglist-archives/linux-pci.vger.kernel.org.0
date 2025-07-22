Return-Path: <linux-pci+bounces-32722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C34FB0D8C7
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 14:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630E116969F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA36028A1D5;
	Tue, 22 Jul 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slrGHiF3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96B2356DA;
	Tue, 22 Jul 2025 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185661; cv=none; b=WmY9GDQyyRivWdtyuBDnPsYn51KUuAnXcU/WPwQPzoeSYvcNIJEJ4DR8A+vRFhnQwi0zTAV05M+XOYEQPTmd25mt5Uk0nkghxIZ8A7l9N5xJbMgz/kLrVIe+VhNbJ0IhB+lI3ml0qF4cjlSpjan3+PHwe7YARsTIRbNJvUtdX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185661; c=relaxed/simple;
	bh=ftwyc4Rsa5PkJtcbA2GUll7HG+Q6Q06RPAVEveTG0uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWWppPUCzrWWLhBQ0GsdyRNoy/KYsYKirPzVum1b2eJRO4sAZ4e/Uu1VOB0wS5BalzqB4Bs7xt2E4ugt5wQy2oQxHm8wYtARyehJnBbFquur+UnyrLLKbGsFRvU8jvueuMAKcy/mGtuF+17NBlhci/i4La26LW8zJyrirMJ4fLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slrGHiF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18838C4CEEB;
	Tue, 22 Jul 2025 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753185661;
	bh=ftwyc4Rsa5PkJtcbA2GUll7HG+Q6Q06RPAVEveTG0uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slrGHiF3zjYaMc60IUNK6RjWE3rdbO2DQBO8dNxOtCo8AqXh+e8ZVnFDuTJLKm3sV
	 qPxxiVnx6HuvBdZBICMTbRy6cys+7bQwWK6PWUJncEcga/3onpycniF3/PcKP4o9sV
	 W4hhlTq7WGbYYIZdegFSm8/UANecYid4haKbKnziKFJE2mfRl+1T8bbvn58cW3VIRh
	 R/JfaPOum/o5RRxKYUcxvVAfpmGxKzDiUjQZU/FJOdzhe6M8ne8yDD/lfnhG6b1rXQ
	 GkZb/G1XOSjVESgAML8GizFmHrK6lO2l7WyqUMniRJtRk2clg2JPszFUeGRZ3o3uoa
	 8qYtcPnJGQhGg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueBfu-000000002NY-0V1w;
	Tue, 22 Jul 2025 14:00:50 +0200
Date: Tue, 22 Jul 2025 14:00:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI/pwrctrl: Fix device leak at registration
Message-ID: <aH99cmBkOwCOkIZk@hovoldconsulting.com>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
 <20250721153609.8611-2-johan+linaro@kernel.org>
 <20250722110526.00002a60@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722110526.00002a60@huawei.com>

On Tue, Jul 22, 2025 at 11:05:26AM +0100, Jonathan Cameron wrote:
> On Mon, 21 Jul 2025 17:36:07 +0200
> Johan Hovold <johan+linaro@kernel.org> wrote:

> Perhaps time for 
> DEFINE_FREE(put_pdev, struct platform_device *, if (_T) put_device(&_T->dev));
> 
> then...
> 
> > ---
> >  drivers/pci/bus.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 69048869ef1c..0394a9c77b38 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -362,11 +362,15 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  	 * before PCI client drivers.
> >  	 */
> >  	pdev = of_find_device_by_node(dn);
> > -	if (pdev && of_pci_supply_present(dn)) {
> > -		if (!device_link_add(&dev->dev, &pdev->dev,
> > -				     DL_FLAG_AUTOREMOVE_CONSUMER))
> > -			pci_err(dev, "failed to add device link to power control device %s\n",
> > -				pdev->name);
> 
> 	struct platform_device *pdev __free(put_pdev) =
> 		of_find_device_by_node(dn);
> > +	if (pdev) {
> > +		if (of_pci_supply_present(dn)) {
> > +			if (!device_link_add(&dev->dev, &pdev->dev,
> > +					     DL_FLAG_AUTOREMOVE_CONSUMER)) {
> > +				pci_err(dev, "failed to add device link to power control device %s\n",
> > +					pdev->name);
> > +			}
> > +		}
> > +		put_device(&pdev->dev);
> 
> and no need for any explicit put.
> 
> We already do this extensively in some subsystems (e.g. CXL) and it
> greatly simplifies code.

No, I'm no fan of those kind of changes which I find leads to less
readable code (e.g. with those in-code declarations).

Johan

