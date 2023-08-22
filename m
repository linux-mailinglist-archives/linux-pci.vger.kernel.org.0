Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415007838F1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 06:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjHVEyc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 00:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjHVEyc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 00:54:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8111B11C;
        Mon, 21 Aug 2023 21:54:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M4nRcQ024823;
        Tue, 22 Aug 2023 04:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=SAs9CDXh/Luh+5xE/9okTidiVvDMJtvJVDgPqA5oHuQ=;
 b=YcIBcccW86J5fKzOREGtMemu+Tjsf5CWTzYMBC3KoPYVch+0FRYFn9AjdXs7souHMv2b
 QPqhXEtiee0ZG7NRdly+9Tq5Vn2lbm6wIJ4Gc5Dx8knVsgeCpzx4vfTH68UlBzUQHu9I
 321JrsW/00/xReybIBy4946HLgvcDaczUefMcJwHKWm3YQtpGhaX2qGud3Y6ucRsD7wF
 afPCv3lrsJr92jd3dS8dt/dmCjnMpJFCfaGDKWe5jPeDppeJyDrtP4xua8lLtqomQAM5
 ZEBp/eBgA4TkgiNrhK0TKeHC+xKbFTX1iwumjMbtYXF/ktD+/1ZVftIHvkqH66KzE2MI 3A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smf3q8qeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 04:54:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37M4rwqo032361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 04:53:59 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 21 Aug 2023 21:53:51 -0700
Date:   Tue, 22 Aug 2023 10:23:48 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] PCI: qcom: Add OPP support for speed based
 performance state of RPMH
Message-ID: <a0465222-6e03-4fef-a662-4a2c22240d91@quicinc.com>
References: <1692627343-4380-1-git-send-email-quic_krichai@quicinc.com>
 <1692627343-4380-4-git-send-email-quic_krichai@quicinc.com>
 <95078a8b-857d-4900-8737-a495212db935@quicinc.com>
 <162b135d-7e27-bf3b-df8f-45e2a5e73897@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <162b135d-7e27-bf3b-df8f-45e2a5e73897@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C3fxsfgQuSMU2ac_LgQk342vUF_KY1EZ
X-Proofpoint-ORIG-GUID: C3fxsfgQuSMU2ac_LgQk342vUF_KY1EZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_02,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308220039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+linux-pm and OPP maintainers

On Tue, Aug 22, 2023 at 09:57:41AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 8/22/2023 9:33 AM, Pavan Kondeti wrote:
> > On Mon, Aug 21, 2023 at 07:45:43PM +0530, Krishna chaitanya chundru wrote:
> > > Before link training vote for the maximum performance state of RPMH
> > > and once link is up, vote for the performance state based upon the link
> > > speed.
> > > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 47 ++++++++++++++++++++++++++++++++++
> > >   1 file changed, 47 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 7a87a47..c57ca1a 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -22,6 +22,7 @@
> > >   #include <linux/of_device.h>
> > >   #include <linux/of_gpio.h>
> > >   #include <linux/pci.h>
> > > +#include <linux/pm_opp.h>
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/phy/pcie.h>
> > > @@ -1357,6 +1358,32 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> > >   	return 0;
> > >   }
> > > +static void qcom_pcie_opp_update(struct qcom_pcie *pcie)
> > > +{
> > > +	struct dw_pcie *pci = pcie->pci;
> > > +	struct dev_pm_opp *opp;
> > > +	u32 offset, status;
> > > +	int speed, ret = 0;
> > > +
> > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> > > +
> > > +	/* Only update constraints if link is up. */
> > > +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> > > +		return;
> > > +
> > What happens if link is not up during probe? We set max vote before
> > this, should not we bring it down in suspend and vote it back again in
> > resume?
> 
> ok, I will set to lower value in the suspend path if the link is not up.  If
> the link is already up driver will not
> 
> do any modifications.
> 
> > 
> > > +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> > > +
> > > +	opp = dev_pm_opp_find_level_exact(pci->dev, speed);
> > > +	if (!IS_ERR(opp)) {
> > > +		ret = dev_pm_opp_set_opp(pci->dev, opp);
> > > +		if (ret)
> > > +			dev_err(pci->dev, "Failed to set opp: %d\n", ret);
> > > +		dev_pm_opp_put(opp);
> > > +	}
> > Since you added an error message, make it more useful by printing the
> > opp level also. dev_pm_opp_get_level().
> Sure I will add this in next patch.
> > 
> > > +
> > > +}
> > > +
> > >   static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> > >   {
> > >   	struct dw_pcie *pci = pcie->pci;
> > > @@ -1439,8 +1466,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> > >   static int qcom_pcie_probe(struct platform_device *pdev)
> > >   {
> > >   	const struct qcom_pcie_cfg *pcie_cfg;
> > > +	unsigned long max_freq = INT_MAX;
> > >   	struct device *dev = &pdev->dev;
> > >   	struct qcom_pcie *pcie;
> > > +	struct dev_pm_opp *opp;
> > >   	struct dw_pcie_rp *pp;
> > >   	struct resource *res;
> > >   	struct dw_pcie *pci;
> > > @@ -1511,6 +1540,22 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >   	if (ret)
> > >   		goto err_pm_runtime_put;
> > > +	/* OPP table is optional */
> > > +	ret = devm_pm_opp_of_add_table(dev);
> > > +	if (ret && ret != -ENODEV) {
> > > +		dev_err(dev, "Invalid OPP table in Device tree\n");
> > > +		goto err_pm_runtime_put;
> > > +	}
> > > +
> > > +	/* vote for max level in the opp table */
> > > +	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> > > +	if (!IS_ERR(opp)) {
> > > +		ret = dev_pm_opp_set_opp(dev, opp);
> > > +		if (ret)
> > > +			dev_err(pci->dev, "Failed to set opp: %d\n", ret);
> > > +		dev_pm_opp_put(opp);
> > > +	}
> > > +
> > This needs an update since you moved from frequency based voting to link
> > speed based voting.
> 
> dev_pm_opp_find_freq_floor will give us the max the opp level opp we don't
> have a similar API to get max opp-level
> 
> For that reason we are using this API.
> 

Ok, thanks. I get that it is working. Would you be not knowing the exact
level for the max speed supported? if that is unknown, I believe we have
a use case for dev_pm_opp_find_level_floor() API. Adding the best people
on this matter for thei valuable opinion/suggestions.

Thanks,
Pavan

