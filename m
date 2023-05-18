Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767F3708ADA
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjERV4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 17:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjERV4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 17:56:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FFE7;
        Thu, 18 May 2023 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684447014; x=1715983014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TfncyPoLkgEVKt4cWoEjhnDcsRhR4hVCsiDKfdnguT0=;
  b=ilTUs+AtIeT5pna9Vt4ARWCoTY3z1q30bi1ndDsBKZNtZhDoy8KIdvnX
   PeTUtmSWu0tijJHhU3XmszAlr9H3oAr1NsYl5ShbcGolL6mQdtXR7yoIl
   V3B6IoRGw5FjLcsbMqPc/WSPdXRQZF0ba3QYkfwGrcStlGdSYAzGBzaaU
   3atKU/JCvdWNPg7Di6oxaZ1Li743mjYZnGk7V+69cUEiuPBpd4OE1/6iY
   AbCD+nGgvODVpmWNrL1GNADv7+32VRhJKK28YRWq8slCwW3Zc8ANSyRL5
   O2ZSpBEPSXqWdQMk1fwFSk6ltOo4ihP63pRM6M/UonYIgnoOjoheTJsUQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354550228"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="354550228"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 14:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="948852100"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="948852100"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.209.81.123]) ([10.209.81.123])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 14:56:52 -0700
Message-ID: <a78d9dcd-0bc1-7e98-a8f1-e5d6cd0c09a3@intel.com>
Date:   Thu, 18 May 2023 14:56:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/20] x86: address -Wmissing-prototype warnings
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
References: <20230516193549.544673-1-arnd@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230516193549.544673-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/16/23 12:35, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This addresses all x86 specific prototype warnings. The majority of the
> patches should be straightforward, either adding an #include statement
> to get the right header, or ensuring that an unused global function is
> left out of the build when the prototype is hidden.
> 
> The ones that are a bit awkward are those that just add a prototype to
> shut up the warning, but the prototypes are never used for calling the
> function because the only caller is in assembler code. I tried to come up
> with other ways to shut up the compiler using the asmlinkage annotation,
> but with no success.
> 
> All of the warnings have to be addressed in some form before the warning
> can be enabled by default.

I picked up the ones that were blatantly obvious, but left out 03, 04,
10, 12 and 19 for the moment.

BTW, I think the i386 allyesconfig is getting pretty lightly tested
these days.  I think you and I hit the same mlx4 __bad_copy_from()
compile issue.
