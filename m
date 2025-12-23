Return-Path: <linux-pci+bounces-43594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F25CD9940
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 15:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0BD6309C5D7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B4322B92;
	Tue, 23 Dec 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpnvfoa4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D74E314A61;
	Tue, 23 Dec 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499099; cv=none; b=BpM0RHaA/nP/17K8lzXTa/FqteBHNjv3/laNbcb8HhmdYeCwh+OvM3ti/39tIDXp08EHWydejqovDrEeUmuRSkzuK/GU8kGT7WMFr6VN/NYThC8l47GqQZAyjK3/nKbUQHxlLN/bjwomlYBiIR8pPYBD+QAAYarelVjLwOtShLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499099; c=relaxed/simple;
	bh=qg5Wlc0FWYEZe6DnyHhJ5KKMO/2TXY90NCXdHs32ta0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyEdBjr5HvtbLDMiJu7xvI0o0kQWt7xn2BnHVqL8HCV6zWIjMkoFxuyO04Z+evwLPG+DbBcJjO6kKRYg7yCzkWo4IZwQN5tK2lcstctCePQxw4mSb6tWJr2UaLx31//p+yp9pdxHGQ2DbahaZTEn8VmyQ+OWOjj8w0h2H7Xmrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpnvfoa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BE6C16AAE;
	Tue, 23 Dec 2025 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766499099;
	bh=qg5Wlc0FWYEZe6DnyHhJ5KKMO/2TXY90NCXdHs32ta0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpnvfoa4k29G0mgsVrIki5sYupWQ9oR0F31Vv679dtEze35rRq2HklFB3OyCNPBzR
	 n55lesF8eogt8OVhbKFu6jWLMSYaBdutLDNO9KSUw80BGkmPbdNtqAsh4BHCY1Gok6
	 Bf1tU4Amx3+qC6LI6Pa107stp1jc4VF3KQRxJMcGqal+Q22N5Fq1aMZKyBLtfxhmXp
	 qTBeLIhZoauFYC713Yk+WIFK5Zq62bEEEVJzHMgVdAhkRWCaF4Dc8q71SRTInQlwKD
	 eSYCIToag3nQl4rXs1NDfwxL4y06etbBkKvF1uDwPg5+kYpYeqrE7JUH1U4lEtm1hq
	 mcM8uHCwAROuQ==
Date: Tue, 23 Dec 2025 19:41:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v2 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
Message-ID: <tutxwjciedqoje5wxvtin4h637auni5zzpvb7rtfg4uticxoux@yfl6xg7oht7t>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
 <20251216-pci-pwrctrl-rework-v2-5-745a563b9be6@oss.qualcomm.com>
 <dec83f5f-6238-43b3-8fe7-41f301347935@seco.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dec83f5f-6238-43b3-8fe7-41f301347935@seco.com>

On Fri, Dec 19, 2025 at 01:35:39PM -0500, Sean Anderson wrote:
> On 12/16/25 07:51, Manivannan Sadhasivam wrote:
> > Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
> > and power off pwrctrl devices. In qcom_pcie_host_init(), call
> > pci_pwrctrl_create_devices() to create devices, then
> > pci_pwrctrl_power_on_devices() to power them on, both after controller
> > resource initialization. Once successful, deassert PERST# for all devices.
> >
> > In qcom_pcie_host_deinit(), call pci_pwrctrl_power_off_devices() after
> > asserting PERST#. Note that pci_pwrctrl_destroy_devices() is not called
> > here, as deinit is only invoked during system suspend where device
> > destruction is unnecessary. If the driver becomes removable in future,
> > pci_pwrctrl_destroy_devices() should be called in the remove() handler.
> >
> > At last, remove the old pwrctrl framework code from the PCI core, as the
> > new APIs are now the sole consumer of pwrctrl functionality. And also do
> > not power on the pwrctrl drivers during probe() as this is now handled by
> > the APIs.
> >
> > Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c   | 22 ++++++++++--
> >  drivers/pci/probe.c                      | 59 --------------------------------
> >  drivers/pci/pwrctrl/core.c               | 15 --------
> >  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  5 ---
> >  drivers/pci/pwrctrl/slot.c               |  2 --
> >  drivers/pci/remove.c                     | 20 -----------
> >  6 files changed, 20 insertions(+), 103 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 73032449d289..7c0c66480f12 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/of_pci.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-ecam.h>
> > +#include <linux/pci-pwrctrl.h>
> >  #include <linux/pm_opp.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/platform_device.h>
> > @@ -1318,10 +1319,18 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >       if (ret)
> >               goto err_deinit;
> >
> > +     ret = pci_pwrctrl_create_devices(pci->dev);
> > +     if (ret)
> > +             goto err_disable_phy;
> > +
> > +     ret = pci_pwrctrl_power_on_devices(pci->dev);
> 
> Won't this result in a deferred probe loop if there is more than one
> pwrctrl device and one has a driver loaded but the other does not?
> 
> deferred_probe_work_func()
>   driver_probe_device(controller)
>     qcom_pcie_probe(controller)
>       pci_pwrctrl_create_devices()
>         device_add(pwrctrl1)
>           (probe successful)
>           driver_deferred_probe_trigger()
>         device_add(pwrctrl2)
>           (driver not loaded)
>       pci_pwrctrl_power_on_devices()
>         return -EPROBE_DEFER
>       pci_pwrctrl_destroy_devices()
>         device_unregister(pwrctrl1)
>         device_unregister(pwrctrl2)
>     driver_deferred_probe_add(controller)
>     // deferred_trigger_count changed, so...
>     driver_deferred_probe_trigger()
> 
> And now you will continually probe the controller until all of the
> drivers are loaded.
> 
> There is a non-obvious property of the deferred probe infrastructure
> which is:
> 
>         Once a device creates children, it must never fail with
>         EPROBE_DEFER.
> 
> So if you want to have something like this, the pwrctrl devices need to
> be created before the controller is probed. Or you can use the current
> system where the pwrctrl devices are probed asynchronously.
> 

You are right and it is an oversight from me. If the pwrctrl driver is not
found, the pwrctrl devices should not be destroyed in the error path, but the
controller driver can still return -EPROBE_DEFER. This will allow the controller
driver to get reprobed later and by that time, pwrctrl device creation will be
skipped. I believe this satisfies the comment you quoted above.

I found this issue while testing the series with one of our Qcom switches and I
fixed it in yet to be submitted v3.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

