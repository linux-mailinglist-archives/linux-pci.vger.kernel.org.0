Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF2C318723
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBKJbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:31:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhBKJ3A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Feb 2021 04:29:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2636864DDA;
        Thu, 11 Feb 2021 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613035692;
        bh=4zp7hrTl2WIK1ymf7+bLpA+MnEUH1vlcijdjumyfaoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1EoBfCloRlea8lIaBlP5LatOjvHTqFjTGqgmtb7FieTwQ/oviQ41j4MkWeX2WKgk
         +zSjWvjjANcVFi9Pqt9aiNLtU7FdonceEPRZu3V/ScY/OwIHUusG40qhGQ5zU8nMFk
         1bqKt45nciccwuCKc80Nw+9PhLA1o2trygks1fAk=
Date:   Thu, 11 Feb 2021 10:28:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 2/6] misc: Add Synopsys DesignWare xData IP driver to
 Makefile
Message-ID: <YCT4qS673nWKJVeA@kroah.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <04060811848603958d9d3c1f2b577169c9021ce4.1613034397.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04060811848603958d9d3c1f2b577169c9021ce4.1613034397.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 10:08:39AM +0100, Gustavo Pimentel wrote:
> Add Synopsys DesignWare xData IP driver to Makefile.
> 
> This driver enables/disables the PCIe traffic generator module
> pertain to the Synopsys DesignWare prototype.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/Makefile | 1 +
>  1 file changed, 1 insertion(+)

I said patch 2 and 3 should be merged into 1 before, right?  Why ignore
that suggestion?  Otherwise build errors/issues will get attributed to
the wrong commit...

greg k-h
