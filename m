Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8362C70B1C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2019 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbfGVVPs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jul 2019 17:15:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729697AbfGVVPq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jul 2019 17:15:46 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1822221955;
        Mon, 22 Jul 2019 21:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563830145;
        bh=AIZzoT5ZYNcjgOzxp5tAPR6+/rNuqLReT3uMdcYoavY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRJji6EcKDZ3rNaenkThR3bEKTYeoPbgWZ5Em5QbX6S3sLNUNEmwShKrkD3Iz3et3
         fsrBVi68W2MImveoLTFgx5nNRgtbWMIZ1mkJwIql8NEci4tBOmN/WV7j/Dk+txETd1
         yDQ84WnlNQ4e7tkMX4/PwhqFjwh4AxDCeiZyQqhA=
Date:   Mon, 22 Jul 2019 16:15:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Chocron, Jonathan" <jonnyc@amazon.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Gustavo.Pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 6/8] PCI: al: Add support for DW based driver type
Message-ID: <20190722211542.GB203187@google.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
 <20190718094718.25083-2-jonnyc@amazon.com>
 <DM6PR12MB4010913E5408349A600762CADACB0@DM6PR12MB4010.namprd12.prod.outlook.com>
 <d323007c6bf14cb9f90a497a26b66dac151164fc.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d323007c6bf14cb9f90a497a26b66dac151164fc.camel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 21, 2019 at 03:08:18PM +0000, Chocron, Jonathan wrote:
> On Fri, 2019-07-19 at 08:55 +0000, Gustavo Pimentel wrote:
> > On Thu, Jul 18, 2019 at 10:47:16, Jonathan Chocron <jonnyc@amazon.com> wrote:

> > > +static int al_pcie_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct al_pcie *al_pcie;
> > > +	struct dw_pcie *pci;
> > > +	struct resource *dbi_res;
> > > +	struct resource *controller_res;
> > > +	struct resource *ecam_res;
> > > +	int ret;
> > 
> > Please sort the variables following the reverse tree order.
> > 
> Done. 
> 
> I'd think that it would make sense to group variables which have a
> common characteristic (e.g. resources read from the DT), even if it
> mildly breaks the convention (as long as the general frame is longest
> to shortest). Does this sound ok?
> 
> BTW, I couldn't find any documentation regarding the reverse-tree
> convention, do you have a pointer to some?

What I personally do is sort declarations in the order they're used.
