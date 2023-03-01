Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E896A71EA
	for <lists+linux-pci@lfdr.de>; Wed,  1 Mar 2023 18:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCARRT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 12:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCARRT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 12:17:19 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235D3B0E0;
        Wed,  1 Mar 2023 09:17:17 -0800 (PST)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 321HGuBv1145373
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 1 Mar 2023 09:16:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 321HGuBv1145373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023020601; t=1677691018;
        bh=5hNMK+tD8odHiA4uw42+cFXxmyDl1DpNIg8KWnkmi/U=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=trCFRYsdzMYc/K/gmsizn5jQdX3cbZ4Ww+6mVEZMHLW7d20BO9/r0pDrk8gCzsmCM
         xWQUUvYUeGMXqNCOeXKefDHbI0c8nK0JRNLoFvbEIhpM9CUYCZdri1bPOn4EqZLp7u
         yTexpznb1m5XGbycQiDUqJQJ6RRdbGw3Y8EkK33b9YAQQg7aABgnIUsfetcE6Bymv9
         +jSrSEUea7tffR7JVNUuZj2G3Nc7LdKfVh3/Uhz15A920t7bN7KvFtSbbKTe8fZFk8
         +pQYuQ6yFpQ9e+PYj2r7HjhuKTXpEIokVjqLfztOcwhHrq21CdmlBEEa+sm9IPdshu
         w5Qng9njILPqA==
Date:   Wed, 01 Mar 2023 09:16:54 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
CC:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPING=5E3=5D=5BRESEND=5E3=5D=5BPAT?= =?US-ASCII?Q?CH_v3=5D_x86/PCI=3A_Add_support?= =?US-ASCII?Q?_for_the_Intel_82378ZB/82379AB_=28SIO/SIO=2EA=29_PIRQ_router?=
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.2303011311540.57556@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301081956290.65308@angie.orcam.me.uk> <alpine.DEB.2.21.2303011311540.57556@angie.orcam.me.uk>
Message-ID: <66DC3D77-91AC-4F1B-BE3E-892A9B9980BC@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On March 1, 2023 5:14:59 AM PST, "Maciej W=2E Rozycki" <macro@orcam=2Eme=2E=
uk> wrote:
>On Sun, 8 Jan 2023, Maciej W=2E Rozycki wrote:
>
>> The Intel 82378ZB System I/O (SIO) and 82379AB System I/O APIC (SIO=2EA=
)=20
>> ISA bridges implement PCI interrupt steering with a PIRQ router[1][2]=
=20
>> that is exactly the same as that of the PIIX and ICH southbridges (or=
=20
>> actually the other way round, given that the SIO ASIC was there first)=
=2E
>
> Ping for:
><https://lore=2Ekernel=2Eorg/lkml/alpine=2EDEB=2E2=2E21=2E2301081956290=
=2E65308@angie=2Eorcam=2Eme=2Euk/>=2E
>
> I think the patch is fairly obvious=2E  Are there any outstanding concer=
ns=20
>that prevent it from being applied?
>
>  Maciej
>

Has this patch been actually tested on a real machine, or is it purely the=
oretical?
