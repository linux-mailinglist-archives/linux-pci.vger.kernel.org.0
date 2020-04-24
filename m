Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF11B7DEF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 20:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgDXSie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 14:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXSid (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 14:38:33 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791DD20728;
        Fri, 24 Apr 2020 18:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587753513;
        bh=wIEGkqfGbo0wktCESICA4cfx2JF7YvqHp3t0mzYCuBE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kJZlAcA4WE+2FSKijpHwdNk+ufsZuWeffmzvKIQoGGmEPFvGziaMDW//Ef+sRVTGc
         l3ecGSykzHm/WqzNf8el7kSM7Pc6ur9F/eH8Y0ffEmM59QrMsL/7rjJ3CaPnIkdnbc
         Fe2Wql18xKlppnffLwt/R0322O3ENOy7pr49ezgQ=
Received: by mail-qt1-f175.google.com with SMTP id w29so8773804qtv.3;
        Fri, 24 Apr 2020 11:38:33 -0700 (PDT)
X-Gm-Message-State: AGi0PubBCZsInSJBeCZTQPKvSBbETRCCLx95g6iLxsbJSj8ZNuYuSb5V
        itSivxFJrJnpcDTu1Cy5YSQxxT/eiuE4fC0vsg==
X-Google-Smtp-Source: APiQypKgIEUnRJArWmTjGHuSUVMOghCieTSzPhQJGSyPEdujX/KO+Q/IU+CNfVRapzsFGx9e9YS7CCXLHmsSrQLqMa4=
X-Received: by 2002:ac8:47cb:: with SMTP id d11mr9981420qtr.136.1587753512579;
 Fri, 24 Apr 2020 11:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com> <20200424130847.328584-5-jiaxun.yang@flygoat.com>
In-Reply-To: <20200424130847.328584-5-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Apr 2020 13:38:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKM_3DXb4JYcvotsMQPesNz5C4tD8WURYaSbmab1cxiww@mail.gmail.com>
Message-ID: <CAL_JsqKM_3DXb4JYcvotsMQPesNz5C4tD8WURYaSbmab1cxiww@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] dt-bindings: Document Loongson PCI Host Controller
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 24, 2020 at 8:10 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> PCI host controller found on Loongson PCHs and SoCs.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> --
> v3: Fix ranges
> ---
>  .../devicetree/bindings/pci/loongson.yaml     | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/loongson.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
