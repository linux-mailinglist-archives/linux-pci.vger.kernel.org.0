Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8622964B81A
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 16:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiLMPJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 10:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbiLMPJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 10:09:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D706B64DF
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670944178; x=1702480178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSSMwIQD+G+i9tnloMHYHmBwBmpvRTkXzg0Lp62Cfrk=;
  b=fXqNP/KWXI2hCk/vAfD6FU7mege9STBljBqBOWXw3neP429t2evPOH/M
   qfvBbQSNpLYhpjkGTWgGsBTBFkGZRsGjf+I9A/s7p874y3D4yG/qXfXRE
   WZ3WGi0PdCnWO7IJ7c/GFDejdDoVRGHlN7eBkbRG6Fw5am59b5DoqJ8XP
   Wff35SHwtFXdxxAF+bU7yWQHcMbhURxCv6niialHevPxMD7uLB/y5owv+
   MElmPuJ19Y7sYBUWeG0bDN8SU4rJvoHhgUdqYd62hloKxrW12FPPRgYgL
   o2L0x00xAUDKVeEfGtYRbkWTYlcYOQrh4sh3N44/kmEZPZv996wz6fbaA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="315788707"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="315788707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 07:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="737422020"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="737422020"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2022 07:09:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 58857F7; Tue, 13 Dec 2022 17:10:05 +0200 (EET)
Date:   Tue, 13 Dec 2022 17:10:05 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alexander Motin <mav@ixsystems.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Nick Wolff <nwolff@ixsystems.com>,
        Bjorn Helgaas <bjorn@helgaas.com>, linux-pci@vger.kernel.org
Subject: Re: pci_bus_distribute_available_resources() is wrong?
Message-ID: <Y5iVzTcS6OzIMM7a@black.fi.intel.com>
References: <2ec11223-edb3-5f5c-62cd-3532d92de0a4@ixsystems.com>
 <CAErSpo7WrAg5D4xyv0SycoDc1etSspU_TL6XMAK4STYrXDrGNQ@mail.gmail.com>
 <6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com>
 <Y5gSfJd0H4rKXe9H@black.fi.intel.com>
 <35208ffe-0aee-b055-0ed7-99b6414af6da@ixsystems.com>
 <Y5iQtaNgr0nMWjAI@black.fi.intel.com>
 <2f49eee1-7c72-8281-50c1-debaccd43c81@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f49eee1-7c72-8281-50c1-debaccd43c81@ixsystems.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Dec 13, 2022 at 10:00:42AM -0500, Alexander Motin wrote:
> On 13.12.2022 09:48, Mika Westerberg wrote:
> > On Tue, Dec 13, 2022 at 09:11:12AM -0500, Alexander Motin wrote:
> > > > I'm also more than happy to test any patches regarding this if someone
> > > > else wants to work on it ;-)
> > > 
> > > I was kind of ready to dive in, I hate hacks and tunables to workaround
> > > bugs.  But as I have told, I see this code first time, so my solutions may
> > > appear not right.  But I'll help as I can, if needed.
> > 
> > That's good to hear :) Okay feel free to use any of my previous patches
> > as base if needed. I can test the Thunderbolt/USB4 and the QEMU PCI/PCIe
> > topologies so please keep me in the loop when submitting.
> 
> It is quite a quick change of roles, don't you find?  It is you created the
> problem.  It is your email includes "@linux.intel.com" here.  Don't you feel
> some responsibility? ;)

Sorry I must have misunderstood what you meant then. I was under
impression that you were ready to go and fix the issue. Okay no problem
I will work on this myself then and keep you guys updated.

> Where are the current result of "I'm working on a new version of the patch
> series that should take these into consideration"?

Still early "draft" I will submit it once it is in better shape (and I
have validated it works in the known cases). Anyway it will happen after
the merge window is closed.
