Return-Path: <linux-pci+bounces-44253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F980D01019
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 05:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 761FB3010E47
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 04:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3BE299959;
	Thu,  8 Jan 2026 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGm10c/g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8C8F5B
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847786; cv=none; b=RfTbaL8eKAJYcEm4ZkIAT6MEpCzH49zMVADbD01pPbDkFRB/kJBIGMCP0jNrUPAhEjZhcsSR2ZeVknAfDTHIfIx3usAoaIv4EpaFVg97nN14mEtPaZaB8bFvWbqWsNgzWTagYdM+L9CF6ChS0yrKVb1EyzOJPdRwGEBbT3J23s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847786; c=relaxed/simple;
	bh=15m7K95zVoOdI/m4xKL5i8plPwLtD38rR5+qrxDhq/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYTX5dAeZheC43NyXixCBSBhM+VplZ3eblOfEoGfR18RXM+4bpq0X0WHuSIG6r+0SGpBMygYU77gKzFwkDTz0vSGBIFXePwYj8YKtO4epvdm0IuWlnfmotaJvr891FWSmdgbhL8yW84HNtd5+Pb9fkY6EfkKwNzK7K+41bw11qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGm10c/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3706C116C6;
	Thu,  8 Jan 2026 04:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767847785;
	bh=15m7K95zVoOdI/m4xKL5i8plPwLtD38rR5+qrxDhq/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGm10c/gNb0OYzzRbyO7cebiDz64r+pKHFY+ImqjqqSQOuVYpxq0AxB6ABScC7Axn
	 Nf6J7Gz7SyE0mXU2apE0jZblTYnKlKDvcDsj3tGEeVGdeRjHgQwNJf0sERcmvty3W7
	 qLP7yTYxV+NiS9udjsbxG+Mcr8sZpY0jFFW6DsYUCDbR9FGBdbbWaf99pUUuCEvbYB
	 eZzGhT92G2Se3UV3qRLNAKbpUck3XXVDojduwpBGVCg2s6S1v70fQq+dIQ7MK1ko/B
	 cd4anHLlRbTclSTVDoA87PBG3P9/Q46ujTyj4z5IaDNURl7nc5vmvJLtxbAA8R6zn9
	 Pt/aClxpYN/Jw==
Date: Thu, 8 Jan 2026 10:19:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
Message-ID: <lhshuxj4aztwbernypwgaxkdtxzonzydzipu63mspbqfygyrvy@nggpj7vwsw7n>
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
 <cudy2lfd7q7tujfivampgciziuho7izkpvmabj3qa2udvzkvfh@lw5vasqcrs6c>
 <2e1a3eff-5d4d-4e3a-a076-ef8a76e08d4c@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e1a3eff-5d4d-4e3a-a076-ef8a76e08d4c@rock-chips.com>

On Thu, Jan 08, 2026 at 09:01:43AM +0800, Shawn Lin wrote:
> 在 2026/01/07 星期三 20:41, Manivannan Sadhasivam 写道:
> > On Tue, Jan 06, 2026 at 05:18:38PM +0800, Shawn Lin wrote:
> > > Some platforms may provide LTSSM trace functionality, recording historical
> > > LTSSM state transition information. This is very useful for debugging, such
> > > as when certain devices cannot be recognized. Add an ltssm_trace operation
> > > node in debugfs for platform which could provide these information to show
> > > the LTSSM history.
> > > 
> > 
> > Why don't you implement it as a tracepoint since you want to expose traces?
> > 
> 
> I evaluated this option but didn't choose to do it just as I didn't
> want to select CONFIG_TRACING_SUPPORT for dwc driver because of this
> cheap function. But I'm fine to implement it as a tracepoint. Just to
> make it clear, if a tracepoint is preferred, should I need to create a new
> file like pcie-designware-trace?
> 

I would prefer that, because that will allow us to add more tracepoints in the
future and not muddle pcie-designware.h. General convention is to define
trace events in a separate header.

- Mani

> > - Mani
> > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > ---
> > >   .../controller/dwc/pcie-designware-debugfs.c  | 44 +++++++++++++++++++
> > >   drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
> > >   2 files changed, 50 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > > index df98fee69892..569e8e078ef2 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > > @@ -511,6 +511,38 @@ static int ltssm_status_open(struct inode *inode, struct file *file)
> > >   	return single_open(file, ltssm_status_show, inode->i_private);
> > >   }
> > > +static struct dw_pcie_ltssm_history *dw_pcie_ltssm_trace(struct dw_pcie *pci)
> > > +{
> > > +	if (pci->ops && pci->ops->ltssm_trace)
> > > +		return pci->ops->ltssm_trace(pci);
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +static int ltssm_trace_show(struct seq_file *s, void *v)
> > > +{
> > > +	struct dw_pcie *pci = s->private;
> > > +	struct dw_pcie_ltssm_history *history;
> > > +	enum dw_pcie_ltssm val;
> > > +	u32 loop;
> > > +
> > > +	history = dw_pcie_ltssm_trace(pci);
> > > +	if (!history)
> > > +		return 0;
> > > +
> > > +	for (loop = 0; loop < history->count; loop++) {
> > > +		val = history->states[loop];
> > > +		seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int ltssm_trace_open(struct inode *inode, struct file *file)
> > > +{
> > > +	return single_open(file, ltssm_trace_show, inode->i_private);
> > > +}
> > > +
> > >   #define dwc_debugfs_create(name)			\
> > >   debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
> > >   			&dbg_ ## name ## _fops)
> > > @@ -552,6 +584,11 @@ static const struct file_operations dwc_pcie_ltssm_status_ops = {
> > >   	.read = seq_read,
> > >   };
> > > +static const struct file_operations dwc_pcie_ltssm_trace_ops = {
> > > +	.open = ltssm_trace_open,
> > > +	.read = seq_read,
> > > +};
> > > +
> > >   static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
> > >   {
> > >   	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> > > @@ -644,6 +681,12 @@ static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> > >   			    &dwc_pcie_ltssm_status_ops);
> > >   }
> > > +static void dwc_pcie_ltssm_trace_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> > > +{
> > > +	debugfs_create_file("ltssm_trace", 0444, dir, pci,
> > > +			    &dwc_pcie_ltssm_trace_ops);
> > > +}
> > > +
> > >   static int dw_pcie_ptm_check_capability(void *drvdata)
> > >   {
> > >   	struct dw_pcie *pci = drvdata;
> > > @@ -922,6 +965,7 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode)
> > >   			err);
> > >   	dwc_pcie_ltssm_debugfs_init(pci, dir);
> > > +	dwc_pcie_ltssm_trace_debugfs_init(pci, dir);
> > >   	pci->mode = mode;
> > >   	pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 5cd27f5739f1..0df18995b7fe 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -395,6 +395,11 @@ enum dw_pcie_ltssm {
> > >   	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
> > >   };
> > > +struct dw_pcie_ltssm_history {
> > > +    enum dw_pcie_ltssm *states;
> > > +    u32 count;
> > > +};
> > > +
> > >   struct dw_pcie_ob_atu_cfg {
> > >   	int index;
> > >   	int type;
> > > @@ -499,6 +504,7 @@ struct dw_pcie_ops {
> > >   			      size_t size, u32 val);
> > >   	bool	(*link_up)(struct dw_pcie *pcie);
> > >   	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> > > +	struct dw_pcie_ltssm_history * (*ltssm_trace)(struct dw_pcie *pcie);
> > >   	int	(*start_link)(struct dw_pcie *pcie);
> > >   	void	(*stop_link)(struct dw_pcie *pcie);
> > >   	int	(*assert_perst)(struct dw_pcie *pcie, bool assert);
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

