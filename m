Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF417EAF5D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 12:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjKNLlr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 06:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjKNLlh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 06:41:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5841AC;
        Tue, 14 Nov 2023 03:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699961535; x=1731497535;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JTzcwCtdnMiga/o5pFKTO6FZ9pdO84nmnA+h3IRlPOg=;
  b=KFRNe8YNLdwG2ZO54UwlCsQHW8VCrWQl6X/U6zGCmsqih4v6lcyV8CZR
   KuPMyVQ7+o0a0VOF1MD0jqkVvFc3bs6XvcScY+YlY7yruaII5qnPwXNot
   815pj4ymPXgmve+4RF4iyKXPsiwnmXfCItP4LpDc6ZwQ8OsGHLYt+qsOn
   3jc0H+zE8Fjkaz6u9QkNL5PeqCNTJT5uLP7wMhOpMgeEE0AVWfrhWAsoa
   XSJJwdRw7+fn+QmItA82ON4tSdLOyPkg0DCKXziXX5afQFRCQ0tv6R6ma
   xUq6km09PbrCsBPw/LppOPlimN9P+BQcNr/fpVXk2h9rKjpgumCbQBVqd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3696837"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="3696837"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="938052041"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="938052041"
Received: from rauhjoha-mobl2.ger.corp.intel.com ([10.251.217.194])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:32:05 -0800
Date:   Tue, 14 Nov 2023 13:32:03 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Steve Wahl <steve.wahl@hpe.com>
cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/apic: Drop struct local_apic
In-Reply-To: <ZUVVJkpGg4hoF/Hs@swahl-home.5wahls.com>
Message-ID: <e427fc2a-1b4-9cbc-636-9790406199d9@linux.intel.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com> <20231102-x86-apic-v1-3-bf049a2a0ed6@citrix.com> <ZUVVJkpGg4hoF/Hs@swahl-home.5wahls.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Nov 2023, Steve Wahl wrote:

> On Thu, Nov 02, 2023 at 12:26:21PM +0000, Andrew Cooper wrote:
> > This type predates recorded history in tglx/history.git, making it older
> > than Feb 5th 2002.
> > 
> > This structure is literally old enough to drink in most juristictions in
> > the world, and has not been used once in that time.
> > 
> > Lay it to rest in /dev/null.
> > 
> > Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> > ---
> > There is perhaps something to be said for the longevity of the comment.
> > "Not terribly well tested" certainly hasn't bitrotted in all this time.
> 
>    :-)  !!!
> 
> Reveiewed-by: Steve Wahl <steve.wahl@hpe.com>

There's a typo in your tag (and it was copy-pasted to all patches of this
series).

-- 
 i.

