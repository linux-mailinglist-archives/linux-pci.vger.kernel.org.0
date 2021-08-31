Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0246D3FC2E1
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 08:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhHaGic (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 02:38:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:58942 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhHaGic (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 02:38:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630391857; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qqB1D15exrSt/pTX3OC7nAqPOaP6u3UrkRxV0w2R5VU=;
 b=Q8B5nUtYOtSu5KHIlp9Mcch1SefBlqFdfbIIRm0DdXL41E0JuOVqRsegWLj/T/5EfDgLB0MS
 jlEVdTtSz4k4qY2AXz1lvWHUWjZg2bXecogHoJneGiF1oKI0t7dLeEV6n3Hqf8IxeTDqf2a3
 wlw/cc42Lh7TNnWK4OJkZaVLd1k=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 612dce30f61b2f864b7986a7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 31 Aug 2021 06:37:36
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 433C8C43460; Tue, 31 Aug 2021 06:37:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B809C4338F;
        Tue, 31 Aug 2021 06:37:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Aug 2021 12:07:30 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, svarbanov@mm-sol.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 4/4] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
In-Reply-To: <CAL_Jsq+4RZejPcgX3J5JDGnHB6Lgx54BVgwfaZrNuY759wm9ig@mail.gmail.com>
References: <20210825212549.GA3609092@bjorn-Precision-5520>
 <1795efc94a7b87fb4d9f769e03ce21c6@codeaurora.org>
 <CAL_Jsq+4RZejPcgX3J5JDGnHB6Lgx54BVgwfaZrNuY759wm9ig@mail.gmail.com>
Message-ID: <268d53aa6ec8f05928f083dfb0484ae2@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-26 18:07, Rob Herring wrote:
> On Thu, Aug 26, 2021 at 2:22 AM Prasad Malisetty
> <pmaliset@codeaurora.org> wrote:
>> 
>> On 2021-08-26 02:55, Bjorn Helgaas wrote:
>> > [+cc linux-pci; patches to drivers/pci/ should always be cc'd there]
>> >
>> > On Wed, Aug 25, 2021 at 07:30:09PM +0000, Stephen Boyd wrote:
>> >> Quoting Prasad Malisetty (2021-08-24 01:10:48)
>> >> > On 2021-08-17 22:56, Prasad Malisetty wrote:
>> >> > > On 2021-08-10 09:38, Prasad Malisetty wrote:
>> >> > >> On the SC7280, By default the clock source for pcie_1_pipe is
>> >> > >> TCXO for gdsc enable. But after the PHY is initialized, the clock
>> >> > >> source must be switched to gcc_pcie_1_pipe_clk from TCXO.
>> >> > >>
>> >> > >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
>> >> > >> ---
>> >> > >>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++++
>> >> > >>  1 file changed, 18 insertions(+)
>> >> > >>
>> >> > >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
>> >> > >> b/drivers/pci/controller/dwc/pcie-qcom.c
>> >> > >> index 8a7a300..39e3b21 100644
>> >> > >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> >> > >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> >> > >> @@ -166,6 +166,8 @@ struct qcom_pcie_resources_2_7_0 {
>> >> > >>      struct regulator_bulk_data supplies[2];
>> >> > >>      struct reset_control *pci_reset;
>> >> > >>      struct clk *pipe_clk;
>> >> > >> +    struct clk *gcc_pcie_1_pipe_clk_src;
>> >> > >> +    struct clk *phy_pipe_clk;
>> >> > >>  };
>> >> > >>
>> >> > >>  union qcom_pcie_resources {
>> >> > >> @@ -1167,6 +1169,16 @@ static int qcom_pcie_get_resources_2_7_0(struct
>> >> > >> qcom_pcie *pcie)
>> >> > >>      if (ret < 0)
>> >> > >>              return ret;
>> >> > >>
>> >> > >> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280")) {
>> >> > >> +            res->gcc_pcie_1_pipe_clk_src = devm_clk_get(dev, "pipe_mux");
>> >> > >> +            if (IS_ERR(res->gcc_pcie_1_pipe_clk_src))
>> >> > >> +                    return PTR_ERR(res->gcc_pcie_1_pipe_clk_src);
>> >> > >> +
>> >> > >> +            res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
>> >> > >> +            if (IS_ERR(res->phy_pipe_clk))
>> >> > >> +                    return PTR_ERR(res->phy_pipe_clk);
>> >> > >> +    }
>> >> > >
>> >> > > I would like to check is there any other better approach instead of
>> >> > > compatible method here as well or is it fine to use compatible method.
>> >>
>> >> I'd prefer the compatible method. If nobody is responding then it's
>> >> best
>> >> to just resend the patches with the approach you prefer instead of
>> >> waiting for someone to respond to a review comment.
>> >
>> > I'm missing some context here, so I'm not exactly sure what your
>> > question is, Prasad, but IMO drivers generally should not need to use
>> > of_device_is_compatible() if they've already called
>> > of_device_get_match_data() (as qcom_pcie_probe() has).
>> >
>> > of_device_is_compatible() does basically the same work of looking for
>> > a match in qcom_pcie_match[] that of_device_get_match_data() does, so
>> > it seems pointless to repeat it.
> 
> +1
> 
>> > I am a little confused because while [1] adds "qcom,pcie-sc7280" to
>> > qcom,pcie.txt, I don't see a patch that adds it to qcom_pcie_match[].
> 
> Either that's missing or there's a fallback to 8250 that's not 
> documented.
>> >
>> > Bjorn
>> >
>> Hi Bjorn,
>> 
>> I agree on your point, but the main reason is to use compatible in
>> get_resources_2_7_0 is same hardware version. For SM8250 & SC7280
>> platforms, the hw version is same. Since we can't have a separate ops
>> for SC7280, we are using compatible method in get_resources_2_7_0 to
>> differentiate SM8250 and SC7280.
> 
> Then fix the match data to be not just ops, but ops and the flag you 
> need here.
> 
> Rob

Hi Rob,

Thanks for your review comments and inputs .

This difference is not universal across all the platforms but instead 
this is specific to SC7280.
Hence it make sense to use compatible other than going for a flag.

Thanks
-Prasad
