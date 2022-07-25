Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A938057FEF0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiGYMYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiGYMYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 08:24:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FAD167FA;
        Mon, 25 Jul 2022 05:24:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lrzkb3ML7z4x1N;
        Mon, 25 Jul 2022 22:24:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658751879;
        bh=y+UzVL8kGSqCUz9xn5lz5WfJemKYihBdD0xz8EVTC0o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Z1DvviqPDZM3kXdh6qx5DKZLAJwkCLKRe6kMJcBt6Dgy3QOS3nKZEToJrFofWf6Be
         Dsz2gLQz+XA2Shv1fQQoZCrpOK7vFZugs4ixemxh0eaKul3nKFHz5/8KsepR/Ne78d
         /Ff1pNZTj3LH6VVMa0kGIGGnpxPP9ybGDfc3r/uSXqlflQIhav7gL6q70jUOI3/SsN
         Q+q1lNadpqFZ0f6UixOZh2vc53xVdJl8gOPVmHv4K/TwRhqVAzztUBNqLX3uSxejZD
         0theMhbpkPIjw+f0bvlYVQctYSQa7uFW6B0NKBeMgM4Cc9DlH/6CWhgm7ZCDDO8Du5
         rfznUEDWqDjMA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/fsl-pci: Fix Class Code of PCIe Root Port
In-Reply-To: <20220722194226.GA1927257@bhelgaas>
References: <20220722194226.GA1927257@bhelgaas>
Date:   Mon, 25 Jul 2022 22:24:39 +1000
Message-ID: <87r129bcs8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Wed, Jul 06, 2022 at 12:10:43PM +0200, Pali Roh=C3=A1r wrote:
>> By default old pre-3.0 Freescale PCIe controllers reports invalid PCI Cl=
ass
>> Code 0x0b20 for PCIe Root Port. It can be seen by lspci -b output on P20=
20
>> board which has this pre-3.0 controller:
>>=20
>>   $ lspci -bvnn
>>   00:00.0 Power PC [0b20]: Freescale Semiconductor Inc P2020E [1957:0070=
] (rev 21)
>>           !!! Invalid class 0b20 for header type 01
>>           Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>=20
>> Fix this issue by programming correct PCI Class Code 0x0604 for PCIe Root
>> Port to the Freescale specific PCIe register 0x474.
>>=20
>> With this change lspci -b output is:
>>=20
>>   $ lspci -bvnn
>>   00:00.0 PCI bridge [0604]: Freescale Semiconductor Inc P2020E [1957:00=
70] (rev 21) (prog-if 00 [Normal decode])
>>           Capabilities: [4c] Express Root Port (Slot-), MSI 00
>>=20
>> Without any "Invalid class" error. So class code was properly reflected
>> into standard (read-only) PCI register 0x08.
>>=20
>> Same fix is already implemented in U-Boot pcie_fsl.c driver in commit:
>> http://source.denx.de/u-boot/u-boot/-/commit/d18d06ac35229345a0af80977a4=
08cfbe1d1015b
>>=20
>> Fix activated by U-Boot stay active also after booting Linux kernel.
>> But boards which use older U-Boot version without that fix are affected =
and
>> still require this fix.
>>=20
>> So implement this class code fix also in kernel fsl_pci.c driver.
>>=20
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> I assume the powerpc folks will take care of this.

Will do.

cheers
