Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274332699B
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 20:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfEVSMJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 14:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfEVSMI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 14:12:08 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C75C120863;
        Wed, 22 May 2019 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558548728;
        bh=3WQ3M9QP+2THWg2C9BAXf4+415QJkdpmvuQ16XUxwCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2iwC/N/iNoycLsezLmlaQWwbnSnNqiiwUoDCjjUFf2zie3wDN0zyfYi9cuSVEt6q
         g+XZzv9XD2GR+hX8iP6OWjycEA06Uk9GWGtaFDaB62SCrlgfm4ze5MURwPulf9+XrF
         Umc0gS/Op9bK2i+4Q5i6uNAfAAchOhVX0BLmSp0E=
Date:   Wed, 22 May 2019 13:11:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only
 supports wakeup from D0
Message-ID: <20190522181157.GC79339@google.com>
References: <20190521163104.15759-1-kai.heng.feng@canonical.com>
 <20190521222300.GG57618@google.com>
 <AE3B21D0-5BD9-40A5-B5A1-3E9A8B8E1327@canonical.com>
 <20190522134854.GA79339@google.com>
 <D5DC20F1-6B8F-466F-BAE7-65F0C8FB3D1D@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5DC20F1-6B8F-466F-BAE7-65F0C8FB3D1D@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 11:46:25PM +0800, Kai Heng Feng wrote:
> > On May 22, 2019, at 9:48 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, May 22, 2019 at 11:42:14AM +0800, Kai Heng Feng wrote:
> >> at 6:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>> On Wed, May 22, 2019 at 12:31:04AM +0800, Kai-Heng Feng wrote:
> >>>> There's an xHC device that doesn't wake when a USB device gets plugged
> >>>> to its USB port. The driver's own runtime suspend callback was called,
> >>>> PME signaling was enabled, but it stays at PCI D0.

> > ...
> > And I guess this patch basically means we wouldn't call the driver's
> > suspend callback if we're merely going to stay at D0, so the driver
> > would have no idea anything happened.  That might match
> > Documentation/power/pci.txt better, because it suggests that the
> > suspend callback is related to putting a device in a low-power state,
> > and D0 is not a low-power state.
> 
> Yes, the patch is to let the device stay at D0 and don’t run driver’s own
> runtime suspend routine.
> 
> I guess I’ll just proceed to send a V2 with updated commit message?

Now that I understand what "runtime suspended to D0" means, help me
understand what's actually wrong.

The PCI core apparently *does* enable PME when we "suspend to D0".
But somehow calling the xHCI runtime suspend callback makes the driver
unable to notice when the PME is signaled?

Bjorn
