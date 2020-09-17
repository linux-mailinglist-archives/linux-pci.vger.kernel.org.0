Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBE726DF28
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgIQPKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 11:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgIQPJl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 11:09:41 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3E72222C
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2020 15:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600355375;
        bh=PbObyMj9Fpy+6klhYrr2xldju4K6S5xHdSzl9G3SM/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OMb2s/g/zaLF3Mut3UmCgvlvPJxQdRmm064/qg6z7jn7RKlT4oMNNRbXtOsKiVLjS
         TgnAYK5zylft+3nAnZuvGKFTtsB0gU8rNg3b6Ckpu/0mmok/WfVnX8PmeV3G1lUXOR
         +OXopOmyOL4uS2ok2TWNrhuUe6tdRYMKhDB6lXZQ=
Received: by mail-oo1-f51.google.com with SMTP id 4so625925ooh.11
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2020 08:09:35 -0700 (PDT)
X-Gm-Message-State: AOAM531rMEj/42kD2pkoZPehId49U33xwXyzsn3DMFuf1wrp96LRCNWt
        5/VSdgot5w8A/DcNij/lLoKrCDNxJBli9zJU+A==
X-Google-Smtp-Source: ABdhPJz/+ac26Vk7un6fk+5OH9J5Hmb4PlmlfN6U4+2Z48Z4tyabSDd5XiM22DM/u6GPPhyizEPKR/zuUWP8G58Q5Ik=
X-Received: by 2002:a4a:d306:: with SMTP id g6mr21335181oos.25.1600355374700;
 Thu, 17 Sep 2020 08:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200904141607.4066-1-lorenzo.pieralisi@arm.com> <20200916103045.28651-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200916103045.28651-1-lorenzo.pieralisi@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Sep 2020 09:09:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_LndCYHjMJ_r1ZHfbka++ep69=Y3NcHe6KLD3FHkPrA@mail.gmail.com>
Message-ID: <CAL_JsqJ_LndCYHjMJ_r1ZHfbka++ep69=Y3NcHe6KLD3FHkPrA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM/PCI: Remove unused fields from struct hw_pci
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 16, 2020 at 4:30 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> The msi_ctrl, io_optional and align_resource fields in struct hw_pci are
> currently unused by arm/mach PCI host controller drivers and we won't
> be adding any new users.
>
> Remove them and related code.
>
> Link: https://lore.kernel.org/r/20200904141607.4066-1-lorenzo.pieralisi@arm.com
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> ---

Reviewed-by: Rob Herring <robh@kernel.org>
