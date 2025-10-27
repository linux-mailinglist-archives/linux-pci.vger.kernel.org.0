Return-Path: <linux-pci+bounces-39411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9684AC0CDB6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE71A4F1D07
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F392F7AC2;
	Mon, 27 Oct 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjOEetGk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0DD2F7ADE;
	Mon, 27 Oct 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559246; cv=none; b=O+C41z7bjsi8zqioPlkFaDUECq9KoG2hRJKzVEcS91g78g0EBKYDCATyiJy6h7L1KktDUdatZRD5HEtblBj1kW4IbK6EmO3vVmiCMuO+7fGqQok6XKQdBxYJdb19N80ezSavyw4ZDcpUNQjISnzr4g2yiVNkFB4wrAykxbhRIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559246; c=relaxed/simple;
	bh=g9zJBVbnGEA4HG5ooeAzLqX41v1JBzQYQqje6z0ZFx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnT7/SHm92dB9WFNqCUgQkfYQEOzvJHY3ezH6Mvrx8z751VQkF6s8sJMtoKL0Uy/nlQ8DcRFS980bRdTeR9a9Xw/PW+KH4DqDNEYtpu1kB7zJIcDgqb/myhJRcY3prBnu5s8p5h0nwvoLEi2czTuLccbI6ZfRnDlllPmGyYOZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjOEetGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630C5C4CEF1;
	Mon, 27 Oct 2025 10:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559246;
	bh=g9zJBVbnGEA4HG5ooeAzLqX41v1JBzQYQqje6z0ZFx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjOEetGk9z+CDj6SBDLC3q333GF293fQKVJYDxwd4mFRcpbAl5zochz9FDKgGXH41
	 C5NRL9OOCswq2yBRA6VHx3wscWweZ5DCaKaPIH+HHx/G4CaumZAeuXnNr02lCnLaNt
	 0u3Q6m6HIXhBzojPGbamjXnF6syyixBeTP2ELdZIXKF57uNaQ4j+zkFqL2yE/ntjp9
	 YuDgQWShi2tiOWYKMe9d7vS/L8nUsx7hVtEztKXt23ww/a9+ruGWrVBgoz+xQ8oMH/
	 0bpfLGMt0Aw25SodjvjPRL/V98oy3OoGYxOsN+ts241fDcOxW4UNcSoWjMtbFF1lEx
	 Ykf+RTgh70YQQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDK1w-000000006Yg-38Bu;
	Mon, 27 Oct 2025 11:00:49 +0100
Date: Mon, 27 Oct 2025 11:00:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Dragan Simic <dsimic@manjaro.org>, linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Frank Li <Frank.li@nxp.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <aP9C0H_2XVk6MiLV@hovoldconsulting.com>
References: <aPuZQRaTN2tAwkb5@hovoldconsulting.com>
 <20251024203924.GA1361677@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024203924.GA1361677@bhelgaas>

On Fri, Oct 24, 2025 at 03:39:24PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 24, 2025 at 05:20:33PM +0200, Johan Hovold wrote:
> > On Fri, Oct 24, 2025 at 05:12:38PM +0200, Johan Hovold wrote:

> > > Note that this will regress ASPM on Qualcomm platforms further by
> > > disabling L1SS for devices that do not use pwrctrl (e.g. NVMe). ASPM
> > > with pwrctrl is already broken since 6.15. [1]
> > 
> > Actually, the 6.15 regression was fixed in 6.18-rc1 by the offending
> > commit, but pwrctrl devices will now also regress again.
> > 
> > > Reverting also a729c1664619 ("PCI: qcom: Remove custom ASPM enablement
> > > code") should avoid the new regression until a proper fix for the 6.15
> > > regression is in place.
> 
> Help me think through this.  I just sent a pull request [2] that
> includes df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for
> devicetree platforms").  If all goes well, v6.18-rc3 will enable L0s
> and L1 (but not L1SS) on Qualcomm platforms.
> 
> IIUC, if we then revert a729c1664619 ("PCI: qcom: Remove custom ASPM
> enablement code"), it will enable L1SS again, but since this is done
> in a dw_pcie_host_ops .post_init() hook, L1SS will only be enabled for
> devices powered on at qcom-pcie probe time.  It will *not* be enabled
> for pwrctrl devices because .post_init() was run when those devices
> were powered off.

Correct.

> I think this is the same as in v6.17.  v6.18-rc1 enabled L1SS for
> everything, including pwrctrl devices, because it was done in the PCI
> enumeration path, not the host controller probe path.  I think that
> enumeration is the right place to do this, but we need to figure out
> how to do it in a generic way.  At a minimum, we need to know that
> CLKREQ# is supported, and some platforms like dw-rockchip also need
> device-specific configuration [3].
> 
> Bottom line, I think we need to revert a729c1664619 for v6.18 to get
> all ASPM states including L1SS enabled on Qualcomm platforms for
> non-pwrctrl devices.  I'll post a patch for this.

Right, that would at least restore the 6.17 state of things with respect
to Qualcomm machines.
 
> Then try to figure out how to make this work for pwrctrl devices for
> v6.19.  Does this sound right?

Yes, unless you can come up with a simple way to enable L1SS during
enumeration on Qualcomm platforms, for example, using a driver callback
that returns true for platforms using the 1.9.0 ops to indicate that
L1SS is supported. That should address also the 6.15 pwrctrl regression.

Johan

