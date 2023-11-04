Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B837E10B7
	for <lists+linux-pci@lfdr.de>; Sat,  4 Nov 2023 20:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjKDTPK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Nov 2023 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjKDTPJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Nov 2023 15:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F16184;
        Sat,  4 Nov 2023 12:15:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699125305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=suKMvEgpuhoGUbP+4tESEE8+sFAwazwFRcyQQ47TAp8=;
        b=KOgUc8TBTlGJbGau9Z3d2XFNHnbaV3/Vq0rXQcaCY1aURhF/v4cyUzCFEhqp85vWoG6Joq
        0d7DpCG9dbOOtsOXddUhJMsb+1R+wzuyMusQi+4QkO57jMRvUD6kNSjtW/Pk8grk04e5Yo
        XBAQyhGOPCvApQpr4aWbnrHRJYvlFxgiZFOVAkdxFKK2VyjBtFKlgVSo35ek1DGjcrAQ72
        B7SPAhTINcQFb2kkrSjYwKjSyWWC0Ny6SEWzdpmksUvI7dsaMn9KzY/QINOMpKlv+2uCe+
        iOwpZdHAsWF0a7bAt9EvPMGgK3lunCEBGWMC0n4zA0Q+WMINT+9bfPCkLvm+/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699125305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=suKMvEgpuhoGUbP+4tESEE8+sFAwazwFRcyQQ47TAp8=;
        b=faeoCbbeppsGNw83MdHX58s8enkY0xujcI9KPXCX1T3y1dlXmZ+X/turBtJpwl5wtiYbGB
        IytHyx3J+2ajgLCg==
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Notes on BAD_APICID, Was: [PATCH 0/3] x86/apic: Misc pruning
In-Reply-To: <36462e78-8014-4415-bc47-86fbb46d028b@citrix.com>
References: <20231102-x86-apic-v1-0-bf049a2a0ed6@citrix.com>
 <36462e78-8014-4415-bc47-86fbb46d028b@citrix.com>
Date:   Sat, 04 Nov 2023 20:15:05 +0100
Message-ID: <87zfztib46.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 03 2023 at 19:58, Andrew Cooper wrote:
> On 02/11/2023 12:26 pm, Andrew Cooper wrote:
> Another dodgy construct spotted while doing this work is
>
> #ifdef CONFIG_X86_32
> =C2=A0#define BAD_APICID 0xFFu
> #else
> =C2=A0#define BAD_APICID 0xFFFFu
> #endif
>
> considering that both of those "bad" values are legal APIC IDs in an
> x2APIC system.
>
> The majority use is as a sentential (of varying types - int, u16
> mostly), although the uses for NUM_APIC_CLUSTERS, and
> safe_smp_processor_id() look suspect.
>
> In particular, safe_smp_processor_id() *will* malfunction on some legal
> CPUs, and needs to use -1 (32 bits wide) to spot the intended error case
> of a bad xAPIC mapping.
>
> However, it's use in amd_pmu_cpu_starting() from topology_die_id() looks
> broken.=C2=A0 Partly because the error handling is (only) a WARN_ON_ONCE(=
),
> and also because nb->nb_id's sentinel value is -1 of type int.
>
> I suspect there's a lot of cleaning to be done here too.

Sigh...
