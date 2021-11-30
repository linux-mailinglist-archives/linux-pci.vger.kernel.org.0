Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44F462B38
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 04:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhK3Dji (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 22:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbhK3Djh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 22:39:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D153C061574;
        Mon, 29 Nov 2021 19:36:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFFD7B80DE0;
        Tue, 30 Nov 2021 03:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF36C53FC7;
        Tue, 30 Nov 2021 03:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638243376;
        bh=IycgnrvCMNHeENFLTGVnJuL3IdXlmzt7FRjEBZ4ijb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I1OxSd5rT9W0FplE3jccvEC8b4Ddl3So10QcWdDwbwezIRQ8jbiXaN4wkjceOMJ/g
         c27PxhSSwfw38F9E/+e6GRnnDy355gJh2dDB+ry/6XnOr5ormX7E8HJ3ZN8dQLRmVj
         pF+7tJpydphATIPisalNsdD/uob8cHmI8B8n3vMWRnHAwmFBpjv5GDmirKypXp1m+G
         C4a2rUtTwTK5Fo/Cano8aiX+B+oY9cJuvyzO6ewGfY8oeQvvxN0wEdVE+XY1++AQ/m
         3J+VakHd1Pveh/OvN4lJ3E2hyZJKpxA8EBJTv5uYbK5lpagJr49FTYDr41eA32nBSP
         8X+5LXfpHfpVQ==
Date:   Mon, 29 Nov 2021 21:36:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] PCI: qcom: Fix warning generated due to the incorrect
 data type
Message-ID: <20211130033614.GA2721688@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124140424.51675-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 07:34:24PM +0530, Manivannan Sadhasivam wrote:
> Fix the below sparse warning due to the use of incorrect initializer
> data type (u16) for bdf_be variable that receives the return value of
> cpu_to_be16(). The correct type should be __be16.

I think the patch looks OK, but the reason to change this is not to
"fix the warning".  The reason is to fix the *problem*, i.e.,
cpu_to_be16() returns "__be16", which is incompatible with "u16".

The warning is only a helpful hint, and should not be part of the
subject line.  "cpu_to_be16" or "iommu-map" would be much more
useful information in the subject.

I'm also curious why pcie-qcom.c is the only driver that does this.
"iommu-map" is not specific to qcom, but no other drivers do similar
things with it.

> sparse warnings: (new ones prefixed by >>)
> >> drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [usertype] bdf_be @@     got restricted __be16 [usertype] @@
>    drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     expected unsigned short [usertype] bdf_be
>    drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     got restricted __be16 [usertype]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8a7a300163e5..6c3b034e9946 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1312,7 +1312,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
>  
>  	/* Look for an available entry to hold the mapping */
>  	for (i = 0; i < nr_map; i++) {
> -		u16 bdf_be = cpu_to_be16(map[i].bdf);
> +		__be16 bdf_be = cpu_to_be16(map[i].bdf);
>  		u32 val;
>  		u8 hash;
>  
> -- 
> 2.25.1
> 
