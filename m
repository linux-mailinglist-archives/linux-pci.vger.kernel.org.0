Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E568268CDB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 16:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgINOFT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgINOBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 10:01:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CD2C06174A;
        Mon, 14 Sep 2020 07:01:18 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o8so61031ejb.10;
        Mon, 14 Sep 2020 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FsmZe5O0P/p3M0FxJ0XsG6dr4tN+XjGndrSeePOYVLQ=;
        b=TU+t16F+AZpDvpM6tmEpVlIOQPLAhoPE1cquCeN5k8AOwilOAwh3hRbANn1iX9S8tM
         Zr96G9ieyipocyYfh4C10UpY7mn2twBpkUzfb3GJBn0hkUioI4ehJW/UsMzMpNlBie4U
         +QK+3EOt+8mrpiLz+Dq+Di/QQnudOfmmTypvB06YKcRo8d60/5t/I1oPHkmHShQAXlXk
         z77Ql1eP1gt6V8/1VMigv8oxGZ9gnsoDRzPxevOxyJ3whaW332oGogVqJQKG6RyKw1Ae
         K0cCOtYC4oBurdA6d/AJlZ6F5+V8SkrcyP1wUH+knQFDyg3L6Vd8u1V9um0hlROtbCsi
         gYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FsmZe5O0P/p3M0FxJ0XsG6dr4tN+XjGndrSeePOYVLQ=;
        b=TmxiFTaybMJ6h97gYT6U73IqGFC1B2Ue02NjPBMJE7Zku7O6O295RZ/PjmZ5Zf6bpA
         7Hk8CZgQgOljugQ35uW279XE+sNgSArtab22NerjX3dMLoDPj5EbwINrhKnVksk150c0
         CDYtyVAdgV5zzMSh+DLS1B4TgyNyMkmYhCWAMzs6AEWCDcjP1q+WHQfMyWjKCHv8GiJo
         Cfjw5sB/eBYQUuyrjQqvkFY4OAXYUeOU1CHFoujNkqcJealtr5v1e76qYv1KE/UF5A3z
         qnTiKnZmyG8R3QXv9ZV3Kt7QnfS7GxfHsSaanOd3s581EneS7pmIA6j+lEzUo38YblfG
         5yAA==
X-Gm-Message-State: AOAM533nCSMehDXyRgir/iLU6jLTHQ+/QMIqd+u2nMxJ0d6jnumoDgGL
        jFiirpzqiXodqGNBS00Yzh0=
X-Google-Smtp-Source: ABdhPJy2UBdvzRal8bOeleN4BdmvWhzHCaeHXvF9L0vChKKrvPzgf77fC/MD+0rqVWQT2arqF3Ol0A==
X-Received: by 2002:a17:906:6b0b:: with SMTP id q11mr15310063ejr.412.1600092077249;
        Mon, 14 Sep 2020 07:01:17 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:3000:7936:d9d0:986e:cca5])
        by smtp.gmail.com with ESMTPSA id t4sm7770493ejj.6.2020.09.14.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:01:16 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 14 Sep 2020 16:01:15 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Matthias Brugger <matthias.bgg@gmail.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: make linux-mediatek list remarks
 consistent
In-Reply-To: <9c5aaa15-bdd8-ae4f-0642-092566ab08ba@gmail.com>
Message-ID: <alpine.DEB.2.21.2009141552570.17999@felia>
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com> <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com> <alpine.DEB.2.21.2009141208200.17999@felia> <9c5aaa15-bdd8-ae4f-0642-092566ab08ba@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, 14 Sep 2020, Matthias Brugger wrote:

> 
> 
> On 14/09/2020 12:20, Lukas Bulwahn wrote:
> > 
> > 
> > On Mon, 14 Sep 2020, Matthias Brugger wrote:
> > 
> > > 
> > > 
> > > On 14/09/2020 07:31, Lukas Bulwahn wrote:
> > > > Commit 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller
> > > > support") does not mention that linux-mediatek@lists.infradead.org is
> > > > moderated for non-subscribers, but the other eight entries for
> > > > linux-mediatek@lists.infradead.org do.
> > > > 
> > > > Adjust this entry to be consistent with all others.
> > > > 
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > 
> > > Maybe rephrase the commit message to something like:
> > > "Mark linux-mediatek@lists.infraded.org as moderated for the MediaTek PCIe
> > > host controller entry, as the list actually is moderated."
> > > 
> > > Anyway:
> > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > 
> > > > ---
> > > > applies cleanly on v5.9-rc5 and next-20200911
> > > > 
> > > > Ryder, please ack.
> > > > 
> > > > Bjorn, Matthias, please pick this minor non-urgent clean-up patch.
> > > > 
> > > > This patch submission will also show me if linux-mediatek is moderated
> > > > or
> > > > not. I have not subscribed to linux-mediatek and if it shows up quickly
> > > > in
> > > > the archive, the list is probably not moderated; and if it takes longer,
> > > > it
> > > > is moderated, and hence, validating the patch.
> > > 
> > > I can affirm the list is moderated :)
> > > 
> > 
> > Hmm, do we mean the same "moderation" here?
> > 
> > I believe a mailing list with the remark "moderated for non-subscribers"
> > means that a mail from an address that has not subscribed to the mailing
> > list is put on hold and needs to be manually permitted to be seen on the
> > mailing list.
> > 
> > Matthias, is that also your understanding of "moderated for
> > non-subscribers" for your Reviewed-by tag?
> 
> Yes.
>

Okay, then I guess my patch is actually VALID and can be applied.

> > 
> > I am not subscribed to linux-mediatek. When I sent an email to the list,
> > it showed up really seconds later in the lore.kernel.org of the
> > linux-mediatek public-inbox repository. So, either it was delivered
> > quickly as it is not moderated or my check with lore.kernel.org is wrong,
> > e.g., mails show up in the lore.kernel.org archive, even they were not
> > yet permitted on the actual list.
> > 
> 
> I'm the moderator and I get requests to moderate emails. I suppose I added you
> to the accepted list because of earlier emails you send.
>

Okay, I see. I did send some clean-up patch in the past, but I completely 
forgot that, but my mailbox did not forget. So, now it is clear to me why 
that mail showed up so quickly.

Thanks for the explanation.

Bjorn, with that confirmation and Reviewed-by from Matthias, could you 
please pick this patch?

Lukas
