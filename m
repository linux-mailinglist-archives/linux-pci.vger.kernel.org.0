Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C304DDC2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 01:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfFTXZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 19:25:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:53477 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfFTXZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 19:25:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5KNOnmN006299;
        Thu, 20 Jun 2019 18:24:53 -0500
Message-ID: <59c6111e9567d8f03c4b03caeb1020df51b0fb4c.camel@kernel.crashing.org>
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 3/4]
 PCI: Fix bug resulting in double hpmemsize being assigned to MMIO window]
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date:   Fri, 21 Jun 2019 09:24:48 +1000
In-Reply-To: <20190620134346.GH143205@google.com>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
         <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
         <20190620134346.GH143205@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-06-20 at 08:43 -0500, Bjorn Helgaas wrote:
> This is as it should be.  Non-prefetchable windows are 32 bits, and
> in general non-prefetchable BARs must be placed there.
> 
> There is some wiggle room in pure PCIe systems because PCIe reads
> always contain an explicit length, so in some cases it is safe to
> put a non-prefetchable BAR in a prefetchable window (see the
> implementation note in sec 7.5.1.2.1).  But I don't think Linux
> currently implements this.

We don't, we probably should, but seeing our current allocation code, I
dread of the end result ...

We would need a host bridge flag to indicate it's safe (no byte merging
at the PHB). I know most host bridge implementations don't
differenciate prefetchable from non-prefetchable outbound windows so
should be fine, and the other side effects are generally attributes of
the mapping done in the MMU and thus depend on the device BAR
attribute, not the bridge windows in the way.

I'm not 100% sure how/if x86 throws a wrench into this with MTRRs
(could a BIOS setup one of these things to cover a bridge/switch
prefetchable window ? That would be a bad idea but bad ideas is what
BIOS vendors often come up with).

Cheers,
Ben.


