Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DF3923A3
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 02:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhE0AOw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhE0AOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 20:14:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8393FC061574;
        Wed, 26 May 2021 17:13:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id lr4-20020a17090b4b84b02901600455effdso145973pjb.5;
        Wed, 26 May 2021 17:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MK8a+wfYbMpZQpkMTO0OrrMNbE1xthA2KsqFjKZmXxY=;
        b=lcjllHOuDcrH69QG2w9thgwDkpvfPP8QjTCtnCNQF+bzTG3yyrew7geBnk32udsm7y
         qN3qkJdKXsmlkpFpF1axvZxCHwQeltQDNtiYuQaYiPctTfJpHI/p1PUuyzwePPmBBXpi
         57KHnXuCc5ThYYrDV4T76wFViiGwRo0SDwfpUzHXc0QdN2iqqAWboqMi8RSRhKMsFJnB
         4jia+ZmeAg7tFS+h5LWRV3ApWjRGMt+Bh0nc9oQSlpmPFv5bk9nyuzQ0bCy7tTohgn0f
         34wcaGpfPYENnBvO2rKU/+gF308QNHL+NOyvQsPKutJHTLceYufM2B9VB6YMwrPooeDM
         WRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=MK8a+wfYbMpZQpkMTO0OrrMNbE1xthA2KsqFjKZmXxY=;
        b=sGrvPmLide6aJHp8qUQPhwc+sOi1Nn6UYVGgV3uxwyMc7u7vmnU2Gw7YCm+RFn0Viy
         MI4xiHQafNpZr13hkxkMLEtMOOk0l4vYvcWGU3+pZdkzlYUfEY1wBk5W9FQtuOAP5UAO
         +YJ1X4P4U7m9H99fNTMiaFrXGwQvvatDGjTOvwpV2cVPgwSppOy9Lns3jncQkwzCJeNw
         Z9U5ujTJKwBf6+IsHVZJZWWgog1QATQk4mooP0obaglg+pkHqcDH/WtMy98NScuFuZgP
         0xPakHtuzQGjpCsGppbXcKVWQ7pS2BApmicukTrddJkAcsAips79C44N5owmBWktVpZe
         DbEQ==
X-Gm-Message-State: AOAM533Vteb/eZOzs6HIoExQVzz5rSUCpJWgRNuceDXKEcus0xml5WUf
        F7c6Ufg9IN9fbohUEe77GZA=
X-Google-Smtp-Source: ABdhPJzUL5NJM4VTL7cocKg5ZVC2mJ+Wumyfgb51EzO/Yhg59dNUggwYPSJgoIzZDQ/TMAzaGigE1A==
X-Received: by 2002:a17:90a:8581:: with SMTP id m1mr774224pjn.47.1622074399842;
        Wed, 26 May 2021 17:13:19 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id c71sm282310pfc.148.2021.05.26.17.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 17:13:18 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        PCI <linux-pci@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Update PCI host bridge window to
 32-bit address memory
References: <20210526133457.3102393-1-punitagrawal@gmail.com>
        <CAL_JsqLYdXFG11oSmrAfcRoCkSPQYY-VvTr=QVOn8DDmDjm-dQ@mail.gmail.com>
Date:   Thu, 27 May 2021 09:13:15 +0900
In-Reply-To: <CAL_JsqLYdXFG11oSmrAfcRoCkSPQYY-VvTr=QVOn8DDmDjm-dQ@mail.gmail.com>
        (Rob Herring's message of "Wed, 26 May 2021 09:00:51 -0500")
Message-ID: <87a6ohniec.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thanks for taking a look.

Rob Herring <robh+dt@kernel.org> writes:

> On Wed, May 26, 2021 at 8:35 AM Punit Agrawal <punitagrawal@gmail.com> wrote:
>>
>> The PCIe host bridge on RK3399 advertises a single address range
>> marked as 64-bit memory even though it lies entirely below 4GB. While
>> previously, the OF PCI range parser treated 64-bit ranges more
>> leniently (i.e., as 32-bit), since commit 9d57e61bf723 ("of/pci: Add
>> IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses") the
>> code takes a stricter view and treats the ranges as advertised in the
>> device tree (i.e, as 64-bit).
>>
>> The change in behaviour causes failure when allocating bus addresses
>> to devices connected behind a PCI-to-PCI bridge that require
>> non-prefetchable memory ranges. The allocation failure was observed
>> for certain Samsung NVMe drives connected to RockPro64 boards.
>>
>> Update the host bridge window attributes to treat it as 32-bit address
>> memory. This fixes the allocation failure observed since commit
>> 9d57e61bf723.
>>
>> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
>> Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> ---
>> Hi,
>>
>> The patch fixes the failure observed with detecting certain Samsung
>> NVMe drives on RK3399 based boards.
>>
>> Hopefully, the folks on this thread can provide some input on the
>> reason the host bridge window was originally marked as 64-bit or if
>> there are any downsides to applying the patch.
>
> We can't require *only* a DT update to fix this. Ideally, the Rockchip
> PCI driver should clear the 64-bit flag in the resources though I'm
> not sure if the bridge driver would have access early enough.

Following the discussion in the other thread, I tested the following
changes to fixup 64-bit flag for non-prefetchable memory resources that
fit below 4GB.

If the changes look good, I'll send it out as a proper patch later
today.

---->8----
diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index da5b414d585a..b9d0bee5a088 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -565,10 +565,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
                case IORESOURCE_MEM:
                        res_valid |= !(res->flags & IORESOURCE_PREFETCH);

-                       if (!(res->flags & IORESOURCE_PREFETCH))
+                       if (!(res->flags & IORESOURCE_PREFETCH)) {
                                if (upper_32_bits(resource_size(res)))
                                        dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
-
+                               if ((res->flags & IORESOURCE_MEM_64) && !upper_32_bits(res->end)) {
+                                       dev_warn(dev, "Overriding 64-bit flag for non-prefetchable memory below 4GB\n");
+                                       res->flags &= ~IORESOURCE_MEM_64;
+                               }
+                       }
                        break;
                }
        }
