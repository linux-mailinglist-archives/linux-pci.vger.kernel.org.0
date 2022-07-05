Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4D5662FE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 08:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiGEGOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 02:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGEGOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 02:14:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38476391;
        Mon,  4 Jul 2022 23:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E409B815D1;
        Tue,  5 Jul 2022 06:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCB1C341C7;
        Tue,  5 Jul 2022 06:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657001691;
        bh=N20ajp/3lQ194FtocElV2UAoCsUpGh2T37oUu3nAAso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P28pH94BLJJGjyyxp/2NDywpRovkFVBoHgAZi66TYlpZ2xbJq7sgZ7QtevriUThj5
         JGDX/2Go3bZcb6b+KOIjjrm0ym+u/z9RwYcrYS7pAyxmtxRq8GDAUUpUtKGGLRkE2W
         5gmnAcjN7U+lWAOLfHkCvhxdRTKGdqiCqDtmo50aZ+xsIQ9iuDKOPluaqTMru8ZiKa
         glvT8M+V13GOWyc4J0YTf5iBBRqTL8tJPW0ZtLr0nl+jd+PiZiiJ63I22wFQZWEsv9
         mcdJCRcRLsoBe+SrCaTVJEUVOxcPBDAaJ863xqWooWJa3mDbBEscE72jh8KUqVQRD4
         Rd9V3rQGCuwYg==
Date:   Tue, 5 Jul 2022 11:44:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        kw@linux.com, krzk@kernel.org, p.zabel@pengutronix.de,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 01/11] dt-bindings: PHY: P2U: Add support for Tegra234
 P2U block
Message-ID: <YsPW1w3mYcfxg/sX@matsya>
References: <20220629060435.25297-1-vidyas@nvidia.com>
 <20220629060435.25297-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629060435.25297-2-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29-06-22, 11:34, Vidya Sagar wrote:
> Add support for Tegra234 P2U (PIPE to UPHY) module block which is a glue
> module instantiated once for each PCIe lane between Synopsys DesignWare
> core based PCIe IP and Universal PHY block.

Applied, thanks

> 
-- 
~Vinod
