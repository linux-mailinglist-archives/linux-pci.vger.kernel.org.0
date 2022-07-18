Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F80578DA1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 00:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiGRWkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 18:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiGRWki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 18:40:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A622B261;
        Mon, 18 Jul 2022 15:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D37CBB817B7;
        Mon, 18 Jul 2022 22:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD2AC341C0;
        Mon, 18 Jul 2022 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658184035;
        bh=lhU/JExpOSEKJDInQznDy3qsN7c7UqcbEHd+FzPXqEY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mIGa+9/u5W3L/ehTjMVx+iDuDXxtClxxVs/tEEqzi6L2SMBrbXpEsILTlVtT8QEM4
         QU1qVnB5+99Ra+nMwQvonth+j0hA2QIOPFslDc1FJ3zS33EKqr6s3Ks7vicDJaXz4O
         YvUQ5IA429Ano35x+TQwWNs3+Vy+dYLAX56jDp0hTvbT+q770IHcTsVKN+8LCQmVyk
         tWVm/BNZNknkXqHL6+tuFaD9H7l/poj2ON2M2pYr5maaldeIEXDD5yKCyXlpfzfeNi
         vUY11fMIDYUjNSzLZenS8Qzq1K0E+O0wiBEJNLBZyIcPbwk1QMUGbHe6gxMkz7FPuf
         T5iyd3OMRLhlQ==
Date:   Mon, 18 Jul 2022 17:40:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220718224033.GA1450714@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718181425.GA1431580@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 01:14:25PM -0500, Bjorn Helgaas wrote:
> ...

> So I think brcm_pcie_setup() does initialization that doesn't depend
> on the link or any downstream devices, and brcm_pcie_start_link() does
> things that depend on the link being up.  Right?
> 
> If so, "start_link" might be a slight misnomer since AFAICT
> brcm_pcie_start_link() doesn't do anything to initiate link-up except
> maybe deasserting fundamental reset.  Some drivers start the LTSSM or
> explicitly enable link training, but brcm_pcie_start_link() doesn't
> seem to do anything like that.
> 
> brcm_pcie_start_link() still does brcm_pcie_set_outbound_win().  Does
> that really depend on the link being up?  If that only affects the
> Root Port, maybe it could be done before link-up?

What about the /* PCIe->SCB endian mode for BAR */ thing?  Does that
depend on the link being up?

And the "Refclk from RC should be gated with CLKREQ#" part?  Does that
depend on the link being up?

It seems obvious that brcm_pcie_set_ssc() and reading the negotiated
link speed and width depend on the link being up.
