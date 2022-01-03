Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C362483025
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jan 2022 12:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiACLAo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 06:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiACLAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jan 2022 06:00:43 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A295C061761;
        Mon,  3 Jan 2022 03:00:43 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id s4so37229758ljd.5;
        Mon, 03 Jan 2022 03:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=RnaPEQ+GyYbouV07jQ/IDGsy7R+lQFdvlf3G6ZfyaFc=;
        b=Ay/XTzWWTXvXdqT7IwGdNk+yxkvX6sKycrg4hnxQ+GO2J3WdleMQ+t8KT8M0NAenWl
         fySEaxaEu20d4dnFodKIk35SoPr0f3MOJ5pLdkTe61mICEhRnz1pBBFx+leug6dp50Ta
         MiHqr0z9n9TKlG6XU+J6Lr8PSmJ/mDeq4KQn6n62hxNxsvBGhVSfDcHrJhTR4g6XVxYz
         DJFcNyoDIQprap5fyJbVBgmo5ADfWkDnca+d2Q1PeZICWsc5IxGPJebW+VC7OThfuWPT
         LNzqJP2U6v5uLN1IK36zxhx/V8U2eUotOOvNbe935QQ9LAnl4xZZhfSdj63HaxJqkG2W
         N4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=RnaPEQ+GyYbouV07jQ/IDGsy7R+lQFdvlf3G6ZfyaFc=;
        b=IwvQ92au6SK/zFsgrjnAT/57fa+BedeoLpddEu2eCfGOptuAuF6MtP0zY9LXV5Wu53
         2YuxjkdyxfA8P3E2J9EUxKu6uwTdDHsWkPN8Bnb2d5BnvtJiqrmpSSJ9fymYRENcKBxH
         ozbjg/o3GR4qyFIZLmJadhu+GLEbp+a/hNqmmqBrI9hMOfah/lILeC5UxC7ERxQXxOqg
         y9Wk/RnfSrMCTf434VQTfYJrh0r2aAjjUx4pK3K4n+Qyp9khAO/i34IBv+6fIf3YOcXP
         Qdikfy/a9826dtVG4udpxRsUfy92xDVb4hh24EoOMPMBldfGSn+YwbAfP5MJnVwxr3D+
         x7oQ==
X-Gm-Message-State: AOAM533bAyI65TeHANV6X5LLsYGadDcjG8qzx3qW2dcNvBdRmzK+8P2v
        49kXGL/uGbl0wg1VoiRu/cs=
X-Google-Smtp-Source: ABdhPJycAZukdzBB1w2zWJkGxFA8SthDX9yApe13iw6iQ3W3TTUUwlVClmkH6dKoKHYs1efB2lgPNg==
X-Received: by 2002:a05:651c:1993:: with SMTP id bx19mr21135430ljb.472.1641207641510;
        Mon, 03 Jan 2022 03:00:41 -0800 (PST)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id q2sm1322382lfr.64.2022.01.03.03.00.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 03 Jan 2022 03:00:40 -0800 (PST)
Message-ID: <61D2D9B5.7080401@gmail.com>
Date:   Mon, 03 Jan 2022 14:10:45 +0300
From:   Nikolai Zhubr <zhubr.2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@kernel.org>,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/PCI: SiS PIRQ router updates
References: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Maciej,

Apparently, my previous replies (of 11-sep-2021 to 16-sep-2021) with 
some observations somehow went to spam box or whatever. I was going to 
retry but got too busy with unrelated stuff at that time. I can re-send 
them if necessary.

Anyway. Yes, your patch is very usefull. I've tested it quite thoroughly 
back then, including sharing IRQs for 2 unrelated PCI devices etc. I 
have it always automatically applied in my private trees since then.

One peculiarity with my specific board is that I had to also patch ROM 
BIOS because it included some non-standard $IRT table instead of $PIR 
table. With that in place, it now Just Works.

Thank you again for your effort,

Regards,

Nikolai


03.01.2022 2:24, Maciej W. Rozycki:
> Hi,
>
>   Reposting as this has gone nowhere.  Regenerated for line changes and
> with Nikolai's Tested-by annotation for 2/2, which now have been verified
> in combination with generic PIRQ router updates posted separately (there's
> no ordering dependency between the two patch series).
>
>   Nikolai has observed the trigger mode not being fixed up once it has been
> incorrectly set by the BIOS for PCI devices, causing all kinds of usual
> issues.  As it turns out we don't have a PIRQ router defined for the
> SiS85C497 southbridge, which Nikolai's system uses, and which is different
> from the SiS85C503 southbridge we have support for.
>
>   As we use the generic `sis' infix (capitalised or not) for the SiS85C503
> southbridge I have prepared this small patch series to first make the
> existing SiS program entities use a more specific `sis503' infix, and then
> provide a suitable PIRQ router for the SiS85C497 device.
>
>   See individual change descriptions for further details.
>
>   Please apply.
>
>    Maciej
>

