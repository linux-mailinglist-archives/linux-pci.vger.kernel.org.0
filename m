Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48DE1058DE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 18:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKURzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 12:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKURzJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 12:55:09 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950302068F;
        Thu, 21 Nov 2019 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574358908;
        bh=2EPdODy+7MNcUT49xdDaA0T1l27GqQB5Ebpa+Jv/aD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0xXJEOJWkxchQu9hKjT7ONzVckkDAv81CwAEZjHdWzA/SdPnXfZMnW0lRtHTsPI0R
         qjHZmhu1Krn9CtV8y3H7dPWy/s2/8tGF3VOmsIB7uQWSDte8BDRqNwX8nBTz2yGDzw
         HxeH2ihyqnuP043D2sGTZU9seQ0mDe7yrQapI+ns=
Date:   Thu, 21 Nov 2019 11:55:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Message-ID: <20191121175507.GA54569@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043824FACB1E66E3F31890D2804E0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Naresh]

On Thu, Nov 21, 2019 at 02:52:41PM +0000, Nicholas Johnson wrote:
> On Tue, Nov 19, 2019 at 07:38:28AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 19, 2019 at 03:17:04AM +0000, Nicholas Johnson wrote:
> > > I did just discover linux-next and I built it. Should I be doing this 
> > > more often to help find regressions?
> > 
> > Yes, if you build and run linux-next, that's a great service because
> > it helps find problems before they appear in mainline.
> 
> Funnily enough, I just built Linux next-20191121 and it has a NULL 
> dereference on start-up, which renders the system unusable.
> 
> Can anybody else please confirm? I enabled most of the new options since 
> the last linux-next a few days before.
> ...

> Here is a preliminary bug report (assuming you are meant to report 
> linux-next bugs here):
> https://bugzilla.kernel.org/show_bug.cgi?id=205621

Looks similar to these reports I found by searching for kernfs_find_ns on
https://lore.kernel.org/lkml:

  https://lore.kernel.org/r/000000000000bdfc8e0597ddbde4@google.com
  https://lore.kernel.org/r/000000000000c1e9090597ddbd9d@google.com
  https://lore.kernel.org/r/CA+G9fYsrRw2SRb92eROCt6aU==j6Qr9Fe4AmJyn4fMj5gDFt=w@mail.gmail.com

Thanks very much for doing this testing and reporting the results.  I
don't think there's anything more you need to do.  It looks like
Naresh already cc'd some likely candidates.

Bjorn
