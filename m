Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61A8345BD9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 11:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCWKYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 06:24:30 -0400
Received: from foss.arm.com ([217.140.110.172]:43496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhCWKYL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 06:24:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5A211042;
        Tue, 23 Mar 2021 03:24:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A94B13F719;
        Tue, 23 Mar 2021 03:24:09 -0700 (PDT)
Date:   Tue, 23 Mar 2021 10:24:04 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Zhang Qilong <zhangqilong3@huawei.com>, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: fix reference leak in
 pex_ep_event_pex_rst_deassert
Message-ID: <20210323102404.GA28718@e121166-lin.cambridge.arm.com>
References: <20201102143045.142121-1-zhangqilong3@huawei.com>
 <f09c0801-d584-3c27-d3e7-ca59a64a30d1@nvidia.com>
 <fa858756-8fe4-5049-b280-410d225a58a8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa858756-8fe4-5049-b280-410d225a58a8@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 07:30:13PM +0000, Jon Hunter wrote:
> 
> On 03/11/2020 02:52, Vidya Sagar wrote:
> > 
> > 
> > On 11/2/2020 8:00 PM, Zhang Qilong wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> pm_runtime_get_sync will increment pm usage counter even it
> >> failed. Forgetting to pm_runtime_put_noidle will result in
> >> reference leak in pex_ep_event_pex_rst_deassert, so we should
> >> fix it.
> >>
> >> Fixes: c57247f940e8e ("PCI: tegra: Add support for PCIe endpoint mode
> >> in Tegra194")
> >> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> >> ---
> >>   drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> >> b/drivers/pci/controller/dwc/pcie-tegra194.c
> >> index f920e7efe118..936510b5c649 100644
> >> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> >> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> >> @@ -1662,6 +1662,7 @@ static void pex_ep_event_pex_rst_deassert(struct
> >> tegra_pcie_dw *pcie)
> >>
> >>          ret = pm_runtime_get_sync(dev);
> >>          if (ret < 0) {
> >> +               pm_runtime_put_noidle(dev);
> > Why can't we call pm_runtime_put_sync(dev) as that is what is being
> > called in failure cases anyway further down in this API?
> 
> 
> Simply because this is a failure case where the get_sync did not
> complete. So this change is correct, however, now we have
> pm_runtime_resume_and_get(), it is better/simpler just to replace the
> pm_runtime_get_sync with pm_runtime_resume_and_get.

I think this patch slipped through the cracks, should I update the patch
myself with the suggestion above and merge it or you guys prefer sending
it ?

Thanks,
Lorenzo
