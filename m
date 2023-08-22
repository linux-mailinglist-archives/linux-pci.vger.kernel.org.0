Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA22783B57
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjHVIA5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 04:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjHVIAT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 04:00:19 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15B0CCD
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 01:00:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bd77864e05so3031773a34.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692691216; x=1693296016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n3VViHsFxlPFAPr63U9JvG58yR6RMSw03dS38fpjRKw=;
        b=kEUJ8tova0sWmKZ6bvTwW4OP0MQLl6BVY41Mwc/ZIfjm5xVSwRiOfdAcyLqbjplugR
         5xLYBjx8IsCe/1BUhE5UC7nF5HZKWIlf/pUP3LmhuCR7RLeCT0H3/KTtC/7gCq2X0BQu
         dVklsfn4q2RpUilASToM75Nac+P1QJdkdp9PBPLsf33LgzHG8GgU8UZt/6gL/TSAS59w
         NpME9h9mDX75vDnd/+QfhltDu8iHKCoj0ycy4vWAXkxeq+emVyYgg6tgkUMA5eb4bAWZ
         XOO4SSwAk8HSBfd3jMwt7l305OIyMKWSLFAL92BFmPx8aVr5vc1x28rb2TgXLDe/5Chw
         nNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692691216; x=1693296016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3VViHsFxlPFAPr63U9JvG58yR6RMSw03dS38fpjRKw=;
        b=fbau4Ek1nrDd2Bda2oaOyHYT0jBeUvaWpbDwhYtDyrnqJqh1KiT3rgBMVQ0CMk0k/0
         SKLvaZtCOqhSsFXc8Z5mEOFyMFcK/QZ4kX6+iXDbGACDmaBx5tCxpdvw3ezC9OgT6+xN
         wicbfZtmIh8CK2HAULw8jgVFL6mp7hsNRZQ1Lf6LCs3FNmVOsO2mdeQ9TeNHpMV7qVH+
         fklYPYiUmaJng9GgkR4etfKNzyfdRCbUBleCqFiTzwq3+Y1Dgz3NFVPuL2yleD5wuGb1
         v48vPYBuDaVQD2TpWGEZpZsvlkQjqq6/mntuN7EwFfBxYlmEiyLJpl9MGnOKFhVvIr9T
         JNzA==
X-Gm-Message-State: AOJu0YxC4WBPJ/HnwBMQtBs4QyADY4atsXDaz8Ze4zot9mjFzc6/92Gd
        JQagiEPkKFRkGSqmu+Cif/qiXg==
X-Google-Smtp-Source: AGHT+IGmh/rVLTK3rvnSpFjCcFQAC30iokXX35BjBJboi7/mvGuN/LFYZsml4vDwAgsZssXQp0hW+w==
X-Received: by 2002:a05:6830:1009:b0:6b9:2869:bd81 with SMTP id a9-20020a056830100900b006b92869bd81mr10738128otp.18.1692691216025;
        Tue, 22 Aug 2023 01:00:16 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id p8-20020a63ab08000000b005642a68a508sm7536867pgf.35.2023.08.22.01.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 01:00:15 -0700 (PDT)
Date:   Tue, 22 Aug 2023 13:30:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        krzysztof.kozlowski@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: qcom: Add OPP support for speed based
 performance state of RPMH
Message-ID: <20230822080013.4bedtd5bkjjltfqo@vireshk-i7>
References: <1692627343-4380-1-git-send-email-quic_krichai@quicinc.com>
 <1692627343-4380-4-git-send-email-quic_krichai@quicinc.com>
 <95078a8b-857d-4900-8737-a495212db935@quicinc.com>
 <162b135d-7e27-bf3b-df8f-45e2a5e73897@quicinc.com>
 <a0465222-6e03-4fef-a662-4a2c22240d91@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0465222-6e03-4fef-a662-4a2c22240d91@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-08-23, 10:23, Pavan Kondeti wrote:
> +linux-pm and OPP maintainers
> 
> On Tue, Aug 22, 2023 at 09:57:41AM +0530, Krishna Chaitanya Chundru wrote:
> > 
> > On 8/22/2023 9:33 AM, Pavan Kondeti wrote:
> > > On Mon, Aug 21, 2023 at 07:45:43PM +0530, Krishna chaitanya chundru wrote:
> > > > Before link training vote for the maximum performance state of RPMH
> > > > and once link is up, vote for the performance state based upon the link
> > > > speed.
> > > > 
> > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 47 ++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 47 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 7a87a47..c57ca1a 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -22,6 +22,7 @@
> > > >   #include <linux/of_device.h>
> > > >   #include <linux/of_gpio.h>
> > > >   #include <linux/pci.h>
> > > > +#include <linux/pm_opp.h>
> > > >   #include <linux/pm_runtime.h>
> > > >   #include <linux/platform_device.h>
> > > >   #include <linux/phy/pcie.h>
> > > > @@ -1357,6 +1358,32 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> > > >   	return 0;
> > > >   }
> > > > +static void qcom_pcie_opp_update(struct qcom_pcie *pcie)
> > > > +{
> > > > +	struct dw_pcie *pci = pcie->pci;
> > > > +	struct dev_pm_opp *opp;
> > > > +	u32 offset, status;
> > > > +	int speed, ret = 0;
> > > > +
> > > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> > > > +
> > > > +	/* Only update constraints if link is up. */
> > > > +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > > > +		return;
> > > > +
> > > What happens if link is not up during probe? We set max vote before
> > > this, should not we bring it down in suspend and vote it back again in
> > > resume?
> > 
> > ok, I will set to lower value in the suspend path if the link is not up.  If
> > the link is already up driver will not
> > 
> > do any modifications.
> > 
> > > 
> > > > +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> > > > +
> > > > +	opp = dev_pm_opp_find_level_exact(pci->dev, speed);
> > > > +	if (!IS_ERR(opp)) {
> > > > +		ret = dev_pm_opp_set_opp(pci->dev, opp);
> > > > +		if (ret)
> > > > +			dev_err(pci->dev, "Failed to set opp: %d\n", ret);
> > > > +		dev_pm_opp_put(opp);
> > > > +	}
> > > Since you added an error message, make it more useful by printing the
> > > opp level also. dev_pm_opp_get_level().
> > Sure I will add this in next patch.
> > > 
> > > > +
> > > > +}
> > > > +
> > > >   static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> > > >   {
> > > >   	struct dw_pcie *pci = pcie->pci;
> > > > @@ -1439,8 +1466,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> > > >   static int qcom_pcie_probe(struct platform_device *pdev)
> > > >   {
> > > >   	const struct qcom_pcie_cfg *pcie_cfg;
> > > > +	unsigned long max_freq = INT_MAX;
> > > >   	struct device *dev = &pdev->dev;
> > > >   	struct qcom_pcie *pcie;
> > > > +	struct dev_pm_opp *opp;
> > > >   	struct dw_pcie_rp *pp;
> > > >   	struct resource *res;
> > > >   	struct dw_pcie *pci;
> > > > @@ -1511,6 +1540,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > >   	if (ret)
> > > >   		goto err_pm_runtime_put;
> > > > +	/* OPP table is optional */
> > > > +	ret = devm_pm_opp_of_add_table(dev);
> > > > +	if (ret && ret != -ENODEV) {
> > > > +		dev_err(dev, "Invalid OPP table in Device tree\n");
> > > > +		goto err_pm_runtime_put;
> > > > +	}
> > > > +
> > > > +	/* vote for max level in the opp table */
> > > > +	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> > > > +	if (!IS_ERR(opp)) {
> > > > +		ret = dev_pm_opp_set_opp(dev, opp);
> > > > +		if (ret)
> > > > +			dev_err(pci->dev, "Failed to set opp: %d\n", ret);
> > > > +		dev_pm_opp_put(opp);
> > > > +	}
> > > > +
> > > This needs an update since you moved from frequency based voting to link
> > > speed based voting.
> > 
> > dev_pm_opp_find_freq_floor will give us the max the opp level opp we don't
> > have a similar API to get max opp-level
> > 
> > For that reason we are using this API.
> > 
> 
> Ok, thanks. I get that it is working. Would you be not knowing the exact
> level for the max speed supported? if that is unknown, I believe we have
> a use case for dev_pm_opp_find_level_floor() API. Adding the best people
> on this matter for thei valuable opinion/suggestions.

If required feel free to add dev_pm_opp_find_level_floor(), based on
dev_pm_opp_find_level_ceil().

-- 
viresh
