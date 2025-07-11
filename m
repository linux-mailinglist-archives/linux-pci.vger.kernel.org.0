Return-Path: <linux-pci+bounces-31969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBBB02762
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA783B30A0
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC12222B0;
	Fri, 11 Jul 2025 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f/T4QJ2A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D204220F20
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275191; cv=none; b=ByM4ulukum2huQ61GO/Aexhx4C6tmHC4e/NuuXud2O2t4ghnwuapXWMjNK578Rbgtb/1LCzDIn52R4bgbC550Jk3nntU/6LO/NON96PMXeEOF8zYAJc+3S0pR0l0GPBa3bZBkJgsJ/ATCIN+DxF/S0rtHmlHI5vxds04YpsnWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275191; c=relaxed/simple;
	bh=ftb8jDPRJLRD/D3esyee2T7DhrNjtEME0Bi6Xns0gjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBHPBAt08vyMh8+bdOdcBx+IDzoRWwigROsfYYXVWLhzLeXbknKrs+/AWYas8OPb03lOnAriI4S2CqSAS/ma2/vfJEEV/g8RlhWBcrsF9l4XylSsMctsXXXZ1+qSVqES/gnnTVI7aAsUjLtgyGYYcx0haIhJdeV1BDD+2OjlmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f/T4QJ2A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BATa22008001
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eRi2bFv99W7KvrolTDuk12d65vjZCVs5GiO7uLokh1E=; b=f/T4QJ2AYCB++mb/
	QH3dwnIXdNSUSFPElOYu4mwQ0sIDZUUZK/L5TsGgeZLTGZsGhhg+QSquy+Pdz6RE
	XLCRrcb7iwb3EvR7lUxjBZ6OP0UfrXDVssUa9UlS8+7wz4mx2ngtj+M6kZYUdpYs
	mzvWi9ESdGA0M31LyYLYVRYPrUqrNFQr3Q9IxmC5t1LzqWBTEJGc6PESwOOgni9Q
	3eksdv8bW529+M3oy2EFXWTslCOMGWP/q8HaEyT5GB68TpN174vwSHVMWCcqYyBJ
	gbEiIcpa5Ju02oeVtt/FfSD5Zy3jHzGqSs+VbHwjihBb/wwROboKTS6O3+qN2K0K
	MPOkHQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcga1uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:06:29 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so3510143a91.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 16:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752275188; x=1752879988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRi2bFv99W7KvrolTDuk12d65vjZCVs5GiO7uLokh1E=;
        b=tyKwHRdELtx+huMS0MKFTWw6/uwB9nFZ+GgLASyovgFIPnHl4W5KM9w+nH7uWSeTOo
         6x0bvOyWFWlhVOiluwSqzU5qXj5vv7XScPQC0wmUCkUKBxOJZkqg7gsiENVK1ayVnUuF
         Qh0/7yJcx2xCW9LxEQeOqAkk8+eW1WxIi/I7lH6FBGxv1NaGJdmfcoe1B132FjgDqC1r
         KSPca27zhSec56Ru2o4ylxfQuiFGKDhd2GDhLwufXi1fywFQz0kPbKbI9hiu2I0dGSq/
         W0+2qNz/7AbygUvvE5kiJpnlsckJ/wAMDIHqOEAKPgBVSpP13KuJt4o4mjjhVAh8styP
         I12A==
X-Forwarded-Encrypted: i=1; AJvYcCVtRanr859fbGS4etp19cDv4eXfF99gJB3c71DE0QA5dc+Pn5iRzk3T5jSWIGHWFAJSlzQUVrfbBqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQRICtOrwC0tyC8zfx17th0MS9crbJPMu0uFRMBmByIQ23Cpa
	NOiTV/fa05cZCsbrMP4nRCzBmKeDfezpteSp9+LHInA37e+PXetdSP5aW/7nW3+v4DlSFddtmEa
	OLV5YxKjAo52MlEgBplGMBaH6tYNplO6MKHEIxlB8LcZSH92/6eRDDcV2sN9jIONWKF9RAc0=
X-Gm-Gg: ASbGncuaBgjSBv74qgOcMAIM5QL6DWvD203fZb5EY84yyCzWlBsLE2WYTMltN9IXS0c
	ctD6ETHBrqk5ogPXbYV6T1eYxSfJwUsiLFJ2S9Eq2Z1GLsR2TOkDrb49BUoy49ia/0PD6EHqMIb
	+neBhZQyL3frhghLcUZURNWBbZ1UPiQrF6MOdiJNzQMyBKoRCC0GtVIAwf6yV17HJuRKMeCFdeX
	0wDM2j+ifBvhspBfjgqlHW6nPorXyynetub3CgavvUo9lRUXfoZJJYpTMcCH8RDW0iY5EBoJ+L/
	i9zm3DrN3f5ELnA3jSEPab4BMquj9CGbSMveRrtuPpWrKjYLORgUDKuW/S3qlIDlrP/H
X-Received: by 2002:a17:90b:558f:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31c4f5af641mr6697009a91.28.1752275188342;
        Fri, 11 Jul 2025 16:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOA57b5bd6nFUs/a3OF0BCONNKttUzt98H1lAvER5erkT45XFhKpR098tx16zYR8pMEwH+3w==
X-Received: by 2002:a17:90b:558f:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31c4f5af641mr6696957a91.28.1752275187781;
        Fri, 11 Jul 2025 16:06:27 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.227.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb62ef8sm5955644a91.37.2025.07.11.16.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 16:06:27 -0700 (PDT)
Message-ID: <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
Date: Sat, 12 Jul 2025 04:36:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711213602.GA2307197@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250711213602.GA2307197@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=687198f5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=4nqOr+EkFiuPl9GB/B4vcQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6PMv1mg6ifOMqnheZnAA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: xzUUk4VNNH4vLS9hw_GUi3ha632MsuHm
X-Proofpoint-GUID: xzUUk4VNNH4vLS9hw_GUi3ha632MsuHm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE3NSBTYWx0ZWRfX9TSoDKOYJVU6
 iiZfWR0YrX0mTFBjqQv7b4DFE11J5Z/iq7xnk/TWdTmN5JhZKJqf72/c411xlJONxxKoDQgvAjl
 rrmpvznSgeE/zDLplwbDK7TX0NP81s1qOHDbhn4nK14fmYmPEC9q4gJnO8uCZViZVtq4HIH9hJT
 937mBanXSoyNZqTo+mRv4DHVb4fiOt0xkmmUGuKQbsiRcHID57HdDz1EW2tvMc0rFudQn0uPgZa
 EKQ8m8bxVsbH0jVqVHbjVrotcRYadJUVY0c88P3/I15SfIR1tLtvkW3k738tcJEWK/BV8rHDD8B
 LtoRfn4TfuwR5KAukv6R/186enV9ofrdXeo+hCtgHuqaz8mLDkXqmMRozC0kxx+F6GOcVfVVrRh
 NjDOVqBr+WCa7Z1PeLEbf+GOTB4Rnq/xWiaRs/pbIOvAkI0PBtS3rSPcfdzcqthOLg23c75j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110175



On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya Chundru wrote:
>> If the driver wants to move to higher data rate/speed than the current data
>> rate then the controller driver may need to change certain votes so that
>> link may come up at requested data rate/speed like QCOM PCIe controllers
>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>> link retraining is done controller drivers needs to adjust their votes
>> based on the final data rate.
>>
>> Some controllers also may need to update their bandwidth voting like
>> ICC BW votings etc.
>>
>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>> before & after the link re-train. There is no explicit locking mechanisms
>> as these are called by a single client Endpoint driver.
>>
>> In case of PCIe switch, if there is a request to change target speed for a
>> downstream port then no need to call these function ops as these are
>> outside the scope of the controller drivers.
> 
>> +++ b/include/linux/pci.h
>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>   	void (*release_fn)(struct pci_host_bridge *);
>>   	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>>   	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>> +	/*
>> +	 * Callback to the host bridge drivers to update ICC BW votes, clock
>> +	 * frequencies etc.. for the link re-train to come up in targeted speed.
>> +	 * These are intended to be called by devices directly attached to the
>> +	 * Root Port. These are called by a single client Endpoint driver, so
>> +	 * there is no need for explicit locking mechanisms.
>> +	 */
>> +	int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>> +				     struct pci_dev *dev, int speed);
>> +	/*
>> +	 * Callback to the host bridge drivers to adjust ICC BW votes, clock
>> +	 * frequencies etc.. to the updated speed after link re-train. These
>> +	 * are intended to be called by devices directly attached to the
>> +	 * Root Port. These are called by a single client Endpoint driver,
>> +	 * so there is no need for explicit locking mechanisms.
> 
> No need to repeat the entire comment.  s/.././
> 
> These pointers feel awfully specific for being in struct
> pci_host_bridge, since we only need them for a questionable QCOM
> controller.  I think this needs to be pushed down into qcom somehow as
> some kind of quirk.
> 
Currently these are needed by QCOM controllers, but it may also needed
by other controllers may also need these for updating ICC votes, any
system level votes, clock frequencies etc.
QCOM controllers is also doing one extra step in these functions to
disable and enable ASPM only as it cannot link speed change support
with ASPM enabled.

- Krishna Chaitanya.
>> +	 */
>> +	void (*post_link_speed_change)(struct pci_host_bridge *bridge,
>> +				       struct pci_dev *dev, int speed);

