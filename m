Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16467086F3
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjERRcD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjERRcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 13:32:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451EAA;
        Thu, 18 May 2023 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684431105; x=1715967105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wl8BDYVG0i7AvYNjyPawAfZhnam6nIO2zxc9kJVuY98=;
  b=n6Zm4Of+BldnxQc0YUu+ASMgCbzK4g4rXyxfgtVIC2vl1JBt7SeLKpZp
   qljjuxYfoDzKXUZrlcSJ89kfZoyqK51Ah7HKlru6SrdfmQjtom26vsrmd
   TOIzyxXUW7jaHbalTuvAI6vAsv8BeJS5PSivMZqADfQvEUsb6QNBnDOmn
   4uvBcFukVBd5uvAFCcVq2wE0EnIoU/3dqyDjA8JjMO9joNPR4DkFr1JcF
   1eauAMqrJn+WNe3WKs76V6aTST7bAOz0hcGHGnpwt5bbMUA4UWBbmbijt
   NHAUWy03yZZq1VYMJzqtfeiX9N23vPt6y1+9p/oqGcJzYakYCjK6DCG81
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354475452"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="354475452"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:31:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="1032284552"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="1032284552"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.209.81.123]) ([10.209.81.123])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 10:31:17 -0700
Message-ID: <d03ef733-8098-69b7-97c2-304f1195e2a4@intel.com>
Date:   Thu, 18 May 2023 10:31:16 -0700
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
> The ones that are a bit awkward are those that just add a prototype to
> shut up the warning, but the prototypes are never used for calling the
> function because the only caller is in assembler code. I tried to come up
> with other ways to shut up the compiler using the asmlinkage annotation,
> but with no success.

I went looking for the same thing.  It's too bad gcc doesn't have an
__attribute__ for it.
