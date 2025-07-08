Return-Path: <linux-pci+bounces-31699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC5AFD49F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4427B5916
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626A2E540D;
	Tue,  8 Jul 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd4AsNJE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906092E0405;
	Tue,  8 Jul 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994430; cv=none; b=KFoxBHjRF2ONZRmDQjLUfG/ldB7ZiLPx+GHodvzV/0kPJq0NW3CL7GHg62Kswh0r97pMRmpfLkGnj76HRTgQDnxP2Em5OKPXQa+zIx+4aI7BKm3tVpQPkaQO2WMlYrxJCBiNqD/CEvUdmMuzwVeqJMiaCXrKubN1sNpgqfTURbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994430; c=relaxed/simple;
	bh=SLCNrOS4z/xzHbaD6TvXdsc0ADaK5vVQhx8gd9FuP2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ4wOrQL1z17fAOCaR01HgcmVJMOGc9KIBWMOA19031kLnuL1/3g7+xdG29v7YIHJwLIA3mOTFatKQgiXqFjNVq7we+fRt/jcebNZp579dyRxkHsR8acJYzNMZHbzRI0U/STA7HzXWpr+Er7Qu7teiBOt+yPJJFI2S4/jnlB4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd4AsNJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792C6C4CEED;
	Tue,  8 Jul 2025 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751994430;
	bh=SLCNrOS4z/xzHbaD6TvXdsc0ADaK5vVQhx8gd9FuP2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fd4AsNJEMPLjTBKQ51r44TKkN4H0wAA4kJSHZvwWHvHxrNRezryTpyWQHWuRGFLZd
	 k5llaRIJW/QIGhXUz5T4vpWo2l0MN6n805s1OgcUdgt9BDPTiCxv8cKfxLPCYrsjGv
	 i5iE0yYgmqlP2ubdurgoAdKIKatXYpkOtEPDX4nwuxLYmf0BSQxFw9WoDDqI79BUKb
	 Z8D4lPaT1c/MAGSzO85MTVlSLqzcdg5LbFTYtJhC0Ru/9iROfu+MasklCMmwHCmnHR
	 z3S1/vHQ7fUf1nX9L9xP1XNqcqjs1fpZZFt0dcX5Xmii23+c+BjawN8Br5anf9+uLn
	 9OWlLP1wtHW0A==
Date: Tue, 8 Jul 2025 22:36:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 04/11] bus: mhi: host: Add support for Bandwidth scale
Message-ID: <j24c2ii33yivc7rb3vwbwljxwvhdpqwbfgt3gid2njma6t47i4@uhykehw23h2q>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-4-3faa8fe92b05@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-mhi_bw_up-v4-4-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:25PM GMT, Krishna Chaitanya Chundru wrote:
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
>  drivers/bus/mhi/common.h        | 13 ++++++
>  drivers/bus/mhi/host/init.c     | 63 +++++++++++++++++++++++++-
>  drivers/bus/mhi/host/internal.h |  7 ++-
>  drivers/bus/mhi/host/main.c     | 98 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/bus/mhi/host/pm.c       | 10 ++++-
>  include/linux/mhi.h             | 13 ++++++
>  6 files changed, 198 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index 58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd..6e342519d80b7725e9ef5390a3eb2a06ac69ceac 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -217,6 +217,19 @@ enum mhi_capability_type {
>  	MHI_CAP_ID_MAX,
>  };
>  
> +/* MHI Bandwidth scaling offsets */
> +#define MHI_BW_SCALE_CFG_OFFSET		0x4
> +#define MHI_BW_SCALE_CAP_ID		(3)
> +#define MHI_BW_SCALE_DB_CHAN_ID		GENMASK(31, 25)
> +#define MHI_BW_SCALE_ENABLED		BIT(24)
> +#define MHI_BW_SCALE_ER_INDEX		GENMASK(23, 19)
> +
> +#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	FIELD_GET(GENMASK(15, 8), (MHI_TRE_GET_DWORD(tre, 0)))
> +
> +#define MHI_BW_SCALE_RESULT(status, seq)	cpu_to_le32(FIELD_PREP(GENMASK(11, 8), status) | \
> +						FIELD_PREP(GENMASK(7, 0), seq))
> +#define MHI_BW_SCALE_NACK			0xF
> +
>  enum mhi_pkt_type {
>  	MHI_PKT_TYPE_INVALID = 0x0,
>  	MHI_PKT_TYPE_NOOP_CMD = 0x1,
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 9102ce13a2059f599b46d25ef631f643142642be..26703fea6272de7fd19c6ee76be067f0ff0fd309 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -501,10 +501,55 @@ static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability,
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
> +	u32 bw_cfg_offset, val;
> +	int ret, er_index;
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
> +	val = (__force u32)cpu_to_le32(FIELD_PREP(MHI_BW_SCALE_DB_CHAN_ID, bw_scale_db) |
> +				       FIELD_PREP(MHI_BW_SCALE_ER_INDEX, er_index) |
> +				       MHI_BW_SCALE_ENABLED);
> +

It is wrong to store the value of cpu_to_le32() in a non-le32 variable.
mhi_write_reg() accepts the 'val' in native endian. writel used in the
controller drivers should take care of converting to LE before writing to the
device.

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
> @@ -638,6 +683,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
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

That's it? And you would continue to setup doorbell setup later?

> +	}

nit: newline

>  	return 0;
>  }
>  
> @@ -783,6 +838,9 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
>  		case MHI_ER_CTRL:
>  			mhi_event->process_event = mhi_process_ctrl_ev_ring;
>  			break;
> +		case MHI_ER_BW_SCALE:
> +			mhi_event->process_event = mhi_process_bw_scale_ev_ring;
> +			break;
>  		default:
>  			dev_err(dev, "Event Ring type not supported\n");
>  			goto error_ev_cfg;
> @@ -1017,9 +1075,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
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

synchronization of what?

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

What does it mean?

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

Looks like mhi_device_get_sync() is going runtime_get()/runtime_put() inside
mhi_trigger_resume(). I'm wondering why that is necessary. 

> +	if (ret)
> +		goto exit_bw_scale;
> +
> +	mhi_cntrl->runtime_get(mhi_cntrl);
> +

Here, you want to resume the controller, which is fine.

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

Just return 'ret' directly.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

