Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D226F3975
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEAUze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjEAUzd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 16:55:33 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EB112F
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 13:55:31 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8996C2800B6ED;
        Mon,  1 May 2023 22:55:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7857E4A8DC; Mon,  1 May 2023 22:55:29 +0200 (CEST)
Date:   Mon, 1 May 2023 22:55:29 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] PCI: brcmstb: Set PCIe transaction completion
 timeout
Message-ID: <20230501205529.GA3626@wunner.de>
References: <20230428223500.23337-4-jim2101024@gmail.com>
 <20230430191323.GA388047@bhelgaas>
 <CA+-6iNwb6Cn-78BJ5URhwvDuYHg5b4X5h+WdMw-CB3nRs=pSYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwb6Cn-78BJ5URhwvDuYHg5b4X5h+WdMw-CB3nRs=pSYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 30, 2023 at 05:24:26PM -0400, Jim Quinlan wrote:
> I've been maintaining this driver for over eight years or so and we've
> done fine with the HW default completion timeout value.
> Only recently has a major customer requested that this timeout value
> be changed, and their reason was so they could
> avoid a CPU abort when using L1SS.
> 
> Now we could set this value to a big number for all cases and not
> require "brcm,completion-timeout-us".  I cannot see any
> downsides, other than another customer coming along asking us to
> double the default or lessen it.

The Completion Timeout is configurable in the Device Control 2 Register
(PCIe r2.1 sec 7.8.16).  Your controller does expose that register:

  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled, ARIFwd-
           AtomicOpsCtl: ReqEn- EgressBlck-

Why does your controller allow configuration of the timeout in a
proprietary register in addition to DevCtl2?

If you make the Completion Timeout configurable, please do so in
a spec-compliant way, i.e. via DevCtl2, so that it works for
other products as well.

If the proprietary register has advantages over DevCtl2 (e.g.
finer granularity), perhaps you can divert accesses to the
Completion Timeout Value in DevCtl2 to your proprietary register.

Thanks,

Lukas
