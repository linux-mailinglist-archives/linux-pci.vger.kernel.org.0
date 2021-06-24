Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AFB3B2A48
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 10:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhFXIZg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 04:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231826AbhFXIZg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 04:25:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BBF0613E8;
        Thu, 24 Jun 2021 08:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624522997;
        bh=6+8DC4IpeSttLdmm9MiRqdcSoNk3uI+zKuzqUGGQ0tI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PR8eWWcZxoaaR3PHZ+0yx3IkvkyHx21mNtuv5xgJeJmyJs1W6r+CbjgA+yHVKMkJL
         IWcK4EfdmE/lIZi3VujgYuhGPySCBnosd2qQI+fYUfVdERvbY9tIbkozvfgIs0K+mH
         NeknLrIKOm8FSkTEwJCOyJaRWzxUGIZWcQUhpnh/0R87DkzXQ6A83jGnlQ3CY2qapc
         6Y524qcucOMYihsEQ3UmMrIIZVWLU2OS2drXflYz1gIiWN5Cdc1/Jr3YltLXaNFlL+
         06A4yN2o82WCKI4p3tJU3nxEQ/cmtFBI9mG+HZopzmHC4TmIbRTBYnGYF335qDu6+I
         4PQuN+yfZaSlw==
Received: by pali.im (Postfix)
        id E3C5780E; Thu, 24 Jun 2021 10:23:14 +0200 (CEST)
Date:   Thu, 24 Jun 2021 10:23:14 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     xxm <xxm@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        kernel test robot <lkp@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v9 2/2] PCI: rockchip: Add Rockchip RK356X host
 controller driver
Message-ID: <20210624082314.mw3ilcufswmb635m@pali>
References: <20210506023448.169146-1-xxm@rock-chips.com>
 <20210506023544.169196-1-xxm@rock-chips.com>
 <20210623143333.GA15104@lpieralisi>
 <46b3f277-2bde-321d-b616-3f3b41259e4d@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46b3f277-2bde-321d-b616-3f3b41259e4d@rock-chips.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 June 2021 10:08:54 xxm wrote:
> 在 2021/6/23 22:33, Lorenzo Pieralisi 写道:
> > On Thu, May 06, 2021 at 10:35:44AM +0800, Simon Xue wrote:
> > > +static int rockchip_pcie_start_link(struct dw_pcie *pci)
> > > +{
> > > +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > > +
> > > +	/* Reset device */
> > > +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> > > +
> > > +	rockchip_pcie_enable_ltssm(rockchip);
> > > +
> > > +	/*
> > > +	 * PCIe requires the refclk to be stable for 100µs prior to releasing
> > > +	 * PERST. See table 2-4 in section 2.6.2 AC Specifications of the PCI
> > > +	 * Express Card Electromechanical Specification, 1.1. However, we don't
> > > +	 * know if the refclk is coming from RC's PHY or external OSC. If it's
> > > +	 * from RC, so enabling LTSSM is the just right place to release #PERST.
> > > +	 * We need more extra time as before, rather than setting just
> > > +	 * 100us as we don't know how long should the device need to reset.
> > > +	 */
> > > +	msleep(100);
> > Any rationale behind the time chosen ?
> We found some device need about 30ms, so 100ms here just leave more room for
> other devices.

Can you share information which PCIe card needs 30ms?

Last year I did tests with more WiFi AC cards and "the slowest" one was
Compex WLE1216 which needed about 11ms (more than 10ms). All other cards
were happy with just 1-2ms.
