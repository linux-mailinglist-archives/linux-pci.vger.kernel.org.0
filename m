Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5772934BC5D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhC1MoM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 08:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhC1MoA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Mar 2021 08:44:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43AE661584;
        Sun, 28 Mar 2021 12:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616935439;
        bh=UbLXBcavn3YT3P2cE0yfY81eLjUKbQOHiJGeedJ1Swg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNJJx/JGViRlh28SFmeNSd4EsrUKpXjPwFWhzBEdcd08wvWnONl+Tzk6QlfOq4zNy
         tMItYCVRpWabj6J3WqXA7qooR4wjFXcp4ol/BgBRH9MeyaFt4rq7UNyufaJkiJ0Fs0
         iorGhjjqmaw5ZAzKzy6yfzzjd9ovSPxlU4oZD2AY=
Date:   Sun, 28 Mar 2021 14:43:57 +0200
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
Subject: Re: [PATCH v7 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Message-ID: <YGB6DWw+qE+uFnB2@kroah.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 04:06:50AM +0100, Gustavo Pimentel wrote:
> This patch series adds a new driver called xData-pcie for the Synopsys
> DesignWare PCIe prototype.
> 
> The driver configures and enables the Synopsys DesignWare PCIe traffic
> generator IP inside of prototype Endpoint which will generate upstream
> and downstream PCIe traffic. This allows to quickly test the PCIe link
> throughput speed and check is the prototype solution has some limitation
> or not.
> 
> Changes:
>  V2: Rework driver according to Greg Kroah-Hartman' feedback
>  V3: Fixed issues detected while running on 64 bits platforms
>      Rebased patches on top of v5.11-rc1 version
>  V4: Rework driver according to Greg Kroah-Hartman' feedback
>      Add the ABI doc related to the sysfs implemented on this driver
>  V5: Rework driver accordingly to Leon Romanovsky' feedback
>      Rework driver accordingly to Krzysztof Wilczyński' feedback
>  V6: Rework driver according to Greg Kroah-Hartman' feedback
>      Rework driver accordingly to Krzysztof Wilczyński' feedback
>      Rework driver accordingly to Leon Romanovsky' feedback
>  V7: Rework driver according to Greg Kroah-Hartman' feedback

This really doesn't help as I know I don't remember what my feedback
was, so I can't know what to look at to see if it was changed properly
:(

Please be more specific next time.

thanks,

greg k-h
