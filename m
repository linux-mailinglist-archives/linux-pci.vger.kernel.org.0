Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB04C77CF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 19:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbiB1Sci (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 13:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240651AbiB1Scd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 13:32:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E6F4D08
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 10:15:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8DA86090A
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 18:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0307BC340E7;
        Mon, 28 Feb 2022 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646072130;
        bh=SuKPO0M/231Zpn2uVrhtFu6sK1UCV0OmbB0lcNUO4Mk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qbi3qGCsxCOv1M6mQsp9/kAZzxftrGrHfA7CVF5Y/O3WPI6LfI/BUox86sUhXUu5K
         DHtfjNymN2HBnjCNDG9C6SJw/FjbyPnLYbRCLxGWukV7Orcp3m6xyR+q3M+3cmwGYR
         MVGBBWDRN9/bIxdCBDr82dvV+zLNRnmnprmht79siueRbqRa6rCPSrCfNFer4dy2Ib
         qii80NhAMAtU8Ia+U/CMCvzp89Jg5JeFiXOqZfZTW+hmgBSxdhj2/M/niHAMYLifUc
         8tB4BQiogP8/9xXUJceaOGEUN8kg81Z5cVcck0tjZVSxJSIcU7HC6aDki+Tq4f75Yz
         z1y8Ao1kUhWsA==
Date:   Mon, 28 Feb 2022 12:15:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Zhihao Wang <wangzhihao9@hotmail.com>
Subject: Re: [Bug 215644] New: "PCIe Bus Error: severity=Corrected, type=Data
 Link Layer" flood
Message-ID: <20220228181528.GA509767@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-215644-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 27, 2022 at 02:34:29AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=215644
> 
>             Bug ID: 215644
>            Summary: "PCIe Bus Error: severity=Corrected, type=Data Link
>                     Layer" flood
>            Product: Drivers
>     Kernel Version: 5.13.0-30-generic(Ubuntu 20.04 LTS)
>           Hardware: Intel
>           Priority: P1
>           Reporter: wangzhihao9@hotmail.com
>         Regression: No
> 
> [36418.907739] pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> [36418.907759] pcieport 0000:00:1c.4:   device [8086:02bc] error status/mask=00000080/00002000
> [36418.907779] pcieport 0000:00:1c.4:    [ 7] BadDLLP
> [36422.383718] pcieport 0000:00:1c.4: AER: Corrected error received: 0000:00:1c.4
> [36422.383758] pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [36422.383770] pcieport 0000:00:1c.4:   device [8086:02bc] error status/mask=00001000/00002000
> [36422.383785] pcieport 0000:00:1c.4:    [12] Timeout
> [36423.383999] pcieport 0000:00:1c.4: AER: Corrected error received: 0000:00:1c.4
> [36423.384044] pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [36423.384057] pcieport 0000:00:1c.4:   device [8086:02bc] error status/mask=00001000/00002000
> [36423.384073] pcieport 0000:00:1c.4:    [12] Timeout
> [36423.384099] pcieport 0000:00:1c.4: AER: Corrected error received: 0000:00:1c.4
> [36423.384137] pcieport 0000:00:1c.4: AER: can't find device of ID00e4
> [36423.384145] pcieport 0000:00:1c.4: AER: Corrected error received: 0000:00:1c.4
> [36423.384167] pcieport 0000:00:1c.4: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [36423.384177] pcieport 0000:00:1c.4:   device [8086:02bc] error status/mask=00001000/00002000
> [36423.384188] pcieport 0000:00:1c.4:    [12] Timeout
> [36423.384218] pcieport 0000:00:1c.4: AER: Corrected error received: 0000:00:1c.4
> [36423.384244] pcieport 0000:00:1c.4: AER: can't find device of ID00e4
> [36425.385279] pcieport 0000:00:1c.4: AER: Corrected error received: 0000:00:1c.4
> 
> The Device is 00:1c.0 PCI bridge: Intel Corporation Device 02b8 (rev f0)
>               -- 02:00.0 3D controller: NVIDIA Corporation GP108M [GeForce MX250] (rev a1)
> 
> It happens just after I open the ASPM of the video card to make CPU to achieve
> the Package pc8 state for Power Saving. Normally only pc2.
> 
> Hewlett Packard disabled the ASPM of Video Card in the BIOS defaultly.

Thanks for the report!  I'm ccing it to the linux-pci since the
Bugzilla doesn't get much visibility.

How do you enable ASPM?

Please collect the complete dmesg log and "sudo lspci -vv" output
(before enabling ASPM, and also after if possible) and attach them to
the bugzilla.

Bjorn
