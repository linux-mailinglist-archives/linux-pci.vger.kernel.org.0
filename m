Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B28265161
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 22:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgIJUxg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 16:53:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgIJOuk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 10:50:40 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F21B20809;
        Thu, 10 Sep 2020 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599746101;
        bh=8uitls0FwMbXxeUeaJe4v+UryX88G0t2cRNAeu715Ig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q4zDVMQ/4u5dTCoj1HmW39yDoXKxpPkpsIHUR9BNTRhKKd5sATQbWkpHJJ4bCVCin
         0Oal+bJrb5SFqHNOLs5ZNiLOqPA0HXqezywrZmj8EpmrzFqk3gNOvYl7NjBcwkXu5q
         IXJnVZLiPY+zotF6RtpwTNtAK77Lz8zJ5uwNoolI=
Received: by mail-oo1-f41.google.com with SMTP id 4so1448305ooh.11;
        Thu, 10 Sep 2020 06:55:01 -0700 (PDT)
X-Gm-Message-State: AOAM531FIDH6C6K7Or/KR59yiP+G5/K2iexICPb58oKwKfFyEUP+lYXJ
        oq9GWoq9xcVRGIoQDzTMrMv+Wl6gDlaFjrCgfg==
X-Google-Smtp-Source: ABdhPJy+lHlOja04YRvhjttbYYqlKO/f60ffG9yIDtiL2dYnlDTTuqAcRCeqB1xYH1rB13Um+cg0/NOEacjYYhVASrQ=
X-Received: by 2002:a4a:d306:: with SMTP id g6mr4550240oos.25.1599746100549;
 Thu, 10 Sep 2020 06:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200909134234.31204-1-yuehaibing@huawei.com>
In-Reply-To: <20200909134234.31204-1-yuehaibing@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Sep 2020 07:54:49 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+mdgAF5bq5wv8JYj6bMyRAYyUSYnx3ab_UQzrRYpeAug@mail.gmail.com>
Message-ID: <CAL_Jsq+mdgAF5bq5wv8JYj6bMyRAYyUSYnx3ab_UQzrRYpeAug@mail.gmail.com>
Subject: Re: [PATCH -next] PCI: dwc: unexport dw_pcie_link_set_max_speed
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 9, 2020 at 7:42 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> This function has been made static, which causes warning:
>
> WARNING: modpost: "dw_pcie_link_set_max_speed" [vmlinux] is a static EXPORT_SYMBOL_GPL
>
> Fixes: 3af45d34d30c ("PCI: dwc: Centralize link gen setting")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks for fixing.

Acked-by: Rob Herring <robh@kernel.org>
