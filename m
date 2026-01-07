Return-Path: <linux-pci+bounces-44183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312BACFDB93
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DA8B3014A13
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 12:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD1032BF2E;
	Wed,  7 Jan 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhAQaYUt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119532B9BE
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789623; cv=none; b=oRpCJRQHYRYC99apvsthFX3djCUcpuhLb4XKnt8+HX5OPk5NgjfbZHQCxpQrWq3wxN9NDBDmQG/h/oqa8rPYJ1DvpIk/3N4tsB4Qrsz338rVQPMLpib0mzpFrfrFZ8BKcmgxWNH172QZvXlZ4rfk9wStDmUJ2UqvtMIpOgeozh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789623; c=relaxed/simple;
	bh=rFaRUU7sgdH4A912E0IuUrnecnf1f4y0ae9YUO7iB4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khHqm6gmOBQT2jDSdw0yUdfSpOxP+/G6tMUoXefcNBKhLlef2kwXnA5My1BY1VyQo3s0LT+0sAeGaoDMoyhu0kkP49ZSfa4chPmtUobEPtLTSwc0/DR1Gwbjbq7/qwhBXDaVzrk83l3IxLd3qpEwPlAvLLTmSBQDnbg4crRHc8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhAQaYUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CC2C4CEF7;
	Wed,  7 Jan 2026 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767789620;
	bh=rFaRUU7sgdH4A912E0IuUrnecnf1f4y0ae9YUO7iB4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhAQaYUtNSFNzmmxJYqPcLTb4BB1Kr1TjvGf6xMizF+E7uqDc/aD4ZT8yUA4YRBQm
	 Q5C2SPxcu8ryPlaoPbxdnw6HDG9RSfbQeUJWcsNoOdc6haZg1SAVM4ksuHjDEGWjze
	 xx5OPwxy/9ifOSWpKE1jmoo61tnYzCUOar4zeg4t6iNgYDtQ8+txLYJ/1gXSbOBcR+
	 2Os76w+T6M3nkUIsJLDP7Ii8kSrHBos8160jV26i7pJFnslt1htnWjWBJFIOvitKXz
	 ogYG1Z6TF8OGEYdlbvm1l1g+HyEzF0iJ71xDXO9ITRE7iZQDc2YBshhgz0jUZeSe0g
	 Us0Oq5MrF+9xQ==
Date: Wed, 7 Jan 2026 18:10:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
Message-ID: <6x2ntul3sl6t46hnqcfmbhw4vpjzmp3yh2wikzvbkiqgvwktoe@4cqaavqiawl2>
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
 <8d4e73f5-b4da-4aca-a2b2-b607be8c245a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d4e73f5-b4da-4aca-a2b2-b607be8c245a@oss.qualcomm.com>

On Wed, Jan 07, 2026 at 02:42:38PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 1/6/2026 2:48 PM, Shawn Lin wrote:
> > Some platforms may provide LTSSM trace functionality, recording historical
> > LTSSM state transition information. This is very useful for debugging, such
> > as when certain devices cannot be recognized. Add an ltssm_trace operation
> > node in debugfs for platform which could provide these information to show
> > the LTSSM history.
> > 
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >   .../controller/dwc/pcie-designware-debugfs.c  | 44 +++++++++++++++++++
> >   drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
> >   2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > index df98fee69892..569e8e078ef2 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > @@ -511,6 +511,38 @@ static int ltssm_status_open(struct inode *inode, struct file *file)
> >   	return single_open(file, ltssm_status_show, inode->i_private);
> >   }
> > +static struct dw_pcie_ltssm_history *dw_pcie_ltssm_trace(struct dw_pcie *pci)
> > +{
> > +	if (pci->ops && pci->ops->ltssm_trace)
> > +		return pci->ops->ltssm_trace(pci);
> > +
> > +	return NULL;
> > +}
> > +
> > +static int ltssm_trace_show(struct seq_file *s, void *v)
> > +{
> > +	struct dw_pcie *pci = s->private;
> > +	struct dw_pcie_ltssm_history *history;
> > +	enum dw_pcie_ltssm val;
> > +	u32 loop;
> > +
> > +	history = dw_pcie_ltssm_trace(pci);
> > +	if (!history)
> > +		return 0;
> > +
> > +	for (loop = 0; loop < history->count; loop++) {
> > +		val = history->states[loop];
> > +		seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ltssm_trace_open(struct inode *inode, struct file *file)
> > +{
> > +	return single_open(file, ltssm_trace_show, inode->i_private);
> > +}
> > +
> >   #define dwc_debugfs_create(name)			\
> >   debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
> >   			&dbg_ ## name ## _fops)
> > @@ -552,6 +584,11 @@ static const struct file_operations dwc_pcie_ltssm_status_ops = {
> >   	.read = seq_read,
> >   };
> > +static const struct file_operations dwc_pcie_ltssm_trace_ops = {
> > +	.open = ltssm_trace_open,
> > +	.read = seq_read,
> > +};
> > +
> >   static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> >   {
> >   	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> > @@ -644,6 +681,12 @@ static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> >   			    &dwc_pcie_ltssm_status_ops);
> >   }
> > +static void dwc_pcie_ltssm_trace_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> > +{
> > +	debugfs_create_file("ltssm_trace", 0444, dir, pci,
> > +			    &dwc_pcie_ltssm_trace_ops);
> Can we have this as the sysfs, so that if there is some issue in production
> devices where debugfs is not available,
> we can use this to see LTSSM state figure out the issue.

'figure out' means 'debug'. If you want to debug an issue, you need to enable
debugfs. You should not introduce random sysfs ABI for debug interfaces.

- Mani

> 
> - Krishna Chaitanya.
> > +}
> > +
> >   static int dw_pcie_ptm_check_capability(void *drvdata)
> >   {
> >   	struct dw_pcie *pci = drvdata;
> > @@ -922,6 +965,7 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode)
> >   			err);
> >   	dwc_pcie_ltssm_debugfs_init(pci, dir);
> > +	dwc_pcie_ltssm_trace_debugfs_init(pci, dir);
> >   	pci->mode = mode;
> >   	pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 5cd27f5739f1..0df18995b7fe 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -395,6 +395,11 @@ enum dw_pcie_ltssm {
> >   	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
> >   };
> > +struct dw_pcie_ltssm_history {
> > +    enum dw_pcie_ltssm *states;
> > +    u32 count;
> > +};
> > +
> >   struct dw_pcie_ob_atu_cfg {
> >   	int index;
> >   	int type;
> > @@ -499,6 +504,7 @@ struct dw_pcie_ops {
> >   			      size_t size, u32 val);
> >   	bool	(*link_up)(struct dw_pcie *pcie);
> >   	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> > +	struct dw_pcie_ltssm_history * (*ltssm_trace)(struct dw_pcie *pcie);
> >   	int	(*start_link)(struct dw_pcie *pcie);
> >   	void	(*stop_link)(struct dw_pcie *pcie);
> >   	int	(*assert_perst)(struct dw_pcie *pcie, bool assert);
> 

-- 
மணிவண்ணன் சதாசிவம்

