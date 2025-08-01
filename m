Return-Path: <linux-pci+bounces-33308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B26AB18629
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 19:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567393ADA20
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB21DDC33;
	Fri,  1 Aug 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFBv7MO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CBE1A08CA
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067821; cv=none; b=nv0Esd0s3iOfIzzC3V8b45+a0TL3CmgJsfm87Zc474C1SfSKznHfe39VVUyAoVMOSTNipT001dZczP62K0TlGc4LZwV+0bnKpFzE9ObMJT417jRbN+57BSKHLC73MAa2JzseKReHLT3GQkSZ4wiatR9LHoc7cfWa2wQH3DUZPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067821; c=relaxed/simple;
	bh=nCQxiJoszU8ksOrhF3/w351OjygrjbbqU1ObSybD2RY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I1Kgel2nY9VZ48iXgEmec4788Y8E/M0j+CsSTRqlcSqksPum/K40+XVdsMtVCTJi/DvEzJP2kWTjoaaX8tq1uCsYv+rtfeQMSuMo6qTmUXae1g4atKtuy4IGU7Y1gqgf2/sgnKo2AxZlmQKCxhvlVrHx6Nw48sT/SWkpUOvkg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFBv7MO8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so10570745e9.3
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754067818; x=1754672618; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8Idzcjcrmg19teuU7qWglO1ohyMC29kZ4c9xikiJd8=;
        b=fFBv7MO8DM8RD48Bddnrzh2oxr+ZmOKyuxIUb+aD+BeljgnBqLLg2UxXuouQB+aZkm
         5ZQmHN1C9HYfIfqjRlAHCyoYhCQrRzRgqnGCafbnnbwqKIEDnFKyNFkirumOU1n/edMy
         i3I7xthmIvCA6eM/s/nqPDe+ixoGoIxOKrIMaoEcK0pdOZtkrBT9rSOe50ssOXPqDigl
         nMBlfk5KQQmgAHVRagxcMQumqd8XEI96/fsVL7a5rq+XWIkNcE37/vyxTWpSOfoU2TbE
         9cs1+vUvFIiI5Vam67kXFxRyQLDDXT9rxFZMBoJbikZ/+++Tsic5jFYOSdw4EhPyjNLq
         H0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067818; x=1754672618;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8Idzcjcrmg19teuU7qWglO1ohyMC29kZ4c9xikiJd8=;
        b=AeaQwXVdKnCymmFqOc/mZnoXWonEQzyxxeW8X9/MKoCBi6fluPPehrm3ArGTMrWBHn
         KaY1ksoR7MAiGjP5hwrHIog5rfcffl9k5pkp0P2a+XBRbNiSYGwDMiLXN3LyPz4GH6Y+
         aEHAA+nmja9mps8XtkPM6ae+airhW+PGKdbCYgY3qWE1rksDAdvScWkHpoW3rXw+Lv7h
         JWf1SlcZRtwYgFGAAN92UVhTKhNCnWi14u8Q1zhbrZi1bIFX0kPunwfFT+Yw2D/7+hMb
         2Rue0403MyTALGWc+Ns2kGgvmoAybnFDwLSCDYwgAfb9R6PQASmU2sU1QClq4ihT5icB
         /oLw==
X-Forwarded-Encrypted: i=1; AJvYcCWty9hJ3ckykIQtMjc0Ze1Wm/1tFvN8l9FqkFh1o0U3SxM1xqK4rmi56c6c6TWNPXWH2ySnFG59LZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQrep2W6tVtGmTkir/TKkpfUOuK5PeujvjIzwrR25JLJnVVE8
	z4OipLHL3XEwCcPa2D6fvZEbe+GQ4yBiTaYvQZBQtWPtUILkt5sMlI3eX+cJJyVZbhY=
X-Gm-Gg: ASbGncvvD/srSI89vmJ/o/FLOOGdGMquuWtrKWKiDPKwsuCEXCn5TZzymJqD9mmHheq
	c9xwNUqoc7PvmcE/PNm9JkmaKUPnmJEpnFlm/ji4Vs2omypiqehncBzz0f7pP+Bbk4dqbFOBtE+
	atAC3Cvnc5NItrbJw4XNR9knAytmxsC85TJW2iatJwEUfeJtI/Ea4ivMwJcMKM8hJvAZ3uTaike
	goJebiv83wtiEnkwQXP/urJ5ld8ySFn6LHnRa009eLaT9SL+36iEH8FXh91+b6e8rVrE0JLcno8
	HdnLyPwEFW9N6EWa2cb6WOR/XViK3PURTXcYRKqCxRy+7uhHmCbDv0PgPo2g2bbEBcNG7vdT7nK
	7ZgnYwkBmPjfIZe7BGxNBtXl8mKb03owmeNsaHC85rRE=
X-Google-Smtp-Source: AGHT+IF4SZA4+gvm+qE0CvIZzsjptGyk828yA5KPOKH5NCsTm42x7LDrAlCkH3FYaw1k6NNDuh4ctA==
X-Received: by 2002:a05:600c:35c1:b0:450:d04e:22d6 with SMTP id 5b1f17b1804b1-458b69ca289mr446125e9.7.1754067818139;
        Fri, 01 Aug 2025 10:03:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edf5638sm71554525e9.4.2025.08.01.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:03:37 -0700 (PDT)
Date: Fri, 1 Aug 2025 20:03:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 next] misc: pci_endpoint_test: Fix array underflow in
 pci_endpoint_test_ioctl()
Message-ID: <aIzzZ4vc6ZrmM9rI@suswa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
added NO_BAR (-1) to the pci_barno enum which, in practical terms,
changes the enum from an unsigned int to a signed int.  If the user
passes a negative number in pci_endpoint_test_ioctl() then it results in
an array underflow in pci_endpoint_test_bar().

Fixes: eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Update the commit message to mention the commit which adds the
    NO_BAR.

 drivers/misc/pci_endpoint_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 1c156a3f845e..f935175d8bf5 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -937,7 +937,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case PCITEST_BAR:
 		bar = arg;
-		if (bar > BAR_5)
+		if (bar <= NO_BAR || bar > BAR_5)
 			goto ret;
 		if (is_am654_pci_dev(pdev) && bar == BAR_0)
 			goto ret;
-- 
2.47.2


