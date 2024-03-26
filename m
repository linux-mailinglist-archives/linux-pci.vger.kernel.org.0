Return-Path: <linux-pci+bounces-5210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC87788D2C9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 00:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DC61F3D469
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 23:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B4D13DDC6;
	Tue, 26 Mar 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfbA6nji"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC2A13DDB5;
	Tue, 26 Mar 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711495446; cv=none; b=KR5dLoI6wyvGiJek6Kprls3gz9VtQOJxJ39t9Pw2wnW3BakenL0tn7YX7jJgV5qQQtduTj4GOm2FXM35eclB0IDzEkjUW1EVoCrC4BwjR7mNjmy9ja/9md2608xPQoRisoQWHVv4rUU2UCkbq07hqRyIX7ke28Fi1frGBQ5aXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711495446; c=relaxed/simple;
	bh=GfgyZrV79xoa84Cgd+HTjsbRJ75ZS8ByhFEX2qPLfk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hWDtJkpQ0VFwhhUA+5aYDrIj21v5bSOQHLgA4X22mUhO8/I0N5SXM0p80TH8323JQ0k9WviuRLDFSz01nQarX0QfNlF7ucYTdEpALf80Lf2G6ABHfIk80SbRdJHD4/IK5CmNlD4Hva6vPBjsfYDAUA1iAuIdn/1+yHol3ndyL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfbA6nji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC29C433F1;
	Tue, 26 Mar 2024 23:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711495445;
	bh=GfgyZrV79xoa84Cgd+HTjsbRJ75ZS8ByhFEX2qPLfk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XfbA6njiMzYq8iAN1Mgu+0B23d79KPXLQzGCVdXjI1PveafCTUxoAUOTJhtSAP9Sn
	 uEQpq755ssawAlDuwSCwvAFE88XmZ2d3ZPOaYMrmi+6fu36PMFSPMVvI5sbcSDJW+w
	 dWt5pBPwG1DzwPTX+/USomfTjSqJ3SGYID74cxHNBNXndrDq+qZWPehPCby/dXjrgl
	 /Kjf3BOdZRZyKNZHVqOPzEip9SFSNzFh69L3eqOjg61Hg3w0RQZCcBfyeSD0dh02aZ
	 hsY2k3iw7K1xwysm+CWP/jN1xWnxV5peX6uIqWddYeqm3dJrChQJNoqL8ZYSBwHNMd
	 z1gKpfRp/xBfA==
Date: Tue, 26 Mar 2024 18:24:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com, u.kleine-koenig@pengutronix.de,
	cassel@kernel.org, dlemoal@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH v6] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <20240326232403.GA1502764@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326144258.2404433-1-s-vadapalli@ti.com>

On Tue, Mar 26, 2024 at 08:12:58PM +0530, Siddharth Vadapalli wrote:
> In the process of converting .scan_bus() callbacks to .add_bus(), the
> ks_pcie_v3_65_scan_bus() function was changed to ks_pcie_v3_65_add_bus().
> The .scan_bus() method belonged to ks_pcie_host_ops which was specific
> to controller version 3.65a, while the .add_bus() method had been added
> to ks_pcie_ops which is shared between the controller versions 3.65a and
> 4.90a. Neither the older ks_pcie_v3_65_scan_bus() method, nor the newer
> ks_pcie_v3_65_add_bus() method is applicable to the controller version
> 4.90a which is present in AM654x SoCs.
> 
> Thus, as a fix, move the contents of "ks_pcie_v3_65_add_bus()" to the
> .msi_init callback "ks_pcie_msi_host_init()" which is specific to the
> 3.65a controller. Also, move the definitions of ks_pcie_set_dbi_mode()
> and ks_pcie_clear_dbi_mode() above ks_pcie_msi_host_init() in order to
> avoid forward declaration.

If it's possible to split this into two patches (one that strictly
*moves* the code without otherwise changing it, and another that makes
the actual fix), it would be easier to review the fix.  It's a pain to
have to compare the code in the old location with that in the new
location.

Bjorn

