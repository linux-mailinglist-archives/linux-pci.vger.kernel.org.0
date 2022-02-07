Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BE14AC827
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbiBGSCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 13:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiBGR7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 12:59:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE3CC0401D9;
        Mon,  7 Feb 2022 09:59:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78A56B8165D;
        Mon,  7 Feb 2022 17:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10E6C004E1;
        Mon,  7 Feb 2022 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644256751;
        bh=5Fqi/UtD0xGTUGfiJ1s3twBfT8A8QZEg585SBGwHpXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aWtmiju5E1LDC4Y1jOlEKsy8UW7LbEs0eK6/TA8aLgreC6XgMGc8vlYyvKI1Np0Bh
         HcP+TAAI73eKJJrRhLE3bSls5ZS6EuOuJFbcSET+o1cxA2UgMfUoYIFrFzQJs7KV1M
         vpjcbj9YYwXCyUxJ4E4Q7ygeeDWs0gnDd/S4nj55O3oUynt2fIp7vFaX424prYPvDO
         D1LuiKkWgLjZ5ugcpfn4vKRtsLqj8NbAtHMtOS1SKEyoKV+rcYC/SMn4jv6KDoZS05
         IuXdyUSqX8PdAHbji2IdGE85Q9fV6twDrr7ZieGcEYSJnEX1SXiDF9zPkNwX/Qo70t
         dNWNS8UD7MObA==
Date:   Mon, 7 Feb 2022 11:59:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v8 00/10] vgaarb: Rework default VGA device selection
Message-ID: <20220207175909.GA406079@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a06a30-f479-df9f-980c-b789f0f26ce9@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 04:46:33PM +0100, Maarten Lankhorst wrote:
> Op 31-01-2022 om 23:23 schreef Bjorn Helgaas:
> > [+to Maarten, Maxime, Thomas; beginning of thread:
> > https://lore.kernel.org/r/20220106000658.243509-1-helgaas@kernel.org]
> >
> > On Wed, Jan 05, 2022 at 06:06:48PM -0600, Bjorn Helgaas wrote:
> >> From: Bjorn Helgaas <bhelgaas@google.com>
> >>
> >> Current default VGA device selection fails in some cases because part of it
> >> is done in the vga_arb_device_init() subsys_initcall, and some arches
> >> enumerate PCI devices in pcibios_init(), which runs *after* that.
> > Where are we at with this series?  Is there anything I can do to move
> > it forward?
> 
> I'm afraid that I don't understand the vga arbiter or the vga code
> well enough to review.
> 
> Could you perhaps find someone who could review?
> 
> I see Chen wrote some patches and tested, so perhaps they could?

Huacai, any chance you could review this?  I'm worried that this
series isn't going to go anywhere unless we can find somebody to
review it.

Bjorn
