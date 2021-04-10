Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E4135AC14
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 11:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbhDJJBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 05:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhDJJBO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 10 Apr 2021 05:01:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 828CF610CF;
        Sat, 10 Apr 2021 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618045260;
        bh=7mmCaNKlQoq2SsPWz8tNNebBdY4KFROg02VwRgfwieg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNtxcV50PeEkecrUWLS/c3t6KHXOhn/P4vkDEtP/9TvuCb7DBhZV4WW7ZyQ96/8OM
         QhvFA+irUPGq9ZOrmlD7jwS/2meufGVr+JQlZ+Y6V0CyveQUnF+lBY/mQUS9fUsG5A
         ZzUaeHP9n/KGqLh/aLhIXgYm6kMPZUaV+n50sCJg=
Date:   Sat, 10 Apr 2021 11:00:57 +0200
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
Subject: Re: [PATCH v3 1/2] dw-xdata-pcie: Fix documentation build warns and
 update outdated info
Message-ID: <YHFpSQOSYEWRuDoX@kroah.com>
References: <cover.1617827290.git.gustavo.pimentel@synopsys.com>
 <5e1bc55d098322908ebdf1c32512acad5b65d4d7.1617827290.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1bc55d098322908ebdf1c32512acad5b65d4d7.1617827290.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 10:31:48PM +0200, Gustavo Pimentel wrote:
> Fixes documentation build warnings related to indentation and text
> formatting, such as:
> 
> Documentation/misc-devices/dw-xdata-pcie.rst:20: WARNING: Unexpected
> indentation.
> Documentation/misc-devices/dw-xdata-pcie.rst:24: WARNING: Unexpected
> indentation.
> Documentation/misc-devices/dw-xdata-pcie.rst:25: WARNING: Block quote
> ends without a blank line; unexpected unindent.
> Documentation/misc-devices/dw-xdata-pcie.rst:30: WARNING: Unexpected
> indentation.
> Documentation/misc-devices/dw-xdata-pcie.rst:34: WARNING: Unexpected
> indentation.
> Documentation/misc-devices/dw-xdata-pcie.rst:35: WARNING: Block quote
> ends without a blank line; unexpected unindent.
> Documentation/misc-devices/dw-xdata-pcie.rst:40: WARNING: Unexpected
> indentation.

In the future, there's no need to wrap error/warning lines like this in
a changelog text.  Not a big deal, but the above is messy to read,
right?

> 
> Also fixes some outdated information related to stop file interface in sysfs.

When you say "also", that means you need a separate patch usually.  And
for this patch, that is exactly what you need.  Please split this up
into one patch that fixes the reported problem, and another one that
adds the needed information.

thanks,

greg k-h
