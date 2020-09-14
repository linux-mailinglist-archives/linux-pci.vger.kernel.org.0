Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6F268EA0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgINO57 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgINO5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 10:57:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28ADC06174A;
        Mon, 14 Sep 2020 07:57:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so452947ejb.1;
        Mon, 14 Sep 2020 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Xh4tD223j00jU7T+Vd43Uj9fI1q3F/mpuVRkoDMYyKs=;
        b=GDQV6/KlhWsmL1rEsCarprshmGJdUWS/ItNbt1hdUP+hquCmAK2EBAvPbuO9hNUeNT
         gpil2zbDpNeMWDyOHN7FIa4OEnMzRZbHp1Ptt8vq2EfViROkyIwzl2SUGC61D9+GK6m3
         diaXUiJ71sCdORzU/9+cd6XlwnUk2m0PZOpGJY8yj+mUBgjZ5Jts2WfRXM4RA5C82wYY
         bcqN1zeQLBy96ls/tFFFIRV9uVzSQChTedkI8pzrWVLT4Ml+/oUBZ/v5jBVe3ipRE4wi
         SDFFfQUMX266jrgL9ZJjBSPxet5P8LzJxbRoaYhR2n5rphJo4nuI1ugWkmK7HvAImwJf
         VPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Xh4tD223j00jU7T+Vd43Uj9fI1q3F/mpuVRkoDMYyKs=;
        b=KcsJ1DeXisdbyj2sM7+xWnwb3NIRTXxVx2wqO6fZzwmaV1zDosdqAJRYZa/Hp+w/8e
         IT2JqPzGjHCuegz4+68X/17jPbkmRc7yINVF+auRufjE4a98Hol2TJfLHyBIKjmLCGnV
         rGQTUMbpNN6m8CoZ+8MLaGT6lxmvCvz5AkM/k+vl10xN/mydZ74tqfuziFyI9TZzMhup
         gKaN1s8NlUMWEXRd90lYQDYiGuINeNH8kTJdj1MCo+weoj5gZiUxu2hkB6qL09gW27FM
         dL1T6K4EvrByQ8Va29Aba2L8oph1Y9HgU7uNKcwMDMqKEqR1dXjLupek9ZAma4+68iOc
         lmlg==
X-Gm-Message-State: AOAM5334O19IV3AHEnjIRgK+DwyPXhU7yzraHuaOqujJ1nk5dKNj66BX
        fmTdw2DwcAAwXukjicgZBV8=
X-Google-Smtp-Source: ABdhPJx+0myKK4AhShO6TTXm3+70MJAFc8OcZXHuIWnyTyYe9sX1qwfdEKa81XG8Kuu4WfzQsX5GQA==
X-Received: by 2002:a17:906:46d5:: with SMTP id k21mr14873627ejs.247.1600095465580;
        Mon, 14 Sep 2020 07:57:45 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:3000:7936:d9d0:986e:cca5])
        by smtp.gmail.com with ESMTPSA id d13sm9440145edu.54.2020.09.14.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:57:44 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 14 Sep 2020 16:57:43 +0200 (CEST)
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
Message-ID: <alpine.DEB.2.21.2009141615020.17999@felia>
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com> <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com> <alpine.DEB.2.21.2009141208200.17999@felia> <9c5aaa15-bdd8-ae4f-0642-092566ab08ba@gmail.com> <alpine.DEB.2.21.2009141552570.17999@felia>
 <7da64c0975c345f1f45034410c9ed7d509ba9831.camel@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1939471326-1600095464=:17999"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1939471326-1600095464=:17999
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 14 Sep 2020, David Woodhouse wrote:

> On Mon, 2020-09-14 at 16:01 +0200, Lukas Bulwahn wrote:
> > > > I am not subscribed to linux-mediatek. When I sent an email to the list,
> > > > it showed up really seconds later in the lore.kernel.org of the
> > > > linux-mediatek public-inbox repository. So, either it was delivered
> > > > quickly as it is not moderated or my check with lore.kernel.org is wrong,
> > > > e.g., mails show up in the lore.kernel.org archive, even they were not
> > > > yet permitted on the actual list.
> > > > 
> > > 
> > > I'm the moderator and I get requests to moderate emails. I suppose I added you
> > > to the accepted list because of earlier emails you send.
> > > 
> > 
> > Okay, I see. I did send some clean-up patch in the past, but I completely 
> > forgot that, but my mailbox did not forget. So, now it is clear to me why 
> > that mail showed up so quickly.
> > 
> > Thanks for the explanation.
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

Well, I am happy to send any PATCH v2. I guess we, you, David, Matthias 
and I, now just need to determine if the list is moderated or not.

I will then adjust MAINTAINERS to the final conclusion.

Lukas
--8323329-1939471326-1600095464=:17999--
