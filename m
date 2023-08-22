Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4210783C8A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 11:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjHVJLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHVJLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 05:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9F189
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 02:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F28D260C6E
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 09:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD0BC433C7;
        Tue, 22 Aug 2023 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692695465;
        bh=BrNSb2HvY13bt1egoOwfkcjX4OCdk+/NfVk+KYNZH4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAjpVKETLcHyfQ//GU+qUO4qtfP9E2qmQcFopnmpU+ir5TZnAt0uCf9y2TA6mKwrn
         Vm/D0y16LJSRJPgtxof9lKxGd3f6jRntw3I06WVY27W+aDNsKX+t6zl9zKstvO93eV
         9kr0MY84O6Q2LWIAJwqFuvz+yimaoAy5yRRwzVad9iNT3md05B5QcNSX8oysN4ClgK
         duVrW2+e5uOmL/Ch5yxtya+4zYubANN61a5PcUoxVBHt8wdO9aDZoNY/xoGiy264KQ
         D7Vtb43iNCfih8BDdOrqnRGtB/QsEQKuqR6rqbgJNtfPV2mo0upDVGRE5U09Hlp2Bh
         CJk3HubvzsZNw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v5] PCI: vmd: Disable bridge window for domain reset
Date:   Tue, 22 Aug 2023 11:10:55 +0200
Message-Id: <169269543810.11372.3647092123892841759.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810215029.1177379-1-nirmal.patel@linux.intel.com>
References: <20230810215029.1177379-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Aug 2023 17:50:29 -0400, Nirmal Patel wrote:
> During domain reset process vmd_domain_reset() clears PCI
> configuration space of VMD root ports. But certain platform
> has observed following errors and failed to boot.
>   ...
>   DMAR: VT-d detected Invalidation Queue Error: Reason f
>   DMAR: VT-d detected Invalidation Time-out Error: SID ffff
>   DMAR: VT-d detected Invalidation Completion Error: SID ffff
>   DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
>   DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
>   DMAR: Invalidation Time-out Error (ITE) cleared
> 
> [...]

Applied to controller/vmd, thanks!

[1/1] PCI: vmd: Disable bridge window for domain reset
      https://git.kernel.org/pci/pci/c/f73eedc90bf7

Thanks,
Lorenzo
