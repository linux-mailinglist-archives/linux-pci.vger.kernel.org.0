Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB4C646FFE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 13:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLHMuD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 07:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiLHMt4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 07:49:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431138C6A4;
        Thu,  8 Dec 2022 04:49:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrt3FPpz4xvP;
        Thu,  8 Dec 2022 23:49:50 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linux-pci@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221205223231.1268085-1-helgaas@kernel.org>
References: <20221205223231.1268085-1-helgaas@kernel.org>
Subject: Re: [PATCH] cxl: Remove unnecessary cxl_pci_window_alignment()
Message-Id: <167050321594.1457988.6215186331785819055.b4-ty@ellerman.id.au>
Date:   Thu, 08 Dec 2022 23:40:15 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 5 Dec 2022 16:32:31 -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> cxl_pci_window_alignment() is referenced only via the struct
> pci_controller_ops.window_alignment function pointer, and only in the
> powerpc implementation of pcibios_window_alignment().
> 
> pcibios_window_alignment() defaults to returning 1 if the function pointer
> is NULL, which is the same was what cxl_pci_window_alignment() does.
> 
> [...]

Applied to powerpc/next.

[1/1] cxl: Remove unnecessary cxl_pci_window_alignment()
      https://git.kernel.org/powerpc/c/6aecc0a59e07ba895b5473e0c916ba5f3d556c15

cheers
