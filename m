Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9775A2313C3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgG1UVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgG1UVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:21:31 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A2B2065E;
        Tue, 28 Jul 2020 20:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595967691;
        bh=Mv9Q/ZxNjpKppfW+jS2TBifRUUf8oS+v6oZyhx/+6LU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=v48l7RS/PvnEqagkVZ7R25MIsJ0qq5yf+RxM501ykxo3+zrPDlxrxpC870Ci4qccA
         S/zHu7qi67xUUakwnKofQB3lOlASr1OIHqOo2haAKIHp1yW/PfH+xdAVdRj7RNkueb
         KbJ8gDf+XMLeSUj54/MvD8e/H85uedec0rTBSsXA=
Date:   Tue, 28 Jul 2020 15:21:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_lost_interrupt still needed?
Message-ID: <20200728202126.GA1859314@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5eba931-6e27-8f50-d018-7d51a983bfb8@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 09:20:34PM +0200, Heiner Kallweit wrote:
> Seems that pci_lost_interrupt() has no user. Do we still need this function?
> Same applies for related enum pci_lost_interrupt_reason.

If there's no user, remove it.  Bonus points if you look up the
removal of the last use.
