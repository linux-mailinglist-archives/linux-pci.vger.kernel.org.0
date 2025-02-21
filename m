Return-Path: <linux-pci+bounces-22092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BC0A407BF
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F0A4251E8
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E540020AF8E;
	Sat, 22 Feb 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i6wiyYeJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE320ADCF
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221977; cv=none; b=DTeisGdG1SR++JZNwTbAiXacrn75B038UDKThxDkm09cjzib9t+QAkTi5MSKHIch0oawgQcC+EHKTGBAMgA66NDcgrqYyppxqegWnPU6e5Tr9aFhYukcn25GMRTw4iZloSfvSZdOVVEdgZZvKa5ab0p4Bdo2T7QqbHU3kK5qg5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221977; c=relaxed/simple;
	bh=w0EKQWgVzLT2QqerYXjI4WU/7yE1hixVEzAU7n2hiUw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=NYw/oWbUy9oNKsQl9BV/LXFPO4ZXHHc/IhAHsZ/lIoILal4tI8UdyttUXCSRejCYyIwQfP5ZTPMlPewuN1tmJCK0UOZ5Rc93yX+vpx1Wm5EZ/f+5cmnCnEpfoLTiRY1Dun5DwygLOGoLTu9DfOW9en/zFZbKLJuB3P8gEL8XV3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i6wiyYeJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250222105934epoutp02a40cf414af5f21229616a34beae011b2~mgqpdeIbX3095030950epoutp029
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:59:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250222105934epoutp02a40cf414af5f21229616a34beae011b2~mgqpdeIbX3095030950epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740221974;
	bh=wumr9BYKo3bzF55GK4/s8rKp2ukr6kB5f9Ku9IjlTkk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=i6wiyYeJlWcHs1sGol+Ns7ikG3k7yI6mjaa0s5ynkllTGyl1RP5FkTK7EUdWpJh1y
	 llbOpYw51hNo2bflZAuiFTS9nv6e7BhGBtpHBbMAqARxvz9K3UfLkDNMHqdBGHOp7p
	 gj5EuKK7xyvoU2CtQYx+UzTeOv50kylU2h6+xi9w=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250222105932epcas5p190878b4b11b1b2dddbba0d75c80d0b11~mgqoPh1DX0600806008epcas5p1N;
	Sat, 22 Feb 2025 10:59:32 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z0PC707lkz4x9Pv; Sat, 22 Feb
	2025 10:59:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.1B.19933.21EA9B76; Sat, 22 Feb 2025 19:59:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250221132251epcas5p2cea80ecc913fc2fce22b82536458db49~mO_eJN4Lp3047230472epcas5p2p;
	Fri, 21 Feb 2025 13:22:51 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250221132251epsmtrp1a8e7bedf045c25af01527d9207558418~mO_eIMjkw3268332683epsmtrp1i;
	Fri, 21 Feb 2025 13:22:51 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-d6-67b9ae12b160
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	57.5F.33707.B2E78B76; Fri, 21 Feb 2025 22:22:51 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250221132248epsmtip15851f3eb2f16b9f9cd55ef846d8413b7~mO_bqG_4k0432204322epsmtip1d;
	Fri, 21 Feb 2025 13:22:48 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Niklas Cassel'" <cassel@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>, <nifan.cxl@gmail.com>,
	<a.manzanares@samsung.com>, <pankaj.dubey@samsung.com>,
	<18255117159@163.com>, <quic_nitegupt@quicinc.com>,
	<quic_krichai@quicinc.com>, <gost.dev@samsung.com>
In-Reply-To: <Z7YYzdN-MboQKIt-@ryzen>
Subject: RE: [PATCH v6 0/4] Add support for debugfs based RAS DES feature in
 PCIe DW
Date: Fri, 21 Feb 2025 18:52:47 +0530
Message-ID: <036001db8463$b52940d0$1f7bc270$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHKQE6Shj4kb5W0bTpKgC8ZJRSYvQHuuUhNATmpN3uzWwNpAA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzH99y114OlcFamD0wcnFkWzIAWSncYgfmaG2PItoRkSxg74dKy
	ttfalm1CsiFUESJvToI0DWqpyuqGs6JSXobyGhaYIVaYCAwiEsQ4mLAlCLi1HGz893l+L8/3
	931ecFQyhQXhWZyJNXCMhsR8BTc7wsLCJfUupXTWoqDchUsiqqojlLLnq6ju8jqUyr8yKqQe
	3HYhVN1CtYhyXBjEqLxTS0LqXpMVo/prejDKvGwWUKPmIiG1crMVULYbCyJqfPwoVWTtRKl/
	WhpF70ro2rozQtplGRXR553ZtLnzmZB2OoowemSwBaMn3VUIXdHyDV3a4AD0vHN7iu+n6t0q
	lslkDSEsl6HLzOKUceT7H6fvS49RSGXhsljqHTKEY7RsHLk/KSX8YJbG44gM+ZLRZHtCKYzR
	SEbG7zbosk1siEpnNMWRrD5To5frI4yM1pjNKSM41rRLJpVGxXgKP1erSvrsQN8g+XpkKA/L
	A2X+xcAHh4QcvjCfQYqBLy4hmgG8MH5X4E1IiOcAzjsO8AkPF97pAusd7sUxwCdcAJ4brBbw
	i2kAp5qGV9sx4m046V5GvRxAhMEfFm+JvEUo0Y3C2pOViDfhQ7wJX/41J/LyZiIV2ppuCL0s
	8MStvX94NsJxMRELZ+yfeMNiYhPsrZ5c3R8l3oC3nllRfqIQuPj4kpDX2guHx14ifM1W2LV4
	CvXqQqLQBzr6poR8w344UdAn4nkznOlpWOMg+KTsxBor4ffXz64JaODf1+0Izwnwttu6Ohvq
	MXa1KZIPB8PKX+rXdP1gydLkWrkYNtas8w64sNIi4DkQ1nTfE5YD0rLBmmWDNcsGC5b/1c4D
	gQMEsnqjVskaY/RRHPvVfxeeodM6weqD35nYCCbG5yLaAYKDdgBxlAwQh5salRJxJnM0hzXo
	0g3ZGtbYDmI8x12BBr2WofP8GM6ULpPHSuUKhUIeG62QkVvFBS6zUkIoGROrZlk9a1jvQ3Cf
	oDwk8r7VFpykrX1U+lHkCrOrbboWyXmQse2knpzakTa/fejVc1HRo22fmaedP+Y6445dKw0I
	KA5KOFIQdyV64u6w6rivtpdj3epjk0/R07NbEuKlh/M/UCgqf00+XX1/ueq7slfS5jpzWhMP
	lZUrF0KTX7QOR/tSobMOrDificQTf+9P7gjtlzx8/bJj+viBx6lP/AbsftuO/Hxx/K3gPTPx
	bd9G/7Qv7NrZustpFn0q/pzs+hAbao49WBHarJ7Zqz7xpytxYHHI2SQv9B+hk8IRyZZkhc2W
	W/Hb08P1j67i3Aoc8+tSoQ9Lig+1aQZQwXt1uTlf7GndBHr856V3eqwR4kBSYFQxsp2owcj8
	C12V30d5BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHec85OzubHDrOylcrq6mV1lZCxFtEV8pDJGhIdKWGnmbp5tg0
	utAYaxiTLtpNXUtSl/du03SKhU27jPKDNCyXmpGZdDFFK5eX1bYiv/35Pf/nxwMPhYueEaHU
	YWUGp1bK0sSkkKhrEYdJlmpt8hX1pWHIeWacj/JaFiKLPgU9ySnHkb6qm4c6mxswVD5awEeV
	RR0k0p0d56GXjWYStRU+JZFhwkCgboORhybrHgBUfH+Uj3p7jyOjuRVHniYbf4OILSm/zGMb
	TN189oY1kzW0fuWx1kojyXZ1NJFsnzMPY3ObtOz52krAjljD4oV7hGuTubTDRzn18nUHhSnn
	XliAqlZ0rOuVjtSBCzOygYCCzErodPeAbCCkREw9gNf7a/j+QQgcab+N+XMQrJj66OMiph9A
	69MAbyaZZbDPOYF780wmCla76/leEc64cNjZbP5rvQlg4zMPz9sSMJFw6vuQzxTEJMKrzjLf
	NvGHmx2DRDagKJpZDT9ZdnsxzQRCR0GfD+OMFGbdA16MM/Nh/Vcz7r9tAXR/KOX5b9gEXT1T
	mL8TDB+7z+I5IMg0zWT6bzJNM5mmbdwARCWYxak0CrkiSRUj1cgUmkylXJqUrrAC37Ojd9hA
	6Z1JqR1gFLADSOHimbQkwyYX0cmy4yc4dfoBdWYap7GDORQhDqbD04zJIkYuy+BSOU7Fqf9N
	MUoQqsPqEotffk7fFbtvUXCbRX76fMHFrYlRmwc7Gs8kXG/dfq9Qbzp66J2sNumtNPDCKMFt
	qxKgmiK6b0hy17I2tXBwi4JLkNGX5vX/fDISftLuuvWjW/gmThEiUW658ss1li+Z/zw34WFE
	jdbeZR/Ljb81tlE4e0zZkCfxzC1d5wh5P7yf0CH5znCQ/xoTPDxVMS/auKjskdyqXbYvNdFz
	+tvenPXNcSWk6teEOtRqai4eoGvjFid5eq9dzDUkVL/mR40UDp+i17Sz8cP6ljfHossaizox
	doktS/TzXLt2QMsbWhXrio34khV5N8TBdVQ5JgP0gRvaItzkEdf42/x3j8SEJkUWE42rNbLf
	jS18a1sDAAA=
X-CMS-MailID: 20250221132251epcas5p2cea80ecc913fc2fce22b82536458db49
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214105330epcas5p13b0d5bef72b012d71e850c9454015880
References: <CGME20250214105330epcas5p13b0d5bef72b012d71e850c9454015880@epcas5p1.samsung.com>
	<20250214105007.97582-1-shradha.t@samsung.com> <Z7YYzdN-MboQKIt-@ryzen>



> -----Original Message-----
> From: Niklas Cassel <cassel@kernel.org>
> Sent: 19 February 2025 23:16
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> fan.ni@samsung.com; nifan.cxl@gmail.com; a.manzanares@samsung.com; pankaj.dubey@samsung.com; 18255117159@163.com;
> quic_nitegupt@quicinc.com; quic_krichai@quicinc.com; gost.dev@samsung.com
> Subject: Re: [PATCH v6 0/4] Add support for debugfs based RAS DES feature in PCIe DW
> 
> On Fri, Feb 14, 2025 at 04:20:03PM +0530, Shradha Todi wrote:
> > DesignWare controller provides a vendor specific extended capability
> > called RASDES as an IP feature. This extended capability  provides
> > hardware information like:
> >  - Debug registers to know the state of the link or controller.
> >  - Error injection mechanisms to inject various PCIe errors including
> >    sequence number, CRC
> >  - Statistical counters to know how many times a particular event
> >    occurred
> >
> > However, in Linux we do not have any generic or custom support to be
> > able to use this feature in an efficient manner. This is the reason we
> > are proposing this framework. Debug and bring up time of high-speed
> > IPs are highly dependent on costlier hardware analyzers and this
> > solution will in some ways help to reduce the HW analyzer usage.
> >
> > The debugfs entries can be used to get information about underlying
> > hardware and can be shared with user space. Separate debugfs entries
> > has been created to cater to all the DES hooks provided by the controller.
> > The debugfs entries interacts with the RASDES registers in the
> > required sequence and provides the meaningful data to the user. This
> > eases the effort to understand and use the register information for debugging.
> >
> > This series creates a generic debugfs framework for DesignWare PCIe
> > controllers where other debug features apart from RASDES can also be
> > added as and when required.
> 
> FWIW, for the series:
> Tested-by: Niklas Cassel <cassel@kernel.org>

Hey Niklas, sent out v7 with a few minor modifications. Would be great if you could test that :)


