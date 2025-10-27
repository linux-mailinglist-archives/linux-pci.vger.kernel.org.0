Return-Path: <linux-pci+bounces-39475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C37C11CCB
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378F41A65C27
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DB93451BE;
	Mon, 27 Oct 2025 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwXtzCLu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E773451A9;
	Mon, 27 Oct 2025 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604519; cv=none; b=K/dJkhxrhyZ7pgnTGpmg9Up3OHEZ2LO65lhaXp3A2p2USUWUZFBTILwnWJk4WDeyuzfZF37lRdZhRdVe7rQaCAhC3VGmnls5mGcc5hN/gYBe+6FhWckUcLq/pL4OpQ/bhBKy33sTm4AQPYvDGNGta9ohDFqyNObe7OFsjAEv2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604519; c=relaxed/simple;
	bh=5VghR/NlRdD4hFwfZJEs1wHDzZ2/GT/7qljl5uZwHlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aUNiwTVpYblh5cgzJHDwcBny5SckT4/E/PFY+dLdVbP5Sg9qDVhIGwe7k4Eq51qOrhYCk44QI9ZzoD+vi4ozRSMVBbWQtXz/9vKJxw6QyEK9+AgvWmZBBWKKGw2MJYaf5qlNbWwAg4yfOkFlezdtlorqeyHZXk48w12qcIb7fGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwXtzCLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A020C4CEFB;
	Mon, 27 Oct 2025 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761604519;
	bh=5VghR/NlRdD4hFwfZJEs1wHDzZ2/GT/7qljl5uZwHlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HwXtzCLuhgRMR0TNFUUEstGhaKhQvTxspAltPuTlnb4ivZjGChz/zsPuXmXYtlOaJ
	 5kepQbbF6t6VThTxCeqngQJgTEA6fVx5U2lgzUzX9D6zhnV3pEgnF+A+xMeKaMVTve
	 pUIeCC1GYi0M5A3TDn0fzEzXFPa8pw/6T9cGa3l8BNpX7O5i56ATXcjTkQK+zk+kj8
	 zFm1FFCRdMBRabo2IFyKMFsVhpv0stP2xOeEH7ixkhHbPzmYGLL1Vb1uc7r1EEGPHH
	 4b5tJDGc2Vj13slMxKk+yaJ5eQ+R79azmxhOwxr/Fp9m+xFdMwrhF805mWADzMV1Nj
	 MHN4ISH/ygtAQ==
Date: Mon, 27 Oct 2025 17:35:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Frank Li <Frank.li@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Han Jingoo <jingoohan1@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Revert "PCI: qcom: Remove custom ASPM enablement code"
Message-ID: <20251027223517.GA1484052@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP9Ed1Y1lcayFn7Q@hovoldconsulting.com>

On Mon, Oct 27, 2025 at 11:07:51AM +0100, Johan Hovold wrote:
> On Sun, Oct 26, 2025 at 02:37:54PM -0500, Bjorn Helgaas wrote:
> > On Sun, Oct 26, 2025 at 08:58:29PM +0530, Manivannan Sadhasivam wrote:
> 
> > As far as I know, it's L1SS that has catastrophic effects.  I haven't
> > seen anything for L0s or L1.
> 
> Enabling L0s unconditionally certainly blew up on some Qualcomm
> machines. See commit d1997c987814 ("PCI: qcom: Disable ASPM L0s for
> sc8280xp, sa8540p and sa8295p").

Ah, right, thanks for that reminder.

IIUC the qcom_pcie_clear_aspm_l0s() quirk that removes L0s from the
advertised Link Capabilities is still there and prevents df5192d9bb0e
("PCI/ASPM: Enable only L0s and L1 for devicetree platforms") from
being a problem on those platforms, right?

