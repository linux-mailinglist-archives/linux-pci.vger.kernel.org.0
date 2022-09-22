Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5766C5E69B4
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 19:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIVRgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 13:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiIVRgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 13:36:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9E4E8D8E;
        Thu, 22 Sep 2022 10:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EF3AB82341;
        Thu, 22 Sep 2022 17:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D0FC433D6;
        Thu, 22 Sep 2022 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663868169;
        bh=sd+Nq15xQNHqjmHCOOITrKWP+31hozrwfr3wc+2Tj30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ejkb2qE2uNKOs2/ZKZ5aLYj95qJQF+sZnBYhjc6iJnto5n6VI+Z60nRy47/54cqW7
         1wg7UYAioR4Hydt5vZOlLPEmVNwTW1CmmlhRYf/CgJWpZjHUX3yfJswzS1FjMkwjjk
         BXA7gvQovbYB0Df9D3Ve0zo6lLbGobEJZ3Fx2lo5KTz89K+2MoqTAlSIRmnnqxqGr8
         nYokyqEqCmwA3f9/EA/ihxJvHEHH1J4gYN8j6y2ZWq+Qs7Zfke5pgiwZ/bc7B2ZiUx
         vnLXRsrqtCEZHpMoyAZ9ZJUguM88s6czCNLsZkGGvqzWqAFuVxIqMw025NNGodL+V0
         ExAT//Wq90Rpg==
Date:   Thu, 22 Sep 2022 12:36:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     will@kernel.org, Jonathan.Cameron@Huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20220922173607.GA1318619@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917121036.14864-3-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Sat, Sep 17, 2022 at 08:10:35PM +0800, Shuai Xue wrote:
> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is not a PCIe
> Root Complex integrated End Point(RCiEP) device but only register counters
> provided by each PCIe Root Port.
> 
> To facilitate collection of statistics the controller provides the
> following two features for each Root Port:
> 
> - Time Based Analysis (RX/TX data throughput and time spent in each
>   low-power LTSSM state)
> - Event counters (Error and Non-Error for lanes)
> 
> Note, only one counter for each type.
> 
> This driver add PMU devices for each PCIe Root Port. And the PMU device is
> named based the BDF of Root Port. For example,
> 
>     10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
> 
> the PMU device name for this Root Port is pcie_bdf_100000.
> 
> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> 
>     $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
> 
> average RX bandwidth can be calculated like this:
> 
>     PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

> +++ b/drivers/perf/dwc_pcie_pmu.c
> ...
> +#define DWC_PCIE_VSEC_ID			0x02

I don't think DWC_PCIE_VSEC_ID is a very good name because it doesn't
tell us anything about the purpose of the capability.  Something like
DWC_PCIE_RAS_DES_VSEC_ID would be more useful to readers.

> +#define DWC_PCIE_LINK_CAPABILITIES_REG		0xC
> +#define DWC_PCIE_LANE_SHIFT			4
> +#define DWC_PCIE_LANE_MASK			GENMASK(9, 4)

Shouldn't need these at all; see below.

> +struct dwc_pcie_info_table {
> +	u32 bdf;
> +	u32 cap_pos;

Would be useful to name this "ras_des" or similar so we have a hint
about what we're reading/writing when using "pcie_info->cap_pos" below.

> +static struct device_attribute dwc_pcie_pmu_cpumask_attr =
> +__ATTR(cpumask, 0444, dwc_pcie_pmu_cpumask_show, NULL);

DEVICE_ATTR_RO()?

> +#define _dwc_pcie_format_attr(_name, _cfg, _fld)				\
> +	(&((struct dwc_pcie_format_attr[]) {{				\
> +		.attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),	\

Ditto.

> +#define DWC_PCIE_EVENT_ATTR(_name, _type, _eventid, _lane)		\
> +	(&((struct dwc_pcie_event_attr[]) {{				\
> +		.attr = __ATTR(_name, 0444, dwc_pcie_event_show, NULL),	\

Ditto.

> +static int dwc_pcie_pmu_discover(struct dwc_pcie_pmu_priv *priv)
> +{
> +	int val, where, index = 0;
> +	struct pci_dev *pdev = NULL;
> +	struct dwc_pcie_info_table *pcie_info;
> +
> +	priv->pcie_table =
> +	    devm_kcalloc(priv->dev, RP_NUM_MAX, sizeof(*pcie_info), GFP_KERNEL);
> +	if (!priv->pcie_table)
> +		return -EINVAL;
> +
> +	pcie_info = priv->pcie_table;
> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL &&
> +	       index < RP_NUM_MAX) {
> +		if (!pci_dev_is_rootport(pdev))
> +			continue;
> +
> +		pcie_info[index].bdf = dwc_pcie_get_bdf(pdev);
> +		pcie_info[index].pdev = pdev;
> +
> +		if (dwc_pcie_find_ras_des_cap_position(pdev, &where))
> +			continue;
> +
> +		pcie_info[index].cap_pos = where;
> +
> +		pci_read_config_dword(pdev,
> +				pdev->pcie_cap + DWC_PCIE_LINK_CAPABILITIES_REG,
> +				&val);
> +		pcie_info[index].num_lanes =
> +			(val & DWC_PCIE_LANE_MASK) >> DWC_PCIE_LANE_SHIFT;

I think you can use pcie_get_width_cap() here.

> +static int dwc_pcie_pmu_set_event_id(struct dwc_pcie_info_table *pcie_info,
> +				     int event_id)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = dwc_pcie_pmu_read_dword(pcie_info, DWC_PCIE_EVENT_CNT_CTRL, &val);
> +	if (ret) {
> +		pci_err(pcie_info->pdev, "PCIe read fail\n");

Maybe #define dev_fmt above to add a prefix to these messages?
Otherwise I think they will look like:

  pcieport 0000:00:1c.0: PCIe read fail

which suggests it's related to pcieport, but that's the wrong place to
look.

I think every caller of dwc_pcie_pmu_read_dword() makes the same check
and prints the same message; maybe the message should be moved inside
dwc_pcie_pmu_read_dword()?

Same with dwc_pcie_pmu_write_dword(); moving the message there would
simplify all callers.

> +static int dwc_pcie_pmu_event_enable(struct dwc_pcie_info_table *pcie_info,
> +				     u32 enable)
> +{
> +	u32 ret;
> +	u32 val;
> +
> +	ret = dwc_pcie_pmu_read_dword(pcie_info, DWC_PCIE_EVENT_CNT_CTRL, &val);
> +	if (ret) {
> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
> +		return ret;
> +	}
> +
> +	val &= ~(DWC_PCIE__CNT_ENABLE_MASK);

Superfluous parens.

> +static int dwc_pcie_pmu_base_time_add_prepare(struct dwc_pcie_info_table
> +					      *pcie_info, u32 event_id)
> +{
> +	u32 ret;
> +	u32 val;
> +
> +	ret = dwc_pcie_pmu_read_dword(pcie_info,
> +				      DWC_PCIE_TIME_BASED_ANALYSIS_CTRL, &val);
> +	if (ret) {
> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
> +		return ret;
> +	}
> +
> +	val &= ~DWC_PCIE__TIME_BASED_REPORT_SELECT_MASK;
> +	val |= event_id << DWC_PCIE__TIME_BASED_REPORT_SELECT_SHIFT;
> +	val &= ~DWC_PCIE__TIME_BASED_DURATION_SELECT;
> +
> +	/*
> +	 * TIME_BASED_ANALYSIS_DATA_REG is a 64 bit register, we can safely
> +	 * use it with any manually controllered duration.

s/controllered/controlled/ ?  Not sure what this means.  Maybe that
64 bits is wide enough you don't need to worry about rollover?

> +static struct dwc_pcie_info_table *pmu_to_pcie_info(struct pmu *pmu)
> +{
> +	struct dwc_pcie_info_table *pcie_info;
> +	struct dwc_pcie_pmu *pcie_pmu = to_pcie_pmu(pmu);
> +
> +	pcie_info = container_of(pcie_pmu, struct dwc_pcie_info_table, pcie_pmu);
> +	if (pcie_info == NULL)
> +		pci_err(pcie_info->pdev, "Can't get pcie info\n");

It shouldn't be possible to get here for a pmu with no pcie_info, and
callers don't check for a NULL pointer return value before
dereferencing it, so I guess all this adds is an error message before
a NULL pointer oops?  Not sure the code clutter is worth it.

> +	return pcie_info;
> +}

> +static int dwc_pcie_pmu_event_init(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct dwc_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +	struct perf_event *sibling;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (hwc->sample_period) {
> +		dev_dbg(pcie_pmu->dev, "Sampling not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->cpu < 0) {
> +		dev_dbg(pcie_pmu->dev, "Per-task mode not supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	event->cpu = pcie_pmu->on_cpu;
> +
> +	if (event->group_leader != event &&
> +	    !is_software_event(event->group_leader)) {
> +		dev_dbg(pcie_pmu->dev, "Drive way only allow one event!\n");

"Drive way"?  -ENOPARSE for me :)

> +		return -EINVAL;
> +	}
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (sibling != event && !is_software_event(sibling)) {
> +			dev_dbg(pcie_pmu->dev, "Drive way event not allowed!\n");
> +			return -EINVAL;
> +		}
> +	}

> +static void dwc_pcie_pmu_set_period(struct hw_perf_event *hwc)
> +{
> +	u64 new = 0;

Superfluous variable.

> +	local64_set(&hwc->prev_count, new);
> +}

> +static int __dwc_pcie_pmu_probe(struct dwc_pcie_pmu_priv *priv,
> +				struct dwc_pcie_info_table *pcie_info)
> +{
> +	int ret;
> +	char *name;
> +	struct dwc_pcie_pmu *pcie_pmu;
> +	struct device *dev;
> +
> +	if (!pcie_info || !pcie_info->pdev) {
> +		pci_err(pcie_info->pdev, "Input parameter is invalid\n");

There are a lot of "Input parameter is invalid" messages.  If somebody
sees that, there's no hint about which one to look at.  Messages that
are constant strings are usually a hint that they could include more
information.

> +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	int pcie_index;
> +	struct dwc_pcie_pmu_priv *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* If PMU is not support on current platform, keep slient */

s/not support/not supported/
s/slient/silent/

Bjorn
