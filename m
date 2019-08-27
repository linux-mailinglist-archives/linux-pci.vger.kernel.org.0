Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022839EB7F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 16:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfH0OuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 10:50:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0OuO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 10:50:14 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2cnU-00040x-78
        for linux-pci@vger.kernel.org; Tue, 27 Aug 2019 14:50:12 +0000
Received: by mail-pg1-f199.google.com with SMTP id l11so11920816pgc.14
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2019 07:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QPtHqzYE2I3K6mA1W43Ow1hu2cfsdV6r/QSBv6PmVXE=;
        b=c/c25QdU5tXbfQr6jyS5zcRoZZLimP8SbPEYGVSm8JMAeqxzQYl9lyLoapdFMLr5Zv
         1rmllFd7P780P4X1bf8+gZb2Z4gPC75LQ0jQooNj8/w1bWN+bifPLr9JZk7b5H9uZvo+
         2fx+fw2n5YzziqYG4YoE02XqTUdJg9/BnggOr63ab7CHrQs31aNF/RJuDeMaHHxOU6CZ
         zOcdIKhojG8zKOkQXV5XdSQV23IEU8aPF013gzHBWFGM2ewfsHFkTiMN8yqghhiZVGXD
         AE3/UJNfjnWRtAWakagU8KqDwrJCUoTaHEoSrOtuO57JHv9HYll8SzluIeT5L6W+x2gq
         Yzpg==
X-Gm-Message-State: APjAAAUPUhFjgzRbpudnBYbTuTXZZOQH4SF1p8QRHHzICsNTuRcxZ40t
        8tIBofUQxx4IYhI9fM5wfBxIDs4Msyka1x7OPwVRNUBK9AGVLjdkussZfVRxB1EG8+FBpL+PM3F
        d2uZG8nL0tLmt9LM763G5+LUtXYQJJS2CTE/Kxg==
X-Received: by 2002:a17:90a:3b4f:: with SMTP id t15mr26629453pjf.45.1566917410961;
        Tue, 27 Aug 2019 07:50:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxD/9UP/HN0ldJtPRSnTlHHh4+NxXjhXptKrorWOlvZ1KnXW9fodYpfoV5J9JPcZXw61pCu5A==
X-Received: by 2002:a17:90a:3b4f:: with SMTP id t15mr26629428pjf.45.1566917410640;
        Tue, 27 Aug 2019 07:50:10 -0700 (PDT)
Received: from 2001-b011-380f-3c42-843f-e5eb-ba09-2e70.dynamic-ip6.hinet.net (2001-b011-380f-3c42-843f-e5eb-ba09-2e70.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:843f:e5eb:ba09:2e70])
        by smtp.gmail.com with ESMTPSA id q8sm2479848pjq.20.2019.08.27.07.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 07:50:10 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190827134756.10807-2-kai.heng.feng@canonical.com>
Date:   Tue, 27 Aug 2019 22:50:03 +0800
Cc:     linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <97D68761-4152-4D77-B222-14EA892503DB@canonical.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <20190827134756.10807-2-kai.heng.feng@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, tiwai@suse.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

at 21:47, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> It's a common practice to let dGPU unbound and use PCI port PM to
> disable its power through _PR3. When the dGPU comes with an HDA
> function, the HDA won't be suspended if the dGPU is unbound, so the dGPU
> power can't be disabled.
>
> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") only allows HDA to be runtime-suspended once GPU is
> bound, to keep APU's HDA working.
>
> However, HDA on dGPU isn't that useful if dGPU is unbound. So let relax
> the runtime suspend requirement for dGPU's HDA function, to save lots of
> power.
>
> BugLink: https://bugs.launchpad.net/bugs/1840835
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> —

Forgot to mention that for some platforms this issue happen after commit  
b516ea586d71 ("PCI: Enable NVIDIA HDA controllers”) which starts to unhide  
the “hidden” HDA.

Kai-Heng

>  sound/pci/hda/hda_intel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 99fc0917339b..d4ee070e1a29 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1285,7 +1285,8 @@ static void init_vga_switcheroo(struct azx *chip)
>  		dev_info(chip->card->dev,
>  			 "Handle vga_switcheroo audio client\n");
>  		hda->use_vga_switcheroo = 1;
> -		hda->need_eld_notify_link = 1; /* cleared in gpu_bound op */
> +		/* cleared in gpu_bound op */
> +		hda->need_eld_notify_link = !pci_pr3_present(p);
>  		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
>  		pci_dev_put(p);
>  	}
> -- 
> 2.17.1


