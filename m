Return-Path: <linux-pci+bounces-17471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795249DEC65
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F611280F84
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6131A2543;
	Fri, 29 Nov 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUFwsCwt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C01A2540;
	Fri, 29 Nov 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908493; cv=none; b=LAJdpvJt9gtlAt3RrJll8OvqS1iSlcSmJI53gxuy/AJB0F/Qpuq8m1kzdG1vCeOLSNs8RKUd+uUYW2g9wzIJSIJoFcNkUxU5V+rwow95ms3hdZVGhCYkOj5BQ61WVE3JEMYnQB2r5MTFb6L9QecNt7S4uOhendFY5xQhKPRhkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908493; c=relaxed/simple;
	bh=YUBNEKerjnF9sJxgRIEtwczqegjsidQJrznhM2o8pkw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=INbFzFIxg+SGtk4IPC7ewpOJR+p4N4OnBqf5QLyS4VkLGieQgYL0eQlo9TxrCfpC/HoJo1UWxmibQRH0t1kUNavyXkHGR3O83gEti8fKx5NjLnAmDlLOlegst/RlJmv/Nl2pGlQ3DUuEEH+BJnAT2Qvg/cwWMYxRiPwtrMWgl2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUFwsCwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04474C4CECF;
	Fri, 29 Nov 2024 19:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732908493;
	bh=YUBNEKerjnF9sJxgRIEtwczqegjsidQJrznhM2o8pkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jUFwsCwtnFS4q5m1lQdJSStT+G7aKpE1fVpnWt2427fGo69gVAg3vu92BcvE2LNRl
	 Tv+R74fB52jK7AMU2HAW/njHE09M03+j8hgNEqGUeM6V03pwXdh8X2fO4RiyTvmKFk
	 UeKu0mBnlSozBn7UOrjMYtA5+mgsDHZLwYgeqXmYmzqD6rM3fFZtQjPgsmdL6wh3QI
	 1yhely6z6XDrjPW4fv04ScAed/Qx74iZp/78kJuPn/+MdFfK5K+zlpRvw6o9cmAyxx
	 BvUl2k9+TifYIVSTTekRDGCKrkSdV2n92X043pDD08c7Rpfzvg9TgH8ILpFNF+4Zmj
	 csr+UVWl+MZ5A==
Date: Fri, 29 Nov 2024 13:28:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH 6.13] PCI/pwrctrl: Skip NULL of_node when unregistering
Message-ID: <20241129192811.GA2768738@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126210443.4052876-1-briannorris@chromium.org>

[+cc Jon, Saurabh]

On Tue, Nov 26, 2024 at 01:04:34PM -0800, Brian Norris wrote:
> of_find_device_by_node() doesn't like a NULL pointer, and may end up
> identifying an arbitrary device, which we then start tearing down. We
> should check for NULL first.

I assume pci_pwrctrl_unregister() is unregistering something added by
pci_pwrctrl_create_devices() in pci_bus_add_device()?

There are a couple things I don't like about this code (these are
unrelated to this particular regression fix, but they make me worry
that I'm misunderstanding how this all works):

  - pci_pwrctrl_create_devices() and pci_pwrctrl_unregister() are not
    parallel names.

  - pci_pwrctrl_create_devices() has a loop and potentially creates
    several pwrctrl devices, one for each child that has a "*-supply"
    property, but there is no corresponding loop in
    pci_pwrctrl_unregister().

I see that 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without
iterating over all children of pwrctl parent") is at least partly
*about* removing without iterating, and the commit log has some
explanation about how pwrctrl devices lying around will get removed,
but the lack of parallelism is a hassle for readers.

The subject and commit log also refer to "*the* pwrctl device," which
suggests there is only one, but that seems slightly misleading even
though it goes on to mention "any pwrctl devices lying around."

If they get removed when the parent gets removed, why do we need to
remove *any* of them?  Is the real point that we need to clear
OF_POPULATED?

Maybe I'm missing the whole point here?

> [  222.965216] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
> ...
> [  223.107395] CPU: 3 UID: 0 PID: 5095 Comm: bash Tainted: G        WC         6.12.0-rc1 #3
> ...
> [  223.227750] Call trace:
> [  223.230501]  pci_stop_bus_device+0x190/0x1b0
> [  223.235314]  pci_stop_and_remove_bus_device_locked+0x28/0x48
> [  223.241672]  remove_store+0xa0/0xb8
> [  223.245616]  dev_attr_store+0x20/0x40
> [  223.249737]  sysfs_kf_write+0x4c/0x68
> [  223.253859]  kernfs_fop_write_iter+0x128/0x200
> [  223.253887]  do_iter_readv_writev+0xdc/0x1e0
> [  223.263631]  vfs_writev+0x100/0x2a0
> [  223.267550]  do_writev+0x84/0x130
> [  223.271273]  __arm64_sys_writev+0x28/0x40
> [  223.275774]  invoke_syscall+0x50/0x120
> [  223.279988]  el0_svc_common.constprop.0+0x48/0xf0
> [  223.285270]  do_el0_svc+0x24/0x38
> [  223.288993]  el0_svc+0x34/0xe0
> [  223.292426]  el0t_64_sync_handler+0x120/0x138
> [  223.297311]  el0t_64_sync+0x190/0x198
> [  223.301423] Code: 17fffff8 91030000 d2800101 f9800011 (c85f7c02)
> [  223.308248] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  drivers/pci/remove.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 963b8d2855c1..efc37fcb73e2 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -19,14 +19,19 @@ static void pci_free_resources(struct pci_dev *dev)
>  
>  static void pci_pwrctrl_unregister(struct device *dev)
>  {
> +	struct device_node *np;
>  	struct platform_device *pdev;
>  
> -	pdev = of_find_device_by_node(dev_of_node(dev));
> +	np = dev_of_node(dev);
> +	if (!np)
> +		return;
> +
> +	pdev = of_find_device_by_node(np);
>  	if (!pdev)
>  		return;
>  
>  	of_device_unregister(pdev);
> -	of_node_clear_flag(dev_of_node(dev), OF_POPULATED);
> +	of_node_clear_flag(np, OF_POPULATED);
>  }
>  
>  static void pci_stop_dev(struct pci_dev *dev)
> -- 
> 2.47.0.338
> 

