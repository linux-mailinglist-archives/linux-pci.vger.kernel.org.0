Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D599A9845B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2019 21:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfHUT0s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Aug 2019 15:26:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39352 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfHUT0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Aug 2019 15:26:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id b1so3156864otp.6;
        Wed, 21 Aug 2019 12:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=10waZ0/ZkKGq42Av7UyfIsQLjaV5XyZlPq4+UDb3efY=;
        b=Kl9JXevtUhrZ3Tl8A/NDkp2aZ2yoO6bHdVmhIKjilshkv2HxOM/obSpkzj/3EOoyiD
         ACSo+42qm8I8aJpLFsjBtUjLYxW/iJ9YL28C4tGAOLL9MrXFcZu5O79Dpzch1mlqKVnY
         qH5v/s5tIz8Y1bak6LWqB3hBxiG1qN5tMsYSz6tPKs3T10zcHGvpnMbIhK/Da2WD7bTa
         zpzqMpqY81X3Zz7sSXiDSNobeQOGPz5k9EVINI9Q+aZUuaaTZdj2W1ym92+h6d6tF8oh
         hQyPmJ+S+SiraO+faAqLcyT5zCDXvuhins7ym4pHXL3YxLVWAztKXPJMCwEJSGdzc8UI
         EUUw==
X-Gm-Message-State: APjAAAU4V64p1CzoIS7BSb0skm5VJCreaGsYgcyea+j0cvAj+DjzH6Jm
        Y8MCULMOJZ1XEMiSx8MFsw==
X-Google-Smtp-Source: APXvYqxLs6MFhoQAEH6ogwkzbZqevbuPU9pesTaxbtwOpkRdDuv+cpoUh2/qMzsEYRLg7/dteh3tjg==
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr1554439oto.193.1566415606656;
        Wed, 21 Aug 2019 12:26:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z16sm3139424oic.10.2019.08.21.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 12:26:46 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:26:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, zhiqiang.hou@nxp.com, roy.zang@nxp.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCHv3 1/3] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1028a-pcie"
Message-ID: <20190821192645.GA22618@bogus>
References: <20190806061553.19934-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806061553.19934-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue,  6 Aug 2019 14:15:51 +0800, Xiaowei Bao wrote:
> Add the PCIe compatible string for LS1028A
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> v2:
>  - no change.
> v3:
>  - no change.
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
