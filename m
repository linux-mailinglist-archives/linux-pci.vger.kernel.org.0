Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DF36A2BC5
	for <lists+linux-pci@lfdr.de>; Sat, 25 Feb 2023 22:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBYVCY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Feb 2023 16:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBYVCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Feb 2023 16:02:23 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C3D14E90
        for <linux-pci@vger.kernel.org>; Sat, 25 Feb 2023 13:02:21 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 3486330014819;
        Sat, 25 Feb 2023 22:02:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 285672CCB6; Sat, 25 Feb 2023 22:02:20 +0100 (CET)
Date:   Sat, 25 Feb 2023 22:02:20 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     fk1xdcio@duck.com
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: ASMedia ASM1812 PCIe switch causes system to freeze hard
Message-ID: <20230225210220.GA17261@wunner.de>
References: <9B577F97-4E03-4D1D-B6F2-909897F938CC.1@smtp-inbound1.duck.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9B577F97-4E03-4D1D-B6F2-909897F938CC.1@smtp-inbound1.duck.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 25, 2023 at 01:37:23PM -0500, fk1xdcio@duck.com wrote:
> I'm testing a generic 4-port PCIe x4 2.5Gbps Ethernet NIC. It uses an
> ASM1812 for the PCI packet switch to four RTL8125BG network controllers.
> 
> The more load I put on the NIC the faster the system freezes. For example if
> I activate four 2.5Gbps fully saturated network connections then the system
> hard freezes almost immediately. When the system freezes it seems completely
> dead. SysRq doesn't work, serial consoles are dead, etc. so I haven't been
> able to get much debugging information. I have tested on various different
> physical systems, Xeon E5, Xeon E3, i7, and they all behave the same so it
> doesn't seem like a system hardware issue.
> 
> Disabling IOMMU makes it run for a little longer before crashing.
> 
> The tiny bit of error information I have been able to get under various
> conditions (eg. disabling ASPM, forcing D0, etc):
>   Test #1:
>   pcieport 0000:04:02.0: Unable to change power state from D3hot to D0,
> device inaccessible

Have you tried adding pcie_port_pm=off to the kernel command line?

Thanks,

Lukas
