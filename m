Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6395459365C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 21:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbiHOTSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 15:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345024AbiHOTR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 15:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A13B564FC;
        Mon, 15 Aug 2022 11:39:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6627B61199;
        Mon, 15 Aug 2022 18:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8491DC433D6;
        Mon, 15 Aug 2022 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660588761;
        bh=3G4uZzAdpVjcj/ctLM7juJABNL2m1h7Zq6ocCoet+dM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ruMVx+NljLbRV2Jo6NtY3YlRv6X4E1uOdRXeNLbXRdZT0DVipM2L5Pk0vOEoMvFR7
         lqjqLJ0QRf/Y+VNnHkAaMYPa6we0HRXYXPrGZPpuQbkN+wJPWM/WfsZJp5eBwibpPG
         Qoa2HNe75iinkF29VkeX60ZFDSP/sua3cyOyaW13NgzcaTTEYtgBaGduMs4t3iIlXt
         rqvYRjotAcJzNud5rQSpIdnpbfHJ8y3ND0vaXlrsdoolzWf4mw39s45EO0joYf85Ym
         dFM4mcnBIbkG4XB59Z9Fpj43EjRUYYmELmbp0Qym3uVtsxjOmz7TTZTAd/wFIIhecr
         VOuf2G94vynfQ==
Date:   Mon, 15 Aug 2022 13:39:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jon Mason <jdmason@kudzu.us>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: endpoint: fix Kconfig indent style
Message-ID: <20220815183920.GA1960006@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXvt5osmx+iFdVXYQhGcdBiz5VsA60jzdKXg42c_zSDuxoHxg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 15, 2022 at 12:00:23PM +0900, Shunsuke Mie wrote:
> I have a question, not related to the patch. Could you please tell me
> why the ntb related patches are managed outside the pci branch,
> Helgaas's branch? It confused me a little to find the ntb branch.

My understanding is that the recent drivers/pci/endpoint/functions/*ntb.c
patches were merged by Jon because they had dependencies on other
patches in his tree.

In the future, I think most NTB-related patches in drivers/pci/ will
be merged via my PCI tree.

Bjorn
