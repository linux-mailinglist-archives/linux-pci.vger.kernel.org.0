Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A13139FB0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 04:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgANDE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 22:04:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:31656 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbgANDE2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 22:04:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 19:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="397354511"
Received: from unknown (HELO chenyu-office) ([10.239.158.173])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2020 19:04:25 -0800
Date:   Tue, 14 Jan 2020 11:04:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/PM: Print the pci config space of devices before
 suspend
Message-ID: <20200114030400.GA5065@chenyu-office>
References: <20200113060724.19571-1-yu.c.chen@intel.com>
 <CAJZ5v0jgdfAG_BDefdSQFV9hM61o68Aj31PxShNxxcpsYFpxgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jgdfAG_BDefdSQFV9hM61o68Aj31PxShNxxcpsYFpxgw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,
On Mon, Jan 13, 2020 at 11:01:28AM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 13, 2020 at 7:08 AM Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > The pci config space was found to be insane during resume
> 
> I wouldn't call it "insane".
> 
> It probably means that the device was not present or not accessible
> during hibernation and now it appears to be present (maybe the restore
> kernel found it and configured it).
> 
Right, thanks for the hint. If this is the case, it should not
save any pci config settings if that device is not accessible,
otherwise there's risk of pci config hard confliction after resumed.
I've applied the patch and wait for the issue to be reproduced
(not 100%) and will send the result later.

Thanks,
Chenyu
