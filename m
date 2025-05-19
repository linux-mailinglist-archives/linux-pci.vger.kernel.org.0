Return-Path: <linux-pci+bounces-27979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFEAABBFD9
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 15:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658E67A660B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD14284B3C;
	Mon, 19 May 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/ZdRvJe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08D28468E;
	Mon, 19 May 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662549; cv=none; b=gBW291h2Iu8LKiNyKkWWUDY2mz9uiGQuGzeqzrByL74nHn3lks7FQZvDEm4ZKWoqFO5siXqCY5g4xlLBsnSKVuVjsQzwHhqTrK0v9OGwaiIlNoBR3trEx1X7l7G+ZQ/qMu7GFCU1i3cGM21gJqofZ/Sz0W+mj69FbxnrBECBSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662549; c=relaxed/simple;
	bh=3Y9vgZxUkqCQy/C5E7UaFN+86AiBh9q4BHIvaPaSCI4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q6AMr37nOB8UGs1YFmWXt05Wzx2iKlulqbGMBYBr36RXbipqUQLyoGGu+zAAh6KEEWPXlwr2VpCCL38N3/cVLnKaZmtpy1uG887Zl1s59wgw6/P/DtLskLQXYVrCZn28X0Zzx1EkmS5V1cm6fuR1lUyokVom9k+xLOPZnQp+XhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/ZdRvJe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747662548; x=1779198548;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3Y9vgZxUkqCQy/C5E7UaFN+86AiBh9q4BHIvaPaSCI4=;
  b=f/ZdRvJevqo0WQ+0q517kFdCz5OVm2r9lXtw61gPCASk/JP/1slKMovT
   T9JoPjs5+FdKDUvSICDClPs7DFpZk28MtRxRlBmnt8bYIwubSddzMTbG/
   oha4LEGDDNbFvFb5mXuowuT95j2UWMNHhdClsBB4585bNE0NUCIny9XeC
   LDqUKyLJm4+m1zqx6436ZpK1QqP5w1f1PFgyi5Yxx2KW9eJP11X4Qdlsg
   +nLCqBKwQDOccz+aQiHi4md8CCGAi4zptrc2rlKXCIoyM7L/fS+3PTdLl
   p2BozTlR3ihJyAjZyam6j4NyTTqIY9wALtCigFfMPmpEe99iYsqe07JjX
   A==;
X-CSE-ConnectionGUID: vJZVnxezTLOGEG98QKd6UQ==
X-CSE-MsgGUID: oSJhs6YaSXSchn5bMNTsaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48816176"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="48816176"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:49:06 -0700
X-CSE-ConnectionGUID: 9k6r2Pg+TD6HcGA5O6HG8w==
X-CSE-MsgGUID: OMEVtZL5SI2D4hu/XakykA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="140265633"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:48:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 May 2025 16:48:56 +0300 (EEST)
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
    Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
    qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
    Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3 08/11] bus: mhi: host: Add support for Bandwidth
 scale
In-Reply-To: <20250519-mhi_bw_up-v3-8-3acd4a17bbb5@oss.qualcomm.com>
Message-ID: <9ff58fd9-4a8e-a752-ef28-491102d13ff3@linux.intel.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com> <20250519-mhi_bw_up-v3-8-3acd4a17bbb5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 May 2025, Krishna Chaitanya Chundru wrote:

> As per MHI spec v1.2, sec 14, MHI supports bandwidth scaling to reduce
> power consumption. MHI bandwidth scaling is advertised by devices that
> contain the bandwidth scaling capability registers. If enabled, the device
> aggregates bandwidth requirements and sends them to the host through
> dedicated mhi event ring. After the host performs the bandwidth switch,
> it sends an acknowledgment by ringing a doorbell.
> 
> if the host supports bandwidth scaling events, then it must set
> BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
> doorbell that will be used by the host to communicate the bandwidth
> scaling status and BW_CFG.ER_INDEX to the index for the event ring
> to which the device should send bandwidth scaling request in the
> bandwidth scaling capability register.
> 
> As part of mmio init check if the bw scale capability is present or not,
> if present advertise host supports bw scale by setting all the required
> fields.
> 
> MHI layer will only forward the bw scaling request to the controller
> driver since MHI doesn't have any idea about transport layer used by
> the controller, it is responsibility of the controller driver to do actual
> bw scaling and then pass status to the MHI. MHI will response back to the
> device based up on the status of the bw scale received.
> 
> Add a new get_misc_doorbell() to get doorbell for misc capabilities to
> use the doorbell with mhi events like MHI BW scale etc.
> 
> Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
> which will called by the mhi controller driver can sleep.
> 
> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/bus/mhi/common.h        | 16 +++++++
>  drivers/bus/mhi/host/init.c     | 61 ++++++++++++++++++++++++-
>  drivers/bus/mhi/host/internal.h |  7 ++-
>  drivers/bus/mhi/host/main.c     | 98 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/bus/mhi/host/pm.c       | 10 ++++-
>  include/linux/mhi.h             | 13 ++++++
>  6 files changed, 199 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index eedac801b80021e44f7c65d33cd50760e06c02f2..0a02acee709af7a2a6abddcb9547ef56564ce453 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -208,6 +208,22 @@
>  #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
>  							       MHI_PKT_TYPE_COALESCING))
>  
> +/* MHI Bandwidth scaling offsets */
> +#define MHI_BW_SCALE_CFG_OFFSET		0x4
> +#define MHI_BW_SCALE_CAP_ID		(3)
> +
> +#define MHI_BW_SCALE_ENABLE(bw_scale_db, er_index)	cpu_to_le32(FIELD_PREP(GENMASK(31, 25), \
> +							bw_scale_db) |				\
> +							FIELD_PREP(GENMASK(23, 19), er_index) |	\
> +							BIT(24))

This code would be easier to understand if you would name those 
GENMASK()s and BIT() with defines first.

Why does this have to be a macro?

These are also hard to read when they're misindented like that.

> +#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	FIELD_GET(GENMASK(15, 8), (MHI_TRE_GET_DWORD(tre, 0)))
> +#define MHI_BW_SCALE_DB_ID(er_index)	FIELD_PREP(GENMASK(31, 25), er_index)
> +
> +#define MHI_BW_SCALE_RESULT(status, seq)	cpu_to_le32(FIELD_PREP(GENMASK(11, 8), status) | \
> +						FIELD_PREP(GENMASK(7, 0), seq))
> +#define MHI_BW_SCALE_NACK			0xF
> +
>  enum mhi_pkt_type {
>  	MHI_PKT_TYPE_INVALID = 0x0,
>  	MHI_PKT_TYPE_NOOP_CMD = 0x1,
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index a7137a040bdce1c58c98fe9c2340aae4cc4387d1..9fe6020f7868ec8bd114d0d96edc9d17624cbac5 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -496,10 +496,53 @@ static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability,
>  	return -ENXIO;
>  }
>  
> +static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
> +			    enum mhi_er_data_type type)
> +{
> +	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
> +	int i;
> +
> +	/* Find event ring for requested type */
> +	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
> +		if (mhi_event->data_type == type)
> +			return mhi_event->er_index;
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl,
> +			     int bw_scale_db)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	int ret, er_index, val;
> +	u32 bw_cfg_offset;
> +
> +	ret = mhi_find_capability(mhi_cntrl, MHI_BW_SCALE_CAP_ID, &bw_cfg_offset);
> +	if (ret)
> +		return ret;
> +
> +	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
> +	if (er_index < 0)
> +		return er_index;
> +
> +	bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
> +
> +	/* Advertise host support */
> +	val = MHI_BW_SCALE_ENABLE(bw_scale_db, er_index);
> +
> +	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
> +
> +	dev_dbg(dev, "Bandwidth scaling setup complete with event ring: %d\n",
> +		er_index);
> +
> +	return 0;
> +}
> +
>  int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  {
>  	u32 val;
> -	int i, ret;
> +	int i, ret, doorbell = 0;
>  	struct mhi_chan *mhi_chan;
>  	struct mhi_event *mhi_event;
>  	void __iomem *base = mhi_cntrl->regs;
> @@ -633,6 +676,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  		return ret;
>  	}
>  
> +	if (mhi_cntrl->get_misc_doorbell)
> +		doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, MHI_ER_BW_SCALE);
> +
> +	if (doorbell > 0) {
> +		ret = mhi_init_bw_scale(mhi_cntrl, doorbell);
> +		if (!ret)
> +			mhi_cntrl->bw_scale_db = base + val + (8 * doorbell);
> +		else
> +			dev_warn(dev, "Failed to setup bandwidth scaling: %d\n", ret);
> +	}
>  	return 0;
>  }
>  
> @@ -778,6 +831,9 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
>  		case MHI_ER_CTRL:
>  			mhi_event->process_event = mhi_process_ctrl_ev_ring;
>  			break;
> +		case MHI_ER_BW_SCALE:
> +			mhi_event->process_event = mhi_process_bw_scale_ev_ring;
> +			break;
>  		default:
>  			dev_err(dev, "Event Ring type not supported\n");
>  			goto error_ev_cfg;
> @@ -1012,9 +1068,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  
>  		mhi_event->mhi_cntrl = mhi_cntrl;
>  		spin_lock_init(&mhi_event->lock);
> +		mutex_init(&mhi_event->mutex);
>  		if (mhi_event->data_type == MHI_ER_CTRL)
>  			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
>  				     (ulong)mhi_event);
> +		else if (mhi_event->data_type == MHI_ER_BW_SCALE)
> +			INIT_WORK(&mhi_event->work, mhi_process_ev_work);
>  		else
>  			tasklet_init(&mhi_event->task, mhi_ev_task,
>  				     (ulong)mhi_event);
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index ce566f7d2e9240c64044407aa4124ad3cdb98003..cf64adaecad2aeec8569da5276ec60dd7e97e5e0 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -248,6 +248,8 @@ struct mhi_event {
>  	struct mhi_ring ring;
>  	struct db_cfg db_cfg;
>  	struct tasklet_struct task;
> +	struct work_struct work;
> +	struct mutex mutex; /* lock for synchronization */
>  	spinlock_t lock;
>  	int (*process_event)(struct mhi_controller *mhi_cntrl,
>  			     struct mhi_event *mhi_event,
> @@ -410,7 +412,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  				struct mhi_event *mhi_event, u32 event_quota);
>  int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>  			     struct mhi_event *mhi_event, u32 event_quota);
> -
> +int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
> +				 struct mhi_event *mhi_event, u32 event_quota);
>  /* ISR handlers */
>  irqreturn_t mhi_irq_handler(int irq_number, void *dev);
>  irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
> @@ -426,5 +429,5 @@ void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
>  			    struct mhi_buf_info *buf_info);
>  void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
>  			     struct mhi_buf_info *buf_info);
> -
> +void mhi_process_ev_work(struct work_struct *work);
>  #endif /* _MHI_INT_H */
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 9bb0df43ceef1e54e8817422516aab1def6fdc4a..f87e9550b59227947fc7268c5799eea274c66b98 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -472,7 +472,10 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>  		if (mhi_dev)
>  			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
>  	} else {
> -		tasklet_schedule(&mhi_event->task);
> +		if (mhi_event->data_type == MHI_ER_BW_SCALE)
> +			queue_work(mhi_cntrl->hiprio_wq, &mhi_event->work);
> +		else
> +			tasklet_schedule(&mhi_event->task);
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -1049,6 +1052,99 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>  	return count;
>  }
>  
> +int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
> +				 struct mhi_event *mhi_event, u32 event_quota)
> +{
> +	struct mhi_event_ctxt *er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ring *ev_ring = &mhi_event->ring;
> +	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
> +	u32 response = MHI_BW_SCALE_NACK;
> +	struct mhi_ring_element *dev_rp;
> +	struct mhi_link_info link_info;
> +	int ret = -EINVAL;
> +
> +	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state))) {
> +		ret =  -EIO;
> +		goto exit_bw_scale;
> +	}
> +
> +	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
> +		goto exit_bw_scale;
> +
> +	if (!is_valid_ring_ptr(ev_ring, ptr)) {
> +		dev_err(dev,
> +			"Event ring rp points outside of the event ring\n");
> +		ret =  -EIO;
> +		goto exit_bw_scale;
> +	}
> +
> +	dev_rp = mhi_to_virtual(ev_ring, ptr);
> +
> +	/* If rp points to base, we need to wrap it around */
> +	if (dev_rp == ev_ring->base)
> +		dev_rp = ev_ring->base + ev_ring->len;
> +	dev_rp--;
> +
> +	/* Fast forward to currently processed element and recycle er */
> +	ev_ring->rp = dev_rp;
> +	ev_ring->wp = dev_rp - 1;
> +	if (ev_ring->wp < ev_ring->base)
> +		ev_ring->wp = ev_ring->base + ev_ring->len - ev_ring->el_size;
> +	mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
> +
> +	if (WARN_ON(MHI_TRE_GET_EV_TYPE(dev_rp) != MHI_PKT_TYPE_BW_REQ_EVENT)) {
> +		dev_err(dev, "!BW SCALE REQ event\n");
> +		goto exit_bw_scale;
> +	}
> +
> +	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
> +	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
> +	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
> +
> +	dev_dbg(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
> +		link_info.sequence_num,
> +		link_info.target_link_speed,
> +		link_info.target_link_width);
> +
> +	/* Bring host and device out of suspended states */
> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> +	if (ret)
> +		goto exit_bw_scale;
> +
> +	mhi_cntrl->runtime_get(mhi_cntrl);
> +
> +	ret = mhi_cntrl->bw_scale(mhi_cntrl, &link_info);
> +	if (!ret)
> +		response = 0;
> +
> +	response = MHI_BW_SCALE_RESULT(response, link_info.sequence_num);
> +
> +	write_lock_bh(&mhi_cntrl->pm_lock);
> +	mhi_write_reg(mhi_cntrl, mhi_cntrl->bw_scale_db, 0, response);
> +	write_unlock_bh(&mhi_cntrl->pm_lock);
> +
> +	mhi_cntrl->runtime_put(mhi_cntrl);
> +	mhi_device_put(mhi_cntrl->mhi_dev);
> +
> +exit_bw_scale:
> +	return ret;
> +}
> +
> +void mhi_process_ev_work(struct work_struct *work)
> +{
> +	struct mhi_event *mhi_event = container_of(work, struct mhi_event,
> +						   work);
> +
> +	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
> +
> +	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
> +		return;
> +
> +	guard(mutex)(&mhi_event->mutex);
> +	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
> +}
> +
>  void mhi_ev_task(unsigned long data)
>  {
>  	struct mhi_event *mhi_event = (struct mhi_event *)data;
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 2fb27e6f8f88ebc701dad56dd60844d8470dd418..8b518da4995d83a299f419908b3753e6b78c8803 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -523,7 +523,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
>  		if (mhi_event->offload_ev)
>  			continue;
>  		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
> -		tasklet_kill(&mhi_event->task);
> +		if (mhi_event->data_type == MHI_ER_BW_SCALE)
> +			cancel_work_sync(&mhi_event->work);
> +		else
> +			tasklet_kill(&mhi_event->task);
>  	}
>  
>  	/* Release lock and wait for all pending threads to complete */
> @@ -670,7 +673,10 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
>  	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>  		if (mhi_event->offload_ev)
>  			continue;
> -		tasklet_kill(&mhi_event->task);
> +		if (mhi_event->data_type == MHI_ER_BW_SCALE)
> +			cancel_work_sync(&mhi_event->work);
> +		else
> +			tasklet_kill(&mhi_event->task);
>  	}
>  
>  	/* Release lock and wait for all pending threads to complete */
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index dd372b0123a6da5107b807ff8fe940c567eb2030..2041bbb2e2396eb2e19e6bc0a5e981aa2917ebdd 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -102,10 +102,12 @@ struct image_info {
>   * struct mhi_link_info - BW requirement
>   * target_link_speed - Link speed as defined by TLS bits in LinkControl reg
>   * target_link_width - Link width as defined by NLW bits in LinkStatus reg
> + * sequence_num - used by device to track bw requests sent to host
>   */
>  struct mhi_link_info {
>  	unsigned int target_link_speed;
>  	unsigned int target_link_width;
> +	int sequence_num;
>  };
>  
>  /**
> @@ -183,10 +185,12 @@ enum mhi_ch_ee_mask {
>   * enum mhi_er_data_type - Event ring data types
>   * @MHI_ER_DATA: Only client data over this ring
>   * @MHI_ER_CTRL: MHI control data and client data
> + * @MHI_ER_BW_SCALE: MHI controller bandwidth scale functionality
>   */
>  enum mhi_er_data_type {
>  	MHI_ER_DATA,
>  	MHI_ER_CTRL,
> +	MHI_ER_BW_SCALE,
>  };
>  
>  /**
> @@ -299,6 +303,7 @@ struct mhi_controller_config {
>   * @bhi: Points to base of MHI BHI register space
>   * @bhie: Points to base of MHI BHIe register space
>   * @wake_db: MHI WAKE doorbell register address
> + * @wake_db: MHI BW_SCALE doorbell register address
>   * @iova_start: IOMMU starting address for data (required)
>   * @iova_stop: IOMMU stop address for data (required)
>   * @fw_image: Firmware image name for normal booting (optional)
> @@ -355,6 +360,8 @@ struct mhi_controller_config {
>   * @write_reg: Write a MHI register via the physical link (required)
>   * @reset: Controller specific reset function (optional)
>   * @edl_trigger: CB function to trigger EDL mode (optional)
> + * @get_misc_doobell: function to get doorbell used for MISC feature like BW scale etc (optional)
> + * @bw_scale: CB function for passing BW scale info (optional)
>   * @buffer_len: Bounce buffer length
>   * @index: Index of the MHI controller instance
>   * @bounce_buf: Use of bounce buffer
> @@ -376,6 +383,7 @@ struct mhi_controller {
>  	void __iomem *bhi;
>  	void __iomem *bhie;
>  	void __iomem *wake_db;
> +	void __iomem *bw_scale_db;
>  
>  	dma_addr_t iova_start;
>  	dma_addr_t iova_stop;
> @@ -440,6 +448,11 @@ struct mhi_controller {
>  	void (*reset)(struct mhi_controller *mhi_cntrl);
>  	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
>  
> +	int (*get_misc_doorbell)(struct mhi_controller *mhi_cntrl,
> +				 enum mhi_er_data_type type);
> +	int (*bw_scale)(struct mhi_controller *mhi_cntrl,
> +			struct mhi_link_info *link_info);
> +
>  	size_t buffer_len;
>  	int index;
>  	bool bounce_buf;
> 
> 

-- 
 i.


