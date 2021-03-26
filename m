Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776F934ABDD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 16:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCZPvi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 11:51:38 -0400
Received: from foss.arm.com ([217.140.110.172]:35712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhCZPvX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 11:51:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01D321474;
        Fri, 26 Mar 2021 08:51:23 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34E243F792;
        Fri, 26 Mar 2021 08:51:22 -0700 (PDT)
Date:   Fri, 26 Mar 2021 15:51:12 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] PCI: mediatek: Configure FC and FTS for functions
 other than 0
Message-ID: <20210326155104.GA8190@e121166-lin.cambridge.arm.com>
References: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
 <YDK0fr/UiKjit+ty@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YDK0fr/UiKjit+ty@rocinante>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 21, 2021 at 08:29:02PM +0100, Krzysztof Wilczyński wrote:
> [+cc Lorenzo for visiblity]
> 
> Hi,
> 
> Thank you for taking care of this!
> 
> [...]
> > PCI_FUNC(port->slot << 3)" is always 0, so previously
> > mtk_pcie_startup_port() only configured FC credits and FTs for
> > function 0.
> [...]
> 
> A small nit.  The commit message is missing the opening quote, see
> Bjorn's suggestion:
> 
>   https://lore.kernel.org/linux-pci/20201104131054.GA307984@bjorn-Precision-5520/
> 
> But, it's probably not worth sending another patch, and perhaps either
> Bjorn or Lorenzo could fix this when applying changes.
> 
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Thanks, I will do. Can I apply it or there are still pending review
comments to address ?

Lorenzo
