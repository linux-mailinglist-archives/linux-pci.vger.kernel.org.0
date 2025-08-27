Return-Path: <linux-pci+bounces-34933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486CB38972
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 20:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298CB16DAF0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0892DA779;
	Wed, 27 Aug 2025 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEo+9mT9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB412DA746;
	Wed, 27 Aug 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318980; cv=none; b=mf96Hrkg70796rR7d3EtoFXl/DCJqVYy/j6azCYhaRUHHXqdaaCyg8Yg9vqAanF3X75TEQhnUjNtr+n2Nwd/lxEB1d8v/KkZeMH7lEmP1dO/ZROLaYY1MzDAClHmONjtiWkbd5BoDEHlHIS8BVIvP9JDEtqdyr22o257eNpzixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318980; c=relaxed/simple;
	bh=JNMNAapauZ2G6PcOF8ys1UpdiQSOuyCdsu40nADRsrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RSQDAY5A4k1O77lSy4D1FZewBBdN7TQMZqZKnWjXG8uTV4DscLicDJ2hF2K0ZW8CXfsd5RxsPlsSu4MU9rAWYOgnFee6eRhPIanLf1HNyevg4H9q6uzSDvCf8l+W2qwGQkv1oZlLzroUn2ZjJRti+pSI6ioXUe4bGjWRddRY9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEo+9mT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E224C4CEEB;
	Wed, 27 Aug 2025 18:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756318979;
	bh=JNMNAapauZ2G6PcOF8ys1UpdiQSOuyCdsu40nADRsrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rEo+9mT9Fcinvs06eKzgHgOcvM3ZW0K4Tl1NaRQWtvRghn/0br+gHIkMy84nS/zpK
	 sop74t1VfUuWbhUUUKGSgUa/UlLyZHJif1gk9f6hR6JmQw/6Azqu4YzWP9fY/dNewI
	 aCvG0QUzUFljQnKfo88vfaNHscGFNQYgsWtGb6vJE9ToIt6RcSklIZtoLXHCqfCKZN
	 Y4ZQ0uvRRDl9LF4SoJ+HRvdSHrti0d8HSstL8NVbby10H5nrWPZi6d5Ai/hsOUSXwP
	 t6AEdowRnoBalRJMIiI6EXiqNsHyW2qzX75GEoZhcUf3IT1yhQqTgXwWzDGUE7bgR/
	 iN+1du80/4Uzw==
Date: Wed, 27 Aug 2025 13:22:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Johan Hovold <johan@kernel.org>, stable+noautosel@kernel.org
Subject: Re: [PATCH v3] PCI: qcom: Use pci_host_set_default_pcie_link_state()
 API to enable ASPM for all platforms
Message-ID: <20250827182258.GA891474@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rxdibunhe34gpheegc674cqii4tv6eghh2qskk2uaige5szy3a@nuf6ho2vfbgn>

On Wed, Aug 27, 2025 at 10:43:26PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Aug 27, 2025 at 10:47:39AM GMT, Bjorn Helgaas wrote:
> > On Mon, Aug 25, 2025 at 01:52:57PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms
> > > supporting 1.9.0 ops") allowed the Qcom controller driver to
> > > enable ASPM for all PCI devices enumerated at the time of the
> > > controller driver probe. It proved to be useful for devices
> > > already powered on by the bootloader, as it allowed devices to
> > > enter ASPM without user intervention.
> > > 
> > > However, it could not enable ASPM for the hotplug capable
> > > devices i.e., devices enumerated *after* the controller driver
> > > probe. This limitation mostly went unnoticed as the Qcom PCI
> > > controllers are not hotplug capable and also the bootloader has
> > > been enabling the PCI devices before Linux Kernel boots (mostly
> > > on the Qcom compute platforms which users use on a daily basis).
> > > 
> > > But with the advent of the commit b458ff7e8176 ("PCI/pwrctl:
> > > Ensure that pwrctl drivers are probed before PCI client
> > > drivers"), the pwrctrl driver started to block the PCI device
> > > enumeration until it had been probed.  Though, the intention of
> > > the commit was to avoid race between the pwrctrl driver and PCI
> > > client driver, it also meant that the pwrctrl controlled PCI
> > > devices may get probed after the controller driver and will no
> > > longer have ASPM enabled. So users started noticing high runtime
> > > power consumption with WLAN chipsets on Qcom compute platforms
> > > like Thinkpad X13s, and Thinkpad T14s, etc...
> > > 
> > > Obviously, it is the pwrctrl change that caused regression, but
> > > it ultimately uncovered a flaw in the ASPM enablement logic of
> > > the controller driver. So to address the actual issue, use the
> > > newly introduced pci_host_set_default_pcie_link_state() API,
> > > which allows the controller drivers to set the default ASPM
> > > state for *all* devices. This default state will be honored by
> > > the ASPM driver while enabling ASPM for all the devices.
> > 
> > So I guess this fixes a power consumption regression that became
> > visible with b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers
> > are probed before PCI client drivers").  Arguably we should have a
> > Fixes: tag for that, and maybe even skip the tag for 9f4f3dfad8cf,
> > since if you have 9f4f3dfad8cf but not b458ff7e8176, it doesn't
> > sound like you would need to backport this change?
> 
> 9f4f3dfad8cf is the culprit which added a half baked solution for
> enabling ASPM and b458ff7e8176 made the issue more obvious since
> instead of requiring people to connect a device after boot, it
> allowed the device to enumerate after the probe of the controller
> driver, thereby making it more visible.
> 
> It would make sense to add a Fixes tag for b458ff7e8176 too, but
> 9f4f3dfad8cf should also be present IMO.

OK.  IIUC we would only land on 9f4f3dfad8cf for hot-plugged devices,
and you said these controllers don't support hotplug.  Backporting
something to fix a half-baked solution that doesn't cause an actual
problem is of marginal value, but we can keep the Fixes: 9f4f3dfad8cf.

> > > Also with this change, ASPM is now enabled by default on all
> > > Qcom platforms as I haven't heard of any reported issues (apart
> > > from the unsupported L0s on some platorms, which is still
> > > handled separately).
> > 
> > If ASPM hasn't been enabled by default, how would you hear about
> > issues?  Is ASPM commonly enabled in some other way?
> 
> Mostly from the downstream drivers. They do enable ASPM by default
> and I haven't heard of any issues with that. So I assumed that would
> mean it will be safe for us to enable ASPM for all platforms in
> upstream as well.
> 
> > If you think the risk of ASPM issues is nil, I guess it's OK to do
> > at the same time.  From a maintenance perspective it might be nice
> > to separate that change so if there happened to be a regression,
> > we could identify and revert that part by itself if necessary.  It
> > looks like previously, ASPM was only enabled for one part:
> > 
> >   ops_2_7_0   # cfg_2_7_0 qcom,pcie-sdm845
> 
> No. Previously ASPM was enabled for ops_1_9_0 and ops_1_21_0 based
> platforms.

Oops, my mistake.  Traversing all the ops_ and cfg_ structs was a
little confusing.  For posterity, I guess the corrected matrix is that
ASPM was previously enabled for these:

  ops_1_9_0   # cfg_1_9_0 qcom,pcie-sc7280 qcom,pcie-sc8180x qcom,pcie-sdx55 qcom,pcie-sm8150 qcom,pcie-sm8250 qcom,pcie-sm8350 qcom,pcie-sm8450-pcie0 qcom,pcie-sm8450-pcie1 qcom,pcie-sm8550
	      # cfg_1_34_0 qcom,pcie-sa8775p
  ops_1_21_0  # cfg_sc8280xp qcom,pcie-sa8540p qcom,pcie-sc8280xp qcom,pcie-x1e80100

And will now be enabled for these:

  ops_2_1_0   # cfg_2_1_0 qcom,pcie-apq8064 qcom,pcie-ipq8064 qcom,pcie-ipq8064-v2
  ops_1_0_0   # cfg_1_0_0 qcom,pcie-apq8084
  ops_2_3_2   # cfg_2_3_2 qcom,pcie-msm8996
  ops_2_4_0   # cfg_2_4_0 qcom,pcie-ipq4019 qcom,pcie-qcs404
  ops_2_3_3   # cfg_2_3_3 qcom,pcie-ipq8074
  ops_2_7_0   # cfg_2_7_0 qcom,pcie-sdm845
  ops_2_9_0   # cfg_2_9_0 qcom,pcie-ipq5018 qcom,pcie-ipq6018 qcom,pcie-ipq8074-gen3 qcom,pcie-ipq9574

> If you insist, I can do that by calling
> pci_host_set_default_pcie_link_state() from qcom_pcie_init_2_7_0()
> and later move it to qcom_pcie_host_init() in a separate patch.

I don't insist; that's why I said "if you think the risk of issues
is nil," since I didn't know that you had any experience with ASPM
being enabled on the others.  But it sounds like you do, so I'm ok
with this as-is.

Bjorn

