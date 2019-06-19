Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A9C4BA13
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 15:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfFSNfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 09:35:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:64195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfFSNfE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 09:35:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 06:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,392,1557212400"; 
   d="scan'208";a="181637795"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 19 Jun 2019 06:34:59 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:34:58 +0300
Date:   Wed, 19 Jun 2019 16:34:58 +0300
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
Subject: Re: [PATCH v2 2/3] ACPI / PM: Introduce concept of a _PR0 dependent
 device
Message-ID: <20190619133458.GD2640@lahna.fi.intel.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190618161858.77834-3-mika.westerberg@linux.intel.com>
 <CAJZ5v0jaNpgW2=QfTVYcY=2MzTCaxNNSsVT667Lwz8HxvJT8mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jaNpgW2=QfTVYcY=2MzTCaxNNSsVT667Lwz8HxvJT8mQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 03:20:45PM +0200, Rafael J. Wysocki wrote:
> > +int acpi_device_power_add_dependent(struct acpi_device *adev,
> > +                                   struct device *dev)
> > +{
> > +       struct acpi_power_resource_entry *entry;
> > +       struct list_head *resources;
> > +       int ret;
> > +
> > +       if (!adev->power.flags.power_resources)
> > +               return 0;
> > +       if (!adev->power.states[ACPI_STATE_D0].flags.valid)
> > +               return 0;
> 
> The two checks above can be replaced with an
> adev->flags.power_manageable one AFAICS (the "valid" flag is always
> set for D0 and the list below will be empty if there are no power
> resources).
> 
> Same for acpi_device_power_remove_dependent(), of course.

OK, I'll do that in next version.

> Apart from this LGTM.

Thanks!
