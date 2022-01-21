Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3762495F3A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 13:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350419AbiAUMpB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 07:45:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:46033 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380491AbiAUMos (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jan 2022 07:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642769088; x=1674305088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBgyBJeKeufxtfHZIsR21oR1bSK2PNthOZMTTg5G60A=;
  b=U7CjlmYELeMM6FSb5rHMO0xZN2UvA9bkT4JqwTsD8NybsVnqU/l+CzZN
   XCNJhyG+U3fG6CP/4C67fsjSjgvSuvGtGrvkrjiAPplhG8BYFQtuRU44Z
   rUkPQJLF7Kxyr1oCYyxZ+fHSZRpykkT3OuWBeslukOeSH3sgucYVVx4Vc
   G/URLSN82FShiGoPaof6hP9LwR/S99d9Pk0Q8UXZ2tEtVfSjp17tQAz+1
   9Lcw3AUo9ih6TJg5YrqSiVV6MQ/JLamTlvxXc8yV62/Lc6qnQ5yTgm6yi
   9nqKO9vD9ka66ezbkMyKJx4+y0NWxkaSS3sUxo2xdmD33kt3hSNmHBI53
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="331996130"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="331996130"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 04:44:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="533262147"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 04:44:34 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 21 Jan 2022 14:44:32 +0200
Date:   Fri, 21 Jan 2022 14:44:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        koba.ko@canonical.com, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Skip enabling AER on external facing ports
Message-ID: <Yeqqr1YXTNBkpz5C@lahna>
References: <20220105060643.822111-1-kai.heng.feng@canonical.com>
 <20220105201226.GA218998@bhelgaas>
 <CAAd53p5V9gCCc6v9Wdo-bONYfASnhtyGHVPPb6vOneft2XewQQ@mail.gmail.com>
 <YeqRGQoPKy389ct5@lahna>
 <CAAd53p4ej6FA0dM4ahngnGAccSLe=-bsUVkt-eGb2jZkms1UYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4ej6FA0dM4ahngnGAccSLe=-bsUVkt-eGb2jZkms1UYA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Jan 21, 2022 at 08:31:27PM +0800, Kai-Heng Feng wrote:
> Hi Mika,
> 
> On Fri, Jan 21, 2022 at 6:55 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi Kai-Heng,
> >
> > On Fri, Jan 07, 2022 at 12:09:57PM +0800, Kai-Heng Feng wrote:
> > > Only from root ports of thunderbolt devices.
> > >
> > > The error occurs as soon as the root port is runtime suspended to D3cold.
> > >
> > > Runtime suspend the AER service can resolve the issue. I wonder if
> > > it's the right thing to do here?
> >
> > I think you are right here. It seems that AER "service driver" is
> > completely missing PM hooks. Probably because it is more used in server
> > type of systems where power management is not priority.
> 
> Here is my previous attempt to suspend AER:
> https://lore.kernel.org/linux-pci/20210127173101.446940-1-kai.heng.feng@canonical.com/

That's great!

I think we should do the same for runtime PM paths too, though. Will you
take care of that as well? :)
