Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CB379E6A7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 13:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbjIMLZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 07:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbjIMLZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 07:25:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEED19BE;
        Wed, 13 Sep 2023 04:25:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf7a6509deso46795345ad.3;
        Wed, 13 Sep 2023 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694604336; x=1695209136; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+snWdPw4OwpiJyYyKW+q+QdDJNbVDVuE7cCYvKasOM=;
        b=sKsV+IUYxLdwt5cxFuM2gCePh2mHyys5NDnL78hhOOHOz70l6FlJELNsL36Vwv1JKf
         ECgr5qdgpQxAACF+fItM+1HaFw2Ku7hGc1O+I/GU39dNq18fL+TiJhcFBUB6OpYmlmoQ
         1ELeMtOSlw6YYHG9ICwQLn2e682nSF90on8ay+3Xowe7SRDL7faeaguF4axWMMbhvTZZ
         C4KpT8E70bBXLkR1IMFFPnmTUeEonKuk/9/mZIMylN/sKRwPcfXu/M+8nW1PQtz8Q2Rm
         wm4sYdQE78CwSl8T36nmXxyCJ6TqmZO0zuoMZ/Wl8wRIhtq7yREJUTEWQuJtQQhF+dJs
         U2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694604336; x=1695209136;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U+snWdPw4OwpiJyYyKW+q+QdDJNbVDVuE7cCYvKasOM=;
        b=L1SwDb0PJtB0UrtaWtwCsM9to4rzTUZayEGRGkwYJOkYAxoYeE7rvd9Dz3GGct5aBJ
         GAc9uKMWgP7q0Ht1DEAn9aaGX2XuDPZCXKHadJTikKBqMkX8dTE3eMDDaUndzTeuAQJN
         t5LqsZNzIKTies3XRHWucAF5SB+4yRMHY1uPOKsDHO/iqJzSq6SOviV+LZjg/o5vBod9
         RmgUrbjrGF4ucJmjugyuRGEIPEtzEk3DamsuEdXUk/03paNacGDF3fDXxvkMFnrQtcWC
         a5UNmpgwBWoKvtzy9Ur7NQXlbTz56QDpE7c+p9e4MBZZ1kazDAxlA/OTbYP96eBNoEXj
         kalQ==
X-Gm-Message-State: AOJu0YxoHPGBS8s6u7PuZ1mmF/KNYyWcKBSt89Z3xZEYVe8UMdDXFs25
        /eXs0nPr5FnwDORahnfkubmsaaXjJAg=
X-Google-Smtp-Source: AGHT+IG6qnNRjP8VGlU50n41ujtaU5WA8G9CE3Sr2eMhkVR7KTZlFt9dF+9n+pjjZ8ne4icdXU8kdQ==
X-Received: by 2002:a17:902:d70a:b0:1c3:8230:30d8 with SMTP id w10-20020a170902d70a00b001c3823030d8mr2375056ply.38.1694604336213;
        Wed, 13 Sep 2023 04:25:36 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001b890009634sm10230532pld.139.2023.09.13.04.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:25:35 -0700 (PDT)
Message-ID: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
Date:   Wed, 13 Sep 2023 18:25:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe SATA
 to Constantly Reset
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> After upgrading to 6.5.2 from 6.4.12 I keep getting the following kernel messages around three times per second:
> 
> [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [ 9683.270399] ata16.00: configured for UDMA/66
> 
> So I've tracked the offending device:
> 
> ll /sys/class/ata_port/ata16
> lrwxrwxrwx 1 root root 0 Sep 10 21:51 /sys/class/ata_port/ata16 -> ../../devices/pci0000:00/0000:00:1c.7/0000:0a:00.0/ata16/ata_port/ata16
> 
> cat /sys/bus/pci/devices/0000:0a:00.0/uevent
> DRIVER=ahci
> PCI_CLASS=10601
> PCI_ID=1B4B:9130
> PCI_SUBSYS_ID=1043:8438
> PCI_SLOT_NAME=0000:0a:00.0
> MODALIAS=pci:v00001B4Bd00009130sv00001043sd00008438bc01sc06i01
> 
> lspci | grep 0a:00.0
> 0a:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SATA 6 Gb/s RAID controller with HyperDuo (rev 11)
> 
> I am not using the 88SE9128, so I have no way of knowing whether it works or not. It may simply be getting reset a couple of times per second or it may not function at all.

See Bugzilla for the full thread.

patenteng: I have asked you to bisect this regression. Any conclusion?

Anyway, I'm adding this regression to regzbot:

#regzbot: introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217902

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217902

-- 
An old man doll... just what I always wanted! - Clara
