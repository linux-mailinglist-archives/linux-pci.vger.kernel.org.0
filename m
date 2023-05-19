Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756857095EF
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjESLFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjESLFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 07:05:47 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3021988;
        Fri, 19 May 2023 04:05:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 888FD5C018C;
        Fri, 19 May 2023 07:04:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 May 2023 07:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684494265; x=1684580665; bh=/C
        wla6Z93CmdqEZ213cheaHU/C7xFoaUH7cr2bjxpHQ=; b=fgD3+fClg58VBaUs//
        zaPCHvCJP5VwPquLsJQCejG585X4z+0cgq8+PVQLQhfsm5YWTZtpvK/KaaglSt4v
        AZlDlbvGF3uoZD3fC2SSE25eKMeiJ6Wom5J1YcG2GkUcncWYRhxQyk68GPcM/VQp
        34Ei3ImxNpBRwXdc9tym77ZcH2TZYznA5nJLd0dV2c5Gry+glxktVg9gmMI9439a
        f3L5sFm8wopBNd1vAmNNyXTneaLVTBRRVuEaIadcCeApET3YIvFnFJalDw9tA0h/
        2TZol3iqiGR+i22jK3aoA3M0ZmXVLJnvyzijOnDj+ydVHvdZRUx6GiucYtjtNpoN
        JBTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684494265; x=1684580665; bh=/Cwla6Z93Cmdq
        EZ213cheaHU/C7xFoaUH7cr2bjxpHQ=; b=dFs0aALapqY2/RKBVBoRgsFC+kwwn
        aghUbwauR7c1rX0XPL5DOBgegPR2+r/bkGNCHfJxUzqFkNmnzE8s/4FBbZi5lUoP
        nAOFrE15xfCXbV5De8PpVHEPPQaEzx07LPV8M2YiUR692Ae414HT9CDIPsp6/adS
        ri78lMwnrM8+0M82lszLmKjmmPSM5wfqXIhxwrHo/HhPJmcwFpyMcgcL4OhJuOKD
        iQ+iy6dLE5E+W30aMejTZcd8FnCpaTSh3UIXb6IRU53VnkL0NvNyaDJ3yMEEg3jy
        Amhm2R5vJ7t1jx6KTPd6J1GyNs70g8SgYMjfUjxhve2s0eAY/TVDwYw5g==
X-ME-Sender: <xms:t1dnZJJPaJ2g_2nxuUp5GipLJ04nJ7R8n701jCM3WJMdOGe7-3CtvQ>
    <xme:t1dnZFIpdftyeukP7ox0wWnWvdRtWV5S4-6mNAnBSP0uR5dlSKF5AEHwrDn2R_GBj
    PS_1pR-COVEJwI7y-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:t1dnZBuc-n5XDtHdGoa_Vunbhz_oDVhyhorHNRW0yPyAxt_gejgLQg>
    <xmx:t1dnZKYlvNBeT1qmqCedxwoaVPlHQKmXv30SdUKAdaGMxpMsm1ja6g>
    <xmx:t1dnZAbwOs_Q1raPox-9GKEVt3JVUpAGWNgWD_H68sPb8ESiQXlXfg>
    <xmx:uVdnZLvOcIo3POIIQLS4ujcc4StrWhcyu6DRLzy0SJ32ArlhSgUt0g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A414B60089; Fri, 19 May 2023 07:04:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <1f771dae-1bc7-4fd3-8514-613cf3b12e1a@app.fastmail.com>
In-Reply-To: <cabdd839-71d5-aabb-aee6-d37ebcabf2ab@intel.com>
References: <20230516193549.544673-1-arnd@kernel.org>
 <20230516193549.544673-11-arnd@kernel.org>
 <cabdd839-71d5-aabb-aee6-d37ebcabf2ab@intel.com>
Date:   Fri, 19 May 2023 13:04:03 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>, x86@kernel.org
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        "Alexey Makhalov" <amakhalov@vmware.com>,
        "VMware PV-Drivers Reviewers" <pv-drivers@vmware.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Darren Hart" <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 10/20] x86: xen: add missing prototypes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 18, 2023, at 19:28, Dave Hansen wrote:
> On 5/16/23 12:35, Arnd Bergmann wrote:
>> 
>> arch/x86/xen/enlighten_pv.c:1233:34: error: no previous prototype for 'xen_start_kernel' [-Werror=missing-prototypes]
>> arch/x86/xen/irq.c:22:14: error: no previous prototype for 'xen_force_evtchn_callback' [-Werror=missing-prototypes]
>> arch/x86/xen/mmu_pv.c:358:20: error: no previous prototype for 'xen_pte_val' [-Werror=missing-prototypes]
>> arch/x86/xen/mmu_pv.c:366:20: error: no previous prototype for 'xen_pgd_val' [-Werror=missing-prototypes]
>
> What's the deal with this one?
>
> The patch is doing a bunch functions on top of the ones from the commit
> message.  Were you just showing a snippet of what the actual set of
> warnings is?

I missed this one going through the changelogs before sending them out,
I thought I had added a proper text to each one, but it fell through the
cracks. I've followed up with a v2 patch that has a proper changelog
now.

      Arnd
