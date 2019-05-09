Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C131E1941C
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfEIVIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 17:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfEIVIX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 17:08:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22CDD21744;
        Thu,  9 May 2019 21:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436102;
        bh=Wly7TaPachuEZERSoVEt35VXvn6TyrNCP5Tn83ZqAu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odYNHONJ76B2aeWHrz9oogRk3XRFfXnkH0Enr0C0ew8loCvuuwZWbWGdDm7kpG18T
         2FnGRr5NBv1PIMq49E231CG4//uHNujksp+N4DewTIqAVKLiyeCu3ZWM2x+g71GRVj
         jMgupWV9gWuPN8ZxADSb20AL5n7fFDlAESm2BpUE=
Date:   Thu, 9 May 2019 16:08:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] PCI/AER: Replace dev_printk(KERN_DEBUG) with
 dev_info()
Message-ID: <20190509210819.GB235064@google.com>
References: <20190509141456.223614-1-helgaas@kernel.org>
 <20190509141456.223614-2-helgaas@kernel.org>
 <CAHp75VfbVvpMaKdeKKTs_zF6CcJf5==oV8PR+YF+RTAtZrtRfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfbVvpMaKdeKKTs_zF6CcJf5==oV8PR+YF+RTAtZrtRfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 09, 2019 at 08:36:16PM +0300, Andy Shevchenko wrote:
> On Thu, May 9, 2019 at 5:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Frederick Lawler <fred@fredlawl.com>
> >
> > Replace dev_printk(KERN_DEBUG) with dev_info() or dev_err() to be more
> > consistent with other logging.
> >
> > These could be converted to dev_dbg(), but that depends on
> > CONFIG_DYNAMIC_DEBUG and DEBUG, and we want most of these messages to
> > *always* be in the dmesg log.
> >
> > Also remove a redundant kzalloc() failure message.
> 
> > +               pci_info(parent, "can't find device of ID%04x\n",
> > +                        e_info->id);
> 
> Would it be a chance to take them one line instead of two?
> 
> > +               dev_err(device, "request AER IRQ %d failed\n",
> > +                       dev->irq);
> 
> Ditto.

Indeed, fixed, thanks!
