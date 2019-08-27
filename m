Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BBC9F0F8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfH0Q6j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 12:58:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43417 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbfH0Q6j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 12:58:39 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2enl-0000v7-G0
        for linux-pci@vger.kernel.org; Tue, 27 Aug 2019 16:58:37 +0000
Received: by mail-pf1-f197.google.com with SMTP id 22so15041033pfn.22
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2019 09:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZmU+i265kgZh9bO9prSg01z0i65nfx2GaSB2O7bSk90=;
        b=gLf6Xe1cXwXJvhd3Nbw9tKavxH8jUyz0J72v0DDYgLLcjb6X6t2AR+LYRF21y0OIWV
         6zL1ZGVSGN5G+JW/WZZBGViAkB3jlAwXitjXVIKX5mdYvNUPL0O0k2AlDKK6PXTemfK1
         RKTOF4Ke37nQbKeICEU/CYpfKobpJDcZFQcIpM8opQyzkNzF4AP0j/Ta+Ol0iuoFf2OW
         rPe+a/2TUQyc/+GBhvPPKTXTw05t5X1mEP4GJdJfgViEt372LgC7jGxAvZP1dFI6SYtF
         Z6zBeifCbtVLf+cAtu413vdw43SkeMKIJObDbU3KpNiEVMAeract/cNYrKHzd9ko8i/F
         YE6g==
X-Gm-Message-State: APjAAAWYth1bZgXiN8DrImTvgCRbVrJOhD+Ge9JEMigAx+iHoj2ymuop
        ePnxweqF7vM9AfJ/JiEKZGUt5C98GSogDJPFzKiJ3OA12hOdl54SyUx63vhi0vJy3bX+AxXZrZE
        oUxrWygNtMGq1y+cKyDKsuXwASipOdS5Jo9a9+g==
X-Received: by 2002:a63:1:: with SMTP id 1mr21851560pga.162.1566925115038;
        Tue, 27 Aug 2019 09:58:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUUxXXgspEoNOIqmfJkQtVmAN7fCfHHbqIOIjA5f1KoSAP1aqHJ2qIScW920OpXslsUi9dnA==
X-Received: by 2002:a63:1:: with SMTP id 1mr21851540pga.162.1566925114765;
        Tue, 27 Aug 2019 09:58:34 -0700 (PDT)
Received: from 2001-b011-380f-3c42-843f-e5eb-ba09-2e70.dynamic-ip6.hinet.net (2001-b011-380f-3c42-843f-e5eb-ba09-2e70.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:843f:e5eb:ba09:2e70])
        by smtp.gmail.com with ESMTPSA id q22sm17660250pgh.49.2019.08.27.09.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:58:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hr2567hrd.wl-tiwai@suse.de>
Date:   Wed, 28 Aug 2019 00:58:28 +0800
Cc:     bhelgaas@google.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0379E973-651A-442C-AF74-51702388F55D@canonical.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <s5hr2567hrd.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

at 23:25, Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 27 Aug 2019 15:47:55 +0200,
> Kai-Heng Feng wrote:
>> A driver may want to know the existence of _PR3, to choose different
>> runtime suspend behavior. A user will be add in next patch.
>>
>> This is mostly the same as nouveau_pr3_present().
>
> Then it'd be nice to clean up the nouveau part, too?

nouveau_pr3_present() may call pci_d3cold_disable(), and my intention is to  
only check the presence of _PR3 (i.e. a dGPU) without touching anything.

Kai-Heng

>
>
> thanks,
>
> Takashi


