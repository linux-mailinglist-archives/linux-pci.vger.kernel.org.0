Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D04B3932
	for <lists+linux-pci@lfdr.de>; Sun, 13 Feb 2022 04:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiBMDPA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Feb 2022 22:15:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiBMDPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Feb 2022 22:15:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B49C5F25B;
        Sat, 12 Feb 2022 19:14:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D795DB80765;
        Sun, 13 Feb 2022 03:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA13C340ED;
        Sun, 13 Feb 2022 03:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644722092;
        bh=1tRFFMyPFO9dAmC5T5Ys0voccg/N5Wfh3T5MrLKPRSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+lroi7C+z8H4st9LhyYpClIP5uC32rJxzv6c1qmtbOYl3KjTuIJsNuZzGyFLV2lj
         F0VH6Vh9gj6BTRJdW/MZy6pDn398qzA31sSPyjBqKe6pl6CvfMRYcha2OWyxZEXBbL
         itGgVOwmaXj03AvkC40aLZf4KX33Gqk+cEsoYySAp+pdbRra/e0911vrw1YvyqDOHD
         oX3u8APHkVRp5dhiqlxcDtzdHfmbmZLf+Mbr1MkG3hLpSg+oNrm0XMi1vBjS4vV8i8
         FIJMmztfP74+ceww8TqT4XsD7spB/GFHCT/BLCVTu9jEroXhYVwwI+r99uQ3c9zpmm
         KqWPTBRPbsz7A==
Date:   Sun, 13 Feb 2022 11:14:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     bhelgaas@google.com, l.stach@pengutronix.de,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v2] arm64: dts: imx8mq-evk: Add second PCIe port support
Message-ID: <20220213031446.GK4909@dragon>
References: <1644372408-5485-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644372408-5485-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 09, 2022 at 10:06:48AM +0800, Richard Zhu wrote:
> Enable the second PCIe port support on i.MX8MQ EVK board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Applied, thanks!
