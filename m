Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB46B3DAED6
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhG2W1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:27:45 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:37601 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhG2W1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:27:43 -0400
Received: by mail-io1-f43.google.com with SMTP id r18so9108868iot.4;
        Thu, 29 Jul 2021 15:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qgj7Oz+Z4oQUajH16rwmhqgIjsE8vKHUhln4wEool40=;
        b=nM4PlYn5mDkLkNXSF+Wub463iAJTTNvn5sB+Sies1KKCSTzAw0qcVuOezBAknPKSwJ
         DZWKTe+VVRv4uyMiPn16p6+nEvcnqAxOsXDIBaTAvyDxMTkDd0nOMf87f2EPy1IdKglg
         ojal0lzTiF4+ven0urchf2Jd+wVrRyIoy2s4xGqm8/2X4ttvZGNJ+4MF48WMPkL0UgSO
         tlrOK5LCpQdgXstPXNxV4iQ64KMr/bQQ3N//YYIu1N+Dqeo1JcOG4iRvdK1N1g2TCb51
         A4bpICl+If7aJslOrsXoCiMbI8aTOePQkrU0sMCjJc9mOOL/A55AeyulgMoKGNe6SR70
         UYRw==
X-Gm-Message-State: AOAM530A9fAS7j16f/G8jzBptaBkcEd+QqHObIU19SoamM8WeZuebwLT
        coAOBQ6iK1Yx6ImnSjiE4g==
X-Google-Smtp-Source: ABdhPJxMf6QFRuwiADJWh2p0kei3afSyvCSMwWd/LbLRzsgb78lCuFeuQ4wcy86IpAMeagGMp2fWQg==
X-Received: by 2002:a02:ccec:: with SMTP id l12mr6310078jaq.61.1627597658139;
        Thu, 29 Jul 2021 15:27:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k10sm1468258ili.86.2021.07.29.15.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:27:37 -0700 (PDT)
Received: (nullmailer pid 1016337 invoked by uid 1000);
        Thu, 29 Jul 2021 22:27:36 -0000
Date:   Thu, 29 Jul 2021 16:27:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: qcom: Add sc8180x compatible
Message-ID: <YQMrWHyhvBIlFBMr@robh.at.kernel.org>
References: <20210725040038.3966348-1-bjorn.andersson@linaro.org>
 <20210725040038.3966348-4-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725040038.3966348-4-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 24, 2021 at 09:00:38PM -0700, Bjorn Andersson wrote:
> The SC8180x platform comes with 4 PCIe controllers, typically used for
> things such as NVME storage or connecting a SDX55 5G modem. Add a
> compatible for this, that just reuses the 1.9.0 ops.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++--
>  drivers/pci/controller/dwc/pcie-qcom.c              | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
