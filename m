Return-Path: <linux-pci+bounces-17124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B967A9D42EC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 21:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46851B284A6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5031547F5;
	Wed, 20 Nov 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsNxpOF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5BC13BAF1;
	Wed, 20 Nov 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732133921; cv=none; b=Ghl4CbcFnHOeV9tgXxGcv2ViXCpCRScURgXRGezhkpd/UKlDw0eXR0TOZ6Yv3VFuN/Y7FGCgGHfIrtVFywApdZD0nSCiZIwcn7Vh5knUhI1HirBkVoWUEeTkFr8+5DcAv9zeU2S1ANyXXH+cljt+xHRf7C4DAvktu0pkuFQECj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732133921; c=relaxed/simple;
	bh=q71co9KL5zesMOjvf6uYR/ptvSfu9B5sOZoZT1dd3+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=daLBWo4ruKyZJHXan7jn/rA0BWe0De9wqpJVOR4gNd6FHb0kpfx2dWcsYDtoluTLvPmA+XxPpfFPbZq+lotgv3u3KCejPcmMm1PvMcRS8QHqZ0fQVLT+pE5o07i+61Jo02O/XYtizf11VoiI8ORsfZP7p3gtrALAqLyTxIO/7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsNxpOF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0DDC4CECD;
	Wed, 20 Nov 2024 20:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732133920;
	bh=q71co9KL5zesMOjvf6uYR/ptvSfu9B5sOZoZT1dd3+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XsNxpOF7OkaXE74VQxzRwQj2nW2kM7MgAnU/937b22SCoNdZGXCjs8CU44HtDuqLA
	 n+XZP4huartUD2g38F7t/AfB+1/JBM/sTOh5Bf9CcO2sheC7js0YiMkQBYgJThVCYx
	 4oa0MgUDEszAX81gKlBsxs+7adSmHFSfM45HTJEqp3HgicIZ8A4nhuHCTuSXMr1HnW
	 m50rDFh6wZGOH196jWJnH/DZcDZ/dItjw/EAVl9yxqp4WYj2XdlO5WvcQW10QJVepD
	 K1HGbkr9hkpFPTeN7sYIsdCqjnv05fjvJpUNRAV9Fst7dwMoet39I5fr7g6pwbb/AR
	 Mi5lTmEboI+bw==
Date: Wed, 20 Nov 2024 14:18:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 3/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before the PCI client drivers
Message-ID: <20241120201839.GA2338274@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120170232.flllyqcycsrsk6cj@thinkpad>

On Wed, Nov 20, 2024 at 10:32:32PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Nov 20, 2024 at 10:10:47AM -0600, Bjorn Helgaas wrote:
> > On Fri, Oct 25, 2024 at 01:24:53PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > As per the kernel device driver model, pwrctl device is the supplier for
> > > the PCI device. But the device link that enforces the supplier-consumer
> > > relationship is created inside the pwrctl driver currently. Due to this,
> > > the driver model doesn't prevent probing of the PCI client drivers before
> > > probing the corresponding pwrctl drivers. This may lead to a race condition
> > > if the PCI device was already powered on by the bootloader (before the
> > > pwrctl driver).
> > 
> > > +	 * Create a device link between the PCI device and pwrctl device (if
> > > +	 * exists). This ensures that the pwrctl drivers are probed before the
> > > +	 * PCI client drivers.
> > > +	 */
> > > +	pdev = of_find_device_by_node(dn);
> > > +	if (pdev) {
> > > +		if (!device_link_add(&dev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> > > +			pci_err(dev, "failed to add device link between %s and %s\n",
> > > +				dev_name(&dev->dev), pdev->name);
> > 
> > This prints the name for "dev" twice (once by pci_err(dev) and again
> > from dev_name(&dev->dev)).  Is it helpful to see it twice here?
> 
> Hmm, not very much. It could be reworded as below:
> 
> 	pci_err(dev, "failed to link: %s\n", pdev->name);

OK.  I updated the comment and the message like this (also renamed
of_pci_is_supply_present() to of_pci_supply_present() so it reads more
naturally in "if" statements):

-	 * Create a device link between the PCI device and pwrctrl device (if
-	 * exists). This ensures that the pwrctrl drivers are probed before the
-	 * PCI client drivers.
+	 * If the PCI device is associated with a pwrctrl device with a
+	 * power supply, create a device link between the PCI device and
+	 * pwrctrl device.  This ensures that pwrctrl drivers are probed
+	 * before PCI client drivers.
 	 */
 	pdev = of_find_device_by_node(dn);
-	if (pdev) {
+	if (pdev && of_pci_supply_present(dn)) {
 		if (!device_link_add(&dev->dev, &pdev->dev,
 				     DL_FLAG_AUTOREMOVE_CONSUMER))
-			pci_err(dev, "failed to add device link between %s and %s\n",
-				dev_name(&dev->dev), pdev->name);
+			pci_err(dev, "failed to add device link to power control device %s\n",
+				pdev->name);
 	}

