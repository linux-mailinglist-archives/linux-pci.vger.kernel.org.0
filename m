Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486F163E05
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 00:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfGIWu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 18:50:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33413 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIWuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2019 18:50:55 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so601124iog.0;
        Tue, 09 Jul 2019 15:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UqPnkpAEUlKpVyrsNSV+fc7Kx0vSPNNrsHHUgfNEjus=;
        b=Xc86xulVRMYuYUj6z/+FFg8nUXg5Ia769QdUKABqF7EfYLv9NJZNZnFn8WlFL+fWyS
         D98bEEbdXTIP675Ef0Y2hhsJiEFv5rQyLy9fTN3uJx1vWFqXsPfrmGHE383e8IOtYOPs
         H/zy63h2cSnVn710Tl+xJudYIaP+MoKyC4KuKE3+l3ZZN6m8yfgu5zl9VfgWf1kH8xXS
         CGzVGQw0Yj/FNr3tu0x1K4utNsB3QdksPoNLa36J1y7i5H9a0Bc4iECg283YYUJpob26
         bMduGoSiJhYsg4iDLKhqmf3nl5kvQipmZprEsqVKcUQNbHlx9p2nc+npq8rzYkBUZq3r
         2C5A==
X-Gm-Message-State: APjAAAXX0XTlRLjXYduKjxVTFLjdTJGSm1sn3NDeyJfcssyWznA/ubzV
        X21tLRBXjmYUfKcMDcnvgg==
X-Google-Smtp-Source: APXvYqx6GaFGNFu/Gs8Ct3zM+Thf5p3GPzAn0CoeeaRGIEaKsvMqPDSWW2PRaa//YWXroiwsO+DBDQ==
X-Received: by 2002:a5d:8411:: with SMTP id i17mr21198926ion.83.1562712654937;
        Tue, 09 Jul 2019 15:50:54 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l14sm291821iob.1.2019.07.09.15.50.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 15:50:54 -0700 (PDT)
Date:   Tue, 9 Jul 2019 16:50:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] dt-bindings: 83xx-512x-pci: Drop cell-index property
Message-ID: <20190709225053.GA12654@bogus>
References: <20190622034557.196097-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622034557.196097-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 22 Jun 2019 11:45:57 +0800, Kefeng Wang wrote:
> 28eac2b74cc7 ("powerpc/fsl: Remove cell-index from PCI nodes"),
> and for now it is still not used, drop it from doc.
> 
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  Documentation/devicetree/bindings/pci/83xx-512x-pci.txt | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks.

Rob
