Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6003236FD4F
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhD3PGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 11:06:16 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37506 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3PGQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 11:06:16 -0400
Received: by mail-ot1-f49.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso50598589otm.4;
        Fri, 30 Apr 2021 08:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UtTHHLQsplee9C29Cg59LYjLb0qT4MBNWWXqLYYCrMk=;
        b=fsv3+66RQ9eQEQQ6oDUobG1w7cqxTP9zGeXrL0Z136Ssl0Tz3oBAf+rMb0T1Brb8ek
         tfhXzusSZqMZcLp9JrATuCE2wHoJd3RJbgmZDWScr65E4oxiwAeoGDP/qgFVZJj72mxs
         MU+0Xz+vtF4mx1ICaelhQiweiucSpxvmgl+oh1sL2LvNG50KdJ9ZFSgROAlb/qDNJBBI
         c79KfuNEG9PZU8HCsW+/lO2/th930kgiC4s17s8cRk9flA0dapvj1r3ebUJTxUDIC1aj
         zzHWmcJnmsveQcnAcGVTSQ8zvtIcjaHfo6TuyqmYFM1tmPffD7pqIRDwFlbXAJL8Myyi
         +piA==
X-Gm-Message-State: AOAM531jRutYc8UUDSQFfTDMtLyU2fV748y3cKYbOkbePlFt8SxXjk1p
        IuV1yjIXG/grazSYwOxf+g==
X-Google-Smtp-Source: ABdhPJx1O2/+nZKt9VsdxpJqX6nGHemCbL49ftbKVxAnrCeSzCa7c/mPWvFZ64aU1ZwqfgyTwX8BnA==
X-Received: by 2002:a05:6830:1db9:: with SMTP id z25mr1490915oti.220.1619795127585;
        Fri, 30 Apr 2021 08:05:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w13sm798615oop.0.2021.04.30.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:05:26 -0700 (PDT)
Received: (nullmailer pid 3323131 invoked by uid 1000);
        Fri, 30 Apr 2021 15:05:25 -0000
Date:   Fri, 30 Apr 2021 10:05:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-pci@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-phy@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: pci: qcom: Document PCIe bindings for
 IPQ6018 SoC
Message-ID: <20210430150525.GA3323075@robh.at.kernel.org>
References: <cover.1618916235.git.baruch@tkos.co.il>
 <e285d5041b8c19d4a7fab4d1a3ce9dd2b487cbad.1618916235.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e285d5041b8c19d4a7fab4d1a3ce9dd2b487cbad.1618916235.git.baruch@tkos.co.il>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 20 Apr 2021 14:21:40 +0300, Baruch Siach wrote:
> Document qcom,pcie-ipq6018. This is similar to the ipq8074 with a few
> different clock sources, and one additional reset.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
