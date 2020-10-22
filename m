Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D367B296590
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370498AbgJVT61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 15:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370499AbgJVT61 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 15:58:27 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB2F22248
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603396706;
        bh=lUQW721CJqx4i0bCsUWUoOtxRkOI/sPdw94OjZ6MSWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ae/faLAqs5C5977w/yo+Uu1eahmap5pIif1hSlEWWX+sgfYHfye8ZlUr8uV3jFRZk
         /bFMJcrRXCPFINAxUUxyE1eqGYUfV7lS7tRHWCoyUgOYRkiGRCNS3dxj0r5L2Gx9EE
         Lqrkz4qUNs1i7dAGMJSHFpLh9PXbv+/AZkkz7T0k=
Received: by mail-oi1-f173.google.com with SMTP id k27so3052301oij.11
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 12:58:26 -0700 (PDT)
X-Gm-Message-State: AOAM530THdKcV36JwD9ucFwrQUGLkfwwe+6gA/kaiR0kc+GvZov745ru
        wCEGR92sXEEJ9feKqArj+e5GRuSfyyb46j52bA==
X-Google-Smtp-Source: ABdhPJwpuZUqHz68nxetU41+QMYAfkmQ3OLYHcE98E3PqtFCr+sjbLqM/wkE+1RLvirjRVWPooYS5nSB0KOz5ktqm9w=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr2769456oib.106.1603396706029;
 Thu, 22 Oct 2020 12:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201022173054.GA511367@bjorn-Precision-5520>
In-Reply-To: <20201022173054.GA511367@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Oct 2020 14:58:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKPkg29jv0SyN_bKTRYi+isK-C-eBXE8+RVGQ+68MnwrA@mail.gmail.com>
Message-ID: <CAL_JsqKPkg29jv0SyN_bKTRYi+isK-C-eBXE8+RVGQ+68MnwrA@mail.gmail.com>
Subject: Re: [Bug 209729] mvebu-pcie soc:pcie: resource collision
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        PCI <linux-pci@vger.kernel.org>, vtolkm@googlemail.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 12:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=209729

I see the issue and am working on a fix.

>
> From the bugzilla:
>
>   device: Turris Omnia (armv7l)
>
>   kernel log:
>
>   mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
>   mvebu-pcie soc:pcie: Parsing ranges property...
>   mvebu-pcie soc:pcie: MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
>   mvebu-pcie soc:pcie: MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
>   mvebu-pcie soc:pcie: MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
>   mvebu-pcie soc:pcie: MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
>   mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
>   mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
>   mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
>   mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
>   mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
>   mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
>   mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
>   mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
>   mvebu-pcie soc:pcie: resource collision: [mem 0xf1080000-0xf1081fff] conflicts with pcie [mem 0xf1080000-0xf1081fff]
>   mvebu-pcie: probe of soc:pcie failed with error -16
>
>   As a result PCIe devices, e.g. WLan cards, are not working.
