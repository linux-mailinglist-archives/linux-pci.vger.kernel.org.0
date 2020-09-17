Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1226D2E4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 07:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIQFKO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 01:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQFKO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2020 01:10:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF280C061756
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 22:10:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so1045401oia.8
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2020 22:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSMe0eSMdIe3Gfx6n3S8crTzPvy5rJ0iSHhhJ3uKFKQ=;
        b=iepgFmQ3Sui7+BcQEaNk/iFybMWOQ0B86m5XI/ZdRIUoMN0f6VUK8V3Lt68EYUEwzR
         NpyYa7w3a4CU1H8rh9UvWl9FqtD3Uu5eWb0rKPoG6AKl0UN1EzZjRvvE6StOxT9q0lNq
         vcVV3rZYILRRUqUzHt+DmzHj0nSe3fFpJhcomgoDBLLT1t44r44j7SKLiT4p4w46u+Sa
         NFRDONt4EAwfsR/1HsbxT6jZCEV5QpNj90MLkARVC9L1OhfnoZnnFrA5gIue3tLt5lN2
         Z/M3T73c4p53V2IFF3EX20OaB/yePEHVRIz5NVEn5vcFAbcz05Td3rGBNkWoWu7zt7gd
         cYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSMe0eSMdIe3Gfx6n3S8crTzPvy5rJ0iSHhhJ3uKFKQ=;
        b=rxtjKXH+Oo1L/spmb1NcU4oZrxW2x+VN0jqOuRf3xPM2nSMNNJEE7hFlT8CTJFwL/S
         9syG6HafI7yVGCkMKCPe4e3wrTm0oyJWveZzy9ACGKQYFcRVypAxM3YwbNWQ6DQPn805
         q0J0V2+z2hgEJayiyvpHru1oLkqVXPulvbazxeM9SS7P9QP+74hJeuTQ0r4MrjVxURhe
         zfWsRTRYAtGvKru91cAz7Upch1ETQ+BoYzp6FPraFtyFxyY83HuBfa2GUi1JLs/YqMHa
         bL25llWgyxnh2lpD03m9l5gHyYJAsMtuMJWV9rRXpKdSu2BVh20dJhQcjqSAYR5fym2W
         +I9Q==
X-Gm-Message-State: AOAM532OqM9bpJq/Fbt5j606zuZP5eMlPSxiTDTMjt0wU0DDWZbrY+D8
        YekTJddSyYjobj7zIRQv8MsvSg==
X-Google-Smtp-Source: ABdhPJwlxnRFSwIwfe8pWnIKka7QS5n3Xntowx6Mq4Fdts+kaIq8AluucE5JQFb/Uuoh9uwg/npQDg==
X-Received: by 2002:aca:c7c5:: with SMTP id x188mr5535465oif.34.1600319412788;
        Wed, 16 Sep 2020 22:10:12 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:7cad:6eff:fec8:37e4])
        by smtp.gmail.com with ESMTPSA id 189sm10965833oid.40.2020.09.16.22.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 22:10:11 -0700 (PDT)
Date:   Thu, 17 Sep 2020 00:10:08 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        agross@kernel.org, kishon@ti.com, robh@kernel.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: phy: qcom,qmp: Document SM8250 PCIe PHY
 bindings
Message-ID: <20200917051008.GM1893@yoga>
References: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
 <20200916132000.1850-2-manivannan.sadhasivam@linaro.org>
 <20200916224541.GF1893@yoga>
 <20200917043239.GW2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917043239.GW2968@vkoul-mobl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed 16 Sep 23:32 CDT 2020, Vinod Koul wrote:

> On 16-09-20, 17:45, Bjorn Andersson wrote:
> > On Wed 16 Sep 08:19 CDT 2020, Manivannan Sadhasivam wrote:
> > 
> > > Document the DT bindings of below PCIe PHY versions used on SM8250:
> > > 
> > > QMP GEN3x1 PHY - 1 lane
> > > QMP GEN3x2 PHY - 2 lanes
> > > QMP Modem PHY - 2 lanes
> > 
> > How about something like "Add the three PCIe PHYs found in SM8250 to the
> > QMP binding"?
> 
> Or add just one compatible sm8250-qmp-pcie and then use number of lanes
> as dt property?
> 

If we have the same initialization sequence then that sounds reasonable.
Perhaps we can derive the number of lanes from the child node?

A bigger question is how we deal with this going forward, if there are
more crazy setups like on sc8180x where the lanes might be grouped
differently based on board...

Regards,
Bjorn

> > 
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > > index 185cdea9cf81..69b67f79075c 100644
> > > --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > > +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > > @@ -31,6 +31,9 @@ properties:
> > >        - qcom,sdm845-qmp-usb3-uni-phy
> > >        - qcom,sm8150-qmp-ufs-phy
> > >        - qcom,sm8250-qmp-ufs-phy
> > > +      - qcom,qcom,sm8250-qmp-gen3x1-pcie-phy
> > > +      - qcom,qcom,sm8250-qmp-gen3x2-pcie-phy
> > > +      - qcom,qcom,sm8250-qmp-modem-pcie-phy
> > 
> > One "qcom," should be enough.
> > 
> > >  
> > >    reg:
> > >      items:
> > > @@ -259,6 +262,8 @@ allOf:
> > >              enum:
> > >                - qcom,sdm845-qhp-pcie-phy
> > >                - qcom,sdm845-qmp-pcie-phy
> > > +              - qcom,sm8250-qhp-pcie-phy
> > > +              - qcom,sm8250-qmp-pcie-phy
> > 
> > Adjust these.
> > 
> > Regards,
> > Bjorn
> > 
> > >      then:
> > >        properties:
> > >          clocks:
> > > -- 
> > > 2.17.1
> > > 
> 
> -- 
> ~Vinod
