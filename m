Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D890F4D446
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 18:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFTQxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 12:53:00 -0400
Received: from foss.arm.com ([217.140.110.172]:48988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfFTQxA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 12:53:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C132B;
        Thu, 20 Jun 2019 09:52:59 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1EEF3F246;
        Thu, 20 Jun 2019 09:52:57 -0700 (PDT)
Date:   Thu, 20 Jun 2019 17:52:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, bhelgaas@google.com,
        Jisheng.Zhang@synaptics.com, thierry.reding@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 1/2] PCI: dwc: Add API support to de-initialize host
Message-ID: <20190620165255.GC18771@e121166-lin.cambridge.arm.com>
References: <dec5ecb2-863e-a1db-10c9-2d91f860a2c6@nvidia.com>
 <37697830-5a94-0f8e-a5cf-3347bc4850cb@nvidia.com>
 <b560f3c3-b69e-d9b5-2dae-1ede52af0ea6@nvidia.com>
 <011b52b6-9fcd-8930-1313-6b546226c7b9@nvidia.com>
 <8a6696e0-fc53-2e6b-536b-d1d2668e0f21@nvidia.com>
 <07c3dd04-cfd0-2d52-5917-25d0e40ad00b@nvidia.com>
 <20190618093657.GA30711@e121166-lin.cambridge.arm.com>
 <eb0e5b1e-7e91-4dc6-681f-b497f087c62d@nvidia.com>
 <20190618142821.GC9002@e121166-lin.cambridge.arm.com>
 <69e79afa-16c7-a00c-653d-e4155999660f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e79afa-16c7-a00c-653d-e4155999660f@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 10:41:26AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 18/06/19 7:58 PM, Lorenzo Pieralisi wrote:
> > On Tue, Jun 18, 2019 at 04:21:17PM +0530, Vidya Sagar wrote:
> > 
> > [...]
> > 
> >>> 2) It is not related to this patch but I fail to see the reasoning
> >>>     behind the __ in __dw_pci_read_dbi(), there is no no-underscore
> >>>     equivalent so its definition is somewhat questionable, maybe
> >>>     we should clean-it up (for dbi2 alike).
> >> Separate no-underscore versions are present in pcie-designware.h for
> >> each width (i.e. l/w/b) as inline and are calling __ versions passing
> >> size as argument.
> > 
> > I understand - the __ prologue was added in b50b2db266d8 maybe
> > Kishon can help us understand the __ rationale.
> > 
> > I am happy to merge it as is, I was just curious about the
> > __ annotation (not related to this patch).
> 
> In commit b50b2db266d8a8c303e8d88590 ("PCI: dwc: all: Modify dbi accessors to
> take dbi_base as argument"), dbi accessors was modified to take dbi_base as
> argument (since we wanted to write to dbics2 address space). We didn't want to
> change all the drivers invoking dbi accessors to pass the dbi_base. So we added
> "__" variant to take dbi_base as argument and the drivers continued to invoke
> existing dbi accessors which in-turn invoked "__" version with dbi_base as
> argument.
> 
> I agree there could be some cleanup since in commit
> a509d7d9af5ebf86ffbefa98e49761d ("PCI: dwc: all: Modify dbi accessors to access
> data of 4/2/1 bytes"), we modified __dw_pcie_readl_dbi() to
> __dw_pcie_write_dbi() when it could have been directly modified to
> dw_pcie_write_dbi().

Thanks. Vidya can do it as a preliminary patch, I will merge then
code to export the symbols.

Lorenzo
