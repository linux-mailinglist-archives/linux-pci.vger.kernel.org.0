Return-Path: <linux-pci+bounces-44346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEFD082AB
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 10:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98C17300644A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 09:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D132FA3D;
	Fri,  9 Jan 2026 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IkZmnFp0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aACiz/7c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8713590B5
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767950608; cv=none; b=aRxL/Y2K4vvJJk4yho7MLiceBOPAFR2rrn+Qcgsfxtl/fN8Ov/vpjCHCoztpcxSy57TPGi3MvmPE62HgKU501cSTweqTunoadvkF3inf67cDizVeAhb5vhB9VuWx0coFS2IsfOoWUVMttjq17M1LZhEadH/5d/PEJjjj2nahnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767950608; c=relaxed/simple;
	bh=quyxddBCJbdfnj8ezjVDIXfGNJkfQjaJBRecYk19f+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ1FZrlhz8G3DuCNR+Kv1iAxYXJoCx4+D20uUt4J115/b4ox8eRP4l3BZp68flXAcAPoexnyRZ+CWFwe1IO0v6IMau51rP0H4Hen0Zyy1Lq2ZpAoQHiDqjUPbQmJInp9G0qSCWRAWr0PonRZrybZNFDjBU1qLIfsd/4esRJGPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IkZmnFp0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aACiz/7c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6091qTIp3324889
	for <linux-pci@vger.kernel.org>; Fri, 9 Jan 2026 09:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gbUKEx6h2/06Jgs052NbO21m
	OGxgS4o/wlcmmWs0HKU=; b=IkZmnFp0ssSEw2M68/WhsH1X67QSMzV/C5LhtGce
	qKCNDI65tk0PMOFBkqxJWqBWqgfEBi2RQWbc4paLZz+fV3alGtMUM0PJcMOJUu9w
	q1Q/z0wmdH45Wyw5A2eVXDTkUaj3neguS08kB2okCa0jn9cYqC7g62A9XsiyIpr8
	pTH9eYnf0AVV3/nWDrGpb94Aqe2Dbf3mNpFvNdNIui5eJtRGtOZ5+Wcw7uFi+FsE
	eoDYqNCIgmSnjOt+SRW34+KslU7aIOuCNEILlNBk7sk9/uGivfRsa/YysrDni87a
	DfHdhmnRQOKq9/MIa4ExaCIaFjR0zGRkMB4So9NfuuEAoQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6h7gd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 09:23:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b19a112b75so983580685a.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 01:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767950586; x=1768555386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbUKEx6h2/06Jgs052NbO21mOGxgS4o/wlcmmWs0HKU=;
        b=aACiz/7cnFp+MDLFFX4jFooYyEvVK+apFyKE72gOK1dIt/0ozDIFrT8+KpqrEcYQ7n
         GpyopJQaCSs93c+KQsD7xFjW7X6vC3JwchOPSUbS4iqpUURwW2fqNv3X6kp+S7EncFCU
         0PFAJsdwURM6NANhoTeNu6DrrWWQbD9Ylm8aKTFTPFsLa9b8fruoJby86soiFtHM5jZy
         18C93q/M+S27FFAEF1YDwpytGjCAzqKEN+5XYZXfZQvarPjf/aMWJ4ZkOYjucIGiskMj
         qJmdryU1S5S6MVwDMgBG5vCSk0qWmeCws+EINA7FxmjWuKLidsfn8ZioNAW2f7bfYUmT
         lyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767950586; x=1768555386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbUKEx6h2/06Jgs052NbO21mOGxgS4o/wlcmmWs0HKU=;
        b=JpPhK5V3obAjQetfmO8V5N1haNsZ+Yao9P+/XoqJnKS9wavGnhjiKffBBPVBA0P1xq
         IU6TTZooflvFcU0Si+MRSpYfF814ckdmP08o4/dg95pj1AYmz2XaIePPfPsw1dPF98Zq
         J06fDlkrJXdp4v7vAqXoRcJR9NtcnXQmdFxhzQSKOImH7IGXGGHaydyYRPQg6nZZXXDu
         KZPkFoa6I/YSYNN0c7dn/jJN3bqtK3iaGn8bWdoiJ2Wxfqw/DpCbyDBdoTdDrAn+/0CQ
         znA79bUwY+B7Y3vKNsd1gUS86okXv+9YL607y5s/IKLJwRMzmSpe9LaCpnCkD8J0rVYc
         bWXw==
X-Forwarded-Encrypted: i=1; AJvYcCU4X2U3R3JzB4lymQawLOc5YTktnl3jG7t948ngKOKc/weAKihuflN5yIgKIaVlEhyYWyCtmKzYoB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsW9SK7kJD8Js45CHrXjCUXTQ2ArvFtK3Yr3A5Jb6qTrAyGXL
	TLpTiEXZpfnm0Y4QNKQQpxUZs3ijvqgbeZ2EGMNBBVA8sh8bKBEHXDSy9JJ+D6nr7xhvqspBG1Q
	smsVsdIy4izqH+fVCiqO/CnsJtdIFsXg2ksAwF4jMDV8lUl1UFOeJqoZ0WEHVZXY=
X-Gm-Gg: AY/fxX6pnm6KjTaXoT7oS3SEKAQwV3Omsc6G3t1gVNoDsUm+MMJpCDsuuwUME9c9H9I
	k62TjIZWzEvorjEQTNdvZkHFme3DNKIwv74OSDdPvsCAhLwAToGJJTg2YSTloAtqVmjzqexyxi+
	I/wR3ZRJtSlX8hZv6ljkVCvAKXt6o9BErJgNDmcaey+aepyJVeFe0pqzxH+XLt/kjkm5QQhQ/U4
	FRJoWd1G7XLSAlokSc0MBh5ttc5wN5GEhP3yc6zVPYdYzRHlnoifXEoMVJUPZfsoFnAgcPyKhzN
	SByjntkxhJQU+mgFY2pLDrLKbIlVSHumY6DoRqJA0gZgrMcZIt80yU1zRQ8quFL+3Frvaxs98FE
	reZ704bppS9bqDlPtAdLw
X-Received: by 2002:a05:620a:410e:b0:8c0:d16b:b0a7 with SMTP id af79cd13be357-8c38938dc0amr1108936885a.2.1767950586024;
        Fri, 09 Jan 2026 01:23:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDhJ4s/J+LZvq5xGGHQag3lnHCUa0+1Z4v9U1tVSQgONvR2YU99W2TOhbQzi8LO6OYwTHnkw==
X-Received: by 2002:a05:620a:410e:b0:8c0:d16b:b0a7 with SMTP id af79cd13be357-8c38938dc0amr1108934785a.2.1767950585336;
        Fri, 09 Jan 2026 01:23:05 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.7.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2340a2sm1072317666b.5.2026.01.09.01.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:23:04 -0800 (PST)
Date: Fri, 9 Jan 2026 11:23:03 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/5] phy: qcom: qmp-pcie: Skip PHY reset if already up
Message-ID: <3h7xe2k7iis4mmowvcq5mghneyyk64epcs2hg7fjrpowl6omfu@ltf6vi6mtx36>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-1-7e6782230f4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-link_retain-v1-1-7e6782230f4b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NSBTYWx0ZWRfX3QTrL14CHiE0
 8VkULxxUJXCM/Fs2EzXIKqkFs4waf9uzA/yInlZCFQcueWoMICg+NZKYeN8Jm0Z8ddFlhGy3eKy
 nY9vLXdlFC3+N64YCX8bPcnCS5KI1ph+Y0nNcsZblbOLTX1qawk14ezH4QmIzi6hXnbNrIlE/aF
 doZ/DVFH6KiFpQ9etNPh+k5hWBlglhcZaRxXz8PVOz82Pk9kE0cTw2/d97yXgn6lilNDYYLxiyb
 gesd2WdPRWY+oc6GuPLfwpvdgs4WrbVXd2lWmu9sPCyWRELZrCASANmz3ibtFoii9MJ5a+WStqG
 03NGPvnWD7SjIHTvolWMaLM7Jr9wAjsAOZsDZY2aRRlPf2RfI3xYELumCdYbpR3l7fVuKZkvB1P
 d1TBDfc6S+zzsVef6TFVIPtAAnrGTnG0oXjP4mPaIz0PTAFUiUvwNiPfp38DzAO0IS3WNvBWW6e
 HGwBK3wW4P4CTLYY9KQ==
X-Proofpoint-GUID: lcspUuYfjewydZ8-vieEqvMBu-s9l2YO
X-Proofpoint-ORIG-GUID: lcspUuYfjewydZ8-vieEqvMBu-s9l2YO
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=6960c8fb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=hZ5Vz02otkLiOpJ15TJmsQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Q_-NVal78LaQRGvTYVYA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090065

On 26-01-09 12:51:06, Krishna Chaitanya Chundru wrote:
> If the bootloader has already powered up the PCIe PHY, doing a full
> reset and waiting for it to come up again slows down boot time.
> 
> Add a check for PHY status and skip the reset steps when the PHY is
> already active. In this case, only enable the required resources during
> power-on. This works alongside the existing logic that skips the init
> sequence.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

