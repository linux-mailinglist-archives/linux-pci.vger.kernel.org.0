Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99157268927
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgINKUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgINKU3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 06:20:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73BC06174A;
        Mon, 14 Sep 2020 03:20:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n22so17025879edt.4;
        Mon, 14 Sep 2020 03:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RoEDgYihJB01PzODFzv542pnHyd2X+jx2GeNGs8P7lM=;
        b=Cjbbsi1oaU+n4Sw3Yn6dcLNg/l1FbrB3FTZTu0iKHy7rzjjM+/0r10+OCfugIUo7ut
         lB1iq5C51oGl6OQXI+BblM0EN/71Cl2RmETQIlZdO6EblNqB28jY74qYWCxWBrT3tWA1
         8I3dJKkX6fjz5AKlY8WeDDuSNUWREPrCqkqgRH51KfkvA8L4yzy92rwEqdQUNo4Tmc8H
         5vY4LfiakvXqUp2z/gPpMiXv6h6CKbiNGJBcd3uTMLtDFn4GkWtQcKz2qB+bjdu1k8B4
         xyJ6Aiqm42wFZNdIXsRmXLHCbCWat2aCGI7RJ5ka+frSkn+k2Mzv8+6WD09ujdRpduZ/
         ZjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RoEDgYihJB01PzODFzv542pnHyd2X+jx2GeNGs8P7lM=;
        b=A+Vp7eifjpA/lRbAUS3Xg4NjqVk/uUNvezKOSTfuJ5EYma8G91GIo36DtEF7NvPbmp
         WDntl3KTUGzLnxsNQxI49Q54u6OdOMknMa9qpjGzVxvCwCbpFFkWCfCBdpGtp1BXSD96
         MkqtJtOWjNvso2w2q7eMqoxm1uYX6iN6+vHkTuDlNI4iLzYUtld9pDZfERCEBwuy9vuz
         nUYJYi0BkjQlvb/Yi81tsmYHLgYwePOfvGsdQYuXpu86LRfcsutEv/JK0y2vMIK2G9mo
         HmWKi0RqqhrJChxISYsW0Lsrx5OLXSIbmKAgHaRVpT6eN/BiQXo/c/gHWiFt22GrgPo4
         4ioQ==
X-Gm-Message-State: AOAM5321w0+y7f4AdUGbdlf9msg7B6+1k9nDtjt+uAvD0SxMLKj/ouwL
        ce5TaIcKO2UUNgS2lWbHECE=
X-Google-Smtp-Source: ABdhPJxkCsOJ3JKr74kFh0H+el/JjP4ICfMvMDw8NI5RaCiYgalOH6Eo1PpTETvsUheo14HIp3yeHg==
X-Received: by 2002:aa7:c2d6:: with SMTP id m22mr16222884edp.311.1600078827259;
        Mon, 14 Sep 2020 03:20:27 -0700 (PDT)
Received: from felia ([2001:16b8:2ddc:3000:7936:d9d0:986e:cca5])
        by smtp.gmail.com with ESMTPSA id b6sm8993603eds.46.2020.09.14.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:20:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 14 Sep 2020 12:20:24 +0200 (CEST)
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
In-Reply-To: <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com>
Message-ID: <alpine.DEB.2.21.2009141208200.17999@felia>
References: <20200914053110.23286-1-lukas.bulwahn@gmail.com> <f6bc41d3-5ce4-b9ea-e2bb-e0cee4de3179@gmail.com>
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
> On 14/09/2020 07:31, Lukas Bulwahn wrote:
> > Commit 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller
> > support") does not mention that linux-mediatek@lists.infradead.org is
> > moderated for non-subscribers, but the other eight entries for
> > linux-mediatek@lists.infradead.org do.
> > 
> > Adjust this entry to be consistent with all others.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Maybe rephrase the commit message to something like:
> "Mark linux-mediatek@lists.infraded.org as moderated for the MediaTek PCIe
> host controller entry, as the list actually is moderated."
> 
> Anyway:
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> > ---
> > applies cleanly on v5.9-rc5 and next-20200911
> > 
> > Ryder, please ack.
> > 
> > Bjorn, Matthias, please pick this minor non-urgent clean-up patch.
> > 
> > This patch submission will also show me if linux-mediatek is moderated or
> > not. I have not subscribed to linux-mediatek and if it shows up quickly in
> > the archive, the list is probably not moderated; and if it takes longer, it
> > is moderated, and hence, validating the patch.
> 
> I can affirm the list is moderated :)
>

Hmm, do we mean the same "moderation" here?

I believe a mailing list with the remark "moderated for non-subscribers" 
means that a mail from an address that has not subscribed to the mailing 
list is put on hold and needs to be manually permitted to be seen on the 
mailing list.

Matthias, is that also your understanding of "moderated for 
non-subscribers" for your Reviewed-by tag?

I am not subscribed to linux-mediatek. When I sent an email to the list, 
it showed up really seconds later in the lore.kernel.org of the 
linux-mediatek public-inbox repository. So, either it was delivered 
quickly as it is not moderated or my check with lore.kernel.org is wrong, 
e.g., mails show up in the lore.kernel.org archive, even they were not
yet permitted on the actual list.


Lukas
