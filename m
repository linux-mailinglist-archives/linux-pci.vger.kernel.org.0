Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9287CBC09
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjJQHKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQHKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 03:10:20 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABEA8E;
        Tue, 17 Oct 2023 00:10:17 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D6555300000A6;
        Tue, 17 Oct 2023 09:10:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CE0DA4DD3C9; Tue, 17 Oct 2023 09:10:14 +0200 (CEST)
Date:   Tue, 17 Oct 2023 09:10:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Prevent child devices from doing RPM on
 PCIe Link Down
Message-ID: <20231017071014.GA4592@wunner.de>
References: <20231016040132.23824-1-kai.heng.feng@canonical.com>
 <20231016093210.GA22952@wunner.de>
 <CAAd53p7gbWSkRbng205z2U0_kU42JeFw8qThcBuXuVwCC+Y_VQ@mail.gmail.com>
 <24f72eea9fba45c4b1cd85836b17f251@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f72eea9fba45c4b1cd85836b17f251@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc -= unrelated mailing lists bpf, kernel-hardening]

On Tue, Oct 17, 2023 at 05:44:13AM +0000, Ricky WU wrote:
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > On Mon, Oct 16, 2023 at 5:32???PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Mon, Oct 16, 2023 at 12:01:31PM +0800, Kai-Heng Feng wrote:
> > > > When inserting an SD7.0 card to Realtek card reader, it can trigger
> > > > PCI slot Link down and causes the following error:
> > >
> > > Why does *inserting* a card cause a Link Down?
> > 
> > Ricky, do you know the reason why Link Down happens?
> 
> Because SD7.0 card is use pcie-nvme driver, reader need to re-link
> then just do the pcie channel

I don't quite follow.  I don't see a pcie-nvme driver in Linus'
current master branch.  Which driver are you referring to?

What does "re-link" mean?  Rebind to a different driver?

Thanks,

Lukas
