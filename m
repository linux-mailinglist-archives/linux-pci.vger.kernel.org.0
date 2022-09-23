Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B05E7D7C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiIWOqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIWOqS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 10:46:18 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8951401B9;
        Fri, 23 Sep 2022 07:46:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VQXPcOU_1663944369;
Received: from 30.240.121.51(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VQXPcOU_1663944369)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 22:46:11 +0800
Message-ID: <f67b3c4e-f60e-ec69-bf29-c34604aa0eff@linux.alibaba.com>
Date:   Fri, 23 Sep 2022 22:46:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     will@kernel.org, Jonathan.Cameron@Huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
References: <20220922173607.GA1318619@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20220922173607.GA1318619@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2022/9/23 AM1:36, Bjorn Helgaas 写道:
> [+cc linux-pci]
> 
> On Sat, Sep 17, 2022 at 08:10:35PM +0800, Shuai Xue wrote:
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is not a PCIe
>> Root Complex integrated End Point(RCiEP) device but only register counters
>> provided by each PCIe Root Port.
>>
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - Time Based Analysis (RX/TX data throughput and time spent in each
>>   low-power LTSSM state)
>> - Event counters (Error and Non-Error for lanes)
>>
>> Note, only one counter for each type.
>>
>> This driver add PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>     10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is pcie_bdf_100000.
>>
>> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>>
>>     $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>     PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
>> +++ b/drivers/perf/dwc_pcie_pmu.c
>> ...
>> +#define DWC_PCIE_VSEC_ID			0x02
> 
> I don't think DWC_PCIE_VSEC_ID is a very good name because it doesn't
> tell us anything about the purpose of the capability.  Something like
> DWC_PCIE_RAS_DES_VSEC_ID would be more useful to readers.

Good idea, will use DWC_PCIE_RAS_DES_VSEC_ID instead in next version.

> 
>> +#define DWC_PCIE_LINK_CAPABILITIES_REG		0xC
>> +#define DWC_PCIE_LANE_SHIFT			4
>> +#define DWC_PCIE_LANE_MASK			GENMASK(9, 4)
> 
> Shouldn't need these at all; see below.
> 
>> +struct dwc_pcie_info_table {
>> +	u32 bdf;
>> +	u32 cap_pos;
> 
> Would be useful to name this "ras_des" or similar so we have a hint
> about what we're reading/writing when using "pcie_info->cap_pos" below.

Good idea, will use ras_des instead in next version.

> 
>> +static struct device_attribute dwc_pcie_pmu_cpumask_attr =
>> +__ATTR(cpumask, 0444, dwc_pcie_pmu_cpumask_show, NULL);
> 
> DEVICE_ATTR_RO()?
> 
>> +#define _dwc_pcie_format_attr(_name, _cfg, _fld)				\
>> +	(&((struct dwc_pcie_format_attr[]) {{				\
>> +		.attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),	\
> 
> Ditto.
> 
>> +#define DWC_PCIE_EVENT_ATTR(_name, _type, _eventid, _lane)		\
>> +	(&((struct dwc_pcie_event_attr[]) {{				\
>> +		.attr = __ATTR(_name, 0444, dwc_pcie_event_show, NULL),	\
> 
> Ditto.

DEVICE_ATTR_RO may a good choice. But does it fit the code style to use
DEVICE_ATTR_RO in drivers/perf? As far as know, CCN, CCI, SMMU,
qcom_l2_pmu use "struct device_attribute" directly.

> 
>> +static int dwc_pcie_pmu_discover(struct dwc_pcie_pmu_priv *priv)
>> +{
>> +	int val, where, index = 0;
>> +	struct pci_dev *pdev = NULL;
>> +	struct dwc_pcie_info_table *pcie_info;
>> +
>> +	priv->pcie_table =
>> +	    devm_kcalloc(priv->dev, RP_NUM_MAX, sizeof(*pcie_info), GFP_KERNEL);
>> +	if (!priv->pcie_table)
>> +		return -EINVAL;
>> +
>> +	pcie_info = priv->pcie_table;
>> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL &&
>> +	       index < RP_NUM_MAX) {
>> +		if (!pci_dev_is_rootport(pdev))
>> +			continue;
>> +
>> +		pcie_info[index].bdf = dwc_pcie_get_bdf(pdev);
>> +		pcie_info[index].pdev = pdev;
>> +
>> +		if (dwc_pcie_find_ras_des_cap_position(pdev, &where))
>> +			continue;
>> +
>> +		pcie_info[index].cap_pos = where;
>> +
>> +		pci_read_config_dword(pdev,
>> +				pdev->pcie_cap + DWC_PCIE_LINK_CAPABILITIES_REG,
>> +				&val);
>> +		pcie_info[index].num_lanes =
>> +			(val & DWC_PCIE_LANE_MASK) >> DWC_PCIE_LANE_SHIFT;
> 
> I think you can use pcie_get_width_cap() here.

You are right, will use pcie_get_width_cap() instead in next version.

>> +static int dwc_pcie_pmu_set_event_id(struct dwc_pcie_info_table *pcie_info,
>> +				     int event_id)
>> +{
>> +	int ret;
>> +	u32 val;
>> +
>> +	ret = dwc_pcie_pmu_read_dword(pcie_info, DWC_PCIE_EVENT_CNT_CTRL, &val);
>> +	if (ret) {
>> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
> 
> Maybe #define dev_fmt above to add a prefix to these messages?
> Otherwise I think they will look like:
> 
>   pcieport 0000:00:1c.0: PCIe read fail
> 
> which suggests it's related to pcieport, but that's the wrong place to
> look.
> 
> I think every caller of dwc_pcie_pmu_read_dword() makes the same check
> and prints the same message; maybe the message should be moved inside
> dwc_pcie_pmu_read_dword()?
> 
> Same with dwc_pcie_pmu_write_dword(); moving the message there would
> simplify all callers.

I would like to wrap dwc_pcie_pmu_{write}_dword out, use pci_{read}_config_dword
and drop the snaity check of return value as Jonathan suggests.
How did you like it?

> 
>> +static int dwc_pcie_pmu_event_enable(struct dwc_pcie_info_table *pcie_info,
>> +				     u32 enable)
>> +{
>> +	u32 ret;
>> +	u32 val;
>> +
>> +	ret = dwc_pcie_pmu_read_dword(pcie_info, DWC_PCIE_EVENT_CNT_CTRL, &val);
>> +	if (ret) {
>> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
>> +		return ret;
>> +	}
>> +
>> +	val &= ~(DWC_PCIE__CNT_ENABLE_MASK);
> 
> Superfluous parens.

Will use recap in next version.

> 
>> +static int dwc_pcie_pmu_base_time_add_prepare(struct dwc_pcie_info_table
>> +					      *pcie_info, u32 event_id)
>> +{
>> +	u32 ret;
>> +	u32 val;
>> +
>> +	ret = dwc_pcie_pmu_read_dword(pcie_info,
>> +				      DWC_PCIE_TIME_BASED_ANALYSIS_CTRL, &val);
>> +	if (ret) {
>> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
>> +		return ret;
>> +	}
>> +
>> +	val &= ~DWC_PCIE__TIME_BASED_REPORT_SELECT_MASK;
>> +	val |= event_id << DWC_PCIE__TIME_BASED_REPORT_SELECT_SHIFT;
>> +	val &= ~DWC_PCIE__TIME_BASED_DURATION_SELECT;
>> +
>> +	/*
>> +	 * TIME_BASED_ANALYSIS_DATA_REG is a 64 bit register, we can safely
>> +	 * use it with any manually controllered duration.
> 
> s/controllered/controlled/ ?  Not sure what this means.  Maybe that
> 64 bits is wide enough you don't need to worry about rollover?

Yes, 64 bits is wide enough so we do not need to worry about rollover.
Sorry for this typo.

>> +static struct dwc_pcie_info_table *pmu_to_pcie_info(struct pmu *pmu)
>> +{
>> +	struct dwc_pcie_info_table *pcie_info;
>> +	struct dwc_pcie_pmu *pcie_pmu = to_pcie_pmu(pmu);
>> +
>> +	pcie_info = container_of(pcie_pmu, struct dwc_pcie_info_table, pcie_pmu);
>> +	if (pcie_info == NULL)
>> +		pci_err(pcie_info->pdev, "Can't get pcie info\n");
> 
> It shouldn't be possible to get here for a pmu with no pcie_info, and
> callers don't check for a NULL pointer return value before
> dereferencing it, so I guess all this adds is an error message before
> a NULL pointer oops?  Not sure the code clutter is worth it.

Do you mean to drop the snaity check of container_of?

>> +	return pcie_info;
>> +}
> 
>> +static int dwc_pcie_pmu_event_init(struct perf_event *event)
>> +{
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	struct dwc_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
>> +	struct perf_event *sibling;
>> +
>> +	if (event->attr.type != event->pmu->type)
>> +		return -ENOENT;
>> +
>> +	if (hwc->sample_period) {
>> +		dev_dbg(pcie_pmu->dev, "Sampling not supported\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	if (event->cpu < 0) {
>> +		dev_dbg(pcie_pmu->dev, "Per-task mode not supported\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	event->cpu = pcie_pmu->on_cpu;
>> +
>> +	if (event->group_leader != event &&
>> +	    !is_software_event(event->group_leader)) {
>> +		dev_dbg(pcie_pmu->dev, "Drive way only allow one event!\n");
> 
> "Drive way"?  -ENOPARSE for me :)

Good catch, its a typo and I used this in DDR Driveway PMU debug. Will drop
it in next version.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	for_each_sibling_event(sibling, event->group_leader) {
>> +		if (sibling != event && !is_software_event(sibling)) {
>> +			dev_dbg(pcie_pmu->dev, "Drive way event not allowed!\n");
>> +			return -EINVAL;
>> +		}
>> +	}
> 
>> +static void dwc_pcie_pmu_set_period(struct hw_perf_event *hwc)
>> +{
>> +	u64 new = 0;
> 
> Superfluous variable.
> 
>> +	local64_set(&hwc->prev_count, new);
>> +}

I will set with 0 instead in next version.

> 
>> +static int __dwc_pcie_pmu_probe(struct dwc_pcie_pmu_priv *priv,
>> +				struct dwc_pcie_info_table *pcie_info)
>> +{
>> +	int ret;
>> +	char *name;
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +	struct device *dev;
>> +
>> +	if (!pcie_info || !pcie_info->pdev) {
>> +		pci_err(pcie_info->pdev, "Input parameter is invalid\n");
> 
> There are a lot of "Input parameter is invalid" messages.  If somebody
> sees that, there's no hint about which one to look at.  Messages that
> are constant strings are usually a hint that they could include more
> information.

I see your points. Will give a more accurate hint.

>> +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
>> +{
>> +	int ret = 0;
>> +	int pcie_index;
>> +	struct dwc_pcie_pmu_priv *priv;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +	priv->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	/* If PMU is not support on current platform, keep slient */
> 
> s/not support/not supported/
> s/slient/silent/

Sorry for these typos, will fix in next version.

> 
> Bjorn

Thank you for your valuable comments.

Best Regards,
Shuai

