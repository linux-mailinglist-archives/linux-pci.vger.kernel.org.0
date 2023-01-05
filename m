Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4154B65F308
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjAERmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 12:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjAERmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 12:42:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF64B41032;
        Thu,  5 Jan 2023 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672940536; x=1704476536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nm8XN5UrQy4aa6gZCYXxJPwD8gab0pZ5U+FjFjFY3A=;
  b=JIggYTErMBW4+slXT4ELGqNB1yrPXJ2yMH2aTgiaXdmzdtbtH9EZ5Hxk
   aWDvBOaEcfEBBRzX0OH2wR/Vqq3aps+4MuDpWEUimSgpryqDNAOJ55ZjP
   npp3OemKUe6iKnWACDopFRlWu9yo6PFlCZWgQFpknG0bymtOW6fwM7bwU
   CaxOU2vJeZokLDfp5THOWdi2ZyJa6rpsaCnnFWNM4XOsqg4/traZh7+8m
   RAeRM6b0q85IiYHgjNYc88baENHQST4qZTl7LrwdO4uYHBIFL7wUGMilg
   3TfSsh7RQeVjHM4QxEt7BIGI1+XCRBKjF3BClryzywjFKeTxHYIv9juP2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="408524632"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="408524632"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 09:42:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="718900072"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="718900072"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 09:42:11 -0800
Date:   Thu, 5 Jan 2023 09:42:10 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, bhelgaas@google.com,
        hdegoede@redhat.com, kernelorg@undead.fr, kjhambrick@gmail.com,
        2lprbe78@duck.com, nicholas.johnson-opensource@outlook.com.au,
        benoitg@coeus.ca, mika.westerberg@linux.intel.com,
        wse@tuxedocomputers.com, mumblingdrunkard@protonmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.e.box@intel.com, yunying.sun@intel.com
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <Y7cL8pIqLrwv2z7+@agluck-desk3.sc.intel.com>
References: <20230104145032.GA1069244@bhelgaas>
 <20230104154511.GA1071195@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104154511.GA1071195@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 04, 2023 at 09:45:11AM -0600, Bjorn Helgaas wrote:
> My understanding is that EfiMemoryMappedIO tells the OS to map the
> area for use by runtime services, but is not intended to prevent the
> OS from using the area.  Some platforms use EfiMemoryMappedIO for PCI
> host bridge apertures, and of course the OS needs to use those.
> 
> If your firmware folks disagree and think Linux should be able to
> figure this out differently, I would love to have a conversation about
> how to do this.

It seems that 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
is also the cause of breakage for drivers/edac/sb_edac.c. It is broken
in v6.2-rc2 and reverting this commit makes it work again.

This ancient driver probably plays fast and loose with how it ought to
access extended PCIe config space ... but it needs to do this to read various
memory controller configuration registers to do address translation from
a system physical address to a DIMM address.

-Tony
