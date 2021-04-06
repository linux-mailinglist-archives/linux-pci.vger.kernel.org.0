Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1096C355B48
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 20:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhDFS0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhDFS0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 14:26:09 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18427C06174A;
        Tue,  6 Apr 2021 11:26:01 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so15591025otn.1;
        Tue, 06 Apr 2021 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+YrVHF4/ePuOuqqtVeXHUraWj9qRsuousQu2nUgUwY=;
        b=gy164X6YSgASgLtXNiV0A9vOVIBKYTyWcyLcF3DpYEZh4wirzOP2hYxdlXvyhIr5D1
         gk3B4MjQMlQWelgHFtX7QtWkB49FyDyKpC2+SlWe1JiD8C/LIC4OpuyT6rd1qHqMuP3M
         dLij2UUrWupRlqAYfK2YIsEh/0bli4zeR1g43BSShibYToVxHcH7uwUWzkKR3o/jydQx
         12c6leDYY1bT2SDcjKtnRxLPobCQPX/HOsigeM6sE4TpS78NIucpDlTU7GBE74jv46Hc
         YXjtnr/RioHrvx+nQEtKQZjKK7c9M1XPcnclswNI5X/qAwKlvU1EWDbvQ0aSfhe1Koon
         Gk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+YrVHF4/ePuOuqqtVeXHUraWj9qRsuousQu2nUgUwY=;
        b=fDImMX6ZTAcMz1E7TNRmzfnvH5IB+6ZPqRqzCC3JZbz7qAaEFtfeBNWZ9V5qocQujM
         FkPh8xVQiGP+sK2sJ3DtSTTMl+bkhB+xQ3RYgoZ8QaaP1NJmR9f3IxY+gg0SQaXDyHP+
         f70Gb8sxkpF7sFxOBO9EzMjQ7lhJ0Jw1+iRT8JTdSkCK2djRpKZOcz1jeWfrCVmT2apF
         7zFb7NgcKoc5Vc4Gx0SpMK4ffJe61NkhnqaglLVQYAlFYQxiDQQYNvV3lUKaEVqpe49C
         60iOkozrDMYoLo5pDckDniz2+isKbb3OPMVaCoIYsn3EDOIfxRAcOQzSaLoFBuotM1na
         s+pg==
X-Gm-Message-State: AOAM532E7rlUVz5Lg0ADDlwJnb6KZFvctEgJSEU5LEsYPDklSuTQSXLU
        NQ4nIx+40obRxXu9I1itLWttGaA07zMSm5wAS9o=
X-Google-Smtp-Source: ABdhPJxwg9vd9+MahRWgSay31WWghgV7JzI7axm3jThr1fYHICcQZP169QbCdS0oklbH8a3X8ZgxFJxyij7UiRsyUzs=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr28119450otg.17.1617733560549;
 Tue, 06 Apr 2021 11:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210401212148.47033-1-jim2101024@gmail.com> <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk> <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
 <20210406173211.GP6443@sirena.org.uk>
In-Reply-To: <20210406173211.GP6443@sirena.org.uk>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 6 Apr 2021 14:25:49 -0400
Message-ID: <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 6, 2021 at 1:32 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 06, 2021 at 01:26:51PM -0400, Jim Quinlan wrote:
> > On Tue, Apr 6, 2021 at 12:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > No great problem with having these in the controller node (assming it
> > > accurately describes the hardware) but I do think we ought to also be
> > > able to describe these per slot.
>
> > Can you explain what you think that would look like in the DT?
>
> I *think* that's just some properties on the nodes for the endpoints,
> note that the driver could just ignore them for now.  Not sure where or
> if we document any extensions but child nodes are in section 4 of the
> v2.1 PCI bus binding.

Hi Mark,

I'm a little confused -- here is how I remember the chronology of the
"DT bindings" commit reviews, please correct me if I'm wrong:

o JimQ submitted a pullreq for using voltage regulators in the same
style as the existing "rockport" PCIe driver.
o After some deliberation, RobH preferred that the voltage regulators
should go into the PCIe subnode device's DT node.
o JimQ put the voltage regulators in the subnode device's DT node.
o MarkB didn't like the fact that the code did a global search for the
regulator since it could not provide the owning struct device* handle.
o RobH relented, and said that if it is just two specific and standard
voltage regulators, perhaps they can go in the parent DT node after
all.
o JimQ put the regulators back in the PCIe node.
o MarkB now wants the regulators to go back into the child node again?

Folks, please advise.

Regards,
Jim Quinlan
Broadcom STB
