Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5925F665
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgIGJYu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 05:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgIGJYt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 05:24:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6CB2078E;
        Mon,  7 Sep 2020 09:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599470688;
        bh=MF3X8v5mIVSH9DjNRPkf+bnMwllLl549DAVJziB2y3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYQhFQProeTUxz41B/fAN+u00aIzNiBOvvfGQdrtIhyKndVNP0j8lNqQWz/bSkCia
         GtIMLvLp0bq9K95zQVxT4ijHJcw3u9JzE9nF8uvQT63XarslFfXw7CtMU11pQt/eJQ
         h3o3ef5AOr/VEm9nGEGTJduqzROMWdMAGLI0pT34=
Date:   Mon, 7 Sep 2020 11:25:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, bhelgaas@google.com, ulf.hansson@linaro.org,
        rui_feng@realsil.com.cn, linux-kernel@vger.kernel.org,
        puranjay12@gmail.com, linux-pci@vger.kernel.org,
        vailbhavgupta40@gmail.com
Subject: Re: [PATCH v4 1/2] misc: rtsx: Fix power down flow
Message-ID: <20200907092503.GA1393659@kroah.com>
References: <20200904094220.27533-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904094220.27533-1-ricky_wu@realtek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 04, 2020 at 05:42:19PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> Fix and sort out rtsx driver power down flow
> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rts5227.c  | 15 ---------------
>  drivers/misc/cardreader/rts5228.c  |  5 ++---
>  drivers/misc/cardreader/rts5249.c  | 17 -----------------
>  drivers/misc/cardreader/rts5260.c  | 16 ----------------
>  drivers/misc/cardreader/rtsx_pcr.c | 16 ++++++++++++++++
>  5 files changed, 18 insertions(+), 51 deletions(-)

What changed from the previous versions?  That always needs to go below
the --- line.

Please fix up and resend a v5.

thanks,

greg k-h
