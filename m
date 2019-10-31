Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A37EB0C1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJaNBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 09:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaNBe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 09:01:34 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5301A2080F;
        Thu, 31 Oct 2019 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572526892;
        bh=ZqQmIL+VZ3QRd14dH7SG/ODYbXnGFyGCVOWZyG3KxSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hlInG3xtoBSQHfifz9LHNoOEdY9N8dlqgVblZ/QP0IlO7bwjXFGCVa9icKRitjoso
         PzMKiJFjxRiaVg/P8AAm72mD7oaWA38vJ/M/hParD24E3dYe3FwmvgYptU/BJ5Vt+f
         QlAjWdEH8WPyq0t5hmqDqYZckNeFzT5h1sU9yyEc=
Date:   Thu, 31 Oct 2019 08:01:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        martin.blumenstingl@googlemail.com,
        Linux PCI <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Linux PM <linux-pm@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Message-ID: <20191031130130.GA37287@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5652130.irlrSN52DS@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 31, 2019 at 10:13:11AM +0100, Rafael J. Wysocki wrote:
> On Thursday, October 31, 2019 3:56:37 AM CET Bjorn Helgaas wrote:
> > On Thu, Oct 31, 2019 at 12:31:44AM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Oct 30, 2019 at 11:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> > > > Rafael had some concerns about the proposed ASPM interface [2], but I
> > > > don't know what they are yet.
> > > 
> > > I was talking about the existing ASPM interface in sysfs.  The new one
> > > I still have to review, but I'm kind of wondering what about people
> > > who used the old one?  Would it be supported going forward?
> > 
> > The old one interface was enabled by CONFIG_PCIEASPM_DEBUG.  Red Hat
> > doesn't enable that.  Ubuntu does.  I *thought* we heard from a
> > Canonical person who said they didn't have any tools that used it, but
> > I can't find that now.  I don't know about SUSE.
> > 
> > So the idea was to drop it on the theory that nobody is using it.
> > Possibly that's too aggressive.
> 
> Well, one problem is that the "old" (actually existing) I/F has made it
> to one of my OSS EU presentation slides (I did not talk to this particular
> slide, but it is there in the deck that's available for downloading), so who
> knows who is going to use it. :-)
> 
> So I guess that there's a risk that needs to be taken into consideration.
> 
> What could be done, in principle, would be to make the new I/F depend on
> CONFIG_PCIEASPM_DEBUG being unset and provide the "old" one when it is set.

I would prefer to enable the new interface unconditionally to make it
easier for userspace tools like powertop to use it.

I think the existing and new interfaces could coexist, with the
existing interface being enabled by CONFIG_PCIEASPM_DEBUG as it is
today.  The patch that removes the existing interface is the last in
the series and could easily be dropped.

> In any case, the pcie_aspm.policy module parameter cannot be dropped, because
> AFAICS there is quite a bit of user space using it (e.g. TLP).

What is TLP?  Since CONFIG_PCIEASPM is a bool, aspm.o is built in
statically if enabled, so pcie_aspm.policy is effectively a boot-time
kernel parameter, right?  We don't have a plan to remove it.

Bjorn
