Return-Path: <linux-pci+bounces-2095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07582BF2E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 12:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA631C23944
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C26364CFF;
	Fri, 12 Jan 2024 11:24:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831225FEE8;
	Fri, 12 Jan 2024 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBJyT4wxXz6K7Jp;
	Fri, 12 Jan 2024 19:21:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 59496140A36;
	Fri, 12 Jan 2024 19:24:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 11:24:15 +0000
Date: Fri, 12 Jan 2024 11:24:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>
Subject: Re: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Message-ID: <20240112112414.00006443@Huawei.com>
In-Reply-To: <659f404a99aad_3d2f92946e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
	<20240109155755.0000087b@Huawei.com>
	<659f404a99aad_3d2f92946e@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jan 2024 17:11:38 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 20 Dec 2023 14:07:35 +0900
> > KobayashiDaisuke <kobayashi.da-06@fujitsu.com> wrote:
> >   
> > > Hello.
> > > 
> > > This patch series adds a feature to lspci that displays the link status
> > > of the CXL1.1 device.
> > > 
> > > CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> > > the link status can be output in the same way as traditional PCIe.
> > > However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> > > different method to obtain the link status from traditional PCIe.
> > > This is because the link status of the CXL1.1 device is not mapped
> > > in the configuration space (as per cxl3.0 specification 8.1).
> > > Instead, the configuration space containing the link status is mapped
> > > to the memory mapped register region (as per cxl3.0 specification 8.2,
> > > Table 8-18). Therefore, the current lspci has a problem where it does
> > > not display the link status of the CXL1.1 device. 
> > > This patch solves these issues.
> > > 
> > > The method of acquisition is in the order of obtaining the device UID,
> > > obtaining the base address from CEDT, and then obtaining the link
> > > status from memory mapped register. Considered outputting with the cxl
> > > command due to the scope of the CXL specification, but devices from
> > > CXL2.0 onwards can be output in the same way as traditional PCIe.
> > > Therefore, it would be better to make the lspci command compatible with
> > > the CXL1.1 device for compatibility reasons.
> > > 
> > > I look forward to any comments you may have.  
> > Yikes. 
> > 
> > My gut feeling is that you shouldn't need to do this level of hackery.
> > 
> > If we need this information to be exposed to tooling then we should
> > add support to the kernel to export it somewhere in sysfs and read that
> > directly.  Do we need it to be available in absence of the CXL driver
> > stack?   
> 
> I am hoping that's a non-goal if only because that makes it more
> difficult for the kernel to provide some help here without polluting to
> the PCI core.
> 
> To date, RCRB handling is nothing that the PCI core needs to worry
> about, and I am not sure I want to open that box.
> 
> I am wondering about an approach like below is sufficient for lspci.
> 
> The idea here is that cxl_pci (or other PCI driver for Type-2 RCDs) can
> opt-in to publishing these hidden registers.
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4fd1f207c84e..ee63dff63b68 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -960,6 +960,19 @@ static const struct pci_error_handlers cxl_error_handlers = {
>         .cor_error_detected     = cxl_cor_error_detected,
>  };
>  
> +static struct attribute *cxl_rcd_attrs[] = {
> +       &dev_attr_rcd_lnkcp.attr,
> +       &dev_attr_rcd_lnkctl.attr,
> +       NULL
> +};
> +
> +static struct attribute_group cxl_rcd_group = {
> +       .attrs = cxl_rcd_attrs,
> +       .is_visible = cxl_rcd_visible,
> +};
> +
> +__ATTRIBUTE_GROUPS(cxl_pci);
> +
>  static struct pci_driver cxl_pci_driver = {
>         .name                   = KBUILD_MODNAME,
>         .id_table               = cxl_mem_pci_tbl,
> @@ -967,6 +980,7 @@ static struct pci_driver cxl_pci_driver = {
>         .err_handler            = &cxl_error_handlers,
>         .driver = {
>                 .probe_type     = PROBE_PREFER_ASYNCHRONOUS,
> +               .dev_groups     = cxl_rcd_groups,
>         },
>  };
>  
> 
> However, the problem I believe is this will end up with:
> 
> /sys/bus/pci/devices/$pdev/rcd_lnkcap
> /sys/bus/pci/devices/$pdev/rcd_lnkctl
> 
> ...with valid values, but attributes like:
> 
> /sys/bus/pci/devices/$pdev/current_link_speed
> 
> ...returning -EINVAL.
> 
> So I think the options are:
> 
> 1/ Keep the status quo of RCRB knowledge only lives in drivers/cxl/ and
>    piecemeal enable specific lspci needs with RCD-specific attributes

This one gets my vote.

> 
> ...or:
> 
> 2/ Hack pcie_capability_read_word() to internally figure out that based
>    on a config offset a device may have a hidden capability and switch over
>    to RCRB based config-cycle access for those.
> 
> Given that the CXL 1.1 RCH topology concept was immediately deprecated
> in favor of VH topology in CXL 2.0, I am not inclined to pollute the
> general Linux PCI core with that "aberration of history" as it were.
Agreed.



