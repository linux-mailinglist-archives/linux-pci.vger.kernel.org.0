Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749BA1F6AA5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFKPNS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgFKPNR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2020 11:13:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41DDC08C5C1;
        Thu, 11 Jun 2020 08:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w3fBHCM88Jt6cDakKyk4xboQWGAsFcwZYcNUwD/n+nU=; b=UtaPwmTzyZIQm0eT7m6SNXoJB4
        VEIPQTkfTTpUfAvEF37o1G0jHd+Y95AGyX9dzVYfoFBWjXPQqXXilnzEKOcByAGTvQgHp9w8nTqO7
        QwU9tb6KWeI0n0NbVqy/Hr16C2/p28CsawrQGVa+KMM+AXybJtvEB9SXqJYZhiyS1WGqT3nPV4lyo
        RDAnri9zQcK1XjCgw6xAnoDbnQWYZQt22FfD98tO6SIoYY6HnWAzOd4zHxUzduoq6ChG6oJO8MfhA
        213c7hJBlrrRX/bXaMqCavMXmm6oVJttLCkFhfB5KeGtlWzbPuwfjdaiV1ZXwcX2PI+n/c44fsTcx
        6dkEYKAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjOt3-0001iB-3j; Thu, 11 Jun 2020 15:13:01 +0000
Date:   Thu, 11 Jun 2020 08:13:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: Re: [PATCH v2 01/14] Documentation: PCI: Add specification for the
 *PCI NTB* function device
Message-ID: <20200611151301.GB8681@bombadil.infradead.org>
References: <20200611130525.22746-1-kishon@ti.com>
 <20200611130525.22746-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611130525.22746-2-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 11, 2020 at 06:35:12PM +0530, Kishon Vijay Abraham I wrote:
> +++ b/Documentation/PCI/endpoint/pci-ntb-function.rst
> @@ -0,0 +1,344 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +PCI NTB Function
> +=================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
> +
> +PCI NTB Function allows two different systems (or hosts) to communicate
> +with each other by configurig the endpoint instances in such a way that
> +transactions from one system is routed to the other system.

At no point in this document do you expand "NTB" into Non-Transparent
Bridge.  The above paragraph probably also needs to say something like "By
making each host appear as a device to the other host".  Although maybe
that's not entirely accurate?  It's been a few years since I last played
with NTBs.

So how about the following opening paragraph:

PCI Non Transparent Bridges (NTB) allow two host systems to communicate
with each other by exposing each host as a device to the other host.
NTBs typically support the ability to generate interrupts on the remote
machine, expose memory ranges as BARs and perform DMA.  They also support
scratchpads which are areas of memory within the NTB that are accessible
from both machines.

... feel free to fix that up if my memory is out of date or corrupted.
