Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2057B268FAF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgINPYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgINPYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 11:24:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E9AC06174A;
        Mon, 14 Sep 2020 08:24:01 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t16so18025906edw.7;
        Mon, 14 Sep 2020 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ibWutNLRYfpj9cLUsW6mKo/tcn9AM4qWn7Yan42NOHY=;
        b=sKE0Rk/x5fl66u4LCMVVyYLK+ImwzFZNzx5TqZPzWy2yrGyIcYsfeyeHfP5ItAZvXq
         bidOY37f/6tGajZApgg1NT0OZw8cd130iMVPOLx2fSciqTfJ3hfIK55HSE6rMldXmc/7
         DEi31UAEmnn/gl2Gj7ANdF/V3pE3JpD1q0BazD190FHlqGnWT9p/pY9VduYZVWEeSqrL
         weej1czq1D976bYZv+W3ud2nMAw0Rjbzby0wF5+fq6Zrjn/HjaWITc1Xg8bbM7qelP57
         UZcwrwKwBhY3blTgOfAPEPCZUW5Nh0OOlyDL+YYHQn/X54gRJQ+hasyPqBUw9mDDlJkL
         HQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ibWutNLRYfpj9cLUsW6mKo/tcn9AM4qWn7Yan42NOHY=;
        b=bR+xMucWgZXtsIQS3CuxnWi37EuFqevf6xUN8XLOZqFJd7IqmdaA4qwn+/76T3vQXm
         cwchtAEhQJ+uDT9jMv8Yk5VYadAFrIQefHAft/U4KdTkife0cg0eRqawf5n1O4tlJSA1
         aYDJCzGMU4EzY8UAzHPAyokWRrBQo1SOT5Gd6Kx2xe5AymJoZ49YKCgfPe3d40QY4mZ3
         ob4BTed1E4/uBDtccNyXs7X53R3rvZHFnuWD7oGeNRzhp2YI7rHq4XTwHBgHWOPZ2YAH
         TOkhd0BWoAIwx9VtL3SF6Vm4q5T6NRj/DU7ozcfZEU6F7BCwh4GuDIgFVD3Nk7Hr3+vG
         TAjw==
X-Gm-Message-State: AOAM531wr62wr5NvoDYBFRAJrPTpMMY/jjv/6wWiSyKB9Ffu5RsD9Ukq
        O2+1HCmAhP0EWSLubxgEa2E=
X-Google-Smtp-Source: ABdhPJzmyEdje9c+g8XGhG0iewYFWKhkL1HmaOQ2Fng4S0zg4tjGh4ORre25NR4k4zcLeOa5AvGFUQ==
X-Received: by 2002:a50:9fa1:: with SMTP id c30mr17336095edf.207.1600097040413;
        Mon, 14 Sep 2020 08:24:00 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:3000:7936:d9d0:986e:cca5])
        by smtp.gmail.com with ESMTPSA id lo25sm7949146ejb.53.2020.09.14.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:23:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 14 Sep 2020 17:23:58 +0200 (CEST)
X-X-Sender: lukas@felia
To:     David Woodhouse <dwmw2@infradead.org>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: make linux-mediatek list remarks
 consistent
In-Reply-To: <f511570405799df421397ff65847e927745dad08.camel@infradead.org>
Message-ID: <alpine.DEB.2.21.2009141717470.17999@felia>
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com> <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com> <alpine.DEB.2.21.2009141208200.17999@felia> <9c5aaa15-bdd8-ae4f-0642-092566ab08ba@gmail.com> <alpine.DEB.2.21.2009141552570.17999@felia>
 <7da64c0975c345f1f45034410c9ed7d509ba9831.camel@infradead.org> <alpine.DEB.2.21.2009141615020.17999@felia> <f511570405799df421397ff65847e927745dad08.camel@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, 14 Sep 2020, David Woodhouse wrote:

> On Mon, 2020-09-14 at 16:57 +0200, Lukas Bulwahn wrote:
> > Well, I am happy to send any PATCH v2. I guess we, you, David, Matthias 
> > and I, now just need to determine if the list is moderated or not.
> 
> It really isn't.
> 
>  # /usr/lib/mailman/bin/config_list -o- linux-mediatek | grep -B5 ^generic_nonmember_action
> # legal values are:
> #    0 = "Accept"
> #    1 = "Hold"
> #    2 = "Reject"
> #    3 = "Discard"
> generic_nonmember_action = 0
> 

David, I guess if you have access to the ground truth on 
lists.infradead.org, maybe you can dump the actual setting for all those 
lists?

$ grep "lists.infradead.org" MAINTAINERS | sort | uniq

L:	ath10k@lists.infradead.org
L:	ath11k@lists.infradead.org
L:	b43-dev@lists.infradead.org
L:	kexec@lists.infradead.org
L:	libertas-dev@lists.infradead.org
L:	linux-afs@lists.infradead.org
L:	linux-amlogic@lists.infradead.org
L:	linux-arm-kernel@lists.infradead.org
L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
L:	linux-mediatek@lists.infradead.org
L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
L:	linux-mtd@lists.infradead.org
L:	linux-nvme@lists.infradead.org
L:	linux-parport@lists.infradead.org (subscribers-only)
L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
L:	linux-riscv@lists.infradead.org
L:	linux-rockchip@lists.infradead.org
L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
L:	linux-snps-arc@lists.infradead.org
L:	linux-um@lists.infradead.org
L:	linux-unisoc@lists.infradead.org (moderated for non-subscribers)
L:	wcn36xx@lists.infradead.org


They are all reporting different settings and linux-mediatek and 
linux-arm-kernel even inconsistently. The inconsistency and a poor attempt 
to resolve that is what started this discussion.

I can then send out the patch to adjust MAINTAINERS to your ground truth 
from the server.

Thanks for your support,

Lukas
