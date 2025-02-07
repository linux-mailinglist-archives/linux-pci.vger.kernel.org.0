Return-Path: <linux-pci+bounces-20912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD5AA2C8B6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C133A978F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FEB189B94;
	Fri,  7 Feb 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAdAD63Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5A23C8C5;
	Fri,  7 Feb 2025 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945582; cv=none; b=hORszu2FEaduGf8U7ohBhiEq+ZrOhuJBsy74//PlKI46x4y5mrf6A4Uoe5vj87sNCQa1s8JOHKjDdrPBlHzSkrCiyFDjIXwVCG7FQaEJpOcBro+9MKALVaJOjfN6H9QW2/aAPK6KuQbQpfQLpJayAJ5e2xdLOw7zfFxk3QSTeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945582; c=relaxed/simple;
	bh=Z+23uYCPl3ES/TnEirPH6od61dFnbsbYONvlDb8AxhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI/Z1UMGiKbbGaDjRjG8Sfwvza5qxHS+fKBVvHBWH/mU1cXiC/JpteyRcJu2b/hZTKgBouBd/UICnrDjx36j5yttvyRldoFM08d9XZgCeddECnukZwSEsHj2YFXPB6z8CUCNIw+WvLARBx5+LEjA23mtLslzOqwIgEXpgA0OJk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAdAD63Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F25C4CED1;
	Fri,  7 Feb 2025 16:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738945581;
	bh=Z+23uYCPl3ES/TnEirPH6od61dFnbsbYONvlDb8AxhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAdAD63QAj0slvJUgQanww6BNt31Ti49f1rHTmTdsTakP4eSnvcathTR60y93R/j/
	 lLYbaRwIE3c39Bcq/BMEtFsHpoY121jDeyzqYcBUiKPX2CKc5ijJACpwrDfqPYuILz
	 PaLbR9AXANWjCb/cOjMxfQC9m9VazW7drAMXZgub43MTqReEiizyeupMDRhzN2Ipfb
	 r4/KIsd6TCRLLSOWxHoVeepMQbFlGWKXbLTOOYC5mkzxZe4kRzsrpAbK53FyvCTtqq
	 r4mS7kwHSaTlMkocGM9mbZCDAWr9ZJywtazy8HEPCuZl8II6pkHAfRZFrT4fu3fHTl
	 mgC4HoDGLcVbQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tgRBW-000000004oe-034F;
	Fri, 07 Feb 2025 17:26:30 +0100
Date: Fri, 7 Feb 2025 17:26:30 +0100
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1] PM: sleep: core: Synchronize runtime PM status of
 parents and children
Message-ID: <Z6Y0NlW40yHTIlzm@hovoldconsulting.com>
References: <12619233.O9o76ZdvQC@rjwysocki.net>
 <1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com>
 <Z6YPpbRF_U0TxAbf@hovoldconsulting.com>
 <Z6YcjFBWAVVVANf2@hovoldconsulting.com>
 <CAJZ5v0iHjkfoh2A+hAmMCTG9_nBcJrsRYFD0Hp4ZChYUo7bFEg@mail.gmail.com>
 <Z6YviAFD4Az3EIBa@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6YviAFD4Az3EIBa@hovoldconsulting.com>

On Fri, Feb 07, 2025 at 05:06:32PM +0100, Johan Hovold wrote:
> On Fri, Feb 07, 2025 at 04:41:18PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Feb 7, 2025 at 3:45 PM Johan Hovold <johan@kernel.org> wrote:
> > > On Fri, Feb 07, 2025 at 02:50:29PM +0100, Johan Hovold wrote:
> 
> > > Ok, so the driver data is never set and runtime PM is never enabled for
> > > this simple bus device, which uses pm_runtime_force_suspend() for system
> > > sleep.
> > 
> > This is kind of confusing.  Why use pm_runtime_force_suspend() if
> > runtime PM is never enabled and cannot really work?
> 
> It's only done for some buses that this driver handles. The driver is
> buggy; I'm preparing a fix for it regardless of the correctness of the
> commit that now triggered this.

Hmm. The driver implementation is highly odd, but actually works as long
as the runtime PM status is left at 'suspended' (as
pm_runtime_force_resume() won't enable runtime PM unless it was enabled
before suspend).

So we'd strictly only need something like the below if we are going to
keep the set_active propagation.

Johan


diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 5dea31769f9a..d8e029e7e53f 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -109,9 +109,29 @@ static int simple_pm_bus_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int simple_pm_bus_suspend(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+
+	if (!bus)
+		return 0;
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int simple_pm_bus_resume(struct device *dev)
+{
+	struct simple_pm_bus *bus = dev_get_drvdata(dev);
+
+	if (!bus)
+		return 0;
+
+	return pm_runtime_force_resume(dev);
+}
+
 static const struct dev_pm_ops simple_pm_bus_pm_ops = {
 	RUNTIME_PM_OPS(simple_pm_bus_runtime_suspend, simple_pm_bus_runtime_resume, NULL)
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(simple_pm_bus_suspend, simple_pm_bus_resume)
 };
 
 #define ONLY_BUS	((void *) 1) /* Match if the device is only a bus. */

