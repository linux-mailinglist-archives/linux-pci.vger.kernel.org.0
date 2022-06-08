Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C896543BC3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 20:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiFHSv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiFHSv6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 14:51:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057653E2E9F;
        Wed,  8 Jun 2022 11:51:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA1E8B82616;
        Wed,  8 Jun 2022 18:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F924C34116;
        Wed,  8 Jun 2022 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654714313;
        bh=wGS+AcGNqHfLuT2Hm3nCkkeKEwLClhkrXKZ2e19uFtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uqzk/TUIyXeatRqLcjlUWyEHLm8RX0X6tbBX1ESrbsrWsJKPNa8zzy2R1Mk2TGXFD
         Z2qq04Pw4T6ZANgvUuA5wsLSRrHtMVP2cBLl+heJ0Dzid3rETS4TeNPU1qKQiuw1Do
         mmwepTr+IlAIon/fs966b6CtcbfNBsZBlJ9woIGhLn+Ck4NM9A6tTPY+B/yfdfbKmB
         13lb7vOrDQf0K06E4eRJqtSqaDCy6evjZwWMQALkqpbRptjBN29Pefg/uMR20af8as
         UI3k47G3dX+rowQm+4kUFK0KeyhVxEHtgDa7LWsHtDTsyekZK25iSrqWkqzITXAUek
         83C58AzR7FeOw==
Date:   Wed, 8 Jun 2022 13:51:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, festevam@gmail.com,
        francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v9 1/8] PCI: imx6: Encapsulate the clock enable into one
 standalone function
Message-ID: <20220608185150.GA410588@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651801629-30223-2-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 06, 2022 at 09:47:02AM +0800, Richard Zhu wrote:
> No function changes, just encapsulate the i.MX PCIe clocks enable
> operations into one standalone function

Since there's another rev coming for other reasons, maybe mention the
name of the "one standalone function."

s/clocks enable/clock enable/ above
