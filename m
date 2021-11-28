Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23B460B32
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 00:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359787AbhK1XiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 18:38:23 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42989 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241396AbhK1XgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 18:36:22 -0500
Received: by mail-oi1-f173.google.com with SMTP id n66so31103039oia.9;
        Sun, 28 Nov 2021 15:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLaIVrzhsciazb/WMOwbxqo54xmjIGiDFmP43lfbZuI=;
        b=Q6wWknKdWzwqLQNHpqQa3mMVNFIdn1QI1wMHo4WiUtMb0RkEHccdKFEBBjg1Uochgt
         Cqbeaww0MPh44MVCk6hBrY/XCRQpOf/Q0ff5jeY0J9SZVGZh3j2nj1sniHi+8TedUEK/
         0Bu7EHqgYw1TR72RIKIfaV/LN9U9m/hyEZu+urbPSHiMXfVY6MhY7wmzb0FMnJU4xagZ
         Q0wHOduZpB93b04Me7PUbqRsAclHhtlQYLZnLkfQSWLK/l7W13ab9Y233sqEb/EtF9xB
         9vpRpk/DZP6mK7zJKV12G2oRwW9JOHsFtQABwOy/fyB75gcdKlTszhhWDXf5PCadi5AG
         2m4Q==
X-Gm-Message-State: AOAM533cqVKm7tmRbJ5YSUPC31lX3LGr+qGxnRumHc8q6yAiFiEJN2iA
        xM11cODGebWoNUnJLs1K3Q==
X-Google-Smtp-Source: ABdhPJwMvO66agETDTyVrjALemeJhiff9EcntyMtFDg9PxbsUwq45QUEQmuet6J8vRtgnsPxptaZyg==
X-Received: by 2002:a05:6808:210c:: with SMTP id r12mr36201697oiw.104.1638142385795;
        Sun, 28 Nov 2021 15:33:05 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fe7:4487:4f99:dbc0:75d1:3e27])
        by smtp.gmail.com with ESMTPSA id e16sm2022706ook.38.2021.11.28.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 15:33:05 -0800 (PST)
Received: (nullmailer pid 2820721 invoked by uid 1000);
        Sun, 28 Nov 2021 23:32:41 -0000
Date:   Sun, 28 Nov 2021 17:32:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Jianjun Wang <jianjun.wang@mediatek.com>, john@phrozen.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 08/12] dt-bindings: PCI: Add support for Airoha EN7532
Message-ID: <YaQRmdHdFgIDo9yS@robh.at.kernel.org>
References: <20211125110738.41028-1-nbd@nbd.name>
 <20211125110738.41028-9-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125110738.41028-9-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Nov 2021 12:07:34 +0100, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> EN7532 is an ARM based platform SoC integrating the same PCIe IP as
> MT7622, add a binding for it.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
