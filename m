Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3568E14B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjBGTdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 14:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjBGTdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 14:33:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFEF3D901;
        Tue,  7 Feb 2023 11:33:22 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02F3E1EC06BD;
        Tue,  7 Feb 2023 20:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675798401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oYLuo9jUifMe3lnoQ0WIp7a8bQkqHF8ykphkWYEpKoY=;
        b=HlNWU/Accx4a99AAYULXuPjW97P+5JhZoBTwONbb5omgzimU+c/wocoM+ucRNVdavxHgSE
        Guj9N9BUiP5qBw5m/aMMo6Smm/NxL6dLwcTszI+hOCzVqsZ3p8PhhPD5ZgBQPwNPXattD1
        O1Z7vhClvTXzjQBY64mrhsh4VWqipbo=
Date:   Tue, 7 Feb 2023 20:33:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
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
        "seanjc@google.com" <seanjc@google.com>,
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
Message-ID: <Y+KndbrS1/1i0IFd@zn.tnic>
References: <1673559753-94403-1-git-send-email-mikelley@microsoft.com>
 <1673559753-94403-7-git-send-email-mikelley@microsoft.com>
 <Y8r2TjW/R3jymmqT@zn.tnic>
 <BYAPR21MB168897DBA98E91B72B4087E1D7CA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y9FC7Dpzr5Uge/Mi@zn.tnic>
 <BYAPR21MB16883BB6178DDEEA10FD1F1CD7D69@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+JG9+zdSwZlz6FU@zn.tnic>
 <BYAPR21MB1688A80B91CC4957D938191ED7DB9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688A80B91CC4957D938191ED7DB9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 07, 2023 at 07:01:25PM +0000, Michael Kelley (LINUX) wrote:
> Unless there are objections, I'll go with CC_ATTR_PARAVISOR_DEVICES,

What does "DEVICES" mean in this context?

You need to think about !virt people too who are already confused by the
word "paravisor". :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
