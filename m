Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4132FD03
	for <lists+linux-pci@lfdr.de>; Sat,  6 Mar 2021 21:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhCFUKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Mar 2021 15:10:19 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:34892 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCFUKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Mar 2021 15:10:05 -0500
Received: by mail-pg1-f179.google.com with SMTP id t25so3718944pga.2;
        Sat, 06 Mar 2021 12:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y0NmWmr7+4hpuoemyFwvJHGOeoSS8zaaxD5X6QfXCJc=;
        b=UdraFa/2rbnEQq1x0dFObaf6+9iMNX4KCnilvnxPYt4HQUanwDBiXzfytH+d/n4NHq
         sZid+fJjHpGuH30q05cajNzq0UGMgrL0DMTwsZGd3bV1vIHzSoJotKSalcqJjC23OvRB
         v8sSnkrB8rddHCayXQwqL2tI3aGJ4RRsMWM3g2mGRkxwb/tlf9Les3D7X5/LfDjc5Xxp
         RWiDgDLWOPFHJJJAqsNrXJP4WNI53X/hNWxdkGr4POf4RE1ap69KvE7NismwMNGxWdyv
         LfTuPuHF6mfrfl+wnwT+uy/go093lTWJlF1H0lR1kvBukqx/9wSrFhCOfArOBUFG1WIM
         wexw==
X-Gm-Message-State: AOAM5310IWfW4jQOFhRVyOeUvZSydEsGyfTo28AM2W2ZvfelxDh+IMDH
        ezoiGz/YTI4vTjRbdyCXOIphxKWeIDnX
X-Google-Smtp-Source: ABdhPJwiuJ3EVFjA825MHShdsn4N/3ANb/rRFBPZlrtTeb4DG2Jh3WifNEVmvwdFzrMMQEKlpKHupA==
X-Received: by 2002:a62:e809:0:b029:1ed:c7ec:179b with SMTP id c9-20020a62e8090000b02901edc7ec179bmr14276589pfi.43.1615061405061;
        Sat, 06 Mar 2021 12:10:05 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.27.98])
        by smtp.gmail.com with ESMTPSA id p26sm5933909pfn.127.2021.03.06.12.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 12:10:04 -0800 (PST)
Received: (nullmailer pid 1137739 invoked by uid 1000);
        Sat, 06 Mar 2021 20:09:58 -0000
Date:   Sat, 6 Mar 2021 13:09:58 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
        youlin.pei@mediatek.com, anson.chuang@mediatek.com,
        Philipp Zabel <p.zabel@pengutronix.de>, maz@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, chuanjia.liu@mediatek.com,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rex-BC.Chen@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sj Huang <sj.huang@mediatek.com>, sin_jieyang@mediatek.com,
        drinkcat@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, qizhong.cheng@mediatek.com
Subject: Re: [v8,1/7] dt-bindings: PCI: mediatek-gen3: Add YAML schema
Message-ID: <20210306200958.GA1137684@robh.at.kernel.org>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
 <20210224061132.26526-2-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224061132.26526-2-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Feb 2021 14:11:26 +0800, Jianjun Wang wrote:
> Add YAML schemas documentation for Gen3 PCIe controller on
> MediaTek SoCs.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 181 ++++++++++++++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
