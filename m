Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAAB268F79
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgINPRx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgINPRg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 11:17:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842C0C06174A;
        Mon, 14 Sep 2020 08:17:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so577965ejk.0;
        Mon, 14 Sep 2020 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qovCS0lUGNbN0RSVrQ4gEm2nnw0ctOzM5yUEbqbGJBg=;
        b=ZkkzAsQBhIKVoa25FG579fQzAwVnl657yNv8wR6Z7qurTMC3CE116UYbbOwNoa+OfS
         brLZD3gYnN2Kd++jo10cASyXbJdsFb0YxIL3kMt8qOoYABb7UmbOO9BB17CMaGkshbrO
         lUGYOZZN9YF2QhzPW4t0fw9Iex1gYCsdCFCKPRmoB76tR3rToehQ7oQuLqoWREK8Y6La
         imQ2+WoOi/5xlGImBATstUx2kcJTb/druQfjnUop0+KtZ6uKkMds5mHnLlaibJOxXYHS
         3dSpaRKTLqLATnmhmsDdQVhYxASrZG/E9c+NnyKtLlQBaFzHB+w8i01FJcBXfJKYPd6b
         uLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qovCS0lUGNbN0RSVrQ4gEm2nnw0ctOzM5yUEbqbGJBg=;
        b=S2yD1p9yWCZ8KQl3YniQWIVtMYl9bZQgzq8xsRH53Tz9O9LT4cjY2B8JYe2NODNtfl
         XtK5ZZXqjPQgr/jHSHR7qEuuWuAkbAtBtv4LI9LQDJdgBUOCA/WOhK/MYdMdb04Vs7VD
         7PUz2SiSiE1NMWDPJLSRtNusW7PWas/08xhL+OFWpCoGEEpFAKvnbc4LHNAJdzmnLrCN
         s4IylRnsRNAhr4OjO3kDU0t8zOXF0x1uOakaChRft00ABWgjkySJnd7ilPg8rwePbK5W
         9+/FiM9ukxqSeKjy/0rY3ucZ+WpznI09HZdMuq321itxvg57uH82ONXLqFekUsuAir1G
         Pwgg==
X-Gm-Message-State: AOAM5329KY1MNb5q9G19OrUhWGcOFKhfEYJed1w9OKGzDKXiq3HDZVnE
        HDWX2D2LRtHvYOWAlHhCyM0=
X-Google-Smtp-Source: ABdhPJxIAUFHAfu3RDslU9vgvwk6iqEcGv2wBvJ9c+hW9ci0omsWODnK1/P7J/8OY+IKJdWZqPSmfg==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr15895080eju.290.1600096653239;
        Mon, 14 Sep 2020 08:17:33 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:3000:7936:d9d0:986e:cca5])
        by smtp.gmail.com with ESMTPSA id a15sm7956002ejy.118.2020.09.14.08.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:17:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 14 Sep 2020 17:17:31 +0200 (CEST)
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
In-Reply-To: <7da64c0975c345f1f45034410c9ed7d509ba9831.camel@infradead.org>
Message-ID: <alpine.DEB.2.21.2009141715350.17999@felia>
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com> <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com> <alpine.DEB.2.21.2009141208200.17999@felia> <9c5aaa15-bdd8-ae4f-0642-092566ab08ba@gmail.com> <alpine.DEB.2.21.2009141552570.17999@felia>
 <7da64c0975c345f1f45034410c9ed7d509ba9831.camel@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-481114173-1600096652=:17999"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-481114173-1600096652=:17999
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 14 Sep 2020, David Woodhouse wrote:

> 
> AFAICT the linux-mediatek list isn't configured to automatically
> moderate messages from non-subscribers. Its generic_nonmember_action
> setting is 'Accept'. That is the default setting for lists on
> infradead.org and I strongly encourage list maintainers to leave it
> that way.
>

 
> Lukas, I don't see your address in the allowlist either.
> 
> There are other reasons why some messages get might trapped for
> moderation — the message size, number of recipients, spam score, etc.
> 
> The mere fact that *some* messages are moderated does not mean that the
> list is "moderated for non-subscribers" in the sense that the
> MAINTAINERS file lists.
> 
> > Bjorn, with that confirmation and Reviewed-by from Matthias, could you 
> > please pick this patch?
> 
> I think we should be fixing the ones that *do* say it's moderated for
> non-subscribers, not the one that correctly didn't :)
> 

--8323329-481114173-1600096652=:17999--
