Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C9A26C98E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIPTMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 15:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgIPRka (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F547206DC;
        Wed, 16 Sep 2020 14:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600266462;
        bh=xf7C1Nf+dJFmvaQcodvUwIxkZ93oC4yDDRg3Ab6MZsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4uFbMhTwi4BHj/2LpLqjR+WYtOsZzNWHmwdfZRh4ar5zF7i8hG5HAXnHypm+y0xD
         TgTeq65DXiA+Oa3yijkvFwSp8K+bmWhPfx56pnAbXX+hI7YNF4T5Xb1cs8gXfXkNWG
         ZXM/f3uqsjK9oHAhPridS5xYLtvrLlGemAjMrRkI=
Date:   Wed, 16 Sep 2020 16:28:16 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "rui_feng@realsil.com.cn" <rui_feng@realsil.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "puranjay12@gmail.com" <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vailbhavgupta40@gmail.com" <vailbhavgupta40@gmail.com>
Subject: Re: [PATCH v5 2/2] misc: rtsx: Add power saving functions and fix
 driving parameter
Message-ID: <20200916142816.GA2979962@kroah.com>
References: <20200916123020.GA2796266@kroah.com>
 <20200916133226.GA1535437@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916133226.GA1535437@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 08:32:26AM -0500, Bjorn Helgaas wrote:
> > So is it ok to take this patch now, or does it need to be changed any?
> 
> Yes, it's OK with me if you take this patch.
> 
> The ASPM hardware feature is designed to work without any driver
> support.  It does need to be configured, which involves both the
> device and the upstream bridge, so it should be done by the BIOS or
> the PCI core.  There are a few drivers (amdgpu, radeon, hfi1, e1000e,
> iwlegacy, ath10k, ath9k, mt76, rtlwifi, rtw88, and these rts
> cardreader drivers) that do it themselves, incorrectly.
> 
> But this particular patch only *reads* the ASPM control registers,
> without writing them, so it shouldn't make anything worse.

Ok, thanks for the review, now queued up.

greg k-h
