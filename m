Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF1D6E6DED
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjDRVRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 17:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjDRVRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 17:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B283C1E;
        Tue, 18 Apr 2023 14:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CFE163913;
        Tue, 18 Apr 2023 21:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA49C4339B;
        Tue, 18 Apr 2023 21:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681852635;
        bh=NkZbO3v1vt7AI6j7cVF6xRNunCdnbFbTZvCRF8jsgq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=urpnr/YkVnjIu9iySbQ9lTqnTEQrBcWC8upUe1l5mPT3KJWyc6D800EnYZaVZM8CD
         11YyGIfys29trDDlYBhN+waQP2aRngfkM+sPnAujYbmljKp9khoLZYUnvvE3bfvTkR
         3ZZeWXpDWm7tdVR0kxl0Y9gEx1nNQ4NTQd+I0NXnwzU3Kw2Qz+9vtQVKQnXpQIaQZK
         NNMvP2SPr4UVvxUTCk67K/ucm7h3C77cf0ErtvXWNf1z0TDu5a3ihsSbSVclOMV0Tp
         tAH+lQ0PSxoiiId7vNS50HbtAH2tCyhPBosKNdqpEMyr2b4P/I1BYzb9C5b/027pM3
         JOHn5CY2pIezw==
Date:   Tue, 18 Apr 2023 16:17:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Patrick McLean <chutzpah@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] gpu: Move ASPEED vendor ID definition to pci_ids.h
Message-ID: <20230418211714.GA161849@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418211403.GA160979@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 04:14:03PM -0500, Bjorn Helgaas wrote:
> Most subject lines for pci_ids.h look like this:
> 
>   PCI: Add ASPEED vendor ID
> 
> On Mon, Apr 17, 2023 at 06:17:19PM -0700, Patrick McLean wrote:
> > Currently the ASPEED PCI vendor ID is defined in drivers/gpu/drm/ast/ast_drv.c,
> > move that to include/linux/pci_ids.h with all the rest of the PCI vendor ID
> > definitions. Rename the definition to follow the format that the other
> > definitions follow.
> > 
> > Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
> 
> Given the subject line and file placement (below) updates,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Oh, at the same time, would you mind rewrapping at least this commit
log so it fits in 75 columns to "git log" doesn't overflow an 80
column terminal?

Bjorn
