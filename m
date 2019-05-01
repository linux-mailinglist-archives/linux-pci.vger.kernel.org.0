Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D470E108D6
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEAOLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 10:11:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:20486 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfEAOLf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 10:11:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 07:11:35 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2019 07:11:34 -0700
Date:   Wed, 1 May 2019 08:05:47 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>
Subject: Re: [PATCH] PCI/LINK: Add Kconfig option (default off)
Message-ID: <20190501140546.GA26910@localhost.localdomain>
References: <20190501132248.26842-1-keith.busch@intel.com>
 <20190501134257.GA18020@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501134257.GA18020@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 01, 2019 at 06:42:57AM -0700, Christoph Hellwig wrote:
> On Wed, May 01, 2019 at 07:22:48AM -0600, Keith Busch wrote:
> > +config PCIE_BW
> > +	bool "PCI Express Bandwidth Change Notification"
> > +	default n
> 
> n is the default default, no need to add it manually.

So extra credit for going beyond the bare minimum?!

... sending v2.
