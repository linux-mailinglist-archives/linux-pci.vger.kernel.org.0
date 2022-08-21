Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738C259B501
	for <lists+linux-pci@lfdr.de>; Sun, 21 Aug 2022 17:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiHUPUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Aug 2022 11:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUPUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Aug 2022 11:20:49 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321EC18353
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 08:20:48 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6E79D2805B6D3;
        Sun, 21 Aug 2022 17:20:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 620521FBF0; Sun, 21 Aug 2022 17:20:44 +0200 (CEST)
Date:   Sun, 21 Aug 2022 17:20:44 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/11] PCI: pciehp: Enable Command Completed Interrupt
 only if supported
Message-ID: <20220821152044.GA31612@wunner.de>
References: <20220818135140.5996-1-kabel@kernel.org>
 <20220818135140.5996-3-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818135140.5996-3-kabel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 03:51:31PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> The No Command Completed Support bit in the Slot Capabilities register
> indicates whether Command Completed Interrupt Enable is unsupported.
> 
> We already check whether No Command Completed Support bit is set in
> pcie_wait_cmd(), and do not wait in this case.
> 
> Let's not enable this Command Completed Interrupt at all if NCCS is set,
> so that when users dump configuration space from userspace, the dump
> does not confuse them by saying that Command Completed Interrupt is not
> supported, but it is enabled.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

I note however that this change isn't really necessary because CCIE
"must be hardwired to 0b" "If Command Completed notification is not
supported" per PCIe r6.0 sec 7.5.3.10.  It's purely a cosmetic issue.

Thanks,

Lukas
