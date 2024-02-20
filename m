Return-Path: <linux-pci+bounces-3755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8F85BA40
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AEF61F25260
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF5A664C8;
	Tue, 20 Feb 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DRAYm8BL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6661664AD
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428089; cv=none; b=o0JOAW4/iNQ1+zbP6BFvgIXK10/jbTpvk1a/U3xfHSXdPsXXFJfXF5Hf6fhN/L7fe7W23TIzUckF/cRZe7YgtbOdwpZxYct7bf51+0hxove0B+EPo7/YqBEbEPE6Az+AqJqT+CGrDAqXDCUfhYN9kKJuX4v883elVWuiUKW0+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428089; c=relaxed/simple;
	bh=tMJxfwCSSr3p+ijPgpOexopN0A0/RTNz2LXt/jouBIg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=PRgUw7H0AVsIHAFpgY/7cadzpHsgUwz7/t7OIQoN8mG+idyrEVWz9ZhNx1oXv0YRQorko2QL2M6/Y0d1JN0/8ceKmt5hSd8ZTetcXzVJSr1z1cNsC/PmBjVAIOaww3bHQ1bBeSrAGK/FdSRb9zUco6xSymgNyiXA9L3KCsalhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DRAYm8BL; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240220112118epoutp03053968929d435be9084fbc12019070b1~1jkkzVa552856528565epoutp03E
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 11:21:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240220112118epoutp03053968929d435be9084fbc12019070b1~1jkkzVa552856528565epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708428078;
	bh=1cWhqeulLVD72A386JFQUZWJu92N4UiwYI/DcEzmtt8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=DRAYm8BLEzlPkmljiLn6/vofVK2QFZ79msvhsf/8DJ1zztz4oeM6JfWsCOwYpmU4n
	 +iTFpeXMCFiwsTUZMGtbgs+np4t8WudnLCDXOVyjyGcJ8z/LXlziaB2Bd+B3VlJgL4
	 x62MbxmFVmIdrUXlXkjf4Mrh+DPghgZ2Q+245sBc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240220112118epcas5p20e5f933caf48ebe9fd389527410327b9~1jkkQo-0i3136231362epcas5p2z;
	Tue, 20 Feb 2024 11:21:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TfH6430w6z4x9Q0; Tue, 20 Feb
	2024 11:21:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.E3.09672.C2B84D56; Tue, 20 Feb 2024 20:21:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240220084109epcas5p3dc6b95a0ed69b63e93f4aa0a6fc919fe~1hYvSgQxt0823808238epcas5p33;
	Tue, 20 Feb 2024 08:41:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240220084109epsmtrp2dfee0aa01819adbc0797640442582a6b~1hYvRlQBS1186311863epsmtrp2X;
	Tue, 20 Feb 2024 08:41:09 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-e2-65d48b2ccbca
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.7B.07368.5A564D56; Tue, 20 Feb 2024 17:41:09 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240220084106epsmtip194af0d0ce4318e40dae18b6a06aa7df0~1hYsoDfGI2979629796epsmtip1j;
	Tue, 20 Feb 2024 08:41:06 +0000 (GMT)
From: Shradha Todi <shradha.t@samsung.com>
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: mturquette@baylibre.com, sboyd@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com,
	gost.dev@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v6 0/2] Add helper function to get and enable all bulk
 clocks
Date: Tue, 20 Feb 2024 14:10:44 +0530
Message-Id: <20240220084046.23786-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmlq5O95VUg7d/BC0ezNvGZrGkKcPi
	5oGdTBYrvsxkt9j7eiu7RUPPb1aLTY+vsVp87LnHanF51xw2i7PzjrNZzDi/j8ni0NS9jBYt
	f1pYLNYeuctucbelk9Xi4ilXi0Vbv7Bb/N+zg93i37WNLBa9h2sdRDwuX7vI7PH+Riu7x85Z
	d9k9Fmwq9di0qpPN4861PWweT65MZ/LYvKTeo2/LKkaPz5vkAriism0yUhNTUosUUvOS81My
	89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgH5TUihLzCkFCgUkFhcr6dvZFOWX
	lqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRn/H94gqXgAnfF3RvbWRoY
	j3B2MXJySAiYSDx70MHcxcjFISSwm1Hi28V2KOcTo8S6fTNZIJxvjBKHrr5ghWk51LiVHSKx
	l1Hi3eOljBBOK5PEtCln2ECq2AS0JBq/doHNEhFYzChxa8dmVhCHWeAXk8S+xk1MIFXCAv4S
	HbevAlVxcLAIqEqsOZgGEuYVsJKYM3EPC8Q6eYnVGw6ADZIQWMkh8ezHQUaIhItE/+Ql7BC2
	sMSr41ugbCmJz+/2skHY6RIrN89ghrBzJL5tXsIEYdtLHLgyhwVkL7OApsT6XfoQYVmJqafW
	gZUwC/BJ9P5+AlXOK7FjHoytLPHlL8xtkhLzjl2GBouHxMlpN8BOEBKIlfh86T/LBEbZWQgb
	FjAyrmKUTC0ozk1PLTYtMM5LLYdHVXJ+7iZGcKLV8t7B+OjBB71DjEwcjIcYJTiYlUR4Wcqv
	pArxpiRWVqUW5ccXleakFh9iNAUG2URmKdHkfGCqzyuJNzSxNDAxMzMzsTQ2M1QS533dOjdF
	SCA9sSQ1OzW1ILUIpo+Jg1OqgWlazLZahROGkwofcT7Y8H7rxR08SnuuVixJWtFs/X71Pqu5
	u25pLTwSczrKr37DpBrLfr/67edmr+hZl3lezpPxpurq95qfpu9T1lnx9kn9J4ZrD7/tklrX
	27LDPiblhejqr8kLpqxriDh6UO2l+Ep+l7pLUx1erjhx/WChmOVN/avZipd1+Pa6cOilbbtx
	+kmhbDFLSjxnwOq4m6FO0fWV5woyFlz9fykz4c1zp/zPVXEV3IYPRN95tfi5cf9b+ulI/orf
	TFMeRHCu4bNJXHBT80k786u+bVsnLWP6GJ73/nCnyRqedxV3RFkevP+UU3bg1Suj78c+K27u
	25+gr52ZUNfqHGN3NJe3841EWvU9JZbijERDLeai4kQA2YvRST0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnO7S1CupBkeOs1k8mLeNzWJJU4bF
	zQM7mSxWfJnJbrH39VZ2i4ae36wWmx5fY7X42HOP1eLyrjlsFmfnATXMOL+PyeLQ1L2MFi1/
	Wlgs1h65y25xt6WT1eLiKVeLRVu/sFv837OD3eLftY0sFr2Hax1EPC5fu8js8f5GK7vHzll3
	2T0WbCr12LSqk83jzrU9bB5Prkxn8ti8pN6jb8sqRo/Pm+QCuKK4bFJSczLLUov07RK4Mv4/
	PMFScIG74u6N7SwNjEc4uxg5OSQETCQONW5l72Lk4hAS2M0o8X/WbVaIhKTE54vrmCBsYYmV
	/55DFTUzScw9fJ4FJMEmoCXR+LWLGSQhIrCcUeLnyadgHcwCPcwSB1pDQGxhAV+J92fXAjVw
	cLAIqEqsOZgGEuYVsJKYM3EPC8QCeYnVGw4wT2DkWcDIsIpRMrWgODc9N9mwwDAvtVyvODG3
	uDQvXS85P3cTIzjgtTR2MN6b/0/vECMTB+MhRgkOZiURXvemC6lCvCmJlVWpRfnxRaU5qcWH
	GKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MKXrBS2Qmz2t8cAB34Cpq0xuljGIyX9t
	8/u8/eS8rK7JC16VrXkR3fWEb51AQSsLL4O/RV6QpsGJjf2sRpIalqxsxW4bAk8xa7Q9Y0v7
	Leq88gmPnbme3q/Zz9adDql1+nrtpnyFtOOhZ91iSirN/xLuON9TZbT8zf/CaloDq8Gfpq3z
	myLvSApuzAziuXhqqdBHOUXOLdf2sJR80vHZ3W+yvkFvr03W5USOq2xTs5wflWf5z3KvFvl6
	z/PGdMXPVYvXtCzfwDWTc5UWz6fahyp1m8otd2qpegTH/XpZsj5glf+UO1f+GhZdEL6fN6tZ
	0MQxq9OQd7OrsWrFdPUr85qmfj90LC4qhuHIkQhmJZbijERDLeai4kQASN4U4OcCAAA=
X-CMS-MailID: 20240220084109epcas5p3dc6b95a0ed69b63e93f4aa0a6fc919fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220084109epcas5p3dc6b95a0ed69b63e93f4aa0a6fc919fe
References: <CGME20240220084109epcas5p3dc6b95a0ed69b63e93f4aa0a6fc919fe@epcas5p3.samsung.com>
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
 - https://lore.kernel.org/all/20240124103838.32478-1-shradha.t@samsung.com/
 - Addressed Alim and Manivannan's comments
 - Changed enabled->enable and disabled->disable in function name
 - Remove num_clks out parameter as it is not required by user
 - Removed exit callback and used function name directly in release
v5:
 - https://lore.kernel.org/lkml/20240213132751.46813-1-shradha.t@samsung.com/
 - Rephrased comments for better readability
v6:
 - Removed extra new line

Shradha Todi (2):
  clk: Provide managed helper to get and enable bulk clocks
  PCI: exynos: Adapt to clk_bulk_* APIs

 drivers/clk/clk-devres.c                | 40 ++++++++++++++++++
 drivers/pci/controller/dwc/pci-exynos.c | 54 ++-----------------------
 include/linux/clk.h                     | 22 ++++++++++
 3 files changed, 66 insertions(+), 50 deletions(-)

-- 
2.17.1


