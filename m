Return-Path: <linux-pci+bounces-4734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1A878A40
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 22:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EFBE1C2118E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 21:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFBB57323;
	Mon, 11 Mar 2024 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eome4s09"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041057315;
	Mon, 11 Mar 2024 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194080; cv=none; b=G8p1Ocv66i7eHkkYs5+7N4MJ2kZAW9g7j82s0dhVlbhmxKyWQVVWvJcV4xoLmqmhUslJrqjssp+YFlbYQg4zgkV0Qp+EzbqJPZ7r3xBbHY2J/FOJ6fpK2owClAypTXMG/ghsoofL1Y943qChWU23u1y3iJRbsDrwGzK0fg57gQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194080; c=relaxed/simple;
	bh=RWD53XQN8UsgouYUBF/rTClQBGz527mrHnHW07+LEvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT/Ols7KRl1QUjpP3IxUjd+K8KwB8BEvoNQJoLttUKWFGVf880ZVfjSqfM6iB1cHF1CdjvDgDthQ8KfRZaAornNLZnHwT9ZLQDQawEhjUHEaqbn+q2aHKlHM+a6Ne/JntKSj4rwTcAk9p1g4ICxvNM8ZWlsBLEdJUh62GbzBFHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eome4s09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4BBC433C7;
	Mon, 11 Mar 2024 21:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710194079;
	bh=RWD53XQN8UsgouYUBF/rTClQBGz527mrHnHW07+LEvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eome4s09U0yv2YUiX7PkctOicSMRH/yZOh6gnNHwqz8AI3Od+MdGJEeamS0f7e/Rg
	 EKv3GFwpTGiOOLiVWTZpMtwJHx1nzexz6euFNxlYZWJ+mz5wMTgZY+s7k5ZCuLXjlU
	 Q+epQAXw6XXRuSGu4tO+RzCdoobL9znOdQ45I3dz+B6EpKd4zxdEjk7P6Oh4eNWsAc
	 Lp4NPa4szCmQyVI2rLifPe+RyPkuYYJ5VxV5Y+UMqeicTFacCyxISQMAHTlc0bDHNG
	 GFLAPM9kqVH055Ixhp4hp6Z+B+3XyEurelGgsFQYR8csLnIKr6fF0qQTyfN2WKjaGL
	 QI56/3wgaZNXA==
Date: Mon, 11 Mar 2024 22:54:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v9 07/10] PCI: dwc: ep: Remove "core_init_notifier" flag
Message-ID: <Ze99lLhe2GqIqMgl@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-7-29d433d99cda@linaro.org>
 <ZesRk5Dg4KEASD3U@ryzen>
 <20240311144559.GA2504@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311144559.GA2504@thinkpad>

On Mon, Mar 11, 2024 at 08:15:59PM +0530, Manivannan Sadhasivam wrote:
> > 
> > I would say that it is the following change that breaks things:
> > 
> > > -	if (!core_init_notifier) {
> > > -		ret = pci_epf_test_core_init(epf);
> > > -		if (ret)
> > > -			return ret;
> > > -	}
> > > -
> > 
> > Since without this code, pci_epf_test_core_init() will no longer be called,
> > as there is currently no one that calls epf->core_init() for a EPF driver
> > after it has been bound. (For drivers that call dw_pcie_ep_init_notify() in
> > .probe())
> > 
> 
> Thanks a lot for testing, Niklas!
> 
> > I guess one way to solve this would be for the EPC core to keep track of
> > the current EPC "core state" (up/down). If the core is "up" at EPF .bind()
> > time, notify the EPF driver directly after .bind()?
> > 
> 
> Yeah, that's a good solution. But I think it would be better if the EPC caches
> all events if the EPF drivers are not available and dispatch them once the bind
> happens for each EPF driver. Even though INIT_COMPLETE is the only event that is
> getting generated before bind() now, IMO it is better to add provision to catch
> other events also.
> 
> Wdyt?

I'm not sure.
What if the EPF goes up/down/up, it seems a bit silly to send all those
events to the EPF driver that will alloc+free+alloc.

Do we know for sure that we will want to store + replay events other than
INIT_COMPLETE?

And how many events should we store?


Until we can think of a good reason which events other than UP/DOWN we
can to store, I think that just storing the state as an integer in
struct pci_epc seems simpler.


Or I guess we could continue with a flag in struct pci_epc_features,
like has_perst_notifier, which would then require the EPC driver to
call both epc_notify_core_up() and epc_notify_core_down() when receiving
the PERST deassert/assert.
For a driver without the flag set, the EPC core would call
.epc_notify_core_up() after bind. (And .epc_notify_core_down() would never
be called, or it could call it before unbind().)
That way an EPF driver itself would not need any different handling
(all callbacks would always come, either triggered by an EPC driver that
has PERST GPIO irq, or triggered by the EPC core for a driver that lacks
a PERST GPIO).


Kind regards,
Niklas

