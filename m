Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70112661
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 05:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfECDKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 23:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfECDKd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 23:10:33 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CAB2070B;
        Fri,  3 May 2019 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556853032;
        bh=+1g2xXHLzB+wlup4fZihm+HP4DcA3/0YblOv/pUVDGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRX9apE4PPVTr9nB5HkiKaTV24wRHaLUf8DBRr/RoMzNgUn9CrZpRhvBVSA+8jdoN
         h5BQhLLyk46B8n6ioOcJrlBHyqHLfL97Uta+M01RDSTS/nbe1rmKBToozJCyvmY/Zm
         QVbLlennYlP7B4QZnFUuMNyqEYHnWDlxvGyNXF2w=
Date:   Fri, 3 May 2019 08:40:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
Message-ID: <20190503031020.GV3845@vkoul-mobl.Dlink>
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
 <20190502001955.10575-2-bjorn.andersson@linaro.org>
 <20190502115351.GM3845@vkoul-mobl.Dlink>
 <20190502150006.GL2938@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502150006.GL2938@tuxbook-pro>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02-05-19, 08:00, Bjorn Andersson wrote:
> On Thu 02 May 04:53 PDT 2019, Vinod Koul wrote:
> > On 01-05-19, 17:19, Bjorn Andersson wrote:
> [..]
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 0ed235d560e3..d740cbe0e56d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -112,10 +112,10 @@ struct qcom_pcie_resources_2_3_2 {
> > >  	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
> > >  };
> > >  
> > > +#define QCOM_PCIE_2_4_0_MAX_CLOCKS	3
> > 
> > empty line after the define please
> > 
> 
> This follows the style of QCOM_PCIE_2_3_2_MAX_SUPPLY one block up, so
> I think this is the way we want it.

Okay sounds fine to me

> 
> > >  struct qcom_pcie_resources_2_4_0 {
> [..]
> > 
> > 
> > rest lgtm:
> > 
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > 
> 
> Thanks!
> 
> Regards,
> Bjorn

-- 
~Vinod
