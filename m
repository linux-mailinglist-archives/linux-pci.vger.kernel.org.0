Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC205A8C1A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 05:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbiIADx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 23:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiIADx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 23:53:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB1D110887;
        Wed, 31 Aug 2022 20:53:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJ6bm4QHPz4xFv;
        Thu,  1 Sep 2022 13:53:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662004436;
        bh=ZIFUnm/QOVgs4khUf+2xFOsp57QlqBfQutIPzPII32Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IpCATWbm1lkj72SyfOeWdRXfACjSZgkAouDM/JnI2Hl3LN2n6VjCbvFNL8g7qGIEL
         M14U3clPm6so4DXJuekT/1U59h7Vva8hwMbJgzEG77iy0thgeC0ciPakp1b5r5DGk+
         qnnhE/mj1Hk/FuW18IWmnCOBk/CLNpNMqtrSCo5wN8cFZIKRA3nsoN9Q28WZut5eos
         A2BWQa1QYxS13fhV1DAcxo6fHIMQOhXnmDPLzRpTh+UAovxjXsCqQtaSEUH/xznvO/
         yjoNkWbUUoKgZiqLJ52Jnu69QuthgAkP5MBUhfkqIgNQx4oAdeIM+73tIjvhzazDA1
         s2ZVKHL/E9oow==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pci: Enable PCI domains in /proc when PCI bus
 numbers are not unique
In-Reply-To: <20220825083713.4glfivegmodluiun@pali>
References: <20220820115113.30581-1-pali@kernel.org>
 <878rnclq47.fsf@mpe.ellerman.id.au> <20220825083713.4glfivegmodluiun@pali>
Date:   Thu, 01 Sep 2022 13:53:56 +1000
Message-ID: <87wnanu4vf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> On Thursday 25 August 2022 17:49:28 Michael Ellerman wrote:
>> Pali Roh=C3=A1r <pali@kernel.org> writes:
>> > On 32-bit powerpc systems with more PCIe controllers and more PCI doma=
ins,
>> > where on more PCI domains are same PCI numbers, when kernel is compiled
>> > with CONFIG_PROC_FS=3Dy and CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT=3Dy
>> > options, kernel prints "proc_dir_entry 'pci/01' already registered" er=
ror
>> > message.
>>=20
>> Thanks, I'll pick this up.
>>=20
>> > This regression started appearing after commit 566356813082 ("powerpc/=
pci:
>> > Add config option for using all 256 PCI buses") in case in each mPCIe =
slot
>> > is connected PCIe card and therefore PCI bus 1 is populated in for eve=
ry
>> > PCIe controller / PCI domain.
>> >
>> > The reason is that PCI procfs code expects that when PCI bus numbers a=
re
>> > not unique across all PCI domains, function pci_proc_domain() returns =
true
>> > for domain dependent buses.
>> >
>> > Fix this issue by setting PCI_ENABLE_PROC_DOMAINS and PCI_COMPAT_DOMAI=
N_0
>> > flags for 32-bit powerpc code when CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPEN=
DENT
>> > is enabled. Same approach is already implemented for 64-bit powerpc co=
de
>> > (where PCI bus numbers are always domain dependent).
>>=20
>> We also have the same in ppc4xx_pci_find_bridges().
>>=20
>> And if we can eventually make CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT
>> the standard behaviour on 32-bit then everything would behave the same
>> and we could simplify pci_proc_domain() to match what other arches do.
>
> I sent two patches which do another steps to achieve it:
> https://lore.kernel.org/linuxppc-dev/20220817163927.24453-1-pali@kernel.o=
rg/t/#u
>
> Main blocker is pci-OF-bus-map which is in direct conflict with
> CONFIG_PPC_PCI_BUS_NUM_DOMAIN_DEPENDENT and which used on chrp and pmac.
> And I have no idea if pci-OF-bus-map is still needed or not.

Yeah thanks, I saw those patches.

I can't find any code that refers to pci-OF-bus-map, so I'm inclined to
remove it entirely.

But I'll do some more searching to see if I can find any references to
it in old code.

cheers
