Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51B277F0AF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 08:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbjHQGpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 02:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348304AbjHQGom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 02:44:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EC52705;
        Wed, 16 Aug 2023 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692254679;
        bh=Wx3nMILiB1NeGS4OwS92O58JvJol6RuBMilPby1aexs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pz9ElAbaHeW1WlM6FirXgpjKbRPGtcW5zyN9pjls0kdL5arkLwqzNAVC2PRn8qBwa
         H7IIeZkTzubrcVySUgmaLN+TVRI99448w/43xEZmkedXGjwkQqUrLNaZmEExYUZ3Bm
         XYqMrfLSaC1FaZ8/j+tbrK639d5HhNFaWXxueq9xAh/P7BTLPTGv/ijFYQk9ork8Cb
         7zE2UxOOMfQgPJPLpx84Pc0eVfEe3/KQ1eFlSzHg8H0DaTxISTWpBmNsNlo6kT5kM5
         tD6xpCigM1TCzd9uFuB1hn9Zb+Zagh9PO32Di7yumRtEJRKfvGIKl80K3hYIMqRr7g
         AGomz3KsKnWEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRFqC2jtTz4wZn;
        Thu, 17 Aug 2023 16:44:39 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     mahesh@linux.ibm.com
Cc:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] powerpc/rtas: Rename rtas_error_rc to
 rtas_generic_errno
In-Reply-To: <xzsx7qc3el674iyy2lsn3adm7j2vh5xj6cjaqxgjm6lwcjiz5u@evoqbrvhqf26>
References: <169138864808.65607.6576358707894823512.stgit@jupiter>
 <877cpxdksx.fsf@mail.lhotse>
 <xzsx7qc3el674iyy2lsn3adm7j2vh5xj6cjaqxgjm6lwcjiz5u@evoqbrvhqf26>
Date:   Thu, 17 Aug 2023 16:44:38 +1000
Message-ID: <87zg2q5fs9.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mahesh J Salgaonkar <mahesh@linux.ibm.com> writes:
> On 2023-08-15 13:52:14 Tue, Michael Ellerman wrote:
>> Mahesh Salgaonkar <mahesh@linux.ibm.com> writes:
...
>> > diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
>> > index 3abe15ac79db1..5572a0a2f6e18 100644
>> > --- a/arch/powerpc/include/asm/rtas.h
>> > +++ b/arch/powerpc/include/asm/rtas.h
>> > @@ -202,7 +202,9 @@ typedef struct {
>> >  #define RTAS_USER_REGION_SIZE (64 * 1024)
>> >  
>> >  /* RTAS return status codes */
>> > -#define RTAS_BUSY		-2    /* RTAS Busy */
>> > +#define RTAS_HARDWARE_ERROR	(-1)  /* Hardware Error */
>> > +#define RTAS_BUSY		(-2)  /* RTAS Busy */
>> 
>> Are the brackets necessary?
>
> During v5 changset I received offline review comment to add brackets,
> hence continued here as well. I can take it away if Nathan is fine with
> it.

OK. I can't think of a context where the brackets are useful, but I'm
probably just not thinking hard enough. I don't really mind adding them,
I was just curious what the justification for them was.

cheers
