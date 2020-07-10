Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65E721B914
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 17:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGJPEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 11:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJPEv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 11:04:51 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038CF2078B;
        Fri, 10 Jul 2020 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594393491;
        bh=58u/MQOEZ8t3fLlHJ0ehwOfXZ4J6VQJesNCyTCYYygk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gG+06TDP6sioAAgGCCo/QoUsFEvjgA4VoabdVNK9xI6giTCK+2MZhb+gIFUz6OWSf
         HrgX8AodXtnoo9Rq3aZiWhot65GjOJ1gH7fSxLowH8M3Tsax5q/scBjzsUfr8Nibuc
         yHfLWOVGIhum4hQBkfAhhrC9ObQ/lCkAw6MrlK70=
Received: by mail-ot1-f42.google.com with SMTP id e90so4433593ote.1;
        Fri, 10 Jul 2020 08:04:50 -0700 (PDT)
X-Gm-Message-State: AOAM532nv71aS/P8yjSNQ2L0OMZyHEzBopCQGgQRCOphnqrRXs9TuShL
        oNZxhYr1vSs/s53xqkjQItDd2tvN5EWGYFSW4w==
X-Google-Smtp-Source: ABdhPJwtbdfHYP8GDJhqDLCxjuhRZF3Hh2SoimVunvrX90Iahe1fSDv5RMN4eF18NfuhBmRyYXBxJDuRW3vWiK/sTDw=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr59417384ots.192.1594393490396;
 Fri, 10 Jul 2020 08:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <1592312214-9347-1-git-send-email-bharat.kumar.gogada@xilinx.com> <1592312214-9347-2-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1592312214-9347-2-git-send-email-bharat.kumar.gogada@xilinx.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 10 Jul 2020 09:04:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLbFyVHKU0yf1C9y0DRt6Qz34bvwh9dyiOFX-_wF_XiSw@mail.gmail.com>
Message-ID: <CAL_JsqLbFyVHKU0yf1C9y0DRt6Qz34bvwh9dyiOFX-_wF_XiSw@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] PCI: xilinx-cpm: Add YAML schemas for Versal CPM
 Root Port
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 6:57 AM Bharat Kumar Gogada
<bharat.kumar.gogada@xilinx.com> wrote:
>
> Add YAML schemas documentation for Versal CPM Root Port driver.
>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml

Reviewed-by: Rob Herring <robh@kernel.org>

Though it was not sent to the DT list, so no automatic checking happened.
