Return-Path: <linux-pci+bounces-37895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD67BD304F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 14:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65031349894
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F3E2609FD;
	Mon, 13 Oct 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ibG1wdZh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5DD3A1B5
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359238; cv=none; b=jiJp4h7GFijgEm6xTyX6gEUtz1FXzxJ6RNBckNvd8kJk2xsPxDMNvF49QfY+L1HuzsUmgnRNbu4bTQ2BBkdrvs/iWWKO+V0ptZJlbs+RD3xmhVPrt4K/R992LNT1J0Kt2apK4fL99vrgl3WJmFMsZAZIA27uodd9e2LUQt4w4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359238; c=relaxed/simple;
	bh=dZx1FG/WcIlbQOgcXxuWDW5+YDqYBZQhGx5Hx6dPiIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+hqya8nvXTkpPLj5QafgzcJzv6n9NUN/qGV948uDqR0OgGRl+Zu+qO1YG+lzPxihHxTtSpMtyMjqMBsUnTLcj6iukMVM3SdMHoXEfxYSxYdH2+utpId09h2zMWzGO5f/bLlekQtaJ/ROiRJHXo/tWj5gmx5Z2LvZRxSAGjOE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ibG1wdZh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DBBQTs023435
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 12:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=f6scyOM+ahva9+uwhw48pxSb
	yDQ+LPEwq5/UOfcG8bo=; b=ibG1wdZh8jBFjAAr/HF2MKezLDCDoQs9U+AgU1E+
	gsv1WjshXlYEN9CVA1E5jrdrhhJ6K7/zPyVZqvMENNAU/tCyIKuRxCus6Jc5tetA
	a6rPPK+TO2BnfR38pazxRS7lrCik4W5lChA57gij0xGAxeev/Yl1GjWFyr9HS0nR
	l2fHx/xpO+WjXOHdNhSY1nFy8+H6qGYESv19zRsJl63y/BExMozlu7ORp7RC9c4l
	siWH/7eZgiUEdQnb/G4twJJ4YbPKpXQ0MOFG0iJRvYn+xVIVfDBB/ZAX74srez0Z
	OSrcURx02nSd3it8vowRjjgF1swAg2wZTvtQ1POWLIVZdw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdfvejc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 12:40:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-87561645c1cso2408256085a.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 05:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359235; x=1760964035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6scyOM+ahva9+uwhw48pxSbyDQ+LPEwq5/UOfcG8bo=;
        b=wNfMvxRJrNKLDLqpNhm+6s1d19aYlsSp8B05u4QtiR8d+btMBOF4Ky0zQ/ikFVRM8y
         ZjZuoiqKCJooscojzT7DO3oV4pLnj7NAuzZ9kjNC4044lI/vfPXdgyjfjwbPpDsVVp/h
         m6ljwLMPMJQsRkahw/CJkhjof48QZaO+CxTM6j4MhKbxSvQZ3jPyjNPU0IyA5UogKCLx
         BPnXpnxM2rcrUJiZ9BHot7X7+xxNyk4fvj3OQU+tq31HlqRPrM0dAu+RlDBeA+XReVxC
         2+EiaFJXoYKb2wVKkXvfB8rpHqzFdTA4CFlV5N7Qdgq+9/HQgTfoGXTgASbEkbJnzTaE
         2wig==
X-Forwarded-Encrypted: i=1; AJvYcCWKwv4kVlQI3LyFkK9d66Q9GhhVVfa+IcGp2ZeaxqY0zos4CKhSo6UH8mz5c5/wdMZ4+EmPx0POB1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAg83U1e+qc0AQV+ZBnQu4G6rRfe6JbiXrp7JB9b9oULQ6FLK4
	nWafaqJd5GtDMestwww9lPifmcLk1GjJZkcBtMLrGdQtcYdK6Y3r+croxj6RIHtlWgG9YCOFVda
	pt/n0lN/XBUaeXG+PhHFiDusqPRl+gTGgHMX87KXDS65+JOVep3cP9ogmUsDp8Dg=
X-Gm-Gg: ASbGncvc3Cc0gWHERIho0jgi5g3Z7Beo84Wws1Hki+mCbHLiBfEJ3uuNJ5gR9bSIT0S
	Niv+f2OK5JVuQvhVh5+5RTee9iPoY9A2vtlh27G53ImxVPh9tLdp83vm9tDFqKsC5atcrjg/goZ
	/mcigpkKVWWlnwHtvkDKv4rifKbt3d2Rd6f+5BHxt14ewH3vnjC95/zZ+7SDwmzagM9jmOpoK9U
	rkHjHf3A6gVjEk9V+AuFCDvJhA66t2Y4HH8x6S0JfFqpvztPGzGx9BUNqXTY08eOpFKnyfiJkiY
	npSvyfnal/+PpViNaPBFnwY9HCEVCwwzZqSVr7pdiZ2/cup6E7yBlVp+uLwzBdzv/S69n7LuGqY
	+f36H7rvaMqP9nAQlJXy4hx91stBuWMCCS7LDTk+Zwb+MVEfZK2zZ
X-Received: by 2002:a05:620a:458c:b0:868:54ba:7c42 with SMTP id af79cd13be357-88352f83d61mr2871641585a.25.1760359235458;
        Mon, 13 Oct 2025 05:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkvZQ+8ZJnIwC2hIgs/DILNFhHouXWRCw0k5tWWtya0oIkN3txK/mV8/TSZwSq7k0H8FX0lg==
X-Received: by 2002:a05:620a:458c:b0:868:54ba:7c42 with SMTP id af79cd13be357-88352f83d61mr2871637585a.25.1760359234973;
        Mon, 13 Oct 2025 05:40:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908857792dsm4081471e87.105.2025.10.13.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:40:34 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:40:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 3/6] phy: qcom-qmp: qserdes-txrx: Add QMP PCIe PHY
 v8-specific register offsets
Message-ID: <x2443gg3bj37j7qxjk3ocol4xzcly2vandob5j46bp5c6akqb3@zgwrl7qhl2y6>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
 <20250924-knp-pcie-v1-3-5fb59e398b83@oss.qualcomm.com>
 <fw5hf4p2mjybvfo756dhdm6wwlgnkzks4uwgo7k3dy7hyjhzyr@bv4p7msxapcb>
 <aOzSnxuuAb4gFCkk@hu-qianyu-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOzSnxuuAb4gFCkk@hu-qianyu-lv.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfX+L118XBeltXC
 PsuUZDUn4Ko99NJGCo5R6tG5+ts4+Lf9RR9kvhrI/rxCjnXkebDvBDLSvZSCeju7La/wyUT0k9w
 mLpMG2+KnZlKiyYDehNy521oDZdFEFvJ1QYGRSR6Y75U5CgsHa/4XiwfO901Lzxwbs7eQuMTYz5
 RreT7lPa9ZgOsww698kTKwqIP9HmZtRY7d8Tly+nadn2hwEEi6XZ45mK0VM+KetLICt0aFRaubV
 J6CG5/encV4op35MLml1NTYvUbn3U44ejFS3sEWgQfZ2GO2ApO0TlKo21hV68jZsNPSWZD74S8C
 pEMVPYAD5/NoiXs2f8ODSBdyNeewvOH3O0AnWQ+XSJXZdK8FGifWj5jtjVrFtaRAlD/DY1uh1NM
 hL9NmD5EAFVFbLS2+pyAFZBg6pvK3Q==
X-Proofpoint-GUID: f0gdQfS0PBI7H5L46TbOpsDpXUe-Kp_-
X-Proofpoint-ORIG-GUID: f0gdQfS0PBI7H5L46TbOpsDpXUe-Kp_-
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ecf344 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=SRHymB3k53h_HzVQ3XsA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

On Mon, Oct 13, 2025 at 03:21:19AM -0700, Qiang Yu wrote:
> On Thu, Sep 25, 2025 at 05:28:15AM +0300, Dmitry Baryshkov wrote:
> > On Wed, Sep 24, 2025 at 04:33:19PM -0700, Jingyi Wang wrote:
> > > From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > 
> > > Kaanapali SoC uses QMP PHY with version v8 for PCIe Gen3 x2, but its
> > > qserdes-txrx register offsets differ from the existing v8 offsets. To
> > > accommodate these differences, add the qserdes-txrx specific offsets in
> > > a dedicated header file.
> > 
> > With this approach it's not obvious, which register names are shared
> > with the existing header and which fields are unique. Please provide a
> > full set of defines in this header.
> 
> Sorry, I didn't get you. Do you mean we need to add defines for all PCIe
> qserdes-txrx registers? I don't understand how this makes which register
> names are shared and which fields are unique more obvious.

From your commit message it feels like
phy-qcom-qmp-qserdes-txrx-pcie-v8.h is an extension over some other
"base" header file (likely phy-qcom-qmp-qserdes-txrx-v8.h. It makes it
harder to follow the logic and harder to compare the values. Please
define all used register names inside the new header.


-- 
With best wishes
Dmitry

