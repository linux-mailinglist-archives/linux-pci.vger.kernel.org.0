Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BF4CD7A5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 16:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbiCDPX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 10:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbiCDPXs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 10:23:48 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D41BB702;
        Fri,  4 Mar 2022 07:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646407380; x=1677943380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=66bGrpR5PYIU1/su9EGXUAH+XSxS4Nhc40zZxcfzJR8=;
  b=mn5DeOLLKsmGtbGPwlMokWBBx0yzKxnnOjgO+3j87I2wo4Q0ohhDyYin
   jPrGdqPO74uMMQuxqXZhRml+uB38xidZl5hDaKBroIWn9bvTi1bjgJHS1
   IDn00uwmKuh99ESnYta/4InvMlSHl+phcBr5whxdMZ5lBZvj/c2QSZyzp
   lhBdJbhuKzf41iow9/4+ipXz3Tji8SMZJc6S7Ei/Mrrpfgg56n1iWPrX8
   20lqgSAXyNlulVwKCKqGTOmmIYmHtfg36F9EbW1GdzIo7Uk3sOP4sbqBK
   tBmrk+bEG+h58584SfVuo8K3U8yztxid7lJ2BTiFbY70nzQND2nRbOOjc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="233954757"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="233954757"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 07:22:59 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="609970281"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 07:22:54 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Mar 2022 17:21:41 +0200
Date:   Fri, 4 Mar 2022 17:21:41 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/3] x86/PCI: Clip only partial E820 overlaps
Message-ID: <YiIuhYVpgkzVwtAi@lahna>
References: <20220304035110.988712-1-helgaas@kernel.org>
 <4836963c-7a1e-7452-eb88-454f2b75e407@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4836963c-7a1e-7452-eb88-454f2b75e407@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Mar 04, 2022 at 03:15:16PM +0100, Hans de Goede wrote:
> Hi Bjorn,
> 
> On 3/4/22 04:51, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > This is based on Hans' extensive debugging and patch at
> > https://lore.kernel.org/r/20220228105259.230903-1-hdegoede@redhat.com
> > and applies on 7e57714cd0ad ("Linux 5.17-rc6").
> > 
> > This is basically the same idea (applying the 4dc2287c1805 workaround only
> > when an E820 region *partially* overlaps a host bridge window), but I think
> > it's a little simpler.
> > 
> > This also adds a little dmesg output when clipping, which should make
> > future debugging easier.
> > 
> > I bcc'd several folks who didn't have public email addresses in the RedHat
> > bugzilla or Launchpad.  If you review or test this, I'd be happy to
> > acknowledge that.
> > 
> > Bjorn Helgaas (3):
> >   x86/PCI: Eliminate remove_e820_regions() common subexpressions
> >   x86/PCI: Log host bridge window clipping for E820 regions
> >   x86/PCI: Preserve host bridge windows completely covered by E820
> 
> Thanks, I agree that this is better then my fix I also like the logging
> added to 2/3 which lets us know if the commit 4dc2287c1805 workaround
> is active.
> 
> I have one small remark on 3/3. Regardless of that getting addressed
> the entire series is:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Looks good to me too :)

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
