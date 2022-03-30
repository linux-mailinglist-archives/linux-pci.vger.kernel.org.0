Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D6D4EBFF6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243078AbiC3Lq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 07:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbiC3Lq0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 07:46:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409525DA9B
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 04:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DD25B81ACC
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 11:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A55C340EE;
        Wed, 30 Mar 2022 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648640678;
        bh=ouH2LCtUegSceCgA5onVzRXsBm7StFk8kuTkYiJ93ac=;
        h=Date:From:To:Cc:Subject:From;
        b=pyKuAE7xg3DkSg+9Dqj6CLflFyGU4nZq00ohvoux9KxQjxEFdDXMJ9SqYUd/2+49z
         ZD35YR8boR5u4guyU4KXvqJzCKDf6Ol6j9Rb0g9Ok1cuDeG6QnAgzk1WghEPdmubSF
         8ev3QkGHI5UftsX8QpCevjzFtTyWO6/ccRqmfdghAbJ8hRKadh4prAmtK46YE6+JrP
         a3n7UEZDSJlfYmnpWFIu1+wlCzt1FXvFAClW+FOKS7tNkeWvWSFgGN1mZeaAMF66c8
         dQ3hOtXuo9FxFj2L/t3VL5rHEQWx4eouTObc7o8rlTSq2P+43wKFgVRELe0uP61AUr
         72yxGhKFSvjGQ==
Date:   Wed, 30 Mar 2022 06:44:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Robert Hancock <robert.hancock@calian.com>,
        dri-devel@lists.freedesktop.org
Subject: RX 5500 XT: PCIe link speed stuck at Gen1 2.5GT/s by default
Message-ID: <20220330114436.GA1683263@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

See https://gitlab.freedesktop.org/drm/amd/-/issues/1447

This report was against DRM, but I'm mentioning it here because we've
been talking about some link speed init issues lately, and AFAICT the
gitlab reports don't show up anywhere in lore.

Robert Hancock reported:

> I'm using a RX 5500 XT card on an Asus PRIME H270-PRO motherboard,
> Intel i5-7500 CPU, with kernel 5.10.9 under Fedora 33. I noticed
> that in Linux, "lspci -vv" always showed the GPU PCIe link running
> at 2.5GT/s link speed and never seemed to change regardless of the
> application being run, while in Windows, GPU-Z shows the link
> running at the max supported 8GT/s speed when under graphical load.
> 
> It seems like the driver thinks that 2.5GT/s is the max allowable
> speed, based on the pp_dpm_pcie file:
> 
>   > cd /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:00.0/0000:03:00.0/
>   > cat pp_dpm_pcie
>   0: 2.5GT/s, x8 81Mhz *
>   1: 2.5GT/s, x8 619Mhz *
> 
> I'm assuming that something is going wrong with the PCIe link speed
> detection in the driver. Using the "amdgpu.pcie_gen_cap=0x70007"
> kernel command line option seems to result in the driver detecting
> the proper 8GT/s maximum speed.
> 
> lspci -vv output from booting without overriding the speed is
> attached.
