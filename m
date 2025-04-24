Return-Path: <linux-pci+bounces-26672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB210A9A5FB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 10:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6313B5D69
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ED9214A76;
	Thu, 24 Apr 2025 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rrluGAZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE445579E
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483670; cv=none; b=Po/zlgG4AQxv/zw5MEz0mrt9cn66oxu2ah2tNoreQoX43FCFjAz4eSw4BTTnF9KaHlrn4PKtDYld53923NqcsFlT1mVrYQP2aN+Hw5w7+KlQ81gbnGRV9Pl74w4O8rnnUpVul07tZSXu2kHP6w/4XpLevZCHaGRO4XPfgdecB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483670; c=relaxed/simple;
	bh=vNv6q0bb1dhXpfiDx4lYdoPPd0v2qIBg86Rmq+6QIeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7f8quLxZ/ojzWzOs9dtfCwc/1TMN7W3n7a8xqGywOslERpvYMCNDjb7rxfx+U1dYiAAn+3y37wfTM1pXd42OH0DzM8qQ7zMoKprtGtsMztTymc1Ji41J+v+lDyTz/ogQqjZzR+jod4JGX9ZMhWQy1a2o5R7FEQeduB/p8rJuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rrluGAZF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ee651e419so367093f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745483665; x=1746088465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=rrluGAZFLTrvbsEtplM69wEgWcFW9D9ZCcUhL8kfOKIZ6/SVtLBBRKCUr+URxptpR9
         1GYMOh+x2Cxa+99VM7NJqeMlf96SXNMPkIGffi2tc9KqEUA3aNYDMEW+e156PJ5WIY8d
         sHKWvKnFyPjaTO5OjLJRNf+AF2bv57xDBE6h1a/GSF6X75YiAFJnlHqJpy2xiAJV8j8E
         TvLkLuXV8rjWAbRL4O3avq+Zf7oJlvOYduhP/8R8uR1Be1g/IGqR84vyffuImIlYb9Ww
         Jd/Vv8cJSPQ2SSJpWYxDwnz1ZpWH2SVLLBkZOiI45nrAICFq0k0lv6Kwh56TRQ2DKE3s
         3OmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483665; x=1746088465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=kFWTh2y389mZvJ1NCbk+w6Lp/L5v8bIeGsYCIzwM3rBpH5P4EEc3L52xoyHU6FlC7Q
         ynzut3MbI/N1cC603LOGd7i8PnLFheVUgi2xBEzRyHaLYzwogtYuP61LR56fXG52eZNs
         4idvyFQNtKTDA11hsOkNZFe+EffOyZenpcMmCTwAzHFaIbIn2ZeMxJDkFnq3sylEasfw
         xhDVIGo+3/jcjKR7o89JmQo2edZIxuh99qBcub5nzShQ70c5IgkoDJZv1flquhnyhzLx
         JIjbbYkyg9OdlgCYZsPuCvXZDOxeMH6mejQ10Eb2xr1WePzg+7wifJR6SFKV/BCfehUX
         qkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbudKj6jcFOVwJ+EXnhoxohCmspk+5c4UWQaB4+XCjMnWHHn/GOHT6dgghP9GD1/FzPPp0BpDbRP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQ00SaLV3f9KhpHsVFjf9IFsoMv6dYpwFZfGJTQ9uczQKHJO4
	hX4qwX54EU+hXP5TfPw18LBhmQt5Si1FPX04cuGzxnuMDbVbAOIemOJUEX9vH+E=
X-Gm-Gg: ASbGncs90dBHOw+1TQMsrR4TOe/yb7gPQbmlCeU6wSFJuzelnJ4E+Dj39nHO3B/raD5
	iQixv2slLOQWLazjyRdd7GQ4VCwQIbb6kKb/oNiiO4ScfAhHXYP7dYnia6EpvQJmOuEFRJawLdm
	AQsxe2wFhgmw6yrABY3qDXxQRNPzzMOBn2EsScKJO6EpRD8MaPCm7+4joCyRRTfpDTXbqYGo8NW
	956jDj5TwsFUb7l7xMBpUXzv9Us8AHNJOQYhahizypMFwUcBFVbG6DQfbC2XC5v0/1E0+0wJC0P
	bSsiWk4qfph6jO64Mp0ATohywyPcB5N2zI6e5f0ae0aBWwP221V3WQ==
X-Google-Smtp-Source: AGHT+IHB/1fPMi8W8gNYBZX9ahiEF0UFgajqPwu4G1ECbDegN3oYFc0PmydKXsVY2MSnx6gtJ+HsoQ==
X-Received: by 2002:a5d:47cb:0:b0:39c:2661:4ce0 with SMTP id ffacd0b85a97d-3a06cf5ac06mr1515723f8f.13.1745483665163;
        Thu, 24 Apr 2025 01:34:25 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f74:6a9a:365b:4453])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4c6c56sm1323881f8f.60.2025.04.24.01.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:34:24 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 24 Apr 2025 10:34:05 +0200
Subject: [PATCH v5 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pci-ep-size-alignment-v5-2-2d4ec2af23f5@baylibre.com>
References: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
In-Reply-To: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=vNv6q0bb1dhXpfiDx4lYdoPPd0v2qIBg86Rmq+6QIeY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoCfeNM/XnkovbNkugaUgh+qynHCUCtYyhIWFEg
 Mnjh1220EuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAn3jQAKCRDm/A8cN/La
 henkD/kBk6sa7qTps24wEDvGqFqWVTIMapEBlE7MOo2mVVheqN1DbKKPyXp+48xcqqo8mSJ6y6k
 HDSdfWCOuf0uq9OGCHGxshry3J0/RdzHPn70ZRsT9f1zAt3SooEvxkL5mA0h9NWJaQc4Mjmsx8v
 YkjxiCooDpDHAQodmmZoGJf86HQLybBrSskdskNA9w4+4C7FfPOeXl+QhtjTZhPQp0NR8jvPoDU
 ywoj23FUzDHXoarguypcLl731tXJMsbJKYViABXBcWXD6YH8lPE4aooJnOAzOvDL6ENz2hxmDTu
 fTeYO9LgGa+H2WGmZF+cBCwQlgu+Ezk/mbQap7S5qbJHtXplFrNRY38Tph5tRGYK+ruB8ie3bt9
 wFhs3SN9FSwFCe1OWxO6LJwlMu1jSfIFOo4QHqtfOjgnnccRcjQp4o7d6ji51GNYl2GyaKc5XwQ
 k/TUGW7BD2nMECwtXKLcobsEj+dLOzEjnx847/4IpfzHCBvunz67EzlZb7iSypHXN9kpdSp1BVN
 qtgc7vck/211s5WWWYbNvQskBEvB27/mx29Yp4OI67ZQ3qn7Gh99oZQq+IJPU9scrsnwrYepWUL
 Da5yGlyxLBV3u33uJjya3KgcvgRBCXS7Ksg2GJcpcbEqV7euamaxHnV8uiYlm2HlTKDUJP3IV2V
 uinIHWXjuwaRucg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
should not try to handle the size quirks for underlying BAR, whether it is
fixed size or alignment. This is already handled by pci_epf_alloc_space().

Also, when handling the alignment, this allocate more space than necessary.
For example, with a spad size of 1024B and a ctrl size of 308B, the space
necessary is 1332B. If the alignment is 1MB,
epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
been more than enough.

Drop the handling of the BAR size quirks and let
pci_epf_alloc_space() handle that. Just make sure the 32bits SPAD register
are aligned on 32bits.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..e4da3fdb000723e3adad01f0ddf230ecc0e572a7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
-	size_t align;
 	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
-	u64 size;
 	struct pci_epf *epf = ntb->epf;
 	struct device *dev = &epf->dev;
 	u32 spad_count;
@@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 								epf->func_no,
 								epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	size = epc_features->bar[barno].fixed_size;
-	align = epc_features->align;
-
-	if ((!IS_ALIGNED(size, align)))
-		return -EINVAL;
-
 	spad_count = ntb->spad_count;
 
-	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
-	if (!align) {
-		ctrl_size = roundup_pow_of_two(ctrl_size);
-		spad_size = roundup_pow_of_two(spad_size);
-	} else {
-		ctrl_size = ALIGN(ctrl_size, align);
-		spad_size = ALIGN(spad_size, align);
-	}
-
-	if (!size)
-		size = ctrl_size + spad_size;
-	else if (size < ctrl_size + spad_size)
-		return -EINVAL;
-
-	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
+	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
+				   barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;

-- 
2.47.2


