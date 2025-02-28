Return-Path: <linux-pci+bounces-22744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CAA4BB26
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B20967A6A0A
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496C81EEA27;
	Mon,  3 Mar 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dVuqAp1W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7218EAB
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995351; cv=none; b=cRHGiJyRT8vOnAoYS+uD5ronFDXqbeDwnMN3qkQDH3qY12pkHhUzBf1UkPNdsJLdavN5paFOMJd5QgbDNQHifMZxOlabibVKUZS8az6ke03C10pSQV3OKgD+4D6zWWl6/fm05s/2C2AWnGCs9fzGoVDHca6UodhKYGx7f75u1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995351; c=relaxed/simple;
	bh=dBpyRD3Af4A+AiBhDTBakcxsh6+4fPaRYfan0doQJdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=pT0ndv8NLXJSyUP/J/EPSXdnFsInZVCcTTens7VZISvHlERYu+8N90S/cN5qYtz4jmF+5/v59+k5U1dAtnyNDTl5pwx0Dm0zFx6hD8wWfPoe3WsQ+N/TdLmhpejvq0YrfdnZMG3zRdicRvTUEONergyesGLi9GJRDxeYzmEpAZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dVuqAp1W; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250303094900epoutp02bae585bd72a7444020bc880cb88de083~pQgnUwlwY1148811488epoutp02Y
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 09:49:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250303094900epoutp02bae585bd72a7444020bc880cb88de083~pQgnUwlwY1148811488epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740995340;
	bh=A6rXyxrSkX4HADIgbY5HWK2vNlIuc7WBXS7Zq+Ms0JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVuqAp1WcRurfwCGQ8t3Ms9B0fFGX3lOBlAO2BclgS0K8Ut60gawC/sPdJJsdv/BA
	 8XxQzamtIPPmg3t2AsL9LRe2aGV11+ZLZsophekOsA8n2Oby46Q2w5uvwEOreZF2zL
	 yWgL/qsVHPjVKkCZEdBtoHyK0g2wjPnG6Y8PPo3s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250303094900epcas5p20c3abf562a30579b79a224889f449ef3~pQgmoK8Wm2511625116epcas5p28;
	Mon,  3 Mar 2025 09:49:00 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z5vCY4lGHz4x9Q0; Mon,  3 Mar
	2025 09:48:57 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.54.19710.90B75C76; Mon,  3 Mar 2025 18:48:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250228114813epcas5p32127b99d3a0adf6900a104468b48768d~oXM1p_I5X0606706067epcas5p39;
	Fri, 28 Feb 2025 11:48:13 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250228114813epsmtrp2153ec45f033bf4373aece964cf49075a~oXM1pBsIZ2226522265epsmtrp2e;
	Fri, 28 Feb 2025 11:48:13 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-0b-67c57b09f171
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.F6.33707.D72A1C76; Fri, 28 Feb 2025 20:48:13 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250228114810epsmtip1d1899f45fb2e472c25ba58375dd1b3b5~oXMyy6Y-Z1263712637epsmtip1y;
	Fri, 28 Feb 2025 11:48:10 +0000 (GMT)
From: Hrishikesh Deleep <hrishikesh.d@samsung.com>
To: shradha.t@samsung.com
Cc: 18255117159@163.com, Jonathan.Cameron@Huawei.com,
	a.manzanares@samsung.com, bhelgaas@google.com, cassel@kernel.org,
	fan.ni@samsung.com, jingoohan1@gmail.com, kw@linux.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	mark.rutland@arm.com, nifan.cxl@gmail.com, pankaj.dubey@samsung.com,
	renyu.zj@linux.alibaba.com, robh@kernel.org, will@kernel.org,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Date: Fri, 28 Feb 2025 17:13:01 +0530
Message-Id: <20250228114301.31739-1-hrishikesh.d@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250221131548.59616-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJsWRmVeSWpSXmKPExsWy7bCmli5n9dF0g6tnlC2utP9mt5h+WNFi
	SVOGxbEJK5gtmlbfZbVY8WUmu8WqhdfYLBp6frNabHp8jdXi8q45bBZn5x1ns7iydR2LRcuf
	FhaLuy2drBZLr19ksvi7bS+jxaKtX9gtFja/ZLT4v2cHu0Xv4VqLljumFu9/bmZzEPNYvGIK
	q8eaeWsYPXbOusvusWBTqUfLkbesHptWdbJ53Lm2h81j50NLjydXpjN5bF5S79G3ZRWjx+dN
	cgE8Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDf
	KimUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyB
	ChOyMzZdecxWcMi5Yvr++AbGxVZdjJwcEgImElfXvmTvYuTiEBLYzSix/MglKOcTo8SmpScY
	QarAnL0flGE6Dkz5yARRtJNRouXKDxYI5wujxNzW7SwgVWwCRhLfmvaC2SICkhJf+trAOpgF
	prNIfFn5khkkISwQJvHv5w0wm0VAVeLJqU9gDbwCthJz248zQqyTl1i94QBYDaeAtcSqc9OZ
	IGoEJU7OfAJWzwxU07x1NjPIAgmBfk6Jl7/bmCCaXSQ2vT3KBmELS7w6voUdwpaS+PxuL1Q8
	W2LPoetQywokljQ8g6qxlzhwZQ7QAg6gBZoS63fpQ4RlJaaeWscEsZdPovf3E6hVvBI75sHY
	ahKvZ09khbBlJC7NWswCYXtIzJm0GRq+fYwS2x48YZnAqDALyT+zkPwzC2H1AkbmVYySqQXF
	uempyaYFhnmp5fBYTs7P3cQIzgFaLjsYb8z/p3eIkYmD8RCjBAezkghvYdCRdCHelMTKqtSi
	/Pii0pzU4kOMpsAAn8gsJZqcD8xCeSXxhiaWBiZmZmYmlsZmhkrivM07W9KFBNITS1KzU1ML
	Uotg+pg4OKUamLL47RhrX++ostmTZ+vcdetqu8P8CsP6M+V1ca7BsdNu8D8Qdvg5V2djyZKt
	DSYqOdp7JC6eOWfNb5gQtPhBIKel+6fHLzku7mxkW/n3yH//CWcuXk6dkKPeNoexvnvXfePs
	L+mTo3fskfw4/ZR6+np21ftqEs8SxZneRWbt3/r+66Ekv2N5AjK/e5cGfva9Kvpz1UnF5adl
	gvZNFAlR9OeJVek4PKOh/1nQVMNbc6fWf9Vie6+wjHvrzpBXUqEfGz7suyqyyK3swPJLbrYX
	+9xW6ji/WRBRo77Yb71irXrwYr607GfJ71a0h7Vav3a7lyc5y+t97ocDfK7TIkybbus9zD40
	KbjZoeX9lSmXg5RYijMSDbWYi4oTAWfWAtSKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSnG7tooPpBodPcllcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2qx4stMdotVC6+xWTT0/Ga12PT4GqvF5V1z2CzOzjvOZnFl6zoWi5Y/
	LSwWd1s6WS2WXr/IZPF3215Gi0Vbv7BbLGx+yWjxf88Odovew7UWLXdMLd7/3MzmIOaxeMUU
	Vo8189YweuycdZfdY8GmUo+WI29ZPTat6mTzuHNtD5vHzoeWHk+uTGfy2Lyk3qNvyypGj8+b
	5AJ4orhsUlJzMstSi/TtErgyNl15zFZwyLli+v74BsbFVl2MnBwSAiYSB6Z8ZOpi5OIQEtjO
	KHHn1hVWiISMxNV1J9kgbGGJlf+es0MUfWKUeLJpITNIgk3ASOJb014WEFtEQFLiS18b2CRm
	gfUsElvOPQRLCAuESOyetglsKouAqsSTU5/A4rwCthJz248zQmyQl1i94QDYUE4Ba4lV56Yz
	gdhCAlYSe7bcZ4WoF5Q4OfMJUC8H0AJ1ifXzhEDCzECtzVtnM09gFJyFpGoWQtUsJFULGJlX
	MYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgRHslbQDsZl6//qHWJk4mA8xCjBwawkwjsr9kC6
	EG9KYmVValF+fFFpTmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA1NLy8WShiQ+
	Zt0fgcZli7dz8/66ou6yScjil83rMxp5+89MvhoqdfrnrMNND7OZ3x2xOFi2cPZLa2NBybVG
	Yn+59HSbGDmOdDvOfxi4yJf1/R9H9jdy244lTb+5fe6Vkoeis1x1XzPMWDN1Qb3J2cP/eVf4
	fFZ6ffMmb6jMxdqqFd+L1Xl/3pFX/MHpEHhTu27lxM5Pql2z7LmNW06YlH/8vIXx96Gik3MX
	vGPTub1sq8Wl38dsWLj4had1qByQrc4xKHY5+uR//U7WGR785yK/LZjlplMoLZQ9a7ZHHs/+
	IkODiEl+M/cvf35RbGGq/nJ9oZWn2OR/Rj2ZWP1S9B6ba9jZm+xiS41ipyrfWz1TiaU4I9FQ
	i7moOBEALB5gqlMDAAA=
X-CMS-MailID: 20250228114813epcas5p32127b99d3a0adf6900a104468b48768d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250228114813epcas5p32127b99d3a0adf6900a104468b48768d
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250228114813epcas5p32127b99d3a0adf6900a104468b48768d@epcas5p3.samsung.com>

>Subject: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
> PCIe DW
>Date: Fri, 21 Feb 2025 18:45:43 +0530
>Message-Id: <20250221131548.59616-1-shradha.t@samsung.com>
>X-Mailer: git-send-email 2.17.1
>Precedence: bulk
>X-Mailing-List: linux-kernel@vger.kernel.org
>List-Id: <linux-kernel.vger.kernel.org>
>List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
>List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
>MIME-Version: 1.0
>Content-Transfer-Encoding: 8bit
>X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmum7f2p3pBpev8Fhcaf/NbjH9sKLF
>	kqYMi2MTVjBbNK2+y2qx4stMdotVC6+xWTT0/Ga12PT4GqvF5V1z2CzOzjvOZnFl6zoWi5Y/
>	LSwWd1s6WS2WXr/IZPF3215Gi0Vbv7BbLGx+yWjxf88Odovew7UWLXdMLd7/3MzmIOaxeMUU
>	Vo8189YweuycdZfdY8GmUo+WI29ZPTat6mTzuHNtD5vHzoeWHk+uTGfy2Lyk3qNvyypGj8+b
>	5AJ4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4C+
>	VVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkC
>	FSZkZ9w5vYalYLZqxYb7X5gaGB/IdjFyckgImEi83vKXqYuRi0NIYDejxLsX7UwgCSGBT4wS
>	u6dkQySA7IMTF7PDdKyZ08QKkdjJKHFn3nso5wujxL2+j2BVbAJaEo1fu5hBbBGBVkaJI8/E
>	QIqYBbYxSxxYsQIsISwQJPFjXRsLiM0ioCrx/e98oGYODl4BK4k9K+0htslLrN5wAKycV0BQ
>	4uTMJ2DlzEDx5q2zmSFqvnBIfJnNB2G7SCzadQPqUmGJV8e3QNlSEp/f7WWDsNMlVm6eAdWb
>	I/Ft8xImCNte4sCVOSwgJzALaEqs36UPEZaVmHpqHRPEWj6J3t9PoMp5JXbMg7GVJb783cMC
>	YUtKzDt2mRXC9pDYufkh2EghgViJ/v+2ExjlZyF5ZhaSZ2YhLF7AyLyKUTK1oDg3PTXZtMAw
>	L7UcHq3J+bmbGMFJXstlB+ON+f/0DjEycTAeYpTgYFYS4dUt2ZEuxJuSWFmVWpQfX1Sak1p8
>	iNEUGMATmaVEk/OBeSavJN7QxNLAxMzMzMTS2MxQSZy3eWdLupBAemJJanZqakFqEUwfEwen
>	VAOTyWph2UVGD0z1j0+NvfvEdnGQ413ON1OnCFx4vMfJeqvN3Mp7Kx86NXwKsN+sdkziZXTt
>	kesTTnswSfQ/W1W2UrvUr+Mf14yGGbL9V1cY802NfhC1Su7CI57OFPH5lz5En/srKjG9MXbJ
>	wbvLF2vMuPtkX2nEE4bFtdvOlN1YvEY1xMF6apLnj5CG0sSSXn3PgKUsajzVWQ/TfU7n/lD5
>	bfjrwVJLhqPcRqoTSkq8zi29HTM1wO3dCcNfq6we9H4Sbrx8ef67MN+3L8NLzveyuAo5iV1+
>	s8+BVbngfu6khvO+c9YriUadC2QxkJvBY3eiVHQx3yuDqBXzeubVRsnkfzzpt9tl19/cGTOv
>	1GuzKrEUZyQaajEXFScCAMosolJ7BAAA
>X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvG537Y50g2MLlC2utP9mt5h+WNFi
>	SVOGxbEJK5gtmlbfZbVY8WUmu8WqhdfYLBp6frNabHp8jdXi8q45bBZn5x1ns7iydR2LRcuf
>	FhaLuy2drBZLr19ksvi7bS+jxaKtX9gtFja/ZLT4v2cHu0Xv4VqLljumFu9/bmZzEPNYvGIK
>	q8eaeWsYPXbOusvusWBTqUfLkbesHptWdbJ53Lm2h81j50NLjydXpjN5bF5S79G3ZRWjx+dN
>	cgE8UVw2Kak5mWWpRfp2CVwZd06vYSmYrVqx4f4XpgbGB7JdjJwcEgImEmvmNLF2MXJxCAls
>	Z5Q4cm4FE0RCUuLzxXVQtrDEyn/P2SGKPjFKnLi3HyzBJqAl0fi1ixkkISLQySix98g7sCpm
>	gXPMEjM/tzCCVAkLBEicWbwezGYRUJX4/nc+UBEHB6+AlcSelfYQG+QlVm84wAxi8woISpyc
>	+YQFpIRZQF1i/TwhkDAzUEnz1tnMExj5ZyGpmoVQNQtJ1QJG5lWMoqkFxbnpuckFhnrFibnF
>	pXnpesn5uZsYwbGpFbSDcdn6v3qHGJk4GA8xSnAwK4nw6pbsSBfiTUmsrEotyo8vKs1JLT7E
>	KM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpg4pjMtu2b3EL3R9/vnl2nEvFC55TM2YSA
>	my6J94qZeTt8782a/COa5zfzt5k3prcfseJ7luLkekH78Adlm03yN7mZkk1XMM56/M3uTPar
>	ex8KP295FMh6s2nhnKm/5osxdX5TKq3b61nX9iT1YXNdyKerQsdqYjgT+VaEJK99GX3A6He8
>	1XIWZ2vz9ffnsnQutJ2jtMajR/n7bM0NmbNmena/SZXhnfzD5alN2PFWrd0vK8Je8Blf3/b1
>	x9bwBX5/Yl/s/XhNzGKZrer2uvBbUQqvGNOWb17bYhX/xT3W2q3tpEjcHY7SxiIpxtc63+us
>	rinukH9y8IUFl3ej4vrW9/u/5z0wPMPHsW9quEntZSWW4oxEQy3mouJEAI4aFoM8AwAA
>X-CMS-MailID: 20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5
>X-Msg-Generator: CA
>Content-Type: text/plain; charset="utf-8"
>X-Sendblock-Type: REQ_APPROVE
>CMS-TYPE: 105P
>DLP-Filter: Pass
>X-CFilter-Loop: Reflected
>X-CMS-RootMailID: 20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5
>References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>
>
>DesignWare controller provides a vendor specific extended capability
>called RASDES as an IP feature. This extended capability  provides
>hardware information like:
> - Debug registers to know the state of the link or controller. 
> - Error injection mechanisms to inject various PCIe errors including
>   sequence number, CRC
> - Statistical counters to know how many times a particular event
>   occurred
>
>However, in Linux we do not have any generic or custom support to be
>able to use this feature in an efficient manner. This is the reason we
>are proposing this framework. Debug and bring up time of high-speed IPs
>are highly dependent on costlier hardware analyzers and this solution
>will in some ways help to reduce the HW analyzer usage.
>
>The debugfs entries can be used to get information about underlying
>hardware and can be shared with user space. Separate debugfs entries has
>been created to cater to all the DES hooks provided by the controller.
>The debugfs entries interacts with the RASDES registers in the required
>sequence and provides the meaningful data to the user. This eases the
>effort to understand and use the register information for debugging.
>
>This series creates a generic debugfs framework for DesignWare PCIe
>controllers where other debug features apart from RASDES can also be
>added as and when required.
>
>v7:
>    - Moved the patches to make finding VSEC IDs common from Mani's patchset [1]
>      into this series to remove dependancy as discussed
>    - Addressed style related change requests from v6
>
>v6: https://lore.kernel.org/all/20250214105007.97582-1-shradha.t@samsung.com/
>    - Addressed Niklas's comment to make vsec ID finding similar to perf
>    - Minor changes in the driver to make the debugfs file common and
>      not specefic to RASDES so that other developers can add debug
>      related features to this file.
>
>v5: https://lore.kernel.org/all/20250121111421.35437-1-shradha.t@samsung.com/
>    - Addressed Fan's comment to split the patches for easier review
>    - Addressed Bjorn's comment to fix vendor specific cap search
>    - Addressed style related change requests from v4
>    - Added rasdes debugfs init call to common designware files for host
>      and EP.
>
>v4: https://lore.kernel.org/lkml/20241206074456.17401-1-shradha.t@samsung.com/
>    - Addressed comments from Manivannan, Bjorn and Jonathan
>    - Addressed style related change requests from v3
>    - Added Documentation under Documentation/ABI/testing and kdoc stype
>      comments wherever required for better understanding
>    - Enhanced error injection to include all possible error groups
>    - Removed debugfs init call from common designware file and left it
>      up to individual platform drivers to init/deinit as required.
>
>v3: https://lore.kernel.org/all/20240625093813.112555-1-shradha.t@samsung.com/
>    - v2 had suggestions about moving this framework to perf/EDAC instead of a
>      controller specific debugfs but after discussions we decided to go ahead
>      with the same. Rebased and posted v3 with minor style changes.
>
>v2: https://lore.kernel.org/lkml/20231130115044.53512-1-shradha.t@samsung.com/
>    - Addressed comments from Krzysztof Wilczyński, Bjorn Helgaas and
>      posted v2 with a changed implementation for a better code design
>
>v1: https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung.com/T/
>
>[1] https://lore.kernel.org/all/20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org/
>
>Manivannan Sadhasivam (1):
>  perf/dwc_pcie: Move common DWC struct definitions to 'pcie-dwc.h'
>
>Shradha Todi (4):
>  PCI: dwc: Add helper to find the Vendor Specific Extended Capability
>    (VSEC)
>  Add debugfs based silicon debug support in DWC
>  Add debugfs based error injection support in DWC
>  Add debugfs based statistical counter support in DWC
>
> Documentation/ABI/testing/debugfs-dwc-pcie    | 144 +++++
> MAINTAINERS                                   |   1 +
> drivers/pci/controller/dwc/Kconfig            |  10 +
> drivers/pci/controller/dwc/Makefile           |   1 +
> .../controller/dwc/pcie-designware-debugfs.c  | 564 ++++++++++++++++++
> .../pci/controller/dwc/pcie-designware-ep.c   |   5 +
> .../pci/controller/dwc/pcie-designware-host.c |   6 +
> drivers/pci/controller/dwc/pcie-designware.c  |  46 ++
> drivers/pci/controller/dwc/pcie-designware.h  |  21 +
> drivers/perf/dwc_pcie_pmu.c                   |  25 +-
> include/linux/pcie-dwc.h                      |  36 ++
> 11 files changed, 837 insertions(+), 22 deletions(-)
> create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
> create mode 100644 drivers/pci/controller/dwc/pcie-designware-debugfs.c
> create mode 100644 include/linux/pcie-dwc.h
>
>-- 
>2.17.1
>
>

Thanks for adding the support!

Tested the patch in one of our internal SoC with DesginWare PCIe controller. The patch works fine.

Tested-by: Hrishikesh Deleep <hrishikesh.d@samsung.com>


