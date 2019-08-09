Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9655F883D7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 22:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfHIU2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 16:28:17 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:37231 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfHIU2R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 16:28:17 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 895A8101E69DC;
        Fri,  9 Aug 2019 22:28:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 35D09DFE15; Fri,  9 Aug 2019 22:28:15 +0200 (CEST)
Date:   Fri, 9 Aug 2019 22:28:15 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH] PCI: pciehp: Avoid returning prematurely from sysfs
 requests
Message-ID: <20190809202815.4jtpdsnnmztins34@wunner.de>
References: <4174210466e27eb7e2243dd1d801d5f75baaffd8.1565345211.git.lukas@wunner.de>
 <20190809193216.GD28515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809193216.GD28515@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 09, 2019 at 01:32:16PM -0600, Keith Busch wrote:
> On Fri, Aug 09, 2019 at 12:28:43PM +0200, Lukas Wunner wrote:
> > A sysfs request to enable or disable a PCIe hotplug slot should not
> > return before it has been carried out.  That is sought to be achieved
> > by waiting until the controller's "pending_events" have been cleared.
> > 
> > However the IRQ thread pciehp_ist() clears the "pending_events" before
> > it acts on them.  If pciehp_sysfs_enable_slot() / _disable_slot() happen
> > to check the "pending_events" after they have been cleared but while
> > pciehp_ist() is still running, the functions may return prematurely
> > with an incorrect return value.
> > 
> > Fix by introducing an "ist_running" flag which must be false before a
> > sysfs request is allowed to return.
> 
> Can you instead just call synchronize_irq(ctrl->pcie->irq) after the
> pending events is cleared?

You mean call synchronize_irq() from pciehp_sysfs_enable_slot() /
disable_slot()?  That's a good idea, let me think that through and
try to make it work that way.

Thanks!

Lukas
