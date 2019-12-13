Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB5B11EA84
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfLMShS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 13:37:18 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:40766 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbfLMShS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 13:37:18 -0500
Received: by mail-io1-f43.google.com with SMTP id x1so627944iop.7
        for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2019 10:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rSTbx4+Xnp8FvEJgiPQ5fFPbX8PvFRdBprtRWfCWCQ=;
        b=Ohgf2p7RcDyAO9x+7hqrHkTxJ+a7kT8vOKByrsrMwlsQyfiqsofPMz6dlNEaH2kFr/
         30OXQgmqBqqpNadNXtss0bPV2ZVcHODsCXvhDzcMWmbv1s3KgrYiRRQusO6bkbFDRp5r
         LKvKMn4BTmDY7od/XhpsXT23xIipONjzb6tpmba5Yg7opdrxn9JbPVo+73idK9kGsIF2
         nxFDLQAEjalQhqtduuADtXitKUuXf7FWRkHCJElsAxtG+37Ox7MhGWEh9v8dKVoLChhH
         vtTC4mmQqcAXBoutRncx9v8ysca09wIVNJ/BhTFVjArRy8gBLIIC18A4DbY6RDDKDnlb
         wsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rSTbx4+Xnp8FvEJgiPQ5fFPbX8PvFRdBprtRWfCWCQ=;
        b=GhRxdf79tM5t7IXMtf+P1wmBaI2VR4CnPCbZ9KYOMFW6spnkI9MpoKv3kYwVurI67m
         1F2HgDf6obY4jE3YO4w4ugZebrFt80MQtbkpIoT4OfrIeziRHB5C5Tzj/U/+6os6pE/a
         I9gFVovWDckS0WihfaOAnqGJcyF4Fb5QNcm4noFhe+75aACb0SJW4pzLbyfpXGfELx8X
         pYg5uMu0U5OJXQPhnrWJA4r9H1BB/Y9akofBvrcCmqcGg9EHJFjn93P5F5jnJ+489cXL
         8VstvGcgu7yqth8YqHkzLQNnJTqsGsIPmcXIdRG28QnRlOqQs0OvBtp0n8MJIJvZBxJg
         P7cA==
X-Gm-Message-State: APjAAAXH5O/inaDi+3z3PngYIM6FC3ufMgArMC66DjG/mqNN4yL7eykK
        DNKB3tKh0KV3PvwjDjZUeEw+sR4ZjqJKCBgtYgPr0JdglHI=
X-Google-Smtp-Source: APXvYqwmEGW+SCoK781R1wHEyeHBJdMspwk5PrOmp57kqjQ+5c6ggfMA1Zq5gVwxNfGgc4rjMK4/bvTYtO3f/Xhf1Jc=
X-Received: by 2002:a5e:da0d:: with SMTP id x13mr7973581ioj.123.1576262237318;
 Fri, 13 Dec 2019 10:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 13 Dec 2019 10:37:06 -0800
Message-ID: <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

On Tue, Nov 19, 2019 at 7:45 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> This patch set is to recode the Mobiveil driver and add
> PCIe support for NXP Layerscape series SoCs integrated
> Mobiveil's PCIe Gen4 controller.

Can we get a respin for this on top of the 5.5 merge window material?
Given that it's a bunch of refactorings, many of them don't apply on
top of the material that was merged.

I'd love to see these go in sooner rather than later so I can start
getting -next running on ls2160a here.


-Olof
