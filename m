Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B199F3F8308
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhHZHWu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 03:22:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49942 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239716AbhHZHWs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 03:22:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629962522; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8J143XZo6LFlAmaWmXyTY2AHmtwZhvUtLUftnRuhvRU=;
 b=N/uYYjUqaRdW/gKYQSWvd6OyaaqKvmh2A8j1Q/mhSgDHxLl5biZ6PwO5Fi5qgHxmml9Kruz3
 3fErNE1aV2nKBaCvcWxmY/Q0F2gxiNEtp2OgVrbl6RoZYKZOsV1hozof5lLOhK4t2gdxMkwE
 vR+BhY01v0bjiDHcBMADgvn/NHs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 61274113825e13c54a286fb6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 26 Aug 2021 07:21:55
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A4877C43618; Thu, 26 Aug 2021 07:21:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B42AC4338F;
        Thu, 26 Aug 2021 07:21:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Aug 2021 12:51:53 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bhelgaas@google.com, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        svarbanov@mm-sol.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org, vbadigan@codeaurora.org, sallenki@codeaurora.org,
        manivannan.sadhasivam@linaro.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 4/4] PCI: qcom: Switch pcie_1_pipe_clk_src after PHY
 init in SC7280
In-Reply-To: <20210825212549.GA3609092@bjorn-Precision-5520>
References: <20210825212549.GA3609092@bjorn-Precision-5520>
Message-ID: <1795efc94a7b87fb4d9f769e03ce21c6@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-26 02:55, Bjorn Helgaas wrote:
> [+cc linux-pci; patches to drivers/pci/ should always be cc'd there]
> 
> On Wed, Aug 25, 2021 at 07:30:09PM +0000, Stephen Boyd wrote:
>> Quoting Prasad Malisetty (2021-08-24 01:10:48)
>> > On 2021-08-17 22:56, Prasad Malisetty wrote:
>> > > On 2021-08-10 09:38, Prasad Malisetty wrote:
>> > >> On the SC7280, By default the clock source for pcie_1_pipe is
>> > >> TCXO for gdsc enable. But after the PHY is initialized, the clock
>> > >> source must be switched to gcc_pcie_1_pipe_clk from TCXO.
>> > >>
>> > >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
>> > >> ---
>> > >>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++++
>> > >>  1 file changed, 18 insertions(+)
>> > >>
>> > >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
>> > >> b/drivers/pci/controller/dwc/pcie-qcom.c
>> > >> index 8a7a300..39e3b21 100644
>> > >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> > >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> > >> @@ -166,6 +166,8 @@ struct qcom_pcie_resources_2_7_0 {
>> > >>      struct regulator_bulk_data supplies[2];
>> > >>      struct reset_control *pci_reset;
>> > >>      struct clk *pipe_clk;
>> > >> +    struct clk *gcc_pcie_1_pipe_clk_src;
>> > >> +    struct clk *phy_pipe_clk;
>> > >>  };
>> > >>
>> > >>  union qcom_pcie_resources {
>> > >> @@ -1167,6 +1169,16 @@ static int qcom_pcie_get_resources_2_7_0(struct
>> > >> qcom_pcie *pcie)
>> > >>      if (ret < 0)
>> > >>              return ret;
>> > >>
>> > >> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280")) {
>> > >> +            res->gcc_pcie_1_pipe_clk_src = devm_clk_get(dev, "pipe_mux");
>> > >> +            if (IS_ERR(res->gcc_pcie_1_pipe_clk_src))
>> > >> +                    return PTR_ERR(res->gcc_pcie_1_pipe_clk_src);
>> > >> +
>> > >> +            res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
>> > >> +            if (IS_ERR(res->phy_pipe_clk))
>> > >> +                    return PTR_ERR(res->phy_pipe_clk);
>> > >> +    }
>> > >
>> > > I would like to check is there any other better approach instead of
>> > > compatible method here as well or is it fine to use compatible method.
>> 
>> I'd prefer the compatible method. If nobody is responding then it's 
>> best
>> to just resend the patches with the approach you prefer instead of
>> waiting for someone to respond to a review comment.
> 
> I'm missing some context here, so I'm not exactly sure what your
> question is, Prasad, but IMO drivers generally should not need to use
> of_device_is_compatible() if they've already called
> of_device_get_match_data() (as qcom_pcie_probe() has).
> 
> of_device_is_compatible() does basically the same work of looking for
> a match in qcom_pcie_match[] that of_device_get_match_data() does, so
> it seems pointless to repeat it.
> 
> I am a little confused because while [1] adds "qcom,pcie-sc7280" to
> qcom,pcie.txt, I don't see a patch that adds it to qcom_pcie_match[].
> 
> Bjorn
> 
Hi Bjorn,

I agree on your point, but the main reason is to use compatible in 
get_resources_2_7_0 is same hardware version. For SM8250 & SC7280 
platforms, the hw version is same. Since we can't have a separate ops 
for SC7280, we are using compatible method in get_resources_2_7_0 to 
differentiate SM8250 and SC7280.

Thanks
-Prasad
> [1]
> https://lore.kernel.org/linux-arm-msm/1628568516-24155-2-git-send-email-pmaliset@codeaurora.org/
