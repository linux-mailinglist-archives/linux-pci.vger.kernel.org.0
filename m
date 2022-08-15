Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907F459292A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 07:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiHOFqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 01:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiHOFqj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 01:46:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32B10FE2;
        Sun, 14 Aug 2022 22:46:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M5jvX75Z8z4x1P;
        Mon, 15 Aug 2022 15:46:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1660542394;
        bh=xjW48oFcQsQOFiXcpzHjYMTpjM5xsTjxRkql1X/sLgk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jWYtvhUQmFzSNRL7ewx8eqvEqHMcNQS9vuHCyMShPf+PHFld92WTfRl70GYP/osJr
         LmmWKxbNvu0E4EOo1FEEPskOMfi/91v/5jY+lv1saYTbd+zxfxotBH8pC2hJsnxxkU
         lkcJjMvQWObnyN5AY+Uc0Q8w12+8L37mukutKU3/TyvEsxa7Bd6Yv0WXNu/Cguesif
         B3hZpH1XcqUwBv9ueolyZW9P4q058V6oT1yJ7w5rPeB6DuPyimppneWoiwHfivEnc4
         blfWCcZbixMNDYh+iF8hkG/CtQfPX2b4DLg9DPyMNCqXQU2tIhCpGv9vB7ABZLgPWl
         QgZdmr9Kj2NoQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc/pci: Prefer PCI domain assignment via DT
 'linux,pci-domain' and alias
In-Reply-To: <20220813135735.GA3413265@roeck-us.net>
References: <20220706102148.5060-1-pali@kernel.org>
 <20220706102148.5060-2-pali@kernel.org>
 <20220813135735.GA3413265@roeck-us.net>
Date:   Mon, 15 Aug 2022 15:46:31 +1000
Message-ID: <874jyevz2g.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:
> On Wed, Jul 06, 2022 at 12:21:48PM +0200, Pali Roh=C3=A1r wrote:
>> Other Linux architectures use DT property 'linux,pci-domain' for specify=
ing
>> fixed PCI domain of PCI controller specified in Device-Tree.
>>=20
>> And lot of Freescale powerpc boards have defined numbered pci alias in
>> Device-Tree for every PCIe controller which number specify preferred PCI
>> domain.
>>=20
>> So prefer usage of DT property 'linux,pci-domain' (via function
>> of_get_pci_domain_nr()) and DT pci alias (via function of_alias_get_id())
>> on powerpc architecture for assigning PCI domain to PCI controller.
>>=20
>> Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on devi=
ce-tree properties")
>> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> This patch results in a number of boot warnings with various qemu
> boot tests.

Thanks for the report.

I have automated qemu boot tests to catch things like this, they even
have DEBUG_ATOMIC_SLEEP enabled ... but I inadvertantly broke my script
that checks for "BUG:" in the console log. Sometimes you just can't
win.

cheers
