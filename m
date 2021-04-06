Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F300355B28
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbhDFSSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 14:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235539AbhDFSSb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 14:18:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 854BB613B8;
        Tue,  6 Apr 2021 18:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617733103;
        bh=c2G4rDYRbYPtcYobdDZ+O/zbe5/Gl8tdD2GW2tRKoLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VMoNwIonxr/5wnvt4ku7M3MIX94eMtOmrUSrBM9T4tfrMkjBvMnYK8oWnq20Spxgx
         AIU8lLs2zfg6mWJA2DPmbHsuT10N1V2BlW7jipWLVNKgHQKEFk2Rkr2McPNNIS6pPC
         lgUJjBVl64DyJkeUdsn+MtSgJHr+fdoMGOMsS3X8=
Date:   Tue, 6 Apr 2021 20:18:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation: misc-devices: Fix indentation,
 formatting, and update outdated info
Message-ID: <YGyl7OWHJm1NuaV2@kroah.com>
References: <689d1827d98b2f7a51175ff1efd3a92d8191b28d.1617732412.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689d1827d98b2f7a51175ff1efd3a92d8191b28d.1617732412.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 08:06:52PM +0200, Gustavo Pimentel wrote:
> Fixes indentation issues reported by doing *make htmldocs* as well some
> text formatting.
> 
> Besides these fixes, there was some outdated information related to stop
> file interface in sysfs.

Your subject line is odd, it should look something like:
	[PATCH] dw-xdata-pcie: fix up documentation issues

> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

You do not have a "Reported-by:" line?

Please fix.

thanks,

greg k-h
