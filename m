Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44DD268424
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 07:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgINFjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 01:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINFjc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 01:39:32 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520DC06174A;
        Sun, 13 Sep 2020 22:39:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so21369894ejb.4;
        Sun, 13 Sep 2020 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0ftNeFkIdq9io+RywVag+/vyB7FE8lzg55s4F7kUuI0=;
        b=SnE+7oOa5bqFRiQs4WAusSe6Hmnjw/2MoE3kNjWOVoqjIkYOCaa6soNFn+qIClrrUd
         CYYchI+hUPm/RH2nBzIwgwXZ3+uS4jicw+FWXAv57JbpBM7qzK9x2taUVABBNHV1HqBZ
         LCV0jYAFXId2pR3Ycwg3czyks3GOiF6L88Gz86PKRNMbNpdVQ0x6EuRcZ+pSTvFQA1xN
         qkM8Aa4nMna5conpbmUosbDDaEU9KsBdA+552ockHTd0Ob4eh3b/IuheouFFYvWui9Bi
         pffDCxDf9wCMPVyNZo0NxEfY2eEY33P67m+2P2l0lralMpdFPv21s9DOPfLcnSHTSMEI
         1VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0ftNeFkIdq9io+RywVag+/vyB7FE8lzg55s4F7kUuI0=;
        b=m37IYUwxcCpqG/2+gpi7wEPEEcBEgOdp9nmLYUmJOVnGYA1nuud/ZWANan2Sr55AFq
         DdxUD8N1172n+RTm7kCv4Ll0Xpvrka6TZGsWe5jF45bnPKGhtoX/dup6nb283oLCArtp
         +N2OaNlVWqlyKmuQGB/GkMhwcUz/Y9vR4Yv/XOHmFEYtBng5uX2mc4C6XHmUnIlDw3Gn
         3flfo9lSnLrENI9zu3JlUiOXiV6qTMzzSY/3PCLb43p4UhcnF4f0suvNZL3aK8QOMHz3
         RduB7vvrkJpA2oX/VXBoRk852zxg8xG50XGVhA/cLFbV9/em4O/T2vbBOAs8Wa+IWzXc
         cy5Q==
X-Gm-Message-State: AOAM531chb9u+d+7lnB7aiZpx8xamgkiL//zb1nug+pHxCrt2dlKXvwE
        tFxBvuxPsBVVQeC/Fv2mqo8=
X-Google-Smtp-Source: ABdhPJwYE0wstxgC6zfi9o0oOP+ME0JkQsXu3OIXAIXkBT3aQiHB87ndT7jRCyc625JJFYlGFM4S4g==
X-Received: by 2002:a17:906:1185:: with SMTP id n5mr13091694eja.495.1600061986990;
        Sun, 13 Sep 2020 22:39:46 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:3000:7936:d9d0:986e:cca5])
        by smtp.gmail.com with ESMTPSA id w8sm6899298ejo.117.2020.09.13.22.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 22:39:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 14 Sep 2020 07:39:40 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: make linux-mediatek list remarks
 consistent
In-Reply-To: <20200914053110.23286-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.21.2009140738570.24617@felia>
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, 14 Sep 2020, Lukas Bulwahn wrote:

> Commit 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller
> support") does not mention that linux-mediatek@lists.infradead.org is
> moderated for non-subscribers, but the other eight entries for
> linux-mediatek@lists.infradead.org do.
> 
> Adjust this entry to be consistent with all others.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on v5.9-rc5 and next-20200911
> 
> Ryder, please ack.
> 
> Bjorn, Matthias, please pick this minor non-urgent clean-up patch.
> 
> This patch submission will also show me if linux-mediatek is moderated or
> not. I have not subscribed to linux-mediatek and if it shows up quickly in
> the archive, the list is probably not moderated; and if it takes longer, it
> is moderated, and hence, validating the patch.
> 

Okay, my patch showed up within seconds in the archive:

https://lore.kernel.org/linux-mediatek/20200914053110.23286-1-lukas.bulwahn@gmail.com/


I think the linux-mediatek list is actually NOT _moderated for 
non-subscribers_.

Please IGNORE this patch until someone can confirm if it is moderated or 
not. I will then send the patch that reflects the actual state.

Thanks, Lukas
