Return-Path: <linux-pci+bounces-39862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BCBC22865
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933C43AC133
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BBB33468F;
	Thu, 30 Oct 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2l+45Fv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371D3101D4;
	Thu, 30 Oct 2025 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862445; cv=none; b=OOns/qWkEL/cXXgnegkpIIJMASjsLNu6ZrO1pMTNELRQIoXhPgzUDeKE/Sa40ZgrZvcR9Nb6BLXGYu+UsfNPYgHtpKtYILY1DWPdZo0BmbUEK/TTYm3UlWwdDFEkrQJdAaw98cJ3K1D4kjCeGPQRE78HHwtyTCvXOyb86iUlqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862445; c=relaxed/simple;
	bh=zYBfnEawIKxh7h1Pgru4AwSGlaZ86c7T3y9TiPo3iOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WscZhW2wfp5crhoJL5lb2V2gKf7Z6RgQoFKff7A4+ZjmfBpDXfcj/fCiQRlvcV3So7cMhVvo+r4gUx+f+5B9UdBL6ov8dn+GM0K+9zIuZhrtYAYi+iWodSFyPS0Ms6guI0rvBg5iJ5r8+ybUH81S4YGdEwZPOtjZIwK2OkEm97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2l+45Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C703C4CEF8;
	Thu, 30 Oct 2025 22:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761862445;
	bh=zYBfnEawIKxh7h1Pgru4AwSGlaZ86c7T3y9TiPo3iOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=b2l+45Fv9Wd6dCv89WSzh8Knzl45x1PCcR5w5ICcK1Tcl6Xels5VtjhBiNlK08dZF
	 er+UpbieoNSkorCxXAi94mqi3t0q7cmc073k0j7XW5QduEXU4TiPHpkF/qbvo7WKNL
	 a8zTw/dQoeF+YUwq8P4FUJz2YHmSPGuiXiA5mNrb9VcAVO0kK8cTqiEIOi3+eG77BE
	 KlvbkFhtLnpPT2P6SDpJdLag/prKSgPbT3jrc85WxNZ9euBqPzWuVSF+tNL+z2F/hr
	 a9x1vH5lirMo1nkOgPLduEisfh88ufAo08zVw3O4TDcpkkajZMrklTzoMEd3RiuBDQ
	 +luCWIsYcaGVA==
Date: Thu, 30 Oct 2025 17:14:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <20251030221404.GA1656495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014184905.GA896847@bhelgaas>

On Tue, Oct 14, 2025 at 01:49:05PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 15, 2025 at 01:30:16AM +0900, FUKAUMI Naoki wrote:
> > Hi Manivannan Sadhasivam,
> > 
> > I've noticed an issue on Radxa ROCK 5A/5B boards, which are based on the
> > Rockchip RK3588(S) SoC.
> > 
> > When running Linux v6.18-rc1 or linux-next since 20250924, the kernel either
> > freezes or fails to probe M.2 Wi-Fi modules. This happens with several
> > different modules I've tested, including the Realtek RTL8852BE, MediaTek
> > MT7921E, and Intel AX210.
> > 
> > I've found that reverting the following commit (i.e., the patch I'm replying
> > to) resolves the problem:
> > commit f3ac2ff14834a0aa056ee3ae0e4b8c641c579961
> 
> Thanks for the report, and sorry for the regression.
> 
> Since this affects several devices from different manufacturers and (I
> assume) different drivers, it seems likely that there's some issue
> with the Rockchip end, since ASPM probably works on these devices in
> other systems.  So we should figure out if there's something wrong
> with the way we configure ASPM, which we could potentially fix, or if
> there's a hardware issue and we need some king of quirk to prevent
> usage of ASPM on the affected platforms.
> 
> Can you collect a complete dmesg log when booting with
> 
>   ignore_loglevel pci=earlydump dyndbg="file drivers/pci/* +p"
> 
> and the output of "sudo lspci -vv"?
> 
> When the kernel freezes, can you give us any information about where,
> e.g., a log or screenshot?
> 
> Do you know if any platforms other than Radxa ROCK 5A/5B have this
> problem?
> 
> #regzbot introduced: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> #regzbot dup-of: https://github.com/chzigotzky/kernels/issues/17

#regzbot report: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com

