Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74468E3D5C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 22:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfJXUbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 16:31:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35466 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfJXUbQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Oct 2019 16:31:16 -0400
Received: by mail-ot1-f65.google.com with SMTP id z6so194577otb.2;
        Thu, 24 Oct 2019 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYJ6gEo/hVCrgbEGD/uQo09XTKvuC2XPns9+x2EIVbg=;
        b=GVDICoRF34YVDIHmRFO4I+Wlb/tsKac3U+PmDGHaeRGtbS50fObSEzXliC15S6sI+i
         8+te4hcVOCbpsZenjzCnwsax9RPCIN05p89Q6fRbz5/TRzRW/3HnqANany4Nlav6qRkF
         Uizv+7Wn3eaftNRYlmrOSoqeCT3xzPTydmapcVGVZ/jsYjdULUqs0jWylKI/F/Xou3Wk
         nOZIRUh4BuW6Cj0i1bvOp0d71SQhG6e/w91Jm5B9BnSMfppk8N2q85dqOtSBPlMjeHxa
         ysqfUvVKYByS4NaL9l+qWNNMwtO8bolyANgemhkwBwGOrT/zeCahChIEDopEGv6LG7Ma
         DJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYJ6gEo/hVCrgbEGD/uQo09XTKvuC2XPns9+x2EIVbg=;
        b=bqPaZc+XyIekQE8iVlUfm0Mg/nhK+Qm5wsyAMYkyq4OimmxwhgFgOU9qxp9bT7P6a3
         BBwl76sWGrNbgxdc4slUzcvNPiCa9of6MY+AmbXa/3JtfGR7w35fndH6ntHUUPSWdFuj
         sQ3yaSDulDLUaTkggONqs0kJHUeNaGW2KLxVJYJEu+SvZGXSSfgqra8hvuaSqoc1Y3Y4
         abEiAv1epXjmHMdpToxzFZKYH5K1gyi3p+OrKhvJgaSa4GCmxMOhJ4uAymcMtUsYjVhJ
         eET+GleUyKVf3OjsnjQDMlLjkjhpM0VmZILCVuiZvi76f4ELuuW38lRwf/cMTDHtlaDi
         +YSQ==
X-Gm-Message-State: APjAAAXllYKbP1N1Lzqzmut/fDK/+4Ww6yvlNawurOYwuWKZCQo6e11L
        oUVIZuH81QWrzIEG5J990+GifTXfEdOCst6YMUw=
X-Google-Smtp-Source: APXvYqzsF73bxdUO6gmL8WJ5PmKfZDJ2dxPE35TqJ6sVlfXtsgi5lFQ5zxTJW6X9dWfcPzjLwEj/q4rf2XmMsA4UXvo=
X-Received: by 2002:a9d:6043:: with SMTP id v3mr11975067otj.6.1571949075624;
 Thu, 24 Oct 2019 13:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571638827.git.eswara.kota@linux.intel.com> <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
In-Reply-To: <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 24 Oct 2019 22:31:04 +0200
Message-ID: <CAFBinCCSX_kVB=W3O-WXDMD2_2_Rnv+kiehf37xDkjL8+QoyHQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dilip,

thank you for the update
two nit-picks below, apart from those it looks good to me

On Mon, Oct 21, 2019 at 8:39 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
[...]
> +examples:
> +  - |
> +    pcie10:pcie@d0e00000 {
why no space between pcie10 and pcie@d0e00000?

[...]
> +      status = "okay";
examples should not use the status property, see commit 4da722ca19f30f
("dt-bindings: Remove "status" from examples")


Martin
