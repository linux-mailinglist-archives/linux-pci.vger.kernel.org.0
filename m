Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AEC5826B4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jul 2022 14:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiG0Mdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 08:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiG0Mdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 08:33:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AE12A8;
        Wed, 27 Jul 2022 05:33:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtCqz6Gjgz4x1Y;
        Wed, 27 Jul 2022 22:33:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658925217;
        bh=QAuXrY/FPQVxrLMO9CIU4iIq7ob/dsZ+P55nLBcn+x8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IaAfhwx1qi/6yfin6Mq71kyaKRFN3i+L4jf4geCBX/RpPANKnQ5KeuBDbrrAN8t4F
         Tww/GB1ILmM6xYFXbUJGOJNz3EvnRx75k8CmzVHfo8W0GG6yyCcvi3E6fsfiSFLlp7
         SWvc4Wi6ncdoAVXoan9UVHYvvyUmIj21wKqcOXAlw03uy8YgbZ/j5pBEgs4T5gnAiT
         QlsV9vl3C2QN19MTzNuCYz4cymt9HUAh2wkZzHLuAG/ljLyrSrD5t42qJZ6faADpbh
         12L4FBwRJEaniYCGEFJPvdKhAeqoigrLgwArkt937QrsBLQb2WlKwEUXKSTbXqWLb/
         qqjCKWU/HkRbg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Guowen Shan <gshan@redhat.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/pci: Add config option for using OF
 'reg' for PCI domain
In-Reply-To: <20220706102148.5060-1-pali@kernel.org>
References: <20220706102148.5060-1-pali@kernel.org>
Date:   Wed, 27 Jul 2022 22:33:32 +1000
Message-ID: <87pmhqag6b.fsf@mpe.ellerman.id.au>
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

Pali Roh=C3=A1r <pali@kernel.org> writes:
> Since commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on
> device-tree properties"), powerpc kernel always fallback to PCI domain
> assignment from OF / Device Tree 'reg' property of the PCI controller.
>
> In most cases 'reg' property is not zero and therefore there it cause that
> PCI domain zero is not present in system anymore.
>
> PCI code for other Linux architectures use increasing assignment of the P=
CI
> domain for individual controllers (assign the first free number), like it
> was also for powerpc prior mentioned commit. Also it starts numbering
> domains from zero.
>
> Upgrading powerpc kernels from LTS 4.4 version (which does not contain
> mentioned commit) to new LTS versions brings a change in domain assignmen=
t.
>
> It can be problematic for embedded machines with single PCIe controller
> where it is expected that PCIe card is connected on the domain zero.
> Also it can be problematic as that commit changes PCIe domains in
> multi-controller setup with fixed number of controller (without hotplug
> support).
>
> Originally that change was intended for powernv and pservers and specially
> server machines with more PCI domains or hot plug support.
>
> Fix this issue and introduce a new option CONFIG_PPC_PCI_DOMAIN_FROM_OF_R=
EG.

As I said in my previous reply, I don't want a config option for this.

Adding an option now would revert the behaviour back to the way it was,
which has the potential to break things, as you described.

Maybe we shouldn't have changed the numbering to begin with, but it's
been 6 years, so it's too late to change it back.

cheers
