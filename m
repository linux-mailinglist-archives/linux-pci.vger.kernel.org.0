Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF50F6FFB46
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbjEKU2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 16:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEKU2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 16:28:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A602649DB;
        Thu, 11 May 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683836893; x=1715372893;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=n25ZNHrKsSFUN6rKzqMObOZGz6gbfk8Qx8gF6Zxf8vo=;
  b=Kudmpd7JPraJtZ3MhXJpnqemSCQ5jmGNE8xnNOP065pv9aAFvgGR0lxB
   aN0nUP78KKKCfaZypTDON0WtaAg6pcmTC49ZwU1HbKu5OK7StpoysxJMi
   urmSm8AGcm7JCmID0DRuwhiVz/bt1GJ1WuoFSKpVPWC4+GlS1uKtjfJpM
   e73wnZcg7jfODtFNbqWLzd5+OnAn4/hSs4OvVZawUYz47//78QqKyOZCJ
   r3S+L9Hd6Tg+Oex9bEWxXbqPEqChFMVUQHNsHKXSKU5DXEo3fq+FFqSwa
   a9qV3UgP2gzkIA3/N6/BL4r82ywSSXfbFSeSSXb7uD+LrXo0sAC5GQnR6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335134612"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="335134612"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 13:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="677404573"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="677404573"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.252.39.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 13:28:08 -0700
Date:   Thu, 11 May 2023 23:28:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy?ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
In-Reply-To: <20230511200710.GB31598@wunner.de>
Message-ID: <13f587b-e937-d546-817d-5fd94443c1eb@linux.intel.com>
References: <ZF1AjOKDVlbNFJPK@bhelgaas> <1d5aaff-c7b5-39f6-92ca-319fad6c7fc5@linux.intel.com> <20230511200710.GB31598@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1822236698-1683836300=:1900"
Content-ID: <7bff7d20-6490-156d-cff-a4e145255ea4@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1822236698-1683836300=:1900
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <fea2e7bf-8d71-ffb7-be19-8c234cab82c7@linux.intel.com>

On Thu, 11 May 2023, Lukas Wunner wrote:

> On Thu, May 11, 2023 at 10:58:40PM +0300, Ilpo Järvinen wrote:
> > On Thu, 11 May 2023, Bjorn Helgaas wrote:
> > > Many of these are ASPM-related updates that IMHO should not be in
> > > drivers at all.  Drivers should use PCI core interfaces so the core
> > > doesn't get confused.
> > 
> > Ah, yes. I forgot to mention it in the cover letter but I noticed that 
> > some of those seem to be workarounds for the cases where core refuses to 
> > disable ASPM. Some sites even explicit have a comment about that after 
> > the call to pci_disable_link_state():
> [...]
> > That kinda feels something that would want a force disable quirk that is 
> > reliable. There are quirks for some devices which try to disable it but 
> > could fail for reasons mentioned in that comment. (But I'd prefer to make 
> > another series out of it rather than putting it into this one.)
> 
> I'm wondering if it's worth cleaning up ASPM handling in drivers first
> as the locking issue may then largely solve itself.  The locking could
> probably be kept internal to ASPM core code then.

For some part yes, but at least those copy-pasted gpu setup codes did some 
other things too.

In any case, it would go against some earlier policy decision:

/**
 * pci_disable_link_state - Disable device's link state, so the link will
 * never enter specific states.  Note that if the BIOS didn't grant ASPM
 * control to the OS, this does nothing because we can't touch the LNKCTL
 * register. Returns 0 or a negative errno.

Is it fine to make core capable of violating that policy?

One question before I trying to come up something is when PCIEASPM is =n, 
should I provide some simple function that just does the LNKCTL write to 
disable it? And another thing is the existing quirks, should they be 
kept depending on the existing behavior or not?


-- 
 i.
--8323329-1822236698-1683836300=:1900--
