Return-Path: <linux-pci+bounces-14806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7629A274B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5E1C2680E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5131DED4F;
	Thu, 17 Oct 2024 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j6jwaOYl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE871DACB8;
	Thu, 17 Oct 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180115; cv=none; b=mBi2o91nd+XZJVZXgXFRTz3RBJZdYM2qgYv0PtqNa56PADpOGa4+I3DNjS0VbXgF9GICBHBB8l6yIAW9Tc96IQoZic/n/Fe22fv1/AHy7qhDr0g4ZcdNA+NeyKORLzrRQWAWVhJYJyYSFGkvOeMmSJgMT4w+lrEh5NklodWuNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180115; c=relaxed/simple;
	bh=hWyInFLtEDu2F4Vvf72QE46yB5bngaRqM+QkXyFm7+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nuhNALX20SgHZzc0l171b9wpQqYCHXfWI6ylq7gBFwaXNDsVE3MucbMVTRPf+axOYDMB2tPiefJljawwMiTc121v+kmkxjw9e+ZFKX60WHoOeGklZCkMRkirErCu8EBkfwqh3WOicORFA+eI8UzqHsN+n0Op1Y4QjrwBFw1l/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j6jwaOYl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9magq017430;
	Thu, 17 Oct 2024 15:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I8ST3qrbp8sGbBOpy3rQ2FtgKqHIk9C2F0my2mI+LjY=; b=j6jwaOYlfQu5K9RJ
	tLe62bj8DucFWdjb9gI69ciGGQGdtySjmnIndzXsu+MRBu2LvTUtyuUoPMDXu/rf
	2dPcBvu0UvPOAwCYwMQ0CRUuCUBkaoabKKDjoO3w/U+osSG/fj2jJnMRaS+ccp5X
	Eth7GaKfS3QpzDyuyioznW7yx5wbnPetbRfPMruPKsNch3MZLR9stR10WCTpRW9+
	S3drsATrBL6Jh+r2FXMtvku65df2jDvwsdTHN7Ln9rqNqraLusWtXUVZwGNWw4/1
	gw8SPontB+UmLyFCk2bsFQQJSARRSDqCTtjZrKpaBe5wP/k0Hjrl8f9iOLkCxy/2
	c9Kefw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42a8nq56hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 15:48:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HFm7in029619
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 15:48:07 GMT
Received: from [10.216.4.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 08:48:00 -0700
Message-ID: <9b2831a4-b2c5-2282-a7bc-497a7a215ffa@quicinc.com>
Date: Thu, 17 Oct 2024 21:17:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 8/8] PCI: pwrctl: Add power control driver for qps615
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-8-9560b7c71369@quicinc.com>
 <spaudnuoam3cj7glxmnlw7y3m46d2vsm42s576jqwrcrmywl2n@oyrynorzhddg>
 <872e1c39-4547-7cd3-ba49-bbbe59e52087@quicinc.com>
 <32488500-05B7-4D25-9AAF-06A249CC6B1D@linaro.org>
 <d0c8b466-5df2-853c-608d-ab67af1a9f32@quicinc.com>
 <CAA8EJpo7J9ZXC9uERg=WkjMbDD-fDTOO2VXaRVOCVZXiN18oSw@mail.gmail.com>
 <4d67915a-d57d-0a33-cdef-3bdf05961d16@quicinc.com>
 <CAA8EJppa2Z-h0vH2Cmeem_1Cw8C+53q7pXkJ03mut4Bsn+Vm7A@mail.gmail.com>
 <4c111681-03b8-9b4c-6b5b-ebfa4c5a7377@quicinc.com>
 <w547dmmxqqa4atd62jqiqcfzhlnpjc7n64btjmre5pmbsci4br@w45tuny3mcmn>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <w547dmmxqqa4atd62jqiqcfzhlnpjc7n64btjmre5pmbsci4br@w45tuny3mcmn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wqL5lq2rXRyHB-0SkksntH-V8Ty29oOM
X-Proofpoint-GUID: wqL5lq2rXRyHB-0SkksntH-V8Ty29oOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170109



On 9/3/2024 12:07 AM, Dmitry Baryshkov wrote:
> On Mon, Sep 02, 2024 at 04:17:06PM GMT, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 9/2/2024 3:42 PM, Dmitry Baryshkov wrote:
>>> On Mon, 2 Sept 2024 at 11:32, Krishna Chaitanya Chundru
>>> <quic_krichai@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/2/2024 12:50 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, 2 Sept 2024 at 10:13, Krishna Chaitanya Chundru
>>>>> <quic_krichai@quicinc.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/8/2024 9:00 AM, Dmitry Baryshkov wrote:
>>>>>>> On August 5, 2024 1:14:47 PM GMT+07:00, Krishna Chaitanya Chundru <quic_krichai@quicinc.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/3/2024 5:04 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Sat, Aug 03, 2024 at 08:52:54AM GMT, Krishna chaitanya chundru wrote:
>>>>>>>>>> QPS615 switch needs to be configured after powering on and before
>>>>>>>>>> PCIe link was up.
>>>>>>>>>>
>>>>>>>>>> As the PCIe controller driver already enables the PCIe link training
>>>>>>>>>> at the host side, stop the link training. Otherwise the moment we turn
>>>>>>>>>> on the switch it will participate in the link training and link may come
>>>>>>>>>> up before switch is configured through i2c.
>>>>>>>>>>
>>>>>>>>>> The device tree properties are parsed per node under pci-pci bridge in the
>>>>>>>>>> driver. Each node has unique bdf value in the reg property, driver
>>>>>>>>>> uses this bdf to differentiate ports, as there are certain i2c writes to
>>>>>>>>>> select particular port.
>>>>>>>>>>
>>>>>>>>>> Based up on dt property and port, qps615 is configured through i2c.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/pci/pwrctl/Kconfig             |   7 +
>>>>>>>>>>       drivers/pci/pwrctl/Makefile            |   1 +
>>>>>>>>>>       drivers/pci/pwrctl/pci-pwrctl-qps615.c | 638 +++++++++++++++++++++++++++++++++
>>>>>>>>>>       3 files changed, 646 insertions(+)
>>>>>>>>>>
> 
>>>>>>>>>> +
>>>>>>>>>> +  return qps615_pwrctl_i2c_write(ctx->client,
>>>>>>>>>> +                                 is_l1 ? QPS615_PORT_L1_DELAY : QPS615_PORT_L0S_DELAY, units);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int qps615_pwrctl_set_tx_amplitude(struct qps615_pwrctl_ctx *ctx,
>>>>>>>>>> +                                    enum qps615_pwrctl_ports port, u32 amp)
>>>>>>>>>> +{
>>>>>>>>>> +  int port_access;
>>>>>>>>>> +
>>>>>>>>>> +  switch (port) {
>>>>>>>>>> +  case QPS615_USP:
>>>>>>>>>> +          port_access = 0x1;
>>>>>>>>>> +          break;
>>>>>>>>>> +  case QPS615_DSP1:
>>>>>>>>>> +          port_access = 0x2;
>>>>>>>>>> +          break;
>>>>>>>>>> +  case QPS615_DSP2:
>>>>>>>>>> +          port_access = 0x8;
>>>>>>>>>> +          break;
>>>>>>>>>> +  default:
>>>>>>>>>> +          return -EINVAL;
>>>>>>>>>> +  };
>>>>>>>>>> +
>>>>>>>>>> +  struct qps615_pwrctl_reg_setting tx_amp_seq[] = {
>>>>>>>>>> +          {QPS615_PORT_ACCESS_ENABLE, port_access},
>>>>>>>>>
>>>>>>>>> Hmm, this looks like another port selection, so most likely it should
>>>>>>>>> also be under the same lock.
>>>>>>>>>
>>>>>>>>>> +          {QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
>>>>>>>>>> +          {QPS615_TX_MARGIN, amp},
>>>>>>>>>> +  };
>>>>>>>>>> +
>>>>>>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_SIZE(tx_amp_seq));
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int qps615_pwrctl_disable_dfe(struct qps615_pwrctl_ctx *ctx,
>>>>>>>>>> +                               enum qps615_pwrctl_ports port)
>>>>>>>>>> +{
>>>>>>>>>> +  int port_access, lane_access = 0x3;
>>>>>>>>>> +  u32 phy_rate = 0x21;
>>>>>>>>>> +
>>>>>>>>>> +  switch (port) {
>>>>>>>>>> +  case QPS615_USP:
>>>>>>>>>> +          phy_rate = 0x1;
>>>>>>>>>> +          port_access = 0x1;
>>>>>>>>>> +          break;
>>>>>>>>>> +  case QPS615_DSP1:
>>>>>>>>>> +          port_access = 0x2;
>>>>>>>>>> +          break;
>>>>>>>>>> +  case QPS615_DSP2:
>>>>>>>>>> +          port_access = 0x8;
>>>>>>>>>> +          lane_access = 0x1;
>>>>>>>>>> +          break;
>>>>>>>>>> +  default:
>>>>>>>>>> +          return -EINVAL;
>>>>>>>>>> +  };
>>>>>>>>>> +
>>>>>>>>>> +  struct qps615_pwrctl_reg_setting disable_dfe_seq[] = {
>>>>>>>>>> +          {QPS615_PORT_ACCESS_ENABLE, port_access},
>>>>>>>>>> +          {QPS615_PORT_LANE_ACCESS_ENABLE, lane_access},
>>>>>>>>>> +          {QPS615_DFE_ENABLE, 0x0},
>>>>>>>>>> +          {QPS615_DFE_EQ0_MODE, 0x411},
>>>>>>>>>> +          {QPS615_DFE_EQ1_MODE, 0x11},
>>>>>>>>>> +          {QPS615_DFE_EQ2_MODE, 0x11},
>>>>>>>>>> +          {QPS615_DFE_PD_MASK, 0x7},
>>>>>>>>>> +          {QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x10},
>>>>>>>>>> +          {QPS615_PHY_RATE_CHANGE, phy_rate},
>>>>>>>>>> +          {QPS615_PHY_RATE_CHANGE, 0x0},
>>>>>>>>>> +          {QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x0},
>>>>>>>>>> +
>>>>>>>>>> +  };
>>>>>>>>>> +
>>>>>>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client,
>>>>>>>>>> +                                      disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int qps615_pwrctl_set_nfts(struct qps615_pwrctl_ctx *ctx,
>>>>>>>>>> +                            enum qps615_pwrctl_ports port, u32 nfts)
>>>>>>>>>> +{
>>>>>>>>>> +  int ret;
>>>>>>>>>> +  struct qps615_pwrctl_reg_setting nfts_seq[] = {
>>>>>>>>>> +          {QPS615_NFTS_2_5_GT, nfts},
>>>>>>>>>> +          {QPS615_NFTS_5_GT, nfts},
>>>>>>>>>> +  };
>>>>>>>>>> +
>>>>>>>>>> +  ret =  qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT(port));
>>>>>>>>>> +  if (ret)
>>>>>>>>>> +          return ret;
>>>>>>>>>> +
>>>>>>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int qps615_pwrctl_assert_deassert_reset(struct qps615_pwrctl_ctx *ctx, bool deassert)
>>>>>>>>>> +{
>>>>>>>>>> +  int ret, val = 0;
>>>>>>>>>> +
>>>>>>>>>> +  if (deassert)
>>>>>>>>>> +          val = 0xc;
>>>>>>>>>> +
>>>>>>>>>> +  ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_GPIO_CONFIG, 0xfffffff3);
>>>>>>>>>
>>>>>>>>> It's a kind of magic
>>>>>>>>>
>>>>>>>> I will add a macro in next patch.
>>>>>>>>>> +  if (ret)
>>>>>>>>>> +          return ret;
>>>>>>>>>> +
>>>>>>>>>> +  return qps615_pwrctl_i2c_write(ctx->client, QPS615_RESET_GPIO, val);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static int qps615_pwrctl_parse_device_dt(struct qps615_pwrctl_ctx *ctx, struct device_node *node)
>>>>>>>>>> +{
>>>>>>>>>> +  enum qps615_pwrctl_ports port;
>>>>>>>>>> +  struct qps615_pwrctl_cfg *cfg;
>>>>>>>>>> +  struct device_node *np;
>>>>>>>>>> +  int bdf, fun_no;
>>>>>>>>>> +
>>>>>>>>>> +  bdf = of_pci_get_bdf(node);
>>>>>>>>>> +  if (bdf < 0) {
>>>>>>>>>
>>>>>>>>> This is incorrect, it will fail if at any point BDF uses the most
>>>>>>>>> significant bit (which is permitted by the spec, if I'm not mistaken).
>>>>>>>>>
>>>>>>>> As per the reg property as described in the binding document we are not
>>>>>>>> expecting any change here.
>>>>>>>> https://elixir.bootlin.com/linux/v6.10.3/source/Documentation/devicetree/bindings/pci/pci.txt#L50.
>>>>>>>
>>>>>>> What will this function return if the bus no is 256?
>>>>>>> The supported PCI bus number is from 0x0 to 0xff only. so we
>>>>>> are not expecting any numbers greater than 0xff.
>>>>>>> Also please either move the function to the generic PCI code is change its name to match the rest of the driver. The of_pci_ prefix is reserved for the generic code.
>>>>>>>
>>>>>> ack.
>>>>>>>
>>>>>>>>>> +          dev_err(ctx->pwrctl.dev, "Getting BDF failed\n");
>>>>>>>>>> +          return 0;
>>>>>>>>>> +  }
>>>>>>>>>> +
>>>>>>>>>> +  fun_no = bdf & 0x7;
>>>>>>>>>
>>>>>>>>> I assume that ARI is not supported?
>>>>>>>>>
>>>>>>>> Yes this doesn't support ARI.
>>>>>>>>>> +
>>>>>>>>>> +  /* In multi function node, ignore function 1 node */
>>>>>>>>>> +  if (of_pci_get_bdf(of_get_parent(node)) == ctx->bdf->dsp3_bdf && !fun_no)
>>>>>>>>>> +          port = QPS615_ETHERNET;
>>>>>>>>>> +  else if (bdf == ctx->bdf->usp_bdf)
>>>>>>>>>> +          port = QPS615_USP;
>>>>>>>>>
>>>>>>>>> The function is being called for child device nodes. Thus upstream
>>>>>>>>> facing port (I assume that this is what USP means) can not be enumerated
>>>>>>>>> in this way.
>>>>>>>> Sorry, but I didn't your question.
>>>>>>>>
>>>>>>>> These settings will not affect the enumeration sequence these are
>>>>>>>> for configuring ports only.
>>>>>>>
>>>>>>> You are handling the case of bdf equal to the USP. Is it possible at all?
>>>>>>>
>>>>>> at the time of the configuration the PCI link is not enabled yet,
>>>>>> once we are done with the configurations only we are resumeing the link
>>>>>> training. so when we start this configuration the link is not up yet.
>>>>>
>>>>> Is your answer relevant to the question I have asked?
>>>>>
>>>> sorry dmitry I might got your question wrong. what I understood is
>>>> "you are configuring USP port before the link is up, is that possible?"
>>>> I might read your statement wrongly.
>>>>
>>>> If the question is "why do we need to configure USP?" I will try to
>>>> respond below.
>>>> "USP also will have l0s, L1 entry delays, nfts etc which can be
>>>> configured".
>>>>
>>>> Sorry once again if your question doesn't fall in both can you tell
>>>> me your question.
>>>
>>> My question was why the function gets executed for the root port. But
>>> after reading the qps615_pwrctl_parse_device_dt() I have another
>>> question: you are parsing DT nodes recursively. You should stop
>>> parsing at the first level, so that grandchildren nodes can not
>>> override your data (and so that the time isn't spent on parsing
>>> useless data). Also I have the feeling that BDF parsing isn't so
>>> correct. Will it work if QPS is sitting behind a PCI-PCI bridge?
>>>
>> we are not executing for root port. we are configuring for USP
>> since there are some features of USP which can be configured.
> 
> What is USP? Upstream side port?
> 
>>
>> we are trying to store each configurations in below line.
>> cfg = &ctx->cfg[port];
>>
>> port will have enum value based upon the bdf. after filling
>> the parent node we calling recursive function for child nodes.
>> As the BDF is unique value for each node we not expecting to get
>> same enum value for child or grand child nodes and there will
>> be no overwrite. If the BDF is not matched we are just returning
>> instead of looking for the properties.
>>
>> QPS615 node is defined as child of the pci-pci bridge only.
>> The pwrctl framework is designed to work if the device
>> is represented as child node in the pci-pci bridge only.
> 
> Of course. Each PCIe device is either a child of the root port or a
> child of a pci-pci bridge. So are the BDFs specific to the case of
> QPS615 being a child of the root PCIe bridge?
> 
yes these are specific to qps615 being a child of the root PCIe bridge.
>>
>> Hope it clarifies all the queries.
> 
> Yes. Please drop recursive parsing and add explicit single
> for_each_child_of_node().
> 
Dimitry, the ethernet nodes which are child of dsp3 need extra
for_each_child_of_node and also we are going to add support for cascade
switch once this patch lands, in that cascade switch one more QPS615
switch will be connected to the one of the downstream port of the first
switch in that case we might need to do for_each_child_of_node twice
from  the dsp node where cascade switch is connected.
So it will good if we have this recursive parsing.

- Krishna Chaitanya.
>
>> - Krishna chaitanya.
>>>>>>>
>>>>>>>>>
>>>>>>>>>> +  else if (bdf == ctx->bdf->dsp1_bdf)
>>>>>>>>>> +          port = QPS615_DSP1;
>>>>>>>>>> +  else if (bdf == ctx->bdf->dsp2_bdf)
>>>>>>>>>> +          port = QPS615_DSP2;
>>>>>>>>>> +  else if (bdf == ctx->bdf->dsp3_bdf)
>>>>>>>>>> +          port = QPS615_DSP3;
>>>>>>>>>> +  else
>>>>>>>>>> +          return 0;
>>>>>>>>>
>>>>>>>>> -EINVAL >
>>>>>>>> There are can be nodes describing endpoints also,
>>>>>>>> for those nodes bdf will not match and we are not
>>>>>>>> returning since it is expected for endpoint nodes.
>>>>>>>
>>>>>>> Which endpoints? Bindings don't describe them.
>>>>>>>
>>>>>> The client drivers like ethernet will add them once
>>>>>> this series is merged. Their drivers are not present
>>>>>> in the linux as of now.
>>>>>
>>>>> The bindings describe the hardware, not the drivers. Also the driver
>>>>> should work with the bindings that you have submitted, not some
>>>>> imaginary to-be-submitted state. Please either update the bindings
>>>>> within the patchset or fix the driver to return -EINVAL.
>>>>>
>>>> The qps615 bindings describes only the PCIe switch part,
>>>> the endpoints binding connected to the switch should be described by the
>>>> respective clients like USB hub, NVMe, ethernet etc bindings should
>>>> describe their hardware and its properties. And these bindings will
>>>> defined in seperate bindinds file not in qps615 bindings.
>>>>
>>>> for example:-
>>>>
>>>> in the following example pcie@0,0 describes usp and
>>>> pcie@1,0 & pcie@2,0 describes dsp's of the switch.
>>>> now if we say usb hub is connected to dsp1 i.e to the
>>>> node pcie@1,0 there will be a child node to the pcie@1,0
>>>> to denote usb hub hardware.
>>>> And that node is external to the switch and we are not
>>>> configuring it through i2c. As these are pcie devices
>>>> representation is generic one we can't say if the client
>>>> nodes(in this case usb hub) will be present or not. if the child
>>>> node( for example usb hub) is present we can't return -EINVAL
>>>> because qps615 will not configure it.
>>>>
>>>> &pcieport {
>>>>           pcie@0,0 {
>>>>                   pcie@1,0 {
>>>>                           reg = <0x20800 0x0 0x0 0x0 0x0>;
>>>>                           #address-cells = <3>;
>>>>                           #size-cells = <2>;
>>>>
>>>>                           device_type = "pci";
>>>>                           ranges;
>>>>                           usb_hub@0,0 {
>>>>                                   //describes USB hub
>>>>                           };
>>>>                   };
>>>>
>>>>                   pcie@2,0 {
>>>>                           reg = <0x21000 0x0 0x0 0x0 0x0>;
>>>>                           #address-cells = <3>;
>>>>                           #size-cells = <2>;
>>>>
>>>>                           device_type = "pci";
>>>>                           ranges;
>>>>                   };
>>>>           };
>>>> };
> 

