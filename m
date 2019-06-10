Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72C3B3F7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2019 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389659AbfFJLVw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jun 2019 07:21:52 -0400
Received: from foss.arm.com ([217.140.110.172]:40922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388611AbfFJLVw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jun 2019 07:21:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE4AE337;
        Mon, 10 Jun 2019 04:21:51 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 489523F557;
        Mon, 10 Jun 2019 04:23:32 -0700 (PDT)
Date:   Mon, 10 Jun 2019 12:21:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Qualcomm QCS404 PCIe support
Message-ID: <20190610112134.GA30098@redmoon>
References: <20190529005710.23950-1-bjorn.andersson@linaro.org>
 <20190529163155.GA24655@redmoon>
 <20190604113347.GA13029@centauri.ideon.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604113347.GA13029@centauri.ideon.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 04, 2019 at 01:33:47PM +0200, Niklas Cassel wrote:
> On Wed, May 29, 2019 at 05:31:55PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, May 28, 2019 at 05:57:07PM -0700, Bjorn Andersson wrote:
> > > This series adds support for the PCIe controller in the Qualcomm QCS404
> > > platform.
> > > 
> > > Bjorn Andersson (3):
> > >   PCI: qcom: Use clk_bulk API for 2.4.0 controllers
> > >   dt-bindings: PCI: qcom: Add QCS404 to the binding
> > >   PCI: qcom: Add QCS404 PCIe controller support
> > > 
> > >  .../devicetree/bindings/pci/qcom,pcie.txt     |  25 +++-
> > >  drivers/pci/controller/dwc/pcie-qcom.c        | 113 ++++++++----------
> > >  2 files changed, 75 insertions(+), 63 deletions(-)
> > 
> > Applied to pci/qcom for v5.3, thanks.
> > 
> > Lorenzo
> 
> Hello Lorenzo,
> 
> I don't see these patches in linux-next.
> 
> It appears that only Bjorn Helgaas tree is in linux-next, and not yours.
> 
> I think that it makes a lot of sense for patches to cook in linux-next
> for as long a possible.
> 
> Perhaps you and Bjorn Helgaas could have a shared PCI git tree?
> Or perhaps you could add your tree to linux-next?
> ..or some other solution :)

I ask Bjorn to pull branches into linux-next at appropriate times
that fit our schedules, be patient and this code will be in -next
shortly.

Lorenzo
