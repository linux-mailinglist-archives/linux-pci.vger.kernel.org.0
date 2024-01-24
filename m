Return-Path: <linux-pci+bounces-2518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F983A879
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 12:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CB61F21E3C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C15B200;
	Wed, 24 Jan 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZQPhwcOO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB158223
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096866; cv=none; b=NHSQlUM6QLvc4lyyZ73ccBNQx7oI8CUUlLV6G20FkShssHqeaWRLcmQT23/jjw5NOvZVywzjMIPF9lUjnOqUQEgXUwl1mcgNR/nZiHMQlIBFENd9m2GoarORsEG1WnxSPc/UHZVQ41VxLxG9h/w+rFCK9dBRTCqJ3YuaFR1cfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096866; c=relaxed/simple;
	bh=dwUFUgXnc97o1JhfPJM4lmSZq785hcoEF4F3egx8Bq4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=eniOLS/D8mLd+XSBQ6BXsxOjEZzOUrfSPc+wUXi1O9aqiAxQLOL1Jn2QeterEZQ5z9ucdzMLivhBbp6dptLGnoof5/7wV97CQKXGrKp1DBgfE5sqiTYXnr/klwx+lMyedznixufVrb/HTqtEBo+96DwKXjoxQXcy1Vkcx+6uVhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZQPhwcOO; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240124114740epoutp01acdf1da9186eaeafa54f2ee7d7ac4a49~tRg42hSi90196801968epoutp01O
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 11:47:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240124114740epoutp01acdf1da9186eaeafa54f2ee7d7ac4a49~tRg42hSi90196801968epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706096860;
	bh=FAgkRhdAC59JFAtm6cZa0lcuph+thmUnykW5y5DcQUI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZQPhwcOOfJhIjaSXLhqK2zJoqczs0rv2migJCof/kn3ULLzW8g0KCQYcFiCl24kGr
	 uQUujZUwy26sFlTqUSfNSSB09LOAnXeUEl5JrqQwmhnA3N3t4owtlU5n8jucRMlSI/
	 qoZeie0nFR4yq6jC7TUg6KVlsgTyPgUEnJHxS4jQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240124114740epcas5p13e64a477aeab25808dfb39ee2f01be06~tRg4XzjGz0304803048epcas5p1s;
	Wed, 24 Jan 2024 11:47:40 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TKhyy3jbvz4x9Pv; Wed, 24 Jan
	2024 11:47:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.D5.19369.AD8F0B56; Wed, 24 Jan 2024 20:47:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240124103850epcas5p48fcb1e92172efd246b8292a294740dd1~tQkx79-pI2047220472epcas5p47;
	Wed, 24 Jan 2024 10:38:50 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240124103850epsmtrp126601239072c5bb26298f097af4e18d4~tQkx6KDW32198721987epsmtrp1T;
	Wed, 24 Jan 2024 10:38:50 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-ff-65b0f8da8882
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.6C.08817.9B8E0B56; Wed, 24 Jan 2024 19:38:49 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240124103847epsmtip26853ef4be44a9903676df0f3deffbbfd~tQkvY2buE0212502125epsmtip2q;
	Wed, 24 Jan 2024 10:38:47 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com, Shradha Todi
	<shradha.t@samsung.com>
Subject: [PATCH v4 0/2] Add helper function to get and enable all bulk
 clocks
Date: Wed, 24 Jan 2024 16:08:36 +0530
Message-Id: <20240124103838.32478-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmpu6tHxtSDT7cEbN4MG8bm8WSpgyL
	FV9mslvsfb2V3aKh5zerxabH11gtPvbcY7W4vGsOm8XZecfZLGac38dkcWjqXkaLlj8tLBZr
	j9xlt7jb0slqcfGUq8WirV/YLf7v2cFu8e/aRhaL3sO1DsIel69dZPZ4f6OV3WPnrLvsHgs2
	lXpsWtXJ5nHn2h42jydXpjN5bF5S79G3ZRWjx+dNcgFcUdk2GamJKalFCql5yfkpmXnptkre
	wfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBvKSmUJeaUAoUCEouLlfTtbIryS0tSFTLy
	i0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMw7828Ja8JCz4tmrlAbGD+xdjJwc
	EgImElOamtm6GLk4hAT2MErcOtXNBOF8YpQ48e4wO4TzjVFiVuNTli5GDrCWr1v9IOJ7GSX+
	fullgXBamSQ+7uoCm8smoCXR+LWLGSQhIrAYaO6OzawgDrPAEyaJJTf+soBUCQv4Szw5uo8V
	xGYRUJX4ufwzWDevgJXE1O2f2SAulJdYveEA2CQJgbUcEh3Nk6ESLhKf9r9lgrCFJV4d3wL1
	kpTEy/42KDtdYuXmGcwQdo7Et81LoOrtJQ5cmQP2D7OApsT6XfoQYVmJqafWgZUwC/BJ9P5+
	AlXOK7FjHoytLPHl7x4WCFtSYt6xy6wQtofEjLfTwGqEBGIlFixuZZ/AKDsLYcMCRsZVjFKp
	BcW56anJpgWGunmp5fCoSs7P3cQITq9aATsYV2/4q3eIkYmD8RCjBAezkgjvDcl1qUK8KYmV
	ValF+fFFpTmpxYcYTYGBNpFZSjQ5H5jg80riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnN
	Tk0tSC2C6WPi4JRqYOrwDwhQVk6sj0hu0bSWLltwNcQ+/X3p/ocbemoqnF6+v787SLNI+/XT
	uYe+7LT5Zm/tI3Wl7LjhsicGy9/1XTv508nvlujUmdH3+TYvFQniV1u9zeXegbDwqFuOb+yO
	7ebNeqLi0VR7Mq4t4a192Ly3BVrVc3cvcI13n37p8TyB28t1LwWdty+Lm7KkZq5brkCFlEtd
	fS7Ldwmh4xu4P/VKPXhx9PYb1fNXAnz7sp9NtV4RMWnOSutPkZ51IVcfC7Guk8oy7dO90rz8
	hvXCj4wZOxvE1X6vfO8lvknni5jwec/N+5ddmXGzw4v36f+vK0WNfL2f9fxrN+t/WXvGePFG
	jV7937w8Umax7zq5LJRYijMSDbWYi4oTAd8/t8c4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvO7OFxtSDS7ssbJ4MG8bm8WSpgyL
	FV9mslvsfb2V3aKh5zerxabH11gtPvbcY7W4vGsOm8XZecfZLGac38dkcWjqXkaLlj8tLBZr
	j9xlt7jb0slqcfGUq8WirV/YLf7v2cFu8e/aRhaL3sO1DsIel69dZPZ4f6OV3WPnrLvsHgs2
	lXpsWtXJ5nHn2h42jydXpjN5bF5S79G3ZRWjx+dNcgFcUVw2Kak5mWWpRfp2CVwZB/5tYS14
	yFnx7FVKA+MH9i5GDg4JAROJr1v9uhi5OIQEdjNKzH14gqWLkRMoLinx+eI6JghbWGLlv+fs
	EEXNTBLt/w6wgSTYBLQkGr92MYMkRASWM0r8PPmUCcRhFvjCJDHp4S4mkBXCAr4SJ2+VgjSw
	CKhK/Fz+mR3E5hWwkpi6/TMbxAZ5idUbDjBPYORZwMiwilEytaA4Nz232LDAKC+1XK84Mbe4
	NC9dLzk/dxMjOMi1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeG5LrUoV4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpg0s75XbaO4/P+SR94++7fz1pySv3WzRXN
	99QXM1qFSc4MVfHjv/KDIYWj6sad6F19UrKJf/K2pgRbnrvy5BVXYlX7jcrSCIkVf9wPfdhZ
	NC0t9PexdfLPHz5fbppvqXxFeIGyoJ/4+80c4eu6GpLXd6wyTPWMYOd9Pbn4u1fx3J/WZad+
	+gc9eTZvWlDkosQdOrKNG2WnNnhsalrou3nxsp3M9+7YNAWI/uVPOZ11+912xn98+ZrXN+1M
	M68u/SKzNPnlRg7WWTOyFn29e80p6fgqm2u5Gb+mHPbx5T33nLe6uDZta59p06Rl7QXmUm2m
	Cwx/Xnjw7njk++W/Pk/YZq11ZZH2waMc+3Vqv12Z+EeJpTgj0VCLuag4EQAt8+rK4QIAAA==
X-CMS-MailID: 20240124103850epcas5p48fcb1e92172efd246b8292a294740dd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124103850epcas5p48fcb1e92172efd246b8292a294740dd1
References: <CGME20240124103850epcas5p48fcb1e92172efd246b8292a294740dd1@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Create a managed API wrapper to get all the bulk clocks and enable them
as it is a very common practice in many drivers. The second patch uses
this API to adapt to clk_bulk_* APIs in the exynos driver.
v1:
 - https://lore.kernel.org/lkml/20231009062216.6729-1-shradha.t@samsung.com/
v2:
 - https://lore.kernel.org/lkml/20231115065621.27014-1-shradha.t@samsung.com/
 - Addressed Manivannan's comments to improve patch
v3:
 - https://lore.kernel.org/all/20240110110115.56270-1-shradha.t@samsung.com/
 - Took Marek's suggestion to make a common bulk clk wrapper and use it in
   the exynos driver
v4:
 - Addressed Alim and Manivannan's comments
 - Changed enabled->enable and disabled->disable in function name
 - Remove num_clks out parameter as it is not required by user
 - Removed exit callback and used function name directly in release

Shradha Todi (2):
  clk: Provide managed helper to get and enable bulk clocks
  PCI: exynos: Adapt to clk_bulk_* APIs

 drivers/clk/clk-devres.c                | 40 ++++++++++++++++++
 drivers/pci/controller/dwc/pci-exynos.c | 54 ++-----------------------
 include/linux/clk.h                     | 24 +++++++++++
 3 files changed, 68 insertions(+), 50 deletions(-)

-- 
2.17.1


