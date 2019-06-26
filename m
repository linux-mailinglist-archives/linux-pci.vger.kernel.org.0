Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0D56747
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFZK6s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 06:58:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:45547 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfFZK6s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 06:58:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 03:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="183139426"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2019 03:58:44 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Jun 2019 13:58:43 +0300
Date:   Wed, 26 Jun 2019 13:58:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
Message-ID: <20190626105843.GQ2640@lahna.fi.intel.com>
References: <1668247.RaJIPSxJUN@kreacher>
 <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
 <CAJZ5v0gGdXmgc_9r2rbiadq4e31hngpjYQ40QoC6C0z19da_hQ@mail.gmail.com>
 <2287147.DxjcvLeq6l@kreacher>
 <CAJZ5v0gU9OedmZBNDGefG3GjS7FHRmgQ67eOcr2vXRrAg3zZbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gU9OedmZBNDGefG3GjS7FHRmgQ67eOcr2vXRrAg3zZbg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 06:23:46PM +0200, Rafael J. Wysocki wrote:
> > So I wonder if the patch below makes any difference?
> 
> Mika, can you please test this one in combination with the other
> changes we've been working on?

Sure, I'll give it a try shortly.
