Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86CE344E20
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCVSJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 14:09:29 -0400
Received: from foss.arm.com ([217.140.110.172]:36370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhCVSJY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 14:09:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B26A113E;
        Mon, 22 Mar 2021 11:09:23 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 698C93F718;
        Mon, 22 Mar 2021 11:09:22 -0700 (PDT)
Date:   Mon, 22 Mar 2021 18:09:17 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gustavo.pimentel@synopsys.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
Message-ID: <20210322180917.GA15539@e121166-lin.cambridge.arm.com>
References: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
 <161643622212.21337.14859040633786233709.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161643622212.21337.14859040633786233709.b4-ty@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 22, 2021 at 06:03:57PM +0000, Lorenzo Pieralisi wrote:
> On Mon, 25 Jan 2021 12:48:03 +0800, Zhiqiang Hou wrote:
> > In the dw_pcie_ep_init(), it depends on the detected iATU region
> > numbers to allocate the in/outbound window management bit map.
> > It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
> > of iATU windows").
> > 
> > So this patch move the iATU region detection into a new function,
> > move forward the detection to the very beginning of functions
> > dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
> > from the dw_pcie_setup(), since it's more like a software
> > perspective initialization step than hardware setup.
> 
> Applied to pci/dwc, thanks!
> 
> [1/1] PCI: dwc: Move forward the iATU detection process
>       https://git.kernel.org/lpieralisi/pci/c/5ff8ca16f8

Bjorn will queue it for v5.12, so I have dropped it, ignore
this notification.

Thanks,
Lorenzo
