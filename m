Return-Path: <linux-pci+bounces-31903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF60B0124E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 06:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A152D16BDEB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 04:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB301C5F06;
	Fri, 11 Jul 2025 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPMc6wqM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130641C4A20;
	Fri, 11 Jul 2025 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208401; cv=none; b=TmmALwdcxlZScuuETaDyJFcgu5BDM1flpG244tiS95XZpyBSiVYZUJydVQI+ae/SRTbRL3+Gjfhf8bQnSwOXG1Sqz4CEW8J2+KmKb/AQLlxvbtIB3ThOcIL7WDDdN0njvHQYb6IEXwoWIIBTo8AiUCCBAnX4rW3nCPcHBpcTqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208401; c=relaxed/simple;
	bh=ADUlxN5vRAMoH+bUBIPnCkxN+wm8oydTF3zMTV6RCPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgElQpdl3O+JDLZnyoo5W+CQ0mq07eCsDDCgWL/mHIlQpqOVeT2gs47HpIBriAvMONSZbZzOWLC9+xaHBvQLJVHuPQI/urP87ZPbKToY2EG3TmvG3NsVGTJPASggu82ONGlQwtTtHDd/695/520rGfWAkHf8hKIv9MUtcDm7Iro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPMc6wqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6A1C4CEEF;
	Fri, 11 Jul 2025 04:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752208400;
	bh=ADUlxN5vRAMoH+bUBIPnCkxN+wm8oydTF3zMTV6RCPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPMc6wqMegydFdHC/efGONuSfXTyZbe5tsXbIroa82StpgKDbEvJPuj48tapBwPyf
	 EtVHrya8nElzNy0urWzuc6uc3+P/BhYhyllSsJwAlWh7lYs5nCg3PCVMoSGtmE4eHa
	 IMX942N7HcpHaEDvKk/pcHyxWkS1lUIozmVu6pPPyubGupM4QuWOeg3fVzOPXb5Z4h
	 SrGb9KgLIy6SLPmYDVt0CEvM6cQ1M97xX5zkwXVewuH3ePmqmSFbhBCz4+5V2E/5j0
	 ZGDphlx7xrl9wUIVzNALWHUi/AasvWNt1O4R7Oz1o3rxk3Gy07+Zd4C10f5VgqL7ur
	 LWVdCR8rbYDhQ==
Date: Fri, 11 Jul 2025 10:03:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com, 
	quic_mrana@quicinc.com
Subject: Re: [PATCH v4 04/11] bus: mhi: host: Add support for Bandwidth scale
Message-ID: <eg2v3kctnztxcaulffu7tvysljimmyhnramyjj5gpa4vrv3yxu@g3pgwpwx37iq>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-4-3faa8fe92b05@qti.qualcomm.com>
 <j24c2ii33yivc7rb3vwbwljxwvhdpqwbfgt3gid2njma6t47i4@uhykehw23h2q>
 <31c192f7-cd69-46ad-9443-5d57ae2aa86e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31c192f7-cd69-46ad-9443-5d57ae2aa86e@oss.qualcomm.com>

On Wed, Jul 09, 2025 at 05:51:34PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/8/2025 10:36 PM, Manivannan Sadhasivam wrote:
> > On Mon, Jun 09, 2025 at 04:21:25PM GMT, Krishna Chaitanya Chundru wrote:
> > > As per MHI spec v1.2, sec 14, MHI supports bandwidth scaling to reduce
> > > power consumption. MHI bandwidth scaling is advertised by devices that
> > > contain the bandwidth scaling capability registers. If enabled, the device
> > > aggregates bandwidth requirements and sends them to the host through
> > > dedicated mhi event ring. After the host performs the bandwidth switch,
> > > it sends an acknowledgment by ringing a doorbell.
> > > 
> > > if the host supports bandwidth scaling events, then it must set
> > > BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
> > > doorbell that will be used by the host to communicate the bandwidth
> > > scaling status and BW_CFG.ER_INDEX to the index for the event ring
> > > to which the device should send bandwidth scaling request in the
> > > bandwidth scaling capability register.
> > > 
> > > As part of mmio init check if the bw scale capability is present or not,
> > > if present advertise host supports bw scale by setting all the required
> > > fields.
> > > 
> > > MHI layer will only forward the bw scaling request to the controller
> > > driver since MHI doesn't have any idea about transport layer used by
> > > the controller, it is responsibility of the controller driver to do actual
> > > bw scaling and then pass status to the MHI. MHI will response back to the
> > > device based up on the status of the bw scale received.
> > > 
> > > Add a new get_misc_doorbell() to get doorbell for misc capabilities to
> > > use the doorbell with mhi events like MHI BW scale etc.
> > > 
> > > Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
> > > which will called by the mhi controller driver can sleep.
> > > 
> > > Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >   drivers/bus/mhi/common.h        | 13 ++++++
> > >   drivers/bus/mhi/host/init.c     | 63 +++++++++++++++++++++++++-
> > >   drivers/bus/mhi/host/internal.h |  7 ++-
> > >   drivers/bus/mhi/host/main.c     | 98 ++++++++++++++++++++++++++++++++++++++++-
> > >   drivers/bus/mhi/host/pm.c       | 10 ++++-
> > >   include/linux/mhi.h             | 13 ++++++
> > >   6 files changed, 198 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> > > index 58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd..6e342519d80b7725e9ef5390a3eb2a06ac69ceac 100644
> > > --- a/drivers/bus/mhi/common.h
> > > +++ b/drivers/bus/mhi/common.h
> > > @@ -217,6 +217,19 @@ enum mhi_capability_type {
> > >   	MHI_CAP_ID_MAX,
> > >   };
> > > +/* MHI Bandwidth scaling offsets */
> > > +#define MHI_BW_SCALE_CFG_OFFSET		0x4
> > > +#define MHI_BW_SCALE_CAP_ID		(3)
> > > +#define MHI_BW_SCALE_DB_CHAN_ID		GENMASK(31, 25)
> > > +#define MHI_BW_SCALE_ENABLED		BIT(24)
> > > +#define MHI_BW_SCALE_ER_INDEX		GENMASK(23, 19)
> > > +
> > > +#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	FIELD_GET(GENMASK(15, 8), (MHI_TRE_GET_DWORD(tre, 0)))
> > > +
> > > +#define MHI_BW_SCALE_RESULT(status, seq)	cpu_to_le32(FIELD_PREP(GENMASK(11, 8), status) | \
> > > +						FIELD_PREP(GENMASK(7, 0), seq))
> > > +#define MHI_BW_SCALE_NACK			0xF
> > > +
> > >   enum mhi_pkt_type {
> > >   	MHI_PKT_TYPE_INVALID = 0x0,
> > >   	MHI_PKT_TYPE_NOOP_CMD = 0x1,
> > > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > > index 9102ce13a2059f599b46d25ef631f643142642be..26703fea6272de7fd19c6ee76be067f0ff0fd309 100644
> > > --- a/drivers/bus/mhi/host/init.c
> > > +++ b/drivers/bus/mhi/host/init.c
> > > @@ -501,10 +501,55 @@ static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability,
> > >   	return -ENXIO;
> > >   }
> > > +static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
> > > +			    enum mhi_er_data_type type)
> > > +{
> > > +	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
> > > +	int i;
> > > +
> > > +	/* Find event ring for requested type */
> > > +	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
> > > +		if (mhi_event->data_type == type)
> > > +			return mhi_event->er_index;
> > > +	}
> > > +
> > > +	return -ENOENT;
> > > +}
> > > +
> > > +static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl,
> > > +			     int bw_scale_db)
> > > +{
> > > +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> > > +	u32 bw_cfg_offset, val;
> > > +	int ret, er_index;
> > > +
> > > +	ret = mhi_find_capability(mhi_cntrl, MHI_BW_SCALE_CAP_ID, &bw_cfg_offset);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
> > > +	if (er_index < 0)
> > > +		return er_index;
> > > +
> > > +	bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
> > > +
> > > +	/* Advertise host support */
> > > +	val = (__force u32)cpu_to_le32(FIELD_PREP(MHI_BW_SCALE_DB_CHAN_ID, bw_scale_db) |
> > > +				       FIELD_PREP(MHI_BW_SCALE_ER_INDEX, er_index) |
> > > +				       MHI_BW_SCALE_ENABLED);
> > > +
> > 
> > It is wrong to store the value of cpu_to_le32() in a non-le32 variable.
> > mhi_write_reg() accepts the 'val' in native endian. writel used in the
> > controller drivers should take care of converting to LE before writing to the
> > device.
> > 
> ok then I will revert to u32.
> 
> I think we need a patch in the controller drivers seperately to handle
> this.

Why?

> > > +	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
> > > +
> > > +	dev_dbg(dev, "Bandwidth scaling setup complete with event ring: %d\n",
> > > +		er_index);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
> > >   {
> > >   	u32 val;
> > > -	int i, ret;
> > > +	int i, ret, doorbell = 0;
> > >   	struct mhi_chan *mhi_chan;
> > >   	struct mhi_event *mhi_event;
> > >   	void __iomem *base = mhi_cntrl->regs;
> > > @@ -638,6 +683,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
> > >   		return ret;
> > >   	}
> > > +	if (mhi_cntrl->get_misc_doorbell)
> > > +		doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, MHI_ER_BW_SCALE);
> > > +
> > > +	if (doorbell > 0) {
> > > +		ret = mhi_init_bw_scale(mhi_cntrl, doorbell);
> > > +		if (!ret)
> > > +			mhi_cntrl->bw_scale_db = base + val + (8 * doorbell);
> > > +		else
> > > +			dev_warn(dev, "Failed to setup bandwidth scaling: %d\n", ret);
> > 
> > That's it? And you would continue to setup doorbell setup later?
> > 
> event ring for BW scale and capability are exposed during bootup only,
> if those are not present at bootup no need to retry later.

I'm not asking you to retry. I was asking why would you continue to initialize
bw_scale resources (like workqueue) even if mhi_init_bw_scale() fails.

> > > +	}
> > 
> > nit: newline
> > 
> > >   	return 0;
> > >   }

[...]

> > > +		goto exit_bw_scale;
> > > +	}
> > > +
> > > +	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
> > > +	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
> > > +	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
> > > +
> > > +	dev_dbg(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
> > > +		link_info.sequence_num,
> > > +		link_info.target_link_speed,
> > > +		link_info.target_link_width);
> > > +
> > > +	/* Bring host and device out of suspended states */
> > > +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> > 
> > Looks like mhi_device_get_sync() is going runtime_get()/runtime_put() inside
> > mhi_trigger_resume(). I'm wondering why that is necessary.
> > 
> Before mhi_trigger_resume we are doing wake_get, which will make sure
> device will not transition to the low power modes while servicing this
> event. And also make sure mhi state is in M0 only.
> 
> As we are in workqueue this can be scheduled at some later time and by
> that time mhi can go to m1 or m2 state.
> 

My comment was more about the behavior of mhi_trigger_resume(). Why does it call
get() and put()? Sorry if I was not clear.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

