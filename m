Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320978405F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 14:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjHVMJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjHVMJM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 08:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFC193
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 05:09:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D04165530
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 12:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3EFC433C9;
        Tue, 22 Aug 2023 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692706149;
        bh=GSufGp04k7WSywYxrG+LIxVSRqd8DgsTxFexeWGc5CM=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=CA0TugwLQb/EM1yN0TTteZDXjpLtsAJP7B6fb03TWuF8fO5rcLaSYMDo7AI3WmRhR
         VqGRVRvcayrKrYAqkntJqJ60XKaetG3yIorcddrszaecBKLDQVne212yrbvs1hFc7D
         JErTAgQ0a3tNmSSbP7zItSzN3U28Qcvv9UZGcNb0Xi2bJyAlZTdbG+/CUu/wFeaR+M
         +3jCS1Rloa6WzjoM3BCFvTowUA0q+W1ip5bD4AJ3VGHItMFr97xe02vUxuyznUns7S
         dQnSUBGgGNP3uh09dKwaIYV/oMgWZYHX/3umZWM2blwwIuE6HaBgK/EbEcCxPCredw
         bsZT4w99vggEw==
Message-ID: <feef32b8-2eab-4fa2-c27b-0c482c5ef1dd@kernel.org>
Date:   Tue, 22 Aug 2023 21:09:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/2] Cleanup IRQ type definitions
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230802094036.1052472-1-dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230802094036.1052472-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/2/23 18:40, Damien Le Moal wrote:
> The first patch renames PCI_IRQ_LEGACY to PCI_IRQ_INTX as suggested by
> Bjorn (hence the patch authorship is given to him).
> 
> The second patch removes the redundant IRQ type definitions
> PCI_EPC_IRQ_XXX and replace these with a direct use of the PCI_IRQ_XXX
> definitions. Going forward, more cleanups renaming "legacy" to "intx"
> in various drivers can be added on top of this series.

Ping ?
I do not see queued in pci/next. Can we get it there please ? More coming on top
of this, so it would be nice to avoid one cycle delay. Thanks.

> 
> Changes from v2:
>  - Modified PCI_IRQ_LEGACY comment in patch 1 as suggested by Serge
>  - Fixed forgotten rename in patch 2
> 
> Changes from v1:
>  - Updated first patch Signed-of tag and commit message as suggested by
>    Bjorn.
>  - Added review tags.
> 
> Bjorn Helgaas (1):
>   PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
> 
> Damien Le Moal (1):
>   PCI: endpoint: Drop PCI_EPC_IRQ_XXX definitions
> 
>  drivers/pci/controller/cadence/pcie-cadence-ep.c  |  9 ++++-----
>  drivers/pci/controller/dwc/pci-dra7xx.c           |  6 +++---
>  drivers/pci/controller/dwc/pci-imx6.c             |  9 ++++-----
>  drivers/pci/controller/dwc/pci-keystone.c         |  9 ++++-----
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  8 ++++----
>  drivers/pci/controller/dwc/pcie-artpec6.c         |  8 ++++----
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 +-
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  drivers/pci/controller/dwc/pcie-keembay.c         | 13 ++++++-------
>  drivers/pci/controller/dwc/pcie-qcom-ep.c         |  6 +++---
>  drivers/pci/controller/dwc/pcie-tegra194.c        |  9 ++++-----
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  7 +++----
>  drivers/pci/controller/pcie-rcar-ep.c             |  7 +++----
>  drivers/pci/controller/pcie-rockchip-ep.c         |  7 +++----
>  drivers/pci/endpoint/functions/pci-epf-mhi.c      |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-ntb.c      |  4 ++--
>  drivers/pci/endpoint/functions/pci-epf-test.c     |  6 +++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c     |  7 ++-----
>  drivers/pci/endpoint/pci-epc-core.c               |  2 +-
>  include/linux/pci-epc.h                           | 11 ++---------
>  include/linux/pci.h                               |  4 +++-
>  22 files changed, 65 insertions(+), 82 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research

