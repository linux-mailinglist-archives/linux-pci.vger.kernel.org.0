Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1068F40A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 18:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjBHRLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 12:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBHRLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 12:11:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098AB4C6C9
        for <linux-pci@vger.kernel.org>; Wed,  8 Feb 2023 09:11:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so17441414wrg.13
        for <linux-pci@vger.kernel.org>; Wed, 08 Feb 2023 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cLeU01iMrKTQSb7NiGqblMUa6KGJs2t7KVkHL7EHQk=;
        b=h9Xh6ZADnvzoyAa4lzuNJ3dunqiN989gqbGwMrwuADfAobTQVl8ZYv5sh4VK+jNP48
         l4io5Pze8UM1YrFr2W9Cd+/5tgsPnwQor6///gucqpUtAB4CEQ1H45+pFC7O8O8NWC9U
         QWA09EwiCNs1El6NxGqC5tnHvfVbTUtSidx1f/wfOYib0Sqmv7MWBL8qqeFGEYPDX2Ra
         vu45b+L13CyUIGYQAYWef8h0zpj4qWJKkTHO+McEwWm9JXNWJ7WoiQ7IJSjiMhpbZ67I
         GozeHwl0TxaS61gTmWyTULXMHdGQek0xN+RfIz0BZZfyl41ywHHwgRf48J7RdJtfDkDc
         nlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cLeU01iMrKTQSb7NiGqblMUa6KGJs2t7KVkHL7EHQk=;
        b=POOqbkanyfKZP+gtF2R9mxNGoMvk8Upoq8BYtv5GsnAGB7WetI7TjuXSTiAmIYBVhf
         kBdZYvbNCY8raofnWTJBeeUeUQeYOUsIqw+aZfUjvTcsjJxfWZ36NkZ3TpLynxe3kW7Z
         EGaDEVioPN8pp8Q9uZqsjh1gsGhTimZarATY+4ypxhEleVT8TeJAP4qQ7F4x6MyHd8gT
         /JLUkQkhgTnfVtdYfe3uHzASH6KIxHDD1+KM4BZNSmcbzxtDRJmaVtEusoUe8wU5kIy9
         vg10vlk9vXox9deIt7XtwqHRD/Fh61bILQkPIXCqL3NN8QqaUwIWWNNUVIIFtgFBu67q
         CDjA==
X-Gm-Message-State: AO0yUKWmsupdHTElGTmfuHSOt+y1fZEWVtYewZzAd4b2NLe2X5/JWjhC
        rHxJAbuy858L6fhtlZJOEdam5w==
X-Google-Smtp-Source: AK7set98jhEGSGk80D+eEr7eD6Owem9Ck1coSHfJWvUYUEw5nAybGY8DOyPTrpJ/86nlYwAYwgU+gw==
X-Received: by 2002:a5d:6ac5:0:b0:2c3:ea7e:be24 with SMTP id u5-20020a5d6ac5000000b002c3ea7ebe24mr7723349wrw.28.1675876271530;
        Wed, 08 Feb 2023 09:11:11 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600002ab00b002bfb5ebf8cfsm14879545wry.21.2023.02.08.09.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:11:10 -0800 (PST)
Date:   Wed, 8 Feb 2023 19:11:08 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 10/12] PCI: qcom: Add SM8550 PCIe support
Message-ID: <Y+PXrFxobTf/+X+U@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-11-abel.vesa@linaro.org>
 <Y9zYpE/GnxUqnIyq@hovoldconsulting.com>
 <Y+EYhe/xYSFpI1Yn@linaro.org>
 <Y+PQYxh4t/ytOe3+@hovoldconsulting.com>
 <Y+PXeYrBBL3QaznM@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PXeYrBBL3QaznM@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23-02-08 19:10:17, Abel Vesa wrote:
> On 23-02-08 17:40:03, Johan Hovold wrote:
> > On Mon, Feb 06, 2023 at 05:11:01PM +0200, Abel Vesa wrote:
> > > On 23-02-03 10:49:24, Johan Hovold wrote:
> > > > On Fri, Feb 03, 2023 at 10:18:05AM +0200, Abel Vesa wrote:
> > > > > Add compatible for both PCIe found on SM8550.
> > > > > Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> > > > 
> > > > nit: You're now also adding 'noc_aggr'
> > > > 
> > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > > ---
> > 
> > > > > @@ -182,10 +182,10 @@ struct qcom_pcie_resources_2_3_3 {
> > > > >  
> > > > >  /* 6 clocks typically, 7 for sm8250 */
> > > > >  struct qcom_pcie_resources_2_7_0 {
> > > > > -	struct clk_bulk_data clks[12];
> > > > > +	struct clk_bulk_data clks[14];
> > > > >  	int num_clks;
> > > > >  	struct regulator_bulk_data supplies[2];
> > > > > -	struct reset_control *pci_reset;
> > > > > +	struct reset_control *rst;
> > > > 
> > > > Please name this one 'reset' or 'resets' (e.g. to avoid hard to parse
> > > > things like res->rst below).
> > > 
> > > Well, it would then be inconsitent with 2_3_3 and 2_9_0, which both use
> > > rst.
> > 
> > Yeah, I saw that. Fortunately these resources are completely
> > independent, but whatever.
> 
> Will do it in the next version then.
> 
> >  
> > > > >  };
> > > > >  
> > > > >  struct qcom_pcie_resources_2_9_0 {
> > > > > @@ -1177,9 +1177,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > > > >  	unsigned int idx;
> > > > >  	int ret;
> > > > >  
> > > > > -	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> > > > > -	if (IS_ERR(res->pci_reset))
> > > > > -		return PTR_ERR(res->pci_reset);
> > > > > +	res->rst = devm_reset_control_array_get_exclusive(dev);
> > > > > +	if (IS_ERR(res->rst))
> > > > > +		return PTR_ERR(res->rst);
> > > > 
> > > > So the reset array implementation apparently both asserts and deasserts
> > > > the resets in the order specified in DT (i.e. does not deassert in
> > > > reverse order).
> > > > 
> > > > Is that ok also for the new "pci" and "link_down" resets?
> > > 
> > > According to the HPG, yes, this is perfectly fine. It specifically says
> > > to assert the pcie reset and then continues saying to assert the
> > > link_down reset.
> > 
> > Ok, but that doesn't really say anything about whether it's ok to
> > *deassert* them in the same order, which was what I asked about.
> 
> Actually, what I wanted to say is that the HPG says something like this:
> 
> "assert pcie reset, then assert link_down"
> 
> and then at the end it literaly repeats the same phrase.

but uses deassert instead of assert ...

> 
> 
> 
> 
> 
> > 
> > Johan
