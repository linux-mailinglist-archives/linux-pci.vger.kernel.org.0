Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FAFFF6D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3SK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 14:10:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:46938 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3SK7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 14:10:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 11:10:58 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2019 11:10:57 -0700
Date:   Tue, 30 Apr 2019 12:05:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alex G <mr.nuke.me@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI/LINK: Report degraded links via link
 bandwidth notification"
Message-ID: <20190430180508.GB25654@localhost.localdomain>
References: <20190429185611.121751-1-helgaas@kernel.org>
 <20190429185611.121751-2-helgaas@kernel.org>
 <d902522e-f788-5e12-6b63-18ac5d5fa955@gmail.com>
 <20190430161151.GB145057@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430161151.GB145057@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 30, 2019 at 11:11:51AM -0500, Bjorn Helgaas wrote:
> > I'm not convinced a revert is the best call.
> 
> I have very limited options at this stage of the release, but I'd be
> glad to hear suggestions.  My concern is that if we release v5.1
> as-is, we'll spend a lot of energy on those false positives.

May be too late now if the revert is queued up, but I think this feature
should have been a default 'false' Kconfig bool rather than always on.
