Return-Path: <linux-pci+bounces-44885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C40D221AD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 03:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33F0230039FA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 02:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A629A2;
	Thu, 15 Jan 2026 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ly4cuAb+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghD1Ekbk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D71B67E
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768443389; cv=none; b=UHRQ2dpr3b+oGmBROEULKdApksZ9vxwl7140pF3zg0oBABEdCSw7UBV7IxFtqFIvwh7fdkcpaD2smjFdvQDhEBGVfmdUTdy7+FDFJHzcEZwVT87xGtJrRhLPHOAGFlIrGUCTyHppSOfh5AGKI/7FzaNKFIMK8262j/SOIIy5JUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768443389; c=relaxed/simple;
	bh=oX5+1uLOn8pPtzqRYnXngxMaYs3vqEhWezhWsGt68/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/Mzrb7AH8FeS/mEMvTt9Xz+CSaHTqzZvdXNS7tE/XYsxF8Dl2AYLnGqtAnUYiKp9p1+IhCbfNQgayl8YWMuOoWokTVHQprJrCQJG92FIGroIkb7dUMZUB0D5soZg3/meTq6bZI1oEW6/v5Xc3mg17XXnTn9DszuluZBMtQcoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ly4cuAb+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ghD1Ekbk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EMgXBH568702
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 02:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y6Nz50atGe4ppbMfJdSspqFK
	hDiCNfLuXTq78OiHIm8=; b=Ly4cuAb+gE5B+z36T4mwsz6tJmefkbZMWKV9iEWY
	/ofcZF55Hj+hjytzF0J6qWrAAuLwGAmVJUtporSSUMP6/p/j4THmQ7Rywi7jVBCc
	weQRzH3Bo9m7LYTyAWIFw/IiadUYkp48NR4EKg5nYdBXEeo/XZcCkmw+77ehiS5c
	1V7YkTYgKGQe15k78tIbL4QsAerPJzMiygeQO9LuwHMO9x2l6o8OUL9BnNW3ZL3+
	BRZeXBzGevBbIoI7taWWTn6c+L9/+VoxJsIPKZ1WJCbp/ctJ0vuOByJ9ul6DP/RZ
	2cmn9CtZTZWt6SGdmRZnkygL9Y4L4mkqH1kwyzvdXT40Jw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp9x8tp4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 02:16:26 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b062c1aa44so1244473eec.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 18:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768443386; x=1769048186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6Nz50atGe4ppbMfJdSspqFKhDiCNfLuXTq78OiHIm8=;
        b=ghD1EkbktMwpDhg/JJCfc1K/O6nNCVUU7qHHAT9mfreUOiBzzNEG9CDv4JRrJqTdzC
         W/wMg1sF9/Sx6scbT8Xaz4QnIANWb4wgpbWoonuaSwWHj4GfNnuIg7sKkJrg/XHRK4rl
         TVKD+uykxnncjnSbJ4X5t/P2wSSJ7e/2qFp2KWqyCsHtTvXopLLCL5wwoVV14SFmyf1v
         nZxjSIiwNivKEDBW7z6X4w6MQTT0q1Vm4cJZV1SxmDeiYosPuGHh5h2zEGG5cWNVM+sX
         tQLncxdCSPLojbIKaJHPWnN5YgBhQgLpRwJyScVxEQUNt7zmAoZoEPSYCQfqLF00MujC
         PeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768443386; x=1769048186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6Nz50atGe4ppbMfJdSspqFKhDiCNfLuXTq78OiHIm8=;
        b=kIgP2vnWMNjIAmULLVKGm7+0Hc09iI0TPaZ1gPT578C/zVav1ixEJcwz0CjyrWTPoV
         RnkNHp6VfMtGP47oqmDawu6r8i1kxTxnUndwxDvvmSOnwcgaVNy+HAjPbzkn92tRu+PL
         zFudif80N5A0kIaXSy6EE4D1cIuzX4BeJ81FSPck4U8aEEtsI1YivOHxPQkXG/89bTEs
         iis5s0kX08r3lZduAp7oOwSjrkWgHys0worLoGE9vBqWvtLazlfHnoBvde6EMXyWM1va
         e68cJAHoD5dW6KqndSOA3QnI4K/T3hUZKLpx8uYhADKmYs/fmEQhtNvXxfnskEcIkzjg
         kmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyGeq1wAdSV+Yu//14CTaCtYzA7Xh/NabBNzQgD1CLco51OpSmalAqok0J10NIg+yYQV7b9OKcHP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwesOcne10g5WtpwMYySKwfIslKrHNuHaiS1W74dN60uLzj888W
	AQ7XZjRQqxD7U71xA4Tek0n/tbfOzL63moQtFgFgNZcNvE7EBa6/MYEUTh0omG6f7fol/VH1ZTD
	mibZm7CiaWuJMXcS20YUQIcqFOLMUky+1cEEEA3GvXffp2mdrJ6YNTC3Hif9nd8E=
X-Gm-Gg: AY/fxX5nY7nbifSuW1G6NYV7/TStHWZGKQ6zsIjoWFAdf3mNkjnwo8jPaaL2tSNuNqt
	6yaSRiOH+ieJ2GeslVI4JUz/19k3Bg8NOSLebqXILFVPZvcf9l/a0PUBpsa/klMX5G0EXC1dj42
	DV4iO7Qj6He+mITMrBwu0mOihI89p+EwIkmjURlzADXoRvkAKgw0cwBSR5A9I1BcRUVs7PFQDQ4
	ohwCHBR5xZjQpSfYMI6GlGX97PpK1nBkGrozibQl9pIzsEBAsn/ATpQCEEfuVqmOsJz/OoFkTfQ
	1vHSu8cbWpHoJCRT5KyfMKTnTilsDVs2lQOCsW6N0pQuCrYjWR8rdp8GR34WKsvVLthuTqUPnS4
	C45kyuB3goMN5u+Iv/XHVCa0foJ+UhCIUSyjYCfe9kDaj2C/8TjKAEdTH
X-Received: by 2002:a05:693c:3944:b0:2b0:580b:856c with SMTP id 5a478bee46e88-2b486f68038mr6473607eec.28.1768443385643;
        Wed, 14 Jan 2026 18:16:25 -0800 (PST)
X-Received: by 2002:a05:693c:3944:b0:2b0:580b:856c with SMTP id 5a478bee46e88-2b486f68038mr6473559eec.28.1768443385055;
        Wed, 14 Jan 2026 18:16:25 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6a49173b2sm293974eec.31.2026.01.14.18.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 18:16:24 -0800 (PST)
Date: Wed, 14 Jan 2026 18:16:22 -0800
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
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
Subject: Re: [PATCH 0/5] PCI: qcom: Add link retention support
Message-ID: <aWhN9nlsma5T5ixf@hu-qianyu-lv.qualcomm.com>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
X-Proofpoint-GUID: kX3L-tg_r0f46j9-owQy7-W6i5BzoJCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAxMSBTYWx0ZWRfX6ZPTZvVzslbf
 U9RrQYMudsQ8ep4BfmqhwvQpto1Vheq0eant9vI1ZQ75js9RkiAlgBD+T+ASZDJc/4mlhUD0AR2
 7lbwLNnoFQRHYmEgP5KdblA2uxu9vmQWjUMfJhjjiimg/VFbHF2BsH6lAjIXcH6SeNScsjJ2mTV
 RBKzKSGcUaYGH1oGAEdZQL+CidgOv06dcK4aeS9YmLHn6evbRkiGz6dVUcjN/IjVQHMyzKED/Gk
 LtsxnaYPaNKR+tAlJ2XV8e3W4EdM0oO8+z7XydiB+Lx67xbD5mxnBpzQL37Svk39Sbe5L2Jo864
 UUufOqIvwSdI2LETLIU/zpAyxBlxrkgLFDKEUuKc/5WYU8i8Q4fTfctbIuVV1SHmDCIWk0TKceA
 G0do7VNUZN8RVsWTHuFUJEITzeInewArSggG/K/a6vi40NAKHri2/JFsT/Aw1BfAGWMLnywUC3b
 3XosA+6G8RszoTTVuOA==
X-Authority-Analysis: v=2.4 cv=HY4ZjyE8 c=1 sm=1 tr=0 ts=69684dfa cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ietwBVO8KLLdgrj2ZJ4A:9
 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: kX3L-tg_r0f46j9-owQy7-W6i5BzoJCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_01,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601150011

On Fri, Jan 09, 2026 at 12:51:05PM +0530, Krishna Chaitanya Chundru wrote:
> This patch series introduces support for retaining the PCIe link across
> bootloader and kernel handoff on Qualcomm platforms, specifically
> X1E80100. The goal is to reduce boot time and avoid unnecessary link
> reinitialization  when the link is already up.
> 
> We are not enabling link retantion support for all the targets, as there
> is no guarantee that the bootloader on all targets has initialized the
> PCIe link in max supported speed. So we are enabling for hamoa & glymur
> target only for now based on the config flag.
> 
> If the link is up and has link_retain is set to true in the
> ithe driver config data then enable retain logic in the controller.
> 
> In phy as we already have skip init logic, the phy patch uses same
> assumption that if there is phy no csr and bootloader has done the init
> then driver can skip resetting the phy when phy status indicates it is
> up.
> 
> Problem:-
> 1) As part of late init calls of clock & GENPD(for power domains) the
> framework is disabling all the unvoted resources by that time and also
> there is no sync state to keep them enabled till the probe is completed.
> Due to dependencies with regulators and phy, qcom pcie probe is happening
> after late init which is causing the resources(clocks & power domains) to
> be off which causes the link to go down. To avoid this we need to use these
> two kernel command line arguments (clk_ignore_unused & pd_ignore_unused)
> to skip disabling clocks and gendp power domains as part of late init
> for initial version. Once it is resolved we can avoid those kernel command
> line arguments.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Tested on Hamoa QCP and Glymur CRD, so

Tested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
> Krishna Chaitanya Chundru (5):
>       phy: qcom: qmp-pcie: Skip PHY reset if already up
>       PCI: dwc: Add support for retaining link during host init
>       PCI: qcom: Keep PERST# GPIO state as-is during probe
>       PCI: qcom: Add link retention support
>       PCI: qcom: enable Link retain logic for Hamoa
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++--
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c            | 62 ++++++++++++++++++++---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c          | 28 ++++++----
>  4 files changed, 83 insertions(+), 19 deletions(-)
> ---
> base-commit: fc065cadc7ed048bedbb23cb6b7c4475198f431c
> change-id: 20251001-link_retain-f181307947e4
> 
> Best regards,
> -- 
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> 

