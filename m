Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F03744DDF9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 23:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhKKW4N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 17:56:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhKKW4N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Nov 2021 17:56:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EEE16124D;
        Thu, 11 Nov 2021 22:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636671203;
        bh=xB78a6Ir3081AjdWRSJRJ27+LjgB8Tv/XSf7soHAcGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ViEK7Zgzgk6oTySgTWDRnDrXXmVp3PpxRCzRqg28L9efL70DVSplKk2LnKEnryUer
         wFAC+qRNTw0p9xE0Z87bMUgRGIngd3G87wwMX1CM9VFPPygsa51I6R41NooGIASePh
         5BYK5yELuxc0piVfeH6wdcQ/cGEfcfh6KI8gtsWmQaTUXtgplQtWpUMUwXhGaihBPX
         uz60gmM77cqTu4XJyZTxZ1TwITNHC6bjy5P8CabVpWAlFoQ0D/1Hdw4w3xWVRTMfUW
         7i+zi2B2eHYK66nCd5OVpmNq2fr2fuLowpnYO7NgRRJg3CWmkdr7RhFKw9WxkMvGB4
         KO9eVGcvhyHZw==
Received: by mail-ed1-f51.google.com with SMTP id o8so29976488edc.3;
        Thu, 11 Nov 2021 14:53:23 -0800 (PST)
X-Gm-Message-State: AOAM530C61UCQa6GVPfsJ8owhU23DxGEgmK4eaMsULdJ2LIn8i5HTRyO
        JSGGQcW7UEyvuyT1ffXPd7/0tD+smPTNRlcnqg==
X-Google-Smtp-Source: ABdhPJymtn9ZDw5BxCaYSsqzEe7wEgn9pGy56vGZnTPH85avyFmkCu8G3taqBzhmPoMsgJ7xqYZPqZOdcUd3+dgt3Z4=
X-Received: by 2002:a50:d492:: with SMTP id s18mr15136451edi.145.1636671201896;
 Thu, 11 Nov 2021 14:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-1-jim2101024@gmail.com> <20211110221456.11977-5-jim2101024@gmail.com>
 <aa040d6e-66b0-5159-2eba-870db74b0e31@gmail.com>
In-Reply-To: <aa040d6e-66b0-5159-2eba-870db74b0e31@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Nov 2021 16:53:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJpxWcBfgfze8Zwx3WWnazQK1W5H=JTmMyVgzyj4VVvyQ@mail.gmail.com>
Message-ID: <CAL_JsqJpxWcBfgfze8Zwx3WWnazQK1W5H=JTmMyVgzyj4VVvyQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] PCI/portdrv: Create pcie_is_port_dev() func from
 existing code
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 3:51 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 11/10/21 2:14 PM, Jim Quinlan wrote:
> > The function will be needed elsewhere in a few commits.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/pci.h              |  2 ++
> >  drivers/pci/pcie/portdrv_pci.c | 23 ++++++++++++++++++-----
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 1cce56c2aea0..c2bd1995d3a9 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -744,4 +744,6 @@ extern const struct attribute_group aspm_ctrl_attr_group;
> >
> >  extern const struct attribute_group pci_dev_reset_method_attr_group;
> >
> > +bool pcie_is_port_dev(struct pci_dev *dev);
>
> Looks like you need an inline stub here when CONFIG_PCIEPORTBUS is
> disabled to avoid the linking failure reported by the kbuild robot:

Probably always an inline function. It has nothing to do with the
driver, so portdrv_pci.c is not the right place.

Rob
