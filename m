Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB02245ED
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 23:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGQVji (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 17:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgGQVjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 17:39:37 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C157720759;
        Fri, 17 Jul 2020 21:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595021977;
        bh=0RjVAWHDnrEwR2TO2+v6QbgWs4WgKKxdYyuRXnTv7Z8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gS5nE300oddH2xzOAzrVgigEYvZpSVUlgZ3oKSZ6SfhaY7xB5hG7feah2rwdwbGE8
         adKpqp1VIJeH5UfT9x9omrTL4B/tCli+KVlUsLXtRSJbeF/xTk78PpX6IaMv2dK/M7
         GCPXBqVVmTqK7v4DFJhalWf4v8CHVueD5bhIQ3Q8=
Date:   Fri, 17 Jul 2020 16:39:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Kelley <sean.v.kelley@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCH v2] PCI/AER: Do not reset the port device status if doing
 firmware first handling.
Message-ID: <20200717213935.GA775201@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717200129.GA671299@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 03:01:29PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 22, 2020 at 07:35:23PM +0800, Jonathan Cameron wrote:
> > pci_aer_clear_device_status() currently resets the device status
> > (PCI_EXP_DEVSTA) on the downstream port above a device, or the port itself
> > if the port is the reported AER error source.  This happens even when error
> > handling is firmware first.
> > 
> > Our interpretation is that firmware first handling means that the firmware
> > will deal with clearing all relevant error reporting registers
> > including this one.
> 
> ...
> But I think what the _OSC negotiation for AER ownership is relevant,
> and that's what your patch tests, so I think this is the right thing
> to do.
> 
> So I applied this as below to pci/error for v5.8, thanks a lot!

Oops, sorry, I meant for v5.9.  It doesn't seem to be an urgent bug
fix that we could justify merging for v5.8 after the merge window.
