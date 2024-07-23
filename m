Return-Path: <linux-pci+bounces-10677-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4560B93A969
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EE31F22290
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729401422AB;
	Tue, 23 Jul 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtydTuZn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38233148FFC;
	Tue, 23 Jul 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774465; cv=none; b=SAyFVHHgaQ7PCM7K9AKRGnFfgNRwyGB/S6pb4D0A1xCeHHU3mbT4gePNRCZbZTg+cbXFPj7L1Lg4xk7fsWXL4GAKeEjnkbE7rDHEdxV+b4bu+3eObQHD2m/SZWqY5ZOvQ1rdZl0V0YtoTbpKAq0CmjgROO2BNIvegE7vQqPI2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774465; c=relaxed/simple;
	bh=22uv/eISLRooyvNECmkIOgFtK1XmcboDRKg1HrLS4iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gooqk+tJx/uCNjKk31xYUt8ounbvTm1R28+uAX6VxMLt14yq9glrl1EQuiwmuuIGOvl/abBMDoKmLD35ARHiMZizuPfX+Cq3llVx3FfIq7RzOwUrQcE1OK1dqzQtToPPmzuv2DqXYtq0oklMWZensSq0luLCIdmoKvhCMBt+ldE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtydTuZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F029C4AF09;
	Tue, 23 Jul 2024 22:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721774464;
	bh=22uv/eISLRooyvNECmkIOgFtK1XmcboDRKg1HrLS4iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jtydTuZn9uoFshl3k4DJx0HH//v1HSHNIB/lIvCgO3vAVVNjlcNNm+kvFfmWrtIT6
	 CSw9S+boEDL44WtRQCrxO1g4cNRJr9n+sIih3XWC6nq0NrtytYvr0nIMY9y+3ZFn7N
	 aJAflLh9o1Q4iZX0MsiR8aEyb9CdfK8Tt7XsObfs7v5Dua6pdOpb6TIz5I17e13V/y
	 1IW+IpiddCzVDLtrU10zgpDbjbYPM7qg+MYohd1tNNIqzRs5GowrtrOYZ5Z+1MeXE9
	 Jff31408d+MINA76D8l3Ehwd9t6xL9+3HISbP/+GuWn0vN1dfW2CpauPVhFiSfZkhM
	 jgPhztZQOHKLw==
Date: Tue, 23 Jul 2024 17:41:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 03/10] PCI/TPH: Add pci=notph to prevent use of TPH
Message-ID: <20240723224102.GA779599@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-4-wei.huang2@amd.com>

On Wed, Jul 17, 2024 at 03:55:04PM -0500, Wei Huang wrote:
> TLP headers with incorrect steering tags (e.g. caused by buggy driver)
> can potentially cause issues when the system hardware consumes the tags.

Hmm.  What kind of issues?  Crash?  Data corruption?  Poor
performance?

> Provide a kernel option, with related helper functions, to completely
> prevent TPH from being enabled.

Also would be nice to have a hint about the difference between "notph"
and "nostmode".  Maybe that goes in the "nostmode" patch?  I'm not
super clear on all the differences here.

> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4655,6 +4655,7 @@
>  		nomio		[S390] Do not use MIO instructions.
>  		norid		[S390] ignore the RID field and force use of
>  				one PCI domain per PCI function
> +		notph		[PCIE] Do not use PCIe TPH

Expand acronym here since there's no helpful context.  Can also
include "(TPH)" if that's useful.

> @@ -322,8 +323,12 @@ static long local_pci_probe(void *_ddi)
>  	pm_runtime_get_sync(dev);
>  	pci_dev->driver = pci_drv;
>  	rc = pci_drv->probe(pci_dev, ddi->id);
> -	if (!rc)
> +	if (!rc) {
> +		if (pci_tph_disabled())
> +			pcie_tph_disable(pci_dev);

I'm not really a fan of cluttering probe() like this.  Can't we
disable it in pcie_tph_init() so all devices start off with TPH
disabled, and then check pci_tph_disabled() in whatever interface
drivers use to enable TPH?

> +bool pci_tph_disabled(void)
> +{
> +	return pcie_tph_disabled;
> +}
> +EXPORT_SYMBOL_GPL(pci_tph_disabled);

Other related interfaces use "pcie" prefix; I think this should match.

Do drivers need this?  Would be nice not to export it unless they do.

Bjorn

