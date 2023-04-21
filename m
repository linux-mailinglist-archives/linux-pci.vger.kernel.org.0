Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923866EA7D9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Apr 2023 12:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDUKHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Apr 2023 06:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjDUKHb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Apr 2023 06:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46EAD17;
        Fri, 21 Apr 2023 03:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 795A064FB3;
        Fri, 21 Apr 2023 10:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9051C433EF;
        Fri, 21 Apr 2023 10:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682071648;
        bh=/0OhRuGj6n5KH5ITNoVDRZmLJcKTXz8TiF6s12pumHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUSI4nqcJJRvWVuFElINY+HOdSmiFzUCbJCkglbJ+xHi0+olKr/y1/Y1LPC5XBDp1
         yBj53LFhBn82gJyoWD54OQ1aQndyzDzOQLYxRkJaDfhEaL8O9sMKBsTsWrccrR8QRV
         Kf+pfJtHGjFUdjuB5DAYDYCrA758VgAgS1hApxBboHDMDqV/VBC6PfpcdC61RLdXs1
         1DidMI0JUj6j03rvNwieIndY0KImh6mdww85LuGHeGWZLpV+3Bkd5qoQnPHRs/obRm
         4qzO3wmEQW0J3YZscEf/OWe/Hf/O8gdMDOAypByUM4D7cXlakIOas1liR4Pg6Gx3Aq
         HspWlEUMgPl/g==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix a Kconfig prompt of vNTB driver
Date:   Fri, 21 Apr 2023 12:07:23 +0200
Message-Id: <168207163080.82492.11121926793358179384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230202103832.2038286-1-mie@igel.co.jp>
References: <20230202103832.2038286-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 02 Feb 2023 19:38:32 +0900, Shunsuke Mie wrote:
> vNTB driver and NTB driver have same Kconfig prompt. Changed to make it
> distinguishable.
> 
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> 
> 

Applied to controller/endpoint, thanks!

[1/1] PCI: endpoint: Fix a Kconfig prompt of vNTB driver
      https://git.kernel.org/pci/pci/c/e49f106fb073

Thanks,
Lorenzo
