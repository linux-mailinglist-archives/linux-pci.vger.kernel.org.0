Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6309B2D7BAF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 17:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbgLKQzh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 11:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390711AbgLKQzW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 11:55:22 -0500
Date:   Fri, 11 Dec 2020 10:54:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607705681;
        bh=qGbi0KCwfARwG62mclTn4fkyQ7GIU9YNOHL1UyRxz9E=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=tQVNrCiXBSnc1tpGQsMSV3gFYFrnbKOScEReL7bZ24hc6ES4892YIRsAsbFxVa+8Z
         tIoBRExganwnfZWMuYHEVSAwEMcGseDwSwVK/y59jwt+vOGS7C0ZoNxrd08Jtc5AX7
         Q9HCsa8n3vocaCMycso25w07Fer69n3ETjEgewkkY8hU1+oZG31Mx596qymQFoICRZ
         vZNcVdELUb4PQ7cD+Wdr7SdNerR9Tq0PQ5cz1+nOpIGdv8/azugB+11kfW9eYvW3Vb
         Ivj/b40Z+kYHc/dWoK4fee1xO9mw/FO/jpyxTnQ05TU2ExN2nYJrdHObwBRMb2wFw2
         r/QNIGNlAHuvw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Add support to configure for ECRC
Message-ID: <20201211165440.GA80431@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK7EtRhGhd20P2raj1C4GLOoBQ55ngY+BvygRE-61E+9A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 11, 2020 at 08:49:16AM -0600, Rob Herring wrote:
> On Fri, Dec 11, 2020 at 7:58 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> >
> > Hi Lorenzo,
> > Apologies to bug you, but wondering if you have any further comments on
> > this patch that I need to take care of?
> 
> You can check the status of your patches in Patchwork:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20201111121145.7015-1-vidyas@nvidia.com/
> 
> If it's in 'New' state and delegated to Lorenzo or Bjorn, it's in
> their queue. You can shorten the queue by reviewing stuff in front of
> you. :)

Thanks for pointing this out, this is exactly right.  I *love* it when
people help review things.  Obviously it saves me time, and often it
raises questions I would have missed.

Even "trivial" things like spelling, grammar, whitespace, subject line
formats, etc. help because they are distractions to me and I will
comment on them or spend time fixing them myself.  That doesn't mean
"repost immediately after somebody points out a typo"; it means
"collect feedback for a week or so, fix everything, *then* repost."

This is an old but still relevant list of some of my OCD tendencies
that take no special expertise to review for:
https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
