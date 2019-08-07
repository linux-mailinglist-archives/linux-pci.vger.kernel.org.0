Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76E84917
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfHGKGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 06:06:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:36189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfHGKGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 06:06:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 03:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="192883454"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 07 Aug 2019 03:06:47 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 07 Aug 2019 13:06:46 +0300
Date:   Wed, 7 Aug 2019 13:06:46 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Matthias Andree <matthias.andree@gmx.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: Re: [Regression] pcie_wait_for_link_delay (1132.853 ms @ 5039.414431)
Message-ID: <20190807100646.GJ2716@lahna.fi.intel.com>
References: <2857501d-c167-547d-c57d-d5d24ea1f1dc@molgen.mpg.de>
 <20190806093626.GF2548@lahna.fi.intel.com>
 <acca5213-7d8b-7db1-ff3c-cb5b4a704f04@molgen.mpg.de>
 <20190806113154.GS2548@lahna.fi.intel.com>
 <f1093e5c-2b90-c61c-7fed-437abda6ec6a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1093e5c-2b90-c61c-7fed-437abda6ec6a@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 06, 2019 at 09:56:27PM +0200, Matthias Andree wrote:
> Mika,
> 
> reviewing the code in your commit, can we double-check the "!" in "if
> (!pdev->imm_ready)" here?
> 
> > static int get_downstream_delay(struct pci_bus *bus)
> > {
> >         struct pci_dev *pdev;
> >         int min_delay = 100;
> >         int max_delay = 0;
> >
> >         list_for_each_entry(pdev, &bus->devices, bus_list) {
> >                 if (!pdev->imm_ready)
> 
> I have zero clue of PCI (Express), but reading other parts of your patch,
> I think min_delay should be zeroed if imm_ready is 1 (currently it is
> zeroed if imm_ready == 0),
> unless the header file has a misleading comment.

Agreed it should be pdev->imm_ready without the negation.

I'll send a revert for that commit later today so the two reported
issues caused by it should get fixed.
