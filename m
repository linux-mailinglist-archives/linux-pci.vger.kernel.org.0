Return-Path: <linux-pci+bounces-1222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4BD81A11B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 15:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A982855A7
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315938F8B;
	Wed, 20 Dec 2023 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDfvNxqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8D39844;
	Wed, 20 Dec 2023 14:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDCBC433C8;
	Wed, 20 Dec 2023 14:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703082471;
	bh=PbcxQV3R6UY1YiVESDyUAZnHxABvldU4o8NABOycW5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDfvNxqA3zIdDySbm5xkjXyQfU8gaioIQGX7Onsvm+18RPBIMmPHqsnzhroowCaxP
	 GM8ItdV12YVb1Ofb529JKKfRm/d0T5pd0jxqNSBjCOdUiATvV5u0Gu+/2tMiIEJLuu
	 iLt3iuXef33QSdBpI7ocxnQqeujPjc0SCXsuuD/iuL2FeP9AAbTb+d2Ypb54uJK8Tv
	 l3i2WZGBBbcGZqq9N9gLGDz/UdehgvxEj38E5xvNH4sntP42I3vLnw/Ljsr31MKpYo
	 lX68MUxZ7ao58sv4V40eOSnB4HZmIVmaMG/JY6+JseBim4ry3sDno36lsO+mBrh7LD
	 4ehwxFc8cBPdQ==
Date: Wed, 20 Dec 2023 19:57:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
	imx@lists.linux.dev, jdmason@kudzu.us, kishon@kernel.org,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer fail
 when BAR1 is fixed size
Message-ID: <20231220142736.GE3544@thinkpad>
References: <20231219142403.1223873-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219142403.1223873-1-Frank.Li@nxp.com>

On Tue, Dec 19, 2023 at 09:24:03AM -0500, Frank Li wrote:
> ntb_netdev transfer is failing when epc controller's BAR1 is fix size, such
> as 64K. Certain controller(like dwc) require memory address must be align
> with the fixed bar size.
> 
> For example:
> 	If BAR1's fix size is 64K, and other size programmable BAR's
> alignment is 4K.
> 	vntb call pci_epf_alloc_space() get 4K aligned address, like
> 0x104E31000. But root complex actually write to address 0x104E30000 when
> write BAR1.
> 
> Adds bar_fixed_size check and sets correct alignment for fixed-size BAR.
> 

Change looks fine by me, but I have a hard time understanding this commit
message.

The change just checks the size of the doorbell BAR if a fixed size BAR is used
by the controller and uses the fixed size. In the commit message you are talking
about alignment and root complex writing to the BAR which are just confusing.

Please reword this commit message to make it understandable.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v1 to v2
>     - Remove unnessary set align when fix_bar_size.
> 
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 3f60128560ed0..ec3922f404efe 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -550,6 +550,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  
>  	barno = ntb->epf_ntb_bar[BAR_DB];
>  
> +	if (epc_features->bar_fixed_size[barno]) {
> +		if (size > epc_features->bar_fixed_size[barno]) {
> +			dev_err(dev, "Fixed BAR%d is too small for doorbell\n", barno);
> +			return -EINVAL;

-ENOMEM?

- Mani

> +		}
> +		size = epc_features->bar_fixed_size[barno];
> +	}
> +
>  	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
>  	if (!mw_addr) {
>  		dev_err(dev, "Failed to allocate OB address\n");
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

