Return-Path: <linux-pci+bounces-44154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FB2CFCC25
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 10:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B2F0301B111
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62213221FBD;
	Wed,  7 Jan 2026 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PN8UjXow";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UQHA+heo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B978F59
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777168; cv=none; b=NZI68oN+9NnUAFih7nKFgZNNnoAacSzhGozVWbbCtOiIk70vVsSEWlH9z2G45S8F1ZwAfLjLiuPDWHd+bd5ic5z620QueXsgLsvYyZxXb2Vncd+yPvD9q/9DGpzW5tmARuR+Na/WcLG54UzVbGeK3Qx8V8LQ+KG20Gn3SLudrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777168; c=relaxed/simple;
	bh=wai+GqvJvFlhPJhzTtgAbQJzeons6MagRjGQ75agA5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulqSO76BgMkau2VH2rUNJpQkl4NbKLnBE3EgNM4z6OB6Kl/0FzaDZAga3FIaOnQT2rD+E9FEPcXoMGfdOGxNXXHVsm97EbuvAqFQGZWk8eRCI04Wquogt2P1b3WWMUYPWAgl4y5wytEhzzLv0oWJIYyR7mtAbGUMbUZiLdLcX1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PN8UjXow; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UQHA+heo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6078MujR1981768
	for <linux-pci@vger.kernel.org>; Wed, 7 Jan 2026 09:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hHAUzxwohVtVS8qEFuX6Wc1xyTV2ML0rdi33N1nF55Q=; b=PN8UjXowzxAvq379
	+WruZgDBAuqdCSnsFmiiDoSslxtVltEPeBg2qZEMBYNJRnv/Mx8vOJGoou9SyTIi
	Atolo/Swc4S7FAy8nYxk4+uV3F9kkm/6HOVikE2B2ubxoa5pRaRc7qhFvQm0xNFD
	QzsZ7oLYFURoZQhASH/elchCInrr1WvxPyd+485q00pFkB0XjwFXsUaVkqw4FjRP
	UUaD0ehPRG/Gr3jbNbS3KUMXgjZLX77DxXERynJseegZGns7IS31b7VU074uL3vT
	JjO6a+ko196B9QrWAjOoJyFStTgjDc4BO8UXW2YkoPr3/NDVZrtetpQoh6x4iTF4
	q/ww5g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhdavhdvm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 09:12:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c6e05af6fso2111687a91.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 01:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767777164; x=1768381964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHAUzxwohVtVS8qEFuX6Wc1xyTV2ML0rdi33N1nF55Q=;
        b=UQHA+heoPLFelJ7i0wIquuYH+pKi1jB2xKZmCh1Xk3RD8DYdk2zjUVmedGxkWGyeK0
         4yD7SCjlh4TTlTpTKBnYgDj+rUfsi2xD3cLRTPc+W5dZ1MGy1M13Gp5PfDQ+vXmfYsLl
         64XJWOhEYff2vbi4O59p+JwWf2WFppIx7+mqYCp34ksVV3px/hDKACAVjZdp2ndXGAOB
         zK2seDaha4v+HlivSx1QhcqyLghljiamyzbsZx6In4eMP8QacXda9FTRBJ/WL8o0AQs8
         VX4cTJqKbpemZPZQ9Qzvrps8GgBTO2P7OD7+RXxufv30lG0a9uEndc+p6uuH+ZA2vqYG
         akkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767777164; x=1768381964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHAUzxwohVtVS8qEFuX6Wc1xyTV2ML0rdi33N1nF55Q=;
        b=uaCHcoSdUCrUHWstwmig0t607zgP/rFpGqIZBwcT1xUjWftIa16fO7LrnUTt2zWDEW
         5fV+lTCEe/kU75upele2oR6N3SlI5w1mqRWrLJoZbGdenAlQxinnfYsdgLuNZmvPCO6f
         5MEtSzXfLPZlJse1bW067Csa4rSUJd8mGBPNxFW2PuHvjcc3PgotK+K9D4WHlT14Lm52
         xojOjSw0VJUl1n8WReDfTutYvoQepO+3WFC0T9DWUTViPCXeeWNFWMuCL9SNzgLM3fyw
         5ig2aqxsPbWBMoMvqJ4t4qmfn73rNTCenfd/KQ/7/rN6rL3UngSDnEicxJiEjToHB3Pj
         tLMw==
X-Forwarded-Encrypted: i=1; AJvYcCUgYtSynJ2g84QngLK8va0k+Jg8RQzdsapI7Y7JUbkBUTx4FXmDpJ4M1WMwYD2Ha71ZvkpaIgVQcsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYc1s/0U1bgXE1oIsZAO3zMjtfFK1wNDK9BoW/scsqHWJKC+rP
	w3VWKEyVAJlfZkjYggEZeYU4xCBxgDhF711VhKtfWVsAgsXjWfmvQV85VbdSNJJD8L8CnohqkNR
	Fmbeip/bBapPEzjxlBEYh9vtavwFWbcVFZT4f8nv+c8jLLnRO9QjuwbNq2RSxZHI=
X-Gm-Gg: AY/fxX7PL0yxJTC5xwi3tAYQbOc+Cv5YwQ/8sVVGyunJILtfrC4IQzXNsROjCCAzIdC
	WpOeTzBrIAvoQCcLvNCO/BBytExQNCfPI/WlruCHmvXdyRYwa5q7yh18zLc1JT8XzzRuNZ9RFur
	OybJeFsUrnZiy/BuKC1C3OEFTCPtYmjb+xu9p90/VxV30W90iFCT+DB42Kwa/+TY5HhmoQgexC/
	0nHosp3tiAPqPCPHdOVEdedLXPgluyiyG+/XbWUu7h0O9E5nbbTOV+6X+Te4u1nLWmMIkf8C8Jb
	DxA6Ycp0FOxs/KikQ0HK5GGAMX7z5ncJP0BdcQlCsAh6f1WeiceCdNv9x5FDlfTRS0XzTdeptww
	KytNiKNkqDaT5qYp1PVUuC/AjUKSAvwf3K9N+KfuJ7bttH6c=
X-Received: by 2002:a17:90b:1d12:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-34f68c4ff6amr1877899a91.11.1767777164379;
        Wed, 07 Jan 2026 01:12:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM6Zy2UFfivjhElXjRRuklrVapne06gvWk7bAjM5RXr3nEWbLf6lxUhBfV7oDr5Z8sqtPPBw==
X-Received: by 2002:a17:90b:1d12:b0:340:e8e9:cc76 with SMTP id 98e67ed59e1d1-34f68c4ff6amr1877874a91.11.1767777163839;
        Wed, 07 Jan 2026 01:12:43 -0800 (PST)
Received: from [192.168.55.102] ([223.196.168.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8afba8sm4418849a91.13.2026.01.07.01.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:12:43 -0800 (PST)
Message-ID: <8d4e73f5-b4da-4aca-a2b2-b607be8c245a@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 14:42:38 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
        linux-pci@vger.kernel.org
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3NCBTYWx0ZWRfX7tDZ0prAjplh
 Pix4/Q4gj67xPqoOmns06rQ/fxWxwX5wHhOZQiLOGGXWlu0j7TMqfmj4dm9ZuBNsRjHFufUfwas
 x61W3IxuFWlzoTivgmHcskLlYclvbDHzvx/rsksAZxIAawlXolCns52Bs6FRDjZB8FJ3Pu4hrTB
 k/qNfkx6Z68wtnNUt2GDWnUXZa7s+RbP1kjMqH9KlONfbYIU5Pxc1aUXEyD1wgwRruYbXYNdKri
 +bngD0eAXRYXnewksen7f4ckYmh6Yvp/rPBg/JPQBLRQGwvEQ457TnV1UK//eMSMPTRfRLFcLM1
 JcuoJ16uITNLqojGpkfw4ZrFSU780PUoHCcNFDqeXVT5TPiXYAXGW9W5wbZhe7U9m3VdWgNo5Mp
 1mh/GGxsMcvTcuKjD/BW1NqUqZ96VUEkg5Q75sHD4R/xsxT6MzzEajyWTY0wXWY5MfxZsyFjSo6
 z88w+Ihx3Z2f8VI1JbA==
X-Proofpoint-ORIG-GUID: 1l7QwS6Ch1wjMANbeoSYifkTIpYxZVfE
X-Authority-Analysis: v=2.4 cv=comWUl4i c=1 sm=1 tr=0 ts=695e238d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=N6F11WvAWHOX8D43ukpQPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=s8YR1HE3AAAA:8 a=qaNWRtGRZj0PP8Kx_68A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: 1l7QwS6Ch1wjMANbeoSYifkTIpYxZVfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070074



On 1/6/2026 2:48 PM, Shawn Lin wrote:
> Some platforms may provide LTSSM trace functionality, recording historical
> LTSSM state transition information. This is very useful for debugging, such
> as when certain devices cannot be recognized. Add an ltssm_trace operation
> node in debugfs for platform which could provide these information to show
> the LTSSM history.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>   .../controller/dwc/pcie-designware-debugfs.c  | 44 +++++++++++++++++++
>   drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
>   2 files changed, 50 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index df98fee69892..569e8e078ef2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -511,6 +511,38 @@ static int ltssm_status_open(struct inode *inode, struct file *file)
>   	return single_open(file, ltssm_status_show, inode->i_private);
>   }
>   
> +static struct dw_pcie_ltssm_history *dw_pcie_ltssm_trace(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->ltssm_trace)
> +		return pci->ops->ltssm_trace(pci);
> +
> +	return NULL;
> +}
> +
> +static int ltssm_trace_show(struct seq_file *s, void *v)
> +{
> +	struct dw_pcie *pci = s->private;
> +	struct dw_pcie_ltssm_history *history;
> +	enum dw_pcie_ltssm val;
> +	u32 loop;
> +
> +	history = dw_pcie_ltssm_trace(pci);
> +	if (!history)
> +		return 0;
> +
> +	for (loop = 0; loop < history->count; loop++) {
> +		val = history->states[loop];
> +		seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ltssm_trace_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ltssm_trace_show, inode->i_private);
> +}
> +
>   #define dwc_debugfs_create(name)			\
>   debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
>   			&dbg_ ## name ## _fops)
> @@ -552,6 +584,11 @@ static const struct file_operations dwc_pcie_ltssm_status_ops = {
>   	.read = seq_read,
>   };
>   
> +static const struct file_operations dwc_pcie_ltssm_trace_ops = {
> +	.open = ltssm_trace_open,
> +	.read = seq_read,
> +};
> +
>   static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>   {
>   	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
> @@ -644,6 +681,12 @@ static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
>   			    &dwc_pcie_ltssm_status_ops);
>   }
>   
> +static void dwc_pcie_ltssm_trace_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
> +{
> +	debugfs_create_file("ltssm_trace", 0444, dir, pci,
> +			    &dwc_pcie_ltssm_trace_ops);
Can we have this as the sysfs, so that if there is some issue in 
production devices where debugfs is not available,
we can use this to see LTSSM state figure out the issue.

- Krishna Chaitanya.
> +}
> +
>   static int dw_pcie_ptm_check_capability(void *drvdata)
>   {
>   	struct dw_pcie *pci = drvdata;
> @@ -922,6 +965,7 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode)
>   			err);
>   
>   	dwc_pcie_ltssm_debugfs_init(pci, dir);
> +	dwc_pcie_ltssm_trace_debugfs_init(pci, dir);
>   
>   	pci->mode = mode;
>   	pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5cd27f5739f1..0df18995b7fe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -395,6 +395,11 @@ enum dw_pcie_ltssm {
>   	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>   };
>   
> +struct dw_pcie_ltssm_history {
> +    enum dw_pcie_ltssm *states;
> +    u32 count;
> +};
> +
>   struct dw_pcie_ob_atu_cfg {
>   	int index;
>   	int type;
> @@ -499,6 +504,7 @@ struct dw_pcie_ops {
>   			      size_t size, u32 val);
>   	bool	(*link_up)(struct dw_pcie *pcie);
>   	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
> +	struct dw_pcie_ltssm_history * (*ltssm_trace)(struct dw_pcie *pcie);
>   	int	(*start_link)(struct dw_pcie *pcie);
>   	void	(*stop_link)(struct dw_pcie *pcie);
>   	int	(*assert_perst)(struct dw_pcie *pcie, bool assert);


