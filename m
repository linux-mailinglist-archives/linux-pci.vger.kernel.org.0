Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4E215804A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 17:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBJQ7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 11:59:01 -0500
Received: from verein.lst.de ([213.95.11.211]:56630 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbgBJQ7B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 11:59:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 057FD68B20; Mon, 10 Feb 2020 17:58:58 +0100 (CET)
Date:   Mon, 10 Feb 2020 17:58:57 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Message-ID: <20200210165857.GA19419@lst.de>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com> <20200210070115.GA7748@lst.de> <3a4de58ad83a88f90f372e162c39d09eeebd8043.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a4de58ad83a88f90f372e162c39d09eeebd8043.camel@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 10, 2020 at 03:05:47PM +0000, Derrick, Jonathan wrote:
> > The code seems like one giant hack to me.  What is the real life
> > use case for this?  Another Intel chipset fuckup like vmd or the ahci
> > remapping?
> > 
> Exactly as the cover letter describes. An interposer being used on a
> non-hotplug slot.

That isn't a use a case, that iѕ a description of the implementation.
Why would you want this code?
