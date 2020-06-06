Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B2E1F0814
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jun 2020 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgFFSJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Jun 2020 14:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgFFSJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Jun 2020 14:09:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D145BC03E96A
        for <linux-pci@vger.kernel.org>; Sat,  6 Jun 2020 11:09:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so13986767ljm.9
        for <linux-pci@vger.kernel.org>; Sat, 06 Jun 2020 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfZS6FD3PVKTeFod390EA9OFYChxy7azm74/xGOYsC8=;
        b=DgKPeLGSSTDInt10KbPCgP/rEDD+SgAJgEOpT14iuC7S68iv3fc74iAjfj9WZwuQ+d
         IqXb0HmIOILsKK7OCe3VsJaTzPGBsuOsqIQmnh5yznNkRCCilV2PA6SxzfGNjIy9nRZj
         S+Nb/3+/qsy0PuBAn7+aTt/7b4XFUNq/GACwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfZS6FD3PVKTeFod390EA9OFYChxy7azm74/xGOYsC8=;
        b=UoETkyyb6omKKjpRSTLWEzLEukd0/yo00eFhaW8CcBwbO32uzj+qPKVhXNnpjLVXBo
         lkZvY61FUlIAG0L8xpAcQzwl8QIZPyXU7bX+87Hv3d+v3twQjnoyNiwNOao7XcRsT+R8
         DEN8ZEStUcJ3+mhfgxgriuvbL1akr+LLPx9z6StrcjYd5pzoN18VBw9uud4NtrMmKzuJ
         9FT8fIUVXY+5zu4FSBwn+aELd3FWeXqvlqP/VtjnkhtwAkNesY9K6Px8jI5ZEUrw9A0k
         VizfuywhDM9RNF9mNb13W3MD08Ara4hdRYsilPsaEL0Nzg3hxHv2zLU1waS04Y2bUvdR
         /Oyw==
X-Gm-Message-State: AOAM533L6Ss3Xne+RxTdOqWCfE0bJpgAd4EpCVXiRqrcD5ma8dhXZwth
        h15j+XcjvJ+GdEEFI5zcdDWhbcRQpqE=
X-Google-Smtp-Source: ABdhPJzPVRb3cq8O1IGjg8eUOJ9fz4IPz2fBcpBGFVpbufYzUOBwtNw+XimU7ngJD4qgpoXUNHiTUg==
X-Received: by 2002:a2e:9786:: with SMTP id y6mr7295209lji.398.1591466984552;
        Sat, 06 Jun 2020 11:09:44 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y1sm2092458lja.13.2020.06.06.11.09.43
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 11:09:43 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e4so15680820ljn.4
        for <linux-pci@vger.kernel.org>; Sat, 06 Jun 2020 11:09:43 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr7519625ljj.312.1591466982709;
 Sat, 06 Jun 2020 11:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200605202257.GA1152522@bjorn-Precision-5520>
In-Reply-To: <20200605202257.GA1152522@bjorn-Precision-5520>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Jun 2020 11:09:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wien36zOp4aqf6XULz+7uM5rtxUb21xh8PGbTa-gL06aQ@mail.gmail.com>
Message-ID: <CAHk-=wien36zOp4aqf6XULz+7uM5rtxUb21xh8PGbTa-gL06aQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.8
To:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 5, 2020 at 1:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> You should see two conflicts:
>
>   2) Documentation/devicetree/bindings/pci/cdns-pcie.yaml: conflict
>   between Rob's 3d21a4609335 ("dt-bindings: Remove cases of 'allOf'
>   containing a '$ref'") and Kishon's fb5f8f3ca5f8 ("dt-bindings: PCI:
>   cadence: Deprecate inbound/outbound specific bindings").
>
>   Kishon moved a hunk from cdns-pcie.yaml to cdns-pcie-ep.yaml and
>   cdns-pcie-host.yaml, so I think the new homes need Rob's change:
>
>     Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>     Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml

I decided not to touch those two files, because the AllOf rules seem
strange, and not all were updated anyway, so I'm going to leave it to
others (ie Rob) to decide how they want to handle it.

I suspect your resolution is correct, but I also suspect it doesn't
_matter_, and since I don't understand the yaml rules I'll leave it
alone.

Rob?

              Linus
