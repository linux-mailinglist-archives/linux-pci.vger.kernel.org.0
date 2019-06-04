Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9159B34750
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 14:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfFDMw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 08:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbfFDMw0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 08:52:26 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 445CF2075C;
        Tue,  4 Jun 2019 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559652745;
        bh=TI//IwvVH2KA10K2fPqSGn4jya7M7Om2ADT6qWSZz60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UX+QyaR1JZL+2rhj/O/mvKmEnURKyjwVwjIesADGaL7D1soH7BrbMcNGEZ0a1Pan7
         molVHJYOjaNNJf2mUaP1xnf5jzhjI05SQmOjBSDNcescJ0l8dZFGB+S9PEKapob+p5
         NwjexAwr6aKk4/OME9Hu1loH3YOeScpWUNnwPsY4=
Date:   Tue, 4 Jun 2019 07:52:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Qualcomm QCS404 PCIe support
Message-ID: <20190604125224.GG189360@google.com>
References: <20190529005710.23950-1-bjorn.andersson@linaro.org>
 <20190529163155.GA24655@redmoon>
 <20190604113347.GA13029@centauri.ideon.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604113347.GA13029@centauri.ideon.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

I pull Lorenzo's branches into my -nexst branch.  I just haven't
gotten to it yet.
