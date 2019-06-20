Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460654CF38
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfFTNnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 09:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFTNnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 09:43:49 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C620206E0;
        Thu, 20 Jun 2019 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561038228;
        bh=Qw5LLT/u0To2Gq4gQ4lqwg1AplHYn4Ot3u+F9Dhdnfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLaKQlwuyjgiqBwE3u11UvQGK9UPGv5KLCQG34pk7OoTuBv1dlZ1KEnrhoKi43Mzx
         8mVT8GL9c/whTCD3Agan7hWEqhzLh0ihYEAwT331d8rqEBOyXjDdCK/whSn4SKts7q
         h/y0dKMfEBhLR9F2fNUJ5NlkO5Bi7EnJAAWNrNVw=
Date:   Thu, 20 Jun 2019 08:43:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 3/4] PCI:
 Fix bug resulting in double hpmemsize being assigned to MMIO window]
Message-ID: <20190620134346.GH143205@google.com>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 12:44:11AM +0000, Nicholas Johnson wrote:

> Correct me if I am wrong about assumptions about windows. My
> understanding cannot be perfect. As far as I know, 64-bit BARs
> should always be prefetchable, 

There's no requirement that a 64-bit BAR be prefetchable.

  - BARs of PCIe Functions must be prefetchable unless they have read
    side effects or can't tolerate write merging (PCIe r5.0, sec
    7.5.1.2.1).

  - BARs of PCIe Functions other than Legacy Endpoints must be 64-bit
    if they are prefetchable (sec 7.5.1.2.1).

  - Bridge non-prefetchable memory windows are limited to 32-bit
    (7.5.1.3.8).

  - There's some ambiguity in the spec about bridge prefetchable
    memory windows.  Current specs claim 64-bit addresses must be
    supported (sec 7.5.1.3.9), but also say the upper 32 bits are
    optional (sec 7.5.1.3.10).  Both 32- and 64-bit versions
    definitely exist.

> but I own the Aquantia AQC-107S NIC and it has three 64-bit non-pref
> BARs. It happens that they are assigned into the 32-bit window.

This is as it should be.  Non-prefetchable windows are 32 bits, and
in general non-prefetchable BARs must be placed there.

There is some wiggle room in pure PCIe systems because PCIe reads
always contain an explicit length, so in some cases it is safe to
put a non-prefetchable BAR in a prefetchable window (see the
implementation note in sec 7.5.1.2.1).  But I don't think Linux
currently implements this.
