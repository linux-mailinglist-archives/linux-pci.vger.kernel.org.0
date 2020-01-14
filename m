Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA713B29F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 20:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgANTGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 14:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbgANTGd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jan 2020 14:06:33 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D155222C4;
        Tue, 14 Jan 2020 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579028792;
        bh=13IflzZpLaLZL3xSAJ55gLJNP3cz/M84IOILAKmmi3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MdqPl2BtwochWuO4zhXzMSR9NriX5vjiUQ9ksONrtaGxiE7OJBIvPr6jJTRTrwoeQ
         XZ6ZrwBNwe3GhL3xBXSwvD/ZyKN5TpbSJ149DQ/rViQTXOP3Q7OckpyV9jttjoqw3d
         hsotX5gyKDa+UY8mNgBAzg3+XRrhXboukTJsbF6o=
Date:   Tue, 14 Jan 2020 13:06:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5] PCI: Fix disabling of bridge BARs when assigning bus
 resources
Message-ID: <20200114190630.GA262043@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f15334a9-6cac-803d-7e64-28c74c4d12af@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 11:07:12AM -0700, Logan Gunthorpe wrote:
> On 2020-01-13 1:07 p.m., Bjorn Helgaas wrote:
> > Applied to pci/resource for v5.6, thanks!
> > 
> > I added a check of pci_is_bridge() as another hint that this is really
> > a bridge-specific issue.  Let me know if that breaks anything.
> > 
> > commit 9db8dc6d0785 ("PCI: Don't disable bridge BARs when assigning bus resources")
> > Author: Logan Gunthorpe <logang@deltatee.com>
> > Date:   Wed Jan 8 14:32:08 2020 -0700
> 
> Thanks! I was going to test the pci/resource branch, but I haven't seen
> the patch in your repo yet... Current head is
> 
> 86f98025a075 ("PCI: Allow extend_bridge_window() to shrink resource if
> necessary")

Pushed.  I'm anticipating some tweaks to Nicholas' patches on that
branch, so I put yours at the base.
