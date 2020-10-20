Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB48A293877
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 11:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404009AbgJTJsq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 05:48:46 -0400
Received: from foss.arm.com ([217.140.110.172]:48786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404045AbgJTJsq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 05:48:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 231BF101E;
        Tue, 20 Oct 2020 02:48:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDB713F66E;
        Tue, 20 Oct 2020 02:48:44 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:48:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Michael Walle <michael@walle.cc>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of
 dw_child_pcie_ops
Message-ID: <20201020094839.GA21935@e121166-lin.cambridge.arm.com>
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com>
 <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 09:27:40AM -0600, Rob Herring wrote:

[...]

> > > Maybe a link down just never happens once up, but if so, then we only need
> > > to check it once and fail probe.
> >
> > Many customers connect the FPGA Endpoint, which may establish PCIe link
> > after the PCIe enumeration and then rescan the PCIe bus, so I think it should
> > not exit the probe of root port even if there is not link up during enumeration.
> 
> That's a good reason. I want to unify the behavior here as it varies
> per platform currently and wasn't sure which way to go.

We don't need to fail probe - just skip enumeration. Is there an IRQ
event associated with link coming up ? Scanning the bus can be done
upon link-up IRQ.

For platforms that forward the link down as an SError this still does
not solve the problem (if the link goes down unexpectedly) but I
question their design in the first place, this patch does not fix their
behaviour regardless.

Lorenzo
