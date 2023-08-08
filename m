Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A697774CA5
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 23:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjHHVNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 17:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbjHHVNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 17:13:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15465359B
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 12:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A964862BA8
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 19:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60F9C433C7;
        Tue,  8 Aug 2023 19:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691523668;
        bh=1i/WOLutUv8ruHYAvbTfRxHuiyEVFIB89VyFxdme5ts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZreQXlIxUXiSUIRtStSjfXoJyAkoWrpHI339yEuCKhsiNRBmlPckZ20DQSFfE/3bi
         2DeDxOL8VvfmyjgxvLdVApZJNyRa1h+HlglZt/9Ao8F1IEy778566GGtQp8Zej20KZ
         TzAMv9VtJ4vEmiV6qh/qIRm47vnOLn6UZMWZj9XWArNVTK9/6gY2BIBHh/nwmJ8YYn
         xZLUxA5lnFVsqMw0OtRzS8hm1ERRVqzfSMGxUhGSW67fTR2lHORqZarQTRjBG5RCHU
         TUZo9ea2QOJ+Q4fGjwIU3hEv1Gwkd7NKzZ0OXdM1jKMihqfziAr2SBDqdDbPt9NHQS
         CX2nxLCIcT1sQ==
Date:   Tue, 8 Aug 2023 14:41:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808194105.GA330258@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808190609.d7sbfklwlfo522lp@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 09:06:09PM +0200, Pali Rohár wrote:

> ... then go ahead and send a patch to remove
> my maintainer line from this driver ...

Oh, I forgot that you're listed in MAINTAINERS for this driver.  I
don't want to do it for you, but if you'd prefer not to get problem
reports about pci-mvebu, you could send a patch to update that
MAINTAINERS entry.

Bjorn
