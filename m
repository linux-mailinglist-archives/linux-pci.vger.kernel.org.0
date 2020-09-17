Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2187D26DF17
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 17:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgIQPHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 11:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgIQPGW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 11:06:22 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CBAD206D4;
        Thu, 17 Sep 2020 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600355163;
        bh=8+fGfAsiNIkFfwWzfEoIkpdYXv05xEG/Mk74AEbV3KA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dtM/sJD3trp/6qxR9BtZvoZPH1lUl3GdSHtZ8Rtb4mrFrgaMB6wZ+Eo5EBcbr/Ago
         0PBVW/Y0C+IhYk7+r3uuCVqXUM3buZujzwShWOFZ6HmufruRDX7S62BH58i8jDShfI
         IgGyOCDFE/aKugFcmSdibi0DoMx2mMWr3dYTpG08=
Received: by mail-ot1-f53.google.com with SMTP id a2so2177822otr.11;
        Thu, 17 Sep 2020 08:06:03 -0700 (PDT)
X-Gm-Message-State: AOAM532lualD+QhnmPTN6eMlWvYvfhSXjpJvCcu4EM6xlwd+dzuphlC7
        gNyM0LGgvO2TEE/k974AEHYbJwYBTxl16cuN+w==
X-Google-Smtp-Source: ABdhPJzgXW4cPWg9VRoYlcrlEIdDXTPw7/10UjC2KXcBPOjIop+H0uxfDb0v0+9REEInvtLv6LwJTn99swSsEJaYDGE=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr18556801otp.107.1600355162516;
 Thu, 17 Sep 2020 08:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200917071758.1915565-1-liushixin2@huawei.com>
In-Reply-To: <20200917071758.1915565-1-liushixin2@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Sep 2020 09:05:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKa6ptUiTRtQhibJ2sYN1LvdcZgmkN1s3Tx+bLNC7=D+w@mail.gmail.com>
Message-ID: <CAL_JsqKa6ptUiTRtQhibJ2sYN1LvdcZgmkN1s3Tx+bLNC7=D+w@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: dwc: Remove set but not used variable
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 12:55 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/pci/controller/dwc/pci-dra7xx.c: In function 'dra7xx_pcie_establish_link':
> drivers/pci/controller/dwc/pci-dra7xx.c:142:6: warning: unused variable 'exp_cap_off'
> [-Wunused-variable]
>
> After 3af45d34d30c ("PCI: dwc: Centralize link gen setting"), variable 'exp_cap_off'
> is never used. Remove it to avoid build warning.

Already fixed in next.

Rob
