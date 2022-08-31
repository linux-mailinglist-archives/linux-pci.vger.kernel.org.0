Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23235A884C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiHaVol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHaVok (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 17:44:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37664DDB78;
        Wed, 31 Aug 2022 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kIg3AH4362vCOzZwffSIGEmUFZF1IIXCakf1Rr4tLS4=; b=L5ygStRs692GtLlVW/KJR8EgnS
        9S0Dp9k2vpoF9Hy28acYCyXbNQ2hjA4NKXoapqG2ze9wcdhNcQJgyAkM4c7HDh6fBdGYD5GsJZSGt
        A8sH7++KivwCDIF1I9Y4bmLr9WIKTihivoGdP7dUFzvMJEFZLdSgFq9FocjORMWGdZrQBo9U2ufVH
        fLsXHYNXFGU+28uUmvgVT98bkOOfP3rmsWGJTHm2w8/19J5Gsl53qvoGz8krnrWoun2J7sqpd7W/N
        nz8h1FcFoxxMD+szs2EWIs0P15dLK5XBtqDMmdvBcah0Rx6Zo3usUskETmsuYrU63F5BwcwiUTgb3
        5aMQ9Q7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTVVK-005TXB-L7; Wed, 31 Aug 2022 21:44:10 +0000
Date:   Wed, 31 Aug 2022 22:44:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Nadav Amit <namit@vmware.com>, Ajay Kaher <akaher@vmware.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH] MMIO should have more priority then IO
Message-ID: <Yw/WKo69Re0g3zLl@casper.infradead.org>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com>
 <20220628180919.GA1850423@bhelgaas>
 <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com>
 <YsgplrrJnk5Ly19z@casper.infradead.org>
 <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com>
 <YshvnodeqmJV6uIJ@casper.infradead.org>
 <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com>
 <Ysh63kRVGMFJMNfG@casper.infradead.org>
 <0fac9918-2848-d01c-ee19-96a0cfd7b370@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fac9918-2848-d01c-ee19-96a0cfd7b370@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 03:20:57PM -0600, Shuah Khan wrote:
> Hi Matthew,
> 
> On 7/8/22 12:43 PM, Matthew Wilcox wrote:
> > On Fri, Jul 08, 2022 at 06:35:48PM +0000, Nadav Amit wrote:
> > > On Jul 8, 2022, at 10:55 AM, Matthew Wilcox <willy@infradead.org> wrote:
> > > 
> > 
> > Just because I don't use your terminology, you think I have
> > "misconceptions"?  Fuck you, you condescending piece of shit.
> > 
> 
> This is clearly unacceptable and violates the Code of Conduct.

In a message I sent to this mailing list on July 8, I used language
which offended some readers.  I would like to apologise for my choice of
words.  I remain committed to fostering a community where disagreements
can be handled respectfully and will do my best to uphold these important
principles in the future.  I would like to thank the Code of Conduct
committee for their diligence in overseeing these matters.

