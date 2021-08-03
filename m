Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350613DE932
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 11:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhHCJFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 05:05:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:52552 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234554AbhHCJFs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 05:05:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="200827029"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="200827029"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 02:05:36 -0700
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="scan'208";a="479400208"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 02:05:33 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Aug 2021 12:05:30 +0300
Date:   Tue, 3 Aug 2021 12:05:30 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, bhelgaas@google.com,
        YehezkelShB@gmail.com, Basavaraj.Natikar@amd.com,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] thunderbolt: Fix adapter init handling during switch
 add
Message-ID: <YQkG2oeZ4nRpzx4R@lahna>
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-4-git-send-email-Sanju.Mehta@amd.com>
 <YQgOj7elfCp7l4OO@lahna>
 <6da505a4-abad-ab8b-7706-17f83a35ff41@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da505a4-abad-ab8b-7706-17f83a35ff41@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Aug 03, 2021 at 12:23:44AM +0530, Sanjay R Mehta wrote:
> 
> 
> On 8/2/2021 8:56 PM, Mika Westerberg wrote:
> > [CAUTION: External Email]
> > 
> > On Mon, Aug 02, 2021 at 07:58:19AM -0500, Sanjay R Mehta wrote:
> >> From: Sanjay R Mehta <sanju.mehta@amd.com>
> >>
> >> Adapter0 (Port0) is the control adapter on the AMD USB4 host router.
> >> As per USB4 spec in "Section 1.8", Control Adapters do not
> >> have an Adapter Configuration Space".
> >>
> >> The read requests on Adapter0 time's out and driver initialization fails.
> >>
> >> Hence Disabling the Adapter in case of read-request timeout and continuing
> >> the driver init.
> >>
> >> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> >> ---
> >>  drivers/thunderbolt/switch.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> >> index 83b1ef3..effbfe4 100644
> >> --- a/drivers/thunderbolt/switch.c
> >> +++ b/drivers/thunderbolt/switch.c
> >> @@ -2747,8 +2747,9 @@ int tb_switch_add(struct tb_switch *sw)
> >>                       }
> >>                       ret = tb_init_port(&sw->ports[i]);
> >>                       if (ret) {
> >> +                             sw->ports[i].disabled = true;
> >>                               dev_err(&sw->dev, "failed to initialize port %d\n", i);
> >> -                             return ret;
> >> +                             continue;
> > 
> > Instead of this, would it work if we start the loop at 1? In case of the
> > control adapter (0) tb_port_init() does not do anything useful anyway
> > and it actually would simplify that function too if we get rid of the
> > special casing.
> > 
> Hi Mika,
> 
> If we start loop from 1, it will work for host router
> but this will skip port (0) on device router which may be valid port.

For device router adapter 0 is also contror adapter so I think we can
just skip it here unconditionally.
