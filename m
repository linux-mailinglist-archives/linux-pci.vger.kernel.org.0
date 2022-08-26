Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B895A210B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 08:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbiHZGpa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245102AbiHZGpa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 02:45:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC6BA61E3
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 23:45:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MDVhQ0WRSz4x1G;
        Fri, 26 Aug 2022 16:45:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1661496326;
        bh=YdTNamzH/TUdshV3Q5FUH2pPsMLKLln71bBuYe/qFtg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q+KGV/ycNrADBH4LtYQiCFy43yiKKEdbNSPJ8gHUbo6GGHkxFOpbzE4TJrCaqmC13
         H7bYhRtpxdEHnQek3eNQvEQS32ymT4MpgrpavEL6E7osVTmjdCft6H3FUun39BKdx8
         2rHMmRAn/VK7geoGcLglOYyhbY2Da6d+AFDF0jRyhiT5kaPGUdYCPdps7NzCBrZHn6
         LGP5H0MBWF8m/8dSsnAQcep41RnVDhIr9X4QPIiyJuKRjqucVLzM34cMkRBxlA1kAu
         wuNTp59e8G3u11QNGCic8wcE9hmDAQYnlCFx9vQ5f2wyJKi+B59XpDbcVSMKL3kr/e
         QQGJA81xbruHQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Russell Currey <ruscur@russell.cc>, oohall@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove myself as EEH maintainer
In-Reply-To: <20220825200310.GA2869783@bhelgaas>
References: <20220825200310.GA2869783@bhelgaas>
Date:   Fri, 26 Aug 2022 16:45:22 +1000
Message-ID: <87tu5zjyf1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Sat, Aug 20, 2022 at 10:17:41AM +1000, Michael Ellerman wrote:
>> Bjorn Helgaas <helgaas@kernel.org> writes:
>> > On Sat, Aug 06, 2022 at 06:53:01PM +1000, Russell Currey wrote:
>> >> I haven't touched EEH in a long time I don't have much knowledge of the
>> >> subsystem at this point either, so it's misleading to have me as a
>> >> maintainer.
>> >> 
>> >> I remain grateful to Oliver for picking up my slack over the years.
>> >> 
>> >> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> >> ---
>> >>  MAINTAINERS | 1 -
>> >>  1 file changed, 1 deletion(-)
>> >> 
>> >> diff --git a/MAINTAINERS b/MAINTAINERS
>> >> index a9f77648c107..dfe6081fa0b3 100644
>> >> --- a/MAINTAINERS
>> >> +++ b/MAINTAINERS
>> >> @@ -15639,7 +15639,6 @@ F:	drivers/pci/endpoint/
>> >>  F:	tools/pci/
>> >>  
>> >>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
>> >> -M:	Russell Currey <ruscur@russell.cc>
>> >>  M:	Oliver O'Halloran <oohall@gmail.com>
>> >>  L:	linuxppc-dev@lists.ozlabs.org
>> >>  S:	Supported
>> >
>> > I was thinking along these lines, but if you want to take this,
>> > Michael, I'll drop it:
>> 
>> Hi Bjorn,
>> 
>> I was hoping one of the protagonists would send a patch :), but that
>> looks perfect.
>
> Waiting for that patch would have been the *smart* thing to do, but I
> added your ack and put it on for-linus for v6.0.  Thanks!

:) Thanks.

cheers
