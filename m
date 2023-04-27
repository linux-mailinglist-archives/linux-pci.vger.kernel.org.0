Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B966F0C0D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 20:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbjD0Sii (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243558AbjD0Sih (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 14:38:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0813BE4;
        Thu, 27 Apr 2023 11:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97BCA63F15;
        Thu, 27 Apr 2023 18:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D27C433D2;
        Thu, 27 Apr 2023 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682620715;
        bh=63rZ6oKXHT4RQ6j3QCN/KK6+FdSVlUibkCVfjxxt48o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jbz73+aINXhOJZT8oWCJ3Zbs8TSg4d28s+hqlwHSNge1JLHpAoFNQbntGLQ/3l6hV
         90Ok6oFO+gyX8mrgFhW9KdHYTayo5OiNlmscRdIg7yFZ8M/dDnKIxptUjBNi9pUTHN
         4a4A7zYrv371pDdtOwwfZiVSK2BIwhaUmwRxpZVVutudMGJ56r1KHIfLAzEcT61vJ+
         Rrl5QPc/W/GHjDmTiG7GTSahGA2cluxRhPfsSG6riDs35tNLm5ab50E2Wz9xmU8uuF
         taKfxVTIHljklAmw2k8cVnRJJbo8X2nbDlJS3L8LRlbpNbcnoENKWlvAIduc0D6Qfn
         eCn1IvcvGSUkg==
Date:   Thu, 27 Apr 2023 13:38:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Junyan Ye <yejunyan@hust.edu.cn>
Cc:     christophe.jaillet@wanadoo.fr,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: controller: pci-ftpci100: Release the clock
 resources
Message-ID: <20230427183833.GA263506@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423053208.2348-1-yejunyan@hust.edu.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 23, 2023 at 01:32:07PM +0800, Junyan Ye wrote:
> Smatch reported:
> 1. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe()
> warn: 'clk' from clk_prepare_enable() not released on lines:
> 442,451,462,478,512,517.
> 2. drivers/pci/controller/pci-ftpci100.c:526 faraday_pci_probe()
> warn: 'p->bus_clk' from clk_prepare_enable() not released on lines:
> 451,462,478,512,517.

If/when you repost this, please:

  - Rebase to v6.4-rc1 (when it's available).

  - Look at subject line history for this file and match it.

  - Include the smatch warnings exactly above (not wrapped to fit in
    75 columns).  This is to make it easier to search for the text.

  - Add "()" after function names below to make it obvious they are
    functions.  You can also omit "function", e.g., "... is obtained
    by devm_clk_get()."

> The clock resource is obtained by the devm_clk_get function. The
> clk_prepare_enable function then makes the clock resource ready for use,
> notifying the system that the clock resource should be run. After that,
> the clock resource should be released when it is no longer needed. The
> corresponding function is clk_disable_unprepare. However, while doing
> some error handling in the faraday_pci_probe function, the
> clk_disable_unprepare function is not called to release the clk and
> p->bus_clk resources.

I don't know the clk terminology.  Does "... clock resource should be
run" mean the clock should be "running" or "enabled"?
include/linux/clk.h only uses "running" twice but has many instances
of "enable", so maybe that would be better.  Or maybe it's enough to
say:

  clk_prepare_enable() then makes the clock resource ready for use.

and omit the rest of that sentence?

Looks like a nice fix, thank you!

Bjorn
