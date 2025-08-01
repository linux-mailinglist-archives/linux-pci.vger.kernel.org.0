Return-Path: <linux-pci+bounces-33290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A0B18287
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3643A7A4F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F826AEC;
	Fri,  1 Aug 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xh3/9Y1B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A522D78F
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055272; cv=none; b=GKPl8q3ozvBX6bYkFbKbMeEAp6TtyHMLY4ND2TuzLRB6g/E+NGY2JhFRNhuZbwhYAMTEAu4pRzMr9NUPtz9N2mKhJhdHdzRzhQ2wfln2lSYf9ILnA9OOd4uAFhUptPsxGfj3sVocN8bN93cBpgI4qHr9/Cyq7N3KgmHyMZgeyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055272; c=relaxed/simple;
	bh=kRZxvVYrz7Hra0DaAuY0TwUpnxsMRb0GdYsC6KRGam0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OjFspf5OXovUCqBhjawtgNnEIG/sZReeZc1aRX4OxHwmv5A7F8MBX3ykR0XZ1OVMJtd7VxYCJkfvDhwfKrN/081GXcEKLAwi8pBleVnsAoevcrrTMeZCpfbBRo/kuhlFucCprv6r9n3v4GOLwF8I4OHZRt0ZUxZu9UFtpYwNHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xh3/9Y1B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so14806425e9.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754055269; x=1754660069; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ikwrGSjcBBLrvu9XsOAXM0jftfGyj555P1DWTA9Hp8=;
        b=Xh3/9Y1BcoXy4gVMWOGSUfekHimMfbdwXykQLeZ+425zF/a+oqQlZovU42npsBKYsw
         kiGrNEZ2e6u/AnAH1nrasyhmNUmPqLhz5wTrRlVa7nSgaPh06e/BFNBqBL/+w+isvsC9
         o31tegrNe2+UpGnSogolYx+BkziUVj67GUvBBFz2Ynslmw1JoHajTmOwX7znySU2/1Jb
         UzBRw+i4LFqcW/7Sa63FQ8VfWP9YIHqwhwY/5Qen48KQQk8ZW6KtWoS8HZd7FssXjx8y
         Cv1Nh00gjHEE4D776DFuZKLiiW5c2NuiRIPXydDByWtphjgOjUAnVF7xOAixRGmE8use
         AGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055269; x=1754660069;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ikwrGSjcBBLrvu9XsOAXM0jftfGyj555P1DWTA9Hp8=;
        b=SWi/X6f7w2ETKqaJsqA5J6p4Fr8zHNWVD0Z3OSmFeiuutmEw36VOXiZsa2ENY8m+jp
         7ntyxgfzrBvI9qPVhTraeFkqG7UiYKSvThsIjJAcZO2czH5lHBXkdTl+dIZWY09QgSRH
         pwDhe/1tKotAHXkodBQJQgmU8gTIUNoEZfInljNpvO+iQ+zKRlk3TnqnZ6Wn2+3/bYtg
         irCoT9jFYDcozkajKa7+IYW53YFODBPaQLFx7XSFghNxTz5W7nujISSo8b0cibETImeI
         RCxpFwxbzhyTWRDYk2vhPNc8ZjpEkwK/l3DgrcxsspAEaYcJfIH0fFXHpTHJaas+xHo9
         vcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKJs31qzlIFA4JmfZS9ByS36Cpio3ZpAsxAlqiMzT2x0S2KknVgu5MZwpma8hPruR+LiZarW69KUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAC3siVdINI/CahclM/53euHy49i0uwkycI8b18V0nd8kNeUC
	notYvWJMCWO2cLL+hf3jDeG3iMWvHAPyfYc66Xd59W9suUw9COKbkjXhhMaO0YFbaAY=
X-Gm-Gg: ASbGncu5i9nr7d1eHEpM7OHGHO7zxniij56+OIwPRupZim+a3gJm3NkcpSHAIblinvF
	p9gY7g9KvDODDAlc5W+42C9lJiFmKgeFlXpzzjYIhYe/+8v4vf4ic68lHUN2SbeV1Kre2IwkZmF
	Ty/bqJDNlJDuz8aDfnqBg2U6DQ3twnGyMeptKycQVBz0QTPGvho0RMK1zSythul2P7XJtw9VEYI
	98TRW9uWba5Urp5SxV1lqGCiYyJ92RcNGrr5fXV+ywmAzarEl6agS7Jam15lAl3GV7++Dq53lke
	zraC0AW/jNFhuA2nDmeJnNbRl+7Ri2Pp2YV6yOAFHEBDTOJ4aatyKJ/YhRRMrG8/NaudFPcLudy
	yn3p5DxzxJXnflpHEnzPInN/ndbMqUgDgftjSNCRtgbY=
X-Google-Smtp-Source: AGHT+IF+SIPd3jy2PLV5NH/C2c9z1GDxjjS04pa20jYwnWKoaqf9mFZGTto/hJb9geJcaBIO6yUqfg==
X-Received: by 2002:a05:600c:3b01:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-458aa325e47mr28237545e9.13.1754055268940;
        Fri, 01 Aug 2025 06:34:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589edf56e0sm66135635e9.1.2025.08.01.06.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:34:28 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:34:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] misc: pci_endpoint_test: Fix array underflow in
 pci_endpoint_test_ioctl()
Message-ID: <aIzCYdH9dOMDag5i@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We recently added NO_BAR (-1) to the pci_barno enum which, in practical
terms, changes the enum from an unsigned int to a signed int.  If the
user passes a negative number in pci_endpoint_test_ioctl() then it
results in an array underflow in pci_endpoint_test_bar().

Fixes: eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
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


