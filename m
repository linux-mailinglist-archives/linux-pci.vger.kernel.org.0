Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93909692583
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjBJSmE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 13:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjBJSmB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 13:42:01 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5469C241D3
        for <linux-pci@vger.kernel.org>; Fri, 10 Feb 2023 10:41:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d8so6165769plr.10
        for <linux-pci@vger.kernel.org>; Fri, 10 Feb 2023 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ok45EUB5a0lrC1G1VBEVIJghKeOSx8dIT5YrcpXaZ2U=;
        b=GgjbQSZy1IdPTox+nR5ZLWTTXO7nzY/UMimwyDKci+qHnDHiXVnPsr/YKUeoxdwuCF
         zRyXiMSJLLFbPedh2Ek6TS5A4Tp5q9b4CKjWwJ8AWSfUOkzWDDf0i4Wsuvxw7WcBNMwX
         yBPsHXrxMECfexaRc6rBcBK8ib7PFOK5jxBmM3Bj/mLNrFrkHfQPotqyXTQ83lRqcGpH
         Wgb8FDbkydZZgOKI95IsGhjydWszVFbReaoR+JgIwemL3x7hLv25HLQ9iA3PxJqAsswF
         7gMIiQi7gtC8Zf/qPhn88buWnIrBU+9LuQqHhogX1qcG2uorcOYPD9koLiIuNrvumYBx
         wNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok45EUB5a0lrC1G1VBEVIJghKeOSx8dIT5YrcpXaZ2U=;
        b=y7xVf0L/YbU2Jjkt8W0mm24NRkFwk5eqAk85inu1424S0MVB+UEeQt2AERLVsbujyt
         E01wZvmLetcWWUnjjliL3NNaWCqKSysJZGht5gtgYAXmZz/Rt5RcFZ06uNjNK0HMnv4y
         BLHt8ZNz8XY9gBCVKwHZUDR+nanMnVCjNSpSEFWEEDvLhz19+1OTUHwUUKUyLxQkKb1F
         TcndJt9rELYLCX84fmuDFBg7IfyO48omb82dTC1C9hkl1pwcAy0q8I9+loj/3zNYi62g
         6+eWZKDfBfXO7PwNqEhs/887vD8XtlcQ4OpgOS27QPCiQNZ20mIGHuhpAupTrViTQofk
         fvHg==
X-Gm-Message-State: AO0yUKVxCQdQ+q1ThbexOgq5MFVrGm1gWq7X8KRg0UCicyc3jz+8OWL9
        DFVATyFZ+X+e+NKOqilyZovLjw==
X-Google-Smtp-Source: AK7set93DJYG63ys9SOctBQRI7ddeFJlbzAb9UdgGVNbO8ool9VJU4UwhLQF6yN0q5ReGJyClZ0xtg==
X-Received: by 2002:a17:902:e551:b0:19a:6cd2:a658 with SMTP id n17-20020a170902e55100b0019a6cd2a658mr234114plf.7.1676054518244;
        Fri, 10 Feb 2023 10:41:58 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b00199190b00efsm3701641pld.97.2023.02.10.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:41:57 -0800 (PST)
Date:   Fri, 10 Feb 2023 18:41:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v5 06/14] x86/ioremap: Support hypervisor specified range
 to map as encrypted
Message-ID: <Y+aP8rHr6H3LIf/c@google.com>
References: <1673559753-94403-1-git-send-email-mikelley@microsoft.com>
 <1673559753-94403-7-git-send-email-mikelley@microsoft.com>
 <Y8r2TjW/R3jymmqT@zn.tnic>
 <BYAPR21MB168897DBA98E91B72B4087E1D7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y9FC7Dpzr5Uge/Mi@zn.tnic>
 <BYAPR21MB16883BB6178DDEEA10FD1F1CD7D69@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+JG9+zdSwZlz6FU@zn.tnic>
 <4216dea6-d899-aecb-2207-caa2ae7db0e3@intel.com>
 <BYAPR21MB16886D92828BA2CA8D47FEA4D7D99@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16886D92828BA2CA8D47FEA4D7D99@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Wearing my KVM hat and not my Google hat...

On Thu, Feb 09, 2023, Michael Kelley (LINUX) wrote:
> From: Dave Hansen <dave.hansen@intel.com> Sent: Wednesday, February 8, 2023 9:24 AM
> > 
> > On 2/7/23 04:41, Borislav Petkov wrote:
> > > Or are there no similar TDX solutions planned where the guest runs
> > > unmodified and under a paravisor?
> > 
> > I actually don't think paravisors make *ANY* sense for Linux.

I 100% agree, but Intel made what I think almost entirely irrelevant by refusing
to allow third party code to run in SEAM.

> > If you have to modify the guest, then just modify it to talk to the
> > hypervisor directly.  This code is... modifying the guest.  What does
> > putting a paravisor in the middle do for you?
> 
> One of the original goals of the paravisor was to make fewer
> modifications to the guest, especially in areas that aren't directly related
> to the hypervisor.  It's arguable as to whether that goal played out in
> reality.
> 
> But another significant goal is to be able to move some device emulation
> from the hypervisor/VMM to the guest context.  In a CoCo VM, this move
> is from outside the TCB to inside the TCB.  A great example is a virtual
> TPM.  Per the CoCo VM threat model, a guest can't rely on a vTPM
> provided by the host.

I vehemently disagree with this assertion.  It's kinda sorta true, but only
because Intel and AMD have gone down the road of not providing the mechanisms and
ability for the hypervisor to run and attest to the integrity, functionality, etc.
of (a subset of) the hypervisor's own code.

Taking SEAM/TDX as an example, if the code running in SEAM were an extension of
KVM instead of a hypervisor-agnostic nanny, then there would be no need for a
"paravisor" to provide a vTPM.  It would be very feasible to teach the SEAM-protected
bits of KVM to forward vTPM accesses to a host-provided, signed, attested, and open
source software running in a helper TD.

I fully realize you meant "untrusted host", but statements like "the host can't
be trusted" subconciously reinforce the, IMO, flawed model of hardware vendors
and _only_ hardware vendors providing the trusted bits.

The idea that firmware/software written by hardware vendors is somehow more
trustworthy than fully open source software is simultaneously laughable and
infuriating.  

Anyways, tying things back to the actual code being discussed, I vote against
CC_ATTR_PARAVISOR.  Being able to trust device emulation is not unique to a
paravisor.  A single flag also makes too many assumptions about what is trusted
and thus should be accessed encrypted.
