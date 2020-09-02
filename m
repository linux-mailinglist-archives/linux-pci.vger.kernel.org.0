Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7525AB21
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBM3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 08:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBM3D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 08:29:03 -0400
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A87F62083B;
        Wed,  2 Sep 2020 12:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599049743;
        bh=/5zITwQgLMel5YXHYupTFIKYxnlLuiBxHFfhEAM0zfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BbTPZSuwNhYPSzyKeYXdR2ks3rMVlCPg6Y1GA8H9h86rRYg1Vih7Csu9U/nxJ/lYC
         TENC8nhd0UiDYOX5RrIeDcOjt57ddMQ+FYTxqkf2fUW99aQdEFMgwbJVe0J9blyW14
         V7HlRBi6yEcXCoiDy/37tUpos8rsamYLRKdgQMyQ=
Date:   Wed, 2 Sep 2020 07:29:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rui_feng@realsil.com.cn" <rui_feng@realsil.com.cn>,
        "vailbhavgupta40@gamail.com" <vailbhavgupta40@gamail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "puranjay12@gmail.com" <puranjay12@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] misc: rtsx: add power saving function and bios guide
 options
Message-ID: <20200902122901.GA241240@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c64d07b5269a4830932d639baec6eab4@realtek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > > From: Ricky Wu <ricky_wu@realtek.com>
> > >
> > > Added rts5227 rts5249 rts5260 rts5228 power saving functions,
> > > added BIOS guide MMC funciton and U_d3_en register support and
> > > fixed rts5260 driving parameter
> > 
> > This should be split into small logical pieces.  I can't really tell
> > what those would be, but just based on the commit message, it could
> > be:
> > 
> >   1) Add rts5227 rts5249 rts5260 rts5228 power saving functions
> > 
> >   2) Add BIOS guide MMC function and U_d3_en register support
> > 
> >   3) Fix rts5260 driving parameter
> > 
> > s/funciton/function/
> > 
> > It looks like 1) *might* be just this:
> > 
> >   rts*_force_power_down()
> >   {
> >     ...
> >     rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, D3_DELINK_MODE_EN,
> > 			    D3_DELINK_MODE_EN);
> > 
> > That should be a single patch by itself so it's obvious that it's
> > doing the same thing to several drivers.
> 
> Ok, I will have a extra patch for all xx_force_power_down()

Great, thanks!

> > Explain what "BIOS guide MMC function" means.  Mention the name of the
> > function this adds so we can connect the patch with the commit log.
> > 
> 
> "BIOS guide MMC function" means, via BIOS setting to know MMC card
> support or not 

It will be helpful if this is in a patch by itself.

As far as I know, there's no actual BIOS *call* here, so you must be
looking at some setting in the *device* itself, on the assumption that
it was done by the BIOS?

That sounds like it could become a problem if the device is ever reset
or put in a low-power state.  For resets, and possibly even a
low-power state, BIOS won't be involved, so the setting will be lost,
and the device may work differently after the reset than it did
before.  That sounds undesirable.

> > Explain what "U_d3_en" is; that doesn't even appear in the patch.
> 
> I am going to remove U_d3_en from patch description, this mean
> D3_DELINK_MODE_EN register 

OK.  Given the size of the patch, I think the commit log is too short
to describe what's going on.  More details would be helpful.

Bjorn
