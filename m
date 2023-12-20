Return-Path: <linux-pci+bounces-1227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCBA81A682
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 18:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0A21C2599F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA3547A7F;
	Wed, 20 Dec 2023 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe3lnkV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16847A59;
	Wed, 20 Dec 2023 17:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD52EC433C8;
	Wed, 20 Dec 2023 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703094088;
	bh=5Xlp1kmL+9sf60Znhi3G0Telb2yFxg4srnBL7eqxQlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qe3lnkV8jEdZPfS35OjakjvYfLPOpFIq+g28CkASCttzL9dP50Z/103JkbGAIN9vs
	 jjqZnyO8vJNnUJqqwhRnSSVwQ6TPap93rG0Y0/BqBg4CQKaTVLQgP4K8ZO1V9jRo9+
	 zSMIINkQFzyxXPB9Hmza+D+DIJYU/RQ9phTRbsy1X7gYGvHB7aoug0nVwT/ioWm/Ms
	 pkrdu2IHSp1/kwogxEJxfHGEaNcFm3Ur/utp9H1OQQa+rmOZwo4+4rwKEZecjN7GqH
	 PbRl1s+ooAUPRgQrWQODSHjmPfkGyfS+zP3W699wG5k5xoLfrdYCbjTUDkBuaQVZC1
	 NdayTWTfn48Iw==
Date: Wed, 20 Dec 2023 23:11:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
	imx@lists.linux.dev, jdmason@kudzu.us, kishon@kernel.org,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer fail
 when BAR1 is fixed size
Message-ID: <20231220174113.GO3544@thinkpad>
References: <20231219142403.1223873-1-Frank.Li@nxp.com>
 <20231220142736.GE3544@thinkpad>
 <ZYMVMo3TVPMiEN/L@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYMVMo3TVPMiEN/L@lizhi-Precision-Tower-5810>

On Wed, Dec 20, 2023 at 11:24:18AM -0500, Frank Li wrote:
> On Wed, Dec 20, 2023 at 07:57:36PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Dec 19, 2023 at 09:24:03AM -0500, Frank Li wrote:
> > > ntb_netdev transfer is failing when epc controller's BAR1 is fix size, such
> > > as 64K. Certain controller(like dwc) require memory address must be align
> > > with the fixed bar size.
> > > 
> > > For example:
> > > 	If BAR1's fix size is 64K, and other size programmable BAR's
> > > alignment is 4K.
> > > 	vntb call pci_epf_alloc_space() get 4K aligned address, like
> > > 0x104E31000. But root complex actually write to address 0x104E30000 when
> > > write BAR1.
> > > 
> > > Adds bar_fixed_size check and sets correct alignment for fixed-size BAR.
> > > 
> > 
> > Change looks fine by me, but I have a hard time understanding this commit
> > message.
> > 
> > The change just checks the size of the doorbell BAR if a fixed size BAR is used
> > by the controller and uses the fixed size. In the commit message you are talking
> > about alignment and root complex writing to the BAR which are just confusing.
> > 
> > Please reword this commit message to make it understandable.
> 
> Maybe I talk about too much about it. Actually, supposed it should  work if
> use fixed-size bar(64K), which actually only mapped 4k, if RC only use 4k
> also.
> 
> "copy from dwc spec"
> 
> But dwc iATU IATU_LWR_TARGET_ADDR_OFF_INBOUND_0
> 11-0
> LWR_TARGET_HW
> Forms the LSB's of the Lower Target part of the new address of the translated region.
> Forms the LSB's of the Lower Target part of the new address of the translated region. The start address must be aligned to a CX_ATU_MIN_REGION_SIZE kB boundary (in address match mode); and to the Bar size boundary (in BAR match mode) so that these bits are always '0'. If the BAR is smaller than the iATU region size, then the iATU target address must align to the iATU region size; otherwise it must align to the BAR size.
> A write to this location is ignored by the PCIe controller.
> - Field size depends on log2(CX_ATU_MIN_REGION_SIZE) in address match mode.
> - Field size depends on log2(BAR_MASK+1) in BAR match mode.
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> For fixed size bar, BAR_MASK is fixed value. If pass down a 4k aligned
> address to iATU for 64K fixed sized bar, some address bits will be
> truncated. 
> 

Okay, now I understood the issue, thanks.

But this issue can happen for other BARs also, right. Since you encountered the
issue with DB BAR, it doesn't mean that the issue won't happen with other BARs.
So you need to have this check in place for all the used BARs.

> Hidden some hardware detail, do you think if it is enough?
> 
> "ntb_netdev transfer is failing when epc controller's BAR1 is fix size.
> Adds bar_fixed_size check. If require memory bigger than BAR1's fixed size,
> return -ENOMEM. If smaller than BAR1's fixed size, use BAR1's fixed size."
> 

How about,

"PCI: endpoint: pci-epf-vntb: Fix transfer failure for fixed size BARs

For the inbound MEM/IO TLPs, iATU on the endpoint expects the target address to
be aligned to the size of the BAR. For configurable BARs, there is no issue
because both host and endpoint will know the exact size of the BAR region. But
for fixed size BARs available in some controllers, if the BAR size advertised by
the endpoint is not same as of the actual BAR size used in the controller, then
the MEM/IO TLPs generated by the host will not be translated properly by the
endpoint iATU.

So if the fixed size BARs are available in endpoint controllers, always use the
actual BAR size."

Also, add the Fixes tag and CC stable list since this is a bug.

- Mani

> Frank
> 
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >     Change from v1 to v2
> > >     - Remove unnessary set align when fix_bar_size.
> > > 
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 3f60128560ed0..ec3922f404efe 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -550,6 +550,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
> > >  
> > >  	barno = ntb->epf_ntb_bar[BAR_DB];
> > >  
> > > +	if (epc_features->bar_fixed_size[barno]) {
> > > +		if (size > epc_features->bar_fixed_size[barno]) {
> > > +			dev_err(dev, "Fixed BAR%d is too small for doorbell\n", barno);
> > > +			return -EINVAL;
> > 
> > -ENOMEM?
> > 
> > - Mani
> > 
> > > +		}
> > > +		size = epc_features->bar_fixed_size[barno];
> > > +	}
> > > +
> > >  	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
> > >  	if (!mw_addr) {
> > >  		dev_err(dev, "Failed to allocate OB address\n");
> > > -- 
> > > 2.34.1
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

