Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217F5558015
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiFWQkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiFWQkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 12:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085D4925F;
        Thu, 23 Jun 2022 09:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04B49B8248A;
        Thu, 23 Jun 2022 16:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D90AC3411B;
        Thu, 23 Jun 2022 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656002412;
        bh=JfbqMd3ZFkhV2Jb0VUbEs8hnVb0OikMcCTXQnjWaEJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tnD+s1cMkq8CTU/zJrXjVry1+V7AyXUhWjp+hb4ABETeA59Awz56s4J1uNkgN2e79
         5G0OTgd8omUH1DArMdqX+HMIfJyagj6Fpk6+nppc1ovp9NMeCSwo5vw3CwR2xGqQ/A
         Yqw0kPoV2E0v1RWyCqHxnXccm9JKci4Zd/hhxPWs6PIMQCa8cYarq1ftVFWHf0kyP6
         me+GoRnYBNfIoL6fNi8S5ykKw3R4lNBqro7+iHE2xhYze74E6iVVZrPNis02/jC6gD
         hHGN7DZXk4cLX4A9FY1AT2n6d/FVXiZLx/K/UCuD8n4IQdT1+B30NO64Um1Ci2M3UN
         ANb5nn4rJGZIA==
Date:   Thu, 23 Jun 2022 11:40:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/2] dt-bindings: PCI: uniphier: Fix endpoint
 descriptions
Message-ID: <20220623164010.GA1457016@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655950142-2026-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 11:09:00AM +0900, Kunihiko Hayashi wrote:
> Changes since v3:
> - Add Reviewed-by: and Acked-by: tags

Hi Rob, I notice your Reviewed-by and Acked-by tags.  Does that mean
you want me to merge these?  It looks like you've merged most of the
recent changes yourself.  Happy to do it either way, whatever you
intend.

> Changes since v2:
> - Move some items to minimize if/then schemas in Patch 2
> - Remove Patch 3 because the warning comment is for an unmerged source
> 
> Changes since v1:
> - Fix "config" in the Patch 1 commit message to "addr_space"
> 
> Kunihiko Hayashi (2):
>   dt-bindings: PCI: designware-ep: Increase maxItems of reg and
>     reg-names
>   dt-bindings: PCI: uniphier-ep: Clean up reg, clocks, resets, and their
>     names using compatible string
> 
>  .../bindings/pci/snps,dw-pcie-ep.yaml         |  4 +-
>  .../pci/socionext,uniphier-pcie-ep.yaml       | 76 ++++++++++++-------
>  2 files changed, 51 insertions(+), 29 deletions(-)
> 
> -- 
> 2.25.1
> 
