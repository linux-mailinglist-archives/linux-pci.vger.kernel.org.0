Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D664C0A05
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfI0RH2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 13:07:28 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42043 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0RH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 13:07:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id i185so5782511oif.9;
        Fri, 27 Sep 2019 10:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmlKF4hMEHfzpRwq7atJ+qTxrDo2w2v+Z7AeG3RAxUE=;
        b=MzGi9eqlXmRvoh04md29d07B2wxNaCsFGg1KPYJtJpuHGRPSCQ/rQ/oJDE6a0POfGi
         78pJsqkKq8goJ4YvItvgCSIChx7UrPIEHzW7xsInQgRvtoBE7eHX2BwCcsZlcEKGLTtO
         svNP4tfhpJMK5uPwRIF8+cgGPU5wTNasAs85SDuD+2HqU6BuoHPS4uhuCVRqOflfxFLr
         PmBxvhiCYjOGj1R5y1O3qpIaoQYA5srRxiPLf9MpeI48CZVhGGlz/NCPnCGjWX6RE7Uh
         zD7ZZKrEl9Pruj2jLa/hkbLvsI1Mgl7FWZDqSekDFNgfnnLkPXEDL0lXA3rGfdsVxyko
         8iCA==
X-Gm-Message-State: APjAAAXpV7nw/U+GkFHHfylBVeoeLg4QiJ86ydsMbcgQ/b4bNFErqWmX
        eMGuMgkZ2PCsgc/oLg6RUg==
X-Google-Smtp-Source: APXvYqy6XbAKw09JULTK3jY2nEL2mm1ktOd1lHG8UV4Z/DmKhKvtYR9KJiuaxJ397QE0WXhXkgIvaA==
X-Received: by 2002:aca:f3d4:: with SMTP id r203mr7634907oih.164.1569604046646;
        Fri, 27 Sep 2019 10:07:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m25sm1763994oie.39.2019.09.27.10.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 10:07:26 -0700 (PDT)
Date:   Fri, 27 Sep 2019 12:07:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH v4 05/11] dt-bindings: pci: layerscape-pci: Add
 compatible strings for ls1088a and ls2088a
Message-ID: <20190927170725.GA28135@bogus>
References: <20190924021849.3185-1-xiaowei.bao@nxp.com>
 <20190924021849.3185-6-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924021849.3185-6-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 24 Sep 2019 10:18:43 +0800, Xiaowei Bao wrote:
> Add compatible strings for ls1088a and ls2088a.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - No change.
> v3:
>  - Use one valid combination of compatible strings.
> v4:
>  - Add the comma between the two compatible.
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
