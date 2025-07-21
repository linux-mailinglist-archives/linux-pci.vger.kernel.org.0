Return-Path: <linux-pci+bounces-32621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0462B0BD57
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C713BD69D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55A27F006;
	Mon, 21 Jul 2025 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5G6tq1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED126F449
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082163; cv=none; b=tYNu1ah4+8d09lLfnS2aVBI3nXTAfEZfkfR78snTH5MEdiV+ob0zGIHcAxofbkTtytsu12sWPad9EcRKFu8UksTaGAZhwoxh5LtIUZbeSX0pnFXQ17MVSUsqKHPTmpj+A7RwHi9Vr5y9GaEz1dGiXe1BhcL0UrMUVrSOm8qb3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082163; c=relaxed/simple;
	bh=xGTcX1ux2vw4d85+cDd+19Ti6NSd8WC+Ot3o18ARsLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reqDJiIL4RoXiCmu5KGbs8WzM+zq3GpIMeyEGBY7CQKb+BhQNeDVshWwc6ClatEgAOc961vWs3j6yPf+tFZ57umeP5sbaCFxoga13keSFbxcNz+V1RP5i14xRkAxDUOnnpoYAhQsWJczr4KrF8DJ8xO6LndMkBjhfXdOJaqOFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5G6tq1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B60C4CEED;
	Mon, 21 Jul 2025 07:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753082162;
	bh=xGTcX1ux2vw4d85+cDd+19Ti6NSd8WC+Ot3o18ARsLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5G6tq1wOLsVgaI4lvvlgexfwUJeXxK+dOW4rLaPbM5jlG0JhdCp3DCJgwdVcoCpp
	 4mfpLa++YuKbT8OvMAtfi+lVQyaB22qW3B9h6zxjpYQqdt9DYeohDhMcTlY6mROzET
	 XCgQE0/Ccc8pryquGJmZ/ZLlKalwZU0Oe6MLW3RyUFD7BNWN/15kEHJ42Zh/gQENui
	 YihX3w0blVc0lstCPdONOG1XsAqKahmZ4r3x/+qqVj+6SRGa0B3JQ0gpu8CX18jxKc
	 SGeZQDWYMBWxamq7KgdsNTwTcuZlc0RMhKpoIac8bDfJpkJ5FdyhL3JeXKnmMmuGUm
	 N8X6SiCpTm5jA==
Date: Mon, 21 Jul 2025 12:45:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com, 
	bhelgaas@google.com, Stephen Rothwell <sfr@canb.auug.org.au>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Adjust visibility of boot_display attribute
 instead of creation
Message-ID: <tvee57irw3xjdcpvikxu63sryxt3admlbtdwgd634in3woxhob@rvq3njadpmie>
References: <20250720151551.735348-1-superm1@kernel.org>
 <aH0MlOshychrsvg9@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aH0MlOshychrsvg9@wunner.de>

On Sun, Jul 20, 2025 at 05:34:44PM GMT, Lukas Wunner wrote:
> On Sun, Jul 20, 2025 at 10:15:08AM -0500, Mario Limonciello wrote:
> > There is a desire to avoid creating new sysfs files late, so instead
> > of dynamically deciding to create the boot_display attribute, make
> > it static and use sysfs_update_group() to adjust visibility on the
> > applicable devices.
> [...]
> > @@ -1698,7 +1690,7 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
> >  	if (!sysfs_initialized)
> >  		return -EACCES;
> >  
> > -	retval = pci_create_boot_display_file(pdev);
> > +	retval = sysfs_update_group(&pdev->dev.kobj, &pci_display_attr_group);
> >  	if (retval)
> >  		return retval;
> >
> 
> pci_create_sysfs_dev_files() is called from two places, pci_bus_add_device()
> and the late_initcall pci_sysfs_init().
> 

Separate question: Do we really need to call pci_create_sysfs_dev_files() from
pci_sysfs_init()? It is already getting called from pci_bus_add_device() and it
looks redundant to me. More importantly, it can also lead to a race (though
won't happen practically) [1].

Same goes for pci_proc_attach_device(). I was tempted to submit a patch removing
both these calls from pci_sysfs_init() and pci_proc_init(), but wanted to check
first.

[1] https://lore.kernel.org/linux-pci/r7fgb5xrn6ocstq6ctq4q7r4o2esgh4rqr44c3u234kcep6thk@bge2vzl33ptb/

- Mani 

-- 
மணிவண்ணன் சதாசிவம்

