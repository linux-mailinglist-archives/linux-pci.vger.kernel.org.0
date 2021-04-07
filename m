Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3969C3563D1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 08:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbhDGGRY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 02:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239344AbhDGGRY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 02:17:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E687613C0;
        Wed,  7 Apr 2021 06:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617776234;
        bh=DxKf3kMjq+Nqw4QY7M0vYDTVldSFnbyPF/cTVssl85o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzVafj270QDgJqVnTNhXYQi3TFlC8UQdEVqvfA9ppo70wkumEWVXD/VvT3+y5vVlH
         m9TMwqs5p+BlfMHsxioh0m0zNVMvk5B2KfkspKSLCbxBUXlz5LBe3onWG0r+V8bzff
         CLoz3RrYi6NMxwkIIJz6KneEa8G0XRbvgax7VZRg=
Date:   Wed, 7 Apr 2021 08:17:12 +0200
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
Subject: Re: [PATCH v2 1/2] Documentation: misc-devices: Fix indentation,
 formatting, and update outdated info
Message-ID: <YG1OaKU7slMHfweX@kroah.com>
References: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
 <95bef5f98380bc91b4d321c2638d08da61ef6d6e.1617743702.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95bef5f98380bc91b4d321c2638d08da61ef6d6e.1617743702.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 11:17:48PM +0200, Gustavo Pimentel wrote:
> Fixes indentation issues reported by doing *make htmldocs* as well some
> text formatting.
> 
> Besides these fixes, there was some outdated information related to stop
> file interface in sysfs.

You are not doing this for all "misc-devices", you are doing this only
for one specific driver file.

Please look at the example I provided for how to name this and fix up.

> 
> Fixes: e1181b5bbc3c ("Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver")
> Link: https://lore.kernel.org/linux-next/20210406214615.40cf3493@canb.auug.org.au/
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/misc-devices/dw-xdata-pcie.rst | 62 +++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 19 deletions(-)

What changed from v1?  Always put that below the --- line.

thanks,

greg k-h
