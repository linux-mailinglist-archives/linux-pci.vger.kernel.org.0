Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D365F5E7C74
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiIWODA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 10:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiIWOC7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 10:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9527513A04D;
        Fri, 23 Sep 2022 07:02:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED79C611FE;
        Fri, 23 Sep 2022 14:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BABC433C1;
        Fri, 23 Sep 2022 14:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663941777;
        bh=ixvslB3k4f1Z+i5nljwfgK1Ai9iYp3xq8hITW4HXtw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HX4C9a+ooEJNK8nNxgxYp2jKQOrFi0RVTd281nbW5Bvv9koLVgCd9z3DUjCX5QuhZ
         JVJTdbnG0DyKfqjIntIslYA24l7lpmp57s6JzCzUdL7ArHedpO31ILluNximecp5Tk
         l4xxQVv3PhNLaWO4olD+/1I+zXf/AKNUZISQALaZYrrUONX6ocwblCJ9vJiQnIJu2z
         vl7fN7KqCebTY23vx9SVA9AHzOHCb0lSHMIauzcqtm5qDK6/KTV5dy3Q5G+r+Q3zkc
         CZoCVIP2pv4yhJlowaTWiWaSGhUAku2SbBhUStdU6WnEeu/xMydc32LzM4ohs4cbJU
         f/+/XuWgwg1JQ==
Date:   Fri, 23 Sep 2022 09:02:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v3 05/14] arm64: dts: Add iMX8MM PCIe EP support
Message-ID: <20220923140255.GA1388596@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663913220-9523-6-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 02:06:51PM +0800, Richard Zhu wrote:
> Add iMX8MM PCIe EP support.

Half the time this is spelled "i.MX..." and half the time it's
"iMX..."  Pick one and use it consistently.  I think "i.MX..." is
right because that's what I see on nxp.com, e.g.,
https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-8-processors/i-mx-8-family-arm-cortex-a53-cortex-a72-virtualization-vision-3d-graphics-4k-video:i.MX8

Also applies to several subsequent patches.

Bjorn
