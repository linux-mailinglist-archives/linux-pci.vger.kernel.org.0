Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C024629C078
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 18:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1817974AbgJ0RQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 13:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1817219AbgJ0ROr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 13:14:47 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EAD920657;
        Tue, 27 Oct 2020 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603818887;
        bh=sXVHnKGNfJmka3AKJsAEnCIAg9yWEv5oSthTVHBwoAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GVjme1F+GqdaD1MbKtfFamLZZYO4rNNhDD9YRBoLgHkh6ERoJ9CKUMg1lAs4Y/Vwr
         wjOdBhoRSdpxkuWofIOHBNfdyHwY1wv03UUCA/YPr5+4MFfZIhmj1ZpEogMOojcs1D
         M3HxZiIweRd+cwcbSc2d4DjQkK+SGH8Htw43hStU=
Date:   Tue, 27 Oct 2020 12:14:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: pci-exynos.c coverity issue #1437287
Message-ID: <20201027171445.GA186716@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027164042.GA123158@kozik-lap>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 05:40:42PM +0100, Krzysztof Kozlowski wrote:
> On Tue, Oct 27, 2020 at 11:34:46AM -0500, Bjorn Helgaas wrote:
> > Hi Jingoo,
> > 
> > Please take a look at this issue reported by Coverity:
> > 
> > 222 static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
> > 223 {
> > 224        struct dw_pcie *pci = ep->pci;
> > 225        struct device *dev = pci->dev;
> > 226
> >    	1. Condition ep->reset_gpio >= 0, taking true branch.
> > 227        if (ep->reset_gpio >= 0)
> > 
> > CID 1437287 (#1 of 1): Unchecked return value (CHECKED_RETURN) 2.
> > check_return: Calling devm_gpio_request_one without checking return
> > value (as is done elsewhere 112 out of 113 times).
> > 
> > 228                devm_gpio_request_one(dev, ep->reset_gpio,
> > 229                                GPIOF_OUT_INIT_HIGH, "RESET");
> > 
> > 
> > Maybe you can guarantee that it's safe to ignore the return value by
> > doing a lot of code analysis, but I think it would be better to check
> > like all the other callers do.
> 
> +Cc Marek,
> 
> Hi Bjorn,
> 
> I think this is being removed by Marek's patchset:
> https://lore.kernel.org/linux-samsung-soc/20201023075744.26200-1-m.szyprowski@samsung.com/

Perfect, thanks!
