Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9160523FB4
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfETR5c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 13:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfETR5c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 May 2019 13:57:32 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD278206B6;
        Mon, 20 May 2019 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558375051;
        bh=ffyeII7/nmRLuGHHd0K9nhnUiqgQDgqqy1z0eKBOvyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5o0BcOkg4n6pUD8iLQCFZBCxXxk4bt+VcQsAxSnABUsDz8bRFJlp3uKi8ivj++cG
         USpRioxQgHMiEFvvhoCwIZ8Dg7CKelyHjYARsgbKxU4iMl/ejfFsj8YIAwiA7N8MLU
         eBEAsroj+DCYjUrChLCxOo3iWOMJVat5EBKL8j6g=
Date:   Mon, 20 May 2019 12:57:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
Message-ID: <20190520175729.GC49425@google.com>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
 <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
 <20190516133426.GC101793@google.com>
 <bd08ccaa-c6ee-f966-91e4-bcd5d99d5cf2@nvidia.com>
 <20190517132453.GA30700@google.com>
 <ba611a45-9589-8dce-58e1-d99dd463265d@nvidia.com>
 <20190517185545.GB49425@google.com>
 <bf220eba-f9d7-81f3-6b75-db463c74fbfa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf220eba-f9d7-81f3-6b75-db463c74fbfa@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 18, 2019 at 07:28:29AM +0530, Vidya Sagar wrote:
> On 5/18/2019 12:25 AM, Bjorn Helgaas wrote:
> > On Fri, May 17, 2019 at 11:23:36PM +0530, Vidya Sagar wrote:
> > > On 5/17/2019 6:54 PM, Bjorn Helgaas wrote:
> > > > Do you have "lspci -vvxxx" output for the root ports handy?
> > > > 
> > > > If there's some clue in the standard config space that would tell us
> > > > that MSI works for some events but not others, we could make the PCI
> > > > core pay attention it.  That would be the best solution because it
> > > > wouldn't require Tegra-specific code.
> > > 
> > > Here is the output of 'lspci vvxxx' for one of Tegra194's root ports.
> > 
> > Thanks!
> > 
> > This port advertises both MSI and MSI-X, and neither one is enabled.
> > This particular port doesn't have a slot, so hotplug isn't applicable
> > to it.
> > 
> > But if I understand correctly, if MSI or MSI-X were enabled and the
> > port had a slot, the port would generate MSI/MSI-X hotplug interrupts.
> > But PME and AER events would still cause INTx interrupts (even with
> > MSI or MSI-X enabled).
> > 
> > Do I have that right?  I just want to make sure that the reason for
> > PME being INTx is a permanent hardware choice and that it's not
> > related to MSI and MSI-X currently being disabled.
>
> Yes. Thats right. Its hardware choice that our hardware engineers made to
> use INTx for PME instead of MSI irrespective of MSI/MSI-X enabled/disabled
> in the root port.

Here are more spec references that seem applicable:

  - PCIe r4.0, sec 7.7.1.2 (Message Control Register for MSI) says:

      MSI Enable – If Set and the MSI-X Enable bit in the MSI-X
      Message Control register (see Section 7.9.2) is Clear, the
      Function is permitted to use MSI to request service and is
      prohibited from using INTx interrupts.

  - PCIe r4.0, sec 7.7.2.2 (Message Control Register for MSI-X) says:

      MSI-X Enable – If Set and the MSI Enable bit in the MSI Message
      Control register (see Section 6.8.1.3) is Clear, the Function is
      permitted to use MSI-X to request service and is prohibited from
      using INTx interrupts (if implemented).

I read that to mean a device is prohibited from using MSI/MSI-X for
some interrupts and INTx for others.  Since Tegra194 cannot use
MSI/MSI-X for PME, it should use INTx for *all* interrupts.  That
makes the MSI/MSI-X Capabilities superfluous, and they should be
omitted.

If we set pdev->no_msi for Tegra194, we'll avoid MSI/MSI-X completely,
so we'll assume *all* interrupts including hotplug will be INTx.  Will
that work?
