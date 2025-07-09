Return-Path: <linux-pci+bounces-31766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87C1AFE8BE
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 14:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C692A3A9DBA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8912D97AD;
	Wed,  9 Jul 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SB+1GbZx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729522D8380
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063707; cv=none; b=KTItk9MuY0lGzLBEwGVNP4TR/nCDC9Te1VB9wGPiIChPyGeCwRAFYLHzz7Y3XRkipCKpyLnRzkrLPbxYzKgN5bn9RGirmQ6cWosAhEpIC0uLOIzjqWVIO26DUEfndbXJ2KfVkYPKc1umqCCSiqDdLb7SnU8oqA/YLSfl3INM29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063707; c=relaxed/simple;
	bh=M+Y8eWi2Ta/SjWWvmksbheTfNk5SeKfW2NPqRi7mwTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1ASDZXxAPuSk8qr7HJhkrVJi0/dT7Ae8mf4rjqA2Hln1+dKAPkizhLjI8J7foYIUD0HUoqvOKmx7WqDSUxaLPArM881x4/Q4xpWf1H47tvEgsWkrEVYDyvT3PfxnC2bpq0/2ADSKVbdyxvm9ioIZpYPW/2iaNF9qr2YP+orEsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SB+1GbZx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697jlDf010352
	for <linux-pci@vger.kernel.org>; Wed, 9 Jul 2025 12:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w8lMNlghogK+mSBU0imSNt3VUdNIAATPo+LYJj0VaH4=; b=SB+1GbZxuYC8pFvA
	Un+T68Ld3svjdPkOGPPsx4aX9HgY9IgaFoFxfJdZDPOlOzEs8I25bLUai36Gvvxn
	h0B0+y9kcnxEjyjHwVMjIuWh9OqwMAVlQUYh7ll4udjWFHLXYOdvvn/jHV808GIL
	dfztXKJEPWtOl/gRj516Tx70DFpBbxBtio60Ndp4ELNV/UzmRr749hg45V+514FI
	iViT9+lC/YFRwVEeq9rStsoyxhl5SdvHDTMf1y0OWwb8xJFTHz7QiysvpHi2Aiup
	93f4g/p3ZUgs/avVGsrvO/w/Bqj+f4sU1IEYugo9J9EQyNBin0PWOQ1YWcswp7+A
	vvwNng==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smap0yc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 12:21:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23536f7c2d7so86443565ad.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Jul 2025 05:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752063703; x=1752668503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8lMNlghogK+mSBU0imSNt3VUdNIAATPo+LYJj0VaH4=;
        b=jugPkhFINmpO3jM+FTJndKH4O7/lmWmyP9PdrfzE/7nSv82W3/fl1XSnBJjCJMuouj
         o0HA6K24R5PuN+c3p/6QeHyRm4remwb0yXJXsQNsQtM8LZ7ifD47qLuJTfL7oKeOUTeQ
         hE86C4Y/S9TJUte7y98dO5jMaEm+IKJx0V3pkJdBWOf3sQEmTCcVguhn6ugGPpRaYcNQ
         bmnuP4Dh7CGFq8NXBmgFfYGD7cn3kP3JexWq4zkQScQepgRXPOJECF/Crr1T8ICdfyoW
         8EyNV0of31CqAcD6+XTxaMSac++BWcJfHKiFuLPRkxVN3lNj3i8zHaro2CCHo+jX8w4c
         4FeA==
X-Forwarded-Encrypted: i=1; AJvYcCUterYR4Cj8btCg086twefHjA3q9dywWaDYid/FiJI4YMz8mMheYMHeg8bNzmHhob1+wEP0j1Qd/lU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19pnm+QyALxRYoymo2pSwVPns74/f6+FKD0LwugLnkhvEAp9g
	D3de4Q64/DX+DIILUkDsnhkTXk4MM54U3mbQYlNWE9WZCwl6IOyQ5/SoF929wcU4cTx5ACFjhMa
	T4bjxgzy1EMnMSbyzMCr91kT2ww89zLrtSIE7gGFKxPEOevb59pYa6yX4YQmGqps=
X-Gm-Gg: ASbGncsJYZ3uElA91ZdwuXIiWyDV0mfgMaDjQGu59syL8U7KI6PoY87FpgfSp8bsgjz
	dVv+FNUWeGEa+ktD2LO+odI9EiUqUcZaIw3Fy+JWLebZLjyDjX6lPlr2X+baAZhFUPmc+ToDcVH
	Hz7ejmOkcWvOSQ97VJdJy1Wr7apiVCsxRPzpoRt6We+PbEJ6Ohc+NlUVvzhbG9tV8yVwklJ7/5I
	OWvr8z7GWP7pvkkl7U0GRQwKknb3xXVkyh0OJaRL3J7Ul2+tgx5bbeioIF2Y+i8NGoVLbzeGieT
	iEgGS0j2waakYGraQfCB1pdHdL9utrP6l8F2Uak6hDcA3lc8aSFW
X-Received: by 2002:a17:902:7c82:b0:23d:dd63:2cd9 with SMTP id d9443c01a7336-23ddd632e55mr21311555ad.46.1752063702430;
        Wed, 09 Jul 2025 05:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+N2gWyM/Nz7yeHFW1eJrFZUgPFq/ZAcz6utFyo46eMvEqlEANyy2zxzepXmUlk0dgO/OWRA==
X-Received: by 2002:a17:902:7c82:b0:23d:dd63:2cd9 with SMTP id d9443c01a7336-23ddd632e55mr21311035ad.46.1752063701828;
        Wed, 09 Jul 2025 05:21:41 -0700 (PDT)
Received: from [10.218.37.122] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455babasm135586755ad.107.2025.07.09.05.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:21:41 -0700 (PDT)
Message-ID: <31c192f7-cd69-46ad-9443-5d57ae2aa86e@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 17:51:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] bus: mhi: host: Add support for Bandwidth scale
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-4-3faa8fe92b05@qti.qualcomm.com>
 <j24c2ii33yivc7rb3vwbwljxwvhdpqwbfgt3gid2njma6t47i4@uhykehw23h2q>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <j24c2ii33yivc7rb3vwbwljxwvhdpqwbfgt3gid2njma6t47i4@uhykehw23h2q>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=686e5ed8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=uugI8YhyZeVs79u1j28A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: R67TyCSMJ7pTCdIBnkMVjB_KC1S4XO3u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExMSBTYWx0ZWRfX1UvyDejci7Ct
 t+2qE6/VlVE1PHyx7YW0f/DVzt++QtmuSIXkbX0TSKjkdReIGADI+TJNtlw2pP7+bcaRl7nM2HM
 01mYM7r1d3AJNT5TiWHaWqq91290AL3Fw9CynZcXln855mO35N7WEL2sX/himIoJCkOSQZLxlfB
 YXznv3rK6hzsKJRmvpXmB+FAbxm6uEWXpMBnfPRiLjjjjBIi/jfl2rj7fFu96ONnLIikE8nKNfq
 YcwXkSbcUiZqI1CJPnbA2ommZ0y9VlE6FJNQDQ3xk62RYeUEtkaAHoRZ+/dP5L+tSNjGEkM7IZF
 yVBIN+qHIVmOUzqvEmX+ygIjMGr5ceriBnU+dGjgWrKa0CPhS/4IqIUf/puYqEweMNZnkTAFSZM
 jagYh25KoTGZ7Sp7q7bi9O0LdClaC0LOG81x9pZDYKqZ+QlPycNriUub+HGe2494052n6rP+
X-Proofpoint-GUID: R67TyCSMJ7pTCdIBnkMVjB_KC1S4XO3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090111



On 7/8/2025 10:36 PM, Manivannan Sadhasivam wrote:
> On Mon, Jun 09, 2025 at 04:21:25PM GMT, Krishna Chaitanya Chundru wrote:
>> As per MHI spec v1.2, sec 14, MHI supports bandwidth scaling to reduce
>> power consumption. MHI bandwidth scaling is advertised by devices that
>> contain the bandwidth scaling capability registers. If enabled, the device
>> aggregates bandwidth requirements and sends them to the host through
>> dedicated mhi event ring. After the host performs the bandwidth switch,
>> it sends an acknowledgment by ringing a doorbell.
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
>> driver since MHI doesn't have any idea about transport layer used by
>> the controller, it is responsibility of the controller driver to do actual
>> bw scaling and then pass status to the MHI. MHI will response back to the
>> device based up on the status of the bw scale received.
>>
>> Add a new get_misc_doorbell() to get doorbell for misc capabilities to
>> use the doorbell with mhi events like MHI BW scale etc.
>>
>> Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
>> which will called by the mhi controller driver can sleep.
>>
>> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/bus/mhi/common.h        | 13 ++++++
>>   drivers/bus/mhi/host/init.c     | 63 +++++++++++++++++++++++++-
>>   drivers/bus/mhi/host/internal.h |  7 ++-
>>   drivers/bus/mhi/host/main.c     | 98 ++++++++++++++++++++++++++++++++++++++++-
>>   drivers/bus/mhi/host/pm.c       | 10 ++++-
>>   include/linux/mhi.h             | 13 ++++++
>>   6 files changed, 198 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>> index 58f27c6ba63e3e6fa28ca48d6d1065684ed6e1dd..6e342519d80b7725e9ef5390a3eb2a06ac69ceac 100644
>> --- a/drivers/bus/mhi/common.h
>> +++ b/drivers/bus/mhi/common.h
>> @@ -217,6 +217,19 @@ enum mhi_capability_type {
>>   	MHI_CAP_ID_MAX,
>>   };
>>   
>> +/* MHI Bandwidth scaling offsets */
>> +#define MHI_BW_SCALE_CFG_OFFSET		0x4
>> +#define MHI_BW_SCALE_CAP_ID		(3)
>> +#define MHI_BW_SCALE_DB_CHAN_ID		GENMASK(31, 25)
>> +#define MHI_BW_SCALE_ENABLED		BIT(24)
>> +#define MHI_BW_SCALE_ER_INDEX		GENMASK(23, 19)
>> +
>> +#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	FIELD_GET(GENMASK(15, 8), (MHI_TRE_GET_DWORD(tre, 0)))
>> +
>> +#define MHI_BW_SCALE_RESULT(status, seq)	cpu_to_le32(FIELD_PREP(GENMASK(11, 8), status) | \
>> +						FIELD_PREP(GENMASK(7, 0), seq))
>> +#define MHI_BW_SCALE_NACK			0xF
>> +
>>   enum mhi_pkt_type {
>>   	MHI_PKT_TYPE_INVALID = 0x0,
>>   	MHI_PKT_TYPE_NOOP_CMD = 0x1,
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index 9102ce13a2059f599b46d25ef631f643142642be..26703fea6272de7fd19c6ee76be067f0ff0fd309 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -501,10 +501,55 @@ static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability,
>>   	return -ENXIO;
>>   }
>>   
>> +static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
>> +			    enum mhi_er_data_type type)
>> +{
>> +	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
>> +	int i;
>> +
>> +	/* Find event ring for requested type */
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
>> +	u32 bw_cfg_offset, val;
>> +	int ret, er_index;
>> +
>> +	ret = mhi_find_capability(mhi_cntrl, MHI_BW_SCALE_CAP_ID, &bw_cfg_offset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
>> +	if (er_index < 0)
>> +		return er_index;
>> +
>> +	bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
>> +
>> +	/* Advertise host support */
>> +	val = (__force u32)cpu_to_le32(FIELD_PREP(MHI_BW_SCALE_DB_CHAN_ID, bw_scale_db) |
>> +				       FIELD_PREP(MHI_BW_SCALE_ER_INDEX, er_index) |
>> +				       MHI_BW_SCALE_ENABLED);
>> +
> 
> It is wrong to store the value of cpu_to_le32() in a non-le32 variable.
> mhi_write_reg() accepts the 'val' in native endian. writel used in the
> controller drivers should take care of converting to LE before writing to the
> device.
> 
ok then I will revert to u32.

I think we need a patch in the controller drivers seperately to handle
this.
>> +	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
>> +
>> +	dev_dbg(dev, "Bandwidth scaling setup complete with event ring: %d\n",
>> +		er_index);
>> +
>> +	return 0;
>> +}
>> +
>>   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>   {
>>   	u32 val;
>> -	int i, ret;
>> +	int i, ret, doorbell = 0;
>>   	struct mhi_chan *mhi_chan;
>>   	struct mhi_event *mhi_event;
>>   	void __iomem *base = mhi_cntrl->regs;
>> @@ -638,6 +683,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
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
>> +			dev_warn(dev, "Failed to setup bandwidth scaling: %d\n", ret);
> 
> That's it? And you would continue to setup doorbell setup later?
> 
event ring for BW scale and capability are exposed during bootup only,
if those are not present at bootup no need to retry later.
>> +	}
> 
> nit: newline
> 
>>   	return 0;
>>   }
>>   
>> @@ -783,6 +838,9 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
>>   		case MHI_ER_CTRL:
>>   			mhi_event->process_event = mhi_process_ctrl_ev_ring;
>>   			break;
>> +		case MHI_ER_BW_SCALE:
>> +			mhi_event->process_event = mhi_process_bw_scale_ev_ring;
>> +			break;
>>   		default:
>>   			dev_err(dev, "Event Ring type not supported\n");
>>   			goto error_ev_cfg;
>> @@ -1017,9 +1075,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
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
>> index ce566f7d2e9240c64044407aa4124ad3cdb98003..cf64adaecad2aeec8569da5276ec60dd7e97e5e0 100644
>> --- a/drivers/bus/mhi/host/internal.h
>> +++ b/drivers/bus/mhi/host/internal.h
>> @@ -248,6 +248,8 @@ struct mhi_event {
>>   	struct mhi_ring ring;
>>   	struct db_cfg db_cfg;
>>   	struct tasklet_struct task;
>> +	struct work_struct work;
>> +	struct mutex mutex; /* lock for synchronization */
> 
> synchronization of what?
I will update in next patch, synchronizatrion between multiple bw scale
events in this case.
> 
>>   	spinlock_t lock;
>>   	int (*process_event)(struct mhi_controller *mhi_cntrl,
>>   			     struct mhi_event *mhi_event,
>> @@ -410,7 +412,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>>   				struct mhi_event *mhi_event, u32 event_quota);
>>   int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>>   			     struct mhi_event *mhi_event, u32 event_quota);
>> -
>> +int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
>> +				 struct mhi_event *mhi_event, u32 event_quota);
>>   /* ISR handlers */
>>   irqreturn_t mhi_irq_handler(int irq_number, void *dev);
>>   irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
>> @@ -426,5 +429,5 @@ void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
>>   			    struct mhi_buf_info *buf_info);
>>   void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
>>   			     struct mhi_buf_info *buf_info);
>> -
>> +void mhi_process_ev_work(struct work_struct *work);
>>   #endif /* _MHI_INT_H */
>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>> index 9bb0df43ceef1e54e8817422516aab1def6fdc4a..f87e9550b59227947fc7268c5799eea274c66b98 100644
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
>> @@ -1049,6 +1052,99 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>>   	return count;
>>   }
>>   
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
>> +		goto exit_bw_scale;
>> +	}
>> +
>> +	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
>> +		goto exit_bw_scale;
>> +
>> +	if (!is_valid_ring_ptr(ev_ring, ptr)) {
>> +		dev_err(dev,
>> +			"Event ring rp points outside of the event ring\n");
>> +		ret =  -EIO;
>> +		goto exit_bw_scale;
>> +	}
>> +
>> +	dev_rp = mhi_to_virtual(ev_ring, ptr);
>> +
>> +	/* If rp points to base, we need to wrap it around */
>> +	if (dev_rp == ev_ring->base)
>> +		dev_rp = ev_ring->base + ev_ring->len;
>> +	dev_rp--;
>> +
>> +	/* Fast forward to currently processed element and recycle er */
>> +	ev_ring->rp = dev_rp;
>> +	ev_ring->wp = dev_rp - 1;
>> +	if (ev_ring->wp < ev_ring->base)
>> +		ev_ring->wp = ev_ring->base + ev_ring->len - ev_ring->el_size;
>> +	mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>> +
>> +	if (WARN_ON(MHI_TRE_GET_EV_TYPE(dev_rp) != MHI_PKT_TYPE_BW_REQ_EVENT)) {
>> +		dev_err(dev, "!BW SCALE REQ event\n");
> 
> What does it mean?
> 
I will update it in next patch saying not a bw scale event.
>> +		goto exit_bw_scale;
>> +	}
>> +
>> +	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
>> +	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
>> +	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
>> +
>> +	dev_dbg(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
>> +		link_info.sequence_num,
>> +		link_info.target_link_speed,
>> +		link_info.target_link_width);
>> +
>> +	/* Bring host and device out of suspended states */
>> +	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
> 
> Looks like mhi_device_get_sync() is going runtime_get()/runtime_put() inside
> mhi_trigger_resume(). I'm wondering why that is necessary.
> 
Before mhi_trigger_resume we are doing wake_get, which will make sure
device will not transition to the low power modes while servicing this
event. And also make sure mhi state is in M0 only.

As we are in workqueue this can be scheduled at some later time and by
that time mhi can go to m1 or m2 state.

- Krishna Chaitanya.
>> +	if (ret)
>> +		goto exit_bw_scale;
>> +
>> +	mhi_cntrl->runtime_get(mhi_cntrl);
>> +
> 
> Here, you want to resume the controller, which is fine.
> 
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
>> +exit_bw_scale:
>> +	return ret;
> 
> Just return 'ret' directly.
> 
> - Mani
> 

