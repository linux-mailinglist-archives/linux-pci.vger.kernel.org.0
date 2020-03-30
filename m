Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7C61982AD
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgC3Rt4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 13:49:56 -0400
Received: from verein.lst.de ([213.95.11.211]:34955 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgC3Rty (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 13:49:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB2B468B05; Mon, 30 Mar 2020 19:49:50 +0200 (CEST)
Date:   Mon, 30 Mar 2020 19:49:50 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Message-ID: <20200330174950.GA19929@lst.de>
References: <20200328215123.GA130140@google.com> <97b916ad6ad03f39ccdf5b62fe7d7b9e10190708.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b916ad6ad03f39ccdf5b62fe7d7b9e10190708.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 05:43:33PM +0000, Derrick, Jonathan wrote:
> > There's a lot of good work in here, and I don't claim to understand
> > the use case and all the benefits.
> I've received more info that the customer use case is an AIC that
> breaks out 1-4 M.2 cards which have been made hotplug tolerant.

Which sounds completely bogus.  M.2 cards are eletrically not designed
for this at all, and neither is the AIC.  If people want to support
similar use cases they need to get them standardized by PCI SIG
and handled by hotplug capable slots.
