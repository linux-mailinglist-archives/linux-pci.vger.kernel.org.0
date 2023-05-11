Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE56FFB33
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbjEKUXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 16:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbjEKUXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 16:23:35 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C6549DB;
        Thu, 11 May 2023 13:23:34 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 06D00300002CB;
        Thu, 11 May 2023 22:23:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E47DD160E04; Thu, 11 May 2023 22:23:32 +0200 (CEST)
Date:   Thu, 11 May 2023 22:23:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <20230511202332.GD31598@wunner.de>
References: <20230511131441.45704-2-ilpo.jarvinen@linux.intel.com>
 <ZF0P2hedTFXPv8IK@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZF0P2hedTFXPv8IK@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 10:55:06AM -0500, Bjorn Helgaas wrote:
> On Thu, May 11, 2023 at 04:14:25PM +0300, Ilpo Järvinen wrote:
> > +int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
> > +					      u16 clear, u16 set)
> > +{
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	spin_lock_irqsave(&dev->cap_lock, flags);
> > +	ret = pcie_capability_clear_and_set_word(dev, pos, clear, set);
> > +	spin_unlock_irqrestore(&dev->cap_lock, flags);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(pcie_capability_clear_and_set_word_locked);
> 
> I didn't see the prior discussion with Lukas, so maybe this was
> answered there, but is there any reason not to add locking to
> pcie_capability_clear_and_set_word() and friends directly?
> 
> It would be nice to avoid having to decide whether to use the locked
> or unlocked versions.

I think we definitely want to also offer lockless accessors which
can be used in hotpaths such as interrupt handlers if the accessed
registers don't need any locking (e.g. because there are no concurrent
accesses).

So the relatively lean approach chosen here which limits locking to
Link Control and Link Control 2, but allows future expansion to other
registers as well, seemed reasonable to me.

Thanks,

Lukas
