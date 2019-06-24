Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1126050956
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 12:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfFXK6h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 06:58:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:25138 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfFXK6h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 06:58:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 03:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,411,1557212400"; 
   d="scan'208";a="182613006"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Jun 2019 03:58:33 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Jun 2019 13:58:32 +0300
Date:   Mon, 24 Jun 2019 13:58:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
Message-ID: <20190624105832.GE2640@lahna.fi.intel.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190618161858.77834-2-mika.westerberg@linux.intel.com>
 <CAJZ5v0huw-n1m3mz2fEk9y2ejQuT4XYeP8_a-iR+epSq5Wu6yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0huw-n1m3mz2fEk9y2ejQuT4XYeP8_a-iR+epSq5Wu6yQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 21, 2019 at 01:56:49PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 18, 2019 at 6:19 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> 
> Actually, to start with, you can say that the ACPI power state
> returned by acpi_device_get_power() may depend on the configuration of
> ACPI power resources in the system which may change at any time after
> acpi_device_get_power() has returned, unless the reference counters of
> the ACPI power resources in question are set to prevent that from
> happening.  Thus it is invalid to use acpi_device_get_power() in
> acpi_pci_get_power_state() the way it is done now and the value of the
> power.state field in the corresponding struct acpi_device object
> (which reflects the ACPI power resources reference counting, among
> other things) should be used instead.
> 
> Then you can describe the particular issue below as an example.
> 
> IMO that would explain the rationale better here.

Thanks! I'll update the changelog accordingly.
