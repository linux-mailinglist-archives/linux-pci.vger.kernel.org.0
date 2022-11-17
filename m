Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B330862E562
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 20:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbiKQToY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 14:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiKQToV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 14:44:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8C28A161
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 11:44:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8862B82191
        for <linux-pci@vger.kernel.org>; Thu, 17 Nov 2022 19:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A60AC433C1;
        Thu, 17 Nov 2022 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668714255;
        bh=U/Am7xdxGE2o6bVkVCC8UoAVVU2V5aIjhVU+2DgHYrk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oNHbNI0bGO/zdyKFouy5/roeghtIcnZ6LdSocAuwU50QpnLF3gGlqlwKQ5GfTNexi
         +7GD7EYBewIorkfFaG7d6D45fPNqLUT5dMwDZyfMIemYPYlf73cUW79TWetQS2Sanp
         Wy8yl2KN2iVk963I/+pD617s4iXQc3Y3AzYPPPVT9M+kxFczVBTpFNPxFPY9WmHniz
         j+mNWrd62AYdTqXayaqY2kvT1N1e0/Rcn8p3oIVSdKwgi0JqASaaHEYL7vihTjEsZP
         JQ5wd05taLgsYPbYwgmmyoFgTtR19kwPXWADTV9OR4Q4bl81/sbdeqHYnnhVzbet7i
         hcDHMCWU8SvFA==
Date:   Thu, 17 Nov 2022 13:44:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] MAINTAINERS: Include PCI bindings in host bridge entry
Message-ID: <20221117194413.GA1205039@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116215337.1032890-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 03:53:37PM -0600, Rob Herring wrote:
> Almost all PCI bindings are controller bindings, so the PCI bindings should
> be listed under the host bridge and endpoint entry.
> 
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-linus for v6.1, thanks!

> ---
> I left the entry under PCI subsystem though just about anything common 
> should end up going to dtschema rather than the kernel. So we could 
> remove it if Bjorn prefers.
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c379db61b800..86fe870c3697 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15930,6 +15930,7 @@ Q:	https://patchwork.kernel.org/project/linux-pci/list/
>  B:	https://bugzilla.kernel.org
>  C:	irc://irc.oftc.net/linux-pci
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> +F:	Documentation/devicetree/bindings/pci/
>  F:	drivers/pci/controller/
>  F:	drivers/pci/pci-bridge-emul.c
>  F:	drivers/pci/pci-bridge-emul.h
> -- 
> 2.35.1
> 
