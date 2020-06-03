Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B23C1EC7C2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 05:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFCDXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 23:23:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:36069 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFCDXz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 23:23:55 -0400
IronPort-SDR: IMlM+UulnSJPzgjwdwfJI4ZGg4Vlo54EXEdst7h80Y9SMmwqvJHnaYHYQu+3UlLrINbJzk5JHD
 ihIuLWUImk6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 20:23:54 -0700
IronPort-SDR: w4l+stt4XifZhyuRljBOvl9fnsYXtXYlJNhCRnHDcMxw1ooCIZ0nYxQwi9EOr2IVZUU+ejXiHO
 RiD3J+B9KQhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="304459016"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2020 20:23:54 -0700
Date:   Tue, 2 Jun 2020 20:23:54 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: pcie_bus_config settings. What exactly do each setting mean.. 
Message-ID: <20200603032354.GA18165@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn

I was trying to fix pcie_write_mrrs() since its seems to not follow PCIe
SIG recommendations. 

It appears to that 010 (512b) is the default and 4096b is the max spec
allowed limit.

Current code seems to match MRRS and MPS, which seem to be completely
different purposes. 

But trying to fix i got confused with all these pcie_bus_config_types.

enum pcie_bus_config_types {
        PCIE_BUS_TUNE_OFF,      /* Don't touch MPS at all */
        PCIE_BUS_DEFAULT,       /* Ensure MPS matches upstream bridge */
        PCIE_BUS_SAFE,          /* Use largest MPS boot-time devices support */
        PCIE_BUS_PERFORMANCE,   /* Use MPS and MRRS for best performance */
        PCIE_BUS_PEER2PEER,     /* Set MPS = 128 for all devices */
};

Not sure what the difference between BUS_TUNE_OFF and BUS_DEFAULT is.

MPS matching upstream bridge is required in all cases right?
BUS_SAFE/BUS_PERFORMANCE? Not sure why that is special for BUS_DEFAULT.

Wouldn't it be simple to say:

BUS_DEFAULT : Just use BIOS settings, no change to anything.

BUS_SAFE: Says Choose largest MPS boot-time settings? What does that
actually mean? Why isn't that BUS_PERFORMANCE?

P2P: Choose smallest setting makes sense.

I think only 3 settings make sense.

BUS_DEFAULT == TUNE_OFF : Choose BIOS values, don't touch anything
BUS_SAFE == BUS_PERFORMANCE : Should actually be the default.
BUS_PEER2PEER - Same as now

Do we really have value for the other settings? Maybe for BUS_DEFAULT we
should call it BUS_BIOS (to indicate real meaning)

BUS_PERFORMANCE should be the default setting for the system.

BUS_P2P if someone needs to configure for p2p.

Cheers,
Ashok
