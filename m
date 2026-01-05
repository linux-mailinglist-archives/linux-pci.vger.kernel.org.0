Return-Path: <linux-pci+bounces-44041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9344CF4F2F
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 18:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDD0E30136D0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 17:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9D337B81;
	Mon,  5 Jan 2026 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJK2TIcE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W50QYJVP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA73336ED8
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633370; cv=none; b=c5F/S+wglr74i9wG3qHzUzBwdQFDLcvYbJ1ZhPfIywOzXpwp/DIpSPT2eqGME9OSYbf7mvo6+HDnpr6YmEiBbElwBDWraXRwCkVFQCoqvLlRVTLg4JqBLuS153jnOxs4TVXtRppW0KNH8/eNqfqae5f0hbyDSmEShKR8DOp0HTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633370; c=relaxed/simple;
	bh=hpKIOZ5A3Cxt7CeuAF9TvNrJ9+kmSTfm9eb1T3pjX2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWNjpKirB3vwGZZXNiP50gZFMaN7wo43VV66aKxCVzpaVFIQdMfCHLWzIGS/1nu9BgWMpHyRUdbPny8ELQqtVqIft9rEFIjiiGzihQlkxa3V8m315qVFo05MFvoE3KdGMd1XG8o0stFMTMzyjymhavi6F1ojLEVQh6bnMoTsb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJK2TIcE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W50QYJVP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605FKdAd1751622
	for <linux-pci@vger.kernel.org>; Mon, 5 Jan 2026 17:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BP6Gu/c4u72ZuJtLgtoBCZcMdP8EzVQc6SErXMu+NVM=; b=iJK2TIcElu/UfXQV
	UvzgwnNdTKPmjV+ldOkt+wmncU7M/+LJK8zj7oxg0lQnKO9M3nVatd5QseCCMdlm
	v6Gf9MfKK1QWOptn1ZfV4OUGZGA2OawuLhP1qZo1TY9E493FDAbuSi8QlWI7eVFr
	0nd6Ie6hremkkOfX5HjfV8L80MUEVI2cu/4akS8xssybFVCiurZ2NnXhfUVhV4cs
	jEyavDC65WsZZdtzEGDX/Xw0oQcuXrHVEgEzUIu8UWAEdUn0jX7Y/Vmk7z5v3GXM
	6M1Nk/2oSjIfJIH2QVS+1xTieirzDgWkStxqNKs36epIh5mF/T4c2inJeobU0BMo
	Od8Z8Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgfv00baw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 17:16:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0a0bad5dfso2089575ad.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767633364; x=1768238164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BP6Gu/c4u72ZuJtLgtoBCZcMdP8EzVQc6SErXMu+NVM=;
        b=W50QYJVPZT5wKcjumeHMjxGGNSJN9WKF5hXHZc70dx5uYWFWrt0J1JQkWzEbkRuuKR
         3szlEgfCsSagHfFXnSRjMpjp21Gcu2ax2Zat82+lhYsS2Xbuwahp7cP2pSijBX++Yx8R
         3N3r5+lUo5sSHfd9pNPtFAasnYwacwwdoJ4Qs1gJVQltYKVdB9I+mRv7YAX0k/UYkkbm
         2+8Mn7Xkvpn5k5LybFqPDunTPTPobG+QIwk3M5edj+UdNgAVSmQcKOCRZtHTBwpcEKVC
         RydAnwZR7WH7sK6aOCd4enH6CBV6E7hvetrIGS0cwZ5VHwfi4GRqr679bLP4Nf+NqM4/
         QyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767633364; x=1768238164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP6Gu/c4u72ZuJtLgtoBCZcMdP8EzVQc6SErXMu+NVM=;
        b=kUOs/XEAyPWiRCxv3f38+h/IGi7SofCS2+7ZQKm+4yi8tQeqrLfCUIaJ2mSpR31I97
         jfxNizLuFMNESvplSjaqYl9dtquJsB6VeTJDRcuDShMq9QEeMj3gpyVPG+1EcdfSvF3D
         jCz864D/w2KXPm7uzy7i7i8RxEBf1CopiDH7uz2lyBGksH+IhHiFcn9cYeJTU3BLeR2U
         l65JE7C3fpnzLhQseIl+PljYsHrqctqddlgxZsl8fPZ2XxXNUI7JQpSKFaoiLNUXxwGL
         aymKce1apv0gIaByHyXoO877gs31zugns0E8gQ4Kz000VcbXTcTd9s7GNHd1HSVnG4/0
         m6FA==
X-Forwarded-Encrypted: i=1; AJvYcCWxY5CAAIIvc7WWrj76IKlWLrqijvvwHbjSqEFzr1FC1KgQis1WcA89yfpzzT30LdTLgqc2HloUSzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrUrrPWoTmMklqo8Sgj5SvzRV8du6ikLh0ofbGg8296420ZLS
	J/nO8M/p42v3bCwNsTKm5pf/O91+jZOoTI3Z2oLsvkYM4DJ94/fnsGEIVyWnKGC2ZyRJVs7qH2f
	f6Dq1tzdgsFQ8AMemWHx7G3McJ3BjxPB7oPpqtn/86fdHEKaOQplA0x8/5nHaZl8=
X-Gm-Gg: AY/fxX6u3euvRvEx0Nr9YaXtydUhbZZOY6al7d6+AGB2LqGLzB79fgQA93iw+UhCPyb
	9yZIq1EEfQbSnVyt9fBUE7Z+FywxUV8BNSkh3bXNNrY5RNBG219JeZDxTv1zaRiWXrdL/L4OcfR
	C0N+beIjqSr2TsEgXVQApnyLN3k4D40HOSrJvMvPqWChayWdg5ESd9UQq6aSRs+/CkI8q9bIuzR
	nPSD9fixiSjB+PCqugtJVUK+vZlyYcO7BGyWUgRW5t3bN7BB8UQ/pjLZa1R97J+/4envUSEwYb5
	Q27zfbmztNbY25NHYdw9BerUzk7k6X98U7Pg5x98dKChtpGg4meSnJ2XCCrnS+s5g6+A8PICl5/
	xbSdQ8N+pnpf6uBHRXh5QwMBlTA==
X-Received: by 2002:a05:6a20:3c8e:b0:371:53a7:a4ba with SMTP id adf61e73a8af0-389822fca65mr45913637.30.1767633363789;
        Mon, 05 Jan 2026 09:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDb3ibB9yyf+XjsFBKFvP7NjPBf6cbuRzUcRVAfkOINXdA704jnRwHCauACbYKxkz5R4nWrA==
X-Received: by 2002:a05:6a20:3c8e:b0:371:53a7:a4ba with SMTP id adf61e73a8af0-389822fca65mr45883637.30.1767633363170;
        Mon, 05 Jan 2026 09:16:03 -0800 (PST)
Received: from work ([120.56.194.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4bfca6fbccsm199197a12.3.2026.01.05.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:16:02 -0800 (PST)
Date: Mon, 5 Jan 2026 22:45:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Yue Wang <yue.wang@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Linnaea Lavia <linnaea-von-lavia@live.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        stable@vger.kernel.org, Ricardo Pardini <ricardo@pardini.net>
Subject: Re: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout,
 message, speed check
Message-ID: <2veit3krpnauq67smexshnknbahup4yuckjgd6bxqisfqswkqe@dbhcgpiaajga>
References: <20251103221930.1831376-1-helgaas@kernel.org>
 <176603796183.17581.9416209133990924154.b4-ty@kernel.org>
 <CAFBinCAPpiq=M00ZQXAB4Pu2Myjo8gpXC7DByKkGN6Z_Ahqafg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAPpiq=M00ZQXAB4Pu2Myjo8gpXC7DByKkGN6Z_Ahqafg@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=e9YLiKp/ c=1 sm=1 tr=0 ts=695bf1d4 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=3dEILRYKsVIWdVk4w2Qziw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6FUes5m74a-6EvCHSkUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Na4EnRBn0CabRraehWEItHU7FyP1rktj
X-Proofpoint-ORIG-GUID: Na4EnRBn0CabRraehWEItHU7FyP1rktj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE1MCBTYWx0ZWRfX6w8aUDJ+xuyL
 nfg/slabJ5nqIXuHd7JamTth2O/dn07and/TmEJEgjFBiCoWxHUboTmM8a93jgpgK2wGxGmX2CC
 c6MJote4HZybsfDVUKE/2PTZB9ywh6USNauyKfo6BgLYPBOPhytk8dWI2pKhjbmUQ/2gc2zO8Ik
 l7FIZPzv7YAmowu/CmJPF1Dk8szZT6SUePpIOjzZTAe+GhMK43QP8Ll0Wi4L4nkMze2pVf7Q0w6
 DTasr8as8soytiSsoXP/5XusohTpYHE2sbl+u35kpNS3t+xC9UHi2TnV7A0gIj5BqD4V6aevjFj
 nGjjoyqLOxrN/+fUHWCHPnw4g4KIRpCqN3pf3LyRuJ4nMFwL8mZrxbWc2tbxe/BF4v2SquYWq9C
 DgM97CWeeFef07axISlG7Lc0gtpflc4RFPm3xBc4X5yd+mlX9IZzFn/WqZG7BWc2gjUh9lWxfRB
 9tjhtqQmcRblHyfsWPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050150

On Mon, Jan 05, 2026 at 05:49:00PM +0100, Martin Blumenstingl wrote:
> Hi Mani,
> 
> On Thu, Dec 18, 2025 at 7:06 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> >
> >
> > On Mon, 03 Nov 2025 16:19:26 -0600, Bjorn Helgaas wrote:
> > > Previously meson_pcie_link_up() only returned true if the link was in the
> > > L0 state.  This was incorrect because hardware autonomously manages
> > > transitions between L0, L0s, and L1 while both components on the link stay
> > > in D0.  Those states should all be treated as "link is active".
> > >
> > > Returning false when the device was in L0s or L1 broke config accesses
> > > because dw_pcie_other_conf_map_bus() fails if the link is down, which
> > > caused errors like this:
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] PCI: meson: Remove meson_pcie_link_up() timeout, message, speed check
> >       commit: 11647fc772e977c981259a63c4a2b7e2c312ea22
> My understanding is that this is queued for -next.
> Ricardo (Cc'ed) reported that this patch fixes PCI link up on his Odroid-HC4.
> Is there a chance to get this patch into -fixes, so it can be pulled
> by Linus for one of the next -rc?
> 

Hmm, I looked at the Fixes tag and mistakenly assumed that the issue existed
from the beginning.

Bjorn, could you please include this patch in the next fixes PR?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

