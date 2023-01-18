Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F66672A28
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 22:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjARVPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 16:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjARVOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 16:14:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC722630A6
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 13:14:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E3061997
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2023 21:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4755C433EF;
        Wed, 18 Jan 2023 21:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674076466;
        bh=viBveGu88AsjPiWErhOmDAlRkCq1n+hHkT6lfehusXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P+6bLzgWp6OrhYNUKh0Na3pZPGFySZh1vdknGJs07Sv3v9YQhRQ7UswUPlw4GiBgb
         JBPUBrig5WTpInKkRFONkP/qc6CodmBitUjFCcDCfQLo1cyUyetD7Kp9k8Qb17wgtf
         Ev7/LKkPyqO5/wzi0MeavkzZqTdOa0E4pe1t4JLsTsowOZVhq11e7Bs5MHljC8fGUZ
         5pplkjlokWREuRzbafSn4/zwL3I5O6s+99jorULvNBLgkMz0VFdVYR6U+Ckav7/c+b
         6H+dWMgEuCCuq+a/HE6ZcKBDJFmnXJF5TuENyt50XslCKLYGV7z+x/M33viHH/sh7W
         AW4QXjPlBy92Q==
Date:   Wed, 18 Jan 2023 15:14:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Marcin <martii@interia.pl>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, regressions@lists.linux.dev
Subject: Re: [Bug 216950] New: DisplayPort USB-C hub issue
Message-ID: <20230118211424.GA259217@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216950-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 18, 2023 at 07:49:38PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216950
>            Summary: DisplayPort USB-C hub issue
>     Kernel Version: 6.2.0-rc3
> ...
> Created attachment 303624
>   --> https://bugzilla.kernel.org/attachment.cgi?id=303624&action=edit
> dmidecode + kern.log
> 
> I have HP 845 EliteBook G7 (Ryzen) and before 6.2.0-rc3 installation
> there was no issue with my laptop and HP docking station via USB-C.
> 
> This kernel display behaves weirdly. LCD monitor (connected to
> docking station via DisplayPort) wakes up only once after reboot.
> Second docking connection ends up with blank external screen and
> only restart helps.
> 
> Display manager detects extra screen and even newly launched apps
> land there.
> 
> I didn't have such issues with original distro kernel
> 5.16.15-76051615-generic

This report (which looks like a regression between
5.16.15-76051615-generic and 6.2.0-rc3) was raised against PCI, but I
don't see PCI issues in the logs.  Any DRM ideas?

Bjorn
