Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB857086E6
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjERR3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjERR3Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 13:29:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E510F8;
        Thu, 18 May 2023 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684430940; x=1715966940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YbB0ITNWC6W+DKq+pyGIH80h6yd4xEjccS7jew/3CTQ=;
  b=LvgOCBPppG56F7c62H+OqHCOLayG5MSgAP7pjnVJmAVRoe8ymVZg/7HW
   OXdAsRuXNnXbphEGwy8OLEdPFt9UCpjQGWIrgNAkTK1a/tUVuU3PaKppv
   KR5rTNtDJxYikVk6lOHp2cenrRpo4rXwTbkyHjNo2IfmXaa28VQ57vZeo
   7vJh3lq5M9L95dDhKwdf7StfZZD/8FscmggqN0QcYHRhWbCn12XX4l0tE
   0lsvmtuiY2BkHOkiTmpL9edIjlLbi5JyeEHFlfej4k82yLkTeQozm6BZl
   jfVslEHNeLHTKFXBiJbgwtiZw6BIOgdqnqwS0a+IbABS/M87FTFp8vnq9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354474558"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="354474558"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="702214993"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="702214993"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.209.81.123]) ([10.209.81.123])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:28:58 -0700
Message-ID: <cabdd839-71d5-aabb-aee6-d37ebcabf2ab@intel.com>
Date:   Thu, 18 May 2023 10:28:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 10/20] x86: xen: add missing prototypes
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
 <20230516193549.544673-11-arnd@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230516193549.544673-11-arnd@kernel.org>
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
> arch/x86/xen/enlighten_pv.c:1233:34: error: no previous prototype for 'xen_start_kernel' [-Werror=missing-prototypes]
> arch/x86/xen/irq.c:22:14: error: no previous prototype for 'xen_force_evtchn_callback' [-Werror=missing-prototypes]
> arch/x86/xen/mmu_pv.c:358:20: error: no previous prototype for 'xen_pte_val' [-Werror=missing-prototypes]
> arch/x86/xen/mmu_pv.c:366:20: error: no previous prototype for 'xen_pgd_val' [-Werror=missing-prototypes]

What's the deal with this one?

The patch is doing a bunch functions on top of the ones from the commit
message.  Were you just showing a snippet of what the actual set of
warnings is?

Also, fwiw, it would be nice to have actual words in the changelog, even
for these maddeningly repetitive series.  Even something like:

	Xen has a bunch of these because of how the paravirt code uses
	inline assembly.
