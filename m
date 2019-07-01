Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E675C426
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGAUHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 16:07:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38006 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 16:07:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so818955wmj.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Jul 2019 13:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fOpcYsp8ldJAc3KN3E6Zi1otn7ZmzkZ8yXwgSo/lpWQ=;
        b=DTDMKxf/183C8v7B0FKv50wVGcksC6UAVjf4FbSkj7beVIgnK7HKMKwiO0IBzKbv/w
         VKC+B++O0AWMvhV20TLB79+MwKzKeRDXqM8NcM84sFzI4CW6G8CSHRx8LA98aaEFnU9Q
         73DjBc2huS2oVXtiB6Ja2qINcFYKedW6Pm93mFbZ6Cc2mtglmv4Gkur7Kot8Nw1S6YM/
         HHsFBie05qBDT0YAsF7Smmq9Xg/7k96H8y00IUGxgBn2lqU75YiqvzBuoc9u2LuVTKXB
         L6KFAO4R5KQ0dVNb2h1Xaao9DJV1ICts3kAzkoSVjhQ4yN1xSp1pTy65rKj6dKo2fQ5t
         w5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fOpcYsp8ldJAc3KN3E6Zi1otn7ZmzkZ8yXwgSo/lpWQ=;
        b=aIbHExE4B1XZzh311lKJE3hh1Tvk2yQxOJRzQbH3Q13z/ggc5tGGvXbFb62aCdYJz0
         RrdXEX/kVgkQDWxYzBu3H9PELdL0vLe1Z0F4Rso/SATwvZSfxWCNBOX98+K9JbshZ6PC
         OXEezDi2yXDj/3XiviLCziHHjrsIJqUqsLW1qV87K+rnpoifIl7PXWCBB0nt827s9YLs
         L9OStTGwVj4SM4XbwUw5wE4nFtpTDo8d6JOYIbrtD/b531ZrUm/TMjr+AIzKLYAN/WlU
         u0h6Gy0DbW+zxI9n8MggVEvHt8cDSEuMQvHXgkbjS28l4pkYO7bylIIKKxZkLg4T/rq9
         J5Vg==
X-Gm-Message-State: APjAAAUgEjTRCisbASHwBmo4xp65+aSEsHKf11g3QxG+Mf4rl7Stq1Ux
        j8i2PaB3P0dSVfGFkw+1MXkhLr0o
X-Google-Smtp-Source: APXvYqywUmZmMh/AO8okhiCNKnPa0kpNKN+vxGntCyPQF+6EiNv9FSCPx3zla/VTK7/SF2duZhEdog==
X-Received: by 2002:a1c:b604:: with SMTP id g4mr559286wmf.111.1562011634929;
        Mon, 01 Jul 2019 13:07:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd6:c00:8dac:9ad2:a34c:33bc? (p200300EA8BD60C008DAC9AD2A34C33BC.dip0.t-ipconnect.de. [2003:ea:8bd6:c00:8dac:9ad2:a34c:33bc])
        by smtp.googlemail.com with ESMTPSA id r16sm20915196wrr.42.2019.07.01.13.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 13:07:14 -0700 (PDT)
Subject: Re: [PATCH 0/3] PCI/ASPM: add sysfs attribute for controlling ASPM
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Message-ID: <7c4b2931-b90f-c6ca-50fb-b04296c10387@gmail.com>
Date:   Mon, 1 Jul 2019 22:07:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7a6d2f14-f2a6-99ad-3a93-fdaa0726ce86@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23.05.2019 22:03, Heiner Kallweit wrote:
> Background of this extension is a problem with the r8169 network driver.
> Several combinations of board chipsets and network chip versions have
> problems if ASPM is enabled, therefore we have to disable ASPM per
> default. However especially on notebooks ASPM can provide significant
> power-saving, therefore we want to give users the option to enable
> ASPM. With the new sysfs attribute users can control which ASPM
> link-states are disabled.
> 
> After few RFC's this is the submission-ready version. Added to the RFC
> version has been documentation of the new sysfs attribute.
> 
> Heiner Kallweit (3):
>   PCI/ASPM: add L1 sub-state support to pci_disable_link_state
>   PCI/ASPM: allow to re-enable Clock PM
>   PCI/ASPM: add sysfs attribute for controlling ASPM
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  13 ++
>  drivers/pci/pci.h                       |   8 +-
>  drivers/pci/pcie/aspm.c                 | 211 ++++++++++++++++++++++--
>  include/linux/pci-aspm.h                |   8 +-
>  4 files changed, 219 insertions(+), 21 deletions(-)
> 
Can we get this into 5.3? The series was reviewed before in RFC state and
there have been no change requests.

Thanks, Heiner
