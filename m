Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3DB75B8A1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjGTUVQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 16:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGTUVP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 16:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A72272C;
        Thu, 20 Jul 2023 13:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C0DE61C37;
        Thu, 20 Jul 2023 20:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227DFC433C8;
        Thu, 20 Jul 2023 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689884473;
        bh=dmhjCBaGiwYim4fPl8sE7+2zbi+1rP0uV56nlbTaoqk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kk1TmLNUwQKDcMXi9FOXz6oIJrwXlWn8imhGgXjgMqzCv5/ZJ0vguuQgH1logJjur
         lVNBdCsk2z6PS9EJOl4WizpIbipsjiMzAb6eVBlmhVGqhly2mZQ0oM6a3VBcW4elXZ
         zoVYcfzjynySATR1BNV2XI4WhNVWCBGdD0ibcOjMzrmKTn/rB/3kepI8AzIOehX4jE
         ip8MydcfWJB6ybpuy0Lnjeaa/XsCo3waSsWi1iZ7E9ccuI7zJ1PlQF7jRrQw+2Af2Q
         CZUCZt8dnB4pGN9K/Ia7SOPakoIuxK+pi3KfhvPK7CJMYoI5aBi+DKj644kGjlL4wC
         fdl+TtYsnlU7Q==
Date:   Thu, 20 Jul 2023 15:21:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     imammedo@redhat.com, bhelgaas@google.com,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: Kernel 6.5-rc2: system crash on suspend bisected
Message-ID: <20230720202110.GA544761@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc regressions list]

On Wed, Jul 19, 2023 at 11:36:51PM -0400, Woody Suwalski wrote:
> Laptop shows a kernel crash trace after a first suspend to ram, on a second
> attempt to suspend it becomes frozen solid. This is 100% repeatable with a
> 6.5-rc2 kernel, not happening with a 6.4 kernel - see the attached dmesg
> output.
> 
> I have bisected the kernel uilds and it points to :
> [40613da52b13fb21c5566f10b287e0ca8c12c4e9] PCI: acpiphp: Reassign resources
> on bridge if necessary
> 
> Reversing this patch seems to fix the kernel crash problem on my laptop.

Thank you very much for all your work debugging, bisecting, and
reporting this!  This is incredibly helpful.

Original report, including complete dmesg logs for both v6.4 and
v6.5-rc2:
https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com

I queued up a revert of 40613da52b13 ("PCI: acpiphp: Reassign
resources on bridge if necessary") (on my for-linus branch for v6.5).

It looks like a NULL pointer dereference; hopefully the fix is obvious
and I can drop the revert and replace it with the fix.

Bjorn
