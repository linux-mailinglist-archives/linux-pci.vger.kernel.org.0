Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957C0732BD9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 11:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbjFPJcP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344354AbjFPJcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 05:32:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3DE30FF;
        Fri, 16 Jun 2023 02:31:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C73D6339C;
        Fri, 16 Jun 2023 09:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B2FC433C8;
        Fri, 16 Jun 2023 09:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686907881;
        bh=afznl1xu2FedPHnZ6GwWLSsAYaSSpfgT68N9LhlDOIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5FuMmbm4AOpRluSAcOrgFB9mR/QK8tv8sLf7JixuZSo1Mll4OFQ90Cije78Jlobu
         ysKHLaT2DYlX5mONK/5jTL9w6Qlqp0BBAcijxNHV+EUkhisFgHRaFotu1Si+VxUx7H
         FNwjype88qr+RSxR8vZkTdBo0sTuCM/++VV+rHOb4kZ8aEa+LqgQ5lrJiDFEs1ctzn
         a+D8BTNNUp8Kzi9WEoxLNtzJiGLCyaOE7r+GAuy7YQmxCAUavuxxhacVQhMza2UTCy
         v3GgOs7fOiiDEMTvS5USzacHRMFRXt0o0uTsW4+Y+QL2H/nhC/kKTX4mxVyKXL4aXK
         12Ib22qcq+UZg==
Date:   Fri, 16 Jun 2023 10:31:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Bibo Mao <maobibo@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v4] PCI: Align pci memory space base address with page
 size
Message-ID: <20230616093116.GA10423@willie-the-truck>
References: <20230609022047.2195689-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609022047.2195689-1-maobibo@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 09, 2023 at 10:20:47AM +0800, Bibo Mao wrote:
> Some PCI devices have only 4K memory space size, it is normal in general
> machines and aligned with page size. However some architectures which
> support different page size, default page size on LoongArch is 16K, and
> ARM64 supports page size varying from 4K to 64K.

Shouldn't we also select this new Kconfig option on arm64 then?

Will
