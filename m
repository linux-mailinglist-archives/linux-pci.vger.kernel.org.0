Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC299632FFB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 23:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKUWu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 17:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKUWu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 17:50:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878DC786E8
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 14:50:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C8FB614E9
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 22:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E66C433D6;
        Mon, 21 Nov 2022 22:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669071054;
        bh=ap1N3+4/8uZjjGLMRx5193Qyixb9FcylGccUDlvLkTc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UcRkyxXeLG/+xUAqEe/KJj1q1NfE1uMqhxtNDQ+Erh37pHW7RtiQRiFXMjQHBjeZ5
         76sfIApYICwUd9OAJXa2ZpmAm1eb8JI+MOVoS6SjrEIMoYIlV+IDVBS0fEpdKNY3QQ
         XazK8SHE4vc50fB2wMlZ8FzYZg+KQDEcBRe1t+pRXU2qwNUPgeFaRdqA8mMQRRwVm7
         DHgeujSgce3wMcCCnno4yWbVGc5PhAsj2fnKkrgMZYktcP1K3w+qy5+ll+fLB/U0RN
         s+UrWXwEYAXe1bT2YAI2aSlp9zmAaJ8jZTnFXMRkHkEnpUA3FJFWBkcvVvWagEuLdu
         EN20bsvliX45w==
Date:   Mon, 21 Nov 2022 16:50:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
        bhelgaas@google.com, kw@linux.com, robh@kernel.org,
        lpieralisi@kernel.org
Subject: Re: [PATCH] PCI: mt7621: increase PERST_DELAY_MS
Message-ID: <20221121225052.GA140064@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMhs-H-i1arxS4daudfG8AGuFyxmJuNe6CY4A+Pi+u8RNUM65A@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URI_TRY_3LD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 20, 2022 at 08:37:50AM +0100, Sergio Paracuellos wrote:
> On Sat, Nov 19, 2022 at 7:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sat, Nov 19, 2022 at 12:08:37PM +0100, Sergio Paracuellos wrote:
> > > Some devices using this SoC and PCI's like ZBT WE1326 and Netgear R6220 need
> > > more time to get the PCI ports properly working after reset. Hence, increase
> > > PERST_DELAY_MS definition used for this purpose from 100 ms to 500 ms to get
> > > into confiable boots and working PCI for these devices.
> >
> > confiable?
> 
> It seems my spanish confused my mind here :). I meant trustable.

Your English is WAY, WAY better than my Spanish :)

I assume this is more about just making boots more "reliable" than
something like the "Trusted Boot" or "Secure Boot" technologies [1,2]?

Bjorn

[1] https://trustedcomputinggroup.org/resource/trusted-boot/
[2] https://learn.microsoft.com/en-us/windows/security/trusted-boot
