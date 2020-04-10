Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285C81A468C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 14:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDJM5B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 08:57:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38428 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJM5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 08:57:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id v16so1877611ljg.5;
        Fri, 10 Apr 2020 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZGLlXFa9BMlMphwKHzLxdDqmfz+d5IQ0la+96J6uLA=;
        b=jRWsPN/q4w8R0K1NX4BIweHQRnqggiAxiN01umnhH/GU2QgTPY6eo1nXL3xJ3brfrP
         EvsaV8jmZmi7oJpMPTx69DedRLAUfXowfEF8GG9z+EP70m5n0lh+j+DxKJuOTn1XvFf8
         dq2GN7pV6958BVWIybrGb3b9W35ZI2HHMfx386w57uD987ESAuVZkmn12CfMcqj1EStr
         Dav+E+7lDswNC8oTEud7WdsiT8zEKa5CcUepW6KTEQhuCu92LeI9uYHtU+IzxnpNFro+
         C0kv2KHcPOPm4XQrr1yXs9dsDcn7z0ER98kOq6bcN+ilyMaJzFE/nL7QprLALNeiHcbo
         F3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZGLlXFa9BMlMphwKHzLxdDqmfz+d5IQ0la+96J6uLA=;
        b=YOmk9UbCBwaTSA/083q9irZYzYSnZ/WZTL+rIHoMrDu9CG+/41sn+ZH4wEnbHKZkfR
         PpG9diOTA7Bz4EURyEPZlVnFf0xlxg3ZQFD8lRG3Cgadq5Q8mRATkuGcuL0omd3mzyzR
         ZvfIYGFukTJT8X+Y87eMZvo5M8KshKv0lKVdn211R5sTyGlVrCbCYs3IGNiLx7b72OXt
         x/UgA20E6rArZ+6KWku8OukPkvlwS1YK6XH3lipYCtWsf0HoNjBkg/RdYfZIw8nCQiPO
         yvcI152jTV65xmBv/WX/uQrQg1znhHxPiEa7ynypVNV8RdWLs05+ipMdueoSEPbEQCVa
         JZaA==
X-Gm-Message-State: AGi0PuYLwPNLHLrKMMjG6baSDpMYSBwjROmzjzcim8VVhVOlUWuPNyW0
        nBpAcUL57uvKrCdxvkveLG6w6m1uhuYyLrFagqk=
X-Google-Smtp-Source: APiQypJJXUKGskGMpbpEP9q9R7kkXnKsW+kEywaCc/jfEw1V4RieDufDc9+AW+YUfJ+Fa0VkdsJdHUzkO2j3QCmHhbs=
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr2803753ljc.195.1586523417912;
 Fri, 10 Apr 2020 05:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200410004738.19668-1-ansuelsmth@gmail.com> <20200410004738.19668-3-ansuelsmth@gmail.com>
 <CAOMZO5AKYO3xLsp4k6_fJCV9qW=rAtRKEGWnxksixU794dOw8A@mail.gmail.com>
 <003401d60f28$3d045190$b70cf4b0$@gmail.com> <CAOMZO5B+rEoQD_ujt9cx9VXO-i2oqfW2UN2cVeB5hZB3aVpGeQ@mail.gmail.com>
 <003401d60f35$3725b630$a5712290$@gmail.com>
In-Reply-To: <003401d60f35$3725b630$a5712290$@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 10 Apr 2020 09:57:25 -0300
Message-ID: <CAOMZO5D+nMPDcQ3rPB+QC437tXYoa2VKdZtZzFdAnBkJEa=A6w@mail.gmail.com>
Subject: Re: [PATCH 2/4] drivers: pci: dwc: pci-imx6: update binding to
 generic name
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 9:40 AM <ansuelsmth@gmail.com> wrote:

> It's really to not have the same exact binding to 2 different driver.
> If this would cause problem I will use qcom,tx-deemph...... but still it looks
> wrong to me having this. How should I proceed?

You could make the imx6 PCI driver to accept both the new and old
binding versions.

This way we can keep compatibility with old dtb's.

Also, if you respin this, please state the motivation that you
explained here in the commit log.
