Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85234BC64
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 14:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhC1Mtw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 08:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhC1Mti (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Mar 2021 08:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F10796193F;
        Sun, 28 Mar 2021 12:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616935778;
        bh=OSnQHbxEtIhRfgD/63lkkJmsoikDTiPOynuNQM0vM8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rn1kQsV3dCLnshSTNRzqOJepm8XiaDyYsyi02xbYMJUOLXwpVzl/pHU2he71JNlFs
         7HZ/23f41/+SjMXWGSkOOYuul1HMrvXnuEtOeiGW3xLWRZrRRDQSgc46F6fpSKjTBk
         r+ALFd7HrDQsxhdI0AVcRX7cz0nHivepvb+fsuw8=
Date:   Sun, 28 Mar 2021 14:49:36 +0200
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
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v7 2/5] misc: Add Synopsys DesignWare xData IP driver to
 Makefile and Kconfig
Message-ID: <YGB7YARat0dOrz7K@kroah.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
 <3912988f09d71b76d80f8184e73821f76808fd2f.1616814273.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3912988f09d71b76d80f8184e73821f76808fd2f.1616814273.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 04:06:52AM +0100, Gustavo Pimentel wrote:
> Add Synopsys DesignWare xData IP driver to Makefile and Kconfig.
> 
> This driver enables/disables the PCIe traffic generator module
> pertain to the Synopsys DesignWare prototype.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/Kconfig  | 10 ++++++++++
>  drivers/misc/Makefile |  1 +
>  2 files changed, 11 insertions(+)

This should be part of the patch that adds the driver so that you can
properly bisect things to when problems really happen.

thnaks,

greg k-h
