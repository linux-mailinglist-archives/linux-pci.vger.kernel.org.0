Return-Path: <linux-pci+bounces-43253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B78CCA99C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C8B1300EE53
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 07:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487E28136C;
	Thu, 18 Dec 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ac5cYdg8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khuwt/vm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AAE1BC41
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041941; cv=none; b=DSqBovOzYwEm/X+FvbVR+PI3wq4TFuDR5JxcQl7PLtC7IckcNdzYl9aORQY9bfd7400SQY7oyGXzImZIiuY8MLkqldL9vTu0+m61a6TTwheL5jGtx/eXxJkUTDMPGUqsUoDtgN7DdFFp8kNOPyKSbr4dSVfmfJveV2tX5UBxV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041941; c=relaxed/simple;
	bh=AN95OchgL4d85AdNcxmpNW7QNWoPIQ8PBn4+l4FvOdA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mjVYalBVrWbuBL7m02Ervy+qBmb7YqkcNW3RLKxg8GThWU3wBzCCtvsGWihwP9JqzG94aFjmIRfJzA3LiuL/bjr67mzczhrKnMdhalxLTMFm5BLLyHqUWPIlEYEsPeN5ixtv/nv0xuxOaev22/82WtSSc43cMrOyQpXysdBjNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ac5cYdg8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=khuwt/vm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YUCa680516
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahhQW/xS+HGo8BV5zZn10IecWFFHyhVHUWfbV0Q/7jk=; b=ac5cYdg8VM6QJXvT
	p41SJ9GrbdL6Nzdjno9pflgYeYTA8EV35BO5z2F/C6lq0d14j2I3dh87hhjixM7F
	gH4sGSS9P14qrllnI904peHfLKDYgcH/s6/cHCWL2TKdMcxpWMTJOG8bqxsKyPUV
	mxPs7xMfOH+BnkIjF5wOvFfYZJOZYMzHM6yOmC+i3DzlIdZf/Qqx5fbUvH3txJGQ
	9x2QD5/E0A4RI54+UeBnsfIyH9ifhrUFYr3RXfy0Lft4icE/19ADbzAIHkYUfwHz
	5tDGbK7FEdeyaon8YkZilpGBIxCoOyG1iL0ZZ0xFLYyHe77RWhMHWOBvUw/0adqv
	zsl+dg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45bhh73w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Dec 2025 07:12:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a99a5f77e0so638491b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 23:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766041938; x=1766646738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahhQW/xS+HGo8BV5zZn10IecWFFHyhVHUWfbV0Q/7jk=;
        b=khuwt/vmxDo5hE5yuxInZCv/13nF0VwXPTdvsP2zwYVa2zcNmRo2h05I2zaX0f+72e
         QZnZQL2x3jz3hxwcmynniQzc7Ugg3qRUk7wZ62rbLKyVf4pyr+GwIKGAyBQ0GWcGk8hp
         YV7DjgOSHENp5+Ur2Mm/TWmPLwQe0YxZqREQdl658q+bmTkA6i0bztvSKEzE12waIFOK
         kVJ5h2PTU4XazWGNOGZSoB5LfQzLMRFhXM8Vhq4a5qlhI6cz6dKGzgQRSgt/Qd7w8hCA
         yOmSQZuF0cjah5zZ8wZgvyCxK76EWHoL2Un7vvtPPl/Yb1pc2Ia8phz0GIUKSMC1JECl
         M/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766041938; x=1766646738;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahhQW/xS+HGo8BV5zZn10IecWFFHyhVHUWfbV0Q/7jk=;
        b=sK3yhJKODksuDDtf+sIcgfO5X7fWwVO1cQhb/K3a/lOduyAMbuYICanr1xaxbnLLAa
         J1qx4hCSvm80dQQbAkrQvzrTcHw00ApylQuATDikGVXUl/qO9V8h1FapF3ULS51VdF74
         yO9WxZw/t8uaWVnpKLGfZinZhAyf53RVMs61JIXLT/cx/dU+L892qbD3/MbdKzlqvGtz
         kj8PmWX0tjoCUBlQt2M+n+mKEx29PYZXebktwSFMAR3YrwhQ0pMUYILnPRYY07dORPUX
         v/u0O8yYj8GqzSIc205+Ityp4jkXMRHUib17Z0Tg4GojfPFQEAgpHw18vd0Z+Dr66ntX
         V2Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV7O9DothCFC43Aq+kTl9SuBQF/l+afu2zkBGAOmMfvDrxOsXK1wNWwvHMZh0lMNQrrAMzENM4TvMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVnFb1BVajPz/MD8KYZDZna7eXa5jtHcnuVipMOWCcENxodOgN
	pgvRCqisv9505+j2XmP8+cxZmUsQ+rQPt2ygvSdmGK90FiCEVyoIo0NdrCOglLkrnAIkzDL67s6
	IgVS8W75VKEWm30Hv8zm9ScrgQKW0fx1IhvTyxn6/igCLF2AuqIerG54gzFcywEZ5v6LbAv4=
X-Gm-Gg: AY/fxX7IdGaE5X3RRp6ieuO3G8s7sApyN/fmKUS460KTSVD0wmLmijP+U5vc6XBp2+0
	RGdvsmUugDbR6NDD/asP6Q2DqNOdEf729opm19ZChVQce0aKwWJlotd/SRXR1OH8dIFY/F1bNla
	upee33QdUaW0m+K6CYng9zuCKp+LCQHCaSphs3vBRWP1CpmUp0Vq7VXgwXxAN8cvxGGpgVn+yu/
	AJjRT4L1YVsW2PSG82TEclOJZPRkw9dLcSCGHAaw92A9VTcGS38AJzZtD5g8N1/93MOvkETzQ57
	JUDYq9bTbcm9ycDEmTPGzQ671lcI8j8xYgI5UJlgZZhSjttXKXmedemyQ+jXue/YZR7tzjzgIqG
	Bm/kPCJ9xdWc=
X-Received: by 2002:a05:6a00:3696:b0:7ef:3f4e:9176 with SMTP id d2e1a72fcca58-7f66969f9e9mr18140532b3a.49.1766041937650;
        Wed, 17 Dec 2025 23:12:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG11rF+3NKr1QQWhXJyxJqKYYwR65DHW2sTsWEIJ/HZEjaTc4mNS1eB0BLsCSK/AF4hase5wA==
X-Received: by 2002:a05:6a00:3696:b0:7ef:3f4e:9176 with SMTP id d2e1a72fcca58-7f66969f9e9mr18140511b3a.49.1766041937214;
        Wed, 17 Dec 2025 23:12:17 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fecdd3e10fsm197516b3a.5.2025.12.17.23.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:12:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        Haotian Zhang <vulab@iscas.ac.cn>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251110040446.2065-1-vulab@iscas.ac.cn>
References: <20251110040446.2065-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] pci: endpoint: Add missing NULL check for
 alloc_workqueue()
Message-Id: <176604193414.795334.4365952101287468707.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 12:42:14 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 44NB7AB9fsRnx0nsIgBqmz4KLZTRnZAo
X-Proofpoint-ORIG-GUID: 44NB7AB9fsRnx0nsIgBqmz4KLZTRnZAo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NyBTYWx0ZWRfX4v28IvUuqebg
 VPLDrpfYKB6RbzZ9ZPZbPkbFpVdZXS/DtZWoSz2lpF1xr4zbCLDHlaZwy+EoeRe8oLAwKiqD9TZ
 ke9EJEV4iX/C3IUirJ2pMsIv95hp9l9Fr/INv5K5jeZHi0bY5J7DH9yXrirmbj8yIKPKQFEvJ3G
 BHzBHAQN6y83Qt0ZcqaprZYNMFFF7itQkfcaIVpe3ixFV/5qpi2quwGpJ88yqI21XmSuvB+ffhx
 jUTX9IAYnO8XCXt7vG/Uewu1smZlOqLZBoJgVmuuFt4dvW4m9DZMu6f1drl674QV4mya/+VQRtW
 sOkPfzGccTFHjQK88Ec97ZmRtFUQBkWV2raMr65KHxRsmpgLDa+mowMU3cLVkzN0QNROK2tQqFc
 l7DUYlvbM2S8x8L3IuvflV3KpWr/wQ==
X-Authority-Analysis: v=2.4 cv=SZr6t/Ru c=1 sm=1 tr=0 ts=6943a952 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=2AY8z-vqmeJrc45qOLYA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512180057


On Mon, 10 Nov 2025 12:04:46 +0800, Haotian Zhang wrote:
> The alloc_workqueue() function can return NULL on memory allocation
> failure. Without proper error checking, this leads to a NULL pointer
> dereference when queue_work() is later called with the NULL workqueue
> pointer in epf_ntb_epc_init().
> 
> Add a NULL check immediately after alloc_workqueue() and return -ENOMEM
> on failure to prevent the driver from loading with an invalid workqueue
> pointer.
> 
> [...]

Applied, thanks!

[1/1] pci: endpoint: Add missing NULL check for alloc_workqueue()
      commit: 0a19a6d9ed65ef7df845c32befa994e45620c12d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


