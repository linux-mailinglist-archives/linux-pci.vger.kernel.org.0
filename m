Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236AD5709CD
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiGKSUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 14:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiGKSUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 14:20:08 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D92B253;
        Mon, 11 Jul 2022 11:19:57 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 26BIIgkM2907643
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 11 Jul 2022 11:18:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 26BIIgkM2907643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022070501; t=1657563523;
        bh=rYKyoAm9NejlFDvavPBi1oFgoBtFXul3PFuCTQGr00o=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=XVu0jzhzb3sa1+Tk1eSDhp1f9Ih+66yhKoEMGdbiomtlRtc2H2bXTCHF+NbJmwLtv
         Dc5/eQ5woSW8F/g976bAom6bW17uz64dD3EZ912zm45VBwOG/ARzcpJBJgyJb5BShm
         yPgkJ436+n7uucNCRW6bt3f2sElS9Uyrq9wrwTBpdeJ4kZxVIE3hBFcpJTK42UvogE
         q9l8w4bMDrYJJHXcgnjs2lbCGo796/G/NvKXjFO1Ru7zoBbSRJVPy9Z2ceCfU7WrJQ
         F2b5Gb1bhrWLkCP74M1aDWpaAyXSQQZF7b1mCeuvevgyPfoVcMFmhsaJn1SbtB3yh8
         9SHeIY2tDDxDw==
Date:   Mon, 11 Jul 2022 11:18:40 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ajay Kaher <akaher@vmware.com>, Nadav Amit <namit@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Anish Swaminathan <anishs@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] MMIO should have more priority then IO
User-Agent: K-9 Mail for Android
In-Reply-To: <F9E62470-71EA-40DD-875C-6B2B1831F3ED@vmware.com>
References: <1656433761-9163-1-git-send-email-akaher@vmware.com> <20220628180919.GA1850423@bhelgaas> <25F843ED-7EB4-4D00-96CB-7DE1AC886460@vmware.com> <YsgplrrJnk5Ly19z@casper.infradead.org> <96D533E5-F3AF-4062-B095-8C143C307E37@vmware.com> <YshvnodeqmJV6uIJ@casper.infradead.org> <1A0FA5B7-39E8-4CAE-90DD-E260937F14E1@vmware.com> <Ysh63kRVGMFJMNfG@casper.infradead.org> <85071FE5-E37A-44CF-9EF7-CB80C116A876@vmware.com> <4E0E503E-64E1-4B0A-B96A-0CD554A67107@vmware.com> <83C436BD-E12E-420C-B651-B3788F1C4683@vmware.com> <F9E62470-71EA-40DD-875C-6B2B1831F3ED@vmware.com>
Message-ID: <058DA908-87F7-438E-9850-9CD9DCCFD928@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On July 11, 2022 10:53:54 AM PDT, Ajay Kaher <akaher@vmware=2Ecom> wrote:
>
>=EF=BB=BFOn 11/07/22, 10:34 PM, "Nadav Amit" <namit@vmware=2Ecom> wrote:
>
>> On Jul 10, 2022, at 11:31 PM, Ajay Kaher <akaher@vmware=2Ecom> wrote:
>>
>> During boot-time there are many PCI reads=2E Currently, when these read=
s are
>> performed by a virtual machine, they all cause a VM-exit, and therefore=
 each
>> one of them induces a considerable overhead=2E
>>
>> When using MMIO (but not PIO), it is possible to map the PCI BARs of th=
e
>> virtual machine to some memory area that holds the values that the =E2=
=80=9Cemulated
>> hardware=E2=80=9D is supposed to return=2E The memory region is mapped =
as "read-only=E2=80=9D
>> in the NPT/EPT, so reads from these BAR regions would be treated as reg=
ular
>> memory reads=2E Writes would still be trapped and emulated by the hyper=
visor=2E
>
>I guess some typo mistake in above paragraph, it's per-device PCI config =
space
>i=2Ee=2E 4KB ECAM not PCI BARs=2E Please read above paragraph as:
>
>When using MMIO (but not PIO), it is possible to map the PCI config space=
 of the
>virtual machine to some memory area that holds the values that the =E2=80=
=9Cemulated
>hardware=E2=80=9D is supposed to return=2E The memory region is mapped as=
 "read-only=E2=80=9D
>in the NPT/EPT, so reads from these PCI config space would be treated as =
regular
>memory reads=2E Writes would still be trapped and emulated by the hypervi=
sor=2E
>
>We will send v2 or new patch which will be VMware specific=2E
>
>> I have a vague recollection from some similar project that I had 10 yea=
rs
>> ago that this might not work for certain emulated device registers=2E F=
or
>> instance some hardware registers, specifically those the report hardwar=
e
>> events, are =E2=80=9Cclear-on-read=E2=80=9D=2E Apparently, Ajay took th=
at into consideration=2E
>>
>> That is the reason for this quite amazing difference - several orders o=
f
>> magnitude - between the overhead that is caused by raw_pci_read(): 120u=
s for
>> PIO and 100ns for MMIO=2E Admittedly, I do not understand why PIO acces=
s would
>> take 120us (I would have expected it to be 10 times faster, at least), =
but
>> the benefit is quite clear=2E
>
>
>

For one thing, please correct the explanation=2E

It does not take "more PCI cycles" to use PIO =E2=80=93 they are exactly t=
he same, in fact=2E  The source of improvements are all in the CPU and VMM =
interfaces; on the PCI bus, they are (mostly) just address spaces=2E

"Using MMIO may allow a VMM to map a shadow memory area readonly, so read =
transactions can be executed without needing any VMEXIT at all=2E In contra=
st, PIO transactions to PCI configuration space are done through an indirec=
t address-data interface, requiring two VMEXITs per transaction regardless =
of the properties of the underlying register=2E"

You should call out exactly what is being done to prevent incorrect handli=
ng of registers with read side effects (I believe that would be all on the =
VMM side; unfortunately the presence of a register with read side effects p=
robably would mean losing this optimization for the entire 4K page =3D this=
 entire function, but read side effects have always been discouraged althou=
gh not prohibited in config space=2E)
