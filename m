Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7614C64BE6E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Dec 2022 22:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiLMVa6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 16:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiLMVa5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 16:30:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFF823BEF
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 13:30:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B3E761709
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 21:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4659DC433D2;
        Tue, 13 Dec 2022 21:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670967055;
        bh=CS7rh9kvRPxKAP0qRuf16chDx/zpKBDUPphsDa9o4P0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cgKcLJ6R+//h8J7NXhz4cEz/iGyJAotetERey26nj6W8AsmE2AsC+YsO0GVyo4oUp
         O5BVj/K42r1u6F3mgaAsP1LXyXLjX2TkQQRC8T5Ia5RsTDoZEt7c4Y8o54qq8+FDpC
         8MbG1lvVMYdQDJzCOyTl8jF9vSdrThQt1afYMrjU3eDCec+jbTDxsQUqYTucOGNkTi
         J02t8r/t8VOyw+KMM7K8TkiDnJc9cJIwd5BPvLQKiWFvny4LdF2Te9ttstwZqamXxl
         FXezAK4Z9Bc4gfjhk33MFbaaZL/qjfWDkIUouXeRGImtX8F+rpouxc9T/cr0gL85JE
         GC6smPxAXLz6w==
Date:   Tue, 13 Dec 2022 15:30:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: uefi secureboot vm and IO window overlap
Message-ID: <20221213213053.GA208909@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR02MB7986DFD09C363B691D7EF194FE1F9@BL3PR02MB7986.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 10, 2022 at 05:45:50PM +0000, Kallol Biswas [C] wrote:
> The part1 of the dmesg:
> 
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.10.0-957.el7.x86_64 (mockbuild@kbuilder.bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC) ) #1 SMP Thu Nov 8 23:39:32 UTC 2018

Is there any chance you can reproduce the problem on a current kernel?
If it's been fixed by now, maybe we could identify the fix and you
could backport it?

Bjorn
