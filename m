Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C8599A8F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348521AbiHSLFS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 07:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348576AbiHSLEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 07:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D695AFAC4E
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 04:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 693236171A
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 11:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99889C433C1;
        Fri, 19 Aug 2022 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660907078;
        bh=Q1fuI6kaHUAKv7wckjSX+NjcOnO//x+YueLRXxDkRVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OiH9oAxVgOifiMh44MQ7+gci9H9HpPzkUVcSXO2NlagkWNs+eW2yhvdrtgbBPsYYk
         rNzaSQ6i6Udw9TmNlTPvYQnZ9Pe/IdaQr5FY1wwpRW0/XK+o7vPgd6w6GAo71JNbnY
         9s6GtGMpRvVicUzj64cVvG6tpr3SWtC1H1GBpu+KrPW+z6AlJFPVU6IHF1LZpOtNXn
         VuHxQI4LBR1x0czrNCfqsU7uDKyhX6njsOkBIsMl/iuzyGaqit1yLwUgHRFJaugeHw
         0IxtxOfAj/x/+FP9LfZ19q9XRtgUaCu0Zfvd9UDqidQr/gaql2+USeEBSgVC63HgtQ
         2YkTgG9vK/aEQ==
Date:   Fri, 19 Aug 2022 06:04:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>, regressions@lists.linux.dev,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Tom Seewald <tseewald@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>, Stefan Roese <sr@denx.de>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Message-ID: <20220819110437.GA2432401@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc036a10-5c13-fdd7-9d98-2b5f0f8af383@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 02:03:59PM +0530, Lazar, Lijo wrote:

> Or, it could be amdgpu or some other software component -
> 
> register mmio base: 0x95E00000
> Address       0x95e7f000
> 
> 0x95e7f000 indicates access from CPU to a register offset 0x7FE000. This
> doesn't look like a valid register offset for this chip (device
> [1002:73df]). Any other clues in dmesg?

The complete dmesg is at
https://bugzilla.kernel.org/attachment.cgi?id=301596
