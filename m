Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C34405C5B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbhIIRw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 13:52:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:33497 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241252AbhIIRw4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Sep 2021 13:52:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631209906; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=e6AFBjVQo6kyrlar3z1aBbA4tOY9oubcLSMrHzrshzs=;
 b=IDLpZ+HnhqYMfGgdUfmv0qJSWgyAn53Wad7J15WX0EbSW+c9A//LtbKPrvdo/ujMfO4Y0HGg
 5wl03rHkaobKAItSsR+2giFvBM23qi3xAmukB9dK9C9w89u/Yo16pZyvBACHBbuY3fMzdWFC
 af1S5xeVoo9VqpHhZIKAARp8pjs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 613a499c37cdab60401b8e65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Sep 2021 17:51:24
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9238C43616; Thu,  9 Sep 2021 17:51:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 789C9C4338F;
        Thu,  9 Sep 2021 17:51:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Sep 2021 23:21:22 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
In-Reply-To: <20210831153714.GA103513@bjorn-Precision-5520>
References: <20210831153714.GA103513@bjorn-Precision-5520>
Message-ID: <5fae4f586edfde4f615a8ea6a309fbff@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-08-31 21:07, Bjorn Helgaas wrote:
> On Tue, Aug 31, 2021 at 12:07:30PM +0530, Prasad Malisetty wrote:
>> On 2021-08-26 18:07, Rob Herring wrote:
>> > On Thu, Aug 26, 2021 at 2:22 AM Prasad Malisetty
>> > <pmaliset@codeaurora.org> wrote:
>> > >
>> > > On 2021-08-26 02:55, Bjorn Helgaas wrote:
>> > > > [+cc linux-pci; patches to drivers/pci/ should always be cc'd there]
>> > > >
>> > > > On Wed, Aug 25, 2021 at 07:30:09PM +0000, Stephen Boyd wrote:
>> > > >> Quoting Prasad Malisetty (2021-08-24 01:10:48)
>> > > >> > On 2021-08-17 22:56, Prasad Malisetty wrote:
>> > > >> > > On 2021-08-10 09:38, Prasad Malisetty wrote:
>> > > >> > >> On the SC7280, By default the clock source for pcie_1_pipe is
>> > > >> > >> TCXO for gdsc enable. But after the PHY is initialized, the clock
>> > > >> > >> source must be switched to gcc_pcie_1_pipe_clk from TCXO.
>> > > >> > >>
>> > > >> > >> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
>> > > >> > >> ---
>> > > >> > >>  drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++++++++++++
>> > > >> > >>  1 file changed, 18 insertions(+)
>> > > >> > >>
>> > > >> > >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
>> > > >> > >> b/drivers/pci/controller/dwc/pcie-qcom.c
>> > > >> > >> index 8a7a300..39e3b21 100644
>> > > >> > >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> > > >> > >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> > > >> > >> @@ -166,6 +166,8 @@ struct qcom_pcie_resources_2_7_0 {
>> > > >> > >>      struct regulator_bulk_data supplies[2];
>> > > >> > >>      struct reset_control *pci_reset;
>> > > >> > >>      struct clk *pipe_clk;
>> > > >> > >> +    struct clk *gcc_pcie_1_pipe_clk_src;
>> > > >> > >> +    struct clk *phy_pipe_clk;
>> > > >> > >>  };
>> > > >> > >>
>> > > >> > >>  union qcom_pcie_resources {
>> > > >> > >> @@ -1167,6 +1169,16 @@ static int qcom_pcie_get_resources_2_7_0(struct
>> > > >> > >> qcom_pcie *pcie)
>> > > >> > >>      if (ret < 0)
>> > > >> > >>              return ret;
>> > > >> > >>
>> > > >> > >> +    if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280")) {
>> > > >> > >> +            res->gcc_pcie_1_pipe_clk_src = devm_clk_get(dev, "pipe_mux");
>> > > >> > >> +            if (IS_ERR(res->gcc_pcie_1_pipe_clk_src))
>> > > >> > >> +                    return PTR_ERR(res->gcc_pcie_1_pipe_clk_src);
>> > > >> > >> +
>> > > >> > >> +            res->phy_pipe_clk = devm_clk_get(dev, "phy_pipe");
>> > > >> > >> +            if (IS_ERR(res->phy_pipe_clk))
>> > > >> > >> +                    return PTR_ERR(res->phy_pipe_clk);
>> > > >> > >> +    }
>> > > >> > >
>> > > >> > > I would like to check is there any other better approach instead of
>> > > >> > > compatible method here as well or is it fine to use compatible method.
>> > > >>
>> > > >> I'd prefer the compatible method. If nobody is responding then it's
>> > > >> best
>> > > >> to just resend the patches with the approach you prefer instead of
>> > > >> waiting for someone to respond to a review comment.
>> > > >
>> > > > I'm missing some context here, so I'm not exactly sure what your
>> > > > question is, Prasad, but IMO drivers generally should not need to use
>> > > > of_device_is_compatible() if they've already called
>> > > > of_device_get_match_data() (as qcom_pcie_probe() has).
>> > > >
>> > > > of_device_is_compatible() does basically the same work of looking for
>> > > > a match in qcom_pcie_match[] that of_device_get_match_data() does, so
>> > > > it seems pointless to repeat it.
>> >
>> > +1
>> >
>> > > > I am a little confused because while [1] adds "qcom,pcie-sc7280" to
>> > > > qcom,pcie.txt, I don't see a patch that adds it to qcom_pcie_match[].
>> >
>> > Either that's missing or there's a fallback to 8250 that's not
>> > documented.
>> >
>> > > I agree on your point, but the main reason is to use compatible in
>> > > get_resources_2_7_0 is same hardware version. For SM8250 & SC7280
>> > > platforms, the hw version is same. Since we can't have a separate ops
>> > > for SC7280, we are using compatible method in get_resources_2_7_0 to
>> > > differentiate SM8250 and SC7280.
>> >
>> > Then fix the match data to be not just ops, but ops and the flag you
>> > need here.
>> 
>> This difference is not universal across all the platforms but instead 
>> this
>> is specific to SC7280.
>> Hence it make sense to use compatible other than going for a flag.
> 
> There's no reason your qcom_pcie_match[].data pointers need to be
> strictly based on the hardware version.
> 
> You can do something like what pcie-brcmstb.c does, e.g.,
> 
>   struct pcie_cfg_data {
>     struct qcom_pcie_ops *ops;
>     unsigned int pipe_mux:1;
>   };
> 
>   static const struct pcie_cfg_data sm8250_cfg = {
>     .ops = &ops_1_9_0,
>   };
> 
>   static const struct pcie_cfg_data sc7280_cfg = {
>     .ops = &ops_1_9_0,
>     .pipe_mux = 1,
>   };
> 
>   static const struct of_device_id qcom_pcie_match[] = {
>     { .compatible = "qcom,pcie-sm8250", .data = &sm8250_cfg },
>     { .compatible = "qcom,pcie-sc7280", .data = &sc7280_cfg },
>   };

Hi Bjorn,

Thanks for the detailed example.

I have one quick query, If we use above approach, we should change 
platform data reading in PCIe probe to differentiate remaining platforms 
right.
expect SM8250 and SC7280 all other platforms are using same 
qcom_pcie_ops structure pointer as data.

Kindly correct me if my understanding is wrong.

Just posted v6 patch series with same compatible approach as of now. I 
will go through your example and update further.

Thanks
-Prasad
