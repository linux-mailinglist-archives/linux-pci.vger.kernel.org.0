Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60815E8211
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 20:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIWSvu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 14:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIWSvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 14:51:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41E5120BFE;
        Fri, 23 Sep 2022 11:51:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CD47B819FE;
        Fri, 23 Sep 2022 18:51:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC0C433D6;
        Fri, 23 Sep 2022 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663959103;
        bh=AfmJuFAhQ53hPbrPwULtlYaeFWnbOCfCu4ZiIdx+G9w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OZ4JsFfgi0OG+lLzGvLwX7BI94AaPDBaEpyvaShqvBCPfqO9/DVbDFXVtgwSkpohm
         CRUKwf9AEuV4FFt/N1/kbtVOMIpLYuYeQhZXmDCxCGES4GD2dvVjj8y33C/kPH/cZy
         R6TDHTHYjhvLQ2R45+kztLNdjWR/C4Ni1lfdQom02nxsQoBrIUIOk9fBMIT/DviwmF
         A5oNRXA38492wNpq81xzX5OAlWgX+F0m4NeovP9NbCJppuP3bBnffM9tqdShUtFgK/
         WE3RxcaM+gftqTxG4YtyH/tckcgKw9vnCuhrYmFIMAsIBpR/VjvhKEGLh+mHny4M8f
         QdercMTtmK3ww==
Date:   Fri, 23 Sep 2022 13:51:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     will@kernel.org, Jonathan.Cameron@Huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20220923185141.GA1407035@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f67b3c4e-f60e-ec69-bf29-c34604aa0eff@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 10:46:09PM +0800, Shuai Xue wrote:
> 在 2022/9/23 AM1:36, Bjorn Helgaas 写道:
> > On Sat, Sep 17, 2022 at 08:10:35PM +0800, Shuai Xue wrote:

> >> +static struct device_attribute dwc_pcie_pmu_cpumask_attr =
> >> +__ATTR(cpumask, 0444, dwc_pcie_pmu_cpumask_show, NULL);
> > 
> > DEVICE_ATTR_RO()?

> DEVICE_ATTR_RO may a good choice. But does it fit the code style to use
> DEVICE_ATTR_RO in drivers/perf? As far as know, CCN, CCI, SMMU,
> qcom_l2_pmu use "struct device_attribute" directly.

DEVICE_ATTR_RO is just newer, and I think CCN, CCI, SMMU, etc. would
be using it if they were written today.  Of course, the drivers/perf
maintainers may have a different opinion :)

> > I think every caller of dwc_pcie_pmu_read_dword() makes the same check
> > and prints the same message; maybe the message should be moved inside
> > dwc_pcie_pmu_read_dword()?
> > 
> > Same with dwc_pcie_pmu_write_dword(); moving the message there would
> > simplify all callers.
> 
> I would like to wrap dwc_pcie_pmu_{write}_dword out, use
> pci_{read}_config_dword and drop the snaity check of return value as
> Jonathan suggests.  How did you like it?

Sounds good.  Not sure the error checking is worthwhile since
pci_read_config_dword() really doesn't return meaningful errors
anyway.

> >> +static struct dwc_pcie_info_table *pmu_to_pcie_info(struct pmu *pmu)
> >> +{
> >> +	struct dwc_pcie_info_table *pcie_info;
> >> +	struct dwc_pcie_pmu *pcie_pmu = to_pcie_pmu(pmu);
> >> +
> >> +	pcie_info = container_of(pcie_pmu, struct dwc_pcie_info_table, pcie_pmu);
> >> +	if (pcie_info == NULL)
> >> +		pci_err(pcie_info->pdev, "Can't get pcie info\n");
> > 
> > It shouldn't be possible to get here for a pmu with no pcie_info, and
> > callers don't check for a NULL pointer return value before
> > dereferencing it, so I guess all this adds is an error message before
> > a NULL pointer oops?  Not sure the code clutter is worth it.
> 
> Do you mean to drop the snaity check of container_of?

Yes.  I'm suggesting that the NULL pointer oops itself has enough
information to debug this problem, even without the pci_err().

Bjorn
