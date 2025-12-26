Return-Path: <linux-pci+bounces-43743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C34CDF1A7
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 00:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B3C93007619
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990FA28641F;
	Fri, 26 Dec 2025 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm/yj8HS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8F1391;
	Fri, 26 Dec 2025 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766790433; cv=none; b=UiNIIm9OSsk+PMzyCvuSGawSuhdGikewXJMbJOjTCrchhBFRj9RHKtEWb4GiGpY+kV/s87Nn8+w06yedBvhDg/5o9/qJBbtvrsxFDo1oH+/CT8bRbzp+37d755uMneJZe3eBerTns/TAz8Q9mmNvWQkSgemJTTXIHbc/dUWThMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766790433; c=relaxed/simple;
	bh=WVlYEyUPSeq2vaHDNlsnmC4rv18ZSMMtnZ8XazsYtBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=U+1SvPhQ6Xa/qolTaEMYe0FsZK0ADB26UKz95oRu61viM9ooCoPAZb4mOUvNQxd+NNytxHZm7naFzGcBzXEHqJpzdfemz5kjcW1fi5pfK4D6fBKDZAspakcT81m2ijr1OAGyjMy95iCy2xN+rtN8yyN56dcaNhp14ECqgBny9hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm/yj8HS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE3AC4CEF7;
	Fri, 26 Dec 2025 23:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766790432;
	bh=WVlYEyUPSeq2vaHDNlsnmC4rv18ZSMMtnZ8XazsYtBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Pm/yj8HS5M3sY7gKDKYPcIXjKHtNhwyLpEukTHbzmWllPAoeUOkmKl9pS8u45rGOt
	 1u/hxT4ou1vvJUE6uDLLV7ydPBYsevIbJhoT2cM/e7dsN1Bxti46KjpD74gpVI8BVb
	 DXyYI68xA8XPXbANhGb6zDFGDpACT+OppNwUQOcToblUxKzjkRfBGcIn5PIpQCsMbL
	 5aZGp1z4VBMOQ3jaWJjL60RAqj4pz3o3q0YkC4q7lRPOK0v728VESr7f3OTb+bX6ud
	 GuMN4q00e+cbNvLh3RBnSMPTddLJ5cHOsXCbPuSb9uTF6Zd62arFAdGtMbZtJGbhdL
	 WK/25NvvYWfOA==
Date: Fri, 26 Dec 2025 17:07:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sean Anderson <sean.anderson@seco.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
Message-ID: <20251226230711.GA4146413@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tutxwjciedqoje5wxvtin4h637auni5zzpvb7rtfg4uticxoux@yfl6xg7oht7t>

On Tue, Dec 23, 2025 at 07:41:30PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Dec 19, 2025 at 01:35:39PM -0500, Sean Anderson wrote:
> > On 12/16/25 07:51, Manivannan Sadhasivam wrote:
> > > Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
> > > and power off pwrctrl devices. In qcom_pcie_host_init(), call
> > > pci_pwrctrl_create_devices() to create devices, then
> > > pci_pwrctrl_power_on_devices() to power them on, both after controller
> > > resource initialization. Once successful, deassert PERST# for all devices.

> ...
> > And now you will continually probe the controller until all of the
> > drivers are loaded.
> > 
> > There is a non-obvious property of the deferred probe infrastructure
> > which is:
> > 
> >         Once a device creates children, it must never fail with
> >         EPROBE_DEFER.
> > 
> > So if you want to have something like this, the pwrctrl devices need to
> > be created before the controller is probed. Or you can use the current
> > system where the pwrctrl devices are probed asynchronously.
> 
> You are right and it is an oversight from me. If the pwrctrl driver
> is not found, the pwrctrl devices should not be destroyed in the
> error path, but the controller driver can still return
> -EPROBE_DEFER. This will allow the controller driver to get reprobed
> later and by that time, pwrctrl device creation will be skipped. I
> believe this satisfies the comment you quoted above.
> 
> I found this issue while testing the series with one of our Qcom
> switches and I fixed it in yet to be submitted v3.

I guess I should wait for v3 before putting this in linux-next?

