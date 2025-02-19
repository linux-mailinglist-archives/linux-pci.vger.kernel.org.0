Return-Path: <linux-pci+bounces-21827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59534A3C6F6
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 19:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC251894E14
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBE121481D;
	Wed, 19 Feb 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KCP29Hge"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194182144CE
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988193; cv=none; b=Xud0dlOHXdNFPVywN75p0nEbEj2g6ne87B8G3m8bU1BrCIgjd5WvVN1A9SAWKZeGJ2g/ZGxssGp0CHXMD7ruEuzz/IXv6mBL+yBWeHphWlbsYEH+eAfEmNlmEqEaNAx/nyFppwtzJpLoYxhIZa3Aqn2D8nwuZOxA5LNyYlJILOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988193; c=relaxed/simple;
	bh=fx2mURBC8dy161x5v+JDLVevtqNL0pXWs5eKCcPUI60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHV+mzSYYIxjbzjjbIa4HdMeybM2M9S70SjS7r8AMvVYhBfD90jnkJP2X2KQ2fUwV/j5j/7PdRBfXmLSdAm33Se+vbnOjioFrgLgaqS+o0nIaUjIC7qkMvaD4r8DNFFODBZykch/Wua2+n7bjQyy5dMAAu9ZZWZVWqlweBdkEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KCP29Hge; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JHJ5v7015031
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 18:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qDJ92W9IA6hYw8nyXbIJGn61XvD0KYeHHEbu7HRI8Xo=; b=KCP29HgexImJEDvC
	uapDkSesaqR/tyzxoClvZVuw6fe7bUdMfDfUlCEr8wGDhh0+uRTkyYawQbvUO38N
	AT9lRIFjyD9R31RVqkrT6CqC+6bTj/9CKNPesyyvivc5B/O7NDVgHalFt6PXKEyf
	GWf8ZrX4Ng/TH3cULMTIizX8pAIa1QpbX8jK3BWLVu86vyeEmTa3s5gH9SJCDAaY
	NIOQb4yNek7Ho4Xb+8og1XsCpLGfKjn+p8j0Tamp4r50Vmz3zaaupeiNm8zRpzmr
	QFopiR8brF65ZkExKctTn262RM8px53IGnoWCYNbaZCtA8ZH6KBdXUl3GYHTk5Yh
	Y+he+Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy13h45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 18:03:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc0bc05afdso305309a91.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 10:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739988188; x=1740592988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDJ92W9IA6hYw8nyXbIJGn61XvD0KYeHHEbu7HRI8Xo=;
        b=cNZF6zHtsdoiBhH9Hq8nLf6V6hYuFyaJqe7Zis7wSUulEGY7/wlSr9hWA827+9CCS1
         m7wr6tzO+TTZCcvxnsVFKllUQz8lo2521m041B9aN0ed++6Jx4IwwbSreSQq8AwjXfVr
         bgHOkR0Qh3YcqPs0vT5fIEUvVg3dQxPIkvESCzvusqvCsh5gcsh5/EiJ4OdVG8Dd/LFc
         HORBf4o3DhU8mvv/uJeMnB3efaXX/wLhoEm7T3DVLyZemKPeoNgRwlbNmKpO6FXrKOcx
         t7TnIOPSuAfk1rpp2dM8PHBzrM9rUBTJ+UueM5OPAVkamPx4D9u4K7Du94aMZmZ7cBoD
         tbrw==
X-Forwarded-Encrypted: i=1; AJvYcCXjcePg5FQhOU1TnoK9YlBqDsh+DR/ZbGkZw7olBCD6iTFYi3G9e+neKJKmdZbiw9bNwkXzSn+pYmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0H9rVqdVei5yE3KtRD7uoTiHY26f3FDK8Yt8oT4pmyOb6xHv
	luKbVUefnWZpHAI8MrX0n1ifQS/g0h2PfTn4Dc7/W1wDKTAMnL9+xDB3I/Rf7W7HHbQCNb0OPPO
	NiBHgo7kzhEveISwGlMl4T96I1yhSjvPVaO2BeiJ0xmfHZm64p9w2+zuCHwU=
X-Gm-Gg: ASbGncvHXNUoHLCew9G+axehZJewHflRobQ9rXhXZVCw3JMRBUDLDTTpYMPrhgbUq1j
	IRxU/LlW1VpnNaRIPnSXB/v4kMOZMFvqIXm/WKsHjo6UpS+DIbenWHiTM0rrPqv90x9DQqqree5
	dPQKYn0KiEMOC/SrmnQ5vjiEJNzI5CNpcR1127///KwiaHsviy7SowxANc4E74EFOzzjZF6oaUH
	O6F+RY7+MjqBmYjwMh7trb5WQtO1dgNz5gp3nhyJofA87chzHlU9e44g9Ir/Zr5BeRrG90dfHqN
	9T302EoH4uZqoaxVuRRb1jvdpdfXfY/OVDA=
X-Received: by 2002:a17:90b:4acc:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-2fc4116aa99mr27673458a91.30.1739988188070;
        Wed, 19 Feb 2025 10:03:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPb/D/eoJU0uKoAPMHP+knmd1zwCoPk+UrYQwkyuaEMZYaEwgyaVjy5Y/7qW3gT57cPGIyug==
X-Received: by 2002:a17:90b:4acc:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-2fc4116aa99mr27673416a91.30.1739988187581;
        Wed, 19 Feb 2025 10:03:07 -0800 (PST)
Received: from [192.168.29.92] ([49.43.231.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc138d0846sm12506106a91.0.2025.02.19.10.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 10:03:07 -0800 (PST)
Message-ID: <92e70ba0-a83f-bcfd-8579-840da59c5f90@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 23:32:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/8] bus: mhi: host: Add support for Bandwidth scale
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, quic_jjohnson@quicinc.com,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
 <20250217-mhi_bw_up-v1-6-9bad1e42bdb1@oss.qualcomm.com>
 <0ec7933e-d580-1b21-2754-e2d4e4cd5ba7@linux.intel.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <0ec7933e-d580-1b21-2754-e2d4e4cd5ba7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vzQZx1uiaBRrSzvep286bM6bVu1bHXiM
X-Proofpoint-ORIG-GUID: vzQZx1uiaBRrSzvep286bM6bVu1bHXiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502190140



On 2/17/2025 2:47 PM, Ilpo Järvinen wrote:
> On Mon, 17 Feb 2025, Krishna Chaitanya Chundru wrote:
> 
>> As per MHI spec sec 14, MHI supports bandwidth scaling to reduce power
>> consumption. MHI bandwidth scaling is advertised in devices that contain
>> the bandwidth scaling capability registers. If enabled, the device
>> aggregates bandwidth requirements and sends them to the host in the form
>> of an event. After the host performs the bandwidth switch, it sends an
>> acknowledgment by ringing a doorbell.
>>
>> if the host supports bandwidth scaling events, then it must set
>> BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
>> doorbell that will be used by the host to communicate the bandwidth
>> scaling status and BW_CFG.ER_INDEX to the index for the event ring
>> to which the device should send bandwidth scaling request in the
>> bandwidth scaling capability register.
>>
>> As part of mmio init check if the bw scale capability is present or not,
>> if present advertise host supports bw scale by setting all the required
>> fields.
>>
>> MHI layer will only forward the bw scaling request to the controller
>> driver, it is responsibility of the controller driver to do actual bw
>> scaling and then pass status to the MHI. MHI will response back to the
>> device based up on the status of the bw scale received.
>>
>> Add a new get_misc_doorbell() to get doorbell for misc capabilities to
>> use the doorbell with mhi events like MHI BW scale etc.
>>
>> Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
>> which will called by the mhi controller driver can sleep.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/common.h        |  14 ++++++
>>   drivers/bus/mhi/host/init.c     |  64 ++++++++++++++++++++++++-
>>   drivers/bus/mhi/host/internal.h |   7 ++-
>>   drivers/bus/mhi/host/main.c     | 102 +++++++++++++++++++++++++++++++++++++++-
>>   drivers/bus/mhi/host/pm.c       |  10 +++-
>>   include/linux/mhi.h             |  13 +++++
>>   6 files changed, 204 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>> index eedac801b800..b900199fab10 100644
>> --- a/drivers/bus/mhi/common.h
>> +++ b/drivers/bus/mhi/common.h
>> @@ -208,6 +208,20 @@
>>   #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
>>   							       MHI_PKT_TYPE_COALESCING))
>>   
>> +/* MHI Bandwidth scaling offsets */
>> +#define BW_SCALE_CFG_OFFSET		(0x04)
>> +#define BW_SCALE_CFG_CHAN_DB_ID_SHIFT	(25)
>> +#define BW_SCALE_CFG_ENABLED_MASK	BIT(24)
>> +#define BW_SCALE_CFG_ENABLED_SHIFT	(24)
>> +#define BW_SCALE_CFG_ER_ID_SHIFT	(19)
>> +
>> +#define BW_SCALE_CAP_ID			(3)
>> +#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	(((tre)->dword[0] >> 8) & 0xFF)
> 
> This looks open-coded FIELD_GET(). Add the field define and use
> FIELD_GET() with it.
> 
ack
>> +
>> +#define MHI_BW_SCALE_RESULT(status, seq)	(((status) & 0xF) << 8 | \
>> +						((seq) & 0xFF))
> 
> 2x FIELD_PREP().
> 
ack
>> +#define	MHI_BW_SCALE_NACK			0xF
>> +
>>   enum mhi_pkt_type {
>>   	MHI_PKT_TYPE_INVALID = 0x0,
>>   	MHI_PKT_TYPE_NOOP_CMD = 0x1,
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index 0b14b665ed15..f15c79f85d13 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -496,10 +496,56 @@ static int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl, u32 capab
>>   	return -ENXIO;
>>   }
>>   
>> +/* to be used only if a single event ring with the type is present */
>> +static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
>> +			    enum mhi_er_data_type type)
>> +{
>> +	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
>> +	int i;
>> +
>> +	/* find event ring for requested type */
>> +	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>> +		if (mhi_event->data_type == type)
>> +			return mhi_event->er_index;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>> +static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl,
>> +			     int bw_scale_db)
>> +{
>> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>> +	u32 bw_cfg_offset, val = 0;
>> +	int ret, er_index;
>> +
>> +	ret = mhi_get_capability_offset(mhi_cntrl, BW_SCALE_CAP_ID,
>> +					&bw_cfg_offset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* No ER configured to support BW scale */
>> +	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
>> +	if (er_index < 0)
>> +		return er_index;
>> +
>> +	bw_cfg_offset += BW_SCALE_CFG_OFFSET;
>> +
>> +	/* advertise host support */
>> +	val = ((bw_scale_db << BW_SCALE_CFG_CHAN_DB_ID_SHIFT) |
>> +		BW_SCALE_CFG_ENABLED_MASK | (er_index << BW_SCALE_CFG_ER_ID_SHIFT));
> 
> Please name the fields with defines and use FIELD_PREP(). And remove
> _SHIFT ending defines.
> 
> Also make the file does correct #include for FIELD_PREP/GET if not yet
> there.
> 
ack
>> +	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
>> +
>> +	dev_info(dev, "Bandwidth scaling setup complete. Event ring:%d\n",
>> +		 er_index);
> 
> This sound like dev_dbg() to me. What's the value for user in normal
> scenarios?
> 
ack
>> +	return 0;
>> +}
>> +
>>   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>   {
>>   	u32 val;
>> -	int i, ret;
>> +	int i, ret, doorbell;
>>   	struct mhi_chan *mhi_chan;
>>   	struct mhi_event *mhi_event;
>>   	void __iomem *base = mhi_cntrl->regs;
>> @@ -633,6 +679,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>   		return ret;
>>   	}
>>   
>> +	if (mhi_cntrl->get_misc_doorbell)
>> +		doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, MHI_ER_BW_SCALE);
>> +
>> +	if (doorbell > 0) {
>> +		ret = mhi_init_bw_scale(mhi_cntrl, doorbell);
>> +		if (!ret)
>> +			mhi_cntrl->bw_scale_db = base + val + (8 * doorbell);
>> +		else
>> +			dev_warn(dev, "BW scale setup failure\n");
> 
> Is it okay to return 0 in this case?
> 
Not all the controllers support this feature, so we want to return
failure so that controllers can continue normally.
>> +	}
>>   	return 0;
>>   }
>>   
>> @@ -778,6 +834,9 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
>>   		case MHI_ER_CTRL:
>>   			mhi_event->process_event = mhi_process_ctrl_ev_ring;
>>   			break;
>> +		case MHI_ER_BW_SCALE:
>> +			mhi_event->process_event = mhi_process_bw_scale_ev_ring;
>> +			break;
>>   		default:
>>   			dev_err(dev, "Event Ring type not supported\n");
>>   			goto error_ev_cfg;
>> @@ -1012,9 +1071,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>>   
>>   		mhi_event->mhi_cntrl = mhi_cntrl;
>>   		spin_lock_init(&mhi_event->lock);
>> +		mutex_init(&mhi_event->mutex);
>>   		if (mhi_event->data_type == MHI_ER_CTRL)
>>   			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
>>   				     (ulong)mhi_event);
>> +		else if (mhi_event->data_type == MHI_ER_BW_SCALE)
>> +			INIT_WORK(&mhi_event->work, mhi_process_ev_work);
>>   		else
>>   			tasklet_init(&mhi_event->task, mhi_ev_task,
>>   				     (ulong)mhi_event);
>> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
>> index 3134f111be35..bf7c6a7c9383 100644
>> --- a/drivers/bus/mhi/host/internal.h
>> +++ b/drivers/bus/mhi/host/internal.h
>> @@ -241,6 +241,8 @@ struct mhi_event {
>>   	struct mhi_ring ring;
>>   	struct db_cfg db_cfg;
>>   	struct tasklet_struct task;
>> +	struct work_struct work;
>> +	struct mutex mutex;
>>   	spinlock_t lock;
>>   	int (*process_event)(struct mhi_controller *mhi_cntrl,
>>   			     struct mhi_event *mhi_event,
>> @@ -403,7 +405,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>>   				struct mhi_event *mhi_event, u32 event_quota);
>>   int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>>   			     struct mhi_event *mhi_event, u32 event_quota);
>> -
>> +int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
>> +				 struct mhi_event *mhi_event, u32 event_quota);
>>   /* ISR handlers */
>>   irqreturn_t mhi_irq_handler(int irq_number, void *dev);
>>   irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
>> @@ -419,5 +422,5 @@ void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
>>   			    struct mhi_buf_info *buf_info);
>>   void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
>>   			     struct mhi_buf_info *buf_info);
>> -
>> +void mhi_process_ev_work(struct work_struct *work);
>>   #endif /* _MHI_INT_H */
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index 4de75674f193..a6732bbead44 100644
>> --- a/drivers/bus/mhi/host/main.c
>> +++ b/drivers/bus/mhi/host/main.c
>> @@ -472,7 +472,10 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>>   		if (mhi_dev)
>>   			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
>>   	} else {
>> -		tasklet_schedule(&mhi_event->task);
>> +		if (mhi_event->data_type == MHI_ER_BW_SCALE)
>> +			queue_work(mhi_cntrl->hiprio_wq, &mhi_event->work);
>> +		else
>> +			tasklet_schedule(&mhi_event->task);
>>   	}
>>   
>>   	return IRQ_HANDLED;
>> @@ -1049,6 +1052,103 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>>   	return count;
>>   }
>>   
>> +/* dedicated bw scale event ring processing */
>> +int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
>> +				 struct mhi_event *mhi_event, u32 event_quota)
>> +{
>> +	struct mhi_event_ctxt *er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
>> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>> +	struct mhi_ring *ev_ring = &mhi_event->ring;
>> +	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
>> +	u32 response = MHI_BW_SCALE_NACK;
>> +	struct mhi_ring_element *dev_rp;
>> +	struct mhi_link_info link_info;
>> +	int ret = -EINVAL;
>> +
>> +	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state))) {
>> +		ret =  -EIO;
>> +		goto exit_bw_scale_process;
>> +	}
>> +
>> +	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
>> +		goto exit_bw_scale_process;
>> +
>> +	if (!is_valid_ring_ptr(ev_ring, ptr)) {
>> +		dev_err(dev,
>> +			"Event ring rp points outside of the event ring\n");
>> +		ret =  -EIO;
>> +		goto exit_bw_scale_process;
>> +	}
>> +
>> +	dev_rp = mhi_to_virtual(ev_ring, ptr);
>> +
>> +	/* if rp points to base, we need to wrap it around */
>> +	if (dev_rp == ev_ring->base)
>> +		dev_rp = ev_ring->base + ev_ring->len;
>> +	dev_rp--;
>> +
>> +	/* fast forward to currently processed element and recycle er */
>> +	ev_ring->rp = dev_rp;
>> +	ev_ring->wp = dev_rp - 1;
>> +	if (ev_ring->wp < ev_ring->base)
>> +		ev_ring->wp = ev_ring->base + ev_ring->len - ev_ring->el_size;
>> +	mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>> +
>> +	if (WARN_ON(MHI_TRE_GET_EV_TYPE(dev_rp) != MHI_PKT_TYPE_BW_REQ_EVENT)) {
>> +		dev_err(dev, "!BW SCALE REQ event\n");
>> +		goto exit_bw_scale_process;
>> +	}
>> +
>> +	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
>> +	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
>> +	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
>> +
>> +	dev_info(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
>> +		 link_info.sequence_num,
>> +		 link_info.target_link_speed,
>> +		 link_info.target_link_width);
>> +
>> +	/* bring host and device out of suspended states */
>> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
>> +	if (ret)
>> +		goto exit_bw_scale_process;
>> +
>> +	mhi_cntrl->runtime_get(mhi_cntrl);
>> +
>> +	ret = mhi_cntrl->bw_scale(mhi_cntrl, &link_info);
>> +	if (!ret)
>> +		response = 0;
>> +
>> +	response = MHI_BW_SCALE_RESULT(response, link_info.sequence_num);
>> +
>> +	write_lock_bh(&mhi_cntrl->pm_lock);
>> +	mhi_write_reg(mhi_cntrl, mhi_cntrl->bw_scale_db, 0, response);
>> +	write_unlock_bh(&mhi_cntrl->pm_lock);
>> +
>> +	mhi_cntrl->runtime_put(mhi_cntrl);
>> +	mhi_device_put(mhi_cntrl->mhi_dev);
>> +
>> +exit_bw_scale_process:
>> +	dev_info(dev, "exit er_index:%u ret:%d\n", mhi_event->er_index, ret);
> 
> There's zero value for normal user with something as obscure as
> this, make it dev_dbg().
> 
ack
>> +	return ret;
>> +}
>> +
>> +void mhi_process_ev_work(struct work_struct *work)
>> +{
>> +	struct mhi_event *mhi_event = container_of(work, struct mhi_event,
>> +						   work);
>> +
>> +	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
>> +
>> +	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
>> +		return;
>> +
>> +	mutex_lock(&mhi_event->mutex);
> 
> guard()()
> 
ack.

- Krishna Chaitanya.
>> +	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
>> +	mutex_unlock(&mhi_event->mutex);
>> +}
>> +
>>   void mhi_ev_task(unsigned long data)
>>   {
>>   	struct mhi_event *mhi_event = (struct mhi_event *)data;
>> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
>> index 11c0e751f223..9c848ca582f0 100644
>> --- a/drivers/bus/mhi/host/pm.c
>> +++ b/drivers/bus/mhi/host/pm.c
>> @@ -523,7 +523,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
>>   		if (mhi_event->offload_ev)
>>   			continue;
>>   		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
>> -		tasklet_kill(&mhi_event->task);
>> +		if (mhi_event->data_type == MHI_ER_BW_SCALE)
>> +			cancel_work_sync(&mhi_event->work);
>> +		else
>> +			tasklet_kill(&mhi_event->task);
>>   	}
>>   
>>   	/* Release lock and wait for all pending threads to complete */
>> @@ -670,7 +673,10 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
>>   	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>>   		if (mhi_event->offload_ev)
>>   			continue;
>> -		tasklet_kill(&mhi_event->task);
>> +		if (mhi_event->data_type == MHI_ER_BW_SCALE)
>> +			cancel_work_sync(&mhi_event->work);
>> +		else
>> +			tasklet_kill(&mhi_event->task);
>>   	}
>>   
>>   	/* Release lock and wait for all pending threads to complete */
>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>> index 059dc94d20bb..d9bf88c35d14 100644
>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -102,10 +102,12 @@ struct image_info {
>>    * struct mhi_link_info - BW requirement
>>    * target_link_speed - Link speed as defined by TLS bits in LinkControl reg
>>    * target_link_width - Link width as defined by NLW bits in LinkStatus reg
>> + * sequence_num - used by device to track bw requests sent to host
>>    */
>>   struct mhi_link_info {
>>   	unsigned int target_link_speed;
>>   	unsigned int target_link_width;
>> +	int sequence_num;
>>   };
>>   
>>   /**
>> @@ -183,10 +185,12 @@ enum mhi_ch_ee_mask {
>>    * enum mhi_er_data_type - Event ring data types
>>    * @MHI_ER_DATA: Only client data over this ring
>>    * @MHI_ER_CTRL: MHI control data and client data
>> + * @MHI_ER_BW_SCALE: MHI controller bandwidth scale functionality
>>    */
>>   enum mhi_er_data_type {
>>   	MHI_ER_DATA,
>>   	MHI_ER_CTRL,
>> +	MHI_ER_BW_SCALE,
>>   };
>>   
>>   /**
>> @@ -299,6 +303,7 @@ struct mhi_controller_config {
>>    * @bhi: Points to base of MHI BHI register space
>>    * @bhie: Points to base of MHI BHIe register space
>>    * @wake_db: MHI WAKE doorbell register address
>> + * @wake_db: MHI BW_SCALE doorbell register address
>>    * @iova_start: IOMMU starting address for data (required)
>>    * @iova_stop: IOMMU stop address for data (required)
>>    * @fw_image: Firmware image name for normal booting (optional)
>> @@ -355,6 +360,8 @@ struct mhi_controller_config {
>>    * @write_reg: Write a MHI register via the physical link (required)
>>    * @reset: Controller specific reset function (optional)
>>    * @edl_trigger: CB function to trigger EDL mode (optional)
>> + * @get_misc_doobell: function to get doorbell used for MISC feature like BW scale etc (optional)
>> + * @bw_scale: CB function for passing BW scale info (optional)
>>    * @buffer_len: Bounce buffer length
>>    * @index: Index of the MHI controller instance
>>    * @bounce_buf: Use of bounce buffer
>> @@ -376,6 +383,7 @@ struct mhi_controller {
>>   	void __iomem *bhi;
>>   	void __iomem *bhie;
>>   	void __iomem *wake_db;
>> +	void __iomem *bw_scale_db;
>>   
>>   	dma_addr_t iova_start;
>>   	dma_addr_t iova_stop;
>> @@ -440,6 +448,11 @@ struct mhi_controller {
>>   	void (*reset)(struct mhi_controller *mhi_cntrl);
>>   	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
>>   
>> +	int (*get_misc_doorbell)(struct mhi_controller *mhi_cntrl,
>> +				 enum mhi_er_data_type type);
>> +	int (*bw_scale)(struct mhi_controller *mhi_cntrl,
>> +			struct mhi_link_info *link_info);
>> +
>>   	size_t buffer_len;
>>   	int index;
>>   	bool bounce_buf;
>>
>>
> 

