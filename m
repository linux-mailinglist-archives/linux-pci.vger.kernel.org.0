Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9275C9F0F4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 18:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfH0Q5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 12:57:45 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:39938 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbfH0Q5o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 12:57:44 -0400
Received: by mail-ot1-f53.google.com with SMTP id c34so19356323otb.7;
        Tue, 27 Aug 2019 09:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e34XC5omSPkrZmlMoY94//8TGLk1xQwBY2owDQuZ6pU=;
        b=WwFCAQL6xjcL39RzeYzWqPIkDGliOto7KQQN3P8HoSxGt4xKGlLjDj/qX9aw9T4caL
         clKrk4pvHI1lqayrX8mr7r2dTpDvRVNOVo7QMdMrnJRwhr2m1L+4oZkdtTSmZ2/WvEI5
         HhyaNU5+TMEnUXepuztWb+0d4hkvd3meD96gF1+Vn68y0pDjG9lLSDXFO9joGqw/HHEM
         FFPgbNLb++Otdv5uZarVGNvobir3V1sFx1YOiy+jbfqtvzu089npXG1M9yQxU0/iChez
         DkO1OyJ1vHfjlVprW9/27Vr7LxaWj3U/360nDtSfNoBBP9VVkPGTpvBWxD3dFjLbVxpY
         RwFw==
X-Gm-Message-State: APjAAAW0JeZc8da7rZNiGNcq+xIoA1Y/HpKhEbKlJkpZYYeX09B7sEnA
        j6goAMXc9Be/DEE1QKvl2w==
X-Google-Smtp-Source: APXvYqxfJvReAk8gOPh8OBq+8npMo5SEDQRFFNpZg0W2AGejCsNo+idFunecxm0L/VujnvtLXPrsJQ==
X-Received: by 2002:a9d:200c:: with SMTP id n12mr21465382ota.334.1566925063917;
        Tue, 27 Aug 2019 09:57:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w10sm5452551otm.68.2019.08.27.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:57:43 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:57:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: Re: [PATCHv2 1/4] dt-bindings: PCI: designware: Remove the num-lanes
 from  Required properties
Message-ID: <20190827165742.GA5083@bogus>
References: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
 <20190820073022.24217-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820073022.24217-2-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 20 Aug 2019 07:28:43 +0000, "Z.q. Hou" wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The num-lanes is not a mandatory property, e.g. on FSL
> Layerscape SoCs, the PCIe link training is completed
> automatically base on the selected SerDes protocol, it
> doesn't need the num-lanes to set-up the link width.
> 
> It is previously in both Required and Optional properties,
> let's remove it from the Required properties.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Reworded the change log and subject.
>  - Fixed a typo in subject.
> 
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
