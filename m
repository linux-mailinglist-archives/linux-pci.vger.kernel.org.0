Return-Path: <linux-pci+bounces-43641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB8FCDB77F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 07:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0934B300C0D2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 06:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE42D3732;
	Wed, 24 Dec 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RbncKnbc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XHhBDZvl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F523EA83
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557253; cv=none; b=Lb/pwN09ccRF4WLX1x7/u9Gb6w/oX6aOkU0qpGyBNuIRdO2fbI1LqdeUMbVLDuUB8bvy9ePT1chigeLVpPYb35y/5FW/SSfWXJWqtBBCPg04gH9AYVQccBZIctIU6JpeJZCxXmB0NVEoNir2DPcLgm1wGw/P3MpxvjA9UrLTmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557253; c=relaxed/simple;
	bh=YEu0N6mtsX+78cD/CmPzoRJXQWcn88nSaLemCI2Qcz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWrU0rr7w8/ohugMYXYMKc0NhM8Y170TivTP8typU7Dp5mh+nzG7YHIp/FmI0OY6DBfXwluQxH3ABpzhzpihAQyaiY83jZR5IBbEwYv98GUGDpvW1VrOjrt067PnRRH5wmOHyA0nQzDV+7ginW5lCFZ9inKNqxWowhTzfeMGNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RbncKnbc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XHhBDZvl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO24ark461397
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 06:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ud2Hux0xDTUlgWj08/z4AcHL
	iSpvn9bJIK3RFYzsRn4=; b=RbncKnbcKlTMI/eDjblTwS0S2SaV2ls4OZhu2/db
	2h4Pz4jI+1AV4ZEoH9TNcbs3wD4SlJflg0xiijJivMm1zz4iAMWL9D9pmibguGO9
	5TDCh7b4ZL1N4XNApWl6bLo4BDtvsh6ArnQUZGQ/owaI+iWTicrUrt4dq1M+j/kj
	rWUZfc/bV5mNGo2t5eFc2k/VUh7QMskdoR0YXnGxaUnsjxxn7oChcyiGNQ1mBIrZ
	ExdooQqK6FTzmJYhx7TANjaxl/jxLgtB2drAVco80sKY5AAkFx0Eon0b2mT9an2L
	F3ugiHbLSsvhoOgV8C3YGAYKBEv7uBroUW2FkxoEiM+NhQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7w8fta0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 06:20:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62da7602a0so5809359a12.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 22:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766557250; x=1767162050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ud2Hux0xDTUlgWj08/z4AcHLiSpvn9bJIK3RFYzsRn4=;
        b=XHhBDZvl6kjXP8rs8hqZj0GWDFsFtbskso55dFY6w4WW/sM8a6JNZ2g+G+fpYKE/gw
         XZts9TQTYSfK6kZBvixap9xQkN+oNFx+tepIFta/HIxpI+q8pa3RMgPHEuKY1tNSP7VP
         THSHxEwni9qXrA0TwO3RxRMAZJshhfOVrmUA61Jo1YSj8G7Tv1ZZ0bhX7tX17wMj5E5Y
         IhSHz9JTTqHhHl3g0Uad8isSSalr0fWJWuYgn1ewqQqEbQGZ/+1jw2aYmaKD4szgq8mp
         A+gi43AVGpPpezWcBnI7ueVygz+5+9aJ62zqkrD7moHX06TFcLrve+o0K5RsnkhyFSyX
         xECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766557250; x=1767162050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud2Hux0xDTUlgWj08/z4AcHLiSpvn9bJIK3RFYzsRn4=;
        b=XgpB3iuBpjOAescTdE+jhOrEIVlGw9+9yGsYAwRiH5WK1ZdAstCwnS8Fv6PYcgMxdQ
         VgFRZy0dBd/X9PeUCplktMK4kfPYfLv5gQXHZ6GjyPs6Yhebg1Aexd0Gip92HG245Wk+
         erM8vpBJprkKQ/uj2WrXpRTLdJsDrPGk2JmLv/9zBFx0GE5pkoWDKkv88NMungFW0H8p
         kPiPs9ZIXYOQ+h1CqedVxTi7CSTbJVw6x2SSEG0LKxGSjE+za2860pgx3GIYWepwALVj
         WoS+iJ1FULC7xLms/bAeEyFjVz+34V7zfkgrvS3rNh4jaZhIxsR4yKwl/n64N2Of+RYC
         LB6g==
X-Forwarded-Encrypted: i=1; AJvYcCVcQz2vxQTUEWeAQ+amZM40OnsdVxuE+HDtSrgLVd9suku03V6QP0dLxRUCfSc8JcjXuUrFpFth6ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemLkqzcBBr97U2ra3yP4Xk//Y/Z2aRwTnR/+YjgmTpAEEUTda
	IjvvqPp8PIME1RvQ/MIYJnDB98dRCJKKC3QcSfTRHlZvwVSsnsd+6j0jX3yQtsuq34gg59LvG/S
	Lm+bewmQNWoWS/xoucBxB7ZXmoAvKdl+BQObNlqYqeqfUolbmR7XAmi72O12ujtuyaEFtIvIGqQ
	==
X-Gm-Gg: AY/fxX5v+XsNnIHl4PJLrVHEZNAZPsOW2S/lasTTBJ8bM7//PBPcAczyyExIaMq2ihO
	oZpOlV4VLFancOKtQCZt8hCQ2pniAlgbRcnjMqsAUWOeMImNPzIEVPiRswK8fuz1Em7JxV1dGyR
	jj3r41/cefOEVweGPJmsOUqbo6EYMLCM+2zf8i6eWd78wh10tw7FQYP5d4uG8aWB9JFTk7Guxbp
	vtaP3BLxZugtmuzxz0ZmqACZO2Qmh9fLgF821gzIYWaKxM+uioZmlcingaNnJa9Mb50OdLRiMbj
	oGeoDuG1PphT24fnHmPwZiMFsA0z6XaYV89CqbZ3HyuAev0Izz9hMNR2nCE5I6pAGCTDTOg9bo+
	5ChuTjiCRZ15EnbnGZ4L/ASwxwCBM/wggGvIUjR5bw7oLxOZyh1rv6l4A
X-Received: by 2002:a05:693c:809a:b0:2ae:5f34:e93f with SMTP id 5a478bee46e88-2b05ebd0b12mr16934090eec.15.1766557249877;
        Tue, 23 Dec 2025 22:20:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGazPArtUoNJjmrUNLWEIyeTwzXqVQN3BUYwynjWKWeSW5YA90q+PzXzxtaqjuA8VNcdGa/UA==
X-Received: by 2002:a05:693c:809a:b0:2ae:5f34:e93f with SMTP id 5a478bee46e88-2b05ebd0b12mr16934078eec.15.1766557249293;
        Tue, 23 Dec 2025 22:20:49 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm47567444eec.2.2025.12.23.22.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 22:20:48 -0800 (PST)
Date: Tue, 23 Dec 2025 22:20:47 -0800
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] PCI: dwc: Add new APIs to remove standard and
 extended Capability
Message-ID: <aUuGPw0Ml+BvDL+z@hu-qianyu-lv.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
 <20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com>
 <aUpDqu8598J4yNHb@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUpDqu8598J4yNHb@ryzen>
X-Proofpoint-GUID: SzgN-nGXz5EU27uVe4aHxGTU1VXljBSJ
X-Proofpoint-ORIG-GUID: SzgN-nGXz5EU27uVe4aHxGTU1VXljBSJ
X-Authority-Analysis: v=2.4 cv=QutTHFyd c=1 sm=1 tr=0 ts=694b8642 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=keqCWTWlQfiW9DbH:21 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=grQ0gQtqvyRId-AEQfsA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA1MiBTYWx0ZWRfX1Bv45zMb6/9T
 ASiuhKfBmm/8PhmGsLlJQkimgFrZGK7zYff7rBLXQofdDwHbMuK4YSlctr9SzQPAJwK03YNYImY
 /gt0gnqwf0R/6Hs/f3SCRhMzH6UxGd2Gq3AlcPKAloxAmzK0qLlb9/z8ALGyzR/oLPigVgz1lYO
 4AkgpyyrA/tR6pLTNvUGbeMu20dM5F4G8n8ZiyVmh0l8+kzNs0WNBehT2jFdAmlpIEHiigzOKSM
 PkGfCE/8uafi/sXm6o5GyRqXvMeC3fJ57QCH+s68x8Bqzm/erI1IrfpGojG0Xyo5GQQvZDa8KxY
 SBMgnFBLEdx2YuE8px5E3UiuYHP33DsJaDTPxWp+L4BsdvJQ6IMYeZ06QTc4dKFJ27vdxfEXXtK
 OBHNrxOTmBz3TnYEdtVv2glKz8rXV7DFG+jKLBsAAgf7+Mgm4Kk0O2eBBypH4P41M/I83CtD/1V
 kT9MIGa3A+e1gIPzz4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240052

On Tue, Dec 23, 2025 at 08:24:26AM +0100, Niklas Cassel wrote:
> Hello Qiang Yu,
> 
> I just saw that this patch was queued up.
> 
> dw_pcie_remove_ext_capability() basically seems to be identical to:
> dw_pcie_ep_hide_ext_capability(), only that your new function does
> not require previous cap as an argument (so it seems better).
> 
> It seems a bit silly to have two functions that do the same thing,
> perhaps you can send a patch that removes dw_pcie_ep_hide_ext_capability()
> and updates the only user of that function to use your new function?
> 
> Sorry for not seeing this earlier.
>
Hi Niklas

Thank you for the comments. I'd be happy to send a follow-up patch to 
resolve this.

- Qiang Yu
> 
> Kind regards,
> Niklas
> 
> On Sun, Nov 09, 2025 at 10:59:41PM -0800, Qiang Yu wrote:
> > On some platforms, certain PCIe Capabilities may be present in hardware
> > but are not fully implemented as defined in PCIe spec. These incomplete
> > capabilities should be hidden from the PCI framework to prevent unexpected
> > behavior.
> > 
> > Introduce two APIs to remove a specific PCIe Capability and Extended
> > Capability by updating the previous capability's next offset field to skip
> > over the unwanted capability. These APIs allow RC drivers to easily hide
> > unsupported or partially implemented capabilities from software.
> > 
> > Co-developed-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> > Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 53 ++++++++++++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h |  2 ++
> >  2 files changed, 55 insertions(+)

