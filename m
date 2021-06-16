Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372363A9B5F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 15:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhFPNCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbhFPNCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 09:02:33 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3FFC061767;
        Wed, 16 Jun 2021 06:00:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t13so1875495pgu.11;
        Wed, 16 Jun 2021 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nbiAswAKlZ0y8YPJxSeoqwYopSHf2ViQ7XrbNtGNP7U=;
        b=uXdMqCkrPWNTiKAf7OMydRO333IWQVnoKc7TSmyHW5AYBvNUsSNHX8CKo0EWS6/YaH
         cilJMMRHTtZoK77Rk3pA9OB5r2+C2dSFKrYVFSrvJ/4xLQF9uu9LTvM+mRzB5Rw0iu+h
         8/qeGU2sQ2XZ4eE0uJgV07fAIW+Gbb+W71HdY4dT1bVxwRar8jpbEwI9nM/KyBxgpfqg
         RQ1+qoMD+Mx5MiBEem6KLuIp5E2Qzff47pZG9iOMLOsdBtLwT1UsPFY31vge55jumMBf
         7gcYCwkqDUa5eNWwPQisr6w5Q5i9/0iAh3nsxC81jJOG0NB5kpxJR3S6fgnR3u7X8QU3
         chzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=nbiAswAKlZ0y8YPJxSeoqwYopSHf2ViQ7XrbNtGNP7U=;
        b=tvWpdk+02wzGR+nQnHs1frHSGRfuIESP0w1V7Fg6D5PrPgmdn0UJ90iubrA9tRsrIa
         W2Bw5oaYJn6zBg4B+bt0OgqGU85ne9LMfq7XfWWNDZM9D+CsE5lSSnjbH0pidCgT0GMt
         BvapRj+I5EO0NLNU/9wRbKtj3mftXZfhjyO1dtIm1i8TiVX4r4TPPaPrt8ZRICWx3yAQ
         V7H0Dr7RkKggWKk+x7CEyZzeEypqa9y9dHNDgiI686UY+15gVNp/iT/p97Pi0D//Hoy9
         juIrQPpN0FL82vhF8Mrs2iHrSIdYsT2Av9U3OqBxMnPK6++4IRxVeLesmBo4WVfogBX2
         p8Hw==
X-Gm-Message-State: AOAM533CMYr/FHmuvoXWpu4vij9tpaPKn0j/+6hAGj3EKxZeOiRzVFB6
        4PRN9fuwC+dY2FAycDIvGyo=
X-Google-Smtp-Source: ABdhPJzICrZwP7kf4FTaRUp8e7LF5XaMDQHdJRB1XT5FoGculVj+18BbPpYXhqA4KlHFVFaYJsOlkA==
X-Received: by 2002:a62:ae03:0:b029:2f8:b04f:c012 with SMTP id q3-20020a62ae030000b02902f8b04fc012mr9593948pff.62.1623848424167;
        Wed, 16 Jun 2021 06:00:24 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id h18sm2394018pgl.87.2021.06.16.06.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 06:00:23 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Update PCI host bridge
 window to 32-bit address memory
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
        <3105233.izSxrag8PF@diego>
        <CAL_JsqL8iDo5sLmgNVuXs5wt3TpVJbKHfk7gE740DidmvLOwiQ@mail.gmail.com>
        <3238453.R1toDxpfAE@diego>
Date:   Wed, 16 Jun 2021 22:00:21 +0900
In-Reply-To: <3238453.R1toDxpfAE@diego> ("Heiko =?utf-8?Q?St=C3=BCbner=22'?=
 =?utf-8?Q?s?= message of "Tue, 15
        Jun 2021 23:49:07 +0200")
Message-ID: <871r92t15m.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Heiko St=C3=BCbner <heiko@sntech.de> writes:

> Am Dienstag, 15. Juni 2021, 23:29:12 CEST schrieb Rob Herring:
>> On Thu, Jun 10, 2021 at 3:50 PM Heiko St=C3=BCbner <heiko@sntech.de> wro=
te:
>> >
>> > Hi,
>> >
>> > Am Montag, 7. Juni 2021, 13:28:56 CEST schrieb Punit Agrawal:
>> > > The PCIe host bridge on RK3399 advertises a single 64-bit memory
>> > > address range even though it lies entirely below 4GB.
>> > >
>> > > Previously the OF PCI range parser treated 64-bit ranges more
>> > > leniently (i.e., as 32-bit), but since commit 9d57e61bf723 ("of/pci:
>> > > Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
>> > > the code takes a stricter view and treats the ranges as advertised in
>> > > the device tree (i.e, as 64-bit).
>> > >
>> > > The change in behaviour causes failure when allocating bus addresses
>> > > to devices connected behind a PCI-to-PCI bridge that require
>> > > non-prefetchable memory ranges. The allocation failure was observed
>> > > for certain Samsung NVMe drives connected to RockPro64 boards.
>> > >
>> > > Update the host bridge window attributes to treat it as 32-bit addre=
ss
>> > > memory. This fixes the allocation failure observed since commit
>> > > 9d57e61bf723.
>> > >
>> > > Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> > > Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911=
@arm.com
>> > > Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> > > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> > > Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> > > Cc: Heiko Stuebner <heiko@sntech.de>
>> > > Cc: Rob Herring <robh+dt@kernel.org>
>> >
>> > just for clarity, should I just pick this patch separately for 5.13-rc=
 to
>> > make it easy for people using current kernel devicetrees, or should
>> > this wait for the update mentioned in the cover-letter response
>> > and should go all together through the PCI tree?
>>=20
>> This was dropped from v4, but should still be applied IMO.
>
> It was probably dropped because I applied it ;-)
>
> It's part of armsoc already [0] and should make its way into
> 5.13 shortly.

Thanks for sending the patch along. I left a note to the effect in v4
but it's easy to miss.

Hopefully all sorted now.

[...]
