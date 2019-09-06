Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05095AB7EA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391877AbfIFMOk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 08:14:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731749AbfIFMOk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Sep 2019 08:14:40 -0400
Received: from zn.tnic (p200300EC2F0B9E00346CD1FB7E5FDCD3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9e00:346c:d1fb:7e5f:dcd3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CC9B1EC094F;
        Fri,  6 Sep 2019 14:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567772078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=79EBy9AeBqq6L1WBzZT+FwMS331T0dhBIGN6GbLK7u4=;
        b=kg//2/D0gfxWhUJsz0z3oIPbAEW7XcH8M/If/6OEtPSaAQSVXEo+YuyIfGag/IfCcedk+P
        RtiArw6ot7IyZ+YlFDR6x4upxdlJj7MnryLR+wnhclAU1HB1llD/gtAj83X8ybeKaqrBul
        xko8qqqTgW6mRNPfy7V5Rp06wfk2iWA=
Date:   Fri, 6 Sep 2019 14:14:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
Message-ID: <20190906121431.GC19008@zn.tnic>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190904215308.GA12374@zn.tnic>
 <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905070917.GA19246@zn.tnic>
 <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905135408.GE19246@zn.tnic>
 <20190905215650.f8b5d22b625ddcff7d093883@knights.ucf.edu>
 <20190906091250.GB19008@zn.tnic>
 <20190906075729.9e2faf7147da62fc26006833@knights.ucf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906075729.9e2faf7147da62fc26006833@knights.ucf.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 11:57:35AM +0000, Isaac Vaughn wrote:
> Will do, thanks.

And, when you reply to mails, please press "Reply-to-all" in your mail
client and do not do private mails. There's a reason there's a Cc list.
Readding them.

> I built my patch on both 5.3.0rc7 and master, and have tested and
> am currently running it on 5.3.0rc7. Which tag are you building
> on? I suspect there is a version mismatch since ".dbam_to_cs =
> f17_base_addr_to_cs_size" is on line 2262 for me and a recursive grep
> of the entire returned no results for "f17_addr_mask_to_cs_size".

Ah, yes, you couldn't have known that, lemme explain.

So almost all maintainers have one or more branches which contain the
work scheduled to go to Linus in the next merge window and that work is
being merged on a daily basis into  linux-next.

The EDAC branch which has that is edac-for-next in the repo

git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git

Please use that one to base your patch on.

That branch also has a previous patch which does this:

-static int f17_base_addr_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,

which explains the failure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
