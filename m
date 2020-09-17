Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244DD26D2C5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 06:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIQEkb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 00:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgIQEkb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 00:40:31 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 00:40:30 EDT
Received: from localhost (unknown [136.185.111.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48D02075E;
        Thu, 17 Sep 2020 04:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600317163;
        bh=s17TDe+HqxPv+0W4FH6Ox4FMMt2wi7Eu6ArcbO9bhkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TurpCaD5gtig9W8PoCYREz2lJlmgzsA58TCSwN/U9l6CiDsM23pwmRXXe85F/LIqF
         BubWSy4a/0Tg1MSv3gbWEn/WqxrBMcZwO0vPPy/BaLeX0KBU5yzLN5I3gJ+cCpBFdf
         RoySljMsD8wUqaUX2HZVXfvLCDonq8+ScJRgi/R0=
Date:   Thu, 17 Sep 2020 10:02:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        agross@kernel.org, kishon@ti.com, robh@kernel.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: phy: qcom,qmp: Document SM8250 PCIe PHY
 bindings
Message-ID: <20200917043239.GW2968@vkoul-mobl>
References: <20200916132000.1850-1-manivannan.sadhasivam@linaro.org>
 <20200916132000.1850-2-manivannan.sadhasivam@linaro.org>
 <20200916224541.GF1893@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916224541.GF1893@yoga>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16-09-20, 17:45, Bjorn Andersson wrote:
> On Wed 16 Sep 08:19 CDT 2020, Manivannan Sadhasivam wrote:
> 
> > Document the DT bindings of below PCIe PHY versions used on SM8250:
> > 
> > QMP GEN3x1 PHY - 1 lane
> > QMP GEN3x2 PHY - 2 lanes
> > QMP Modem PHY - 2 lanes
> 
> How about something like "Add the three PCIe PHYs found in SM8250 to the
> QMP binding"?

Or add just one compatible sm8250-qmp-pcie and then use number of lanes
as dt property?

> 
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > index 185cdea9cf81..69b67f79075c 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> > @@ -31,6 +31,9 @@ properties:
> >        - qcom,sdm845-qmp-usb3-uni-phy
> >        - qcom,sm8150-qmp-ufs-phy
> >        - qcom,sm8250-qmp-ufs-phy
> > +      - qcom,qcom,sm8250-qmp-gen3x1-pcie-phy
> > +      - qcom,qcom,sm8250-qmp-gen3x2-pcie-phy
> > +      - qcom,qcom,sm8250-qmp-modem-pcie-phy
> 
> One "qcom," should be enough.
> 
> >  
> >    reg:
> >      items:
> > @@ -259,6 +262,8 @@ allOf:
> >              enum:
> >                - qcom,sdm845-qhp-pcie-phy
> >                - qcom,sdm845-qmp-pcie-phy
> > +              - qcom,sm8250-qhp-pcie-phy
> > +              - qcom,sm8250-qmp-pcie-phy
> 
> Adjust these.
> 
> Regards,
> Bjorn
> 
> >      then:
> >        properties:
> >          clocks:
> > -- 
> > 2.17.1
> > 

-- 
~Vinod
