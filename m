Return-Path: <linux-pci+bounces-13604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E3988A0D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 20:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1441C229CF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80612174EFA;
	Fri, 27 Sep 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrJ9iO9Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670A524B0;
	Fri, 27 Sep 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461362; cv=none; b=CwBHv7wIOBQA96R/1jUWaozvk97n5ZU4plxzMCns/Zi6KK1YZ0sJB2mEM66JaWtzjyL+W/6hkbPNEcfPR9czNc979FUyuBkx1mbYrkrV21s1Hd0wBGoenzDOElC2ARfL0h0T3tPA5BdatSRMnV9sn/TI3wbkgYvsoojDU+hB0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461362; c=relaxed/simple;
	bh=Aj6QsXN9+wurRdEhLLOgrIKRi1TKrZH9iLUL4lOE1aI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=S4zUANZOmwyQgMrMZnhZJvcbuZGYzyvucGjdLiHE2B3AGgvlSW8xLWleZMmgN4sLWTUUOQ9BJTpTVayD723FCWsGoKlzW2wAgYPymxdbPvJJJn9BXW9wD4TtQqQrv3UtUc0z82VEHd64RzUHhwveFJZgU+n2+HcJ7gqd5WRmZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrJ9iO9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8520AC4CEC4;
	Fri, 27 Sep 2024 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727461360;
	bh=Aj6QsXN9+wurRdEhLLOgrIKRi1TKrZH9iLUL4lOE1aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HrJ9iO9Y/DzVq8thg17WFcf91NweE6AOMVZnFbBW6wetlh8Dzbd9hwP61HNIEw7qx
	 Sw+FwQQ+5GuwF5ZyKG6x6LYW+HRsm9H8+TvvynPjlDLbb+Con37B2qfukao8pNaVKg
	 aMhjTDC7cWr07Vr6bhNfgFo/LHSAoAgxfQpdbCejz0NJplLsM8hXHSyJoTwCZNIjRo
	 KdXgeciJAPYNeaEE+CwCSyEUGQgyePSXJTqJC34wGJOnsfGgkkWO16f/Zv+J3LByVK
	 Zsy+GXUswnLxIZ878CbvnmLfxy6BHDZDc0BrbGQu0wgZHTZdIvBVU/3PojaWCftmL8
	 IOZQINqOzH48g==
Date: Fri, 27 Sep 2024 13:22:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <20240927182238.GA85539@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANAwSgSgwx0kuV-boF14_WXiPkE8KXxOWOfS2e_QOWMKgKSLnA@mail.gmail.com>

On Fri, Sep 27, 2024 at 01:47:44PM +0530, Anand Moon wrote:
> On Mon, 2 Sept 2024 at 00:03, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Refactor the clock handling in the Rockchip PCIe driver,
> > introducing a more robust and efficient method for enabling and
> > disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
> > the clock handling for the core clocks becomes much simpler.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> 
> Do you have any review comments on this series?

Looks like nice work, thanks.  Minor tips below.  We'll start applying
PCI patches to v6.13-rc1 after it is tagged.  It looks like these will
apply cleanly, so no rebasing needed.

  - It would be helpful if you can add a cover letter (0/n), which is
    a good place for the overall diffstat and series-level changelog.

  - This v5 series adds drivers/phy patches, which are also related to
    rockchip, but will be handled by a different maintainer, so best
    to send them as separate series (and of course send the phy
    patches to the right maintainer, linux-phy, etc).

  - "b4 am -o/tmp/ 20240901183221.240361-2-linux.amoon@gmail.com"
    complains about something, I dunno how to fix:

      Checking attestation on all messages, may take a moment...
      ---
	✗ [PATCH v5 1/6] PCI: rockchip: Simplify clock handling by using clk_bulk*() function
	✗ [PATCH v5 2/6] PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function
	✗ [PATCH v5 3/6] PCI: rockchip: Refactor rockchip_pcie_disable_clocks function signature
	✗ [PATCH v5 4/6] phy: rockchip-pcie: Simplify error handling with dev_err_probe()
	✗ [PATCH v5 5/6] phy: rockchip-pcie: Change to use devm_clk_get_enabled() helper
	✗ [PATCH v5 6/6] phy: rockchip-pcie: Use regmap_read_poll_timeout for PCIe reference clk PLL status
	---
	✗ BADSIG: DKIM/gmail.com

  - In 3/6 and 6/6 commit logs, add parens after function names as
    you did elsewhere.

  - Super nit: In 5/6, s/Change to use/Use/.  Every patch is a change,
    so "Change to" doesn't add any information.

Bjorn

