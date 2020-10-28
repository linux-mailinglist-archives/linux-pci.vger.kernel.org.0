Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2925629DA62
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 00:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgJ1XVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 19:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgJ1XTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 19:19:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60215C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 16:19:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 2so1023880ljj.13
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2020 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bddUYsH0Q4taj7eCHyEIuGJKg/yr7YiUZPcQWZ6v1LE=;
        b=CHOjYBk8HiC/jeqJz46qiJ+eYkb+cO4QM0ST57G8Nj2qaYtoA0bq4KHBXJtXjg+qn+
         qekfDBVppaQE4Yyke5X5qlxyMuhkAbtoBNmRWxYK34Vrwe3eM4wSayOsyRBkjvzCNUUv
         HMCWEwEVOMezfYxCSLc7scukjloUxce/3BAD2DjJ/WYsKofME5qrQK+vJqTQ1TsAtLFw
         lNAnvVGC40++z0+IzngjlpSCAVdy2FYHPPrLqZbaVs2MH3WVU416Yz/AiNmPgRrQ6RjX
         MSX4iUdP+tds4JwsZst/RWETtsd+DLjwE26Rp3d3tbLnZ5YsEy1G3RHY9AyfoPwGky8q
         9ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bddUYsH0Q4taj7eCHyEIuGJKg/yr7YiUZPcQWZ6v1LE=;
        b=TLzyljF8fuB+RGr1oOSzCM0GcwVuJYbR1jmmZObPGzqcxtd03F3kPKleCUKBifNDjC
         7l1+C858DbsclqO9IfIYKwQgpq6+5WbAPMeEq3rQW/OQYc1k0e44A1psdFBDn74fTOMT
         JwJUbsrNIlkvXRbams90fCh7RTSvwlhtjKy9UBIYmgeUoHfNkc8lUtDEa2EQvDGzjwxW
         n44KKYccZcIcB5WjZSRKV287PFL06tKlUgEqun0C5JSbaygBYOcxB9P659L5yvDHZFbs
         mnjVfGOanrdoJpiWa1N2meaW/M6YILKeG2IpuDVC1YjaCbV60kNcF4vw98tH2ecvuaP5
         N63Q==
X-Gm-Message-State: AOAM533wdGu/Xdq5lrth7pDMOziiVBg7I/m83L1SjsGKukw1BENwTic9
        bzOEjJuOJJZiGknl8oZ9gdHtVIH1tT4/glQBQCMjp78Fwh4=
X-Google-Smtp-Source: ABdhPJzCs+C7nGVmskqV5HWtwP2HsoDUyoZPtmjPyl0kVxXWNVUEZaqXQZSqJhoXzMmq2aFQ+100yvJkxcOjHt+nb5g=
X-Received: by 2002:a2e:8845:: with SMTP id z5mr648833ljj.216.1603927193515;
 Wed, 28 Oct 2020 16:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201028231545.4116866-1-rajatja@google.com>
In-Reply-To: <20201028231545.4116866-1-rajatja@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 28 Oct 2020 16:19:17 -0700
Message-ID: <CACK8Z6HHP7O96zAHW4MM6ZtH-6h1WcJ=VtAVCXbGnRL3400SLA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Always call pci_enable_acs() regardless of pdev->acs_cap
To:     linux-pci <linux-pci@vger.kernel.org>,
        "Boris V." <borisvk@bstnet.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

-random email address (typo)
