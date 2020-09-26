Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486B12797A1
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZHuB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Sep 2020 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZHuA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Sep 2020 03:50:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D15C0613CE;
        Sat, 26 Sep 2020 00:50:00 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ay8so4810893edb.8;
        Sat, 26 Sep 2020 00:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrAfMnN1cDVaMgoAsNfzzlqzPewf+U+U/Sjm7fSeqNs=;
        b=O4wmkPfXCecoN5FIWCHYSlxfWMvhXCKD1C8ypWpVKcWOHlrpNJD2QOPuD5VScGwNFI
         x5gT5ck5NDes3Wt6P3trkdluUur8rZc8o5Z+fkxZVHf8fTSL9IKtd/WgN+jM/3VCS185
         PleEjvyhP4GtHlgnW9cVV6Klztu5k+MAk7ixl/uTxbFptTTEwPx3GISZh10xcDbhfGoH
         COk1jYShjG0kz+zk6xyv3/6ZNYRalazfV79zILZbkp0pomAb51NSZG2nmVyORe8p4y/Q
         ACfgU6J53D7zpR7Cr0bkBFzrgEJllUp5GCYzTJdFtqHTYd5mU8znAZlOU4hZ1lqIaOAG
         pddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrAfMnN1cDVaMgoAsNfzzlqzPewf+U+U/Sjm7fSeqNs=;
        b=osn0D3DUUgASPxe7a/dNFbbkCRZqY1uYNHZE0K/PekDN1e5nFdthPCMH0f2A8510qa
         1w/w7To8AmcLJuIumhO/MMAUCM0qmwIw+iJ7VSp7rdRd/WzCyrEwfMljSjJSqHuUdJFN
         8D9HzZsxRajN0A52i0XL/Eklwo7YNHWdYlfBBYf3gCT8bV6ge5T4pEboE0LBCtW0im/p
         T0n94GVVpztNb/DhinOVXHBC14TymHmw7/4Aw3/GsiQtKB8xGwmasQAmpkP7qccbN6Ek
         uVawdY56uZH53uRquo6eH8hetXrvw1KyvQgANy9pE9n6iU64LdQQabh7xTSVkN9jbOF9
         xnfg==
X-Gm-Message-State: AOAM533Oob6nL1PHhSidCwKjxc7BO8kEcxjpAi5qdGcoCJqmwldkXseQ
        mDLbnjrupmkQeAAdmfYq1hQ=
X-Google-Smtp-Source: ABdhPJwuExWLiVytMZwBjaDi0kpbv0Acdl+GRGEp/9DK+txT0NXtCVnJKwqq37z4dEKjTUi5Rk7rZg==
X-Received: by 2002:a50:a694:: with SMTP id e20mr5424804edc.114.1601106599202;
        Sat, 26 Sep 2020 00:49:59 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bee54.dynamic.kabel-deutschland.de. [95.91.238.84])
        by smtp.googlemail.com with ESMTPSA id z16sm3597662edr.56.2020.09.26.00.49.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Sep 2020 00:49:58 -0700 (PDT)
Message-ID: <9f5d395618ebd435a573527137370937ae3ef723.camel@gmail.com>
Subject: Re: [PATCH] PCI: kirin: Return -EPROBE_DEFER in case the gpio isn't
 ready
From:   Bean Huo <huobean@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        songxiaowei@hisilicon.com, wangbinghui@hisilicon.com
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
Date:   Sat, 26 Sep 2020 09:49:56 +0200
In-Reply-To: <2f29372be8186f25222e370f5601019b4d95b7b3.camel@gmail.com>
References: <20200918123800.19983-1-huobean@gmail.com>
         <20200921112209.GA2220@e121166-lin.cambridge.arm.com>
         <2f29372be8186f25222e370f5601019b4d95b7b3.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

seems the Hisilicon PCI driver maintainers are absent, however, we are
still using their old platform based on Kirin.

hi, Lorenzo
is it possible to take this patch without Hisilicon maintainter's ACK?

Thanks,
Bean

