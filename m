Return-Path: <linux-pci+bounces-39490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF1CC12E75
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 06:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330CA188EFD4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 05:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26A189906;
	Tue, 28 Oct 2025 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNkf5Fro"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F852433BC;
	Tue, 28 Oct 2025 05:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627718; cv=none; b=h7R9evd8ZCiea1L8VYvJBxbaqi2n5X1iTr7OigpmtsvqBZo5VOOD/e+m1mh/O887qSSEwD6CpbenHSCNY6M7Rvo9r3hy7SabgskHj/OqjFFxzmfpxOhlafqPmqBNfgWqjTXwTwSAzoEAu2MMhLs1K3oHOTazxfXVHdxqbFfu5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627718; c=relaxed/simple;
	bh=xK+kOBtYAu7vr9m5Az5VjqJevz0PMXjM8dbbnRJ0x8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbao+XUQHpNrkxLszJeKCqUqalQZbyxKo4zD5cEDaYAv++aO+DI7sp5lrtijdnZaAyk3daC4xQ0wvt6JWA6qZZXhX2VENgXE6+gDD+AhIOSHBbAGqbk/0tHoNoJ3mpv34NiT3GfXMxJQBP2KM7YDxedCynAez/ouL5mbw6xyIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNkf5Fro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1D3C4CEE7;
	Tue, 28 Oct 2025 05:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761627718;
	bh=xK+kOBtYAu7vr9m5Az5VjqJevz0PMXjM8dbbnRJ0x8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNkf5FroBtcLgMWY5vahyh+zj/PzpfdiUIzPxY88VmzHJR5O2Cm1iIhfvIKvyZDrr
	 DsogUXYnzwdxZFmGmFlSMuRLvFIWFE+gB5+4+vJeMSgDccI2JBJYVEjpv7ZDdKqUBW
	 25Yd3Zi2icYXqbQvfHZSEIWdiIeHQmzQp4i0/2OZxpBVDep3lKOHLjCEk/VeAkRNKl
	 tQqJH69b3TJ473aBsPqigR27mCx6l2S6agNS8c+02hVgRUl8XnhUGjAnzlZGccW4bn
	 f69E/rl9TYivGwwRoChM7Y0/Qf0HlupnmvR0gYiB5VQUKuQlRN5t/MZAIiZhzEykP2
	 h+gQqSmIOnGtg==
Date: Tue, 28 Oct 2025 10:31:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-pci@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Frank Li <Frank.li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Rob Herring <robh@kernel.org>, "David E . Box" <david.e.box@linux.intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Chia-Lin Kao <acelan.kao@canonical.com>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Han Jingoo <jingoohan1@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Revert "PCI: qcom: Remove custom ASPM enablement code"
Message-ID: <gvafqo6oabquhxmzdeaf5i3wetvhflvegj5esa5mog2lgyoiwi@qfdklajr2w4v>
References: <aP9Ed1Y1lcayFn7Q@hovoldconsulting.com>
 <20251027223517.GA1484052@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027223517.GA1484052@bhelgaas>

On Mon, Oct 27, 2025 at 05:35:17PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 27, 2025 at 11:07:51AM +0100, Johan Hovold wrote:
> > On Sun, Oct 26, 2025 at 02:37:54PM -0500, Bjorn Helgaas wrote:
> > > On Sun, Oct 26, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:
> > 
> > > As far as I know, it's L1SS that has catastrophic effects.  I haven't
> > > seen anything for L0s or L1.
> > 
> > Enabling L0s unconditionally certainly blew up on some Qualcomm
> > machines. See commit d1997c987814 ("PCI: qcom: Disable ASPM L0s for
> > sc8280xp, sa8540p and sa8295p").
> 
> Ah, right, thanks for that reminder.
> 
> IIUC the qcom_pcie_clear_aspm_l0s() quirk that removes L0s from the
> advertised Link Capabilities is still there and prevents df5192d9bb0e
> ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms") from
> being a problem on those platforms, right?

Yes. Since the capability itself is disabled, df5192d9bb0e doesn't affect our
platforms.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

