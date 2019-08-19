Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6DD91F7A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfHSI40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 04:56:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:2887 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfHSI4Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 04:56:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 01:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="195493515"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 19 Aug 2019 01:56:21 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 19 Aug 2019 11:56:20 +0300
Date:   Mon, 19 Aug 2019 11:56:20 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20190819085620.GM19908@lahna.fi.intel.com>
References: <20190812143133.75319-1-mika.westerberg@linux.intel.com>
 <20190812143133.75319-2-mika.westerberg@linux.intel.com>
 <ba0380b1-e8d1-890a-82e2-61d0ab6e9cae@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba0380b1-e8d1-890a-82e2-61d0ab6e9cae@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 18, 2019 at 10:28:13PM -0400, Sinan Kaya wrote:
> On 8/12/2019 10:31 AM, Mika Westerberg wrote:
> > +int pciehp_card_present_or_link_active(struct controller *ctrl)
> >  {
> > -	return pciehp_card_present(ctrl) || pciehp_check_link_active(ctrl);
> > +	int ret;
> > +
> > +	ret = pciehp_card_present(ctrl);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return pciehp_check_link_active(ctrl);
> 
> The semantics of this function changed here. Before it was checking for
> either presence detect bit or link active bit. Now, it is looking to
> have both set.

Hmm, maybe I haven't got enough coffee yet but I'm not sure I understand :)
The intention was that the above two are equivalent with the exception
of handling the possible error.

> There are PCI controllers that won't report presence detect correctly,
> but still report link active.

If that's the case then pciehp_card_present() returns false so we call
pciehp_check_link_active() which should work with those controllers.

What I'm missing here?
