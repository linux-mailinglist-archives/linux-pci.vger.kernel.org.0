Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBF3354178
	for <lists+linux-pci@lfdr.de>; Mon,  5 Apr 2021 13:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhDELQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Apr 2021 07:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhDELQk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Apr 2021 07:16:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09EF9613AD;
        Mon,  5 Apr 2021 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617621394;
        bh=ZgX5FuV/d1B88HMRXIpFcIpEF91kBI/1grIvpM3ISU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKCjUSF2qmT3zjArYOV07BK0ubsSA+Garp1PiqqswEfpSwcNPrJ8ezbHPgFY/09hP
         5EZCoLV6XwhMFDGpte12URD+aICjSxvbTJPAnmA2X7gIxqeLRfPRe/2/j3tGQwkF1c
         0dZsOZJamg5yiCjchaboGSy15gmzbcWuzarex9pA=
Date:   Mon, 5 Apr 2021 13:16:32 +0200
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
Subject: Re: [PATCH v10 0/4] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YGrxkJCxb683PP2O@kroah.com>
References: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 01:17:44PM +0200, Gustavo Pimentel wrote:
> This patch series adds a new driver called xData-pcie for the Synopsys
> DesignWare PCIe prototype.
> 
> The driver configures and enables the Synopsys DesignWare PCIe traffic
> generator IP inside of prototype Endpoint which will generate upstream
> and downstream PCIe traffic. This allows to quickly test the PCIe link
> throughput speed and check is the prototype solution has some limitation
> or not.

Looks good, all now queued up.

greg k-h
