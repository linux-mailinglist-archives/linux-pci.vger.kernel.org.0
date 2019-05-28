Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0E2D093
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 22:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfE1UmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 16:42:18 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:43768 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfE1UmS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 May 2019 16:42:18 -0400
Received: from [192.168.1.6] (hst-221-77.medicom.bg [84.238.221.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 7CF61CE7C;
        Tue, 28 May 2019 23:42:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1559076135; bh=sGsg/qLXUK4RWVjSX2z2nrH/IEOd2T0BBE97JwegLYk=;
        h=Subject:To:Cc:From:Date:From;
        b=M2ft+CH5DGzAV8OAppNWlqZK0d/9EMwBrlIc8Ys0f2nuc/F9nvROwzpNs9H+biPAA
         mOSHDXZsHc44EZH0QZpNmdmZgy/whmxYV+jBLKlz7k+XIRj7CVGUUzIzVi+Ca/H0WB
         yo+v1xY1BvaWtxzXfPe3dw7BQPemjq4y/isKgSWFdqmjkhNaAi0idh2cQ8KSffNKBe
         sKKK+NnfmYtmMlm4sKX17jtJ1C6+EM0ddHWrNPvW9SG3rsghw9f9N+3Mo0RT3Ke6Eq
         f0ZMwMjycwLLT9nnw0WjkrOy/n6kZhxbi+Knr6m1CbDbfPfsf4D2k9Y6AIOYsmOoyx
         ezC+2Gar88H/A==
Subject: Re: [PATCH v3 1/3] PCI: qcom: Use clk_bulk API for 2.4.0 controllers
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190502001955.10575-1-bjorn.andersson@linaro.org>
 <20190502001955.10575-2-bjorn.andersson@linaro.org>
 <fcfcd3b4-99d2-7b10-e82d-b92e6bf37a33@mm-sol.com>
 <20190528151330.GA28649@redmoon>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <89e9be83-a91c-510c-87cf-b5db9c6e1b23@mm-sol.com>
Date:   Tue, 28 May 2019 23:42:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528151330.GA28649@redmoon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 28.05.19 г. 18:13 ч., Lorenzo Pieralisi wrote:
> On Thu, May 16, 2019 at 12:14:04PM +0300, Stanimir Varbanov wrote:
>> Hi Bjorn,
>>
>> On 5/2/19 3:19 AM, Bjorn Andersson wrote:
>>> Before introducing the QCS404 platform, which uses the same PCIe
>>> controller as IPQ4019, migrate this to use the bulk clock API, in order
>>> to make the error paths slighly cleaner.
>>>
>>> Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
>>> Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> ---
>>>
>>> Changes since v2:
>>> - Defined QCOM_PCIE_2_4_0_MAX_CLOCKS
>>>
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++------------------
>>>   1 file changed, 14 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 0ed235d560e3..d740cbe0e56d 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -112,10 +112,10 @@ struct qcom_pcie_resources_2_3_2 {
>>>   	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
>>>   };
>>>   
>>> +#define QCOM_PCIE_2_4_0_MAX_CLOCKS	3
>>>   struct qcom_pcie_resources_2_4_0 {
>>> -	struct clk *aux_clk;
>>> -	struct clk *master_clk;
>>> -	struct clk *slave_clk;
>>> +	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
>>> +	int num_clks;
>>>   	struct reset_control *axi_m_reset;
>>>   	struct reset_control *axi_s_reset;
>>>   	struct reset_control *pipe_reset;
>>> @@ -638,18 +638,17 @@ static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
>>>   	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
>>>   	struct dw_pcie *pci = pcie->pci;
>>>   	struct device *dev = pci->dev;
>>> +	int ret;
>>>   
>>> -	res->aux_clk = devm_clk_get(dev, "aux");
>>> -	if (IS_ERR(res->aux_clk))
>>> -		return PTR_ERR(res->aux_clk);
>>> +	res->clks[0].id = "aux";
>>> +	res->clks[1].id = "master_bus";
>>> +	res->clks[2].id = "slave_bus";
>>>   
>>> -	res->master_clk = devm_clk_get(dev, "master_bus");
>>> -	if (IS_ERR(res->master_clk))
>>> -		return PTR_ERR(res->master_clk);
>>> +	res->num_clks = 3;
>>
>> Use the new fresh define QCOM_PCIE_2_4_0_MAX_CLOCKS?
>>
>>>   
>>> -	res->slave_clk = devm_clk_get(dev, "slave_bus");
>>> -	if (IS_ERR(res->slave_clk))
>>> -		return PTR_ERR(res->slave_clk);
>>> +	ret = devm_clk_bulk_get(dev, res->num_clks, res->clks);
>>> +	if (ret < 0)
>>> +		return ret;
>>>   
>>>   	res->axi_m_reset = devm_reset_control_get_exclusive(dev, "axi_m");
>>>   	if (IS_ERR(res->axi_m_reset))
>>> @@ -719,9 +718,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
>>>   	reset_control_assert(res->axi_m_sticky_reset);
>>>   	reset_control_assert(res->pwr_reset);
>>>   	reset_control_assert(res->ahb_reset);
>>> -	clk_disable_unprepare(res->aux_clk);
>>> -	clk_disable_unprepare(res->master_clk);
>>> -	clk_disable_unprepare(res->slave_clk);
>>> +	clk_bulk_disable_unprepare(res->num_clks, res->clks);
>>>   }
>>>   
>>>   static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>>> @@ -850,23 +847,9 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>>>   
>>>   	usleep_range(10000, 12000);
>>>   
>>> -	ret = clk_prepare_enable(res->aux_clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "cannot prepare/enable iface clock\n");
>>> +	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
>>> +	if (ret)
>>>   		goto err_clk_aux;
>>
>> Maybe you have to change the name of the label too?
>>
>>> -	}
>>> -
>>> -	ret = clk_prepare_enable(res->master_clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "cannot prepare/enable core clock\n");
>>> -		goto err_clk_axi_m;
>>> -	}
>>> -
>>> -	ret = clk_prepare_enable(res->slave_clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "cannot prepare/enable phy clock\n");
>>> -		goto err_clk_axi_s;
>>> -	}
>>>   
>>>   	/* enable PCIe clocks and resets */
>>>   	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
>>> @@ -891,10 +874,6 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
>>>   
>>>   	return 0;
>>>   
>>> -err_clk_axi_s:
>>> -	clk_disable_unprepare(res->master_clk);
>>> -err_clk_axi_m:
>>> -	clk_disable_unprepare(res->aux_clk);
>>>   err_clk_aux:
>>>   	reset_control_assert(res->ahb_reset);
>>>   err_rst_ahb:
> 
> Hi Bjorn, Stanimir,
> 
> can I merge the series as-is or we need a v4 for the requested
> updates ? Please let me know.

I'm fine with either way:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

regards,
Stan
