Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D04C156FBA
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 08:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgBJHBY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 02:01:24 -0500
Received: from verein.lst.de ([213.95.11.211]:53901 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgBJHBX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 02:01:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E6E8E68C65; Mon, 10 Feb 2020 08:01:16 +0100 (CET)
Date:   Mon, 10 Feb 2020 08:01:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Message-ID: <20200210070115.GA7748@lst.de>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 07, 2020 at 04:59:58PM -0700, Jon Derrick wrote:
> This set adds an emulation driver for PCIe Hotplug. There may be platforms with
> specific configurations that can support hotplug but don't provide the logical
> slot hotplug hardware. For instance, the platform may use an
> electrically-tolerant interposer between the slot and the device.

The code seems like one giant hack to me.  What is the real life
use case for this?  Another Intel chipset fuckup like vmd or the ahci
remapping?

