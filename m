Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB921A323A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 12:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDIKGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 06:06:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42214 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKGh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 06:06:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id t92so984422otb.9;
        Thu, 09 Apr 2020 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5NC/aoEyzH+2mxoFZv386bE5G3S+Vy1WnLbB1xBCzU=;
        b=DRLAoSrWnVR2JhbFDdUn7whtg1Q3SttneTHHvjilPfIs8/gR0S6UhKgbBm+wSjaDXe
         ShT6Cx1vFJZiEjrWguDMkygL3Khm3gDmIgsUjgaBdQd9Cvohr4/qvRtc0k1SEPbboVhO
         Csi6gsh0Oew7Qq9yG/G++eDphcTEmrdJldfUU950de45wF1FOyWfNfo1+uZeiOxCsJlr
         iF6z03B0esddhtBTEbwZN/MzWC56BoBvmLz5FO+3q+UMeijUJ8esCemYTdUVHgRjeTi7
         WstkEtIifJGpDc+HrvQoVt+hznZg6M1Qb0XYdQJeD2zrGNR1mZ6+D3rulE5u1E6OESWz
         LXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5NC/aoEyzH+2mxoFZv386bE5G3S+Vy1WnLbB1xBCzU=;
        b=NrzzfBO9AHfoxGJf07kSus6n3sNI2w7mT81iiHVf34+kGbLxZwyyfOfdXhtpvBVFUT
         plnygcOadyrDLw9kOl0/UkIZ/sJiIeCxNM5duj4ONnZM3uAyWXbRcEtaucZn4UB2GLk1
         AYwonH6ABRxh/cXfM5ALxI60TEhzhNSsGLr9KnzCdYPcQHID5C1W4BCr9grytsKWDHY0
         dQSsSVkqxYMBfTihqjmrWZ7RoRHC/kKxq0t8ydZa3byzvhUkZWi+m3DAvlwmgSpEiK3L
         tcOTuvVubDbr1H5ibn+XIxiSpmkqcbcDOI0RLedboZoPm0W7foCACCuyKz8/gjhphFbG
         gg0g==
X-Gm-Message-State: AGi0PuZfDGJx0PSWHFn2XVJHVHAqcAobaTBfJXilBSLFDxN8lDwJVNo8
        DR6yDAQTClkpXwqtyjWifCUDF5ET7x7puwC6/Cg=
X-Google-Smtp-Source: APiQypLSDjhC54tJv9NztavckA8J0z5rxJ5yJW8bbn29fHSowO5tivlkjtg4rktwsC+zSD8PcJXTSQS89WNUMyK0mHo=
X-Received: by 2002:a9d:895:: with SMTP id 21mr8758143otf.365.1586426796800;
 Thu, 09 Apr 2020 03:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <1586360280-10956-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200408233008.GA150200@google.com>
In-Reply-To: <20200408233008.GA150200@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 9 Apr 2020 11:06:10 +0100
Message-ID: <CA+V-a8v6=9dmgtvP+vWo+isZXeo45ARDpXZ2YKqn3reMVw3Xiw@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] PCI: rcar: Move shareable code to a common file
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review.

On Thu, Apr 9, 2020 at 12:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Apr 08, 2020 at 04:37:54PM +0100, Lad Prabhakar wrote:
> > This patch moves sharable code to common file pcie-rcar.c and the #defines
> > to pcie-rcar.h so that the common code can be reused with endpoint driver.
> > There are no functional changes with this patch for the host controller
> > driver.
>
> s/This patch moves/Move/
> s/sharable/shareable/

My bad shall replace it.

Cheers,
--Prabhakar
